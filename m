Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F244A192C39
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 16:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCYPW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 11:22:56 -0400
Received: from comms.puri.sm ([159.203.221.185]:33646 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbgCYPWz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 11:22:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 95FA3DFA1F;
        Wed, 25 Mar 2020 08:22:54 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JmE3ovJBVZ1C; Wed, 25 Mar 2020 08:22:53 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     linux-imx@nxp.com, leonard.crestez@nxp.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [RFC] PM / devfreq: add busfreq governor
Date:   Wed, 25 Mar 2020 16:22:24 +0100
Message-Id: <20200325152224.6613-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A devfreq governor to be used by drivers to request ("get") a frequency
setting they need. Currently only "HIGH" (performance) is available.

ATTENTION: This is a first draft to serve merely as a basis for discussions!
ONLY USE FOR TESTING!
---

I wanted to get early feedback on an idea that AFAIK is not yet available
in the kernel (but something similar via "busfreq" in NXP's tree):

Let drivers request high (dram) frequencies at runtime if they know they need
them. In our case the display stack on imx8mq would be the first user,
looking like so: #include <linux/devfreq.h> and:

	--- a/drivers/gpu/drm/bridge/nwl-dsi.c
	+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
	@@ -1116,6 +1117,9 @@ static int imx8mq_dsi_poweron(struct nwl_dsi *dsi)
			ret = reset_control_deassert(dsi->rstc);
	 
	+       devfreq_busfreq_request(DEVFREQ_BUSFREQ_HIGH);
	+
		return ret;
	@@ -1125,6 +1129,10 @@ static int imx8mq_dsi_poweroff(struct nwl_dsi *dsi)
		if (dsi->rstc)
			ret = reset_control_assert(dsi->rstc);
	+
	+       devfreq_busfreq_release(DEVFREQ_BUSFREQ_HIGH);
	+
		return ret;


Could be called in pm_runtime() calls too.

_If_ the idea of such or a similar governor is viable, there are at least
some problems with this implemenation still:

* The governor saves its data as a global variable (which I don't yet like)
  but the driver (user) API becomes minimal.

* the name: In order to add to the devfreq/busfreq confusion, I named the
  devfreq governor "busfreq" -.-
  I just wanted to grab NXPs' attention because they do something similar
  in their tree.

* ATM we switch between "performace" and "powersave, which is
  not bad at all, but still limited in case a driver would really only
  need a medium frequecy for a device to work. doable?

* I doubt locking is done correctly and the code is overall of bad quality
  still. Again, It's a first idea.

I'm glad about any thought or feedback,

thanks,
                                   martin




 drivers/devfreq/Kconfig            |   5 +
 drivers/devfreq/Makefile           |   1 +
 drivers/devfreq/governor_busfreq.c | 172 +++++++++++++++++++++++++++++
 include/linux/devfreq.h            |  22 ++++
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/devfreq/governor_busfreq.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index fc2ea336ef4b..3575cbdcd29e 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -74,6 +74,11 @@ config DEVFREQ_GOV_PASSIVE
 	  through sysfs entries. The passive governor recommends that
 	  devfreq device uses the OPP table to get the frequency/voltage.
 
+config DEVFREQ_GOV_BUSFREQ
+	tristate "Busfreq"
+	help
+	  Sets the frequency that compatible drivers request it to set.
+
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 61d0edee16f7..657b0b6d92c4 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
+obj-$(CONFIG_DEVFREQ_GOV_BUSFREQ)	+= governor_busfreq.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
diff --git a/drivers/devfreq/governor_busfreq.c b/drivers/devfreq/governor_busfreq.c
new file mode 100644
index 000000000000..e12d64e9a09b
--- /dev/null
+++ b/drivers/devfreq/governor_busfreq.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/drivers/devfreq/governor_busfreq.c
+ *
+ *  Copyright (C) 2020 Purism SPC
+ */
+
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/devfreq.h>
+#include <linux/pm.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include "governor.h"
+
+struct busfreq_data {
+	unsigned long user_frequency;
+	bool valid;
+	struct devfreq *df;
+	unsigned int high_count;
+};
+
+static struct busfreq_data *bfdata = NULL;
+
+static int devfreq_busfreq_func(struct devfreq *df, unsigned long *freq)
+{
+	if (bfdata->valid)
+		*freq = bfdata->user_frequency;
+	else
+		*freq = df->previous_freq; /* No user freq specified yet */
+
+	return 0;
+}
+
+int devfreq_busfreq_request(unsigned long freq)
+{
+	struct devfreq *devfreq;
+	int err = 0;
+
+	if (!bfdata) {
+		pr_info("%s: governor not available\n", __func__);
+		return -ENODEV;
+	}
+
+	if (freq != DEVFREQ_BUSFREQ_HIGH) {
+		pr_err("%s: undefined frequency\n", __func__);
+		return -EINVAL;
+	}
+
+	if (freq == DEVFREQ_BUSFREQ_HIGH)
+		bfdata->high_count++;
+
+	devfreq = bfdata->df;
+
+	mutex_lock(&devfreq->lock);
+
+	bfdata->user_frequency = freq;
+	bfdata->valid = true;
+	err = update_devfreq(devfreq); /* calls our get_target_freq */
+	if (err)
+		dev_err(&devfreq->dev, "update_devfreq failed: %d\n", err);
+
+	mutex_unlock(&devfreq->lock);
+
+	return err;
+}
+EXPORT_SYMBOL(devfreq_busfreq_request);
+
+void devfreq_busfreq_release(unsigned long freq)
+{
+	struct devfreq *devfreq;
+	int err = 0;
+
+	if (!bfdata) {
+		pr_info("%s: governor not available\n", __func__);
+		return;
+	}
+
+	if (freq != DEVFREQ_BUSFREQ_HIGH) {
+		pr_err("%s: undefined frequency\n", __func__);
+		return;
+	}
+
+	if (freq == DEVFREQ_BUSFREQ_HIGH && bfdata->high_count > 0)
+		bfdata->high_count--;
+
+	if (bfdata->high_count)
+		return;
+
+	devfreq = bfdata->df;
+
+	mutex_lock(&devfreq->lock);
+
+	bfdata->user_frequency = DEVFREQ_BUSFREQ_LOW;
+	bfdata->valid = true;
+	err = update_devfreq(devfreq); /* calls our get_target_freq */
+	if (err)
+		dev_err(&devfreq->dev, "update_devfreq failed: %d\n", err);
+
+	mutex_unlock(&devfreq->lock);
+}
+EXPORT_SYMBOL(devfreq_busfreq_release);
+
+static int busfreq_init(struct devfreq *devfreq)
+{
+	int err = 0;
+
+	bfdata = kzalloc(sizeof(struct busfreq_data),
+		      GFP_KERNEL);
+	if (!bfdata) {
+		err = -ENOMEM;
+		goto out;
+	}
+	bfdata->valid = false;
+	devfreq->data = bfdata;
+	bfdata->df = devfreq;
+
+out:
+	return err;
+}
+
+static void busfreq_exit(struct devfreq *devfreq)
+{
+	if (bfdata)
+		kfree(bfdata);
+
+	devfreq->data = NULL;
+}
+
+static int devfreq_busfreq_handler(struct devfreq *devfreq,
+				   unsigned int event, void *data)
+{
+	int ret = 0;
+
+	switch (event) {
+	case DEVFREQ_GOV_START:
+		ret = busfreq_init(devfreq);
+		break;
+	case DEVFREQ_GOV_STOP:
+		busfreq_exit(devfreq);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static struct devfreq_governor devfreq_busfreq = {
+	.name = "busfreq",
+	.get_target_freq = devfreq_busfreq_func,
+	.event_handler = devfreq_busfreq_handler,
+};
+
+static int __init devfreq_busfreq_init(void)
+{
+	return devfreq_add_governor(&devfreq_busfreq);
+}
+subsys_initcall(devfreq_busfreq_init);
+
+static void __exit devfreq_busfreq_exit(void)
+{
+	int ret;
+
+	ret = devfreq_remove_governor(&devfreq_busfreq);
+	if (ret)
+		pr_err("%s: failed remove governor %d\n", __func__, ret);
+
+	return;
+}
+module_exit(devfreq_busfreq_exit);
+MODULE_LICENSE("GPL");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 678391c1bb0f..df1bf6928d87 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -23,6 +23,7 @@
 #define DEVFREQ_GOV_POWERSAVE		"powersave"
 #define DEVFREQ_GOV_USERSPACE		"userspace"
 #define DEVFREQ_GOV_PASSIVE		"passive"
+#define DEVFREQ_GOV_BUSFREQ		"busfreq"
 
 /* DEVFREQ notifier interface */
 #define DEVFREQ_TRANSITION_NOTIFIER	(0)
@@ -310,6 +311,27 @@ struct devfreq_passive_data {
 };
 #endif
 
+/*
+ * "powersave" by default
+ * giving drivers the option to require "performance"
+ */
+#define DEVFREQ_BUSFREQ_HIGH			ULONG_MAX
+#define DEVFREQ_BUSFREQ_LOW			0
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_BUSFREQ)
+extern int devfreq_busfreq_request(unsigned long freq);
+extern void devfreq_busfreq_release(unsigned long freq);
+#else
+static inline int devfreq_busfreq_request(unsigned long freq)
+{
+	return -ENOSYS;
+}
+
+static inline void devfreq_busfreq_release(unsigned long freq)
+{
+	return;
+}
+#endif
+
 #else /* !CONFIG_PM_DEVFREQ */
 static inline struct devfreq *devfreq_add_device(struct device *dev,
 					  struct devfreq_dev_profile *profile,
-- 
2.20.1

