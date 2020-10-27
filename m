Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D729A2ED
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 04:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436983AbgJ0DGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 23:06:39 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53591 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436963AbgJ0DGj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 23:06:39 -0400
Received: by mail-pj1-f67.google.com with SMTP id g16so33684pjv.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 20:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQGNSG6H63pNMqU9sqlYyAvudn7TgOWia7TrZnYgCGA=;
        b=dslmTjfTyW/nmJjmrd21DA5VZKLPsSKSKJ/TS/vNkxy8txy30oHZga1/qwbm5ZRUJ9
         EljbDC769ItR4eOBQKI6WaJp9Ifixi+ipqvmQd9N7JZHF3iGlllrgagDD8SiDBJXb5YY
         tkr4Z/QpDSPWE7qotli6QTHiN2Vf6ltGrmdevTGdDY3YUwpm/Jv2QGW7L93A5iG7WONx
         ZoURF997b1/SZ/5g0zO7mQPBkTtjlqcxOz8DdkLpiB0TEoxa5SSMLde6Zd1iWR7r5/Rs
         /lrEvEKZokC3LicmO+tuoKUoIqL761daXgaWFqSQo/+AJ2cJ067t+yam/5+nEEKrTTsW
         Y18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQGNSG6H63pNMqU9sqlYyAvudn7TgOWia7TrZnYgCGA=;
        b=BXAbkLJ1F9jLKijHoBmZlm9U12ro45jDlsUKulFdJC6O0PTSTbZAgOx0q3YFpB0cig
         7ccEmxdYJI11LQJdbJNqeOojdjmFWiUjuwojk3yWu0oXqtHt3tCc0t7N17MGxGD1SERi
         GARk3q5yBMHxi0KK4wSF1UuBDO96Luq9OjIpl07kc1l/+4ANRdmW+cAsrpNAPz7ZCBPI
         FQA6vOpRLXF1Jkr6SejVJDGwmud6qN7V6knzIAz21o4UfnqYT2aZGvdftCTZGX+yXOg3
         VyNMO0+wPAej6lDKzwbLAVF5htfJiTCIAMv/nsf+PPwA4QPGXoLKIrUiBvAzURtHU/DI
         2M/g==
X-Gm-Message-State: AOAM533cP8aPF4AWsZss6JPzQqyzAKgWnvKthS17Aur0y2VjqaufF5Hn
        KiMQ8oeaUxLGYm6N94238CPdqQ==
X-Google-Smtp-Source: ABdhPJxmI18b3xQLuztAsQzdI8nq6vUTPQp1BThreBSLFp9R0jAkKOkabmOSba/IXkWG0uDscuv9uQ==
X-Received: by 2002:a17:902:c24b:b029:d3:f3e6:1915 with SMTP id 11-20020a170902c24bb02900d3f3e61915mr317961plg.56.1603767998331;
        Mon, 26 Oct 2020 20:06:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 17sm165872pfj.49.2020.10.26.20.06.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 20:06:37 -0700 (PDT)
Date:   Tue, 27 Oct 2020 08:36:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 2/4] cpufreq: intel_pstate: Avoid missing HWP max
 updates in passive mode
Message-ID: <20201027030636.hvqllxkarjvb5wnn@vireshk-i7>
References: <2183878.gTFULuzKx9@kreacher>
 <3212190.yEXfVNHMLB@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3212190.yEXfVNHMLB@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 17:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the cpufreq policy max limit is changed when intel_pstate operates
> in the passive mode with HWP enabled and the "powersave" governor is
> used on top of it, the HWP max limit is not updated as appropriate.
> 
> Namely, in the "powersave" governor case, the target P-state
> is always equal to the policy min limit, so if the latter does
> not change, intel_cpufreq_adjust_hwp() is not invoked to update
> the HWP Request MSR due to the "target_pstate != old_pstate" check
> in intel_cpufreq_update_pstate(), so the HWP max limit is not
> updated as a result.
> 
> Also, if the CPUFREQ_NEED_UPDATE_LIMITS flag is not set for the
> driver and the target frequency does not change along with the
> policy max limit, the "target_freq == policy->cur" check in
> __cpufreq_driver_target() prevents the driver's ->target() callback
> from being invoked at all, so the HWP max limit is not updated.
> 
> To prevent that occurring, set the CPUFREQ_NEED_UPDATE_LIMITS flag
> in the intel_cpufreq driver structure if HWP is enabled and modify
> intel_cpufreq_update_pstate() to do the "target_pstate != old_pstate"
> check only in the non-HWP case and let intel_cpufreq_adjust_hwp()
> always run in the HWP case (it will update HWP Request only if the
> cached value of the register is different from the new one including
> the limits, so if neither the target P-state value nor the max limit
> changes, the register write will still be avoided).
> 
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The v2 is just the intel_pstate changes (without the core changes) and setting
> the new flag.
> 
> ---
>  drivers/cpufreq/intel_pstate.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2550,14 +2550,12 @@ static int intel_cpufreq_update_pstate(s
>  	int old_pstate = cpu->pstate.current_pstate;
>  
>  	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
> -	if (target_pstate != old_pstate) {
> +	if (hwp_active) {
> +		intel_cpufreq_adjust_hwp(cpu, target_pstate, fast_switch);
> +		cpu->pstate.current_pstate = target_pstate;
> +	} else if (target_pstate != old_pstate) {
> +		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
>  		cpu->pstate.current_pstate = target_pstate;
> -		if (hwp_active)
> -			intel_cpufreq_adjust_hwp(cpu, target_pstate,
> -						 fast_switch);
> -		else
> -			intel_cpufreq_adjust_perf_ctl(cpu, target_pstate,
> -						      fast_switch);
>  	}
>  
>  	intel_cpufreq_trace(cpu, fast_switch ? INTEL_PSTATE_TRACE_FAST_SWITCH :
> @@ -3014,6 +3012,7 @@ static int __init intel_pstate_init(void
>  			hwp_mode_bdw = id->driver_data;
>  			intel_pstate.attr = hwp_cpufreq_attrs;
>  			intel_cpufreq.attr = hwp_cpufreq_attrs;
> +			intel_cpufreq.flags |= CPUFREQ_NEED_UPDATE_LIMITS;
>  			if (!default_driver)
>  				default_driver = &intel_pstate;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
