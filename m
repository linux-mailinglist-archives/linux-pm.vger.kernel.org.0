Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C248AB6CAE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfIRTgA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 15:36:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfIRTf7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 15:35:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so631899pfb.12
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0n4YOu1xaM555d4aI7Bta2bxtCQAQm73v5aumDVDEg=;
        b=y1qkZm00Pe7tOuIgzsBIDTlc6Eu43jhxRfNJdbYoSiu6prUUQ6uQOrsY4TpquWsVUJ
         fXGKVYSQAEQr3pxTXRiWFEso11ByxFu/2b1hTkLInAdIEYvjtgLVwisz72Fw7sDIPQyf
         IteQxIQwnQGti48UHojn2Uq5aFqQFTeAfA7MzMLKyCSnOzuUAUaVCZEMGkzWwhgiXSqn
         LG3jxEIFuxJG4rioaT3FYYejRumLH1rknGI/6iYNpi3SYRW67GPY3CsOKaIyb0jFekeN
         pExifeOyNW1mOoAHC0Aw941iqFr3UHqGysnNEuBSZ63RlnEJ68pxjYjTnvEXD+M7DuyF
         A6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0n4YOu1xaM555d4aI7Bta2bxtCQAQm73v5aumDVDEg=;
        b=lG1nnslVDKCC0FxdrFUSbtNeghnQ97VGWjuQ35nYBH0H9koz9KD24Pez/JQZVPWUyv
         HdzI6DqkMr3kHkjMCM4hBWPFdemDzd+LQRYuT2qWTQ+zGMecorI+3CBher4gmHv84DIy
         aTCUUWEQT8fOHcg8JGCHIU24VSKsNnrgYqsiWZ/fYD62Lh7jrgOGstIeAaM1JHZWzg9M
         9lbabE6vSwgUuBSkQqDfSLOtGYWZk+/MohyK+pDJ3ZSOBelEMSCF26ujl6gW19WlykeS
         ms29h3zqtC2JrpY/y/gRJ155ZK0uqJqe8bsp029tjM7CtxyLKxxLESAGblaiKxWoJ9fw
         zWbw==
X-Gm-Message-State: APjAAAU6fXpe67e56QpYifqPV7X6ShJeAqY5ZAVAWFeVxsPqt4K+FwDF
        2Yf5/CszuYe8b7LObn6kCBOriQ==
X-Google-Smtp-Source: APXvYqxommAUTPNUFYJSt/UvqD6qFStIBjthOrZfrVk617EcPX50zEBDezE/w2xVRnVO59k4C7gm8g==
X-Received: by 2002:a63:1608:: with SMTP id w8mr5526196pgl.223.1568835356949;
        Wed, 18 Sep 2019 12:35:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p189sm8810331pfp.163.2019.09.18.12.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 12:35:56 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:35:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state
 to inject
Message-ID: <20190918193554.GC24433@xps15>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
 <20190909145015.26317-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909145015.26317-3-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 09, 2019 at 04:50:15PM +0200, Daniel Lezcano wrote:
> Currently the idle injection framework only allows to inject the
> deepest idle state available on the system.
> 
> Give the opportunity to specify which idle state we want to inject by
> adding a new function helper to set the state and use it when calling
> play_idle().
> 
> There is no functional changes, the cpuidle state is the deepest one.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/idle_inject.c | 15 ++++++++++++++-
>  include/linux/idle_inject.h    |  3 +++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index 9b18667b9f26..a612c425d74c 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -38,6 +38,7 @@
>  #define pr_fmt(fmt) "ii_dev: " fmt
>  
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/hrtimer.h>
>  #include <linux/kthread.h>
>  #include <linux/sched.h>
> @@ -65,6 +66,7 @@ struct idle_inject_thread {
>   */
>  struct idle_inject_device {
>  	struct hrtimer timer;
> +	int state;
>  	unsigned int idle_duration_us;
>  	unsigned int run_duration_us;
>  	unsigned long int cpumask[0];
> @@ -139,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
>  	iit->should_run = 0;
>  
>  	play_idle(READ_ONCE(ii_dev->idle_duration_us),
> -		  cpuidle_find_deepest_state());
> +		  READ_ONCE(ii_dev->state));
>  }
>  
>  /**
> @@ -170,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>  
> +/**
> + * idle_inject_set_state - set the idle state to inject
> + * @state: an integer for the idle state to inject
> + */
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
> +{
> +	if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
> +		WRITE_ONCE(ii_dev->state, state);
> +}
> +
>  /**
>   * idle_inject_start - start idle injections
>   * @ii_dev: idle injection control device structure
> @@ -298,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>  	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>  	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	ii_dev->timer.function = idle_inject_timer_fn;
> +	ii_dev->state = cpuidle_find_deepest_state();
>  
>  	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>  
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index a445cd1a36c5..e2b26b9ccd34 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  				 unsigned int *run_duration_us,
>  				 unsigned int *idle_duration_us);
> +
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
> +

The above function is not used in this patch and as such should be introduce as
part of future work.  Otherwise I agree that this patch does not carry any
functional changes.

Without function idle_inject_set_state():

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org> 

>  #endif /* __IDLE_INJECT_H__ */
> -- 
> 2.17.1
> 
