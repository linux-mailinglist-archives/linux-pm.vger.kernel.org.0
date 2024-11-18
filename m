Return-Path: <linux-pm+bounces-17731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBA9D1576
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D54FB2C1AF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AC1BDAAA;
	Mon, 18 Nov 2024 16:34:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAE1BD9F8;
	Mon, 18 Nov 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947650; cv=none; b=vEREXX++tapO0GjeWDkMs7ztYhgy2o1n0pbdl09aqiqXyAWXsBtXcYurozRQ3y8DIhDmFZksxnmkou+qzDmLFdQcJ4sB562dfDrhsRiVUBhgfi8LRJh4HRFrtZ0PzZdTwmQ5fer4+REe8ZCOEaEMZQa6Q8Pxfh+HyJLdrnwQFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947650; c=relaxed/simple;
	bh=ClLV/qgZWddlGeTz3r28T680S77aLUg1RmvQNgSKBBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg9dx4lollwWNYG2gfDpgwAUSimyFwldjhHx3Zxw7Ed58kvA96DRi2cbWHTz1I91nlEt81ayDu9AfuGSqraPiapColarCTUaOPGCk4esu5wDJEX7GoCpu0J7LHVV+BqIs09SXNq/zeG/cm9zZjP6/fWHP1MttBFAsN/RK/lM6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6E1C165C;
	Mon, 18 Nov 2024 08:34:35 -0800 (PST)
Received: from [10.34.129.45] (e126645.nice.arm.com [10.34.129.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A6B3F6A8;
	Mon, 18 Nov 2024 08:34:03 -0800 (PST)
Message-ID: <2b0953b5-4978-446a-b686-5b8d1541a265@arm.com>
Date: Mon, 18 Nov 2024 17:34:01 +0100
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
 Len Brown <len.brown@intel.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Christian Loehle <Christian.Loehle@arm.com>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <115421572.nniJfEyVGO@rjwysocki.net>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <115421572.nniJfEyVGO@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/24 17:46, Rafael J. Wysocki wrote:
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
> 
> Accordingly, the perf domains are registered per CPU type (that is,
> all P-cores belong to one perf domain and all E-cores belong to another
> perf domain) and they are registered only if asymmetric CPU capacity is
> enabled.  Each perf domain has a one-element states table and that
> element only contains the relative cost value (the other fields in
> it are not initialized, so they are all equal to zero), and the cost
> value for the E-core perf domain is lower.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpufreq/intel_pstate.c |  110 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 104 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -8,6 +8,7 @@
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> +#include <linux/energy_model.h>
>   #include <linux/kernel.h>
>   #include <linux/kernel_stat.h>
>   #include <linux/module.h>
> @@ -938,6 +939,12 @@ static struct freq_attr *hwp_cpufreq_att
>   	NULL,
>   };
>   
> +enum hybrid_cpu_type {
> +	HYBRID_PCORE = 0,
> +	HYBRID_ECORE,
> +	HYBRID_NR_TYPES
> +};
> +
>   static struct cpudata *hybrid_max_perf_cpu __read_mostly;
>   /*
>    * Protects hybrid_max_perf_cpu, the capacity_perf fields in struct cpudata,
> @@ -945,6 +952,86 @@ static struct cpudata *hybrid_max_perf_c
>    */
>   static DEFINE_MUTEX(hybrid_capacity_lock);
>   
> +#ifdef CONFIG_ENERGY_MODEL
> +struct hybrid_em_perf_domain {
> +	cpumask_t cpumask;
> +	struct device *dev;
> +	struct em_data_callback cb;
> +};
> +
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
> +}
> +
> +static int hybrid_ecore_cost(struct device *dev, unsigned long freq,
> +			     unsigned long *cost)
> +{
> +	*cost = 1;
> +	return 0;
> +}

The artificial EM was introduced for CPPC based platforms since these platforms
only provide an 'efficiency class' entry to describe the relative efficiency
of CPUs. The case seems similar to yours.
'Fake' OPPs were created to have an incentive for EAS to balance the load on
the CPUs in one perf. domain. Indeed, in feec(), during the energy
computation of a pd, if the cost is independent from the max_util value,
then one CPU in the pd could end up having a high util, and another CPU a
NULL util.
For CPPC platforms, this was problematic as a lower OPP could have been
selected for the same load, so energy was lost for no reason.

In your case it seems that the OPP selection is done independently on each
CPU. However I assume it is still more energy efficient to have 2 CPUs
loaded at 50% than one CPU loaded at 100% and an idle CPU.

Also as Dietmar suggested, maybe it would make sense to have some
way to prefer an CPU with a "energy saving" HFI configuration than
a similar CPU with a "performance" HFI configuration.

Also, out of curiosity, do you have energy numbers to share ?

Regards,
Pierre

