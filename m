Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6A256FCE
	for <lists+linux-pm@lfdr.de>; Sun, 30 Aug 2020 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgH3SzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Aug 2020 14:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgH3SzI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Aug 2020 14:55:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33601C061575;
        Sun, 30 Aug 2020 11:55:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so156291ljj.12;
        Sun, 30 Aug 2020 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7rw93hhaf9uOHs3cGyY1kzgSun5Ciow1DW5ZdMuif0=;
        b=PPJEEYyRhUNt3ZqTR4234D0FB37mqxaZbKxnwDv4ZQAZfC6uwZpU22Mbtk0fau9JVt
         CSI5Uv97tE0MsP9TgcQH01ojbgIx7TmgEX0UohbxT/4BQ0Njl+eDaD537qSY7n03V+kU
         TYEKBPp83EJt/bhyrWT/HnoUGnz00WkXw4lTOxZw7tojF4w4qAwMWiG0TZ/GGAZZHfe9
         QJCbGppfYS+VB47FMBcqYvd7CD+KGj05Inc7wpTUUDcXdqVlFUyyzT98bVP2TTNneIlc
         aXglX60rk3JRB5ZyrTBSavHfrMfvJXo5XIXnjAZXMMN/VBRR7wq2qjvPCLp6ytOF/brN
         MqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7rw93hhaf9uOHs3cGyY1kzgSun5Ciow1DW5ZdMuif0=;
        b=syCiVDFAm1l1tEQhLCovuHn8AbX9ocedjZhf1VFwqeMEUFkiHbXxuZWRbFvCIFBrko
         mCUS26LtUQYca0UU2DRz5jslUt2pIPTi64thzntsiZrn8RF6y5CxxIzm+Y5+JFOAsQic
         GgPJOdFGZXkMOF859ZYB8cgxhNctYmjapGJtSfXmIY71R7sbBeSMRcfEKhu6W1DCCaH/
         L2RsB23S7B2vF3bsQUEP+JrBHPbsV0D942OTPI2w2I63KBCOzvbK4SqvwRdLzL8lfmvB
         aAmiaewGYLZMfjF3Aj3pUhrVsJ+XkgFwGoknUohcrrr60Qp1jNU5A5gq+4pj/NnTIqa/
         v1FA==
X-Gm-Message-State: AOAM533SFelBrIyEFpqNBd3ZIV+8y0gmybZNlpc3W/Ds/X/+ZT+6X+1B
        SicQ9CtHujaGn/TwNIJ18kY=
X-Google-Smtp-Source: ABdhPJyKSJlL7/Ku2+I/3RK7/bmANJhmytCHcV2rJbOAlR7UcMUA7bJJCI4q+f5qkbVJgTG6Kg/SoA==
X-Received: by 2002:a2e:985a:: with SMTP id e26mr2431462ljj.320.1598813705546;
        Sun, 30 Aug 2020 11:55:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id n21sm21630ljc.89.2020.08.30.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:55:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] mfd: Add driver for Embedded Controller found on Acer Iconia Tab A500
Date:   Sun, 30 Aug 2020 21:53:53 +0300
Message-Id: <20200830185356.5365-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200830185356.5365-1-digetx@gmail.com>
References: <20200830185356.5365-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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
 drivers/mfd/Kconfig        |  12 +++
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/acer-ec-a500.c | 203 +++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/mfd/acer-ec-a500.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ecd791ad5e8f..7a0f4952c76e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2062,6 +2062,18 @@ config MFD_KHADAS_MCU
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_ACER_A500_EC
+	tristate "Embedded Controller driver for Acer Iconia Tab A500"
+	depends on I2C
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP
+	help
+	  Support for Acer Iconia Tab A500 Embedded Controller.
+
+	  The controller itself is ENE KB930, it is running firmware
+	  customized for the specific needs of the Acer A500 hardware.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index dd2cc7be7eaa..f6652fb33b7a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -262,6 +262,7 @@ obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
+obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 
diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
new file mode 100644
index 000000000000..2785a6d9bcc4
--- /dev/null
+++ b/drivers/mfd/acer-ec-a500.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MFD driver for Acer Iconia Tab A500 Embedded Controller.
+ *
+ * Copyright 2020 GRATE-driver project.
+ *
+ * Based on downstream driver from Acer Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/reboot.h>
+
+#define A500_EC_I2C_ERR_TIMEOUT		500
+#define A500_EC_POWER_CMD_TIMEOUT	1000
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
+	if (reg_size != 1 || val_sizel != 2)
+		return -EOPNOTSUPP;
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
+	if (count != 3)
+		return -EOPNOTSUPP;
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
+	i2c_smbus_write_word_data(a500_ec_client_pm_off, REG_SHUTDOWN, 0);
+
+	mdelay(A500_EC_POWER_CMD_TIMEOUT);
+}
+
+static int a500_ec_restart_notify(struct notifier_block *this,
+				  unsigned long reboot_mode, void *data)
+{
+	if (reboot_mode == REBOOT_WARM)
+		i2c_smbus_write_word_data(a500_ec_client_pm_off,
+					  REG_WARM_REBOOT, 0);
+	else
+		i2c_smbus_write_word_data(a500_ec_client_pm_off,
+					  REG_COLD_REBOOT, 1);
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
+	struct regmap *rmap;
+	int err;
+
+	rmap = devm_regmap_init(&client->dev, &a500_ec_regmap_bus,
+				client, &a500_ec_regmap_config);
+	if (IS_ERR(rmap))
+		return PTR_ERR(rmap);
+
+	/* register battery and LED sub-devices */
+	err = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
+				   a500_ec_cells, ARRAY_SIZE(a500_ec_cells),
+				   NULL, 0, NULL);
+	if (err) {
+		dev_err(&client->dev, "failed to add sub-devices: %d\n", err);
+		return err;
+	}
+
+	/* set up power management functions */
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
2.27.0

