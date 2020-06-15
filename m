Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC01F8D9E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFOGS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 02:18:27 -0400
Received: from cmta19.telus.net ([209.171.16.92]:51363 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgFOGS1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jun 2020 02:18:27 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id kiRkjsNrPFblkkiRljwT67; Mon, 15 Jun 2020 00:18:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1592201902; bh=zQNMuPsT4ll3hJNXvuLTaoTVr+UglTzfCusuV7uVOtg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=rWstHuc4y3Ll7953LhvHxQUGpnq/MVtm9fE0768bWFtTY6zufmJ6yipsvwdJAaYrT
         IgBeUrOj9ZLEcJPEJNADz3BsTOVTtpdjMmA8rBOhVQ36H6t/t0TERC3Te3+AtGfgkD
         c0jcPcOAAqA4pqjzBZfCQwba3yycFc26s9XHUMAhOXfs0D4JuIYzPFtKJoGfbwqio7
         4tPNCXO1GCF32a0Shst6p+BR8m8HzvBncRvDNbcb4lGJnrFi9vspjY7Nr3fF42Ea4b
         7I7DMj0j7zbkEf8XlD0uiEWvLmOOkMicM8JEoE7C7HMF8t0+td6nIfAyOx5tnVNEAA
         pFq8KOZKB5K8A==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=BNTNU2YG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=gu6fZOg2AAAA:8 a=kYCofrKXt4MtsqnNrjUA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>
References: <3169564.ZRsPWhXyMD@kreacher>
In-Reply-To: <3169564.ZRsPWhXyMD@kreacher>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
Date:   Sun, 14 Jun 2020 23:18:16 -0700
Message-ID: <002801d642dc$c5225c10$4f671430$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdYvk3X5bnwqpX6hRwi7ciAthJfS0AR9+G4g
Content-Language: en-ca
X-CMAE-Envelope: MS4wfARU7e+z96JZosIKQHWrD1iLi45BoxdoG1MOAfXLxuHU6kbdsVkrwpUCxYTMUaVJK5hsiRoxeR8QTkEF7IxyYC9gS4tftUQXe6HwRT1eSYwrLvYGL5cc
 r/hPUHLRyByrgIHY0m/UQHd7hu9ocqLSt3Rt94yk/zQSf71u3hd2QRgAk2cGeMZvZUh7gS86JS6UIDIyKJtg7OBpXX6Xsbfk714mcvYFOLP6p6jVEkkfHDQM
 wy8PhjfGvrDyPLHWkJiT5/iPLqTKTEfvAk+oWibP1RFlY0HpUUN9pcWU24+I6N80/CuUfaGE7YdvMs39kmGosf9y3gU1Fu1WMG+K8z4BWdHw0RuHQpAJOP01
 5w2dps6Ht5rRjuH3GMs0V6RX0V2jr0lCM8fjegbVX34fvO4Kof//Q3VcdRY71RF3dMx1YaWO
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.05.21 10:16 Rafael J. Wysocki wrote:
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Allow intel_pstate to work in the passive mode with HWP enabled and
> make it translate the target frequency supplied by the cpufreq
> governor in use into an EPP value to be written to the HWP request
> MSR (high frequencies are mapped to low EPP values that mean more
> performance-oriented HWP operation) as a hint for the HWP algorithm
> in the processor, so as to prevent it and the CPU scheduler from
> working against each other at least when the schedutil governor is
> in use.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a prototype not intended for production use (based on linux-next).
> 
> Please test it if you can (on HWP systems, of course) and let me know the
> results.
> 
> The INTEL_CPUFREQ_TRANSITION_DELAY_HWP value has been guessed and it very well
> may turn out to be either too high or too low for the general use, which is one
> reason why getting as much testing coverage as possible is key here.
> 
> If you can play with different INTEL_CPUFREQ_TRANSITION_DELAY_HWP values,
> please do so and let me know the conclusions.
> 
> Cheers,
> Rafael

To anyone trying this patch:

You will need to monitor EPP (Energy Performance Preference) carefully.
It changes as a function of passive/active, and if you booted active
or passive or no-hwp and changed later.

Originally, I was not specifically monitoring EPP, or paths taken since boot
towards driver, intel_pstate or intel_cpufreq, and governor, and will now have
to set aside test results.

@Rafael: I am still having problems with my test computer and HWP. However, I can
observe the energy saving potential of this "passive-yet-active HWP mode".

At this point, I am actually trying to make my newer test computer
simply behave and do what it is told with respect to CPU frequency scaling,
because even acpi-cpufreq misbehaves for performance governor under
some conditions [1].

[1] https://marc.info/?l=linux-pm&m=159155067328641&w=2

To my way of thinking:

1.) it is imperative that we be able to decouple the governor servo
from the processor servo. At a minimum this is needed for system testing,
debugging and reference baselines. At a maximum users could, perhaps, decide
for themselves. Myself, I would prefer "passive" to mean "do what you
have been told", and that is now what I am testing.

2.) I have always thought, indeed relied on, performance mode as being
more than a hint. For my older i7-2600K it never disobeyed orders, except
for the most minuscule of workloads.
This newer i5-9600K seems to have a mind of its own which I would like
to be able to turn off, yet still be able to use intel_pstate trace
with schedutil.

Recall last week I said

> moving forward the typical CPU frequency scaling
> configuration for my test system will be:
>
> driver: intel-cpufreq, forced at boot.
> governor: schedutil
> hwp: forced off at boot.

The problem is that baseline references are still needed
and performance mode is unreliable. Maybe other stuff also,
I simply don't know at this point.

Example of EPP changing (no need to read on) (from fresh boot):

Current EPP:

root@s18:/home/doug# rdmsr --bitfield 31:24 -u -a 0x774
128
128
128
128
128
128
root@s18:/home/doug# grep . /sys/devices/system/cpu/cpu3/cpufreq/*
/sys/devices/system/cpu/cpu3/cpufreq/affected_cpus:3
/sys/devices/system/cpu/cpu3/cpufreq/base_frequency:3700000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_min_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu3/cpufreq/energy_performance_available_preferences:default performance balance_performance balance_power
power
/sys/devices/system/cpu/cpu3/cpufreq/energy_performance_preference:balance_performance
/sys/devices/system/cpu/cpu3/cpufreq/related_cpus:3
/sys/devices/system/cpu/cpu3/cpufreq/scaling_available_governors:performance powersave
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:800102
/sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:intel_pstate
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:powersave
/sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:4600000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_setspeed:<unsupported>

Now, switch to passive mode:

echo passive > /sys/devices/system/cpu/intel_pstate/status

And observe EPP:

root@s18:/home/doug# rdmsr --bitfield 31:24 -u -a 0x774
255
255
255
255
255
255
root@s18:/home/doug# grep . /sys/devices/system/cpu/cpu3/cpufreq/*
/sys/devices/system/cpu/cpu3/cpufreq/affected_cpus:3
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:4600000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_min_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_transition_latency:20000
/sys/devices/system/cpu/cpu3/cpufreq/related_cpus:3
/sys/devices/system/cpu/cpu3/cpufreq/scaling_available_governors:conservative ondemand userspace powersave performance schedutil

Hey, where did the ability to adjust the energy_performance_preference setting go?

/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:3400313
/sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:performance
/sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:4600000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_setspeed:<unsupported>

Kernel is 5.7 +plus this patch:

root@s18:/home/doug# uname -a
Linux s18 5.7.0-hwp10 #786 SMP PREEMPT Tue Jun 9 20:15:18 PDT 2020 x86_64 x86_64 x86_64 GNU/Linux

223e5c33f927 (HEAD -> k57-doug-hwp) cpufreq: intel_pstate: Accept passive mode with HWP enabled
5d890a14763d cpufreq: intel_pstate: Use passive mode by default without HWP
3d77e6a8804a (tag: v5.7) Linux 5.7

The below is on top of this patch, and is how I am attempting to move forward:

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4ab8bc1476c9..6c28ec49b192 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2331,33 +2331,32 @@ static void intel_cpufreq_update_hwp_request(struct cpudata *cpu, u32 min_perf)
        value |= HWP_MIN_PERF(min_perf);

        /*
-        * The entire MSR needs to be updated in order to update the HWP min
-        * field in it, so opportunistically update the max too if needed.
+        * the max also...
         */
        value &= ~HWP_MAX_PERF(~0L);
-       value |= HWP_MAX_PERF(cpu->max_perf_ratio);
+       value |= HWP_MAX_PERF(min_perf);

        if (value != prev)
                wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 }

 /**
- * intel_cpufreq_adjust_hwp - Adjust the HWP reuqest register.
+ * intel_cpufreq_adjust_hwp - Adjust the HWP request register.
  * @cpu: Target CPU.
  * @target_pstate: P-state corresponding to the target frequency.
  *
- * Set the HWP minimum performance limit to 75% of @target_pstate taking the
+ * Set the HWP minimum performance limit to @target_pstate taking the
  * global min and max policy limits into account.
  *
- * The purpose of this is to avoid situations in which the kernel and the HWP
- * algorithm work against each other by giving a hint about the expectations of
- * the former to the latter.
+ * The purpose of this is to force the slave (passive) servo to do what
+ * it has been told, not what ever it wants.
+ * This NOT a hint. EPP (responsiveness) is managed from elsewhere.
  */
 static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pstate)
 {
        u32 min_perf;

-       min_perf = max_t(u32, (3 * target_pstate) / 4, cpu->min_perf_ratio);
+       min_perf = max_t(u32, target_pstate, cpu->min_perf_ratio);
        min_perf = min_t(u32, min_perf, cpu->max_perf_ratio);
        if (min_perf != cpu->pstate.current_pstate) {
                cpu->pstate.current_pstate = min_perf;

... Doug

... [deleted] ...


