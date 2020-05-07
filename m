Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F91C98FE
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEGSK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728018AbgEGSK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:27 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A789C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:27 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dh14so6701033qvb.4
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qIuiAOvvRT8hmO6u7skiN+kIu86pFv2tJYmMai5+A9I=;
        b=XuO5bWe/BdA9l8ICcwd67xeqYKBHuj6SfFycygxA/YEJknsrtug6jcdtc5+o1CCB9T
         rnA7cboTm2jAjJkzYYiExhoFetKoql74YWzUDlNsCtoeU3Is/cIZ/Go05k2FQQGWhxG2
         Tt/faoI7naq/erLMMyeByH2p22ZehudEVpQ61WHKaBoqHPXK6yn/GLHcncTLg7Nj54BQ
         AOjCgFi4Jprkdo8rl6ugwMMT8rcNH9Q6f1Ln7CnUXggC1Mx+PaGe9UHRS4yQTvTcmaHt
         PIV9Ks9HFOh4m82LgKue+7FeXVjaI6RprpGkOK58OsbWUgEHcKtD7hGbBlDmbxLBvH8A
         g3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qIuiAOvvRT8hmO6u7skiN+kIu86pFv2tJYmMai5+A9I=;
        b=OKxsjHw0/7C1bumvBIzfM4d6IJHDYPpemIpS5GQIBqQCnD3RD6sF+mLib++QWqjnVr
         Hv8ROd0Y+6RFqTh+9wQoKAy4Q/Sw9KN4SoSSRIg/4VuYQFP5CxjcDT9eaF/8bX7uiOqj
         oeKAL4Qq80lq3eprCm1Q+o/25BRlzNQ60HyLjLWaZfBlTBxvfDEAYSJUuvwhqvTvpMpa
         IalpI16kKJwh9TAjqWOJQtzZgAwzxdlz1QGR5cHhcLnlAAb9ujyg5S9pDgG6mfPrbtZj
         lzUguOgMRgYlTpmXsc5rVMFsjyiZwus3gchDP0pcCBtrEDfp8wX8GgMJXtwo/JAC0cB+
         pGqA==
X-Gm-Message-State: AGi0PuaIHkMlbar2pACY6Mwo/cefOJlv7yIl1tg6Ee46gPNusZYXw2/J
        1NSQZRjlOhgqiACYYjbpkw/CaxHsgT7v
X-Google-Smtp-Source: APiQypIxeHB9B0PYPAzgCNlcFIYWdxDklpWlEPAZH+JGUvjzSqRKkgNbLdi3igaAuz0DTY1KWmcvioAv2CsG
X-Received: by 2002:ad4:42c7:: with SMTP id f7mr15134043qvr.127.1588875026168;
 Thu, 07 May 2020 11:10:26 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:03 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-6-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 05/14] sched: cpufreq: Move schedutil_cpu_util()
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPU util aggregation code for schedutil and EAS currently resides in
schedutil for historical reasons. However, this complicates modularizing
schedutil as that would make the core kernel call into a (potential)
module. While this could probably be done, it seems significantly
simpler to move that function in fair.c directly, as it has no strong
dependencies on schedutil anyway. And as an added benefit, that also
enables that function to be marked as static, hence giving the compiler
a chance to remove a few function calls from the wake-up path.

While at it, rename the function to reflect the fact that it is not
actually schedutil-specific, and remove the now unnecessary
cpu_util_cfs().

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 109 +---------------------------
 kernel/sched/fair.c              | 118 ++++++++++++++++++++++++++++++-
 kernel/sched/sched.h             |  32 ++-------
 3 files changed, 120 insertions(+), 139 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 33e67c48f668..aeb04cc5b740 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -183,122 +183,15 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
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
-	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
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
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util = cpu_util_cfs(rq);
 	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
+	return cpu_util_freq(sg_cpu->cpu, max);
 }
 
 /**
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..dadf0a060abe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6377,6 +6377,118 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
 
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
+static unsigned long aggregate_cpu_util(int cpu, unsigned long util_cfs,
+					unsigned long max,
+					enum cpu_util_type type,
+					struct task_struct *p)
+{
+	unsigned long dl_util, util, irq;
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
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
+unsigned long cpu_util_freq(int cpu, unsigned long max)
+{
+	return aggregate_cpu_util(cpu, cpu_util(cpu), max, FREQUENCY_UTIL, NULL);
+}
+
 /*
  * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
  * to @dst_cpu.
@@ -6449,7 +6561,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		sum_util += aggregate_cpu_util(cpu, util_cfs, cpu_cap,
 					       ENERGY_UTIL, NULL);
 
 		/*
@@ -6459,7 +6571,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		cpu_util = aggregate_cpu_util(cpu, util_cfs, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, cpu_util);
 	}
@@ -6556,7 +6668,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * IOW, placing the task there would make the CPU
 			 * overutilized. Take uclamp into account to see how
 			 * much capacity we can get out of the CPU; this is
-			 * aligned with schedutil_cpu_util().
+			 * aligned with aggregate_cpu_util().
 			 */
 			util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
 			if (!fits_capacity(util, cpu_cap))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..60592cde80e8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2397,10 +2397,9 @@ static inline unsigned long capacity_orig_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
-#endif
 
 /**
- * enum schedutil_type - CPU utilization type
+ * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
  * @ENERGY_UTIL:	Utilization used during energy calculation
  *
@@ -2409,16 +2408,12 @@ static inline unsigned long capacity_orig_of(int cpu)
  * enum is used within schedutil_freq_util() to differentiate the types of
  * utilization expected by the callers, and adjust the aggregation accordingly.
  */
-enum schedutil_type {
+enum cpu_util_type {
 	FREQUENCY_UTIL,
 	ENERGY_UTIL,
 };
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p);
+unsigned long cpu_util_freq(int cpu, unsigned long max);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
@@ -2430,30 +2425,11 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
-static inline unsigned long cpu_util_cfs(struct rq *rq)
-{
-	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
-
-	if (sched_feat(UTIL_EST)) {
-		util = max_t(unsigned long, util,
-			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
-	}
-
-	return util;
-}
-
 static inline unsigned long cpu_util_rt(struct rq *rq)
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
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
-- 
2.26.2.526.g744177e7f7-goog

