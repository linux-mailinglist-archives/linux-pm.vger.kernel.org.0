Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47023331B1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 23:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhCIWnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 17:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhCIWm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 17:42:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD89C06174A
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 14:42:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso8481919wmi.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0x5NnmCRCiyNY9UYzDiRv/bqTSntYaFcl6ygf/f/TM4=;
        b=TVJ/xwG9NZy1JuEErmWA2lk3anjcw77r9ar/9MXO85bVVZClKnUpfOLrecGYrfDv5l
         /YesT30aCQGc3x6m0mgHmAFewX1DVs0esR0lb43JB1C5JyCwrbgjsX10ptt9bpNDD3m2
         Z76mEtgNOuF1jxy36AgcwKWjVD03+6caSv14BGA8Tt9x+LM8So5yaKsjgi2iHVPpcGSZ
         v8kElDJs8gTKD2JzYwe1vSAmH5tK/ET5TLGWVd8oBLArB5Us8WgK3c4ld3k3KLRZC0PF
         3rLLxBW3qAh5iMM9+/GUw/cb7pkP/ceOlriZLbDsn8sZufhAhiw6guu+tHBvLbeLOfk8
         4w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0x5NnmCRCiyNY9UYzDiRv/bqTSntYaFcl6ygf/f/TM4=;
        b=cacwja8ehof2vxsjhFnBiJqk3P+q+9UF+xsU3b+Lk222vvz/qMltwS/8nMQq+zposn
         G+t+oHADpmJrMuRElJ++6FEblZw5AMKjzQVbdtJeCZDASjm5dCr1TXg7XzlvA+BH5Ocq
         HC5r26orv0vRMtOoaaX84edhW9WJJQRIyN3GS+JNw9t4j311G0X+ahEe9YaS5BuzD+8+
         ciFsOQDre50cgXiVVb/gAkplDPSQ3BZucT2oU1cT/sGwF+9b6g7TefLYPELWa97RTpqP
         7yN8lbucWJ/0voD8iC1GAkgFqeBtQOjuaNsoiBmHvuVTZJKOx2UqtP4x2LgFP95lxDz2
         NXqw==
X-Gm-Message-State: AOAM533dPfW45BtZsWrtFZrw+fi7qn1G97gyz99/9G8fUoejc0etfZZx
        o+8fqdb8pLgVzr/x5XwxjakMpA==
X-Google-Smtp-Source: ABdhPJz31wBCjoSvravxHREL1SB0xiCa6xFLyA23LLUZz2BzukysqP1ox0HH+/lW14K4sfr8tGK88w==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr172799wmb.14.1615329776988;
        Tue, 09 Mar 2021 14:42:56 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id p16sm30352179wrt.54.2021.03.09.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 14:42:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v2 5/5] powercap/drivers/dtpm: Scale the power with the load
Date:   Tue,  9 Mar 2021 23:42:44 +0100
Message-Id: <20210309224244.27225-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309224244.27225-1-daniel.lezcano@linaro.org>
References: <20210309224244.27225-1-daniel.lezcano@linaro.org>
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

V2:
  - Replaced cpumask by em_span_cpus
  - Changed 'util' metrics variable types
  - Optimized utilization scaling power computation
  - Renamed parameter name for scale_pd_power_uw()
---
 drivers/powercap/dtpm_cpu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index ac7f2e7e262f..6a1537e6da0d 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -68,27 +68,40 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	return power_limit;
 }
 
+static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
+{
+	unsigned long max, sum_util = 0;
+	int cpu;
+
+	max = arch_scale_cpu_capacity(cpu);
+
+	for_each_cpu_and(cpu, pd_mask, cpu_online_mask)
+		sum_util += sched_cpu_util(cpu, max);
+
+	return (power * ((sum_util << 10) / max)) >> 10;
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

