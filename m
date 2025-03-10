Return-Path: <linux-pm+bounces-23794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CC6A5AE2D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2A1747A9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5222172A;
	Mon, 10 Mar 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="XJG0q6Uj"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F0221730;
	Mon, 10 Mar 2025 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649855; cv=none; b=MbpSIQOF6+j+/wgg77lxgSHjIV2k7FTz1R2bVLpVT1KqNdpWqMG+N5KmOgo5YdKd08gjI4EORK81eRYpaUF8pTsApYUcBFgJabDZrDPLYuyWrAGnnor/Zml5AR/3HinGWy1T+JE/WirvX8knLpptZ5a6ho8shSjt7tTqRx3tPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649855; c=relaxed/simple;
	bh=H2h0DiTR64ruruGycENiRM0/YCYlXnX372feJzt9FPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYS+06Ql0kCAnLQrta6NPI5KzOit/5fAm1Gn6HSkRNTervpYIylv0Piym5jfvG+JQbvaI0J3pGdJABXCrNar6Vw+1V5suKTHbPn4fPRrC6wBAn1JJ+eeIWp15ya8yNltXWm9Dk3LAlzOYeSGvmF+DY4cfyG3Bma26+PtiqOvx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=XJG0q6Uj; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 782202E09B31;
	Tue, 11 Mar 2025 01:37:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741649850;
	bh=8J3ZcuYY2lH8ErqOQPob9kld7QThgS9shDCVdwH0d8Q=;
	h=Received:From:Subject:To;
	b=XJG0q6UjSoqnIAlghjkv58JOWQzxD+NaeLsZjtz4KESnMZq3HMx1bFlln0K5BSxg4
	 ka37dl0z0luU72uacKhAlsPTak3G7WKjwGz8X/wMiYvCPBbHciEweM8Q+SgV8PD24c
	 NXsi1RQkMP7xSr6tkjM9qe+LeJPhobkrd1rUh7jo=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-30bfc79ad97so32086711fa.1;
        Mon, 10 Mar 2025 16:37:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWCA+77gyMv/k7F9RYTfTvm7j5Op+3Cc8mtj3NMPV0JafOivm8syOUjf6sCF4sx5JLCHA2M9e8VVWFz2fA=@vger.kernel.org,
 AJvYcCWUKAiIDtOBjMi6ByQwxWsCyVD9ZoyvKvDWzyzxrlwTa/niCy8/hGFGEpb6LkN9iVicTf1cHnHHzZE=@vger.kernel.org,
 AJvYcCXwDyRyTMKX82AQZQMbEtQxLPoFJesnzMaBW2oqwk6ZWGOb0UQGKALxGNC/eSgx/ESCCrqIJa6BcmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6gIv4+V2siWSEvK6IIu0+GTqNAjKGiqfrwmONuM19QtUq8YL
	NWyNKClFnM6cdG+2hEQfA0F8HmBWOWAajbfdKt6nekUbkZxeZFNfApaewHcTKl3uMQlkmmQEyuC
	lzX8xsn3Mbughwt2L0NRaHJ5eSM8=
X-Google-Smtp-Source: 
 AGHT+IHHsow2e/d+uG/wnnNmZYmdQCWK80oWwCY/wOAC3ii/ckfbw25UM1LgJMepupDWMc1ri4sTVYDmb61aYa6C4Vw=
X-Received: by 2002:a2e:be95:0:b0:30b:ee0c:8475 with SMTP id
 38308e7fff4ca-30c20f0bb19mr3392461fa.15.1741649848672; Mon, 10 Mar 2025
 16:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev>
 <20250309112114.1177361-5-lkml@antheas.dev>
 <CAFqHKTn0pTm_vjq0Vdw1qHeiubSrHJ_QJyM37K+eLTpAy_XQ-w@mail.gmail.com>
In-Reply-To: 
 <CAFqHKTn0pTm_vjq0Vdw1qHeiubSrHJ_QJyM37K+eLTpAy_XQ-w@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 11 Mar 2025 00:37:17 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEpHy1gSDJH0uGdYfLT=wFgyGJC-oxJ6F1-wXB77-8fig@mail.gmail.com>
X-Gm-Features: AQ5f1Jr53jvcoMQJYtUnXsIiS8RTk7Si--3juvl637CZjuODD7UdxJ3GAeb6jrc
Message-ID: 
 <CAGwozwEpHy1gSDJH0uGdYfLT=wFgyGJC-oxJ6F1-wXB77-8fig@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] ABI: testing: add tt_toggle and tt_led entries
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174164984987.8670.9054059466335689238@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 11 Mar 2025 at 00:26, Derek John Clark
<derekjohn.clark@gmail.com> wrote:
>
> On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
> >
> > When tt_toggle was introduced, it was not added to the platform sysfs.
> > Add it, then add documentation for tt_led. Remove the documentation
> > from the hwmon entry, then update its readme to be current.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  Documentation/ABI/testing/sysfs-platform-oxp | 29 +++++++++
> >  Documentation/hwmon/oxpec.rst                | 62 +++++++-------------
> >  2 files changed, 49 insertions(+), 42 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-oxp b/Documentati=
on/ABI/testing/sysfs-platform-oxp
> > new file mode 100644
> > index 000000000000..8727d5ecaab5
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-oxp
> > @@ -0,0 +1,29 @@
> > +What:          /sys/devices/platform/<platform>/tt_toggle
> > +Date:          Jun 2023
> > +KernelVersion: 6.5
> > +Contact:       "Antheas Kapenekakis" <lkml@antheas.dev>
> > +Description:
> > +               Takeover TDP controls from the device. OneXPlayer devic=
es have a
> > +        turbo button that can be used to switch between two TDP modes
> > +        (usually 15W and 25W). By setting this attribute to 1, this
> > +        functionality is disabled, handing TDP control over to (Window=
s)
> > +        userspace software and the Turbo button turns into a keyboard
> > +        shortcut over the AT keyboard of the device.
>
> > In addition,
> > +        using this setting is a prerequisite for PWM control for most
> > +        devices (otherwise it NOOPs).
> > +
>
> Is this accurate? This wasn't the case for the mini pro/A1/A1 pro when
> we added them. If it is accurate, we should check for this in the pwm
> _store functions for affected devices so we can inform the user it
> failed (-EOPNOTSUP or similar).

Fan curve still applies, but does not work until the turbo takeover is
engaged. As it would break current fan curve control apps due to the
race condition between the turbo takeover and them activating, I do
not think this is a good idea. Documentation states most devices so it
is accurate.

> > +        This attribute was originally introduced in 6.5, without a
> > +        corresponding documentation entry.
> > +
>
> This last line doesn't provide anything useful to someone reading the
> ABI docs for implementation. Please drop it.

 If there is a V3 I will remove that hunk. Otherwise hopefully the
merger can yank those 3 lines.

> > +What:          /sys/devices/platform/<platform>/tt_led
> > +Date:          Feb 2025
> > +KernelVersion: 6.15
> > +Contact:       "Antheas Kapenekakis" <lkml@antheas.dev>
> > +Description:
> > +               Some OneXPlayer devices (e.g., X1 series) feature a lit=
tle LED
> > +        nested in the Turbo button. This LED is illuminated when the
> > +        device is in the higher TDP mode (e.g., 25W). Once tt_toggle
> > +        is engaged, this LED is left dangling to its last state. This
> > +        attribute allows userspace to control the LED state manually
> > +        (either with 1 or 0). Only a subset of devices contain this LE=
D.
> > +
> > diff --git a/Documentation/hwmon/oxpec.rst b/Documentation/hwmon/oxpec.=
rst
> > index 581c4dafbfa1..0a0a7c5d0263 100644
> > --- a/Documentation/hwmon/oxpec.rst
> > +++ b/Documentation/hwmon/oxpec.rst
> > @@ -1,35 +1,41 @@
> >  .. SPDX-License-Identifier: GPL-2.0-or-later
> >
> > -Kernel driver oxp-sensors
> > +Kernel driver oxpec
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> >  Authors:
> >      - Derek John Clark <derekjohn.clark@gmail.com>
> >      - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> > +    - Antheas Kapenekakis <lkml@antheas.dev>
> >
> >  Description:
> >  ------------
> >
> > -Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide=
 fan
> > -readings and fan control through their embedded controllers.
> > +Handheld devices from OneXPlayer and AOKZOE provide fan readings and f=
an
> > +control through their embedded controllers, which can be accessed via =
this
> > +module. If the device has the platform `tt_toggle` attribute (see
> > +Documentation/ABI/testing/sysfs-platform-oxp), controlling these attri=
butes
> > +without having it engaged is undefined behavior.
> >
> > -Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
> > -handheld devices. AYANEO devices preceding the AIR and OneXPlayer devi=
ces
> > -preceding the Mini A07 are not supportable as the EC model is differen=
t
> > -and do not have manual control capabilities.
> > -
> > -Some OneXPlayer and AOKZOE models have a toggle for changing the behav=
iour
> > -of the "Turbo/Silent" button of the device. It will change the key eve=
nt
> > -that it triggers with a flip of the `tt_toggle` attribute. See below f=
or
> > -boards that support this function.
> > +In addition, for legacy reasons, this driver provides hwmon functional=
ity
> > +to Ayaneo devices, and the OrangePi Neo (AOKZOE is a sister company of
> > +OneXPlayer and uses the same EC).
> >
> >  Supported devices
> >  -----------------
> >
> >  Currently the driver supports the following handhelds:
> > -
> >   - AOKZOE A1
> >   - AOKZOE A1 PRO
> > + - OneXPlayer 2/2 Pro
> > + - OneXPlayer AMD
> > + - OneXPlayer mini AMD
> > + - OneXPlayer mini AMD PRO
> > + - OneXPlayer OneXFly variants
> > + - OneXPlayer X1 variants
> > +
> > +In addition, until a driver is upstreamed for the following, the drive=
r
> > +also supports controlling them:
> >   - AYANEO 2
> >   - AYANEO 2S
> >   - AYANEO AIR
> > @@ -41,29 +47,8 @@ Currently the driver supports the following handheld=
s:
> >   - AYANEO Geek
> >   - AYANEO Geek 1S
> >   - AYANEO KUN
> > - - OneXPlayer 2
> > - - OneXPlayer 2 Pro
> > - - OneXPlayer AMD
> > - - OneXPlayer mini AMD
> > - - OneXPlayer mini AMD PRO
> > - - OneXPlayer OneXFly
> > - - OneXPlayer X1 A
> > - - OneXPlayer X1 i
> > - - OneXPlayer X1 mini
> >   - OrangePi NEO-01
> >
> > -"Turbo/Silent" button behaviour toggle is only supported on:
> > - - AOK ZOE A1
> > - - AOK ZOE A1 PRO
> > - - OneXPlayer 2
> > - - OneXPlayer 2 Pro
> > - - OneXPlayer mini AMD (only with updated alpha BIOS)
> > - - OneXPlayer mini AMD PRO
> > - - OneXPlayer OneXFly
> > - - OneXPlayer X1 A
> > - - OneXPlayer X1 i
> > - - OneXPlayer X1 mini
> > -
>
> As in the previous patch, I don't think we need to pre-stage the move
> of those devices until the other driver is ready to be submitted.

AFAIK this is the onexplayer platform driver moving forward so I do
not see an issue with saying Ayaneo support is provided for legacy
reasons. You can discuss that in my email on a parallel patch.

> Cheers,
> - Derek
>
> >  Sysfs entries
> >  -------------
> >
> > @@ -79,11 +64,4 @@ pwm1_enable
> >  pwm1
> >    Read Write. Read this attribute to see current duty cycle in the ran=
ge [0-255].
> >    When pwm1_enable is set to "1" (manual) write any value in the range=
 [0-255]
> > -  to set fan speed.
> > -
> > -tt_toggle
> > -  Read Write. Read this attribute to check the status of the turbo/sil=
ent
> > -  button behaviour function. Write "1" to activate the switch and "0" =
to
> > -  deactivate it. The specific keycodes and behaviour is specific to th=
e device
> > -  both with this function on and off. This attribute is attached to th=
e platform
> > -  driver and not to the hwmon driver (/sys/devices/platform/oxp-platfo=
rm/tt_toggle)
> > +  to set fan speed.
> > \ No newline at end of file
> > --
> > 2.48.1
> >

