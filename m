Return-Path: <linux-pm+bounces-17759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1879D2855
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DFB1F212F4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0971CCEE1;
	Tue, 19 Nov 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJcW35qn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A161C68BE;
	Tue, 19 Nov 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027099; cv=none; b=uAXJqtjWklgnc6z5pUa8jizCJBz8TqdzPtnOBbblB7IfzZfFyK8GEOZ/o5HrHpXzABP5ngsdzylK74APVGVrV1jNwHNDZRXF1zcOVhup2GpHedjqA+EmrU3VtVlbArhpybolO5CPUkvI8Tns4tcpSZfcbgAfeMgt+cnegqD02hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027099; c=relaxed/simple;
	bh=UgP2Qbq3vzgva8CKJIilHv2/vAnSPGgikaGsIi+XM8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+LlsiAPM1rIC3eLHwCQWU+9tzVN1g1tYrkM/gUDq8QvgSaPvt9MR7KgyJIWXZdMl/PC6dBQaGFqmVh+Yf+NKdnuQDjuyr9cWxCQxFDy0zPMxOxK2dvTHXKSBHaGDfdxMxQeGJ9Oi3n/WduKV7qWB0b2E5JBYXxISW9S9hs8Q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJcW35qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84252C4CED9;
	Tue, 19 Nov 2024 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027098;
	bh=UgP2Qbq3vzgva8CKJIilHv2/vAnSPGgikaGsIi+XM8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rJcW35qnXx+lpTwsIqSUAuBmB+12lJ157xbgMnBzSBiyRndhGAH3U6dcdItZrAN4z
	 JKTKBdEjG4ACmPqEpfkMPQ1zx2wHAFZJlCAonFsBq+qW/+Ln1upTrvaSvzZF03FGM9
	 +wQ9t9w7lsEuzANhdhaoMz6Dei67E1Vpj6XoQYFtZ/WU9Mdw4LgKuev1jfvs2ZUA58
	 h+9A4L1wJugnTn130/v87Ve2qzGMFy7yZ+BVcQvxmRGp0yEJgms7Amnfz9WDW+jb0I
	 5/t1knRHdKsGVgAWV7cGXRpYoDJWILbVJzPwALNkkU7KQkbUdSiGs1Rkl9Gq44N19F
	 i0yxnjqnJqYCQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2964645d2b7so643485fac.2;
        Tue, 19 Nov 2024 06:38:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC19ShvJpbI5ZSE0VvamuLt1jafGRu//vQHKjIDvua5I5o/bR6ggBqSLXgpZzS/WOkxZcXNclTd5IXZH4=@vger.kernel.org, AJvYcCXG0JgiMla4BQO0iSK8vnt8tBQsCNQ1TwXc2RZcRytsNRjqPIhw1XxY7UTmESoGojtmEPxim6o1tSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbxeKk4Zl54U2R9sVPdg9BDhJXCj1NpLM9fxg66e1ELnSK4qJ
	NUmg0S6+u7WaMOaSSwdGXZtoCPZx4+ACY4v3Uus1qQdAj2EBi0z8+roQORP6dH6LDYydgrkforA
	zlN7xVdbUGitepf9QoOq5OKdbxKc=
X-Google-Smtp-Source: AGHT+IF5JVYrYmiksujeJZf6YT+vo8cO0b+QRTahJ0pl7ikmHOJ+nDJWsgJ/ggDHw+/gtrIIpea175NUh1n9WHkiSkI=
X-Received: by 2002:a05:6871:3a2b:b0:27c:475c:ab2c with SMTP id
 586e51a60fabf-2962e1140afmr13363617fac.43.1732027097711; Tue, 19 Nov 2024
 06:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <115421572.nniJfEyVGO@rjwysocki.net>
 <c4631fdd-0b01-4bda-9e9f-6ac974e27b68@arm.com>
In-Reply-To: <c4631fdd-0b01-4bda-9e9f-6ac974e27b68@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 15:38:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jZf=FaLAPtZB1O_g+P=rH7Lu5kGPdn2K6pk3vXLLJbLg@mail.gmail.com>
Message-ID: <CAJZ5v0jZf=FaLAPtZB1O_g+P=rH7Lu5kGPdn2K6pk3vXLLJbLg@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 6/6] cpufreq: intel_pstate: Add basic EAS
 support on hybrid platforms
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First off, thanks for all  the feedback!

On Tue, Nov 12, 2024 at 9:21=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 08/11/2024 17:46, Rafael J. Wysocki wrote:
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
>
> By treating all big CPUs (ignoring the different itmt prio values
> between them) we would have a system in which PD's are not in sync with
> the asym_cap_list* or the CPU capacities of individual CPUs and sched
> groups within the sched domain. Not sure if we want to go this way?

I guess you want the biggest tasks to be scheduled at the most-capable CPUs=
.

That's fair, and it may even improve single-threaded performance in
some cases I suppose, but then the cost for the "favored cores" PD
would be the same as for the "other P-cores" PD because there is no
difference between them other than the top-most turbo bin, so we'd
compare PDs with the same cost and that wouldn't be super-useful.

> * used by misfit handling - 22d5607400c6 ("sched/fair: Check if a task
> has a fitting CPU when updating misfit")
>
> > Accordingly, the perf domains are registered per CPU type (that is,
> > all P-cores belong to one perf domain and all E-cores belong to another
> > perf domain) and they are registered only if asymmetric CPU capacity is
> > enabled.  Each perf domain has a one-element states table and that
> > element only contains the relative cost value (the other fields in
> > it are not initialized, so they are all equal to zero), and the cost
> > value for the E-core perf domain is lower.
>
> [...]
>
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
>
> So you're not tying this to HFI energy scores?

Not at this time.

> > +}
> > +
> > +static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
> > +                          unsigned long *cost)
> > +{
> > +     *cost =3D 1;
> > +     return 0;
> > +}
> > +
> > +static struct hybrid_em_perf_domain perf_domains[HYBRID_NR_TYPES] =3D =
{
> > +     [HYBRID_PCORE] =3D { .cb.get_cost =3D hybrid_pcore_cost, },
> > +     [HYBRID_ECORE] =3D { .cb.get_cost =3D hybrid_ecore_cost, }
> > +};
> > +
> > +static bool hybrid_register_perf_domain(struct hybrid_em_perf_domain *=
pd)
> > +{
> > +     /*
> > +      * Registering EM perf domains without asymmetric CPU capacity
> > +      * support enabled is wasteful, so don't do that.
> > +      */
> > +     if (!hybrid_max_perf_cpu)
> > +             return false;
> > +
> > +     pd->dev =3D get_cpu_device(cpumask_first(&pd->cpumask));
> > +     if (!pd->dev)
> > +             return false;
> > +
> > +     if (em_dev_register_perf_domain(pd->dev, 1, &pd->cb, &pd->cpumask=
, false)) {
> > +             pd->dev =3D NULL;
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
>
> What are the issues in case you would use the existing ways (non-stub)
> to setup the EM?
>
> static int intel_pstate_get_cpu_cost()
>
> static void intel_pstate_register_em(struct cpufreq_policy *policy)
>
>   struct em_data_callback em_cb =3D EM_ADV_DATA_CB(NULL,
>                                               intel_pstate_get_cpu_cost)
>
>   em_dev_register_perf_domain(get_cpu_device(policy->cpu), 1,
>                               &em_cb, policy->related_cpus, 1);
>                                       ^^^^^^^^^^^^^^^^^^^^*

I'm not sure what you are asking about here, but I'll try to answer.

No, I don't want to register a PD per policy with one CPU in it
because that would mean useless comparing PDs with the same cost and
CPU capacity.

> static void intel_pstate_set_register_em_fct(void)
>
>   default_driver->register_em =3D intel_pstate_register_em

No, I don't want to register PDs through cpufreq because it is too
early (and see above).

> static int __init intel_pstate_init(void)
>
>   ...
>   intel_pstate_set_register_em_fct()
>   ...
>
> I guess one issue is the per-CPU policy as an argument to
> em_dev_register_perf_domain() (*) ?

Yes.

> > +static void hybrid_register_all_perf_domains(void)
> > +{
> > +     enum hybrid_cpu_type type;
> > +
> > +     for (type =3D HYBRID_PCORE; type < HYBRID_NR_TYPES; type++)
> > +             hybrid_register_perf_domain(&perf_domains[type]);
> > +}
> > +
> > +static void hybrid_add_to_perf_domain(int cpu, enum hybrid_cpu_type ty=
pe)
> > +{
> > +     struct hybrid_em_perf_domain *pd =3D &perf_domains[type];
> > +
> > +     guard(mutex)(&hybrid_capacity_lock);
> > +
> > +     if (cpumask_test_cpu(cpu, &pd->cpumask))
> > +             return;
> > +
> > +     cpumask_set_cpu(cpu, &pd->cpumask);
> > +     if (pd->dev)
> > +             em_dev_expand_perf_domain(pd->dev, cpu);
> > +     else if (hybrid_register_perf_domain(pd))
> > +             em_rebuild_perf_domains();
>
> I assume that the 'if' and the 'else if' condition here are only taken
> when the CPU is brought online after boot?

Yes.

