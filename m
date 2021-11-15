Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF03451631
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 22:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbhKOVRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 16:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347359AbhKOVHy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 16:07:54 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD7C0432DD
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 12:57:24 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id gu12so12227233qvb.6
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPT9XAU/7JpIm6Qep/HBtxJcXg28nk1b69xhCAPgyow=;
        b=Zdm/AfV8kEFGTw/aIHwCkvhXjDEGegV0JkdM5cSpODOMM3belmA7Ovd3CYd4jdBez8
         Gbl3UTa/utmJlMlP69itLjU2qp38ek5YYc5i7KR8LG4sRQcaher2u5Xt2wfnyqG8VJNT
         6TRiLwDAisTck8FnbrKkI4+UCXoRJa7neLKzUe68+7gKXzR6koKht7fKbmKBGdEzoGW5
         BOazMuedWQ/eEvLMgEaa4+1LgbBIZtNXVqzVYUjzUSV+pGtNCtNp74qSBezXyv7qEJNH
         Dw/CV8WkYcpNgjhn6PBH2L6aEsiXjzq1yY0v6/nCrOruYvg+NxojjKtpNt/2tBfLjGZU
         s5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPT9XAU/7JpIm6Qep/HBtxJcXg28nk1b69xhCAPgyow=;
        b=y6cf3pYYPIFuiiU4+sNL6puahZLTClaQz+AE8BV1gaFK0EArSM/NqGEcC7jbIH11LS
         OLp6IFIFMV4ieQYXBsJA+NZPfjVg/BFIhL2Lxi1CI5FWe4RTrkPfNVFuDc4cBH/MYNLd
         9Fm5zp1YyYs2msCQp0hdfrvxjKkiSDVa+E5eht33sBZQbitv0MIzO/GyRIYBuWxeRcpv
         pAdBig8CPreZ+6PebxX9x4O7M2HPuTDl1c0Xdahr6/vG8WJVn+b7jxP0JpDDmNecLtOC
         7t2sVt6FP49G/ZkrBe7Bm+ofyVMPZ6XckTAEINb7jjT+F7soF/xHr+BUQYgPvSVYHjQ5
         XM5A==
X-Gm-Message-State: AOAM533Mvp5otf2B4fAOZyVSoluAgEZYVg/iQu3xbvE2R+yWWN0O/s+5
        Bzs5yypXR8kOpJ4pnXQJw5BzBA==
X-Google-Smtp-Source: ABdhPJwO58ELEc1T0JPvckGTGCiJeBdgLLOXwJ+Jnu7Y5B2iMNp3qAvobyqkr2sjk4jHtmbo2g/6Bw==
X-Received: by 2002:ad4:5f4c:: with SMTP id p12mr40675290qvg.33.1637009843477;
        Mon, 15 Nov 2021 12:57:23 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id j21sm6870072qkk.27.2021.11.15.12.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 12:57:22 -0800 (PST)
Subject: Re: [PATCH v4 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure
 update function
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211109195714.7750-1-lukasz.luba@arm.com>
 <20211109195714.7750-5-lukasz.luba@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <02a848c8-a672-f3df-7144-979a9df71fcb@linaro.org>
Date:   Mon, 15 Nov 2021 15:57:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211109195714.7750-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/9/21 2:57 PM, Lukasz Luba wrote:
> Thermal pressure provides a new API, which allows to use CPU frequency
> as an argument. That removes the need of local conversion to capacity.
> Use this new API and remove old local conversion code.
> 
> The new arch_update_thermal_pressure() also accepts boost frequencies,
> which solves issue in the driver code with wrong reduced capacity
> calculation. The reduced capacity was calculated wrongly due to
> 'policy->cpuinfo.max_freq' used as a divider. The value present there was
> actually the boost frequency. Thus, even a normal maximum frequency value
> which corresponds to max CPU capacity (arch_scale_cpu_capacity(cpu_id))
> is not able to remove the capping.

Yes, although cpuinfo.max_freq does not reflect the boost frequency 
unless boost is enabled atleast once. I have sent a patch to fix this. 
But I agree that using cpuinfo.max_freq has issues you have mentioned in 
this patch if boost is enabled once.

So, for this patch

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara (She/Her/Hers)
> 
> The second side effect which is solved is that the reduced frequency wasn't
> properly translated into the right reduced capacity,
> e.g.
> boost frequency = 3000MHz (stored in policy->cpuinfo.max_freq)
> max normal frequency = 2500MHz (which is 1024 capacity)
> 2nd highest frequency = 2000MHz (which translates to 819 capacity)
> 
> Then in a scenario when the 'throttled_freq' max allowed frequency was
> 2000MHz the driver translated it into 682 capacity:
> capacity = 1024 * 2000 / 3000 = 682
> Then set the pressure value bigger than actually applied by the HW:
> max_capacity - capacity => 1024 - 682 = 342 (<- thermal pressure)
> Which was causing higher throttling and misleading task scheduler
> about available CPU capacity.
> A proper calculation in such case should be:
> capacity = 1024 * 2000 / 2500 = 819
> 1024 - 819 = 205 (<- thermal pressure)
> 
> This patch relies on the new arch_update_thermal_pressure() handling
> correctly such use case (with boost frequencies).
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 0138b2ec406d..248135e5087e 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -275,10 +275,10 @@ static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>   
>   static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   {
> -	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
>   	struct cpufreq_policy *policy = data->policy;
>   	int cpu = cpumask_first(policy->cpus);
>   	struct device *dev = get_cpu_device(cpu);
> +	unsigned long freq_hz, throttled_freq;
>   	struct dev_pm_opp *opp;
>   	unsigned int freq;
>   
> @@ -295,17 +295,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>   
>   	throttled_freq = freq_hz / HZ_PER_KHZ;
>   
> -	/* Update thermal pressure */
> -
> -	max_capacity = arch_scale_cpu_capacity(cpu);
> -	capacity = mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq);
> -
> -	/* Don't pass boost capacity to scheduler */
> -	if (capacity > max_capacity)
> -		capacity = max_capacity;
> -
> -	arch_set_thermal_pressure(policy->related_cpus,
> -				  max_capacity - capacity);
> +	/* Update thermal pressure (the boost frequencies are accepted) */
> +	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
>   
>   	/*
>   	 * In the unlikely case policy is unregistered do not enable
> 

-- 

