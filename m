Return-Path: <linux-pm+bounces-35510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BECBA63C9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 00:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D18617E9F0
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 22:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40AE23C4F1;
	Sat, 27 Sep 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="OMMPUsYf"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45316221DB1;
	Sat, 27 Sep 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759010932; cv=none; b=e8R0lHNTy4vhh1BfklNY8XUEOl3m+GOstnt3H03wKt7DnVShy7N7b0/1bwMnKfxbhmsAEZb/QXclGAZKS9vuAml8AZBnZIfBMOtAl85fXa5BK063iRD40d4iR0DGw5mYNSWfdvpDXt8l1octk/4iVG4H/T5g9H8sjmptX2TLFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759010932; c=relaxed/simple;
	bh=3Qs3XRqaow8ZHf1172nExOqRjirkq2rF9lJUKrxwedk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgJfp5jE6NxSipg0Q7jEFR8me+iTOix+/+UQVp3dt381cvaxvJD+tzYv8jF/+30OdtlFZVDjpRp2l4pVxN76uY2dIOdZp5oZ7l4BvFKeR0DL+tWGhOqW+fGMdpUrJl6WSn0RSq6LqyCsIQ56jH8/bN2YD8rloPCqbqirGGA6848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=OMMPUsYf; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=GpTo8pdhXGMVN7fhGczHnISpGYy58IC87QOueVeboFw=; b=OMMPUsYfHK5YCrxx05cDggLDXV
	/xPmxv0L4Vp0wTnzmtBTMIbOZ1ek5jUTJYzbXKbe1/or7OnXu70wscVZK7S2jMWkAsJE2HGnq6+SV
	tCx6zmb0K4xx2fTOH+2S1eoi+wJakai4Af6USx0C31F9E0FBybnQoTGU9G19V8AlFINXdQKv78fBz
	GCqfhQt8Ecup26gQHiMRpVIFcUKD0Yh2iXM2y0Aof/EoK149d+UCGMxU1NfF+mT9S/jBlRcfbzDpF
	sVI0opbBtBPMdZfGbCw3XZToAk3iq3BwTw0NLN1M2uiQWbwsluyG/cOj/Vg1CVVceypZfZVl9sp0+
	RksunvbA==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2d5r-000QXM-0A;
	Sun, 28 Sep 2025 00:08:39 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Sun, 28 Sep 2025 00:07:40 +0200
Message-ID: <20250927220824.1267318-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250927220824.1267318-1-aurelien@aurel32.net>
References: <20250927220824.1267318-1-aurelien@aurel32.net>
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
 drivers/power/reset/Kconfig              |  9 +++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/power/reset/spacemit-p1-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 77ea3129c7080..5afef049760d6 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -276,6 +276,15 @@ config POWER_RESET_KEYSTONE
 	help
 	  Reboot support for the KEYSTONE SoCs.
 
+config POWER_RESET_SPACEMIT_P1
+	bool "SpacemiT P1 poweroff and reset driver"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select MFD_SPACEMIT_P1
+	default ARCH_SPACEMIT
+	help
+	  This driver supports power-off and reset operations for the SpacemiT
+	  P1 PMIC.
+
 config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index b7c2b5940be99..cb6fb1be865db 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
+obj-$(CONFIG_POWER_RESET_SPACEMIT_P1) += spacemit-p1-reboot.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_TORADEX_EC) += tdx-ec-poweroff.o
 obj-$(CONFIG_POWER_RESET_TPS65086) += tps65086-restart.o
diff --git a/drivers/power/reset/spacemit-p1-reboot.c b/drivers/power/reset/spacemit-p1-reboot.c
new file mode 100644
index 0000000000000..105e19701ef85
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
+	ret = devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handler, regmap);
+	if (ret) {
+		dev_err(dev, "Failed to register power off handler: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_register_restart_handler(dev, spacemit_p1_restart_handler, regmap);
+	if (ret) {
+		dev_err(dev, "Failed to register restart handler: %d\n", ret);
+		return ret;
+	}
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


