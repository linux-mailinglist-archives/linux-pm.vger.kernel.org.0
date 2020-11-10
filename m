Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9DE2ACB37
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 03:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKJCl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 21:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKJCl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 21:41:57 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88397C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 18:41:57 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r186so8878160pgr.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 18:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWpSaYihRWmyIMIqazCaAykBbsdUWTsb9alXGFMU7hs=;
        b=Z9mT0bsY5F9Tdy0MG5QIGody8bzqtfCiujHRTIxkroqfE+qssZTNXrJ+2A1RAGPm2Q
         4wYHEO604Jpz+d99RF3bwsgMNp8Ucavouleq1LyjgDKCV+2XvWOE26rfMpK81mRIDUoR
         66XaN6fm+bOVH7WkKlEjUuZKMg/AiA3ymbHbNr3f5lB/DH7JbUqIRb5PPFZTobLwmqAv
         uzchxxnOim4KL39pTGDDyW9hxGMCI6BT7Jj0jyNEHDCLaFn8iURR/bNc/2FH3CLg9f0E
         /NROUgy/j8xSjdmoLne9a26DnYLsGw1A/r0rhunacBjeqpWLmWxmL3pNgVt6Awt5dmxn
         CxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWpSaYihRWmyIMIqazCaAykBbsdUWTsb9alXGFMU7hs=;
        b=diX9kXhILKYgA/O6oIsVShAYRu0G5Db+Sbe4iP0dH1SBWqMd63qtMDWrek0gXXsts0
         HnYenYeeNGMCQLvBL/sBuKucVZFaM9udPLkoe/FAcfpKiYEJqOwgj35KZGbJ4gKMYbrX
         T2hEOvR70d/oZo+7heYMSUknqqmaJIx8b6zyWx7piSvRc7jK2NrKUh492YUxhvGLH4ab
         xm0wOmmky4FGUt9x70aM6ALEmY0HJl62uyQsIMi5cqtAhF41swPNUNDer8RHFpgG59xl
         BmM0M3+s81JHcIHJQSy5YwKAVl+wtjSBTmTR7bJFogfwTkd/1kN5C1TF/ynG18NAiNIo
         sj9g==
X-Gm-Message-State: AOAM531vI6TMmZWuibfAs5nvjje2tgReSWVObEfGYgqOZJI7l0MbSBSy
        Q+2MVDFXUO0uCWXGV+0DLHajHg==
X-Google-Smtp-Source: ABdhPJwxLdPp+7tVxWo+LjKbWefo6ZaPw1ibzzP0gKL8JqANqXIiOc++wp9eQrNlXox01h8cEXuB+Q==
X-Received: by 2002:a17:90a:ae16:: with SMTP id t22mr2436241pjq.55.1604976117120;
        Mon, 09 Nov 2020 18:41:57 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id k25sm12513992pfi.42.2020.11.09.18.41.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:41:56 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:11:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 2/4] cpufreq: Introduce CPUFREQ_GOV_FLAG_STRICT_TARGET
Message-ID: <20201110024154.rptitysdmwyv3whh@vireshk-i7>
References: <13269660.K2JYd4sGFX@kreacher>
 <1691551.0Fp6MP5ZGR@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691551.0Fp6MP5ZGR@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 17:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a new governor flag, CPUFREQ_GOV_FLAG_STRICT_TARGET, for
> the govenors that want the target frequency to be set exactly to the
> given value without leaving any room for adjustments on the hardware
> side and set this flag for the powersave and performance governors.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_performance.c |    1 +
>  drivers/cpufreq/cpufreq_powersave.c   |    1 +
>  include/linux/cpufreq.h               |    3 +++
>  3 files changed, 5 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
> +++ linux-pm/drivers/cpufreq/cpufreq_performance.c
> @@ -20,6 +20,7 @@ static void cpufreq_gov_performance_limi
>  static struct cpufreq_governor cpufreq_gov_performance = {
>  	.name		= "performance",
>  	.owner		= THIS_MODULE,
> +	.flags		= CPUFREQ_GOV_FLAG_STRICT_TARGET,
>  	.limits		= cpufreq_gov_performance_limits,
>  };
>  
> Index: linux-pm/drivers/cpufreq/cpufreq_powersave.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_powersave.c
> +++ linux-pm/drivers/cpufreq/cpufreq_powersave.c
> @@ -21,6 +21,7 @@ static struct cpufreq_governor cpufreq_g
>  	.name		= "powersave",
>  	.limits		= cpufreq_gov_powersave_limits,
>  	.owner		= THIS_MODULE,
> +	.flags		= CPUFREQ_GOV_FLAG_STRICT_TARGET,
>  };
>  
>  MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -575,6 +575,9 @@ struct cpufreq_governor {
>  /* For governors which change frequency dynamically by themselves */
>  #define CPUFREQ_GOV_FLAG_DYN_SWITCH	BIT(0)
>  
> +/* For governors wanting the target frequency to be set exactly */
> +#define CPUFREQ_GOV_FLAG_STRICT_TARGET	BIT(1)
> +
>  
>  /* Pass a target to the cpufreq driver */
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
