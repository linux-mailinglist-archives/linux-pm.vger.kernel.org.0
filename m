Return-Path: <linux-pm+bounces-16734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F219B63EE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 14:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B6C282A5A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD561FFE;
	Wed, 30 Oct 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFhl33wd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155C45023;
	Wed, 30 Oct 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294350; cv=none; b=ppobCqy7XhU1B6fjAfRsI6IweIdWWB9/CzQ9bMl2NxaJUu5sFNEXVeid34z+rx74zrhgptconRdyWIhfJ8a9cOgr3R+JwQMsTTgeo4pP7ytCuYbRU2tkXh8MFsS7Svr0Jh+aeWzm5GKiMOlONZlyrFrlkcNPPpdGn86jKIt3gRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294350; c=relaxed/simple;
	bh=MRhVGvEjNH1UbMzkczL8eF2VuudhtOy1eqfJ3bwrO9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3DzdxdEVswQju/LoSNBiJZ6v19Qg6RNVirL+414RdFYXunCNaNDrm1WV6q3iXDxICYYDHehq1UFqnEVKmIcZe9DfbzBrPsyvcYU/5Sww5Z5+vfu3sii57a6yiI2ltffGL9z5Iv3hwNEnLNtVzhfvxYQ28QJwtU67o+er4W5PB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFhl33wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1931C4CEE7;
	Wed, 30 Oct 2024 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730294350;
	bh=MRhVGvEjNH1UbMzkczL8eF2VuudhtOy1eqfJ3bwrO9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LFhl33wd3GK77vpOLJT3Dajw/7M9eloG81n4x+ouC3w4gTqWEK+5C7l/ytNRF7NMm
	 zNniqtPw3PM6vB6gOov0R8+F+4fduCi0IbeaAtBD9VFJqlHH75jZXgNxKFrzdcZof8
	 y3MQlasQ1YGRsoJIimKE06OPIgVvYNPQMCDpH+qt8Ro7ei+s/IbMIv1VbfhXiSMfqy
	 duSCJP90jirfJTTH35rzCARUIaFKEzb3+kWoMsgg6YmnkeTN03oUMRLQn3u1GqoZjc
	 PCdLjVaM4YszD98Azy2bJQHw+hI4II7e6xINjzFOd4zjPhoDrdnHCUlLFqc/Ws+qPU
	 5HMYnx/nT2BoQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288916b7fceso3531535fac.3;
        Wed, 30 Oct 2024 06:19:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU77co4+miLffQbJSVX2e0myXT6bPFdJQlN0wG5DbQv+kVAuazbQPfKWUlbV3uve171EBkXamY/qglqdco=@vger.kernel.org, AJvYcCUY/t9TRqhfLhiycJMwkwF7amokw06FdO4uawO/yZ2/OjnSYtLwwFXJaf0x5Uo1t/BkSIw3nwQQIBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hLC0faBAOecyVlRgdcloJ4J2Feh5NSL6aItbk+6OqAZczOl5
	eeiUSPbGhlETCIj3VyBZ589tDVIcJ09tyK91cqLo94wErFroMSM/a6gJTV08BIP1I68uW7pJlDb
	Lr0XQ01i8CnRVyyl2qWySvs/vuwk=
X-Google-Smtp-Source: AGHT+IHqc0ZQqOLpNLO0Vt1yDLQxgSgYmsVbhWlAHo5dc0xh3P8d6p1BgSrUVJL8sHjdKazU9SnkMkdG6hdWon9ozO8=
X-Received: by 2002:a05:6871:892:b0:288:679e:ca8a with SMTP id
 586e51a60fabf-29051bab57cmr14378101fac.18.1730294349115; Wed, 30 Oct 2024
 06:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029094452.495439-1-lukasz.luba@arm.com> <20241029094452.495439-2-lukasz.luba@arm.com>
 <CAJZ5v0jOYw6md9tnb1d=pQ_u06=rSiZ6FAEk1iaN47TO0w+XZQ@mail.gmail.com> <96e694e3-2a65-4f39-ad35-3d1e1459102f@arm.com>
In-Reply-To: <96e694e3-2a65-4f39-ad35-3d1e1459102f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Oct 2024 14:18:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hqMsvJQ4_cXtSFrznPrBSmbo0g7JEQ01ywFpbbN+U8tQ@mail.gmail.com>
Message-ID: <CAJZ5v0hqMsvJQ4_cXtSFrznPrBSmbo0g7JEQ01ywFpbbN+U8tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state limits
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 12:49=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/30/24 11:40, Rafael J. Wysocki wrote:
> > On Tue, Oct 29, 2024 at 10:43=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>
> >> On some devices there are HW dependencies for shared frequency and vol=
tage
> >> between devices. It will impact Energy Aware Scheduler (EAS) decision,
> >> where CPUs share the voltage & frequency domain with other CPUs or dev=
ices
> >> e.g.
> >> - Mid CPUs + Big CPU
> >> - Little CPU + L3 cache in DSU
> >> - some other device + Little CPUs
> >>
> >> Detailed explanation of one example:
> >> When the L3 cache frequency is increased, the affected Little CPUs mig=
ht
> >> run at higher voltage and frequency. That higher voltage causes higher=
 CPU
> >> power and thus more energy is used for running the tasks. This is
> >> important for background running tasks, which try to run on energy
> >> efficient CPUs.
> >>
> >> Therefore, add performance state limits which are applied for the devi=
ce
> >> (in this case CPU). This is important on SoCs with HW dependencies
> >> mentioned above so that the Energy Aware Scheduler (EAS) does not use
> >> performance states outside the valid min-max range for energy calculat=
ion.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   include/linux/energy_model.h | 24 ++++++++++++++---
> >>   kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++=
++
> >>   2 files changed, 72 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/energy_model.h b/include/linux/energy_model=
.h
> >> index 1ff52020cf757..e83bf230e18d1 100644
> >> --- a/include/linux/energy_model.h
> >> +++ b/include/linux/energy_model.h
> >> @@ -55,6 +55,8 @@ struct em_perf_table {
> >>    * struct em_perf_domain - Performance domain
> >>    * @em_table:          Pointer to the runtime modifiable em_perf_tab=
le
> >>    * @nr_perf_states:    Number of performance states
> >> + * @min_ps:            Minimum allowed Performance State index
> >> + * @max_ps:            Maximum allowed Performance State index
> >
> > Any problem with renaming these to min_perf_state and max_perf_state
> > respectively?
>
> OK, I will change those names.
>
> >
> > That would improve the code clarity quite a bit IMV.
> >
>
> [snip]
>
> >>   static inline int
> >>   em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_s=
tates,
> >> -                         unsigned long max_util, unsigned long pd_fla=
gs)
> >> +                         unsigned long max_util, unsigned long pd_fla=
gs,
> >> +                         int min_ps, int max_ps)
> >>   {
> >>          struct em_perf_state *ps;
> >>          int i;
> >>
> >> -       for (i =3D 0; i < nr_perf_states; i++) {
> >> +       for (i =3D min_ps; i <=3D max_ps; i++) {
> >>                  ps =3D &table[i];
> >>                  if (ps->performance >=3D max_util) {
> >>                          if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIEN=
CIES &&
> >> @@ -204,7 +213,7 @@ em_pd_get_efficient_state(struct em_perf_state *ta=
ble, int nr_perf_states,
> >>                  }
> >>          }
> >>
> >> -       return nr_perf_states - 1;
> >> +       return max_ps;
> >>   }
> >>
> >>   /**
> >> @@ -254,7 +263,8 @@ static inline unsigned long em_cpu_energy(struct e=
m_perf_domain *pd,
> >>           */
> >>          em_table =3D rcu_dereference(pd->em_table);
> >>          i =3D em_pd_get_efficient_state(em_table->state, pd->nr_perf_=
states,
> >> -                                     max_util, pd->flags);
> >> +                                     max_util, pd->flags, pd->min_ps,
> >> +                                     pd->max_ps);
> >
> > Couldn't em_pd_get_efficient_state() just take pd as an argument and
> > dereference it by itself?
> >
> > The code would be much easier to follow then.
>
> That's possible. I will keep the em_table rcu_dereference as is, so
> only the rest of arguments with 'pd->' will be taken inside
> em_pd_get_efficient_state().
>
> So the call would look like:
> em_pd_get_efficient_state(em_table->state, pd, max_util);

Yes, that's what I had in mind.

> Thanks for the review. I will send a v3.

Thank you!

