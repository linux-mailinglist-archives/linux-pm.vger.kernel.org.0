Return-Path: <linux-pm+bounces-1062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF668110B1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99AD1F21295
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462628DBD;
	Wed, 13 Dec 2023 12:02:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42BB0;
	Wed, 13 Dec 2023 04:02:04 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5909156aea9so776116eaf.0;
        Wed, 13 Dec 2023 04:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702468924; x=1703073724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEAmrfWfgZx6bB3/5cn+QWsBw2i2koXTN0PXN9whVn8=;
        b=nYU5OVKO5EfPB7T8KVDLps6h/cH/bhh7NPPEnQPKGHEeW8peatYEehdpFEd5cFn5n4
         YLJ2J2UH/t1KEEzc0PSNEFXBqdCO4VMFauG1DUltK/M1REAR1x7kjrX8hH0K0zWbgjEu
         4UMmwqRRr9tlXmMHNuN3iFP9/+V+tK55Oik0RpUUaF9kgv7feoVJdZjpufEsnJc1GoB3
         X59IAO0pXnegjdrJ2d9eiUvFpSDuj0gs73anR4sG18adZLDhl8RY1flsAf3Ek8Ug3f25
         aoo8i8i8uP84LSjb/9fWutZXPPd39fqIo8NI3WI9r5CQHPlhltgZgw9/OKwwK0hmq2q7
         2eEQ==
X-Gm-Message-State: AOJu0YwpF9NnFO9kR5AQXCmz/Do6ZgJRP5h+fYpU6HANgXD/duOM3Fa7
	z9dH8w0wIg8ZmeBxSa8GwFzSYH0bVg0RSxzIEZbPNyZX
X-Google-Smtp-Source: AGHT+IEd98MMQNnvYVtMuG9REb9GI+09RbG/7vfhRBzULZG5FHP6kxtZY+jLCMYeodTMboSxRQWo7+8YZlAYrp8p9/c=
X-Received: by 2002:a05:6871:e717:b0:1fa:df87:4eba with SMTP id
 qa23-20020a056871e71700b001fadf874ebamr15536835oac.5.1702468923676; Wed, 13
 Dec 2023 04:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
In-Reply-To: <20231212221301.12581-1-ansuelsmth@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 13:01:51 +0100
Message-ID: <CAJZ5v0gTUSFeR=8ov_CgMzkPF7hJ4_MXYZNvsONC8wMxyhiu=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:17=E2=80=AFPM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
>
> Add initial support for cold and critical_cold trip point. Many if not
> all hwmon and thermal device have normally trip point for hot
> temperature and for cold temperature.
>
> Till now only hot temperature were supported. Add support for also cold
> temperature to permit complete definition of cold trip point in DT.
>
> Thermal driver may use these additional trip point to correctly set
> interrupt for cold temperature values and react based on that with
> various measure like enabling attached heater, forcing higher voltage
> and other specialaized peripherals.
>
> For hwmon drivers this is needed as currently there is a problem with
> setting the full operating range of the device for thermal devices
> defined with hwmon. To better describe the problem, the following
> example is needed:
>
> In the scenario of a simple hwmon with an active trip point declared
> and a cooling device attached, the hwmon subsystem currently set the
> min and max trip point based on the single active trip point.
> Thermal subsystem parse all the trip points and calculate the lowest and
> the highest trip point and calls the .set_trip of hwmon to setup the
> trip points.
>
> The fact that we currently don't have a way to declare the cold/min
> temperature values, makes the thermal subsystem to set the low value as
> -INT_MAX.
> For hwmon drivers that doesn't use clamp_value and actually reject
> invalid values for the trip point, this results in the hwmon settings to
> be rejected.
>
> To permit to pass the correct range of trip point, permit to set in DT
> also cold and critical_cold trip point.
>
> Thermal driver may also define .cold and .critical_cold to act on these
> trip point tripped and apply the required measure.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Generally speaking, it is kind of late in the cycle for adding
significant new features like this.  We can get to it when 6.8-rc1 is
out, so please resend then.

Also it would be nice to define/document the cold and crtitical_cold
trip points somewhere and is there a better name for critical_cold?

> ---
>  drivers/thermal/thermal_core.c  | 13 +++++++++++++
>  drivers/thermal/thermal_of.c    |  2 ++
>  drivers/thermal/thermal_sysfs.c |  4 ++++
>  drivers/thermal/thermal_trace.h |  4 ++++
>  include/linux/thermal.h         |  2 ++
>  include/uapi/linux/thermal.h    |  2 ++
>  6 files changed, 27 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9c17d35ccbbd..3c5ab560e72f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -344,6 +344,17 @@ static void handle_critical_trips(struct thermal_zon=
e_device *tz,
>                 tz->ops->hot(tz);
>  }
>
> +static void handle_critical_cold_trips(struct thermal_zone_device *tz,
> +                                      const struct thermal_trip *trip)
> +{
> +       trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip-=
>type);
> +
> +       if (trip->type =3D=3D THERMAL_TRIP_CRITICAL_COLD && tz->ops->crit=
ical_cold)
> +               tz->ops->critical_cold(tz);
> +       else if (trip->type =3D=3D THERMAL_TRIP_COLD && tz->ops->cold)
> +               tz->ops->cold(tz);
> +}
> +
>  static void handle_thermal_trip(struct thermal_zone_device *tz,
>                                 const struct thermal_trip *trip)
>  {
> @@ -365,6 +376,8 @@ static void handle_thermal_trip(struct thermal_zone_d=
evice *tz,
>
>         if (trip->type =3D=3D THERMAL_TRIP_CRITICAL || trip->type =3D=3D =
THERMAL_TRIP_HOT)
>                 handle_critical_trips(tz, trip);
> +       else if (trip->type =3D=3D THERMAL_TRIP_CRITICAL_COLD || trip->ty=
pe =3D=3D THERMAL_TRIP_COLD)
> +               handle_critical_cold_trips(tz, trip);
>         else
>                 handle_non_critical_trips(tz, trip);
>  }
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..95bc600bb4b8 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -60,6 +60,8 @@ static const char * const trip_types[] =3D {
>         [THERMAL_TRIP_PASSIVE]  =3D "passive",
>         [THERMAL_TRIP_HOT]      =3D "hot",
>         [THERMAL_TRIP_CRITICAL] =3D "critical",
> +       [THERMAL_TRIP_COLD]     =3D "cold",
> +       [THERMAL_TRIP_CRITICAL_COLD] =3D "critical_cold",
>  };
>
>  /**
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index eef40d4f3063..e1e69e0991c2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -106,6 +106,10 @@ trip_point_type_show(struct device *dev, struct devi=
ce_attribute *attr,
>                 return sprintf(buf, "critical\n");
>         case THERMAL_TRIP_HOT:
>                 return sprintf(buf, "hot\n");
> +       case THERMAL_TRIP_COLD:
> +               return sprintf(buf, "cold\n");
> +       case THERMAL_TRIP_CRITICAL_COLD:
> +               return sprintf(buf, "critical_cold\n");
>         case THERMAL_TRIP_PASSIVE:
>                 return sprintf(buf, "passive\n");
>         case THERMAL_TRIP_ACTIVE:
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_tr=
ace.h
> index 459c8ce6cf3b..0a4f96075d7d 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -11,6 +11,8 @@
>
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_COLD);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL_COLD);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>
> @@ -18,6 +20,8 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>         __print_symbolic(type,                                  \
>                          { THERMAL_TRIP_CRITICAL, "CRITICAL"},  \
>                          { THERMAL_TRIP_HOT,      "HOT"},       \
> +                        { THERMAL_TRIP_COLD,      "COLD"},     \
> +                        { THERMAL_TRIP_CRITICAL_COLD, "CRITICAL_COLD"}, =
\
>                          { THERMAL_TRIP_PASSIVE,  "PASSIVE"},   \
>                          { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index cee814d5d1ac..d6345c9ec50d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -84,6 +84,8 @@ struct thermal_zone_device_ops {
>                           const struct thermal_trip *, enum thermal_trend=
 *);
>         void (*hot)(struct thermal_zone_device *);
>         void (*critical)(struct thermal_zone_device *);
> +       void (*cold)(struct thermal_zone_device *);
> +       void (*critical_cold)(struct thermal_zone_device *);
>  };
>
>  struct thermal_cooling_device_ops {
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index fc78bf3aead7..7fa1ba0dff05 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -14,6 +14,8 @@ enum thermal_trip_type {
>         THERMAL_TRIP_PASSIVE,
>         THERMAL_TRIP_HOT,
>         THERMAL_TRIP_CRITICAL,
> +       THERMAL_TRIP_COLD,
> +       THERMAL_TRIP_CRITICAL_COLD,
>  };
>
>  /* Adding event notification support elements */
> --
> 2.40.1
>

