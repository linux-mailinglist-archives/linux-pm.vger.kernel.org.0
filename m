Return-Path: <linux-pm+bounces-9383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA990BA35
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F91C2385C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7B198A39;
	Mon, 17 Jun 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX36+Us4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95466155C8D;
	Mon, 17 Jun 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650518; cv=none; b=iyuEQIvIaI4kgFOuj9Qznxn9l+hpu1mQ5cj36jzXB63hia5OyScIiNO16OEvFoYBjige3tTvMbGHd+zpM1hmMbCKfC1HTuoQWXpUleL5bL0OZJm5w3MEPiNzPFJEaI1aQdo/ZrMcgZX0ZmgsuuC9Asy2RMB1f11tTXeI1VqJeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650518; c=relaxed/simple;
	bh=hB5OvIFh2E5NbtqdLS4PC5aMFbXa+gEhVT2fH9NndVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG6Np2SlfRdkRxWK/bzHu9LSUgF6lS10OCjoN+6DmMPED2nCSGkjzTu3C3okLXwxojwC+Y2F0IEpLWuCc6o/NqV6k0xaUR6FZwK0vO47qTGNeikJv4d3bsDU2PBoxTSmcxXdYvf2j+Qm/+YS2zvoqxNWhhwTl/BCMezOd2gOFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX36+Us4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A01FC2BD10;
	Mon, 17 Jun 2024 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650518;
	bh=hB5OvIFh2E5NbtqdLS4PC5aMFbXa+gEhVT2fH9NndVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XX36+Us4KiRohASRINRgZHFSYXkVM3aCgFtqodujYA+T32xCm4epvQcYOF74d4+Ih
	 mOpOI6Mop+ASkCwbcA5k3KGIogJGzJjJh7ALe5fEOLxgYHiagZ9tcCnn3rcXbaDhrm
	 iYtsZAgt9EbYl4v8w42ZhNggOhdtUMOeR3Zo9hIb3iSjjOmXaHX5ijdur5bnLiuCnw
	 6JwGcMZtYiDqieK2s9UDPNe2VY5uPG/Wk8fDJJbDP8lKum+DIi1vvDbcVa6FI9/7q4
	 T+95P0692CVHOkRZlrQxv+sujrmFsU56RXoxZYX2fLeEIbyQsGa/F/ucPdj5JdQKZ0
	 PhEjGpnHmR4uA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2583e2930c7so478735fac.3;
        Mon, 17 Jun 2024 11:55:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcGL/brpJBKnM5mK6dGhUHMledDIZPNAuZhj3x5JzwWwpUmo0qcWeEN81labQ0yS7pYgeoCYfbFpvupu1SrY+4lB81Wb4QK9UMXJnhdORCufq4NUrfTp42tkdPWYMGKOdmQP9AfYM=
X-Gm-Message-State: AOJu0YxeX8a74YacFwxsiZ3H+USalqoFY4fA3j2CvaKy+THLI766uOW0
	AOJqrVU9j2RufxUQ5kRRYckNRaoFdAyrJuWDXPSvuvCnxEW5QX3IFiXXs1OS+eAiXts91s1IzXE
	1z7oY+vaHE7+rNXxesO1E9bMPcXM=
X-Google-Smtp-Source: AGHT+IERdzZ8p+qUKe9pZsqYnjjMYgR+BppLUtTjJ+lSe1eSOydZouTVhF1hya+5RHnJ+4m12yO/jkAM7iWKsHFMqnM=
X-Received: by 2002:a05:6870:971e:b0:254:7dbe:1b89 with SMTP id
 586e51a60fabf-2584288b491mr10784977fac.1.1718650517524; Mon, 17 Jun 2024
 11:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8409966.T7Z3S40VBb@kreacher> <3312460.oiGErgHkdL@kreacher> <20240617183949.GO382677@ragnatech.se>
In-Reply-To: <20240617183949.GO382677@ragnatech.se>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 20:55:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggoTXMHxwjVy9OZ4sQU5UHPwEo1OwYwRFVTzsUErje5w@mail.gmail.com>
Message-ID: <CAJZ5v0ggoTXMHxwjVy9OZ4sQU5UHPwEo1OwYwRFVTzsUErje5w@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] thermal: trip: Replace thermal_zone_get_num_trips()
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Mon, Jun 17, 2024 at 8:39=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
>
> Hi Rafael,
>
> Thanks for your patch.
>
> On 2024-06-17 20:11:30 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The only existing caller of thermal_zone_get_num_trips(), which is
> > rcar_gen3_thermal_probe(), uses this function to check whether or
> > not the number of trips in the given thermal zone is nonzero.
> >
> > Because it really only needs to know whether or not the given
> > thermal zone is tripless, replace thermal_zone_get_num_trips() with
> > thermal_zone_is_tripless() that can tell rcar_gen3_thermal_probe()
> > exactly what it needs to know and make it call that function.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thermal/renesas/rcar_gen3_thermal.c |    3 +--
> >  drivers/thermal/thermal_trip.c              |    6 +++---
> >  include/linux/thermal.h                     |    2 +-
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
> > +++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> > @@ -563,8 +563,7 @@ static int rcar_gen3_thermal_probe(struc
> >               if (ret)
> >                       goto error_unregister;
> >
> > -             ret =3D thermal_zone_get_num_trips(tsc->zone);
> > -             if (ret < 0)
> > +             if (thermal_zone_is_tripless(tsc->zone))
>
> There are two issues with this change.
>
> 1. The original code only jumped to error_unregister if there where a
>    negative number of trip points, presumably to allow for an error to
>    be returned when reading the number of trip points.
>
>    If an negative error was found it was stored in ret, and this was
>    then returned from the probe function after jumping to
>    error_unregister. This change jumps to the error out path, but do not
>    fail probe.
>
>    However it is valid to complete probe without any trip points found.
>    So failing probe on thermal_zone_is_tripless() is not desired.
>
> 2. The value returned from thermal_zone_get_num_trips() and stored in
>    ret is used in a dev_info() below, logging how many trip points (if
>    any) where found.
>
>    With this change that is no longer true and it will always log 0 trip
>    points found.

You are right, I've overlooked the above.

> As there is no long (if there ever where) a reason to check for errors
> when reading the number of trip points, and no real use to log the
> number of trip points found maybe a modified patch can do what you want
> (not tested).
>
> - ret =3D thermal_zone_get_num_trips(tsc->zone);
> - if (ret < 0)
> -    goto error_unregister;
> -
> - dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
> + dev_info(dev, "Sensor %u: Loaded %s trip points\n", i,
> +       thermal_zone_is_tripless(tsc->zone) ? "with" : "without");
>
> What do you think?

I would rather first update the driver to stop failing when the zone
is tripless, in a separate patch.

Fortunately, the $subject patch is not really needed in the series, so
please regard it as withdrawn for now and we can get back to this
later.

Thanks!

>
> >                       goto error_unregister;
> >
> >               dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, re=
t);
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -55,11 +55,11 @@ int thermal_zone_for_each_trip(struct th
> >  }
> >  EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
> >
> > -int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> > +bool thermal_zone_is_tripless(struct thermal_zone_device *tz)
> >  {
> > -     return tz->num_trips;
> > +     return tz->num_trips =3D=3D 0;
> >  }
> > -EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
> > +EXPORT_SYMBOL_GPL(thermal_zone_is_tripless);
> >
> >  /**
> >   * thermal_zone_set_trips - Computes the next trip points for the driv=
er
> > Index: linux-pm/include/linux/thermal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -210,7 +210,7 @@ int for_each_thermal_trip(struct thermal
> >  int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
> >                              int (*cb)(struct thermal_trip *, void *),
> >                              void *data);
> > -int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
> > +bool thermal_zone_is_tripless(struct thermal_zone_device *tz);
> >  void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
> >                               struct thermal_trip *trip, int temp);
> >
> >
> >
> >
>
> --

