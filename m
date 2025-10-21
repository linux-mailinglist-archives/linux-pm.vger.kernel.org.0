Return-Path: <linux-pm+bounces-36606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F8ABF8AF7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5099819C556D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999F427E1D7;
	Tue, 21 Oct 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="T/yaLo+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC741DF72C;
	Tue, 21 Oct 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077733; cv=none; b=uWvk2gCPv9E4IC0O1WqbkPtAzYkNLUqdy+5fBnnSdvb8wedujtwFU7DCoewrGjujHOtH+ooYJT3FhCbbGrvvffxl5Z/+8oiv5UBP3fyKLLPkRwWm5vHm3ghUCyYrxb+jp+R9JheF2gNocXG8lGa3Op9OaDfXiGwY5zPfoKIyk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077733; c=relaxed/simple;
	bh=7c9bS2ivA7GkRCsDHGyEvFDeQR3n+4LH5pRWWxE6cVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACgTZh3Zoa++pVWFE4H9UMb/yrIoGpOlWnqR17MvAwG1HNj2KLF+jbm+Eqw6CXc9OzmaeLhJvWB47eqhbfGfKApQRB75ntf4TdU6ZHDjK3LlqPG9okPDs6rLeGsd7YYSjElPdRB1yzel0BTV5mTdG3X3FWCo/8481e0CmSIO4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=T/yaLo+0; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=bHj8D8a7dxXfalQUrw31acaFxGOvab3Ef1Wiao9zazU=; b=T/yaLo+0CGEpCglDEusHG9Z4jH
	RDLnPMTthWthoQaKYNOQ5pvQYJLJeJyezfIXrEgY1u0fxzapTBeuRGulYQ9dMfErCMCXprYBNoxOJ
	oxLzNCdywsAq5Aw4gkUpodvkAm4uGoLWdfzyemlg/xG2SUNUp8Dz5DgxTQgZkHEtZDrjl6ISP/cco
	3/0F2e9jGcVtJqdahYQVagft6r/vAQmZ1Zpq90iZ9zVEwXE+gFE2rXYtYF/Bmub/fK6g3cg+Q20As
	FL+orW1qCGH+1jYaWRpQUB5hmrX27N54GLI4kVEwyrJKlEUapcfT6MDLepIceaL6lSlAbSBwXozIO
	FdWnGGMQ==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1vBIl7-00GWoB-2v;
	Tue, 21 Oct 2025 22:15:05 +0200
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
Subject: [PATCH v3 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
Date: Tue, 21 Oct 2025 22:11:59 +0200
Message-ID: <20251021201451.1013640-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021201451.1013640-1-aurelien@aurel32.net>
References: <20251021201451.1013640-1-aurelien@aurel32.net>
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
Reviewed-by: Yixun Lan <dlan@gentoo.org>
---
v3:
 - Allow building as a module
 - Remove outdated Acked-by and Tested-by
 - Collect Reviewed-by

 drivers/power/reset/Kconfig              |  9 +++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/spacemit-p1-reboot.c | 88 ++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/power/reset/spacemit-p1-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 8248895ca9038..6577d73edbda4 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
 	help
 	  Reboot support for the KEYSTONE SoCs.
 
+config POWER_RESET_SPACEMIT_P1
+	tristate "SpacemiT P1 poweroff and reset driver"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select MFD_SPACEMIT_P1
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


