Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4535530741E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 11:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhA1Kuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 05:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhA1Ku0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 05:50:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70934C061788
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:49:12 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id j12so3723470pfj.12
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97yz6l0kLDIbGcIxD71cn/hPxZItkULobNVAO0iER9c=;
        b=dHI5xIfWdsJ+jWKdyY4VLsX8HrTU4Ndfjue0nerF2/CU1IdyUGT01b/j5AZgqlzrnJ
         NzP6slwCGvhr7jy9+6cGnj29q8AkvyA+uzj+S/qQC83lSthESFgyfogSKuCWuneN6Gv/
         40iY55mp0nybnSSX+EboS2C7ol0PP87yAD5mH5HJW2SH+nHRc+O+5HUNceGT7T3tvc0K
         a7P3ZzbNm0OU+1gwFTGWJKI9KytDgL5d7D1rnGccxzr2KGMkLu972JmVMb2OfeP8kjQb
         QYNmizfTpOXm0RJy7FYyS4Y+oaYcPAMFkZGZonHHZ969oqTyzfkZVfLMus/BfSXVWDP5
         l8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97yz6l0kLDIbGcIxD71cn/hPxZItkULobNVAO0iER9c=;
        b=De7AuZB3UWlSA8hthm+QK8uZMTu9OByB4cfzgPR8j2A3qsgwwqULx0lEYUnstVVKhA
         XFaUsFuv0mvufKDxk95DdD1ZT+aL+W5htK+5BwURCHAw7P1cF10aeJZVDN1B2Jhwz6Ue
         UHJe/VBLSHNU5fKuh1lbW8XIrTeKL7GzPH7HgBKyOMxk9ceG4IfMGmOiO0wD89qkIwFe
         QUSUOtD6MMmh+DuWT6wYEeIYR9i+ZsYVKkOcs8ihgitxnGgQ1pUN7DBthYL7puDFrGBL
         y6c9VgLSsbWaZz+7AX7CRcbqsAzQd4HGfhJxgO/DLziHkUtQkuf6d2M/++Ywj9PGbROw
         A9oA==
X-Gm-Message-State: AOAM533i8YD10+nmyJk18+qoC+k7p48d7Gwh2RtMBNdGQvKGBrq4faUq
        NfuPuGQ/Gp5bs6bFgb9j3cH+sg==
X-Google-Smtp-Source: ABdhPJzXLzSV+BUrNo/bm3UweLs8RDbKETLmPqCea7nR3DhSO6uHdABf7GzdXNssZ+kGuJOTv9viiA==
X-Received: by 2002:a65:6a12:: with SMTP id m18mr15605904pgu.178.1611830951994;
        Thu, 28 Jan 2021 02:49:11 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id r14sm5790996pgi.27.2021.01.28.02.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 02:49:11 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH V3 1/2] topology: Allow multiple entities to provide sched_freq_tick() callback
Date:   Thu, 28 Jan 2021 16:18:55 +0530
Message-Id: <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611829953.git.viresh.kumar@linaro.org>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch attempts to make it generic enough so other parts of the
kernel can also provide their own implementation of scale_freq_tick()
callback, which is called by the scheduler periodically to update the
per-cpu freq_scale variable.

The implementations now need to provide struct scale_freq_data for the
CPUs for which they have hardware counters available, and a callback
gets registered for each possible CPU in a per-cpu variable.

The arch specific (or ARM AMU) counters are updated to adapt to this and
they take the highest priority if they are available, i.e. they will be
used instead of CPPC based counters for example.

Note that this also defines SCALE_FREQ_SOURCE_CPUFREQ but doesn't use it
and it is added to show that cpufreq is also acts as source of
information for FIE and will be used by default if no other counters are
supported for a platform.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/include/asm/topology.h | 10 +---
 arch/arm64/kernel/topology.c      | 89 ++++++++++++++-----------------
 drivers/base/arch_topology.c      | 56 +++++++++++++++++--
 include/linux/arch_topology.h     | 14 ++++-
 4 files changed, 105 insertions(+), 64 deletions(-)

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
index e08a4126453a..1e47dfd465f8 100644
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
+static struct scale_freq_data amu_sfd = {
+	.source = SCALE_FREQ_SOURCE_ARCH,
+	.set_freq_scale = amu_scale_freq_tick,
+};
 
 static void amu_fie_setup(const struct cpumask *cpus)
 {
@@ -227,7 +263,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
 		return;
 
-	static_branch_enable(&amu_fie_key);
+	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
 
 	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
 		 cpumask_pr_args(cpus));
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
index de8587cc119e..20b511949cd8 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,17 +21,65 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
+static struct cpumask scale_freq_counters_mask;
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
+}
+
+void topology_set_scale_freq_source(struct scale_freq_data *data,
+				    const struct cpumask *cpus)
+{
+	struct scale_freq_data *sfd;
+	int cpu;
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
 }
+EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
 
-__weak bool arch_freq_counters_available(const struct cpumask *cpus)
+void topology_clear_scale_freq_source(enum scale_freq_source source,
+				      const struct cpumask *cpus)
 {
-	return false;
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
 }
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
@@ -47,7 +95,7 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
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

