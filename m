Return-Path: <linux-pm+bounces-8964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C19043E0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDB11F21623
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876457CB5;
	Tue, 11 Jun 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm8fEhlE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22138FA1;
	Tue, 11 Jun 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131419; cv=none; b=Fmz10XjECiiQzmRorqhsnNTByEcx1q78gh5WR7ptKcDQpsB0nhrmT1TKZ2Gkcm3vsxLkDPFCnu2J4e74gtXzI5eJ6TFmehC0Kf/LqWJdGOZez+dj6KM+GxllIrBjjBMPdsDTgAUJDUqqJVCMZ8zOD5Fl+4yeNKI0fiSR6vd8iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131419; c=relaxed/simple;
	bh=xyfbWFD9PEoC0hy5UMfciLSU6DEIzoltYKj4K6js7RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BP6VjE3PAappFO3uy7259nTEuHoSQwZByGKpSBnjtfnknCPHL6R+58L1MLA8+Gc4YaHk1kkAdxYaVxDhwk2KpV88z+hY584hhdSE6ZgffwDw75BeaGROx+o10FTnXwkpfaKaDjad3BcR3PJ7/ytMbX+Yxk0xQUioYPt16VFrEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm8fEhlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22772C4AF48;
	Tue, 11 Jun 2024 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131419;
	bh=xyfbWFD9PEoC0hy5UMfciLSU6DEIzoltYKj4K6js7RA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zm8fEhlEWdlglYa4KZ5EuSpkNUcRkJGAd17h4EYZvvFDFSA93DTXbfIOw3w6DwtmH
	 TGmDy/pdVlPPtsiyJGhIhn07+twJuLeGy9JPSW27dRx/+P6DJycx/PkAzZaxcAzMfG
	 Om9EfSd/Betu8WIZAHFQvZHRQJl2gTWS2LpYi+g2kLS9ixzKOa2vJ/WEOo2h1yNzNk
	 bIQeRIhhm4jBJPzNSsE5f7GmcQur/6W08LWVTKhG04lIUHsSlERgb1bq+ESVIMWj0j
	 tsVG9/zHQ9qvivfs+pDVIBfyUijoGhx0M8lcOwiW3DyRg00/P2Laan8cAKVXfcVTH1
	 YajS9ATp5ednA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24c582673a5so242195fac.2;
        Tue, 11 Jun 2024 11:43:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWicWQo4T0uQk8D11ME6H/BrZEUF1bkaBvV50QvJ2etpOQmAa/7ooN8ErZyVRDpOyrD+1aUpXT6py6pP29pO44luMnU8/UP/d5tswsE0lAXFl+IKIBI1i18Uobo1t/49sdrkO4D9eE=
X-Gm-Message-State: AOJu0YxvgGYVaxb09gOPlkwPI1irMmY71kMzUjENIB6OyqZbWMTByJ5m
	tG8a1F3P8PV+uKUfWO63KimUKPF3WKWBlCzohM1ZTt7rfRa78qyJFemUySDALnUayYcYFN4OOLa
	pfCO7vas4+CsHMf/oAQdJCIHs8cY=
X-Google-Smtp-Source: AGHT+IFPl+PkoahK2p0WiQw8OufLfv0QQnXJlc3eiBq9v+GXj33OITqROCuusmvJvSUvwDC2JlLd1/wPv7ppf7jivC8=
X-Received: by 2002:a05:6870:8182:b0:254:c111:12b9 with SMTP id
 586e51a60fabf-254c11119dcmr7784411fac.2.1718131418437; Tue, 11 Jun 2024
 11:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12458899.O9o76ZdvQC@kreacher> <2340783.ElGaqSPkdT@kreacher> <e0a9f173-1abf-4faa-9a2d-b8310e72ef28@linaro.org>
In-Reply-To: <e0a9f173-1abf-4faa-9a2d-b8310e72ef28@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Jun 2024 20:43:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNX03dhSO5rWBhK8Fyzu1zH-aLhrTkm_b0zhMQr_W1Sw@mail.gmail.com>
Message-ID: <CAJZ5v0hNX03dhSO5rWBhK8Fyzu1zH-aLhrTkm_b0zhMQr_W1Sw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] thermal: trip: Make thermal_zone_set_trips() use
 trip thresholds
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 8:01=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/05/2024 18:51, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Modify thermal_zone_set_trips() to use trip thresholds instead of
> > computing the low temperature for each trip to avoid deriving both
> > the high and low temperature levels from the same trip (which may
> > happen if the zone temperature falls into the hysteresis range of
> > one trip).
> >
> > Accordingly, make __thermal_zone_device_update() call
> > thermal_zone_set_trips() later, when threshold values have been
> > updated for all trips.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Rebase.
> >
> > ---
> >   drivers/thermal/thermal_core.c |    4 ++--
> >   drivers/thermal/thermal_trip.c |   14 ++++----------
> >   2 files changed, 6 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -513,13 +513,13 @@ void __thermal_zone_device_update(struct
> >       if (tz->temperature =3D=3D THERMAL_TEMP_INVALID)
> >               return;
> >
> > -     thermal_zone_set_trips(tz);
> > -
> >       tz->notify_event =3D event;
> >
> >       for_each_trip_desc(tz, td)
> >               handle_thermal_trip(tz, td, &way_up_list, &way_down_list)=
;
>
> Would it make sense to use the for_each_trip_desc() loop here and update
> low and high on the fly in this loop ?
>
> If a trip point is crossed the way up or down, then
> handle_thermal_trip() returns a value which in turn results in updating
> low and high. If low and high are changed then the we call
> thermal_zone_set_trips() after the loop.
>
> The results for the thermal_zone_set_trips() will be the loop, the low,
> high, prev_low_trip and prev_high_trip variables going away.
>
> The resulting function should be:
>
> void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int
> high)
> {
>          int ret;
>
>          lockdep_assert_held(&tz->lock);
>
>          if (!tz->ops.set_trips)
>                  return;
>
>          /*
>
>
>           * Set a temperature window. When this window is left the
> driver
>
>           * must inform the thermal core via thermal_zone_device_update.
>
>
>           */
>          ret =3D tz->ops.set_trips(tz, low, high);
>          if (ret)
>                  dev_err(&tz->device, "Failed to set trips: %d\n", ret);
> }

So you essentially mean moving the for_each_trip_desc() loop from
thermal_zone_set_trips() to __thermal_zone_device_update() IIUC.

The caveat is that it is not necessary to run this loop at all if
tz->ops.set_trips is NULL.

I was thinking about folding the entire thermal_zone_set_trips() into
the caller, but that would be a different patch.

>
> But if you consider that is an additional change, then:

I do.

> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thank you!

>
> > +     thermal_zone_set_trips(tz);
> > +
> >       list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
> >       list_for_each_entry(td, &way_up_list, notify_list_node)
> >               thermal_trip_crossed(tz, &td->trip, governor, true);
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -88,17 +88,11 @@ void thermal_zone_set_trips(struct therm
> >               return;
> >
> >       for_each_trip_desc(tz, td) {
> > -             const struct thermal_trip *trip =3D &td->trip;
> > -             int trip_low;
> > +             if (td->threshold < tz->temperature && td->threshold > lo=
w)
> > +                     low =3D td->threshold;
> >
> > -             trip_low =3D trip->temperature - trip->hysteresis;
> > -
> > -             if (trip_low < tz->temperature && trip_low > low)
> > -                     low =3D trip_low;
> > -
> > -             if (trip->temperature > tz->temperature &&
> > -                 trip->temperature < high)
> > -                     high =3D trip->temperature;
> > +             if (td->threshold > tz->temperature && td->threshold < hi=
gh)
> > +                     high =3D td->threshold;
> >       }
> >
> >       /* No need to change trip points */
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

