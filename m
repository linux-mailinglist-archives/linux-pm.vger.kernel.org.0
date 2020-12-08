Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EB32D21EF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 05:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgLHESY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 23:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgLHESY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 23:18:24 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14EC0617A6
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 20:17:10 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so757879plq.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 20:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgroMCzBx2iJ+H86ym6L2CJTtyoziwkrOuTzWQtpDQI=;
        b=uQtBmECumfix2CVr91vbg+9llcJiypEeUz0345IueFtDzmXZlPAjtJyohrI28xhdRP
         jRrbaOGvoUJY7kqpFCK3qB+vjR5NxuMl9GocAKXYLkVTtsr0bnewBp31OGYx/DpxvV24
         NX9Y26SZAanZhM4fSLvXgyhslSULTS+xX0YktbEWQV3MwOx5h+NI1H+PgrNKOZhYJAFL
         hK2/U/2UVpZ3Wd5Bf3OW8/E/jSVRf98I+1nsusXozTrJ0P3evMaU10teFpxOeOe9tGuS
         N9FTQVfI2x/wOK6XO9Zk6x1X7FTj9cU3+nrQrQwFlcDPdMvSd7gW5SmCffbVFf1Kx1tJ
         jaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgroMCzBx2iJ+H86ym6L2CJTtyoziwkrOuTzWQtpDQI=;
        b=lTsvBgqT/z9xpqIajtbvGUaV4/CNqgQcqCbiH3Na1PEC+HbEP6glFBoqtJ7hN3PcZ1
         j034Rgpg+WPuva+Okm9iMbs9XMSj03cSCWzk7wYl43XgYijiOmIeM4WXWT6iyVq1us27
         2KiKC8FNsHhXCE99CpoFgG888D8SpgR1OkGIhHuCRXRTEiVco/Oy60F1/T7xA/DHvb+V
         B1oSFL2WTft0Y5DHMhy200LhLdPZrxy7hlWJr+VG2DjvkVVIFAsCH+DiCxZyYwcFe//O
         bbUjG/Z+0UVOCSeWLFoWlGQgCeY/tegULlPk8KHmVU9uHWK2XqS0Ye8DG41lEr4YAhu0
         XEIg==
X-Gm-Message-State: AOAM530BVW6tltNXWCALN3R/qqvC/8RtTwm/fiSrENniFMitoMzQPnU1
        c/yeu/VmO2hC2oTbzH5wznDPbg==
X-Google-Smtp-Source: ABdhPJztWek+D5By5JgNfsJ88G4y/ZLdUOrZwStsy5peQSV92dXoY44EukbPq0bXvxoFqKTLvJGDBw==
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id m18-20020a170902bb92b02900d9e9bfb775mr19582388pls.24.1607401030082;
        Mon, 07 Dec 2020 20:17:10 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id x128sm16035595pfx.52.2020.12.07.20.17.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:17:09 -0800 (PST)
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
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH V5 2/3] sched/core: Rename schedutil_cpu_util() and allow rest of the kernel to use it
Date:   Tue,  8 Dec 2020 09:46:56 +0530
Message-Id: <db011961fb3bb8bef1c0eda5cd64564637d3ef31.1607400596.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1607400596.git.viresh.kumar@linaro.org>
References: <cover.1607400596.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is nothing schedutil specific in schedutil_cpu_util(), rename it
to effective_cpu_util(). Also create and expose another wrapper
sched_cpu_util() which can be used by other parts of the kernel, like
thermal core (that will be done in a later commit).

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched.h            |  5 +++++
 kernel/sched/core.c              | 10 ++++++++--
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              |  6 +++---
 kernel/sched/sched.h             | 10 +++++-----
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 063cd120b459..3a2fe4fe6155 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1926,6 +1926,11 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
+#ifdef CONFIG_SMP
+/* Returns effective CPU energy utilization, as seen by the scheduler */
+unsigned long sched_cpu_util(int cpu, unsigned long max);
+#endif /* CONFIG_SMP */
+
 #ifdef CONFIG_RSEQ
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b81265aec4a0..0a24b93dd7f3 100644
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
@@ -5223,6 +5223,12 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 
 	return min(max, util);
 }
+
+unsigned long sched_cpu_util(int cpu, unsigned long max)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max,
+				  ENERGY_UTIL, NULL);
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
index 0db6bcf0881f..495e7ea278ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2486,22 +2486,22 @@ static inline unsigned long capacity_orig_of(int cpu)
 }
 
 /**
- * enum schedutil_type - CPU utilization type
+ * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
  * @ENERGY_UTIL:	Utilization used during energy calculation
  *
  * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
  * need to be aggregated differently depending on the usage made of them. This
- * enum is used within schedutil_freq_util() to differentiate the types of
+ * enum is used within effective_cpu_util() to differentiate the types of
  * utilization expected by the callers, and adjust the aggregation accordingly.
  */
-enum schedutil_type {
+enum cpu_util_type {
 	FREQUENCY_UTIL,
 	ENERGY_UTIL,
 };
 
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
-- 
2.25.0.rc1.19.g042ed3e048af

