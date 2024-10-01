Return-Path: <linux-pm+bounces-15033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518C98C65A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 21:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA6B2150D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B51CDA3F;
	Tue,  1 Oct 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7cBuxqd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415821DFCB
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812683; cv=none; b=DFH6daTExZsVjHNQ2U8shFfHQe/ObrQQp5/YcK9AlWQnnJs4XZ5fvd7u+3BSThEGi/ysCpl3LMmEYfmQgvuPl5ZiEy3PCNv5e1IKw8imUnMKyDe/neq0+4V4HL2+Ev6bT9/kuWoHQzCv2Bu5htQ2RH/C+A15Q0hcb+yeH6VkurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812683; c=relaxed/simple;
	bh=FBt6Ty7CS8B7VKN97HEhTC8VVZm/DMvoDr2u7lG8L9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V18kIkrCCubdXBxz6N5QO+ddjh3uH5SRBKSrqjhTCKR8UwYZA9GZtEocHLLJUAF4PW7LfA52Wfc6wpeqNUtFNui0PyDW7coLwBWpicJN/RmrkLw9COewwdc4QDVqghzO/8bR7MUcdAJdH4eSyA+aP/vuegm5MN2nQmg0xAvEN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7cBuxqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FC1C4CECD
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727812682;
	bh=FBt6Ty7CS8B7VKN97HEhTC8VVZm/DMvoDr2u7lG8L9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s7cBuxqd2YcvMpIqcIMzu2A8oqm2Kv6PplFu9gnXjhDMyXIkkQBESaUBES4hjMptg
	 GfjNXO2PH+3ap+Sw2G5OeU3vzUHh99+BwT1ERI4CMVOIpQyXpI3xxdzArFWk4sxmbH
	 FbYqxEqS3NqMrPfVQCYGK96/XrpNy1y2czvNBLhvZtP/4j4OhJvNUGyXNzLsQB6gFo
	 lYOkq3YOYfTgfYLt66OkZymHdjjgVn/RwgURQhtTk4q2ceBZbLlpvan/zsBj24mjnX
	 jirfP/Jeg6McG9GY9lLPcB0hEukIlC3JvuWxobARB7ZVOKRcM41E99kue+qdqm1KYo
	 aWUeH9tRff5Ew==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1baf317c7so2508304eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2024 12:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWycbPKmy5I4NldzJijzZr0Cdmfd91Sh3HnJv7TA6QPvXVkOu88e5xkHTSWBo8Egr2e26E1sAr0kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6RWh+ARkzeynh0YbItlNwJ7CZeiMEouMI9e9cJI8ybD1gzvE
	8WliFdn992vRO//dWYdAGqWkkSVTEDWFUQiTVexQ61sG5ZMpjdsEcNTpz/Xj18tz4DOY5NieGhN
	kVNCczcIWfvrjZOQPqJcJyVq1ot0=
X-Google-Smtp-Source: AGHT+IE7HbbFmuz+20BlKbaHJ7SIotNBUG0Lx70cRQScRmB3RBRs9b5WuRCfUcXDvQ4WGuoF9W95vaYKD231VGwvKEU=
X-Received: by 2002:a4a:ee0c:0:b0:5e1:efda:3991 with SMTP id
 006d021491bc7-5e7b1bf6e38mr981755eaf.0.1727812681975; Tue, 01 Oct 2024
 12:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org> <20240923100005.2532430-2-daniel.lezcano@linaro.org>
In-Reply-To: <20240923100005.2532430-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Oct 2024 21:57:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9N_ie_duMXYSumQSnFDVxHj1h1ikSyrApJyEjXs_mQg@mail.gmail.com>
Message-ID: <CAJZ5v0i9N_ie_duMXYSumQSnFDVxHj1h1ikSyrApJyEjXs_mQg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] thermal/core: Add user thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:00=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The user thresholds mechanism is a way to have the userspace to tell
> the thermal framework to send a notification when a temperature limit
> is crossed. There is no id, no hysteresis, just the temperature and
> the direction of the limit crossing. That means we can be notified
> when a threshold is crossed the way up only, or the way down only or
> both ways. That allows to create hysteresis values if it is needed.
>
> A threshold can be added, deleted or flushed. The latter means all
> thresholds belonging to a thermal zone will be deleted.
>
> When a threshold is added:
>
>  - if the same threshold (temperature and direction) exists, an error
>    is returned
>
>  - if a threshold is specified with the same temperature but a
>    different direction, the specified direction is added
>
>  - if there is no threshold with the same temperature then it is
>    created
>
> When a threshold is deleted:
>
>  - if the same threshold (temperature and direction) exists, it is
>    deleted
>
>  - if a threshold is specified with the same temperature but a
>    different direction, the specified direction is removed
>
>  - if there is no threshold with the same temperature, then an error
>    is returned
>
> When the threshold are flushed:
>
>  - All thresholds related to a thermal zone are deleted
>
> When a threshold is crossed:
>
>  - the userspace does not need to know which threshold(s) have been
>    crossed, it will be notified with the current temperature and the
>    previous temperature
>
>  - if multiple thresholds have been crossed between two updates only
>    one notification will be send to the userspace, it is pointless to
>    send a notification per thresholds crossed as the userspace can
>    handle that easily when it has the temperature delta information
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Makefile             |   1 +
>  drivers/thermal/thermal_core.h       |   2 +
>  drivers/thermal/thermal_thresholds.c | 229 +++++++++++++++++++++++++++
>  drivers/thermal/thermal_thresholds.h |  19 +++
>  include/linux/thermal.h              |   3 +
>  include/uapi/linux/thermal.h         |   2 +
>  6 files changed, 256 insertions(+)
>  create mode 100644 drivers/thermal/thermal_thresholds.c
>  create mode 100644 drivers/thermal/thermal_thresholds.h
>
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 41c4d56beb40..1e1559bb971e 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -6,6 +6,7 @@ CFLAGS_thermal_core.o           :=3D -I$(src)
>  obj-$(CONFIG_THERMAL)          +=3D thermal_sys.o
>  thermal_sys-y                  +=3D thermal_core.o thermal_sysfs.o
>  thermal_sys-y                  +=3D thermal_trip.o thermal_helpers.o
> +thermal_sys-y                  +=3D thermal_thresholds.o
>
>  # netlink interface to manage the thermal framework
>  thermal_sys-$(CONFIG_THERMAL_NETLINK)          +=3D thermal_netlink.o
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 50b858aa173a..8f320d17d927 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -13,6 +13,7 @@
>  #include <linux/thermal.h>
>
>  #include "thermal_netlink.h"
> +#include "thermal_thresholds.h"
>  #include "thermal_debugfs.h"
>
>  struct thermal_attr {
> @@ -139,6 +140,7 @@ struct thermal_zone_device {
>  #ifdef CONFIG_THERMAL_DEBUGFS
>         struct thermal_debugfs *debugfs;
>  #endif
> +       struct list_head user_thresholds;
>         struct thermal_trip_desc trips[] __counted_by(num_trips);
>  };
>
> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/therm=
al_thresholds.c
> new file mode 100644
> index 000000000000..f33b6d5474d8
> --- /dev/null
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2024 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * Thermal thresholds
> + */
> +#include <linux/list.h>
> +#include <linux/list_sort.h>
> +#include <linux/slab.h>
> +
> +#include "thermal_core.h"
> +#include "thermal_thresholds.h"
> +
> +int thermal_thresholds_init(struct thermal_zone_device *tz)
> +{
> +       INIT_LIST_HEAD(&tz->user_thresholds);
> +
> +       return 0;
> +}
> +
> +void thermal_thresholds_flush(struct thermal_zone_device *tz)
> +{
> +       struct list_head *thresholds =3D &tz->user_thresholds;
> +       struct user_threshold *entry, *tmp;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       list_for_each_entry_safe(entry, tmp, thresholds, list_node) {
> +               list_del(&entry->list_node);
> +               kfree(entry);
> +       }
> +
> +       __thermal_zone_device_update(tz, THERMAL_TZ_FLUSH_THRESHOLDS);
> +}
> +
> +void thermal_thresholds_exit(struct thermal_zone_device *tz)
> +{
> +       thermal_thresholds_flush(tz);
> +}
> +
> +static int __thermal_thresholds_cmp(void *data,
> +                                   const struct list_head *l1,
> +                                   const struct list_head *l2)
> +{
> +       struct user_threshold *t1 =3D container_of(l1, struct user_thresh=
old, list_node);
> +       struct user_threshold *t2 =3D container_of(l2, struct user_thresh=
old, list_node);
> +
> +       return t1->temperature - t2->temperature;
> +}
> +
> +static struct user_threshold *__thermal_thresholds_find(const struct lis=
t_head *thresholds,
> +                                                       int temperature)
> +{
> +       struct user_threshold *t;
> +
> +       list_for_each_entry(t, thresholds, list_node)
> +               if (t->temperature =3D=3D temperature)
> +                       return t;
> +
> +       return NULL;
> +}
> +
> +static bool __thermal_threshold_is_crossed(struct user_threshold *thresh=
old, int temperature,
> +                                          int last_temperature, int dire=
ction,
> +                                          int *low, int *high)
> +{
> +
> +       if (temperature >=3D threshold->temperature) {
> +               if (threshold->temperature > *low &&
> +                   THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
> +                       *low =3D threshold->temperature;
> +
> +               if (last_temperature < threshold->temperature &&
> +                   threshold->direction & direction)
> +                       return true;
> +       } else {
> +               if (threshold->temperature < *high && THERMAL_THRESHOLD_W=
AY_UP
> +                   & threshold->direction)
> +                       *high =3D threshold->temperature;
> +
> +               if (last_temperature >=3D threshold->temperature &&
> +                   threshold->direction & direction)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool thermal_thresholds_handle_raising(struct list_head *threshol=
ds, int temperature,
> +                                             int last_temperature, int *=
low, int *high)
> +{
> +       struct user_threshold *t;
> +
> +       list_for_each_entry(t, thresholds, list_node) {
> +               if (__thermal_threshold_is_crossed(t, temperature, last_t=
emperature,
> +                                                  THERMAL_THRESHOLD_WAY_=
UP, low, high))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool thermal_thresholds_handle_dropping(struct list_head *thresho=
lds, int temperature,
> +                                              int last_temperature, int =
*low, int *high)
> +{
> +       struct user_threshold *t;
> +
> +       list_for_each_entry_reverse(t, thresholds, list_node) {
> +               if (__thermal_threshold_is_crossed(t, temperature, last_t=
emperature,
> +                                                  THERMAL_THRESHOLD_WAY_=
DOWN, low, high))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low,=
 int *high)
> +{
> +       struct list_head *thresholds =3D &tz->user_thresholds;
> +
> +       int temperature =3D tz->temperature;
> +       int last_temperature =3D tz->last_temperature;
> +       bool notify;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       /*
> +        * We need a second update in order to detect a threshold being c=
rossed
> +        */
> +       if (last_temperature =3D=3D THERMAL_TEMP_INVALID)
> +               return;
> +
> +       /*
> +        * The temperature is stable, so obviously we can not have
> +        * crossed a threshold.
> +        */
> +       if (last_temperature =3D=3D temperature)
> +               return;
> +
> +       /*
> +        * Since last update the temperature:
> +        * - increased : thresholds are crossed the way up
> +        * - decreased : thresholds are crossed the way down
> +        */
> +       if (temperature > last_temperature)
> +               notify =3D thermal_thresholds_handle_raising(thresholds, =
temperature,
> +                                                          last_temperatu=
re, low, high);
> +       else
> +               notify =3D thermal_thresholds_handle_dropping(thresholds,=
 temperature,
> +                                                           last_temperat=
ure, low, high);
> +
> +       if (notify)
> +               pr_debug("A threshold has been crossed the way %s, with a=
 temperature=3D%d, last_temperature=3D%d\n",
> +                        temperature > last_temperature ? "up" : "down", =
temperature, last_temperature);
> +}
> +
> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction)
> +{
> +       struct list_head *thresholds =3D &tz->user_thresholds;
> +       struct user_threshold *t;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       t =3D __thermal_thresholds_find(thresholds, temperature);
> +       if (t) {
> +               if (t->direction =3D=3D direction)
> +                       return -EEXIST;
> +
> +               t->direction |=3D direction;
> +       } else {
> +
> +               t =3D kmalloc(sizeof(*t), GFP_KERNEL);
> +               if (!t)
> +                       return -ENOMEM;
> +
> +               INIT_LIST_HEAD(&t->list_node);
> +               t->temperature =3D temperature;
> +               t->direction =3D direction;
> +               list_add(&t->list_node, thresholds);
> +               list_sort(NULL, thresholds, __thermal_thresholds_cmp);
> +       }
> +
> +       __thermal_zone_device_update(tz, THERMAL_TZ_ADD_THRESHOLD);
> +
> +       return 0;
> +}
> +
> +int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction)
> +{
> +       struct list_head *thresholds =3D &tz->user_thresholds;
> +       struct user_threshold *t;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       t =3D __thermal_thresholds_find(thresholds, temperature);
> +       if (!t)
> +               return -ENOENT;
> +
> +       if (t->direction =3D=3D direction) {
> +               list_del(&t->list_node);
> +               kfree(t);
> +       } else {
> +               t->direction &=3D ~direction;
> +       }
> +
> +       __thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
> +
> +       return 0;
> +}
> +
> +int thermal_thresholds_for_each(struct thermal_zone_device *tz,
> +                               int (*cb)(struct user_threshold *, void *=
arg), void *arg)
> +{
> +       struct list_head *thresholds =3D &tz->user_thresholds;
> +       struct user_threshold *entry;
> +       int ret;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       list_for_each_entry(entry, thresholds, list_node) {
> +               ret =3D cb(entry, arg);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/therm=
al_thresholds.h
> new file mode 100644
> index 000000000000..232f4e8089af
> --- /dev/null
> +++ b/drivers/thermal/thermal_thresholds.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __THERMAL_THRESHOLDS_H__
> +#define __THERMAL_THRESHOLDS_H__
> +
> +struct user_threshold {
> +       struct list_head list_node;
> +       int temperature;
> +       int direction;
> +};
> +
> +int thermal_thresholds_init(struct thermal_zone_device *tz);
> +void thermal_thresholds_exit(struct thermal_zone_device *tz);
> +void thermal_thresholds_flush(struct thermal_zone_device *tz);
> +void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low,=
 int *high);
> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction);
> +int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction);
> +int thermal_thresholds_for_each(struct thermal_zone_device *tz,
> +                               int (*cb)(struct user_threshold *, void *=
arg), void *arg);
> +#endif
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 25ea8fe2313e..bcaa92732e14 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -56,6 +56,9 @@ enum thermal_notify_event {
>         THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal=
 zone */
>         THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight chang=
ed */
>         THERMAL_TZ_RESUME, /* Thermal zone is resuming after system sleep=
 */
> +       THERMAL_TZ_ADD_THRESHOLD, /* Threshold added */
> +       THERMAL_TZ_DEL_THRESHOLD, /* Threshold deleted */
> +       THERMAL_TZ_FLUSH_THRESHOLDS, /* All thresholds deleted */
>  };
>
>  /**
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index fc78bf3aead7..3e7c1c2e71a7 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -3,6 +3,8 @@
>  #define _UAPI_LINUX_THERMAL_H
>
>  #define THERMAL_NAME_LENGTH    20
> +#define THERMAL_THRESHOLD_WAY_UP       0x1
> +#define THERMAL_THRESHOLD_WAY_DOWN     0x2

It would be somewhat better to use BIT(0) and BIT(1) here IMO, but
apart from that this patch and patch [2/6] are fine with me (even
though my implementation of threshold crossing detection would be
different).

I still have questions regarding patch [3/6] though, but I'll need to
take a fresh look at it tomorrow.

>
>  enum thermal_device_mode {
>         THERMAL_DEVICE_DISABLED =3D 0,
> --
> 2.43.0
>

