Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153712D9A2C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440030AbgLNOlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:41:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408238AbgLNOlI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:41:08 -0500
Date:   Mon, 14 Dec 2020 14:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1tBb04OVvZfleX4tAoSu0Iiy0lzgH9qxxzdLFHZHOE=;
        b=ulpbz2EUijxHKRIOMSyvpmA/8Dz/pwWxCGJxJFPrMAzXSjqxHWKA7AKpcuL0aqgbUy3Ku1
        blHR4mwUcBqhNA02kR0QcycaEci4DYz2LeNBXAx7zgvGohCnFADatz/Lq1a0O+8/08SjpL
        0j8rvTEVrYPFAT8nGoJBiSu43uPiXYcbO3e/mc6Us9k0QhvFQ0hlYYgezJppnknyWByhPV
        bwQ0X/ywKffD9UBkq/C6cY/iQnPteYx5UXYcA4cR7OoocKlfiwUA5LGArod7/YghZLN6R5
        z940ynhXwGx3vTjbDIEky8MYvfuuiRplfqUbpujNH2Y539+Xecu9vsG+d5jhAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1tBb04OVvZfleX4tAoSu0Iiy0lzgH9qxxzdLFHZHOE=;
        b=B3O+npI255wiwCuedxMQ4oB4lOWrmVtRVnQWAdgxd7l131fJQS3igwCF17fSS+tXj7vAGD
        LB4oTiSHka1jWAAw==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: devfreq_cooling: add new
 registration functions with Energy Model
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210143014.24685-4-lukasz.luba@arm.com>
References: <20201210143014.24685-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160795681999.3364.3075945558960881233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     84e0d87c9944eb36ae6037af5cb6905f67c074c5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//84e0d87c9944eb36ae6037af5cb6905f67c074c5
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 10 Dec 2020 14:30:12 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Dec 2020 14:10:44 +01:00

thermal: devfreq_cooling: add new registration functions with Energy Model

The Energy Model (EM) framework supports devices such as Devfreq. Create
new registration function which automatically register EM for the thermal
devfreq_cooling devices. This patch prepares the code for coming changes
which are going to replace old power model with the new EM.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210143014.24685-4-lukasz.luba@arm.com
---
 drivers/thermal/devfreq_cooling.c | 54 +++++++++++++++++++++++++++++-
 include/linux/devfreq_cooling.h   | 10 ++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index afcebad..6cea027 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -12,6 +12,7 @@
 
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
@@ -577,21 +578,72 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
 EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
+ * devfreq_cooling_em_register_power() - Register devfreq cooling device with
+ *		power information and automatically register Energy Model (EM)
+ * @df:		Pointer to devfreq device.
+ * @dfc_power:	Pointer to devfreq_cooling_power.
+ *
+ * Register a devfreq cooling device and automatically register EM. The
+ * available OPPs must be registered for the device.
+ *
+ * If @dfc_power is provided, the cooling device is registered with the
+ * power extensions. It is using the simple Energy Model which requires
+ * "dynamic-power-coefficient" a devicetree property. To not break drivers
+ * which miss that DT property, the function won't bail out when the EM
+ * registration failed. The cooling device will be registered if everything
+ * else is OK.
+ */
+struct thermal_cooling_device *
+devfreq_cooling_em_register(struct devfreq *df,
+			    struct devfreq_cooling_power *dfc_power)
+{
+	struct thermal_cooling_device *cdev;
+	struct device *dev;
+	int ret;
+
+	if (IS_ERR_OR_NULL(df))
+		return ERR_PTR(-EINVAL);
+
+	dev = df->dev.parent;
+
+	ret = dev_pm_opp_of_register_em(dev, NULL);
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
+EXPORT_SYMBOL_GPL(devfreq_cooling_em_register);
+
+/**
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
index 9df2dfc..7a9fbcc 100644
--- a/include/linux/devfreq_cooling.h
+++ b/include/linux/devfreq_cooling.h
@@ -65,6 +65,9 @@ struct thermal_cooling_device *
 of_devfreq_cooling_register(struct device_node *np, struct devfreq *df);
 struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df);
 void devfreq_cooling_unregister(struct thermal_cooling_device *dfc);
+struct thermal_cooling_device *
+devfreq_cooling_em_register(struct devfreq *df,
+			    struct devfreq_cooling_power *dfc_power);
 
 #else /* !CONFIG_DEVFREQ_THERMAL */
 
@@ -87,6 +90,13 @@ devfreq_cooling_register(struct devfreq *df)
 	return ERR_PTR(-EINVAL);
 }
 
+static inline struct thermal_cooling_device *
+devfreq_cooling_em_register(struct devfreq *df,
+			    struct devfreq_cooling_power *dfc_power)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 static inline void
 devfreq_cooling_unregister(struct thermal_cooling_device *dfc)
 {
