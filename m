Return-Path: <linux-pm+bounces-1013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B0980F5E3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1721C20ACE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFF7F55D;
	Tue, 12 Dec 2023 18:58:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A081101;
	Tue, 12 Dec 2023 10:58:27 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5907e590360so257778eaf.0;
        Tue, 12 Dec 2023 10:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407506; x=1703012306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPYriBv9JdGAxc4g5llpBrr+G3FF3YwLNGYDVmKF1sY=;
        b=c89c5GbTiDwFi2I+mWEQRJOYE392CP/qaGMzJmofbgZQ3bpS7NukbX4L5AvLLQdyDW
         u9hlkqppZxmGWbknnmB+5NAqFEoljFIjcDtpAfSritPC6UZVaLMm/KvMmoxhefVbejmF
         pGTCjdx1MuTNteMFCcaF0buz1/1Xdvcgb0LvRi/Xh38Rrl4T9wl+40Pgk1I73eQwO9kL
         ODekuT+k4gn/mm/3f79fbcP07K9LQseIJ4sk8zsxb8aFnTO2KfJrMtk9DALLAR/N6u2X
         yyxcjAFkd0Cdvkv7/p9dpDiVAgZ4SfM9g+8DokPCfd6iXmup7mRQ3lboMIt9xDt9QXIK
         ERUg==
X-Gm-Message-State: AOJu0YwsxtTvcJeCORYtDm/SsXZTKzMeEIecGS96mUOXQfKiX5T5fFSX
	zFgKjg1GfBYSppOx4L9W55jyC3oJIsqr8Z6mLobOs1cD
X-Google-Smtp-Source: AGHT+IHtz+5DBWpAxTkoaTmokFPX5X69YmTTEjoUWwmlmBR15Sg6PxcmTcFi6La1GF3s62mtKpY8h+Id//85cvT0USU=
X-Received: by 2002:a4a:e9ae:0:b0:591:4861:6b07 with SMTP id
 t14-20020a4ae9ae000000b0059148616b07mr597011ood.0.1702407506285; Tue, 12 Dec
 2023 10:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2709306.mvXUDI8C0e@kreacher>
In-Reply-To: <2709306.mvXUDI8C0e@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 19:58:15 +0100
Message-ID: <CAJZ5v0gjwBcvpDRU+2UbhKZk_u2nXheYKVhpqWDOP=pGfnofaA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Drop redundant __thermal_zone_get_trip()
 header
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:36=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The __thermal_zone_get_trip() header in drivers/thermal/thermal_core.h
> is redundant, because there is one already in thermal.h, so drop it.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

From the lack of comments I gather that this change is fine with
everyone, so I'm going to queue it up for 6.8.

Thanks!

> ---
>  drivers/thermal/thermal_core.h |    2 --
>  1 file changed, 2 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -120,8 +120,6 @@ void __thermal_zone_device_update(struct
>         for (__trip =3D __tz->trips; __trip - __tz->trips < __tz->num_tri=
ps; __trip++)
>
>  void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> -int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> -                           struct thermal_trip *trip);
>  int thermal_zone_trip_id(struct thermal_zone_device *tz,
>                          const struct thermal_trip *trip);
>  void thermal_zone_trip_updated(struct thermal_zone_device *tz,
>
>
>
>

