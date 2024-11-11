Return-Path: <linux-pm+bounces-17320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042689C3DCB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FAE1C20CBC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E418E02D;
	Mon, 11 Nov 2024 11:54:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30E176FA2;
	Mon, 11 Nov 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326084; cv=none; b=tEtLuqVYugxFVijXoPSSlBPQTNR4IwSqKY2WIrCN8gSHmm1mtCc+NCjlhWJ7J4CJEhd5cBhrihv65LqlWCa+SwHVK8tgxumu4U7l2BdaZJ1wbBWR/Qx6JUdwbbXqsST7K/+1WDt6BXodbc1dGmj3fy71d3FFK9TSY1KA/8I7w38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326084; c=relaxed/simple;
	bh=756LK5sllhm9bRq/weTu1UQc4I2fsrG+N166MJqHLJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjWpcpGD7Ob7R2KsyDMC/qiNdYeEt65EJtP7MhAvtwolqa8on8shj36vvIyARoFX+2yDfFx2HqTy+h1QMWry8qOLL1ZGUXgizDZ+sx5SlJnGbd53spCDKoWXkVZ/1CdDegWqgCZhhC0RnkWLeaCKyNt4v3sISYxl8OVSEWYnZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F7C11FB;
	Mon, 11 Nov 2024 03:55:10 -0800 (PST)
Received: from [10.1.36.17] (e127648.arm.com [10.1.36.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8C03F6A8;
	Mon, 11 Nov 2024 03:54:37 -0800 (PST)
Message-ID: <64a63f1c-088d-43dc-85c3-cecf8b59764f@arm.com>
Date: Mon, 11 Nov 2024 11:54:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.1 5/6] sched/topology: Allow .setpolicy() cpufreq
 drivers to enable EAS
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <1889415.atdPhlSkOF@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1889415.atdPhlSkOF@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 16:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some cpufreq drivers, like intel_pstate, have built-in governors that
> are used instead of regular cpufreq governors, schedutil in particular,
> but they can work with EAS just fine, so allow EAS to be used with
> those drivers.
> 
> Also update the debug message printed when the cpufreq governor in
> use is not schedutil and the related comment, to better match the
> code after the change.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> I'm not sure how much value there is in refusing to enable EAS without
> schedutil in general.  For instance, if there are no crossover points
> between the cost curves for different perf domains, EAS may as well be
> used with the performance and powersave governors AFAICS.
 
Agreed, but having no cross-over points or no DVFS at all should be the
only instances, right?
For plain (non-intel_pstate) powersave and performance we could replace
sugov_effective_cpu_perf()
that determines the OPP of the perf-domain by the OPP they will be
choosing, but for the rest?
Also there is the entire uclamp thing, not sure what the best
solution is there.
Will intel_pstate just always ignore it? Might be better then to
depend on !intel_pstate?

> ---
>  kernel/sched/topology.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/kernel/sched/topology.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/topology.c
> +++ linux-pm/kernel/sched/topology.c
> @@ -251,7 +251,7 @@ static bool sched_is_eas_possible(const
>  		return false;
>  	}
>  
> -	/* Do not attempt EAS if schedutil is not being used. */
> +	/* Do not attempt EAS with a cpufreq governor other than schedutil. */
>  	for_each_cpu(i, cpu_mask) {
>  		policy = cpufreq_cpu_get(i);
>  		if (!policy) {
> @@ -263,9 +263,9 @@ static bool sched_is_eas_possible(const
>  		}
>  		gov = policy->governor;
>  		cpufreq_cpu_put(policy);
> -		if (gov != &schedutil_gov) {
> +		if (gov && gov != &schedutil_gov) {
>  			if (sched_debug()) {
> -				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
> +				pr_info("rd %*pbl: Checking EAS, cpufreq governor is not schedutil\n",
>  					cpumask_pr_args(cpu_mask));
>  			}
>  			return false;
> 
> 
> 
> 


