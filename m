Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE52C1E31
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 07:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgKXG0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 01:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgKXG0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 01:26:33 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A2C0613D6
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 22:26:32 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so16469755pga.7
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 22:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRaCrzFnuBpNc0a8QYnZlNCHJIyccTR5VAFFQy4r+BA=;
        b=paWhjZUZnQ//0RZ/Caj8oKtcsdvN5eIZPQez+Xc/Po08oMl4Eab6HG2BWNifzqfZO/
         FUxrQIFFxgssEtx6W25Q0tlx2Q1agRj1h39l5UXJGlr5L5aFhOb7BGRNYmLgTC5zL3xS
         H2VmrsPwIuTFowdWcyE0MfZL0EhtugL7CIqtA0EPkTSiW/UYKcNnQGubSepgFahKxZsP
         mfX4IOCU15kOkActBH2h/gNn0fRljJXBH9arVTconYLtogCQ/T0WrWdj0NRFZ4RBtlbY
         4KK90GU3Zod3LDtsRVzMI6NI5c8OehqH1kotAiu6u4l8uQTSWUFJFrv3FQBwYC0QGpUR
         L0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRaCrzFnuBpNc0a8QYnZlNCHJIyccTR5VAFFQy4r+BA=;
        b=Z012IC74hpUL1qr/Jg/3WQWEHCpnQPHGFL6Nr9GIJo+ptTw8jEoJrjS2IUdeG1a3qS
         snBrLYtZciFS5iCf4fo4X5D4WPij8qEJOQtL/hFwir93l1KYRdLaZ8cIfSeUd/KtWJ2F
         GCEqZGj87iwsx+1Pz21RyrJJd/RnizkW2Y2UxfPU3al0f/UZHcOO1+OqNwLln5i3HpXK
         1VqDdW1XWk24gXZ0Sj+o6cMaJiLSxaYJZUfw+pOHse4SjQE+DJ4WXdrEQ328JeFtTs58
         +ovpbDz1MmxNYwdVo2cjmq6Rvp7SdAZiBLJ4xJD8criuOPt6RKBWrUkgxcXQk21dpJeJ
         8hYg==
X-Gm-Message-State: AOAM530Wwz13LcBVJjc22kUI2eyqjuZd8maE0c1iXTIaLHTRdEcyAH55
        79MsNK3fPbl5WlDum0rVLFIKxQ==
X-Google-Smtp-Source: ABdhPJx3qH9sIiGjY8FHdbq9ek8+gv2OTxIu2Bg16+qa/PvTSsFYKDXilnSVHpo9V4PRw5mgb30P4w==
X-Received: by 2002:a17:90a:4dc3:: with SMTP id r3mr3102982pjl.155.1606199192433;
        Mon, 23 Nov 2020 22:26:32 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s189sm13501865pfb.60.2020.11.23.22.26.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 22:26:31 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH V4 3/3] thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms
Date:   Tue, 24 Nov 2020 11:56:16 +0530
Message-Id: <c0d7c796be7df6ac0102d8c2701fc6b541d2ff7d.1606198885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1606198885.git.viresh.kumar@linaro.org>
References: <cover.1606198885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Several parts of the kernel are already using the effective CPU
utilization (as seen by the scheduler) to get the current load on the
CPU, do the same here instead of depending on the idle time of the CPU,
which isn't that accurate comparatively.

This is also the right thing to do as it makes the cpufreq governor
(schedutil) align better with the cpufreq_cooling driver, as the power
requested by cpufreq_cooling governor will exactly match the next
frequency requested by the schedutil governor since they are both using
the same metric to calculate load.

This was tested on ARM Hikey6220 platform with hackbench, sysbench and
schbench. None of them showed any regression or significant
improvements. Schbench is the most important ones out of these as it
creates the scenario where the utilization numbers provide a better
estimate of the future.

Scenario 1: The CPUs were mostly idle in the previous polling window of
the IPA governor as the tasks were sleeping and here are the details
from traces (load is in %):

 Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=203 load={{0x35,0x1,0x0,0x31,0x0,0x0,0x64,0x0}} dynamic_power=1339
 New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=600 load={{0x60,0x46,0x45,0x45,0x48,0x3b,0x61,0x44}} dynamic_power=3960

Here, the "Old" line gives the load and requested_power (dynamic_power
here) numbers calculated using the idle time based implementation, while
"New" is based on the CPU utilization from scheduler.

As can be clearly seen, the load and requested_power numbers are simply
incorrect in the idle time based approach and the numbers collected from
CPU's utilization are much closer to the reality.

Scenario 2: The CPUs were busy in the previous polling window of the IPA
governor:

 Old: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=800 load={{0x64,0x64,0x64,0x64,0x64,0x64,0x64,0x64}} dynamic_power=5280
 New: thermal_power_cpu_get_power: cpus=00000000,000000ff freq=1200000 total_load=708 load={{0x4d,0x5c,0x5c,0x5b,0x5c,0x5c,0x51,0x5b}} dynamic_power=4672

As can be seen, the idle time based load is 100% for all the CPUs as it
took only the last window into account, but in reality the CPUs aren't
that loaded as shown by the utilization numbers.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 68 ++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index cc2959f22f01..5aff2ac4b77f 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -76,7 +76,9 @@ struct cpufreq_cooling_device {
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
 	struct list_head node;
+#ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
+#endif
 	struct freq_qos_request qos_req;
 };
 
@@ -132,14 +134,35 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
- * get_load() - get load for a cpu since last updated
- * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
- * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in time_in_idle*
+ * get_load() - get load for a cpu
+ * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
+ * @cpu: cpu number
+ * @cpu_idx: index of the cpu in time_in_idle array
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
  */
+#ifdef CONFIG_SMP
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
+		    int cpu_idx)
+{
+	unsigned long max = arch_scale_cpu_capacity(cpu);
+	unsigned long util;
+
+	util = sched_cpu_util(cpu, ENERGY_UTIL, max);
+	return (util * 100) / max;
+}
+
+static inline int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	return 0;
+}
+
+static inline void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+}
+
+#else /* !CONFIG_SMP */
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 		    int cpu_idx)
 {
@@ -162,6 +185,26 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 	return load;
 }
 
+static int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	unsigned int num_cpus = cpumask_weight(cpufreq_cdev->policy->related_cpus);
+
+	cpufreq_cdev->idle_time = kcalloc(num_cpus,
+					  sizeof(*cpufreq_cdev->idle_time),
+					  GFP_KERNEL);
+	if (!cpufreq_cdev->idle_time)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	kfree(cpufreq_cdev->idle_time);
+	cpufreq_cdev->idle_time = NULL;
+}
+#endif /* CONFIG_SMP */
+
 /**
  * get_dynamic_power() - calculate the dynamic power
  * @cpufreq_cdev:	&cpufreq_cooling_device for this cdev
@@ -487,7 +530,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
-	unsigned int i, num_cpus;
+	unsigned int i;
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
@@ -498,7 +541,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 	}
 
-
 	if (IS_ERR_OR_NULL(policy)) {
 		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
 		return ERR_PTR(-EINVAL);
@@ -516,12 +558,10 @@ __cpufreq_cooling_register(struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 
 	cpufreq_cdev->policy = policy;
-	num_cpus = cpumask_weight(policy->related_cpus);
-	cpufreq_cdev->idle_time = kcalloc(num_cpus,
-					 sizeof(*cpufreq_cdev->idle_time),
-					 GFP_KERNEL);
-	if (!cpufreq_cdev->idle_time) {
-		cdev = ERR_PTR(-ENOMEM);
+
+	ret = allocate_idle_time(cpufreq_cdev);
+	if (ret) {
+		cdev = ERR_PTR(ret);
 		goto free_cdev;
 	}
 
@@ -581,7 +621,7 @@ __cpufreq_cooling_register(struct device_node *np,
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_idle_time:
-	kfree(cpufreq_cdev->idle_time);
+	free_idle_time(cpufreq_cdev);
 free_cdev:
 	kfree(cpufreq_cdev);
 	return cdev;
@@ -674,7 +714,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-	kfree(cpufreq_cdev->idle_time);
+	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.25.0.rc1.19.g042ed3e048af

