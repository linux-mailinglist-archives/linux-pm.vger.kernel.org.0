Return-Path: <linux-pm+bounces-23789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE48DA5AC58
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B10188E367
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3DA220699;
	Mon, 10 Mar 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="euyfDJIb"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53D1E6DCF;
	Mon, 10 Mar 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648792; cv=none; b=fdPTumySYYVM5ZiLu5vgOAXZDyaJPtQvfiiBdAxedHCw7X0eDK4VekmhJ1FK/5TsLXnFFnf2XD4GaIjP02nkUf85ph4sezVadafDt3vV6HZUnb3VjbRferAF/Yu37dO5aohCEchSMCLKyJSBWOf+6kj+98lKImCl9O782YGJwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648792; c=relaxed/simple;
	bh=asbmRT+5cigpg/nxe78mpWESJk2Milh5ARw77OertXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyKTlQsOt2P2J1n3ymElTrdr66n/uCxWjCZYqrpXV9R64Xau3I3ES2U3LNU8IcTxsm8gznk4uqank1nm2GmGcEfBHB6iD9IFy5BQRov5GLJA/mYACNaToAA/JxSGU2zTzx50t/PRXf0UQqyEcd6/iuYgOPNfPIqwJUqLnt3fEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=euyfDJIb; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id A59292E097B2;
	Tue, 11 Mar 2025 01:19:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741648778;
	bh=YvVhEO2lgbaJIm0nUMLfYRD352susORCoomlnrqUuW4=;
	h=Received:From:Subject:To;
	b=euyfDJIbo+jJ+5vYwQxIuBBzjBy3MC6EXC78Xz+AZAMX5jFOyR1rM3pZhIzXAwSeq
	 hkSqIIIx0l6gxG+Q5WeMOqrrgFUPzQnCVuH/3y45X2QpheOfy/fmoF3rWiBz8P7b4L
	 V4IZqk9oKNoCuQv8H/4DcjXGW6movqRsaxdkl6qc=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-30bee278c2aso47161151fa.0;
        Mon, 10 Mar 2025 16:19:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2sbJPysMJbb4Mx05zt08g56w7n1y3nl7TM9WBcUkHaJyQTW0PfolZ6F1ywEhQznNO5IYwXG85Eag=@vger.kernel.org,
 AJvYcCW9JQ7zRQD3ES8AQUoUCvBQcosjSp4FpesrqjDJZohTifDG2hW3wfOPIwkvHQMuqyeXtxr2cMe4WQdjdL4=@vger.kernel.org,
 AJvYcCWhNC9ho356nhenue1sXWPVeKFwfMGhDFieFUhWW6bGvuRl3hNZ+5E7YeFt6FGzT/4neeE5id3gy8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqyJ9fcZ4MbM0caOhvywNrT0Ib83lfEuCLqKlkNpLM9zQ/FKm
	CtIlHE7mJzzpt7+C60rCZbxZN05ZWs0VPpS9DkpSAGqhFGhxwCT50QonmNLaGtlu4d8PwTlE76X
	oAqe9I3x8bJEHkkp8CxTya6yTY/g=
X-Google-Smtp-Source: 
 AGHT+IHMtd1vBx5zxEC8GMje3gClUFycVAfNYa3lLOVvSbQksO/dDyY+XhGW5lUgghS6n9sX2irsTya8QBCNaFdpmiI=
X-Received: by 2002:a2e:b710:0:b0:30b:f2b4:8868 with SMTP id
 38308e7fff4ca-30c20e3ee8fmr3975141fa.4.1741648776969; Mon, 10 Mar 2025
 16:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev>
 <20250309112114.1177361-3-lkml@antheas.dev>
 <CAFqHKTkvNhbTyDmqCOoMq61NXFTau1Gptbqe7EAqZc6GhQYb=w@mail.gmail.com>
In-Reply-To: 
 <CAFqHKTkvNhbTyDmqCOoMq61NXFTau1Gptbqe7EAqZc6GhQYb=w@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 11 Mar 2025 00:19:25 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGrju56Ki3zqoh3TYZWHrv9+9EcDKqgktiXD5a+MHk1RA@mail.gmail.com>
X-Gm-Features: AQ5f1JrvpRVUkYQvL48xwrhwTAVzuqRW7YL9RS2O7ksH8xsu8Zusad5mYjTBVO0
Message-ID: 
 <CAGwozwGrju56Ki3zqoh3TYZWHrv9+9EcDKqgktiXD5a+MHk1RA@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] hwmon: (oxp-sensors) Add all OneXFly variants
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
 <174164877802.21696.1581097158961397919@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 11 Mar 2025 at 00:04, Derek John Clark
<derekjohn.clark@gmail.com> wrote:
>
> On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
> >
> > Currently, the driver only has the F1 OneXFly variant, which was based
> > on the 7000 AMD platform. Add its special editions: F1 EVA-01, F1 OLED.
> > F1 OLED might have been a dev unit, but it is supported by OneXConsole
> > with the same features so add it. Then add the F1L variant which is
> > based on the 8000 AMD platform and the F1Pro and its special edition
> > EVA-02.
> >
> > One might ask why not just fuzzy match. Well, EVA-02 is a variant of
> > F1Pro which is a Strix Point handheld, but does not have F1Pro in its
> > name. This makes it risky to fuzzy match, as special variants in the
> > future from different platforms might not have the same feature set
> > or registers.
> >
> > By happenstance, all current devices use the same registers. For the
> > charge limitting feature on this series, only F1Pro/X1 (AMD) were
> > released with it, but OneXPlayer is providing bios updates for F1, F1L,
> > X1 Mini units that use the same register, so treat all of them the same=
.
> >
> Greeting Antheas,
>
> Do we know the BIOS version(s) that support was added? If so, I think
> it makes sense to treat these as separate devices  and check for
> device specific BIOS version in an is_visible for the charge limit
> attr. I expect that calling the registers when support isn't present
> will just be a no-op based on how OXP historically does things, but
> having a present attribute that has no effect will probably generate
> bug reports. It is also not appropriate to check/fix this in userspace
> as some folks might use udev to set it over a program with such
> checks.
>
> Cheers,
> - Derek

Unfortunately, I do not know the BIOS versions to check for older
OneXFly devices.

OneXPlayer has informed their users they will need to update their
BIOS and nobody has asked up to now, so I do not expect that to be
that much of an issue. The ones that will need to update know that
their device does not support it currently as they bought it without
the feature. I think we rolled out the GUI for it 3 weeks ago now.

Eileen will know more about that and might be able to provide some
BIOS ranges. I do not expect that to be that much of a problem
though.Yes, it will noop as the register is unused.

> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/hwmon/oxp-sensors.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> > index 5a4230ad3757..f7a64fbc8f33 100644
> > --- a/drivers/hwmon/oxp-sensors.c
> > +++ b/drivers/hwmon/oxp-sensors.c
> > @@ -188,6 +188,41 @@ static const struct dmi_system_id dmi_table[] =3D =
{
> >                 },
> >                 .driver_data =3D (void *)oxp_fly,
> >         },
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 =
EVA-01"),
> > +               },
> > +               .driver_data =3D (void *)oxp_fly,
> > +       },
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 =
OLED"),
> > +               },
> > +               .driver_data =3D (void *)oxp_fly,
> > +       },
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1L=
"),
> > +               },
> > +               .driver_data =3D (void *)oxp_fly,
> > +       },
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1P=
ro"),
> > +               },
> > +               .driver_data =3D (void *)oxp_fly,
> > +       },
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 =
EVA-02"),
> > +               },
> > +               .driver_data =3D (void *)oxp_fly,
> > +       },
> >         {
> >                 .matches =3D {
> >                         DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> > --
> > 2.48.1
> >

