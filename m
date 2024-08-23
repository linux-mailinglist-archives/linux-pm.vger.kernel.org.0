Return-Path: <linux-pm+bounces-12840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A910F95D3AA
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537791F21F12
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5F18C354;
	Fri, 23 Aug 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRQfkGbP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C218C337;
	Fri, 23 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431193; cv=none; b=S4FEUa+J82ehiF+8uxdp6oz/BXacvh6E01T4GVrXOly8PjzWlH3FpxBCL6e59SVPrn203OKXs7sMdkcyisP4r+WffZVqJeQFB9HCYIEfkLM1UVHsHEST2anXYRK+WWx2lUwDO/6YpMCP1gcbfmFOye1MOUuL50huyuOlmmIc47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431193; c=relaxed/simple;
	bh=ld3rxlPAOgQZpn5csg8dC+UyB1soJOGSEerVByE6LBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8zvNVZ6AGSKIkbeZi9t4Tk7AV4BJPbzFTvrdh6TDo0Pj9qu518R6gwgznL3FF0zALQSDrT3KDblFRBamc7UmcBAIP597J/ZEnwmYLVJNURI7+hBbHk8pVSddmIAYQ29C9kmr0Va+pb+hlXvBDgbIjkembNzPbC2u0dmXUejyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRQfkGbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4925C32786;
	Fri, 23 Aug 2024 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724431192;
	bh=ld3rxlPAOgQZpn5csg8dC+UyB1soJOGSEerVByE6LBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IRQfkGbPa03FfneSInllZGqbvUrvqAaPeF6Zvq4Pd+SAIVcoMbmBI2V8FthvxswZa
	 FyHSGpYazedOXjD4MUwSXPuxvMIlKXv/hWFJumWz3pxMZwAEK0erPaZgWfW16vkRkN
	 R8LFFCov5AC/XbY4kyFQ2hGj6v6YmnmH2bXPQti01hCOewzB4yKdO0+uEOHd+2LJrp
	 p8mILqKoD6bg9YM98OBta5J8t5KBYskMOdq86oTMblrb2vH5spp4EYPGo9pVL+2roA
	 U8evuS3YM06ZZ2hyL0jEb/5Bk6iqHWokE3tRCNw17fOia2qU9UrOfFSLUGY0BKt9hP
	 wwNQXqejx9stg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5b22f97b7so2196675eaf.2;
        Fri, 23 Aug 2024 09:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWRl6NibHrBxJtuu3KlJwi3oVJXQ1pidLw5D3eClvGxS/e9VXKKD57gVv70NXpJKNTDEAmXPfoqcE=@vger.kernel.org, AJvYcCX/7pDDxo3Wm9pSVbtJawPKt9VOwxzNm7MZuTBkMNjZ4TiL0ibdPdXzjatNdGwGCHpWDX2cyCkG7qHLlRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnRg1z3m+5/Zd4tR3NRpUQuRaUBR+vEep5J6zoevWrXrijnga
	opNFHIlPMmmbc526jL2GfMxx6v8Inxsyn24wpptHbRwXg/xyXFh4SCaUO3vaW4cWNAuJw9KJluC
	GnPzM6QnjTXQ7FQGbrR2z7crUjF0=
X-Google-Smtp-Source: AGHT+IEthGR/m8pIykKiw5PE+bN9rXgA0bDFoAXdo1JmaQWp1gcncXt84BQhCWz4i1dC2r15In+D4kr3DwX5XwRUqG8=
X-Received: by 2002:a05:6870:b4aa:b0:261:290:a089 with SMTP id
 586e51a60fabf-273e64e5ee5mr3265264fac.28.1724431192036; Fri, 23 Aug 2024
 09:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3331194.44csPzL39Z@rjwysocki.net> <7719509.EvYhyI6sBW@rjwysocki.net>
 <cb8bbde9-1b13-4c63-960d-5846a319f5ea@linaro.org>
In-Reply-To: <cb8bbde9-1b13-4c63-960d-5846a319f5ea@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Aug 2024 18:39:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-NNKeXh_m-O+mAL=w3Roae_EMUWA5fbBvi49jhZM07A@mail.gmail.com>
Message-ID: <CAJZ5v0g-NNKeXh_m-O+mAL=w3Roae_EMUWA5fbBvi49jhZM07A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: sysfs: Add sanity checks for trip
 temperature and hysteresis
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:26=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/08/2024 21:48, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add sanity checks for new trip temperature and hysteresis values to
> > trip_point_temp_store() and trip_point_hyst_store() to prevent trip
> > point thresholds from falling below THERMAL_TEMP_INVALID.
> >
> > However, still allow user space to pass THERMAL_TEMP_INVALID as the
> > new trip temperature value to invalidate the trip if necessary.
> >
> > Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point=
 updates")
> > Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_sysfs.c |   38 ++++++++++++++++++++++++++----=
--------
> >   1 file changed, 26 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -111,18 +111,25 @@ trip_point_temp_store(struct device *dev
> >
> >       mutex_lock(&tz->lock);
> >
> > -     if (temp !=3D trip->temperature) {
> > -             if (tz->ops.set_trip_temp) {
> > -                     ret =3D tz->ops.set_trip_temp(tz, trip, temp);
> > -                     if (ret)
> > -                             goto unlock;
> > -             }
> > +     if (temp =3D=3D trip->temperature)
> > +             goto unlock;
> >
> > -             thermal_zone_set_trip_temp(tz, trip, temp);
> > +     if (temp !=3D THERMAL_TEMP_INVALID &&
> > +         temp <=3D trip->hysteresis + THERMAL_TEMP_INVALID) {
>
> It seems to me the condition is hard to understand.

That's not the key consideration here though.

>
>    temp <=3D trip->hysteresis + THERMAL_TEMP_INVALID

This cannot overflow because trip->hysteresis is non-negative.

>
>           =3D=3D>
>
>    temp - trip->hysteresis <=3D THERMAL_TEMP_INVALID

But this can.

>
>
> Could be the test below simpler to understand ?
>
>         if (trip->hysteresis &&
>             temp - trip->hysteresis < THERMAL_TEMP_INVALID))
>
> I think more sanity check may be needed also.
>
>         if (temp < THERMAL_TEMP_INVALID)

With my version of the check above this is not necessary (unless I'm
missing something}.

> > +             ret =3D -EINVAL;
> > +             goto unlock;
> > +     }

