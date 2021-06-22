Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB03B0050
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhFVJfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFVJfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 05:35:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622FC061756
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 02:33:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w31so16602275pga.6
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etnsU5WMrk2eYTrw8AJr6Gy45eyigJqTyP2EI9j6NRI=;
        b=q7ybZSyhWpolvlawOMGvj2+cnQod8Lfwq5BUr/MkS2GGoFoH36PNv7yIl1D2ahlI8V
         8lnOAyo4oyRcOif+mEM2Ft5Jh/BTYW1PO5SFAwGgbezuMw7S8mRmZvMOkrOm41qDzYKc
         jNtRIbAXHCJKuS01xnYOXi5xmE41EqHPUF6pW+xAsYX3UHeC/YSBrztG/r55I7kFSa1o
         qnWZ7U5bkWqSR0ALwxf2RqrdVbQrdMnNw6+3jqMJuIVXW/QkF2Tt+RIzKRmYW8KOl1jV
         pIObDrP7fGgVEToQtgwT/2vfr0yXElSqdszPdAiWOlXYVrsOyz71hv2eOyPdAIZuVXF8
         nZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etnsU5WMrk2eYTrw8AJr6Gy45eyigJqTyP2EI9j6NRI=;
        b=VitFhha0u1UBHStcD5rvRFalV9D+jim6MZdbEB+bLgYXT1LcSeuMQz1sli1gJaxBFL
         2LAh8cYGOWSQsamFE4oRI0lEgh0/pTk+HlHbsYkhUbOEvHaSA0NvadQpMLlugT85bQT2
         uOmdIq+SXLPJqMqc26Bp937lqWDoKAmFQMbMv1ZBx/ALoVt6aPa/3eM5nV8piyh8AfVD
         um34YMYHOtIYMPh/0o38N9RkB4RweEBXG19BdDevdBcFD0/h2DipaD/QCAweBCv8uigr
         A+KqEmUSM2JAa2YBuNYpwD2pssQgnCaoJE07B0XG5i2NLtsErQU+5h3Qp7v49p45i7PK
         m+tg==
X-Gm-Message-State: AOAM530EA0HKCdOYRNztK3ysHknO8YCVP/qyq+3zxsPcWBQPyATU7Rj2
        yRaDA7PV4JtzC7nuv5Ae1KUF3Wx+eEV4bQ==
X-Google-Smtp-Source: ABdhPJw1z3mob2ePXHn9liFxZvwvCXq1NULY9pjBiHXtjfneurroJYHNoVcxsI07SB0HzPwx6uKDkQ==
X-Received: by 2002:a63:ec15:: with SMTP id j21mr2915948pgh.54.1624354381203;
        Tue, 22 Jun 2021 02:33:01 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u7sm1953648pjd.55.2021.06.22.02.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 02:33:00 -0700 (PDT)
Date:   Tue, 22 Jun 2021 15:02:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, Chris.Redpath@arm.com,
        Beata.Michalska@arm.com, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: Re: [RFC PATCH 3/4] cpufreq: Add Active Stats calls tracking
 frequency changes
Message-ID: <20210622093258.lddlznwsndpw5mju@vireshk-i7>
References: <20210622075925.16189-1-lukasz.luba@arm.com>
 <20210622075925.16189-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622075925.16189-4-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not commenting on the idea itself but just the code changes here.

On 22-06-21, 08:59, Lukasz Luba wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc925b2a..d79cb9310572 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -14,6 +14,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/active_stats.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpu_cooling.h>
> @@ -387,6 +388,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>  
>  		cpufreq_stats_record_transition(policy, freqs->new);
>  		policy->cur = freqs->new;
> +
> +		active_stats_cpu_freq_change(policy->cpu, freqs->new);
>  	}
>  }
>  
> @@ -2085,6 +2088,8 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  			    policy->cpuinfo.max_freq);
>  	cpufreq_stats_record_transition(policy, freq);
>  
> +	active_stats_cpu_freq_fast_change(policy->cpu, freq);
> +

It would have been better if you would have modified
cpufreq_stats_record_transition() instead, since that is there for
similar kind of stats.

Plus don't you need to record this for all policy->cpus instead of
just policy->cpu ?

-- 
viresh
