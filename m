Return-Path: <linux-pm+bounces-17011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49009BC083
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 23:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988EE282B71
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 22:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D41AAE27;
	Mon,  4 Nov 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmpJGA6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987D158522;
	Mon,  4 Nov 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757754; cv=none; b=T5oCnMCSJUXHc8/UaTHPgEkSApcQLIhJoaI1xmThDMsMmw7xjpBU32Jlf3ULP9oVKsxf9KgK2bmAfLb+V/qPh309jG9BD3R8qA5R60F3Y2oNWquQgSMWjPGqnDpePb/iKITapoyGKo+5TClxgcS1PJbeYF0RBCXgstEIKz/9Rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757754; c=relaxed/simple;
	bh=7QIifIssVUmVPesl7ylU2g2JqAzCifBzBoPBx2zV8n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iofc5KD1sCF2fN7ICkEJE/WP6gFm4SL3m3V8rq4czZEsuSeg+ZtD7csURTTL4rVzvSf9G5rbvXMbkVAfdMCoLMDaTjPxJdYFHWcGzODgh3Quae4fjFqhzvOKY+8AqvsTmf3ChB6Itb9+UaPxAAw9wz+hRjrAl1VGn+ejeGvEYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmpJGA6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BECC4CECE;
	Mon,  4 Nov 2024 22:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730757754;
	bh=7QIifIssVUmVPesl7ylU2g2JqAzCifBzBoPBx2zV8n8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bmpJGA6XY4d+1a042eUWC/fe9vHMkD8M506B00CQVFijTXVx9A+mM2dywCp6t5Yk0
	 jHiKm62uOyNv7PKVyJ1Hb3WPKMmguLAjECO+sUeRYmhNAFMD/YRnAtQDXE8jBDALqP
	 ZvJcoV4w/Hn+Ws8RVShiymDbTd1+Dhcscr68yoqMC3g+y7ipFv/ulcOPm+K7N1ljFj
	 0YYiugARaLfJ52qKDrGbJWx8fQwu4zpXHygxLq8ETNEo+n9p7H6djjibNCv15+LtZS
	 LpbA026wK9pBwXGCSgmoynGGUck89Rp951kjI8HXypHZ1vnfbEG8G9ZXAX8dRoy1Vu
	 3Y9n4ekf7jcdw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ebc0dbc566so2377763eaf.3;
        Mon, 04 Nov 2024 14:02:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXgowsM+P87OLQtfz2NXFtCq+MCYmv/hSkm7bCnwcxOj8bFyYnMFEHRwUMbMeP51HF7Ehw3iheCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lkHErNAksyiBgYmTnHDBm/q5Z+DLvGb9vRV/veWin9pdew4n
	76DuEdMhfxd8JB++WUWo6sqSuukpOwUnzJChfJobmlxjK2HGxUE/bP5ltUJ4oWzxvkFEVenflxi
	UfM0q6vD19UtfLpltKa2ttjwbxAI=
X-Google-Smtp-Source: AGHT+IF7OgK5DkrXYX6V8ZPi7SK75DYbhSrAGlARSEhx+S1zP/RJOCbCTW7jpP8xvwV3uCs0xPmMgiwe55OmjZ0z68M=
X-Received: by 2002:a05:6820:f05:b0:5ee:a5b:d172 with SMTP id
 006d021491bc7-5ee0a5bd5bdmr4172827eaf.5.1730757753286; Mon, 04 Nov 2024
 14:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030164126.1263793-1-lukasz.luba@arm.com> <20241030164126.1263793-2-lukasz.luba@arm.com>
In-Reply-To: <20241030164126.1263793-2-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 23:02:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iRQ4fZ0xOeLkwvg80nuB7cAM02mj1resEBVvAqr3PQ-Q@mail.gmail.com>
Message-ID: <CAJZ5v0iRQ4fZ0xOeLkwvg80nuB7cAM02mj1resEBVvAqr3PQ-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] PM: EM: Add min/max available performance state limits
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dietmar.eggemann@arm.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:40=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
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
>  include/linux/energy_model.h | 29 ++++++++++++++------
>  kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 1ff52020cf757..752e0b2975820 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -55,6 +55,8 @@ struct em_perf_table {
>   * struct em_perf_domain - Performance domain
>   * @em_table:          Pointer to the runtime modifiable em_perf_table
>   * @nr_perf_states:    Number of performance states
> + * @min_perf_state:    Minimum allowed Performance State index
> + * @max_perf_state:    Maximum allowed Performance State index
>   * @flags:             See "em_perf_domain flags"
>   * @cpus:              Cpumask covering the CPUs of the domain. It's her=
e
>   *                     for performance reasons to avoid potential cache
> @@ -70,6 +72,8 @@ struct em_perf_table {
>  struct em_perf_domain {
>         struct em_perf_table __rcu *em_table;
>         int nr_perf_states;
> +       int min_perf_state;
> +       int max_perf_state;
>         unsigned long flags;
>         unsigned long cpus[];
>  };
> @@ -173,13 +177,14 @@ void em_table_free(struct em_perf_table __rcu *tabl=
e);
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
>   * @table:             List of performance states, in ascending order
> - * @nr_perf_states:    Number of performance states
> + * @pd:                        performance domain for which this must be=
 done
>   * @max_util:          Max utilization to map with the EM
> - * @pd_flags:          Performance Domain flags
>   *
>   * It is called from the scheduler code quite frequently and as a conseq=
uence
>   * doesn't implement any check.
> @@ -188,13 +193,16 @@ int em_dev_update_chip_binning(struct device *dev);
>   * requirement.
>   */
>  static inline int
> -em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_state=
s,
> -                         unsigned long max_util, unsigned long pd_flags)
> +em_pd_get_efficient_state(struct em_perf_state *table,
> +                         struct em_perf_domain *pd, unsigned long max_ut=
il)
>  {
> +       unsigned long pd_flags =3D pd->flags;
> +       int min_ps =3D pd->min_perf_state;
> +       int max_ps =3D pd->max_perf_state;
>         struct em_perf_state *ps;
>         int i;
>
> -       for (i =3D 0; i < nr_perf_states; i++) {
> +       for (i =3D min_ps; i <=3D max_ps; i++) {
>                 ps =3D &table[i];
>                 if (ps->performance >=3D max_util) {
>                         if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES=
 &&
> @@ -204,7 +212,7 @@ em_pd_get_efficient_state(struct em_perf_state *table=
, int nr_perf_states,
>                 }
>         }
>
> -       return nr_perf_states - 1;
> +       return max_ps;
>  }
>
>  /**
> @@ -253,8 +261,7 @@ static inline unsigned long em_cpu_energy(struct em_p=
erf_domain *pd,
>          * requested performance.
>          */
>         em_table =3D rcu_dereference(pd->em_table);
> -       i =3D em_pd_get_efficient_state(em_table->state, pd->nr_perf_stat=
es,
> -                                     max_util, pd->flags);
> +       i =3D em_pd_get_efficient_state(em_table->state, pd, max_util);
>         ps =3D &em_table->state[i];
>
>         /*
> @@ -391,6 +398,12 @@ static inline int em_dev_update_chip_binning(struct =
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
> index 927cc55ba0b3d..d07faf42eace6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -628,6 +628,8 @@ int em_dev_register_perf_domain(struct device *dev, u=
nsigned int nr_states,
>                 goto unlock;
>
>         dev->em_pd->flags |=3D flags;
> +       dev->em_pd->min_perf_state =3D 0;
> +       dev->em_pd->max_perf_state =3D nr_states - 1;
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
> +       pd->min_perf_state =3D min_ps;
> +       pd->max_perf_state =3D max_ps;
> +       mutex_unlock(&em_pd_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(em_update_performance_limits);
> --

Applied as 6.13 material, thanks!

