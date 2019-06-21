Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6946D4E8F5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUNXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 09:23:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35438 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfFUNXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 09:23:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so6638420wml.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gx8HrKvqg1+iiIrNTNFr/x4ncyqpR/tpssMykxjZoIo=;
        b=xg/Z0J/KgZDs5GNjVp0/tt7hCsJbGidqTEhq9Lgyniryk6kYV7gIBCMfh1QMNVHXAg
         q4GiZE2HWVVCpHhhgS4mRH61TX94rjq51/V4eT8uqX0y9GCEHdEwcP71GUbK6ZUbzn80
         T4IcNuoTd5Gd9IJTk5YD56OeJ8zeOVRiGRTLcWvGLAldfV+j6FL8B7puPMwwsDeukdlS
         6YF62dMpKA5nLU0jDmzI1FOcHLHqPcs5c33YIZOor0TmgU97X/bFuzXusr4wh+uSnhXN
         ReooB3BmmLa3AoXPfbV+wRxixaEeQl/5TXDFhY/bii1BhFkxCIDsE18/0ZYvm6w6X2bx
         XADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gx8HrKvqg1+iiIrNTNFr/x4ncyqpR/tpssMykxjZoIo=;
        b=kdlvrIMERbngtupF4TT1ZpYka3jdXXckh3D20shp88AyK+lggdpYyaHq4xNnJqHR7e
         +Rh7P/WL2N24lp+S5+bZz+pn6ArNdHp8AK/h0CjxVEtDHC+e3TYlsoCMFDsaQlq3sYvG
         6C1Mj9A+BEXpZ4dz5EFXhoAXlA8oBXDiFW0DkDrQy/0yRAmku3ABbnJnpLfP28rUqhkw
         q1QGUd077f2pe4jAsxZN3YNiOeUTQWVqJITxUndzF13n6TfgW3Qm1OvWrZChtKkkSymF
         QRu2+LdESOOjw94xCBVKsIHcuctVWLPL9QCJThbs0xlcXoduYfEV3ScVFbwCpvxgn0p1
         QNiw==
X-Gm-Message-State: APjAAAWO/dW+8tDhV43xfcGDuuTS1IMhTkc7jz7HEVQigIld7+3MsiH+
        E9zLXA1s/+vSD8Y3Y5xV9GoiiA==
X-Google-Smtp-Source: APXvYqwiK2YLLh/7p4eqEary1Le1rQQ7myE1nL7nNHR+2YMuLzMoEjM0Rtm1jo7pGcrCE7GXEnoXFQ==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr3682724wmg.92.1561123407785;
        Fri, 21 Jun 2019 06:23:27 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Subject: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the policy
Date:   Fri, 21 Jun 2019 15:22:58 +0200
Message-Id: <20190621132302.30414-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621132302.30414-1-daniel.lezcano@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/arm_big_little.c               |  2 +-
 drivers/cpufreq/cpufreq.c                      |  2 +-
 drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
 drivers/thermal/imx_thermal.c                  |  4 ++--
 .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
 include/linux/cpu_cooling.h                    |  6 +++---
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 7fe52fcddcf1..6b243202caa9 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -502,7 +502,7 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
 	if (cur_cluster < MAX_CLUSTERS) {
-		cpufreq_cooling_unregister(cdev[cur_cluster]);
+		cpufreq_cooling_unregister(policy);
 		cdev[cur_cluster] = NULL;
 	}
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c72f7d3509c..dfbc9bea606c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1469,7 +1469,7 @@ static int cpufreq_offline(unsigned int cpu)
 	}
 
 	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
-		cpufreq_cooling_unregister(policy->cdev);
+		cpufreq_cooling_unregister(policy);
 		policy->cdev = NULL;
 	}
 
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 83486775e593..007c7c6bf845 100644
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
@@ -699,18 +701,18 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
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
+	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
+		if (cpufreq_cdev->policy == policy) {
+			list_del(&cpufreq_cdev->node);
+			break;
+		}
+	}
 	/* Unregister the notifier for the last cpufreq cooling device */
 	last = list_empty(&cpufreq_cdev_list);
 	mutex_unlock(&cooling_list_lock);
@@ -719,7 +721,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cdev);
+	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb6754a5342c..6746f1b73eb7 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
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
index b4f981daeaf2..217b1aae8b4f 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
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
-- 
2.17.1

