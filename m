Return-Path: <linux-pm+bounces-17882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644C9D51F7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE156B289EB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CF1AA1D4;
	Thu, 21 Nov 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBzUubfR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC614A0AA;
	Thu, 21 Nov 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210886; cv=none; b=HC03sil1qoQzAHlSQqwlhnkro4kbF0csBD+YwXBe5O34lTUoc9ZrakApzLtyqFLv60U7jJgVb1qmgNl9yHPem5Vh4U6TaGcEXNBYH3K6d6HjNKpQETo/3Dw7o91V/OxqFrKob7K4nG0ticctffekKQMGOTCmX7m4dbgXIxY4KM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210886; c=relaxed/simple;
	bh=P0feMC60hth3rSJATqX1MRVAlwWtwEnhY5hmLhrXyVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EC/TSSpiXANpCk79NLwUm560BO/eNmT77biS57X/2rC8zec38WZ33tnEFOUdYqtPe5GMC0ESiC6+g0w2LIg8nPfwa9Yq0Aa9jAOCUICFPKdTazNVEGRyylTH/bZoyLr2bMy574F5y4gylrCwlWwRc4jlMOZzO41pvjOolfsb858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBzUubfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15024C4CECC;
	Thu, 21 Nov 2024 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732210886;
	bh=P0feMC60hth3rSJATqX1MRVAlwWtwEnhY5hmLhrXyVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MBzUubfR+0xU6sIQhz2tvd+8WRNmC4AZ0j0x44qRFaB1MSUWU1FA+/TKiK+wxKMdd
	 lWjsB0aTZdPfTgmTZ7sBoOswYXVKm8XkqrH5N9176wEUYAMfjvjujsq+H33DevCtj9
	 B/EaQbL0lcGDDqPZt5qPbuoNavAUMjv60aUUJLIzNT4zhmCNaNpkHxE6wsZ2BUrYC/
	 T4oNCtrC/Pa7Whdq1rh0GFjeVel/W4nc4Djl0Tq9/Y87ejGWR7p3NzgahFfyvYWnnV
	 tHWaTqLUGOOPF4eOVtk1V6zNt+xZdZZkLYEzLYWRuJvM5DOYz8Ef6y/kI/L5c78lfu
	 cOz3+S8zh/VNw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-296b0d2271aso799454fac.0;
        Thu, 21 Nov 2024 09:41:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxtpBjvCfAq9mLX2GZr+sccyrtFa8pSlPvtsFmPfuZRpC8HlYG+jaRUZWmYYd49jThwodv0cjqXv3wRuW7k0D2D/P3@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8qzPQ9RTSDPJ7/XRtxmF20Aw7I+UF6joATicJd9D82SUwpKP
	w/99kFanIXwmNeCmANx0lj7Mxv7gGKLfpMfQWzNR2IpK8AUX4Tn5agoevF3FaksvkCTYVFNSvVm
	i6VpfQURzSAKPoTMuO8LLgyg3mfw=
X-Google-Smtp-Source: AGHT+IHLqeIrimbLb4wXUN1Zgww8MR9OFZG5lj+3ockOum7cV87ygjCO3p1xGsSNZiP8/WDlyb6qQgD2+cTYoFUkO8c=
X-Received: by 2002:a05:6870:418e:b0:277:e641:5659 with SMTP id
 586e51a60fabf-296d9ec5dd1mr8315412fac.35.1732210885144; Thu, 21 Nov 2024
 09:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121172239.119590-1-lkml@antheas.dev>
In-Reply-To: <20241121172239.119590-1-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Nov 2024 18:41:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gDg57skLVOH32NtmhCEXGw_m63az4jWRJgkUq6qTsqgQ@mail.gmail.com>
Message-ID: <CAJZ5v0gDg57skLVOH32NtmhCEXGw_m63az4jWRJgkUq6qTsqgQ@mail.gmail.com>
Subject: Re: [RFC 00/13] acpi/x86: s2idle: implement Modern Standby transition
 states and expose to userspace
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 6:28=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> The following series moves the _DSM 3,4,7,8 firmware notifications outsid=
e
> the suspend sequence, and makes them part of a transition function, where
> the system can transition freely between them when it is not suspended.
> This transition function is exposed to userspace, which now gains the
> ability to control the presentation of the device (e.g., pulse the suspen=
d
> light) without forcing the kernel to suspend. In addition, it adds suppor=
t
> for the _DSM 9 call Turn Display On, which was introduced in Windows 22H2
> and aims to speed up device wake-up while remaining in the "Sleep" state.
> If userspace is not standby aware, the kernel will bring the system into
> the "Sleep" state before beginning the suspend sequence.

I'll get to this when 6.13-rc1 is out, but I can tell you right away
that some of the above cannot be done without breaking backwards
compatibility.

> This series requires a bit of background on how modern standby works in
> Windows. Windows has a concept of "Modern Standby" [1], where it performs
> an elaborate userspace and kernel suspend choreography while the device i=
s
> inactive in order to maintain fast wake-up times and connectivity while t=
he
> display of the device is off. This is done through 5 hardware states and
> the OS takes the liberty of transitioning between them, by following a se=
t
> of rules (e.g., "Adaptive Hibernate").
>
> ```
>                                  \/-> "Hibernate (S4)"
> "Active" <-> "Screen Off" <-> "Sleep" <-> "DRIPS"
>                   /\-  "Resume"  <-         <-
> ```
>
> When the display is on and the user is interacting with the device, it is
> in the "Active" state. The moment the display turns off, the device
> transitions to the "Screen Off" state, where hardware and userspace are
> fully active. Userspace will then decide when appropriate to freeze major
> components (such as the DE) and transition into the "Sleep" state, where
> the kernel is still active and connectivity is maintained. Finally, the
> conventional "Suspend-to-idle" path can be used to bring the system into
> the deepest runtime idle platform state (DRIPS) state, which is named
> "s2idle" in the Linux kernel.
>
> After wake-up, the system re-transitions into the "Sleep" state, where
> userspace can run housekeeping and/or hibernate if the wake-up was not us=
er
> initiated (e.g., timer). If user-initiated, userspace can hasten the
> transition out of the "Sleep" state by transitioning into the state
> "Resume" that certain devices use to boost the Power Limit (PLx) while
> remaining in sleep (support for this new notification is rare). Then, it
> transitions back into "Screen Off" and "Active" to prepare for the user.
>
> All transitions between these states feature unique firmware notification=
s
> [3] that change the presentation of the device (e.g., pulse the suspend
> light, turn off RGB). For more information, see the docs in [8]. Making
> these transitions accessible from userspace moves them out of the suspend
> sequence and has them happen while the kernel is fully active, mirroring
> Windows.
>
> As a side effect, this patch series completely fixes the ROG Ally
> controller issue [5], which expects for .5s to lapse before its
> controller's USB hub goes into D3 and otherwise malfunctions. It also fix=
es
> an issue present in (allegedly only) older firmwares where they check the
> USB subsystem is not in D3 before allowing the controller to wake up whil=
e
> in powersave mode (for avoiding spurious wake-ups). As such, this patch
> series is also a universal fix for the ROG Ally controller.
>
> Moreover, this patch series allows turning off the controller and RGB of
> most Windows handhelds (OneXPlayer, Lenovo Legion Go, GPD, and Asus ROG
> Ally), opening the possibility of implementing suspend-then-hibernate and
> other standby features, such as background downloads, without waking up t=
he
> RGB/controller of those devices. A Thinkpad T14 2021 was also tested, and
> it pulses its suspend light during sleep.
>
> There is still the question of where LSP0 entry/exit (_DSM 5,6) should be
> fired or whether they should be fired in the path to hibernation. However=
,
> as they cause no issues currently, and they fire when software activity h=
as
> seized, they are fine where they are.
>
> It is important to note that the effects of these _DSMs persist during
> reboots. I.e., if the Legion Go reboots while in the "Sleep" state, it wi=
ll
> boot into the "Sleep" state and have its controller disabled and suspend
> light pulsing. The reboot persistence is undesirable, so the reboot path
> will need to include a transition to active prior to reboot (not
> included in this series). This is not the case after shutdown and
> hibernation, where the device boots into the "Active" state.
>
> The issue of DPMS is still present. Currently, gamescope and KDE (at leas=
t)
> do not fire DPMS before suspending. This causes an undesirable frozen
> screen while the system is suspending and looks quite ugly in general. Th=
is
> is especially true if the firmware notifications fire earlier. Therefore,
> should the kernel fire DPMS before forcing the transition to sleep for
> backwards compat.? If yes, it will be quite the effort. Moreover, should
> the kernel allow graphics drivers hook the transition function and block
> transitions to "Screen Off" if there is an active CRTC? As that would be =
a
> significant undertaking, there should be proof that there exists such a
> device that has an issue firing the notifications with an active CRTC.
>
> A variant of this series has been tested by thousands of users by now,
> where the notifications fire around .5s before the CRTC is disabled and n=
o
> ill-effects have found in regard to this quirk. AFAIK, it is a visual
> quirk. Making DPMS fire before the backwards compat. transition is a good
> idea in any case, as it will sync the 200ms between Display Off/Sleep Ent=
ry
> firing and the graphics driver turning off the display, but it might not =
be
> worth the effort.
>
> We are currently testing a DPMS patch for gamescope and it completely fix=
es
> this visual quirk while allowing for e.g., hibernation without turning on
> the screen. The DPMS gamescope patch + performing the transitions in
> userspace in such a way where it blends the Ally's suspend delay halves t=
he
> user perceived delay to sleep and results in a very professional
> presentation. This presentation extends to other devices as well, such as
> the Legion Go.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/prepare-hardware-for-modern-standby [1]
> Link: https://learn.microsoft.com/en-us/windows-hardware/customize/power-=
settings/adaptive-hibernate [2]
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/modern-standby-firmware-notifications [3]
> Link: https://github.com/hhd-dev/hwinfo/tree/master/devices [4]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/l=
og/?h=3Dsuperm1/dsm-screen-on-off [5]
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2719 [6]
> Link: https://dl.dell.com/manuals/all-products/esuprt_solutions_int/esupr=
t_solutions_int_solutions_resources/client-mobile-solution-resources_white-=
papers45_en-us.pdf [7]
> File: Documentation/admin-guide/pm/standby-states.rst [8]
>
> Changes from previous series (`acpi/x86: s2idle: move Display off/on call=
s
>   outside suspend (fixes ROG Ally suspend)`):
>   - Separate Display On/Off rename into its own commit (suggested by Hans=
)
>   - Move delay quirks into s2idle.c (suggested by Hans)
>   - Add documentation on Documentation/admin-guide/pm/standby-states.rst
>   - Callbacks are now static and a transition function is used
>   - Fixed all checkpatch warnings
>   - The rest of the series is completely re-written
>
> Antheas Kapenekakis (13):
>   Documentation: PM: Add documentation for S0ix Standby States
>   acpi/x86: s2idle: add support for Display Off and Display On callbacks
>   acpi/x86: s2idle: add support for Sleep Entry and Sleep Exit callbacks
>   acpi/x86: s2idle: add support for Turn On Display callback
>   acpi/x86: s2idle: add modern standby transition function
>   acpi/x86: s2idle: rename Screen On/Off to Display On/Off
>   acpi/x86: s2idle: call Display On/Off as part of callbacks
>   acpi/x86: s2idle: rename MS Exit/Entry to Sleep Exit/Entry
>   acpi/x86: s2idle: call Sleep Entry/Exit as part of callbacks
>   acpi/x86: s2idle: add Turn On Display and call as part of callback
>   acpi/x86: s2idle: add quirk table for modern standby delays
>   platform/x86: asus-wmi: remove Ally (1st gen) and Ally X suspend quirk
>   PM: standby: Add sysfs attribute for modern standby transitions
>
>  Documentation/ABI/testing/sysfs-power         |  34 +++
>  .../admin-guide/pm/standby-states.rst         | 133 ++++++++++
>  Documentation/admin-guide/pm/system-wide.rst  |   1 +
>  drivers/acpi/x86/s2idle.c                     | 249 ++++++++++++++----
>  drivers/platform/x86/asus-wmi.c               |  54 ----
>  include/linux/suspend.h                       |  16 ++
>  kernel/power/main.c                           |  75 ++++++
>  kernel/power/power.h                          |   1 +
>  kernel/power/suspend.c                        | 154 +++++++++++
>  9 files changed, 616 insertions(+), 101 deletions(-)
>  create mode 100644 Documentation/admin-guide/pm/standby-states.rst
>
> --
> 2.47.0
>
>

