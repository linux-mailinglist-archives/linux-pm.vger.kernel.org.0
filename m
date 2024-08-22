Return-Path: <linux-pm+bounces-12773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A504A95BF69
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF1C1F23F33
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C214A4E0;
	Thu, 22 Aug 2024 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/GnUiGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5876E611
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357382; cv=none; b=EhYWuD0nPJSjgcVuAvmTundhYRy4cIfQKibQqkA13YKTcCYop+HJtT6O4uUHzTPduCczfP1JU18GLMp1yHVLcIauvaVFgDlbNat+24B8yw+x/VoCIV1SL2QG3jOg1rzlfJCwezRLRIpXzzTKuFzXC+WJnwEN+gZK80z/XbMBJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357382; c=relaxed/simple;
	bh=VizJr9xRpzFHnX7U2ZvBfO7hGW7fOQWBdPJ7PZVkHl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzjztYJy0SXq5WmnO3ISK1bTeQl/IPNrxd6egYNnffoMZFRFWuxwivPBBDgsIGptbh9F9Qfl4ae379NL0KSsVOT+sD2XP3nnqkmswA4sFiTsLcK28oXxPWCkSTtXxlA7HsTVU/6mJrD3KjINHCRDVBk4XRNsoFaV+zuP75RDViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/GnUiGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE68FC32782
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724357381;
	bh=VizJr9xRpzFHnX7U2ZvBfO7hGW7fOQWBdPJ7PZVkHl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n/GnUiGQOljBFA2BVGiixNLZoU6IfO5sQwPbvMKz8uiNn38sgAbwnXyYbV3e120Y1
	 Gx/OxK+/g7RZyvILBiEDvTpn9xWGYNG2DIMfpQl9D26rRc2niWfOgF8Xp83fuVqymk
	 IRRpiadI4KDuCL7gKAhudCZXJ4ZyQpTRI0FEeHsc2pW8iKngx7h/cqTe0sTjnw+wLF
	 oasuQFxi+H6+PoVet30S1/YW7vewGBN71qlNi0IOJb5+h0PnXGaW6ky0wyXvTj2PwX
	 UqSQpeNtjK9QPBXSaICDfXNGL6MJXes1yBOeebfmcmyBdq+4wG5NrabNCv3RNpgziO
	 sHkThf1FP9xyA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5af7ae388so1195321eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 13:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhTQ2O7UpAMWZZEDWtUjujmKJJXbr7MvNXsjkHq+GSsQy68oVFTmwIaOpZG+ROuF/yHpFkRJVu6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkm0lOV0XdCBN3GTappVxJQWYpr5fJIA0FFogEGNu0ZbOpVLrw
	w0wjn/rVGZGI/C8zLnCpUxGhoTL4c71ErkZt5jGtwXaVnFF/ntlvtJGtiHC0meKe1vMrpdcjHAs
	LwJGIsEByEn/MG6tKBc13MvB6gP8=
X-Google-Smtp-Source: AGHT+IH3t4tmHiSytNBlIk4Ek4meIB5arbHF/XmX5NG3ohB34NMpX/gcWf485apvK8JqbWPBahx2ajWsRBQOILjVejs=
X-Received: by 2002:a05:6870:e9a5:b0:24f:e15a:6536 with SMTP id
 586e51a60fabf-273c8eb216emr1802194fac.18.1724357380454; Thu, 22 Aug 2024
 13:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <20240816081241.1925221-3-daniel.lezcano@linaro.org> <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
 <77c1018e-2cfc-4c14-bd4a-fc2b7bc7c3b4@linaro.org>
In-Reply-To: <77c1018e-2cfc-4c14-bd4a-fc2b7bc7c3b4@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 22:09:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMTiTpuLBHAyo2SH3+9ABoQqaTRFpQ_2uSJ5muNMLnHg@mail.gmail.com>
Message-ID: <CAJZ5v0jMTiTpuLBHAyo2SH3+9ABoQqaTRFpQ_2uSJ5muNMLnHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] thermal/core: Add thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:20=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/08/2024 22:05, Rafael J. Wysocki wrote:
> > On Fri, Aug 16, 2024 at 10:12=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The trip points are a firmware description of the temperature limits
> >> of a specific thermal zone where we associate an action which is done
> >> by the kernel. The time resolution is low.
> >>
> >> The userspace has to deal with a more complex thermal management based
> >> on heuristics from different information coming from different
> >> places. The logic is much more complex but based on a bigger time
> >> resolution, usually one second based.
> >>
> >> The purpose of the userspace is to monitor the temperatures from
> >> different places and take actions. However, it can not be constantly
> >> reading the temperature to detect when a temperature threshold has
> >> been reached. This is especially bad for mobile or embedded system as
> >> that will lead to an unacceptable number of wakeup to check the
> >> temperature with nothing to do.
> >>
> >> On the other side, the sensors are now most of the time interrupt
> >> driven. That means the thermal framework will use the temperature trip
> >> points to program the sensor to trigger an interrupt when a
> >> temperature limit is crossed.
> >>
> >> Unfortunately, the userspace can not benefit this feature and current
> >> solutions found here and there, iow out-of-tree, are to add fake trip
> >> points in the firmware and enable the writable trip points.
> >>
> >> This is bad for different reasons, the trip points are for in-kernel
> >> actions, the semantic of their types is used by the thermal framework
> >> and by adding trip points in the device tree is a way to overcome the
> >> current limitation but tampering with how the thermal framework is
> >> supposed to work. The writable trip points is a way to adjust a
> >> temperature limit given a specific platform if the firmware is not
> >> accurate enough and TBH it is more a debug feature from my POV.
> >>
> >> The thresholds mechanism is a way to have the userspace to tell
> >> thermal framework to send a notification when a temperature limit is
> >> crossed. There is no id, no hysteresis, just the temperature and the
> >> direction of the limit crossing. That means we can be notified when a
> >> threshold is crossed the way up only, or the way down only or both
> >> ways. That allows to create hysteresis values if it is needed.
> >>
> >> A threshold can be added, deleted or flushed. The latter means all
> >> thresholds belonging to a thermal zone will be deleted.
> >>
> >> When a threshold is added:
> >>
> >>   - if the same threshold (temperature and direction) exists, an error
> >>     is returned
> >>
> >>   - if a threshold is specified with the same temperature but a
> >>     different direction, the specified direction is added
> >>
> >>   - if there is no threshold with the same temperature then it is
> >>     created
> >>
> >> When a threshold is deleted:
> >>
> >>   - if the same threshold (temperature and direction) exists, it is
> >>     deleted
> >>
> >>   - if a threshold is specified with the same temperature but a
> >>     different direction, the specified direction is removed
> >>
> >>   - if there is no threshold with the same temperature, then an error
> >>     is returned
> >>
> >> When the threshold are flushed:
> >>
> >>   - All thresholds related to a thermal zone are deleted
> >>
> >> When a threshold is crossed:
> >>
> >>   - the userspace does not need to know which threshold(s) have been
> >>     crossed, it will be notified with the current temperature and the
> >>     previous temperature
> >>
> >>   - if multiple thresholds have been crossed between two updates only
> >>     one notification will be send to the userspace, it is pointless to
> >>     send a notification per thresholds crossed as the userspace can
> >>     handle that easily when it has the temperature delta information
> >
> > The above seems to be an exact copy of the first part of the cover lett=
er.
>
> Yes, it is done on purpose as it is the commit bringing the feature. I
> thought it is convenient for the developer to read the description of
> the commit introducing the feature.

I agree, but then you could just say "refer to the changelog of the
first patch for details" in the cover letter.

> [ ... ]
>
> >> +config THERMAL_THRESHOLDS
> >> +       bool "Thermal thresholds notification mechanism"
> >> +       depends on THERMAL_NETLINK
> >> +       help
> >> +         The userspace implements thermal engines which needs to get
> >> +         notified when temperature thresholds are crossed the way up
> >> +         and down. These notification allow them to analyze the
> >> +         thermal situation of the platform and take decision to
> >> +         fulfill specific thermal profile like 'balanced',
> >> +         'performance' or 'power saving'. In addition, the
> >> +         temperature of the skin sensor is very important in this
> >> +         case and must be monitored as well.
> >> +
> >> +         If in doubt, say Y
> >> +
> >
> > I'm not sure if this needs an additional user-selectable Kconfig
> > option.  It is not modular anyway and not so big, and distros don't
> > like user-selectable Kconfig options.
>
> Ok, I can drop the user selectable option.
>
> [ ... ]
>
> >> +#endif
> >> +#ifdef CONFIG_THERMAL_THRESHOLDS
> >> +       struct thresholds *thresholds;
> >
> > Why does it need to be a pointer?
> >
> > I would just use a plain struct list_head for it anyway.
> >
> > Also, as stated in my reply to the cover letter, I would prefer to
> > clearly distinguish these thresholds from trip thresholds, so I would
> > call this user_thresholds.
> >
> >>   #endif
> >>          struct thermal_trip_desc trips[] __counted_by(num_trips);
> >>   };
> >> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/th=
ermal_thresholds.c
> >> new file mode 100644
> >> index 000000000000..0241b468cfbd
> >> --- /dev/null
> >> +++ b/drivers/thermal/thermal_thresholds.c
> >> @@ -0,0 +1,241 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright 2024 Linaro Limited
> >> + *
> >> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> + *
> >> + * Thermal thresholds
> >> + */
> >> +#include <linux/list.h>
> >> +#include <linux/list_sort.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include "thermal_core.h"
> >
> > +#include "thermal_thresholds.h"
> >
> >> +
> >> +struct thresholds {
> >> +       struct list_head list;
> >> +};
> >
> > This duplicates the definition in the header file.
>
> No actually it is plural.
>
> struct threshold;
> struct thresholds;

I saw the first one, but for some reason I thought the other was there
too, sorry.

But this means that it is missing from thermal_core.h where it is used
in the struct thermal_zone_device definition.

> > Besides, why is the wrapper struct needed?
>
> Because I think the threshold will continue to evolve.

Fair enough, like I said here:

https://lore.kernel.org/linux-pm/CAJZ5v0h=3DDgBSiFbdmnzSFjEJd6sdBffCODspxmM=
-G92FN2HGiA@mail.gmail.com/

> So instead of
> dealing with lists, we use a dedicated structure. In case we add new
> fields or we change the list by something else the functions prototypes
> are untouched. It is my way of coding in order to always set the scene
> for future changes.
>
> >> +int thermal_thresholds_init(struct thermal_zone_device *tz)
> >> +{
> >> +       struct thresholds *thresholds;
> >> +
> >> +       thresholds =3D kmalloc(sizeof(*thresholds), GFP_KERNEL);
> >> +       if (!thresholds)
> >> +               return -ENOMEM;
> >> +
> >> +       INIT_LIST_HEAD(&thresholds->list);
> >> +       tz->thresholds =3D thresholds;
> >> +
> >> +       return 0;
> >> +}
> >
> > I'd rather embed "thresholds" in struct thermal_zone_device and avoid
> > allocating memory separately for it.  Less code, less complexity.
>
> Ok
>
> >> +static bool __thermal_threshold_is_crossed(struct threshold *threshol=
d, int temperature,
> >> +                                          int last_temperature, int d=
irection,
> >> +                                          int *low, int *high)
> >> +{
> >> +       if (temperature > threshold->temperature && threshold->tempera=
ture > *low &&
> >> +           (THERMAL_THRESHOLD_WAY_DOWN & threshold->direction))
> >> +               *low =3D threshold->temperature;
> >> +
> >> +       if (temperature < threshold->temperature && threshold->tempera=
ture < *high &&
> >> +           (THERMAL_THRESHOLD_WAY_UP & threshold->direction))
> >> +               *high =3D threshold->temperature;
> >> +
> >> +       if (temperature < threshold->temperature &&
> >> +           last_temperature >=3D threshold->temperature &&
> >> +           (threshold->direction & direction))
> >> +               return true;
> >> +
> >> +       if (temperature >=3D threshold->temperature &&
> >> +           last_temperature < threshold->temperature &&
> >> +           (threshold->direction & direction))
> >> +               return true;
> >
> > I would combine the checks, so something like this
> >
> > if (temperature >=3D threshold->temperature) {
> >          if (threshold->temperature > *low &&
> > THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
> >                  *low =3D threshold->temperature;
> >          if (last_temperature < threshold->temperature &&
> > threshold->direction & direction)
> >                  return true;
> > } else {
> >          if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
> > & threshold->direction)
> >                *high =3D threshold->temperature;
> >
> >          if (last_temperature >=3D threshold->temperature &&
> > threshold->direction & direction)
> >                  return true;
> > }
>
> Ok
>
> [ ... ]
>
> >> +void thermal_thresholds_flush(struct thermal_zone_device *tz)
> >> +{
> >> +       struct thresholds *thresholds =3D tz->thresholds;
> >> +       struct threshold *entry, *tmp;
> >> +
> >> +       lockdep_assert_held(&tz->lock);
> >> +
> >> +       list_for_each_entry_safe(entry, tmp, &thresholds->list, list) =
{
> >> +               list_del(&entry->list);
> >> +               kfree(entry);
> >> +       }
> >> +
> >> +       __thermal_zone_device_update(tz, THERMAL_THRESHOLD_FLUSHED);
> >> +}
> >
> > I'd move the function above before thermal_thresholds_exit() which
> > uses it.  Having it here is somewhat confusing.
>
> Sure
>
> >> +
> >> +int thermal_thresholds_handle(struct thermal_zone_device *tz, int *lo=
w, int *high)
> >
> > This function doesn't return anything other than 0 AFAICS.  Make it voi=
d?
>
> Ok
>
> >> +{
> >> +       struct thresholds *thresholds =3D tz->thresholds;
> >> +
> >> +       int temperature =3D tz->temperature;
> >> +       int last_temperature =3D tz->last_temperature;
> >> +       bool notify;
> >> +
> >> +       lockdep_assert_held(&tz->lock);
> >> +
> >> +       /*
> >> +        * We need a second update in order to detect a threshold bein=
g crossed
> >> +        */
> >> +       if (last_temperature =3D=3D THERMAL_TEMP_INVALID)
> >> +               return 0;
> >
> > So user space won't get notified when tz->temperature is above some
> > thresholds the first time this runs.  Fair enough, but won't they be
> > confused by subsequent notifications that will not cover some
> > thresholds?
>
> It is unlikely to happen.
>
> When the thermal zone is created and enabled, it updates the temperature
> of the thermal zone so tz->temperature is no longer THERMAL_TEMP_INVALID.
>
> At this step, there is no userspace set yet.
>
> Assuming there is zero update until we create a threshold. When this one
> is created then the thermal zone is updated, the temperature is read,
> the tz->last_temperature =3D tz->temperature and tz->temperature has the
> new value. Then handle_thresholds is called and finally set_trips
>
> If the temperature is above or below a threshold then it is detected and
> notified because tz->last_temperature is not equal to THERMAL_TEMP_INVALI=
D.
>
> Others situations are IMO resulting from a bogus driver/sensor and
> should be handled at the sensor level, not the core code.
>
> [ ... ]
>
> >> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temper=
ature, int direction)
> >> +{
> >> +       struct thresholds *thresholds =3D tz->thresholds;
> >
> > So IMO it would be cleaner to just put "thresholds" into struct
> > thermal_zone_device directly as a struct list_head because the above
> > wouldn't be needed then.
>
> I can change that to list directly but if we add anything (which can
> probably happen) then the API change as well as anything below again.

But it can be

 #ifdef CONFIG_THERMAL_DEBUGFS
     struct thermal_debugfs *debugfs;
 #endif
+   struct thresholds thresholds;
     struct thermal_trip_desc trips[] __counted_by(num_trips);
 };

> >> +       struct threshold *t;
> >> +
> >> +       lockdep_assert_held(&tz->lock);
> >> +
> >> +       t =3D __thermal_thresholds_find(thresholds, temperature);
> >> +       if (t) {
> >> +               if (t->direction =3D=3D direction)
> >> +                       return -EEXIST;
> >
> > Why is it useful to return an error here?
>
> I was expecting this comment :)
>
> We have the choice between :
>   * we do nothing
>   * we return an error
>
> Let's assume the userspace is misbehaving and because of an internal bug
> of a thermal engine it creates multiple times the same threshold (eg.
> index not incremented, etc ...). If the kernel reports nothing, then the
> user space will never detect this problem. If it reports the error the
> user space can choose to ignore it or follow it up.
>
> The kernel is strict and it is up to the user space to ignore it or not.

Well, I'm not sure.

IMO it will just cause user space code to be more complex in some
valid use cases, but whatever.

