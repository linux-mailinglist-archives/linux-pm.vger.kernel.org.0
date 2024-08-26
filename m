Return-Path: <linux-pm+bounces-12871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3007695EEFA
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 12:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557891C2255C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51C181337;
	Mon, 26 Aug 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWjfcoYu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E4155320;
	Mon, 26 Aug 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669466; cv=none; b=eAbesUoFCA1VIS0Tj0EfBflBxCwIL+hW6HNYJrqhL1Ru/HotiFbOrBEdnigQM2FBRkVt1sit92yuFEPJD+ZbjvpuuZU8w5HMgI6YMJHhjVP2vToJLln3He/T6rDyeYpv9L+Pb09e69Lkte0XkmDlFGLdrTDzXxhz/KC4q+uTt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669466; c=relaxed/simple;
	bh=9XyQq7hdN4dGzn1MtGZZojRBMFR+oodXbd34LMBXDIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCmdHmkb4vj0nqkIUW/4vfQ5ruBYYxVIX9kCUPLP5CThOXOLFhqPLPzAClVpGqJs1BoMMvf0vJUNxDSIxj6Wdc2ZLfqe6d740phAhAhWXghFVZNBiOtRMEL+RCrAXvAVgtXXJCwvdKq8aG7zdcjCe8MmaHq+jusDTwQQpI5rfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWjfcoYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CCCC51430;
	Mon, 26 Aug 2024 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724669466;
	bh=9XyQq7hdN4dGzn1MtGZZojRBMFR+oodXbd34LMBXDIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gWjfcoYu6ixbrHVQjLtZOWbTPo6MCryVZBz1KT7SPK5k6+TpmPBvO7SM1R02ax7Pl
	 V510tLNe9PxYcP9LzKn2LM1ke2JGrPYH+ou84VYZ7sK+VjChmQ4Vgy6BByYvEntBf2
	 pxZ7zIPJ/sOpcp1gpBewrUZtbrFTNGm8u752zo/laS10FVwzcx+HwVLdi3U7NjIGpD
	 AhKilOM9ZfLjrxuFgHew4Ajq0vpoel6s/cLpGgf47aftDOvoMQn4VxzpkfPuDpkBKP
	 L6uJfmeoU4ACyca19YVlXBwuNS4EDaB2APqGBfiF82yFK8rso7soDEaKTNe2uhZf8o
	 +5pbD9fTbgMTw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27012aa4a74so2655667fac.0;
        Mon, 26 Aug 2024 03:51:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7/DkG5BuLoai2Vf44BD3iygXAtSdfYf4v6KNrpgLGR9UaMKonBLt+eXSEueA7iZK6oV72rQF50jrPzCY=@vger.kernel.org, AJvYcCVhGCChZEcKYK7312S+7BdgFqf0UjlzByqXPrH36USKKsPqabcmR7PfsRqihr8dGDRyy5mi9TtBin0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyNVkVipBxiHeDHhh7v5n8mRZaEfr4U+ZesTrw4RlzTG0b1gT
	qW4AqfKOydyaTyUawPGJrQy+DBNTHGxDteZYeFGoy3C/Y/egDMa5lNoAoO2oN/vJhjlg3loT8rj
	xTf0PMjJgPva4TYgNpWBwjMNJSEM=
X-Google-Smtp-Source: AGHT+IG/B0nHhfbw6Kn8YVjXqkuGvBovBzk1DNUWe6U/NOEIulbu0M6i4Zl+zEUFYMMQFsI53zmuwal55fsqTrOwINk=
X-Received: by 2002:a05:6870:700f:b0:25d:f0ba:eab7 with SMTP id
 586e51a60fabf-273e6472850mr11131650fac.18.1724669465070; Mon, 26 Aug 2024
 03:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823154245.1553458-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240823154245.1553458-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 12:50:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikXJrKyHm-texq1ZnWSBqSdi-bi0NCRQ2jPTu8mJ8izA@mail.gmail.com>
Message-ID: <CAJZ5v0ikXJrKyHm-texq1ZnWSBqSdi-bi0NCRQ2jPTu8mJ8izA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] thermal/core: Use thermal_zone_device_param
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	=?UTF-8?B?SsOpcsOpbWllIEdhcmNpYQ==?= <jgarcia@baylibre.com>, 
	Alexandre Bailon <abailon@baylibre.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:43=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The function thermal_zone_device_register_*() have now a significant
> number of parameters.

Which may or may not be regarded as a problem.

To me, there are two arguments for doing a change like this:

(a) A struct initialization is less error-prone than passing a long
list of arguments to a function.  In the particular case of
thermal_zone_device_register_with_trips(), the last two arguments are
easy to mishandle because they are of the same type and similar
meaning.

(b) It gets rid of multiline function invocations that are hard to read.

> Simplify the parameters by extending the thermal_zone_device_param
> structure with the parameters usually used when registering the
> thermal zone.
>
> With that change we have a simpler function:
>
>      thermal_zone_device_register()
>
> which can be reused in the different drivers and replace the
> duplicate thermal_zone_device_register_with_trips() and
> thermal_zone_device_register_tripless() functions.

I actually think that having a special helper for registering a
tripless zone is useful because it makes it super easy to find the
code paths doing that.

> Cc: J=C3=A9r=C3=A9mie Garcia <jgarcia@baylibre.com>
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c |  9 +++++++
>  include/linux/thermal.h        | 43 ++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index e6669aeda1ff..5869562caf9e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1390,6 +1390,15 @@ int thermal_zone_get_crit_temp(struct thermal_zone=
_device *tz, int *temp)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>
> +struct thermal_zone_device *thermal_zone_device_register(const char *typ=
e,
> +                                                        const struct the=
rmal_zone_params *tzp)
> +{
> +       return thermal_zone_device_register_with_trips(type, tzp->trips, =
tzp->num_trips,
> +                                                      tzp->devdata, tzp-=
>ops,
> +                                                      tzp, tzp->passive_=
delay,
> +                                                      tzp->polling_delay=
);

My basic concern with this approach is the copying of pointers that
may become invalid going forward to tzp.

Generally speaking, it is less than useful to hold on to copies of all
data that is only used during thermal zone registration (like a
pointer to the trips table for one example).

I would define a new struct type to hold all of the current
thermal_zone_device_register_with_trips() parameters:

struct thermal_zone_data {
        const char *type,
        const struct thermal_trip *trips;
        int num_trips;
        void *devdata;
        const struct thermal_zone_device_ops *ops,
        const struct thermal_zone_params *tzp;
        unsigned int passive_delay;
        unsigned int polling_delay;
};

and pass that to a wrapper function:

int thermal_zone_register(struct thermal_zone_data *tzdata)
{
        return thermal_zone_device_register_with_trips(tzdata->type,
tzdata->trips, tzdata->num_trips,

              tzdata->devdata, tzdata->ops, tzdata->tzp,

              tzdata->passiva_delay, tzdata->polling_delay);
}

BTW, I don't think that the "device" part of the function name adds
any value, so I wouldn't use it.

A similar thing can be done for the tripless case:

struct thermal_tripless_zone_data {
        const char *type,
        void *devdata;
        const struct thermal_zone_device_ops *ops,
        bool no_hwmon;
};

int thermal_tripless_zone_register(thermal_tripless_zone_data *tzdata)
{
        struct thermal_zone_params tzp =3D { .no_hwmon =3D tzdata->no_hwmon=
 };

        return thermal_zone_device_register_with_trips(tzdata->type, NULL, =
0,

              tzdata->devdata, tzdata->ops, &tzp,

              0, 0);

}

And yes, I would do it so that the users of tripless thermal zones
don't need to use a full struct thermal_zone_params just in order to
pass the no_hwmon value.

> +}
> +
>  /**
>   * thermal_zone_device_register_with_trips() - register a new thermal zo=
ne device
>   * @type:      the thermal zone device type
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b86ddca46b9e..1681b9ddd890 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -174,11 +174,45 @@ struct thermal_zone_params {
>          *              Used by thermal zone drivers.
>          */
>         int slope;
> +
>         /*
>          * @offset:     offset of a linear temperature adjustment curve.
>          *              Used by thermal zone drivers (default 0).
>          */
>         int offset;
> +
> +       /*
> +        * @trips:      a pointer to an array of thermal trips
> +        */
> +       const struct thermal_trip *trips;
> +
> +       /*
> +        * @num_trips:  the number of trip points the thermal zone suppor=
t
> +        */
> +       int num_trips;
> +
> +       /*
> +        * @devdata:    private device data
> +        */
> +       void *devdata;
> +
> +       /*
> +        * @ops:        standard thermal zone device callbacks
> +        */
> +       const struct thermal_zone_device_ops *ops;
> +
> +       /*
> +        * @passive_delay:      number of milliseconds to wait between po=
lls when
> +        *                      performing passive cooling
> +        */
> +       unsigned int passive_delay;
> +
> +       /*
> +        * @polling_delay:      number of milliseconds to wait between po=
lls when checking
> +        *                      whether trip points have been crossed (0 =
for interrupt
> +        *                      driven systems)
> +        */
> +       unsigned int polling_delay;
>  };
>
>  /* Function declarations */
> @@ -218,6 +252,10 @@ void thermal_zone_set_trip_temp(struct thermal_zone_=
device *tz,
>  int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp=
);
>
>  #ifdef CONFIG_THERMAL
> +
> +struct thermal_zone_device *thermal_zone_device_register(const char *typ=
e,
> +                                                        const struct the=
rmal_zone_params *tzp);
> +
>  struct thermal_zone_device *thermal_zone_device_register_with_trips(
>                                         const char *type,
>                                         const struct thermal_trip *trips,
> @@ -281,6 +319,11 @@ int thermal_zone_device_enable(struct thermal_zone_d=
evice *tz);
>  int thermal_zone_device_disable(struct thermal_zone_device *tz);
>  void thermal_zone_device_critical(struct thermal_zone_device *tz);
>  #else
> +static inline struct thermal_zone_device *thermal_zone_device_register(
> +       const char *type,
> +       const struct thermal_zone_params *tzp)
> +{ return ERR_PTR(-ENODEV); }
> +
>  static inline struct thermal_zone_device *thermal_zone_device_register_w=
ith_trips(
>                                         const char *type,
>                                         const struct thermal_trip *trips,
> --
> 2.43.0
>

