Return-Path: <linux-pm+bounces-30481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379DAFE960
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579DC564233
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3602951A7;
	Wed,  9 Jul 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9cN77tY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403828DF42;
	Wed,  9 Jul 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065292; cv=none; b=U52J8/s6w3E5kq/tk4GR14AvGM8gtZL34Ybse3v+wEJjW9neD0G1JW4Ujk9w5/uOJofY64xvLHL1i+rqkSeRbYbemvRf/aPZfG++dtx8ojh/1iiF1cyWTqNp4qy/FcCoOBgqUkxDmd+LkJIfaerxxUIYu5PswLsv95QQQ7YVDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065292; c=relaxed/simple;
	bh=IjKafDrSKpDO3jWbUE5S33Zi4PuRIjRGcR1MuBt2QsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoCpoeMVq6UtFAgfO3xBNhi786G93OEQW7aUZYqJ240DNM60Y1StCba3FVm6h1764Z1SnLTnD5shlPSaxr8Aimx0oVIicPFsAGkiFDZnxDD0vKdTx4Lx3bTiCznmjpN5zOcMT0H4CQZ4lqjThEWsfTyJB6J4uq1Eui95G9B1wTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9cN77tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D06C4CEEF;
	Wed,  9 Jul 2025 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065292;
	bh=IjKafDrSKpDO3jWbUE5S33Zi4PuRIjRGcR1MuBt2QsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D9cN77tYsBx7RnFEQtcP4Bqg1Wqu7kNoj0aF+UP7qcq0dJWw0wCH/uUhGBWaopshB
	 71+AniRIHP/d22+LXp3v7RXvyA4YwdTkD8ibDgnyirVs+cuNS0NxjKoNeYLsA897Ot
	 WIFTJiLckNxn4uBd1fNhlsJ+C3ByidIxbZ4S5MK9LrPMZ5AKjOqBSOYDwrihKy83DK
	 P1GRWBp6f3kx61RTLxjHCqTPhvQtQ/yhpLXeIq9sJhXuI6NM2zD1s9W6Ojm6o3LQ5l
	 4FkJH3UWBZiFFqotlbIMb+Rz82nGTFUC6vHDRRisicM9mQKmD1Y7y8bZmvCJGrC0hO
	 KqdlO2NFtVTHA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60f0a92391bso2844156eaf.0;
        Wed, 09 Jul 2025 05:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6r4vVFNkc30NJX0m2fRJViOA+MMRSgPXN8Yw37BTaVfZNrwoTNBbvKsNW7LBT10YvOBzv0rKQL7c=@vger.kernel.org, AJvYcCWyi5i+Hl5qmt+Ep8guV523/zUnpRAw65cITBNwRE+GHtXhWPEdgdjemkJOBJrynf2qwat31vjbC8xpmig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhm5get1mugcWesDBz2Zlr4lSu31T0iJos24tlZnOHuxYv0gMd
	PA4KglA/JMK43t8f0E+yb9nM3KTJyM/44O/LFz2Dt2xl+LDZMBiChnb3lk7QKA+NGvlQU0rDLZt
	beRUXwYvE0EfF7DrA1SlUU9kI2EimwfI=
X-Google-Smtp-Source: AGHT+IEG7HX5l8eAamULm2qP4yxYrJlancU7qVZt40GWX3GoE5XQFna5v28re8xxoiPRwNMzlWvYRZDAzqoG/O0+7g4=
X-Received: by 2002:a4a:e912:0:b0:613:cafd:610 with SMTP id
 006d021491bc7-613ccedd834mr1557919eaf.7.1752065291018; Wed, 09 Jul 2025
 05:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12700973.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpGH=ZUyQ0wbkEKVLxknm59hDX6DNm9hXpuqzHCpoe-KQ@mail.gmail.com>
 <CAJZ5v0how7VXTjuxtd533zNeqKwCqnJDVVKK=Vpww_HbQkwxKw@mail.gmail.com>
In-Reply-To: <CAJZ5v0how7VXTjuxtd533zNeqKwCqnJDVVKK=Vpww_HbQkwxKw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 14:48:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0isuV-HDyGCrLeFp0WFcCQoQpi9dMEbJnWrsOdvk4Bf1A@mail.gmail.com>
X-Gm-Features: Ac12FXxWzmeQz1W1fKJ2C4G3hUpEArUz5F_Y7Bx1Mk9dwdcqkFiQ4FUOOpZ0ei0
Message-ID: <CAJZ5v0isuV-HDyGCrLeFp0WFcCQoQpi9dMEbJnWrsOdvk4Bf1A@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Alex Elder <elder@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:06=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Jul 9, 2025 at 1:47=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Wed, 9 Jul 2025 at 12:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > For all practical purposes, there is no difference between the situat=
ion
> > > in which a given device is not ignoring children and its active child
> > > count is nonzero and the situation in which its runtime PM usage coun=
ter
> > > is nonzero.  However, pm_runtime_get_if_in_use() will only increment =
the
> > > device's usage counter and return 1 in the latter case.
> > >
> > > For consistency, make it do so in the former case either by adjusting
> > > pm_runtime_get_conditional() and update the related kerneldoc comment=
s
> > > accordingly.
> > >
> > > Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active(=
) usage")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > >
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -1203,10 +1203,12 @@
> > >   *
> > >   * Return -EINVAL if runtime PM is disabled for @dev.
> > >   *
> > > - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and ei=
ther
> > > - * @ign_usage_count is %true or the runtime PM usage counter of @dev=
 is not
> > > - * zero, increment the usage counter of @dev and return 1. Otherwise=
, return 0
> > > - * without changing the usage counter.
> > > + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_u=
sage_count
> > > + * is set, or (2) @dev is not ignoring children and its active child=
 count is
> > > + * nonero, or (3) the runtime PM usage counter of @dev is not zero, =
increment
> > > + * the usage counter of @dev and return 1.
> > > + *
> > > + * Otherwise, return 0 without changing the usage counter.
> > >   *
> > >   * If @ign_usage_count is %true, this function can be used to preven=
t suspending
> > >   * the device when its runtime PM status is %RPM_ACTIVE.
> > > @@ -1228,7 +1230,8 @@
> > >                 retval =3D -EINVAL;
> > >         } else if (dev->power.runtime_status !=3D RPM_ACTIVE) {
> > >                 retval =3D 0;
> > > -       } else if (ign_usage_count) {
> > > +       } else if (ign_usage_count || (!dev->power.ignore_children &&
> > > +                  atomic_read(&dev->power.child_count) > 0)) {
> >
> > I am not sure I understand why this is needed, sorry.
> >
> > If someone and somehow we have "dev->power.runtime_status =3D=3D
> > RPM_ACTIVE", then the dev's parents/childrens and suppliers/consumers
> > should have been reference counted correctly already.
>
> Sure.
>
> > Otherwise it should not have been possible to set the runtime_status to=
 RPM_ACTIVE
> > in the first place, right?
>
> Right.
>
> runtime_status must be RPM_ACTIVE, but pm_runtime_get_if_in_use() only
> wants to bump it up if the device is in use in addition to that.

I mean pm_runtime_get_if_in_use() only wants to bump up the device's
usage counter if it is in use already.

> So far it's been checking the usage counter only though.

And the above is correct.

> >
> > >                 retval =3D 1;
> > >                 atomic_inc(&dev->power.usage_count);
> > >         } else {
> > > @@ -1261,10 +1264,16 @@
> > >   * @dev: Target device.
> > >   *
> > >   * Increment the runtime PM usage counter of @dev if its runtime PM =
status is
> > > - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, i=
n which case
> > > - * it returns 1. If the device is in a different state or its usage_=
count is 0,
> > > - * 0 is returned. -EINVAL is returned if runtime PM is disabled for =
the device,
> > > - * in which case also the usage_count will remain unmodified.
> > > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or=
 it is not
> > > + * ignoring children and its active child count is nonzero.  1 is re=
turned in
> > > + * this case.
> > > + *
> > > + * If @dev is in a different state or it is not in use (that is, its=
 usage
> > > + * counter is 0, or it is ignoring children, or its active child cou=
nt is 0),
> > > + * 0 is returned.
> > > + *
> > > + * -EINVAL is returned if runtime PM is disabled for the device, in =
which case
> > > + * also the usage counter of @dev is not updated.
> > >   */
> > >  int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > >
> > >
> > >
> >
> > Kind regards
> > Uffe
> >

