Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF9FD9A4B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394528AbfJPTiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:38:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39541 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394467AbfJPThf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:37:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so23910314qki.6
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38nUlQ280db1teoWXJr5goa3S5XCcmnJve1ialuZYvw=;
        b=v/D8Y7BXvaM6J4ToYwytgKAszlQ2KPBpo663ZehSYFofsjHDLPgvmwgVr48dLKV60q
         k4/IV1qmrP/bfQfepJLIsGocha/KYKZ8DESwYGMfwGsTZPYXRRw1ZgFI90lobiPBlPAD
         ow9KSH+phCTVKdYntLWqt3ePrOfmK1x0gzrKWJRRxWJirQ2OCwKDLeURiSTda23mrnxu
         HTDA3C1XcYVCScZ6AJmseKbJbmoIbtA0L53LE2GYEfhFgiiAYX7/d/dpB7TiU7zJkcWl
         isPwThklVOYKgez/NZtjSjWTUPudlv9K1GvMe+JLN7A+hxG8wvwY3il1ocf5JPlSOc4k
         Ipvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38nUlQ280db1teoWXJr5goa3S5XCcmnJve1ialuZYvw=;
        b=lRKpoYxBbx12psL+8aYP9/N+ySfl5HpV6w0H41rh1eL0iZcNR8GaUTlTCXOPXcZlqU
         usP4RWjnVLgCwnyGa20w/8xCEbzMjcSOYmwWMDEQGnO0uiOUt84adr1Y6UHxY2JjpknS
         pPDQLV3DIinqG/0bzUOh33Im+YVV9J5ccUp+d47C4h6fTW0YPdoXXxtSAFyx6HOoIHD0
         gXnASRmXCM/G+UYYqwKPVuEfSuvPCqAHZYLBZOQxLe8V5yPGchJ4VrXQ15DYHg+dKltZ
         TU3X349OWLH9mNQUNwAg+cLaIcNozRFd9a4pJLoMQdMxLKS4vfht5cbwArzko2VKi1RU
         6ueA==
X-Gm-Message-State: APjAAAUIrj/hoswKLB+twNB2TsGcrcvaGtQ4sb8wKeEVGgKJWGg2kg1d
        MiQsbyidAFUM7Eja3Uqy7p250w==
X-Google-Smtp-Source: APXvYqwQQEKa/nQ3OjN9x8FiX7dtyFHIetb+iJx78Vj+w7diiKBavLlyLLuQwr52oe1gBEUpL5234g==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr43633188qkk.482.1571254654648;
        Wed, 16 Oct 2019 12:37:34 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:33 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] thermal: Add generic power domain warming device driver.
Date:   Wed, 16 Oct 2019 15:37:18 -0400
Message-Id: <1571254641-13626-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resources modeled as power domains in linux kenrel
can  be used to warm the SoC(eg. mx power domain on sdm845).
To support this feature, introduce a generic power domain
warming device driver that can be plugged into the thermal framework
(The thermal framework itself requires further modifiction to
support a warming device in place of a cooling device.
Those extensions are not introduced in this patch series).

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/Kconfig              |  10 +++
 drivers/thermal/Makefile             |   2 +
 drivers/thermal/pwr_domain_warming.c | 136 +++++++++++++++++++++++++++++++++++
 include/linux/pwr_domain_warming.h   |  31 ++++++++
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
index 0000000..60fae3e
--- /dev/null
+++ b/drivers/thermal/pwr_domain_warming.c
@@ -0,0 +1,136 @@
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
+	struct generic_pm_domain *gpd;
+	struct device *dev;
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
+	*state = dev_pm_genpd_get_performance_state(pd_wdev->dev);
+
+	return 0;
+}
+
+static int pd_wdev_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = pd_wdev->dev;
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
+static int pd_wdev_late_init(struct thermal_cooling_device *cdev)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = &cdev->device;
+	int state_count, ret;
+
+	ret = pm_genpd_add_device(pd_wdev->gpd, dev);
+
+	if (ret)
+		return ret;
+
+	state_count = dev_pm_genpd_performance_state_count(dev);
+	if (state_count < 0)
+		return state_count;
+
+	pm_runtime_enable(dev);
+
+	pd_wdev->dev = dev;
+	pd_wdev->max_state = state_count - 1;
+
+	return 0;
+}
+
+static struct thermal_cooling_device_ops pd_warming_device_ops = {
+	.late_init	= pd_wdev_late_init,
+	.get_max_state	= pd_wdev_get_max_state,
+	.get_cur_state	= pd_wdev_get_cur_state,
+	.set_cur_state	= pd_wdev_set_cur_state,
+};
+
+struct thermal_cooling_device *
+pwr_domain_warming_register(struct device_node *node,
+			    struct generic_pm_domain *gpd)
+{
+	struct pd_warming_device *pd_wdev;
+
+	pd_wdev = kzalloc(sizeof(*pd_wdev), GFP_KERNEL);
+	if (!pd_wdev)
+		return ERR_PTR(-ENOMEM);
+
+	pd_wdev->runtime_resumed = false;
+	pd_wdev->gpd = gpd;
+
+	pd_wdev->cdev = thermal_of_cooling_device_register
+					(node, gpd->name, pd_wdev,
+					 &pd_warming_device_ops);
+	if (IS_ERR(pd_wdev->cdev)) {
+		pr_err("unable to register %s cooling device\n", gpd->name);
+		if (pd_wdev->dev)
+			pm_runtime_disable(pd_wdev->dev);
+	}
+
+	return pd_wdev->cdev;
+}
+EXPORT_SYMBOL_GPL(pwr_domain_warming_register);
+
+void pwr_domain_warming_unregister(struct thermal_cooling_device *cdev)
+{
+	struct pd_warming_device *pd_wdev = cdev->devdata;
+	struct device *dev = pd_wdev->dev;
+
+	if (pd_wdev->runtime_resumed) {
+		dev_pm_genpd_set_performance_state(dev, 0);
+		pm_runtime_put(dev);
+		pd_wdev->runtime_resumed = false;
+	}
+	pm_runtime_disable(pd_wdev->dev);
+	thermal_cooling_device_unregister(cdev);
+	kfree(pd_wdev);
+}
+EXPORT_SYMBOL_GPL(pwr_domain_warming_unregister);
diff --git a/include/linux/pwr_domain_warming.h b/include/linux/pwr_domain_warming.h
new file mode 100644
index 0000000..ed9942b
--- /dev/null
+++ b/include/linux/pwr_domain_warming.h
@@ -0,0 +1,31 @@
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
+pwr_domain_warming_register(struct device_node *node,
+			    struct generic_pm_domain *gpd);
+
+void pwr_domain_warming_unregister(struct thermal_cooling_device *cdev);
+
+#else
+static inline struct thermal_cooling_device *
+pwr_domain_warming_register(struct device_node *node,
+			    struct generic_pm_domain *gpd)
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

