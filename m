Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206CD42F0D4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhJOM26 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 08:28:58 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35611 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238875AbhJOM2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 08:28:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 654FA580EC5;
        Fri, 15 Oct 2021 08:26:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Oct 2021 08:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=pyVtUnZYzGrcH
        1g1RkGLXUcs/0mV92qZW3HWmcKlct4=; b=dZFMq4xfKQ4Am6OK3U+fApc41+xjf
        o2hM1GyZz5nhcAPTDRYLQkP7tKLpv17INmT1I12lwZWDqiWTWBmOOQJCP4bt9uP0
        T4Ho4GQIbUcbMtjZBviTQVQ1/SKJ7t1KD1R7o7zuuPWZPUy0j08O0P6ZgibYDXtr
        7/5dFlkptH6X40UZg1GOzS3YWW3uqWePIiNbK3zJXMkUbGeVkeg+zZd8IJNHty8m
        FGjhdCSehsLM1hfazcXNV9QdEJhPDBULO7q204qHLlqex4QV5Aq5d+zemtxODoiC
        6HvFdS31lyaQfdIo0wvqcI/IG4iKRg7T5xp9HY9jjCCqYDWWHABdqq9Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pyVtUnZYzGrcH1g1RkGLXUcs/0mV92qZW3HWmcKlct4=; b=QtMx7mSW
        E0VGOVq4J33c970QF1mskQXPidpkyPCSt1+FqP4HlYJ9aZG2nSLfG1VNBMeVz9YE
        OhMjHjaVRkxBq6lTUNZE3st5TEnw5/Gvf7pzP/pncxXGQqr1ylpMGUvjlx4o3yQo
        OSHo4OdxQbnMTU5Y1dgHefFKZ4/MK5DCdniY7sfRJycajIFawCvDKKU9kgISMghp
        at+ofFzuu6JP1cM0boMn1nd03gox3trc6a9FjZS9+FarbWcsZIU123KxogA3DDyF
        gIEv+/stS177zQjYNnUT+iw6XtpSz9Rxzxu3d1SPP/250x4gVUSSHmt2tScHrbKu
        su8fr8YrPYiQaA==
X-ME-Sender: <xms:eXNpYQM6HTN04oK2vVOUc5zlRZmPTL57OUCya5BWR6TjfnRJFTnE_A>
    <xme:eXNpYW-BSmIMhXgWYaETIUjIG2d_BVJIECrrYY-nPEWuU8DzZ0Do_5i4vZHrYXIsW
    oKsXtAqCg7akSZ2ajE>
X-ME-Received: <xmr:eXNpYXQut1UnWOX7McWeioiIzxsY99ttzuj7ByFWbKI3RzvuKML7qi-T1qwySrCP0RsyeIbBeCMa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:eXNpYYtrjsJM8Y-D_-cLUeT7rJv-Nf6mfCXvbL-SibJoiH7ranag6Q>
    <xmx:eXNpYYdwqrVMhFIrVuUPxfH24w8i4HDniRRQDJQEiu0pGR-J4PF5hA>
    <xmx:eXNpYc3PBcoBRNOxeQKmqHOj8H8FZ61dWXMnkcEwM91Sd-I9Sx7Jag>
    <xmx:eXNpYc9zfgQ2qHKxwhxXFMgCSv-OWZTTdumqGLgjA4EUTzHXfWDsTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 08:26:27 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v13 5/9] thermal: sy7636a: Add thermal driver for sy7636a
Date:   Fri, 15 Oct 2021 22:25:47 +1000
Message-Id: <20211015122551.38951-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015122551.38951-1-alistair@alistair23.me>
References: <20211015122551.38951-1-alistair@alistair23.me>
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

