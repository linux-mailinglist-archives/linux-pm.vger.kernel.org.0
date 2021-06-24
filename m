Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA13B24A2
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 03:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFXByy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFXByv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 21:54:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6283C061756
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 18:52:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u190so3369539pgd.8
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dYfuNrQpXoszXgYnFAghv58zb9ib9WhbwqYYiptVh90=;
        b=bLSHoUuh9W9/6lmR5JVBuNiHvmmikg/DBtPcZWJUtikTQIW2q4EQksgLSigQ1qx7lw
         UdjmSfQLaXxrkEtXEGeAVQtdFWnQ0Mih4eDti+ulu8an2DBRHJHdHGBsccnv7kNlw8D/
         XqDf7sp2/MAatRPzJdSsu4Egx7om1CCnj5JF1tp+yc6/pITTaMGBfK1ndbCK4IuQaUyk
         tj7B7MNU50tGgkGdR1N+AK70d/t64tqHtgAsOr6+tp5VQz4ZnYMsUm5IKR3uJPzrCkiW
         1EUpHuSDMKh0j+1c0XbOloLYfNfq9Fa5OaTZOFK3AyOawqzJ8/9AF2fC2h61QHZHVm5E
         miOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dYfuNrQpXoszXgYnFAghv58zb9ib9WhbwqYYiptVh90=;
        b=XKBL3kAIWdM7FSMbVNomMLBP+4IUCtOdlrzD3uOzoBHlZjVWK7IuhTuKCCVucjor/C
         bJYZgohy2lztGD1l/izzLK/x+AuSw0c/rPqXTv/VJu+55EiFaPgkMaz0HJCBsgCvVpU1
         mo6nMIqF0Rk8hAvAY85bXcaA9lwkq3McaxB06KG94SOgwH4JR7++95BECBil12lV93G8
         rCBbtKE/WEPrXVcFs5J/DL/9Kl9WXrUVeDqxO7xrKZejcIoz3dTkhMMJcxFwDP1rF1xF
         +ES3cVxhykdtWdY0jdO0TXLLza3z7kdIhOJlDa6oPgM8QjtJ8a/pSsHoaoVI6vL2Q3z/
         Sx/g==
X-Gm-Message-State: AOAM531qr7oUUJwWaHpOO35vz+zzCU+JMjOKf8wVayPj4NeXwBp5ILeA
        WmRe0ad7eNBFBOvEJ4e3eFAyIQ==
X-Google-Smtp-Source: ABdhPJy7Wqr/zehasRfBCIS5fVRMNyGg2sJG5Gf3X8fqn2sv5UUwrdHlNdJHRM2Plm8Zfv/7pJfP4Q==
X-Received: by 2002:a65:44c1:: with SMTP id g1mr2425812pgs.76.1624499552011;
        Wed, 23 Jun 2021 18:52:32 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id a15sm935117pff.128.2021.06.23.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 18:52:31 -0700 (PDT)
Date:   Thu, 24 Jun 2021 07:22:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/4] cpufreq: intel_pstate: Migrate to ->offline()
 instead of ->stop_cpu()
Message-ID: <20210624015138.nzrrgiqyk3hblknv@vireshk-i7>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
 <6144911f36d3d1f5faddf81d744bd39946843f6b.1624421816.git.viresh.kumar@linaro.org>
 <5741915.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5741915.lOV4Wx5bFT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-21, 17:13, Rafael J. Wysocki wrote:
> As mentioned already in
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0g2tCZptcqh+c55YYiO7rDHmZivMLsmpq_7005zNPN1xg@mail.gmail.com/

Sorry about failing to reply over that, I got confused somehow..

> this isn't particularly clean, because intel_pstate_cpu_offline() is
> also used in the passive mode where the above call is not needed.

intel_pstate_clear_update_util_hook() returns early if the hook was never
registered, and so calling it was safe, but yes not very clean.

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: intel_pstate: Combine ->stop_cpu() and ->offline()
> 
> Combine the ->stop_cpu() and ->offline() callback routines for the
> active mode of intel_pstate so as to avoid setting the ->stop_cpu
> callback pointer which is going to be dropped from the framework.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2577,11 +2577,13 @@ static int intel_pstate_cpu_online(struc
>  	return 0;
>  }
>  
> -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> +static int intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>  {
>  	pr_debug("CPU %d stopping\n", policy->cpu);
>  
>  	intel_pstate_clear_update_util_hook(policy->cpu);
> +
> +	return intel_pstate_cpu_offline(policy);
>  }
>  
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> @@ -2654,8 +2656,7 @@ static struct cpufreq_driver intel_pstat
>  	.resume		= intel_pstate_resume,
>  	.init		= intel_pstate_cpu_init,
>  	.exit		= intel_pstate_cpu_exit,
> -	.stop_cpu	= intel_pstate_stop_cpu,
> -	.offline	= intel_pstate_cpu_offline,
> +	.offline	= intel_pstate_stop_cpu,

I would suggest to rename intel_pstate_cpu_offline() as
intel_cpufreq_cpu_offline() and intel_pstate_stop_cpu() as
intel_pstate_cpu_offline(), so we remove the stop-cpu terminology completely.

Either way:
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

>  	.online		= intel_pstate_cpu_online,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_pstate",

-- 
viresh
