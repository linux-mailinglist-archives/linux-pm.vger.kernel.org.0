Return-Path: <linux-pm+bounces-12216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE179520F3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C4B1F22D32
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447D1BC075;
	Wed, 14 Aug 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQMkLTO+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2FE1BC072;
	Wed, 14 Aug 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655929; cv=none; b=TUezd+srBGNljdNXZz7hlXRsJVMgixacxC0EujZm8uhJ6e5mKbkt93d3EK/eBk7263CNaUW3dZ+TjifgYxGdoKNL8bwvDcpcpZXIn3lmFqkmxa/cGgPCcq5+9X1sZzmVU/i8IPiJmHiG3+6zI/ZZ7WDJKMr63hLE6Z0r7Gev7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655929; c=relaxed/simple;
	bh=JAX+m4fppNgSQ/+GhddMYohO4O4t5T3sNGxMKK7zuSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqXRZ/5fQq/YGlIUIm4MC48X9/Jve7jP9b/sKCL5IdBhsV13ne+qgzxtOos3wZAeE1Du005QJvFdkFssT6eW1fTEffgB0LgNkVCoMvKcrUdLJ2kApK+xc6FtcCUGD0Uel3t6nuxO5z3E6CgGJLDtXfdq0rcQIwHwyHtMm0l6zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQMkLTO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C1DC4AF0B;
	Wed, 14 Aug 2024 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655928;
	bh=JAX+m4fppNgSQ/+GhddMYohO4O4t5T3sNGxMKK7zuSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KQMkLTO+GrZza97ONRv7qao/005tKEIOtXRv85kDSL6S2k3RrmjviX1hO1GLa1+kM
	 wDdbvnH93u2oFc6dnuXGEFt9scwU9PSUAhsprcIfu6qN+hTBNo19RErPvf2/n56+l1
	 yCv4mR45wIDKykkMRG+k0mrax4qOT/DlKxayB7hdyZh3mXsDpYrN7Nk444vLmqtVCs
	 dfsZhbc0s3bA0SFm3pqxK3XCYXhRISfyCmvUjL5AK6MCrJJv5J+E1wpAW8XBJX3rDV
	 qOoKatU1rZDJZY3NEi5WWqyi7R2ZzBf9CVNjzWvOIdo7ZAMH0M9Ze59/LsIJ7UhMEQ
	 osgUwx4JrEYGA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db165f8211so2572b6e.1;
        Wed, 14 Aug 2024 10:18:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQrbLaRoEGSGgD6OKI05Hv4pte77OT9GaFCRVx75ZAd9nFUOOgqEAHtSdxOuvCa/PMpg2QbptclUn1B5Y=@vger.kernel.org, AJvYcCWRGbwN80FlCdArMfbVHInecEtdNnB31HxqaySVbHzSBJUzzsOQEyRTZeLcSRaaHCwAfoz/PDJiXNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgha0Ib4iGn4j9sayQmwi2BXt3PN3fQj31Iw8NpLKc9BzhTN9
	Gv1uiw7u9aZh3r+zluJzqCbXMb9aDg0gnD68wCbmjOaYXwD+jLQ7smp6Yk3WEvBg+WQQKuD7HVL
	K7mECl98DY3lmEoz8Kc9QWB4VQrM=
X-Google-Smtp-Source: AGHT+IEcPur4ZSNbQqbpwTgvwU44XbV9zRTh9m5di2rNYc+Kr8Hli3o+31uaJek63R9rWQJmXuoHZ9cqVzGZKhITdtU=
X-Received: by 2002:a05:6870:ac11:b0:25e:dce:491b with SMTP id
 586e51a60fabf-26fe59bb7bbmr2475269fac.1.1723655928230; Wed, 14 Aug 2024
 10:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1903691.tdWV9SEqCh@rjwysocki.net> <8419356.T7Z3S40VBb@rjwysocki.net>
 <291044b7-7300-42c2-91e6-fef164482cf3@piie.net>
In-Reply-To: <291044b7-7300-42c2-91e6-fef164482cf3@piie.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Aug 2024 19:18:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h9b2E0meeHGRtRv+=GbsABUs=L4RqAvAZuCksU+uN0cQ@mail.gmail.com>
Message-ID: <CAJZ5v0h9b2E0meeHGRtRv+=GbsABUs=L4RqAvAZuCksU+uN0cQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] thermal: gov_bang_bang: Add .manage() callback
To: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:50=E2=80=AFAM Peter K=C3=A4stle <peter@piie.net>=
 wrote:
>
> On 13.08.24 16:27, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After recent changes, the Bang-bang governor may not adjust the
> > initial configuration of cooling devices to the actual situation.
> >
> > Namely, if a cooling device bound to a certain trip point starts in
> > the "on" state and the thermal zone temperature is below the threshold
> > of that trip point, the trip point may never be crossed on the way up
> > in which case the state of the cooling device will never be adjusted
> > because the thermal core will never invoke the governor's
> > .trip_crossed() callback.  [Note that there is no issue if the zone
> > temperature is at the trip threshold or above it to start with because
> > .trip_crossed() will be invoked then to indicate the start of thermal
> > mitigation for the given trip.]
> >
> > To address this, add a .manage() callback to the Bang-bang governor
> > and use it to ensure that all of the thermal instances managed by the
> > governor have been initialized properly and the states of all of the
> > cooling devices involved have been adjusted to the current zone
> > temperature as appropriate.
> >
> > Fixes: 530c932bdf75 ("thermal: gov_bang_bang: Use .trip_crossed() inste=
ad of .throttle()")
> > Link: https://lore.kernel.org/linux-pm/1bfbbae5-42b0-4c7d-9544-e9885571=
5294@piie.net/
> > Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> oops, previously sent from wrong email address, here again from correct o=
ne...
> Acked-by: Peter K=C3=A4stle <peter@piie.net>

No worries and thanks for the ACKs!

I gather that they mean that the changes work for you.

> > ---
> >   drivers/thermal/gov_bang_bang.c |   30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >
> > Index: linux-pm/drivers/thermal/gov_bang_bang.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> > +++ linux-pm/drivers/thermal/gov_bang_bang.c
> > @@ -26,6 +26,7 @@ static void bang_bang_set_instance_targe
> >        * when the trip is crossed on the way down.
> >        */
> >       instance->target =3D target;
> > +     instance->initialized =3D true;
> >
> >       dev_dbg(&instance->cdev->device, "target=3D%ld\n", instance->targ=
et);
> >
> > @@ -80,8 +81,37 @@ static void bang_bang_control(struct the
> >       }
> >   }
> >
> > +static void bang_bang_manage(struct thermal_zone_device *tz)
> > +{
> > +     const struct thermal_trip_desc *td;
> > +     struct thermal_instance *instance;
> > +
> > +     for_each_trip_desc(tz, td) {
> > +             const struct thermal_trip *trip =3D &td->trip;
> > +
> > +             if (tz->temperature >=3D td->threshold ||
> > +                 trip->temperature =3D=3D THERMAL_TEMP_INVALID ||
> > +                 trip->type =3D=3D THERMAL_TRIP_CRITICAL ||
> > +                 trip->type =3D=3D THERMAL_TRIP_HOT)
> > +                     continue;
> > +
> > +             /*
> > +              * If the initial cooling device state is "on", but the z=
one
> > +              * temperature is not above the trip point, the core will=
 not
> > +              * call bang_bang_control() until the zone temperature re=
aches
> > +              * the trip point temperature which may be never.  In tho=
se
> > +              * cases, set the initial state of the cooling device to =
0.
> > +              */
> > +             list_for_each_entry(instance, &tz->thermal_instances, tz_=
node) {
> > +                     if (!instance->initialized && instance->trip =3D=
=3D trip)
> > +                             bang_bang_set_instance_target(instance, 0=
);
> > +             }
> > +     }
> > +}
> > +
> >   static struct thermal_governor thermal_gov_bang_bang =3D {
> >       .name           =3D "bang_bang",
> >       .trip_crossed   =3D bang_bang_control,
> > +     .manage         =3D bang_bang_manage,
> >   };
> >   THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
> >
> >
> >
>

