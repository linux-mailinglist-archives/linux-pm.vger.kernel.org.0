Return-Path: <linux-pm+bounces-10538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D04925E87
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A1C2A2ACC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD23180A9C;
	Wed,  3 Jul 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZOlQ9Pc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD1741D8;
	Wed,  3 Jul 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006165; cv=none; b=ue2IVlA3I6aZ6sqMYcL/sSMflRG1uzNF8OwbWjkfCeFZ8WlcTZZjciN3mCKBrQ7jX9+ziSklaKiP0r2h9nlWrWKW9TfJALQVzDWkBTkRvX910YxJTZa+h/IFdqzStal1Y5gOAwxnv1omIQmI7P+XQt3NGVnt9A1qn2cYYEybFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006165; c=relaxed/simple;
	bh=J1TqBfgMvz3MisIs2hh8O8mTQPg8xA/goCyFhkuKx7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3gERoxK3IUZOKY4/kx9zIXGvAfOkI5ZwJNChbxvVL4ybHHrD7b2vYThi2Z9FieK12j/z1cya+vJNdCv0xcd29UilV0Q1xDVP4ncuWJcKEUak65RH2T2PlOMn/CNb1IiVopwVscL0ThPg1ojtGSsFOR+7yzS2kM3l98VbmLGmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZOlQ9Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EA3C4AF0E;
	Wed,  3 Jul 2024 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720006164;
	bh=J1TqBfgMvz3MisIs2hh8O8mTQPg8xA/goCyFhkuKx7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IZOlQ9PcKnngdX1qW1D2uVGf7FRuZz7tgzdlqicMpZeSv5TfyZAoiIbmKfQMqjFCI
	 Fq8LQj6ZCdnd9yTuJsMF4CgqocLuo4RPLD6UOE5MMrJKcYd5zbb8VxReOGZFATJSXk
	 3LiJXOUfgHd0Ulku5jyIKpPQ9OQAY99Kkqyu1sRxT7cT4YYr2nhmW5HbQ9NIA94hl/
	 oQmnV3PEvv5zW3O7FDMDtIhSo0tOBOOgGd8rg+gVKgl0PdCv1jy6h401arUbwN+Y9H
	 T1IOkOlMRQJb/9ClGOa7hWRvoI+UgjeJfxcGRvrg3ELamblrKky6blMlRscDnUZsuD
	 t30TpIewTfehA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25cb5ee9d2dso808069fac.1;
        Wed, 03 Jul 2024 04:29:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS4ClJ/0gJ67YnjiHQO1dL/SwKUAOdOpfmnNSgxgC/qPZURmV19OYIFONJ3IrwYjOotS+Ay6gl0Gc0jeV2r+V9AuxIAECst1CiDLjoVqWJP7XcTzUHdsHLX6xz/HWoTZPpcEJPI+FhF/ThGu/jQh9XHxRu17fUhdykP7p8bXsv9XY2jv/T
X-Gm-Message-State: AOJu0YxLqgslFj/+Gpq/Gcl6kk6sHSugq+0xEfJ+TRE6pnBGPvxxKjEd
	oQVlNu/2I1hE+TexK9ivvFj7eWvQG00K6KtUX0Rrcl5p6z9+mQwRGjsThnRDdgxZFu3Yr7Gbenc
	DEI5Dh1MCO0xEpaUA7eSXbzw8Yn0=
X-Google-Smtp-Source: AGHT+IEfBcCjatNC6wC5BGGI315cgOmTa423h04GO+a7g0cgFZZJ/cgCoSiY1QtLJ4b3xk8CiR2OfueDiVajgIduryo=
X-Received: by 2002:a05:6871:24d2:b0:25e:180:9183 with SMTP id
 586e51a60fabf-25e0180af8amr3552026fac.4.1720006163639; Wed, 03 Jul 2024
 04:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2764814.mvXUDI8C0e@rjwysocki.net> <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
In-Reply-To: <2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2024 13:29:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ghYd28H5eX8b68PSABMm8vTbeSpMxUsQ5mpVOXRPZ3RA@mail.gmail.com>
Message-ID: <CAJZ5v0ghYd28H5eX8b68PSABMm8vTbeSpMxUsQ5mpVOXRPZ3RA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: neil.armstrong@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 3, 2024 at 1:04=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Hi,
>
> On 28/06/2024 14:10, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> > if zone temperature is invalid") caused __thermal_zone_device_update()
> > to return early if the current thermal zone temperature was invalid.
> >
> > This was done to avoid running handle_thermal_trip() and governor
> > callbacks in that case which led to confusion.  However, it went too
> > far because monitor_thermal_zone() still needs to be called even when
> > the zone temperature is invalid to ensure that it will be updated
> > eventually in case thermal polling is enabled and the driver has no
> > other means to notify the core of zone temperature changes (for example=
,
> > it does not register an interrupt handler or ACPI notifier).
> >
> > Also if the .set_trips() zone callback is expected to set up monitoring
> > interrupts for a thermal zone, it has to be provided with valid
> > boundaries and that can only happen if the zone temperature is known.
> >
> > Accordingly, to ensure that __thermal_zone_device_update() will
> > run again after a failing zone temperature check, make it call
> > monitor_thermal_zone() regardless of whether or not the zone
> > temperature is valid and make the latter schedule a thermal zone
> > temperature update if the zone temperature is invalid even if
> > polling is not enabled for the thermal zone.
> >
> > Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() =
if zone temperature is invalid")
> > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c |    5 ++++-
> >   drivers/thermal/thermal_core.h |    6 ++++++
> >   2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -300,6 +300,8 @@ static void monitor_thermal_zone(struct
> >               thermal_zone_device_set_polling(tz, tz->passive_delay_jif=
fies);
> >       else if (tz->polling_delay_jiffies)
> >               thermal_zone_device_set_polling(tz, tz->polling_delay_jif=
fies);
> > +     else if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
> > +             thermal_zone_device_set_polling(tz, msecs_to_jiffies(THER=
MAL_RECHECK_DELAY_MS));
> >   }
> >
> >   static struct thermal_governor *thermal_get_tz_governor(struct therma=
l_zone_device *tz)
> > @@ -514,7 +516,7 @@ void __thermal_zone_device_update(struct
> >       update_temperature(tz);
> >
> >       if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
> > -             return;
> > +             goto monitor;
> >
> >       tz->notify_event =3D event;
> >
> > @@ -536,6 +538,7 @@ void __thermal_zone_device_update(struct
> >
> >       thermal_debug_update_trip_stats(tz);
> >
> > +monitor:
> >       monitor_thermal_zone(tz);
> >   }
> >
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -133,6 +133,12 @@ struct thermal_zone_device {
> >       struct thermal_trip_desc trips[] __counted_by(num_trips);
> >   };
> >
> > +/*
> > + * Default delay after a failing thermal zone temperature check before
> > + * attempting to check it again.
> > + */
> > +#define THERMAL_RECHECK_DELAY_MS     100
> > +
> >   /* Default Thermal Governor */
> >   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> >   #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> >
> >
> >
> >
>
> This patch on next-20240702 makes Qualcomm HDK8350, HDK8450, QRD8550, HDK=
8560, QRD8650 & HDK8650 output in loop:
>
> thermal thermal_zoneXX: failed to read out thermal zone (-19)

Is the loop endless?  If not, how many times does the message get printed?

If I'm not mistaken, it would be printed at least once without the
commit in question.  Can you please check that?

Also, can you check the previous version of the patch in question:

https://lore.kernel.org/linux-pm/2745114.mvXUDI8C0e@rjwysocki.net/

and see if it has the same problem (just apply it instead of the $subject o=
ne).

Thanks!

