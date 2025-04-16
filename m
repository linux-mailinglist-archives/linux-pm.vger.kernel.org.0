Return-Path: <linux-pm+bounces-25545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C435A8B80B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2809D444D6E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964512459DF;
	Wed, 16 Apr 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb9+z3he"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA84243947;
	Wed, 16 Apr 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804750; cv=none; b=DwXuhyWGTOvAOYLgO0Jb55xu67okxRqJe/MJQ7XhJwU33se18rbJjd/qjL0yZcQPfz5mkBDbXP322PMU3wWi/bAeOUvxQw0eMs6+AsyldEfGeXADOrfYgx62gc7wR8Y3P0Ct57wiABbb1AlpkWz/05T59VraCAmepRQFjj14Obw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804750; c=relaxed/simple;
	bh=ALtJQWXgZ6dN7/4UoANBpoZDVZTBpnr7WjxXKFApxyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP1DfNKFPQSyO8aRMyVqU12h5ojrDNpOMDXhc1tgvKXMm8nE5K5EpC1Ms/j7ewrEK5jG/PRGx74mEDPqJsmHMVY9uib6AD1/yUtROqjzjN4iTpLIsCuy/D0jGSjZ5GJJ4b4bJfBv23JrvCTFSx2lNu0x3W7nyaBG2N9cqKwtOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb9+z3he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC571C4AF0B;
	Wed, 16 Apr 2025 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744804748;
	bh=ALtJQWXgZ6dN7/4UoANBpoZDVZTBpnr7WjxXKFApxyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hb9+z3heJulB223YkFfTYprUoXmfjh1/NpF+gh80Ps9qeEfzFVmn79lu8eLWRhIQS
	 w9ISqlHxsRCPf+Mg1F7PtVduS632OV/90K+mGzEHV/+4oYAt5EAhvQJo7HCk2JMn9s
	 IIPiUecrzG0i586fNUL0hBde4A5HWuqajs76qiQsdTXbloZLTv4Yxg4CxaLEiXWhDD
	 Od9h+oQLNCsyK4M9lAQANvfB6Qwep1fKgUnnojJe5iN59mP7EhCmUWgcFpsHVex4jn
	 9Q3nfbQA3LSvrBWuYr/F9LctHu9xMr8GRggXzXRV6wpbucMXYGC+xz/NYOggSbOHxS
	 agronkrJ78Flw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c7b2c14455so4296331fac.2;
        Wed, 16 Apr 2025 04:59:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQ3xnT+V9odSHj2JlQdUvNLv3r2ycbcH8Hubb59eCWXTUpIIgEClOLb8k75J0LRjjZ188tVXBchXiUPuU=@vger.kernel.org, AJvYcCWmdKQGnHjqS6QX6wu9yG6hyIKAFGPM3Y1JibUAKvYQXBQHNvFJC/E1hJASwbQvPdmeCoKPpZ4TtuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5z9nKX4df7Enlp6NcxwCo2SIvl8cfV36V7upMBe1XlH8mjrTe
	v+1ApFKdoa1LK6SrVs8r9pXp4dzBl7TLdEHlcFf4M5mNcwCJ8KBZN+KCZX29Z1EjgfSzJOIMLx6
	tg/eyBeWM68hkeYYba4sqy8PAWZM=
X-Google-Smtp-Source: AGHT+IEOcIVMxPhD85Zgkg4nhoiGIkKp4+2/bsREymu1TNHKVG4+1Cg/k72QVd3D1cutVfhQ21BsE0D/9orPt13jsKQ=
X-Received: by 2002:a05:6870:596:b0:2d4:e101:13dd with SMTP id
 586e51a60fabf-2d4e1011ad8mr225979fac.1.1744804748169; Wed, 16 Apr 2025
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com> <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
 <tencent_8E3A87C6D6A193F757BA846F0C41887CC405@qq.com>
In-Reply-To: <tencent_8E3A87C6D6A193F757BA846F0C41887CC405@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 13:58:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iq4bw3WAk1yQRP=B3zk-rRYwibKNRjSfu=PGqTt6RNYw@mail.gmail.com>
X-Gm-Features: ATxdqUE-tmeeHAEfid9e8PoBcQlKbHjRF175tpJhnR3Wn_yFirnDS7kDRNAlGeA
Message-ID: <CAJZ5v0iq4bw3WAk1yQRP=B3zk-rRYwibKNRjSfu=PGqTt6RNYw@mail.gmail.com>
Subject: Re: [PATCH v3] PM: EM: Fix potential division-by-zero error in em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:57=E2=80=AFAM Yaxiong Tian <iambestgod@qq.com> wr=
ote:
>
> =E5=9C=A8 2025/4/16 01:17, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Apr 14, 2025 at 11:09=E2=80=AFAM Yaxiong Tian <iambestgod@qq.co=
m> wrote:
> >>
> >> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> >>
> >> When the device is of a non-CPU type, table[i].performance won't be
> >> initialized in the previous em_init_performance(), resulting in divisi=
on
> >> by zero when calculating costs in em_compute_costs().
> >>
> >> Since the 'cost' algorithm is only used for EAS energy efficiency
> >> calculations and is currently not utilized by other device drivers, we
> >> should add the _is_cpu_device(dev) check to prevent this division-by-z=
ero
> >> issue.
> >>
> >> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove di=
vision")
> >
> > Please look at the Fixes: tags in the kernel git history.  They don't
> > look like the one above.
> >
> Yes, there's an extra '<>' here.
>
> >> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> >> ---
> >>   kernel/power/energy_model.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> >> index d9b7e2b38c7a..fc972cc1fc12 100644
> >> --- a/kernel/power/energy_model.c
> >> +++ b/kernel/power/energy_model.c
> >> @@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, st=
ruct em_perf_state *table,
> >>
> >>          /* Compute the cost of each performance state. */
> >>          for (i =3D nr_states - 1; i >=3D 0; i--) {
> >> -               unsigned long power_res, cost;
> >> +               unsigned long power_res, cost =3D 0;
> >>
> >>                  if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_co=
st) {
> >>                          ret =3D cb->get_cost(dev, table[i].frequency,=
 &cost);
> >> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, st=
ruct em_perf_state *table,
> >>                                          cost, ret);
> >>                                  return -EINVAL;
> >>                          }
> >> -               } else {
> >> +               } else if (_is_cpu_device(dev)) {
> >
> > Can't you just check this upfront at the beginning of the function and
> > make it bail out if dev is not a CPU device?
> >
> Sure, But the current implementation applies em_compute_costs() to both
> non-CPU devices and CPU devices.

Maybe it shouldn't do that for non-CPU ones?

> After carefully reviewing the latest code,
> I've found this issue has expanded in scope.
>
> There are currently three call paths for invoking em_compute_costs():
>
> 1) Registering performance domains (for both non-CPU and CPU devices)
> em_dev_register_perf_domain() =E2=86=92 em_create_pd() =E2=86=92
> em_create_perf_table() =E2=86=92 em_compute_costs()
>
> 2)EM update paths (CPU devices only)
>
> Periodic 1000ms update check via em_update_work work item:
> em_check_capacity_update() =E2=86=92 em_adjust_new_capacity() =E2=86=92
> em_recalc_and_update() =E2=86=92 em_compute_costs()
>
> Exynos-chip initialization:
> em_dev_update_chip_binning() =E2=86=92 em_recalc_and_update() =E2=86=92 e=
m_compute_costs()
>
> 3) Device cost computation (non-CPU devices only - currently unused)
> em_dev_compute_costs() =E2=86=92 em_compute_costs()

So because this one is unused and AFAICS the cost values are never
used for non-CPU devices, it's better to just avoid computing them at
all.

> Note: In em_dev_compute_costs(), when calling em_compute_costs(),
> neither the callback (cb) nor flags are set.In fact, it either does
> nothing at all or performs incorrect operations.
>
> Therefore, should we mandate that non-CPU devices must provide a
> get_cost callback?

Why would that be an improvement?

> So Should we add a check at the beginning of the em_compute_costs() to:
>
>         if (!_is_cpu_device(dev) && !cb->get_cost) {
>                 dev_dbg(dev, "EM: No get_cost provided, cost unset.\n");
>                 return 0;
>         }
> And Modify em_dev_compute_costs() to require callers to provide the cb
> callback function,Also need to update its corresponding comments.
>
>
> >>                          /* increase resolution of 'cost' precision */
> >>                          power_res =3D table[i].power * 10;
> >>                          cost =3D power_res / table[i].performance;
> >> --

I think until there is a user of em_dev_compute_costs() this is all
moot and hard to figure out.

I would drop em_dev_compute_costs() altogether for now and put a
_is_cpu_device(dev) upfront check into em_compute_costs().

