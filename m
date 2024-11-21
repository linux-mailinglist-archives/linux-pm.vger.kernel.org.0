Return-Path: <linux-pm+bounces-17921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F59D5348
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B69B22006
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9EC1AAE38;
	Thu, 21 Nov 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="pEw+XdiL"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEF15990E;
	Thu, 21 Nov 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216297; cv=none; b=lkTI0pxHp8szuXZzYGcgDtphh28CtGkRuXBj/rH3t3mZoPVyPwFpVRR+Di6sVjYh+fw94MJPBh8bMzEVSuCvY27UqKnStyuqZsWjOIkBn1+NuXVitdS1ktVD/knWGDbfdsE5SuVelLkOpteurDFTzm2/bXW3vSycvKfEDiu8fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216297; c=relaxed/simple;
	bh=ZYYJ8V3WqRkX6AaCn22FOGav7U5l9Y9Ts5KsWRxLZ/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUGPpmwjjEi+kclywAinPn+Ty5jxuhu1JodxP54REr4HjtVBeb3IDqoyEBRg/DFndm6UKViVSXHivvP1R2WtwEzrlJwlWEhX8DirY9IY31hJ1urhuQvrYgDgkeJJeplVdPP5iGn9dgvHBmxccQt2eREECQDpr6Qo38CiabWlLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=pEw+XdiL; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 27E572E00934;
	Thu, 21 Nov 2024 21:11:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732216291;
	bh=JjbG2fgesaUuEr5u9yCICxV2z7OmFi3w2y+kFu9Ilno=;
	h=Received:From:Subject:To;
	b=pEw+XdiL7bWzyWV7UVyVgb7XfgLWbbqkt67BGGIGd1h7KYSFHuC8DV3cAriZSEroC
	 nVV/6+AW6Hu6UYmc5kAwchDP2gp0pRPXgRVi5o1hJcbZ1zhbBDgOMLdr3FPdT0qZp4
	 skfey5bigBJhc79rFK3+nA89ZB7jG5IB3SRe9gzY=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso14791461fa.2;
        Thu, 21 Nov 2024 11:11:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV8mLMgb2wTMi8fzz4yXyzvIMpQjtlCNWwNzzl9K9nBQqU3V7eGGj/oKFnamEhmYQmB/UJcrlwThDPAEAQQiJKXIqVf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3MSKsjum/DZVqoyFn2YBZEF/Xv9sCCj+eunJSXaZd5U3fNi5
	uLqkS+AEY3Zr023eofVyYiHeSpLzNuZoBrrmYkDBFe6X3TUsJYNouzTax2IzJ0Tf1rnQgixcltX
	G3j4vIAR5tTZ8XN7FXxoKCChrdug=
X-Google-Smtp-Source: 
 AGHT+IFkXQoa+nttqkTvyJGxmzUjx44ftPwCqho0WQ21rDo7mwII9cB1HC9B2Q5jHc6hDOxyAri8t0NOZ3riiXIVMv8=
X-Received: by 2002:a05:651c:410f:b0:2fb:556c:fe0b with SMTP id
 38308e7fff4ca-2ff8dcc9c3cmr38901491fa.26.1732216289391; Thu, 21 Nov 2024
 11:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121172239.119590-1-lkml@antheas.dev>
 <20241121172239.119590-2-lkml@antheas.dev>
 <1e7057cc-c74e-48ff-8585-8b0db58e08bf@amd.com>
In-Reply-To: <1e7057cc-c74e-48ff-8585-8b0db58e08bf@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 21 Nov 2024 20:11:18 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwF9qzinGmyJQQ+KK02troC-u6+vULpExvYE8taYaBHCXw@mail.gmail.com>
Message-ID: 
 <CAGwozwF9qzinGmyJQQ+KK02troC-u6+vULpExvYE8taYaBHCXw@mail.gmail.com>
Subject: Re: [RFC 01/13] Documentation: PM: Add documentation for S0ix Standby
 States
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <173221629171.21752.4900752328914516352@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 21 Nov 2024 at 19:58, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/21/2024 11:22, Antheas Kapenekakis wrote:
> > Add documentation about the S0ix Standby States that will be exposed
> > to userspace as part of this series.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   .../admin-guide/pm/standby-states.rst         | 133 +++++++++++++++++=
+
> >   Documentation/admin-guide/pm/system-wide.rst  |   1 +
> >   2 files changed, 134 insertions(+)
> >   create mode 100644 Documentation/admin-guide/pm/standby-states.rst
> >
> > diff --git a/Documentation/admin-guide/pm/standby-states.rst b/Document=
ation/admin-guide/pm/standby-states.rst
> > new file mode 100644
> > index 000000000000..96727574312d
> > --- /dev/null
> > +++ b/Documentation/admin-guide/pm/standby-states.rst
> > @@ -0,0 +1,133 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +S0ix Standby States
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Copyright: |copy| 2024 Antheas Kapenekakis
> > +
> > +:Author: Antheas Kapenekakis <lkml@antheas.dev>
> > +
> > +With the advent of modern mobile devices, users have become accustomed=
 to instant
> > +wake-up times and always-on connectivity. To meet these expectations, =
modern
> > +standby was created, which is a standard that allows the platform to s=
eamlessly
> > +transition between an S3-like low-power idle state and a set of low po=
wer active
> > +states, where connectivity is maintained, and the system is responsive=
 to user
> > +input. Current x86 hardware supports 5 different standby states, which=
 are:
> > +"Deepest run-time idle platform state" or "DRIPS" (S3-like), "Sleep", =
"Resume",
> > +"Screen Off", and "Active".
> > +
> > +The system begins in the "Active" state. Either due to user inactivity=
 or
> > +user action (e.g., pressing the power button), it transitions to the "=
Screen Off"
> > +state.
>
> So are you implicitly suggesting that userspace should be responsible
> for *telling* the kernel that the screen is off?  I feel some DRM
> helpers are missing to make it easy, but after such helpers are made the
> kernel "should" be able to easily tell this on it's own.

There are two issues with this
  1) Windows implements a 5 second grace period on idle before firing
that firmware notification [1]. This is also a partial debounce, the
kernel cannot do that reliably or with the finesse required for such a
notification
  2) Windows clearly states virtual or real and virtual can really
mean anything here.

In the end, only systemd and the compositor know if both conditions 1
and 2 are met and as such can be responsible for the notification.

However, if that notification firing before certain CRTCs are
deactivated causes issues, such DRM helpers could be used to block the
transition

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/display--sleep--and-hibernate-idle-timers
[1]

> > Afterwards, it is free to transition between the "Sleep", "DRIPS", and
> > +"Screen Off" states until user action is received. Once that happens, =
the system
> > +begins to transition to the "Active" state. From "DRIPS" or "Sleep", i=
t
> > +transitions to "Resume", where the Power Limit (PLx) is restored to it=
s normal
> > +level, to speed up finishing "Sleep". Then, it transitions to "Screen =
Off".
> > +If on "Screen Off" or after the transition, the display is prepared to=
 turn on
> > +and the system transitions to "Active" alongside turning it on.
> > +
> > +To maintain battery life, in the Windows implementation, the system is=
 allocated
> > +a maximum percentage of battery and time it can use while staying in i=
dle states.
> > +By default, this is 5% of battery or up to 2 days, where the system de=
signer/OEM
> > +is able to tweak these values. If the system exceeds either the batter=
y
> > +percentage or time limit, it enters Hibernation (S4), through a concep=
t
> > +called "Adaptive Hibernate".
> > +
> > +
> > +S0ix Standby States
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The following idle states are supported::
> > +
> > +                 =E2=86=93=E2=86=92  <Hibernate (S4)>
>
> I think S4 distracts in this context.

Sure, can be removed.

> > +    <DRIPS> =E2=86=94 <Sleep> =E2=86=94 <Screen Off> =E2=86=94 <Active=
>
> > +        =E2=86=92       =E2=86=92  <Resume>  =E2=86=91
> > +
> > +.. _s2idle_drips:
> > +
> > +DRIPS
> > +-----
> > +
> > +The "Deepest run-time idle platform state" or "DRIPS" is the lowest po=
wer idle
> > +state that the system can enter. It is similar to the S3 state, with t=
he
> > +difference that the system may wake up faster than S3 and due to a lar=
ger number
> > +of interrupts (e.g., fingerprint sensor, touchpad, touchscreen). This =
state
> > +is entered when the system is told to suspend to idle, through convent=
ional
> > +means (see :doc:`sleep states <sleep-states>`). The system can only tr=
ansition
> > +to "DRIPS" while it is in the "Sleep" state. If it is not, the kernel =
will
> > +automatically transition to the "Sleep" state before beginning the sus=
pend
> > +sequence and restore the previous state afterwards. After the kernel h=
as
> > +suspended, the notifications LSP0 Entry and Exit are used.
> > +
> > +.. _s2idle_sleep:
> > +
> > +Sleep
> > +-----
> > +
> > +The "Sleep" state is a low power idle state where the kernel is fully =
active.
> > +However, userspace has been partially frozen, particularly desktop app=
lications,
> > +and only essential "value adding" activities are allowed to run. This =
is not
> > +enforced by the kernel and is the responsibility of userspace (e.g., s=
ystemd).
> > +Hardware wise, the Sleep Entry and Exit firmware notifications are fir=
ed, which
> > +may lower the Power Limit (PLx), pulse the suspend light, turn off the=
 keyboard
> > +lighting or disable a handheld device's gamepad. This state is associa=
ted with
> > +the firmware notifications "Sleep Entry" and "Sleep Exit".
> > +
> > +.. _s2idle_resume:
> > +
> > +Resume
> > +------
> > +
> > +The "Resume" state is a faux "Sleep" state that is used to fire the Tu=
rn On
> > +Display firmware notification when the system is in the "Sleep" state =
but
> > +intends to turn on the display. It solves the problem of system design=
ers
> > +limiting the Power Limit (PLx) while the system is in the "Sleep" stat=
e causing
>
> AFAIK, PLx is an Intel specific acronym, it's probably better to be more
> generic in documentation.  You mentioned PLx in a commit too.

Microsoft used this term in their documentation [2]. Can update to
generic terms.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-expe=
riences/modern-standby-firmware-notifications#turn-on-display-notification-=
function-9
[2]

> > +the system to wake up slower than desired. This firmware notification =
is used
> > +to restore the normal Power Limit of the system, while having it stay =
in the
> > +"Sleep" state.  As such, the system can only transition to the "Resume=
" state
> > +while in the "Sleep" state and cannot re-transition to the "Sleep" sta=
te
> > +afterwards.
> > +
> > +.. _s2idle_screen_off:
> > +
> > +Screen Off
> > +----------
> > +
> > +The "Screen Off" state is the state the system enters when all its dis=
plays
> > +(virtual or real) turn off. It is used to signify the user is not acti=
vely
> > +using the system. The associated firmware notifications of "Display On=
" and
> > +"Display Off" are used by manufacturers to turn off certain hardware
> > +components that are associated with the display being on, e.g., a hand=
held
> > +device's controller and RGB. Windows implements a 5-second grace perio=
d
> > +before firing this callback when the screen turns off due to inactivit=
y.
> > +
> > +.. _s2idle_active:
> > +
> > +Active
> > +------
> > +
> > +Finally, the "Active" state is the default state of the system and the=
 one it
> > +has when it is turned on. It is the state where the system is fully op=
erational,
> > +the displays of the device are on, and the user is actively interactin=
g with
> > +the system.
> > +
> > +Basic ``sysfs`` Interface for S0ix Standby transitions
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The file :file:`/sys/power/standby` can be used to transition the syst=
em between
> > +the different standby states. The file accepts the following values: `=
`active``,
> > +``screen_off``, ``sleep``, and ``resume``. File writes will block unti=
l the
> > +transition completes. It will return ``-EINVAL`` when asking for an un=
supported
> > +state or, e.g., requesting ``resume`` when not in the ``sleep`` state.=
 If there
> > +is an error during the transition, the transition will pause on the la=
st
> > +error-free state and return an error. The file can be read to retrieve=
 the
> > +current state (and potential ones) using the following format:
> > +``[active] screen_off sleep resume``. The state "DRIPS" is omitted, as=
 it is
> > +entered through the conventional suspend to idle path and userspace wi=
ll never
> > +be able to see its value due to being suspended.
>
> If you follow my above suggestion, I think this file is totally
> unnecessary and then there is no compatibility issue.
>
> It would mean that userspace if it wants to see this "screen off" state
> and associated performance needs to do literally just that - turn the
> screens off.

Please see the reasoning above for Display On/Off. Also, you omitted
sleep and resume, which have no hardware analogues you can hook into
and are just as important if not more than Display On/Off.

> > +
> > +Before entering the "Screen Off" state or suspending, it is recommende=
d that
> > +userspace marks all CRTCs as inactive (DPMS). Otherwise, there will be=
 a split
> > +second where the display of the device is on, but the presentation of =
the system
> > +is inactive (e.g., the power button pulses), which is undesirable.
> > \ No newline at end of file
> > diff --git a/Documentation/admin-guide/pm/system-wide.rst b/Documentati=
on/admin-guide/pm/system-wide.rst
> > index 1a1924d71006..411775fae4ac 100644
> > --- a/Documentation/admin-guide/pm/system-wide.rst
> > +++ b/Documentation/admin-guide/pm/system-wide.rst
> > @@ -8,4 +8,5 @@ System-Wide Power Management
> >      :maxdepth: 2
> >
> >      sleep-states
> > +   standby-states
> >      suspend-flows
>

