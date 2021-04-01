Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E808A351FB3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhDATY7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhDATYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 15:24:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04814C0319E0
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 11:37:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z2so2751390wrl.5
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IN1SjCUiJXttEzEwKJpOwO8v8lxJB5yWOIgxTzXkjf4=;
        b=ju8n3USnaxhhInT8bHoK0O8Q+jNnDM93vNa6glwrdRfdcG5o9CssZIqPXKiV8fcOSF
         397FBdWnyUZ/h3yC8/rKIteR2jIX3Ai8ZE55e7knAGIo81u0NeEhBsx1g8ar7ufyybGa
         SZXxUMbLcwreoYamhiaoPigO6FtXfCY56EGu1q65o2+Iftn3noZLlqyO7ataBz7z0hPj
         v48uD5iHJFcJZY/wH6cGz+nC3xIa4cwFjToK+SlzE/w71aj+QbfyMHtXgL+GZZNJPkC4
         e2Ys1dD4BXutq1xIhF2u3AVpf6Ni/H/pWevx590KAkxM7dB6RgMbldEOltQlbaXTeipm
         zbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IN1SjCUiJXttEzEwKJpOwO8v8lxJB5yWOIgxTzXkjf4=;
        b=FGrtkB/khu8ZNOCQQHlCUIWKiKnC5rL84cd1/EBjty3nQbhbznLTOIJtFMpSljh335
         N82QsXpKO6DXMmIPT/t9ssHtbQSafzDLymFO++xptx+deWHM3ficlWLKFi8boFoOroj1
         Qmii9e+ThpJ+N186MalR9NHFlaj/EYcpKl4epHHMREmO7FN/xyaVldHTtYPmTqfb/mUD
         hGjT76wYe8fdvvKnOUhFPNw0WQN9f1iNgHtyT64THYlPbj7c9cBM6to8xgGD/BOqQiPC
         Lm8oKMCPQNDIXlbVzcyh3Xcd7aY0HnsdOKT9hQoMKIGePQUN5NbuhzjggZTPm99AZECc
         AVLA==
X-Gm-Message-State: AOAM533waTyHU/Cb1a0o4saVvpHz/BI97Bd7usmRnzO8i/uIdojUqxuR
        +CfVYWW65xNhlcDmcYr6JvlFFw==
X-Google-Smtp-Source: ABdhPJy3mVd8OhSj7jurZo2He6O+lQ5XAsdkC1gSFOVBuoYTB6OH80mJpBmbSvdUDk1o0xLclTCtaA==
X-Received: by 2002:a5d:548c:: with SMTP id h12mr11363871wrv.46.1617302233482;
        Thu, 01 Apr 2021 11:37:13 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id b131sm9111490wmb.34.2021.04.01.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:37:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v6 5/7] powercap/drivers/dtpm: Scale the power with the load
Date:   Thu,  1 Apr 2021 20:36:52 +0200
Message-Id: <20210401183654.27214-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401183654.27214-1-daniel.lezcano@linaro.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
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
index f4092d1b01d7..eae35ae3c42e 100644
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

