Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E849F3D5D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 02:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKHBUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 20:20:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63959 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHBUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 20:20:30 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 7418509ce44e4b04; Fri, 8 Nov 2019 02:20:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH V6 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Fri, 08 Nov 2019 02:20:27 +0100
Message-ID: <143021538.HHUP3Pj7i7@kreacher>
In-Reply-To: <20191030075141.1039-2-daniel.lezcano@linaro.org>
References: <20191030075141.1039-1-daniel.lezcano@linaro.org> <20191030075141.1039-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 30, 2019 8:51:40 AM CET Daniel Lezcano wrote:
> Currently, the play_idle function does not allow to tell which idle
> state we want to go. Improve this by passing the idle state as
> parameter to the function.
> 
> Export cpuidle_find_deepest_state() symbol as it is used from the
> intel_powerclamp driver as a module.
> 
> There is no functional changes, the cpuidle state is the deepest one.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   V6:
>    - Change variable name 'state' -> 'index':
>      https://lkml.org/lkml/2019/10/28/874
>   V4:
>    - Add EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state) for the
>      intel_powerclamp driver when this one is compiled as a module
>   V3:
>    - Add missing cpuidle.h header
> ---
>  drivers/cpuidle/cpuidle.c                | 1 +
>  drivers/powercap/idle_inject.c           | 4 +++-
>  drivers/thermal/intel/intel_powerclamp.c | 4 +++-
>  include/linux/cpu.h                      | 2 +-
>  kernel/sched/idle.c                      | 4 ++--
>  5 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 18523ea6b11b..b871fc2e8e67 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -126,6 +126,7 @@ int cpuidle_find_deepest_state(void)
>  
>  	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
> +EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state);

That doesn't appear to be really necessary to me.

>  
>  #ifdef CONFIG_SUSPEND
>  static void enter_s2idle_proper(struct cpuidle_driver *drv,
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..233c878cbf46 100644
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
> @@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
>  	 */
>  	iit->should_run = 0;
>  
> -	play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +	play_idle(READ_ONCE(ii_dev->idle_duration_us),
> +		  cpuidle_find_deepest_state());

The next patch changes this again and I'm not sure why this intermediate
change is useful.

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

I don't see a reason for changing the code here like this.

What you really need is to have a way to set a limit on the idle
state exit latency for idle injection on ARM.

For that you can pass the exit latency limit to play_idle(), but then
you need to change powerclamp to pass UNIT_MAX or similar which is
ugly, or you can redefine cpuidle_use_deepest_state() to take the
exit latency limit as the arg (with 0 meaning use_deepest_state == false).

In the latter case, it would be quite straightforward to add an
exit_latency argument to cpuidle_find_deepest_state() and note that
find_deepest_state() takes a max_latency arg already, so that would be
a trivial change (hint!).



