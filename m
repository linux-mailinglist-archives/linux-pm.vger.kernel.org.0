Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E160381155
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 07:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfHEFTt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 01:19:49 -0400
Received: from comms.puri.sm ([159.203.221.185]:45260 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfHEFTt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 01:19:49 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 01:19:48 EDT
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D11B8DF8E0;
        Sun,  4 Aug 2019 22:11:28 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XwR4pE4Qe2a6; Sun,  4 Aug 2019 22:11:27 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        kevin.wangtao@linaro.org, leo.yan@linaro.org, edubezval@gmail.com,
        vincent.guittot@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date:   Mon,  5 Aug 2019 07:11:11 +0200
Message-Id: <20190805051111.24318-1-martin.kepplinger@puri.sm>
In-Reply-To: <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
References: <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

---

On 05-04-18, 18:16, Daniel Lezcano wrote:
> The cpu idle cooling driver performs synchronized idle injection across all
> cpus belonging to the same cluster and offers a new method to cool down a SoC.
> 
> Each cluster has its own idle cooling device, each core has its own idle
> injection thread, each idle injection thread uses play_idle to enter idle.  In
> order to reach the deepest idle state, each cooling device has the idle
> injection threads synchronized together.
> 
> It has some similarity with the intel power clamp driver but it is actually
> designed to work on the ARM architecture via the DT with a mathematical proof
> with the power model which comes with the Documentation.
> 
> The idle injection cycle is fixed while the running cycle is variable. That
> allows to have control on the device reactivity for the user experience. At
> the mitigation point the idle threads are unparked, they play idle the
> specified amount of time and they schedule themselves. The last thread sets
> the next idle injection deadline and when the timer expires it wakes up all
> the threads which in turn play idle again. Meanwhile the running cycle is
> changed by set_cur_state.  When the mitigation ends, the threads are parked.
> The algorithm is self adaptive, so there is no need to handle hotplugging.
> 
> If we take an example of the balanced point, we can use the DT for the hi6220.
> 
> The sustainable power for the SoC is 3326mW to mitigate at 75°C. Eight cores
> running at full blast at the maximum OPP consumes 5280mW. The first value is
> given in the DT, the second is calculated from the OPP with the formula:
> 
>    Pdyn = Cdyn x Voltage^2 x Frequency
> 
> As the SoC vendors don't want to share the static leakage values, we assume
> it is zero, so the Prun = Pdyn + Pstatic = Pdyn + 0 = Pdyn.
> 
> In order to reduce the power to 3326mW, we have to apply a ratio to the
> running time.
> 
> ratio = (Prun - Ptarget) / Ptarget = (5280 - 3326) / 3326 = 0,5874
> 
> We know the idle cycle which is fixed, let's assume 10ms. However from this
> duration we have to substract the wake up latency for the cluster idle state.
> In our case, it is 1.5ms. So for a 10ms latency for idle, we are really idle
> 8.5ms.
> 
> As we know the idle duration and the ratio, we can compute the running cycle.
> 
>    running_cycle = 8.5 / 0.5874 = 14.47ms
> 
> So for 8.5ms of idle, we have 14.47ms of running cycle, and that brings the
> SoC to the balanced trip point of 75°C.
> 
> The driver has been tested on the hi6220 and it appears the temperature
> stabilizes at 75°C with an idle injection time of 10ms (8.5ms real) and
> running cycle of 14ms as expected by the theory above.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig       |  10 +
>  drivers/thermal/cpu_cooling.c | 479 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpu_cooling.h   |   6 +
>  3 files changed, 495 insertions(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5aaae1b..6c34117 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -166,6 +166,16 @@ config CPU_FREQ_THERMAL
>  	  This will be useful for platforms using the generic thermal interface
>  	  and not the ACPI interface.
>  
> +config CPU_IDLE_THERMAL
> +       bool "CPU idle cooling strategy"
> +       depends on CPU_IDLE
> +       help
> +	 This implements the generic CPU cooling mechanism through
> +	 idle injection.  This will throttle the CPU by injecting
> +	 fixed idle cycle.  All CPUs belonging to the same cluster
> +	 will enter idle synchronously to reach the deepest idle
> +	 state.
> +
>  endchoice
>  
>  config CLOCK_THERMAL
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 5c219dc..1eec8d6 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -10,18 +10,33 @@
>   *		Viresh Kumar <viresh.kumar@linaro.org>
>   *
>   */
> +#define pr_fmt(fmt) "CPU cooling: " fmt
> +
>  #include <linux/module.h>
>  #include <linux/thermal.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpuidle.h>
>  #include <linux/err.h>
> +#include <linux/freezer.h>
>  #include <linux/idr.h>
> +#include <linux/kthread.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> +#include <linux/sched/prio.h>
> +#include <linux/sched/rt.h>
> +#include <linux/smpboot.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
>  
> +#include <linux/ratelimit.h>
> +
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +
>  #include <trace/events/thermal.h>
>  
> +#include <uapi/linux/sched/types.h>
> +
>  #ifdef CONFIG_CPU_FREQ_THERMAL
>  /*
>   * Cooling state <-> CPUFreq frequency
> @@ -928,3 +943,467 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
>  #endif /* CONFIG_CPU_FREQ_THERMAL */
> +
> +#ifdef CONFIG_CPU_IDLE_THERMAL
> +/**
> + * struct cpuidle_cooling_device - data for the idle cooling device
> + * @cdev: a pointer to a struct thermal_cooling_device
> + * @cpumask: a cpumask containing the CPU managed by the cooling device
> + * @timer: a hrtimer giving the tempo for the idle injection cycles
> + * @kref: a kernel refcount on this structure
> + * @count: an atomic to keep track of the last task exiting the idle cycle
> + * @idle_cycle: an integer defining the duration of the idle injection
> + * @state: an normalized integer giving the state of the cooling device
> + */
> +struct cpuidle_cooling_device {
> +	struct thermal_cooling_device *cdev;
> +	struct cpumask *cpumask;
> +	struct hrtimer timer;
> +	struct kref kref;
> +	atomic_t count;
> +	unsigned int idle_cycle;
> +	unsigned long state;
> +};
> +
> +struct cpuidle_cooling_thread {
> +	struct task_struct *tsk;
> +	int should_run;
> +};
> +
> +static DEFINE_PER_CPU(struct cpuidle_cooling_thread, cpuidle_cooling_thread);
> +static DEFINE_PER_CPU(struct cpuidle_cooling_device *, cpuidle_cooling_device);
> +
> +/**
> + * cpuidle_cooling_wakeup - Wake up all idle injection threads
> + * @idle_cdev: the idle cooling device
> + *
> + * Every idle injection task belonging to the idle cooling device and
> + * running on an online cpu will be wake up by this call.
> + */
> +static void cpuidle_cooling_wakeup(struct cpuidle_cooling_device *idle_cdev)
> +{
> +	struct cpuidle_cooling_thread *cct;
> +	int cpu;
> +
> +	for_each_cpu_and(cpu, idle_cdev->cpumask, cpu_online_mask) {
> +		cct = per_cpu_ptr(&cpuidle_cooling_thread, cpu);
> +		cct->should_run = 1;
> +		wake_up_process(cct->tsk);
> +	}
> +}
> +
> +/**
> + * cpuidle_cooling_wakeup_fn - Running cycle timer callback
> + * @timer: a hrtimer structure
> + *
> + * When the mitigation is acting, the CPU is allowed to run an amount
> + * of time, then the idle injection happens for the specified delay
> + * and the idle task injection schedules itself until the timer event
> + * wakes the idle injection tasks again for a new idle injection
> + * cycle. The time between the end of the idle injection and the timer
> + * expiration is the allocated running time for the CPU.
> + *
> + * Always returns HRTIMER_NORESTART
> + */
> +static enum hrtimer_restart cpuidle_cooling_wakeup_fn(struct hrtimer *timer)
> +{
> +	struct cpuidle_cooling_device *idle_cdev =
> +		container_of(timer, struct cpuidle_cooling_device, timer);
> +
> +	cpuidle_cooling_wakeup(idle_cdev);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * cpuidle_cooling_runtime - Running time computation
> + * @idle_cdev: the idle cooling device
> + *
> + * The running duration is computed from the idle injection duration
> + * which is fixed. If we reach 100% of idle injection ratio, that
> + * means the running duration is zero. If we have a 50% ratio
> + * injection, that means we have equal duration for idle and for
> + * running duration.
> + *
> + * The formula is deduced as the following:
> + *
> + *  running = idle x ((100 / ratio) - 1)
> + *
> + * For precision purpose for integer math, we use the following:
> + *
> + *  running = (idle x 100) / ratio - idle
> + *
> + * For example, if we have an injected duration of 50%, then we end up
> + * with 10ms of idle injection and 10ms of running duration.
> + *
> + * Returns a s64 nanosecond based
> + */
> +static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
> +{
> +	s64 next_wakeup;
> +	unsigned long state = idle_cdev->state;
> +
> +	/*
> +	 * The function should not be called when there is no
> +	 * mitigation because:
> +	 * - that does not make sense
> +	 * - we end up with a division by zero
> +	 */
> +	if (!state)
> +		return 0;
> +
> +	next_wakeup = (s64)((idle_cdev->idle_cycle * 100) / state) -
> +		idle_cdev->idle_cycle;
> +
> +	return next_wakeup * NSEC_PER_USEC;
> +}
> +

There is a bug in your calculation formula here when "state" becomes 100.
You return 0 for the injection rate, which is the same as "rate" being 0,
which is dangerous. You stop cooling when it's most necessary :)

I'm not sure how much sense really being 100% idle makes, so I, when testing
this, just say if (state == 100) { state = 99 }. Anyways, just don't return 0.

Daniel, thanks a lot for these additions! Could you send an update of this?

btw, that's what I'm referring to:
https://lore.kernel.org/linux-pm/1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org/
I know it's a little old already, but it seems like there hasn't been any
equivalent solution in the meantime, has it?

Using cpuidle for cooling is way more effective than cpufreq (which often
hardly is).

thanks again,

                                     martin


