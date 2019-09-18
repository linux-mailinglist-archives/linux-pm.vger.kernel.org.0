Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA91B6CA4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfIRTbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 15:31:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38052 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfIRTbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 15:31:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so432502pgi.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FcjaFRkF/K9EFIAeHVS2iXw3vpzZ6BGPswp+WEanLQU=;
        b=WQLBnvpnv0n77Azgk1x46VffG1dsTTcw6nb42o6qyLWfiFJWqDx/NWLuBzdNm3a24M
         ecQxIMU0sCmmny5nlbcyz7r+6SYlMsGVHBtf7MjUSc/QkNwNEtLsQHU+jkEAjcDJjYEg
         Y2RVj/7dQp2JLGs7H27M74mzHzaNPSJVdpc/+OidcUN0LMJwGWFd2TaCPwuEgpBkx0fQ
         IkAFkDLkKHigfMPyPmBA+zwiQk07q9wNTrLt4ZSOAPDj0mHoOw5pV2rGKb9+b5LKdOwF
         TAPRQ78N18F5ngC/TGZ8V7TSEc4GXMTfneHv4m+VGrKqXgZMU4i7cMIkKqqs4BzkaDyD
         F46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FcjaFRkF/K9EFIAeHVS2iXw3vpzZ6BGPswp+WEanLQU=;
        b=fZhzk10QEVd6HhK1/OynQEkZ3fh8AffZyH15R5eIFN8CFu7whwPYHNcFi8d5yZKL2r
         MyeUYzbEXfhsjFNCXAGe0RDj6PnVD7GxfNtQentUNefJWGsmn7QwVE+nLehH+QHEXQ8A
         85ayVWU+hFMK4qWaZynk6+azm/K44gDY78++2S2AIEtRiHBbbT4Jy4UpPWlKNaJHpXCh
         YBmEArfIFH2qnc24Immp1DaHxlJY0bcUzDkV9sWFAS6iE9ucKs7aQTljH2JLje9QLVFl
         1G6nOGtTmhHzQboAypcBgaYOKXT3a4pzAP2hanGevTkqSbCJBQOXhxOR1FQydUVq8hgx
         jb3Q==
X-Gm-Message-State: APjAAAUGkdOxaS/VBdH6IWkCoQA3Aw2ob6WpyMOi4/gYxiSM6k2Z+p3A
        AztTqxaoQj4lbZh9Iw9WNvnSaQ==
X-Google-Smtp-Source: APXvYqztAeaDpYXX9edD123X83h/EIrO6TAP6Q6Nscufq2BdUPP0AFStKZXLkiVgExfFyvschUpUJg==
X-Received: by 2002:a63:c246:: with SMTP id l6mr5587337pgg.210.1568835095355;
        Wed, 18 Sep 2019 12:31:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 65sm6978927pff.148.2019.09.18.12.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 12:31:34 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:31:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] cpuidle: play_idle: Specify play_idle with an idle
 state
Message-ID: <20190918193132.GB24433@xps15>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
 <20190909145015.26317-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909145015.26317-2-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 09, 2019 at 04:50:14PM +0200, Daniel Lezcano wrote:
> Currently, the play_idle function does not allow to tell which idle
> state we want to go. Improve this by passing the idle state as
> parameter to the function.
> 
> There is no functional changes, the cpuidle state is the deepest one.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/idle_inject.c           | 3 ++-
>  drivers/thermal/intel/intel_powerclamp.c | 4 +++-
>  include/linux/cpu.h                      | 2 +-
>  kernel/sched/idle.c                      | 4 ++--
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..9b18667b9f26 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -138,7 +138,8 @@ static void idle_inject_fn(unsigned int cpu)
>  	 */
>  	iit->should_run = 0;
>  
> -	play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +	play_idle(READ_ONCE(ii_dev->idle_duration_us),
> +		  cpuidle_find_deepest_state());
>  }
>  
>  /**
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 53216dcbe173..b55786c169ae 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -29,6 +29,7 @@
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/thermal.h>
>  #include <linux/slab.h>
>  #include <linux/tick.h>
> @@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
>  	if (should_skip)
>  		goto balance;
>  
> -	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
> +	play_idle(jiffies_to_usecs(w_data->duration_jiffies),
> +		  cpuidle_find_deepest_state());
>  
>  balance:
>  	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 88dc0c653925..76e3038b63ce 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
>  int cpu_report_state(int cpu);
>  int cpu_check_up_prepare(int cpu);
>  void cpu_set_state_online(int cpu);
> -void play_idle(unsigned long duration_us);
> +void play_idle(unsigned long duration_us, int state);
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  bool cpu_wait_death(unsigned int cpu, int seconds);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 17da9cb309e1..ead439dab2b5 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> -void play_idle(unsigned long duration_us)
> +void play_idle(unsigned long duration_us, int state)
>  {
>  	struct idle_timer it;
>  
> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>  	rcu_sleep_check();
>  	preempt_disable();
>  	current->flags |= PF_IDLE;
> -	cpuidle_use_state(cpuidle_find_deepest_state());
> +	cpuidle_use_state(state);
>  
>  	it.done = 0;
>  	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 
