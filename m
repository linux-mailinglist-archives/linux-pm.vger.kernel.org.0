Return-Path: <linux-pm+bounces-36862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10129C0B62D
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 23:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF2114E0643
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 22:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C847E2FF171;
	Sun, 26 Oct 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="KpciAmJ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D32E413;
	Sun, 26 Oct 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761518700; cv=none; b=gThMX0PF+LHjlBbUu6agrvZQaqZGXjFVkUhbkEj2cfS9WuZaAwhDI3nA25oy4k9N75QxV5xkyud/KP+sxVK20Tz2k9V8irKRuIt00D93UOxIiR/e7ZlztqosEBbn+5NH8twmhzsAelq61Ycf6cXzAcpVHTp9kL6ZNekLdGlD4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761518700; c=relaxed/simple;
	bh=rnKM3Mf4zNvlmpFAY+C6o35rhzmhrxjGH/xsMqAZTV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLbIsWD0McTxQZokTTSO607MmvXJ/NHwZ9uZSymbHJORuXWq06bCdjXc9uXTAcpDarIf++nkHML1OggutBtaWn4sLo+dfa2GO/mLTiD/HZjrE8ajygL+7xc5BT/hKrM/zGNUMfSHaWCOtABbQHh/k9NB+E+o3GQqjp5z+2kkjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=KpciAmJ2; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=upuvDJ4uHcxGhtGccy6wLQYNYBh7CDWGSkmRMwmBkeQ=; b=KpciAmJ2X1ae/s3WQG+HnrqApw
	obxX0S9zBigyEP8PYi/N5g/E3TwI6A8gpAs/pxmzD8ZdjJBs4n8Thuv9CAlKQpHo1vUYvNehhrV9D
	el2HQXIWvp6vKZacsDc1W7rHVLDYnMkNhI6Yu3XFSXQgZKqHQxuuOzOAHufynpAbA5bUm+Yv1a7to
	LMPxX4bGzqaCFK71f54eZ6yryniLLKY29hc3s3Gt9zy2Zv0Cc83Xl1V0N1UCLmOgQk1j8KwqEJk9H
	PXrUONlzS669Q6IzRrFXq2ilzte7OvGXon9rlrQbYHiC4eOX8viDlSfrD4iCOUbrZtyclblKyOKsU
	uZ5b5oWg==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vD9TV-0065U5-1b;
	Sun, 26 Oct 2025 23:44:33 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE:Keyword:riscv),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS)
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Sun, 26 Oct 2025 23:41:14 +0100
Message-ID: <20251026224424.1891541-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251026224424.1891541-1-aurelien@aurel32.net>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver implements poweroff/reboot support for the SpacemiT P1 PMIC
chip, which is commonly paired with the SpacemiT K1 SoC.

The SpacemiT P1 support is implemented as a MFD driver, so the access is
done directly through the regmap interface. Reboot or poweroff is
triggered by setting a specific bit in a control register, which is
automatically cleared by the hardware afterwards.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
v2:
 - Replace the "select" by a "depends on"
 - Remove outdated Reviewed-by

 drivers/power/reset/Kconfig              |  9 +++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/power/reset/spacemit-p1-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 8248895ca9038..61c16f3d5abc7 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
 	help
 	  Reboot support for the KEYSTONE SoCs.
 
+config POWER_RESET_SPACEMIT_P1
+	tristate "SpacemiT P1 poweroff and reset driver"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	depends on MFD_SPACEMIT_P1
+	default m
+	help
+	  This driver supports power-off and reset operations for the SpacemiT
+	  P1 PMIC.
+
 config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 51da87e05ce76..0e4ae6f6b5c55 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
+obj-$(CONFIG_POWER_RESET_SPACEMIT_P1) += spacemit-p1-reboot.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_TH1520_AON) += th1520-aon-reboot.o
 obj-$(CONFIG_POWER_RESET_TORADEX_EC) += tdx-ec-poweroff.o
diff --git a/drivers/power/reset/spacemit-p1-reboot.c b/drivers/power/reset/spacemit-p1-reboot.c
new file mode 100644
index 0000000000000..9ec3d1fff8f3d
--- /dev/null
+++ b/drivers/power/reset/spacemit-p1-reboot.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 by Aurelien Jarno
+ */
+
+#include <linux/bits.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reboot.h>
+
+/* Power Control Register 2 */
+#define PWR_CTRL2		0x7e
+#define PWR_CTRL2_SHUTDOWN	BIT(2)	/* Shutdown request */
+#define PWR_CTRL2_RST		BIT(1)	/* Reset request */
+
+static int spacemit_p1_pwroff_handler(struct sys_off_data *data)
+{
+	struct regmap *regmap = data->cb_data;
+	int ret;
+
+	/* Put the PMIC into shutdown state */
+	ret = regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_SHUTDOWN);
+	if (ret) {
+		dev_err(data->dev, "shutdown failed: %d\n", ret);
+		return notifier_from_errno(ret);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int spacemit_p1_restart_handler(struct sys_off_data *data)
+{
+	struct regmap *regmap = data->cb_data;
+	int ret;
+
+	/* Put the PMIC into reset state */
+	ret = regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_RST);
+	if (ret) {
+		dev_err(data->dev, "restart failed: %d\n", ret);
+		return notifier_from_errno(ret);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int spacemit_p1_reboot_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	ret = devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handler,
+					      regmap);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register power off handler\n");
+
+	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler,
+					    regmap);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register restart handler\n");
+
+	return 0;
+}
+
+static const struct platform_device_id spacemit_p1_reboot_id_table[] = {
+	{ "spacemit-p1-reboot", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, spacemit_p1_reboot_id_table);
+
+static struct platform_driver spacemit_p1_reboot_driver = {
+	.driver = {
+		.name = "spacemit-p1-reboot",
+	},
+	.probe = spacemit_p1_reboot_probe,
+	.id_table = spacemit_p1_reboot_id_table,
+};
+module_platform_driver(spacemit_p1_reboot_driver);
+
+MODULE_DESCRIPTION("SpacemiT P1 reboot/poweroff driver");
+MODULE_LICENSE("GPL");
-- 
2.47.2


