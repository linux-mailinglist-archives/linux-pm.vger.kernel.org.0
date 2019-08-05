Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56C8128F
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 08:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfHEGxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 02:53:49 -0400
Received: from comms.puri.sm ([159.203.221.185]:47774 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfHEGxs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 02:53:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B0C80DF61D;
        Sun,  4 Aug 2019 23:53:45 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D774uKjCs9a5; Sun,  4 Aug 2019 23:53:44 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To:     daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        kevin.wangtao@linaro.org, leo.yan@linaro.org, edubezval@gmail.com,
        vincent.guittot@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <20190805051111.24318-1-martin.kepplinger@puri.sm>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Openpgp: preference=signencrypt
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 WG//KA68tPVBR2xhy7Fp+qAa
Message-ID: <02ec23c3-37ee-4e9f-56a4-453a30a29747@puri.sm>
Date:   Mon, 5 Aug 2019 08:53:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20190805051111.24318-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05.08.19 07:11, Martin Kepplinger wrote:
> ---
> 
> On 05-04-18, 18:16, Daniel Lezcano wrote:
>> The cpu idle cooling driver performs synchronized idle injection across all
>> cpus belonging to the same cluster and offers a new method to cool down a SoC.
>>
>> Each cluster has its own idle cooling device, each core has its own idle
>> injection thread, each idle injection thread uses play_idle to enter idle.  In
>> order to reach the deepest idle state, each cooling device has the idle
>> injection threads synchronized together.
>>
>> It has some similarity with the intel power clamp driver but it is actually
>> designed to work on the ARM architecture via the DT with a mathematical proof
>> with the power model which comes with the Documentation.
>>
>> The idle injection cycle is fixed while the running cycle is variable. That
>> allows to have control on the device reactivity for the user experience. At
>> the mitigation point the idle threads are unparked, they play idle the
>> specified amount of time and they schedule themselves. The last thread sets
>> the next idle injection deadline and when the timer expires it wakes up all
>> the threads which in turn play idle again. Meanwhile the running cycle is
>> changed by set_cur_state.  When the mitigation ends, the threads are parked.
>> The algorithm is self adaptive, so there is no need to handle hotplugging.
>>
>> If we take an example of the balanced point, we can use the DT for the hi6220.
>>
>> The sustainable power for the SoC is 3326mW to mitigate at 75°C. Eight cores
>> running at full blast at the maximum OPP consumes 5280mW. The first value is
>> given in the DT, the second is calculated from the OPP with the formula:
>>
>>    Pdyn = Cdyn x Voltage^2 x Frequency
>>
>> As the SoC vendors don't want to share the static leakage values, we assume
>> it is zero, so the Prun = Pdyn + Pstatic = Pdyn + 0 = Pdyn.
>>
>> In order to reduce the power to 3326mW, we have to apply a ratio to the
>> running time.
>>
>> ratio = (Prun - Ptarget) / Ptarget = (5280 - 3326) / 3326 = 0,5874
>>
>> We know the idle cycle which is fixed, let's assume 10ms. However from this
>> duration we have to substract the wake up latency for the cluster idle state.
>> In our case, it is 1.5ms. So for a 10ms latency for idle, we are really idle
>> 8.5ms.
>>
>> As we know the idle duration and the ratio, we can compute the running cycle.
>>
>>    running_cycle = 8.5 / 0.5874 = 14.47ms
>>
>> So for 8.5ms of idle, we have 14.47ms of running cycle, and that brings the
>> SoC to the balanced trip point of 75°C.
>>
>> The driver has been tested on the hi6220 and it appears the temperature
>> stabilizes at 75°C with an idle injection time of 10ms (8.5ms real) and
>> running cycle of 14ms as expected by the theory above.
>>
>> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig       |  10 +
>>  drivers/thermal/cpu_cooling.c | 479 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/cpu_cooling.h   |   6 +
>>  3 files changed, 495 insertions(+)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 5aaae1b..6c34117 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -166,6 +166,16 @@ config CPU_FREQ_THERMAL
>>  	  This will be useful for platforms using the generic thermal interface
>>  	  and not the ACPI interface.
>>  
>> +config CPU_IDLE_THERMAL
>> +       bool "CPU idle cooling strategy"
>> +       depends on CPU_IDLE
>> +       help
>> +	 This implements the generic CPU cooling mechanism through
>> +	 idle injection.  This will throttle the CPU by injecting
>> +	 fixed idle cycle.  All CPUs belonging to the same cluster
>> +	 will enter idle synchronously to reach the deepest idle
>> +	 state.
>> +
>>  endchoice
>>  
>>  config CLOCK_THERMAL
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 5c219dc..1eec8d6 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -10,18 +10,33 @@
>>   *		Viresh Kumar <viresh.kumar@linaro.org>
>>   *
>>   */
>> +#define pr_fmt(fmt) "CPU cooling: " fmt
>> +
>>  #include <linux/module.h>
>>  #include <linux/thermal.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/cpuidle.h>
>>  #include <linux/err.h>
>> +#include <linux/freezer.h>
>>  #include <linux/idr.h>
>> +#include <linux/kthread.h>
>>  #include <linux/pm_opp.h>
>>  #include <linux/slab.h>
>> +#include <linux/sched/prio.h>
>> +#include <linux/sched/rt.h>
>> +#include <linux/smpboot.h>
>>  #include <linux/cpu.h>
>>  #include <linux/cpu_cooling.h>
>>  
>> +#include <linux/ratelimit.h>
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/of_platform.h>
>> +
>>  #include <trace/events/thermal.h>
>>  
>> +#include <uapi/linux/sched/types.h>
>> +
>>  #ifdef CONFIG_CPU_FREQ_THERMAL
>>  /*
>>   * Cooling state <-> CPUFreq frequency
>> @@ -928,3 +943,467 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
>>  #endif /* CONFIG_CPU_FREQ_THERMAL */
>> +
>> +#ifdef CONFIG_CPU_IDLE_THERMAL
>> +/**
>> + * struct cpuidle_cooling_device - data for the idle cooling device
>> + * @cdev: a pointer to a struct thermal_cooling_device
>> + * @cpumask: a cpumask containing the CPU managed by the cooling device
>> + * @timer: a hrtimer giving the tempo for the idle injection cycles
>> + * @kref: a kernel refcount on this structure
>> + * @count: an atomic to keep track of the last task exiting the idle cycle
>> + * @idle_cycle: an integer defining the duration of the idle injection
>> + * @state: an normalized integer giving the state of the cooling device
>> + */
>> +struct cpuidle_cooling_device {
>> +	struct thermal_cooling_device *cdev;
>> +	struct cpumask *cpumask;
>> +	struct hrtimer timer;
>> +	struct kref kref;
>> +	atomic_t count;
>> +	unsigned int idle_cycle;
>> +	unsigned long state;
>> +};
>> +
>> +struct cpuidle_cooling_thread {
>> +	struct task_struct *tsk;
>> +	int should_run;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct cpuidle_cooling_thread, cpuidle_cooling_thread);
>> +static DEFINE_PER_CPU(struct cpuidle_cooling_device *, cpuidle_cooling_device);
>> +
>> +/**
>> + * cpuidle_cooling_wakeup - Wake up all idle injection threads
>> + * @idle_cdev: the idle cooling device
>> + *
>> + * Every idle injection task belonging to the idle cooling device and
>> + * running on an online cpu will be wake up by this call.
>> + */
>> +static void cpuidle_cooling_wakeup(struct cpuidle_cooling_device *idle_cdev)
>> +{
>> +	struct cpuidle_cooling_thread *cct;
>> +	int cpu;
>> +
>> +	for_each_cpu_and(cpu, idle_cdev->cpumask, cpu_online_mask) {
>> +		cct = per_cpu_ptr(&cpuidle_cooling_thread, cpu);
>> +		cct->should_run = 1;
>> +		wake_up_process(cct->tsk);
>> +	}
>> +}
>> +
>> +/**
>> + * cpuidle_cooling_wakeup_fn - Running cycle timer callback
>> + * @timer: a hrtimer structure
>> + *
>> + * When the mitigation is acting, the CPU is allowed to run an amount
>> + * of time, then the idle injection happens for the specified delay
>> + * and the idle task injection schedules itself until the timer event
>> + * wakes the idle injection tasks again for a new idle injection
>> + * cycle. The time between the end of the idle injection and the timer
>> + * expiration is the allocated running time for the CPU.
>> + *
>> + * Always returns HRTIMER_NORESTART
>> + */
>> +static enum hrtimer_restart cpuidle_cooling_wakeup_fn(struct hrtimer *timer)
>> +{
>> +	struct cpuidle_cooling_device *idle_cdev =
>> +		container_of(timer, struct cpuidle_cooling_device, timer);
>> +
>> +	cpuidle_cooling_wakeup(idle_cdev);
>> +
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +/**
>> + * cpuidle_cooling_runtime - Running time computation
>> + * @idle_cdev: the idle cooling device
>> + *
>> + * The running duration is computed from the idle injection duration
>> + * which is fixed. If we reach 100% of idle injection ratio, that
>> + * means the running duration is zero. If we have a 50% ratio
>> + * injection, that means we have equal duration for idle and for
>> + * running duration.
>> + *
>> + * The formula is deduced as the following:
>> + *
>> + *  running = idle x ((100 / ratio) - 1)
>> + *
>> + * For precision purpose for integer math, we use the following:
>> + *
>> + *  running = (idle x 100) / ratio - idle
>> + *
>> + * For example, if we have an injected duration of 50%, then we end up
>> + * with 10ms of idle injection and 10ms of running duration.
>> + *
>> + * Returns a s64 nanosecond based
>> + */
>> +static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
>> +{
>> +	s64 next_wakeup;
>> +	unsigned long state = idle_cdev->state;
>> +
>> +	/*
>> +	 * The function should not be called when there is no
>> +	 * mitigation because:
>> +	 * - that does not make sense
>> +	 * - we end up with a division by zero
>> +	 */
>> +	if (!state)
>> +		return 0;
>> +
>> +	next_wakeup = (s64)((idle_cdev->idle_cycle * 100) / state) -
>> +		idle_cdev->idle_cycle;
>> +
>> +	return next_wakeup * NSEC_PER_USEC;
>> +}
>> +
> 
> There is a bug in your calculation formula here when "state" becomes 100.
> You return 0 for the injection rate, which is the same as "rate" being 0,
> which is dangerous. You stop cooling when it's most necessary :)
> 
> I'm not sure how much sense really being 100% idle makes, so I, when testing
> this, just say if (state == 100) { state = 99 }. Anyways, just don't return 0.
> 

oh and also, this breaks S3 suspend:

Aug  5 06:09:20 pureos kernel: [  807.487887] PM: suspend entry (deep)
Aug  5 06:09:40 pureos kernel: [  807.501148] Filesystems sync: 0.013
seconds
Aug  5 06:09:40 pureos kernel: [  807.501591] Freezing user space
processes ... (elapsed 0.003 seconds) done.
Aug  5 06:09:40 pureos kernel: [  807.504741] OOM killer disabled.
Aug  5 06:09:40 pureos kernel: [  807.504744] Freezing remaining
freezable tasks ...
Aug  5 06:09:40 pureos kernel: [  827.517712] Freezing of tasks failed
after 20.002 seconds (4 tasks refusing to freeze, wq_busy=0):
Aug  5 06:09:40 pureos kernel: [  827.527122] thermal-idle/0  S    0
161      2 0x00000028
Aug  5 06:09:40 pureos kernel: [  827.527131] Call trace:
Aug  5 06:09:40 pureos kernel: [  827.527148]  __switch_to+0xb4/0x200
Aug  5 06:09:40 pureos kernel: [  827.527156]  __schedule+0x1e0/0x488
Aug  5 06:09:40 pureos kernel: [  827.527162]  schedule+0x38/0xc8
Aug  5 06:09:40 pureos kernel: [  827.527169]  smpboot_thread_fn+0x250/0x2a8
Aug  5 06:09:40 pureos kernel: [  827.527176]  kthread+0xf4/0x120
Aug  5 06:09:40 pureos kernel: [  827.527182]  ret_from_fork+0x10/0x18
Aug  5 06:09:40 pureos kernel: [  827.527186] thermal-idle/1  S    0
162      2 0x00000028
Aug  5 06:09:40 pureos kernel: [  827.527192] Call trace:
Aug  5 06:09:40 pureos kernel: [  827.527197]  __switch_to+0x188/0x200
Aug  5 06:09:40 pureos kernel: [  827.527203]  __schedule+0x1e0/0x488
Aug  5 06:09:40 pureos kernel: [  827.527208]  schedule+0x38/0xc8
Aug  5 06:09:40 pureos kernel: [  827.527213]  smpboot_thread_fn+0x250/0x2a8
Aug  5 06:09:40 pureos kernel: [  827.527218]  kthread+0xf4/0x120
Aug  5 06:09:40 pureos kernel: [  827.527222]  ret_from_fork+0x10/0x18
Aug  5 06:09:40 pureos kernel: [  827.527226] thermal-idle/2  S    0
163      2 0x00000028
Aug  5 06:09:40 pureos kernel: [  827.527231] Call trace:
Aug  5 06:09:40 pureos kernel: [  827.527237]  __switch_to+0xb4/0x200
Aug  5 06:09:40 pureos kernel: [  827.527242]  __schedule+0x1e0/0x488
Aug  5 06:09:40 pureos kernel: [  827.527247]  schedule+0x38/0xc8
Aug  5 06:09:40 pureos kernel: [  827.527259]  smpboot_thread_fn+0x250/0x2a8
Aug  5 06:09:40 pureos kernel: [  827.527264]  kthread+0xf4/0x120
Aug  5 06:09:40 pureos kernel: [  827.527268]  ret_from_fork+0x10/0x18
Aug  5 06:09:40 pureos kernel: [  827.527272] thermal-idle/3  S    0
164      2 0x00000028
Aug  5 06:09:40 pureos kernel: [  827.527278] Call trace:
Aug  5 06:09:40 pureos kernel: [  827.527283]  __switch_to+0xb4/0x200
Aug  5 06:09:40 pureos kernel: [  827.527288]  __schedule+0x1e0/0x488
Aug  5 06:09:40 pureos kernel: [  827.527293]  schedule+0x38/0xc8
Aug  5 06:09:40 pureos kernel: [  827.527298]  smpboot_thread_fn+0x250/0x2a8
Aug  5 06:09:40 pureos kernel: [  827.527303]  kthread+0xf4/0x120
Aug  5 06:09:40 pureos kernel: [  827.527308]  ret_from_fork+0x10/0x18
Aug  5 06:09:40 pureos kernel: [  827.527375] Restarting kernel threads
... done.
Aug  5 06:09:40 pureos kernel: [  827.527771] OOM killer enabled.
Aug  5 06:09:40 pureos kernel: [  827.527772] Restarting tasks ... done.
Aug  5 06:09:40 pureos kernel: [  827.528926] PM: suspend exit


do you know where things might go wrong here?

thanks,

                            martin

