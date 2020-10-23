Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B33296CBA
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462123AbgJWKUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462042AbgJWKUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:20:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEECC0613CE
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:20:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 19so853249pge.12
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJn3vpKHjyunPy1SpVU44rpe3v+8KsE7bamMpHnJEfA=;
        b=sIRCbRdSslsypUJlXwkdywfbkFkaAOLp9J96punFZJpgC5lsWEp0u0DG3J5MMFe2nD
         GTePe7hitMrf2Yk6GiU5vGkICySqd0oGgNRcyKV1P7Uj/9gMqqb2X+YbGjIlXxWKihAN
         MOMYBWzrRydc7VXE7e6lr15QezFLpDq0VsDFA6/PTWlDNCqQftdUwR/azTjzW6Sv19pg
         p2GrFOqCY94O8uEkWTVSW0qYZHqnHu3FGMK71vNzfaSzI3SotwR8HXwn/lKeNlmvKTo+
         htT4QvC0Pgx9zJjsivM8ptJ1LHrF1CSCk6aR/IsjqRTaGR+921monB3JpkNkJIq9sC3f
         wR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJn3vpKHjyunPy1SpVU44rpe3v+8KsE7bamMpHnJEfA=;
        b=BSF0r8169CoE5I7xOfSs4ch5PsOcqhYb3mTJQqQ3SpIQwUwEK2WSZofM+MH1huYgzf
         Y3EhZwJY7sSajrZBhlFQX5ysSXN6JIXUJRL6g9avtdP6Qg5sWo+QJWVJ8gtUgIkhUvwx
         pRfsQEgTHe+lU/WApHjHw0lhgBib1okYUJ+ZaVF1VUj5/pgNHQuM4lRJBJCae6UIOQJa
         vP/FVx3lqBs/IOKfjPVsJ3W/rKmkdeRMc/Vs27EmAseGsUbLPWNBNs7bql4t1sJarkHm
         7KBldwkwq+sRZi5mqNDgBVbnb13LRKl3s+aLkIoC0insk+CNQpkPZr68sqLuDutecjKK
         RGvg==
X-Gm-Message-State: AOAM531qhSHhw98FFhc4cJpODPOw+G2ioFbjQ/QKL+8vFOMa/Gs1UJ8F
        aD5DV0S251wtqzIwquu8BSrW1Q==
X-Google-Smtp-Source: ABdhPJxCu5+eJ1PQLkD5WlGnkCCv328uYZldZ4WXNbQc5PMfBye1LisAbvKLs3GXRZqOu1ygYFjt5w==
X-Received: by 2002:a63:4f26:: with SMTP id d38mr1467103pgb.34.1603448435552;
        Fri, 23 Oct 2020 03:20:35 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x2sm1614531pfc.133.2020.10.23.03.20.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 03:20:34 -0700 (PDT)
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
Subject: [PATCH V2 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
Date:   Fri, 23 Oct 2020 15:50:21 +0530
Message-Id: <11e7c7dcb07ae258fa02e187c9697252f3835466.1603448113.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1603448113.git.viresh.kumar@linaro.org>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Several parts of the kernel are already using the effective CPU
utilization (as seen by the scheduler) to get the current load on the
CPU, do the same here instead of depending on the idle time of the CPU,
which isn't that accurate comparatively.

Note that, this (and CPU frequency scaling in general) doesn't work that
well with idle injection as that is done from rt threads and is counted
as load while it tries to do quite the opposite. That should be solved
separately though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 70 +++++++------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index cc2959f22f01..1315e4d4758b 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
@@ -38,16 +39,6 @@
  *	...
  */
 
-/**
- * struct time_in_idle - Idle time stats
- * @time: previous reading of the absolute time that this cpu was idle
- * @timestamp: wall time of the last invocation of get_cpu_idle_time_us()
- */
-struct time_in_idle {
-	u64 time;
-	u64 timestamp;
-};
-
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
@@ -62,7 +53,6 @@ struct time_in_idle {
  *	registered cooling device.
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
- * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
  *
  * This structure is required for keeping information of each registered
@@ -76,7 +66,6 @@ struct cpufreq_cooling_device {
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
 	struct list_head node;
-	struct time_in_idle *idle_time;
 	struct freq_qos_request qos_req;
 };
 
@@ -132,34 +121,18 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
- * get_load() - get load for a cpu since last updated
- * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
+ * get_load() - get current load for a cpu
  * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in time_in_idle*
  *
- * Return: The average load of cpu @cpu in percentage since this
- * function was last called.
+ * Return: The current load of cpu @cpu in percentage.
  */
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
-		    int cpu_idx)
+static u32 get_load(int cpu)
 {
-	u32 load;
-	u64 now, now_idle, delta_time, delta_idle;
-	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
-
-	now_idle = get_cpu_idle_time(cpu, &now, 0);
-	delta_idle = now_idle - idle_time->time;
-	delta_time = now - idle_time->timestamp;
+	unsigned long max = arch_scale_cpu_capacity(cpu);
+	unsigned long util;
 
-	if (delta_time <= delta_idle)
-		load = 0;
-	else
-		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
-
-	idle_time->time = now_idle;
-	idle_time->timestamp = now;
-
-	return load;
+	util = sched_cpu_util(cpu, ENERGY_UTIL, max);
+	return (util * 100) / max;
 }
 
 /**
@@ -191,13 +164,12 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
  * Instead, we calculate the current power on the assumption that the
  * immediate future will look like the immediate past.
  *
- * We use the current frequency and the average load since this
- * function was last called.  In reality, there could have been
- * multiple opps since this function was last called and that affects
- * the load calculation.  While it's not perfectly accurate, this
- * simplification is good enough and works.  REVISIT this, as more
- * complex code may be needed if experiments show that it's not
- * accurate enough.
+ * We use the current frequency and the current load.  In reality,
+ * there could have been multiple opps since this function was last
+ * called and that affects the load calculation.  While it's not
+ * perfectly accurate, this simplification is good enough and works.
+ * REVISIT this, as more complex code may be needed if experiments show
+ * that it's not accurate enough.
  *
  * Return: 0 on success, -E* if getting the static power failed.
  */
@@ -223,7 +195,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 		u32 load;
 
 		if (cpu_online(cpu))
-			load = get_load(cpufreq_cdev, cpu, i);
+			load = get_load(cpu);
 		else
 			load = 0;
 
@@ -517,13 +489,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cpufreq_cdev->policy = policy;
 	num_cpus = cpumask_weight(policy->related_cpus);
-	cpufreq_cdev->idle_time = kcalloc(num_cpus,
-					 sizeof(*cpufreq_cdev->idle_time),
-					 GFP_KERNEL);
-	if (!cpufreq_cdev->idle_time) {
-		cdev = ERR_PTR(-ENOMEM);
-		goto free_cdev;
-	}
 
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
@@ -531,7 +496,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		cdev = ERR_PTR(ret);
-		goto free_idle_time;
+		goto free_cdev;
 	}
 	cpufreq_cdev->id = ret;
 
@@ -580,8 +545,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-free_idle_time:
-	kfree(cpufreq_cdev->idle_time);
 free_cdev:
 	kfree(cpufreq_cdev);
 	return cdev;
@@ -674,7 +637,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.25.0.rc1.19.g042ed3e048af

