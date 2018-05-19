---
title: Building services with iMessage
tags: Hack
layout: post
---
Earlier this year, [David Kendal](http://dpk.org.uk) and I discovered you can fairly easily **send and receive iMessages using Ruby**. The key is to interact with OS X's Messages app, more specifically it's AppleScript bindings. We built and released [iREPL](http://irepl.im), a Scheme programming environment that you can use on your iPhone/iPad without having to jailbreak. I've been using it for months when I fancied hacking some Lisp.
<!--more-->

![](/assets/imessage-irepl-example.jpg)

An example of using iREPL to run some Scheme. The executed replies are entirely automated and come back in roughly 1 second. It's run without crashing since April, on a 2010 Mac Mini of mine.

I'm going to show you how to get started on your own iMessage hack, that bounces your iMessages back to you. Let's get started.

## What you'll need
These instructions are for OSX Mountain Lion, but should work for Lion onwards. If using Lion you'll have to [manually install Messages Beta](http://appldnld.apple.com/MessagesBeta/041-4274.20120216.z5km/MessagesBeta.dmg). I'll talk about some tools you can use to go beyond this tutorial later.

## About AppleScript
Included with OSX is a programming language called AppleScript, designed to resemble natural language as opposed to the syntax of languages like C or even Ruby. Open up the Preferences pane of Messages.app and click the Alerts tab. You'll notice a long list of events with the option to "Run an Applescript script".

![](/assets/imessage-events-intro.png)

Notice the AppleScript option. This is how we'll hook our programs up to iMessage.

## Getting going
The first thing to bear in mind is that Messages is heavily based on the previous iChat app. So much so, in fact, that even for iMessage it still forces you to "Accept" a new contact. The first thing to do therefore is to work around this by scripting it. Save the following script as `imessage-accept.scpt`:

``` applescript
using terms from application "Messages"
  on recieved text invitation the_message from the_buddy for the_chat
    accept the_chat
  end message received
end using terms from
```

Now tell Messages to run this whenever a new chat is initated. In the app Preferences, browse to Events, select the Text Invitation event and Choose your `imessage-accept.scpt` script.

![](/assets/imessage-autoaccept.png)

If you send yourself an iMessage now, then you'll notice nothing's changed from before. You might think this script is pointless, and you'd be correct: it's just needed if we're to intercept the first iMessage.

## Replying to iMessages
Next up is the actual replying. To keep things simple we're just going to reply to an iMessage saying the same thing (that is, we'll 'bounce' the iMessage). Save the following as `imessage-received.scpt`:

``` applescript
using terms from application "Messages"
  on message received the_message from the_buddy for the_chat
    send the_message to the_buddy
  end message received
end using terms from
```

Similarly to what you did with `imessage-accept.scpt`, set the Message Received Event to run your new `imessage-received.scpt` script. If you

You'll also need to update your `imessage-accept.scpt` script by adding the `send text to buddy` line, so that the first iMessage from a new contact also gets replied to. You'll need to reselect for the Text Invitation Event to update it's copy of your script. If you've done that right, `imessage-accept.scpt` should now look like this:

``` applescript
using terms from application "Messages"
  on recieved text invitation the_message from the_buddy for the_chat
    accept the_chat
    send the_message to the_buddy
  end message received
end using terms from
```

You're probably starting to get the picture. Every time you alter a script you need to reselect it for the Event, and Text Invitation runs exclusively for the first message you recieve from an iMessage user.

## Where to go from here
You've more than one option. What we did for iREPL was to use [MacRuby](http://macruby.org), a Ruby implementation designed for working closely with OS X. MacRuby makes it easy to interact with AppleScript bindings from a more popular programming language.

If you'd like to look into a bit more of how we put iREPL together, examine the source in it's [Github repository](https://github.com/46Bit/irepl).

One final bit of help: as an example of how to run shell commands securely, protected from shell-injection vulnerabilities:

``` applescript
using terms from application "iChat"
  on message received the_message from the_buddy for the_chat
    set quoted_message to quoted form of the_message
    set quoted_id to quoted form of (id of the_buddy as text)
    do shell script "echo " & quoted_message & " | ~/your-script-here.sh " & quoted_id
  end message received
end using terms from
```

[Let me know](/contact/) if you'd like a further tutorial on the MacRuby side of things as used in iREPL - although I can't claim to have more than a limited working knowledge.
