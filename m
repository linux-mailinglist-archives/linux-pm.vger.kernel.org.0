Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1022F178
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgG0Ocg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgG0OS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 10:18:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BADC0619D2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 07:18:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so12268998qtg.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pdmKQetK0QLJ8rFRGpIDAlZksqbKSxwq3s5x5iSj/6k=;
        b=IJ6z7XlWdHP11wN6ofEIEZ8eiR6sqBYmqASCFE7tsyV0XaLFN6UBCLhSDxG3ZtxFiB
         6UUQmZZQPtZ5gWL5TR/BbzcqU4PRy1rsZs1ydjdNLg3DukK8x+zI+T5IrylXKZcJrp7X
         wgzsam6DyjyXmTzlExIy6Gz+ESwjakDY8S7H+WJNUPiGauBejJX9bL1UdYuOeP4pj6DE
         upJWQuBQhzHG9jhW6jTcUmhVdyytehsFjMWOs5NLeA9zWbEPdR+c2Lh3HlXUFaiIaFfI
         c4NcJMTaVP+qgpPKCcMERNPi8R+BSrrTeP2DhEflbq++A2XpC+Qam2kcKEcY1g6hCLWg
         xxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pdmKQetK0QLJ8rFRGpIDAlZksqbKSxwq3s5x5iSj/6k=;
        b=QhbjP7R9T2WzuCGw/fzufcow9C2pcZdvwuuRW9AmLAlTOnEnf0lnUOkRFs4eCUa3hH
         YNic0S4Co+1UaBOCFO0xROE0uHJCAqAqFc8KUAUei1+7JWL+ShspnK99RS7jZ7XQ/5hN
         YvheApbX5+ah475W2h4bYT1UC83FU7+0MM279MXr9ALFJ4poF44oZWMWmTxwiJCWHxBo
         /H0NI9TEi3BrkvjIlDFP4Bzjez57KhPNrV1V9rLuDDSCnFZPOwEULCsWI63HP02/qV7A
         y7xWgbXPti/48+fey4+da44pplqTVpxnGfxb/3ODy6KrMPpYsTUhCecTBS9Wg/7tlvRS
         aIBQ==
X-Gm-Message-State: AOAM532i7GMEo6ubKFCCMIlaimpKQlPTdCoD4BYo1dcpP0aYUGmdsVgX
        YDOlqsXfwRRct377YxExNkc4rw==
X-Google-Smtp-Source: ABdhPJy130C3D8M0rAarkjKcRWiHNErupodcdoc3UEhXmIRDecJWWcdT53d/lQhoGpyYSerZL6QGHQ==
X-Received: by 2002:ac8:7a95:: with SMTP id x21mr7959782qtr.135.1595859535983;
        Mon, 27 Jul 2020 07:18:55 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k24sm14790073qtb.26.2020.07.27.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:18:55 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:18:48 -0400
From:   Qian Cai <cai@lca.pw>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 2/3] sched: Cleanup SCHED_THERMAL_PRESSURE kconfig
 entry
Message-ID: <20200727141825.GA4174@lca.pw>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
 <20200712165917.9168-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712165917.9168-3-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 12, 2020 at 05:59:16PM +0100, Valentin Schneider wrote:
> As Russell pointed out [1], this option is severely lacking in the
> documentation department, and figuring out if one has the required
> dependencies to benefit from turning it on is not straightforward.
> 
> Make it non user-visible, and add a bit of help to it. While at it, make it
> depend on CPU_FREQ_THERMAL.
> 
> [1]: https://lkml.kernel.org/r/20200603173150.GB1551@shell.armlinux.org.uk
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  init/Kconfig | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 0498af567f70..0a97d85568b2 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -492,8 +492,21 @@ config HAVE_SCHED_AVG_IRQ
>  	depends on SMP
>  
>  config SCHED_THERMAL_PRESSURE
> -	bool "Enable periodic averaging of thermal pressure"
> +	bool
>  	depends on SMP
> +	depends on CPU_FREQ_THERMAL
> +	help
> +	  Select this option to enable thermal pressure accounting in the
> +	  scheduler. Thermal pressure is the value conveyed to the scheduler
> +	  that reflects the reduction in CPU compute capacity resulted from
> +	  thermal throttling. Thermal throttling occurs when the performance of
> +	  a CPU is capped due to high operating temperatures.
> +
> +	  If selected, the scheduler will be able to balance tasks accordingly,
> +	  i.e. put less load on throttled CPUs than on non/less throttled ones.
> +
> +	  This requires the architecture to implement
> +	  arch_set_thermal_pressure() and arch_get_thermal_pressure().
>  
>  config BSD_PROCESS_ACCT
>  	bool "BSD Process Accounting"
> -- 

On arm64 linux-next (20200727),

https://gitlab.com/cailca/linux-mm/-/blob/master/arm64.config

WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
  Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
  Selected by [y]:
  - ARM64 [=y]
