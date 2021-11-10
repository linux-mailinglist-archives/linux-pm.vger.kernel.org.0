Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5F44C14D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhKJMdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:33:32 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45247 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231747AbhKJMdR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 07:33:17 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 71BE7580867;
        Wed, 10 Nov 2021 07:30:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 07:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iy8l2/k4fz+dN
        nL088tkgbgbfdBttUJTxzjw7rleDEo=; b=xWQsnlnZlxznm6vfuRohPft92XRR7
        MJbn8fNihM0yk1f1QhJVxL5h0n0tZWsGNJNxDXn7dRDQxbRf4Yh/1vm7aj6DwwsC
        C767MtdWkH+mOmQZze5xf6sqEtwJZ+OhL8RxCTOoG1FGX/7MaQvZUBF/vXNyu+6R
        P0y3XSrwFlKNTOtbKZYNlV/jWc8f0cmr4MzHGlai0oNTjDguZ/KYY4dqMMRtBc67
        MoMudJ8cTRaTIfsJc21xxthboAyg/tG8JyO3semo1DcCarhdmW/zJ2F+yeKp3rYe
        FSIspqUSqMrZgMr6gU196zLDYhRnt+OKovi6aOhPaTLBGIrn4Sf8r//QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=iy8l2/k4fz+dNnL088tkgbgbfdBttUJTxzjw7rleDEo=; b=gvyEv7Ag
        ClQMe0xF7wNC8THXLcyh95Ec2JG+ivAES0rBps7AcFlVd0D/xnOo9onUwIRBaRsc
        yBsWA8D7cb1FTCycVxXUCJxbNblbUG6sSHzZsn7qDyBgx6o5PAN3zg5tThMTScEy
        oZYd+pLhW3hWHorNkk7oAxpgugNjvrgovV36xN/zwOm83V4zuGLyzwt/vosD1DFq
        /6kgX+kEfEKjoB+SePSd9ZRJ/TTyzVIgvoQhPBj4GcOHEeUuQvdHQ5VZVQAiuaRz
        VgeMB4xGSvIEq6f7Z1XnBCN1xvKtGXTSZtCnbyFHswl+pIZlZ+g9szdDfw1zBd7Z
        9X4CSuo7iCRPkQ==
X-ME-Sender: <xms:ZbuLYb7wOjVE_e4y5CW-sx3NXLAqJAqXofM37brN5kNLc9eDYEDjNg>
    <xme:ZbuLYQ5RgZmbT2NyWmm9eX6MhxYnl4vNleQbCzT30UgHyMTY_oZ9pJ02hXyL2J4-Q
    ubwOG0HpmmqoUWYA-g>
X-ME-Received: <xmr:ZbuLYSdvKl_W88Ifd6Z_dcxwO6HnYsZoMJNDB9UQkEaRH36cMTG_lW-C3IvOZW5xVaEEY20NeeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ZbuLYcLJxTPCKpUEDgeBICwxMxwci4xlsJKgK6B9rbkW3SDaLnW-ow>
    <xmx:ZbuLYfL3ljW59DxYYagX_TGoZNzW7DD3b2SGC46jg2CXc1JjSpuQ7A>
    <xmx:ZbuLYVyaCWRB0YBCWw5Oenx5VIBK9mt0s8JRVm4MtUR7_fHv4sYGSA>
    <xmx:ZbuLYY641EceqXXmOPKn-gcY8dzaO3-5cakBEB8fUQlrNRPK_m6Ubw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 07:30:23 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, andreas@kemnade.info, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v15 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
Date:   Wed, 10 Nov 2021 22:29:45 +1000
Message-Id: <20211110122948.188683-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110122948.188683-1-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a multi-function device to interface with the sy7636a
EPD PMIC chip from Silergy.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/hwmon/index.rst         |   1 +
 Documentation/hwmon/sy7636a-hwmon.rst |  24 ++++++
 drivers/hwmon/Kconfig                 |   9 +++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/sy7636a-hwmon.c         | 108 ++++++++++++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 Documentation/hwmon/sy7636a-hwmon.rst
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 7046bf1870d9..a887308850cd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -180,6 +180,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m1
    sparx5-temp
    stpddc60
+   sy7636a-hwmon
    tc654
    tc74
    thmc50
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
index 64bd3dfba2c4..3139a286c35a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1662,6 +1662,15 @@ config SENSORS_SIS5595
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
index baee6a8d4dd1..8f8da52098d1 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -182,6 +182,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
+obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
new file mode 100644
index 000000000000..84ceaae3a404
--- /dev/null
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -0,0 +1,108 @@
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
+static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *temp)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int ret, reg_val;
+
+	ret = regmap_read(regmap,
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
+	struct regulator *regulator;
+	struct device *hwmon_dev;
+	int err;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	regulator = devm_regulator_get(&pdev->dev, "vcom");
+	if (IS_ERR(regulator)) {
+		return PTR_ERR(regulator);
+	}
+
+	err = regulator_enable(regulator);
+	if (err) {
+		regulator_put(regulator);
+		return err;
+	}
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

