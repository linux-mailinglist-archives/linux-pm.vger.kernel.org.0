Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB705113FF7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 12:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfLELPL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 06:15:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42261 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELPL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 06:15:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so2995486wrf.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 03:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rR3YUGi0wDL6AhOJ1Do0ulSAa4rvkWEvSmErI9Ci+ss=;
        b=EG8BAkz6SAXiXTZCRQNb/d1L2jqAAD7nJduZk1/Q1RWkOfipykgBORIgpNj29I+k+c
         wX7fKGCW5rdWxJvBt4HeDr41BL25PGbXCVjAKR0E2Lb/qe5tGsiosx3yqD05dLsRhmeA
         qtU2q02S4vh9SqD+HTfrMYtzvT+MATv+TKpgoa8Qi8xb9gOPJZF6vyJA1ubzTPD5LWcx
         MG6JlNy6nlLVjUSzbTSLeoDHL37b9DU8YxAYGYuAmcGocbu8tKspld1TQWPKSziKo/eW
         WvSbYNdNFT3dBCAhMfKcqeIJYO7gZG4qlXmkVRMJGRph7yVSQX3m8ABD7mZ+Fhcws/yu
         yP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rR3YUGi0wDL6AhOJ1Do0ulSAa4rvkWEvSmErI9Ci+ss=;
        b=OzKx7BPwTs1MizztjpmvCsW3+CGSPYHKJ1UdUwVydKF5wAo15PnpFUUNb3yVhR76oQ
         Ltu1Noe7605rITak5jIP8Iiyn5XqzwkHd6AAa0H3daDdIX7atisJayrv+jbh4XmR4ocI
         csXLMXkkPZWKgKqOEZCcI47s3i0Adlhe/MjmqUdQWPpMLYbQWdBTxYaiGEHNkeHf6Bjv
         tV64JIE0BjB104kVjCZUYcjfPnlKfBWjxHMNlAd4yG6+OfWfAC758bRbSBR+fu/itVfe
         F29Jox0STEaKpJ4V2Oasp7UFzgYniWOiP9pux9J3sCkBsvekNkt0bzjSbMoJ4woIatG5
         3zmQ==
X-Gm-Message-State: APjAAAWezvK0rVfVf26O2ce1vs4VLpPLGp8M1wPRA5ZlnzxXyMQfA71G
        9G2kyKLMpewsHIgUwwfZwiOJ7A==
X-Google-Smtp-Source: APXvYqzYUT0deS/7+jHX6nL1YKcyXxjTJNOuKFyOQaCJIjzprrtM6tcvbUZr1lNmz7yQhp8kLS8Omw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr10003791wrx.304.1575544507038;
        Thu, 05 Dec 2019 03:15:07 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6? ([2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6])
        by smtp.googlemail.com with ESMTPSA id u10sm9917137wmd.1.2019.12.05.03.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 03:15:06 -0800 (PST)
Subject: Re: [PATCH 1/2] cpuidle: Drop disabled field from struct
 cpuidle_state
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
References: <5961586.ml7s97geqL@kreacher> <3690440.Wzkxfdnirm@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c7863ab-8efc-ab2c-cab0-3cd68e415a57@linaro.org>
Date:   Thu, 5 Dec 2019 12:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <3690440.Wzkxfdnirm@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/11/2019 19:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent cpuidle updates the "disabled" field in struct
> cpuidle_state is only used by two drivers (intel_idle and shmobile
> cpuidle) for marking unusable idle states, but that may as well be
> achieved with the help of a state flag, so define an "unusable" idle
> state flag, CPUIDLE_FLAG_UNUSABLE, make the drivers in question use
> it instead of the "disabled" field and make the core set
> CPUIDLE_STATE_DISABLED_BY_DRIVER for the idle states with that flag
> set.
> 
> After the above changes, the "disabled" field in struct cpuidle_state
> is not used any more, so drop it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Changes from RFC:
> 
>  - Do not add extra braces (unrelated to the rest of the patch).
> 
> ---
>  arch/sh/kernel/cpu/shmobile/cpuidle.c |    8 ++++----
>  drivers/cpuidle/cpuidle.c             |    2 +-
>  drivers/cpuidle/poll_state.c          |    1 -
>  drivers/idle/intel_idle.c             |    6 +++---
>  include/linux/cpuidle.h               |    2 +-
>  5 files changed, 9 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/idle/intel_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/idle/intel_idle.c
> +++ linux-pm/drivers/idle/intel_idle.c
> @@ -1291,8 +1291,8 @@ static void sklh_idle_state_table_update
>  			return;
>  	}
>  
> -	skl_cstates[5].disabled = 1;	/* C8-SKL */
> -	skl_cstates[6].disabled = 1;	/* C9-SKL */
> +	skl_cstates[5].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C8-SKL */
> +	skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C9-SKL */
>  }
>  /*
>   * intel_idle_state_table_update()
> @@ -1355,7 +1355,7 @@ static void __init intel_idle_cpuidle_dr
>  			continue;
>  
>  		/* if state marked as disabled, skip it */
> -		if (cpuidle_state_table[cstate].disabled != 0) {
> +		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
>  			pr_debug("state %s is disabled\n",
>  				 cpuidle_state_table[cstate].name);
>  			continue;
> Index: linux-pm/include/linux/cpuidle.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -54,7 +54,6 @@ struct cpuidle_state {
>  	unsigned int	exit_latency; /* in US */
>  	int		power_usage; /* in mW */
>  	unsigned int	target_residency; /* in US */
> -	bool		disabled; /* disabled on all CPUs */
>  
>  	int (*enter)	(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
> @@ -77,6 +76,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> +#define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> Index: linux-pm/arch/sh/kernel/cpu/shmobile/cpuidle.c
> ===================================================================
> --- linux-pm.orig/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ linux-pm/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -67,7 +67,7 @@ static struct cpuidle_driver cpuidle_dri
>  			.enter = cpuidle_sleep_enter,
>  			.name = "C2",
>  			.desc = "SuperH Sleep Mode [SF]",
> -			.disabled = true,
> +			.flags = CPUIDLE_FLAG_UNUSABLE,
>  		},
>  		{
>  			.exit_latency = 2300,
> @@ -76,7 +76,7 @@ static struct cpuidle_driver cpuidle_dri
>  			.enter = cpuidle_sleep_enter,
>  			.name = "C3",
>  			.desc = "SuperH Mobile Standby Mode [SF]",
> -			.disabled = true,
> +			.flags = CPUIDLE_FLAG_UNUSABLE,
>  		},
>  	},
>  	.safe_state_index = 0,
> @@ -86,10 +86,10 @@ static struct cpuidle_driver cpuidle_dri
>  int __init sh_mobile_setup_cpuidle(void)
>  {
>  	if (sh_mobile_sleep_supported & SUSP_SH_SF)
> -		cpuidle_driver.states[1].disabled = false;
> +		cpuidle_driver.states[1].flags = CPUIDLE_FLAG_NONE;

That will overwrite other flags value, bit operation should be used here
to remove CPUIDLE_FLAG_UNUSABLE.

>  	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
> -		cpuidle_driver.states[2].disabled = false;
> +		cpuidle_driver.states[2].flags = CPUIDLE_FLAG_NONE;
>  
>  	return cpuidle_register(&cpuidle_driver, NULL);
>  }
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -570,7 +570,7 @@ static int __cpuidle_register_device(str
>  		return -EINVAL;
>  
>  	for (i = 0; i < drv->state_count; i++)
> -		if (drv->states[i].disabled)
> +		if (drv->states[i].flags & CPUIDLE_FLAG_UNUSABLE)
>  			dev->states_usage[i].disable |= CPUIDLE_STATE_DISABLED_BY_DRIVER;
>  
>  	per_cpu(cpuidle_devices, dev->cpu) = dev;
> Index: linux-pm/drivers/cpuidle/poll_state.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/poll_state.c
> +++ linux-pm/drivers/cpuidle/poll_state.c
> @@ -53,7 +53,6 @@ void cpuidle_poll_state_init(struct cpui
>  	state->target_residency_ns = 0;
>  	state->power_usage = -1;
>  	state->enter = poll_idle;
> -	state->disabled = false;
>  	state->flags = CPUIDLE_FLAG_POLLING;
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_poll_state_init);
> 
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

