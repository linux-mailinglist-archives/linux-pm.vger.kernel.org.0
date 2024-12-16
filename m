Return-Path: <linux-pm+bounces-19327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C69F3784
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 18:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2D1188350A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3B206266;
	Mon, 16 Dec 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toTUnwew"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93988205E17;
	Mon, 16 Dec 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369947; cv=none; b=Bvnl2kak+uq0zFDxbWDEk3h1TrX+KtSgNx4C4adVGx8K0PS2FKnXRX3Ozmr1zeyoRUfqUFbnR+7vMAJSOoJhV3wCcBv5lq2Yl1Q85vannNEn22HH+/bLYEX7jz2kzGyY0pCDop2S2GoTtO4TvrhvjFjkg5mIexru4/GH6AXKobc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369947; c=relaxed/simple;
	bh=vrhax0uCiqAGQOLYSpdt9ZOKtlA1P7bIl0Zey18a2nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED2msNDRptqrP//TLLqMIWJlb8ZxUBwa3xOntgtovcz4QIV927FPiac7idR824Oy8aYKM4uFehGfM9TbG5K0coNo0VYG2af7LCJgjY4iGbEAvv1FekS7DpZPuHnMU4XP1gH85GKY4xLZeoNk/KLlWKOdUnPftRP/t/7HnynBacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toTUnwew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A020C4CEDF;
	Mon, 16 Dec 2024 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369947;
	bh=vrhax0uCiqAGQOLYSpdt9ZOKtlA1P7bIl0Zey18a2nA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=toTUnwewEEZTYhL+I2YLM2oNfs7M+hKzJ92JGBAX03Us784/Gosfx/Tl6Nr7F8PdC
	 +oFTemCZiwohqst6Zg7/O2u1nj3Vh8P1iy8xSsAhoOtClQL4KI9TSYiCeS1314kcvs
	 kdPGrknwz6phBaVtNJptpWL+y3uZi8ZV3ohc5IgDQYf1Tc6gbLD/owcYPMrZEeOteJ
	 Z0G+NCIbmfng1UyRCs6KX0w7NUmzZmsqpLsMyaSy/lTxa1WdsBbGqrS6vS2oG/h4g5
	 J1UMzAhr6bO+arR1x7x8OBJ8DpQCDzrkeK9buZa1f0Mb0ZHo+tSHigxrZXnTNcxtIL
	 8PqNVcYkqIrxA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e63e5c0c50so2231395b6e.0;
        Mon, 16 Dec 2024 09:25:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcL7GJ0sEREPlyQUtamEBRIiwzfws2sJr2N4oOjmzCdG5ld+DknsANA93uhnUojjsK7EJPVZQxoEUVVSA=@vger.kernel.org, AJvYcCVvDqqDDdeFnl5kS9mgzMgth6RrDcYPlynPmddohQlCBB6XsCjkT5u30U2Bl5b6YpQgicxw4keKLj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5ge+rSQEyB4VBSh434qJyOKRGOizzPjASAKZ3ALzUZL8rl9g
	IruQ5g9JKuEcPQxxOfe1Hu1mj6Gon0nkXfhtMRIQEO7X6jNexP5pMTIHh1K0hUdXfVwalY01wrV
	yUCzZ/JOQjQVSCVXaTKxp+lZzTns=
X-Google-Smtp-Source: AGHT+IFDBJrOSWDGX2nbG+PjKRGvDraMZbwtcEXMHLHOXB92iCn9tAWqUkN27WJXftFoueYL+mx32GZFNIGAnWzmXww=
X-Received: by 2002:a05:6808:2114:b0:3e6:22d4:d2c8 with SMTP id
 5614622812f47-3ebca7212cfmr86184b6e.12.1734369946282; Mon, 16 Dec 2024
 09:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <115421572.nniJfEyVGO@rjwysocki.net>
 <2b0953b5-4978-446a-b686-5b8d1541a265@arm.com> <CAJZ5v0hH424_4N1TZVVgKCegUsAisjdAXr7KekafJteSSLEnHA@mail.gmail.com>
 <c920700c-9969-4c23-a1fc-a88c87dc98a6@arm.com>
In-Reply-To: <c920700c-9969-4c23-a1fc-a88c87dc98a6@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 18:25:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hTC20LB1ifbGmesYQULGS4-uEfu2Tgc17OMftvFqvnJg@mail.gmail.com>
Message-ID: <CAJZ5v0hTC20LB1ifbGmesYQULGS4-uEfu2Tgc17OMftvFqvnJg@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 6/6] cpufreq: intel_pstate: Add basic EAS
 support on hybrid platforms
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Christian Loehle <Christian.Loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:33=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.=
com> wrote:
>
>
>
> On 11/19/24 18:20, Rafael J. Wysocki wrote:
> > On Mon, Nov 18, 2024 at 5:34=E2=80=AFPM Pierre Gondois <pierre.gondois@=
arm.com> wrote:
> >>
> >>
> >>
> >> On 11/8/24 17:46, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Modify intel_pstate to register stub EM perf domains for CPUs on
> >>> hybrid platforms via em_dev_register_perf_domain() and to use
> >>> em_dev_expand_perf_domain() introduced previously for adding new
> >>> CPUs to existing EM perf domains when those CPUs become online for
> >>> the first time after driver initialization.
> >>>
> >>> This change is targeting platforms (for example, Lunar Lake) where
> >>> "small" CPUs (E-cores) are always more energy-efficient than the "big=
"
> >>> or "performance" CPUs (P-cores) when run at the same HWP performance
> >>> level, so it is sufficient to tell the EAS that E-cores are always
> >>> preferred (so long as there is enough spare capacity on one of them
> >>> to run the given task).
> >>>
> >>> Accordingly, the perf domains are registered per CPU type (that is,
> >>> all P-cores belong to one perf domain and all E-cores belong to anoth=
er
> >>> perf domain) and they are registered only if asymmetric CPU capacity =
is
> >>> enabled.  Each perf domain has a one-element states table and that
> >>> element only contains the relative cost value (the other fields in
> >>> it are not initialized, so they are all equal to zero), and the cost
> >>> value for the E-core perf domain is lower.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>    drivers/cpufreq/intel_pstate.c |  110 ++++++++++++++++++++++++++++=
++++++++++---
> >>>    1 file changed, 104 insertions(+), 6 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> >>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> >>> @@ -8,6 +8,7 @@
> >>>
> >>>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >>>
> >>> +#include <linux/energy_model.h>
> >>>    #include <linux/kernel.h>
> >>>    #include <linux/kernel_stat.h>
> >>>    #include <linux/module.h>
> >>> @@ -938,6 +939,12 @@ static struct freq_attr *hwp_cpufreq_att
> >>>        NULL,
> >>>    };
> >>>
> >>> +enum hybrid_cpu_type {
> >>> +     HYBRID_PCORE =3D 0,
> >>> +     HYBRID_ECORE,
> >>> +     HYBRID_NR_TYPES
> >>> +};
> >>> +
> >>>    static struct cpudata *hybrid_max_perf_cpu __read_mostly;
> >>>    /*
> >>>     * Protects hybrid_max_perf_cpu, the capacity_perf fields in struc=
t cpudata,
> >>> @@ -945,6 +952,86 @@ static struct cpudata *hybrid_max_perf_c
> >>>     */
> >>>    static DEFINE_MUTEX(hybrid_capacity_lock);
> >>>
> >>> +#ifdef CONFIG_ENERGY_MODEL
> >>> +struct hybrid_em_perf_domain {
> >>> +     cpumask_t cpumask;
> >>> +     struct device *dev;
> >>> +     struct em_data_callback cb;
> >>> +};
> >>> +
> >>> +static int hybrid_pcore_cost(struct device *dev, unsigned long freq,
> >>> +                          unsigned long *cost)
> >>> +{
> >>> +     /*
> >>> +      * The number used here needs to be higher than the analogous
> >>> +      * one in hybrid_ecore_cost() below.  The units and the actual
> >>> +      * values don't matter.
> >>> +      */
> >>> +     *cost =3D 2;
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
> >>> +                          unsigned long *cost)
> >>> +{
> >>> +     *cost =3D 1;
> >>> +     return 0;
> >>> +}
> >>
> >> The artificial EM was introduced for CPPC based platforms since these =
platforms
> >> only provide an 'efficiency class' entry to describe the relative effi=
ciency
> >> of CPUs. The case seems similar to yours.
> >
> > It is, but I don't particularly like the CPPC driver's approach to this=
.
> >
> >> 'Fake' OPPs were created to have an incentive for EAS to balance the l=
oad on
> >> the CPUs in one perf. domain. Indeed, in feec(), during the energy
> >> computation of a pd, if the cost is independent from the max_util valu=
e,
> >> then one CPU in the pd could end up having a high util, and another CP=
U a
> >> NULL util.
> >
> > Isn't this a consequence of disabling load balancing by EAS?
>
> Yes. Going in that direction, this patch from Vincent should help balanci=
ng
> the load in your case I think. The patch evaluates other factors when the=
 energy
> cost of multiple CPU-candidates is the same.
>
> Meaning, if all CPUs of the same type have only one OPP, the number of ta=
sks
> and the the load of the CPUs is then compared. This is not the case curre=
ntly.
> Doing so will help to avoid having one CPU close to being overutilized wh=
ile
> others are idle.
>
> However I think it would still be better to have multiple OPPs in the ene=
rgy model.
> Indeed, it would be closer to reality as I assume that for Intel aswell, =
there
> might be frequency domains and the frequency of the domain is lead by the=
 most
> utilized CPU.

There are a couple of problems with this on my target platforms.

First, it is not actually known what the real OPPs are and how the
coordination works.

For some cores (P-cores mostly) the voltage can be adjusted per-core
and for some others there are coordination domains, but the
coordination there involves idle states (for instance, one core may be
allowed to run at the max turbo frequency when the other ones in the
same domain are in idle states, but not otherwise) and dynamic
balancing (that is, the effective capacity depends on how much energy
is used by the domain over time).

Thus whatever is put into the perf states table will be way off most
of the time and there isn't even a good way to choose the numbers to
put in there.  Using the entire range of HWP P-states for that would
be completely impractical IMV because it would only increase overhead
for no real benefit.  Either it would need to be done per-CPU, which
doesn't really make sense because CPUs of the same type really share
the same cost-performance curve, or the assumption that the entire
domain is led by the most utilized CPU would need to be lifted to some
extent.  That would require some more intrusive changes in EAS which
I'd rather avoid unless the simplest approach doesn't work.

The second problem is that the current platforms are much smaller than
what we're expecting to see in the future and whatever is done today
needs to scale.

Also, I really wouldn't want to have to register special perf domains
for favored cores that share the cost-performance curve with the other
cores of the same type except that they can turbo-up higher if
everyone else is idle or similar.

> This would also avoid hitting corner cases. As if there is one big task a=
nd many
> small tasks, balancing on the number of tasks per CPU is not the best ide=
a.
>
> https://lore.kernel.org/all/20240830130309.2141697-4-vincent.guittot@lina=
ro.org/

Understood.

