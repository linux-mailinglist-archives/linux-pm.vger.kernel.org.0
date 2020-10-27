Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11FB29A39A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 05:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443707AbgJ0E0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 00:26:04 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38561 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443683AbgJ0E0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 00:26:04 -0400
Received: by mail-pj1-f68.google.com with SMTP id gi3so111407pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 21:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q8a1R7APHXz6ZL6IXaQsICKfgqyJPeRktgCx//C+/Ss=;
        b=KL+NuJfe1pirzhrR+nfUoyaxO2yXPH1uQXQPaV5UwSxCeRIhuE79ubRUDClresUNw4
         S2EyapN9q7kGcOkjPIo2kAcI6/9l8TSMph5lrpsgX3XdISyzG5UFd6xrpfJfqTxjDoXX
         z8NDBKaqg0zqjTLnDyzrH1QIXIkUH2BdOpzTQTNrzyIhqNSqrdPr1907a4IzDUlJ3bkV
         Rx1IRL27ZvGfJS3bXAjyoHEF3hS9eOMA2zFOqUVENhekPsr7MK/WySJ8rcLugCo4beUL
         kNrlbI/92UBdNqKs4amVQ/BZWWznuBzGmmEJHkp8p0SFZZEaRztZz+rr5Rwq9PXYTxvn
         kRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q8a1R7APHXz6ZL6IXaQsICKfgqyJPeRktgCx//C+/Ss=;
        b=copsFbfSC1RDBU9uwuwedidXzYW/UrHl0N9LeL01XesFx8sQrcsE6OaMD75FPfnwJs
         2G7B8MgACJW39f51gulTNYg46dOs2GGoJnGASG/frsLukhONf7jh5h4g0sUlaknqo+jf
         x8vLjfgRxp02k05BJy458Yfm/nsqavadfuEerCsC+VccGe7yaYURLYPTFdhd011eisIi
         0eU4+sMbDct5a3/e8uFtu0/HMmFL0/FBxKA8XD3Qe6d1/FkczSMA1KAeo8DluOy/tCvK
         MsXcNB3Hbtu363b2uTX8FCj833dMVK5fQGN20eegIXHPCz9nHzF9NJGo0CgwvArFjWFy
         6wEQ==
X-Gm-Message-State: AOAM533E9KLq3J5aQvnogMylKD5jj28uleY56LeTPpE1wK72N0LOqiR2
        TDECjCo01vLo89EogXncAlc0yg==
X-Google-Smtp-Source: ABdhPJyZSrthlQUhdkUr5Xtk/g+rLCqfqrp9PuiJWMQMH4v/m2TkanY+50e2zHzy5+6QSVRWIY/8Qg==
X-Received: by 2002:a17:902:d706:b029:d5:dde6:f56 with SMTP id w6-20020a170902d706b02900d5dde60f56mr634056ply.26.1603772763043;
        Mon, 26 Oct 2020 21:26:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id y3sm325813pfn.167.2020.10.26.21.26.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 21:26:01 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:55:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 4/4] cpufreq: schedutil: Always call drvier if
 need_freq_update is set
Message-ID: <20201027042559.hang4fnpyfd6yqu4@vireshk-i7>
References: <2183878.gTFULuzKx9@kreacher>
 <1905098.zDJocX6404@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1905098.zDJocX6404@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Spelling mistake in $subject (driver)

On 23-10-20, 17:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because sugov_update_next_freq() may skip a frequency update even if
> the need_freq_update flag has been set for the policy at hand, policy
> limits updates may not take effect as expected.
> 
> For example, if the intel_pstate driver operates in the passive mode
> with HWP enabled, it needs to update the HWP min and max limits when
> the policy min and max limits change, respectively, but that may not
> happen if the target frequency does not change along with the limit
> at hand.  In particular, if the policy min is changed first, causing
> the target frequency to be adjusted to it, and the policy max limit
> is changed later to the same value, the HWP max limit will not be
> updated to follow it as expected, because the target frequency is
> still equal to the policy min limit and it will not change until
> that limit is updated.
> 
> To address this issue, modify get_next_freq() to clear
> need_freq_update only if the CPUFREQ_NEED_UPDATE_LIMITS flag is
> not set for the cpufreq driver in use (and it should be set for all
> potentially affected drivers) and make sugov_update_next_freq()
> check need_freq_update and continue when it is set regardless of
> whether or not the new target frequency is equal to the old one.
> 
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch in v2.
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(str
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->next_freq == next_freq)
> +	if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update)
>  		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> +	sg_policy->need_freq_update = false;
>  
>  	return true;
>  }
> @@ -164,7 +165,10 @@ static unsigned int get_next_freq(struct
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  
> -	sg_policy->need_freq_update = false;
> +	if (sg_policy->need_freq_update)
> +		sg_policy->need_freq_update =
> +			cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> +

The behavior here is a bit different from what we did in cpufreq.c. In cpufreq
core we are _always_ allowing the call to reach the driver's target() routine,
but here we do it only if limits have changed. Wonder if we should have similar
behavior here as well ?

Over that the code here can be rewritten a bit like:

	if (sg_policy->need_freq_update)
                sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
        else if (freq == sg_policy->cached_raw_freq)
		return sg_policy->next_freq;

-- 
viresh
