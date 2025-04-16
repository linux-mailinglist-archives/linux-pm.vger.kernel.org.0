Return-Path: <linux-pm+bounces-25528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C5A8B444
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E25188C72B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42222FF2B;
	Wed, 16 Apr 2025 08:47:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAE1B808;
	Wed, 16 Apr 2025 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793243; cv=none; b=Ks0u2fP8/dIa/a7bJn2szFzgnKrLd3Zutkcr7D9Or4+ZohoL+teA6DYwQXkdixQaQlbNJV7Xb4XK2Ula4eAGZO0rajXObYLbRsvu+XsN9wCVENx6jbgIkC1vkbQg5w1XSjcOUi3JgkGhHKlcIWKSdpU28wNx34U8GLNU0QOBbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793243; c=relaxed/simple;
	bh=fLXHMkxoJ8Z1dDK7dL/OMmJXrTAheJQWIFyzqwbg7a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=edDdvqF8aaHFhuNBwQbTHrXgiE+/NGKDixhwXsIDH2zOUlJlRzICFj/Hvwq6YMfpV89ZrIuCuBzjXR4cne1rE/MV7QiYvRN+tPTGqGvUgd7i4EVuhZcyKsUJt1IqAQyXaDUCnENUbi2KxGRCozp9uS++59844Mk4yj/SPWIhIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zcvjk5BfLz1R7Z5;
	Wed, 16 Apr 2025 16:45:14 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 51FAE1401F3;
	Wed, 16 Apr 2025 16:47:11 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Apr
 2025 16:47:10 +0800
Message-ID: <87665307-1be3-465b-ab7c-3bf908b45217@huawei.com>
Date: Wed, 16 Apr 2025 16:47:10 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/16 13:29, Viresh Kumar wrote:

> The boost-related code in cpufreq has undergone several changes over the
> years, but this particular piece remained unchanged and is now outdated.
> 
> The cpufreq core currently manages boost settings during initialization,
> and only when necessary. As such, there's no longer a need to enable
> boost explicitly when entering system suspend.
> 
> Previously, this wasn’t causing issues because boost settings were
> force-updated during policy initialization. However, commit 2b16c631832d
> ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()") changed
> that behavior—correctly—by avoiding unnecessary updates.
> 
> As a result of this change, if boost was disabled prior to suspend, it
> remains disabled on resume—as expected. But due to the current code
> forcibly enabling boost at suspend time, the system ends up with boost
> frequencies enabled after resume, even if the global boost flag was
> disabled. This contradicts the intended behavior.
> 
> Fix this by not enabling boost on policy exit.
> 
> Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220013
> Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 924314cdeebc..85b5a88f723f 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -89,8 +89,9 @@ static bool boost_state(unsigned int cpu)
>  	return false;
>  }
>  
> -static int boost_set_msr(bool enable)
> +static void boost_set_msr_each(void *p_en)
>  {
> +	bool enable = (bool) p_en;
>  	u32 msr_addr;
>  	u64 msr_mask, val;
>  
> @@ -107,7 +108,7 @@ static int boost_set_msr(bool enable)
>  		msr_mask = MSR_K7_HWCR_CPB_DIS;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return;
>  	}
>  
>  	rdmsrl(msr_addr, val);
> @@ -118,14 +119,6 @@ static int boost_set_msr(bool enable)
>  		val |= msr_mask;
>  
>  	wrmsrl(msr_addr, val);
> -	return 0;
> -}
> -
> -static void boost_set_msr_each(void *p_en)
> -{
> -	bool enable = (bool) p_en;
> -
> -	boost_set_msr(enable);
>  }
>  
>  static int set_boost(struct cpufreq_policy *policy, int val)
> @@ -532,15 +525,6 @@ static void free_acpi_perf_data(void)
>  	free_percpu(acpi_perf_data);
>  }
>  
> -static int cpufreq_boost_down_prep(unsigned int cpu)
> -{
> -	/*
> -	 * Clear the boost-disable bit on the CPU_DOWN path so that
> -	 * this cpu cannot block the remaining ones from boosting.
> -	 */
> -	return boost_set_msr(1);
> -}
> -
>  /*
>   * acpi_cpufreq_early_init - initialize ACPI P-States library
>   *
> @@ -931,7 +915,6 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s\n", __func__);
>  
> -	cpufreq_boost_down_prep(policy->cpu);
>  	policy->fast_switch_possible = false;
>  	policy->driver_data = NULL;
>  	acpi_processor_unregister_performance(data->acpi_perf_cpu);

Nice!

I wonder why this cpufreq_boost_down_prep() was needed at the beginning.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>


