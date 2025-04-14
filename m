Return-Path: <linux-pm+bounces-25388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC8A88988
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A9C1895E8C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45528A1DD;
	Mon, 14 Apr 2025 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JOvvIrKn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BA289360;
	Mon, 14 Apr 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650909; cv=none; b=dE6R3Pr4pVNaSWblfKJOnwKbWKmzVRNByeJLwzHH/hQz4X+RBhw06kSpi3ETl4emo1G8we4sj8S8yR1KHlB0LCYruyERwB3+beVfjqXtGhFq+y4jnH7tpRp20gSSyRuDR1D7yh4g8svMUf41xYFZg0dm0DvOz3QvHgnDQOULt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650909; c=relaxed/simple;
	bh=dlGf92UFV+ckbKnZntoWZ+oVvS5yIxAL0pi0RWf0AKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbnj6jvSd4IT1SohiCRcOSdUK3pJIwn+zXD1BE+pJgkggsJTsp9e+jHZgeHbXvcteQxPShIamL/6SXvvhERLueckFN7TQFF8sKqoeE9tGJcYwgfNZOsH3uVMDOVvEdvODFKB6In5LvqIBoFikAjFtaSEzbYbSYPQUfsdWWZCk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JOvvIrKn; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id E9B931FC15;
	Mon, 14 Apr 2025 19:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744650904;
	bh=T3bc8Op2Zld0Q0DNhuVhhUQ2pn3oSrVd6mywcjBGb5Y=; h=From:To:Subject;
	b=JOvvIrKnPfFHjN+Y+8h6mkeF4XMJU/ZJtqpayVsgMPiAtTCsHVhc1fYbjjFHcf5af
	 nfM7Y0Lmgf/PpmJ0n4Y3zjjexl3Rpxt7fG909MvWftfjVGSRUIKHtvEoE5DTf+Buuk
	 XYZXgTPjR8iU8fvzD8LnRNzTztd/kVUoaoH1SgNewCOAwRT+bfMQmPQbZsj5oOT6F+
	 JCyuGn9IjHjoyOsuLNedWYKPKFwq9/MfSqz0uijzj3GzUOdlZdHgai1xgOWYRdtGjE
	 VM6EzdkR3J373xWCtClzOzP8A7UVHdl35DWzlvfQ9gDE20BxOxS53z8DN9bIS4dfFR
	 L8UqISN7tnwnw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] power: reset: add Toradex Embedded Controller
Date: Mon, 14 Apr 2025 19:14:55 +0200
Message-Id: <20250414171455.155155-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414171455.155155-1-francesco@dolcini.it>
References: <20250414171455.155155-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Toradex SMARC iMX8MP and SMARC iMX95 SoM modules use a small Embedded
Controller (EC) to manage power and reset functions and related SMARC
signals.

This driver implements power-off and reboot handlers, communicating with
the EC via I2C to issue the appropriate power management commands.

During probe, the driver logs the Embedded Controller ID (unique ID for
each SMARC board supported) in hex format along with the firmware version.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
v1: https://lore.kernel.org/lkml/20250407114947.41421-1-francesco@dolcini.it/
---
 MAINTAINERS                           |   1 +
 drivers/power/reset/Kconfig           |  13 +++
 drivers/power/reset/Makefile          |   1 +
 drivers/power/reset/tdx-ec-poweroff.c | 150 ++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 drivers/power/reset/tdx-ec-poweroff.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddb279436f8..ad811c003c51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24413,6 +24413,7 @@ M:	Emanuele Ghidoli <ghidoliemanuele@gmail.com>
 M:	Francesco Dolcini <francesco@dolcini.it>
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
+F:	drivers/power/reset/tdx-ec-poweroff.c
 
 TORTURE-TEST MODULES
 M:	Davidlohr Bueso <dave@stgolabs.net>
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 60bf0ca64cf3..e71f0af4e378 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -216,6 +216,19 @@ config POWER_RESET_ST
 	help
 	  Reset support for STMicroelectronics boards.
 
+config POWER_RESET_TORADEX_EC
+	tristate "Toradex Embedded Controller power-off and reset driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver supports power-off and reset for SMARC Toradex SoMs,
+	  for example the SMARC iMX8MP and SMARC iMX95, using Toradex
+	  Embedded Controller (EC).
+
+	  Say Y here if you have a Toradex SMARC SoM.
+
+	  If unsure, say N.
+
 config POWER_RESET_TPS65086
 	bool "TPS65086 restart driver"
 	depends on MFD_TPS65086
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 10782d32e1da..1b9b63a1a873 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
+obj-$(CONFIG_POWER_RESET_TORADEX_EC) += tdx-ec-poweroff.o
 obj-$(CONFIG_POWER_RESET_TPS65086) += tps65086-restart.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
diff --git a/drivers/power/reset/tdx-ec-poweroff.c b/drivers/power/reset/tdx-ec-poweroff.c
new file mode 100644
index 000000000000..3302a127fce5
--- /dev/null
+++ b/drivers/power/reset/tdx-ec-poweroff.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toradex Embedded Controller driver
+ *
+ * Copyright (C) 2025 Toradex
+ *
+ * Author: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define EC_CHIP_ID_REG                  0x00
+#define EC_CHIP_ID_SMARC_IMX95          0x11
+#define EC_CHIP_ID_SMARC_IMX8MP         0x12
+
+#define EC_VERSION_REG_MAJOR            0x01
+#define EC_VERSION_REG_MINOR            0x02
+#define EC_ID_VERSION_LEN               3
+
+#define EC_CMD_REG                      0xD0
+#define EC_CMD_POWEROFF                 0x01
+#define EC_CMD_RESET                    0x02
+
+#define EC_REG_MAX                      0xD0
+
+static const struct regmap_range volatile_ranges[] = {
+	regmap_reg_range(EC_CMD_REG, EC_CMD_REG),
+};
+
+static const struct regmap_access_table volatile_table = {
+	.yes_ranges	= volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(volatile_ranges),
+};
+
+static const struct regmap_range read_ranges[] = {
+	regmap_reg_range(EC_CHIP_ID_REG, EC_VERSION_REG_MINOR),
+};
+
+static const struct regmap_access_table read_table = {
+	.yes_ranges	= read_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(read_ranges),
+};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= EC_REG_MAX,
+	.cache_type	= REGCACHE_RBTREE,
+	.rd_table	= &read_table,
+	.volatile_table = &volatile_table,
+};
+
+static int tdx_ec_cmd(struct regmap *regmap, u8 cmd)
+{
+	int err = regmap_write(regmap, EC_CMD_REG, cmd);
+
+	if (err)
+		dev_err(regmap_get_device(regmap), "Failed to send command 0x%02X: %d\n", cmd, err);
+
+	return err;
+}
+
+static int tdx_ec_power_off(struct sys_off_data *data)
+{
+	struct regmap *regmap = data->cb_data;
+	int err;
+
+	err = tdx_ec_cmd(regmap, EC_CMD_POWEROFF);
+
+	return err ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+static int tdx_ec_restart(struct sys_off_data *data)
+{
+	struct regmap *regmap = data->cb_data;
+	int err;
+
+	err = tdx_ec_cmd(regmap, EC_CMD_RESET);
+
+	return err ? NOTIFY_BAD : NOTIFY_DONE;
+}
+
+static int tdx_ec_register_power_off_restart(struct device *dev, struct regmap *regmap)
+{
+	int err;
+
+	err = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_FIRMWARE,
+					    tdx_ec_restart, regmap);
+	if (err)
+		return err;
+
+	return devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF,
+					     SYS_OFF_PRIO_FIRMWARE,
+					     tdx_ec_power_off, regmap);
+}
+
+static int tdx_ec_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	u8 reg_val[EC_ID_VERSION_LEN];
+	struct regmap *regmap;
+	int err;
+
+	regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	err = regmap_bulk_read(regmap, EC_CHIP_ID_REG, &reg_val, EC_ID_VERSION_LEN);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Cannot read id and version registers\n");
+
+	dev_info(dev, "Toradex Embedded Controller id %x - Firmware %u.%u\n",
+		 reg_val[0], reg_val[1], reg_val[2]);
+
+	err = tdx_ec_register_power_off_restart(dev, regmap);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Cannot register system restart handler\n");
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused of_tdx_ec_match[] = {
+	{ .compatible = "toradex,smarc-ec" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_tdx_ec_match);
+
+static struct i2c_driver tdx_ec_driver = {
+	.probe			= tdx_ec_probe,
+	.driver			= {
+		.name		= "toradex-smarc-ec",
+		.of_match_table = of_tdx_ec_match,
+	},
+};
+module_i2c_driver(tdx_ec_driver);
+
+MODULE_AUTHOR("Emanuele Ghidoli <emanuele.ghidoli@toradex.com>");
+MODULE_DESCRIPTION("Toradex SMARC Embedded Controller driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


