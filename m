Return-Path: <linux-pm+bounces-12651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6495A4D1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06A5B21216
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1581B2503;
	Wed, 21 Aug 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMTru04H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458771D131A;
	Wed, 21 Aug 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265726; cv=none; b=qKRwvzsO2mVYGGuy1MQI4NC0lhjJzEKpdviQndyKWQW7L57iGtjDXjCmJTM3uEV8V3Yp/inTz/4n/ZNcCEM2tt/8pcZ2z7s6tN5gyGAAay1pdGaefUJbHAJQVCCwMvh5IYWeJN/+HCNYvo1PPqPgF2D+Ca3A6xc4F4YHqSssYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265726; c=relaxed/simple;
	bh=PCzwycnQ68FnAihEnpURA+cP62Lf4j+4rNmVTJmIjzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBpFVhTAAdw1Lm48GrxM2Z4LYihpMZkY10/9veAsexJ3wkwnjA86vtsabT8w4L4ecmOD2gnAYnkNyHUW4/ndvfg845FOz/uMahFF5Lh2ibyYUKc/MC1YTCb6/fwvDZMayv3gE1a7mV8iQ0g/0Wkswi2SA1jAZHGEioA8Of218n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMTru04H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3799C4AF0E;
	Wed, 21 Aug 2024 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724265725;
	bh=PCzwycnQ68FnAihEnpURA+cP62Lf4j+4rNmVTJmIjzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iMTru04Hh9bmSxfYycLcitK89VnZw7FwF+aOGrDjyUP3OZTk67uc8Fjje7iFru/qf
	 gr/uqCPceHKigAxBJXGUl6ZrD+Ty+5JVmqdSPmTEYsWAmcidQoaRUL9hVejwHGKZzz
	 VIoL0HMolbaJ5jKP9Dw4mjTat+aWB6CkIt9OJxgI9cJXYTPrse4dHq1sFtegrbNlCe
	 XnXYBfY1IRnApi8t1tdP0WFUukgnIOVf/dd07biUlqg54YI+VGTCC2qJHH1QqYRGP0
	 zNu077cWAg/2G0wIuBAD2z4ZXTWh0hu7uz94fqKqkQx0Gnw8g/3OxFwHpkYJLAx4yy
	 hWYJcUh8IkxHw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2704d461058so2506331fac.0;
        Wed, 21 Aug 2024 11:42:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYNL8n9I897/+Hy/ctH/kc7YJSo3hASf0LRHnAr6jwp+ApPyWL+Nl6VxxUTC8noPgQg8W+z7pA/SxnFGQ=@vger.kernel.org, AJvYcCUtJjupyZ23PIF38klrBJIOH7tM2bcNs3d8J/8u9QVqt693gsatwiJl0eO5nDups9mGjBYhd/S1+Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiyDKxn+naomccf7IvzV/3Vok0f8QgZT4iWCTn/OFzNZr0uyE
	JJgSM9cbEAH0u/a4SpD8k6WhD13uAkyxjaBGzkfGgDg7YU3+uh8+/Rijx4B4Wq35zCQ51rjui3l
	KVqnogG08Ur2y/y8pGLBU3Hex8A4=
X-Google-Smtp-Source: AGHT+IEW4+QE6jrLQfnnAK8xiews+yZgmyZbloPzgNPMruNN0gbTIxN27K0jnMMaCJdrg6m9IzsJwkIVaBFLM3L+2/Q=
X-Received: by 2002:a05:6870:b52a:b0:270:2691:5ad5 with SMTP id
 586e51a60fabf-2737eeaa528mr3732322fac.7.1724265725130; Wed, 21 Aug 2024
 11:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821075934.12145-1-11162571@vivo.com>
In-Reply-To: <20240821075934.12145-1-11162571@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 20:41:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jLaZqbJw-DXjFD983sW0j_adrGjK5U97h49+9bh28e=w@mail.gmail.com>
Message-ID: <CAJZ5v0jLaZqbJw-DXjFD983sW0j_adrGjK5U97h49+9bh28e=w@mail.gmail.com>
Subject: Re: [PATCH v1] drivers:thermal:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
To: Yang Ruibin <11162571@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:59=E2=80=AFAM Yang Ruibin <11162571@vivo.com> wro=
te:
>
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/thermal/thermal_debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index 7dd67bf48571..939d3e5f1817 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -178,11 +178,11 @@ struct thermal_debugfs {
>  void thermal_debug_init(void)
>  {
>         d_root =3D debugfs_create_dir("thermal", NULL);
> -       if (!d_root)
> +       if (IS_ERR(d_root))
>                 return;
>
>         d_cdev =3D debugfs_create_dir("cooling_devices", d_root);
> -       if (!d_cdev)
> +       if (IS_ERR(d_cdev))
>                 return;
>
>         d_tz =3D debugfs_create_dir("thermal_zones", d_root);
> @@ -202,7 +202,7 @@ static struct thermal_debugfs *thermal_debugfs_add_id=
(struct dentry *d, int id)
>         snprintf(ids, IDSLENGTH, "%d", id);
>
>         thermal_dbg->d_top =3D debugfs_create_dir(ids, d);
> -       if (!thermal_dbg->d_top) {
> +       if (IS_ERR(thermal_dbg->d_top)) {
>                 kfree(thermal_dbg);
>                 return NULL;
>         }
> --

Good catch!

Applied as 6.11-rc material with some edits in the subject and changelog.

Thanks!

