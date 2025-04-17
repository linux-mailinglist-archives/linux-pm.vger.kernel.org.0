Return-Path: <linux-pm+bounces-25629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F089BA91C94
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9FA19E507B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE024339C;
	Thu, 17 Apr 2025 12:42:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961D242917;
	Thu, 17 Apr 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893737; cv=none; b=E4QKXrV+T8pasTaaZkknqR96N7xckaUpY359OudqFpnXVwJGLClLIEQy3XPPt4B20Zyg3MtCRqtSoFeUTmRegiBoljHl3MrF9GQqon0sjI2Kp8uRsF/maLJMAYtQIzaVkHSgJWBUoiVXO5Xx0JFg6/uypFjwkc43rn9GP7n0QWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893737; c=relaxed/simple;
	bh=2SpWKf4ZPt9JumY9RoMh5nejz0XyYw6hMSWrET+8/Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5kne9djTZg4MgIWeKXDV7GqdC1ffRy2mK+IbtKqAykWZUwtin8pdw3zfW3uDR/7F+N2L/apHHLc/mdd9JV2eTI5CI37SdZ6Pe6zcYPeVY5CF194EMrZTJ2CIgJ5m86rznvxIVxDijXGRwjIXZQQRW2H0aNf3JYEhgWFNX7exsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48C0E1515;
	Thu, 17 Apr 2025 05:42:11 -0700 (PDT)
Received: from [10.1.25.43] (e127648.arm.com [10.1.25.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B9E73F694;
	Thu, 17 Apr 2025 05:42:12 -0700 (PDT)
Message-ID: <b8832097-71bd-4e68-918a-1e986457d03b@arm.com>
Date: Thu, 17 Apr 2025 13:42:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 7/8] cpufreq: intel_pstate: Align perf domains
 with L2 cache
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <1964444.taCxCBeP46@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1964444.taCxCBeP46@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 19:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some hybrid platforms a group of cores (referred to as a module) may
> share an L2 cache in which case they also share a voltage regulator and
> always run at the same frequency (while not in idle states).
> 
> For this reason, make hybrid_register_perf_domain() in the intel_pstate
> driver add all CPUs sharing an L2 cache to the same perf domain for EAS.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New in v1.
> 
> ---
>  drivers/cpufreq/intel_pstate.c |   23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -999,8 +999,11 @@
>  {
>  	static const struct em_data_callback cb
>  			= EM_ADV_DATA_CB(hybrid_active_power, hybrid_get_cost);
> +	struct cpu_cacheinfo *cacheinfo = get_cpu_cacheinfo(cpu);
> +	const struct cpumask *cpumask = cpumask_of(cpu);
>  	struct cpudata *cpudata = all_cpu_data[cpu];
>  	struct device *cpu_dev;
> +	int ret;
>  
>  	/*
>  	 * Registering EM perf domains without enabling asymmetric CPU capacity
> @@ -1014,9 +1017,25 @@
>  	if (!cpu_dev)
>  		return false;
>  
> -	if (em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
> -					cpumask_of(cpu), false))
> +	if (cacheinfo) {
> +		unsigned int i;
> +
> +		/* Find the L2 cache and the CPUs sharing it. */
> +		for (i = 0; i < cacheinfo->num_leaves; i++) {
> +			if (cacheinfo->info_list[i].level == 2) {
> +				cpumask = &cacheinfo->info_list[i].shared_cpu_map;
> +				break;
> +			}
> +		}
> +	}
> +
> +	ret = em_dev_register_perf_domain(cpu_dev, HYBRID_EM_STATE_COUNT, &cb,
> +					  cpumask, false);
> +	if (ret) {
> +		cpudata->em_registered = ret == -EEXIST;
> +
>  		return false;
> +	}
>  
>  	cpudata->em_registered = true;
>  
> 

debugfs already provides a way to retrieve that information, but with more
complex perf domain constructions like here maybe this would be useful
(maybe it already is):

--->8---

Subject: [PATCH] PM: EM: Print CPUs of perf domains

In preparation for future EAS users who make the relation from CPU
to perf-domain not strictly based on cpufreq policies print the
affected CPUs when registering a perf-domain.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 99a1ae324c2d..a202968b2ee9 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -627,7 +627,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	em_cpufreq_update_efficiencies(dev, em_table->state);
 
 	em_debug_create_pd(dev);
-	dev_info(dev, "EM: created perf domain\n");
+	dev_info(dev, "EM: created perf domain for CPUs %*pbl\n", cpumask_pr_args(cpus));
 
 unlock:
 	mutex_unlock(&em_pd_mutex);
-- 
2.34.1


