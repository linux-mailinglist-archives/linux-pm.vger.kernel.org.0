Return-Path: <linux-pm+bounces-10628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A543927B7D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BD21F22980
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0291B373D;
	Thu,  4 Jul 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBGNlt1R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E31B29DA;
	Thu,  4 Jul 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112350; cv=none; b=kFQepEJJ3wZfltXoNIKrVnW790SZ2sBKwx8QLwRyZh5HCjrHLjqTZ8jvNowrxpjeR+TAgylkwbm+xIRCOAKl2AU6e8FfCJe4eEiqQcSEMcR8egkRN0RrLfbgbdP6Vxv4FLphN8NIARVkIqJTUwli375xNykWAxlBBFLbRJLLZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112350; c=relaxed/simple;
	bh=o5p1lL0PiHSWqTkv3oaQrdUom4dwJMspYAsi/YSbyi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbRO+kSZLrX7sXo2Ik4y5rXVxKpeFJyrkyXr/8YH6LyvGCJ6VR2asy6psgGfJPek5mjMr+Dkb7nvFORBsqtxt6TjqEXu9ihOTbJhRafeSwk8msioFkldaSi1zp4ZWxRDUV++IDuOxO5b2fzz8DarzeyoMzizs8nCxji5SHnKJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBGNlt1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB56C4AF0C;
	Thu,  4 Jul 2024 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720112349;
	bh=o5p1lL0PiHSWqTkv3oaQrdUom4dwJMspYAsi/YSbyi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VBGNlt1RsL6qFQXJh2sNYQFFX/jo+Sy6lIHNEHe0hQfPNKVPgzUM/9xnlwate2RfC
	 nniNN3HFjo2UMZi2xxFYLPfWNx+2WiN3Nd+iMc/1ULneNNC9QNqxMw/OOASGZXWpr1
	 T32UawOXvEss8WDGM1o2QgC7wMs2GLDKvTUSofp9r9ZCkS9/oEuarrfI4mQV1u0jzn
	 0Uwsne6zeH4/0UtHRdWQJAHpjyuyKgayGUHfZ+T8Ucjd6f0N8Pik8wusaHDn2nXCNO
	 RQWpz+67jH+15ORCuED574nYgVWxweyxL/YvHp1jEiszmqHVbIVMpiFZczBn4t6yA+
	 A4mMoJ9mzGwKQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c4463b5ebcso10613eaf.2;
        Thu, 04 Jul 2024 09:59:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZgw5W7QnrNAoY2fNlqQ+YxzeLU+yjO/PB11IUBZsie5jSSyfAgaIFHOR5vSFwQlfWjesmwKp35JXLsk3cWvxNEzKZrZDJYCsczxKOsVEks158Tf7QCJ2UfBWQVcx7Vi0CxwM8MNg=
X-Gm-Message-State: AOJu0YyWFj4KNcMl2URkQw9LO1C2l7XzFtes3BMpZTPhZ/RMdiyVkJEg
	jhVfe2Ic6BTLbmESB6sf5VpO+JWaHH6Lp3GLLrzv+xzhGHX14WqlVuLTwHTC99CBq+vPB0sx5S9
	X7yIf3LeBJwsZMTzSxIDb1hv3QdM=
X-Google-Smtp-Source: AGHT+IFbHUxvcKLIdRrGVL2gPG3pYNl93R9hG4g5XOCTZsDsH84f0xgSAPcMdXVQ41sjdojEjwz/SdgvVlTSUJuRcII=
X-Received: by 2002:a05:6820:1f18:b0:5c4:24e0:26cd with SMTP id
 006d021491bc7-5c646ea313fmr2236664eaf.1.1720112348183; Thu, 04 Jul 2024
 09:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
 <CAJZ5v0gRoy0+LD0EgwbS0NL8kHhas4T6itgawGjE8iNf57MOcg@mail.gmail.com> <db358fd0-4163-48c2-b6f2-66c0357fc064@linaro.org>
In-Reply-To: <db358fd0-4163-48c2-b6f2-66c0357fc064@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 18:58:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVLr2+PLXy2Y4pmGtZUOMGPVTpytRDgTTGbKt=Zq_LZA@mail.gmail.com>
Message-ID: <CAJZ5v0iVLr2+PLXy2Y4pmGtZUOMGPVTpytRDgTTGbKt=Zq_LZA@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 6:53=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 04/07/2024 16:21, Rafael J. Wysocki wrote:
> > On Thu, Jul 4, 2024 at 2:49=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> >>
> >> On 04/07/2024 13:46, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip(=
)
> >>> if zone temperature is invalid") caused __thermal_zone_device_update(=
)
> >>> to return early if the current thermal zone temperature was invalid.
> >>>
> >>> This was done to avoid running handle_thermal_trip() and governor
> >>> callbacks in that case which led to confusion.  However, it went too
> >>> far because monitor_thermal_zone() still needs to be called even when
> >>> the zone temperature is invalid to ensure that it will be updated
> >>> eventually in case thermal polling is enabled and the driver has no
> >>> other means to notify the core of zone temperature changes (for examp=
le,
> >>> it does not register an interrupt handler or ACPI notifier).
> >>>
> >>> Also if the .set_trips() zone callback is expected to set up monitori=
ng
> >>> interrupts for a thermal zone, it needs to be provided with valid
> >>> boundaries and that can only be done if the zone temperature is known=
.
> >>>
> >>> Accordingly, to ensure that __thermal_zone_device_update() will
> >>> run again after a failing zone temperature check, make it call
> >>> monitor_thermal_zone() regardless of whether or not the zone
> >>> temperature is valid and make the latter schedule a thermal zone
> >>> temperature update if the zone temperature is invalid even if
> >>> polling is not enabled for the thermal zone (however, if this
> >>> continues to fail, give up after some time).
> >>
> >> Rafael,
> >>
> >> do we agree that we should fix somehow the current issue in this way
> >> because we are close to the merge window,
> >
> > Yes.
> >
> >> but the proper fix is not doing that ?
> >
> > We need to decide what to do in general when __thermal_zone_get_temp()
> > returns an error.  A proper fix would result from that, but it would
> > require more time than is available IMV.  We can properly fix this in
> > 6.11.
>
> Right, in general we should take care of returning values from the
> different functions, update_temperature(), etc... in order to have the
> thermal_zone_device_update() returning a value.
>
> So from there we can catch the result in the initialization function and
> do the proper actions.
>
>  From a higher perspective, IMO the code contains too many returning
> void functions. We should convert that into returning values and handle
> the error cases.
>
> > For 6.10 I see two options:
> >
> > 1. Apply the v2 of this patch:
> >
> > https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net/
> >
> > I slightly prefer it because it is simpler and doesn't change the size
> > of struct thermal_zone_device.
>
> I agree
>
> >  However, the clear disadvantage of it
> > is that it will poke at dead thermal zones indefinitely.
>
> Yes, but the advantage of this disadvantage is it is so visible that
> buggy routine will be brought to the light, so they can be fixed. I
> don't think we should have so many, perhaps none.
>
> > The THERMAL_RECHECK_DELAY_MS value in it can be adjusted.  Maybe 250
> > ms would be a better choice?
>
> Yes
>
> > 2. Apply this patch (ie. v3)
> >
> > It is nicer to thermal zones that never become operational, but it may
> > miss thermal zones that become operational very late.
>
> I would keep this v3 as a backup in case there are too many complaints,
> but I doubt

OK, I'll go for the v2 with THERMAL_RECHECK_DELAY_MS equal to 250 ms.

Thanks!

> >>> Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip(=
) if zone temperature is invalid")
> >>> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd03=
3fca16@linaro.org
> >>> Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.n=
et
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>    drivers/thermal/thermal_core.c |   13 ++++++++++++-
> >>>    drivers/thermal/thermal_core.h |    9 +++++++++
> >>>    2 files changed, 21 insertions(+), 1 deletion(-)
> >>>
> >>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>> @@ -300,6 +300,14 @@ static void monitor_thermal_zone(struct
> >>>                thermal_zone_device_set_polling(tz, tz->passive_delay_=
jiffies);
> >>>        else if (tz->polling_delay_jiffies)
> >>>                thermal_zone_device_set_polling(tz, tz->polling_delay_=
jiffies);
> >>> +     else if (tz->temperature =3D=3D THERMAL_TEMP_INVALID &&
> >>> +              tz->recheck_delay_jiffies <=3D THERMAL_MAX_RECHECK_DEL=
AY) {
> >>> +             thermal_zone_device_set_polling(tz, tz->recheck_delay_j=
iffies);
> >>> +             /* Double the recheck delay for the next attempt. */
> >>> +             tz->recheck_delay_jiffies +=3D tz->recheck_delay_jiffie=
s;
> >>> +             if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DEL=
AY)
> >>> +                     dev_info(&tz->device, "Temperature unknown, giv=
ing up\n");
> >>> +     }
> >>>    }
> >>>
> >>>    static struct thermal_governor *thermal_get_tz_governor(struct the=
rmal_zone_device *tz)
> >>> @@ -430,6 +438,7 @@ static void update_temperature(struct th
> >>>
> >>>        tz->last_temperature =3D tz->temperature;
> >>>        tz->temperature =3D temp;
> >>> +     tz->recheck_delay_jiffies =3D 1;
> >>>
> >>>        trace_thermal_temperature(tz);
> >>>
> >>> @@ -514,7 +523,7 @@ void __thermal_zone_device_update(struct
> >>>        update_temperature(tz);
> >>>
> >>>        if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
> >>> -             return;
> >>> +             goto monitor;
> >>>
> >>>        tz->notify_event =3D event;
> >>>
> >>> @@ -536,6 +545,7 @@ void __thermal_zone_device_update(struct
> >>>
> >>>        thermal_debug_update_trip_stats(tz);
> >>>
> >>> +monitor:
> >>>        monitor_thermal_zone(tz);
> >>>    }
> >>>
> >>> @@ -1438,6 +1448,7 @@ thermal_zone_device_register_with_trips(
> >>>
> >>>        thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_=
delay);
> >>>        thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_=
delay);
> >>> +     tz->recheck_delay_jiffies =3D 1;
> >>>
> >>>        /* sys I/F */
> >>>        /* Add nodes that are always present via .groups */
> >>> Index: linux-pm/drivers/thermal/thermal_core.h
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.h
> >>> +++ linux-pm/drivers/thermal/thermal_core.h
> >>> @@ -67,6 +67,8 @@ struct thermal_governor {
> >>>     * @polling_delay_jiffies: number of jiffies to wait between polls=
 when
> >>>     *                  checking whether trip points have been crossed=
 (0 for
> >>>     *                  interrupt driven systems)
> >>> + * @recheck_delay_jiffies: delay after a failed thermal zone tempera=
ture check
> >>> + *                   before attempting to check it again
> >>>     * @temperature:    current temperature.  This is only for core co=
de,
> >>>     *                  drivers should use thermal_zone_get_temp() to =
get the
> >>>     *                  current temperature
> >>> @@ -108,6 +110,7 @@ struct thermal_zone_device {
> >>>        int num_trips;
> >>>        unsigned long passive_delay_jiffies;
> >>>        unsigned long polling_delay_jiffies;
> >>> +     unsigned long recheck_delay_jiffies;
> >>>        int temperature;
> >>>        int last_temperature;
> >>>        int emul_temperature;
> >>> @@ -133,6 +136,12 @@ struct thermal_zone_device {
> >>>        struct thermal_trip_desc trips[] __counted_by(num_trips);
> >>>    };
> >>>
> >>> +/*
> >>> + * Maximum delay after a failing thermal zone temperature check befo=
re
> >>> + * attempting to check it again (in jiffies).
> >>> + */
> >>> +#define THERMAL_MAX_RECHECK_DELAY    (30 * HZ)
> >>> +
> >>>    /* Default Thermal Governor */
> >>>    #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> >>>    #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> >>>
> >>>
> >>>
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
> >>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

