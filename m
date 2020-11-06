Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3B2A93A7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgKFKHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFKHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:07:16 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E290C0613CF
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 02:07:15 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id f21so445992plr.5
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 02:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xh2yyII4BN2Q0eHqaVwfCJTzF58UCCvCSQVIKFDV04Q=;
        b=a9yURkJBvngqIkd0EW7So3jIDwRAQ3W43yeEA/MT3DTidowcoOWa4sDGM6UqBT6Yr2
         AV4QEi2bzh/xRSGsRZHtPN6U8hatlLN0X4CMa/Jg+91WXv/T2U+9w8LYjBQ9/OgQANMb
         +8LR1nrQY4uasl1uyyfvxLdXjeMOJDZGtVdq+GQkH+eQQwAIX3PJzLRcnYFAdti17eME
         wIL8CHpY4x48ljBxbzxklflYrRccsCGi3LQEZqnK6Ipzjon0tuRjLUC90PQUjEc0xofq
         l7LzfJkET9NcFMkczfmzwqQpr5s/8lxlOgGjPR2EmFqbLXJ+3jOGDZj6EIp1Sz1qmOxV
         41oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xh2yyII4BN2Q0eHqaVwfCJTzF58UCCvCSQVIKFDV04Q=;
        b=KvwIFwCYmBbC/T3OZCfOYGBLvK2/e8OIxKRO+k8KJqGy0i4db2USJmVy1Zh7bAsEuc
         Zu7HzTIC7CMCrlXPAJUnHwFE6cLKRvszYl/AD+BkL0f11HwuAnBx8km0ZXSxnaVMdU+s
         Bk0Fb8GMFhB3QnxbbAIaAIojexPP9aF8tvOMXzOYKQEJoKYLcE7bv7UUJ/zkR94xjXzh
         QDLcCAHMuX//UAmmR7wU6EjJTmmHR8hyiRa8blcVxDnzEkqn+K+SZtP+SXAtQ3c7oBzP
         PJIZngyzZ5pZs9e5jd+uGDUW2iLFywPgkEAY9m2wrPIBbIgLclP2Dy1L/vsWsBuT5vjf
         Z+Dg==
X-Gm-Message-State: AOAM531KJERAavOtMJCqWTwT1Xdj4wQ3vXhGvh2SxUyC8R1K4gHzCN+7
        /EV9TDhy4Hm7X5leLbp/3y+wIA==
X-Google-Smtp-Source: ABdhPJyVGNKHMQmLlALereriRPy7JZsHpyOHgoK9YawOfeu1b2OHOCZOlor3Gbdw0tJqF5fBHI8XBA==
X-Received: by 2002:a17:902:724c:b029:d5:c1de:e34e with SMTP id c12-20020a170902724cb02900d5c1dee34emr1106053pll.71.1604657235380;
        Fri, 06 Nov 2020 02:07:15 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id ck21sm1755608pjb.56.2020.11.06.02.07.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:07:14 -0800 (PST)
Date:   Fri, 6 Nov 2020 15:37:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: Introduce target min and max frequency hints
Message-ID: <20201106100712.u336gbtblaxr2cit@vireshk-i7>
References: <7417968.Ghue05m4RV@kreacher>
 <2233690.N3OVLkotou@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2233690.N3OVLkotou@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-20, 19:23, Rafael J. Wysocki wrote:
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -63,6 +63,8 @@ struct cpufreq_policy {
>  
>  	unsigned int		min;    /* in kHz */
>  	unsigned int		max;    /* in kHz */
> +	unsigned int		target_min; /* in kHz */
> +	unsigned int		target_max; /* in kHz */
>  	unsigned int		cur;    /* in kHz, only needed if cpufreq
>  					 * governors are used */
>  	unsigned int		suspend_freq; /* freq to set during suspend */

Rafael, honestly speaking I didn't like this patch very much. We need
to fix a very specific problem with the intel-pstate driver when it is
used with powersave/performance governor to make sure the hard limits
are enforced. And this is something which no one else may face as
well.

What about doing something like this instead in the intel_pstate
driver only to get this fixed ?

        if (!strcmp(policy->governor->name, "powersave") ||
            !strcmp(policy->governor->name, "performance"))
                hard-limit-to-be-enforced;

This would be a much simpler and contained approach IMHO.

-- 
viresh
