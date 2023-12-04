Return-Path: <linux-pm+bounces-689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D74803BEF
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 18:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16651C20A40
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054E2510C;
	Mon,  4 Dec 2023 17:47:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D4F3;
	Mon,  4 Dec 2023 09:47:16 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fb1620a00eso575917fac.1;
        Mon, 04 Dec 2023 09:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712035; x=1702316835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLxhbHxHs0yyW58U+USrAp9QZYXyCCBbOT0f2qo1Lmw=;
        b=Scj0c0/PQKWNuW9DfEoB5V+mrGtkuR4dZzpmVETXHLKLjFJF1PPr8XqdzpVqMgY5Aa
         06kStxIrvvqdhBjyRmwS4AAFj36+wvlIbkC+5k1LqD2pnaWSNlPkbV9xKweLqeQIaFCz
         cq8lptJ1/cbwzOyrgg+Msl2vCqTA61MOOkoNik0cW7+Kb+39y/oVPFKCJ5f1YmrmcHPB
         zSwuFEI46FaypSqsGkn85hsuuBmMA/s5/EofjX0plNbCfhw0NX54UwP3AwEHTfjzgHp/
         jAgUtOOTvePyhFkwOeXmEYU3wnpjfr3iB0gFOGikx+mKpwhLluhpZgd/fgCXKkqz69u+
         hF+A==
X-Gm-Message-State: AOJu0YzK0oFP9HK8vvp+/IJ6GcfUU+TkgX4Ra/qv3kw2hk7vjoNDi5CM
	Zfj0aRoW55ME1tjzWvGYeNym4Sf3e7KNs3MigzA=
X-Google-Smtp-Source: AGHT+IG9XswzgrLgYJtdTDaf8gWSyrFBQ4WCE+EubF3UY9rkdQ4XYJYZxIhR3tHSoqMCUpWcXa3k1oTkJ3kzQk8MkcY=
X-Received: by 2002:a05:6870:e38a:b0:1fb:25fb:fabc with SMTP id
 x10-20020a056870e38a00b001fb25fbfabcmr6338860oad.5.1701712035690; Mon, 04 Dec
 2023 09:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12338384.O9o76ZdvQC@kreacher> <4883151.31r3eYUQgx@kreacher> <b3c86caf-635d-416b-af98-9e26f2a68948@linaro.org>
In-Reply-To: <b3c86caf-635d-416b-af98-9e26f2a68948@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Dec 2023 18:47:04 +0100
Message-ID: <CAJZ5v0hEo_HPMR=wVsHDTjPrEBLXgBHwom491rEiLJfapg6Rhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: sysfs: Rework the handling of trip point updates
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Dec 4, 2023 at 5:55=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
>
> Hi Rafael,
>
> On 04/12/2023 15:50, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both trip_point_temp_store() and trip_point_hyst_store() use
> > thermal_zone_set_trip() to update a given trip point, but none of them
> > actually needs to change more than one field in struct thermal_trip
> > representing it.  However, each of them effectively calls
> > __thermal_zone_get_trip() twice in a row for the same trip index value,
> > once directly and once via thermal_zone_set_trip(), which is not
> > particularly efficient, and the way in which thermal_zone_set_trip()
> > carries out the update is not particularly straightforward.
> >
> > Moreover, input processing need not be done under the thermal zone lock
> > in any of these functions.
> >
> > Rework trip_point_temp_store() and trip_point_hyst_store() to address
> > the above, move the part of thermal_zone_set_trip() that is still
> > useful to a new function called thermal_zone_trip_updated() and drop
> > the rest of it.
> >
> > While at it, make trip_point_hyst_store() reject negative hysteresis
> > values.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: No changes
> >
> > v1 -> v2: Still check device_is_registered() under the zone lock
> >
> > ---
> >   drivers/thermal/thermal_core.h  |    2 +
> >   drivers/thermal/thermal_sysfs.c |   75 ++++++++++++++++++++++++++++--=
----------
> >   drivers/thermal/thermal_trip.c  |   45 ++++--------------------
> >   include/linux/thermal.h         |    4 --
> >   4 files changed, 64 insertions(+), 62 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -78,6 +78,19 @@ mode_store(struct device *dev, struct de
> >       return count;
> >   }
> >
> > +static int check_thermal_zone_and_trip_id(struct device *dev,
> > +                                       struct thermal_zone_device *tz,
> > +                                       int trip_id)
> > +{
> > +     if (!device_is_registered(dev))
> > +             return -ENODEV;
> > +
> > +     if (trip_id < 0 || trip_id >=3D tz->num_trips)
> > +             return -EINVAL;
>
> I'm not sure if this check is useful. The function is called from
> trip_point_*_store() which is providing the trip id from the file name
> parsing which is in turn built from an existing trip id. There is no
> reason the trip id is going to be wrong.

I can drop the check just fine.

Do you have any other comments on this patch?

