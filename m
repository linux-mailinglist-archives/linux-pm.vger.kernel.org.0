Return-Path: <linux-pm+bounces-353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF107FBA8F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 13:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39902B21464
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62394446B2;
	Tue, 28 Nov 2023 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE010D4;
	Tue, 28 Nov 2023 04:54:07 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d815062598so871708a34.0;
        Tue, 28 Nov 2023 04:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176045; x=1701780845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KansKB/I6JMABnep2eO/OwfMWyW5lRyhE+ZO5W+A/ws=;
        b=cHVMkKQjb2/3hAfY2clot2YmI6PaEOiLfqgoFZAfmWL3XjZJRzf9mwyeWOqh467EwY
         sORBJgHhJdg7yZRzvhXkj68t4Su97edQZt5kk0UxUGt26ZdYIymzPNEYfSaYV/0SpKm0
         T5TawRQUpher0tjniLpKLKksc2YgRJuxSDqPVA+EnlqRRUHx6dC+zTnVzYxEY38EMI8u
         4XQs+T+/s69CKTnQcxYGtNWblp63AiD4xE62hXyxI8S9wNYVqOi3mDQUMkL23WP8GRR8
         oKTaaXD/rjFqci7pDZ48mw7Y8s7jQSezEE3iZwJG6IeNVsFJE8fjrV3XtC8Yc7ysr2CC
         4Bug==
X-Gm-Message-State: AOJu0YzGYoCVrMpuXJAQCRzclSqwgCju/WRDyJ1wvvYWASIJ1mTvKmk9
	sILwuOwmvp2qIvh7sUSCZSMMFYG/Qf5v8JXQsr4=
X-Google-Smtp-Source: AGHT+IEPoptBOm+FCdrsD7uMUnoB/xFwq4DwM8OLtwgqU3ZrwwVTieoVYv+j/HqoSQetrl66aq3gAlFezhhjcgjCihA=
X-Received: by 2002:a05:6820:b0b:b0:58a:7cff:2406 with SMTP id
 df11-20020a0568200b0b00b0058a7cff2406mr13172699oob.0.1701176045412; Tue, 28
 Nov 2023 04:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4892163.31r3eYUQgx@kreacher> <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
In-Reply-To: <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Nov 2023 13:53:54 +0100
Message-ID: <CAJZ5v0iYy90+WPceFrJdv15jBg4NKUz0gj9DsxjCYQr38GznBQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Rework thermal_zone_set_trip() and its callers
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Nov 28, 2023 at 9:16=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 11/27/23 19:59, Rafael J. Wysocki wrote:
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
> > Moreover, some checks done by them both need not go under the thermal
> > zone lock and code duplication between them can be reduced quilte a bit
>
> s/quilte/quite/
>
> > by moving the majority of logic into thermal_zone_set_trip().
> >
> > Rework all of the above funtcions to address the above.
>
> s/funtcions/functions/

Thanks for spotting the typos!

> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.h  |    9 +++++
> >   drivers/thermal/thermal_sysfs.c |   52 +++++++-----------------------=
----
> >   drivers/thermal/thermal_trip.c  |   61 ++++++++++++++++++++++++++----=
----------
> >   include/linux/thermal.h         |    3 -
> >   4 files changed, 61 insertions(+), 64 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -122,6 +122,15 @@ void __thermal_zone_device_update(struct
> >   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> >   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_=
id,
> >                           struct thermal_trip *trip);
> > +
> > +enum thermal_set_trip_target {
> > +     THERMAL_TRIP_SET_TEMP,
> > +     THERMAL_TRIP_SET_HYST,
> > +};
> > +
> > +int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> > +                       enum thermal_set_trip_target what, const char *=
buf);
> > +
> >   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> >                        const struct thermal_trip *trip);
> >   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp=
);
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -120,31 +120,17 @@ trip_point_temp_store(struct device *dev
> >                     const char *buf, size_t count)
> >   {
> >       struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > -     struct thermal_trip trip;
> > -     int trip_id, ret;
> > +     int trip_id;
> > +     int ret;
> > +
> > +     if (!device_is_registered(dev))
> > +             return -ENODEV;
> >
> >       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=3D =
1)
> >               return -EINVAL;
> >
> > -     mutex_lock(&tz->lock);
> > -
> > -     if (!device_is_registered(dev)) {
> > -             ret =3D -ENODEV;
> > -             goto unlock;
> > -     }
> > -
> > -     ret =3D __thermal_zone_get_trip(tz, trip_id, &trip);
> > -     if (ret)
> > -             goto unlock;
> > -
> > -     ret =3D kstrtoint(buf, 10, &trip.temperature);
> > -     if (ret)
> > -             goto unlock;
> > +     ret =3D thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_TEMP,=
 buf);
> >
> > -     ret =3D thermal_zone_set_trip(tz, trip_id, &trip);
> > -unlock:
> > -     mutex_unlock(&tz->lock);
> > -
> >       return ret ? ret : count;
> >   }
> >
> > @@ -179,30 +165,16 @@ trip_point_hyst_store(struct device *dev
> >                     const char *buf, size_t count)
> >   {
> >       struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > -     struct thermal_trip trip;
> > -     int trip_id, ret;
> > +     int trip_id;
> > +     int ret;
> > +
> > +     if (!device_is_registered(dev))
> > +             return -ENODEV;
> >
> >       if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) !=3D =
1)
> >               return -EINVAL;
> >
> > -     mutex_lock(&tz->lock);
> > -
> > -     if (!device_is_registered(dev)) {
> > -             ret =3D -ENODEV;
> > -             goto unlock;
> > -     }
> > -
> > -     ret =3D __thermal_zone_get_trip(tz, trip_id, &trip);
> > -     if (ret)
> > -             goto unlock;
> > -
> > -     ret =3D kstrtoint(buf, 10, &trip.hysteresis);
> > -     if (ret)
> > -             goto unlock;
> > -
> > -     ret =3D thermal_zone_set_trip(tz, trip_id, &trip);
> > -unlock:
> > -     mutex_unlock(&tz->lock);
> > +     ret =3D thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_HYST,=
 buf);
> >
> >       return ret ? ret : count;
> >   }
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -148,42 +148,61 @@ int thermal_zone_get_trip(struct thermal
> >   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
> >
> >   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id=
,
> > -                       const struct thermal_trip *trip)
> > +                       enum thermal_set_trip_target what, const char *=
buf)
> >   {
> > -     struct thermal_trip t;
> > -     int ret;
> > +     struct thermal_trip *trip;
> > +     int val, ret =3D 0;
> >
> > -     if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->tr=
ips)
> > -             return -EINVAL;
>
> Here we could bail out when there are no callbacks.

Not really, because the trip is updated regardless.

>
> > +     if (trip_id < 0 || trip_id >=3D tz->num_trips)
> > +             ret =3D -EINVAL;
> >
> > -     ret =3D __thermal_zone_get_trip(tz, trip_id, &t);
> > +     ret =3D kstrtoint(buf, 10, &val);
> >       if (ret)
> >               return ret;
> >
> > -     if (t.type !=3D trip->type)
> > -             return -EINVAL;
> > +     mutex_lock(&tz->lock);
> >
> > -     if (t.temperature !=3D trip->temperature && tz->ops->set_trip_tem=
p) {
> > -             ret =3D tz->ops->set_trip_temp(tz, trip_id, trip->tempera=
ture);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     trip =3D &tz->trips[trip_id];
> >
> > -     if (t.hysteresis !=3D trip->hysteresis && tz->ops->set_trip_hyst)=
 {
> > -             ret =3D tz->ops->set_trip_hyst(tz, trip_id, trip->hystere=
sis);
> > -             if (ret)
> > -                     return ret;
> > +     switch (what) {
> > +     case THERMAL_TRIP_SET_TEMP:
> > +             if (val =3D=3D trip->temperature)
> > +                     goto unlock;
> > +
> > +             if (tz->ops->set_trip_temp) {
> > +                     ret =3D tz->ops->set_trip_temp(tz, trip_id, val);
> > +                     if (ret)
> > +                             goto unlock;
> > +             }
>
> But here we don't bail out and go line below
>
> > +             trip->temperature =3D val;
>
> where we modify the actual '&tz->trips[trip_id]'.

Right, the trip is updated regardless unless the callback invocation
fails, in which case it is better to retain the existing configuration
for consistency.

The current logic is exactly this AFAICS except that it is hard to untangle=
.

> Shouldn't be something like the code flow below?
> --------------------------------------------8<---------------------------=
--
>                 if (!tz->ops->set_trip_temp)
>                         goto unlock;
>
>                 ret =3D tz->ops->set_trip_temp(tz, trip_id, val);
>                 if (ret)
>                         goto unlock;
>
>                 trip->temperature =3D val;
>                 break
> ----------------------------------->8------------------------------------=
--

Not really.

>
>
>
>
> > +             break;
> > +
> > +     case THERMAL_TRIP_SET_HYST:
> > +             if (val =3D=3D trip->hysteresis)
> > +                     goto unlock;
> > +
> > +             if (tz->ops->set_trip_hyst) {
> > +                     ret =3D tz->ops->set_trip_hyst(tz, trip_id, val);
> > +                     if (ret)
> > +                             goto unlock;
> > +             }
> > +             trip->hysteresis =3D val;
>
> Similar question here.
>
> > +             break;
> > +
> > +     default:
> > +             ret =3D -EINVAL;
> > +             goto unlock;
> >       }
> >
> > -     if (tz->trips && (t.temperature !=3D trip->temperature || t.hyste=
resis !=3D trip->hysteresis))
> > -             tz->trips[trip_id] =3D *trip;
> > -
> >       thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
> >                                     trip->temperature, trip->hysteresis=
);
> >
> >       __thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> >
> > -     return 0;
> > +unlock:
> > +     mutex_unlock(&tz->lock);
> > +
> > +     return ret;
> >   }
> >
> >   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> > Index: linux-pm/include/linux/thermal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -283,9 +283,6 @@ int __thermal_zone_get_trip(struct therm
> >   int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id=
,
> >                         struct thermal_trip *trip);
> >
> > -int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> > -                       const struct thermal_trip *trip);
> > -
>
> Surprisingly, nothing outside thermal fwk uses it...
> Maybe it's worth to check other functions there.

Fair enough, but that's outside this patch IMO.

> Other than that, it looks like a good idea.

Thanks for the review!

