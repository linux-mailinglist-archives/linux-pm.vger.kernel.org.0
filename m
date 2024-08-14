Return-Path: <linux-pm+bounces-12217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837D95210F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E46028149F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709541BBBCD;
	Wed, 14 Aug 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKifysO+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47825111A1;
	Wed, 14 Aug 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656399; cv=none; b=FS5KnMayyg7hCPZekm+INi3OwFusUsiFjd8mZW6f1DNAJSbswHCRFKoniMhsg1+yMO2KMKUA7oFv4SOvGLALMxM+NviVdvFti+BEbikKGCZEXhp5vORRNWGaat0QPZ++u9BK04DMYqr7Bjz4VB4g+KKfxri11WoYfpd5JPi73y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656399; c=relaxed/simple;
	bh=eTnLoZGdchWutqvJYFrXoB9RVGn/dZ58dMhkGG+oPew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL3lx7QIl1Umso9+drWIEdos15IhBpbQmAm686ugcoEWf1aPYCHVmjhZ20jcMtJS+ILL+Q3s6Uhjg4EbmSY6c6q3L/IHCe1SlaA2j+GXVc8cG1WHnmXT0smd2sNxGc7FtvmmlkDjwCMpS7MjAKhqxzsqT+s+uygNyAilauw1Wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKifysO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0435C4AF0D;
	Wed, 14 Aug 2024 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723656398;
	bh=eTnLoZGdchWutqvJYFrXoB9RVGn/dZ58dMhkGG+oPew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKifysO+lcCzM678N2K1mv1IQ2FLJutwG0rJdkc2DENLzMr8bNGw4fFi6u+JGlj/1
	 MdQm/N1GPK9nE0udZQwBkrptZ6iCi2mYt9UzKllvds0oODVeH7iQo7F6VGuq3Bo2bI
	 xmAkk62md2dERDNtT9Ks9RKChoXr5SvLcyH0u+ycpAbRCDhBjE7PEtADtlCsitVtiW
	 sLYS6sJble0rQKBnC/bBFvFGj5td3/+7PRAJTcIpscPRo4vFDSpV2VBenTLkTasmyh
	 eKEq0PqCLV9pzxytkYPjJmZjomdc2bkX11hNnhGq4q8P9mIr4ha1hFCRTGqPm+CI1v
	 qEysPa96H8BGQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-26110765976so18067fac.1;
        Wed, 14 Aug 2024 10:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/mVThzbPT/SBdXWlv3CfuDwpJykO3jqC24w9hf+/dV9eKndj5/XTwyFT3U2Q+bizzvK3wKUVb9Vubzy8ItBHVsIliEWOh4WbgQQFh
X-Gm-Message-State: AOJu0YzbF7KUlZh2MD1valj7kVMAspGFMd7WXFjXD8E2Dc2ace0hjfrf
	UoXsJozD+jQNM6ovqcU5MHDrkdqJqFgEYmPrYjju+Wn4qyP8mhUhzIiG9mMaYkIlMjIgV+DeLyu
	W6GN9ztI3psWAEHGBcYMX9ifIkOI=
X-Google-Smtp-Source: AGHT+IENZovxxdHeWc1pSFQJYl614ru0uPWXXnobS9h5XVlXu/A0J4gRih3/rTG4z86U6Xt5771SYhMooaFKguZE7qo=
X-Received: by 2002:a05:6870:e3cc:b0:260:f1c4:2fe2 with SMTP id
 586e51a60fabf-26fe5cc3422mr2028529fac.9.1723656397927; Wed, 14 Aug 2024
 10:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1903691.tdWV9SEqCh@rjwysocki.net> <2285575.iZASKD2KPV@rjwysocki.net>
 <2f16fd5a59d6655ec9339473d516ac49c89e43f8.camel@intel.com>
In-Reply-To: <2f16fd5a59d6655ec9339473d516ac49c89e43f8.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Aug 2024 19:26:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icxkRyd_1T53JmX3XDQOC6_Ak9nOD65Yx-rhZbDa4Y_w@mail.gmail.com>
Message-ID: <CAJZ5v0icxkRyd_1T53JmX3XDQOC6_Ak9nOD65Yx-rhZbDa4Y_w@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, 
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "peter@piie.net" <peter@piie.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:09=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Tue, 2024-08-13 at 16:29 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After running once, the for_each_trip_desc() loop in
> > bang_bang_manage() is pure needless overhead because it is not going
> > to
> > make any changes unless a new cooling device has been bound to one of
> > the trips in the thermal zone or the system is resuming from sleep.
> >
> > For this reason, make bang_bang_manage() set governor_data for the
> > thermal zone and check it upfront to decide whether or not it needs
> > to
> > do anything.
> >
> > However, governor_data needs to be reset in some cases to let
> > bang_bang_manage() know that it should walk the trips again, so add
> > an
> > .update_tz() callback to the governor and make the core additionally
> > invoke it during system resume.
> >
> > To avoid affecting the other users of that callback unnecessarily,
> > add
> > a special notification reason for system resume, THERMAL_TZ_RESUME,
> > and
> > also pass it to __thermal_zone_device_update() called during system
> > resume for consistency.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thermal/gov_bang_bang.c |   18 ++++++++++++++++++
> >  drivers/thermal/thermal_core.c  |    3 ++-
> >  include/linux/thermal.h         |    1 +
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/thermal/gov_bang_bang.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> > +++ linux-pm/drivers/thermal/gov_bang_bang.c
> > @@ -86,6 +86,10 @@ static void bang_bang_manage(struct ther
> >         const struct thermal_trip_desc *td;
> >         struct thermal_instance *instance;
> >
> > +       /* If the code below has run already, nothing needs to be
> > done. */
> > +       if (tz->governor_data)
> > +               return;
> > +
> >         for_each_trip_desc(tz, td) {
> >                 const struct thermal_trip *trip =3D &td->trip;
> >
> > @@ -107,11 +111,25 @@ static void bang_bang_manage(struct ther
> >                                 bang_bang_set_instance_target(instanc
> > e, 0);
> >                 }
> >         }
> > +
> > +       tz->governor_data =3D (void *)true;
> > +}
> > +
> > +static void bang_bang_update_tz(struct thermal_zone_device *tz,
> > +                               enum thermal_notify_event reason)
> > +{
> > +       /*
> > +        * Let bang_bang_manage() know that it needs to walk trips
> > after binding
> > +        * a new cdev and after system resume.
> > +        */
> > +       if (reason =3D=3D THERMAL_TZ_BIND_CDEV || reason =3D=3D
> > THERMAL_TZ_RESUME)
> > +               tz->governor_data =3D NULL;
> >  }
>
> can we do the cdev initialization for BIND_CDEV and RESUME notification
> in .update_tz() directly?

That would be viable if the zone temperature was known at the time
.update_tz() runs, but it isn't.  See this message:

https://lore.kernel.org/linux-pm/CAJZ5v0ji_7Z-24iCO_Xxu4Zm4jgVFmR9jVp8QNiCO=
xzV9gqSnA@mail.gmail.com/

As long as the zone temperature is not known, it is not clear which
way to initialize the cooling devices.

Interestingly enough, the zone temperature is first checked by the
core when the zone is enabled and not when it is registered.

> Then we don't need .manage() callback. This makes more sense to me
> because bang_bang governor cares about trip point crossing only.

That's true, but this is all about a corner case in which no trip
points are crossed and the cooling devices need to be initialized
properly regardless.

> >  static struct thermal_governor thermal_gov_bang_bang =3D {
> >         .name           =3D "bang_bang",
> >         .trip_crossed   =3D bang_bang_control,
> >         .manage         =3D bang_bang_manage,
> > +       .update_tz      =3D bang_bang_update_tz,
> >  };
> >  THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1692,7 +1692,8 @@ static void thermal_zone_device_resume(s
> >
> >         thermal_debug_tz_resume(tz);
> >         thermal_zone_device_init(tz);
> > -       __thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> > +       thermal_governor_update_tz(tz, THERMAL_TZ_RESUME);
> > +       __thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
> >
> >         complete(&tz->resume);
> >         tz->resuming =3D false;
> > Index: linux-pm/include/linux/thermal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -55,6 +55,7 @@ enum thermal_notify_event {
> >         THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal
> > zone */
> >         THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the
> > thermal zone */
> >         THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight
> > changed */
> > +       THERMAL_TZ_RESUME, /* Thermal zone is resuming after system
> > sleep */
> >  };
> >
> >  /**
> >
> >
> >
>

