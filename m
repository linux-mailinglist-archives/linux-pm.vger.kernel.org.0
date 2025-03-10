Return-Path: <linux-pm+bounces-23786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2209BA5AAB3
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D9F17252A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7111F09B0;
	Mon, 10 Mar 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgR/lZP9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344D1DE3D2;
	Mon, 10 Mar 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647853; cv=none; b=NjT7FiGfGZ4XHEw+yKwDbQWp0VBT05Ou2jPrxRxKLEfAIcwFABtAunJlYo5halvhbPPju3wk1AEeZ3UJ2o1NO/ep40VotxwHgjFGSJwOKAx+7mBjm4e2YRO6r8ZyXZsF0f08OkP/zLDNgEIOcdt/f0P+hVm9bfEwMt7LjfMbM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647853; c=relaxed/simple;
	bh=+haLqFNayGcvZzFqgy9IPhgSVDV6DEg6QSbumjsPCTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB8SvnDJL+WNweh0CWrcKx1tMld0rg05sHULYdnoqzU0EmIuiXqfW2PiTxh+T6gIAMXxX+hYpL4B6H6FOoVQ9eLeyB8AqZY4/6y9CDhtjhtcuEliHr+a16nKtb1H92tCIMLIkpCDrUgdyv1DeyThyI0ifbl8gdOjDJ23XfkMusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgR/lZP9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f94c2698so21447236d6.0;
        Mon, 10 Mar 2025 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741647850; x=1742252650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2jbyGvMajC80IEN9GNO5bY/eJxmLOGWz+jQElsYBjw=;
        b=QgR/lZP9BKUp2N2pF9g2hPcswfeZfrxOV62ZKT5S4+PIlqYvcZ0gvPiUTDNv7ywNai
         2PIlqBUcIc/Vj5oZ8PbN4+18MYQXnC0FjDqhKVy4AjBFzMSewpn3BRH0X3tG1PjnFOHq
         rnyEvN9LsPMn+flt31/bz8VzLQbFJAoXeeT98Q3UimeAvle9VnTaVFfnfHug9wBs1nAh
         PdkXDGu9Mx4a3GbZcydft2yR6ae7nWZELPBzHYcGwqbEH41+lNiNEq8e4YJqy7s4yUNj
         C21Z8eL2K2Q3zTnmUV1b6XbBnbCZPOOxH2yCR9HtiMntvHEbaoyqB/qJ2f/pfBLE60vL
         sxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741647850; x=1742252650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2jbyGvMajC80IEN9GNO5bY/eJxmLOGWz+jQElsYBjw=;
        b=mIsCyAH4qYu5+jTnto1FrY4wKB6YQJkfEMgr/FcbEra6godJdrYKt5EuncM3PvqoBt
         duEjikrIzG9BExOcXsQ0QesM5Z+GSmbQoK4FeELJgqdFCqXkdXRLrXOPhQRs69joRn1V
         gSXWhvxqOmtuYF3zjB9UFg2xawMl9M3Bj5WlGtZofe6Qu8zHcAnnRt+ZscE4uWKMn0rQ
         M0tONyRsQ6Up24SH3JixB+B4gQBfzXG1yRTHJDfgzR2vfWvsEqE3NOvbS6vv+XiLGogo
         0U8aShE4vnlKmYNHqpR5OKsTUS7J0VZnZqQs1eOlv28AMD6adh5WLWjVdbhi/aEn+6Hq
         02aA==
X-Forwarded-Encrypted: i=1; AJvYcCVAKBMLZR3Xs3GGwYA5cjYeDOYFlECEBx8cFppjjTu2gOg8C0mBA7x53JsKVFZtu9cEivDiUvtHKMs=@vger.kernel.org, AJvYcCX9XGqA1MiB9nP39XqQ6s4eywfoXCxOUtQX7EVLg1RZ2/Wh3D00q0DMIJ8QGYDm4TKOat0ArdkdAnJj7P4=@vger.kernel.org, AJvYcCXSUKwHmZZ5Ekmh34AGGLCM6OiBBJ+ODNb9sHT1ef3sbULmFXXCk93xCnS/CicE/cpEmFUa/LoOLAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0AyvpAComMap06BeQrXMrSKi1HdUu1S8lNLGj0ajCjLY62qd
	0vbM8B7GC17qTmmYQU1RqlcRS0SugHAcV/LP40aDcE2X+Ur3tKTV552UBy3zso8YuyxsXB7sLRw
	oSBA7DmgIT4yfY1CKsRJdTmI/h2A=
X-Gm-Gg: ASbGncuqBgI3m8f9HQizTJimKEViuvw2/mKoP9IF7dpO+StlIo2axdIb3EE2pnJJPrg
	tjwFwxTy6Bulpw2vaZhzzKVx7dK038VkYW304N8BCNHW+Sb3Py9kQJ9vF/CrgoAD/LnbCPy+Pjt
	J/aQTLW7wlXaOlM79rYdtAPvPXt4c=
X-Google-Smtp-Source: AGHT+IHtpjz+mYSdGw1McE5Wegqv5LQI0POhWFiT4oDhVlKIrlpyhBp8VExF9lm4bjwHciYsgSgJtFBa/BFB2cOmsXE=
X-Received: by 2002:ad4:5d49:0:b0:6e8:f4f6:9311 with SMTP id
 6a1803df08f44-6e9006019c7mr225757206d6.1.1741647850474; Mon, 10 Mar 2025
 16:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-3-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-3-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:03:59 -0700
X-Gm-Features: AQ5f1JoOtNPfri84vLX0kRcK-7tOcgRLs_0XAe901KR-b1oLKTbHvVbJfanC8dA
Message-ID: <CAFqHKTkvNhbTyDmqCOoMq61NXFTau1Gptbqe7EAqZc6GhQYb=w@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] hwmon: (oxp-sensors) Add all OneXFly variants
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Kevin Greenberg <kdgreenberg234@protonmail.com>, 
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> Currently, the driver only has the F1 OneXFly variant, which was based
> on the 7000 AMD platform. Add its special editions: F1 EVA-01, F1 OLED.
> F1 OLED might have been a dev unit, but it is supported by OneXConsole
> with the same features so add it. Then add the F1L variant which is
> based on the 8000 AMD platform and the F1Pro and its special edition
> EVA-02.
>
> One might ask why not just fuzzy match. Well, EVA-02 is a variant of
> F1Pro which is a Strix Point handheld, but does not have F1Pro in its
> name. This makes it risky to fuzzy match, as special variants in the
> future from different platforms might not have the same feature set
> or registers.
>
> By happenstance, all current devices use the same registers. For the
> charge limitting feature on this series, only F1Pro/X1 (AMD) were
> released with it, but OneXPlayer is providing bios updates for F1, F1L,
> X1 Mini units that use the same register, so treat all of them the same.
>
Greeting Antheas,

Do we know the BIOS version(s) that support was added? If so, I think
it makes sense to treat these as separate devices  and check for
device specific BIOS version in an is_visible for the charge limit
attr. I expect that calling the registers when support isn't present
will just be a no-op based on how OXP historically does things, but
having a present attribute that has no effect will probably generate
bug reports. It is also not appropriate to check/fix this in userspace
as some folks might use udev to set it over a program with such
checks.

Cheers,
- Derek

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/hwmon/oxp-sensors.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 5a4230ad3757..f7a64fbc8f33 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -188,6 +188,41 @@ static const struct dmi_system_id dmi_table[] =3D {
>                 },
>                 .driver_data =3D (void *)oxp_fly,
>         },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 EV=
A-01"),
> +               },
> +               .driver_data =3D (void *)oxp_fly,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 OL=
ED"),
> +               },
> +               .driver_data =3D (void *)oxp_fly,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1L")=
,
> +               },
> +               .driver_data =3D (void *)oxp_fly,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1Pro=
"),
> +               },
> +               .driver_data =3D (void *)oxp_fly,
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 EV=
A-02"),
> +               },
> +               .driver_data =3D (void *)oxp_fly,
> +       },
>         {
>                 .matches =3D {
>                         DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> --
> 2.48.1
>

