Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70C2B5182
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgKPTsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbgKPTsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 14:48:37 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBFC0613D1;
        Mon, 16 Nov 2020 11:48:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so26821759lfo.5;
        Mon, 16 Nov 2020 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8KpbZOgGt3xzne9of7zJGRD6cfCFXXRYEAwgly7URQ=;
        b=mzponcs9I00VzANTg4mmG5ibB/n3y5cHOqxITj6nHmmvd16knU6mrPesarcuPWuhv/
         UamE2QSHr1AYwaXj/Nbf600AZDCokgsFoVZwD0LYXZ0VUE9cwmw2RND5PPF+frQv3VPb
         ya+505LFdWZULTHAkGRqn4uoWHL0I0hJrR5KdgranW/KcxtQVEplSwYi0/46l3WArJmi
         9zKLNao9LRJk5QsTBf/k4HpZAyf62CsQu/cjYvzbdL7Q0jWiODIxenyyST1OkjIrR3tP
         IzRNGJSRfw30ckrZuMOeKIShBP5ALe2CUIrjOWeE/apQmQG0ZKQvaNkAorFagf7nX1pP
         0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8KpbZOgGt3xzne9of7zJGRD6cfCFXXRYEAwgly7URQ=;
        b=MPE3U+Z6v4cbOwy/fXAx0Ezgv5lkOIbXTbkIYJFrz7KH6PiTpj/ipc94k37txyvQS/
         xztLRM7GdeDg6HDKpJLv2cR8Hl/0qgVGvL/6bt34QSJJTYNPpb1OvsJJc/ZvEUuZHN9B
         m+GMyn8xKHwkTBrz+w8dMDlDlsjoNfNwlsTwkzm2H9HUffyymJaxRzvlkpJcsFA1ghKp
         ZDR9RgVEpKyZHQOOPeF6iM38Db5ODzc1SVupgMHxstxDv6wY4bg8KQ469kWisWqG0DD/
         8BiqeQ8CmwiHVz+npL0mma73Xm8TLCO6ajjxscuFFLUwCmizR8EaBjqdZYoZdWiNO4v3
         38aQ==
X-Gm-Message-State: AOAM530gTILgDtP+TMLfOOSGJS2O0BnFdgl4rt0kfOlEEVZSlajUm2sR
        G5bJcoPYYbOA79ISdwPpiGA=
X-Google-Smtp-Source: ABdhPJz/jZz20OtZ/mh8c4E67mCoKvlHiOmRVvmFI97pW0XnSxa5JH2WFY+JnVKI2toRk0tUOpHHmQ==
X-Received: by 2002:a19:2407:: with SMTP id k7mr361133lfk.533.1605556115419;
        Mon, 16 Nov 2020 11:48:35 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id n5sm2864286lfb.306.2020.11.16.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:48:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
Date:   Mon, 16 Nov 2020 22:48:25 +0300
Message-Id: <20201116194827.28947-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116194827.28947-1-digetx@gmail.com>
References: <20201116194827.28947-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Acer Iconia Tab A500 is an Android tablet device, it has ENE KB930
Embedded Controller which provides battery-gauge, LED, GPIO and some
other functions. The EC uses firmware that is specifically customized
for Acer A500. This patch adds MFD driver for the Embedded Controller
which allows to power-off / reboot the A500 device, it also provides
a common register read/write API that will be used by the sub-devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/Kconfig        |  11 ++
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/acer-ec-a500.c | 202 +++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/mfd/acer-ec-a500.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index cc0b73280c68..9c6c451dd416 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2107,6 +2107,17 @@ config MFD_KHADAS_MCU
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_ACER_A500_EC
+	tristate "Support for Acer Iconia Tab A500 Embedded Controller"
+	depends on I2C
+	depends on (ARCH_TEGRA_2x_SOC && OF) || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP
+	help
+	  Support for Embedded Controller found on Acer Iconia Tab A500.
+	  The controller itself is ENE KB930, it is running firmware
+	  customized for the specific needs of the Acer A500 hardware.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 14fdb188af02..025543418835 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,6 +264,7 @@ obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
+obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
new file mode 100644
index 000000000000..80c2fdd14fc4
--- /dev/null
+++ b/drivers/mfd/acer-ec-a500.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Acer Iconia Tab A500 Embedded Controller Driver
+ *
+ * Copyright 2020 GRATE-driver project
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+#define A500_EC_I2C_ERR_TIMEOUT		500
+#define A500_EC_POWER_CMD_TIMEOUT	1000
+
+/*
+ * Controller's firmware expects specific command opcodes to be used for the
+ * corresponding registers. Unsupported commands are skipped by the firmware.
+ */
+#define CMD_SHUTDOWN			0x0
+#define CMD_WARM_REBOOT			0x0
+#define CMD_COLD_REBOOT			0x1
+
+enum {
+	REG_CURRENT_NOW = 0x03,
+	REG_SHUTDOWN = 0x52,
+	REG_WARM_REBOOT = 0x54,
+	REG_COLD_REBOOT = 0x55,
+};
+
+static struct i2c_client *a500_ec_client_pm_off;
+
+static int a500_ec_read(void *context, const void *reg_buf, size_t reg_size,
+			void *val_buf, size_t val_sizel)
+{
+	struct i2c_client *client = context;
+	unsigned int reg, retries = 5;
+	u16 *ret_val = val_buf;
+	s32 ret = 0;
+
+	reg = *(u8 *)reg_buf;
+
+	while (retries-- > 0) {
+		ret = i2c_smbus_read_word_data(client, reg);
+		if (ret >= 0)
+			break;
+
+		msleep(A500_EC_I2C_ERR_TIMEOUT);
+	}
+
+	if (ret < 0) {
+		dev_err(&client->dev, "read 0x%x failed: %d\n", reg, ret);
+		return ret;
+	}
+
+	*ret_val = ret;
+
+	if (reg == REG_CURRENT_NOW)
+		fsleep(10000);
+
+	return 0;
+}
+
+static int a500_ec_write(void *context, const void *data, size_t count)
+{
+	struct i2c_client *client = context;
+	unsigned int reg, val, retries = 5;
+	s32 ret = 0;
+
+	reg = *(u8  *)(data + 0);
+	val = *(u16 *)(data + 1);
+
+	while (retries-- > 0) {
+		ret = i2c_smbus_write_word_data(client, reg, val);
+		if (ret >= 0)
+			break;
+
+		msleep(A500_EC_I2C_ERR_TIMEOUT);
+	}
+
+	if (ret < 0) {
+		dev_err(&client->dev, "write 0x%x failed: %d\n", reg, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config a500_ec_regmap_config = {
+	.name = "KB930",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+};
+
+static const struct regmap_bus a500_ec_regmap_bus = {
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.write = a500_ec_write,
+	.read = a500_ec_read,
+	.max_raw_read = 2,
+};
+
+static void a500_ec_poweroff(void)
+{
+	i2c_smbus_write_word_data(a500_ec_client_pm_off,
+				  REG_SHUTDOWN, CMD_SHUTDOWN);
+
+	mdelay(A500_EC_POWER_CMD_TIMEOUT);
+}
+
+static int a500_ec_restart_notify(struct notifier_block *this,
+				  unsigned long reboot_mode, void *data)
+{
+	if (reboot_mode == REBOOT_WARM)
+		i2c_smbus_write_word_data(a500_ec_client_pm_off,
+					  REG_WARM_REBOOT, CMD_WARM_REBOOT);
+	else
+		i2c_smbus_write_word_data(a500_ec_client_pm_off,
+					  REG_COLD_REBOOT, CMD_COLD_REBOOT);
+
+	mdelay(A500_EC_POWER_CMD_TIMEOUT);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block a500_ec_restart_handler = {
+	.notifier_call = a500_ec_restart_notify,
+	.priority = 200,
+};
+
+static const struct mfd_cell a500_ec_cells[] = {
+	{ .name = "acer-a500-iconia-battery", },
+	{ .name = "acer-a500-iconia-leds", },
+};
+
+static int a500_ec_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+	int err;
+
+	regmap = devm_regmap_init(&client->dev, &a500_ec_regmap_bus,
+				  client, &a500_ec_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	err = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
+				   a500_ec_cells, ARRAY_SIZE(a500_ec_cells),
+				   NULL, 0, NULL);
+	if (err) {
+		dev_err(&client->dev, "failed to add sub-devices: %d\n", err);
+		return err;
+	}
+
+	if (of_device_is_system_power_controller(client->dev.of_node)) {
+		a500_ec_client_pm_off = client;
+
+		err = register_restart_handler(&a500_ec_restart_handler);
+		if (err)
+			return err;
+
+		if (!pm_power_off)
+			pm_power_off = a500_ec_poweroff;
+	}
+
+	return 0;
+}
+
+static int a500_ec_remove(struct i2c_client *client)
+{
+	if (of_device_is_system_power_controller(client->dev.of_node)) {
+		if (pm_power_off == a500_ec_poweroff)
+			pm_power_off = NULL;
+
+		unregister_restart_handler(&a500_ec_restart_handler);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id a500_ec_match[] = {
+	{ .compatible = "acer,a500-iconia-ec" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, a500_ec_match);
+
+static struct i2c_driver a500_ec_driver = {
+	.driver = {
+		.name = "acer-a500-embedded-controller",
+		.of_match_table = a500_ec_match,
+	},
+	.probe_new = a500_ec_probe,
+	.remove = a500_ec_remove,
+};
+module_i2c_driver(a500_ec_driver);
+
+MODULE_DESCRIPTION("Acer Iconia Tab A500 Embedded Controller driver");
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.29.2

