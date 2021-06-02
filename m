Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8B398DAB
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFBPCh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhFBPCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 11:02:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B9C061574
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 08:00:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o127so1503998wmo.4
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ts9H8QXix66oiVi0Fp3V9jQgKIODN0K4a3T7GcUqHdw=;
        b=cRcpXHyH5K/HzA/xCHULX/KTD/N1DNwFoOkwB/xnmIUDVRGhel0cCOpQvwfc1SyEMZ
         YLzjeSkFqLR6KDPRajPKc9LnCK/w65Pa8FMi5dSbXlVsNDA9E7w/n4yJ/PaqXSGF+tdC
         RejGFUikivufycbj1IRf9Pxmri8qQ2Yj90YQBFsxjne5sQ1dp6b2rOiAbDqTjABihXbb
         oxlujh2cj5UsEloa9cLi3bXFeU261teqAR5F1tewRWrZ/qOObD8+pFZ7NDqrfYB66zDo
         Nnf1cTa2lKpBFTWhyoCxauGj4FOT7bVEHvRYnvwCap1yO9pofg9uOi4kNirMLoB2XoXB
         pYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ts9H8QXix66oiVi0Fp3V9jQgKIODN0K4a3T7GcUqHdw=;
        b=nnUHf5kcfB88sM36KqAaHR8lM3xLiawaudJOxhbIuwlMh6wW25E2h/fMSNgBOeCEj1
         qGUDd+ID5cM0pXrZTqDsx4pJSqS5vUy1gYunATnaX1hV1RiSz1o0IeQNjuYu4hPewpyQ
         Fkc+EfRFDAsa3tPA0Gb7XJkOIqPTmHcG8z9PG45z23tAKXahcAfGm6zSXxDd7/EV6HRx
         XboPZfBq0D5OLhymMQNnjS4tmijcucGwFJl4tqRKUUcysxhsNT6ydMVzRxzpGduy6kbM
         FoPlJbnfqGGrT13WAb6i+hQBbsYFKddVgJ9KN4DBqpJ9JNvfm8Niqb2WtTDfbfN8ewiU
         Lm+A==
X-Gm-Message-State: AOAM532MX9eKjQXaWcwDRWlFGOqhNnM2aeO4GgeJG4N2swGphpeK9qGY
        Jm8gHN3BF2pCM/BEtkGISYPRRg==
X-Google-Smtp-Source: ABdhPJzDSCX9VSiFJFLcm2w+Cgo54TCb7l2H+eKJ0TeRtwjDMofg2N0CarU9Z+zuOW2fVwa8k4GmeA==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr5669765wmh.186.1622646051886;
        Wed, 02 Jun 2021 08:00:51 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id y6sm3035557wmy.23.2021.06.02.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:00:51 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:00:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: [PATCH 1/2] sched/fair: Take thermal pressure into account while
 estimating energy
Message-ID: <YLedIMNFlZ5eu2Oe@google.com>
References: <20210602135609.10867-1-lukasz.luba@arm.com>
 <20210602135609.10867-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602135609.10867-2-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Wednesday 02 Jun 2021 at 14:56:08 (+0100), Lukasz Luba wrote:
>  compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  {
>  	struct cpumask *pd_mask = perf_domain_span(pd);
> -	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
> +	unsigned long _cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>  	unsigned long max_util = 0, sum_util = 0;
> +	unsigned long cpu_cap = _cpu_cap;
>  	int cpu;
>  
>  	/*
> @@ -6558,6 +6559,14 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  				cpu_util_next(cpu, p, -1) + task_util_est(p);
>  		}
>  
> +		/*
> +		 * Take the thermal pressure from non-idle CPUs. They have
> +		 * most up-to-date information. For idle CPUs thermal pressure
> +		 * signal is not updated so often.
> +		 */
> +		if (!idle_cpu(cpu))
> +			cpu_cap = _cpu_cap - thermal_load_avg(cpu_rq(cpu));

This messes up the irq time scaling no? Maybe move the capping in this
function instead of relying on effective_cpu_util() to do it for you?

>  		/*
>  		 * Busy time computation: utilization clamping is not
>  		 * required since the ratio (sum_util / cpu_capacity)
> -- 
> 2.17.1
> 
