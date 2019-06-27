Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8011D58C65
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF0VCd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:02:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfF0VCc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:02:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so7035562wmj.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=is3WVnPlz2KiQ5jH/G21MQoeFOw4WJycj+NB9X17b0s=;
        b=mIZPcUHCIGfdIzSMTEJn4KwutjdroAiSMKHPHNiezcv3dj5Wu4jNjdhdRHM62oVdVi
         PkubWcOWZ2Kbcwyu5MzqrtBkEdaXjRg54Jzp+F2ltb39oAzYJp5dkAAhSwN1m3OS43X6
         2LleLhNgrv6oFZs1qWV+laKNw7rxCRSoqvEgEkuDrF1ZpgyVXnNehzNUGgbvJZXgjD+I
         sYfm0bGbQ8AhJ33tiZwm+Kl/hgFCI0WsDouJ+m5BBDq/hwUKmPnUL6vzbL/VIcybvvfn
         60nnuJXOgu60O9t8K36zKkuYwjKZdJ8/70eeM1xlc0L8DQbcRtflZqn+p1HWJYN8T3s5
         5O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=is3WVnPlz2KiQ5jH/G21MQoeFOw4WJycj+NB9X17b0s=;
        b=Gbk2OwX0a2txT+H+QqG/MstrMpZA46aRyPeua57oZVlcKxlISajmzcfkNo3w6QmEUp
         Is0bKaTkP3SWDWOouNXszA/PJ3HGavKGAcpjCrANFVV9yfV+xZK+IncQwjWPQ+vXjjFQ
         bEJm2U/SXPcHWzwHMo3svy2RCZPpV9fzDCe79R50UQ2xk7nntvQh/4z4zaI/dGOaT566
         2i6QtntFgkaYaJGgtCM1h0nmIek0pet9Nh6k6BkUgTYqmQfdxiVp+94PAYPBrrhH+vn9
         F1f3CaNVSeK8OB6h9ualN/hO8GQaKmCCKkYdNv2zKTGRv+veZ75PDbAcwp6o+LPiO92B
         gcKw==
X-Gm-Message-State: APjAAAUY+IEmuehFzgALatoFdO9c5cae+PSYzZf0e177hX5XDHD1R+i7
        jRSGSC2GaezXfUEnvONHhMN+ig==
X-Google-Smtp-Source: APXvYqxPlfMits1SIBemTnLXknSZW+fVDlhj1ZiyiZDCaoXLgRTP8APeor5IN/wC+VhZ1MixR2Qosg==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr4368747wmo.18.1561669349137;
        Thu, 27 Jun 2019 14:02:29 -0700 (PDT)
Received: from clegane.local (11.117.130.77.rev.sfr.net. [77.130.117.11])
        by smtp.gmail.com with ESMTPSA id k82sm107902wma.15.2019.06.27.14.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:02:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS - ARM BIG
        LITTLE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH V4 2/3] thermal/drivers/cpu_cooling: Unregister with the policy
Date:   Thu, 27 Jun 2019 23:02:07 +0200
Message-Id: <20190627210209.32600-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627210209.32600-1-daniel.lezcano@linaro.org>
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the function cpufreq_cooling_register() returns a cooling
device pointer which is used back as a pointer to call the function
cpufreq_cooling_unregister(). Even if it is correct, it would make
sense to not leak the structure inside a cpufreq driver and keep the
code thermal code self-encapsulate. Moreover, that forces to add an
extra variable in each driver using this function.

Instead of passing the cooling device to unregister, pass the policy.

Because the cpufreq_cooling_unregister() function uses the policy to
unregister itself. The only purpose of the cooling device pointer is
to unregister the cpu cooling device.

As there is no more need of this pointer, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c              |  9 ++--
 drivers/cpufreq/cpufreq.c                     |  8 ++--
 drivers/thermal/cpu_cooling.c                 | 42 +++++++++++--------
 drivers/thermal/imx_thermal.c                 | 12 +++---
 .../ti-soc-thermal/ti-thermal-common.c        | 10 ++---
 include/linux/cpu_cooling.h                   |  6 +--
 include/linux/cpufreq.h                       |  3 --
 7 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 7fe52fcddcf1..718c63231e66 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -56,7 +56,6 @@ static bool bL_switching_enabled;
 #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
 #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
 
-static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
 static const struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
@@ -501,10 +500,8 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
-	if (cur_cluster < MAX_CLUSTERS) {
-		cpufreq_cooling_unregister(cdev[cur_cluster]);
-		cdev[cur_cluster] = NULL;
-	}
+	if (cur_cluster < MAX_CLUSTERS)
+		cpufreq_cooling_unregister(policy);
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -527,7 +524,7 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 	if (cur_cluster >= MAX_CLUSTERS)
 		return;
 
-	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
+	of_cpufreq_cooling_register(policy);
 }
 
 static struct cpufreq_driver bL_cpufreq_driver = {
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index aee024e42618..1663a5601811 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1379,7 +1379,7 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->ready(policy);
 
 	if (cpufreq_thermal_control_enabled(cpufreq_driver))
-		policy->cdev = of_cpufreq_cooling_register(policy);
+		of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
 
@@ -1468,10 +1468,8 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
-		cpufreq_cooling_unregister(policy->cdev);
-		policy->cdev = NULL;
-	}
+	if (cpufreq_thermal_control_enabled(cpufreq_driver))
+		cpufreq_cooling_unregister(policy);
 
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 83486775e593..be01546a656f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -78,6 +78,7 @@ struct cpufreq_cooling_device {
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
+	struct thermal_cooling_device *cdev;
 };
 
 static DEFINE_IDA(cpufreq_ida);
@@ -606,6 +607,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto remove_ida;
 
 	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
+	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -693,35 +695,41 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
+void __cpufreq_cooling_unregister(struct cpufreq_cooling_device *cpufreq_cdev, int last)
+{
+	/* Unregister the notifier for the last cpufreq cooling device */
+	if (last)
+		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
+					    CPUFREQ_POLICY_NOTIFIER);
+
+	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
+	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
+	kfree(cpufreq_cdev->idle_time);
+	kfree(cpufreq_cdev);
+}
+
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
  *
  * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
  */
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	bool last;
 
-	if (!cdev)
-		return;
-
-	cpufreq_cdev = cdev->devdata;
-
 	mutex_lock(&cooling_list_lock);
-	list_del(&cpufreq_cdev->node);
-	/* Unregister the notifier for the last cpufreq cooling device */
-	last = list_empty(&cpufreq_cdev_list);
+	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
+		if (cpufreq_cdev->policy == policy) {
+			list_del(&cpufreq_cdev->node);
+			last = list_empty(&cpufreq_cdev_list);
+			break;
+		}
+	}
 	mutex_unlock(&cooling_list_lock);
 
-	if (last)
-		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
-					    CPUFREQ_POLICY_NOTIFIER);
-
-	thermal_cooling_device_unregister(cdev);
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-	kfree(cpufreq_cdev->idle_time);
-	kfree(cpufreq_cdev);
+	if (cpufreq_cdev->policy == policy)
+		__cpufreq_cooling_unregister(cpufreq_cdev, last);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb6754a5342c..021c0948b740 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -203,7 +203,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
@@ -656,6 +655,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 {
 	struct device_node *np;
+	struct thermal_cooling_device *cdev;
 	int ret;
 
 	data->policy = cpufreq_cpu_get(0);
@@ -667,9 +667,9 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 	np = of_get_cpu_node(data->policy->cpu, NULL);
 
 	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
-		data->cdev = cpufreq_cooling_register(data->policy);
-		if (IS_ERR(data->cdev)) {
-			ret = PTR_ERR(data->cdev);
+		cdev = cpufreq_cooling_register(data->policy);
+		if (IS_ERR(cdev)) {
+			ret = PTR_ERR(cdev);
 			cpufreq_cpu_put(data->policy);
 			return ret;
 		}
@@ -680,7 +680,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 
 static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
 {
-	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cooling_unregister(data->policy);
 	cpufreq_cpu_put(data->policy);
 }
 
@@ -872,7 +872,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cooling_unregister(data->policy);
 	cpufreq_cpu_put(data->policy);
 
 	return 0;
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b4f981daeaf2..170b70b6ec61 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -41,7 +41,6 @@ struct ti_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *ti_thermal;
 	struct thermal_zone_device *pcb_tz;
-	struct thermal_cooling_device *cool_dev;
 	struct ti_bandgap *bgp;
 	enum thermal_device_mode mode;
 	struct work_struct thermal_wq;
@@ -233,6 +232,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 {
 	struct ti_thermal_data *data;
 	struct device_node *np = bgp->dev->of_node;
+	struct thermal_cooling_device *cdev;
 
 	/*
 	 * We are assuming here that if one deploys the zone
@@ -256,9 +256,9 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	}
 
 	/* Register cooling device */
-	data->cool_dev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(data->cool_dev)) {
-		int ret = PTR_ERR(data->cool_dev);
+	cdev = cpufreq_cooling_register(data->policy);
+	if (IS_ERR(cdev)) {
+		int ret = PTR_ERR(cdev);
 		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
 			ret);
 		cpufreq_cpu_put(data->policy);
@@ -277,7 +277,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
 	if (data) {
-		cpufreq_cooling_unregister(data->cool_dev);
+		cpufreq_cooling_unregister(data->policy);
 		if (data->policy)
 			cpufreq_cpu_put(data->policy);
 	}
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index bae54bb7c048..89f469ee4be4 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -29,9 +29,9 @@ cpufreq_cooling_register(struct cpufreq_policy *policy);
 
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
- * @cdev: thermal cooling device pointer.
+ * @policy: cpufreq policy
  */
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
+void cpufreq_cooling_unregister(struct cpufreq_policy *policy);
 
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
@@ -41,7 +41,7 @@ cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 
 static inline
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
 {
 	return;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a1467aa7f58b..ce13204df972 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -144,9 +144,6 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
-
-	/* Pointer to the cooling device if used for thermal mitigation */
-	struct thermal_cooling_device *cdev;
 };
 
 struct cpufreq_freqs {
-- 
2.17.1

