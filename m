Return-Path: <linux-pm+bounces-12354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E228954821
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 13:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC00E1F232BA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688113C695;
	Fri, 16 Aug 2024 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="execNs4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D841AC8B9
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808099; cv=none; b=MIvOk6o1uY0aveekZlCXk1TfR32phT/rUIjRWh+Hzg57zCb8pSd4Lw2D23tN4EF2EhzGVCo3BLAmvFl3Yzgfd/d+mkgIJRDqmDecgaJXVtRmtnO1fkuIOwh3CPBtHUTLJk0L6BcCXF56gAs0qDvMDrRFv4GfTA5c4mAwxKKTDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808099; c=relaxed/simple;
	bh=HQIVWtSjtyfk5glhg+FtS9fE5dX/mTn/TOlArJe0vkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSQe53Y32z8QBWuYfxHAjmL6f9wgahRLGvcBB0GI551qRfRgZFBI6uzXwLe3JX7D8tpeC4qsHuLiXQFr8cdel1sGiEr5a/zRDUJnCAqcGZHhUE1LrM7fuKcROk3UMPPG+0kc+sjMZ/mZqdxjZ8jG0gp/RcZdC0j4Dci+Egapty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=execNs4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663BEC4AF0F
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 11:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723808099;
	bh=HQIVWtSjtyfk5glhg+FtS9fE5dX/mTn/TOlArJe0vkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=execNs4jXkjSn8fseR1YGTUNHGGfoUFC1V3bsFAdSaPFI9sp0wkUwtW4d98cMYIDF
	 t+BRy8unDDBTKknn7gWBgM0TvvYdGe/+QPhuRM60V7EMdtvPpEXZj/GMAzwFKjPfA3
	 zWLzxZX1KDzGHpqL/gXrYXt7MzMjO3Oo1AuFheu+a1RUn3OV1/uvv085tyUhOOkYnA
	 TS7C0G99SNBquWCqvfj5AlVocAOqQ1Tg8I048nQKMQdZnU2+5IVr6xVHlsDwUw7nVF
	 Rp6FOi1rT5xcJM160WrJxutbifv1wp/ldIEUphXwto65gOV0eYhqEUJv7U0AvYyR8c
	 EHuGrSWyW8yfA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so234947fac.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 04:34:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI4QSDNVjDd4GLEmOhjSSYRlAGA8lo6MSDbkq7fdZuSmvRFOo41lwtqVoT4g7CIhHZXM9N+5oKkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznzwZg7eZhuOe0H4guzayAazrBtWXQC8TVYUkwTGOLKWomru8f
	PeSEdemNSpdfFM7koaocVNrq+PNDKkAFEBf6tNXZ7Ff3k2fZmeExd/EJMd+Fr9cog5dh+60geBK
	CbZKJ4EPnXITr87Pd1CGqQVZMONA=
X-Google-Smtp-Source: AGHT+IGd5uFCyJ40GompZ8koHcPD99hGIojQ7eG3zhDuZFKaCMSPq8tGdsMvl7A/We4dGNim2k6Ynm0YFsN/luLWytI=
X-Received: by 2002:a05:6870:71d3:b0:260:df6a:28ca with SMTP id
 586e51a60fabf-2701c50f784mr1670000fac.5.1723808098612; Fri, 16 Aug 2024
 04:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org> <20240816081241.1925221-2-daniel.lezcano@linaro.org>
In-Reply-To: <20240816081241.1925221-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Aug 2024 13:34:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iS+iJBsURzfeipum2ekPfxDGLKrotEkH10_FQhUKvbiA@mail.gmail.com>
Message-ID: <CAJZ5v0iS+iJBsURzfeipum2ekPfxDGLKrotEkH10_FQhUKvbiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] thermal/core: Compute low and high boundaries in thermal_zone_device_update()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:12=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> In order to set the scene for the thresholds support which have to
> manipulate the low and high temperature boundaries for the interrupt
> support, we must pass the low and high values to the incoming
> thresholds routine.
>
> The variables are set from the thermal_zone_set_trips() where the
> function loops the thermal trips to figure out the next and the
> previous temperatures to set the interrupt to be triggered when they
> are crossed.
>
> These variables will be needed by the function in charge of handling
> the thresholds in the incoming changes but they are local to the
> aforementioned function thermal_zone_set_trips().
>
> Move the low and high boundaries computation out of the function in
> thermal_zone_device_update() so they are accessible from there.
>
> The positive side effect is they are computed in the same loop as
> handle_thermal_trip(), so we remove one loop.
>
> Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Looks good to me and I'd like to apply it earlier separately as I have
material depending on it in the works.

> ---
>  drivers/thermal/thermal_core.c | 12 ++++++++++--
>  drivers/thermal/thermal_core.h |  2 +-
>  drivers/thermal/thermal_trip.c | 27 +--------------------------
>  3 files changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 95c399f94744..166f48071487 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -547,6 +547,7 @@ void __thermal_zone_device_update(struct thermal_zone=
_device *tz,
>         struct thermal_trip_desc *td;
>         LIST_HEAD(way_down_list);
>         LIST_HEAD(way_up_list);
> +       int low =3D -INT_MAX, high =3D INT_MAX;
>         int temp, ret;
>
>         if (tz->suspended)
> @@ -580,10 +581,17 @@ void __thermal_zone_device_update(struct thermal_zo=
ne_device *tz,
>
>         tz->notify_event =3D event;
>
> -       for_each_trip_desc(tz, td)
> +       for_each_trip_desc(tz, td) {
>                 handle_thermal_trip(tz, td, &way_up_list, &way_down_list)=
;
>
> -       thermal_zone_set_trips(tz);
> +               if (td->threshold <=3D tz->temperature && td->threshold >=
 low)
> +                       low =3D td->threshold;
> +
> +               if (td->threshold >=3D tz->temperature && td->threshold <=
 high)
> +                       high =3D td->threshold;
> +       }
> +
> +       thermal_zone_set_trips(tz, low, high);
>
>         list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
>         list_for_each_entry(td, &way_up_list, notify_list_node)
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 4cf2b7230d04..67a09f90eb95 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -259,7 +259,7 @@ void thermal_governor_update_tz(struct thermal_zone_d=
evice *tz,
>
>  const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
>
> -void thermal_zone_set_trips(struct thermal_zone_device *tz);
> +void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int=
 high);
>  int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>                          const struct thermal_trip *trip);
>  void thermal_zone_trip_updated(struct thermal_zone_device *tz,
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_tri=
p.c
> index 06a0554ddc38..1d43ab52e86a 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -61,25 +61,8 @@ int thermal_zone_get_num_trips(struct thermal_zone_dev=
ice *tz)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
>
> -/**
> - * thermal_zone_set_trips - Computes the next trip points for the driver
> - * @tz: a pointer to a thermal zone device structure
> - *
> - * The function computes the next temperature boundaries by browsing
> - * the trip points. The result is the closer low and high trip points
> - * to the current temperature. These values are passed to the backend
> - * driver to let it set its own notification mechanism (usually an
> - * interrupt).
> - *
> - * This function must be called with tz->lock held. Both tz and tz->ops
> - * must be valid pointers.
> - *
> - * It does not return a value
> - */
> -void thermal_zone_set_trips(struct thermal_zone_device *tz)
> +void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int=
 high)
>  {
> -       const struct thermal_trip_desc *td;
> -       int low =3D -INT_MAX, high =3D INT_MAX;
>         int ret;
>
>         lockdep_assert_held(&tz->lock);
> @@ -87,14 +70,6 @@ void thermal_zone_set_trips(struct thermal_zone_device=
 *tz)
>         if (!tz->ops.set_trips)
>                 return;
>
> -       for_each_trip_desc(tz, td) {
> -               if (td->threshold <=3D tz->temperature && td->threshold >=
 low)
> -                       low =3D td->threshold;
> -
> -               if (td->threshold >=3D tz->temperature && td->threshold <=
 high)
> -                       high =3D td->threshold;
> -       }
> -
>         /* No need to change trip points */
>         if (tz->prev_low_trip =3D=3D low && tz->prev_high_trip =3D=3D hig=
h)
>                 return;
> --
> 2.43.0
>

