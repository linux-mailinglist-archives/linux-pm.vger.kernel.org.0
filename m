Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4604439432
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhJYK4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 06:56:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58901 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231338AbhJYK4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 06:56:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 040A258045A;
        Mon, 25 Oct 2021 06:54:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 25 Oct 2021 06:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=26mmE8gPTzxJk
        4F657DbPbd4Vbe1ZwN4n5cX/C8l/bM=; b=mfaRE/Clbv5eQCOrq1oDd09LeSjMq
        eTNWy+r3epmcLze4BhIKE9mHyfC90KqY4rGOwftPuYf2iiqt+1IYCjTFuOYHGe70
        WSCeQj7NLdhtt/5C2V1L0GFpOIVQ8yoU3TGHmnCe73hutjf5LYwXmWkAioiqPTl2
        Dx3j2HDNyt9sDb2ch1gzuiuT1V/NwQXuSJ+2FHSqDDh9zj0/Z61M1dAXs0eNlNS6
        OWSHAso5oONmwWSSwKQwJRzt2WjmPcLkIgV4rCdwkLmYHa7OKTNF9UpD/qh9Wp44
        50DeETqkiFUBIPRhj97yX2H9D9ID3QMkTsTQ+XfqlWi86wsaiP7SitvGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=26mmE8gPTzxJk4F657DbPbd4Vbe1ZwN4n5cX/C8l/bM=; b=geYmhNEe
        UcMQgn+6jaRjqcf0b5jGxgVwCZhEtZnAURAmiw2iRh+v/Zgrz1kFcQgvnrTJTIZn
        6ifP4untr/JVbdLiXInw6DtL3WsjhSJrKJhMIqA86QtgLmPaZYs9zo5tifpsA4gs
        AxCfjfH85IJTPYHup9Bcw+wyMs+U7W98w8/iQM9r88z8Wu823rvet84WKUDgKylJ
        1V2CT465zMMqQecEdnWTwJv8qIDAYE0KZUCMjEjxWfTNVUA/8DZmr+yIB9eRLL7C
        wYaal4KhzPOxKmInEAbyvLprFrFnV0u0YxSBtuk/2QWbKTIpb7hl+H+rp5Fkw8C1
        xopBd1K8iAFj9A==
X-ME-Sender: <xms:1Ix2YQfXqgcMRs4asqz8dQu1_n4jWfaRbIQlmppbEn1pIIJkv9TZPA>
    <xme:1Ix2YSP0V1VJCr8uX9Ku1UAeKUU9dvsyi4RpYLBPUSH8lhAk3ZC4Y0sXRV0drCBQR
    HGzlGMnsDixzN8PLT8>
X-ME-Received: <xmr:1Ix2YRi9br1DbDY9SJmpi8ep_Ntj9MVkEMrJ94kxQO4ussACiu-5pGTlvEfgnRENHOk3dEnO-Bsj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:1Ix2YV9_DY1BdHReW9LKoHxdcS_DJc_BatikcIbya_6K0HFkatruWg>
    <xmx:1Ix2YctZBjlLt2uDLS87O2Pv02iOM6_9Y6nDo4DcpdCPSyeuKTDMcw>
    <xmx:1Ix2YcE5a05mnhlnqr1vWXNooWsOKBNI6RvjfH8yW8s2kI5n7o_1Sw>
    <xmx:1Yx2Yd9Z-YuE_DpE3t5s99Iz7GSTNsWvaZoBJSTt-YGO1WJWwdqOaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 06:54:03 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     s.hauer@pengutronix.de, rui.zhang@intel.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        amitk@kernel.org, shawnguo@kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        andreas@kemnade.info, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v14 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Mon, 25 Oct 2021 20:53:06 +1000
Message-Id: <20211025105309.37942-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025105309.37942-1-alistair@alistair23.me>
References: <20211025105309.37942-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/hwmon/sy7636a-hwmon.rst |  24 ++++++
 drivers/hwmon/Kconfig                 |   9 ++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/sy7636a-hwmon.c         | 114 ++++++++++++++++++++++++++
 4 files changed, 148 insertions(+)
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
index 000000000000..1727a5f2a2ea
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Functions to access SY3686A power management chip temperature
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ *
+ * Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
+ *          Alistair Francis <alistair@alistair23.me>
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/machine.h>
+
+#include <linux/mfd/sy7636a.h>
+
+struct sy7636a_data {
+	struct regmap *regmap;
+	struct regulator *regulator;
+};
+
+static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *temp)
+{
+	struct sy7636a_data *data = dev_get_drvdata(dev);
+	int ret, reg_val;
+
+	ret = regulator_enable(data->regulator);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	*temp = reg_val * 1000;
+
+	return 0;
+}
+
+static umode_t sy7636a_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	if (attr != hwmon_temp_input)
+		return 0;
+
+	return 0444;
+}
+
+static const struct hwmon_ops sy7636a_hwmon_ops = {
+	.is_visible = sy7636a_is_visible,
+	.read = sy7636a_read,
+};
+
+static const struct hwmon_channel_info *sy7636a_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info sy7636a_chip_info = {
+	.ops = &sy7636a_hwmon_ops,
+	.info = sy7636a_info,
+};
+
+static int sy7636a_sensor_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct sy7636a_data *data;
+	struct device *hwmon_dev;
+	int err;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
+	if (!data) {
+		return -ENOMEM;
+	}
+
+	data->regmap = regmap;
+	data->regulator = devm_regulator_get(&pdev->dev, "vcom");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+			"sy7636a_temperature", regmap, &sy7636a_chip_info, NULL);
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

