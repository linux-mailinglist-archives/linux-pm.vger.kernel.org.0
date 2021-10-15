Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550B542F0D8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbhJOM27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:59 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56039 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238889AbhJOM2q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 569FA580ECC;
        Fri, 15 Oct 2021 08:26:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 15 Oct 2021 08:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=WsTwXpxrUZfoY
        qLUtmFGqHSYxMxsCAPXqbvqeGLZ/qI=; b=wTmJKsr5+ZOtqCXUQWBLnLN53Gpa4
        MFP5CeGojjkoU0R3hRxvhXj27XuqzPz/3D5Z+X5g3z2FJfJILP1k9f7nyYxMI5Lg
        CtP1wyITvNm+nk+99kvWXUMedq9tEDw/5dSKrgvXyg/QCfkcQqgfYwnBNn8spNkE
        PSNSN0r2VlP73BHvjh/gjLZc85136I2vgD41dUt3yzYo97xHr/DCqtQMA0gbw1IF
        Iq9O4fE61uRCaJ3bofLQPB9722W/57cVQ9JkwHE16s/4FPtfv5AxY9eogtqovM2c
        j6OBEI4sLdtRZJDIzxBfvc1+Hd1oNMiXs20lQxThmlxgrfITxgpiSxzEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WsTwXpxrUZfoYqLUtmFGqHSYxMxsCAPXqbvqeGLZ/qI=; b=QBm0bj9p
        6xP9xD48rbU6RYb5HRnMuIRSpboHCDVL9hsTvVwB5ZAM5W57VBlAwQH4K7XcDXbt
        XMpK54bclWWiNnytgdYuzN6CNWDeUfbb36xSaMFSwQ3o5i+WCPhEYaEl4g97Gusx
        IUJyxGC08dWll2jokMtPWwpMRYpvJuc9AaeMQvu5spHQXvlQbIQRqypvltUODM02
        Tt/7uvuMCX2C01uHTazvTAjpn/5QTwgjEUELQGbfBL5bK+sfTpY0kUYg0fgez3vi
        NvTaVFl2FsKmNoK0t22+dmapVdflbSP13dYGu+kHrCJUsFMXunDsJL6v+RRUlpD6
        8tTHTBTUYgpCwQ==
X-ME-Sender: <xms:f3NpYV5OrpqyTZoUyMonIPyaVaE-H7r4HgWo46gkRv1bAogcBPE5Tw>
    <xme:f3NpYS7uPYHeYevvVaTnaI4bZiyxxQ4DC1So-AKNnKHuTe9651mddzQuVYRw8vDcW
    RNtPjtO4edCMdptHPw>
X-ME-Received: <xmr:f3NpYccVJBmqbpUkk4pD-ZjB0evWMMZNYwbWuhda0i5T9QBHnlbKzgDcgzYc1T9Dcm7Q_wNNk1o4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:f3NpYeJ7RQp1v9nh4TAUFDF_-POvNJ7pj0PpxiBHSlr0EWLlgwfNpg>
    <xmx:f3NpYZKPfjl_PlKvYDIH5xA1l-AiDRxn0BApPzOgvVaLf-WBUGI8GQ>
    <xmx:f3NpYXzpXqehBtUad6zisJ9WlKiZMPHQGYn2rRQeX2mxH4WK7O6DYQ>
    <xmx:f3NpYS6_BeaTWDaEJa21kT8kfUUx8xty6Umhs73mUrY8kZJbbCGhUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:33 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 6/9] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Fri, 15 Oct 2021 22:25:48 +1000
Message-Id: <20211015122551.38951-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/hwmon/sy7636a-hwmon.rst | 24 +++++++++
 drivers/hwmon/Kconfig                 |  9 ++++
 drivers/hwmon/Makefile                |  1 +
 drivers/hwmon/sy7636a-hwmon.c         | 75 +++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c

diff --git a/Documentation/hwmon/sy7636a-hwmon.rst b/Documentation/hwmon/sy7636a-hwmon.rst
new file mode 100644
index 000000000000..6b3e36d028dd
--- /dev/null
+++ b/Documentation/hwmon/sy7636a-hwmon.rst
@@ -0,0 +1,24 @@
+Kernel driver sy7636a-hwmon
+=========================
+
+Supported chips:
+
+ * Silergy SY7636A PMIC
+
+
+Description
+-----------
+
+This driver adds hardware temperature reading support for
+the Silergy SY7636A PMIC.
+
+The following sensors are supported
+
+  * Temperature
+      - SoC on-die temperature in milli-degree C
+
+sysfs-Interface
+---------------
+
+temp0_input
+	- SoC on-die temperature (milli-degree C)
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c4578e8f34bb..d768b833b721 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1651,6 +1651,15 @@ config SENSORS_SIS5595
 	  This driver can also be built as a module. If so, the module
 	  will be called sis5595.
 
+config SENSORS_SY7636A
+	tristate "Silergy SY7636A"
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
index 000000000000..a59628f87ff3
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,75 @@
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
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	unsigned int reg_val;
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_read(regmap, SY7636A_REG_TERMISTOR_READOUT, &reg_val);
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
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+			"sy7636a_temperature", regmap, NULL, sy7636a_groups);
+
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		dev_err(&pdev->dev, "Unable to register hwmon device, returned %d\n", err);
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

