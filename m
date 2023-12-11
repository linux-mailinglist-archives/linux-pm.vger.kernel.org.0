Return-Path: <linux-pm+bounces-915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81780DBD5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E537281942
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B553E29;
	Mon, 11 Dec 2023 20:42:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14219D6;
	Mon, 11 Dec 2023 12:42:02 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d9f4682c7bso411076a34.1;
        Mon, 11 Dec 2023 12:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327321; x=1702932121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Je421ZZjq5p+OuHl7zbDHQE6QhkT5uZwNBv6r9BGPzY=;
        b=iita/VpqC3r5v966kn4sjgi7dWUOLmmTvSBsEVSmn7/GKxTweQL52THyPt4d6xIOoc
         zibkzQaVfF8PRX4BddC/8/8oHk1kyYURpE3q9c6nR2Ajfgx0Ha4blTcX8RacQztor1A4
         DaGl6Uk6ntbnkXFiKYehCl3qzfo8AZaLRyDxiqzr9aHKzyk7yfaEcG11kU62qx++46IB
         5aB/Ry/FW1fxYZfw04x1eOLG8npu3/SKMo2mcI/1lKavJfy7x61AS0JUubt6LQhMphDE
         ra/7fli7d3btG0Ttg273o4HR0K6N5XZKuu5ej0tARYVQAX1F+EK7+HzMYJ7FyJmc5ZBs
         fBFQ==
X-Gm-Message-State: AOJu0YwXA/Dz5fYErMoNBvE8KXfyOWi4eJ+X1P2RGI0f+YvwZffBN+TC
	yFEuljc/wUynbeJXWSKs/TSJSWX6t3AAy5Lt5bc=
X-Google-Smtp-Source: AGHT+IER1auBCj7n2l4nsZLpRoOiy2A55k+ZFCiloz2G+BKWFIlf6+MzopZkyM3DSBCmOdR+y2XYhX+BH2CmsV8sv7Y=
X-Received: by 2002:a05:6820:2d44:b0:58d:be0d:6f7b with SMTP id
 dz4-20020a0568202d4400b0058dbe0d6f7bmr8522288oob.1.1702327321245; Mon, 11 Dec
 2023 12:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206113138.3576492-1-lukasz.luba@arm.com> <20231206113138.3576492-2-lukasz.luba@arm.com>
In-Reply-To: <20231206113138.3576492-2-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 21:41:50 +0100
Message-ID: <CAJZ5v0goUEmvK57VEB6wdvubssLtzYBnb2HSJsed7VWWLs0s2w@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: core: Add callback for governors with
 cooling instances change
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:30=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Allow governors to react to the changes in the cooling instances list.
> That makes possible to move memory allocations related to the number of
> cooling instances out of the throttle() callback. The throttle() callback
> is called much more often thus the cost of managing allocations there is
> an extra overhead. The list of cooling instances is not changed that ofte=
n
> and it can be handled in dedicated callback. That will save CPU cycles
> in the throttle() code path.  Both callbacks code paths are protected wit=
h
> the same thermal zone lock, which guaranties the list of cooling instance=
s
> is consistent.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

I agree with the direction, but I'm wondering if changes of the
bindings between trip points and cooling devices are the only type of
changes which can affect the IPA.  For instance, what if the trip
point temperatures are updated?

If it needs to react to other types of changes in general, it may be
good to introduce a more general callback that can be made handle them
in the future.

> ---
>  drivers/thermal/thermal_core.c | 14 ++++++++++++++
>  include/linux/thermal.h        |  4 ++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 625ba07cbe2f..c993b86f7fb5 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -314,6 +314,15 @@ static void handle_non_critical_trips(struct thermal=
_zone_device *tz,
>                        def_governor->throttle(tz, trip);
>  }
>
> +static void handle_instances_list_update(struct thermal_zone_device *tz)
> +{
> +
> +       if (!tz->governor || !tz->governor->instances_update)
> +               return;
> +
> +       tz->governor->instances_update(tz);
> +}
> +
>  void thermal_zone_device_critical(struct thermal_zone_device *tz)
>  {
>         /*
> @@ -723,6 +732,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_dev=
ice *tz,
>                 list_add_tail(&dev->tz_node, &tz->thermal_instances);
>                 list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>                 atomic_set(&tz->need_update, 1);
> +
> +               handle_instances_list_update(tz);
>         }
>         mutex_unlock(&cdev->lock);
>         mutex_unlock(&tz->lock);
> @@ -781,6 +792,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone=
_device *tz,
>                 if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cd=
ev =3D=3D cdev) {
>                         list_del(&pos->tz_node);
>                         list_del(&pos->cdev_node);
> +
> +                       handle_instances_list_update(tz);
> +
>                         mutex_unlock(&cdev->lock);
>                         mutex_unlock(&tz->lock);
>                         goto unbind;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c7190e2dfcb4..e7b2a1f4bab0 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -195,6 +195,9 @@ struct thermal_zone_device {
>   *                     thermal zone.
>   * @throttle:  callback called for every trip point even if temperature =
is
>   *             below the trip point temperature
> + * @instances_update:  callback called when thermal zone instances list
> + *     i               has changed (e.g. added new or removed), which
> + *                     may help to offload work for governor like alloca=
tions
>   * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>   */
>  struct thermal_governor {
> @@ -203,6 +206,7 @@ struct thermal_governor {
>         void (*unbind_from_tz)(struct thermal_zone_device *tz);
>         int (*throttle)(struct thermal_zone_device *tz,
>                         const struct thermal_trip *trip);
> +       void (*instances_update)(struct thermal_zone_device *tz);

So this could be more general I think, something like (*update_tz)(),
and it may take an additional argument representing the type of the
change.

>         struct list_head        governor_list;
>  };
>
> --
> 2.25.1
>

