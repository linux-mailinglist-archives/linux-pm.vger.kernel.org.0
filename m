Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10A71FEF11
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgFRJyg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 05:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgFRJyd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 05:54:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D8C06174E
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 02:54:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so2236458plk.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2020 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jxYaQFOuethLH+6qCp7SYy5ev2dqdee2Bmv5jtz/8kU=;
        b=SwZyvRFdIOLAmwWOUo+F40IAyx5vcY7t7VtCMKmlXE5959lxtrfuSOav6SXn4HEn9b
         qfL+cZUXFpZGvbPTC0VlkifpM0hcelUY7m2dbEIVCQDc0i5gwQLG8jRublPoOSB8U/A1
         CKLeuwPhIXsjBVZHBPSvT9aVkkzWnvLpesnQzIHA/l82U+rOC2gO5V0int8I8RCnhuNo
         eFYWYbjZF600Vd0sOYvGaO0vsM6+v/nsa46OEeu+OWY/jwRx2Rrz2AOy43tjQbMeADoK
         vP+wEJo0eNBi9Zt0Hpo4x1Wd/Dg1bEnKYbB1LhKC/pAUd14DWmTBmrs7gvgmBx27wOQq
         Nzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxYaQFOuethLH+6qCp7SYy5ev2dqdee2Bmv5jtz/8kU=;
        b=Z2pWQaHoPiTNVRZF77+6XuUtlFYlaBQWM0Y3xj5YOSQWtzVopT084q6+t0VQRVnlgR
         lHH6ZjAUa1o3MLtbDOCMdhf+nDIjJ5UqOQcK6r357mi1aD5xprm1G/hk/aMLTbDVwDMz
         5MUi+EP8xHT7gYR76UiGqOSQt1s+vaEdHkXZ1hF/k2o2vR+ErIjZ9CkL8/dc9l8OrSVM
         H1KucIoJmnaqhjAR2lWjVnJGbuIRIS8xleeb3HJesQPgQLkFLxxvCJ1dbMAwvbfCZyAd
         9IKvWt0laUqN6ByZSYzWzNUCChCR4//kEV1RlEtaA8uq3sSei4RufGja2CBagSAO7T+w
         88Fg==
X-Gm-Message-State: AOAM532YrXM+MBjPOkL0mYnOvVzWJSKYdpToW4JMzGlGAKNb4gQKgNRS
        N2s3d1rnfAGtGD4o38FWlc7sRg==
X-Google-Smtp-Source: ABdhPJwri2PoCABkalcKuQR/pD7ASrRIrdyeZ9bnWjTeKTykWL3STjOgPPvyP9Bl4x+fqvXirq3UgQ==
X-Received: by 2002:a17:902:ee12:: with SMTP id z18mr2983112plb.308.1592474072433;
        Thu, 18 Jun 2020 02:54:32 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id z144sm2567092pfc.195.2020.06.18.02.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 02:54:31 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:24:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible
 conditionally
Message-ID: <20200618095429.tj3ddquy5m2q367e@vireshk-i7>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
 <20200617094332.8391-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617094332.8391-2-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-20, 10:43, Nicola Mazzucato wrote:
> Currently the fast_switch_possible flag is set unconditionally
> to true. Based on this, schedutil does not create a
> thread for frequency switching and would always use the
> fast switch path.
> However, if the platform does not support frequency
> fast switch, this may cause the governor to attempt an
> operation that is not supported by the platform.
> 
> Fix this by correctly retrieve the fast_switch capability
> from the driver which knows if the platform can support
> this feature.
> 
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 61623e2ff149..1cf688fcb56b 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -198,7 +198,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> -	policy->fast_switch_possible = true;
> +	policy->fast_switch_possible =
> +		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
>  
>  	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
