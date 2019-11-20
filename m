Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACC103A6F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfKTM44 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:56:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46695 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfKTM4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:56:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id r20so28730884qtp.13
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UM2VNIyhsEQWAdxoUvBsAp0FiOlz8ZfKGsaB/5AYX7U=;
        b=WD85C7u9NWEMbHwM/sjKEJ4ryfnNgTq8BlVICVvxRxopHEEe+V0gp1qsTJaBODoV7L
         0qE3b01AwO9mamaPEukWnzpvRAICFGL7Y8V75jkkn9rrt7FV3M5EGCKxmLZkRM//MeLu
         DL8MqTPlzvfuO5j1DL1pl2mCM/ht/AVuL48lXY70xE6x0XbDx9px3UdYVm+4OPRzs+ma
         SVnyBCFwbqQu4TrVCYt28lHsyhxIzzrQhY1C5NU4YtVLv5/nnBpk4oDMYrgFeukxKudZ
         Q7lrhjUG0BvDr12OTGAnxAi5mtLuYnTL8xM4L2OxgzHcTj+BIHpX6RX18JQx3Y+DsrKi
         N0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UM2VNIyhsEQWAdxoUvBsAp0FiOlz8ZfKGsaB/5AYX7U=;
        b=SZWBsDQ0Q9rO7BoWvz2Iahry239HeIbjnsRqIGWLb6PMzop2llqtz2aE7SqS6XQyT+
         gtjvNr/Gq+PiIeixEEYxAr/ttreEea5WICDpVCECdWq0K0py+79KtJUeE1WQYM8Ild1b
         vOidIike4SMcy5dbP2qFbPYvp2vEqvE2xx0N9/ug97f7WVb8bSoTz6XziYYLKzYjwdud
         OiuN+Nnrj9dUz23QCnrW6AnLF1cte/z6dyDo0XSl6L+VpgAbaxdQEz2uuTU1QwWCN1da
         B4Z6sXUqrNCGXEj2b7O55s090FUJQV3lGHm8jeYjg08uAplRDqZnlvXO/X1SekjGs8WJ
         GXzA==
X-Gm-Message-State: APjAAAXUMqM/+mNhUHxoqClM/s3bFfVQO5BKKsSeCi/z8yAk1UjdL9cs
        wK60AXUZKyktkxDouS9+Kw9lnQ==
X-Google-Smtp-Source: APXvYqwCTITcGMrN0VxfpnmTjfH0pUcc1CbAhIlqWewcG1arkytYtpoX747E2f8lLjCTV79k0rI32A==
X-Received: by 2002:ac8:288a:: with SMTP id i10mr2378040qti.139.1574254613445;
        Wed, 20 Nov 2019 04:56:53 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 4/7] thermal: Add generic power domain warming device driver.
Date:   Wed, 20 Nov 2019 07:56:30 -0500
Message-Id: <1574254593-16078-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resources modeled as power domains in linux kenrel can  be used to warm the
SoC(eg. mx power domain on sdm845).  To support this feature, introduce a
generic power domain warming device driver that can be plugged into the
thermal framework (The thermal framework itself requires further
modifiction to support a warming device in place of a cooling device.
Those extensions are not introduced in this patch series).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v3->v4:
	- Removed late_init hook pd_warming_device_ops.
	- Use of_genpd_add_device instead of pm_genpd_add_device to attach
	  device to the generic power domain.
	- Use thermal_of_cooling_device_parent_register to register the
	  cooling device so that the device with genpd attached can be
	  made parent of the cooling device.
	- With above changes, remove reference to generic_pm_domain in
	  pd_warming_device.

 drivers/thermal/Kconfig              |  10 +++
 drivers/thermal/Makefile             |   2 +
 drivers/thermal/pwr_domain_warming.c | 138 +++++++++++++++++++++++++++++++++++
 include/linux/pwr_domain_warming.h   |  29 ++++++++
 4 files changed, 179 insertions(+)
 create mode 100644 drivers/thermal/pwr_domain_warming.c
 create mode 100644 include/linux/pwr_domain_warming.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 001a21a..0c5c93e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -187,6 +187,16 @@ config DEVFREQ_THERMAL
 
 	  If you want this support, you should say Y here.
 
+config PWR_DOMAIN_WARMING_THERMAL
+	bool "Power Domain based warming device"
+	depends on PM_GENERIC_DOMAINS_OF
+	help
+	  This implements the generic power domain based warming
+	  mechanism through increasing the performance state of
+	  a power domain.
+
+	  If you want this support, you should say Y here.
+
 config THERMAL_EMULATION
 	bool "Thermal emulation mode support"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 74a37c7..382c64a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -27,6 +27,8 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
+thermal_sys-$(CONFIG_PWR_DOMAIN_WARMING_THERMAL)	+= pwr_domain_warming.o
+
 # platform thermal drivers
 obj-y				+= broadcom/
 obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
diff --git a/drivers/thermal/pwr_domain_warming.c b/drivers/thermal/pwr_domain_warming.c
new file mode 100644
index 0000000..40162b9
--- /dev/null
+++ b/drivers/thermal/pwr_domain_warming.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd
+ */
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/pwr_domain_warming.h>
+
+struct pd_warming_device {
+	struct thermal_cooling_device *cdev;
+	struct device dev;
+	int max_state;
+	int cur_state;
+	bool runtime_resumed;
+};
+
+static int pd_wdev_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+
+	*state = pd_wdev->max_state;
+	return 0;
+}
+
+static int pd_wdev_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+
+	*state = dev_pm_genpd_get_performance_state(&pd_wdev->dev);
+
+	return 0;
+}
+
+static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = &pd_wdev->dev;
+	int ret;
+
+	ret = dev_pm_genpd_set_performance_state(dev, state);
+
+	if (ret)
+		return ret;
+
+	if (state && !pd_wdev->runtime_resumed) {
+		ret = pm_runtime_get_sync(dev);
+		pd_wdev->runtime_resumed = true;
+	} else if (!state && pd_wdev->runtime_resumed) {
+		ret = pm_runtime_put(dev);
+		pd_wdev->runtime_resumed = false;
+	}
+
+	return ret;
+}
+
+static struct thermal_cooling_device_ops pd_warming_device_ops = {
+	.get_max_state	= pd_wdev_get_max_state,
+	.get_cur_state	= pd_wdev_get_cur_state,
+	.set_cur_state	= pd_wdev_set_cur_state,
+};
+
+struct thermal_cooling_device *
+pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)
+{
+	struct pd_warming_device *pd_wdev;
+	struct of_phandle_args pd_args;
+	int ret;
+
+	pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
+	if (!pd_wdev)
+		return ERR_PTR(-ENOMEM);
+
+	dev_set_name(&pd_wdev->dev, "%s_warming_dev", pd_name);
+	pd_wdev->dev.parent = parent;
+
+	ret = device_register(&pd_wdev->dev);
+	if (ret)
+		goto error;
+
+	pd_args.np = parent->of_node;
+	pd_args.args[0] = pd_id;
+	pd_args.args_count = 1;
+
+	ret = of_genpd_add_device(&pd_args, &pd_wdev->dev);
+
+	if (ret)
+		goto error;
+
+	ret = dev_pm_genpd_performance_state_count(&pd_wdev->dev);
+	if (ret < 0)
+		goto error;
+
+	pd_wdev->max_state = ret - 1;
+	pm_runtime_enable(&pd_wdev->dev);
+	pd_wdev->runtime_resumed = false;
+
+	pd_wdev->cdev = thermal_of_cooling_device_parent_register
+					(NULL, parent, pd_name, pd_wdev,
+					 &pd_warming_device_ops);
+	if (IS_ERR(pd_wdev->cdev)) {
+		pr_err("unable to register %s cooling device\n", pd_name);
+		pm_runtime_disable(&pd_wdev->dev);
+		ret = PTR_ERR(pd_wdev->cdev);
+		goto error;
+	}
+
+	return pd_wdev->cdev;
+error:
+	put_device(&pd_wdev->dev);
+	kfree(pd_wdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pwr_domain_warming_register);
+
+void pwr_domain_warming_unregister(struct thermal_cooling_device *cdev)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = &pd_wdev->dev;
+
+	if (pd_wdev->runtime_resumed) {
+		dev_pm_genpd_set_performance_state(dev, 0);
+		pm_runtime_put(dev);
+		pd_wdev->runtime_resumed = false;
+	}
+	pm_runtime_disable(dev);
+	thermal_cooling_device_unregister(cdev);
+	kfree(pd_wdev);
+}
+EXPORT_SYMBOL_GPL(pwr_domain_warming_unregister);
diff --git a/include/linux/pwr_domain_warming.h b/include/linux/pwr_domain_warming.h
new file mode 100644
index 0000000..cb6550d
--- /dev/null
+++ b/include/linux/pwr_domain_warming.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ */
+#ifndef __PWR_DOMAIN_WARMING_H__
+#define __PWR_DOMAIN_WARMING_H__
+
+#include <linux/pm_domain.h>
+#include <linux/thermal.h>
+
+#ifdef CONFIG_PWR_DOMAIN_WARMING_THERMAL
+struct thermal_cooling_device *
+pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id);
+
+void pwr_domain_warming_unregister(struct thermal_cooling_device *cdev);
+
+#else
+static inline struct thermal_cooling_device *
+pwr_domain_warming_register(struct device *parent, char *pd_name, int pd_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void
+pwr_domain_warming_unregister(struct thermal_cooling_device *cdev)
+{
+}
+#endif /* CONFIG_PWR_DOMAIN_WARMING_THERMAL */
+#endif /* __PWR_DOMAIN_WARMING_H__ */
-- 
2.1.4

