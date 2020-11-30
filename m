Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3042C8602
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgK3N4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 08:56:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgK3N4D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 08:56:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0CDDD6E;
        Mon, 30 Nov 2020 05:55:17 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78D153F71F;
        Mon, 30 Nov 2020 05:55:15 -0800 (PST)
Subject: Re: [PATCH V4 2/3] sched/core: Rename schedutil_cpu_util() and allow
 rest of the kernel to use it
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org
References: <cover.1606198885.git.viresh.kumar@linaro.org>
 <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
 <20201124091019.GA1023091@google.com>
 <20201124132239.h3kjk6pdwqeoitvb@vireshk-mac-ubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d70ac48d-4efa-d084-60c7-cbbca6f2cf82@arm.com>
Date:   Mon, 30 Nov 2020 14:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201124132239.h3kjk6pdwqeoitvb@vireshk-mac-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/11/2020 14:22, Viresh Kumar wrote:
> On 24-11-20, 09:10, Quentin Perret wrote:
>> Hey Viresh,
>>
>> On Tuesday 24 Nov 2020 at 11:56:15 (+0530), Viresh Kumar wrote:
>>> There is nothing schedutil specific in schedutil_cpu_util(), rename it
>>> to effective_cpu_util(). Also create and expose another wrapper
>>> sched_cpu_util() which can be used by other parts of the kernel, like
>>> thermal core (that will be done in a later commit).
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  include/linux/sched.h            | 21 +++++++++++++++++++++
>>>  kernel/sched/core.c              | 11 +++++++++--
>>>  kernel/sched/cpufreq_schedutil.c |  2 +-
>>>  kernel/sched/fair.c              |  6 +++---
>>>  kernel/sched/sched.h             | 19 ++-----------------
>>>  5 files changed, 36 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index 063cd120b459..926b944dae5e 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -1926,6 +1926,27 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
>>>  #define TASK_SIZE_OF(tsk)	TASK_SIZE
>>>  #endif
>>>  
>>> +#ifdef CONFIG_SMP
>>> +/**
>>> + * enum cpu_util_type - CPU utilization type
>>> + * @FREQUENCY_UTIL:	Utilization used to select frequency
>>> + * @ENERGY_UTIL:	Utilization used during energy calculation
>>> + *
>>> + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
>>> + * need to be aggregated differently depending on the usage made of them. This
>>> + * enum is used within sched_cpu_util() to differentiate the types of
>>> + * utilization expected by the callers, and adjust the aggregation accordingly.
>>> + */
>>> +enum cpu_util_type {
>>> +	FREQUENCY_UTIL,
>>> +	ENERGY_UTIL,
>>> +};
>>> +
>>> +/* Returns effective CPU utilization, as seen by the scheduler */
>>> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
>>> +			     unsigned long max);
>>
>> Are 'type' and 'max' useful to anybody outside of kernel/sched ?
>> If not then how about we hide them, keep the cpu_util_type enum in
>> kernel/sched/sched.h and evaluate arch_scale_cpu_capacity() in
>> sched_cpu_util() directly?
> 
> cpufreq_cooling uses 'max' (as can be seen in the next patch).

But the enum cpu_util_type type doesn't have to be exported outside the
task scheduler code?

--8<--

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 5aff2ac4b77f..cd9d717654a8 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -149,7 +149,7 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long util;
 
-	util = sched_cpu_util(cpu, ENERGY_UTIL, max);
+	util = sched_cpu_util(cpu, max);
 	return (util * 100) / max;
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fcd70c075349..0511e4fb946f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1954,24 +1954,8 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #endif
 
 #ifdef CONFIG_SMP
-/**
- * enum cpu_util_type - CPU utilization type
- * @FREQUENCY_UTIL:	Utilization used to select frequency
- * @ENERGY_UTIL:	Utilization used during energy calculation
- *
- * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
- * need to be aggregated differently depending on the usage made of them. This
- * enum is used within sched_cpu_util() to differentiate the types of
- * utilization expected by the callers, and adjust the aggregation accordingly.
- */
-enum cpu_util_type {
-	FREQUENCY_UTIL,
-	ENERGY_UTIL,
-};
-
 /* Returns effective CPU utilization, as seen by the scheduler */
-unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
-			     unsigned long max);
+unsigned long sched_cpu_util(int cpu, unsigned long max);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f20dacc2fa7..270f10e01ad2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5757,11 +5757,10 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	return min(max, util);
 }
 
-unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
-			     unsigned long max)
+unsigned long sched_cpu_util(int cpu, unsigned long max)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
-				  NULL);
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max,
+				  ENERGY_UTIL, NULL);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b7611020d5cf..a49d6c3e9147 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2561,6 +2561,21 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
+/**
+ * enum cpu_util_type - CPU utilization type
+ * @FREQUENCY_UTIL:     Utilization used to select frequency
+ * @ENERGY_UTIL:        Utilization used during energy calculation
+ *
+ * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
+ * need to be aggregated differently depending on the usage made of them. This
+ * enum is used within sched_cpu_util() to differentiate the types of
+ * utilization expected by the callers, and adjust the aggregation accordingly.
+ */
+enum cpu_util_type {
+        FREQUENCY_UTIL,
+        ENERGY_UTIL,
+};
+
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p);
-- 
2.17.1

 
