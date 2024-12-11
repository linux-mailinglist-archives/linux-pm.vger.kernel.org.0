Return-Path: <linux-pm+bounces-18997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD99ECA63
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E5616991D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16023211A33;
	Wed, 11 Dec 2024 10:33:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05290211A03;
	Wed, 11 Dec 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913219; cv=none; b=Bz7r7mX42EDBbUSMI2G4qz/JDtrX7NLgj0tGtoQ20BAF5H7z0PE7esTh1/Ft2HBlrdPIOaZqo/C2W0EadjtS56+hxTSe++v7JHyVr9zZNxW/yXql9mYEOc6zP4hiZTERyO5UUCWfgbpcTiFla+juEZdZpzZbPIAyeHaKWJ5rxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913219; c=relaxed/simple;
	bh=N7rHFJy8aXYAhJDzRjrgX0Pwi1zSYuP66NiIJ6ZPwzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUC+ep1JQDy9JHSaKI9jPjvAqfSEnpH+hhd3v6B2Mne5c1RFqdYm/cEgTboTKa+qRHNzOTb9kdbaI2US6BZpqKHY/hsXcYp4m/5bsd4skVN9CMGD+tNIq6iOdSAOySfOyIKcUZd98+tl9B7HGHZnSxOsOOtpPOoiZR2k2s9rsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C2291063;
	Wed, 11 Dec 2024 02:34:03 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318683F720;
	Wed, 11 Dec 2024 02:33:31 -0800 (PST)
Message-ID: <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com>
Date: Wed, 11 Dec 2024 10:33:29 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for
 EAS
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <2989520.e9J7NaK4W3@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2989520.e9J7NaK4W3@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 16:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it possible to use EAS with cpufreq drivers that implement the
> :setpolicy() callback instead of using generic cpufreq governors.
> 
> This is going to be necessary for using EAS with intel_pstate in its
> default configuration.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is the minimum of what's needed, but I'd really prefer to move
> the cpufreq vs EAS checks into cpufreq because messing around cpufreq
> internals in topology.c feels like a butcher shop kind of exercise.

Makes sense, something like cpufreq_eas_capable().

> 
> Besides, as I said before, I remain unconvinced about the usefulness
> of these checks at all.  Yes, one is supposed to get the best results
> from EAS when running schedutil, but what if they just want to try
> something else with EAS?  What if they can get better results with
> that other thing, surprisingly enough?

How do you imagine this to work then?
I assume we don't make any 'resulting-OPP-guesses' like
sugov_effective_cpu_perf() for any of the setpolicy governors.
Neither for dbs and I guess userspace.
What about standard powersave and performance?
Do we just have a cpufreq callback to ask which OPP to use for
the energy calculation? Assume lowest/highest?
(I don't think there is hardware where lowest/highest makes a
difference, so maybe not bothering with the complexity could
be an option, too.)

> 
> ---
>  kernel/sched/topology.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/kernel/sched/topology.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/topology.c
> +++ linux-pm/kernel/sched/topology.c
> @@ -217,6 +217,7 @@ static bool sched_is_eas_possible(const
>  	bool any_asym_capacity = false;
>  	struct cpufreq_policy *policy;
>  	struct cpufreq_governor *gov;
> +	bool cpufreq_ok;
>  	int i;
>  
>  	/* EAS is enabled for asymmetric CPU capacity topologies. */
> @@ -251,7 +252,7 @@ static bool sched_is_eas_possible(const
>  		return false;
>  	}
>  
> -	/* Do not attempt EAS if schedutil is not being used. */
> +	/* Do not attempt EAS if cpufreq is not configured adequately */
>  	for_each_cpu(i, cpu_mask) {
>  		policy = cpufreq_cpu_get(i);
>  		if (!policy) {
> @@ -261,11 +262,14 @@ static bool sched_is_eas_possible(const
>  			}
>  			return false;
>  		}
> +		/* Require schedutil or a "setpolicy" driver */
>  		gov = policy->governor;
> +		cpufreq_ok = gov == &schedutil_gov ||
> +				(!gov && policy->policy != CPUFREQ_POLICY_UNKNOWN);
>  		cpufreq_cpu_put(policy);
> -		if (gov != &schedutil_gov) {
> +		if (!cpufreq_ok) {
>  			if (sched_debug()) {
> -				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
> +				pr_info("rd %*pbl: Checking EAS, unsuitable cpufreq governor\n",
>  					cpumask_pr_args(cpu_mask));
>  			}
>  			return false;

The logic here looks fine to me FWIW.


