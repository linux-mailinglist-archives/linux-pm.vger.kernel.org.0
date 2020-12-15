Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB872DABC5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgLOLSo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 06:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgLOLSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 06:18:25 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E875C0617A7
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 03:17:33 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x18so4754640pln.6
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 03:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6++dMGM1FCC5pOaCFzsM+Us3BSilGScrEfoUSQ6anmM=;
        b=vMn03ETfI15mhXTc/u6kRPMA7u+C9RVBlTviPSBGG78sPfY/32VWaY8PoT8hn718hR
         5bfFCcFvM/b3aImkJ/gYzidODEHpiQcfW61I77yZBG5xjOTC82Wa6kjpHkejtt1mqOR5
         Aa1abKCgqrGK9fymjybug0aw/ZNLNXkr6QsAx6iz+t4yM/Yq8rRKxSY5T5iCvfNoM2bQ
         KYbE5l7n/Aju8gsYGYIDeOOepdyBWFXT+VTb6Fk0lrPaRGSpLwxms+2OlzrWXgizEoYh
         xrJNS4Nc2Io0LasuDjqIzfRRIzDmZ9YSXGfe6jT6G11kBbe8cYZggSe8y44kzv1xrk8k
         BWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6++dMGM1FCC5pOaCFzsM+Us3BSilGScrEfoUSQ6anmM=;
        b=tyTo0l0n1UTyKSiXhRPZd9Osq0gAL0WWj6/c6aYy7MULQuaaQ6P1X1js5FjsAJ1TQk
         ++MX1Ao+G17UHG8sj2krIxkrt6JysBxKV570Vx5VoxT967mP/BxWPww3QnTDtdPKdSPT
         ZO6Fu3HOLV6P5F9wtTCqs30IxCZxVDuU0msU+7IjbfYEKwBRdz7vhoOMYR6oE4NqUEb3
         tD7wz+ltMOMZ42BTvWIeujjR8/HYDiq7kr0uB69rG4JMVyyWiGfQ084OJq6tr4rQhiR2
         GwdBvinkqVirlSYuqg8lEPkG5CEmtkR1ykLaTVbm0vaIEgf/6ZP0V+TDaE7asJa+8uU6
         Ihyw==
X-Gm-Message-State: AOAM530KxQzbUhb1OiGWm/ClDyndzQtmvVJt/w/9PXMENbjtvLvD1mGL
        FTFu36cQ2lruF1SUokE1pkBx2g==
X-Google-Smtp-Source: ABdhPJxekiCucfTOMCe9TtyUvabyXTd1Y7OA4VDtveI+/WBlY9GEOHLKr+dPSXZco+Q2ITWzqDzKEw==
X-Received: by 2002:a17:90a:6604:: with SMTP id l4mr12001617pjj.119.1608031053176;
        Tue, 15 Dec 2020 03:17:33 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id n68sm24405883pfn.161.2020.12.15.03.17.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:17:32 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC V2 2/2] cpufreq: cppc: Add support for frequency invariance
Date:   Tue, 15 Dec 2020 16:46:36 +0530
Message-Id: <069c40c173fc391116d13d60f4c1382c47e1a05a.1608030508.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1608030508.git.viresh.kumar@linaro.org>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
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

Another way of obtaining that is using the AMU counter support, which is
already present in kernel, but that hardware is optional for platforms.

This patch thus obtains this scaling factor using the existing logic
present in the cppc driver. Note that the AMUs have higher priority than
CPPC counters if available, though the CPPC driver doesn't need to have
any special handling for that.

This also exports sched_setattr_nocheck() as the CPPC driver can be
built as a module.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 140 ++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7cc9bd8568de..a739e20aefd6 100644
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
 
@@ -39,6 +43,15 @@
 static struct cppc_cpudata **all_cpu_data;
 static bool boost_supported;
 
+struct cppc_freq_invariance {
+	struct kthread_worker *worker;
+	struct irq_work irq_work;
+	struct kthread_work work;
+	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
+	unsigned int max_freq;
+};
+static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_f_i);
+
 struct cppc_workaround_oem_info {
 	char oem_id[ACPI_OEM_ID_SIZE + 1];
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
@@ -243,7 +256,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
-	int ret = 0;
+	int ret = 0, i;
 
 	cpu_data->cpu = cpu;
 	ret = cppc_get_perf_caps(cpu, caps);
@@ -300,6 +313,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu_data->cur_policy = policy;
 
+	for_each_cpu(i, policy->cpus)
+		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
+
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
@@ -374,7 +390,7 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	int ret;
+	int ret, i;
 
 	if (!boost_supported) {
 		pr_err("BOOST not supported by CPU or firmware\n");
@@ -389,6 +405,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 						       caps->nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
+	for_each_cpu(i, policy->related_cpus)
+		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
+
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
 	if (ret < 0)
 		return ret;
@@ -449,6 +468,120 @@ static void cppc_check_hisi_workaround(void)
 	acpi_put_table(tbl);
 }
 
+static void cppc_scale_freq_tick_workfn(struct kthread_work *work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	int cpu = raw_smp_processor_id();
+	struct cppc_cpudata *cpudata = all_cpu_data[cpu];
+	u64 rate;
+
+	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
+
+	if (cppc_get_perf_ctrs(cpu, &fb_ctrs)) {
+		pr_info("%s: cppc_get_perf_ctrs() failed\n", __func__);
+		return;
+	}
+
+	rate = cppc_get_rate_from_fbctrs(cpudata, cppc_fi->prev_perf_fb_ctrs, fb_ctrs);
+	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+
+	rate <<= SCHED_CAPACITY_SHIFT;
+	per_cpu(freq_scale, cpu) = div64_u64(rate, cppc_fi->max_freq);
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
+static struct scale_freq_tick_data cppc_sftd = {
+	.source = SCALE_FREQ_SOURCE_CPPC,
+	.scale_freq = cppc_scale_freq_tick,
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
+	topology_clear_scale_freq_tick(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
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
+		kthread_init_work(&cppc_fi->work, cppc_scale_freq_tick_workfn);
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
+	topology_set_scale_freq_tick(&cppc_sftd, cpu_present_mask);
+}
+
 static int __init cppc_cpufreq_init(void)
 {
 	struct cppc_cpudata *cpu_data;
@@ -484,6 +617,8 @@ static int __init cppc_cpufreq_init(void)
 	if (ret)
 		goto out;
 
+	cppc_freq_invariance_init();
+
 	return ret;
 
 out:
@@ -504,6 +639,7 @@ static void __exit cppc_cpufreq_exit(void)
 	struct cppc_cpudata *cpu_data;
 	int i;
 
+	cppc_freq_invariance_exit();
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	for_each_possible_cpu(i) {
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index b2422ebef2dd..09205b584ca5 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -36,6 +36,7 @@ bool topology_scale_freq_invariant(void);
 
 enum scale_freq_tick_source {
 	SCALE_FREQ_SOURCE_AMU,
+	SCALE_FREQ_SOURCE_CPPC,
 };
 
 struct scale_freq_tick_data {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51514eef0a9d..76b2fa1a7aaa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6075,6 +6075,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.25.0.rc1.19.g042ed3e048af

