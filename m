Return-Path: <linux-pm+bounces-19427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556119F67BB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1500A1884800
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1661B0408;
	Wed, 18 Dec 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I02B9EgV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFF158853;
	Wed, 18 Dec 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530026; cv=none; b=ovMJQ71YRtNhLxX6nWkovXLiasq8g+UMeloss4NNQxAE2ssqrljOkfhFs9gpMbdPVQfg8mt8sYfhLQ5p0z95ZD06l3DUwuodWEjFByNsa9ScYOTGwa91neOc8lbifGaXmBx6AhK/5pTS8IluX5WnccNASNcXgOOM4my6i1GcAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530026; c=relaxed/simple;
	bh=/SM6hnoDBNO2IGbhZcd1P7w+NACzRK80DOFLnGvAA4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzWqIVRPHbCStVJhKZZCzcQEPCXjLu7+FU3pcvq4La0LZe864jVMEZXjetkaB2n3j65YkM3q6qegOPD6/bR/ms/uIPugis9tlcKbhntDDS4okwulQKjRWwgC9qxO0qJeLudg21vSsryFFETlvruSwYqkPW3yqnwo3QLb3gJBu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I02B9EgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4666C4CED4;
	Wed, 18 Dec 2024 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734530025;
	bh=/SM6hnoDBNO2IGbhZcd1P7w+NACzRK80DOFLnGvAA4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I02B9EgVWE4sLZsmR70M60jFWrusu3ZDZmFJD+z31FYMITf5sVSwR0LR2vjjimAvN
	 tJbqUX7kz6YexYtYhV/m2rbS4ryo69Mws0nhN+KrniYjTyyoLFlEQeD26J4cY3wAuk
	 9GQlx1B2JajujWfeJPxfuP/j2x6VslsawaqdKjoSEuGHObavdU6a19eosze+pphQ6G
	 7tqddFLZOGB+0QPDP0zuaAENxBaCgQaWJ+1zO7FtXhdz3kM3gScnTey7CUUzLN+IlU
	 Z6EFBNjewOxO1PUhAyqxC1xw8Cu0PGLGTuABICYIV7qZIQkZGAQT4+jh6p1pr2o4QC
	 dIwOEbeOP4ZRw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb7e725aa0so2992649b6e.0;
        Wed, 18 Dec 2024 05:53:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVr8sIdbo9FsGBh9+MevdhsAVZp0TFEekM8XO6/aAuL1wuoKYUug4Ehk98Z59yaUKsT0JemUZilOUA=@vger.kernel.org, AJvYcCXObJkkw4B51qTk43U7FFICYss2/ux3wxdwkPtp76JXG8xioPebVWLNCo/nNDEEty0L41rlcbQdjkqIe+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3odTaFYfF0PD8r89VTfVhmfbOZtwvyYTh2qlM4lWVLZCSsesw
	voieyhS7tCWJpOYqt1pwn3wl2+XJywZYHBTjR5NSyWrg1rU9KicQX4yzOoJWvpGWMB0cXEUy+vP
	aTFRC3z1L+nMNZR4DITJ1gCA/Ogg=
X-Google-Smtp-Source: AGHT+IFVXOmRokjmy0FKtoVcuNGIQoCr5bn8fmLdqY/tNzSrumVI2JMqsosFTo37RurPC/ZpVWHXj7fG5UiM4TDQFMc=
X-Received: by 2002:a05:6808:15a0:b0:3ea:5880:fe1d with SMTP id
 5614622812f47-3eccc0b329fmr1430835b6e.35.1734530025066; Wed, 18 Dec 2024
 05:53:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216212644.1145122-1-daniel.lezcano@linaro.org>
In-Reply-To: <20241216212644.1145122-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 14:53:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iG+vwuh1OgR1t09kpP=uVBMnoWB6UAA=d6eiq_g_dReQ@mail.gmail.com>
Message-ID: <CAJZ5v0iG+vwuh1OgR1t09kpP=uVBMnoWB6UAA=d6eiq_g_dReQ@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/thresholds: Fix boundaries and detection routine
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, quic_manafm@quicinc.com, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:27=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The current implementation does not work if the thermal zone is
> interrupt driven only.
>
> The boundaries are not correctly checked and computed as it happens
> only when the temperature is increasing or decreasing.
>
> The problem arises because the routine to detect when we cross a
> threshold is correlated with the computation of the boundaries. We
> assume we have to recompute the boundaries when a threshold is crossed
> but actually we should do that even if the it is not the case.
>
> Mixing the boundaries computation and the threshold detection for the
> sake of optimizing the routine is much more complex as it appears
> intuitively and prone to errors.
>
> This fix separates the boundaries computation and the threshold
> crossing detection into different routines. The result is a code much
> more simple to understand, thus easier to maintain.
>
> The drawback is we browse the thresholds list several time but we can
> consider that as neglictible because that happens when the temperature
> is updated. There are certainly some aeras to improve in the
> temperature update routine but it would be not adequate as this change
> aims to fix the thresholds for v6.13.
>
> Fixes: 445936f9e258 ("thermal: core: Add user thresholds support")
> Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # rock5b, Lenovo x1=
3s
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   -V2: Fix the conditions for the temperature crossing the way down
> ---
>  drivers/thermal/thermal_thresholds.c | 68 +++++++++++++++-------------
>  1 file changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/therm=
al_thresholds.c
> index d9b2a0bb44fc..38f5fd0e8930 100644
> --- a/drivers/thermal/thermal_thresholds.c
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -69,58 +69,60 @@ static struct user_threshold *__thermal_thresholds_fi=
nd(const struct list_head *
>         return NULL;
>  }
>
> -static bool __thermal_threshold_is_crossed(struct user_threshold *thresh=
old, int temperature,
> -                                          int last_temperature, int dire=
ction,
> -                                          int *low, int *high)
> +static bool thermal_thresholds_handle_raising(struct list_head *threshol=
ds, int temperature,
> +                                             int last_temperature)
>  {
> +       struct user_threshold *t;
>
> -       if (temperature >=3D threshold->temperature) {
> -               if (threshold->temperature > *low &&
> -                   THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
> -                       *low =3D threshold->temperature;
> +       list_for_each_entry(t, thresholds, list_node) {
>
> -               if (last_temperature < threshold->temperature &&
> -                   threshold->direction & direction)
> -                       return true;
> -       } else {
> -               if (threshold->temperature < *high && THERMAL_THRESHOLD_W=
AY_UP
> -                   & threshold->direction)
> -                       *high =3D threshold->temperature;
> +               if (!(t->direction & THERMAL_THRESHOLD_WAY_UP))
> +                   continue;
>
> -               if (last_temperature >=3D threshold->temperature &&
> -                   threshold->direction & direction)
> +               if (temperature >=3D t->temperature &&
> +                   last_temperature < t->temperature)
>                         return true;
>         }
>
>         return false;
>  }
>
> -static bool thermal_thresholds_handle_raising(struct list_head *threshol=
ds, int temperature,
> -                                             int last_temperature, int *=
low, int *high)
> +static bool thermal_thresholds_handle_dropping(struct list_head *thresho=
lds, int temperature,
> +                                              int last_temperature)
>  {
>         struct user_threshold *t;
>
> -       list_for_each_entry(t, thresholds, list_node) {
> -               if (__thermal_threshold_is_crossed(t, temperature, last_t=
emperature,
> -                                                  THERMAL_THRESHOLD_WAY_=
UP, low, high))
> +       list_for_each_entry_reverse(t, thresholds, list_node) {
> +
> +               if (!(t->direction & THERMAL_THRESHOLD_WAY_DOWN))
> +                   continue;
> +
> +               if (temperature <=3D t->temperature &&
> +                   last_temperature > t->temperature)
>                         return true;
>         }
>
>         return false;
>  }
>
> -static bool thermal_thresholds_handle_dropping(struct list_head *thresho=
lds, int temperature,
> -                                              int last_temperature, int =
*low, int *high)
> +static void thermal_threshold_find_boundaries(struct list_head *threshol=
ds, int temperature,
> +                                             int *low, int *high)
>  {
>         struct user_threshold *t;
>
> -       list_for_each_entry_reverse(t, thresholds, list_node) {
> -               if (__thermal_threshold_is_crossed(t, temperature, last_t=
emperature,
> -                                                  THERMAL_THRESHOLD_WAY_=
DOWN, low, high))
> -                       return true;
> +       list_for_each_entry(t, thresholds, list_node) {
> +               if (temperature < t->temperature &&
> +                   (t->direction & THERMAL_THRESHOLD_WAY_UP) &&
> +                   *high > t->temperature)
> +                       *high =3D t->temperature;
>         }
>
> -       return false;
> +       list_for_each_entry_reverse(t, thresholds, list_node) {
> +               if (temperature > t->temperature &&
> +                   (t->direction & THERMAL_THRESHOLD_WAY_DOWN) &&
> +                   *low < t->temperature)
> +                       *low =3D t->temperature;
> +       }
>  }
>
>  void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low,=
 int *high)
> @@ -132,6 +134,8 @@ void thermal_thresholds_handle(struct thermal_zone_de=
vice *tz, int *low, int *hi
>
>         lockdep_assert_held(&tz->lock);
>
> +       thermal_threshold_find_boundaries(thresholds, temperature, low, h=
igh);
> +
>         /*
>          * We need a second update in order to detect a threshold being c=
rossed
>          */
> @@ -151,12 +155,12 @@ void thermal_thresholds_handle(struct thermal_zone_=
device *tz, int *low, int *hi
>          * - decreased : thresholds are crossed the way down
>          */
>         if (temperature > last_temperature) {
> -               if (thermal_thresholds_handle_raising(thresholds, tempera=
ture,
> -                                                     last_temperature, l=
ow, high))
> +               if (thermal_thresholds_handle_raising(thresholds,
> +                                                     temperature, last_t=
emperature))
>                         thermal_notify_threshold_up(tz);
>         } else {
> -               if (thermal_thresholds_handle_dropping(thresholds, temper=
ature,
> -                                                      last_temperature, =
low, high))
> +               if (thermal_thresholds_handle_dropping(thresholds,
> +                                                      temperature, last_=
temperature))
>                         thermal_notify_threshold_down(tz);
>         }
>  }
> --

Applied as 6.13-rc material, thanks!

