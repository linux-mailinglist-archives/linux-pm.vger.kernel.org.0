Return-Path: <linux-pm+bounces-12655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2F95A59C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F351C203DC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BD166F24;
	Wed, 21 Aug 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Deg9Y7lM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBA1D12F4
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270724; cv=none; b=IfIGcQzv2BjUG7pM1+0P3WjZoDEN7qhjlJ46RKeF+u1vfhisXUOGRL2CgicfcchHm2NUw6ay6xzByurZeYZazTjK0CVtJDUYF2/txIAgxaeJiqLRPm+ce/i7JDW7LnttR+BJQsxrKEG0koXx/8Q2h2mKp0Tksq8e+Peozhnqxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270724; c=relaxed/simple;
	bh=ntcGuqUSEx6SXrYPP56Q4ZUgqZbTpAjcOMMZPhotnvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd3S/E13Wx4vLFEQz/gR3dBItO6y4eTin5dzTibODdaUX4VO/NyIS75t0nuH4uu/eKzq/8X7FxnPpmpYb3X28GSte99bscoJ2AdVq9hqefEgINjhAwW0fCC0QTJAhV6+FDPQrY1OlKc9EdEJt0mIPXkhLUvsvDpsJQci7smEvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Deg9Y7lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F7C4AF10
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 20:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724270724;
	bh=ntcGuqUSEx6SXrYPP56Q4ZUgqZbTpAjcOMMZPhotnvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Deg9Y7lMspge6/dU5WY1IRG8G8exorfzjCy1VlGU7Df3nIL6jvzN0mzJBg94Qwi3W
	 zaQG6PRzBtNRv/oS9uf1+Hn+p7KrJ58yWHjRvZjWhRJfLIp1Zv1YvU50Czgb8siw2z
	 WFVtrUhbq47XJS7a8d7r+i5iYnV1bsa/dnFqp4WgFKCcOdGgPI5dTxfZbFymyF3Rs9
	 7ScGVg3+qbMbSnZLTe3SKm/XmZbkuUqvqkVnn519AQijkBHwgbJQP728OykqgA+jpZ
	 fWd1cxY++YVdw5vqPV/6LvhzjnsU17daFj6eGqPzyzHPlHfSf+znGNzYY6bbJMqvdY
	 mk6ECHoEBixUA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2705d31a35cso54768fac.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:05:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdr7Ui1qgoUNZxCI+ahvF7NzpAkgi8xVxSvD9QytEuapmKMMDLqeA7ZmmkW/rWAceoTTtxWZUOnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XSit+VlD+W+LuKHFCSBjJoDRxVfgSu+yHQFblEwvD4UwKHiC
	nApPXBi5V0PPMfKfmqez5uCwKF7yDVzcPFRWbAdbvZzFWBx/UeH59ATl7KWuzljpshauOAZIW3F
	jJK8yVMH4Tt5KdvLfThilMt+4poc=
X-Google-Smtp-Source: AGHT+IGuRUnzhz2R4Csn1WHMgT6AI8/fH84s74OtoGxDjlZqJkTlwdT+R33VHxSVLkgIbPS6DpNK0oEX/xgMc3w2twM=
X-Received: by 2002:a05:6871:b2c:b0:261:1f7d:cf70 with SMTP id
 586e51a60fabf-2738be52df6mr3187508fac.36.1724270723573; Wed, 21 Aug 2024
 13:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org> <20240816081241.1925221-3-daniel.lezcano@linaro.org>
In-Reply-To: <20240816081241.1925221-3-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 22:05:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
Message-ID: <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] thermal/core: Add thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:12=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The trip points are a firmware description of the temperature limits
> of a specific thermal zone where we associate an action which is done
> by the kernel. The time resolution is low.
>
> The userspace has to deal with a more complex thermal management based
> on heuristics from different information coming from different
> places. The logic is much more complex but based on a bigger time
> resolution, usually one second based.
>
> The purpose of the userspace is to monitor the temperatures from
> different places and take actions. However, it can not be constantly
> reading the temperature to detect when a temperature threshold has
> been reached. This is especially bad for mobile or embedded system as
> that will lead to an unacceptable number of wakeup to check the
> temperature with nothing to do.
>
> On the other side, the sensors are now most of the time interrupt
> driven. That means the thermal framework will use the temperature trip
> points to program the sensor to trigger an interrupt when a
> temperature limit is crossed.
>
> Unfortunately, the userspace can not benefit this feature and current
> solutions found here and there, iow out-of-tree, are to add fake trip
> points in the firmware and enable the writable trip points.
>
> This is bad for different reasons, the trip points are for in-kernel
> actions, the semantic of their types is used by the thermal framework
> and by adding trip points in the device tree is a way to overcome the
> current limitation but tampering with how the thermal framework is
> supposed to work. The writable trip points is a way to adjust a
> temperature limit given a specific platform if the firmware is not
> accurate enough and TBH it is more a debug feature from my POV.
>
> The thresholds mechanism is a way to have the userspace to tell
> thermal framework to send a notification when a temperature limit is
> crossed. There is no id, no hysteresis, just the temperature and the
> direction of the limit crossing. That means we can be notified when a
> threshold is crossed the way up only, or the way down only or both
> ways. That allows to create hysteresis values if it is needed.
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

The above seems to be an exact copy of the first part of the cover letter.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig              |  15 ++
>  drivers/thermal/Makefile             |   3 +
>  drivers/thermal/thermal_core.h       |   4 +
>  drivers/thermal/thermal_thresholds.c | 241 +++++++++++++++++++++++++++
>  drivers/thermal/thermal_thresholds.h |  57 +++++++
>  include/linux/thermal.h              |   3 +
>  6 files changed, 323 insertions(+)
>  create mode 100644 drivers/thermal/thermal_thresholds.c
>  create mode 100644 drivers/thermal/thermal_thresholds.h
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index ed16897584b4..84f9643678d6 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -40,6 +40,21 @@ config THERMAL_DEBUGFS
>           Say Y to allow the thermal subsystem to collect diagnostic
>           information that can be accessed via debugfs.
>
> +config THERMAL_THRESHOLDS
> +       bool "Thermal thresholds notification mechanism"
> +       depends on THERMAL_NETLINK
> +       help
> +         The userspace implements thermal engines which needs to get
> +         notified when temperature thresholds are crossed the way up
> +         and down. These notification allow them to analyze the
> +         thermal situation of the platform and take decision to
> +         fulfill specific thermal profile like 'balanced',
> +         'performance' or 'power saving'. In addition, the
> +         temperature of the skin sensor is very important in this
> +         case and must be monitored as well.
> +
> +         If in doubt, say Y
> +

I'm not sure if this needs an additional user-selectable Kconfig
option.  It is not modular anyway and not so big, and distros don't
like user-selectable Kconfig options.

>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>         int "Emergency poweroff delay in milli-seconds"
>         default 0
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index ce7a4752ef52..3b991b1a7db4 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -7,6 +7,9 @@ obj-$(CONFIG_THERMAL)           +=3D thermal_sys.o
>  thermal_sys-y                  +=3D thermal_core.o thermal_sysfs.o
>  thermal_sys-y                  +=3D thermal_trip.o thermal_helpers.o
>
> +# thermal thresholds
> +thermal_sys-$(CONFIG_THERMAL_THRESHOLDS)       +=3D thermal_thresholds.o
> +
>  # netlink interface to manage the thermal framework
>  thermal_sys-$(CONFIG_THERMAL_NETLINK)          +=3D thermal_netlink.o
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index 67a09f90eb95..0742c0f03d46 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -13,6 +13,7 @@
>  #include <linux/thermal.h>
>
>  #include "thermal_netlink.h"
> +#include "thermal_thresholds.h"
>  #include "thermal_debugfs.h"
>
>  struct thermal_trip_desc {
> @@ -132,6 +133,9 @@ struct thermal_zone_device {
>         bool resuming;
>  #ifdef CONFIG_THERMAL_DEBUGFS
>         struct thermal_debugfs *debugfs;
> +#endif
> +#ifdef CONFIG_THERMAL_THRESHOLDS
> +       struct thresholds *thresholds;

Why does it need to be a pointer?

I would just use a plain struct list_head for it anyway.

Also, as stated in my reply to the cover letter, I would prefer to
clearly distinguish these thresholds from trip thresholds, so I would
call this user_thresholds.

>  #endif
>         struct thermal_trip_desc trips[] __counted_by(num_trips);
>  };
> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/therm=
al_thresholds.c
> new file mode 100644
> index 000000000000..0241b468cfbd
> --- /dev/null
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -0,0 +1,241 @@
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

+#include "thermal_thresholds.h"

> +
> +struct thresholds {
> +       struct list_head list;
> +};

This duplicates the definition in the header file.

Besides, why is the wrapper struct needed?

> +
> +int thermal_thresholds_init(struct thermal_zone_device *tz)
> +{
> +       struct thresholds *thresholds;
> +
> +       thresholds =3D kmalloc(sizeof(*thresholds), GFP_KERNEL);
> +       if (!thresholds)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&thresholds->list);
> +       tz->thresholds =3D thresholds;
> +
> +       return 0;
> +}

I'd rather embed "thresholds" in struct thermal_zone_device and avoid
allocating memory separately for it.  Less code, less complexity.

> +
> +void thermal_thresholds_exit(struct thermal_zone_device *tz)
> +{
> +       thermal_thresholds_flush(tz);
> +       kfree(tz->thresholds);
> +       tz->thresholds =3D NULL;
> +}
> +
> +static int __thermal_thresholds_cmp(void *data,
> +                                   const struct list_head *l1,
> +                                   const struct list_head *l2)
> +{
> +       struct threshold *t1 =3D container_of(l1, struct threshold, list)=
;
> +       struct threshold *t2 =3D container_of(l2, struct threshold, list)=
;
> +
> +       return t1->temperature - t2->temperature;
> +}
> +
> +static struct threshold *__thermal_thresholds_find(const struct threshol=
ds *thresholds, int temperature)
> +{
> +       struct threshold *t;
> +
> +       list_for_each_entry(t, &thresholds->list, list)
> +               if (t->temperature =3D=3D temperature)
> +                       return t;
> +
> +       return NULL;
> +}
> +
> +static bool __thermal_threshold_is_crossed(struct threshold *threshold, =
int temperature,
> +                                          int last_temperature, int dire=
ction,
> +                                          int *low, int *high)
> +{
> +       if (temperature > threshold->temperature && threshold->temperatur=
e > *low &&
> +           (THERMAL_THRESHOLD_WAY_DOWN & threshold->direction))
> +               *low =3D threshold->temperature;
> +
> +       if (temperature < threshold->temperature && threshold->temperatur=
e < *high &&
> +           (THERMAL_THRESHOLD_WAY_UP & threshold->direction))
> +               *high =3D threshold->temperature;
> +
> +       if (temperature < threshold->temperature &&
> +           last_temperature >=3D threshold->temperature &&
> +           (threshold->direction & direction))
> +               return true;
> +
> +       if (temperature >=3D threshold->temperature &&
> +           last_temperature < threshold->temperature &&
> +           (threshold->direction & direction))
> +               return true;

I would combine the checks, so something like this

if (temperature >=3D threshold->temperature) {
        if (threshold->temperature > *low &&
THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
                *low =3D threshold->temperature;

        if (last_temperature < threshold->temperature &&
threshold->direction & direction)
                return true;
} else {
        if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
& threshold->direction)
              *high =3D threshold->temperature;

        if (last_temperature >=3D threshold->temperature &&
threshold->direction & direction)
                return true;
}

> +
> +       return false;
> +}
> +
> +static bool thermal_thresholds_handle_raising(struct thresholds *thresho=
lds, int temperature,
> +                                             int last_temperature, int *=
low, int *high)
> +{
> +       struct threshold *t;
> +
> +       list_for_each_entry(t, &thresholds->list, list) {
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
> +static bool thermal_thresholds_handle_dropping(struct thresholds *thresh=
olds, int temperature,
> +                                              int last_temperature, int =
*low, int *high)
> +{
> +       struct threshold *t;
> +
> +       list_for_each_entry_reverse(t, &thresholds->list, list) {
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
> +void thermal_thresholds_flush(struct thermal_zone_device *tz)
> +{
> +       struct thresholds *thresholds =3D tz->thresholds;
> +       struct threshold *entry, *tmp;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       list_for_each_entry_safe(entry, tmp, &thresholds->list, list) {
> +               list_del(&entry->list);
> +               kfree(entry);
> +       }
> +
> +       __thermal_zone_device_update(tz, THERMAL_THRESHOLD_FLUSHED);
> +}

I'd move the function above before thermal_thresholds_exit() which
uses it.  Having it here is somewhat confusing.

> +
> +int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, =
int *high)

This function doesn't return anything other than 0 AFAICS.  Make it void?

> +{
> +       struct thresholds *thresholds =3D tz->thresholds;
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
> +               return 0;

So user space won't get notified when tz->temperature is above some
thresholds the first time this runs.  Fair enough, but won't they be
confused by subsequent notifications that will not cover some
thresholds?

> +
> +       /*
> +        * The temperature is stable, so obviously we can not have
> +        * crossed a threshold.
> +        */
> +       if (last_temperature =3D=3D temperature)
> +               return 0;
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
> +
> +       return 0;
> +}
> +
> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction)
> +{
> +       struct thresholds *thresholds =3D tz->thresholds;

So IMO it would be cleaner to just put "thresholds" into struct
thermal_zone_device directly as a struct list_head because the above
wouldn't be needed then.

> +       struct threshold *t;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       t =3D __thermal_thresholds_find(thresholds, temperature);
> +       if (t) {
> +               if (t->direction =3D=3D direction)
> +                       return -EEXIST;

Why is it useful to return an error here?

> +
> +               t->direction |=3D direction;
> +       } else {
> +
> +               t =3D kmalloc(sizeof(*t), GFP_KERNEL);
> +               if (!t)
> +                       return -ENOMEM;
> +
> +               INIT_LIST_HEAD(&t->list);
> +               t->temperature =3D temperature;
> +               t->direction =3D direction;
> +               list_add(&t->list, &thresholds->list);
> +               list_sort(NULL, &thresholds->list, __thermal_thresholds_c=
mp);

And the above would become

+        list_add(&t->list, &tz->thresholds);
+        list_sort(NULL, &tz->thresholdst, __thermal_thresholds_cmp);

And analogously below.

> +       }
> +
> +       __thermal_zone_device_update(tz, THERMAL_THRESHOLD_ADDED);
> +
> +       return 0;
> +}
> +
> +int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction)
> +{
> +       struct thresholds *thresholds =3D tz->thresholds;
> +       struct threshold *t;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       t =3D __thermal_thresholds_find(thresholds, temperature);
> +       if (!t)
> +               return -ENOENT;
> +
> +       if (t->direction =3D=3D direction) {
> +               list_del(&t->list);
> +               kfree(t);
> +       } else {
> +               t->direction &=3D ~direction;
> +       }
> +
> +       __thermal_zone_device_update(tz, THERMAL_THRESHOLD_DELETED);
> +
> +       return 0;
> +}
> +
> +int thermal_thresholds_for_each(struct thermal_zone_device *tz,
> +                               int (*cb)(struct threshold *, void *arg),=
 void *arg)
> +{
> +       struct thresholds *thresholds =3D tz->thresholds;
> +       struct threshold *entry;
> +       int ret;
> +
> +       lockdep_assert_held(&tz->lock);
> +
> +       list_for_each_entry(entry, &thresholds->list, list) {
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
> index 000000000000..7c8ce150d6d0
> --- /dev/null
> +++ b/drivers/thermal/thermal_thresholds.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define THERMAL_THRESHOLD_WAY_UP   BIT(0)
> +#define THERMAL_THRESHOLD_WAY_DOWN BIT(1)
> +
> +struct threshold {
> +       int temperature;
> +       int direction;
> +       struct list_head list;
> +};

IMO it would be better to put the list field at the top for better
alignment and such.  I would also call it something like list_node.

And I'd call this struct user_threshold as a whole (as per the
previous remarks about the naming).

> +
> +#ifdef CONFIG_THERMAL_THRESHOLDS
> +int thermal_thresholds_init(struct thermal_zone_device *tz);
> +void thermal_thresholds_exit(struct thermal_zone_device *tz);
> +void thermal_thresholds_flush(struct thermal_zone_device *tz);
> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction);
> +int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction);
> +int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, =
int *high);
> +int thermal_thresholds_for_each(struct thermal_zone_device *tz,
> +                               int (*cb)(struct threshold *, void *arg),=
 void *arg);
> +#else
> +static inline int thermal_thresholds_init(struct thermal_zone_device *tz=
)
> +{
> +       return 0;
> +}
> +
> +static inline void thermal_thresholds_exit(struct thermal_zone_device *t=
z)
> +{
> +       ;
> +}
> +
> +static inline void thermal_thresholds_flush(struct thermal_zone_device *=
tz)
> +{
> +       ;
> +}
> +
> +static inline int thermal_thresholds_add(struct thermal_zone_device *tz,=
 int temperature, int direction)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_thresholds_delete(struct thermal_zone_device *=
tz, int temperature, int direction)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_thresholds_handle(struct thermal_zone_device *=
tz, int *low, int *high)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_thresholds_for_each(struct thermal_zone_device=
 *tz,
> +                                             int (*cb)(struct threshold =
*, void *arg), void *arg)
> +{
> +       return 0;
> +}
> +#endif
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 25fbf960b474..bf0b4a8218f6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -55,6 +55,9 @@ enum thermal_notify_event {
>         THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone =
*/
>         THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal=
 zone */
>         THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight chang=
ed */

There is an additional item here in the mainline (THERMAL_TZ_RESUME).

> +       THERMAL_THRESHOLD_ADDED, /* Threshold added */
> +       THERMAL_THRESHOLD_DELETED, /* Threshold deleted */
> +       THERMAL_THRESHOLD_FLUSHED, /* All thresholds deleted */

I'd add "TZ" to these names, eg. THERMAL_TZ_THRESHOLD_ADDED, or even
THERMAL_TZ_ADD_THRESHOLD in analogy with the cdev events above.

And THERMAL_TZ_FLUSH_THRESHOLDS sounds more like proper English to me. ;-)

>  };
>
>  /**
> --

