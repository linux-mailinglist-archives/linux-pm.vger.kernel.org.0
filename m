Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E51F711BE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 08:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfGWGOj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 02:14:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44472 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbfGWGOi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 02:14:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so18554775pfe.11
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfxdZKhpROdsD8TEUU0uSmTytrjjuhlMQjqVQfanDQg=;
        b=hEjEXBoEqNjml0DemynQzJhiNMoQfS3MUfI8uB/l1iStoCmt/+43B5V3mF8G1ldH3w
         Apty1XSG1DB1n+aaB6SNjHy7JHzAf73ZIsMUCybv4iLpOuuVQTPFJh9rgdaeXkQsPIPQ
         ybZEpK0OEmih9P/PWGiamnPYRLJUqLLos/yIvmAg74+GgiOwDReK1jPr6j8QBycmMYdt
         gz5wWMsvWPileZtUcLLKNp0+bH5ezgduOdNYDPAclEv8e+dPjvFEdOeHZdz9z3RXns16
         cLwLNFbszLDv4Snsk2oo0JEG68GGRQKMUskVedyFFgJTx7CLJ3fOoclP64oHdY3ttnwH
         Bz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfxdZKhpROdsD8TEUU0uSmTytrjjuhlMQjqVQfanDQg=;
        b=rSm3ER8XOKEllxABGRphZTmlHyCAhB97FAxCJ73I7M+CmgyBXc/1CZO+GtKMStXJFn
         N0Pi303oIoik3QP8Hc51QnDk6AlboSPQ95DlNvV1H7VkFRbq+Wj2neemD4D9ENXGrChu
         oRP3WCGqHoKsjNJEnz/9At8uWMAgX9zAqwwxe7pc9GaZEeCuQNwsseonTCvWsMTzMzZq
         8lyFE2qDFzaLdG85YXK7MMFFKKUDQGQEFUQzmEAhtSzWT59Dcbb8yAuA2KjxRLqxhEDt
         pVrEH0h/Z898tv7tF4cezfnXjt9UGVIuVXPuUzl6dCHXxITvU3P/z5RzwvSupO8oDx2D
         appQ==
X-Gm-Message-State: APjAAAWqGlS6bWK90uLq5+J66QL1pz0/5fOFYurahOVlIepY9TvWF05i
        AHStc4IYyQ/T9lre4gXzQ2cCdA==
X-Google-Smtp-Source: APXvYqxEY/0tEKgl4RMrbKsXYPW7lQZ8dRpTgGhF1QHWQsSta80SZSgu8LeiBZY4jUQYS0hRjABw0w==
X-Received: by 2002:a17:90a:9488:: with SMTP id s8mr82818553pjo.2.1563862477399;
        Mon, 22 Jul 2019 23:14:37 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id l26sm27326325pgb.90.2019.07.22.23.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH V2 05/10] ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
Date:   Tue, 23 Jul 2019 11:44:05 +0530
Message-Id: <86dc4a082ea00c278c0e1d7f3fcbdc4ab9af2eec.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq core now takes the min/max frequency constraints via QoS
requests and the CPUFREQ_ADJUST notifier shall get removed later on.

Switch over to using the QoS request for maximum frequency constraint
for acpi driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/acpi/processor_driver.c  |  44 +++++++++++--
 drivers/acpi/processor_perflib.c | 106 +++++++++++++------------------
 drivers/acpi/processor_thermal.c |  81 ++++++++++++-----------
 include/acpi/processor.h         |  22 ++++---
 4 files changed, 137 insertions(+), 116 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index aea8d674a33d..e7a3f07e9879 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -284,6 +284,35 @@ static int acpi_processor_stop(struct device *dev)
 	return 0;
 }
 
+bool acpi_processor_cpufreq_init;
+
+static int acpi_processor_notifier(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	struct cpufreq_policy *policy = data;
+	int cpu;
+
+	if (event == CPUFREQ_CREATE_POLICY) {
+		for_each_cpu(cpu, policy->cpus)
+			per_cpu(processors, cpu)->policy = policy;
+
+		acpi_thermal_cpufreq_init(policy);
+		acpi_processor_ppc_init(policy);
+	} else if (event == CPUFREQ_REMOVE_POLICY) {
+		acpi_processor_ppc_exit(policy);
+		acpi_thermal_cpufreq_exit(policy);
+
+		for_each_cpu(cpu, policy->cpus)
+			per_cpu(processors, cpu)->policy = NULL;
+	}
+
+	return 0;
+}
+
+static struct notifier_block acpi_processor_notifier_block = {
+	.notifier_call = acpi_processor_notifier,
+};
+
 /*
  * We keep the driver loaded even when ACPI is not running.
  * This is needed for the powernow-k8 driver, that works even without
@@ -310,8 +339,11 @@ static int __init acpi_processor_driver_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
 				  NULL, acpi_soft_cpu_dead);
 
-	acpi_thermal_cpufreq_init();
-	acpi_processor_ppc_init();
+	if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
+				       CPUFREQ_POLICY_NOTIFIER)) {
+		acpi_processor_cpufreq_init = true;
+	}
+
 	acpi_processor_throttling_init();
 	return 0;
 err:
@@ -324,8 +356,12 @@ static void __exit acpi_processor_driver_exit(void)
 	if (acpi_disabled)
 		return;
 
-	acpi_processor_ppc_exit();
-	acpi_thermal_cpufreq_exit();
+	if (acpi_processor_cpufreq_init) {
+		cpufreq_unregister_notifier(&acpi_processor_notifier_block,
+					    CPUFREQ_POLICY_NOTIFIER);
+		acpi_processor_cpufreq_init = false;
+	}
+
 	cpuhp_remove_state_nocalls(hp_online);
 	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
 	driver_unregister(&acpi_processor_driver);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index ee87cb6f6e59..1a22b2415a8b 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -50,57 +50,13 @@ module_param(ignore_ppc, int, 0644);
 MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
 		 "limited by BIOS, this should help");
 
-#define PPC_REGISTERED   1
-#define PPC_IN_USE       2
-
-static int acpi_processor_ppc_status;
-
-static int acpi_processor_ppc_notifier(struct notifier_block *nb,
-				       unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	struct acpi_processor *pr;
-	unsigned int ppc = 0;
-
-	if (ignore_ppc < 0)
-		ignore_ppc = 0;
-
-	if (ignore_ppc)
-		return 0;
-
-	if (event != CPUFREQ_ADJUST)
-		return 0;
-
-	mutex_lock(&performance_mutex);
-
-	pr = per_cpu(processors, policy->cpu);
-	if (!pr || !pr->performance)
-		goto out;
-
-	ppc = (unsigned int)pr->performance_platform_limit;
-
-	if (ppc >= pr->performance->state_count)
-		goto out;
-
-	cpufreq_verify_within_limits(policy, 0,
-				     pr->performance->states[ppc].
-				     core_frequency * 1000);
-
-      out:
-	mutex_unlock(&performance_mutex);
-
-	return 0;
-}
-
-static struct notifier_block acpi_ppc_notifier_block = {
-	.notifier_call = acpi_processor_ppc_notifier,
-};
+static int acpi_processor_ppc_in_use;
 
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
-
+	int ret;
 
 	if (!pr)
 		return -EINVAL;
@@ -112,7 +68,7 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 	status = acpi_evaluate_integer(pr->handle, "_PPC", NULL, &ppc);
 
 	if (status != AE_NOT_FOUND)
-		acpi_processor_ppc_status |= PPC_IN_USE;
+		acpi_processor_ppc_in_use = 1;
 
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PPC"));
@@ -124,6 +80,16 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 
 	pr->performance_platform_limit = (int)ppc;
 
+	if (ignore_ppc || ppc >= pr->performance->state_count)
+		return 0;
+
+	ret = dev_pm_qos_update_request(pr->perflib_req,
+			pr->performance->states[ppc].core_frequency * 1000);
+	if (ret) {
+		pr_warn("Failed to update perflib freq constraint: cpu%d (%d)\n",
+			pr->id, ret);
+	}
+
 	return 0;
 }
 
@@ -184,23 +150,39 @@ int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 }
 EXPORT_SYMBOL(acpi_processor_get_bios_limit);
 
-void acpi_processor_ppc_init(void)
+void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
-	if (!cpufreq_register_notifier
-	    (&acpi_ppc_notifier_block, CPUFREQ_POLICY_NOTIFIER))
-		acpi_processor_ppc_status |= PPC_REGISTERED;
-	else
-		printk(KERN_DEBUG
-		       "Warning: Processor Platform Limit not supported.\n");
+	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
+	struct dev_pm_qos_request *req;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return;
+
+	ret = dev_pm_qos_add_request(get_cpu_device(policy->cpu),
+				     req, DEV_PM_QOS_MAX_FREQUENCY,
+				     policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		pr_err("Failed to add freq constraint for cpu%d (%d)\n",
+		       policy->cpu, ret);
+		kfree(req);
+		return;
+	}
+
+	pr->perflib_req = req;
+
+	if (ignore_ppc < 0)
+		ignore_ppc = 0;
 }
 
-void acpi_processor_ppc_exit(void)
+void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 {
-	if (acpi_processor_ppc_status & PPC_REGISTERED)
-		cpufreq_unregister_notifier(&acpi_ppc_notifier_block,
-					    CPUFREQ_POLICY_NOTIFIER);
+	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
 
-	acpi_processor_ppc_status &= ~PPC_REGISTERED;
+	dev_pm_qos_remove_request(pr->perflib_req);
+	kfree(pr->perflib_req);
+	pr->perflib_req = NULL;
 }
 
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
@@ -477,7 +459,7 @@ int acpi_processor_notify_smm(struct module *calling_module)
 	static int is_done = 0;
 	int result;
 
-	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
+	if (!acpi_processor_cpufreq_init)
 		return -EBUSY;
 
 	if (!try_module_get(calling_module))
@@ -513,7 +495,7 @@ int acpi_processor_notify_smm(struct module *calling_module)
 	 * we can allow the cpufreq driver to be rmmod'ed. */
 	is_done = 1;
 
-	if (!(acpi_processor_ppc_status & PPC_IN_USE))
+	if (!acpi_processor_ppc_in_use)
 		module_put(calling_module);
 
 	return 0;
@@ -742,7 +724,7 @@ acpi_processor_register_performance(struct acpi_processor_performance
 {
 	struct acpi_processor *pr;
 
-	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
+	if (!acpi_processor_cpufreq_init)
 		return -EINVAL;
 
 	mutex_lock(&performance_mutex);
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 50fb0107375e..02407b33b874 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -35,7 +35,6 @@ ACPI_MODULE_NAME("processor_thermal");
 #define CPUFREQ_THERMAL_MAX_STEP 3
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
-static unsigned int acpi_thermal_cpufreq_is_init = 0;
 
 #define reduction_pctg(cpu) \
 	per_cpu(cpufreq_thermal_reduction_pctg, phys_package_first_cpu(cpu))
@@ -61,35 +60,11 @@ static int phys_package_first_cpu(int cpu)
 static int cpu_has_cpufreq(unsigned int cpu)
 {
 	struct cpufreq_policy policy;
-	if (!acpi_thermal_cpufreq_is_init || cpufreq_get_policy(&policy, cpu))
+	if (!acpi_processor_cpufreq_init || cpufreq_get_policy(&policy, cpu))
 		return 0;
 	return 1;
 }
 
-static int acpi_thermal_cpufreq_notifier(struct notifier_block *nb,
-					 unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	unsigned long max_freq = 0;
-
-	if (event != CPUFREQ_ADJUST)
-		goto out;
-
-	max_freq = (
-	    policy->cpuinfo.max_freq *
-	    (100 - reduction_pctg(policy->cpu) * 20)
-	) / 100;
-
-	cpufreq_verify_within_limits(policy, 0, max_freq);
-
-      out:
-	return 0;
-}
-
-static struct notifier_block acpi_thermal_cpufreq_notifier_block = {
-	.notifier_call = acpi_thermal_cpufreq_notifier,
-};
-
 static int cpufreq_get_max_state(unsigned int cpu)
 {
 	if (!cpu_has_cpufreq(cpu))
@@ -108,7 +83,9 @@ static int cpufreq_get_cur_state(unsigned int cpu)
 
 static int cpufreq_set_cur_state(unsigned int cpu, int state)
 {
-	int i;
+	struct acpi_processor *pr;
+	unsigned long max_freq;
+	int i, ret;
 
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
@@ -121,33 +98,53 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	 * frequency.
 	 */
 	for_each_online_cpu(i) {
-		if (topology_physical_package_id(i) ==
+		if (topology_physical_package_id(i) !=
 		    topology_physical_package_id(cpu))
-			cpufreq_update_policy(i);
+			continue;
+
+		pr = per_cpu(processors, i);
+		max_freq = (pr->policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+
+		ret = dev_pm_qos_update_request(pr->thermal_req, max_freq);
+		if (ret) {
+			pr_warn("Failed to update thermal freq constraint: cpu%d (%d)\n",
+				pr->id, ret);
+		}
 	}
 	return 0;
 }
 
-void acpi_thermal_cpufreq_init(void)
+void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int i;
+	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
+	struct dev_pm_qos_request *req;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return;
+
+	ret = dev_pm_qos_add_request(get_cpu_device(policy->cpu),
+				     req, DEV_PM_QOS_MAX_FREQUENCY,
+				     policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		pr_err("Failed to add freq constraint for cpu%d (%d)\n",
+		       policy->cpu, ret);
+		kfree(req);
+		return;
+	}
 
-	i = cpufreq_register_notifier(&acpi_thermal_cpufreq_notifier_block,
-				      CPUFREQ_POLICY_NOTIFIER);
-	if (!i)
-		acpi_thermal_cpufreq_is_init = 1;
+	pr->thermal_req = req;
 }
 
-void acpi_thermal_cpufreq_exit(void)
+void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
-	if (acpi_thermal_cpufreq_is_init)
-		cpufreq_unregister_notifier
-		    (&acpi_thermal_cpufreq_notifier_block,
-		     CPUFREQ_POLICY_NOTIFIER);
+	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
 
-	acpi_thermal_cpufreq_is_init = 0;
+	dev_pm_qos_remove_request(pr->thermal_req);
+	kfree(pr->thermal_req);
+	pr->thermal_req = NULL;
 }
-
 #else				/* ! CONFIG_CPU_FREQ */
 static int cpufreq_get_max_state(unsigned int cpu)
 {
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1194a4c78d55..a1a7966bb755 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -4,6 +4,8 @@
 
 #include <linux/kernel.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/pm_qos.h>
 #include <linux/thermal.h>
 #include <asm/acpi.h>
 
@@ -230,6 +232,9 @@ struct acpi_processor {
 	struct acpi_processor_limit limit;
 	struct thermal_cooling_device *cdev;
 	struct device *dev; /* Processor device. */
+	struct cpufreq_policy *policy;
+	struct dev_pm_qos_request *perflib_req;
+	struct dev_pm_qos_request *thermal_req;
 };
 
 struct acpi_processor_errata {
@@ -296,16 +301,17 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 /* in processor_perflib.c */
 
 #ifdef CONFIG_CPU_FREQ
-void acpi_processor_ppc_init(void);
-void acpi_processor_ppc_exit(void);
+extern bool acpi_processor_cpufreq_init;
+void acpi_processor_ppc_init(struct cpufreq_policy *policy);
+void acpi_processor_ppc_exit(struct cpufreq_policy *policy);
 void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
 #else
-static inline void acpi_processor_ppc_init(void)
+static inline void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
 	return;
 }
-static inline void acpi_processor_ppc_exit(void)
+static inline void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
@@ -421,14 +427,14 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
-void acpi_thermal_cpufreq_init(void);
-void acpi_thermal_cpufreq_exit(void);
+void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
+void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
 #else
-static inline void acpi_thermal_cpufreq_init(void)
+static inline void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
 	return;
 }
-static inline void acpi_thermal_cpufreq_exit(void)
+static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

