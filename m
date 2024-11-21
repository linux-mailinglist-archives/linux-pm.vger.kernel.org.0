Return-Path: <linux-pm+bounces-17927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6729D5404
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 21:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CB4B20D05
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47F21A2C04;
	Thu, 21 Nov 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="SJO5V7d8"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65326148FE8;
	Thu, 21 Nov 2024 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221220; cv=none; b=b31lL0Q8Uk4HUoCncxGl6vsG+tA46HtvWNM8f5kHjGTfkex2qejggbm5yErjN4/fc+E94yyhGuY7CjQ3iNV1seoubUGEno7kRds1gGSFyxrmioNMIy2CePvGOGgMzeh8L9g40rV2BkhUVNB/hLIDv+AhbEOIQSX+LcAlwAXYN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221220; c=relaxed/simple;
	bh=uef/ICnbyxN/GdqCbfdvZ0VJNQno/v41yz7Ftb1iPyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks9jObTEFRD0UcQnIC8U9TxCwt17MMoU96bUo9D0To/WvCFP8B5hpYmXwP5Zi/UnvepdoucQ+Oqla4DcLLXFKChHMritULXQIQIzO4TFAaQSAQX3vMe1rJBju4yuDUH6dO6SjjIXe8QX9MbEClk7rWkEFNG2uG25iEhYcWjqGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=SJO5V7d8; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 40A712E09AF6;
	Thu, 21 Nov 2024 22:33:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732221214;
	bh=1EaKYwTQ3Bcs2Z402LIB5Z2yY0uSm+5kPhX6ojsIOJs=;
	h=Received:From:Subject:To;
	b=SJO5V7d8JjpM+XONVTnpbi/BF983mUxQ4ezNnutH0tomTvbvEcTOWA7TqcgiktHmE
	 O7ssTlb1H3lGSKLYLfZCn0HOgZkLdrmQrzWCiotIT3U/xdhmgxIok3hlcMuytxZtAY
	 8DURrq/ryYqzmCI/lISu3jhZdX5KCQT42PukWKdQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2fb5111747cso15952711fa.2;
        Thu, 21 Nov 2024 12:33:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnKwzpof5g7fGDY/+6+r13fuI+BpIwyySe1C+CKcFY8VufcUKh5pPobT0TG5DmnA5edvxMX8H/D3ule5Hod3Ntto5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vFV0PvbI8eioWFxH9TTLszyOMBPPoVH6viWUW28w5xOEz+0r
	kBxTFAyISV5OrqPlkNdAPG97UP5yIL7kEN3QWqBKtuGII1oEy6A2Q99vVWUsIZoUwZDTdPXSze0
	bMfibLWyWk4ZWIxcVY4FqlqIN7e0=
X-Google-Smtp-Source: 
 AGHT+IEv9IezpGoyNp9Nf9mIvgPMnPHP0sueFjqbbKJQ2BFHx0qbzRNX9DZjjPzmV+3FxwmwtLsXk6LXz52Jnc/pv78=
X-Received: by 2002:a05:651c:2119:b0:2ff:5a42:9205 with SMTP id
 38308e7fff4ca-2ffa7180af4mr569711fa.31.1732221213486; Thu, 21 Nov 2024
 12:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121172239.119590-1-lkml@antheas.dev>
 <20241121172239.119590-2-lkml@antheas.dev>
 <1e7057cc-c74e-48ff-8585-8b0db58e08bf@amd.com>
 <CAGwozwF9qzinGmyJQQ+KK02troC-u6+vULpExvYE8taYaBHCXw@mail.gmail.com>
 <80653958-2f34-4ed8-b77e-8f82d80ebbea@amd.com>
In-Reply-To: <80653958-2f34-4ed8-b77e-8f82d80ebbea@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 21 Nov 2024 21:33:22 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFtbxptqH1ZwLcpjibfRdnm5VvQoLSjAO8mtD=Aw9y=eg@mail.gmail.com>
Message-ID: 
 <CAGwozwFtbxptqH1ZwLcpjibfRdnm5VvQoLSjAO8mtD=Aw9y=eg@mail.gmail.com>
Subject: Re: [RFC 01/13] Documentation: PM: Add documentation for S0ix Standby
 States
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <173222121467.3807.15931436422826740273@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 21 Nov 2024 at 20:40, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/21/2024 13:11, Antheas Kapenekakis wrote:
> > On Thu, 21 Nov 2024 at 19:58, Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 11/21/2024 11:22, Antheas Kapenekakis wrote:
> >>> Add documentation about the S0ix Standby States that will be exposed
> >>> to userspace as part of this series.
> >>>
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> ---
> >>>    .../admin-guide/pm/standby-states.rst         | 133 ++++++++++++++=
++++
> >>>    Documentation/admin-guide/pm/system-wide.rst  |   1 +
> >>>    2 files changed, 134 insertions(+)
> >>>    create mode 100644 Documentation/admin-guide/pm/standby-states.rst
> >>>
> >>> diff --git a/Documentation/admin-guide/pm/standby-states.rst b/Docume=
ntation/admin-guide/pm/standby-states.rst
> >>> new file mode 100644
> >>> index 000000000000..96727574312d
> >>> --- /dev/null
> >>> +++ b/Documentation/admin-guide/pm/standby-states.rst
> >>> @@ -0,0 +1,133 @@
> >>> +.. SPDX-License-Identifier: GPL-2.0
> >>> +.. include:: <isonum.txt>
> >>> +
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +S0ix Standby States
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +:Copyright: |copy| 2024 Antheas Kapenekakis
> >>> +
> >>> +:Author: Antheas Kapenekakis <lkml@antheas.dev>
> >>> +
> >>> +With the advent of modern mobile devices, users have become accustom=
ed to instant
> >>> +wake-up times and always-on connectivity. To meet these expectations=
, modern
> >>> +standby was created, which is a standard that allows the platform to=
 seamlessly
> >>> +transition between an S3-like low-power idle state and a set of low =
power active
> >>> +states, where connectivity is maintained, and the system is responsi=
ve to user
> >>> +input. Current x86 hardware supports 5 different standby states, whi=
ch are:
> >>> +"Deepest run-time idle platform state" or "DRIPS" (S3-like), "Sleep"=
, "Resume",
> >>> +"Screen Off", and "Active".
> >>> +
> >>> +The system begins in the "Active" state. Either due to user inactivi=
ty or
> >>> +user action (e.g., pressing the power button), it transitions to the=
 "Screen Off"
> >>> +state.
> >>
> >> So are you implicitly suggesting that userspace should be responsible
> >> for *telling* the kernel that the screen is off?  I feel some DRM
> >> helpers are missing to make it easy, but after such helpers are made t=
he
> >> kernel "should" be able to easily tell this on it's own.
> >
> > There are two issues with this
> >    1) Windows implements a 5 second grace period on idle before firing
> > that firmware notification [1]. This is also a partial debounce, the
> > kernel cannot do that reliably or with the finesse required for such a
> > notification
>
> Why can't the kernel do this?  I'm thinking something like this pseudo
> code that is triggered when number of enabled CRTCs changes:
>
> if (in_suspend_sequence)
>         return;
> switch (old_num_displays) {
> case 0:
>         display_on_cb();
> default:
>         schedule_delayed_work(&drm_s2idle_wq);
> }
>
> Then if the "normal" suspend sequence is started the delayed work is
> cancelled.
>
> If the "normal" suspend sequence doesn't start when it fires then it
> would call the display off callback.

Fundamentally, it is more complicated and error prone than 2 systemd
suspend targets that fire at the same time DEs lock the lock screen
(or any init system for that matter). This pseudocode also hardcodes
the delay and does not debounce the display on callback.

There is the theoretical risk of a device misbehaving if the callbacks
fire at the wrong time. But this risk is theoretical and could be
solved by a device driver quirk that blocks the transition for that
specific device. Which is also much simpler than trying to hardcode an
implementation that works with all devices.

> >    2) Windows clearly states virtual or real and virtual can really
> > mean anything here.
>
> In the context of the kernel, to me this is a DRM driver that has made
> outputs that are not tied to a physical display.  Does it mean anything
> else?  They should still be DRM connectors, and they should still have a
> CRTC AFAICT.

For all the devices I tested, the display calls change the
presentation of the device such as RGB or aux devices that drain power
during suspend. I do not see a connection to DRM. This points me to
userspace being more appropriate for handling this. It also solves all
UX edge cases because userspace knows when it is inactive.

Userspace handling this will not be backwards compatible in the sense
that it will not fire when the displays turn off with current
userspace. But it preserves current behavior and as such it is not a
breaking change.

> >
> > In the end, only systemd and the compositor know if both conditions 1
> > and 2 are met and as such can be responsible for the notification.
> >
> > However, if that notification firing before certain CRTCs are
> > deactivated causes issues, such DRM helpers could be used to block the
> > transition
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/display--sleep--and-hibernate-idle-timers
> > [1]
> >
> >>> Afterwards, it is free to transition between the "Sleep", "DRIPS", an=
d
> >>> +"Screen Off" states until user action is received. Once that happens=
, the system
> >>> +begins to transition to the "Active" state. From "DRIPS" or "Sleep",=
 it
> >>> +transitions to "Resume", where the Power Limit (PLx) is restored to =
its normal
> >>> +level, to speed up finishing "Sleep". Then, it transitions to "Scree=
n Off".
> >>> +If on "Screen Off" or after the transition, the display is prepared =
to turn on
> >>> +and the system transitions to "Active" alongside turning it on.
> >>> +
> >>> +To maintain battery life, in the Windows implementation, the system =
is allocated
> >>> +a maximum percentage of battery and time it can use while staying in=
 idle states.
> >>> +By default, this is 5% of battery or up to 2 days, where the system =
designer/OEM
> >>> +is able to tweak these values. If the system exceeds either the batt=
ery
> >>> +percentage or time limit, it enters Hibernation (S4), through a conc=
ept
> >>> +called "Adaptive Hibernate".
> >>> +
> >>> +
> >>> +S0ix Standby States
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +The following idle states are supported::
> >>> +
> >>> +                 =E2=86=93=E2=86=92  <Hibernate (S4)>
> >>
> >> I think S4 distracts in this context.
> >
> > Sure, can be removed.
> >
> >>> +    <DRIPS> =E2=86=94 <Sleep> =E2=86=94 <Screen Off> =E2=86=94 <Acti=
ve>
> >>> +        =E2=86=92       =E2=86=92  <Resume>  =E2=86=91
> >>> +
> >>> +.. _s2idle_drips:
> >>> +
> >>> +DRIPS
> >>> +-----
> >>> +
> >>> +The "Deepest run-time idle platform state" or "DRIPS" is the lowest =
power idle
> >>> +state that the system can enter. It is similar to the S3 state, with=
 the
> >>> +difference that the system may wake up faster than S3 and due to a l=
arger number
> >>> +of interrupts (e.g., fingerprint sensor, touchpad, touchscreen). Thi=
s state
> >>> +is entered when the system is told to suspend to idle, through conve=
ntional
> >>> +means (see :doc:`sleep states <sleep-states>`). The system can only =
transition
> >>> +to "DRIPS" while it is in the "Sleep" state. If it is not, the kerne=
l will
> >>> +automatically transition to the "Sleep" state before beginning the s=
uspend
> >>> +sequence and restore the previous state afterwards. After the kernel=
 has
> >>> +suspended, the notifications LSP0 Entry and Exit are used.
> >>> +
> >>> +.. _s2idle_sleep:
> >>> +
> >>> +Sleep
> >>> +-----
> >>> +
> >>> +The "Sleep" state is a low power idle state where the kernel is full=
y active.
> >>> +However, userspace has been partially frozen, particularly desktop a=
pplications,
> >>> +and only essential "value adding" activities are allowed to run. Thi=
s is not
> >>> +enforced by the kernel and is the responsibility of userspace (e.g.,=
 systemd).
> >>> +Hardware wise, the Sleep Entry and Exit firmware notifications are f=
ired, which
> >>> +may lower the Power Limit (PLx), pulse the suspend light, turn off t=
he keyboard
> >>> +lighting or disable a handheld device's gamepad. This state is assoc=
iated with
> >>> +the firmware notifications "Sleep Entry" and "Sleep Exit".
> >>> +
> >>> +.. _s2idle_resume:
> >>> +
> >>> +Resume
> >>> +------
> >>> +
> >>> +The "Resume" state is a faux "Sleep" state that is used to fire the =
Turn On
> >>> +Display firmware notification when the system is in the "Sleep" stat=
e but
> >>> +intends to turn on the display. It solves the problem of system desi=
gners
> >>> +limiting the Power Limit (PLx) while the system is in the "Sleep" st=
ate causing
> >>
> >> AFAIK, PLx is an Intel specific acronym, it's probably better to be mo=
re
> >> generic in documentation.  You mentioned PLx in a commit too.
> >
> > Microsoft used this term in their documentation [2]. Can update to
> > generic terms.
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/modern-standby-firmware-notifications#turn-on-display-notificat=
ion-function-9
> > [2]
> >
> >>> +the system to wake up slower than desired. This firmware notificatio=
n is used
> >>> +to restore the normal Power Limit of the system, while having it sta=
y in the
> >>> +"Sleep" state.  As such, the system can only transition to the "Resu=
me" state
> >>> +while in the "Sleep" state and cannot re-transition to the "Sleep" s=
tate
> >>> +afterwards.
> >>> +
> >>> +.. _s2idle_screen_off:
> >>> +
> >>> +Screen Off
> >>> +----------
> >>> +
> >>> +The "Screen Off" state is the state the system enters when all its d=
isplays
> >>> +(virtual or real) turn off. It is used to signify the user is not ac=
tively
> >>> +using the system. The associated firmware notifications of "Display =
On" and
> >>> +"Display Off" are used by manufacturers to turn off certain hardware
> >>> +components that are associated with the display being on, e.g., a ha=
ndheld
> >>> +device's controller and RGB. Windows implements a 5-second grace per=
iod
> >>> +before firing this callback when the screen turns off due to inactiv=
ity.
> >>> +
> >>> +.. _s2idle_active:
> >>> +
> >>> +Active
> >>> +------
> >>> +
> >>> +Finally, the "Active" state is the default state of the system and t=
he one it
> >>> +has when it is turned on. It is the state where the system is fully =
operational,
> >>> +the displays of the device are on, and the user is actively interact=
ing with
> >>> +the system.
> >>> +
> >>> +Basic ``sysfs`` Interface for S0ix Standby transitions
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +The file :file:`/sys/power/standby` can be used to transition the sy=
stem between
> >>> +the different standby states. The file accepts the following values:=
 ``active``,
> >>> +``screen_off``, ``sleep``, and ``resume``. File writes will block un=
til the
> >>> +transition completes. It will return ``-EINVAL`` when asking for an =
unsupported
> >>> +state or, e.g., requesting ``resume`` when not in the ``sleep`` stat=
e. If there
> >>> +is an error during the transition, the transition will pause on the =
last
> >>> +error-free state and return an error. The file can be read to retrie=
ve the
> >>> +current state (and potential ones) using the following format:
> >>> +``[active] screen_off sleep resume``. The state "DRIPS" is omitted, =
as it is
> >>> +entered through the conventional suspend to idle path and userspace =
will never
> >>> +be able to see its value due to being suspended.
> >>
> >> If you follow my above suggestion, I think this file is totally
> >> unnecessary and then there is no compatibility issue.
> >>
> >> It would mean that userspace if it wants to see this "screen off" stat=
e
> >> and associated performance needs to do literally just that - turn the
> >> screens off.
> >
> > Please see the reasoning above for Display On/Off. Also, you omitted
> > sleep and resume, which have no hardware analogues you can hook into
> > and are just as important if not more than Display On/Off.
>
> I suppose I'm not seeing the argument yet for why "sleep" and HW DRIPS
> need to be different.  What kind of things would be allowed to run in
> this state?  Who draws that line?

The most useful thing would be maintaining some basic connectivity so
that the device can resume faster if it suspended a couple of minutes
before and handling transitions such as to hibernation. The transition
to hibernation is especially important, as if both DPMS and the sleep
transition fire the transition looks proper. Being able to run certain
maintenance tasks without changing the presentation of the device from
sleep (e.g., the APM timer to check the battery level) is important.

Even without that, if userspace transitions to sleep and fires DPMS
before beginning freezing and the suspend sequence, it halfs the user
perceived delay to sleep. It is a big deal. This is a planned feature
for the next version of bazzite so I am testing it right now. It looks
really professional.

> As it stands today the kernel freezes all tasks when suspending, so in
> this "half" suspend state I feel like there would need to be some sort
> of allow list, no?

I do sympathize with this. The most important part would be to lower
the power limit of the device which the manufacturers can already do
via the notification and perhaps other kernel drivers could do too.
Non-root software can be limited by the init system in general.

As a side note, after all tasks have frozen, including compositors,
you can fire DPMS safely before beginning the suspend sequence for
backwards compatibility and to lower the span the old framebuffer is
shown. This would be a useful addition to this series.

> >
> >>> +
> >>> +Before entering the "Screen Off" state or suspending, it is recommen=
ded that
> >>> +userspace marks all CRTCs as inactive (DPMS). Otherwise, there will =
be a split
> >>> +second where the display of the device is on, but the presentation o=
f the system
> >>> +is inactive (e.g., the power button pulses), which is undesirable.
> >>> \ No newline at end of file
> >>> diff --git a/Documentation/admin-guide/pm/system-wide.rst b/Documenta=
tion/admin-guide/pm/system-wide.rst
> >>> index 1a1924d71006..411775fae4ac 100644
> >>> --- a/Documentation/admin-guide/pm/system-wide.rst
> >>> +++ b/Documentation/admin-guide/pm/system-wide.rst
> >>> @@ -8,4 +8,5 @@ System-Wide Power Management
> >>>       :maxdepth: 2
> >>>
> >>>       sleep-states
> >>> +   standby-states
> >>>       suspend-flows
> >>
>

