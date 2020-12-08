Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451AF2D21EE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 05:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLHESY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 23:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgLHESY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 23:18:24 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC2C0617A7
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 20:17:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 11so6405742pfu.4
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 20:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HS1iJkm0hv8Ke2csA68ZLm2xcERjTLMbURsBR9ZOsB4=;
        b=qX8hLtO9+Pw8qEOWiWZoSgX/K+1uf38NjGAhipQoXgrGUrkt4De+MR5KgTa2Zz/T18
         Km9nrQPYzrsy+RKyjVeuCKznbAqpjaTg520f8diuzJZO17WY/g4lbHdbJgcLWMPebRoo
         IER9UcGkZXBz/gvfORKEuB6lc0j3vYooS0rCVi8tpQDsd6QKpt+O2X7WDoZrOtxiDjzh
         VMu8ECkUrg26j8n3UF3ROb1fJij8Y4qt5P1vj+OSMTR0BAOzq0/zFCPumP8vgaUELfNU
         v/HJvXorvVx0mm5yeLaQXU3MvAZzKLJ3bJtBpJ4LtiUhswCc+wAmE8m1Ygg9ZDDXUpSz
         GBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HS1iJkm0hv8Ke2csA68ZLm2xcERjTLMbURsBR9ZOsB4=;
        b=oRBEgyoNIm9Fy4GqQI8V+tI6pA2VkkMCicQx9+1vuktVsTo21/h6nIeTHwFeS8l1SZ
         uf+VdkJ1sedkhIqTsAXftH9x0RkVS2MiRosuI3BX+PFB5iDMGVBo0RvfvM64BiHDGp05
         olQQOJRk/fPxpNN7ksDCcUfvxM1ydn8F8cVxz9dNt9AAASDp7uVB5FUr69N+X4z3z2IN
         Ns4WesvxLucnGS3/ZEAuxnTsJeGZqkGWtoHVOaNAUewkshJbG8SVtxSr8uIa9H+PLFmE
         xUphdu4K2ZhKmyap4Zq4NKRb30KpubCoQBcvc2nZcTsQPafAf4BS5ttz6ZYVUcGJL4ui
         B/aw==
X-Gm-Message-State: AOAM533rxFRhv9L8tyzQE9J042ryQ6m8ecQWXxBzs98LfXfkjaEdhw2F
        tWY+saD9YriBssbbTEYHBAdH+A==
X-Google-Smtp-Source: ABdhPJwQKlI5K5tbD3X2rWL/4KCZ0oRCOnvHrTve+MrFezA/tl5hICdOQPt3KpOkgYaew52cICnl8g==
X-Received: by 2002:a62:be13:0:b029:19a:4c0:efe3 with SMTP id l19-20020a62be130000b029019a04c0efe3mr19199070pff.75.1607401033563;
        Mon, 07 Dec 2020 20:17:13 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id s30sm14195891pgl.39.2020.12.07.20.17.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:17:12 -0800 (PST)
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
Subject: [PATCH V5 3/3] thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms
Date:   Tue,  8 Dec 2020 09:46:57 +0530
Message-Id: <9c255c83d78d58451abc06848001faef94c87a12.1607400596.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1607400596.git.viresh.kumar@linaro.org>
References: <cover.1607400596.git.viresh.kumar@linaro.org>
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
 drivers/thermal/cpufreq_cooling.c | 69 ++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index cc2959f22f01..cee59b95633b 100644
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
 
@@ -132,14 +134,25 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
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
+	util = sched_cpu_util(cpu, max);
+	return (util * 100) / max;
+}
+#else /* !CONFIG_SMP */
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 		    int cpu_idx)
 {
@@ -161,6 +174,7 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 
 	return load;
 }
+#endif /* CONFIG_SMP */
 
 /**
  * get_dynamic_power() - calculate the dynamic power
@@ -346,6 +360,36 @@ static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 #endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
 
+#ifdef CONFIG_SMP
+static inline int allocate_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	return 0;
+}
+
+static inline void free_idle_time(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+}
+#else
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
 static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 				   unsigned long state)
 {
@@ -487,7 +531,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
-	unsigned int i, num_cpus;
+	unsigned int i;
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
@@ -498,7 +542,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 	}
 
-
 	if (IS_ERR_OR_NULL(policy)) {
 		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
 		return ERR_PTR(-EINVAL);
@@ -516,12 +559,10 @@ __cpufreq_cooling_register(struct device_node *np,
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
 
@@ -581,7 +622,7 @@ __cpufreq_cooling_register(struct device_node *np,
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_idle_time:
-	kfree(cpufreq_cdev->idle_time);
+	free_idle_time(cpufreq_cdev);
 free_cdev:
 	kfree(cpufreq_cdev);
 	return cdev;
@@ -674,7 +715,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
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

