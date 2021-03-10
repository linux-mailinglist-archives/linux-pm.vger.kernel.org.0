Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE50F3334DC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 06:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCJFYG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 00:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCJFXr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 00:23:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E40C06174A
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 21:23:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l7so11289884pfd.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 21:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEAXzUrWlVVEIkd6/enraEtoxzINjvaaB6cgDN5URsY=;
        b=UYF/XgzB8+EImKu+A2bembjT2GS9ALv2830P/N09gDxWWu9Masz7a0S5cFBeevpkUg
         oXn2yc3u4vVJEEIfu4+xSYyVxf7JSPSWE921YjpC3pJaEfD6iXq9qBw49Og+Q2e8j8+h
         aGUQsgIZ5nU0jtvxWYMnbiXuzFY9MdC7i11IaZjmkOBH7jvQVjEOcKmHi98IEYs/xFkR
         m5aahpLhhQS8FZ3haE+DhxiG2UwoS7YdTiviFq2qgDWu1AOnNHpAHnQZY5eIkpABdWFl
         zRTHI+Xk56RJIeOW5/XrQ5TVikrOUXnlLIaGBZnhp86GeBDSkSkvKms0sKg4tJMCQ7fh
         0eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEAXzUrWlVVEIkd6/enraEtoxzINjvaaB6cgDN5URsY=;
        b=eHYaZtyQbD+SFrFBZVo7VdQwJOzZltnnyDaL0yVMD56ZC5OhtTtPHY94NToCtWF1sP
         18dT86ADjgkEgTBUoaiXU0aIQFSXHoWB4Tca9UnKtv/OFB8c/tDWc9TYwyk0/Lxklgeg
         pWNfWOllCGx34IpBltjkJkxMTwjsdohqNGESIya5KagtfkrxD+ljzq8GpDB5Y7FEZXcg
         faMC2Z76jtJ8Hf1VBzEqZTMNWYgnZ7VHY6i51fV5XONYQobj8m/W1B5iosR3rB4K2grY
         Kfa+WhOMQ3GpaTjuIPwptBgqM5lqZKupSfAtGusEECBRK44aAfwHzN1eXG/DvtMpVeFk
         wouA==
X-Gm-Message-State: AOAM530XNUCeuUUW2O+fSXi23SXdA/N2qqSTN2QbLg+WcvkG1YqNcF/i
        qmRN1SMmzsUOpJOqcoY8cJ+NOA==
X-Google-Smtp-Source: ABdhPJyI1OURuDkOxhkQtoEnltM4W7zVrFmCR5CO8369uesozkZBv9WFiLJ85qurhe0ULbNoZAPLjA==
X-Received: by 2002:a63:ce18:: with SMTP id y24mr1321967pgf.246.1615353827115;
        Tue, 09 Mar 2021 21:23:47 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id u7sm14268026pfh.150.2021.03.09.21.23.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 21:23:46 -0800 (PST)
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
Subject: [PATCH V6 2/4] arch_topology: Allow multiple entities to provide sched_freq_tick() callback
Date:   Wed, 10 Mar 2021 10:53:24 +0530
Message-Id: <cbd5b58a5fa44cc93d18c2d6d5e50bbc36fd8cd1.1615351622.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615351622.git.viresh.kumar@linaro.org>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch attempts to make it generic enough so other parts of the
kernel can also provide their own implementation of scale_freq_tick()
callback, which is called by the scheduler periodically to update the
per-cpu arch_freq_scale variable.

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
Acked-by: Will Deacon <will@kernel.org> # for arm64
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/include/asm/topology.h |  10 +--
 arch/arm64/kernel/topology.c      | 105 +++++++++++-------------------
 drivers/base/arch_topology.c      |  82 +++++++++++++++++++++--
 include/linux/arch_topology.h     |  14 +++-
 4 files changed, 131 insertions(+), 80 deletions(-)

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
index aa8d893619ed..4dd14a6620c1 100644
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
+	this_cpu_write(arch_freq_scale, (unsigned long)scale);
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
-	this_cpu_write(arch_freq_scale, (unsigned long)scale);
-}
-
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 2a1cecbde0a4..ebcd2ea3091f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,16 +21,90 @@
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
+
+void topology_scale_freq_tick(void)
+{
+	struct scale_freq_data *sfd = *this_cpu_ptr(&sft_data);
+
+	if (sfd)
+		sfd->set_freq_scale();
+}
+
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
@@ -47,7 +121,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 	 * want to update the scale factor with information from CPUFREQ.
 	 * Instead the scale factor will be updated from arch_scale_freq_tick.
 	 */
-	if (arch_freq_counters_available(cpus))
+	if (supports_scale_freq_counters(cpus))
 		return;
 
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 583af517f123..11e555cfaecb 100644
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

