Return-Path: <linux-pm+bounces-14481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8797CD07
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE22855BF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD911A2C02;
	Thu, 19 Sep 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ELaFrwh2"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01881A2846;
	Thu, 19 Sep 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766798; cv=none; b=qgVNY2vwu+LXj2BM8jzmCHBJxxxRG8r4ErOpUk1EwYGhJObps2CyXZoz7CG1Bygw7//jOq1I0zjqHACar/HNy8Yz0DFfoXBxyMa1+fHGH/iS1DLKv4pBkOQ+y5IGOWfA073mN2xF+4lzKYp2soav4/8m+w9RufUlowJVFZiE6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766798; c=relaxed/simple;
	bh=TQWPNq8DyM/4me8VRKVsJwijLwYjiWGJi45ISt7PEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyiFyx3Il9QbksABCVzs2ovKSJUFSIGoCaAMLFQTLw422czNBV6Syhu38iQ/yRu7Tyq9kA16jzvet40gXJnVBeg7+cP+FWh+jfJtXIj9ugiSVmsP9l7eRR+E2+LIs8N05k4Sv3zBoACrgF8T6WkcQmHQMYhthy2pdGqMPgXcjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ELaFrwh2; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:6813:1156:549c:fa23])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 1A9D22E09C22;
	Thu, 19 Sep 2024 20:20:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726766414;
	bh=LfUaB5yPDbKb/LkMr/y9H5z351Im1vjb13XjVA1irWM=; h=From:To:Subject;
	b=ELaFrwh2lJhA5oftOjd5BYj1E/210X/98/WGCssDM7/9Slf7BsaPuf2LSl4S+6YDU
	 pIyLuhDZPM4CqJGC27VVBoBRs13c4Um9fRTTL5A7uITwbXbdZsmBchNgx6J0volMSY
	 ZKXJ0g5uQdbDaFBYtHkLX6AGKt2ZElTWTUaNElic=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:6813:1156:549c:fa23) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario.Limonciello@amd.com,
	luke@ljones.dev,
	me@kylegospodneti.ch
Subject: [PATCH v1 0/4] acpi/x86: s2idle: move Display off/on calls outside
 suspend (fixes ROG Ally suspend)
Date: Thu, 19 Sep 2024 19:19:48 +0200
Message-ID: <20240919171952.403745-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172676640787.26346.1362010344851206874@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The following series moves the Display off/on calls outside of the suspend sequence,
as they are performed in Windows. This fixes certain issues that appear
in devices that use the calls and expect the kernel to be active during their
call (especially in the case of the ROG Ally devices) and opens the possibility
of implementing a "Screen Off" state in the future (which mirrors Windows).

This series requires a bit of background on how modern standby works in Windows.
Fundamentally, it is composed of two stages: "Screen Off" and "Sleep".
Each stage consists of a series of steps, with the former focusing on software
and the latter focusing on the kernel.

The "Screen Off" stage is a software only stage, where the kernel and drivers
are fully active. In this stage, software is supposed to minimize non-essential
activity and to slowly coalesce into a state of non-activity over a period of
minutes. This can last from 1 second to hours, depending on device state (e.g.,
if it is plugged in). During research of this patch on Windows, most times it
fluxuates between 5 seconds to 10 minutes. To aid in battery life and in how
fast the system suspends, Microsoft provides the _DSM firmware notifications
"Display On" and "Display Off" that can be used to deactivate unnecessary
hardware (e.g., RGB).

The "Sleep" stage mirrors the traditional suspend sequence, in which kernel
components are succesively suspended to reach a low power state.

Currently, the kernel calls the Display On/Off calls during a late part of the
suspend sequence, where most drivers have already suspended. Since these calls
are not often used (and if they are, they are mostly used for lid switches),
this has not caused issues up to now (although a little birdie tells me those
lid sensors might not be behaving correctly currently).

That was until the release of ROG Ally, where Asus placed a callback that turns
the controller on and off in those _DSM calls. The Display Off call disconnects
(if powersave is off) or powers off (if powersave is on and on DC power) the MCU
responsible for the controller and deactivates the RGB of the device. Display On
powers on or reconnects the controller respectively.
This controller, in the Ally X, is composed of 6 HID devices that register to
the kernel. As can be inferred, the handling of the calls during the suspend
sequence leads to a set of undesirable outcomes, such as the controller
soft-locking or only half of the HID devices coming back after resume.

After moving the calls outside of the suspend sequence, my ROG Ally X test unit
can suspend more than 50 times without rebooting, both with powersave on or off,
regardless of whether it is plugged/unplugged during suspend, and still have the
controller work with full reliability.

In addition, moving the calls outside of the suspend sequence (and the validation
work it implies) opens the possibility of implementing a "Screen Off" state in
the future. This state would make a great addition to something like logind or
systemd, if it is exposed over a sysfs endpoint. The recommendation here would
be to allow userspace to instruct the kernel to enter "Screen Off" state when
the device becomes inactive. The kernel would then call "Display Off" and
delegade the responsibility of exiting "Screen Off" (and calling Display On)
to userspace, regardless of the number of the suspensions afterwards.
If userspace does not make the kernel enter "Screen Off" prior to suspend, the
kernel would call Display Off and On before suspending, in the same way it is
done with this patch.

This series is worth backing this up with sources, so as part of it I reference
Microsoft's documentation on Modern standby below that explains the difference
between "Screen Off" and "Sleep" and how to prepare for them and attach a
repository of more than 15 device DSDT tables from different manufacturers.
This repository also contains instructions on how to decode the DSDT tables on
a test laptop, to figure out what the _DSM calls will do on that device (in most
cases it is a NOOP).

Moreover, I conduct a short behavioral test in Windows with the Ally X to showcase
the documentation empirically. The Ally is great for such a test, as it contains
visual indicators for all Microsoft suspend points: "Display Off/On" calls are
indicated with the Controller RGB turning off/on, "Screen Off" is indicated with
the suspend light and fan being on, and suspend is indicated with the suspend
light blinking.

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
inactivity after 5 seconds) than the screen being off and as such it is
not something that would be a great fit for tying into the DRM subsystem.
If controlled by userspace and part of the screen turning off, it would also
solve several behavioral issues that currently exist. For example, as I look
at my Ally X dev right now, with its screen off, I notice the RGB is still on,
which is kind of bothersome, now that I know what the expected behavior is in
Windows.

This patch series is based on work of and communication with Mario Limonciello,
so Mario I would gladly credit you as a co-author here. It also references prior
upstream work by Luke Jones on Asus-wmi for the Ally controller quirk that is
removed on patch (4) and an issue on amd-drm in 2023 in preparation for that
the work in that quirk (reference below).

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/prepare-hardware-for-modern-standby
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/prepare-software-for-modern-standby
Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications
Link: https://github.com/hhd-dev/hwinfo/tree/master/devices
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2719

Antheas Kapenekakis (4):
  acpi/x86: s2idle: add support for screen off and screen on callbacks
  acpi/x86: s2idle: handle screen off/on calls outside of suspend
    sequence
  acpi/x86: s2idle: call screen on and off as part of callbacks
  platform/x86: asus-wmi: remove Ally (1st gen) and Ally X suspend quirk

 drivers/acpi/x86/s2idle.c       | 72 ++++++++++++++++++++++++++-------
 drivers/platform/x86/asus-wmi.c | 54 -------------------------
 include/linux/suspend.h         |  5 +++
 kernel/power/suspend.c          | 28 +++++++++++++
 4 files changed, 90 insertions(+), 69 deletions(-)

-- 
2.46.1


