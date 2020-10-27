Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0104D29A6E1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509298AbgJ0Iru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:47:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:61236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406265AbgJ0Iru (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Oct 2020 04:47:50 -0400
IronPort-SDR: yGKrNwIflwpv97rjaxrnee4gjeAgTtNosk2en39O/8tAUV0pkbqNjbzbp6nmyHDEJUqLxh1jO2
 1eyWiqW9xPJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232233526"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="232233526"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:47:49 -0700
IronPort-SDR: joSJwF7+NAz7pl8+PeXASjinmw8/o8NZxPqSXL3ji6G69k8Iz7j45C3GBs7URP/zcJbTvqo04J
 YQyXabzngwEQ==
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="524615151"
Received: from zzhao15-mobl1.ccr.corp.intel.com ([10.255.30.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:47:47 -0700
Message-ID: <1975659e1cd98e6bbf80595bc91c78079350c677.camel@intel.com>
Subject: Re: [PATCH v2 4/4] cpufreq: schedutil: Always call drvier if
 need_freq_update is set
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Tue, 27 Oct 2020 16:47:44 +0800
In-Reply-To: <1905098.zDJocX6404@kreacher>
References: <2183878.gTFULuzKx9@kreacher> <1905098.zDJocX6404@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-10-23 at 17:36 +0200, Rafael J. Wysocki wrote:
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
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode
> with HWP enabled")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I have confirmed that the problem is gone with this patch series
applied.

Tested-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

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
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy,
> u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->next_freq == next_freq)
> +	if (sg_policy->next_freq == next_freq && !sg_policy-
> >need_freq_update)
>  		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> +	sg_policy->need_freq_update = false;
>  
>  	return true;
>  }
> @@ -164,7 +165,10 @@ static unsigned int get_next_freq(struct
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy-
> >need_freq_update)
>  		return sg_policy->next_freq;
>  
> -	sg_policy->need_freq_update = false;
> +	if (sg_policy->need_freq_update)
> +		sg_policy->need_freq_update =
> +			cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_L
> IMITS);
> +
>  	sg_policy->cached_raw_freq = freq;
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
> 
> 
> 

