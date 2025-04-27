Return-Path: <linux-pm+bounces-26300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79524A9E3EC
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB33BD96C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593081D5CFB;
	Sun, 27 Apr 2025 16:23:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3E522A;
	Sun, 27 Apr 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771004; cv=none; b=rolT1QUwDNlUjl4emhhsUX/pW1mSKa8x1syTWxmEn7ancDS32Ge7SUVafRP4AzEm7Zz9knh8S05PliREHXCSaiM3/E5A/XKFqESDYO98l5aVpe5TtpXCdhYgnpbwEW+F483EBIIuz4W9GSIT8b+QDtZ99NT3xTDG+nUCqOWZyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771004; c=relaxed/simple;
	bh=ZoFAR+DzIuQgSzDzF+2BJDpN4FfRssopwE4j8Pe4wBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqwwvdcSZWU+wtHb6IptThb5Ya6580jxVcE421dN4HFmc6lKVfkHSSMLf+mrk9rxBsP3eFaoncgsmVarWCh9WrSuT4uFxi3z8PRpkCKDM1HVLwSRukBb6/xGPT58g1UI/Ql7VX/mow4zsnwL3K7pzpx0W7OyK+DdjSoQ4DHCS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B04D106F;
	Sun, 27 Apr 2025 09:23:13 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7493F66E;
	Sun, 27 Apr 2025 09:23:13 -0700 (PDT)
Message-ID: <a8f11abd-758e-4e5e-bf78-419b95100918@arm.com>
Date: Sun, 27 Apr 2025 18:23:06 +0200
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
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <1964444.taCxCBeP46@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <1964444.taCxCBeP46@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2025 20:10, Rafael J. Wysocki wrote:
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

There seems to be an issue with late CPU-hotplug-in and this alignment
on L2 cache boundaries.

Example:

i7-13700K [P-cores: [0,2,4,6,8,10,12,14] E-cores: [16-23] w/ 'nosmt' and
'maxcpus=12', [16-19] & [20-23] share L2 cache.

root:/sys/kernel/debug/energy_model# cat cpu*/cpus
0
10
12
14
16-19
2
4
6
8

# echo 1 > /sys/devices/system/cpu/cpu20/online

...
[  496.616050] root_domain 0,2,4,6,8,10,12,14,16-20: pd20:{ cpus=20
nr_pstate=4 } pd16:{ cpus=16-19 nr_pstate=4 } pd14:{ cpus=14 nr_pstate=4
} pd12:{ cpus=12 nr_pstate=4 } pd10:{ cpus=10 nr_pstate=4 } pd8:{ cpus=8
nr_pstate=4 } pd6:{ cpus=6 nr_pstate=4 } pd4:{ cpus=4 nr_pstate=4 }
pd2:{ cpus=2 nr_pstate=4 } pd0:{ cpus=0 nr_pstate=4 }
...

root:/sys/kernel/debug/energy_model# cat cpu*/cpus
0
10
12
14
16-19
20
2
4
6
8

# echo 1 > /sys/devices/system/cpu/cpu21/online

...
[  589.001256] root domain span: 0,2,4,6,8,10,12,14,16-21
[  589.001265] pd_init: no EM found for CPU21
[  589.001266] sched_energy_set: stopping EAS
...

root:/sys/kernel/debug/energy_model# cat cpu*/cpus
0
10
12
14
16-19
20
2
4
6
8


