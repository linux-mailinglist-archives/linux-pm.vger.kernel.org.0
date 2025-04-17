Return-Path: <linux-pm+bounces-25624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A76A91BC8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5F43B098D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA021C168;
	Thu, 17 Apr 2025 12:19:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6B39851;
	Thu, 17 Apr 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892385; cv=none; b=PHGCbuueL/NpYw51tV7Yda/Nsr1HkqiAM3Yy2YhanxcxVP43HaahLpGUYKtaJD+rsIPHE1trBuJ2UBAPis7b52WVngLEwiMJY0v/8FlA9ANREhctCVtOqEgOfOrGiXEjIi0jffV3qJlNnjzGHQay+QeHYCrIDNJEMqZV4D20gA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892385; c=relaxed/simple;
	bh=7oGjk65zLyxi8wQEHBBN+pE4ICLq8BTgj4YoVvfc/5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWwGsTbknOzKOXWFevqvzFIgi+sfj8Dw55Q2b7b/rRxZ7nnPYsNBp9cSpY9LXbowCsmAvaJOJPUWd90MX9YNzSKe8mQa8T3lXDsQCwap13HPZM01pFBV/1Qop3YBoQvm3GVbO62rXhBZsVJJFESSG7ZC8ocULdbwVEDhhjp3iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432E91515;
	Thu, 17 Apr 2025 05:19:40 -0700 (PDT)
Received: from [10.1.25.43] (e127648.arm.com [10.1.25.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62BB83F694;
	Thu, 17 Apr 2025 05:19:41 -0700 (PDT)
Message-ID: <e439a75c-fe36-4fba-b394-c154adeff15a@arm.com>
Date: Thu, 17 Apr 2025 13:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 3/8] cpufreq/sched: Allow .setpolicy() cpufreq
 drivers to enable EAS
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
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <8554829.NyiUUSuA9g@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <8554829.NyiUUSuA9g@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 19:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some cpufreq drivers, like intel_pstate, have built-in governors that
> are used instead of regular cpufreq governors, schedutil in particular,
> but they can work with EAS just fine, so allow EAS to be used with
> those drivers.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v0.3 -> v1
>      * Rebase on top of the new [1-2/8].
>      * Update the diagnostic message printed if the conditions are not met.
> 
> This patch is regarded as a cleanup for 6.16.
> 
> ---
>  drivers/cpufreq/cpufreq.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -3054,7 +3054,16 @@
>  
>  	guard(cpufreq_policy_read)(policy);
>  
> -	return sugov_is_governor(policy);
> +	/*
> +	 * For EAS compatibility, require that either schedutil is the policy
> +	 * governor or the policy is governed directly by the cpufreq driver.
> +	 *
> +	 * In the latter case, it is assumed that EAS can only be enabled by the
> +	 * cpufreq driver itself which will not enable EAS if it does not meet
> +	 * the EAS' expectations regarding performance scaling response.
> +	 */
> +	return sugov_is_governor(policy) || (!policy->governor &&
> +		policy->policy != CPUFREQ_POLICY_UNKNOWN);
>  }
>  
>  bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
> @@ -3064,7 +3073,7 @@
>  	/* Do not attempt EAS if schedutil is not being used. */
>  	for_each_cpu(cpu, cpu_mask) {
>  		if (!cpufreq_policy_is_good_for_eas(cpu)) {
> -			pr_debug("rd %*pbl: schedutil is mandatory for EAS\n",
> +			pr_debug("rd %*pbl: EAS requirements not met\n",
>  				 cpumask_pr_args(cpu_mask));

I'd prefer to have at least "EAS cpufreq requirements" printed here.
with that caveat
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Maybe we should amend the EAS documentation to reflect this?
(And also emphasise that EAS will make cpufreq assumptions as if sugov
was the governor regardless.)

>  			return false;
>  		}
> 
> 
> 


