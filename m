Return-Path: <linux-pm+bounces-34349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C8B51365
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD053B71DF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02298313278;
	Wed, 10 Sep 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOt2pnXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2930E0DA;
	Wed, 10 Sep 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498467; cv=none; b=JxCdvTjlGCBV6qx+jclcasN+HxJnfk+ZkOHtOS63+d8mUMlolPnJmlzxjaMUoWxH9SAYbaXUilPjAy+IFLtiQs3aBicJTaFvLWdGlUV/esb6rofJ8k8Z/6CXFn1CXXm5dhtIMLQl849TaYlGzqAcXJ55jG3Oltrlu7bkKZlDKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498467; c=relaxed/simple;
	bh=jlGAhDTkRZXnnMPZMrWHeqZDzLhhCobBET585hoVFBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLJHNoAgdRjItOaLjVJZ7omD9faXbLjHRO7RXbEE7KEc6yamz1cauilc10v4HJAtjpbkYnAgrtf22dVPUQHxRg6p3RwhFDC4CDAUNggDjpw/8ZiXwaJU1fom0yecd2RM0sW80mBOy5pmw5kmqcwR+XT0G/x1QiXUtOk4c4zSnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOt2pnXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63CC4CEFB;
	Wed, 10 Sep 2025 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498467;
	bh=jlGAhDTkRZXnnMPZMrWHeqZDzLhhCobBET585hoVFBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SOt2pnXPpiYQ6AZYq9hTNcgn/uy9Er5D9+Ibe2Kng0alqMwEM38HvSt48LbMq/0yD
	 Igc69OLUPGudsiYbsKad2PLNlLRhVBTwPACPorJYGTtQs4okvP9lq/9uOYbHBXRxAm
	 TNjORtSS1LYKFAoaXOAIBtBJ8ewUgUxb4xq6Qpj0uZFGaK2nRQF2JbiWA8A9zPzr4D
	 N008dAnTlq9Sk0MVmHYUkzhmV4vcirOqexiWRR7x/Gl5iENG+hvAKbPLZWZo9UU3v3
	 koIA8ueh/sDh3Hz2lC1BcDljlL3yt+xVbjMDRgBHg4XVuYGQXOXz2R+sYcJgEUbYH/
	 sRepcu8RcN75A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61e783a1e00so4343364eaf.1;
        Wed, 10 Sep 2025 03:01:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp2tponcQGGvVo99AgWkbSOl7cIfFyxt+O4J/ZXPEO52bQX55x94dxVW0TJISJLV535bXW/AfDZxr58y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfi88Vhq8oh6GH3t87avnCYjdTEeHQq4vegRAaJEztxvpnreY
	X6QbjfsEmE7UQX0aVXaBak+tVAWWKPJ5CGse6aNoa8hK1INnRUz6BFRdNavlTGn8ymXnwMZ8Pt4
	xq7cuOebq/nhdJTRC/XzGkCtlP1hNs6Q=
X-Google-Smtp-Source: AGHT+IEZ/z6cWc+DwnvhPi4i9a5DeQP3XdWyBXb0TQImWOzWBi8cr1RWQdfORhfoA4ruZJfCbYnD847XOPnQ7oR36iw=
X-Received: by 2002:a05:6820:1501:b0:621:a6f6:7bf3 with SMTP id
 006d021491bc7-621a6f67ce5mr1018585eaf.8.1757498466603; Wed, 10 Sep 2025
 03:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5939134.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <5939134.DvuYhMxLoT@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 12:00:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0inBsg+g150_tFfkff9bJVRE2XCRY-zDcDpfNvAcmHsCQ@mail.gmail.com>
X-Gm-Features: Ac12FXzg67u0ijO7GZZtjdM-AmPip11ZbU4FQPyS_9kYgmPukGnf92fbczNMguw
Message-ID: <CAJZ5v0inBsg+g150_tFfkff9bJVRE2XCRY-zDcDpfNvAcmHsCQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: EM: Add function for registering a PD without
 capacity update
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Christian Loehle <christian.loehle@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Kenneth R. Crudup" <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The intel_pstate driver manages CPU capacity changes itself and it does
> not need an update of the capacity of all CPUs in the system to be
> carried out after registering a PD.
>
> Moreover, in some configurations (for instance, an SMT-capable
> hybrid x86 system booted with nosmt in the kernel command line) the
> em_check_capacity_update() call at the end of em_dev_register_perf_domain=
()
> always fails and reschedules itself to run once again in 1 s, so
> effectively it runs in vain every 1 s forever.
>
> To address this, introduce a new variant of em_dev_register_perf_domain()=
,
> called em_dev_register_pd_no_update(), that does not invoke
> em_check_capacity_update(), and make intel_pstate use it instead of the
> original.
>
> Fixes: 7b010f9b9061 ("cpufreq: intel_pstate: EAS support for hybrid platf=
orms")
> Link: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b814=
4d@panix.com/
> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Tested-by: Kenneth R. Crudup <kenny@panix.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+

I'd appreciate feedback on this.

Since it is 6.16-stable material, I'm inclined to just apply it and
let it into the mainline.

> ---
>
> Normally, I would place the definition of em_dev_register_pd_no_update()
> before the definition of em_dev_register_perf_domain() which called it,
> but in this particular case that would cause the real change to be much
> harder to grasp.
>
> ---
>  drivers/cpufreq/intel_pstate.c |    4 ++--
>  include/linux/energy_model.h   |   10 ++++++++++
>  kernel/power/energy_model.c    |   29 +++++++++++++++++++++++++----
>  3 files changed, 37 insertions(+), 6 deletions(-)
>
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1034,8 +1034,8 @@ static bool hybrid_register_perf_domain(
>         if (!cpu_dev)
>                 return false;
>
> -       if (em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &=
cb,
> -                                       cpumask_of(cpu), false))
> +       if (em_dev_register_pd_no_update(cpu_dev, HYBRID_EM_STATE_COUNT, =
&cb,
> +                                        cpumask_of(cpu), false))
>                 return false;
>
>         cpudata->pd_registered =3D true;
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -171,6 +171,9 @@ int em_dev_update_perf_domain(struct dev
>  int em_dev_register_perf_domain(struct device *dev, unsigned int nr_stat=
es,
>                                 const struct em_data_callback *cb,
>                                 const cpumask_t *cpus, bool microwatts);
> +int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_sta=
tes,
> +                                const struct em_data_callback *cb,
> +                                const cpumask_t *cpus, bool microwatts);
>  void em_dev_unregister_perf_domain(struct device *dev);
>  struct em_perf_table *em_table_alloc(struct em_perf_domain *pd);
>  void em_table_free(struct em_perf_table *table);
> @@ -350,6 +353,13 @@ int em_dev_register_perf_domain(struct d
>  {
>         return -EINVAL;
>  }
> +static inline
> +int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_sta=
tes,
> +                                const struct em_data_callback *cb,
> +                                const cpumask_t *cpus, bool microwatts)
> +{
> +       return -EINVAL;
> +}
>  static inline void em_dev_unregister_perf_domain(struct device *dev)
>  {
>  }
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -553,6 +553,30 @@ int em_dev_register_perf_domain(struct d
>                                 const struct em_data_callback *cb,
>                                 const cpumask_t *cpus, bool microwatts)
>  {
> +       int ret =3D em_dev_register_pd_no_update(dev, nr_states, cb, cpus=
, microwatts);
> +
> +       if (_is_cpu_device(dev))
> +               em_check_capacity_update();
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
> +
> +/**
> + * em_dev_register_pd_no_update() - Register a perf domain for a device
> + * @dev : Device to register the PD for
> + * @nr_states : Number of performance states in the new PD
> + * @cb : Callback functions for populating the energy model
> + * @cpus : CPUs to include in the new PD (mandatory if @dev is a CPU dev=
ice)
> + * @microwatts : Whether or not the power values in the EM will be in uW
> + *
> + * Like em_dev_register_perf_domain(), but does not trigger a CPU capaci=
ty
> + * update after registering the PD, even if @dev is a CPU device.
> + */
> +int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_sta=
tes,
> +                                const struct em_data_callback *cb,
> +                                const cpumask_t *cpus, bool microwatts)
> +{
>         struct em_perf_table *em_table;
>         unsigned long cap, prev_cap =3D 0;
>         unsigned long flags =3D 0;
> @@ -636,12 +660,9 @@ int em_dev_register_perf_domain(struct d
>  unlock:
>         mutex_unlock(&em_pd_mutex);
>
> -       if (_is_cpu_device(dev))
> -               em_check_capacity_update();
> -
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
> +EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
>
>  /**
>   * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for a =
device
>
>
>
>

