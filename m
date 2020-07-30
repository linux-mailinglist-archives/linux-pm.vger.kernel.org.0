Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177EF232B0F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 06:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgG3Enu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 00:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3Enu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 00:43:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15538C0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:43:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so14322531pfm.4
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF05xhf0pmO+SSDfaVtMOIn5xpcwCosKEIhsXa5iKW0=;
        b=fzel8NfefEAXLrAbNWtDcfYD0YL3yGUJOZ3zytgP3tVwdyw20MGYQzzKYicNU9dZru
         ZYDVRNCXeeALbgfgg7WKV8Gz5ueVQ9X12Ypfah1VBwaQbAAzjmkkUNRaGmSJLcaY7eFH
         30rB53RFoOHvXqK0yuFOFX6oekKlie4+nLSSMBDlQNV4BoBrKJiAbDsVaPwQH5N71GFo
         8y3/iSrAWU26TB6qnbDiKcQVDw9vTTyYl6QEjfRpPhbfWP9grtYdwN0ejgxda8HI/1n2
         qfkQYKGpZ5yLugfXZtPpyxJUqEKAKTD4DmzOx+pd9moHzFYO5o0Ro3KUKwkExoEkl5CN
         ODTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF05xhf0pmO+SSDfaVtMOIn5xpcwCosKEIhsXa5iKW0=;
        b=lNmd5rR1D9IMbgdEI//ht80odI8DYNXYht7f0k3hu7FxgqZiZVu5ogPgLMg8+K8I7U
         l2ofNAX02JWlKY8M9r+2tyggmLmpAIG3mxhY7qNTBxt7nOIx8Nt+eL0Wee1PW/o0OqKJ
         2HxmboBialtYXzqnK99Y6+QcAnx8Bhq3WOiBdrHOKwkPycZCeNRbkC9nGLoj6D4EyDsR
         sFAFxkc7hTEtMK9tOPLzkU0e0p84X35DTOnea4JF9+2ZHNzeomMw2Xt8NU1ThM+14NEF
         tBkIyUp9BUt/Jg0ccNkrNb/dGm+3+fWlDl6a/IZIcLLJVuHhltf2LOpOFXmtuQzmIspI
         0hCQ==
X-Gm-Message-State: AOAM533HAtjz1wpoSZ9Bi1jyXsg5ZG+M3M03N3cqfncw4jLH0XzotIpp
        JBas11/9hllirlOy1HmuW04DzA==
X-Google-Smtp-Source: ABdhPJxoozYbKSzWF/vpDj6rzKXc6Czkqc1yWHX7rgEwF6c/alcWJ6gw85vqUjBwUGpFgmce229YqQ==
X-Received: by 2002:a63:f316:: with SMTP id l22mr31659281pgh.291.1596084229406;
        Wed, 29 Jul 2020 21:43:49 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id t184sm4334122pfd.49.2020.07.29.21.43.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:43:48 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:13:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200730044346.rgtaikotkgwdpc3m@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-5-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-5-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-07-20, 10:37, Ionela Voinescu wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 3497c1cd6818..1d0b046fe8e9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  
> +/* Mark support for the scheduler's frequency invariance engine */
> +static DEFINE_STATIC_KEY_FALSE(cpufreq_set_freq_scale);
> +
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>  
> @@ -69,6 +72,25 @@ static inline bool has_target(void)
>  	return cpufreq_driver->target_index || cpufreq_driver->target;
>  }
>  
> +static inline
> +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> +{
> +	if ((driver->target || driver->target_index || driver->fast_switch) &&
> +	    !driver->setpolicy) {

Just checking for !driver->setpolicy should be enough here.

> +		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> +		pr_debug("%s: Driver %s can provide frequency invariance.",
> +			 __func__, driver->name);

I think a simpler print will work well too.

                pr_debug("Freq invariance enabled");

__func__ isn't really required as this is the only print with that
kind of info in cpufreq.c.

> +	} else
> +		pr_err("%s: Driver %s cannot provide frequency invariance.",
> +		__func__, driver->name);

Why not supporting freq-invariance an error ? I will just drop this
message completely.

-- 
viresh
