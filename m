Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EA219D47
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 12:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGIKOU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgGIKOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 06:14:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC6C08C5CE
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 03:14:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so902055pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DVzPsDvdzI3pfZi3ttDIdjoa2spBp2jugfimMjUizA=;
        b=s84x2/l5q8rCICBOzSZvWMvVvbZ7ObguAovTe61cN5R3UPCXb0P+TJUQ4u5jxFKhU6
         a9sBTVIdxNjpUJKAxdBjsaexNriXSn1yxqJYh+84DTgKnFOCa3wJoTbt/ohkpNu71Nlo
         ypw4+wPAgFLIj2AFH6HcS3geUZJvmonfPGPuYxD2SU7OtH964bleAQFbgov9X/mniCuF
         4J0GRG60qDPERq7HvzCGvRD60Vz/3z/BollSVEq0Lv/s709w/i6gu4jUjTR2HFrEuIu7
         LLWDUlSHb9AjfhqXBkdMI2OYT/W4OSJS9MszKVDFyW78sVcGDlXqmf/uTk1QgHlmO1GB
         uGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DVzPsDvdzI3pfZi3ttDIdjoa2spBp2jugfimMjUizA=;
        b=o+kxJLeFl9Oz4TkZVjwAHAU2aNDt53hx+s5+UOgSvI5WUChr7VUS2uM6DypvhEz7xG
         U1OasdsWrKaMvX7F5fa6/KVfaJjRmO6Rk/kMiMnyxtMf+WipUntmDLBUAJZtXZi3TLiC
         1RQOzFJrEx3DzyDS5qez+NT/Ou+WCXOz+HQQkf5vcVgp1qNsTsxaynLT8saaf7TCBRDo
         kb8c1qcfcrC5N45T7eHm1QlucGPY31Y0Z/ilgNr9+8dvhLO6bU1QOykt3AzNI3m6lSUb
         87uqT0wpkyiksTx+GwU6y6bGepQXiJuAJ4t04FR/wvIYhPaKmxlpbaIrNlib0Glfriio
         4vYQ==
X-Gm-Message-State: AOAM533IOKajdnaOwNpzVxwEYmq1UuV4/5E93nGQQ82hBsP1akWcj3ma
        jzC+klLG7PLtnTC97rqvq20HPQ==
X-Google-Smtp-Source: ABdhPJxx87GjwgsSLhN5rLzS2vlMmrUHitUtGzITAm3Lg+av9NA83QB7O4FThN/N7r8WBSbgJSrSMQ==
X-Received: by 2002:a17:90a:ff09:: with SMTP id ce9mr13202286pjb.149.1594289654938;
        Thu, 09 Jul 2020 03:14:14 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id j36sm2433858pgj.39.2020.07.09.03.14.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:14:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Puhov <peter.puhov@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 3/3] cpufreq: cppc: Add support for frequency invariance
Date:   Thu,  9 Jul 2020 15:43:35 +0530
Message-Id: <49818b46ccc5d29b3009ad15513bd6a0bc5a8767.1594289009.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1594289009.git.viresh.kumar@linaro.org>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Frequency Invariance Engine (FIE) is providing a frequency scaling
correction factor that helps achieve more accurate load-tracking.

Normally, this scaling factor can be obtained directly with the help of
the cpufreq drivers as they know the exact frequency the hardware is
running at. But that isn't the case for CPPC driver.

Another way of obtaining that is using the AMU counter support, which is
already present in kernel, but that hardware is optional for platforms
and few of the platforms lack it.

This patch thus obtains this scaling factor using the existing logic
present in the cppc driver. This checks if the AMU counters are
available or not on the platform, if not it goes ahead and registers
itself for frequency invariance, else it lets AMU stuff come in later
and take it over.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 138 ++++++++++++++++++++++++++++++++-
 kernel/sched/core.c            |   1 +
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f29e8d0553a8..d08c5852f4c4 100644
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
 
@@ -39,6 +43,17 @@
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
+static bool scale_freq_tick_registered;
+
 struct cppc_workaround_oem_info {
 	char oem_id[ACPI_OEM_ID_SIZE + 1];
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
@@ -274,6 +289,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 */
 	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_perf);
 	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
+	per_cpu(cppc_f_i, cpu_num).max_freq = policy->cpuinfo.max_freq;
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
 	policy->shared_type = cpu->shared_type;
@@ -287,6 +303,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			if (unlikely(i == policy->cpu))
 				continue;
 
+			per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
 			memcpy(&all_cpu_data[i]->perf_caps, &cpu->perf_caps,
 			       sizeof(cpu->perf_caps));
 		}
@@ -372,7 +389,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpudata;
-	int ret;
+	int ret, i;
 
 	if (!boost_supported) {
 		pr_err("BOOST not supported by CPU or firmware\n");
@@ -388,6 +405,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 					cpudata->perf_caps.nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
+	for_each_cpu(i, policy->related_cpus)
+		per_cpu(cppc_f_i, i).max_freq = policy->cpuinfo.max_freq;
+
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
 	if (ret < 0)
 		return ret;
@@ -448,6 +468,117 @@ static void cppc_check_hisi_workaround(void)
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
+static void cppc_freq_invariance_exit(void)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int i;
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
+extern bool amu_counters_supported(void);
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
+	/* Lets use the AMU counters if they are supported */
+	if (amu_counters_supported())
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
+	if (cppc_cpufreq_driver.get != hisi_cppc_cpufreq_get_rate &&
+	    !topology_set_scale_freq_tick(cppc_scale_freq_tick, cpu_possible_mask)) {
+		scale_freq_tick_registered = true;
+		pr_info("Registered cppc_scale_freq_tick()\n");
+	}
+}
+
 static int __init cppc_cpufreq_init(void)
 {
 	int i, ret = 0;
@@ -483,6 +614,8 @@ static int __init cppc_cpufreq_init(void)
 	if (ret)
 		goto out;
 
+	cppc_freq_invariance_init();
+
 	return ret;
 
 out:
@@ -503,6 +636,9 @@ static void __exit cppc_cpufreq_exit(void)
 	struct cppc_cpudata *cpu;
 	int i;
 
+	if (scale_freq_tick_registered)
+		cppc_freq_invariance_exit();
+
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	for_each_possible_cpu(i) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..a5eeb8f499a4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5143,6 +5143,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.25.0.rc1.19.g042ed3e048af

