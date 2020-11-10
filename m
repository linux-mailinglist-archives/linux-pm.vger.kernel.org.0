Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41A42ACB41
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 03:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKJCr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 21:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJCr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 21:47:27 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F14C0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 18:47:27 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so5714862pll.13
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 18:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UuLx7prIHda8827z12iEWkf6vSvIP09lTJVmS5Ox0Q=;
        b=Kw2B6lykWnSw7p5AV07ZJWL2A+cDzPdUYe9FzX/Us+etFHFI/T/T661fzpgfpmkB23
         L0s3IqzWxMuEpLtG2nf6epBUGvBgNQslbrwL/xWnLHM+dK3GSDrF8rS8Ot0Oc564aJVq
         519Wx4Vc34QuvNNgwC7LCzTeN+G1UMlAKa5NF+0slmhYZh6HLDYjufjEZVDPLlIGIQQe
         VLqdYK/5TswL8tpPoztGNjJ6kb5bI+IoagL3MAll0zOwQtq40+uQ1lh3Pd4g/04WfzRU
         Ijgf2QTBUMV3h0wJsQ3ydF/lb4a7N9BHcoTppT3suDT0Hqj+oetpijIKCSsBuOfIKIVK
         ZH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UuLx7prIHda8827z12iEWkf6vSvIP09lTJVmS5Ox0Q=;
        b=RW1ROownaW/zUFS1XkNn4dVCekm8fcA4tJMXu6LupevpZVs5VcNSF4Yjd5yXMVzWXl
         SeObvqXD79ixVq4XxqEDIN1cRSo2wrhv97UsyvIKh+kbNmFDUfl3ShHAQa47bCypogXW
         3yFK6+MZySTdvuWlCXCnRJ2h0YtyaumcTFMk6XLpsppExc5KNDkkOExYJQLu6F6GsrR+
         TljugDYcf1GRgOddU5yc7VebQNuxqLz6njDzqcSgElWUNf17s8C8q51mNAZwLieYFxYf
         F9PPcNOZLmeM1+K+I8adLpdGivSWd5hv+repa4b4PyKArR5ZsWiGRqItpGkcKlaXwYrT
         H9KA==
X-Gm-Message-State: AOAM533cLF4EharRupruhj5AQDW0lvH4irCN6ChsPds2QxFnK0b5s5ua
        qTPWA44cUyWFOtL8CGavNGUDuw==
X-Google-Smtp-Source: ABdhPJxrMfhkgS5xHKwvNJHFu2FRs4gK6JPlC1peRayhgiaY1blEDcAwRDcyQi3TKu5oxZkNxe3KuQ==
X-Received: by 2002:a17:902:d309:b029:d7:cc2d:1ee7 with SMTP id b9-20020a170902d309b02900d7cc2d1ee7mr1676854plc.10.1604976446323;
        Mon, 09 Nov 2020 18:47:26 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id i11sm12461961pfq.156.2020.11.09.18.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:47:25 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:17:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 3/4] cpufreq: Add strict_target to struct
 cpufreq_policy
Message-ID: <20201110024723.a5ouawbgj5ftyfe4@vireshk-i7>
References: <13269660.K2JYd4sGFX@kreacher>
 <2826323.52ZM0ncLkd@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2826323.52ZM0ncLkd@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 17:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new field to be set when the CPUFREQ_GOV_FLAG_STRICT_TARGET
> flag is set for the current governor to struct cpufreq_policy, so
> that the drivers needing to check CPUFREQ_GOV_FLAG_STRICT_TARGET do
> not have to access the governor object during every frequency
> transition.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    2 ++
>  include/linux/cpufreq.h   |    6 ++++++
>  2 files changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2280,6 +2280,8 @@ static int cpufreq_init_governor(struct
>  		}
>  	}
>  
> +	policy->strict_target = !!(policy->governor->flags & CPUFREQ_GOV_FLAG_STRICT_TARGET);
> +
>  	return 0;
>  }
>  
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -109,6 +109,12 @@ struct cpufreq_policy {
>  	bool			fast_switch_enabled;
>  
>  	/*
> +	 * Set if the CPUFREQ_GOV_FLAG_STRICT_TARGET flag is set for the
> +	 * current governor.
> +	 */
> +	bool			strict_target;
> +
> +	/*
>  	 * Preferred average time interval between consecutive invocations of
>  	 * the driver to set the frequency for this policy.  To be set by the
>  	 * scaling driver (0, which is the default, means no preference).

I was kind of hoping to avoid adding a field here when I proposed updating the
gov structure. I do understand the performance related penalty of accessing the
gov structure for fast switch case though and so wonder if we really need this,
then should we avoid changing the gov structure at all ? I mean there is only
one user of that field now, do we really need a flag for it ? We can just do the
string comparison here with powersave and performance to set strict_target.

Whatever you feel is better though.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
