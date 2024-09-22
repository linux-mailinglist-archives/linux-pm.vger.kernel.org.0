Return-Path: <linux-pm+bounces-14536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8397E2B6
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5721F2176F
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322E36124;
	Sun, 22 Sep 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AUbzA6pv"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DE27701;
	Sun, 22 Sep 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727025873; cv=none; b=Ln5EJx2cx9RQIi5lrg+7G2xfeYAZvvVXd5gBl2oQgEsiGxJOBu1tL9LLLODZHZhoDxZPHSyOpoLKdZio0gkZBo9QUS433HRea03kFNi9g3lvB7p+I5FA50JOAWdlFaTvyMcxy+nKfCB9ecrWCnZQG0omiWgjF1m6QwuiBKyqgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727025873; c=relaxed/simple;
	bh=bnLzN4Yd7SeUn+V//eSJ3+hynOp0RV3vLjgM9yCqLS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6apynzrRaPOSNwstLkL9Ta7txhPPhA2IbhgndFskpGZy36cIYgWTHLIpCn7cV+PPj0ykfBY20qA9qi9KcwRcbE3C4AmFJDYPPH14nA9H9IPjc4/YYVp8ehkD1I9H7jd6ytmKpJL59bFJGJYuOkiVCaqVBuszM/oI3d2HsBd1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AUbzA6pv; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id F29942E09564;
	Sun, 22 Sep 2024 20:24:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727025865;
	bh=9eM8YeUVGOodXZhBAVZeVu15EZfnaHTBOdy0q0xeTfo=; h=From:To:Subject;
	b=AUbzA6pvL5Ho7uzT9CVlQahKwlD+8bp7TVjovBdagB/lLEjAjHt+ZtrndLfnT0wbl
	 2w1PCSa05eIGVY/a8UD3TbbulO5RXFG51xrrtCliCUMB6cTZ3C5+cmF6Cj8r+iVQwq
	 920uKS9LzwJxU1HrQ2O4cBqos42VYv5oxW6QQwYU=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	luke@ljones.dev,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside
 suspend (fixes ROG Ally suspend)
Date: Sun, 22 Sep 2024 19:22:53 +0200
Message-ID: <20240922172258.48435-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172702586583.19468.15243485098059782940@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The following series moves the Display off/on calls outside of the suspend
sequence, as they are performed in Windows. This fixes certain issues that appear
in devices that use the calls and expect the kernel to be active during their
call (especially in the case of the ROG Ally devices) and opens the possibility
of implementing a "Screen Off" state in the future (which mirrors Windows).
In addition, it adds a quirk table that will allow for adding delays between
Modern Standby transitions, to help resolve racing conditions.

This series requires a bit of background on how modern standby works in Windows.
Fundamentally, it is composed of four states: "Active", "Screen Off", "Sleep",
and "DRIPS". Here, I take the liberty of naming the state "Active", as it is
implied in Windows documentation.

When the user actively interacts with a device, it is in the "Active" state.
The screen is on, all devices are connected, and desired software is running.
The other 3 stages play a role once the user stops interacting with the device.
This is triggered in two main ways: either by pressing the power button or by
inactivity. Once either of those targets is met, the system enters Modern Standby.

Modern Standby consists of an orchestration of the "Screen Off", "Sleep", and
"DRIPS" states. Windows is free to move throughout these states until the user
interacts with the device again, where the device will transition to being
"Active". Moving between the states implies a transition, where Windows performs
a set of actions. In addition, Windows can only move between adjacent states
as follows:

"Active" <-> "Screen Off" <-> "Sleep" <-> "DRIPS"

"Screen Off" is the state where all active displays in the device (whether
*virtual* or real; this means unrelated to DRM) are off. The user might still
be interacting with the device or running programs (e.g., compiling a kernel).

"Sleep" is a newer state, in which the device turns off its fan and pulses its
power button, but still supports running software activities. As part of this,
and to avoid overheating the device a lot of manufacturers lower the TDP (PLx)
of the device [3; _DSM 9 description].

Finally, DRIPS stands for Deepest Runtime Idle Power State, i.e. suspend.

While Windows may transition from any state to any state, doing so implies
performing all transitions to reach that state. All states other than DRIPS
have a fully active kernel (Wifi, USB at least) and allow userspace activity.
What changes is the extent of the activity, and whether some power consuming
devices are turned off (this is done with Modern Standby aware drivers and
firmware notifications). The Windows kernel suspends during the transition from
the "Sleep" state to the "DRIPS" state. In all other states it is active.

After finishing each transition, the kernel performs a firmware notification,
described in the _DSM document [3]. Moving from left to right with function num.,
we have Display Off (3; Active -> Screen Off), Sleep Entry (7; Screen Off -> Sleep),
and Lowest Power State Entry Notification (5; LPSEN; Sleep -> DRIPS). Then, from
right to left, we have Lowest Power State Exit Notification (6; DRIPS -> Sleep),
Sleep Exit (8; Sleep -> Screen) and Display On (4; Screen Off -> Active).

The Linux kernel is not currently Modern Standby aware but will still make these
calls. Currently, the problem is that the kernel calls all of the firmware
notifications at the point LPSEN (5, 6) should be called, which is when the
kernel is mostly suspended. This is a clear deviation from Windows, and causes
undesirable behavior in certain devices, the main one focused in this patch
series being the ROG Ally. Although series patch is aimed at Modern Standby
devices in general.

The ROG Ally is a Modern Standby capable device (uses Secure Core too; really
ticks all the MS boxes) and in it, there are issues with both Display 3,4
calls and Sleep 7,8 calls cause issues (7,8 are suspected and todo).

The Display 3,4 calls are responsible for the controller. The Display Off call
disconnects (if powersave is off) or powers off (if powersave is on and on DC
power) the MCU(s) responsible for the controller and deactivates the RGB of the
device. Display On powers on or reconnects the controller respectively.
This controller, in the Ally X, is composed of 6 HID devices that register to
the kernel. From testing, it seems that the majority of the problem in the Ally
comes from Display Off being called way too late timewise, and Display

The Sleep 7,8 calls, in general, are responsible for setting a low power state
that is safe to use while the device is sleeping, making the suspend light
pulse, and turning off the fan. Due to a variety of race conditions, there is
a rare occasion where the Ally EC can get stuck in its Sleep mode, where the
TDP is 5W, and prevent increasing it until the device reboots. The sleep entries
contain actions in the Ally, so there is a suspicion that calling them during
DRIPS is causing issues. However, this is not the subject of this patch and
has not been verified yet.

This patch centers around moving the Display 3,4 calls outside the suspend
sequence (which is the transition from Sleep to DRIPS in Modern Standby terms),
and by implementing the proper locks necessary, opening up the possibility of
making these calls as part of a more elaborate "Modern Standby"-like userspace
suspend/wakelock implementation. As of this patch, they are only called before
the suspend sequence, including with the possibility of adding a delay.

This makes the intent of this patch primarily compatibility focused, as it aims
to fix issues by the current implementation. And to that end it works.
After moving the calls outside of the suspend sequence, my ROG Ally X test unit
can suspend more than 50 times without rebooting, both with powersave on or off,
regardless of whether it is plugged/unplugged during suspend, and still have the
controller work with full reliability. In V1, there was an unsolved race condition
that was dealt by (5) before Display Off triggers. Essentially, Linux suspends
too fast for the current version of the firmware to deal with. After adding a
quirk table, which delays suspend after the Display Off call, the controller
of the original Ally should power off properly (a lot of testing will be done).

Moving the calls outside of the suspend sequence (and the validation work it
implies) is an important first step in including "Modern Standby"-like
features in Linux. For example, consider an endpoint /sys/power/standby, that
allows for entering "active", "inactive" (for Screen Off; since the name causes
too much confusion), "sleep" values. Those values will then in turn call the
respective firmware notifications (and driver callbacks in the very future)
for all transitions required to reach the entered state. Here, the value
"suspend" (for DRIPS; another confusing name as it can refer to drivers) is
missing, as userspace will never be able to see it. The kernel should support
suspending at all standby states, orchestrating the required transitions to
reach suspend/DRIPS and after suspend returning to the last state.

Therefore, if userspace is not standby aware, the kernel will work the same way
it works today. In addition, depending on hardware generation, certain power
states might not be supported. It is important to inform userspace of this, as
if the hardware does not support sleep, and userspace holds a wakelock for sleep,
it will just overheat and drain the device battery.

This series is worth backing this up with sources, so as part of it I reference
Microsoft's documentation on Modern standby [1-3] that explains the whole
process, including a document by Dell [7] and how to prepare for them and attach a
repository of more than 15 device DSDT tables [4] from different manufacturers.
This repository also contains instructions on how to decode the DSDT tables on
a test laptop, to figure out what the _DSM calls will do on that device.

Moreover, I conduct a short behavioral test in Windows with the Ally X to showcase
the documentation empirically. The Ally is great for such a test, as it contains
visual indicators for all Microsoft suspend points: "Display Off/On" calls are
indicated with the Controller RGB turning off/on, "Screen Off" is indicated with
the suspend light and fan being on, and Sleep is indicated with the suspend
light blinking.

Unfortunately, as part of this testing, I never found how to see if the device
is actually suspended. As the ROG Ally X NOOPs on firmware notifications 5,6,
and even though I disabled a Mouse from waking up a device, it still would wake
up my Ally X dev unit.

Referencing Microsoft's documentation, "Screen Off" is entered either through
inactivity or by pressing the power button, so I conduct two tests: one by pressing
the powerbutton, and one for entering Screen Off due to inactivity.

1) Powerbutton test:
When pressing the powerbutton, the screen of the Ally turns off, and the RGB of
the controller faints to off within 1s. Following, depending on whether the
system is plugged in, the power light and fan stay on for 5 seconds to 10 minutes.
After this point, the power light begins to blink and the fan turns off, showing
that the system has entered the "Sleep" state.

2) Inactivity test:
I set the Windows power settings to turn off the screen after 1 minute and wait.
After one minute, the display turns off, and after 5 seconds, the controller RGB
turns off. This indicates to me that "Screen Off" is not defined by the screen
being off, but is rather characterized by it. During those 5 seconds while the
RGB is on, I can use the controller to wake up the device. Afterwards it cannot.

Those tests validate Microsoft's documentation and show that "Screen Off"
seems to more closely correlate to lockscreen behavior (button locks instantly,
inactivity after 5 seconds) than the screen being off. One other behavior I
notice is that, as I look at my Ally X dev right now, with its screen off, I
notice the RGB is still on, which is kind of bothersome, as in Windows the
device would turn the RGB off. Whether as a side effect or planned, it is still
a nice touch.

This patch series is developed with help from Mario Limonciello, and, to be
bisection friendly, is structured based on a patch series he made connecting the
callbacks to the drm subsystem suspend [5]. It also references (already)
upstream work by Luke Jones on Asus-wmi for the Ally controller quirk that is
removed on patch (5) and an issue on amd-drm in 2023 in preparation for the
work in that quirk [6]. Since patch (3) now uses part of the dmi table removed
in patch (5) and adds a (small) delay, @Luke I can add you as Suggested-by.

We will begin testing on the patch series, and there will probably be a V3,
where testing acknowledgements are added. V2 patch adds a delay to display_off
(500ms), where 300-1300ms were tried, and there was no behavioral difference on
the Ally X. However, that is arbitrary so it warrants a lot of testing.
Current status is that my Ally X unit works perfectly other than a little quirk:
with powersave on, if asus_hid or a userspace program talks to it within
2 seconds, it causes the RGB to softfade to off and then on. This is a cosmetic
issue that can be dealt with by userspace (waiting 2s) or a firmware update
or both. Windows did not seem to fare much better either in that regard, with
RGB turning on and off randomly. Original Ally still needs to be verified.

I am personally going to take a bit of a breather on this patch, test it, and
revisit it next week. I send it today so I get comments on the revision.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/prepare-hardware-for-modern-standby [1]
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/prepare-software-for-modern-standby [2]
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications [3]
Link: https://github.com/hhd-dev/hwinfo/tree/master/devices [4]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/dsm-screen-on-off [5]
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2719 [6]
Link: https://dl.dell.com/manuals/all-products/esuprt_solutions_int/esuprt_solutions_int_solutions_resources/client-mobile-solution-resources_white-papers45_en-us.pdf [7]

Changes in v2:
 - Rewrote cover letter to better reflect the Windows Modern Standby sequence
 - Renamed the "screen_" callbacks to "display_" to match Microsoft's naming
 - Added attribution to Mario Limonciello and changed the text to reflect that
 - Made the screen on/off callbacks warn and bail with -EINVAL if they are
   called in the wrong order (currently impossible)
    - Changed patch 2 to not bail the suspend sequence when receiving an error
      (as these calls are not part of the suspend sequence and failing the
      suspend sequence would cause a user visible fault)
 - Fixed bug reported by Denis Benato by adding a quirk table in patch (3)
    - The ROG controllers get a slight delay after the Display Off call
    - This delay fixes a race condition with the controller disconnecting from
      the system before being powered off
    - Reworded patches to reflect that
 - Moved the display calls a bit higher up the suspend sequence in patch (2)

Antheas Kapenekakis (5):
  acpi/x86: s2idle: add support for Display Off and Display On callbacks
  acpi/x86: s2idle: handle Display On/Off calls outside of suspend
    sequence
  acpi/x86: s2idle: add quirk table for modern standby delays
  acpi/x86: s2idle: call Display On/Off as part of callbacks and rename
  platform/x86: asus-wmi: remove Ally (1st gen) and Ally X suspend quirk

 drivers/acpi/x86/s2idle.c       | 89 +++++++++++++++++++++++----------
 drivers/platform/x86/asus-wmi.c | 54 --------------------
 include/linux/suspend.h         | 10 ++++
 kernel/power/suspend.c          | 62 +++++++++++++++++++++++
 4 files changed, 134 insertions(+), 81 deletions(-)

-- 
2.46.1


