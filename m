Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5495E2C1E2E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgKXG0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 01:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgKXG0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 01:26:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D1C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 22:26:29 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id n137so7437376pfd.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 22:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNtM0MaukWKLeykgjeC5xsgWS0X78S8oFPhzD7Rh5OM=;
        b=qpwXt+1QC2Ho8ePpan7K4yqGgIkQru3q8ErF9OyRl0suCRvMvfeUYF328TZ/vm5BCk
         fSmpv7eYRnbriUuEcqBUjn1WnbjO2P+6jUxSAuNnQZl6613pBpS1uH+Y5gjrwI0Wqy/n
         s5JtLRBe9AyyqYSyfjOXx4/ECnJxovAzq37weRR+wNo903yxXgnkc9QZ2PLaeG0R/4jJ
         dRM0bh+t31PJ5L6nAd95QDs1pQAtsx0b0Aa5umx5cPYQOlj13KCY80l5LqjRi1eZU/1D
         6uOKCuN6PoPgnAIVQO9WKcLM3kNz1JxSPp/BQ5v8NiljQVP8xdXqqv1nBRchIU4s2SzB
         xYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNtM0MaukWKLeykgjeC5xsgWS0X78S8oFPhzD7Rh5OM=;
        b=i2G+HpyCsyk+StbCYGvqJAQAKCZx1s6VHyxlyilHlrkgKV5NpHFLqS9MT+y+BGIWqE
         z0azSFrnUk7DJhOYgehK4QmAIOOZiV+XQ7L1YcxOBz3vfPKgeFNt5IQjrtoqHoK9FoCq
         +4lw0FXCCXCgBfsORIIAe8JGIIdfnGwtCBkVx8sbaJ8w6FF91DPj8AvzCjid6/BJIpzc
         SA/LJDitrIexfFk5si8VCF3dtA9KopYL5QGIE0X0sn2YvDfkAvv3c6yfaUL5TAHrANjR
         9shXbUMktlg2TNi0GvcDWXl4qON8zkdGG5f1CuvG9kL/V2F1Zp7YR2e84qc/FcJnPK0G
         Xf0A==
X-Gm-Message-State: AOAM530MUGuF01KzHbcZdPFgkcLKJQwgI8Rpl+wl3YL9PYT+dIsJQjyt
        BFcVGVSxc+go0Uu6uf9MnJojzg==
X-Google-Smtp-Source: ABdhPJzxEMJBDlqj1uKonCyHqzmzsERUHPiWJRd6zF6oFF3FAP4i+7nkx5S0IncDxh5VEQQQjl9gqA==
X-Received: by 2002:a17:90a:ead2:: with SMTP id ev18mr3088956pjb.91.1606199189204;
        Mon, 23 Nov 2020 22:26:29 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s26sm12632501pgv.93.2020.11.23.22.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 22:26:28 -0800 (PST)
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
Subject: [PATCH V4 2/3] sched/core: Rename schedutil_cpu_util() and allow rest of the kernel to use it
Date:   Tue, 24 Nov 2020 11:56:15 +0530
Message-Id: <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1606198885.git.viresh.kumar@linaro.org>
References: <cover.1606198885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is nothing schedutil specific in schedutil_cpu_util(), rename it
to effective_cpu_util(). Also create and expose another wrapper
sched_cpu_util() which can be used by other parts of the kernel, like
thermal core (that will be done in a later commit).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched.h            | 21 +++++++++++++++++++++
 kernel/sched/core.c              | 11 +++++++++--
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              |  6 +++---
 kernel/sched/sched.h             | 19 ++-----------------
 5 files changed, 36 insertions(+), 23 deletions(-)

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
index b81265aec4a0..845c976ccd53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5138,8 +5138,8 @@ struct task_struct *idle_task(int cpu)
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p)
 {
 	unsigned long dl_util, util, irq;
@@ -5223,6 +5223,13 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 
 	return min(max, util);
 }
+
+unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
+			     unsigned long max)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
+				  NULL);
+}
 #endif /* CONFIG_SMP */
 
 /**
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2d44befb322b..e71627a3792b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,7 +178,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
+	return effective_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
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
index 0db6bcf0881f..4fab3b930ace 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2485,23 +2485,8 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
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
-
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
-- 
2.25.0.rc1.19.g042ed3e048af

