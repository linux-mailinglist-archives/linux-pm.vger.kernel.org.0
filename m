Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB0159FD9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 05:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgBLEOf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 23:14:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43585 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgBLEOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 23:14:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id u12so138579pgb.10
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2020 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZ3ZYbaVLun1NnfPLPAT22OHZ6g8sxnkwxcv5sKT920=;
        b=vQNupsIMA2yXCaE1orRwVW77FW+9VIa30eWb7zpP19R5c/Aih8ZgTyNQWe/XbON4pp
         ZAGo0WOkutbDdtQLKAzVtyrVRRhxAwGjxr3+mFB3Hv4v1pwuNMx5ki8A/xACtlMQRLQ8
         SLh6uz4/TLXATlp98R1FKlY5R3OrsuTMidbmEsFLMCAhKICB0ecvembRyye8ck/s6nqZ
         6nXjwE9wuBqhdlYLIlMBy0xefSOnrTpW4S7a5bTWkjWxXPp2RKb5H4ScgK+3yHjUZdC3
         ojjGwDcvhic8PndBNnoRpwyull81g/oyxJLqGmiSHapM75PAkbOAJFEwnpH611F80DQ1
         DMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ3ZYbaVLun1NnfPLPAT22OHZ6g8sxnkwxcv5sKT920=;
        b=jTqh2Co0BaGAotlbDDSRfm1HOxz0fmwbHhc4x99ki3K9h0lMSDJvoohmyK+0h1wLKz
         GNpcuMFreakHqdmfo+23m/XJfHz77aTfxVBmC8jgqhh4E44Yacy4kVRPtxSzSuRgsNAi
         W/LHQcJlqkJQQ3TDJv7vPUkQJBh0ZYwb4vjXhoqmyGQpnQ6rAhFccR7Ab7RUr0KpI/Gr
         CVm97rYsKhFGFy5T1QuLUQ6cEcU/fg9SnDC8yaREh1VJZmV6w9a/rAtbxOuFHqjLf/Su
         kxP3sngl1AorQUSnOqDlXcY094TCFwzNEudtK3sLI+BC7+nzDjeXCxss3R3xSVAYNNgE
         9ZGw==
X-Gm-Message-State: APjAAAVluepR701tohfI/iDGjv3bWCUlqOM74urgLnU6rB1eMA/T5IMr
        9fz1D7PmWfg97IVesV9hVYsVXg==
X-Google-Smtp-Source: APXvYqyHSqNTHRqD5NdDHMKHmKYMxDu37PNMyx96YHdVHIep/S7UjgfUEP5hGW8Wmb29BaOidFuxrg==
X-Received: by 2002:a63:36c2:: with SMTP id d185mr10840052pga.59.1581480874044;
        Tue, 11 Feb 2020 20:14:34 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id h11sm121982pgk.48.2020.02.11.20.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 20:14:33 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:44:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/7] cpufreq: add function to get the hardware max
 frequency
Message-ID: <20200212041431.x5ginopepyyqu7wt@vireshk-i7>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-6-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211184542.29585-6-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-02-20, 18:45, Ionela Voinescu wrote:
> Add weak function to return the hardware maximum frequency of a
> CPU, with the default implementation returning cpuinfo.max_freq.
> 
> The default can be overwritten by a strong function in platforms
> that want to provide an alternative implementation.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 20 ++++++++++++++++++++
>  include/linux/cpufreq.h   |  5 +++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 77114a3897fb..d2ff3018861d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1733,6 +1733,26 @@ unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_quick_get_max);
>  
> +/**
> + * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
> + * @cpu: CPU number
> + *
> + * The default return value is the max_freq field of cpuinfo.
> + */
> +__weak unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	unsigned int ret_freq = 0;
> +
> +	if (policy) {
> +		ret_freq = policy->cpuinfo.max_freq;
> +		cpufreq_cpu_put(policy);
> +	}
> +
> +	return ret_freq;
> +}
> +EXPORT_SYMBOL(cpufreq_get_hw_max_freq);
> +
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>  {
>  	if (unlikely(policy_is_inactive(policy)))
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 31b1b0e03df8..b4423ff619f4 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -194,6 +194,7 @@ extern struct kobject *cpufreq_global_kobject;
>  unsigned int cpufreq_get(unsigned int cpu);
>  unsigned int cpufreq_quick_get(unsigned int cpu);
>  unsigned int cpufreq_quick_get_max(unsigned int cpu);
> +unsigned int cpufreq_get_hw_max_freq(unsigned int cpu);
>  void disable_cpufreq(void);
>  
>  u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
> @@ -223,6 +224,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  {
>  	return 0;
>  }
> +static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
> +{
> +	return 0;
> +}
>  static inline void disable_cpufreq(void) { }
>  #endif

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
