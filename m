Return-Path: <linux-pm+bounces-26474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02404AA54A5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 21:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B117A7D2F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 19:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DB265616;
	Wed, 30 Apr 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC75ruCj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274C13FEE;
	Wed, 30 Apr 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040997; cv=none; b=jMl73iM+hzI5yUCxoPvaNmA6OQiX7WJnencPiknprKChyGJ0an7umgm2QH13SoW/dx9ucJL7wMeswZ0SLOmXKvEjmLrGjvkFgg9xoGU9uiuLBYAmZbsZti781EJY/84vbkxJT0cYQ3zsTk/YIk6njZWRNlBsbBRQNDaiqvsBvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040997; c=relaxed/simple;
	bh=qKVf2uWtAWkcLqWXv30hNFM5h1+cdnihKyt11hHc+hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9aOvdXEbx2jJQ1XDWrR1XawnQwynDbnzusPTLgnQaACt/2H+mRt16k+X3zNF4nuWk9hHvE/ingzUHbnA6g8sT968+4che8M8PHIUUPizDRwvKMuJL3gkAGuOdZ9jLPvVI+9lvME0PRJiMzrhCGLt+uOuZNey1wcucPahoFEueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC75ruCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA801C4CEEA;
	Wed, 30 Apr 2025 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746040997;
	bh=qKVf2uWtAWkcLqWXv30hNFM5h1+cdnihKyt11hHc+hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LC75ruCjBH4uMwAGgzNxoB/8wwIOVVlA94h/AVRzIYXV//1sf1HC21L7Q934nFS7H
	 xwuCJP0pdBJ4xWajj3CchWwl+EakLPHMnlDUPfvGUGqzv/ukd36JepttJK+iTmaLFd
	 dULOX24Oz5Ef8errz0xeelJQaBqVDHFE7Jx6XYXxlao43hEWIge5yuMmPnO7gTUMvT
	 IzP2ecs4Vv/78L3DmyfHuLzeBHE7krmZNkCldqv4ZD46xNBERLKgAJKk6C3gCwMmB0
	 AyfexQkzAUzC/SROESUN37BA+Rsc0gzxTYQK9tNnzmb27LlCn5jQNwoift6Xnan9+s
	 7VnPj82TIMToQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d522f699bcso151041fac.2;
        Wed, 30 Apr 2025 12:23:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSvXm54CCcvLiPmP/w4ef2XMDQtKmLglLBPnle2oNgExinnawf9tEwd9FMxx+dIdxbwgSp2CLkXXI=@vger.kernel.org, AJvYcCUqRQc9qOLxPvjZ+0HbGPHOcYivt7KGsCrAj8VJIJGCecf3BzeDkr9z0J0hC7K4Maja6TFAUUgCNJkYwWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3T6fmvlstSCLhLS9XgWuyNdAVdU/5kYswQPw7UN1HKHslGLpL
	DItMdqISPgxcU0JKq7Zl/O0iJ6iRF0dB/r/rPDY2SF1ei0ba+ZfYImABHBdKUSxAR7VObwbfOC5
	hxROJvAdbRV0I95usBrRjajPLW/g=
X-Google-Smtp-Source: AGHT+IHUI53IjqhLZsoXIyntYPJj60++S86bTyvBt+MxGDWfXCH4PkyX07o7wwNCWcSsFqFn39gXAo2z0Y7G4R96d30=
X-Received: by 2002:a05:6871:7411:b0:2d6:6639:52d9 with SMTP id
 586e51a60fabf-2da6d21df4bmr2159551fac.32.1746040996276; Wed, 30 Apr 2025
 12:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3344336.aeNJFYEL58@rjwysocki.net> <2649447.Lt9SDvczpP@rjwysocki.net>
 <61cd69f5-6790-4480-8fe7-77ef763ed82b@arm.com>
In-Reply-To: <61cd69f5-6790-4480-8fe7-77ef763ed82b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 21:23:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=wR464YqDEesnm3QscJ4UBy8CX0ixZV6QsY0DS22E8A@mail.gmail.com>
X-Gm-Features: ATxdqUEKeMYWqWS1_ddAWAHbKbg2c8smMMVFYd6PIHbsAluPm-bSN46sfBJtq1w
Message-ID: <CAJZ5v0h=wR464YqDEesnm3QscJ4UBy8CX0ixZV6QsY0DS22E8A@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 5/8] PM: EM: Introduce em_adjust_cpu_capacity()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 4:07=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 16/04/2025 20:06, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a function for updating the Energy Model for a CPU after its
> > capacity has changed, which subsequently will be used by the
> > intel_pstate driver.
> >
> > An EM_PERF_DOMAIN_ARTIFICIAL check is added to em_adjust_new_capacity()
> > to prevent it from calling em_compute_costs() for an "artificial" perf
> > domain with a NULL cb parameter which would cause it to crash.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
> >
> > v0.3 -> v1:
> >      * Added R-by from Lukasz.
> >
> > ---
> >  include/linux/energy_model.h |    2 ++
> >  kernel/power/energy_model.c  |   28 ++++++++++++++++++++++++----
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> >
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -179,6 +179,7 @@
> >  int em_dev_update_chip_binning(struct device *dev);
> >  int em_update_performance_limits(struct em_perf_domain *pd,
> >               unsigned long freq_min_khz, unsigned long freq_max_khz);
> > +void em_adjust_cpu_capacity(unsigned int cpu);
> >  void em_rebuild_sched_domains(void);
> >
> >  /**
> > @@ -405,6 +406,7 @@
> >  {
> >       return -EINVAL;
> >  }
> > +static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
> >  static inline void em_rebuild_sched_domains(void) {}
> >  #endif
> >
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -698,10 +698,12 @@
> >  {
> >       int ret;
> >
> > -     ret =3D em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_=
states,
> > -                            pd->flags);
> > -     if (ret)
> > -             goto free_em_table;
> > +     if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
>
> This looks weird to me. How can an artificial EM ever have a non-ZERO
> em_data_callback here?
>
> There is already EM_PERF_DOMAIN_ARTIFICIAL specific handling in
> em_compute_costs(). Which probably works well for the
> em_create_perf_table() call-site.

Yes, but that one doesn't pass a NULL cb pointer to it.

> Will there be cases for Hybrid CPU EM's in which 'em_max_perf !=3D
> cpu_capacity':

When the capacity is updated, the EM needs to be updated accordingly,
which is why the new function is being added.

> em_adjust_new_capacity()
>
>   if (em_max_perf =3D=3D cpu_capacity)
>     return
>
>   em_recalc_and_update()
>     em_compute_costs()
>
> so that em_compute_costs() might be called?
>
> Maybe:
>
> @@ -233,11 +237,17 @@ static int em_compute_costs(struct device *dev,
> struct em_perf_state *table,
>         unsigned long prev_cost =3D ULONG_MAX;
>         int i, ret;
>
> +       if (!cb && (flags & EM_PERF_DOMAIN_ARTIFICIAL))
> +               return 0;
>
> is somehow clearer in this case?

This would work, but I prefer my version because it does one check
less and it does the check directly in em_recalc_and_update(), so it
is clear that this doesn't call em_compute_costs() for artificial PDs
at all.

