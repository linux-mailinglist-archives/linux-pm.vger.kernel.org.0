Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412C24279C2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbhJILxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:33 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58909 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244797AbhJILxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D0FB4580542;
        Sat,  9 Oct 2021 07:51:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 09 Oct 2021 07:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZfeDL5nl1NIgK
        gueOXQ9S8l3j9f7cNPcD1eW3HuqJ6c=; b=nTXuGOHjcfMv7uAOFLSmxDkxDpm8D
        Kx3TNYqjiqc4Ny9d3iM41Se7kAihs0ZuJyLzGofN+KySwf3h6V+ZSO/p+OA1tZsG
        1AGU3USqL6SFEc+ICPLYVxJ5vsRMXF6bwJo8L2ckyqoRuSx5HbzWJ2Vbwhatc2/6
        N3HRU15p/Y3fbgle+sllPmAbMLBRC4xODsfmnC2aBnVIkYQuQOZg16XVTWFPrnsM
        MQCbJMeGk+N7G4S1jD4zqy8JaSLHrETXpao6Nxshi9cDZmCYj9WTu4JpxJ5HDMTd
        SY7/aTFjeGg1WxazrSJQ5mDHP8XDIyZFU49LpcWG5d98tu3nTjcvs4lPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZfeDL5nl1NIgKgueOXQ9S8l3j9f7cNPcD1eW3HuqJ6c=; b=jngZVZ83
        3ukS+OUgvzzRP3rbqs17nVXjYnRsI9eZxNWHf+kH7ZqAnsifoEuVlzyZ+pxKn9rT
        xUBCG63Exp12DaTSxb4sLVanRDYvtiiOJhHqzgBHm4Yr99ScWRMO7v0lPAEGNHdX
        EAHE+aLVkp1Nt9954jNtzw3Y5j5kwWbZHvOmsoVsBUBWc9CY8rqSnKXUYf/4i17N
        x21u5FvHmXh2LMHAeViSzdnlj+N9KcibHVemWKT2WnvU4W2lsIA+37jsfxs0hfvC
        /8+BJLoZzuC1xuI7ISemQhwOomDHWN+XNmcfzn8XtLEdUbgKnlj2KL/S0+jsy3JM
        qIPlZ2qSKTzO9Q==
X-ME-Sender: <xms:R4JhYQwmoumpQAQkCA99lOGONv5QXbvj-R74TfXE__kmixAcPPT0WQ>
    <xme:R4JhYUQXP-uyUKGUzh3gxZ_eCAnugI4YStvjuz-MuT4MOCz6-ptk19t3Q_H4nnQIM
    6MnqBiTkLt7mugvwPA>
X-ME-Received: <xmr:R4JhYSVY1DovoA7QOExgmDHLlTv9FDZCGN7VsXjdYiheai3WVcFf2z7RQVYM-epS5rEBrAZNEXqUzuqXTCBeZKmtYkNGj7jSDOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:R4JhYegxmnDA77oNXtbExgkIjljXG4HnPrvyqHNWW_GbHdFlR822zw>
    <xmx:R4JhYSB0oeiq8zAo4GCcqnHMszNldiWUhYJFjYTOVePFbJ7dT1OoAQ>
    <xmx:R4JhYfLNeWnSzqraiD7NX00tveaT9Hk9HvGaPrnFugfkf9HruEmLdQ>
    <xmx:R4JhYYTW_2_Wj2kaLsRr7VLbzsudKwjvZAElbit4mVDNl7xyl_SN2Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:30 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 06/10] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Sat,  9 Oct 2021 21:50:28 +1000
Message-Id: <20211009115031.18392-10-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig |  1 +
 drivers/hwmon/Kconfig                | 10 ++++
 drivers/hwmon/Makefile               |  1 +
 drivers/hwmon/sy7636a-hwmon.c        | 77 ++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8a54a4d0181a..b87adf823e44 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -228,6 +228,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c4578e8f34bb..59f358293202 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1651,6 +1651,16 @@ config SENSORS_SIS5595
 	  This driver can also be built as a module. If so, the module
 	  will be called sis5595.
 
+config SENSORS_SY7636A
+	tristate "Silergy SY7636A"
+	depends on I2C
+	help
+	  If you say yes here you get support for the thermistor readout of
+	  the Silergy SY7636A PMIC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sy7636a-hwmon.
+
 config SENSORS_DME1737
 	tristate "SMSC DME1737, SCH311x and compatibles"
 	depends on I2C && !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 162940270661..1355ffdb1481 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -181,6 +181,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
+obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
new file mode 100644
index 000000000000..e0204278339b
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functions to access SY3686A power management chip temperature
+ *
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+ *
+ * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *          Alistair Francis <alistair@alistair23.me>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static ssize_t show_temp(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned int reg_val;
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", reg_val);
+}
+
+static SENSOR_DEVICE_ATTR(temp0, 0444, show_temp, NULL, 0);
+
+static struct attribute *sy7636a_attrs[] = {
+	&sensor_dev_attr_temp0.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(sy7636a);
+
+static int sy7636a_sensor_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct device *hwmon_dev;
+	int err;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+			"sy7636a_temperature", regmap, sy7636a_groups);
+
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver sy7636a_sensor_driver = {
+	.probe = sy7636a_sensor_probe,
+	.driver = {
+		.name = "sy7636a-temperature",
+	},
+};
+module_platform_driver(sy7636a_sensor_driver);
+
+MODULE_DESCRIPTION("SY7636A sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

