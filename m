Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AEB58C5F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF0VCe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:02:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34053 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0VCe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:02:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so7898397wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpUESVgsv/sulA0PM7+SZlP275qaUOQmqQ29BukGITA=;
        b=sQohD71HHG60ny5GLHRLPoXwYOfyt+Dnz8+4A04pWdW1QoTXb/LdwXbRkhWxoRp4fw
         AH7pws31fi2NICaQ4sznHRkNtLe/7uQQMWlfJ3GkYFptzTXEUPcMr8i+D2IY7+QI2RQP
         +TdsP/gO8BbvQQac2AsX5GLmzCi6gccA1slEmPehIUfy/oLqYM2/nYA2SLMYCJpbfMEd
         dyZPxr4amzs6WKCvUlbKwMGJZTu75gGyNDhd6RFQmNyzifEJyJVIQweUxK25vPxj8ZZ+
         RIqKZalcXz6PSmATz+H1V9ezTkK0iywtbEcyz43c7bfkH9OVwtL/7sqM0dSOtjNjKS6H
         5AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpUESVgsv/sulA0PM7+SZlP275qaUOQmqQ29BukGITA=;
        b=nM1uGoqZm+sp5jlvc5LavTlIr9M6jTyE3HdjoLerMkFhYBpIqPDUlFsd6XzwH2xBKN
         UnEIAiaX9PI1h1i4jZtYzB+pN/YSmvcMA8qjJK2EXVJUUTVEyRKAD2fba5mOqtGHx4w7
         RH6Kc/8i93qMJ2ldwyXqt7IBaOpGwto5dBebdXjJjPVoYPhzOxmoYd2jDht4dCDoGIPv
         rlKY9FPKAAXXb++SruzE9PMm/mO4SPf6XP/T1YKJeLlHQ0eK9Vfsn14xHFDQrUGc2o+X
         O4CSCY7KkviPXxO56tGP/wUVR5wHcv4hkuGD2An4evgIEVyNHLW8DzFKnsGe5BNcMpjV
         heGA==
X-Gm-Message-State: APjAAAWCS0fD5PagCs68jl8VtGe3vVgZu4vEOHDQQjLpkwTHNKr1kVWM
        crUDeT+JDQykwjrLNjctOFdygA==
X-Google-Smtp-Source: APXvYqyJz7Sg9VCZbrLR8wTcu5ovTV7bYzP7QonyZBoPnMAicgOqlDo71sRR5F7q97AHJwt/TmvAOw==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr4610761wmf.111.1561669352055;
        Thu, 27 Jun 2019 14:02:32 -0700 (PDT)
Received: from clegane.local (11.117.130.77.rev.sfr.net. [77.130.117.11])
        by smtp.gmail.com with ESMTPSA id k82sm107902wma.15.2019.06.27.14.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:02:31 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH V4 3/3] thermal/drivers/cpu_cooling: cpufreq_cooling_register returns an int
Date:   Thu, 27 Jun 2019 23:02:08 +0200
Message-Id: <20190627210209.32600-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627210209.32600-1-daniel.lezcano@linaro.org>
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It looks like after the changes in the patch the only reason for
returning (struct thermal_cooling_device *) from
cpufreq_cooling_register() is error checking, but it would be much
more straightforward to return int for this purpose.

Moreover, that would prevent the callers of it from doing incorrect
things with the returned pointers (like using it to unregister the
cooling device).

Replace the returned value an integer instead of a pointer to a
thermal cooling device structure.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c                 | 63 +++++++++----------
 drivers/thermal/imx_thermal.c                 |  6 +-
 .../ti-soc-thermal/ti-thermal-common.c        |  7 +--
 include/linux/cpu_cooling.h                   | 16 ++---
 4 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index be01546a656f..0d5e39716542 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -530,13 +530,12 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
  * cooling devices. It also gives the opportunity to link the cooling device
  * with a device tree node, in order to bind it via the thermal DT code.
  *
- * Return: a valid struct thermal_cooling_device pointer on success,
- * on failure, it returns a corresponding ERR_PTR().
+ * Return: zero on success, less than zero corresponding to the
+ * negative error code.
  */
-static struct thermal_cooling_device *
-__cpufreq_cooling_register(struct device_node *np,
-			struct cpufreq_policy *policy,
-			struct em_perf_domain *em)
+static int __cpufreq_cooling_register(struct device_node *np,
+				      struct cpufreq_policy *policy,
+				      struct em_perf_domain *em)
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
@@ -548,19 +547,19 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	if (IS_ERR_OR_NULL(policy)) {
 		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	i = cpufreq_table_count_valid_entries(policy);
 	if (!i) {
 		pr_debug("%s: CPUFreq table not found or has no valid entries\n",
 			 __func__);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
 	cpufreq_cdev = kzalloc(sizeof(*cpufreq_cdev), GFP_KERNEL);
 	if (!cpufreq_cdev)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	cpufreq_cdev->policy = policy;
 	num_cpus = cpumask_weight(policy->related_cpus);
@@ -568,7 +567,7 @@ __cpufreq_cooling_register(struct device_node *np,
 					 sizeof(*cpufreq_cdev->idle_time),
 					 GFP_KERNEL);
 	if (!cpufreq_cdev->idle_time) {
-		cdev = ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
 		goto free_cdev;
 	}
 
@@ -576,10 +575,8 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_cdev->max_level = i - 1;
 
 	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		cdev = ERR_PTR(ret);
+	if (ret < 0)
 		goto free_idle_time;
-	}
 	cpufreq_cdev->id = ret;
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
@@ -597,14 +594,16 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
 		pr_err("%s: unsorted frequency tables are not supported\n",
 				__func__);
-		cdev = ERR_PTR(-EINVAL);
+		ret = -EINVAL;
 		goto remove_ida;
 	}
 
 	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
 						  cooling_ops);
-	if (IS_ERR(cdev))
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
 		goto remove_ida;
+	}
 
 	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
 	cpufreq_cdev->cdev = cdev;
@@ -619,7 +618,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
 
-	return cdev;
+	return 0;
 
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
@@ -627,7 +626,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	kfree(cpufreq_cdev->idle_time);
 free_cdev:
 	kfree(cpufreq_cdev);
-	return cdev;
+	return ret;
 }
 
 /**
@@ -638,11 +637,10 @@ __cpufreq_cooling_register(struct device_node *np,
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
  * cooling devices.
  *
- * Return: a valid struct thermal_cooling_device pointer on success,
- * on failure, it returns a corresponding ERR_PTR().
+ * Return: zero on success, less than zero corresponding to the
+ * negative error code.
  */
-struct thermal_cooling_device *
-cpufreq_cooling_register(struct cpufreq_policy *policy)
+int cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return __cpufreq_cooling_register(NULL, policy, NULL);
 }
@@ -664,34 +662,31 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
  * It also takes into account, if property present in policy CPU node, the
  * static power consumed by the cpu.
  *
- * Return: a valid struct thermal_cooling_device pointer on success,
- * and NULL on failure.
+ * Return: zero on success, less than zero corresponding to the
+ * negative error code.
  */
-struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct cpufreq_policy *policy)
+int of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
-	struct thermal_cooling_device *cdev = NULL;
+	int ret = -EINVAL;
 
 	if (!np) {
 		pr_err("cpu_cooling: OF node not available for cpu%d\n",
 		       policy->cpu);
-		return NULL;
+		return -EINVAL;
 	}
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
 		struct em_perf_domain *em = em_cpu_get(policy->cpu);
 
-		cdev = __cpufreq_cooling_register(np, policy, em);
-		if (IS_ERR(cdev)) {
-			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
-			       policy->cpu, PTR_ERR(cdev));
-			cdev = NULL;
-		}
+		ret = __cpufreq_cooling_register(np, policy, em);
+		if (ret)
+			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %d\n",
+			       policy->cpu, ret);
 	}
 
 	of_node_put(np);
-	return cdev;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 021c0948b740..1c4b49b583bc 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -655,7 +655,6 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 {
 	struct device_node *np;
-	struct thermal_cooling_device *cdev;
 	int ret;
 
 	data->policy = cpufreq_cpu_get(0);
@@ -667,9 +666,8 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 	np = of_get_cpu_node(data->policy->cpu, NULL);
 
 	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
-		cdev = cpufreq_cooling_register(data->policy);
-		if (IS_ERR(cdev)) {
-			ret = PTR_ERR(cdev);
+		ret = cpufreq_cooling_register(data->policy);
+		if (ret) {
 			cpufreq_cpu_put(data->policy);
 			return ret;
 		}
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 170b70b6ec61..eacc46d7bd1c 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -232,7 +232,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 {
 	struct ti_thermal_data *data;
 	struct device_node *np = bgp->dev->of_node;
-	struct thermal_cooling_device *cdev;
+	int ret;
 
 	/*
 	 * We are assuming here that if one deploys the zone
@@ -256,9 +256,8 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	}
 
 	/* Register cooling device */
-	cdev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(cdev)) {
-		int ret = PTR_ERR(cdev);
+	ret = cpufreq_cooling_register(data->policy);
+	if (ret) {
 		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
 			ret);
 		cpufreq_cpu_put(data->policy);
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 89f469ee4be4..98f7c8a9cab6 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -24,8 +24,7 @@ struct cpufreq_policy;
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @policy: cpufreq policy.
  */
-struct thermal_cooling_device *
-cpufreq_cooling_register(struct cpufreq_policy *policy);
+int cpufreq_cooling_register(struct cpufreq_policy *policy);
 
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
@@ -34,10 +33,9 @@ cpufreq_cooling_register(struct cpufreq_policy *policy);
 void cpufreq_cooling_unregister(struct cpufreq_policy *policy);
 
 #else /* !CONFIG_CPU_THERMAL */
-static inline struct thermal_cooling_device *
-cpufreq_cooling_register(struct cpufreq_policy *policy)
+static inline int cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return ERR_PTR(-ENOSYS);
+	return -ENOSYS;
 }
 
 static inline
@@ -52,13 +50,11 @@ void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
  * @policy: cpufreq policy.
  */
-struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct cpufreq_policy *policy);
+int of_cpufreq_cooling_register(struct cpufreq_policy *policy);
 #else
-static inline struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct cpufreq_policy *policy)
+static inline int of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return NULL;
+	return -ENOSYS;
 }
 #endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
 
-- 
2.17.1

