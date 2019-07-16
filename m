Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E987A6A5F1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfGPJzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:55:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39729 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733066AbfGPJzS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:55:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so9182267pgi.6
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCHE6jmJHvvf4ZOfPHyOAwxkEw7udl1CJtgxI9QEJbs=;
        b=cyDgYafjtQ9BTLfXLwRoWNuVpBgLISxcZazGQYNrTGFUzlsgpGS5yhv/yPp7LXUPYv
         rTOA5TTk/wdufu1YAISq/IoarJgOmanKbMeIuXOb6AjUvC7b3XjEsefLkgEB6vYpgSBh
         Uu1DYcNJYyWfjkGOTv6dSXqxGYj1jiAZZcX8LjVTTE4lMxEIiwbg6XgvEKKQvNp1QOXC
         LejdLEMEqdrQagKYWyxCAieW4SOivR/2TQAZ1tPzejXzJErkSV4RZwPzgP+v7bJRKhs7
         tHYeH++bwkEyZWAYE1Og5vEGwfutWGp6OlbowV/sjNT0rd123qx6chxSx/PznWhvxZDQ
         IAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCHE6jmJHvvf4ZOfPHyOAwxkEw7udl1CJtgxI9QEJbs=;
        b=l/AiPP4b8IGoVnXMrGgJdhtl/hJrk6vauW04a/8K9XXJSoLckgsr0zNdUuCAMR+eUR
         J70vGjBtr3Vf/gD9s6Jif+R7cty5s4GN2QZXXE/p2RWmOTIuhGDJxdTurcHze1QHvSsx
         Elyj4ZM089O96efZc5Acq1G4gQl57Fdei/3LJmRgkOQSH6Kb95mwY+S+UeKh50dwICkG
         +GvwRo582gQgdnz7FHyz3CiBKzxj69Y94gWF0EZuPb0QMvrwIo+ptwK+mw3glTnMJDAb
         D22k1fz+UKX7XEgcImk/+/f9aM0BSSS7Vqm7rPdYO091n8IOtp1dgT2iQMI7tMf1edYw
         dW4A==
X-Gm-Message-State: APjAAAVE2Wd8sYZz2aMIsAB9fz9qfgSlUPw/tFsbgr5UL5lOkr5/MAk4
        dGWYjxVxVGuu+a4XSUpm6m3YfA==
X-Google-Smtp-Source: APXvYqwMBob2VfmnrLN5v4d5N+jfwUfKIWSHNvnYNp2pCMrmR3RooE8VYXZ1G5UeTyBjp6+lja6m2w==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr35296476pjp.62.1563270917408;
        Tue, 16 Jul 2019 02:55:17 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id bg3sm19071910pjb.9.2019.07.16.02.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] cpufreq: powerpc_cbe: Switch to QoS requests instead of cpufreq notifier
Date:   Tue, 16 Jul 2019 15:24:51 +0530
Message-Id: <889777691cd3de894c37f5113e4ec1cc73473a0f.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq core now takes the min/max frequency constraints via QoS
requests and the CPUFREQ_ADJUST notifier shall get removed later on.

Switch over to using the QoS request for maximum frequency constraint
for ppc_cbe_cpufreq driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc_cbe_cpufreq.c     | 19 +++++-
 drivers/cpufreq/ppc_cbe_cpufreq.h     |  8 +++
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 96 +++++++++++++++++----------
 3 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index b83f36febf03..c58abb4cca3a 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -110,6 +110,13 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 #endif
 
 	policy->freq_table = cbe_freqs;
+	cbe_cpufreq_pmi_policy_init(policy);
+	return 0;
+}
+
+static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cbe_cpufreq_pmi_policy_exit(policy);
 	return 0;
 }
 
@@ -129,6 +136,7 @@ static struct cpufreq_driver cbe_cpufreq_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= cbe_cpufreq_target,
 	.init		= cbe_cpufreq_cpu_init,
+	.exit		= cbe_cpufreq_cpu_exit,
 	.name		= "cbe-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 };
@@ -139,15 +147,24 @@ static struct cpufreq_driver cbe_cpufreq_driver = {
 
 static int __init cbe_cpufreq_init(void)
 {
+	int ret;
+
 	if (!machine_is(cell))
 		return -ENODEV;
 
-	return cpufreq_register_driver(&cbe_cpufreq_driver);
+	cbe_cpufreq_pmi_init();
+
+	ret = cpufreq_register_driver(&cbe_cpufreq_driver);
+	if (ret)
+		cbe_cpufreq_pmi_exit();
+
+	return ret;
 }
 
 static void __exit cbe_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
+	cbe_cpufreq_pmi_exit();
 }
 
 module_init(cbe_cpufreq_init);
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.h b/drivers/cpufreq/ppc_cbe_cpufreq.h
index 9d973519d669..00cd8633b0d9 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.h
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.h
@@ -20,6 +20,14 @@ int cbe_cpufreq_set_pmode_pmi(int cpu, unsigned int pmode);
 
 #if IS_ENABLED(CONFIG_CPU_FREQ_CBE_PMI)
 extern bool cbe_cpufreq_has_pmi;
+void cbe_cpufreq_pmi_policy_init(struct cpufreq_policy *policy);
+void cbe_cpufreq_pmi_policy_exit(struct cpufreq_policy *policy);
+void cbe_cpufreq_pmi_init(void);
+void cbe_cpufreq_pmi_exit(void);
 #else
 #define cbe_cpufreq_has_pmi (0)
+static inline void cbe_cpufreq_pmi_policy_init(struct cpufreq_policy *policy) {}
+static inline void cbe_cpufreq_pmi_policy_exit(struct cpufreq_policy *policy) {}
+static inline void cbe_cpufreq_pmi_init(void) {}
+static inline void cbe_cpufreq_pmi_exit(void) {}
 #endif
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 97c8ee4614b7..0babb27c1c72 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -12,6 +12,7 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/pm_qos.h>
 
 #include <asm/processor.h>
 #include <asm/prom.h>
@@ -24,8 +25,6 @@
 
 #include "ppc_cbe_cpufreq.h"
 
-static u8 pmi_slow_mode_limit[MAX_CBE];
-
 bool cbe_cpufreq_has_pmi = false;
 EXPORT_SYMBOL_GPL(cbe_cpufreq_has_pmi);
 
@@ -65,64 +64,89 @@ EXPORT_SYMBOL_GPL(cbe_cpufreq_set_pmode_pmi);
 
 static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
 {
+	struct cpufreq_policy *policy;
+	struct dev_pm_qos_request *req;
 	u8 node, slow_mode;
+	int cpu, ret;
 
 	BUG_ON(pmi_msg.type != PMI_TYPE_FREQ_CHANGE);
 
 	node = pmi_msg.data1;
 	slow_mode = pmi_msg.data2;
 
-	pmi_slow_mode_limit[node] = slow_mode;
+	cpu = cbe_node_to_cpu(node);
 
 	pr_debug("cbe_handle_pmi: node: %d max_freq: %d\n", node, slow_mode);
-}
-
-static int pmi_notifier(struct notifier_block *nb,
-				       unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	struct cpufreq_frequency_table *cbe_freqs = policy->freq_table;
-	u8 node;
-
-	/* Should this really be called for CPUFREQ_ADJUST and CPUFREQ_NOTIFY
-	 * policy events?)
-	 */
-	node = cbe_cpu_to_node(policy->cpu);
-
-	pr_debug("got notified, event=%lu, node=%u\n", event, node);
 
-	if (pmi_slow_mode_limit[node] != 0) {
-		pr_debug("limiting node %d to slow mode %d\n",
-			 node, pmi_slow_mode_limit[node]);
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy) {
+		pr_warn("cpufreq policy not found cpu%d\n", cpu);
+		return;
+	}
 
-		cpufreq_verify_within_limits(policy, 0,
+	req = policy->driver_data;
 
-			cbe_freqs[pmi_slow_mode_limit[node]].frequency);
-	}
+	ret = dev_pm_qos_update_request(req,
+			policy->freq_table[slow_mode].frequency);
+	if (ret)
+		pr_warn("Failed to update freq constraint: %d\n", ret);
+	else
+		pr_debug("limiting node %d to slow mode %d\n", node, slow_mode);
 
-	return 0;
+	cpufreq_cpu_put(policy);
 }
 
-static struct notifier_block pmi_notifier_block = {
-	.notifier_call = pmi_notifier,
-};
-
 static struct pmi_handler cbe_pmi_handler = {
 	.type			= PMI_TYPE_FREQ_CHANGE,
 	.handle_pmi_message	= cbe_cpufreq_handle_pmi,
 };
 
+void cbe_cpufreq_pmi_policy_init(struct cpufreq_policy *policy)
+{
+	struct dev_pm_qos_request *req;
+	int ret;
+
+	if (!cbe_cpufreq_has_pmi)
+		return;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return;
+
+	ret = dev_pm_qos_add_request(get_cpu_device(policy->cpu), req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     policy->freq_table[0].frequency);
+	if (ret < 0) {
+		pr_err("Failed to add freq constraint (%d)\n", ret);
+		kfree(req);
+		return;
+	}
 
+	policy->driver_data = req;
+}
+EXPORT_SYMBOL_GPL(cbe_cpufreq_pmi_policy_init);
 
-static int __init cbe_cpufreq_pmi_init(void)
+void cbe_cpufreq_pmi_policy_exit(struct cpufreq_policy *policy)
 {
-	cbe_cpufreq_has_pmi = pmi_register_handler(&cbe_pmi_handler) == 0;
+	struct dev_pm_qos_request *req = policy->driver_data;
 
-	if (!cbe_cpufreq_has_pmi)
-		return -ENODEV;
+	if (cbe_cpufreq_has_pmi) {
+		dev_pm_qos_remove_request(req);
+		kfree(req);
+	}
+}
+EXPORT_SYMBOL_GPL(cbe_cpufreq_pmi_policy_exit);
 
-	cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
+void cbe_cpufreq_pmi_init(void)
+{
+	if (!pmi_register_handler(&cbe_pmi_handler))
+		cbe_cpufreq_has_pmi = true;
+}
+EXPORT_SYMBOL_GPL(cbe_cpufreq_pmi_init);
 
-	return 0;
+void cbe_cpufreq_pmi_exit(void)
+{
+	pmi_unregister_handler(&cbe_pmi_handler);
+	cbe_cpufreq_has_pmi = false;
 }
-device_initcall(cbe_cpufreq_pmi_init);
+EXPORT_SYMBOL_GPL(cbe_cpufreq_pmi_exit);
-- 
2.21.0.rc0.269.g1a574e7a288b

