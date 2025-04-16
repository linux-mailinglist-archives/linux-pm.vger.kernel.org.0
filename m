Return-Path: <linux-pm+bounces-25542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6DA8B7C1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 13:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122235A11B8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7E23959E;
	Wed, 16 Apr 2025 11:35:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D46227E89;
	Wed, 16 Apr 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803328; cv=none; b=AQPQ6nR8Kn7VbDRV306bxxOysZDyEcEdoToFojeGl1/u6jujh+kyFXepIXpj9qTi6sCspJ3CmsPmXubVaYzgHLCa7S/KthpEvI/vvCRMlOh/SudL41gDYj6LByhVJeZN8axsX4IrNkoO21LTL3vtuqBxy2wlV9AjI1v3pkL81j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803328; c=relaxed/simple;
	bh=sPKjAvImyMFJm72uAbPaDc1i7kSMvUFuDDSUDld7wsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHFkIsYE6T2zGH7pK2PeHDJeK1zpXFxp5ZVv4nBRfE4LCMLNxNaSp1XFnkB0shpntK+ypHX3o7NKo70SbRkX7jVsbMWigvY6Kot9FsSQfid9hVGriSnOiGadP5quR2Ec3XLR1Rh8p+Cb3PU2YMnARD9TAkyFnqSQfvPCNJoEMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD0F152B;
	Wed, 16 Apr 2025 04:35:22 -0700 (PDT)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B113F66E;
	Wed, 16 Apr 2025 04:35:22 -0700 (PDT)
Message-ID: <3d5da654-4230-41e3-b746-589055777c69@arm.com>
Date: Wed, 16 Apr 2025 12:35:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] cpufreq/sched: Fix the usage of
 CPUFREQ_NEED_UPDATE_LIMITS
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <3010358.e9J7NaK4W3@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3010358.e9J7NaK4W3@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 10:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused
> by need_freq_update") modified sugov_should_update_freq() to set the
> need_freq_update flag only for drivers with CPUFREQ_NEED_UPDATE_LIMITS
> set, but that flag generally needs to be set when the policy limits
> change because the driver callback may need to be invoked for the new
> limits to take effect.
> 
> However, if the return value of cpufreq_driver_resolve_freq() after
> applying the new limits is still equal to the previously selected
> frequency, the driver callback needs to be invoked only in the case
> when CPUFREQ_NEED_UPDATE_LIMITS is set (which means that the driver
> specifically wants its callback to be invoked every time the policy
> limits change).
> 
> Update the code accordingly to avoid missing policy limits changes for
> drivers without CPUFREQ_NEED_UPDATE_LIMITS.
> 
> Fixes: 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
> Closes: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org/
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> 
> v1 -> v2:
>    * Always set need_freq_update when limits_changed is set.
>    * Take CPUFREQ_NEED_UPDATE_LIMITS into account in sugov_update_next_freq().
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |   18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -83,7 +83,7 @@
>  
>  	if (unlikely(sg_policy->limits_changed)) {
>  		sg_policy->limits_changed = false;
> -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +		sg_policy->need_freq_update = true;
>  		return true;
>  	}
>  
> @@ -95,10 +95,22 @@
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->need_freq_update)
> +	if (sg_policy->need_freq_update) {
>  		sg_policy->need_freq_update = false;
> -	else if (sg_policy->next_freq == next_freq)
> +		/*
> +		 * The policy limits have changed, but if the return value of
> +		 * cpufreq_driver_resolve_freq() after applying the new limits
> +		 * is still equal to the previously selected frequency, the
> +		 * driver callback need not be invoked unless the driver
> +		 * specifically wants that to happen on every update of the
> +		 * policy limits.
> +		 */
> +		if (sg_policy->next_freq == next_freq &&
> +		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> +			return false;
> +	} else if (sg_policy->next_freq == next_freq) {
>  		return false;
> +	}
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> 
> 
> 


