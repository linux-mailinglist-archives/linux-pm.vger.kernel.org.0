Return-Path: <linux-pm+bounces-12841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C28A95D3F9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB15DB21B43
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29F18BBBF;
	Fri, 23 Aug 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL8jc1Up"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D018BB97;
	Fri, 23 Aug 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432655; cv=none; b=Va2o1dXLG75U25oPirP5Pmg2fuKGn33fmZmLUqOje3zASCvCQygnKjbDQb9Jg98wojyHemEQd9lv1NGVNdITGVJf3/Zkkw9eRFVOFxMnOfyzu4WgAumfdEa2UeprQQsAcAGTfSfMVXPfC0hm615Wv/8Dyvb2kAG1DaaReOcJGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432655; c=relaxed/simple;
	bh=gPop/UVhlz7Wrcp5Tuthp7RNQzQjH8WZPkpvf7yD3tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfEJtXZUj6Tv9mJ1IbkPahid35SRseyPtVQ4C4KfbPKHYESBbYx9+PhcN243ZLrB9RBeAy0Lz/7SaTKgOyhdQpJIO4L+qore/bDqKQEfasEc0Vqf5ByyR4jd7xDZlvXK6/FNvj2qY0tkcGDLc6iWaHknYkGUMovFJLJ6rXm1AYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL8jc1Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7931BC4AF0B;
	Fri, 23 Aug 2024 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432654;
	bh=gPop/UVhlz7Wrcp5Tuthp7RNQzQjH8WZPkpvf7yD3tU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sL8jc1UpWeDz0x2Qlcy8Xyq94AiGFAVkCxvIRrjj+Qccy02w9GmAHaDr427wWDHsb
	 BbgpECe2XAXwVs2O3e7Y6AO0UzfI37cybVrsQAddQceBdi7GxUWQrOwh7W1ytnOH7P
	 mN1cP2GruonaXTeKUJ/H9NzOCA4IZTMvo3ThWfLGeEn6MbQlhhPKNIzF6qQsmTOpek
	 0fPLSQFp39cx9Vplig2kmpDb3e+LuMjvpge4s7uuhnAUaIDyZYT8awK7rbSxH3xSGT
	 73VWtyvLKBi5jlLpyvGCpS7J9CJsrs/dwkU5PreXXnOYODXK3yNep9bvkpBpyE5Ia1
	 AD+QxR0OYfXQg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27051f63018so1553716fac.3;
        Fri, 23 Aug 2024 10:04:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWIMGIgYJapFgwT2OtQ+Sg2IjEF5Oj0VMSAbB+tX73TX2TY6yOGvdmcMnjlk882GpRSKoNEnZJne3sr1o=@vger.kernel.org, AJvYcCWX/hTCuocrZ5bijB3FnEALjQqeYfMa/umDQSiIkdy8TyGWj4RvCpgmemhBEV1VlSd5JwZXCT5vUUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YximPAAdHv1ajkK098YYuKb544aeAvM/ShYFKkoD+EZiSehCnpW
	XUdgLEbFXjFzbWgBFvAsEnSwy/rOHiNEJ/wu5quiqCnIah+S5/erXBuoQZ4Uyht90XWGkAzdFhw
	U8NxKvvpK5SK9FwuCZfKthemjXQ0=
X-Google-Smtp-Source: AGHT+IFvfuY5PSYq4C0JygpVUbW7Ga5Qce5crGO5quW3xdzsBfgWGH2H7IvUoFRlXKNu8h5FEWs58XSGsXpyNdaJXhY=
X-Received: by 2002:a05:6871:725:b0:260:f9e4:1fc with SMTP id
 586e51a60fabf-273e64d9609mr2930005fac.20.1724432653808; Fri, 23 Aug 2024
 10:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3331194.44csPzL39Z@rjwysocki.net> <7719509.EvYhyI6sBW@rjwysocki.net>
 <cb8bbde9-1b13-4c63-960d-5846a319f5ea@linaro.org> <CAJZ5v0g-NNKeXh_m-O+mAL=w3Roae_EMUWA5fbBvi49jhZM07A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g-NNKeXh_m-O+mAL=w3Roae_EMUWA5fbBvi49jhZM07A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Aug 2024 19:04:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyYNCiZ5ESsiLHmKzbHypMuqMC3mi-Pnf8Ws6B8k6Gcw@mail.gmail.com>
Message-ID: <CAJZ5v0hyYNCiZ5ESsiLHmKzbHypMuqMC3mi-Pnf8Ws6B8k6Gcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: sysfs: Add sanity checks for trip
 temperature and hysteresis
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 6:39=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Aug 23, 2024 at 5:26=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 22/08/2024 21:48, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Add sanity checks for new trip temperature and hysteresis values to
> > > trip_point_temp_store() and trip_point_hyst_store() to prevent trip
> > > point thresholds from falling below THERMAL_TEMP_INVALID.
> > >
> > > However, still allow user space to pass THERMAL_TEMP_INVALID as the
> > > new trip temperature value to invalidate the trip if necessary.
> > >
> > > Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip poi=
nt updates")
> > > Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >   drivers/thermal/thermal_sysfs.c |   38 ++++++++++++++++++++++++++--=
----------
> > >   1 file changed, 26 insertions(+), 12 deletions(-)
> > >
> > > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > > @@ -111,18 +111,25 @@ trip_point_temp_store(struct device *dev
> > >
> > >       mutex_lock(&tz->lock);
> > >
> > > -     if (temp !=3D trip->temperature) {
> > > -             if (tz->ops.set_trip_temp) {
> > > -                     ret =3D tz->ops.set_trip_temp(tz, trip, temp);
> > > -                     if (ret)
> > > -                             goto unlock;
> > > -             }
> > > +     if (temp =3D=3D trip->temperature)
> > > +             goto unlock;
> > >
> > > -             thermal_zone_set_trip_temp(tz, trip, temp);
> > > +     if (temp !=3D THERMAL_TEMP_INVALID &&
> > > +         temp <=3D trip->hysteresis + THERMAL_TEMP_INVALID) {
> >
> > It seems to me the condition is hard to understand.
>
> That's not the key consideration here though.
>
> >
> >    temp <=3D trip->hysteresis + THERMAL_TEMP_INVALID
>
> This cannot overflow because trip->hysteresis is non-negative.
>
> >
> >           =3D=3D>
> >
> >    temp - trip->hysteresis <=3D THERMAL_TEMP_INVALID
>
> But this can.

Well, I think I should add a comment there to point that out or people
will try to "clean it up".

Also note that in the hysteresis case the condition can be

if (trip->temperature - hyst <=3D THERMAL_TEMP_INVALID) {

because trip->temperature is never below THERMAL_TEMP_INVALID there.

Moreover, setting the hysteresis when the temperature is
THERMAL_TRIP_INVALID does not make much sense.

I'll send a v2.

> >
> >
> > Could be the test below simpler to understand ?
> >
> >         if (trip->hysteresis &&
> >             temp - trip->hysteresis < THERMAL_TEMP_INVALID))
> >
> > I think more sanity check may be needed also.
> >
> >         if (temp < THERMAL_TEMP_INVALID)
>
> With my version of the check above this is not necessary (unless I'm
> missing something}.
>
> > > +             ret =3D -EINVAL;
> > > +             goto unlock;
> > > +     }

