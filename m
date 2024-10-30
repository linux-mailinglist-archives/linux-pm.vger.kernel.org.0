Return-Path: <linux-pm+bounces-16720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B89B6212
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3011C21D7B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360101E3DD8;
	Wed, 30 Oct 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd0GaLib"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3071E1C07;
	Wed, 30 Oct 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288451; cv=none; b=fbM9/S2hGA6bMIjp1eOjxSd7REpUFZDFSZt9V/XqWGwCuCPoeRpBDQU4nBJ7O1jbIbpB3eHu2WSY/U3d3qsh8net3Ek7SPqWe1O1tQl6tF98PT15R+2BC2NSAm0xko4D43PV7tmB9Kxeq9tryAoOaVSL949P+4E1l12TAbfOS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288451; c=relaxed/simple;
	bh=/c+0wPmepFM9QFC/PHGrvTbqxNAhvbln9sczNI+F5CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZqVOuApMapX7K6VnRFDpBopf/SrWXdXfvK9JyH1T5mtmtJJlNNake1/K0vLfuSRB+NpPHgGzHpok1SB6vn1llMa4xCrcj8/PW3393kinU5XZ8tDqSemhwP3ZgK8timgHE+3SD4lUbF/i83FP4XtiHFlozFZBWkQtom1hPx7QDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd0GaLib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F62CC4CEE3;
	Wed, 30 Oct 2024 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730288450;
	bh=/c+0wPmepFM9QFC/PHGrvTbqxNAhvbln9sczNI+F5CU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vd0GaLibLclSWIbufP6fPs7Xg94+l4VhO0EzamrJVChgE371mrSCMDwr7w9I+htjQ
	 W2azowOcapkXuO9Juiv3yHq+zuCpWo9BqS5eiHujdCsUr9AvsPJIswECym7ToDfcvh
	 bjTDWHuG+88kFg90Nc7PghtYwvkyLpmHNgBV5YnoksoCMu7G8rEZfU6WJ/lqwfq31x
	 Xl6IowtMNhdKDuwsiLZLpz5mq5qIDsStHEbHbDK7TLoqm4EAfIuMRmO9H2pBM5sU4q
	 s8CBOo4EjatdF4USeZIpH9atj0pE9GWKUEPSOEv8gGxtCo37JzgTRKrD+r29bwWiwk
	 LAowhLHLUI+IQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5eba450531eso414784eaf.1;
        Wed, 30 Oct 2024 04:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhBqbQei4a2eORoJ9xneT1SQevvqtOwbcsY5lzWvIKKcJAeLWpoXuPfS/BWVXc9lORYdxOco2edA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuQqV/1JfAwVOFNxFWsqK9heaEAiUhgxPDZ30eZ4nplnZCohM
	N3X1iIJAMvGzV50zkwVew4ve5asPZaAkgHtlFBDIdt0uKpi2L6zI6LprX+tbSW5NRTQw7dfeEuj
	JzTPaKJIGtOjXnv5V+xdVxrHOoFE=
X-Google-Smtp-Source: AGHT+IGL6cchEHKCzv9gx+ilv3zmvLQH3b2D+LFw7ZzrKA4XGb45Mas/SBwLtBIbEf3y6kC777gg7cmkPBnpQ/zWY9k=
X-Received: by 2002:a05:6870:ac24:b0:277:d8c3:b539 with SMTP id
 586e51a60fabf-2946af0394cmr1016195fac.16.1730288449911; Wed, 30 Oct 2024
 04:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029094452.495439-1-lukasz.luba@arm.com> <20241029094452.495439-2-lukasz.luba@arm.com>
In-Reply-To: <20241029094452.495439-2-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Oct 2024 12:40:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jOYw6md9tnb1d=pQ_u06=rSiZ6FAEk1iaN47TO0w+XZQ@mail.gmail.com>
Message-ID: <CAJZ5v0jOYw6md9tnb1d=pQ_u06=rSiZ6FAEk1iaN47TO0w+XZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state limits
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dietmar.eggemann@arm.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:43=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> On some devices there are HW dependencies for shared frequency and voltag=
e
> between devices. It will impact Energy Aware Scheduler (EAS) decision,
> where CPUs share the voltage & frequency domain with other CPUs or device=
s
> e.g.
> - Mid CPUs + Big CPU
> - Little CPU + L3 cache in DSU
> - some other device + Little CPUs
>
> Detailed explanation of one example:
> When the L3 cache frequency is increased, the affected Little CPUs might
> run at higher voltage and frequency. That higher voltage causes higher CP=
U
> power and thus more energy is used for running the tasks. This is
> important for background running tasks, which try to run on energy
> efficient CPUs.
>
> Therefore, add performance state limits which are applied for the device
> (in this case CPU). This is important on SoCs with HW dependencies
> mentioned above so that the Energy Aware Scheduler (EAS) does not use
> performance states outside the valid min-max range for energy calculation=
.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 24 ++++++++++++++---
>  kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 1ff52020cf757..e83bf230e18d1 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -55,6 +55,8 @@ struct em_perf_table {
>   * struct em_perf_domain - Performance domain
>   * @em_table:          Pointer to the runtime modifiable em_perf_table
>   * @nr_perf_states:    Number of performance states
> + * @min_ps:            Minimum allowed Performance State index
> + * @max_ps:            Maximum allowed Performance State index

Any problem with renaming these to min_perf_state and max_perf_state
respectively?

That would improve the code clarity quite a bit IMV.

>   * @flags:             See "em_perf_domain flags"
>   * @cpus:              Cpumask covering the CPUs of the domain. It's her=
e
>   *                     for performance reasons to avoid potential cache
> @@ -70,6 +72,8 @@ struct em_perf_table {
>  struct em_perf_domain {
>         struct em_perf_table __rcu *em_table;
>         int nr_perf_states;
> +       int min_ps;
> +       int max_ps;
>         unsigned long flags;
>         unsigned long cpus[];
>  };
> @@ -173,6 +177,8 @@ void em_table_free(struct em_perf_table __rcu *table)=
;
>  int em_dev_compute_costs(struct device *dev, struct em_perf_state *table=
,
>                          int nr_states);
>  int em_dev_update_chip_binning(struct device *dev);
> +int em_update_performance_limits(struct em_perf_domain *pd,
> +               unsigned long freq_min_khz, unsigned long freq_max_khz);
>
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from=
 the EM
> @@ -180,6 +186,8 @@ int em_dev_update_chip_binning(struct device *dev);
>   * @nr_perf_states:    Number of performance states
>   * @max_util:          Max utilization to map with the EM
>   * @pd_flags:          Performance Domain flags
> + * @min_ps:            Minimum allowed Performance State index
> + * @max_ps:            Maximum allowed Performance State index
>   *
>   * It is called from the scheduler code quite frequently and as a conseq=
uence
>   * doesn't implement any check.
> @@ -189,12 +197,13 @@ int em_dev_update_chip_binning(struct device *dev);
>   */
>  static inline int
>  em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_state=
s,
> -                         unsigned long max_util, unsigned long pd_flags)
> +                         unsigned long max_util, unsigned long pd_flags,
> +                         int min_ps, int max_ps)
>  {
>         struct em_perf_state *ps;
>         int i;
>
> -       for (i =3D 0; i < nr_perf_states; i++) {
> +       for (i =3D min_ps; i <=3D max_ps; i++) {
>                 ps =3D &table[i];
>                 if (ps->performance >=3D max_util) {
>                         if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES=
 &&
> @@ -204,7 +213,7 @@ em_pd_get_efficient_state(struct em_perf_state *table=
, int nr_perf_states,
>                 }
>         }
>
> -       return nr_perf_states - 1;
> +       return max_ps;
>  }
>
>  /**
> @@ -254,7 +263,8 @@ static inline unsigned long em_cpu_energy(struct em_p=
erf_domain *pd,
>          */
>         em_table =3D rcu_dereference(pd->em_table);
>         i =3D em_pd_get_efficient_state(em_table->state, pd->nr_perf_stat=
es,
> -                                     max_util, pd->flags);
> +                                     max_util, pd->flags, pd->min_ps,
> +                                     pd->max_ps);

Couldn't em_pd_get_efficient_state() just take pd as an argument and
dereference it by itself?

The code would be much easier to follow then.

>         ps =3D &em_table->state[i];
>
>         /*
> @@ -391,6 +401,12 @@ static inline int em_dev_update_chip_binning(struct =
device *dev)
>  {
>         return -EINVAL;
>  }
> +static inline
> +int em_update_performance_limits(struct em_perf_domain *pd,
> +               unsigned long freq_min_khz, unsigned long freq_max_khz)
> +{
> +       return -EINVAL;
> +}
>  #endif
>
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 927cc55ba0b3d..436c2b8fdf9eb 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -628,6 +628,8 @@ int em_dev_register_perf_domain(struct device *dev, u=
nsigned int nr_states,
>                 goto unlock;
>
>         dev->em_pd->flags |=3D flags;
> +       dev->em_pd->min_ps =3D 0;
> +       dev->em_pd->max_ps =3D nr_states - 1;
>
>         em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
>
> @@ -856,3 +858,53 @@ int em_dev_update_chip_binning(struct device *dev)
>         return em_recalc_and_update(dev, pd, em_table);
>  }
>  EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);
> +
> +
> +/**
> + * em_update_performance_limits() - Update Energy Model with performance
> + *                             limits information.
> + * @pd                 : Performance Domain with EM that has to be updat=
ed.
> + * @freq_min_khz       : New minimum allowed frequency for this device.
> + * @freq_max_khz       : New maximum allowed frequency for this device.
> + *
> + * This function allows to update the EM with information about availabl=
e
> + * performance levels. It takes the minimum and maximum frequency in kHz
> + * and does internal translation to performance levels.
> + * Returns 0 on success or -EINVAL when failed.
> + */
> +int em_update_performance_limits(struct em_perf_domain *pd,
> +               unsigned long freq_min_khz, unsigned long freq_max_khz)
> +{
> +       struct em_perf_state *table;
> +       int min_ps =3D -1;
> +       int max_ps =3D -1;
> +       int i;
> +
> +       if (!pd)
> +               return -EINVAL;
> +
> +       rcu_read_lock();
> +       table =3D em_perf_state_from_pd(pd);
> +
> +       for (i =3D 0; i < pd->nr_perf_states; i++) {
> +               if (freq_min_khz =3D=3D table[i].frequency)
> +                       min_ps =3D i;
> +               if (freq_max_khz =3D=3D table[i].frequency)
> +                       max_ps =3D i;
> +       }
> +       rcu_read_unlock();
> +
> +       /* Only update when both are found and sane */
> +       if (min_ps < 0 || max_ps < 0 || max_ps < min_ps)
> +               return -EINVAL;
> +
> +
> +       /* Guard simultaneous updates and make them atomic */
> +       mutex_lock(&em_pd_mutex);
> +       pd->min_ps =3D min_ps;
> +       pd->max_ps =3D max_ps;
> +       mutex_unlock(&em_pd_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(em_update_performance_limits);
> --

