Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74902ACB43
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 03:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgKJCsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 21:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbgKJCsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 21:48:09 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17556C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 18:48:08 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i13so4088153pgm.9
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 18:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bp4mJcC9PMhcw5y+WqTlQnnOavYlE/Bb079QNbmAgQM=;
        b=LHVswaHAenoYlpIexQbcoC0/+grtt9LKi1E2jo2Smg96sXIVFZrhjIPEKE3SV9911N
         wNdc74AHhTtYGy+150UerhwqQfxU8vcLRJu7bLw9+aDfuAJ6XvR+VyLFCVCyC7TwnDI2
         bgHUBS5bKMGP6z+rxAmpSUnS01bwNM94hdA/ZeBRvuQo462rT2enhiS6tgLaJFNCwS2H
         inqtf9GQ6YaQESyBEqHjBuWo2dW9ThKPxMVAVBJsJNF+kpC5yYtwK/x9zQqCSpzPUO9q
         p8v7rx03LfWYbw9YI6L+aYlbE9ii0pEk0UO/TdKj3WcupF5y+5Zu4LjlimUVPj0iwKXN
         TCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bp4mJcC9PMhcw5y+WqTlQnnOavYlE/Bb079QNbmAgQM=;
        b=JU1k8bYEOgphYQW6c/AKxp+5zhGTM6F6luQW65jmdXnfvfV8ZV2t+1OmBksSbBbyji
         TUjpGCuaCGVIXcNUEwXLG+NI1teyfN4Ng+38RgYQN2uwm4ukHae+Iev8b4Ct93eXEsTE
         jgq7BCkRMqby+zy71auvLkVUVcljZvneezUAK1mCfSPKJzQq0RW7rPmcxvNMAbJ6LQjd
         8zdR3WUya7di7Y1InHlM4xqlx/oEWYxqoo0GzNBwJiBL2NIZ0C0Aul8Xo/dRmz69Qocf
         RmHsWO2QSAkhThOmKcuQ+dPBm6XOnwCXjhHbdiiI0cHGq9p7RnrX9LSJ+Omdt2pgrynC
         Ey3w==
X-Gm-Message-State: AOAM531m+51F8TOJWq74K5EuMxCtnaVly1HeBUIagHcU6mtuFf/JiWzl
        JB3VV7LqGx5FhxVDCPZWVJEvAg==
X-Google-Smtp-Source: ABdhPJwVIUbHBSxAxf+YyCqW+lxjYugM/kd0pbnjEn43+haD/CSalZJ/qLW0CpPT2viRXgsA/WVzcg==
X-Received: by 2002:a17:90b:496:: with SMTP id bh22mr2597127pjb.120.1604976487671;
        Mon, 09 Nov 2020 18:48:07 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id k5sm905648pjj.37.2020.11.09.18.48.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:48:06 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:18:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 4/4] cpufreq: intel_pstate: Take
 CPUFREQ_GOV_FLAG_STRICT_TARGET into account
Message-ID: <20201110024804.j6wrzq7bne7pmwzv@vireshk-i7>
References: <13269660.K2JYd4sGFX@kreacher>
 <2345253.LYi3vV7ftd@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2345253.LYi3vV7ftd@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 17:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make intel_pstate take the new CPUFREQ_GOV_FLAG_STRICT_TARGET
> governor flag into account when it operates in the passive mode with
> HWP enabled, so as to fix the "powersave" governor behavior in that
> case (currently, HWP is allowed to scale the performance all the way
> up to the policy max limit when the "powersave" governor is used,
> but it should be constrained to the policy min limit then).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2527,7 +2527,7 @@ static void intel_cpufreq_trace(struct c
>  }
>  
>  static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate,
> -				     bool fast_switch)
> +				     bool strict, bool fast_switch)
>  {
>  	u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
>  
> @@ -2539,7 +2539,7 @@ static void intel_cpufreq_adjust_hwp(str
>  	 * field in it, so opportunistically update the max too if needed.
>  	 */
>  	value &= ~HWP_MAX_PERF(~0L);
> -	value |= HWP_MAX_PERF(cpu->max_perf_ratio);
> +	value |= HWP_MAX_PERF(strict ? target_pstate : cpu->max_perf_ratio);
>  
>  	if (value == prev)
>  		return;
> @@ -2562,14 +2562,16 @@ static void intel_cpufreq_adjust_perf_ct
>  			      pstate_funcs.get_val(cpu, target_pstate));
>  }
>  
> -static int intel_cpufreq_update_pstate(struct cpudata *cpu, int target_pstate,
> -				       bool fast_switch)
> +static int intel_cpufreq_update_pstate(struct cpufreq_policy *policy,
> +				       int target_pstate, bool fast_switch)
>  {
> +	struct cpudata *cpu = all_cpu_data[policy->cpu];
>  	int old_pstate = cpu->pstate.current_pstate;
>  
>  	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
>  	if (hwp_active) {
> -		intel_cpufreq_adjust_hwp(cpu, target_pstate, fast_switch);
> +		intel_cpufreq_adjust_hwp(cpu, target_pstate,
> +					 policy->strict_target, fast_switch);
>  		cpu->pstate.current_pstate = target_pstate;
>  	} else if (target_pstate != old_pstate) {
>  		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
> @@ -2609,7 +2611,7 @@ static int intel_cpufreq_target(struct c
>  		break;
>  	}
>  
> -	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, false);
> +	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, false);
>  
>  	freqs.new = target_pstate * cpu->pstate.scaling;
>  
> @@ -2628,7 +2630,7 @@ static unsigned int intel_cpufreq_fast_s
>  
>  	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
>  
> -	target_pstate = intel_cpufreq_update_pstate(cpu, target_pstate, true);
> +	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
>  
>  	return target_pstate * cpu->pstate.scaling;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
