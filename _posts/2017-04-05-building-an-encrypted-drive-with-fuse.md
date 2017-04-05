---
title: Building an encrypted virtual drive with FUSE.
layout: post
---

Today I've been at a mini-hackday in Liverpool, part of the [National Conference for Learning and Teaching in Cyber Security](https://www.heacademy.ac.uk/training-events/national-conference-learning-and-teaching-cyber-security). Day 1 has some cybersecurity competitions, and a team of 3 of us participated in the Software Development stream.

I've been to a lot of hackdays---between 16 and 20 I won prizes in at least six of them. I picked up a minimal-product/prototyping mindset, but it was hard to keep going afterwards. Over time my enthusiasm waned. The time limits, intensity and limited feedback hindered stretching my boundaries.

**This competition seemed quite interesting because writing Cryptography-related software is hard.** It's hard to start off in the right direction, and very easy to screw up later on. As such having professional feedback on an interesting day of work sounded great.

So, **our task was to build encrypted local partitions.** We had to build a system which stored encrypted keys on USB keys. Inserting such a USB key automatically prompted users to authenticate for a particular key. The encrypted volume was then to be used as a virtual drive.
<!--more-->

## Work begins

Sam ([@sdhand](https://github.com/sdhand)) is a first-year Computer Scientist at York, and he focused on detecting USB drives and getting the system + GUI together. Chongyang ([@icydoge](https://github.com/icydoge)) concentrated on the encryption using [NaCl AEAD](https://download.libsodium.org/doc/secret-key_cryptography/authenticated_encryption.html). I took on something new to me: engineering the encrypted drive.

After a little research, we settled on a FUSE filesystem wrapper. FUSE provides a virtual disk drive with a custom filesystem - for instance [sshfs](https://github.com/libfuse/sshfs). For our usecase, we encrypt writes and decrypt reads so that the data is encrypted when on physical disk but decrypted when accessed. FUSE was completely new to me and rather exciting.

I've been trying to get deeper into the Systems side of things, and this was a very new experience. Operating on memories of reading about ordinary disk encryption, my first implementation decision was whether to encrypt the entire filesystem or each file individually. Encrypting each individual file has many disadvantages, most notably that the metadata of files (e.g., their name) is unobscured. We only had 5 hours (far shorter than it sounds if you get stuck!) and so I chose to do it file-by-file, with this as an important caveat.

I sketched out a plan for how each API method could adapt to our encrypted filesystem. Opening files would read and decrypt file contents into memory; reading files would output that in-memory plaintext; writing files would update that plaintext and encrypt it to disk; flushing or closing files would encrypt it to disk. File descriptors (handles to open files) were handled very simply by giving the same integer for each file path.

## Debugging `NUL`

This worked rather well until I started hitting difficult debugging issues. I was getting mysterious `NUL` bytes when reading and writing files, and despite a number of bugfixes I could not seem to fix the final issue. For the powerful ecosystem and rapid development we were working with Python, and various issues forced us to mix `bytes`, `bytearray` and `str` in one class.

I had no testsuite. I hadn't found one when getting some example code and I wasn't convinced such a tight timebound was enough to repay the slower development time. So facing tough issues I radically simplified and stopped storing decrypted contents in memory. Every time file contents were needed the entire file was decrypted. I felt that once this simpler form worked I could easily re-add the complexity. I feel the in-memory approach was easy enough to not be premature optimisation, but it did prove to add too much indirection for how unfamiliar I was.

This final issue was that files were mysteriously having `NUL` bytes appended each time they were saved. Nothing I did could fix the issue, to the extent it was bizarre. Stuck, I warned Sam and Chongyang I'd hit a blocking issue. Chongyang and I were able to simplify away some ugly code but couldn't address the problem. **Thankfully Sam has built an [X11 filesystem](https://github.com/sdhand/x11fs) and realised we weren't giving correct filesizes!**

One method of the FUSE API that filesystems implement is `getattr`. This provides metadata on items in the filesystem, including the sizes of files. Sam noticed that we were passing through the size of the encrypted files rather than the decrypted ones! This was rather bad: our encrypted files were padded with a nonce value.

**Our code was built in a hurry. Nonetheless, see [liverpool on Github](https://github.com/46bit/liverpool).**

## Cybersecurity as a career direction?

I was rather interested to have our Cryptography-related work reviewed, but in practice this didn't work so well. I'm not sure if the judges were non-technical or just had a "gold standard" they were seeking but there wasn't very effective feedback. Nonetheless a very enjoyable day and we've reviewed things ourselves on the train back to York.

I enjoyed the [Security work I've done for IT Services here in York](/2017/coldfusion-insecure-escape-spaces/), and with graduation soon approaching I've considered going deeply into cybersecurity. But I'd rather bring my security mindset to more typical engineering roles. I have a rough plan to take an ethical hacking certification in my spare time once I'm settled after graduation, as I'd like to make security a more formal part of my role over time.

**Our code was built in a hurry. Nonetheless, see [liverpool on Github](https://github.com/46bit/liverpool).**
