Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5670307420
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhA1KvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 05:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhA1Ku0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 05:50:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21BC06178A
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:49:16 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g15so4028090pgu.9
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+QOr1VBBcxpq3+IMij9FpJeiD8f73FNY2Kz24AK/Wc=;
        b=boxBbuqgiTCbUWDf1FToigoIJinavf1kTBx3JfE3e7NyJvNVGvUf/cVAbJaaaUR8u7
         ln3FONqnWTVk61MzzTGasRh/zXq0MC8bKg9dxRG+laJ6e9UFsy5Ewsj3KpXH5rCzf8N0
         YvSrEDGoAg4hR/uGvM9kC+KEjKdkvM3wFrKFBCOidx5r+TUbBAXY5U3wNDhsqd3+0k2z
         9TTCVmJ4vJ5CAaynyIZbXLNyOMu8HioEcVh8CF5MaifBLpsYpL6i+8Kc0gW7gVDJtYS6
         /U3jbgDDFJmKz4x37KDUJcyxl5WAIrmQ/yR+jp5nwhaI9ktTj0dNiSuHrLQfx/cUEBHi
         6D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+QOr1VBBcxpq3+IMij9FpJeiD8f73FNY2Kz24AK/Wc=;
        b=GGgozqSwgWvw2TAMUV6keZKf1D/Zy0jKanLAaFu9mm8lBj1lpViojZwS54rvxnu5ql
         yxfx7IOHzx1/zAoU3l731cX/Xly+QqmUPkvGzvqFcroPDZfitMo2nn5qjd2QJPu+jVZy
         wCwXcoYUaNYES0bvaJmtarxuT5D223uzMO8eDn63bNJGxOqs1KQkusqhSyeGfH5VkLSM
         Js2OjRYL/hdMSVaiLIiMKXB/73i0EiBk/MxLseBQbgMLmxyknpxOSwRtGWk0mWJ9NCU3
         DKOmcxe5gmM7rXrjH2Ox4E/O/D98Z03bvHjxWOseEP33ZzOVlPr6plnyB08b00nagmnc
         2zjA==
X-Gm-Message-State: AOAM5329aLNUQUDgXhMnGKe59E6xQbcd7qNbWZxxbRJSBuMfaHdwy9dv
        FMmUWxJTNBDvh6Wfb+uKlG7gXNkO9Hv3oA==
X-Google-Smtp-Source: ABdhPJzh4Uw0k03IPIzIndYwNY75r22pmThXYrnKRrv8iCOSUjqNTXMYub3VUqLQPKccvbDiXjBhzw==
X-Received: by 2002:a62:2c50:0:b029:1b9:1846:b490 with SMTP id s77-20020a622c500000b02901b91846b490mr15096356pfs.76.1611830955926;
        Thu, 28 Jan 2021 02:49:15 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s21sm4763597pjz.13.2021.01.28.02.49.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 02:49:15 -0800 (PST)
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
Subject: [PATCH V3 2/2] cpufreq: cppc: Add support for frequency invariance
Date:   Thu, 28 Jan 2021 16:18:56 +0530
Message-Id: <59f48538545d080cb1c7b201d2d779ab513d2c0c.1611829953.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611829953.git.viresh.kumar@linaro.org>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Frequency Invariance Engine (FIE) is providing a frequency scaling
correction factor that helps achieve more accurate load-tracking.

Normally, this scaling factor can be obtained directly with the help of
the cpufreq drivers as they know the exact frequency the hardware is
running at. But that isn't the case for CPPC cpufreq driver.

Another way of obtaining that is using the arch specific counter
support, which is already present in kernel, but that hardware is
optional for platforms.

This patch thus obtains this scaling factor using the existing logic
present in the cppc driver. Note that the arch specific counters have
higher priority than CPPC counters if available, though the CPPC driver
doesn't need to have any special handling for that.

This also exports sched_setattr_nocheck() as the CPPC driver can be
built as a module.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 179 ++++++++++++++++++++++++++++++---
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 3 files changed, 169 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8a482c434ea6..53815f6d2797 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -10,14 +10,18 @@
 
 #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
 
+#include <linux/arch_topology.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
+#include <linux/irq_work.h>
+#include <linux/kthread.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
+#include <uapi/linux/sched/types.h>
 
 #include <asm/unaligned.h>
 
@@ -39,6 +43,17 @@ static LIST_HEAD(cpu_data_list);
 
 static bool boost_supported;
 
+struct cppc_freq_invariance {
+	struct kthread_worker *worker;
+	struct irq_work irq_work;
+	struct kthread_work work;
+	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
+	struct cppc_cpudata *cpu_data;
+	unsigned int max_freq;
+};
+
+static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_f_i);
+
 struct cppc_workaround_oem_info {
 	char oem_id[ACPI_OEM_ID_SIZE + 1];
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
@@ -292,7 +307,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
-	int ret;
+	int ret, i;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
 	if (!cpu_data) {
@@ -343,6 +358,11 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -EFAULT;
 	}
 
+	for_each_cpu(i, policy->cpus) {
+		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
+		per_cpu(cppc_f_i, i).cpu_data = cpu_data;
+	}
+
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
@@ -370,12 +390,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf, delivered_perf;
+	u64 reference_perf;
 
 	reference_perf = fb_ctrs_t0.reference_perf;
 
@@ -385,11 +405,20 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 				    fb_ctrs_t0.delivered);
 
 	/* Check to avoid divide-by zero */
-	if (delta_reference || delta_delivered)
-		delivered_perf = (reference_perf * delta_delivered) /
-					delta_reference;
-	else
-		delivered_perf = cpu_data->perf_ctrls.desired_perf;
+	if (!delta_reference && !delta_delivered)
+		return cpu_data->perf_ctrls.desired_perf;
+
+	return (reference_perf * delta_delivered) / delta_reference;
+}
+
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delivered_perf;
+
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
+					       fb_ctrs_t1);
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -420,7 +449,7 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	int ret;
+	int ret, i;
 
 	if (!boost_supported) {
 		pr_err("BOOST not supported by CPU or firmware\n");
@@ -435,6 +464,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 						       caps->nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
+	for_each_cpu(i, policy->related_cpus)
+		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
+
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
 	if (ret < 0)
 		return ret;
@@ -512,8 +544,126 @@ static void cppc_check_hisi_workaround(void)
 	acpi_put_table(tbl);
 }
 
+static void cppc_scale_freq_workfn(struct kthread_work *work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	int cpu = raw_smp_processor_id();
+	struct cppc_cpudata *cpu_data;
+	u64 perf;
+
+	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
+	cpu_data = cppc_fi->cpu_data;
+
+	if (cppc_get_perf_ctrs(cpu, &fb_ctrs)) {
+		pr_info("%s: cppc_get_perf_ctrs() failed\n", __func__);
+		return;
+	}
+
+	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+	perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
+				     fb_ctrs);
+
+	perf <<= SCHED_CAPACITY_SHIFT;
+	per_cpu(freq_scale, cpu) = div64_u64(perf, cpu_data->perf_caps.highest_perf);
+}
+
+static void cppc_irq_work(struct irq_work *irq_work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+
+	cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
+	kthread_queue_work(cppc_fi->worker, &cppc_fi->work);
+}
+
+static void cppc_scale_freq_tick(void)
+{
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_f_i, raw_smp_processor_id());
+
+	/*
+	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
+	 * context.
+	 */
+	irq_work_queue(&cppc_fi->irq_work);
+}
+
+static struct scale_freq_data cppc_sftd = {
+	.source = SCALE_FREQ_SOURCE_CPPC,
+	.set_freq_scale = cppc_scale_freq_tick,
+};
+
+static void cppc_freq_invariance_exit(void)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int i;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
+
+	for_each_possible_cpu(i) {
+		cppc_fi = &per_cpu(cppc_f_i, i);
+		if (cppc_fi->worker) {
+			irq_work_sync(&cppc_fi->irq_work);
+			kthread_destroy_worker(cppc_fi->worker);
+			cppc_fi->worker = NULL;
+		}
+	}
+}
+
+static void __init cppc_freq_invariance_init(void)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_freq_invariance *cppc_fi;
+	struct sched_attr attr = {
+		.size		= sizeof(struct sched_attr),
+		.sched_policy	= SCHED_DEADLINE,
+		.sched_nice	= 0,
+		.sched_priority	= 0,
+		/*
+		 * Fake (unused) bandwidth; workaround to "fix"
+		 * priority inheritance.
+		 */
+		.sched_runtime	= 1000000,
+		.sched_deadline = 10000000,
+		.sched_period	= 10000000,
+	};
+	struct kthread_worker *worker;
+	int i, ret;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	for_each_possible_cpu(i) {
+		cppc_fi = &per_cpu(cppc_f_i, i);
+
+		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+		worker = kthread_create_worker_on_cpu(i, 0, "cppc:%d", i);
+		if (IS_ERR(worker))
+			return cppc_freq_invariance_exit();
+
+		cppc_fi->worker = worker;
+		ret = sched_setattr_nocheck(worker->task, &attr);
+		if (ret) {
+			pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
+			return cppc_freq_invariance_exit();
+		}
+
+		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
+		if (!ret)
+			per_cpu(cppc_fi->prev_perf_fb_ctrs, i) = fb_ctrs;
+	}
+
+	/* Register for freq-invariance */
+	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
+}
+
 static int __init cppc_cpufreq_init(void)
 {
+	int ret;
+
 	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
@@ -521,7 +671,11 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_check_hisi_workaround();
 
-	return cpufreq_register_driver(&cppc_cpufreq_driver);
+	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (!ret)
+		cppc_freq_invariance_init();
+
+	return ret;
 }
 
 static inline void free_cpu_data(void)
@@ -538,6 +692,7 @@ static inline void free_cpu_data(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	cppc_freq_invariance_exit();
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	free_cpu_data();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3bcfba5c21a7..47ac4b41c28d 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -37,6 +37,7 @@ bool topology_scale_freq_invariant(void);
 enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
+	SCALE_FREQ_SOURCE_CPPC,
 };
 
 struct scale_freq_data {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8c5481077c9c..85d1d23951ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6190,6 +6190,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.25.0.rc1.19.g042ed3e048af

