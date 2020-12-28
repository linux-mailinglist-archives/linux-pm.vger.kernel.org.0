Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE812E65FC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 17:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391007AbgL1QHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 11:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393373AbgL1QG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 11:06:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCF0C06179C;
        Mon, 28 Dec 2020 08:06:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m25so24832072lfc.11;
        Mon, 28 Dec 2020 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzXM5kh78uP6JLUZoqHPn7MjFL/ZE3XLB3soRLgh4bc=;
        b=GLZwzVelfhq+xp0TqV0TXTHUo5jdFglOGjlwnCzlbl7PuhJzhZbdSafcEV7zvdElgQ
         AKdfNcMtxnyYFxi56X2DvnupLg6VxukmZ3ho3Wu8PsbHeJXCejCd43luOl4Nw7hZFr3/
         U2BJ2VF4A3KRfD54OZlM/6V98YEBF42jWYLdRUQ6AMqIY917cphWa438zfghOjL9q0oo
         tFql8Fj5oposECv+zPsZxa0ZwMS/hGhKkIkopGs5jZ0EGQAIb6P0YNH0Zi9jjvKUF6/d
         jbIYWaFNaZQdg4r1O8IgPdfo0A5bvmJpMyDMw9/9k3WkvmtmRRzplMpEkSrebbWc+g0m
         W6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzXM5kh78uP6JLUZoqHPn7MjFL/ZE3XLB3soRLgh4bc=;
        b=ZxB5yKpgaJEuqH3NzfY6PXrhK6yje0UyTZY6uUjfiTo2HbfJHCYDv7jnjaHAPUhZXM
         75BdGTmZLqBckqzTok2BNq8zETEUzD/1vINXukKJMdyV7zzHH2oDhySetX86SthuAROR
         ANlzP6qDCtvTR5qNa43DpdeIA8CaIXMtu+EDNx4VfpYGXewDNx4LnW4qp5vjZOnXGxGg
         igFH6s5iQPQ7MnpgfvOU8hSL5l9C1PGojHxMFN9XpZOo9ne6EkvmW9Dz/h+3ATcSBXIR
         KQC4oRbW/RvKe/dhT/9KGnxormMGlQrKxd619gm8venC9zHj+zeYlZv178jQPlRwDT/3
         iCqg==
X-Gm-Message-State: AOAM530m+1cJrU4CEJdYbe7hiO3FviE2BOSkdLJvKnvHnZHE6abogtMe
        3T9SXgVG86fCX/5OOvDXJ6Y=
X-Google-Smtp-Source: ABdhPJxufQZeXEMU9Zgtw7D/nNJx/2lpv9IRh1qF5mFkc4vVvICfegprJMaN8z19aQknnZieyoMUuQ==
X-Received: by 2002:a2e:5452:: with SMTP id y18mr21724022ljd.224.1609171565541;
        Mon, 28 Dec 2020 08:06:05 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id v28sm5338837lfd.57.2020.12.28.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:06:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
Date:   Mon, 28 Dec 2020 19:05:46 +0300
Message-Id: <20201228160547.30562-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228160547.30562-1-digetx@gmail.com>
References: <20201228160547.30562-1-digetx@gmail.com>
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
index bdfce7b15621..750709219e00 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2085,6 +2085,17 @@ config MFD_KHADAS_MCU
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

