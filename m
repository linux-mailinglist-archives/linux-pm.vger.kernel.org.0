Return-Path: <linux-pm+bounces-11807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01594493E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE761C21400
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA40616F0C6;
	Thu,  1 Aug 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECi9NtrR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15F446A1;
	Thu,  1 Aug 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507843; cv=none; b=VwH2QtJw3VmWluFn43THqA8s/5VKqpwLmVOOnmziJcaSnApf72f0t7cL7v7oei5qQ8VGQFEUha7G61Xu2fSko/NzvGEvgyvriLlREqXJCb+NlXlNu5En85806D9niN7KI1o30F7xjAr5CT3pQKR4s4lkMjxrHIs9JTYS8V5CJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507843; c=relaxed/simple;
	bh=2qqKLa49EvzmM19MRf9Bcfq/xYYI+V8D6kv7dmOhKVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmZR2ZaAmGuvcFmTDddjcUyyT7LrVeRWeDg6BwBsiS4GTzscCO1Yb0X71Mj4R3VK4gIPey/ntGy9HsRgYWrWqZBr4wNGySmbxGT7gk9qtFxiWpY+Z/K5F/kfE/45QNxZhdSETCY6mHGuQ2BPG623y8Lp/mPSDd/DTCywWFSLyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECi9NtrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C8C4AF0E;
	Thu,  1 Aug 2024 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722507843;
	bh=2qqKLa49EvzmM19MRf9Bcfq/xYYI+V8D6kv7dmOhKVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ECi9NtrRXeYu40pM7Jmh/4wt2ajtq7MPUdnzean5RfI3hBLLw/von4XF8eMTiCj/b
	 kcRZie+561VzfExlC6A1o/AQYT7im8AWqGf1CTN+8RdMjTxvHtUOZFPz71so3ZDClc
	 BrObgHuabYbANJ8jpgQF7I3D7FkoE7hYt6nW3XrvKfbQcs6EJ0oIBlPg86TsQZfiNN
	 LR96QFYXWXRefSh5u5l6FuVOLxl612AAkaY1hIzhIGa4+3+9GKk5sSN+G+1ItQHMm1
	 ow0sb6iYdomI+aefOmvne3dTnzxXeFiLMgcZc8xE23Nss1+Dx8nV5Y35mRvjoxWm/g
	 /FBmS3Ax/zk0A==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db3763e924so309075b6e.2;
        Thu, 01 Aug 2024 03:24:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy9TqmrxaIKlz2jiEgpNngXFey/RssqfmzJjS1mWZ/BjwY4T65Z9tXMbc/yHyXZyjXnGsENNtXTw==@vger.kernel.org, AJvYcCVWM0AdqiLbT12hrQT7gpfMNLrnKm2lVCFKEDIZs/xSoYnHPGQjrtqnrTHs31nLUkIRUU+RKS5s@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlEnFuLQRMebU4WYpvDk5YrwtSetTcSCRccI9h5eIN7qIFCWn
	SLQS4d0afJsuiYdEmxzAGEsMaIDA8JzVvnBrcRkhh7XCQZeHl39Ke4utW75IkDmemUUWyUkC3XW
	F9n+HcaHVXmyO2CxAQU3I5AiXSE4=
X-Google-Smtp-Source: AGHT+IFSc0QSvBW/YVrvyVouC9aOFYfVQ5CbvNkJfU37sydbsMcTetupYjsIJy8Su3F3gmHoo8mJXk5LjGMR4RHSaio=
X-Received: by 2002:a05:6871:3329:b0:258:476d:a781 with SMTP id
 586e51a60fabf-2687a3cee76mr1163991fac.3.1722507842262; Thu, 01 Aug 2024
 03:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000834.3930818-1-sashal@kernel.org> <20240801000834.3930818-69-sashal@kernel.org>
In-Reply-To: <20240801000834.3930818-69-sashal@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Aug 2024 12:23:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPDBWZA4zwrnkam=6a5APjviccoEh6gEHEQegpjpnAtA@mail.gmail.com>
Message-ID: <CAJZ5v0hPDBWZA4zwrnkam=6a5APjviccoEh6gEHEQegpjpnAtA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.10 069/121] thermal: trip: Use READ_ONCE() for
 lockless access to trip properties
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:15=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> [ Upstream commit a52641bc6293a24f25956a597e7f32148b0e2bb8 ]
>
> When accessing trip temperature and hysteresis without locking, it is
> better to use READ_ONCE() to prevent compiler optimizations possibly
> affecting the read from being applied.
>
> Of course, for the READ_ONCE() to be effective, WRITE_ONCE() needs to
> be used when updating their values.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is more of a matter of annotation than practical issue.  That's
why I haven't even added a Fixes: tag to it.

Whether or not to take it into "stable" is up to you.  It certainly is
low-risk in any case.

> ---
>  drivers/thermal/thermal_sysfs.c | 6 +++---
>  drivers/thermal/thermal_trip.c  | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 88211ccdfbd62..5be6113e7c80f 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev, struct devic=
e_attribute *attr,
>         if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=3D =
1)
>                 return -EINVAL;
>
> -       return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
> +       return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.tem=
perature));
>  }
>
>  static ssize_t
> @@ -174,7 +174,7 @@ trip_point_hyst_store(struct device *dev, struct devi=
ce_attribute *attr,
>         trip =3D &tz->trips[trip_id].trip;
>
>         if (hyst !=3D trip->hysteresis) {
> -               trip->hysteresis =3D hyst;
> +               WRITE_ONCE(trip->hysteresis, hyst);
>
>                 thermal_zone_trip_updated(tz, trip);
>         }
> @@ -194,7 +194,7 @@ trip_point_hyst_show(struct device *dev, struct devic=
e_attribute *attr,
>         if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) !=3D =
1)
>                 return -EINVAL;
>
> -       return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
> +       return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.hys=
teresis));
>  }
>
>  static ssize_t
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_tri=
p.c
> index 49e63db685172..b4e7411b2fe74 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -152,7 +152,7 @@ void thermal_zone_set_trip_temp(struct thermal_zone_d=
evice *tz,
>         if (trip->temperature =3D=3D temp)
>                 return;
>
> -       trip->temperature =3D temp;
> +       WRITE_ONCE(trip->temperature, temp);
>         thermal_notify_tz_trip_change(tz, trip);
>
>         if (temp =3D=3D THERMAL_TEMP_INVALID) {
> --
> 2.43.0
>

