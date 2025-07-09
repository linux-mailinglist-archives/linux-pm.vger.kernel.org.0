Return-Path: <linux-pm+bounces-30478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C4AFE88F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 14:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBDC586EB0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2AE2D7816;
	Wed,  9 Jul 2025 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrwceOhK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8C28DB63;
	Wed,  9 Jul 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062776; cv=none; b=HinVDDByVsrWerbCG6Br+k2XCANapacFZZcOWByRShNS+nKmmj7GKgTcU3h9iMoLc/SOAECet5ml0JybCKw1VS1XZsngJM3PXU5wBnyay71VoUUJWKPAfF3ugHmgYbGpiy6zF5gQ7oAIDieSn1/Q3GINpG8Bo5qaGXOAuIo2RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062776; c=relaxed/simple;
	bh=z4dEedgScU/YlCD+6MrgxXXsdNr/vbYWdMeF3oXSnMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLqJJpWvPkUb2ntK1waFwFf75WJN0jy+dYV0d1LsjqQlxeZbaeBPavevlANofmmMwrGx6UaBZ7FoNus+9AIH1cxIISurTycy+oJgXd4+wH/EqIlkAC3KbyR3TeDmRsVyLD/cFa7lQ9Uh+vxXZuXZAyQT+WEzFt3XRFcUD0/NYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrwceOhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98FAC4CEF4;
	Wed,  9 Jul 2025 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062775;
	bh=z4dEedgScU/YlCD+6MrgxXXsdNr/vbYWdMeF3oXSnMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IrwceOhKqPRzVM2Zlb6p8jV+n0K+kX8zwnjKzPRKNLJxEV1CYWFKxG95u4IzX/S6d
	 SRT+hdi7itRA3wpk6bmEIVTFoHhNk2PgS4qbVd1lrdQM8cXTp8DH85L5dgaAjPobkc
	 rTZsDzpadjp2N0MiTem0UQ2WpD0CvHXffZgRBpK2FfuQD/Vcpr3dFabXR6zykEljT+
	 AxJ+5830Xp/9F3AsBIoCXqH4/Nn5yjgspbKj8OExIcCIuQ7j4djMzTg8EP341hz7XJ
	 ByHn9NMcFcl1cFHjuyYCqQ3D7mFXrROqrUo59JrTYWYd9mFXirHnv9Q4AwHtZsCYu8
	 TEhOHwyEOnUHQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-611f48c6e30so3024776eaf.0;
        Wed, 09 Jul 2025 05:06:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp1VmTCG3uJ4plN/mveeF1NrWi2IT+tuuWasigUPFNZXMwnAI1HMSOqDkq+GaFiECDg9Pa4aNcImA=@vger.kernel.org, AJvYcCXh7XUzn2kEVzR6fkDSFmaRhe33dHVoVoyLyIoNwcrn/xoa9nizXu2oZVplT1mdNUMz1+pu+mqRfCAWOoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZSCGH9suwE7Wz2slQ2MLA+h3sDZ/WgMcTQHItQDjYk4Z6b3P
	T5fkmAddQmdwFiYkKigpcnwT61fYA+MVSrWWd+LjjwYewUn6ln1dTdsVUHox9Cozx1DoBtnC4j9
	UTACsm9tU0nbuLHuf6EXV/wrmEjxIGzc=
X-Google-Smtp-Source: AGHT+IHQ8lmhJmj/6RKKyXpl7wIV2VdST7LucNcCsLdv5I5BpinmjtFK/W5HkN7Y9rLe46Hi3/jgjiEuWn/aL42UXc8=
X-Received: by 2002:a05:6820:6ac3:b0:611:f244:dfa5 with SMTP id
 006d021491bc7-613ccd51bcamr1484661eaf.2.1752062774849; Wed, 09 Jul 2025
 05:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12700973.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpGH=ZUyQ0wbkEKVLxknm59hDX6DNm9hXpuqzHCpoe-KQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpGH=ZUyQ0wbkEKVLxknm59hDX6DNm9hXpuqzHCpoe-KQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 14:06:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0how7VXTjuxtd533zNeqKwCqnJDVVKK=Vpww_HbQkwxKw@mail.gmail.com>
X-Gm-Features: Ac12FXxZ7A0lgWqr6kxxSE0vDTlSWv5NCsnYwahPNyUhL3bRWdRDWxQl93kkXcc
Message-ID: <CAJZ5v0how7VXTjuxtd533zNeqKwCqnJDVVKK=Vpww_HbQkwxKw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Alex Elder <elder@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:47=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Wed, 9 Jul 2025 at 12:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > For all practical purposes, there is no difference between the situatio=
n
> > in which a given device is not ignoring children and its active child
> > count is nonzero and the situation in which its runtime PM usage counte=
r
> > is nonzero.  However, pm_runtime_get_if_in_use() will only increment th=
e
> > device's usage counter and return 1 in the latter case.
> >
> > For consistency, make it do so in the former case either by adjusting
> > pm_runtime_get_conditional() and update the related kerneldoc comments
> > accordingly.
> >
> > Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() =
usage")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1203,10 +1203,12 @@
> >   *
> >   * Return -EINVAL if runtime PM is disabled for @dev.
> >   *
> > - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and eith=
er
> > - * @ign_usage_count is %true or the runtime PM usage counter of @dev i=
s not
> > - * zero, increment the usage counter of @dev and return 1. Otherwise, =
return 0
> > - * without changing the usage counter.
> > + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usa=
ge_count
> > + * is set, or (2) @dev is not ignoring children and its active child c=
ount is
> > + * nonero, or (3) the runtime PM usage counter of @dev is not zero, in=
crement
> > + * the usage counter of @dev and return 1.
> > + *
> > + * Otherwise, return 0 without changing the usage counter.
> >   *
> >   * If @ign_usage_count is %true, this function can be used to prevent =
suspending
> >   * the device when its runtime PM status is %RPM_ACTIVE.
> > @@ -1228,7 +1230,8 @@
> >                 retval =3D -EINVAL;
> >         } else if (dev->power.runtime_status !=3D RPM_ACTIVE) {
> >                 retval =3D 0;
> > -       } else if (ign_usage_count) {
> > +       } else if (ign_usage_count || (!dev->power.ignore_children &&
> > +                  atomic_read(&dev->power.child_count) > 0)) {
>
> I am not sure I understand why this is needed, sorry.
>
> If someone and somehow we have "dev->power.runtime_status =3D=3D
> RPM_ACTIVE", then the dev's parents/childrens and suppliers/consumers
> should have been reference counted correctly already.

Sure.

> Otherwise it should not have been possible to set the runtime_status to R=
PM_ACTIVE
> in the first place, right?

Right.

runtime_status must be RPM_ACTIVE, but pm_runtime_get_if_in_use() only
wants to bump it up if the device is in use in addition to that.

So far it's been checking the usage counter only though.

Thanks!

>
> >                 retval =3D 1;
> >                 atomic_inc(&dev->power.usage_count);
> >         } else {
> > @@ -1261,10 +1264,16 @@
> >   * @dev: Target device.
> >   *
> >   * Increment the runtime PM usage counter of @dev if its runtime PM st=
atus is
> > - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in =
which case
> > - * it returns 1. If the device is in a different state or its usage_co=
unt is 0,
> > - * 0 is returned. -EINVAL is returned if runtime PM is disabled for th=
e device,
> > - * in which case also the usage_count will remain unmodified.
> > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or i=
t is not
> > + * ignoring children and its active child count is nonzero.  1 is retu=
rned in
> > + * this case.
> > + *
> > + * If @dev is in a different state or it is not in use (that is, its u=
sage
> > + * counter is 0, or it is ignoring children, or its active child count=
 is 0),
> > + * 0 is returned.
> > + *
> > + * -EINVAL is returned if runtime PM is disabled for the device, in wh=
ich case
> > + * also the usage counter of @dev is not updated.
> >   */
> >  int pm_runtime_get_if_in_use(struct device *dev)
> >  {
> >
> >
> >
>
> Kind regards
> Uffe
>

