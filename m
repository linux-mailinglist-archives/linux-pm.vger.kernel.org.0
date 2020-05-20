Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389891DA995
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 07:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETFAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 01:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETFAR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 01:00:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9EDC061A0E
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 22:00:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so883788pgn.5
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 22:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QaxIGFD8jHmVVWBDhurC80V7YJ3c6OZJikPPga/xLT8=;
        b=oV7qcWIq+QUjh+p5X2N6/qwDruyKEBc1dUFlvyWKdI5MvoC9swHpy5J08pS/2gqkhT
         CFA2Tg/O2eV3xr73Ofgocvy5rS91QDhGnB+WeHTyMKrqq1aHNIgBw7Dh0GqHGoSwoDhL
         amnI4YwTZycIwJ80VU1ZhuTj0qX+t8BPQmYfkhGrFi+M4OhlZ1jnsZXu+/Uo/YW7BPll
         BzsxP7dEkSCWxuEJKW5cQW/8ee79LzgovnPDSYaLaFBpDT7gkcAeHKIQtMa2MTc+9m/+
         AibzcIXzbTGFj5TufSgWEVH+uPASB4jV93yGWFODYoIRYsZ9OaBn6b3vuzYu/sgLP12x
         CHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaxIGFD8jHmVVWBDhurC80V7YJ3c6OZJikPPga/xLT8=;
        b=SUjlsCfj893J9wroHV4H8lk6PiwllTEqiFBdgcGESjXIs1THRS+c5uPQpsDhS3BxCR
         oTObTq0aGhOUF9wKQz91wDqJPByBs7pkGphe63RPUVSvqbdWsPscJADO0H6ovfFJn3Ih
         /zkDpoVfvBhF8j8IXj363a5HuShU6U50T4D62Eyb4oKlUq8Gbt8SJ56VQ0m2nWSD3wfd
         Vllmr68vNDt8vxzZjRDEZDj8Jb/VhhvKkXDt3Jj3+2I1gay2gyx2FnovG8hUKkJQYhin
         40lPc0RyQ8vctdo6QRnwLjJzEirsF0x6Sj2OdPgzi2Lg8MqjXyM/NfkanYVEwUq6aesT
         7geA==
X-Gm-Message-State: AOAM531VrI0npBxNC19947vqBriaIhQHhao8aQ3vuJoH5BHS8ZUceyFf
        Fx5NMzAgOdXdTuvTCIT5ik5CTw==
X-Google-Smtp-Source: ABdhPJyfKsbIaXqxVGHZTQx2Y4OfuMFdkbnDNsj1D8KQxFQoEnTjtiS+OPtTZhhMSEdByg8AHiPaag==
X-Received: by 2002:a62:5ac5:: with SMTP id o188mr2597090pfb.37.1589950817112;
        Tue, 19 May 2020 22:00:17 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id p62sm926052pfb.93.2020.05.19.22.00.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 22:00:16 -0700 (PDT)
Date:   Wed, 20 May 2020 10:30:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] CPPC: add support for SW BOOST
Message-ID: <20200520050014.qpnnmyas2z7mvcss@vireshk-i7>
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589888489-13828-3-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589888489-13828-3-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-05-20, 19:41, Xiongfeng Wang wrote:
> To add SW BOOST support for CPPC, we need to get the max frequency of
> boost mode and non-boost mode. ACPI spec 6.2 section 8.4.7.1 describe
> the following two CPC registers.
> 
> "Highest performance is the absolute maximum performance an individual
> processor may reach, assuming ideal conditions. This performance level
> may not be sustainable for long durations, and may only be achievable if
> other platform components are in a specific state; for example, it may
> require other processors be in an idle state.
> 
> Nominal Performance is the maximum sustained performance level of the
> processor, assuming ideal operating conditions. In absence of an
> external constraint (power, thermal, etc.) this is the performance level
> the platform is expected to be able to maintain continuously. All
> processors are expected to be able to sustain their nominal performance
> state simultaneously."
> 
> To add SW BOOST support for CPPC, we can use Highest Performance as the
> max performance in boost mode and Nominal Performance as the max
> performance in non-boost mode. If the Highest Performance is greater
> than the Nominal Performance, we assume SW BOOST is supported.
> 
> The current CPPC driver does not support SW BOOST and use 'Highest
> Performance' as the max performance the CPU can achieve. 'Nominal
> Performance' is used to convert 'performance' to 'frequency'. That
> means, if firmware enable boost and provide a value for Highest
> Performance which is greater than Nominal Performance, boost feature is
> enabled by default.
> 
> Because SW BOOST is disabled by default, so, after this patch, boost
> feature is disabled by default even if boost is enabled by firmware.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index bda0b24..792ed9e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -37,6 +37,7 @@
>   * requested etc.
>   */
>  static struct cppc_cpudata **all_cpu_data;
> +static bool boost_supported;
>  
>  struct cppc_workaround_oem_info {
>  	char oem_id[ACPI_OEM_ID_SIZE + 1];
> @@ -310,7 +311,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>  	 */
>  	policy->min = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_nonlinear_perf);
> -	policy->max = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.highest_perf);
> +	policy->max = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
>  
>  	/*
>  	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
> @@ -318,7 +319,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	 * nonlinear perf
>  	 */
>  	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_perf);
> -	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.highest_perf);
> +	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
>  
>  	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
>  	policy->shared_type = cpu->shared_type;
> @@ -343,6 +344,13 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpu->cur_policy = policy;
>  
> +	/*
> +	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
> +	 * is supported.
> +	 */
> +	if (cpu->perf_caps.highest_perf > cpu->perf_caps.nominal_perf)
> +		boost_supported = true;
> +
>  	/* Set policy->cur to max now. The governors will adjust later. */
>  	policy->cur = cppc_cpufreq_perf_to_khz(cpu,
>  					cpu->perf_caps.highest_perf);
> @@ -410,6 +418,32 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>  	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>  }
>  
> +static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> +{
> +	struct cppc_cpudata *cpudata;
> +	int ret = 0;

No need to initialize this.

> +
> +	if (!boost_supported) {
> +		pr_err("BOOST not supported by CPU or firmware\n");
> +		return -EINVAL;
> +	}
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +	if (state)
> +		policy->max = cppc_cpufreq_perf_to_khz(cpudata,
> +					cpudata->perf_caps.highest_perf);
> +	else
> +		policy->max = cppc_cpufreq_perf_to_khz(cpudata,
> +					cpudata->perf_caps.nominal_perf);
> +	policy->cpuinfo.max_freq = policy->max;
> +
> +	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.verify = cppc_verify_policy,
> @@ -417,6 +451,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>  	.get = cppc_cpufreq_get_rate,
>  	.init = cppc_cpufreq_cpu_init,
>  	.stop_cpu = cppc_cpufreq_stop_cpu,
> +	.set_boost = cppc_cpufreq_set_boost,
>  	.name = "cppc_cpufreq",
>  };
>  
> -- 
> 1.7.12.4

-- 
viresh
