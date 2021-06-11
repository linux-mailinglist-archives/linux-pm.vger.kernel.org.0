Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782233A3A32
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 05:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhFKDUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhFKDUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 23:20:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F460C061574
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 20:18:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e20so1374599pgg.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 20:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQq5Dh1D7csPQCkLl89bY9rga8HgYY3LoG4lnjU2NhE=;
        b=vGUtarCuwZUsqWeaaS3FUBgvwal6vuVsgkrJTqMj1JCnB/70pRocbySlrLrbWXkIzi
         Mh7nCWPRK6v4eWrHGmajKj6xFwv4yqSmsC+BeWK1Hz+oDHYIEl6X65qsGwlFvRXN9Bme
         3j+KzFcQ5KIr0plrdQ9LHVSgAjR0qz5Ipw+7KMJS7b9NAQLE74qtIFMLVM0DRJuVQeKR
         3Sp8hiSFAjkyG5m3x+g9UHDipY4sz41fw7wXdIpBfjnxLceazOyJeNpqUh/hhM2X2gE/
         G6kg2ilkJ9mnJOadcDys0ZTC/VKNVaY6pPh+FtHwhgTm7aMNKdkHhVlw31xPFyarksXN
         M6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQq5Dh1D7csPQCkLl89bY9rga8HgYY3LoG4lnjU2NhE=;
        b=emLySofDXtPf3qQOTDt3TXLAb6nH1flrCCc3Vc/BsicYQyzelfr7pkFFflUFue7o+U
         +1J8yZvwIDGTrqkUvGbDs+CRSIv8VQb1IcwANy6q8Dg7IEdIK7FEioTeAs4d6hk3/c+t
         6egLmd8eHWVmmQFFd3i32XFYvGryxf8QPcqPFQHLs8+9l4bIixnSfMYvEyMzEc1TSbSE
         rxmgYNRRS4s9UbMVVNbLbwVLtEUR+/7Em4mNoF6RgpNCwHz1UbCD43cfZNEiLlKZ1eyQ
         wDzKNoQgOpX6yl8MA90EfctQnQlkXTIYZoFUu+zkTceBJnQ49kICs4eeooFHwm6ooNE3
         Zikw==
X-Gm-Message-State: AOAM532Tp5lb3lSF3O/5ZntV9FPLcWHDKsx2omdduVheGoOqq0NfpdEA
        Y1PaQuMfpmlJPkczuF0tvz4cGQ==
X-Google-Smtp-Source: ABdhPJx49AFpBoYmHBmHYmV+nscIsogMvpAA3i2Z1N7nmbu82emujYKL+5jWSll1O7rCWU82oRTpfA==
X-Received: by 2002:a62:d447:0:b029:291:19f7:ddcd with SMTP id u7-20020a62d4470000b029029119f7ddcdmr6151677pfl.54.1623381486544;
        Thu, 10 Jun 2021 20:18:06 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id p26sm3561237pfw.178.2021.06.10.20.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:18:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] Revert "cpufreq: CPPC: Add support for frequency invariance"
Date:   Fri, 11 Jun 2021 08:48:02 +0530
Message-Id: <a71c48fb0150f505680da68a82b4e4fca9a18439.1623381430.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 4c38f2df71c8e33c0b64865992d693f5022eeaad.

There are few races in the frequency invariance support for CPPC driver,
namely the driver doesn't stop the kthread_work and irq_work on policy
exit during suspend/resume or CPU hotplug.

A proper fix won't be possible for the 5.13-rc, as it requires a lot of
changes. Lets revert the patch instead for now.

Fixes: 4c38f2df71c8 ("cpufreq: CPPC: Add support for frequency invariance")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Revert the original patch instead of marking it broken.

 drivers/cpufreq/Kconfig.arm    |  10 --
 drivers/cpufreq/cppc_cpufreq.c | 245 ++-------------------------------
 include/linux/arch_topology.h  |   1 -
 kernel/sched/core.c            |   1 -
 4 files changed, 12 insertions(+), 245 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a5c5f70acfc9..e65e0a43be64 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -19,16 +19,6 @@ config ACPI_CPPC_CPUFREQ
 
 	  If in doubt, say N.
 
-config ACPI_CPPC_CPUFREQ_FIE
-	bool "Frequency Invariance support for CPPC cpufreq driver"
-	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
-	default y
-	help
-	  This extends frequency invariance support in the CPPC cpufreq driver,
-	  by using CPPC delivered and reference performance counters.
-
-	  If in doubt, say N.
-
 config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
 	depends on ARCH_SUNXI
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3848b4c222e1..2f769b1630c5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -10,18 +10,14 @@
 
 #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
 
-#include <linux/arch_topology.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
-#include <linux/irq_work.h>
-#include <linux/kthread.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
-#include <uapi/linux/sched/types.h>
 
 #include <asm/unaligned.h>
 
@@ -61,204 +57,6 @@ static struct cppc_workaround_oem_info wa_info[] = {
 	}
 };
 
-#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
-
-/* Frequency invariance support */
-struct cppc_freq_invariance {
-	int cpu;
-	struct irq_work irq_work;
-	struct kthread_work work;
-	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
-	struct cppc_cpudata *cpu_data;
-};
-
-static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
-static struct kthread_worker *kworker_fie;
-static bool fie_disabled;
-
-static struct cpufreq_driver cppc_cpufreq_driver;
-static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
-static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
-				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				 struct cppc_perf_fb_ctrs fb_ctrs_t1);
-
-/**
- * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
- * @work: The work item.
- *
- * The CPPC driver register itself with the topology core to provide its own
- * implementation (cppc_scale_freq_tick()) of topology_scale_freq_tick() which
- * gets called by the scheduler on every tick.
- *
- * Note that the arch specific counters have higher priority than CPPC counters,
- * if available, though the CPPC driver doesn't need to have any special
- * handling for that.
- *
- * On an invocation of cppc_scale_freq_tick(), we schedule an irq work (since we
- * reach here from hard-irq context), which then schedules a normal work item
- * and cppc_scale_freq_workfn() updates the per_cpu arch_freq_scale variable
- * based on the counter updates since the last tick.
- */
-static void cppc_scale_freq_workfn(struct kthread_work *work)
-{
-	struct cppc_freq_invariance *cppc_fi;
-	struct cppc_perf_fb_ctrs fb_ctrs = {0};
-	struct cppc_cpudata *cpu_data;
-	unsigned long local_freq_scale;
-	u64 perf;
-
-	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
-	cpu_data = cppc_fi->cpu_data;
-
-	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
-		pr_warn("%s: failed to read perf counters\n", __func__);
-		return;
-	}
-
-	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
-	perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
-				     fb_ctrs);
-
-	perf <<= SCHED_CAPACITY_SHIFT;
-	local_freq_scale = div64_u64(perf, cpu_data->perf_caps.highest_perf);
-	if (WARN_ON(local_freq_scale > 1024))
-		local_freq_scale = 1024;
-
-	per_cpu(arch_freq_scale, cppc_fi->cpu) = local_freq_scale;
-}
-
-static void cppc_irq_work(struct irq_work *irq_work)
-{
-	struct cppc_freq_invariance *cppc_fi;
-
-	cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
-	kthread_queue_work(kworker_fie, &cppc_fi->work);
-}
-
-static void cppc_scale_freq_tick(void)
-{
-	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
-
-	/*
-	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
-	 * context.
-	 */
-	irq_work_queue(&cppc_fi->irq_work);
-}
-
-static struct scale_freq_data cppc_sftd = {
-	.source = SCALE_FREQ_SOURCE_CPPC,
-	.set_freq_scale = cppc_scale_freq_tick,
-};
-
-static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
-					     struct cppc_cpudata *cpu_data)
-{
-	struct cppc_perf_fb_ctrs fb_ctrs = {0};
-	struct cppc_freq_invariance *cppc_fi;
-	int i, ret;
-
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
-		return;
-
-	if (fie_disabled)
-		return;
-
-	for_each_cpu(i, policy->cpus) {
-		cppc_fi = &per_cpu(cppc_freq_inv, i);
-		cppc_fi->cpu = i;
-		cppc_fi->cpu_data = cpu_data;
-		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
-		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
-
-		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
-		if (ret) {
-			pr_warn("%s: failed to read perf counters: %d\n",
-				__func__, ret);
-			fie_disabled = true;
-		} else {
-			cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
-		}
-	}
-}
-
-static void __init cppc_freq_invariance_init(void)
-{
-	struct sched_attr attr = {
-		.size		= sizeof(struct sched_attr),
-		.sched_policy	= SCHED_DEADLINE,
-		.sched_nice	= 0,
-		.sched_priority	= 0,
-		/*
-		 * Fake (unused) bandwidth; workaround to "fix"
-		 * priority inheritance.
-		 */
-		.sched_runtime	= 1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
-	};
-	int ret;
-
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
-		return;
-
-	if (fie_disabled)
-		return;
-
-	kworker_fie = kthread_create_worker(0, "cppc_fie");
-	if (IS_ERR(kworker_fie))
-		return;
-
-	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
-	if (ret) {
-		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
-			ret);
-		kthread_destroy_worker(kworker_fie);
-		return;
-	}
-
-	/* Register for freq-invariance */
-	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
-}
-
-static void cppc_freq_invariance_exit(void)
-{
-	struct cppc_freq_invariance *cppc_fi;
-	int i;
-
-	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
-		return;
-
-	if (fie_disabled)
-		return;
-
-	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
-
-	for_each_possible_cpu(i) {
-		cppc_fi = &per_cpu(cppc_freq_inv, i);
-		irq_work_sync(&cppc_fi->irq_work);
-	}
-
-	kthread_destroy_worker(kworker_fie);
-	kworker_fie = NULL;
-}
-
-#else
-static inline void
-cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
-				 struct cppc_cpudata *cpu_data)
-{
-}
-
-static inline void cppc_freq_invariance_init(void)
-{
-}
-
-static inline void cppc_freq_invariance_exit(void)
-{
-}
-#endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
-
 /* Callback function used to retrieve the max frequency from DMI */
 static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 {
@@ -547,12 +345,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret) {
+	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
-	} else {
-		cppc_freq_invariance_policy_init(policy, cpu_data);
-	}
 
 	return ret;
 }
@@ -565,12 +360,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
-				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				 struct cppc_perf_fb_ctrs fb_ctrs_t1)
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf;
+	u64 reference_perf, delivered_perf;
 
 	reference_perf = fb_ctrs_t0.reference_perf;
 
@@ -579,21 +374,12 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 	delta_delivered = get_delta(fb_ctrs_t1.delivered,
 				    fb_ctrs_t0.delivered);
 
-	/* Check to avoid divide-by zero and invalid delivered_perf */
-	if (!delta_reference || !delta_delivered)
-		return cpu_data->perf_ctrls.desired_perf;
-
-	return (reference_perf * delta_delivered) / delta_reference;
-}
-
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
-{
-	u64 delivered_perf;
-
-	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
-					       fb_ctrs_t1);
+	/* Check to avoid divide-by zero */
+	if (delta_reference || delta_delivered)
+		delivered_perf = (reference_perf * delta_delivered) /
+					delta_reference;
+	else
+		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -718,8 +504,6 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
-	int ret;
-
 	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
@@ -727,11 +511,7 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_check_hisi_workaround();
 
-	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-	if (!ret)
-		cppc_freq_invariance_init();
-
-	return ret;
+	return cpufreq_register_driver(&cppc_cpufreq_driver);
 }
 
 static inline void free_cpu_data(void)
@@ -748,7 +528,6 @@ static inline void free_cpu_data(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	cppc_freq_invariance_exit();
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	free_cpu_data();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index f180240dc95f..11e555cfaecb 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -37,7 +37,6 @@ bool topology_scale_freq_invariant(void);
 enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
-	SCALE_FREQ_SOURCE_CPPC,
 };
 
 struct scale_freq_data {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..4ca80df205ce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6389,7 +6389,6 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
-EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.31.1.272.g89b43f80a514

