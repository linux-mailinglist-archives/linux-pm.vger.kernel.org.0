Return-Path: <linux-pm+bounces-12268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC10952E5D
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DA41F2267E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89217C9BD;
	Thu, 15 Aug 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv5WchdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC91714DA;
	Thu, 15 Aug 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725332; cv=none; b=OafJZf5xydgQ5+ucau2U0dvPEWy3dR/lsaMFRsz/+DcnzMkeR/6EZ1o8L6qbM41Tuun3ADI8LDyYsvL0G2CO/vhWPdV5R66V9DLm+NZtROTtQp6S4PC8HgKP/6m92uMS4e4032cH0ltYjuD7vMxM57bhUdqXnrfDU+VBVeYgfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725332; c=relaxed/simple;
	bh=dXaBct2Q9fRbnCiEvN+tKUOp34Nt6Wc6xwlzOM0mSXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZyEA4jWuxpVTv9tjRpHq2YN1ze9SRNGVNqlC/A1oUrLmZHg3vOHdDp+0OJQW3CVGszG5RSgOf4sUReBPgJVLm3yM0NL3PFZ+EIfCt4lPvRgxHjp2bs4aFPJGyBwBej0ZogrM1dssbmbOjlkFO/eIkUjyeGIDsAyKoOfqP5XaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv5WchdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC557C32786;
	Thu, 15 Aug 2024 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723725330;
	bh=dXaBct2Q9fRbnCiEvN+tKUOp34Nt6Wc6xwlzOM0mSXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gv5WchdIfK6YZLQMJsg8SuhNq8qIOAR2nHVj1hrE4Eyr474wVXvV6GnD7vStYyuiz
	 5H2rFPkVaNn/oaLfAz8uwf2Xt4MDstc4eVmSgWufINK61UXOSIuz5SujWUqUnEf93w
	 99M/iHgL0FnTpF5IbgbZo10WsjQPJtJJTbOVaDUWBzLBhF/puebScfKf6bqoPjEf5C
	 ieYezyCmuwNAjPBaeTiU+3VyvFs9Smw3CNvS6uJtgQ93m+PS3DzHseaVI4eIfBndqZ
	 f0kyHlWso8vBjuhesuA4VTMboQ2DNaOhHYGgvXqmZNVqZydwgs4w6IJFYwTWw+KoH6
	 jnbwIU3hXB1sA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so120799fac.0;
        Thu, 15 Aug 2024 05:35:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX157CFFZkQKAR6gk0TcWKQiAC+BB90I0v7DwA8sIPhO0o1YOBZE177JIsbXLJf99UNLz3KJMWfSR8BXgY=@vger.kernel.org, AJvYcCXCHZAq6gl8JhqlhJWUkbu7uaVFg8kJo1tWggFu7AIY4VYoCZSys132qYpwFM8AD3IyutFPjX72FAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBlYRGw+J7xZJrms42iTncMGNaeaW2nMIgMI0hUJkpNBg7sns
	J2saPWQLCNaUH4TI1W4sQ3AWzt7QbpW7ZK+bhdlDK60QS69/ch52IVOrt16K0fMh5RxTqJPOV+G
	xUI+fAY82Ns+t1JlQ8rthLvyraSw=
X-Google-Smtp-Source: AGHT+IG8X5e/cxbJqUe9zIHlPOalxNCTb+siCnJK6pcmYoYz8a5V/XEhW7HvRALv4QzF96PXDxwOpDvDT8A33LWMN0I=
X-Received: by 2002:a05:6870:9b0d:b0:260:e5e1:2411 with SMTP id
 586e51a60fabf-27002a5142cmr1343093fac.6.1723725329985; Thu, 15 Aug 2024
 05:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1903691.tdWV9SEqCh@rjwysocki.net> <2285575.iZASKD2KPV@rjwysocki.net>
 <2f16fd5a59d6655ec9339473d516ac49c89e43f8.camel@intel.com>
 <CAJZ5v0icxkRyd_1T53JmX3XDQOC6_Ak9nOD65Yx-rhZbDa4Y_w@mail.gmail.com> <6f3c94464ae9c2fd4e4d3c75f7f837aa073517ee.camel@intel.com>
In-Reply-To: <6f3c94464ae9c2fd4e4d3c75f7f837aa073517ee.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Aug 2024 14:35:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZvOiJMGEt8FwOztQfjfBTGqdrt8_oWug+GeZ4DR6EBw@mail.gmail.com>
Message-ID: <CAJZ5v0jZvOiJMGEt8FwOztQfjfBTGqdrt8_oWug+GeZ4DR6EBw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to
 reduce overhead
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, 
	"peter@piie.net" <peter@piie.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:26=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Wed, 2024-08-14 at 19:26 +0200, Rafael J. Wysocki wrote:
> > On Wed, Aug 14, 2024 at 8:09=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com=
>
> > wrote:
> > >
> > > On Tue, 2024-08-13 at 16:29 +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > After running once, the for_each_trip_desc() loop in
> > > > bang_bang_manage() is pure needless overhead because it is not
> > > > going
> > > > to
> > > > make any changes unless a new cooling device has been bound to
> > > > one of
> > > > the trips in the thermal zone or the system is resuming from
> > > > sleep.
> > > >
> > > > For this reason, make bang_bang_manage() set governor_data for
> > > > the
> > > > thermal zone and check it upfront to decide whether or not it
> > > > needs
> > > > to
> > > > do anything.
> > > >
> > > > However, governor_data needs to be reset in some cases to let
> > > > bang_bang_manage() know that it should walk the trips again, so
> > > > add
> > > > an
> > > > .update_tz() callback to the governor and make the core
> > > > additionally
> > > > invoke it during system resume.
> > > >
> > > > To avoid affecting the other users of that callback
> > > > unnecessarily,
> > > > add
> > > > a special notification reason for system resume,
> > > > THERMAL_TZ_RESUME,
> > > > and
> > > > also pass it to __thermal_zone_device_update() called during
> > > > system
> > > > resume for consistency.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/thermal/gov_bang_bang.c |   18 ++++++++++++++++++
> > > >  drivers/thermal/thermal_core.c  |    3 ++-
> > > >  include/linux/thermal.h         |    1 +
> > > >  3 files changed, 21 insertions(+), 1 deletion(-)
> > > >
> > > > Index: linux-pm/drivers/thermal/gov_bang_bang.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > =3D=3D
> > > > --- linux-pm.orig/drivers/thermal/gov_bang_bang.c
> > > > +++ linux-pm/drivers/thermal/gov_bang_bang.c
> > > > @@ -86,6 +86,10 @@ static void bang_bang_manage(struct ther
> > > >         const struct thermal_trip_desc *td;
> > > >         struct thermal_instance *instance;
> > > >
> > > > +       /* If the code below has run already, nothing needs to be
> > > > done. */
> > > > +       if (tz->governor_data)
> > > > +               return;
> > > > +
> > > >         for_each_trip_desc(tz, td) {
> > > >                 const struct thermal_trip *trip =3D &td->trip;
> > > >
> > > > @@ -107,11 +111,25 @@ static void bang_bang_manage(struct ther
> > > >
> > > > bang_bang_set_instance_target(instanc
> > > > e, 0);
> > > >                 }
> > > >         }
> > > > +
> > > > +       tz->governor_data =3D (void *)true;
> > > > +}
> > > > +
> > > > +static void bang_bang_update_tz(struct thermal_zone_device *tz,
> > > > +                               enum thermal_notify_event reason)
> > > > +{
> > > > +       /*
> > > > +        * Let bang_bang_manage() know that it needs to walk
> > > > trips
> > > > after binding
> > > > +        * a new cdev and after system resume.
> > > > +        */
> > > > +       if (reason =3D=3D THERMAL_TZ_BIND_CDEV || reason =3D=3D
> > > > THERMAL_TZ_RESUME)
> > > > +               tz->governor_data =3D NULL;
> > > >  }
> > >
> > > can we do the cdev initialization for BIND_CDEV and RESUME
> > > notification
> > > in .update_tz() directly?
> >
> > That would be viable if the zone temperature was known at the time
> > .update_tz() runs, but it isn't.  See this message:
> >
> > https://lore.kernel.org/linux-pm/CAJZ5v0ji_7Z-24iCO_Xxu4Zm4jgVFmR9jVp8Q=
NiCOxzV9gqSnA@mail.gmail.com/
> >
> > As long as the zone temperature is not known, it is not clear which
> > way to initialize the cooling devices.
>
> right. Then the patch LGTM.

Great!

> BTW, what do you think if we add handling for first temperature read in
> handle_thermal_trip(), say, some draft code like below,
>
> if (tz->last_temperature =3D=3D THERMAL_TEMP_INIT) {
>         if (tz->temperature < trip->temperature)
>                 list_add(&td->notify_list_node, way_down_list);
>         else
>                 list_add_tail(&td->notify_list_node, way_up_list);
> }
>
> This should handle both the init and the resume case.

I have considered doing something similar, but there are quite a few
arguments against it.

First, it would cause spurious notifications to be sent to user space.
Second, the debug code would need to be modified to take this case
into account explicitly.  Moreover, this would be extra overhead for
the other governors.

IMV it's better to limit the impact to the Bang-bang governor where
the problem is.

