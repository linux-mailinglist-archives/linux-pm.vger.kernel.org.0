Return-Path: <linux-pm+bounces-17765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB0C9D2D4F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2E6B28ED7
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF61D1514;
	Tue, 19 Nov 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6dZnWlq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6131D0967;
	Tue, 19 Nov 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036820; cv=none; b=oLpCtAv02j+dDNBfU+l7x9NhFMEWCEZC0l4Ei+tuHZ2Y0WkPP8TZmZqJuvw+a4Fy4GgCrhTsMW1WJBor/3MVqy5BWRGjzkIM8B9nU3A7H1QHDKOWl5pqrqQ4+1y3W8lC92H2pd3bn0ixTTNzs1QbH96Pes/DRZyaT50irisbKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036820; c=relaxed/simple;
	bh=tbrEXDYbwQhM6MgTNh9IIYN9AdPjyC/qDEZNeQd0RCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKC/hreBcGtbNQ/cvdpMi4Zl7Ayijffh4f6hDGzaQqr+crmC8jyM6tyPzu3GS6fTnzi4QvMjjwCWBClI83UijrmJHogrsz/oh0XeoB84DcPysdwoQHi3w6xEUuUElsE1Dof/vBTQgYjnp1YvA8YcPuG8WvvPf6UuKuC+CnvbuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6dZnWlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61988C4CED0;
	Tue, 19 Nov 2024 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732036819;
	bh=tbrEXDYbwQhM6MgTNh9IIYN9AdPjyC/qDEZNeQd0RCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B6dZnWlqL/1RbA4iszoqT/ogp6O7Jjp9hT1XNYJ3B5E4X3GldRoWiqqgOR87xlJMa
	 IPbD64x8WKwQZTX0V/yKbn+tXZKNDkrQJLulkE861N6LZ0RBuuWDka1Jc01SB9zd40
	 fwWc+qg/w1iJ9lRWaqPoNCS5j73VMVyBkQAHGzheZcnPRimsjxddIkvEi/9eWl4Ue4
	 jKr/tuXSAX/KJry0Y+LnxyKdiTpyHVDfK91QLxuGrRUT9UF1zGK5JupgOF+MjXf903
	 2Fr+Q1sbsFnYTcwJU+hiY3mrruInNFnZXV9PECHAL2B9XkNBGWGnGDqf2hRmWckmRx
	 4c1zysTBSWGfw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2958ddf99a7so928945fac.2;
        Tue, 19 Nov 2024 09:20:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUA3ts1/64vmiglTzq1NLjb9gy3KWTtsoH0XcZv5COixVIXjM/wJVssejKolcOS4LdRfdQ/7pEZOAkDBA0=@vger.kernel.org, AJvYcCUfuqM5IMxNhFg27WIE3Cpz0INoU41UBTgswPutD/wxGp+z+6Fa0Ag/TT0jmB3JS0IwVJA/yhVQo4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTO2Q5SDh/6sR/brHBWR671D5o3oXZ3/BnmXU/OEoWsTqUpjE
	HzMAJdpvT1is/RlXu2kBz3+5Cnh8OlZjb436J8TPCSXJ5dEIKnFvFoA2YfPDkuQPoJSg9Gdwzc0
	MhbIph1xaIkRrK5zHNmwdTYbPBHg=
X-Google-Smtp-Source: AGHT+IFFemPFTNUwAUEpHn8m/WNBRPkDw4Ph9nBIbUekWCUAmHuwBdv3mBp3Gw9/wgZhLNacgMx4lH78ZN1Pk2dtB40=
X-Received: by 2002:a05:6871:3312:b0:270:50f7:50c1 with SMTP id
 586e51a60fabf-2962dc9d9e1mr14113811fac.1.1732036818607; Tue, 19 Nov 2024
 09:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <115421572.nniJfEyVGO@rjwysocki.net>
 <2b0953b5-4978-446a-b686-5b8d1541a265@arm.com>
In-Reply-To: <2b0953b5-4978-446a-b686-5b8d1541a265@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 18:20:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hH424_4N1TZVVgKCegUsAisjdAXr7KekafJteSSLEnHA@mail.gmail.com>
Message-ID: <CAJZ5v0hH424_4N1TZVVgKCegUsAisjdAXr7KekafJteSSLEnHA@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 6/6] cpufreq: intel_pstate: Add basic EAS
 support on hybrid platforms
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Christian Loehle <Christian.Loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 5:34=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
>
>
> On 11/8/24 17:46, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Modify intel_pstate to register stub EM perf domains for CPUs on
> > hybrid platforms via em_dev_register_perf_domain() and to use
> > em_dev_expand_perf_domain() introduced previously for adding new
> > CPUs to existing EM perf domains when those CPUs become online for
> > the first time after driver initialization.
> >
> > This change is targeting platforms (for example, Lunar Lake) where
> > "small" CPUs (E-cores) are always more energy-efficient than the "big"
> > or "performance" CPUs (P-cores) when run at the same HWP performance
> > level, so it is sufficient to tell the EAS that E-cores are always
> > preferred (so long as there is enough spare capacity on one of them
> > to run the given task).
> >
> > Accordingly, the perf domains are registered per CPU type (that is,
> > all P-cores belong to one perf domain and all E-cores belong to another
> > perf domain) and they are registered only if asymmetric CPU capacity is
> > enabled.  Each perf domain has a one-element states table and that
> > element only contains the relative cost value (the other fields in
> > it are not initialized, so they are all equal to zero), and the cost
> > value for the E-core perf domain is lower.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/cpufreq/intel_pstate.c |  110 +++++++++++++++++++++++++++++++=
+++++++---
> >   1 file changed, 104 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/intel_pstate.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> > +++ linux-pm/drivers/cpufreq/intel_pstate.c
> > @@ -8,6 +8,7 @@
> >
> >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > +#include <linux/energy_model.h>
> >   #include <linux/kernel.h>
> >   #include <linux/kernel_stat.h>
> >   #include <linux/module.h>
> > @@ -938,6 +939,12 @@ static struct freq_attr *hwp_cpufreq_att
> >       NULL,
> >   };
> >
> > +enum hybrid_cpu_type {
> > +     HYBRID_PCORE =3D 0,
> > +     HYBRID_ECORE,
> > +     HYBRID_NR_TYPES
> > +};
> > +
> >   static struct cpudata *hybrid_max_perf_cpu __read_mostly;
> >   /*
> >    * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct c=
pudata,
> > @@ -945,6 +952,86 @@ static struct cpudata *hybrid_max_perf_c
> >    */
> >   static DEFINE_MUTEX(hybrid_capacity_lock);
> >
> > +#ifdef CONFIG_ENERGY_MODEL
> > +struct hybrid_em_perf_domain {
> > +     cpumask_t cpumask;
> > +     struct device *dev;
> > +     struct em_data_callback cb;
> > +};
> > +
> > +static int hybrid_pcore_cost(struct device *dev, unsigned long freq,
> > +                          unsigned long *cost)
> > +{
> > +     /*
> > +      * The number used here needs to be higher than the analogous
> > +      * one in hybrid_ecore_cost() below.  The units and the actual
> > +      * values don't matter.
> > +      */
> > +     *cost =3D 2;
> > +     return 0;
> > +}
> > +
> > +static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
> > +                          unsigned long *cost)
> > +{
> > +     *cost =3D 1;
> > +     return 0;
> > +}
>
> The artificial EM was introduced for CPPC based platforms since these pla=
tforms
> only provide an 'efficiency class' entry to describe the relative efficie=
ncy
> of CPUs. The case seems similar to yours.

It is, but I don't particularly like the CPPC driver's approach to this.

> 'Fake' OPPs were created to have an incentive for EAS to balance the load=
 on
> the CPUs in one perf. domain. Indeed, in feec(), during the energy
> computation of a pd, if the cost is independent from the max_util value,
> then one CPU in the pd could end up having a high util, and another CPU a
> NULL util.

Isn't this a consequence of disabling load balancing by EAS?

> For CPPC platforms, this was problematic as a lower OPP could have been
> selected for the same load, so energy was lost for no reason.
>
> In your case it seems that the OPP selection is done independently on eac=
h
> CPU. However I assume it is still more energy efficient to have 2 CPUs
> loaded at 50% than one CPU loaded at 100% and an idle CPU.

Maybe.

It really depends on the cost of the idle state etc.

> Also as Dietmar suggested, maybe it would make sense to have some
> way to prefer an CPU with a "energy saving" HFI configuration than
> a similar CPU with a "performance" HFI configuration.

As it happens, E-cores have higher energy-efficiency scores in HFI AFAICS.

> Also, out of curiosity, do you have energy numbers to share ?

Not yet, but there will be some going forward.

Thanks!

