Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89F4279BD
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbhJILx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:29 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52913 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233011AbhJILx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8A582580542;
        Sat,  9 Oct 2021 07:51:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Oct 2021 07:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pyVtUnZYzGrcH
        1g1RkGLXUcs/0mV92qZW3HWmcKlct4=; b=nJiyrrUScK4wNx2yrMAFN51b8Zyo9
        /3mdbqh85TgyPGpTjR26zPJaxiByKnh2rvm2zmN0CfLEoiPq5D8vJ8m0xXE8+nip
        OpweVWfq+Uh51Gv4dFAV1PJ+SpF24MBzidw+r0WnRSj8x80hINn0uUWGOEccOa17
        79j2LmTEOukVNmxrOgdT4nZijr+/0yjYXVbQ7/wbDXeUka5Ed/Ep/Hig2OiEswIp
        qN5AC+BjsT4gWiEhkiCuwTW/ZTQ69FbHkhL0L/PlBsueYw8jiEGP9rViklZhq9QN
        XJqZMixrMHKWVLUfavaWEsyObtrs7lBdIrQ4wK0KlRsmp93buSZIuDsjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pyVtUnZYzGrcH1g1RkGLXUcs/0mV92qZW3HWmcKlct4=; b=N419SSHs
        S2ZnPyzlNm+sPhFSpOJ1KtZ8wSTkshh9CO7NhjTGYeL7843H9ka8H0WI931Oq/LG
        8C0jStu9CVSmkaHqqruMmzoI5R0lVS+cI42XIBvNA1od4UomaXlzD8UaQPF0y6np
        3zfXddzzLM4L/11Oy2jsA62rfN/uY9LECC349m7zvbGmRNDuEbvfDKx9AZmSQMbi
        r05pTLOpbhNpAZegNhkMcN6hwjoID1H+EbFeA7ulTAroc0nD/CrKsHHRiu3yklgY
        nZtOHC7VvnsXDqdPLS+bcj5ptQ+ZHvpCglSRcdCp1sRzT5YLRhYyiI01XawmsZNK
        4mHBbib3ttebQQ==
X-ME-Sender: <xms:QoJhYQkPQbQFddJsCkuiJ6DZGu-PGvqd1vO_OFFqo6L2XQ8fRa9g3Q>
    <xme:QoJhYf2YdyVlIZ2BG3v3V2Lj0KZmi3Z9xvTeRJKfvctwRdLIfzyet8pCF9aKjW5em
    6r-Ri0exIhcgVs9t58>
X-ME-Received: <xmr:QoJhYerJ-83OouiB4xO9kPbKJyyMLLkR9A9hphxUcqc08Zymk8go6R-aVBeLLfwavTpmMIBxBHtJQBMO5iYca1xc9ZhP-DZlSc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:QoJhYcmgOEBRf8OkOWaO3NdvchYqoiAG6K1QYb4AwHV_6k5Q_8hysw>
    <xmx:QoJhYe3PIPx3aXSW1o4IYpX_4QkGL9VyAhTyjlsRFhI2qx1lymAxMQ>
    <xmx:QoJhYTsSKopzU08PyA70rjcdytHTAMByhpR8EYAu3mZNdhC3q5jcxg>
    <xmx:QoJhYZ0eE9Q6wiBVJSX4F79_dKQvSZ9PAAcejm2eXmfGZRzalYi2ig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:25 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v12 05/10] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Sat,  9 Oct 2021 21:50:27 +1000
Message-Id: <20211009115031.18392-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal driver to enable kernel based polling
and shutdown of device for temperatures out of spec

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/thermal/Kconfig           |  6 ++
 drivers/thermal/Makefile          |  1 +
 drivers/thermal/sy7636a_thermal.c | 94 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/thermal/sy7636a_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..6ee0e7de1b37 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -450,6 +450,12 @@ depends on (ARCH_STI || ARCH_STM32) && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
+config SY7636A_THERMAL
+	tristate "SY7636A thermal management"
+	help
+	  Enable the sy7636a thermal driver, which supports the
+	  temperature sensor embedded in Silabs SY7636A IC.
+
 source "drivers/thermal/tegra/Kconfig"
 
 config GENERIC_ADC_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e616e54..2e1aca8a0a09 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
 obj-y				+= intel/
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-y				+= st/
+obj-$(CONFIG_SY7636A_THERMAL)	+= sy7636a_thermal.o
 obj-$(CONFIG_QCOM_TSENS)	+= qcom/
 obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
diff --git a/drivers/thermal/sy7636a_thermal.c b/drivers/thermal/sy7636a_thermal.c
new file mode 100644
index 000000000000..9e58305ca3ce
--- /dev/null
+++ b/drivers/thermal/sy7636a_thermal.c
@@ -0,0 +1,94 @@
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
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include <linux/mfd/sy7636a.h>
+
+static int sy7636a_get_temp(void *arg, int *res)
+{
+	unsigned int mode_ctr;
+	int ret, reg_val;
+	struct regmap *regmap = arg;
+	bool isVoltageActive;
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_OPERATION_MODE_CRL, &mode_ctr);
+	if (ret)
+		return ret;
+
+	isVoltageActive = mode_ctr & SY7636A_OPERATION_MODE_CRL_ONOFF;
+
+	/* If operation mode isn't set to control, then let's set it. */
+	if (!isVoltageActive) {
+		ret = regmap_write(regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr | SY7636A_OPERATION_MODE_CRL_ONOFF);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(regmap,
+			SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	if (ret)
+		return ret;
+
+	/* Restore the operation mode if it wasn't set */
+	if (!isVoltageActive) {
+		ret = regmap_write(regmap,
+				SY7636A_REG_OPERATION_MODE_CRL,
+				mode_ctr);
+		if (ret)
+			return ret;
+	}
+
+	*res = reg_val * 1000;
+
+	return ret;
+}
+
+static const struct thermal_zone_of_device_ops ops = {
+	.get_temp	= sy7636a_get_temp,
+};
+
+static int sy7636a_thermal_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct thermal_zone_device *thermal_zone_dev;
+
+	thermal_zone_dev = devm_thermal_zone_of_sensor_register(
+			pdev->dev.parent,
+			0,
+			regmap,
+			&ops);
+
+	return PTR_ERR_OR_ZERO(thermal_zone_dev);
+}
+
+static const struct platform_device_id sy7636a_thermal_id_table[] = {
+	{ "sy7636a-thermal", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sy7636a_thermal_id_table);
+
+static struct platform_driver sy7636a_thermal_driver = {
+	.driver = {
+		.name = "sy7636a-thermal",
+	},
+	.probe = sy7636a_thermal_probe,
+	.id_table = sy7636a_thermal_id_table,
+};
+module_platform_driver(sy7636a_thermal_driver);
+
+MODULE_AUTHOR("Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>");
+MODULE_DESCRIPTION("SY7636A thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

