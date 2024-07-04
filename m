Return-Path: <linux-pm+bounces-10618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CB92782C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909931F23E93
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3761AEFE9;
	Thu,  4 Jul 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF6iv2g/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420441AED3A;
	Thu,  4 Jul 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102895; cv=none; b=XawX+gxxl3t4iCDVWQMkOxeStU2oamNR4tQqVQLI5qZ/oktfKuFTOETQz1nl6Yqqu+xMUq6cO0OAgZxYzI5Av1qui6x+Qb6s6iQgYoqSaK1kwTy7Fb3Bou4gLJSFNEisWFohOqnHpE89gwv7TnHnongxIJi3ZwfcoZmeTBbkCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102895; c=relaxed/simple;
	bh=iLKFAWGQDFnDn9GxZS2C+VpnF9ad2e3JbRlZUG+rICQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwlIcvkLtPBkYb1cLPPaAiwEs5nlcUaQzeJFP3Ex+u1dYcFMp9mfE8JmeU6TpzpCRTjJizXXlMN+qK1DPu0VvVL95k3HgGwtTowYNOS52kR5NbYM8t17bpRpGp5u+0Im1FE966A1KnfTz7T9mI/Lq7qXaaCNFFZaSS+BtsuRdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF6iv2g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3E3C32781;
	Thu,  4 Jul 2024 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102895;
	bh=iLKFAWGQDFnDn9GxZS2C+VpnF9ad2e3JbRlZUG+rICQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mF6iv2g/KmFoTCif6bpdtxVhm3ZUt7Tl+4BN7TjP8go5rTrdsHnsuvUYl6maJTLrL
	 A1AVtYR5fNU2u9oDARHGYByPit0K31ueOrLz8C7XJDTTrNcT+DMLvpwpYh+zKENYmz
	 NxEUM+Mg86iNcXo6bO1yjRqXuPWOSiEl4V54F3zRfEOELlqSLTikaBSHyJ0kpyoP1Q
	 BZU5JI9sWTEDX0/iax1ynJkl3BKfhuI4Z7nj3tO3MDLen6IjvBxWVqFP3OXrJ68l3W
	 FXPVl0tOLhfZeyUUKlbPlbleanQPEuVePZZhWTn381UpOFhYbjmLxR7TpxW6oApe88
	 Iu7zXhRUprbYw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-24c5ec50da1so108370fac.3;
        Thu, 04 Jul 2024 07:21:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGTryIO0KOIlYTMWXyPpZW4Te3pYBGMv6iV39i5VwIalKh0lGlmjU1BHLVefqz/okEHbQCDLolQsdtbcKeUm/YRXAyYESB7FxfRJ89LbXXvsx9qLYHH3p/xJMTTPOy7roEeFQBHnk=
X-Gm-Message-State: AOJu0Yyq17izuSFr/q3OHVh5ztkjQ+iazNOoxf4NXDtYzpBHuXT+gyEl
	lmC9OLBejmRdvbvPbR+7c5HnbYvAMcL70VqP84cTRjXE9+noBczcWy+SccaY5snW1L1ZPO+NAqv
	vlC7Hi7uK8OIdWloFAe6MMNScetk=
X-Google-Smtp-Source: AGHT+IFMajNeUi1LGfOE5/p5eMZrEJ628V1/uxpM2bC+gcHyzFoGeOm0k1VNiPUwTuhaTBAzx/3/aeD4upUrSbAOj2g=
X-Received: by 2002:a05:6870:b250:b0:25e:180:9183 with SMTP id
 586e51a60fabf-25e2bf95bc9mr1626226fac.4.1720102894360; Thu, 04 Jul 2024
 07:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6064157.lOV4Wx5bFT@rjwysocki.net> <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
In-Reply-To: <218d45a8-4c3d-453b-aded-d232c366da2c@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 16:21:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gRoy0+LD0EgwbS0NL8kHhas4T6itgawGjE8iNf57MOcg@mail.gmail.com>
Message-ID: <CAJZ5v0gRoy0+LD0EgwbS0NL8kHhas4T6itgawGjE8iNf57MOcg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:49=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 04/07/2024 13:46, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> > if zone temperature is invalid") caused __thermal_zone_device_update()
> > to return early if the current thermal zone temperature was invalid.
> >
> > This was done to avoid running handle_thermal_trip() and governor
> > callbacks in that case which led to confusion.  However, it went too
> > far because monitor_thermal_zone() still needs to be called even when
> > the zone temperature is invalid to ensure that it will be updated
> > eventually in case thermal polling is enabled and the driver has no
> > other means to notify the core of zone temperature changes (for example=
,
> > it does not register an interrupt handler or ACPI notifier).
> >
> > Also if the .set_trips() zone callback is expected to set up monitoring
> > interrupts for a thermal zone, it needs to be provided with valid
> > boundaries and that can only be done if the zone temperature is known.
> >
> > Accordingly, to ensure that __thermal_zone_device_update() will
> > run again after a failing zone temperature check, make it call
> > monitor_thermal_zone() regardless of whether or not the zone
> > temperature is valid and make the latter schedule a thermal zone
> > temperature update if the zone temperature is invalid even if
> > polling is not enabled for the thermal zone (however, if this
> > continues to fail, give up after some time).
>
> Rafael,
>
> do we agree that we should fix somehow the current issue in this way
> because we are close to the merge window,

Yes.

> but the proper fix is not doing that ?

We need to decide what to do in general when __thermal_zone_get_temp()
returns an error.  A proper fix would result from that, but it would
require more time than is available IMV.  We can properly fix this in
6.11.

For 6.10 I see two options:

1. Apply the v2 of this patch:

https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net/

I slightly prefer it because it is simpler and doesn't change the size
of struct thermal_zone_device.  However, the clear disadvantage of it
is that it will poke at dead thermal zones indefinitely.

The THERMAL_RECHECK_DELAY_MS value in it can be adjusted.  Maybe 250
ms would be a better choice?

2. Apply this patch (ie. v3)

It is nicer to thermal zones that never become operational, but it may
miss thermal zones that become operational very late.

> > Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() =
if zone temperature is invalid")
> > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033f=
ca16@linaro.org
> > Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c |   13 ++++++++++++-
> >   drivers/thermal/thermal_core.h |    9 +++++++++
> >   2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -300,6 +300,14 @@ static void monitor_thermal_zone(struct
> >               thermal_zone_device_set_polling(tz, tz->passive_delay_jif=
fies);
> >       else if (tz->polling_delay_jiffies)
> >               thermal_zone_device_set_polling(tz, tz->polling_delay_jif=
fies);
> > +     else if (tz->temperature =3D=3D THERMAL_TEMP_INVALID &&
> > +              tz->recheck_delay_jiffies <=3D THERMAL_MAX_RECHECK_DELAY=
) {
> > +             thermal_zone_device_set_polling(tz, tz->recheck_delay_jif=
fies);
> > +             /* Double the recheck delay for the next attempt. */
> > +             tz->recheck_delay_jiffies +=3D tz->recheck_delay_jiffies;
> > +             if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DELAY=
)
> > +                     dev_info(&tz->device, "Temperature unknown, givin=
g up\n");
> > +     }
> >   }
> >
> >   static struct thermal_governor *thermal_get_tz_governor(struct therma=
l_zone_device *tz)
> > @@ -430,6 +438,7 @@ static void update_temperature(struct th
> >
> >       tz->last_temperature =3D tz->temperature;
> >       tz->temperature =3D temp;
> > +     tz->recheck_delay_jiffies =3D 1;
> >
> >       trace_thermal_temperature(tz);
> >
> > @@ -514,7 +523,7 @@ void __thermal_zone_device_update(struct
> >       update_temperature(tz);
> >
> >       if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
> > -             return;
> > +             goto monitor;
> >
> >       tz->notify_event =3D event;
> >
> > @@ -536,6 +545,7 @@ void __thermal_zone_device_update(struct
> >
> >       thermal_debug_update_trip_stats(tz);
> >
> > +monitor:
> >       monitor_thermal_zone(tz);
> >   }
> >
> > @@ -1438,6 +1448,7 @@ thermal_zone_device_register_with_trips(
> >
> >       thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_del=
ay);
> >       thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_del=
ay);
> > +     tz->recheck_delay_jiffies =3D 1;
> >
> >       /* sys I/F */
> >       /* Add nodes that are always present via .groups */
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -67,6 +67,8 @@ struct thermal_governor {
> >    * @polling_delay_jiffies: number of jiffies to wait between polls wh=
en
> >    *                  checking whether trip points have been crossed (0=
 for
> >    *                  interrupt driven systems)
> > + * @recheck_delay_jiffies: delay after a failed thermal zone temperatu=
re check
> > + *                   before attempting to check it again
> >    * @temperature:    current temperature.  This is only for core code,
> >    *                  drivers should use thermal_zone_get_temp() to get=
 the
> >    *                  current temperature
> > @@ -108,6 +110,7 @@ struct thermal_zone_device {
> >       int num_trips;
> >       unsigned long passive_delay_jiffies;
> >       unsigned long polling_delay_jiffies;
> > +     unsigned long recheck_delay_jiffies;
> >       int temperature;
> >       int last_temperature;
> >       int emul_temperature;
> > @@ -133,6 +136,12 @@ struct thermal_zone_device {
> >       struct thermal_trip_desc trips[] __counted_by(num_trips);
> >   };
> >
> > +/*
> > + * Maximum delay after a failing thermal zone temperature check before
> > + * attempting to check it again (in jiffies).
> > + */
> > +#define THERMAL_MAX_RECHECK_DELAY    (30 * HZ)
> > +
> >   /* Default Thermal Governor */
> >   #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> >   #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
> >
> >
> >
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
>

