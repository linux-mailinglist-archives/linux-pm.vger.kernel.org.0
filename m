Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2E86FBA
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 04:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405533AbfHICev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 22:34:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46225 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405532AbfHICeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 22:34:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so7860896pgt.13
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n8KBG5nmkGEaawsHMjPOBzO6NvS/PfrVgyogK3T8Log=;
        b=pS3vTy2IwGTZJtm8Atxiya+8KlteqaTjfeLrA+t36U4t867/r7Ng1H9i1bydZy61y9
         y/kNlou8qCAhJrhnBxa+B/p8N09Gn0fZUEp8HxeY4RFZMvZXzKeDbeCunqUaSOQTjQCF
         7iaD6BsdBLZ2ing382OlgLdyJEMPeyMcx3oKfjYas59jLwuiZ1ZoWQVUzEqhD65PR/m6
         haG/akiESl+bLMJSSzadJ6TaeQ9nJkfRDoG+sz2uf9i1BcoM6DTgizTu9f4bM1c7EzXk
         zjq8R4Buf8BrW3QIfdQYzFHSl4sJrFLOHrVlzKpGgJk7Un7U03IcPpO6l6XES8RON9eB
         i0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8KBG5nmkGEaawsHMjPOBzO6NvS/PfrVgyogK3T8Log=;
        b=gopfBnzgOJ50Hod+Q4jD8q+X+Lie6STpQoQadHdAHXzzYq7LNPR5Xi8uaWZywestp+
         lAnhReychgqxsg7chpB0WIl4YYdmUyabRQmGn9GJ/MFS8V/HEyoKPVVPYrwt4CleJP+m
         MskZaTnE2VOD1m/ktfkKp3/b36bfFlzD6g0RGfhvH7Mz3rG0uA31XvR6RaQOPbZUdwxG
         hkaIXzTQekoTJlKudIqCsbIvTAKI9gzkIdAmaXOM/zl9LGV892Vt/c9icC3J9M+weLgd
         5pNdsS4EButZw8W7MwPGSYEmM4KL1Rg9jf2545HZ1xjGM+cPU9ESqnt2Y56RztxCIqDP
         6UcQ==
X-Gm-Message-State: APjAAAVW7w7ak4xTfvaBWYqaop1x8WbcvXnClqV96uzdC+nHJZ8dqgBD
        UBcf4xqq2ZS6/gyCyruDYy+/SA==
X-Google-Smtp-Source: APXvYqwAIzonWFvFcHs1FTxusshjF79mDe9DU1nTJkKVIo3XGpatkk8lRn0c/3N6oxEo2NfhFMqqAw==
X-Received: by 2002:a65:4304:: with SMTP id j4mr15863872pgq.419.1565318089782;
        Thu, 08 Aug 2019 19:34:49 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id q19sm101879983pfc.62.2019.08.08.19.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 19:34:49 -0700 (PDT)
Date:   Fri, 9 Aug 2019 08:04:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/10] cpufreq: powerpc_cbe: Switch to QoS requests
 instead of cpufreq notifier
Message-ID: <20190809023445.xn3mlv5qxjgz6bpp@vireshk-i7>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
 <524de8ace0596e68a24b57b3b4043c707db32ca7.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524de8ace0596e68a24b57b3b4043c707db32ca7.1563862014.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-07-19, 11:44, Viresh Kumar wrote:
> The cpufreq core now takes the min/max frequency constraints via QoS
> requests and the CPUFREQ_ADJUST notifier shall get removed later on.
> 
> Switch over to using the QoS request for maximum frequency constraint
> for ppc_cbe_cpufreq driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/ppc_cbe_cpufreq.c     | 19 +++++-
>  drivers/cpufreq/ppc_cbe_cpufreq.h     |  8 +++
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 96 +++++++++++++++++----------
>  3 files changed, 86 insertions(+), 37 deletions(-)

-------------------------8<-------------------------
From b84e1c119d63ab842c9e4f3acbc3aec22efa866d Mon Sep 17 00:00:00 2001
Message-Id: <b84e1c119d63ab842c9e4f3acbc3aec22efa866d.1565318034.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 5 Jul 2019 15:49:48 +0530
Subject: [PATCH] cpufreq: powerpc_cbe: Switch to QoS requests instead of
 cpufreq notifier

The cpufreq core now takes the min/max frequency constraints via QoS
requests and the CPUFREQ_ADJUST notifier shall get removed later on.

Switch over to using the QoS request for maximum frequency constraint
for ppc_cbe_cpufreq driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
- dev_pm_qos_update_request() can return 1 on success
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
index 97c8ee4614b7..bc9dd30395c4 100644
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
+	if (ret < 0)
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
