Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9229EA66
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgJ2LXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgJ2LXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:23:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A44FC0613D2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 04:23:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k9so383829pgt.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bPCdFlQqiAP/SdCjIdN/XSR2oK0F/m9XRAymWATOa6M=;
        b=m29X1ag4M9AmutEzQDZkDa5AOrYpDtBNX2uns/fF1VDfQRlEoREAENjGxdtpn640yk
         qJMEpJIrcYeVT++OjTbeSDvPLeV73KtNEFt68t9R9PbkvlJBQleq2egiLBFW9EGfUMiD
         rBmYZk54zFcU5jfPvzzwXUdQ4VhiaRu2wbEioB0LliPsBTCdzThIt+FhTL0+06pWz9Q9
         GA2/O4G9IQW4PbRwcngQ+vegR/RYXsRZWamqkMFpoP7xQcpg4YvOdzUFyRwWYlkNN5ld
         LXMSKojZQe2K86XWLq9Dvg2CxHCR6u85Od7aK1B7US00QrgkcZ9NPrZ+d5P4PEW9W6Ca
         pxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPCdFlQqiAP/SdCjIdN/XSR2oK0F/m9XRAymWATOa6M=;
        b=GwpQgnvjuxHhtQzsKhxf8LWeZinM9FfSy1QXhvQ2rg15CG5yoz4oCa5NpDD+IDf2Xl
         P0VlswzNZjeD0Gxkr2D0NJRFO58en7I6wkgNJJgNyIhCWTIOAqfMNkgcTsECrZwXIZki
         47Nni0Vm/sIOlaz8C9pXlCnp4IYEx6PDJTMIseRIu9Oa40uNkRqseLG2X3h8p0jf2zoE
         ObnVa551WvJnPw5Oqrn0OtWAyqM3O7ca2rdatBBa+T7MBGYLRD9vNnzc594+o1GLadAR
         4qMqpapnQFruZwn+LiOw+0HDbb/ALG2BwGwdL3d5lfffjbbTaSyTJnjXWoFC3WelpjXd
         xAZA==
X-Gm-Message-State: AOAM532EnSlAPzmu8wwQls2Ecb4tLST0sh/8J0MQOCepjGKHjRgvge8U
        C6JXM7kO2Ur7g/EEvG3bq0BTQw==
X-Google-Smtp-Source: ABdhPJyaHfxndq1AVX4QhC7XMniJfOh0Pnm2KvNb7goD6SWH35I9hyPeXuTAECg6ZWqBCB+R+usAEA==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr3570875pgj.342.1603970630601;
        Thu, 29 Oct 2020 04:23:50 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b10sm2357878pgm.64.2020.10.29.04.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 04:23:49 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:53:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2.2 4/4] cpufreq: schedutil: Always call driver if
 CPUFREQ_NEED_UPDATE_LIMITS is set
Message-ID: <20201029112347.prt7ni6jqu2w23g3@vireshk-i7>
References: <2183878.gTFULuzKx9@kreacher>
 <1905098.zDJocX6404@kreacher>
 <4720046.CcxZZ2xs9j@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4720046.CcxZZ2xs9j@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-20, 12:12, Rafael J. Wysocki wrote:
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
> To address this issue, modify get_next_freq() to let the driver
> callback run if the CPUFREQ_NEED_UPDATE_LIMITS cpufreq driver flag
> is set regardless of whether or not the new frequency to set is
> equal to the previous one.
> 
> Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Zhang Rui <rui.zhang@intel.com>
> Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2.1 -> v2.2:
>    * Instead of updating need_freq_update if CPUFREQ_NEED_UPDATE_LIMITS is set
>      in get_next_freq() and checking it again in sugov_update_next_freq(),
>      check CPUFREQ_NEED_UPDATE_LIMITS directly in sugov_update_next_freq().
>    * Update the subject.
> 
> v2 -> v2.1:
>    * Fix typo in the subject.
>    * Make get_next_freq() and sugov_update_next_freq() ignore the
>      sg_policy->next_freq == next_freq case when CPUFREQ_NEED_UPDATE_LIMITS
>      is set for the driver.
>    * Add Tested-by from Rui (this version lets the driver callback run more
>      often than the v2, so the behavior in the Rui's case doesn't change).
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -102,7 +102,8 @@ static bool sugov_should_update_freq(str
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->next_freq == next_freq)
> +	if (sg_policy->next_freq == next_freq &&
> +	    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
>  		return false;

Since sg_policy->next_freq is used elsewhere as well, this is the best
we can do here.

>  	sg_policy->next_freq = next_freq;
> @@ -161,7 +162,8 @@ static unsigned int get_next_freq(struct
>  
>  	freq = map_util_freq(util, freq, max);
>  
> -	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> +	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update &&
> +	    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
>  		return sg_policy->next_freq;
>  
>  	sg_policy->need_freq_update = false;

But I was wondering if instead of this we just do this here:

        if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
                sg_policy->cached_raw_freq = freq;

And so the above check will always fail.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
