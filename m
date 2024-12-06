Return-Path: <linux-pm+bounces-18720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F186A9E7B2A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2439318848F5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5020459D;
	Fri,  6 Dec 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="42qtEUOF"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB522C6C0;
	Fri,  6 Dec 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521503; cv=none; b=pwXb0suSzC6LOeJguhTDW1UIMF/shyS0XFbzhmPcT6SLinrNWvghr955SCp8oU8/E1aYE1YhOP1uVQtLZv59vFRiu4VQf7XYVG52d+F3QoD9SlRIvWG1UkE+ACls/ZMlzA3NkAgQdCP/P0OjhUnqA6qMpnfj/GPh+kyrs/eUWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521503; c=relaxed/simple;
	bh=aJWZPAiWAxucwbjk7jb9g/Vq3AuP4WmybZ/3vCS6qSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDYlcgAAD0mnj4JNBP1VuXhz2RDZPdMzFiQcjcivq+w4YRcQp65yvN/Id/leYNAuQKlHJqPqCF3aFbuypWm5qCsdtsmVxdBFcWbXiKKR0571cBctGK0CUW+CKtJQn+/AaFodmn+rUOOfB99KO7XrG21ibocKh0zJLPvR6wy590I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=42qtEUOF; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2BDAD2E08B10;
	Fri,  6 Dec 2024 23:37:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1733521060;
	bh=sUIZ7yFiwkQs7/RyRHjph86Tz7Z33Zp4mkGsfwbVWjw=;
	h=Received:From:Subject:To;
	b=42qtEUOFJrKln6b5nS7YdbvjNGKGAGrpi4eJsHe7q41DKxatcYNdZlA9FKB6uXXFm
	 OX02FsNjh2EFWt/YLW9A6K3EHva8duZ28S8mK41eiiXbmSjRvdzBrivA+IUULb4gHh
	 4xHaygJKjo7dnFeZflZslJd/Ws4BSltW4gEhWMxo=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2ffc7a2c5d5so25381941fa.1;
        Fri, 06 Dec 2024 13:37:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXi9iLN0CNyeQ8z/Wy4D2/4tR6fc9c0QABGz2mqI+Ks8U3FTx13ZFVwRFd+dXwGkGnaxJABdFzlAFaQ+hEoxFBXdTNA@vger.kernel.org
X-Gm-Message-State: AOJu0YyutUN8m/3pPOYt2qY8FhzJXV+gK6lrfcBkZouruxm+dprY6Q/X
	mGe9dBly/QahNjOE6EsjhqIwlIpYKgGqGhgnTdqiVJVeWXqZA376cBAlimr7Rppavqvi4ARBFs+
	JFsyOOot0xkKZOamp2C/GGg+LCSE=
X-Google-Smtp-Source: 
 AGHT+IEiHgR5xIO6c0tBPqpY3rl5MAN0+xVjFvG+Gf/34uH+FygSQslFHHGsFHFwoh1tTLgAr86tfegbq0Ys3XZA2cM=
X-Received: by 2002:a2e:ab0f:0:b0:2ff:7a4f:e770 with SMTP id
 38308e7fff4ca-3002fc68eaemr15238351fa.31.1733521057001; Fri, 06 Dec 2024
 13:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121172239.119590-1-lkml@antheas.dev>
 <CAJZ5v0gDg57skLVOH32NtmhCEXGw_m63az4jWRJgkUq6qTsqgQ@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0gDg57skLVOH32NtmhCEXGw_m63az4jWRJgkUq6qTsqgQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 6 Dec 2024 22:37:25 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEmgtWFD=dErONA8zitPCUhK6JNu6Y-6_AHEiEev7AWvw@mail.gmail.com>
Message-ID: 
 <CAGwozwEmgtWFD=dErONA8zitPCUhK6JNu6Y-6_AHEiEev7AWvw@mail.gmail.com>
Subject: Re: [RFC 00/13] acpi/x86: s2idle: implement Modern Standby transition
 states and expose to userspace
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <173352105855.19321.17167263946980701921@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Rafael,
since 6.13-rc1 is out, hopefully you can have a look over the next few days

We have deployed a variant of this patchset now on desktop builds as
well for over 2 months now, and we haven't had any regressions
reported. We have also been using it on handheld builds, where for the
last 2 or so weeks we transition to the sleep state and fire the dpms
as part of the systemd sleep target, and it makes a big difference in
how devices look when suspending and hibernating.

Essentially, as soon as the suspend animation plays, the screen and
rgb of the devices turn off instantly, and the power light of devices
that have it as part of the sleep call begins to flash. Then, after a
few seconds, the fan of the devices turns off. Before, they'd show a
stale framebuffer and have the RGB be on until almost the suspend
sequence is over.

This is also true for hibernation, where before the RGB lights of the
devices would stay on during the suspend sequence and the device would
show a stale frame buffer on the screen. Now the devices look like
they are suspended while initializing hibernation and then just turn
off

Maybe I need to shoot a video with it..

So I'd love to hear your thoughts. Can you expand on what you mean by
not backwards compatible?

I know that it is not backwards compatible in the way where if the
compositor/init system are not aware of it, the display on/off
notifications will not fire automatically when the displays turn off.

Antheas

On Thu, 21 Nov 2024 at 18:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 21, 2024 at 6:28=E2=80=AFPM Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
> >
> > The following series moves the _DSM 3,4,7,8 firmware notifications outs=
ide
> > the suspend sequence, and makes them part of a transition function, whe=
re
> > the system can transition freely between them when it is not suspended.
> > This transition function is exposed to userspace, which now gains the
> > ability to control the presentation of the device (e.g., pulse the susp=
end
> > light) without forcing the kernel to suspend. In addition, it adds supp=
ort
> > for the _DSM 9 call Turn Display On, which was introduced in Windows 22=
H2
> > and aims to speed up device wake-up while remaining in the "Sleep" stat=
e.
> > If userspace is not standby aware, the kernel will bring the system int=
o
> > the "Sleep" state before beginning the suspend sequence.
>
> I'll get to this when 6.13-rc1 is out, but I can tell you right away
> that some of the above cannot be done without breaking backwards
> compatibility.
>
> > This series requires a bit of background on how modern standby works in
> > Windows. Windows has a concept of "Modern Standby" [1], where it perfor=
ms
> > an elaborate userspace and kernel suspend choreography while the device=
 is
> > inactive in order to maintain fast wake-up times and connectivity while=
 the
> > display of the device is off. This is done through 5 hardware states an=
d
> > the OS takes the liberty of transitioning between them, by following a =
set
> > of rules (e.g., "Adaptive Hibernate").
> >
> > ```
> >                                  \/-> "Hibernate (S4)"
> > "Active" <-> "Screen Off" <-> "Sleep" <-> "DRIPS"
> >                   /\-  "Resume"  <-         <-
> > ```
> >
> > When the display is on and the user is interacting with the device, it =
is
> > in the "Active" state. The moment the display turns off, the device
> > transitions to the "Screen Off" state, where hardware and userspace are
> > fully active. Userspace will then decide when appropriate to freeze maj=
or
> > components (such as the DE) and transition into the "Sleep" state, wher=
e
> > the kernel is still active and connectivity is maintained. Finally, the
> > conventional "Suspend-to-idle" path can be used to bring the system int=
o
> > the deepest runtime idle platform state (DRIPS) state, which is named
> > "s2idle" in the Linux kernel.
> >
> > After wake-up, the system re-transitions into the "Sleep" state, where
> > userspace can run housekeeping and/or hibernate if the wake-up was not =
user
> > initiated (e.g., timer). If user-initiated, userspace can hasten the
> > transition out of the "Sleep" state by transitioning into the state
> > "Resume" that certain devices use to boost the Power Limit (PLx) while
> > remaining in sleep (support for this new notification is rare). Then, i=
t
> > transitions back into "Screen Off" and "Active" to prepare for the user=
.
> >
> > All transitions between these states feature unique firmware notificati=
ons
> > [3] that change the presentation of the device (e.g., pulse the suspend
> > light, turn off RGB). For more information, see the docs in [8]. Making
> > these transitions accessible from userspace moves them out of the suspe=
nd
> > sequence and has them happen while the kernel is fully active, mirrorin=
g
> > Windows.
> >
> > As a side effect, this patch series completely fixes the ROG Ally
> > controller issue [5], which expects for .5s to lapse before its
> > controller's USB hub goes into D3 and otherwise malfunctions. It also f=
ixes
> > an issue present in (allegedly only) older firmwares where they check t=
he
> > USB subsystem is not in D3 before allowing the controller to wake up wh=
ile
> > in powersave mode (for avoiding spurious wake-ups). As such, this patch
> > series is also a universal fix for the ROG Ally controller.
> >
> > Moreover, this patch series allows turning off the controller and RGB o=
f
> > most Windows handhelds (OneXPlayer, Lenovo Legion Go, GPD, and Asus ROG
> > Ally), opening the possibility of implementing suspend-then-hibernate a=
nd
> > other standby features, such as background downloads, without waking up=
 the
> > RGB/controller of those devices. A Thinkpad T14 2021 was also tested, a=
nd
> > it pulses its suspend light during sleep.
> >
> > There is still the question of where LSP0 entry/exit (_DSM 5,6) should =
be
> > fired or whether they should be fired in the path to hibernation. Howev=
er,
> > as they cause no issues currently, and they fire when software activity=
 has
> > seized, they are fine where they are.
> >
> > It is important to note that the effects of these _DSMs persist during
> > reboots. I.e., if the Legion Go reboots while in the "Sleep" state, it =
will
> > boot into the "Sleep" state and have its controller disabled and suspen=
d
> > light pulsing. The reboot persistence is undesirable, so the reboot pat=
h
> > will need to include a transition to active prior to reboot (not
> > included in this series). This is not the case after shutdown and
> > hibernation, where the device boots into the "Active" state.
> >
> > The issue of DPMS is still present. Currently, gamescope and KDE (at le=
ast)
> > do not fire DPMS before suspending. This causes an undesirable frozen
> > screen while the system is suspending and looks quite ugly in general. =
This
> > is especially true if the firmware notifications fire earlier. Therefor=
e,
> > should the kernel fire DPMS before forcing the transition to sleep for
> > backwards compat.? If yes, it will be quite the effort. Moreover, shoul=
d
> > the kernel allow graphics drivers hook the transition function and bloc=
k
> > transitions to "Screen Off" if there is an active CRTC? As that would b=
e a
> > significant undertaking, there should be proof that there exists such a
> > device that has an issue firing the notifications with an active CRTC.
> >
> > A variant of this series has been tested by thousands of users by now,
> > where the notifications fire around .5s before the CRTC is disabled and=
 no
> > ill-effects have found in regard to this quirk. AFAIK, it is a visual
> > quirk. Making DPMS fire before the backwards compat. transition is a go=
od
> > idea in any case, as it will sync the 200ms between Display Off/Sleep E=
ntry
> > firing and the graphics driver turning off the display, but it might no=
t be
> > worth the effort.
> >
> > We are currently testing a DPMS patch for gamescope and it completely f=
ixes
> > this visual quirk while allowing for e.g., hibernation without turning =
on
> > the screen. The DPMS gamescope patch + performing the transitions in
> > userspace in such a way where it blends the Ally's suspend delay halves=
 the
> > user perceived delay to sleep and results in a very professional
> > presentation. This presentation extends to other devices as well, such =
as
> > the Legion Go.
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/prepare-hardware-for-modern-standby [1]
> > Link: https://learn.microsoft.com/en-us/windows-hardware/customize/powe=
r-settings/adaptive-hibernate [2]
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/modern-standby-firmware-notifications [3]
> > Link: https://github.com/hhd-dev/hwinfo/tree/master/devices [4]
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git=
/log/?h=3Dsuperm1/dsm-screen-on-off [5]
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2719 [6]
> > Link: https://dl.dell.com/manuals/all-products/esuprt_solutions_int/esu=
prt_solutions_int_solutions_resources/client-mobile-solution-resources_whit=
e-papers45_en-us.pdf [7]
> > File: Documentation/admin-guide/pm/standby-states.rst [8]
> >
> > Changes from previous series (`acpi/x86: s2idle: move Display off/on ca=
lls
> >   outside suspend (fixes ROG Ally suspend)`):
> >   - Separate Display On/Off rename into its own commit (suggested by Ha=
ns)
> >   - Move delay quirks into s2idle.c (suggested by Hans)
> >   - Add documentation on Documentation/admin-guide/pm/standby-states.rs=
t
> >   - Callbacks are now static and a transition function is used
> >   - Fixed all checkpatch warnings
> >   - The rest of the series is completely re-written
> >
> > Antheas Kapenekakis (13):
> >   Documentation: PM: Add documentation for S0ix Standby States
> >   acpi/x86: s2idle: add support for Display Off and Display On callback=
s
> >   acpi/x86: s2idle: add support for Sleep Entry and Sleep Exit callback=
s
> >   acpi/x86: s2idle: add support for Turn On Display callback
> >   acpi/x86: s2idle: add modern standby transition function
> >   acpi/x86: s2idle: rename Screen On/Off to Display On/Off
> >   acpi/x86: s2idle: call Display On/Off as part of callbacks
> >   acpi/x86: s2idle: rename MS Exit/Entry to Sleep Exit/Entry
> >   acpi/x86: s2idle: call Sleep Entry/Exit as part of callbacks
> >   acpi/x86: s2idle: add Turn On Display and call as part of callback
> >   acpi/x86: s2idle: add quirk table for modern standby delays
> >   platform/x86: asus-wmi: remove Ally (1st gen) and Ally X suspend quir=
k
> >   PM: standby: Add sysfs attribute for modern standby transitions
> >
> >  Documentation/ABI/testing/sysfs-power         |  34 +++
> >  .../admin-guide/pm/standby-states.rst         | 133 ++++++++++
> >  Documentation/admin-guide/pm/system-wide.rst  |   1 +
> >  drivers/acpi/x86/s2idle.c                     | 249 ++++++++++++++----
> >  drivers/platform/x86/asus-wmi.c               |  54 ----
> >  include/linux/suspend.h                       |  16 ++
> >  kernel/power/main.c                           |  75 ++++++
> >  kernel/power/power.h                          |   1 +
> >  kernel/power/suspend.c                        | 154 +++++++++++
> >  9 files changed, 616 insertions(+), 101 deletions(-)
> >  create mode 100644 Documentation/admin-guide/pm/standby-states.rst
> >
> > --
> > 2.47.0
> >
> >

