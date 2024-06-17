Return-Path: <linux-pm+bounces-9384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5199490BA7D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 21:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F0F1C22C09
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C44198A19;
	Mon, 17 Jun 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/glavAc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A070198843;
	Mon, 17 Jun 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650973; cv=none; b=mI/Ra1v0PpHIYwgewHUkXIy37bbI5u8DfSKjE5Pj1kM7LI4YBwqZ1O0ZLPm1MK1qe1BhOav+4gY0fp58nNGT4uLrc1DYl4UrfaiphegQX/2ETOzVi/YXUj9T/tWxXHICQooqUzmBrx1FB3bkBoi4nrZEBIss586p5Psgu2o1pVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650973; c=relaxed/simple;
	bh=X/bpbal1IiAjmGUQRV20MmE4je4hGHSY31mwwAB1mu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2yWc0con9dg80P7HCg6WxpFTwtJgdvHfBH+puv7R1CeTb4AzdURy+vxe2MkePWOGUexEyS6cQ1fMgnDATWpytYq2iusnESn1EWw0a5DsOVCODS2+JdwBgk5nGEY2EXgSh/iiUI7U6wHMeH8FX5FeFzX7GIPmkdt1DQs7DFnkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/glavAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82132C4AF1C;
	Mon, 17 Jun 2024 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650972;
	bh=X/bpbal1IiAjmGUQRV20MmE4je4hGHSY31mwwAB1mu4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/glavAcDFDHNTlpwUN+yovbxF+BLqxiOKAKqPLZ971r8wrlZMr3O46FjHiy6pNCc
	 EEremrAe4kxS6g/ovFmRfwYNMc0OPf+45/pWQUuNSg1yFUtdZYaz7fa6FIGW9PcD+3
	 /nrM4Msf4Mx3po7XJWaxQEhUfZFHJwLoMPofgxe8U5q46kAt5M6Nsdgw9XKfMqxUis
	 PKvl4hup9/azf1Xw8541L8qJ5O/b0Jl742wgN0WgRrut7RdRcHcqS+B/vu51GsHYl7
	 w/UKbOeDNeL6wAAi6o9tTlb+T/WCXH6JnTtYWXKRa7WTEqqBKxoYR33cao96eW5R6n
	 dpsPBUChpjJaw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254e7bdfac1so280417fac.0;
        Mon, 17 Jun 2024 12:02:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2p1Y3gVOA/tNTGn8BZ3AfRfJFL6/bWpeN/y6pi4mHrj37tm4LboSm95YFBMGHF+j9+8XqYaB0p51yVeEjADb0jMsUu2S8AR0+ss8AVxrmhDxHHA4z+uuXepzijOL3WJZ/MLsYsS0=
X-Gm-Message-State: AOJu0Yw1ncTVpfBMuVCi1GUobbd+34PiaZoNcx40Wiwgs80FrlFsj+ID
	H8XI1M0rurK/iRa0+zia3/rkIjCdzxE+giXJisWcoe4wIp4QbiqlXlieIHsdr/7jxj4CO0dL4Hd
	49JMcY7ys1H+KyDYXkHTAN2jCfWY=
X-Google-Smtp-Source: AGHT+IGTqpy7xoT2jl9YetggBH57vfPKPydEed9o7YOYzQbquHL8zhjh8zehk88q1tuIeLeVH+uExQB6LaM29L+UT1M=
X-Received: by 2002:a4a:c482:0:b0:5bd:ad72:15d3 with SMTP id
 006d021491bc7-5bdadc0905fmr11140135eaf.1.1718650971801; Mon, 17 Jun 2024
 12:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8409966.T7Z3S40VBb@kreacher> <3312460.oiGErgHkdL@kreacher>
 <20240617183949.GO382677@ragnatech.se> <CAJZ5v0ggoTXMHxwjVy9OZ4sQU5UHPwEo1OwYwRFVTzsUErje5w@mail.gmail.com>
In-Reply-To: <CAJZ5v0ggoTXMHxwjVy9OZ4sQU5UHPwEo1OwYwRFVTzsUErje5w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 21:02:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLALNVdBQ3_Sg=5XEBzymyS-8bOscdPzg-MpqntX_9Ww@mail.gmail.com>
Message-ID: <CAJZ5v0hLALNVdBQ3_Sg=5XEBzymyS-8bOscdPzg-MpqntX_9Ww@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] thermal: trip: Replace thermal_zone_get_num_trips()
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:55=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Niklas,
>
> On Mon, Jun 17, 2024 at 8:39=E2=80=AFPM Niklas S=C3=B6derlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> >
> > Hi Rafael,
> >
> > Thanks for your patch.
> >
> > On 2024-06-17 20:11:30 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The only existing caller of thermal_zone_get_num_trips(), which is
> > > rcar_gen3_thermal_probe(), uses this function to check whether or
> > > not the number of trips in the given thermal zone is nonzero.
> > >
> > > Because it really only needs to know whether or not the given
> > > thermal zone is tripless, replace thermal_zone_get_num_trips() with
> > > thermal_zone_is_tripless() that can tell rcar_gen3_thermal_probe()
> > > exactly what it needs to know and make it call that function.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/thermal/renesas/rcar_gen3_thermal.c |    3 +--
> > >  drivers/thermal/thermal_trip.c              |    6 +++---
> > >  include/linux/thermal.h                     |    2 +-
> > >  3 files changed, 5 insertions(+), 6 deletions(-)
> > >
> > > Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
> > > +++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> > > @@ -563,8 +563,7 @@ static int rcar_gen3_thermal_probe(struc
> > >               if (ret)
> > >                       goto error_unregister;
> > >
> > > -             ret =3D thermal_zone_get_num_trips(tsc->zone);
> > > -             if (ret < 0)
> > > +             if (thermal_zone_is_tripless(tsc->zone))
> >
> > There are two issues with this change.
> >
> > 1. The original code only jumped to error_unregister if there where a
> >    negative number of trip points, presumably to allow for an error to
> >    be returned when reading the number of trip points.
> >
> >    If an negative error was found it was stored in ret, and this was
> >    then returned from the probe function after jumping to
> >    error_unregister. This change jumps to the error out path, but do no=
t
> >    fail probe.
> >
> >    However it is valid to complete probe without any trip points found.
> >    So failing probe on thermal_zone_is_tripless() is not desired.
> >
> > 2. The value returned from thermal_zone_get_num_trips() and stored in
> >    ret is used in a dev_info() below, logging how many trip points (if
> >    any) where found.
> >
> >    With this change that is no longer true and it will always log 0 tri=
p
> >    points found.
>
> You are right, I've overlooked the above.
>
> > As there is no long (if there ever where) a reason to check for errors
> > when reading the number of trip points, and no real use to log the
> > number of trip points found maybe a modified patch can do what you want
> > (not tested).
> >
> > - ret =3D thermal_zone_get_num_trips(tsc->zone);
> > - if (ret < 0)
> > -    goto error_unregister;
> > -
> > - dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
> > + dev_info(dev, "Sensor %u: Loaded %s trip points\n", i,
> > +       thermal_zone_is_tripless(tsc->zone) ? "with" : "without");
> >
> > What do you think?
>
> I would rather first update the driver to stop failing when the zone
> is tripless, in a separate patch.

Well, it actually never fails when the zone is tripless because
thermal_zone_get_num_trips() returns a non-negative value.

So something like the above patch, but using
thermal_zone_get_num_trips() or maybe just

- ret =3D thermal_zone_get_num_trips(tsc->zone);
- if (ret < 0)
-    goto error_unregister;
-
- dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
+ dev_info(dev, "Sensor %u: Loaded", i);

because the number of trips (and whether or not there are any) can be
checked via sysfs.

> Fortunately, the $subject patch is not really needed in the series, so
> please regard it as withdrawn for now and we can get back to this
> later.

But the above still holds.

Thanks!

