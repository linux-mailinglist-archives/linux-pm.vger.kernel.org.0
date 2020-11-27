Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246452C60FC
	for <lists+linux-pm@lfdr.de>; Fri, 27 Nov 2020 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgK0Igy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 03:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgK0Igw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Nov 2020 03:36:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56BC0613D1;
        Fri, 27 Nov 2020 00:36:52 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t21so3798158pgl.3;
        Fri, 27 Nov 2020 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3GI0yzxrLtNBSs7MmAql586m2mzfUCGcCSg0XwCpMJ0=;
        b=l+6J5ABEraDSNC+g7EwHs4y4WtpVZE1Cgc2Gytzvj7s7NACvWVpYZATEFfsbLcLSO0
         r5QZIPPCMnK3Vels1cFI+quKaIUFTY5b/MxvgCjqt6Ihp0hfo1fDuRDnaq+Wz9lWNNqr
         iMOqsBVuXPT6qb0jfWPGwedUlCDPIerw6Va47O6DhLus1sxY3axIsAOekh8z9o+JAplK
         kriDamKAn8+g/C0TiUJWwLHO350zWuFL6AORz7uHmYzlRl2GV5O70yf5Wna6Pa/eBGrd
         TcJoJqTpKHXP/XducMvOjrqV0ZuLWLzXew+9xXWM7tblAaW0DRtHivejsUhyO0Q9kp0D
         FedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3GI0yzxrLtNBSs7MmAql586m2mzfUCGcCSg0XwCpMJ0=;
        b=RaRVGWU4VuE7Ogp0H5udHrudBr4OpLZp9dvdHzw0oVEiTIJBChlzzO8ab32p0O1KJu
         21RWQa8zUgX2PWb1xSwm2MF+mdYWsDN1MLoRRCtS2i8GOjweHitRpPSG1eYyN72l1N5b
         a9y7nvk8yM6EFWgI6zuH92ZQIapUdfy/XqeNH15B+V6dtKh1gj5mBdogfa8cdo1JiLMD
         XsIdOkJfMjXTazhpj4426HX8l76RUwNeM7i+9XCvR6rb71AWGqUTRm+Rt6ya5QDB5FXy
         7C9aicGMySug+UOzVqs2GJA37LWwHb+h3Lk77Z5vReTq5LfTk1n9c4zYl40lUItVJBfr
         dsdQ==
X-Gm-Message-State: AOAM533pNIqBFbVib3mRZb+L2Zcty3BjhBbfogUo5ZDK86+g/m5H0ffj
        auXXsl/X7J7sULLzEY9MJhY=
X-Google-Smtp-Source: ABdhPJw8k/laYHTH2PeO5VkzF9MUHLLLdjTEzK0lB5mThFAWE6Ub77vKuNoekmYFppfnjhVO/Yq4fQ==
X-Received: by 2002:a65:608b:: with SMTP id t11mr5738678pgu.72.1606466212429;
        Fri, 27 Nov 2020 00:36:52 -0800 (PST)
Received: from bj04432pcu2.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm7009969pfn.85.2020.11.27.00.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:36:52 -0800 (PST)
From:   gao.yunxiao6@gmail.com
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        robh+dt@kernel.org, javi.merino@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
Subject: [RFC 2/2] thermal: sprd: Add virtual thermal driver
Date:   Fri, 27 Nov 2020 16:36:44 +0800
Message-Id: <1606466204-31657-1-git-send-email-gao.yunxiao6@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "jeson.gao" <jeson.gao@unisoc.com>

IPA need a temperature of the whole CPU zone for thermal-cpufreq-0
and thermal-cpufreq-1 cooling device but the real sensor is placed
near per-core on sprd platform,so adding this driver to register a
virtual sensor,it will polling the temperature of per-core and find
the highest temperature as the current temperature of the whole cpu
zone for IPA using.

Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
---
 drivers/thermal/Kconfig                |   9 ++
 drivers/thermal/Makefile               |   1 +
 drivers/thermal/sprd_virtual_thermal.c | 213 +++++++++++++++++++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 drivers/thermal/sprd_virtual_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7edc8dc6bbab..b3d392846f69 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -500,6 +500,15 @@ config SPRD_THERMAL
 	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
 	  framework.
 
+config SPRD_VIRTUAL_THERMAL
+	tristate "sprd virtual thermal"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on SPRD_THERMAL
+	help
+	  Say Y here to support virtual thermal driver
+	  We can use it to find the highest temperature from 8 per core sensor
+	  as the current temperature of the whole cpu zone.
+
 config KHADAS_MCU_FAN_THERMAL
 	tristate "Khadas MCU controller FAN cooling support"
 	depends on OF || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b64dd50a6629..f4aecfff3703 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,4 +61,5 @@ obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
+obj-$(CONFIG_SPRD_VIRTUAL_THERMAL)	+= sprd_virtual_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
diff --git a/drivers/thermal/sprd_virtual_thermal.c b/drivers/thermal/sprd_virtual_thermal.c
new file mode 100644
index 000000000000..db4d6eca2356
--- /dev/null
+++ b/drivers/thermal/sprd_virtual_thermal.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 Unisoc Inc.
+
+#include <linux/cpu_cooling.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/of.h>
+#include <linux/kernel.h>
+
+struct virtual_thm {
+	int id;
+	struct device *dev;
+	struct thermal_zone_device *thm_dev;
+};
+
+struct real_tz_list {
+	int temp;
+	struct thermal_zone_device *tz_dev;
+};
+
+struct virtual_thm_data {
+	int nr_thm;
+	struct real_tz_list *tz_list;
+	struct virtual_thm *vir_thm;
+};
+
+static int virtual_thm_get_temp(void *devdata, int *temp)
+{
+	int i, ret = 0;
+	int max_temp = 0;
+	struct thermal_zone_device *tz = NULL;
+	struct real_tz_list *tz_list = NULL;
+	struct virtual_thm_data *thm_data = devdata;
+	struct device *dev;
+
+	if (!thm_data || !temp)
+		return -EINVAL;
+
+	dev = thm_data->vir_thm->dev;
+	for (i = 0; i < thm_data->nr_thm; i++) {
+		tz_list = &thm_data->tz_list[i];
+		tz = tz_list->tz_dev;
+		if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
+			return -EINVAL;
+		ret = tz->ops->get_temp(tz, &tz_list->temp);
+		if (ret) {
+			dev_err(dev, "fail to get temp\n");
+			return ret;
+		}
+		max_temp = max(max_temp, tz_list->temp);
+	}
+	*temp = max_temp;
+
+	return ret;
+}
+
+static void virtual_thm_unregister(struct platform_device *pdev)
+{
+	struct virtual_thm_data *data = platform_get_drvdata(pdev);
+	struct virtual_thm *vir_thm = data->vir_thm;
+
+	devm_thermal_zone_of_sensor_unregister(&pdev->dev, vir_thm->thm_dev);
+}
+
+static const struct thermal_zone_of_device_ops virtual_thm_ops = {
+	.get_temp = virtual_thm_get_temp,
+};
+
+static int virtual_thm_register(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct virtual_thm_data *data = platform_get_drvdata(pdev);
+	struct virtual_thm *vir_thm = data->vir_thm;
+
+	vir_thm->thm_dev = devm_thermal_zone_of_sensor_register(dev,
+							   vir_thm->id, data,
+							   &virtual_thm_ops);
+	if (IS_ERR_OR_NULL(vir_thm->thm_dev))
+		return -ENODEV;
+	thermal_zone_device_update(vir_thm->thm_dev, THERMAL_EVENT_UNSPECIFIED);
+
+	return 0;
+}
+
+static int get_thm_zone_counts(struct device *dev)
+{
+	int count;
+	struct device_node *np = dev->of_node;
+
+	if (!np) {
+		dev_err(dev, "device node not found\n");
+		return -EINVAL;
+	}
+
+	count = of_property_count_strings(np, "thmzone-names");
+	if (count < 0) {
+		dev_err(dev, "thmzone-names not found\n");
+		return count;
+	}
+
+	return count;
+}
+
+static int get_thm_zone_device(struct platform_device *pdev)
+{
+	int i, ret = 0;
+	const char *name;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct real_tz_list *tz_list;
+	struct virtual_thm_data *data = platform_get_drvdata(pdev);
+
+	for (i = 0; i < data->nr_thm; i++) {
+		ret = of_property_read_string_index(np, "thmzone-names",
+						    i, &name);
+		if (ret) {
+			dev_err(dev, "fail to get thmzone-names\n");
+			return ret;
+		}
+		tz_list = &data->tz_list[i];
+		tz_list->tz_dev = thermal_zone_get_zone_by_name(name);
+		if (IS_ERR(tz_list->tz_dev)) {
+			dev_err(dev, "failed to get thermal zone by name\n");
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int virtual_thm_probe(struct platform_device *pdev)
+{
+	int count = 0, ret = 0, id;
+	struct virtual_thm_data *data;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!np) {
+		dev_err(dev, "device node not found\n");
+		return -EINVAL;
+	}
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	count = get_thm_zone_counts(dev);
+	if (count < 0) {
+		dev_err(dev, "failed to get thmzone count\n");
+		return -EINVAL;
+	}
+	data->nr_thm = count;
+	data->tz_list = devm_kzalloc(dev, sizeof(*data->tz_list) * data->nr_thm,
+				     GFP_KERNEL);
+	if (!data->tz_list)
+		return -ENOMEM;
+
+	data->vir_thm = devm_kzalloc(dev, sizeof(*data->vir_thm), GFP_KERNEL);
+	if (!data->vir_thm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+	ret = get_thm_zone_device(pdev);
+	if (ret) {
+		dev_err(dev, "failed to get thmzone device\n");
+		return -EINVAL;
+	}
+	id = of_alias_get_id(np, "thm-sensor");
+	if (id < 0) {
+		dev_err(dev, "failed to get id\n");
+		return -ENODEV;
+	}
+	data->vir_thm->id = id;
+	data->vir_thm->dev = dev;
+	ret = virtual_thm_register(pdev);
+	if (ret < 0) {
+		dev_err(dev, "failed to register virtual thermal\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int virtual_thm_remove(struct platform_device *pdev)
+{
+	virtual_thm_unregister(pdev);
+	return 0;
+}
+
+static const struct of_device_id virtual_thermal_of_match[] = {
+	{ .compatible = "sprd,virtual-thermal" },
+	{},
+};
+
+static struct platform_driver virtual_thermal_driver = {
+	.probe = virtual_thm_probe,
+	.remove = virtual_thm_remove,
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = "virtual_thermal",
+		   .of_match_table = virtual_thermal_of_match,
+	},
+};
+
+module_platform_driver(virtual_thermal_driver);
+
+MODULE_AUTHOR("Jeson Gao <jeson.gao@unisoc.com>");
+MODULE_DESCRIPTION("Unisoc virtual thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

