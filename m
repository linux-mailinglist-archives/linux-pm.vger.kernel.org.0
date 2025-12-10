Return-Path: <linux-pm+bounces-39401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21294CB28EF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 10:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0274C30F1962
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA1C2DF128;
	Wed, 10 Dec 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FN30c93d"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A698217F31;
	Wed, 10 Dec 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358807; cv=none; b=L9IKiOrDpRWCv/lYSq7561r4yY/xlWU/gqtgbzSEuxr0AzgcNdHA5ZP9nceEN5LuDlRblshPGBFXai46bnElhSHE9nQISQn+yPT2K1VvkVf5k9asupwd/hGMD15buHng+AVRuEzVEcS9YH2SWTd1CirCQUcy7ygwKGO/r4VVK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358807; c=relaxed/simple;
	bh=lUgc/HqkFGklmFP/hsaNDHkuXKQLbK5M/82r4NV1gNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m91NSGcXZUoIKdALwQBIJrTxnA7HbXh1MUNXRmN26wLiDs3fZslrwLTZGF3I8UhiBg9Olczu09oC7DQBJTcZGZdYVtlWnxvmkAZZZj5fdTPGQdYtndNbQKl74m+N0f0aVExoNXtj3w4M90VXAjw1CkCr/IVSyfmWInquft+/y2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FN30c93d; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l2jRMQhPYK+39qM2zlNsZvGOrs4C3ONTajeF6IKfB5Y=;
	b=FN30c93d+OeWdqf7nfMexUjLBDTNP3o3UZDUAPVdMNbElmNrOhryWshiM2h4IRAJpLXpCe27o
	kV72aR7UCJU5V+inqBn/1yWW/Kf3jWRva7XYtUtGEoKGh8iwtQBFcHERzU7hSs+kq0k/8hGhkKM
	MLoRrNU0nQG6rExQZaUeS3o=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dR9Jd5zL0zcb1b;
	Wed, 10 Dec 2025 17:24:01 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 71BCA180BDD;
	Wed, 10 Dec 2025 17:26:42 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Dec
 2025 17:26:41 +0800
Message-ID: <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
Date: Wed, 10 Dec 2025 17:26:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251208105933.1369125-4-pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/8 18:59, Pierre Gondois wrote:
> In the existing set_boost() callbacks:
> - Don't update policy->max as this is done through the qos notifier
>   cpufreq_notifier_max() which calls cpufreq_set_policy().
> - Remove freq_qos_update_request() calls as the qos request is now
>   done in policy_set_boost() and updates the new boost_freq_req
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/amd-pstate.c   |  2 --
>  drivers/cpufreq/cppc_cpufreq.c | 21 ++++-----------------
>  drivers/cpufreq/cpufreq.c      | 14 ++------------
>  3 files changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b44f0f7a5ba1c..50416358a96ac 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -754,8 +754,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  	else if (policy->cpuinfo.max_freq > nominal_freq)
>  		policy->cpuinfo.max_freq = nominal_freq;
>  
> -	policy->max = policy->cpuinfo.max_freq;
> -
>  	if (cppc_state == AMD_PSTATE_PASSIVE) {
>  		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>  		if (ret < 0)
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index e23d9abea1359..3baf7baaec371 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -597,21 +597,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	caps = &cpu_data->perf_caps;
>  	policy->driver_data = cpu_data;
>  
> -	/*
> -	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
> -	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
> -	 */
> -	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> -	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> -						caps->highest_perf : caps->nominal_perf);

Why remove this?

> -
>  	/*
>  	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
>  	 * available if userspace wants to use any perf between lowest & lowest
>  	 * nonlinear perf
>  	 */
>  	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> +	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
> +						caps->highest_perf : caps->nominal_perf);
>  
>  	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>  	policy->shared_type = cpu_data->shared_type;
> @@ -776,17 +769,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -	int ret;
>  
>  	if (state)
> -		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>  	else
> -		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
> -	policy->cpuinfo.max_freq = policy->max;
> -
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
> +		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>  
>  	return 0;
>  }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 65ef0fa70c388..ab2def9e4d188 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1514,10 +1514,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  				CPUFREQ_CREATE_POLICY, policy);
> -	} else {
> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -		if (ret < 0)
> -			goto out_destroy_policy;

I think boost_freq_req should be updated here, to solve the problem that
this code originally intended to solve.

>  	}
>  
>  	if (cpufreq_driver->get && has_target()) {
> @@ -2819,16 +2815,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>  		return -ENXIO;
>  
>  	ret = cpufreq_frequency_table_cpuinfo(policy);

cpufreq_frequency_table_cpuinfo() may change policy->max. I believe this
isn't what you want.

> -	if (ret) {
> +	if (ret)
>  		pr_err("%s: Policy frequency update failed\n", __func__);
> -		return ret;
> -	}
>  
> -	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>  


