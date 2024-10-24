Return-Path: <linux-pm+bounces-16379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C39AE4C6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B02E284147
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED321D173E;
	Thu, 24 Oct 2024 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVZzg7aM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A321CACE9;
	Thu, 24 Oct 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773226; cv=none; b=OWBuYICnPNeS9YAMOIgwLx2gEuu9uiFp4QTVvR+VXYaNGV9MNdJBhySk96Z1rivM5zMS6VhZNe27xcz9aFEFeRhqSqztRnfQCqxYjEqtLaR1f7sX2nM6HTKOvN4rsiSDI0X+fd3I5VXsRjYwo6XKn29qOSMYyrTVsyZ+m+ealcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773226; c=relaxed/simple;
	bh=dYfmzmSe7qbgKOOt8aNPskAcFR6ELsZbR86hZoSQ1r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sh6tTRSLWZfrUZ5ap3Sc5K69ysptWF2ipMXKRW2npFgQ6/RdUsAPafEgJghW4Mnp0k4TIWrEgls7RzSpPvX8B7ORiG4JXtQzB69uijD5EiPl4uSaoxMYlOcDlZ0h7RVGnYy50ErecU2ZZJBQesQWRTlkwIiZLNFbm3etvu9pqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVZzg7aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A2DC4CEE3;
	Thu, 24 Oct 2024 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773225;
	bh=dYfmzmSe7qbgKOOt8aNPskAcFR6ELsZbR86hZoSQ1r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FVZzg7aMYr4Zi9mzT7iCQTb8LUmlt/VYSU94NuG6H+XFdK7FAhmz/YPoThmvSp+Xt
	 F3fEM/lAd4bvCGkPkQk7a9itSusWgqhptlUqZWGO3LYCqfl7LzTVL7hpOAslWpCdF4
	 NIfuFVET8Yui+YeUKs+grBkMuwru7tEGmlqouLDZ7y8v4hgpbKcjkfaX/JZrFGZQBp
	 6ssq8CV4e6QgztJ65IvfzUFlT9Ao01+LyU1JzCLPVTvw1Oinm1Ndo0tGHiJgLLBN/v
	 lJV1NnDQhwiqIiXRHGwaJd73MpF6zqbALEuOYd7kESw3qa7uTRmEIdNyljtALg1VU8
	 TWpHXXBrHtO9w==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-27ce4f37afeso598459fac.0;
        Thu, 24 Oct 2024 05:33:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYQgbvGc6acJ6/rgS0znQV2gp3rgO9pg52OEgTWrgxQ7DwhV4Kggis8fKjVc9wa6UkIGms4WfO81M=@vger.kernel.org, AJvYcCV4j2ofQNdvrRb6fVqH9NBlmxfi5hX2wTYAJQojgP8dZZiGVhOag9hgEWQN25OAM1XIJL6dr/+poduKU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIF9qFHbVRb5MRABlzaqQc3J53GBs8jG8ExXBaHc00pX0fAR+
	BAubsQoo4j7NP4DV3h39uHXQCLdfmzkIl/rEF2AowaWBHDt0vEMLdc9R4q1XelE7oNp8kbni65V
	oFXYj4hWW7qG6QQGx21zMgJSQ2tQ=
X-Google-Smtp-Source: AGHT+IG+e4nlGZUQryue2nbs6hhSww387TPz9uwQmdvgn0/4UAIwxNT/0wN7Xh00rcvSFwIpTUvkQMPeQGSZZeiQCPk=
X-Received: by 2002:a05:6870:b528:b0:270:1dab:64a9 with SMTP id
 586e51a60fabf-28ccb7ce1efmr6184141fac.14.1729773225082; Thu, 24 Oct 2024
 05:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4958885.31r3eYUQgx@rjwysocki.net> <1807510.VLH7GnMWUR@rjwysocki.net>
 <d2239ab1-ae95-4b51-9cc5-8aac9eb67970@arm.com>
In-Reply-To: <d2239ab1-ae95-4b51-9cc5-8aac9eb67970@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 14:33:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-T_ynbMsMrVndSHwCJP97A1-PX-p-NNskopO=i0xtpw@mail.gmail.com>
Message-ID: <CAJZ5v0j-T_ynbMsMrVndSHwCJP97A1-PX-p-NNskopO=i0xtpw@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] thermal: core: Eliminate thermal_zone_trip_down()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:32=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/16/24 12:33, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since thermal_zone_set_trip_temp() is not located in the same file
>
> nit: s/not/now

Thanks, will fix when applying the patch.

> > as thermal_trip_crossed(), it can invoke the latter directly without
> > using the thermal_zone_trip_down() wrapper that has no other users.
> >
> > Update thermal_zone_set_trip_temp() accordingly and drop
> > thermal_zone_trip_down().
> >
> > No functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c |    8 +-------
> >   drivers/thermal/thermal_core.h |    2 --
> >   2 files changed, 1 insertion(+), 9 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -565,7 +565,7 @@ void thermal_zone_set_trip_temp(struct t
> >                * are needed to compensate for the lack of it going forw=
ard.
> >                */
> >               if (tz->temperature >=3D td->threshold)
> > -                     thermal_zone_trip_down(tz, td);
> > +                     thermal_trip_crossed(tz, td, thermal_get_tz_gover=
nor(tz), false);
>
> minor thing:
> won't that be too long line?

It is longer than 80 characters, but this is not a hard boundary - see
"2) Breaking long lines and strings" in
Documentation/process/coding-style.rst).

Well, you can argue about the "hide information" part, but IMV this
line just looks cleaner the way it is than when it would be broken in
any way.

> IMHO we can add somewhere earlier:
> struct thermal_governor *gov =3D thermal_get_tz_governor(tz);
> and use it here

That would have been harder to follow than the current code IMO.

> >
> >               /*
> >                * Invalidate the threshold to avoid triggering a spuriou=
s
> > @@ -699,12 +699,6 @@ void thermal_zone_device_update(struct t
> >   }
> >   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
> >
> > -void thermal_zone_trip_down(struct thermal_zone_device *tz,
> > -                         struct thermal_trip_desc *td)
> > -{
> > -     thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
> > -}
> > -
> >   int for_each_thermal_governor(int (*cb)(struct thermal_governor *, vo=
id *),
> >                             void *data)
> >   {
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -273,8 +273,6 @@ void thermal_zone_set_trips(struct therm
> >   int thermal_zone_trip_id(const struct thermal_zone_device *tz,
> >                        const struct thermal_trip *trip);
> >   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp=
);
> > -void thermal_zone_trip_down(struct thermal_zone_device *tz,
> > -                         struct thermal_trip_desc *td);
> >   void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
> >                               struct thermal_trip *trip, int hyst);
> >
> >
> >
> >
>
> other than that, LGTM
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!

