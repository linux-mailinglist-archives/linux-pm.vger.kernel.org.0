Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D390D2B8C73
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgKSHiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 02:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSHiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 02:38:22 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5029FC0613D4
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 23:38:22 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so3627954pfg.8
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2020 23:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfSBkuFNN8lqF35HgNFGXb7/+prYzyUutqgkPAXlbnc=;
        b=bboK+Fy5/uK8dzSKEVIojFrQAKoJ7KnVrpceEKXgv7ez1vWPDCt4kqZN45DIlmDJTS
         3wHzBt4EUXz20/2dlViXp9NZQe/OE0/CvOmzketS88rZTdQUtrPb6fT1w8vEyCPtdT0v
         +w8kJCR2rMra7mUhEzYyf22vvEI9RKlhPKv5HiYmnLCsIiFEcOvti16/iWeRhNOO89/W
         ZFeG1nXlA8UmtP1McQOg0kdVwnBx01w6nmo3Ta8kHh3d9a0rZDUe6GA0V9I/S2GIDBGM
         alE7TKcubooDMMoBmkE5ruEqAWLiUFpJWY75Wq1Pb7IA52hyKVc2dcML/OpLqmzpP056
         ONLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfSBkuFNN8lqF35HgNFGXb7/+prYzyUutqgkPAXlbnc=;
        b=BNBfLqJkbjjfXiyKiz4gMnYQbJ+Ln7gdTYXsYzbtfDZG2Zpsn6TPh//Rfjpj2waeu6
         BrGjtgLaxGIeE46qKOqCrbMIG7YjkUgFitPbcz3zea1nQdKtTqFfUYb3zkL+ZfCgcZSu
         95j+DZ8bZ3XzY0C65F/expZ5hZ4q7cbnVDLSKFihINC2b7QPFGuQzMHRKt3zBzZIoxM6
         UWINbmGZg0dOBFiHu1WVbnI6On5R2HxqFEtc08o0GUZ3TOW1YtebQP7bqgkGxf9KJW2e
         BMaNd4MaWB16t8UDajKBUlIyE6yIr6ue1clD8ajsdarmB3EzeSJBl+kcc336X1omxKmI
         AOxA==
X-Gm-Message-State: AOAM531uMfjTlQzFIVrbt6PTLJpdX7MyAulPOYsVonSlBWy5ZBXMBsj0
        MdUikhhk0a6FCX+RNCt65H2d6g==
X-Google-Smtp-Source: ABdhPJzwmgoFjYS5VQ/Am04IjIBJMHMZGCqkqpWstAkuISdN9C9lFk3IlexRNbEYPo4TyZcPVhruaA==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr11522355pgc.319.1605771501681;
        Wed, 18 Nov 2020 23:38:21 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id m73sm13402907pfd.106.2020.11.18.23.38.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 23:38:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH V3 1/2] sched/core: Rename and move schedutil_cpu_util() to core.c
Date:   Thu, 19 Nov 2020 13:08:07 +0530
Message-Id: <a04646d277f1c93b248346db61c369cb8e7c2d02.1605770951.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1605770951.git.viresh.kumar@linaro.org>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is nothing schedutil specific in schedutil_cpu_util(), move it to
core.c and rename it to sched_cpu_util(), so it can be used from other
parts of the kernel as well.

The cpufreq_cooling stuff will make use of this in a later commit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched.h            |  21 ++++++
 kernel/sched/core.c              | 115 ++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 116 +------------------------------
 kernel/sched/fair.c              |   6 +-
 kernel/sched/sched.h             |  31 +--------
 5 files changed, 145 insertions(+), 144 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..926b944dae5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1926,6 +1926,27 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
+#ifdef CONFIG_SMP
+/**
+ * enum cpu_util_type - CPU utilization type
+ * @FREQUENCY_UTIL:	Utilization used to select frequency
+ * @ENERGY_UTIL:	Utilization used during energy calculation
+ *
+ * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
+ * need to be aggregated differently depending on the usage made of them. This
+ * enum is used within sched_cpu_util() to differentiate the types of
+ * utilization expected by the callers, and adjust the aggregation accordingly.
+ */
+enum cpu_util_type {
+	FREQUENCY_UTIL,
+	ENERGY_UTIL,
+};
+
+/* Returns effective CPU utilization, as seen by the scheduler */
+unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
+			     unsigned long max);
+#endif /* CONFIG_SMP */
+
 #ifdef CONFIG_RSEQ
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..845c976ccd53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5117,6 +5117,121 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+#ifdef CONFIG_SMP
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
+				 struct task_struct *p)
+{
+	unsigned long dl_util, util, irq;
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!uclamp_is_used() &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
+		return max;
+	}
+
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
+	irq = cpu_util_irq(rq);
+	if (unlikely(irq >= max))
+		return max;
+
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
+	 */
+	util = util_cfs + cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_rq_util_with(rq, util, p);
+
+	dl_util = cpu_util_dl(rq);
+
+	/*
+	 * For frequency selection we do not make cpu_util_dl() a permanent part
+	 * of this sum because we want to use cpu_bw_dl() later on, but we need
+	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
+	 * that we select f_max when there is no idle time.
+	 *
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
+	 */
+	if (util + dl_util >= max)
+		return max;
+
+	/*
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
+
+	/*
+	 * There is still idle time; further improve the number by using the
+	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
+	 *
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
+	 */
+	util = scale_irq_capacity(util, irq, max);
+	util += irq;
+
+	/*
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
+	 */
+	if (type == FREQUENCY_UTIL)
+		util += cpu_bw_dl(rq);
+
+	return min(max, util);
+}
+
+unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
+			     unsigned long max)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
+				  NULL);
+}
+#endif /* CONFIG_SMP */
+
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e254745a82cb..a6de75c8b984 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -169,122 +169,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the irq utilization.
- *
- * The DL bandwidth number otoh is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p)
-{
-	unsigned long dl_util, util, irq;
-	struct rq *rq = cpu_rq(cpu);
-
-	if (!uclamp_is_used() &&
-	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
-		return max;
-	}
-
-	/*
-	 * Early check to see if IRQ/steal time saturates the CPU, can be
-	 * because of inaccuracies in how we track these -- see
-	 * update_irq_load_avg().
-	 */
-	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= max))
-		return max;
-
-	/*
-	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
-	 * CFS tasks and we use the same metric to track the effective
-	 * utilization (PELT windows are synchronized) we can directly add them
-	 * to obtain the CPU's actual utilization.
-	 *
-	 * CFS and RT utilization can be boosted or capped, depending on
-	 * utilization clamp constraints requested by currently RUNNABLE
-	 * tasks.
-	 * When there are no CFS RUNNABLE tasks, clamps are released and
-	 * frequency will be gracefully reduced with the utilization decay.
-	 */
-	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
-
-	dl_util = cpu_util_dl(rq);
-
-	/*
-	 * For frequency selection we do not make cpu_util_dl() a permanent part
-	 * of this sum because we want to use cpu_bw_dl() later on, but we need
-	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
-	 * that we select f_max when there is no idle time.
-	 *
-	 * NOTE: numerical errors or stop class might cause us to not quite hit
-	 * saturation when we should -- something for later.
-	 */
-	if (util + dl_util >= max)
-		return max;
-
-	/*
-	 * OTOH, for energy computation we need the estimated running time, so
-	 * include util_dl and ignore dl_bw.
-	 */
-	if (type == ENERGY_UTIL)
-		util += dl_util;
-
-	/*
-	 * There is still idle time; further improve the number by using the
-	 * irq metric. Because IRQ/steal time is hidden from the task clock we
-	 * need to scale the task numbers:
-	 *
-	 *              max - irq
-	 *   U' = irq + --------- * U
-	 *                 max
-	 */
-	util = scale_irq_capacity(util, irq, max);
-	util += irq;
-
-	/*
-	 * Bandwidth required by DEADLINE must always be granted while, for
-	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
-	 * to gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
-	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
-	 * an interface. So, we only do the latter for now.
-	 */
-	if (type == FREQUENCY_UTIL)
-		util += cpu_bw_dl(rq);
-
-	return min(max, util);
-}
-
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util = cpu_util_cfs(rq);
-	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
-
-	sg_cpu->max = max;
-	sg_cpu->bw_dl = cpu_bw_dl(rq);
+	sg_cpu->max = arch_scale_cpu_capacity(sg_cpu->cpu);
+	sg_cpu->bw_dl = cpu_bw_dl(cpu_rq(sg_cpu->cpu));
 
-	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
+	return sched_cpu_util(sg_cpu->cpu, FREQUENCY_UTIL, sg_cpu->max);
 }
 
 /**
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e38378c..0e1c8eb7ad53 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6499,7 +6499,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
 					       ENERGY_UTIL, NULL);
 
 		/*
@@ -6509,7 +6509,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, cpu_util);
 	}
@@ -6607,7 +6607,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * IOW, placing the task there would make the CPU
 			 * overutilized. Take uclamp into account to see how
 			 * much capacity we can get out of the CPU; this is
-			 * aligned with schedutil_cpu_util().
+			 * aligned with sched_cpu_util().
 			 */
 			util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
 			if (!fits_capacity(util, cpu_cap))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..4fab3b930ace 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2484,27 +2484,9 @@ static inline unsigned long capacity_orig_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
-#endif
-
-/**
- * enum schedutil_type - CPU utilization type
- * @FREQUENCY_UTIL:	Utilization used to select frequency
- * @ENERGY_UTIL:	Utilization used during energy calculation
- *
- * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
- * need to be aggregated differently depending on the usage made of them. This
- * enum is used within schedutil_freq_util() to differentiate the types of
- * utilization expected by the callers, and adjust the aggregation accordingly.
- */
-enum schedutil_type {
-	FREQUENCY_UTIL,
-	ENERGY_UTIL,
-};
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
@@ -2533,14 +2515,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
-#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+#endif
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
-- 
2.25.0.rc1.19.g042ed3e048af

