Return-Path: <linux-pm+bounces-17387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921679C506C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 09:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E8285CE2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063EC20A5EB;
	Tue, 12 Nov 2024 08:21:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043720C009;
	Tue, 12 Nov 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399681; cv=none; b=FO+0h+GU0M0EAabm97G2WYFPPna3tB96Boheqp9oi/7C3CSjsCF3WwOzM2agsEvmP+7Cya+zhAsrYes68SSXlSQ7kzEVUcSq8qhs6wAknP1D4Oo7okpD9iqv979lLnubdMuaoHiZWaL6KxL7CYLHW+QUg4sq/k4lUKH+GcGLwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399681; c=relaxed/simple;
	bh=uwoun4OOl8XruolRVALC6myjgpm3tS2FLog1+GGP+/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIvXi47Y9HugYE4B8Lqp/9eg/wMcdJhrSDgBicQfLNGJmIVC/c5YQkOEVAxt0REyCW8mPaAMe5QWxuGHSLHQAQGG9bYotOE33/T6MD2pzqyWdiGnJ83SLTvAHn03xbzWjK22Qjau1p6j2qcHulWuIkJlLKKd2pqLTbbGasmMIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E4912FC;
	Tue, 12 Nov 2024 00:21:48 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E001C3F6A8;
	Tue, 12 Nov 2024 00:21:16 -0800 (PST)
Message-ID: <c4631fdd-0b01-4bda-9e9f-6ac974e27b68@arm.com>
Date: Tue, 12 Nov 2024 09:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.1 6/6] cpufreq: intel_pstate: Add basic EAS
 support on hybrid platforms
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Morten Rasmussen
 <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <115421572.nniJfEyVGO@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <115421572.nniJfEyVGO@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 17:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify intel_pstate to register stub EM perf domains for CPUs on
> hybrid platforms via em_dev_register_perf_domain() and to use
> em_dev_expand_perf_domain() introduced previously for adding new
> CPUs to existing EM perf domains when those CPUs become online for
> the first time after driver initialization.
> 
> This change is targeting platforms (for example, Lunar Lake) where
> "small" CPUs (E-cores) are always more energy-efficient than the "big"
> or "performance" CPUs (P-cores) when run at the same HWP performance
> level, so it is sufficient to tell the EAS that E-cores are always
> preferred (so long as there is enough spare capacity on one of them
> to run the given task).

By treating all big CPUs (ignoring the different itmt prio values
between them) we would have a system in which PD's are not in sync with
the asym_cap_list* or the CPU capacities of individual CPUs and sched
groups within the sched domain. Not sure if we want to go this way?

* used by misfit handling - 22d5607400c6 ("sched/fair: Check if a task
has a fitting CPU when updating misfit")

> Accordingly, the perf domains are registered per CPU type (that is,
> all P-cores belong to one perf domain and all E-cores belong to another
> perf domain) and they are registered only if asymmetric CPU capacity is
> enabled.  Each perf domain has a one-element states table and that
> element only contains the relative cost value (the other fields in
> it are not initialized, so they are all equal to zero), and the cost
> value for the E-core perf domain is lower.

[...]

> +static int hybrid_pcore_cost(struct device *dev, unsigned long freq,
> +			     unsigned long *cost)
> +{
> +	/*
> +	 * The number used here needs to be higher than the analogous
> +	 * one in hybrid_ecore_cost() below.  The units and the actual
> +	 * values don't matter.
> +	 */
> +	*cost = 2;
> +	return 0;

So you're not tying this to HFI energy scores?

> +}
> +
> +static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
> +			     unsigned long *cost)
> +{
> +	*cost = 1;
> +	return 0;
> +}
> +
> +static struct hybrid_em_perf_domain perf_domains[HYBRID_NR_TYPES] = {
> +	[HYBRID_PCORE] = { .cb.get_cost = hybrid_pcore_cost, },
> +	[HYBRID_ECORE] = { .cb.get_cost = hybrid_ecore_cost, }
> +};
> +
> +static bool hybrid_register_perf_domain(struct hybrid_em_perf_domain *pd)
> +{
> +	/*
> +	 * Registering EM perf domains without asymmetric CPU capacity
> +	 * support enabled is wasteful, so don't do that.
> +	 */
> +	if (!hybrid_max_perf_cpu)
> +		return false;
> +
> +	pd->dev = get_cpu_device(cpumask_first(&pd->cpumask));
> +	if (!pd->dev)
> +		return false;
> +
> +	if (em_dev_register_perf_domain(pd->dev, 1, &pd->cb, &pd->cpumask, false)) {
> +		pd->dev = NULL;
> +		return false;
> +	}
> +
> +	return true;
> +}

What are the issues in case you would use the existing ways (non-stub)
to setup the EM?

static int intel_pstate_get_cpu_cost()

static void intel_pstate_register_em(struct cpufreq_policy *policy)

  struct em_data_callback em_cb = EM_ADV_DATA_CB(NULL,
                                              intel_pstate_get_cpu_cost)

  em_dev_register_perf_domain(get_cpu_device(policy->cpu), 1,
                              &em_cb, policy->related_cpus, 1);
                                      ^^^^^^^^^^^^^^^^^^^^*

static void intel_pstate_set_register_em_fct(void)

  default_driver->register_em = intel_pstate_register_em

static int __init intel_pstate_init(void)

  ...
  intel_pstate_set_register_em_fct()
  ...

I guess one issue is the per-CPU policy as an argument to
em_dev_register_perf_domain() (*) ?

> +static void hybrid_register_all_perf_domains(void)
> +{
> +	enum hybrid_cpu_type type;
> +
> +	for (type = HYBRID_PCORE; type < HYBRID_NR_TYPES; type++)
> +		hybrid_register_perf_domain(&perf_domains[type]);
> +}
> +
> +static void hybrid_add_to_perf_domain(int cpu, enum hybrid_cpu_type type)
> +{
> +	struct hybrid_em_perf_domain *pd = &perf_domains[type];
> +
> +	guard(mutex)(&hybrid_capacity_lock);
> +
> +	if (cpumask_test_cpu(cpu, &pd->cpumask))
> +		return;
> +
> +	cpumask_set_cpu(cpu, &pd->cpumask);
> +	if (pd->dev)
> +		em_dev_expand_perf_domain(pd->dev, cpu);
> +	else if (hybrid_register_perf_domain(pd))
> +		em_rebuild_perf_domains();

I assume that the 'if' and the 'else if' condition here are only taken
when the CPU is brought online after boot?

[...]

