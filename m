Return-Path: <linux-pm+bounces-12715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92B95B3D9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 13:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00D31C22EF4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13391C8FC9;
	Thu, 22 Aug 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKrveZOh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57C1836D5
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326225; cv=none; b=YUOdYgg0zXViTaMzwHVNJM5uiXi0nYtTillkGNNA7sxXyOS/zQtVOF4Mv8odVwvfugKTWmy+AYe228MJt2WHhcBhw0GSAmy4ftf9vnw1qGL59mdIHX5C8N4LV5fIqj/jc4W4oqnu3iHXdtiSQ0lZReYaIIINUooUNIsYyxXnF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326225; c=relaxed/simple;
	bh=b7pQe5okhvL0o1YKBycfCakJN7rb+c0+xQvK8NC8DP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlSSHcI6r7ukQs/cTMShX5oMIBsOqmT3wmbfpl5FIfYFlorzgZv/g27iNLGGIwtXfXsz7xXdmAWIOOtGXcdtPX/tjigOaNcx+Vv4chIjDlybL+xfauIZqJNdX5fMMvLeW2Wh+kQjZMYBuyLqe/Palq/cpve0xua9IkzBFzJhLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKrveZOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D222C4AF0C
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724326225;
	bh=b7pQe5okhvL0o1YKBycfCakJN7rb+c0+xQvK8NC8DP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KKrveZOhjG3j24+V6Nl4YuMmJB6k51Z1KVZkCASCrB3tGQDsB3NhtPD5nWPH/AIQZ
	 EIo5ZrmzaTUPNNDAAmaocQkkLM++IyDusCMN2CmERGtTFhOcLNj+MLNOUGMrC4Y/Xd
	 SQxREvbzrJOIdVJgI6yEsMiOA4WvYGHl6n4JYI75oqv1/2ybTNI0rz7FFUsbPCUhgh
	 VuiwPNuaNSaRowncxApOM7f7+M6uc1iAKP4Oa8yKGngUSr7/+FN9Yy6RHm3eRzkjGt
	 J7uBbrVbWGwvNv0u6IP7lRTb0GbzEBb9FIgIGL0jNghm8cDIIl3T8L4d4rotHAqdKL
	 Gfu66SIdbvC6Q==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d608060241so459037eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 04:30:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZXVsnkWVNFXl2iBWHe7MMtHV6PFTA9B2Y6b1QxvbRMLZmLjrW
	bvb756D/QOg+VWjbQ8x+OnGcm5YPH2iUmBp1HrzDan4qe0hH5CweoDGz23XaS8R3jsUvyAzcaZn
	P/KND7fPiB7fcN8hGPorL4IzMy5E=
X-Google-Smtp-Source: AGHT+IFKGCNT6PHRjZ5PEDYcemKQQwXN/1A+VmXRZHAIzCbtzLQF9bJHQGNnBnCOVwTvU1NbUYPtgoe2LoPG6LJhy+4=
X-Received: by 2002:a05:6870:4996:b0:270:463e:4b72 with SMTP id
 586e51a60fabf-2737ef1d5ccmr5674375fac.20.1724326224821; Thu, 22 Aug 2024
 04:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <20240816081241.1925221-3-daniel.lezcano@linaro.org> <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 13:30:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=DgBSiFbdmnzSFjEJd6sdBffCODspxmM-G92FN2HGiA@mail.gmail.com>
Message-ID: <CAJZ5v0h=DgBSiFbdmnzSFjEJd6sdBffCODspxmM-G92FN2HGiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] thermal/core: Add thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Fri, Aug 16, 2024 at 10:12=E2=80=AFAM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:

[cut]

> > --- /dev/null
> > +++ b/drivers/thermal/thermal_thresholds.c
> > @@ -0,0 +1,241 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2024 Linaro Limited
> > + *
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *
> > + * Thermal thresholds
> > + */
> > +#include <linux/list.h>
> > +#include <linux/list_sort.h>
> > +#include <linux/slab.h>
> > +
> > +#include "thermal_core.h"
>
> +#include "thermal_thresholds.h"
>
> > +
> > +struct thresholds {
> > +       struct list_head list;
> > +};
>
> This duplicates the definition in the header file.
>
> Besides, why is the wrapper struct needed?

On second thought, it can hold a pointer to the first threshold that
was strictly above the zone temperature when
thermal_thresholds_handle() ran last time, so something like:

struct thresholds {
      struct list_head list;
      struct user_threhold *first_above;
};

and first_above =3D=3D NULL would mean that the zone temperature was above
all of the threshold or at the highest one.

Then thermal_thresholds_handle() could do something like:

tr =3D tz->user_thresholds.first_above;

if (tr && tz->temperature >=3D tr->temperature) {
    do {
        if (tr->direction & THERMAL_THRESHOLD_WAY_UP)
            notify =3D true;

        if (tr->list_node.next !=3D &tz->user_thresholds.list) {
            tr =3D list_next_entry(tr, list_node);
        else
            tr =3D NULL;
    } while (tr && tz->temperature >=3D tr->temperature);
} else {
    if (!tr)
        tr =3D list_last_entry(&tz->user_thresholds.list,
                     struct user_threshold, list_node);

    while (tz->temperature < tr->temperature)
        if (tr->direction & THERMAL_THRESHOLD_WAY_DOWN)
            notify =3D true;

        if (tr->list_node.prev !=3D &tz->user_thresholds.list) {
            tr =3D list_prev_entry(tr, list_node);
        else
            break;
    }
    if (tz->temperature >=3D tr->temperature)
        tr =3D NULL;
}
tz->user_thresholds.first_above =3D tr;

which is a bit simpler than the code in the current patch.

> > +
> > +int thermal_thresholds_init(struct thermal_zone_device *tz)
> > +{
> > +       struct thresholds *thresholds;
> > +
> > +       thresholds =3D kmalloc(sizeof(*thresholds), GFP_KERNEL);
> > +       if (!thresholds)
> > +               return -ENOMEM;
> > +
> > +       INIT_LIST_HEAD(&thresholds->list);
> > +       tz->thresholds =3D thresholds;
> > +
> > +       return 0;
> > +}
>
> I'd rather embed "thresholds" in struct thermal_zone_device and avoid
> allocating memory separately for it.  Less code, less complexity.
>
> > +
> > +void thermal_thresholds_exit(struct thermal_zone_device *tz)
> > +{
> > +       thermal_thresholds_flush(tz);
> > +       kfree(tz->thresholds);
> > +       tz->thresholds =3D NULL;
> > +}
> > +
> > +static int __thermal_thresholds_cmp(void *data,
> > +                                   const struct list_head *l1,
> > +                                   const struct list_head *l2)
> > +{
> > +       struct threshold *t1 =3D container_of(l1, struct threshold, lis=
t);
> > +       struct threshold *t2 =3D container_of(l2, struct threshold, lis=
t);
> > +
> > +       return t1->temperature - t2->temperature;
> > +}
> > +
> > +static struct threshold *__thermal_thresholds_find(const struct thresh=
olds *thresholds, int temperature)
> > +{
> > +       struct threshold *t;
> > +
> > +       list_for_each_entry(t, &thresholds->list, list)
> > +               if (t->temperature =3D=3D temperature)
> > +                       return t;
> > +
> > +       return NULL;
> > +}
> > +
> > +static bool __thermal_threshold_is_crossed(struct threshold *threshold=
, int temperature,
> > +                                          int last_temperature, int di=
rection,
> > +                                          int *low, int *high)
> > +{
> > +       if (temperature > threshold->temperature && threshold->temperat=
ure > *low &&
> > +           (THERMAL_THRESHOLD_WAY_DOWN & threshold->direction))
> > +               *low =3D threshold->temperature;
> > +
> > +       if (temperature < threshold->temperature && threshold->temperat=
ure < *high &&
> > +           (THERMAL_THRESHOLD_WAY_UP & threshold->direction))
> > +               *high =3D threshold->temperature;
> > +
> > +       if (temperature < threshold->temperature &&
> > +           last_temperature >=3D threshold->temperature &&
> > +           (threshold->direction & direction))
> > +               return true;
> > +
> > +       if (temperature >=3D threshold->temperature &&
> > +           last_temperature < threshold->temperature &&
> > +           (threshold->direction & direction))
> > +               return true;
>
> I would combine the checks, so something like this
>
> if (temperature >=3D threshold->temperature) {
>         if (threshold->temperature > *low &&
> THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
>                 *low =3D threshold->temperature;
>
>         if (last_temperature < threshold->temperature &&
> threshold->direction & direction)
>                 return true;
> } else {
>         if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
> & threshold->direction)
>               *high =3D threshold->temperature;
>
>         if (last_temperature >=3D threshold->temperature &&
> threshold->direction & direction)
>                 return true;
> }

Also, I'm not sure why "high" and "low" are needed at all.

The current and last zone temperature could be included in the
notification just fine and user space should be able to figure out
which thresholds are affected.

> > +
> > +       return false;
> > +}
> > +

