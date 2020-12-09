Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C20E2D3FF4
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 11:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgLIKcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 05:32:00 -0500
Received: from foss.arm.com ([217.140.110.172]:60672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgLIKbz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Dec 2020 05:31:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4C5A142F;
        Wed,  9 Dec 2020 02:31:05 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.24.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 443083F718;
        Wed,  9 Dec 2020 02:31:02 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com, orjan.eide@arm.com,
        robh@kernel.org, alyssa.rosenzweig@collabora.com,
        steven.price@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        ionela.voinescu@arm.com
Subject: [PATCH v3 3/5] thermal: devfreq_cooling: add new registration functions with Energy Model
Date:   Wed,  9 Dec 2020 10:30:14 +0000
Message-Id: <20201209103016.10442-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209103016.10442-1-lukasz.luba@arm.com>
References: <20201209103016.10442-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model (EM) framework supports devices such as Devfreq. Create
new registration functions which automatically register EM for the thermal
devfreq_cooling devices. This patch prepares the code for coming changes
which are going to replace old power model with the new EM.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c | 83 ++++++++++++++++++++++++++++++-
 include/linux/devfreq_cooling.h   | 23 +++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index afcebadbad24..655eb89d60be 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -576,22 +576,103 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
 }
 EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
+/**
+ * devfreq_cooling_em_register_power() - Register devfreq cooling device with
+ *		power information and automatically register Energy Model (EM)
+ * @df:		Pointer to devfreq device.
+ * @dfc_power:	Pointer to devfreq_cooling_power.
+ * @em_cb:	Callback functions providing the data of the EM
+ *
+ * Register a devfreq cooling device and automatically register EM. The
+ * available OPPs must be registered for the device.
+ *
+ * If @dfc_power is provided, the cooling device is registered with the
+ * power extensions. If @em_cb is provided it will be called for each OPP to
+ * calculate power value and cost. If @em_cb is not provided then simple Energy
+ * Model is going to be used, which requires "dynamic-power-coefficient" a
+ * devicetree property. To not break drivers which miss that DT property,
+ * the function won't bail out when the EM registration failed. The cooling
+ * device will be registered if everything else is OK.
+ */
+struct thermal_cooling_device *
+devfreq_cooling_em_register_power(struct devfreq *df,
+				  struct devfreq_cooling_power *dfc_power,
+				  struct em_data_callback *em_cb)
+{
+	struct thermal_cooling_device *cdev;
+	struct device *dev;
+	int nr_opp, ret;
+
+	if (IS_ERR_OR_NULL(df))
+		return ERR_PTR(-EINVAL);
+
+	dev = df->dev.parent;
+
+	if (em_cb) {
+		nr_opp = dev_pm_opp_get_opp_count(dev);
+		if (nr_opp <= 0) {
+			dev_err(dev, "No valid OPPs found\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		ret = em_dev_register_perf_domain(dev, nr_opp, em_cb, NULL, true);
+	} else {
+		ret = dev_pm_opp_of_register_em(dev, NULL);
+	}
+
+	if (ret)
+		dev_dbg(dev, "Unable to register EM for devfreq cooling device (%d)\n",
+			ret);
+
+	cdev = of_devfreq_cooling_register_power(dev->of_node, df, dfc_power);
+
+	if (IS_ERR_OR_NULL(cdev))
+		em_dev_unregister_perf_domain(dev);
+
+	return cdev;
+}
+EXPORT_SYMBOL_GPL(devfreq_cooling_em_register_power);
+
+/**
+ * devfreq_cooling_em_register() - Register devfreq cooling device together
+ *				with Energy Model.
+ * @df:		Pointer to devfreq device.
+ * @em_cb:	Callback functions providing the data of the Energy Model
+ *
+ * This function attempts to register Energy Model for devfreq device and then
+ * register the devfreq cooling device.
+ */
+struct thermal_cooling_device *
+devfreq_cooling_em_register(struct devfreq *df, struct em_data_callback *em_cb)
+{
+	return devfreq_cooling_em_register_power(df, NULL, em_cb);
+}
+EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
+
 /**
  * devfreq_cooling_unregister() - Unregister devfreq cooling device.
  * @cdev: Pointer to devfreq cooling device to unregister.
+ *
+ * Unregisters devfreq cooling device and related Energy Model if it was
+ * present.
  */
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct devfreq_cooling_device *dfc;
+	struct device *dev;
 
-	if (!cdev)
+	if (IS_ERR_OR_NULL(cdev))
 		return;
 
 	dfc = cdev->devdata;
+	dev = dfc->devfreq->dev.parent;
 
 	thermal_cooling_device_unregister(dfc->cdev);
 	ida_simple_remove(&devfreq_ida, dfc->id);
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
+
+	em_dev_unregister_perf_domain(dev);
+
 	kfree(dfc->power_table);
 	kfree(dfc->freq_table);
 
diff --git a/include/linux/devfreq_cooling.h b/include/linux/devfreq_cooling.h
index 9df2dfca68dd..f8c9aeaa17f5 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -11,6 +11,7 @@
 #define __DEVFREQ_COOLING_H__
 
 #include <linux/devfreq.h>
+#include <linux/energy_model.h>
 #include <linux/thermal.h>
 
 
@@ -65,6 +66,13 @@ struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df);
 struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df);
 void devfreq_cooling_unregister(struct thermal_cooling_device *dfc);
+struct thermal_cooling_device *
+devfreq_cooling_em_register_power(struct devfreq *df,
+				  struct devfreq_cooling_power *dfc_power,
+				  struct em_data_callback *em_cb);
+struct thermal_cooling_device *
+devfreq_cooling_em_register(struct devfreq *df,
+			    struct em_data_callback *em_cb);
 
 #else /* !CONFIG_DEVFREQ_THERMAL */
 
@@ -87,6 +95,21 @@ devfreq_cooling_register(struct devfreq *df)
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct thermal_cooling_device *
+devfreq_cooling_em_register_power(struct devfreq *df,
+				  struct devfreq_cooling_power *dfc_power,
+				  struct em_data_callback *em_cb)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline struct thermal_cooling_device *
+devfreq_cooling_em_register(struct devfreq *df,
+			    struct em_data_callback *em_cb)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 static inline void
 devfreq_cooling_unregister(struct thermal_cooling_device *dfc)
 {
-- 
2.17.1

