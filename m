Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4975333AEE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhCJLCt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhCJLCW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:02:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9795C061761
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:02:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo10420155wmq.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v0a0P82FBqcJYMtTstBhU6OwDjxrI0ymrdgmVRwXE98=;
        b=oSnESTuRrlSPD8vl748DcLdzGj6QpSScfFvSqW6pyUMeI5jXG4tMVHSYvKVBkuawlj
         89UFnoMMkfLlf/vEwqmA+mMYghOq0Ji1bIzA7UXBRv+0/QvToOGMHyCtN1NDriEssZeb
         U6RR95/XVyJ45HFSSjbAmamJU067SJx8F0YaOnWdiyyGdyUWGMYq/s8bpAkFgobt9Lri
         MOViG6bwNvLYa8c1WMuPVu5Ha0sWIYyBvNtFSNLNBOkB1lJOfgUDNU7Ur5hhUdLRJKFD
         ozrdV3mVMYFCB/pKfRnR2DTQkn2gBVIU9WOihIMwdBQ4t5bCIVpM7cbU61S7UcCtk8sI
         vAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0a0P82FBqcJYMtTstBhU6OwDjxrI0ymrdgmVRwXE98=;
        b=SWPgfW0rVp0OVhisZ2tJLjkhF4cTfRdCV0WzvWngmo1tda48WoS4cfH++NC3+vS0VV
         M8AnA0I/QDoqQqPskcmtXrje9vNlhluV4RxFbIYHNqFFoQvSjMoJUUmS7EEkQpahvtz8
         heKwIhxNMIU9o0inqNZfs0FOngMd6Vge1ElC3txLB9OofHq0fvc8Pdn3iMILoQ8F7OzF
         1lIUatw8FJ3AFoexRaQiIWoH84GG9RWaVVGmd55PnryU1JQmOhVlDFbO5ysNr/PPUHqW
         jY3WI+44UAnVqak2x1NqblAodw+YbsAUL/lJpEZ268TUyrpkbXhLzBNHQy9YXVcUPsXj
         YeCQ==
X-Gm-Message-State: AOAM531ZNhR95oMsg1uSzwFHnSJcrmVf/jqGW6JhWHvfLYjQUhA6sbYF
        uBZ5oM1GDttmxqt1xUA8buFXEw==
X-Google-Smtp-Source: ABdhPJwumqdTQGcNS35dpB48M2Ryxk3bSaitVmd1n77FnIWGtJm8StbZCAcL5y/CjpbykEqdIpO2+g==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr2801524wmd.78.1615374140239;
        Wed, 10 Mar 2021 03:02:20 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id k4sm36193902wrd.9.2021.03.10.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:02:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v3 5/5] powercap/drivers/dtpm: Scale the power with the load
Date:   Wed, 10 Mar 2021 12:02:12 +0100
Message-Id: <20210310110212.26512-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310110212.26512-1-daniel.lezcano@linaro.org>
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
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
index ac7f2e7e262f..47854923d958 100644
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

