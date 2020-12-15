Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E12DABFC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 12:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgLOL0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 06:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgLOLSN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 06:18:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28346C061248
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 03:17:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e2so3696950plt.12
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 03:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nclCHANFNijvEDnymHTZhqBOvD0PdZUMm8AQp2xAWLI=;
        b=uOj10VFTGCZlHtTLgzshL9J7I+7HFxXnslBQ6WH1pbh+rQukw+h8S0dpORerJ5H2oH
         T3vI1t+J8y5Rz1gKkhQMn5mrBOLRsaHcHHsFijW1dK63wgnDdjxbPA5TbhfDyJmhmQGE
         ABHxvNaIvNAI43e9owLbZs/ZicJHyZVjkGaIG+L/HARYb8+jpe1HhScjAGi6CeQtqg5Y
         mWCFVrcqFbq+e+KHJPPY/Uz/FsbUkj6aDf7ZiCs27CwXG7hu6p9feXPhpkfxGhTHecZQ
         TPSXzDazZAj+eAQsUNwddaSsBVnOYV2DJhWfVNCLB7EJ+qMjMqNnt023j2w0fDq+CUNO
         ppRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nclCHANFNijvEDnymHTZhqBOvD0PdZUMm8AQp2xAWLI=;
        b=Dvf+ZbFdii4nY1yLCYUd0qYNLYuq8SGR/A7YyC1z+sFu9IvHDhFpI0DOoOoVXJAzgu
         voHdQkZeDRwRIUhDRXC4O0REkD7GmE9Y+12LliBoz4r/bmLBlPlbWwW5ALvw4gxqNAxz
         T/7AxsUDIbw9xLhiutjNk0LfD6hF8pNgM5zL7zUX4+YUpq6TwSs9UlMtojo+imwnQxR/
         +r4cFyIDUoZ81bNe+zKH+mX1xAC7PWK6/2zrKqGY05wfRpj3mwsnstS9nMqZ4xTeL4pQ
         ooHBd8hdJ0lolprVdxhTumHuKD14wFihVV+lKR4mQo2MFTUS7nUrLy4DDnvBa40pdNzM
         fsfg==
X-Gm-Message-State: AOAM531qxgvE7T8LskOd+gqUqQWBy/WHlOPv/iD0Nj+FD/XcobuxfK8o
        JOt1ffkHksvcyrOIvd+AV5lv4Wu6UhZBMQ==
X-Google-Smtp-Source: ABdhPJycj3p9qs4bJA1A2K4DuS1ScRWDc3mE4oOc+jvseAOncXmuTkTMszfNTV6wm5uUs/E585De9A==
X-Received: by 2002:a17:90a:ea02:: with SMTP id w2mr29527143pjy.99.1608031049626;
        Tue, 15 Dec 2020 03:17:29 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id x7sm22694450pfb.96.2020.12.15.03.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:17:29 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 1/2] topology: Allow multiple entities to provide sched_freq_tick() callback
Date:   Tue, 15 Dec 2020 16:46:35 +0530
Message-Id: <28ade070dd80f6f22d6e8fce5db5f0142b428fa9.1608030508.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1608030508.git.viresh.kumar@linaro.org>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch attempts to make it generic enough so other parts of the
kernel can also provide their own implementation of scale_freq_tick()
callback, which is called by the scheduler periodically to update the
per-cpu freq_scale variable.

The implementations now need to provide struct scale_freq_tick_data for
the CPUs for which they have hardware counters available, and a callback
gets registered for each possible CPU in a per-cpu variable.

The AMU counters are updated to adapt to this and they take the highest
priority if they are available, i.e. they will be used instead of CPPC
based counters for example.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/include/asm/topology.h |  8 +--
 arch/arm64/kernel/topology.c      | 89 ++++++++++++++-----------------
 drivers/base/arch_topology.c      | 56 +++++++++++++++++--
 include/linux/arch_topology.h     | 13 ++++-
 4 files changed, 104 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 3b8dca4eb08d..be6a53ba3e2d 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -17,15 +17,9 @@ int pcibus_to_node(struct pci_bus *bus);
 #include <linux/arch_topology.h>
 
 void update_freq_counters_refs(void);
-void topology_scale_freq_tick(void);
 
-#ifdef CONFIG_ARM64_AMU_EXTN
-/*
- * Replace task scheduler's default counter-based
- * frequency-invariance scale factor setting.
- */
+/* Replace task scheduler's default frequency-invariance scale factor setting */
 #define arch_scale_freq_tick topology_scale_freq_tick
-#endif /* CONFIG_ARM64_AMU_EXTN */
 
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_set_freq_scale topology_set_freq_scale
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0fc2b32ddb45..22f056821585 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -199,8 +199,44 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	return 0;
 }
 
-static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
-#define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
+static void amu_scale_freq_tick(void)
+{
+	u64 prev_core_cnt, prev_const_cnt;
+	u64 core_cnt, const_cnt, scale;
+
+	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
+	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
+
+	update_freq_counters_refs();
+
+	const_cnt = this_cpu_read(arch_const_cycles_prev);
+	core_cnt = this_cpu_read(arch_core_cycles_prev);
+
+	if (unlikely(core_cnt <= prev_core_cnt ||
+		     const_cnt <= prev_const_cnt))
+		return;
+
+	/*
+	 *	    /\core    arch_max_freq_scale
+	 * scale =  ------- * --------------------
+	 *	    /\const   SCHED_CAPACITY_SCALE
+	 *
+	 * See validate_cpu_freq_invariance_counters() for details on
+	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
+	 */
+	scale = core_cnt - prev_core_cnt;
+	scale *= this_cpu_read(arch_max_freq_scale);
+	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
+			  const_cnt - prev_const_cnt);
+
+	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
+	this_cpu_write(freq_scale, (unsigned long)scale);
+}
+
+static struct scale_freq_tick_data amu_sftd = {
+	.source = SCALE_FREQ_SOURCE_AMU,
+	.scale_freq = amu_scale_freq_tick,
+};
 
 static void amu_fie_setup(const struct cpumask *cpus)
 {
@@ -227,7 +263,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
 		return;
 
-	static_branch_enable(&amu_fie_key);
+	topology_set_scale_freq_tick(&amu_sftd, amu_fie_cpus);
 
 	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
 		cpumask_pr_args(amu_fie_cpus));
@@ -283,53 +319,6 @@ static int __init init_amu_fie(void)
 }
 core_initcall(init_amu_fie);
 
-bool arch_freq_counters_available(const struct cpumask *cpus)
-{
-	return amu_freq_invariant() &&
-	       cpumask_subset(cpus, amu_fie_cpus);
-}
-
-void topology_scale_freq_tick(void)
-{
-	u64 prev_core_cnt, prev_const_cnt;
-	u64 core_cnt, const_cnt, scale;
-	int cpu = smp_processor_id();
-
-	if (!amu_freq_invariant())
-		return;
-
-	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
-		return;
-
-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
-
-	update_freq_counters_refs();
-
-	const_cnt = this_cpu_read(arch_const_cycles_prev);
-	core_cnt = this_cpu_read(arch_core_cycles_prev);
-
-	if (unlikely(core_cnt <= prev_core_cnt ||
-		     const_cnt <= prev_const_cnt))
-		return;
-
-	/*
-	 *	    /\core    arch_max_freq_scale
-	 * scale =  ------- * --------------------
-	 *	    /\const   SCHED_CAPACITY_SCALE
-	 *
-	 * See validate_cpu_freq_invariance_counters() for details on
-	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
-	 */
-	scale = core_cnt - prev_core_cnt;
-	scale *= this_cpu_read(arch_max_freq_scale);
-	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
-			  const_cnt - prev_const_cnt);
-
-	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
-	this_cpu_write(freq_scale, (unsigned long)scale);
-}
-
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index de8587cc119e..07774fb47bc4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,17 +21,65 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+static DEFINE_PER_CPU(struct scale_freq_tick_data *, sft_data);
+static struct cpumask scale_freq_tick_mask;
+
+static bool supports_scale_freq_tick(const struct cpumask *cpus)
+{
+	return cpumask_subset(cpus, &scale_freq_tick_mask);
+}
+
 bool topology_scale_freq_invariant(void)
 {
 	return cpufreq_supports_freq_invariance() ||
-	       arch_freq_counters_available(cpu_online_mask);
+	       supports_scale_freq_tick(cpu_online_mask);
+}
+
+void topology_set_scale_freq_tick(struct scale_freq_tick_data *data,
+				  const struct cpumask *cpus)
+{
+	struct scale_freq_tick_data *sftd;
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		sftd = per_cpu(sft_data, cpu);
+
+		/* Use AMU counters whenever possible */
+		if (!sftd || sftd->source != SCALE_FREQ_SOURCE_AMU) {
+			per_cpu(sft_data, cpu) = data;
+			cpumask_set_cpu(cpu, &scale_freq_tick_mask);
+		}
+	}
 }
+EXPORT_SYMBOL_GPL(topology_set_scale_freq_tick);
 
-__weak bool arch_freq_counters_available(const struct cpumask *cpus)
+void topology_clear_scale_freq_tick(enum scale_freq_tick_source source,
+				    const struct cpumask *cpus)
 {
-	return false;
+	struct scale_freq_tick_data *sftd;
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		sftd = per_cpu(sft_data, cpu);
+
+		if (sftd && sftd->source == source) {
+			per_cpu(sft_data, cpu) = NULL;
+			cpumask_clear_cpu(cpu, &scale_freq_tick_mask);
+		}
+	}
 }
+EXPORT_SYMBOL_GPL(topology_clear_scale_freq_tick);
+
+void topology_scale_freq_tick(void)
+{
+	struct scale_freq_tick_data *sftd = *this_cpu_ptr(&sft_data);
+
+	if (sftd)
+		sftd->scale_freq();
+}
+
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(freq_scale);
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
@@ -47,7 +95,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 	 * want to update the scale factor with information from CPUFREQ.
 	 * Instead the scale factor will be updated from arch_scale_freq_tick.
 	 */
-	if (arch_freq_counters_available(cpus))
+	if (supports_scale_freq_tick(cpus))
 		return;
 
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b73a61..b2422ebef2dd 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -34,7 +34,18 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq);
 bool topology_scale_freq_invariant(void);
 
-bool arch_freq_counters_available(const struct cpumask *cpus);
+enum scale_freq_tick_source {
+	SCALE_FREQ_SOURCE_AMU,
+};
+
+struct scale_freq_tick_data {
+	enum scale_freq_tick_source source;
+	void (*scale_freq)(void);
+};
+
+void topology_scale_freq_tick(void);
+void topology_set_scale_freq_tick(struct scale_freq_tick_data *data, const struct cpumask *cpus);
+void topology_clear_scale_freq_tick(enum scale_freq_tick_source source, const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
 
-- 
2.25.0.rc1.19.g042ed3e048af

