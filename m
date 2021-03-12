Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814EC338E55
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhCLNKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 08:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhCLNJx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 08:09:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E90C061762
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:09:52 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d191so3759863wmd.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciQbVSMUlmG+EHnejb8dZoNHxiJgO/iaArkSXQInEQA=;
        b=VPZw1uaRvXSaT1vcJm+4Tnk6DwVz8AS7pSmoBzLltwLgKQw9Wcf8vpLZBqyWkPlG2Q
         GSTCPnBz92ZbF5VYfMEOfHgQQ3LyTRgvnZ7sMoIOSlrlFiWpB+xia3q3KXHSF2dp1OmR
         kaDmuSHHyekLUkOKYe9Lzs4/rXDtFWDS9F+P8b7Z1Cxut6cxFHB0smQTnVGh6H5ONLjN
         p4Y+BJ9YwFfsTIM1ABf2Y/oHOYQQqNWjS7uvUf2j3L2qe/bLELJH4SpgA/g+QnU4ZDnt
         z9j62hPLTGn521bJ70hotMTAVUOR/4vtZpQN5yyYMJrr0uyLlPyAe+BydTYPn2mWHkqt
         uWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciQbVSMUlmG+EHnejb8dZoNHxiJgO/iaArkSXQInEQA=;
        b=b3+k6V7MTMTv35pO/EDg9JlEO4Rb7YGW0cThvIO4EkuAUqPLTAUUbf9nUWxk04PWlB
         SFaAj47Opw43eS8TRGZ2s/NCs79U5uuvdgjbDHBQgDtg1SzmGPObh37TzgZlNm4BDwXi
         IaQmvgT7hLObxqakN5qWcHzA5KzZLdUACYZPYRMPwbivioLqeaC0pys0E4dHkh3CUOwv
         V3Ag8mGmiFUT3O9455Ga+C+hB5QJb7AfOCN8vY6bHf2WJ9t9mLGTNWtYD02xQAY/Yxb5
         qb+K8vb4i8Gzs2Armf+6VsqUU5S+SdKq0i8PbUhTiMEanyeO4KjsphemD8jhkEr1BCyc
         viTw==
X-Gm-Message-State: AOAM531lQ2cOMD2+tcU3v8MAPMTeB4LNhOq7iUpyA85UioTPABV6QzLL
        RjN+sJLE0bbETsyApPrtzxx8OQ==
X-Google-Smtp-Source: ABdhPJwypoqzYl7C8Dp5rgJscirKBA+PtMWt0rgAEpEZ0zYCZ0QjajPrCIw5ptD+YpxgVfX1cqDGHw==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr12749759wml.113.1615554591411;
        Fri, 12 Mar 2021 05:09:51 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id q15sm7655033wrr.58.2021.03.12.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:09:51 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v4 5/5] powercap/drivers/dtpm: Scale the power with the load
Date:   Fri, 12 Mar 2021 14:04:11 +0100
Message-Id: <20210312130411.29833-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312130411.29833-1-daniel.lezcano@linaro.org>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the power consumption is based on the current OPP power
assuming the entire performance domain is fully loaded.

That gives very gross power estimation and we can do much better by
using the load to scale the power consumption.

Use the utilization to normalize and scale the power usage over the
max possible power.

Tested on a rock960 with 2 big CPUS, the power consumption estimation
conforms with the expected one.

Before this change:

~$ ~/dhrystone -t 1 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
2260000

After this change:

~$ ~/dhrystone -t 1 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
1130000

~$ ~/dhrystone -t 2 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
2260000

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

V3:
  - Fixed uninitialized 'cpu' in scaled_power_uw()
V2:
  - Replaced cpumask by em_span_cpus
  - Changed 'util' metrics variable types
  - Optimized utilization scaling power computation
  - Renamed parameter name for scale_pd_power_uw()
---
 drivers/powercap/dtpm_cpu.c | 46 +++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 1c6d1e54691f..e120ea239d75 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -68,27 +68,59 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	return power_limit;
 }
 
+static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
+{
+	unsigned long max = 0, sum_util = 0;
+	int cpu;
+
+	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+
+		/*
+		 * The capacity is the same for all CPUs belonging to
+		 * the same perf domain, so a single call to
+		 * arch_scale_cpu_capacity() is enough. However, we
+		 * need the CPU parameter to be initialized by the
+		 * loop, so the call ends up in this block.
+		 *
+		 * We can initialize 'max' with a cpumask_first() call
+		 * before the loop but the bits computation is not
+		 * worth given the arch_scale_cpu_capacity() just
+		 * returns a value where the resulting assembly code
+		 * will be optimized by the compiler.
+		 */
+		max = arch_scale_cpu_capacity(cpu);
+		sum_util += sched_cpu_util(cpu, max);
+	}
+
+	/*
+	 * In the improbable case where all the CPUs of the perf
+	 * domain are offline, 'max' will be zero and will lead to an
+	 * illegal operation with a zero division.
+	 */
+	return max ? (power * ((sum_util << 10) / max)) >> 10 : 0;
+}
+
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd;
-	struct cpumask cpus;
+	struct cpumask *pd_mask;
 	unsigned long freq;
-	int i, nr_cpus;
+	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
-	freq = cpufreq_quick_get(dtpm_cpu->cpu);
 
-	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
-	nr_cpus = cpumask_weight(&cpus);
+	pd_mask = em_span_cpus(pd);
+
+	freq = cpufreq_quick_get(dtpm_cpu->cpu);
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		return pd->table[i].power *
-			MICROWATT_PER_MILLIWATT * nr_cpus;
+		return scale_pd_power_uw(pd_mask, pd->table[i].power *
+					 MICROWATT_PER_MILLIWATT);
 	}
 
 	return 0;
-- 
2.17.1

