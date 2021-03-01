Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417FB3277D2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 07:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhCAGwW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 01:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhCAGwN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 01:52:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C65C06178B
        for <linux-pm@vger.kernel.org>; Sun, 28 Feb 2021 22:51:27 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id x29so2637266pgk.6
        for <linux-pm@vger.kernel.org>; Sun, 28 Feb 2021 22:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX/XsUCp4LSfX2hn2td5aSv5gGjfLpKvsXKWXdZTK6g=;
        b=I7HrZf+N5/DlpJ23Y99qxcUjlM0+e7Os9kT9lu9sdkMIfOjNd1I2DWkKftBP5v7y+P
         dIjrWMOaCKYW5/XA+fLwseJUKwYNDFxLP4aWVVD4O30nOxE3Dtc/hJ25NLC6LPHiviTy
         8FI1mn7K1Ceq0t+oz7AtAh5EA8YmOdSz9PlsZq42L1U94boLPg7DbXUUMQJBwmymCzwJ
         jr4YTJfydeogv40QEqPIb8PNSuxO1zmtOKWHUe11Ppy8cj1Z13Paau5JBlTUGqyOnqGN
         4EQu5uv/Neo7RMtzL6906NS3+yj1xYSskf5S1Pg54VOQxCXs9XUutrAuqgKn7fQ24vbm
         x+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX/XsUCp4LSfX2hn2td5aSv5gGjfLpKvsXKWXdZTK6g=;
        b=CEDJSYQxeHoCyB+BjbLBKCdNGwNNAA5bfp/PbIWQHDrqcINySeutZWGAbHsq5i1u6j
         RrTemRXEkC/llSMSUbo7GXLWKq5yOr6ppTXxJyRMX2i+tJ0kUgmDGfPG6qlNT78EEI9U
         jKLt/kU9H/AX7TiLrGi8fN9tH0y5XiAYD2ix/YGseZTln5/ZXs+EnmcngHooNdgmW9EP
         PnHQI5w8yHfeX+R0p028arswLFSkB2ip9ZeNWn36V0Cs92GEPT+IbubUCM/cvezGBhid
         +2PCazbTwzDhcjYyWZa0M1krK5YThf1Zbmt4fHBW9gM+owHWC/0e5IgzPACav7C9JZkn
         t31Q==
X-Gm-Message-State: AOAM530GWZkgg2r60BS9ARE1RMIrL25zsBSJ2O8nPZJBE/neowshAHVQ
        h9LpW/CT7Dg7p3kWwHh44jpinw==
X-Google-Smtp-Source: ABdhPJxSo6lVe2emJlP8zYqfYCIB3vXFPd24+Ge1bVN8/eaMt0WcBEhgVW4RdyAFQsNqkA4JBcjWRQ==
X-Received: by 2002:a62:6444:0:b029:1ee:67c6:a169 with SMTP id y65-20020a6264440000b02901ee67c6a169mr6694203pfb.47.1614581487207;
        Sun, 28 Feb 2021 22:51:27 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id w3sm16598973pjn.12.2021.02.28.22.51.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 22:51:26 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/2] topology: Allow multiple entities to provide sched_freq_tick() callback
Date:   Mon,  1 Mar 2021 12:21:17 +0530
Message-Id: <a34f549bc75eecd4804aebb7b7794b45769eccf0.1614580695.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1614580695.git.viresh.kumar@linaro.org>
References: <cover.1614580695.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch attempts to make it generic enough so other parts of the
kernel can also provide their own implementation of scale_freq_tick()
callback, which is called by the scheduler periodically to update the
per-cpu freq_scale variable.

The implementations now need to provide 'struct scale_freq_data' for the
CPUs for which they have hardware counters available, and a callback
gets registered for each possible CPU in a per-cpu variable.

The arch specific (or ARM AMU) counters are updated to adapt to this and
they take the highest priority if they are available, i.e. they will be
used instead of CPPC based counters for example.

The special code to rebuild the sched domains, in case invariance status
change for the system, is moved out of arm64 specific code and is added
to arch_topology.c.

Note that this also defines SCALE_FREQ_SOURCE_CPUFREQ but doesn't use it
and it is added to show that cpufreq is also acts as source of
information for FIE and will be used by default if no other counters are
supported for a platform.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/include/asm/topology.h |  10 +--
 arch/arm64/kernel/topology.c      | 105 +++++++++++-------------------
 drivers/base/arch_topology.c      |  85 ++++++++++++++++++++++--
 include/linux/arch_topology.h     |  14 +++-
 4 files changed, 134 insertions(+), 80 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 3b8dca4eb08d..ec2db3419c41 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -17,17 +17,9 @@ int pcibus_to_node(struct pci_bus *bus);
 #include <linux/arch_topology.h>
 
 void update_freq_counters_refs(void);
-void topology_scale_freq_tick(void);
-
-#ifdef CONFIG_ARM64_AMU_EXTN
-/*
- * Replace task scheduler's default counter-based
- * frequency-invariance scale factor setting.
- */
-#define arch_scale_freq_tick topology_scale_freq_tick
-#endif /* CONFIG_ARM64_AMU_EXTN */
 
 /* Replace task scheduler's default frequency-invariant accounting */
+#define arch_scale_freq_tick topology_scale_freq_tick
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index e08a4126453a..47fca7376c93 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -199,12 +199,47 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
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
+static struct scale_freq_data amu_sfd = {
+	.source = SCALE_FREQ_SOURCE_ARCH,
+	.set_freq_scale = amu_scale_freq_tick,
+};
 
 static void amu_fie_setup(const struct cpumask *cpus)
 {
-	bool invariant;
 	int cpu;
 
 	/* We are already set since the last insmod of cpufreq driver */
@@ -221,25 +256,10 @@ static void amu_fie_setup(const struct cpumask *cpus)
 
 	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
 
-	invariant = topology_scale_freq_invariant();
-
-	/* We aren't fully invariant yet */
-	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
-		return;
-
-	static_branch_enable(&amu_fie_key);
+	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
 
 	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
 		 cpumask_pr_args(cpus));
-
-	/*
-	 * Task scheduler behavior depends on frequency invariance support,
-	 * either cpufreq or counter driven. If the support status changes as
-	 * a result of counter initialisation and use, retrigger the build of
-	 * scheduling domains to ensure the information is propagated properly.
-	 */
-	if (!invariant)
-		rebuild_sched_domains_energy();
 }
 
 static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
@@ -283,53 +303,6 @@ static int __init init_amu_fie(void)
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
index de8587cc119e..8f62dbf93f67 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,17 +21,94 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
+static struct cpumask scale_freq_counters_mask;
+static bool scale_freq_invariant;
+
+static bool supports_scale_freq_counters(const struct cpumask *cpus)
+{
+	return cpumask_subset(cpus, &scale_freq_counters_mask);
+}
+
 bool topology_scale_freq_invariant(void)
 {
 	return cpufreq_supports_freq_invariance() ||
-	       arch_freq_counters_available(cpu_online_mask);
+	       supports_scale_freq_counters(cpu_online_mask);
 }
 
-__weak bool arch_freq_counters_available(const struct cpumask *cpus)
+static void update_scale_freq_invariant(bool status)
 {
-	return false;
+	if (scale_freq_invariant == status)
+		return;
+
+	/*
+	 * Task scheduler behavior depends on frequency invariance support,
+	 * either cpufreq or counter driven. If the support status changes as
+	 * a result of counter initialisation and use, retrigger the build of
+	 * scheduling domains to ensure the information is propagated properly.
+	 */
+	if (topology_scale_freq_invariant() == status) {
+		scale_freq_invariant = status;
+		rebuild_sched_domains_energy();
+	}
 }
+
+void topology_set_scale_freq_source(struct scale_freq_data *data,
+				    const struct cpumask *cpus)
+{
+	struct scale_freq_data *sfd;
+	int cpu;
+
+	/*
+	 * Avoid calling rebuild_sched_domains() unnecessarily if FIE is
+	 * supported by cpufreq.
+	 */
+	if (cpumask_empty(&scale_freq_counters_mask))
+		scale_freq_invariant = topology_scale_freq_invariant();
+
+	for_each_cpu(cpu, cpus) {
+		sfd = per_cpu(sft_data, cpu);
+
+		/* Use ARCH provided counters whenever possible */
+		if (!sfd || sfd->source != SCALE_FREQ_SOURCE_ARCH) {
+			per_cpu(sft_data, cpu) = data;
+			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
+		}
+	}
+
+	update_scale_freq_invariant(true);
+}
+EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
+
+void topology_clear_scale_freq_source(enum scale_freq_source source,
+				      const struct cpumask *cpus)
+{
+	struct scale_freq_data *sfd;
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		sfd = per_cpu(sft_data, cpu);
+
+		if (sfd && sfd->source == source) {
+			per_cpu(sft_data, cpu) = NULL;
+			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
+		}
+	}
+
+	update_scale_freq_invariant(false);
+}
+EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
+
+void topology_scale_freq_tick(void)
+{
+	struct scale_freq_data *sfd = *this_cpu_ptr(&sft_data);
+
+	if (sfd)
+		sfd->set_freq_scale();
+}
+
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(freq_scale);
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
@@ -47,7 +124,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 	 * want to update the scale factor with information from CPUFREQ.
 	 * Instead the scale factor will be updated from arch_scale_freq_tick.
 	 */
-	if (arch_freq_counters_available(cpus))
+	if (supports_scale_freq_counters(cpus))
 		return;
 
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b73a61..3bcfba5c21a7 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -34,7 +34,19 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq);
 bool topology_scale_freq_invariant(void);
 
-bool arch_freq_counters_available(const struct cpumask *cpus);
+enum scale_freq_source {
+	SCALE_FREQ_SOURCE_CPUFREQ = 0,
+	SCALE_FREQ_SOURCE_ARCH,
+};
+
+struct scale_freq_data {
+	enum scale_freq_source source;
+	void (*set_freq_scale)(void);
+};
+
+void topology_scale_freq_tick(void);
+void topology_set_scale_freq_source(struct scale_freq_data *data, const struct cpumask *cpus);
+void topology_clear_scale_freq_source(enum scale_freq_source source, const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
 
-- 
2.25.0.rc1.19.g042ed3e048af

