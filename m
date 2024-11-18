Return-Path: <linux-pm+bounces-17727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD609D1469
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 16:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8496B1F22805
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F219EEC0;
	Mon, 18 Nov 2024 15:25:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D251863F;
	Mon, 18 Nov 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943504; cv=none; b=O7BHQDG17oYmnJGa5cbOvFBvFN9cRb6/fSLl8g+tNbFvG8Q4RzP+n50kSDZwB482VLCZ5mTywTy1+l4sWowRh6moQc8i6ETYZm/7r+vvcgPy+2iVkE0zuS5PFdNPVUFLxdqLRKDHS9ZZ/nHzSjDeHmMj3l52loqB8I9iOC3zOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943504; c=relaxed/simple;
	bh=tsXifg2pVa2WN/mQuGl3FGYm8qUkMzHeAqJWv2OcvN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A37TPNEcpb7kMaWYOEnhfGLMoChLO+cihTAUw8u8VI0LEK11PBc2yal7XgxPb6biIn9gVtpUKtJhdSUnhMYGk3DNvXT0aLjNCXhQJG0j7e0f4fIVHYBTPub36ZKsaN6H+gOjTnkDKbecSWGbF2upx10UvyLZlyL/QEvB6APCqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D782165C;
	Mon, 18 Nov 2024 07:25:32 -0800 (PST)
Received: from [10.1.38.74] (e133649.arm.com [10.1.38.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B54D3F5A1;
	Mon, 18 Nov 2024 07:25:00 -0800 (PST)
Message-ID: <173507d9-ec20-431d-a444-0531fd346c03@arm.com>
Date: Mon, 18 Nov 2024 15:24:58 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.1 3/6] PM: EM: Add special case to
 em_dev_register_perf_domain()
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
 <2017201.usQuhbGJ8B@rjwysocki.net>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <2017201.usQuhbGJ8B@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2024 16:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Allow em_dev_register_perf_domain() to register a cost-only stub
> perf domain with one-element states table if the .active_power()
> callback is not provided.
> 
> Subsequently, this will be used by the intel_pstate driver to register
> stub perf domains for CPUs on hybrid systems.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   kernel/power/energy_model.c |   26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/kernel/power/energy_model.c
> ===================================================================
> --- linux-pm.orig/kernel/power/energy_model.c
> +++ linux-pm/kernel/power/energy_model.c
> @@ -426,9 +426,11 @@ static int em_create_pd(struct device *d
>   	if (!em_table)
>   		goto free_pd;
>   
> -	ret = em_create_perf_table(dev, pd, em_table->state, cb, flags);
> -	if (ret)
> -		goto free_pd_table;
> +	if (cb->active_power) {
> +		ret = em_create_perf_table(dev, pd, em_table->state, cb, flags);
> +		if (ret)
> +			goto free_pd_table;
> +	}
>   
>   	ret = em_compute_costs(dev, em_table->state, cb, nr_states, flags);
>   	if (ret)
> @@ -561,11 +563,20 @@ int em_dev_register_perf_domain(struct d
>   {
>   	unsigned long cap, prev_cap = 0;
>   	unsigned long flags = 0;
> +	bool stub_pd = false;
>   	int cpu, ret;
>   
>   	if (!dev || !nr_states || !cb)
>   		return -EINVAL;
>   
> +	if (!cb->active_power) {
> +		if (!cb->get_cost || nr_states > 1 || microwatts)
> +			return -EINVAL;
> +
> +		/* Special case: a stub perf domain. */
> +		stub_pd = true;
> +	}
> +

I wonder if the only purpose of stub_pd is to just skip the capacity 
check below, which doesn't look very nice.

I may be echoing Dietmar's comments here. What's the problem of just 
having 3 domains?

Or, could you just specify the same capacities so that the same-capacity 
check won't fail, but just to use hardware load or CPU pressure to model 
the slight difference in real capacities? This way you'd re-use a lot of 
existing infrastructure.

>   	/*
>   	 * Use a mutex to serialize the registration of performance domains and
>   	 * let the driver-defined callback functions sleep.
> @@ -590,6 +601,15 @@ int em_dev_register_perf_domain(struct d
>   				ret = -EEXIST;
>   				goto unlock;
>   			}
> +
> +			/*
> +			 * The capacity need not be the same for all CPUs in a
> +			 * stub perf domain, so long as the average cost of
> +			 * running on each of them is approximately the same.
> +			 */
> +			if (stub_pd)
> +				continue;
> +
>   			/*
>   			 * All CPUs of a domain must have the same
>   			 * micro-architecture since they all share the same
> 
> 
> 


