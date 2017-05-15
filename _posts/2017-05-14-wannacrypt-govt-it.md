---
title: WannaCrypt and Government IT
layout: post
---
WannaCrypt is the malware whose remarkable spread from mass emails to leaping across vulnerable SMB servers has led to major problems for many organisations in the last few days - in particular the NHS. Much has been written about its spread and [MalwareTech's heroic but accidental halting of its spread](https://www.malwaretech.com/2017/05/how-to-accidentally-stop-a-global-cyber-attacks.html).

> The British prime minister, Theresa May, and NHS Digital said they were not aware of any evidence that patient records had been compromised in the attack. May said: “This is not targeted at the NHS, it’s an international attack and a number of countries and organisations have been affected.”

This would seem to be true. WannaCrypt did not exfiltrate data from SMB shares, merely encrypting it. But this is only true because its motivation was extorting BitCoins. A more strategic attacker could have infiltrated at least as deeply, accessing systems that deal with highly-confidential patient data. This could be used for information, influence, or as a weapon.
<!--more-->

<!--This gives an excellent view of how effective an attacker with different motives could be. WannaCrypt is a BitCoin extortion scheme, but other attackers (such as the vulnerability's presumed original discover, the NSA) are probably more interested in gathering information. It's clear this malware reached computers used to access highly-confidential patient databases and handle medical scans. WannaCrypt disabled the systems, but a more systematic attack could retrieve or manipulate information.-->

The UK Government bought an extension when Microsoft ended Windows XP support in 2014, [and then ended it in 2015](https://governmenttechnology.blog.gov.uk/2015/05/22/update-on-the-customer-support-agreement-for-windows-xp/). The idea seems to be that individual areas of government would buy support if needed, but with so many NHS machines vulnerable two months after a patch was released for this vulnerability we can assume that didn't go to plan.

> “It effectively means that unless individual trusts were willing to pay Microsoft for an extended support deal, since May 2015 their operating systems have been extremely vulnerable to being hacked.”
>
> &mdash;[Letter from the shadow health secretary, Jonathan Ashworth, as relayed by The Guardian](https://www.theguardian.com/society/2017/may/13/jeremy-hunt-ignored-warning-signs-before-cyber-attack-hit-nhs)

The success of this attack within the NHS is not so remarkable when looking at **[comments on The Guardian](https://www.theguardian.com/technology/2015/may/26/uk-government-pcs-open-to-hackers-as-paid-windows-xp-support-ends)** from the time the support contract was cancelled. Some government offices have clearly migrated but others have not. Apparently this is still the case.

> “All XP machines were banned from accessing the network some time ago. There are still some around but they aren't connected and therefore don't represent a threat.”

> “I'm not sure why this is still a problem. I work in the public sector and there was a programme to replace or upgrade XP machines. After a certain date XP machines were banned from accessing the network.”

> “Currently running XP, as do 90% of the computers of the organisation. NHS.”

> “The vast majority of Ministry of Justice PCs still run XP (and Office 2003). Priority is inevitably being given to its Whitehall HQ. The hicks in the sticks will just have to wait till heaven knows when; years probably. Any sense of urgency is wholly absent yet at a time when further cuts are being demanded it's apparently ok to spend money keeping software they have had 7 years to upgrade secure.”

That this support is still available is remarkable - but necessary. Relatively few Software Engineers would relish working on Windows XP patches sixteen years after its original release. That Microsoft offer such an option is testament to how critical Windows XP machines remain in many organisations.

These issues may be getting worse over time. The situation is apparently *worse* with Android: modern phones would seem to be properly supported for about two years. Even during that time, security patches can be delayed a long time by the phone's vendor.

Earlier this year I briefly talked about an engineering role with NHS Digital. What I saw of salaries there was extremely underwhelming even on a Leeds cost-of-living, although I can't be certain of its accuracy. If salaries are so low then they rule themselves out of a great deal of talent, and either way it's clear that the NHS is in need of a major funding boost.

Optimistically this front-page news story (and potentially deaths!) will lead to a major investment and improvement to NHS and Government IT. In practice I am less than convinced such efforts will be sustained. Immediate, obvious issues will be fixed but as time moves on it might be forgotten until this happens again.

But we can hope for better. GDS seems to have transformed much of the public-facing Government IT into an improved state, and the same could happen for internal infrastructure. In addition, this could be a critical example when opposing Government [hopes to mandate backdoors](https://www.theregister.co.uk/2017/05/04/uk_bulk_surveillance_powers_draft/), if such arguments are properly used by campaigners. In the wake of this I think I'll contact my MP and give feedback on the wider issues.
