Return-Path: <linux-pm+bounces-40685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49158D14C23
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2661030F0918
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C963876A8;
	Mon, 12 Jan 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAkpqsA0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C538758A
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242203; cv=none; b=DODHrGinJtomJewM/8ecG5/UyQeq7a/2eGCNiEbCtzKjH56lJvQ8i0ihtG2Gha3veCp1bpW7AiboOsTUIqvWm6s3CArnX58IW7hBbxT9wYql6JmC0dO1Sw1JNQi/3cPHAFwqIIDvlDlWysqhRRPI2zvLikrQMS4FbcRRBt09g7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242203; c=relaxed/simple;
	bh=JixI5MKXXHfbCAOb4sZTT/q9s6LOvmfZnYyMilwvDNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceQCO6QW6roDUhblCsxwaoBY53bwpTFrIOQj68nBrvyqd3oVOyufbVlu3H8JxgD5O6whumF6CGWqm4LwFWLPIJsAqy5bfclMaS08FUzjmAY/wXy1x8n+7SH9en60UG/R3aGHvPtYwDUmkLuW7TQEwRr014CcuHKaNi+xQ1xsnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAkpqsA0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f30233d8aso44771135ad.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768242199; x=1768846999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4oM9+6NMg5ZQ1ImC64TO0sq8NspPgsBXi1LprWrWHQ=;
        b=OAkpqsA0friR89/RMXT7Faw/B4SVrEpsimPi6OsntwHxo++PSTM1cwpVZKMQCMtrVk
         m7ASh/dqPWymsGoPCcTZGvNuE27aAbI6XDVah3rsifIbIcVAha5qvdkDIPJfyRkGQngd
         dda9dhXWDSXcm46rTehH7WToBYJH6ZLuQB+PeirJAJRkJwKGnx2OXFHK2PmFpJb7RtLp
         zqeNDJoIXIOniCRgyb3FyoG2hbIpNEpl+hW3KOxTmHpl+cb2hUjSOn5yaJJSTOdIT/m0
         hyRA6vVvIvK9OYs3V+ld1Lgk5Z5GezAR4Lw+pMhqgFmilWYLMyUhpbzbYp7DDawa/d0E
         jrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242199; x=1768846999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X4oM9+6NMg5ZQ1ImC64TO0sq8NspPgsBXi1LprWrWHQ=;
        b=TX3ClpWlOcJrdl+Wv5yjhCsj3PfV86RwaMCslSWMm0nOnXg7ebhJQ2LQ5iLfdOVgvk
         NBFCYABSqzDIyP8ZDAd5ufsNf9P7faCP7tr/0KY2vcv704uO9T6R7K8P0e41C+p/UOxF
         geYDZW6iMqXUrItQLYwztgLD5xVOMyCtau7R4LwGSkoP+kjkRlWaL12rvLpqFRtCH8im
         KPMFA/WhTDgGgGWWuzN1taPj0iO1ArgQUVDST13vgtKD4RnxOd65AjlhODw5DI6vz/Vu
         g8R2OXrL+izqdriPn1QbTOu8SNVj5OOwGuoq0N6WzAOZkv6k9ZqhoXuWX06g0XRKfpkI
         Piyw==
X-Forwarded-Encrypted: i=1; AJvYcCUnc2SmUsdnGdqtg5ucWaxkZRuMpn4BEEnxmvSaGNyHw2J6qo4/KgY5Fq+27sqJ0eyeWcnGKWV5cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnPeL9JNkxbi0Lo5Pkq9INqLHxFr9vOvyprKvnlWfNRY3DqK3
	sH7PpMsfqmZVuEfryL8k9XkE0+mzs/9MjG+dE+ZriyoSZxeFC34GAbZb
X-Gm-Gg: AY/fxX7r3rDAs2k0LykTGzdoXJmDS1xucPDer/3XQdBWH60fZ3LzaL+MYjp5hNkLOi/
	B8TwrVAaTL+9bMQOh/bpK5U4BsbiWwEFB0KzG38kaQF332WaDGqo8Li+HiHXkiywjgv9jAWHREu
	fp9DbGdMhYobJ+6Sd7ATGB7VL6MUlOpiufDkCG3vXSJdMZ1Qc5KEmzaOWneUlYHunOSLgTPUn0V
	6Exm+wvp8sKOcaXykBSdEVjt6Bh2wpLrQluZjBk3pWPZV9FyZRIkZcnYrY4Egh+LmpW1rYCtx2M
	ckS4bvEHA2KYNLJMFK06la0Pzz7LrZow2OXCDtdjVrYcDVXqiOJmxX9g2VOTl49XlhvC+hgojz9
	OrVKxHrslOTQ7OV+4N+UjtHZnjiti5vBGMOzKh8v58FNo0Ha5wYA4whdueSuWn0vVsUiFUErBPi
	E/7rrppJh/UTyBqSHYq9EzdXZsEMaI879EV6Sz8iK5Gi6qNcHqvC5k/ihkn56gTEIiyazAxNggN
	g8RC1vU2+cvZ4beJf6xj6m1AEDwyoWi
X-Google-Smtp-Source: AGHT+IFt8RVpeeOtq9O9bSM2ksXYcn2EaNgWu8GverPZh2BzB+VspJTa4/pMhcKRNs5POXbaKfo/GQ==
X-Received: by 2002:a17:903:13ce:b0:295:560a:e499 with SMTP id d9443c01a7336-2a3ee43316amr164992035ad.5.1768242198685;
        Mon, 12 Jan 2026 10:23:18 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc794asm180981205ad.70.2026.01.12.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:23:18 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] power: reset: Add QEMU virt-ctrl driver
Date: Mon, 12 Jan 2026 18:22:56 +0000
Message-ID: <20260112182258.1851769-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260112182258.1851769-1-visitorckw@gmail.com>
References: <20260112182258.1851769-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
(e.g. m68k). This device provides a simple interface for system reset
and power off [1].

This driver registers a restart handler for system reboot and sets the
global pm_power_off callback for system shutdown. It is designed to be
generic and can be reused by other architectures utilizing this QEMU
device.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                          |  6 ++
 drivers/power/reset/Kconfig          | 10 +++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/qemu-virt-ctrl.c | 98 ++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d044a58cbfe..2586e4162304 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21179,6 +21179,12 @@ S:	Maintained
 F:	drivers/firmware/qemu_fw_cfg.c
 F:	include/uapi/linux/qemu_fw_cfg.h
 
+QEMU VIRT MACHINE SYSTEM CONTROLLER DRIVER
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/power/reset/qemu-virt-ctrl.c
+
 QLOGIC QL41xxx FCOE DRIVER
 M:	Saurav Kashyap <skashyap@marvell.com>
 M:	Javed Hasan <jhasan@marvell.com>
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f6c1bcbb57de..1ca1c2913cbc 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -354,4 +354,14 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config POWER_RESET_QEMU_VIRT_CTRL
+	bool "QEMU Virt Machine System Controller"
+	depends on HAS_IOMEM
+	help
+	  This driver supports the system reset and power off functionality
+	  provided by the QEMU 'virt-ctrl' device.
+
+	  Say Y here if you are running Linux on a QEMU virtual machine that
+	  provides this controller, such as the m68k virt machine.
+
 endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0e4ae6f6b5c5..d7ae97241a83 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
+obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
diff --git a/drivers/power/reset/qemu-virt-ctrl.c b/drivers/power/reset/qemu-virt-ctrl.c
new file mode 100644
index 000000000000..f1acd22172ce
--- /dev/null
+++ b/drivers/power/reset/qemu-virt-ctrl.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QEMU Virt Machine System Controller Driver
+ *
+ * Copyright (C) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+/* Registers */
+#define VIRT_CTRL_REG_FEATURES	0x00
+#define VIRT_CTRL_REG_CMD	0x04
+
+/* Commands */
+#define CMD_NOOP	0
+#define CMD_RESET	1
+#define CMD_HALT	2
+#define CMD_PANIC	3
+
+struct qemu_virt_ctrl {
+	void __iomem *base;
+	struct notifier_block restart_nb;
+};
+
+static void __iomem *qemu_virt_ctrl_base;
+
+static void qemu_virt_ctrl_power_off(void)
+{
+	if (qemu_virt_ctrl_base)
+		iowrite32be(CMD_HALT, qemu_virt_ctrl_base + VIRT_CTRL_REG_CMD);
+}
+
+static int qemu_virt_ctrl_restart(struct notifier_block *nb, unsigned long action,
+				  void *data)
+{
+	struct qemu_virt_ctrl *vc = container_of(nb, struct qemu_virt_ctrl, restart_nb);
+
+	iowrite32be(CMD_RESET, vc->base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_probe(struct platform_device *pdev)
+{
+	struct qemu_virt_ctrl *vc;
+	int ret;
+
+	vc = devm_kzalloc(&pdev->dev, sizeof(*vc), GFP_KERNEL);
+	if (!vc)
+		return -ENOMEM;
+
+	vc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(vc->base))
+		return PTR_ERR(vc->base);
+
+	qemu_virt_ctrl_base = vc->base;
+
+	vc->restart_nb.notifier_call = qemu_virt_ctrl_restart;
+	vc->restart_nb.priority = 128;
+
+	ret = register_restart_handler(&vc->restart_nb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register restart handler\n");
+
+	if (!pm_power_off)
+		pm_power_off = qemu_virt_ctrl_power_off;
+
+	platform_set_drvdata(pdev, vc);
+
+	return 0;
+}
+
+static void qemu_virt_ctrl_remove(struct platform_device *pdev)
+{
+	struct qemu_virt_ctrl *vc = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&vc->restart_nb);
+
+	if (pm_power_off == qemu_virt_ctrl_power_off)
+		pm_power_off = NULL;
+}
+
+static struct platform_driver qemu_virt_ctrl_driver = {
+	.probe = qemu_virt_ctrl_probe,
+	.remove = qemu_virt_ctrl_remove,
+	.driver = {
+		.name = "qemu-virt-ctrl",
+	},
+};
+module_platform_driver(qemu_virt_ctrl_driver);
+
+MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
+MODULE_DESCRIPTION("QEMU Virt Machine System Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.52.0.457.g6b5491de43-goog


