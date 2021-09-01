Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB733FD2E5
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbhIAFcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhIAFcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 01:32:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A24C061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 22:31:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c6so1120112pjv.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+Wl+NZhXHKzcawWHKGamXQNgEsSlp7bThUYoGLkX8E=;
        b=sGc5GhNsCC6NPDB3T8ZsPY/mX3bADYprC1/6xY1hRf39Nk9k0wq0haac30dM2OYIPX
         wXL6oXB1jsCz+4dT1t4PGJHluNIrKrA/QOWakhA/1O/x2BrcK8cwe3aRLZC5H18ba0Lm
         +R6acPMwKOwuBQP7drUb83whbx7Qz3CjEjHx49TOoiuc3JIe0MdWYpE7MaoIEzGnu2tV
         Q838ZmxLxJ0gVjUsRduhl99yEWQYlxC59OG/7erDpaMaokmdM0WPRTFTVeuGVOq90D7e
         1Q0l+ztXii1T8lkMKKhOzSY/JakHbK6R5UnXCzxN4vzvW/V2x0R3eXAccHYnGhsU1p2N
         eizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+Wl+NZhXHKzcawWHKGamXQNgEsSlp7bThUYoGLkX8E=;
        b=HP/26FfOWzgzms76tUPAAk2AVtZPiGc7s4H16VOORYULuTKPwio0A/3oIPflJ+Xodr
         cWLvd4bq6YFoT3xyLkwKw81QU/QgT/XE529/LnOHhYBImJtzrVwLpGP2gb13OtgbJEja
         WwB3cPQkKFZDFm4POXCbc2QxEpQ6PqxAAUuB50rguMJ6L0ut+nuicFwerFjr1vc0nNs9
         tEW61NqidVcB705yeqBywREy7DiBMNaHziRTgNWhDW7IMAXwEILVgwore5MfjrUV9cEv
         APu7g5WIqdsm7t2qul9w4DohXblnXR72S54gnRloYQxB38ZKrkE2GSHbiHCjeHUEFkh0
         Tmeg==
X-Gm-Message-State: AOAM530zBD/eB0gZMic8/HP2vTcqetCrsI9jwe60VoscayUumDt60ebW
        rS44HGAUoRDZS/d7dpFzR234eQ==
X-Google-Smtp-Source: ABdhPJxpd+iQ1LpSaRNx9HQduDJdydnG17GCwJVAqoFiflJjwOhVvw9xzRQtYWpbDDtVhfxTQF2Grw==
X-Received: by 2002:a17:90a:de04:: with SMTP id m4mr9592389pjv.187.1630474272678;
        Tue, 31 Aug 2021 22:31:12 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id e5sm815011pjv.44.2021.08.31.22.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:31:12 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:01:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v6 7/7] PM / EM: Mark inefficiencies in CPUFreq
Message-ID: <20210901053110.bbf4mkou3demcmlg@vireshk-i7>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-8-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630405453-275784-8-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 11:24, Vincent Donnefort wrote:
> The Energy Model has a 1:1 mapping between OPPs and performance states
> (em_perf_state). If a CPUFreq driver registers an Energy Model,
> inefficiencies found by the latter can be applied to CPUFreq.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cb09afbf01e2..153ddc7b0506 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1121,7 +1121,6 @@ void cpufreq_generic_init(struct cpufreq_policy *policy,
>  
>  static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
>  {
> -	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> -				  policy->related_cpus);
> +	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu), policy->related_cpus);
>  }
>  #endif /* _LINUX_CPUFREQ_H */
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d353ef29e37f..dfcbb2deb794 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt) "energy_model: " fmt
>  
>  #include <linux/cpu.h>
> +#include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/debugfs.h>
>  #include <linux/energy_model.h>
> @@ -231,6 +232,46 @@ static int em_create_pd(struct device *dev, int nr_states,
>  	return 0;
>  }
>  
> +static void em_cpufreq_update_efficiencies(struct device *dev)
> +{
> +	struct em_perf_domain *pd = dev->em_pd;
> +	struct em_perf_state *table;
> +	struct cpufreq_policy *policy;
> +	bool found = false;
> +	int i;
> +
> +	if (!_is_cpu_device(dev) || !pd)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
> +	if (!policy) {
> +		dev_warn(dev, "EM: Access to CPUFreq policy failed");
> +		return;
> +	}
> +
> +	table = pd->table;
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
> +			continue;
> +
> +		cpufreq_table_set_inefficient(policy, table[i].frequency);
> +		found = true;
> +	}
> +
> +	if (!found)
> +		return;
> +
> +	if (cpufreq_table_update_efficiencies(policy))
> +		return;
> +
> +	/*
> +	 * Efficiencies have been installed in CPUFreq, inefficient frequencies
> +	 * will be skipped. The EM can do the same.
> +	 */
> +	pd->flags |= EM_PERF_DOMAIN_SKIP_INEFFICIENCIES;
> +}
> +
>  /**
>   * em_pd_get() - Return the performance domain for a device
>   * @dev : Device to find the performance domain for
> @@ -347,6 +388,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  	if (milliwatts)
>  		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
>  
> +	em_cpufreq_update_efficiencies(dev);

This is how I always wanted this to be :)

-- 
viresh
