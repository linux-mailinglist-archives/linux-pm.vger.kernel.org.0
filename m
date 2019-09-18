Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF92CB6C93
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfIRTas (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 15:30:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43031 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRTas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 15:30:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so412598pgb.10
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 12:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HLzPRK3GAXNM5xLTblOxGV9Q6DGatzHoWsFQNs/caP0=;
        b=oiSbz40siiKmYPogUFoLfuMN4h1aZgbTxVs57nkOvlUW3DUYQirAdI/q3rrV7RiBlf
         6rZoqxQ/5q5Szu+tiLtwBhFU+M4Z2In5WsdsOgYNr8ia9WblIefGNEOMY0umzxsQxK2k
         BdT5DoB7fa/dgNb8GYWnPGhgDcw0F5yVjsTkqR72FR/WNPNLNsdNA+MOLJYEbrdtjfjz
         KnCEeNTc0DJFWcbzEznLFv7js367/SySemn/nDo/Xwzyh174yd93ef0nXc20jm6pogYl
         Wsnv8uh8woKpA8sWqB2KmWOPq78n2cicXfjOuuAesbfa/fMCKiWgZ1IIkRIEtMYgcF3z
         k1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLzPRK3GAXNM5xLTblOxGV9Q6DGatzHoWsFQNs/caP0=;
        b=sCjRLBb8Yc/C5PIf2qpKQCRPSm3iY3ITIg2VZqtgJoxeAHk4KyiGweWNiKuhWQSh8C
         79pcq9uxo5u58rdh2E7d7iiPn1DN6zgM8UsNj/QZ0cnqAWE6OZoH2bZRzPPo1Edy2+6n
         GyLiBUDOjpNzi306cUddFjodwhLOmrsN5Yq59ds7vPAWbcw0V2aL0JlPvGxD7Yr79N5F
         teIzy9cgZnKFE06X8hCygSFN8h5IWMs7IL6zPxvN74FIszTccRhESIplxpD35ycmIBH1
         BvKf/EkKjyyv5hy8YafFzZWnRPEbLKJ0iyO7EpoT0MzDZUvwDBKMcfgywjxEyEhfdbaw
         kq9Q==
X-Gm-Message-State: APjAAAVg73avvkWNVvIzFr2NDpwQak82r2zWlhLCdPTjAE3dtyPmomHR
        s8owDkmGfgn8aQYOe2NIPX3XLg==
X-Google-Smtp-Source: APXvYqw4Zn7xmwjEJVqTKdp3MaG8FdSq6t+0JVX5q/nTofC9TRVTEvsIAb7bIdvSCZvV7+mt8DqxJA==
X-Received: by 2002:a62:aa0f:: with SMTP id e15mr5846419pff.160.1568835046043;
        Wed, 18 Sep 2019 12:30:46 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k5sm6029441pgo.45.2019.09.18.12.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 12:30:45 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:30:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpuidle: play_idle: Make play_idle more flexible
Message-ID: <20190918193043.GA24433@xps15>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909145015.26317-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 09, 2019 at 04:50:13PM +0200, Daniel Lezcano wrote:
> The play_idle function has two users, the intel powerclamp and the
> idle_injection.
> 
> The idle injection cooling device uses the function via the
> idle_injection powercap's APIs. Unfortunately, play_idle is currently
> limited by the idle state depth: by default the deepest idle state is
> selected. On the ARM[64] platforms, most of the time it is the cluster
> idle state, the exit latency and the residency can be very high. That
> reduces the scope of the idle injection usage because the impact on
> the performances can be very significant.
> 
> If the idle injection cycles can be done with a shallow state like a
> retention state, the cooling effect would eventually give similar
> results than the cpufreq cooling device.
> 
> In order to prepare the function to receive an idle state parameter,
> let's replace the 'use_deepest_state' boolean field with 'use_state'
> and use this value to enter the specific idle state.
> 
> The current code keeps the default behavior which is go to the deepest
> idle state.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
>  include/linux/cpuidle.h   | 14 +++++++-------
>  kernel/sched/idle.c       | 10 +++++-----
>  3 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0895b988fa92..f8b54f277589 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -99,31 +99,31 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>  }
>  
>  /**
> - * cpuidle_use_deepest_state - Set/clear governor override flag.
> - * @enable: New value of the flag.
> + * cpuidle_use_state - Force the cpuidle framework to enter an idle state.
> + * @state: An integer for an idle state
>   *
> - * Set/unset the current CPU to use the deepest idle state (override governors
> - * going forward if set).
> + * Specify an idle state the cpuidle framework must step in and bypass
> + * the idle state selection process.
>   */
> -void cpuidle_use_deepest_state(bool enable)
> +void cpuidle_use_state(int state)
>  {
>  	struct cpuidle_device *dev;
>  
>  	preempt_disable();
>  	dev = cpuidle_get_device();
>  	if (dev)
> -		dev->use_deepest_state = enable;
> +		dev->use_state = state;
>  	preempt_enable();
>  }
>  
>  /**
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
> - * @drv: cpuidle driver for the given CPU.
> - * @dev: cpuidle device for the given CPU.
>   */
> -int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -			       struct cpuidle_device *dev)
> +int cpuidle_find_deepest_state(void)
>  {
> +	struct cpuidle_device *dev = cpuidle_get_device();
> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +
>  	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
>  
> @@ -554,6 +554,7 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>  static void __cpuidle_device_init(struct cpuidle_device *dev)
>  {
>  	memset(dev->states_usage, 0, sizeof(dev->states_usage));
> +	dev->use_state = CPUIDLE_STATE_NOUSE;
>  	dev->last_residency = 0;
>  	dev->next_hrtimer = 0;
>  }
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 1a9f54eb3aa1..a1839122e219 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/hrtimer.h>
>  
> +#define CPUIDLE_STATE_NOUSE	-1
>  #define CPUIDLE_STATE_MAX	10
>  #define CPUIDLE_NAME_LEN	16
>  #define CPUIDLE_DESC_LEN	32
> @@ -80,11 +81,12 @@ struct cpuidle_driver_kobj;
>  struct cpuidle_device {
>  	unsigned int		registered:1;
>  	unsigned int		enabled:1;
> -	unsigned int		use_deepest_state:1;
>  	unsigned int		poll_time_limit:1;
>  	unsigned int		cpu;
> +

Spurious newline

>  	ktime_t			next_hrtimer;
>  
> +	int			use_state;
>  	int			last_state_idx;
>  	int			last_residency;
>  	u64			poll_limit_ns;
> @@ -200,19 +202,17 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #endif
>  
>  #ifdef CONFIG_CPU_IDLE
> -extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -				      struct cpuidle_device *dev);
> +extern int cpuidle_find_deepest_state(void);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev);
> -extern void cpuidle_use_deepest_state(bool enable);
> +extern void cpuidle_use_state(int state);
>  #else
> -static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -					     struct cpuidle_device *dev)
> +static inline int cpuidle_find_deepest_state(void)
>  {return -ENODEV; }
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>  				       struct cpuidle_device *dev)
>  {return -ENODEV; }
> -static inline void cpuidle_use_deepest_state(bool enable)
> +static inline void cpuidle_use_state(int state)
>  {
>  }
>  #endif
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b98283fc6914..17da9cb309e1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -165,7 +165,8 @@ static void cpuidle_idle_call(void)
>  	 * until a proper wakeup interrupt happens.
>  	 */
>  
> -	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> +	if (idle_should_enter_s2idle() ||
> +	    dev->use_state != CPUIDLE_STATE_NOUSE) {
>  		if (idle_should_enter_s2idle()) {
>  			rcu_idle_enter();
>  
> @@ -181,8 +182,7 @@ static void cpuidle_idle_call(void)
>  		tick_nohz_idle_stop_tick();
>  		rcu_idle_enter();
>  
> -		next_state = cpuidle_find_deepest_state(drv, dev);
> -		call_cpuidle(drv, dev, next_state);
> +		call_cpuidle(drv, dev, dev->use_state);
>  	} else {
>  		bool stop_tick = true;
>  
> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>  	rcu_sleep_check();
>  	preempt_disable();
>  	current->flags |= PF_IDLE;
> -	cpuidle_use_deepest_state(true);
> +	cpuidle_use_state(cpuidle_find_deepest_state());
>  
>  	it.done = 0;
>  	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> @@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
>  	while (!READ_ONCE(it.done))
>  		do_idle();
>  
> -	cpuidle_use_deepest_state(false);
> +	cpuidle_use_state(CPUIDLE_STATE_NOUSE);
>  	current->flags &= ~PF_IDLE;
>  
>  	preempt_fold_need_resched();

With the above:

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 
