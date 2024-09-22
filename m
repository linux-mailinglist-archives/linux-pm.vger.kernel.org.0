Return-Path: <linux-pm+bounces-14543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CFD97E2DF
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 20:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC353B20B58
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E421B27453;
	Sun, 22 Sep 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNsU4DE0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961826AD0
	for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727029003; cv=none; b=fFp0eZdinO/bPlbudoMJ08OK2vJz8IBxw/7Y8xUj1M2c5oFK1Ik5IAj9w3217PF0vWclYoDnbwrBgLo1mu8gRUXcQTxHMoK77Wdcjc0myadn5yDx2mvltMmypAcaK4z9Yh2QeWV14VkfHddiw4tpyI/TKXwkx9IAw38+16mGrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727029003; c=relaxed/simple;
	bh=VzshTOT4o8+sUdUKoj3V1s6bhFuYvZYpbEILsZR5j6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcFO7TpEErm9fvSW/hLGTAx5Wz0XXsQ4VKQYG0AOuZIY/tNWhO1nZo2obvirW8Bv5351wLqbXVYOUgqKtbQJf0JUYf2H/vAD0RiNDI6SQs568hDbUqZEv9KVWzFs2Gq6xygN4Vpe41I85Kxyximqix0AEMAHKfxNHEzyKXnzrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNsU4DE0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71781f42f75so3489427b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727029001; x=1727633801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76dqHsgdfoqtXa7x+iMQxtaYoqfR5NsFgcPNYR36iLg=;
        b=LNsU4DE0kCWd3JO89eJBpRJTv22zjfTu8Ur1CBvOo4e0oG4TfH6HpdedzxSpbyys2m
         n6KXrb9JRMXerBWffAQgLwpaMfXFUqVWoKT5nUag7+qsOn/haSWlXrZjJFzw+G66QJOy
         RsXXsEilwAyjta/r56LZJjzfN16oPKsv3ajj638xkbvgvbwxSCz+qE3I3JeuB62A/W6w
         sMgF+nHfVMg+wcRqL3eB4PJ+rzZOlHBUXILSoJgox++ziEEPN6xki5BnwqIRgbJ0LlPe
         V77HAzT5ULYRGMPL1s+35puyxpv26zN1mSssy/fezWmDni0k8T8lxqVbPAqkl/U3TKPA
         +syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727029001; x=1727633801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76dqHsgdfoqtXa7x+iMQxtaYoqfR5NsFgcPNYR36iLg=;
        b=jeD5p7pQTVskwyMJbOvdJ7L8NyiUI8pY/Da6QiHTl9Z736TENpvBEzlIX4edoTgwEJ
         QbdhP3WZH/j5javq+3gd8hv9cpwArvA7BkmXpX+/sf3EEzwOV4UmRoWfJmXhjIICRLSv
         psDq7XaM7Hbz+oGmWn9m/ZEFao81rY0YoAG2F16Q5q1rfZjjYGxjflp2pwFVeqm4IelB
         Xy2TWqb6KK14N9aMRxWQ1Io07GCkfln4TClZLSKOu49/qb2R3E9EhpQ1wSFOunosFJwE
         4GytE9MazYrvlVmHoZ3jGRwF6foePts8GmG2vQ+2Iax81FY+Dq7MRidfL5MCk9OV7yJI
         0vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78AMFEZMw/k0eqbvds9b4aMu0tw2C0sA6pWYJsaqM/ELgTx6JAU8LK46EwhO9DUKC65CS1IR14A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzouwc6ZmX1dYkSM969BSvmWglvCVZ7Qc+gfqNgxCQKwsfUG8zF
	OCv3SkFvEE68zRyk/e3h3lP8QKJtYFBhSRVUctQoPw79xy65Xr8s
X-Google-Smtp-Source: AGHT+IGDwjHlT4xCaUEla7O4B3mExSJ01qcLMMOTHtnR/x1sgbjyrFBCcwfBsx7ULTrfFVnt4LI7iA==
X-Received: by 2002:a05:6a20:4f14:b0:1d3:ed2:5375 with SMTP id adf61e73a8af0-1d30ed256edmr10107804637.27.1727029000717;
        Sun, 22 Sep 2024 11:16:40 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7cfa1sm12705002b3a.104.2024.09.22.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 11:16:40 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Luke Jones <luke@ljones.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	linux-pm@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside suspend (fixes ROG Ally suspend)
Date: Sun, 22 Sep 2024 11:15:41 -0700
Message-ID: <20240922181543.22988-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240922172258.48435-1-lkml@antheas.dev>
References: <20240922172258.48435-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Antheas.

> The following series moves the Display off/on calls outside of the suspend
> sequence, as they are performed in Windows. This fixes certain issues that appear
> in devices that use the calls and expect the kernel to be active during their
> call (especially in the case of the ROG Ally devices) and opens the possibility
> of implementing a "Screen Off" state in the future (which mirrors Windows).
> In addition, it adds a quirk table that will allow for adding delays between
> Modern Standby transitions, to help resolve racing conditions.
> 
> This series requires a bit of background on how modern standby works in Windows.
> Fundamentally, it is composed of four states: "Active", "Screen Off", "Sleep",
> and "DRIPS". Here, I take the liberty of naming the state "Active", as it is
> implied in Windows documentation.
> 
> When the user actively interacts with a device, it is in the "Active" state.
> The screen is on, all devices are connected, and desired software is running.
> The other 3 stages play a role once the user stops interacting with the device.
> This is triggered in two main ways: either by pressing the power button or by
> inactivity. Once either of those targets is met, the system enters Modern Standby.
> 
> Modern Standby consists of an orchestration of the "Screen Off", "Sleep", and
> "DRIPS" states. Windows is free to move throughout these states until the user
> interacts with the device again, where the device will transition to being
> "Active". Moving between the states implies a transition, where Windows performs
> a set of actions. In addition, Windows can only move between adjacent states
> as follows:
> 
> "Active" <-> "Screen Off" <-> "Sleep" <-> "DRIPS"
> 
> "Screen Off" is the state where all active displays in the device (whether
> *virtual* or real; this means unrelated to DRM) are off. The user might still
> be interacting with the device or running programs (e.g., compiling a kernel).
> 
> "Sleep" is a newer state, in which the device turns off its fan and pulses its
> power button, but still supports running software activities. As part of this,
> and to avoid overheating the device a lot of manufacturers lower the TDP (PLx)
> of the device [3; _DSM 9 description].
> 
> Finally, DRIPS stands for Deepest Runtime Idle Power State, i.e. suspend.
> 
> While Windows may transition from any state to any state, doing so implies
> performing all transitions to reach that state. All states other than DRIPS
> have a fully active kernel (Wifi, USB at least) and allow userspace activity.
> What changes is the extent of the activity, and whether some power consuming
> devices are turned off (this is done with Modern Standby aware drivers and
> firmware notifications). The Windows kernel suspends during the transition from
> the "Sleep" state to the "DRIPS" state. In all other states it is active.
> 
> After finishing each transition, the kernel performs a firmware notification,
> described in the _DSM document [3]. Moving from left to right with function num.,
> we have Display Off (3; Active -> Screen Off), Sleep Entry (7; Screen Off -> Sleep),
> and Lowest Power State Entry Notification (5; LPSEN; Sleep -> DRIPS). Then, from
> right to left, we have Lowest Power State Exit Notification (6; DRIPS -> Sleep),
> Sleep Exit (8; Sleep -> Screen) and Display On (4; Screen Off -> Active).
> 
> The Linux kernel is not currently Modern Standby aware but will still make these
> calls. Currently, the problem is that the kernel calls all of the firmware
> notifications at the point LPSEN (5, 6) should be called, which is when the
> kernel is mostly suspended. This is a clear deviation from Windows, and causes
> undesirable behavior in certain devices, the main one focused in this patch
> series being the ROG Ally. Although series patch is aimed at Modern Standby
> devices in general.
> 
> The ROG Ally is a Modern Standby capable device (uses Secure Core too; really
> ticks all the MS boxes) and in it, there are issues with both Display 3,4
> calls and Sleep 7,8 calls cause issues (7,8 are suspected and todo).
> 
> The Display 3,4 calls are responsible for the controller. The Display Off call
> disconnects (if powersave is off) or powers off (if powersave is on and on DC
> power) the MCU(s) responsible for the controller and deactivates the RGB of the
> device. Display On powers on or reconnects the controller respectively.
> This controller, in the Ally X, is composed of 6 HID devices that register to
> the kernel. From testing, it seems that the majority of the problem in the Ally
> comes from Display Off being called way too late timewise, and Display
> 
> The Sleep 7,8 calls, in general, are responsible for setting a low power state
> that is safe to use while the device is sleeping, making the suspend light
> pulse, and turning off the fan. Due to a variety of race conditions, there is
> a rare occasion where the Ally EC can get stuck in its Sleep mode, where the
> TDP is 5W, and prevent increasing it until the device reboots. The sleep entries
> contain actions in the Ally, so there is a suspicion that calling them during
> DRIPS is causing issues. However, this is not the subject of this patch and
> has not been verified yet.
> 
> This patch centers around moving the Display 3,4 calls outside the suspend
> sequence (which is the transition from Sleep to DRIPS in Modern Standby terms),
> and by implementing the proper locks necessary, opening up the possibility of
> making these calls as part of a more elaborate "Modern Standby"-like userspace
> suspend/wakelock implementation. As of this patch, they are only called before
> the suspend sequence, including with the possibility of adding a delay.
> 
> This makes the intent of this patch primarily compatibility focused, as it aims
> to fix issues by the current implementation. And to that end it works.
> After moving the calls outside of the suspend sequence, my ROG Ally X test unit
> can suspend more than 50 times without rebooting, both with powersave on or off,
> regardless of whether it is plugged/unplugged during suspend, and still have the
> controller work with full reliability. In V1, there was an unsolved race condition
> that was dealt by (5) before Display Off triggers. Essentially, Linux suspends
> too fast for the current version of the firmware to deal with. After adding a
> quirk table, which delays suspend after the Display Off call, the controller
> of the original Ally should power off properly (a lot of testing will be done).
> 
> Moving the calls outside of the suspend sequence (and the validation work it
> implies) is an important first step in including "Modern Standby"-like
> features in Linux. For example, consider an endpoint /sys/power/standby, that
> allows for entering "active", "inactive" (for Screen Off; since the name causes
> too much confusion), "sleep" values. Those values will then in turn call the
> respective firmware notifications (and driver callbacks in the very future)
> for all transitions required to reach the entered state. Here, the value
> "suspend" (for DRIPS; another confusing name as it can refer to drivers) is
> missing, as userspace will never be able to see it. The kernel should support
> suspending at all standby states, orchestrating the required transitions to
> reach suspend/DRIPS and after suspend returning to the last state.
> 
> Therefore, if userspace is not standby aware, the kernel will work the same way
> it works today. In addition, depending on hardware generation, certain power
> states might not be supported. It is important to inform userspace of this, as
> if the hardware does not support sleep, and userspace holds a wakelock for sleep,
> it will just overheat and drain the device battery.
> 
> This series is worth backing this up with sources, so as part of it I reference
> Microsoft's documentation on Modern standby [1-3] that explains the whole
> process, including a document by Dell [7] and how to prepare for them and attach a
> repository of more than 15 device DSDT tables [4] from different manufacturers.
> This repository also contains instructions on how to decode the DSDT tables on
> a test laptop, to figure out what the _DSM calls will do on that device.
> 
> Moreover, I conduct a short behavioral test in Windows with the Ally X to showcase
> the documentation empirically. The Ally is great for such a test, as it contains
> visual indicators for all Microsoft suspend points: "Display Off/On" calls are
> indicated with the Controller RGB turning off/on, "Screen Off" is indicated with
> the suspend light and fan being on, and Sleep is indicated with the suspend
> light blinking.
> 
> Unfortunately, as part of this testing, I never found how to see if the device
> is actually suspended. As the ROG Ally X NOOPs on firmware notifications 5,6,
> and even though I disabled a Mouse from waking up a device, it still would wake
> up my Ally X dev unit.
> 
> Referencing Microsoft's documentation, "Screen Off" is entered either through
> inactivity or by pressing the power button, so I conduct two tests: one by pressing
> the powerbutton, and one for entering Screen Off due to inactivity.
> 
> 1) Powerbutton test:
> When pressing the powerbutton, the screen of the Ally turns off, and the RGB of
> the controller faints to off within 1s. Following, depending on whether the
> system is plugged in, the power light and fan stay on for 5 seconds to 10 minutes.
> After this point, the power light begins to blink and the fan turns off, showing
> that the system has entered the "Sleep" state.
> 
> 2) Inactivity test:
> I set the Windows power settings to turn off the screen after 1 minute and wait.
> After one minute, the display turns off, and after 5 seconds, the controller RGB
> turns off. This indicates to me that "Screen Off" is not defined by the screen
> being off, but is rather characterized by it. During those 5 seconds while the
> RGB is on, I can use the controller to wake up the device. Afterwards it cannot.
> 
> Those tests validate Microsoft's documentation and show that "Screen Off"
> seems to more closely correlate to lockscreen behavior (button locks instantly,
> inactivity after 5 seconds) than the screen being off. One other behavior I
> notice is that, as I look at my Ally X dev right now, with its screen off, I
> notice the RGB is still on, which is kind of bothersome, as in Windows the
> device would turn the RGB off. Whether as a side effect or planned, it is still
> a nice touch.
> 
> This patch series is developed with help from Mario Limonciello, and, to be
> bisection friendly, is structured based on a patch series he made connecting the
> callbacks to the drm subsystem suspend [5]. It also references (already)
> upstream work by Luke Jones on Asus-wmi for the Ally controller quirk that is
> removed on patch (5) and an issue on amd-drm in 2023 in preparation for the
> work in that quirk [6]. Since patch (3) now uses part of the dmi table removed
> in patch (5) and adds a (small) delay, @Luke I can add you as Suggested-by.
> 
> We will begin testing on the patch series, and there will probably be a V3,
> where testing acknowledgements are added. V2 patch adds a delay to display_off
> (500ms), where 300-1300ms were tried, and there was no behavioral difference on
> the Ally X. However, that is arbitrary so it warrants a lot of testing.
> Current status is that my Ally X unit works perfectly other than a little quirk:
> with powersave on, if asus_hid or a userspace program talks to it within
> 2 seconds, it causes the RGB to softfade to off and then on. This is a cosmetic
> issue that can be dealt with by userspace (waiting 2s) or a firmware update
> or both. Windows did not seem to fare much better either in that regard, with
> RGB turning on and off randomly. Original Ally still needs to be verified.
> 
> I am personally going to take a bit of a breather on this patch, test it, and
> revisit it next week. I send it today so I get comments on the revision.


I will get into this a little below, but this is not a full and accurate
accounting of what the ROG Ally devices are doing. Before that, I want to
summarize the premise of your proposal. A somewhat oversimplified version might
read as: two systems have an issue where some of the hardware is resumed in a
bad state, and you intend to resolve that issue by reorganizing the idle
process. The reason you want to do this is because you have an intuitive idea
of what those two devices are doing based on reading ACPI tables and guesswork.
Furthermore, this proposal will have additional knock-on effects for millions
of devices that aren't affected by the core issue you are trying to solve, and
you have no way to test all of them. Finally, the solution provided introduces
new issues (as reported by Denis and not yet resolved) for the hardware it is
meant to fix. And you want to do this in spite of knowing the manufacturer is
providing a firmware update that will resolve this issue without any changes
needed in the kernel.

I can confidently state that you don't fully understand the technical issue at
hand as you are missing information on how and why the MCU functions as it
does, so I will add a small amount of background containing information I am
permitted to share. While developing the Ally in Windows, ASUS noticed an issue
with spurious wakeups. To correct this, they added a flag as a workaround that
reports state information internally so they can time certain events during the
synchronous suspend and resume that Windows does to ensure the MCU is asleep or
awake when it needs to be. As Linux has an asynchronous suspend and resume,
this flag causes the extremely timing sensitive quirk to trigger at the wrong
time quite often. There is a group of us who have spent collectively thousands
of hours troubleshooting this issue, so I can confidently say your proposed
DMI quirk suffers from the same issue that all previous attempts to fix it in
kernel do; there is too much variability in how long each piece of this puzzle
takes to reach its full sleep state. Every possible kernel fix is trying to
manage the race condition in the firmware. This inevitably leads to situations
where the Windows quirk triggers a bad state because it doesn't know it is
already resuming, or it wakes early thinking it should have already resumed.
The quirk in 3/5 is masking this issue for your setup, but that delay will be
too long for some configurations and too short for others. Ironically, in an
attempt to fix the issues Denis found, 3/5 moves the delay you're removing in
5/5 outside the device driver. While I'm not allowed to divulge all the
technical details here, I can state your deeper dive into DRIPS is still
missing some key information. My point being this approach appears, at least
to me, to be a major paradigm shift in how suspend is handled so that a
bandaid can be applied that solves a problem in *some* cases while introducing
more problems in others. I do not think that is a valid approach.

The 50 suspend/resume cycles you tested are only valid for your system, with
your power profile settings, running your OS, using your kernel config,
running the same userspace software you have. I know this because we also
reached the same conclusion as you with dozens of patch iterations, many doing
effectively the same thing as this series, only to have 1 device fail on a
different OS or with a different kernel config. The details of this have been
known by ASUS and us for almost a month now and we have been working with them
directly to find a proper hardware level fix for it. They have provided two
testing MCU firmware for us and I can confirm that they resolve the issue in
every kernel and situation we previously tested on both devices. I would like
to gently remind you that manufacturers intent should predominate in these
situations, especially when their intent is to avoid making drastic changes to
the kernel to support a small number of devices. We are also working on a
fwupd module for the MCU so that it can be updated from within Linux directly.
In the meantime, until it is available, dual booting and Win2Go are valid
options for getting the MCU update while that interface is not completed. Luke
will be providing a patch series soon to address backwards compatibility for
the Ally, details to follow. 

As I have already upgraded both of my units testing the manufacturer approved
fix, I cannot provide you with validation testing of the patches here. My
devices simply work with any kernel. Having said that, I am intrigued by the
proposal to add feature parity of Windows modern sleep into Linux. That topic
deserves a request for comment thread in its own right that brings in all the
major subsystem stakeholders and primary userspace components (systemd) so that
a conversation can be had on how best to approach the topic while maintaining
backwards compatibility, and not requiring the extreme level of validation this
patch would require. In that same vein I recommend you drop the unnecessary
adjustments to asus-wmi in 5/5 and the quirks in 3/5, and instead defer to the
manufacturer intentions. If adding general modern sleep support is your
intention then it would be best to focus on that issue.

Thank you for your time,
Derek

