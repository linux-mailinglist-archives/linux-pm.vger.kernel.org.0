Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348E03F2CDB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhHTNLH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbhHTNLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 09:11:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A822C061575
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 06:10:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q6so14213497wrv.6
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGwwJdwtudLTEIgTRNxfN12vJMwR2ib2m9Rc8xqQO/A=;
        b=be/++HF/SDiU7XR3QbVbS6Huz3knXu6tpXk5v6plce1xWf2mn3upyePrih4x1tbvWW
         zhbJuifVz7kz0hphM9KoCVzsyb36tU1MvVs6Bfi31YkjJaLU3OAuktDaNUIPpvtoBpru
         /U6ki79X0NCd2B1A1bpQfL6qNJ/57wVCM6t4uP2k2txAYNII2QRptgmMnAZwjaX7UUxV
         qcXAsaz5medx2G1nnUuVN+Zcs71ii0ap0B64nzqkpCF7laTCJpHEMhIZshM0xuCnA+Jr
         LuUgSHWBUU9MU5gQVHkCAyc+FPPcxqiLjeWipEhX4brJKh98lWI79lyXf0imSTcYX0dD
         pU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGwwJdwtudLTEIgTRNxfN12vJMwR2ib2m9Rc8xqQO/A=;
        b=SXz3wbeWVoNEyWeCXMthNDdwjGjodgj2NQWegU2gxmZDCxLcP83TY9v9B4wpr6KsfU
         TATKLCNwRkkYhqOC9wvaHTtxUNgJeO/uiBUWwxUUiZ3OiKQtGdQaVnUpoM1tiO1ZVg6X
         EiXuoRg2EbzG3Ozrv9+9ojYUHXKNJTvb4ncv9VSstmNsCZjA+QjyxIpM3vGFYxsbhfMJ
         sScWtETLhavM/JQdztuw0cS3SuObkyGZQLxjHaAPjhU8yQxxhCnYyoAFePQtfJlJA62D
         LiZ5S68fV+hJYnAtQVlIpK9NZllnyOaVRUqcbvfKfXvr4k0PADx1gw6QkzB7BYS868U+
         NRew==
X-Gm-Message-State: AOAM530Jvm2d3LW4lqbG2MQ6pyN0dl1tT3+fvzUJFvkyzfactDpiA5cw
        o8UEuoxzrdAl2GuJGuR2Aokr8g==
X-Google-Smtp-Source: ABdhPJw39LyMV35FzoMSAega8xxA34c4SQk4/eGco8RfbC4n5Ho8h2ylExfMZsUsWJQmKkDXzUCY2w==
X-Received: by 2002:adf:f9d2:: with SMTP id w18mr10021565wrr.402.1629465027666;
        Fri, 20 Aug 2021 06:10:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c378:b01b:5d2d:5223? ([2a01:e34:ed2f:f020:c378:b01b:5d2d:5223])
        by smtp.googlemail.com with ESMTPSA id v1sm5755286wrt.93.2021.08.20.06.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 06:10:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Process HWP Guaranteed change
 notification
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
 <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <567c9ec4-9b88-f2f5-6d75-075dd96a76ae@linaro.org>
Date:   Fri, 20 Aug 2021 15:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/08/2021 04:40, Srinivas Pandruvada wrote:
> It is possible that HWP guaranteed ratio is changed in response to
> change in power and thermal limits. For example when Intel Speed Select
> performance profile is changed or there is change in TDP, hardware can
> send notifications. It is possible that the guaranteed ratio is
> increased. This creates an issue when turbo is disabled, as the old
> limits set in MSR_HWP_REQUEST are still lower and hardware will clip
> to older limits.
> 
> This change enables HWP interrupt and process HWP interrupts. When
> guaranteed is changed, calls cpufreq_update_policy() so that driver
> callbacks are called to update to new HWP limits. This callback
> is called from a delayed workqueue of 10ms to avoid frequent updates.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Does this patch depend on 1/2 ?

> ---
>  drivers/cpufreq/intel_pstate.c | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index bb4549959b11..0fd2375c1f1e 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -32,6 +32,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
>  #include <asm/intel-family.h>
> +#include "../drivers/thermal/intel/thermal_interrupt.h"
>  
>  #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
>  
> @@ -219,6 +220,7 @@ struct global_params {
>   * @sched_flags:	Store scheduler flags for possible cross CPU update
>   * @hwp_boost_min:	Last HWP boosted min performance
>   * @suspended:		Whether or not the driver has been suspended.
> + * @hwp_notify_work:	workqueue for HWP notifications.
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -257,6 +259,7 @@ struct cpudata {
>  	unsigned int sched_flags;
>  	u32 hwp_boost_min;
>  	bool suspended;
> +	struct delayed_work hwp_notify_work;
>  };
>  
>  static struct cpudata **all_cpu_data;
> @@ -1625,6 +1628,40 @@ static void intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
>  
>  /************************** sysfs end ************************/
>  
> +static void intel_pstate_notify_work(struct work_struct *work)
> +{
> +	mutex_lock(&intel_pstate_driver_lock);
> +	cpufreq_update_policy(smp_processor_id());
> +	wrmsrl(MSR_HWP_STATUS, 0);
> +	mutex_unlock(&intel_pstate_driver_lock);
> +}
> +
> +void notify_hwp_interrupt(void)
> +{
> +	unsigned int this_cpu = smp_processor_id();
> +	struct cpudata *cpudata;
> +	u64 value;
> +
> +	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +		return;
> +
> +	rdmsrl(MSR_HWP_STATUS, value);
> +	if (!(value & 0x01))
> +		return;
> +
> +	cpudata = all_cpu_data[this_cpu];
> +	schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work, msecs_to_jiffies(10));
> +}
> +
> +static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
> +{
> +	/* Enable HWP notification interrupt for guaranteed performance change */
> +	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
> +		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
> +	}
> +}
> +
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
>  	/* First disable HWP notification interrupt as we don't process them */
> @@ -1634,6 +1671,8 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
>  	if (cpudata->epp_default == -EINVAL)
>  		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
> +
> +	intel_pstate_enable_hwp_interrupt(cpudata);
>  }
>  
>  static int atom_get_min_pstate(void)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
