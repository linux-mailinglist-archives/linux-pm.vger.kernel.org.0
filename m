Return-Path: <linux-pm+bounces-18808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8249E9084
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D04162504
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D012185A3;
	Mon,  9 Dec 2024 10:36:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A50217F44;
	Mon,  9 Dec 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740594; cv=none; b=Ivv8O4eonPUJZGU95sEbqhqvxAP8dlwPHNxh/HD0EieKtipMUxPGq3D4P/0iz0U6WFT/Qmm22DopwdjBmYuFN/rhpkCRdZOm0OUEgzA66GCPCqRwc2fD23k2SutuJhPBYWuTx7TfYpr6FZpiDdblLq2VWxg2+Vp57NnUd0X3ab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740594; c=relaxed/simple;
	bh=T5aO+Tj718wETGZ7W2trjzi2rdQbKIPvyHWipOm+IyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qacXhUH7HvoJWt6UOehv4sDkJtWsuEDvZaiy2ADzyDm19gpzlHM6oKZ3SF+SUAp+wI2Rr1vYMA5+AgyD428avJWuGX45vTlotbE70meFPb8dSpnBGK7B9k2KaO/FPpl3X0BDN3J+DqB+dQUZVDidPKy8XDBshES6dxD65SvxKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAFA9113E;
	Mon,  9 Dec 2024 02:36:59 -0800 (PST)
Received: from [10.1.39.16] (e127648.arm.com [10.1.39.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9FA93F720;
	Mon,  9 Dec 2024 02:36:29 -0800 (PST)
Message-ID: <09acd46b-ec63-46ec-a239-e792c3061e52@arm.com>
Date: Mon, 9 Dec 2024 10:36:27 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpufreq: userspace: Add fast-switch support for
 userspace
To: Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, guohua.yan@unisoc.com, ke.wang@unisoc.com,
 xuewen.yan94@gmail.com
References: <20241209081429.1871-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241209081429.1871-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 08:14, Xuewen Yan wrote:
> Now, the userspace governor does not support userspace,
> if the driver only use the fast-switch and not add target_index(),

Which driver does that? Is that actually valid?
No mainline driver from what I can see.

> it will cause uerspace not work.

s/uerspace/userspace
to not work?

> So add fast-switch support for userspace governor.
> 
> Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/cpufreq/cpufreq_userspace.c | 35 +++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index 2c42fee76daa..3a99197246ed 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -21,6 +21,30 @@ struct userspace_policy {
>  	struct mutex mutex;
>  };
>  
> +static int cpufreq_userspace_target_freq(struct cpufreq_policy *policy,
> +			unsigned int target_freq, unsigned int relation)
> +{
> +	int ret;

not really necessary

> +
> +	if (policy->fast_switch_enabled) {
> +		unsigned int idx;
> +
> +		target_freq = clamp_val(target_freq, policy->min, policy->max);
> +
> +		if (!policy->freq_table)
> +			return target_freq;
> +
> +		idx = cpufreq_frequency_table_target(policy, target_freq, relation);
> +		policy->cached_resolved_idx = idx;
> +		policy->cached_target_freq = target_freq;
> +		ret = !cpufreq_driver_fast_switch(policy, policy->freq_table[idx].frequency);
> +	} else {
> +		ret = __cpufreq_driver_target(policy, target_freq, relation);

NIT: could save the indent if you reverse conditions and ret early on !fast_switch

> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * cpufreq_set - set the CPU frequency
>   * @policy: pointer to policy struct where freq is being set
> @@ -41,7 +65,7 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
>  
>  	userspace->setspeed = freq;
>  
> -	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
> +	ret = cpufreq_userspace_target_freq(policy, freq, CPUFREQ_RELATION_L);
>   err:
>  	mutex_unlock(&userspace->mutex);
>  	return ret;
> @@ -62,6 +86,8 @@ static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
>  
>  	mutex_init(&userspace->mutex);
>  
> +	cpufreq_enable_fast_switch(policy);
> +
>  	policy->governor_data = userspace;
>  	return 0;
>  }
> @@ -72,6 +98,7 @@ static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
>   */
>  static void cpufreq_userspace_policy_exit(struct cpufreq_policy *policy)
>  {
> +	cpufreq_disable_fast_switch(policy);
>  	kfree(policy->governor_data);
>  	policy->governor_data = NULL;
>  }
> @@ -112,13 +139,13 @@ static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
>  		 policy->cpu, policy->min, policy->max, policy->cur, userspace->setspeed);
>  
>  	if (policy->max < userspace->setspeed)
> -		__cpufreq_driver_target(policy, policy->max,
> +		cpufreq_userspace_target_freq(policy, policy->max,
>  					CPUFREQ_RELATION_H);
>  	else if (policy->min > userspace->setspeed)
> -		__cpufreq_driver_target(policy, policy->min,
> +		cpufreq_userspace_target_freq(policy, policy->min,
>  					CPUFREQ_RELATION_L);
>  	else
> -		__cpufreq_driver_target(policy, userspace->setspeed,
> +		cpufreq_userspace_target_freq(policy, userspace->setspeed,
>  					CPUFREQ_RELATION_L);
>  
>  	mutex_unlock(&userspace->mutex);


