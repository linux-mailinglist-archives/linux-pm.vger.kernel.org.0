Return-Path: <linux-pm+bounces-42979-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEoaAM49m2m8wgMAu9opvQ
	(envelope-from <linux-pm+bounces-42979-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 18:33:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93D16FEEC
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7526C30146A8
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993035B63D;
	Sun, 22 Feb 2026 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjgv/zKn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3735B137
	for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781565; cv=none; b=b7ftvGNvq/7u9jeTUz+Kl1WxxHwRbOUppniTAo2ruEYA3tSOz/vy+WBEThIqAFjX3Lpg79b2soJwzh6qtlMlSvU/1pinesnc0cka0LcZpy4JXVebSdQo88Ec/eBVNXGKhfMoUe6fCW5ZaqZQRgzx37IlfdF1OOSTO2fK+wQ3glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781565; c=relaxed/simple;
	bh=hIGKj/FGC8Gh/lZO2wAX9+uKoIqF6oc1pUcFUMBWm3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDWNkukVBuAh/T4twJSm1VEVMDNoEdpQLidMbpS2E+UpAUSYySf4M2GwWh17ICh5VU16dMWaOHw13sqNUq1e2pezVgBmrgSJVkM0+tTOx4Tfi8RzZMAZ+V2Ijpipdsro2JGn5zssjkgNv42wN7/2MzUMc/B+4n8k9CJXZ7K1IOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjgv/zKn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354c825dc77so1576572a91.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771781564; x=1772386364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1btUeakV5x2bdwZTY0fXlY/DrEgaFMrytEHGtVsI2A=;
        b=Vjgv/zKnIOWvGVXjMaoWo5k0z8gzhqIKY1+fx2/toCUqXRz13cbK6NGyrW1mGKcmDk
         qsNlXu0DRUI2aqtf2/VkTcJKhjT+dpuQ+NHRw1Huhnmq2gO9KxEvyedfdxehc+sqprTE
         TzljjNS5RkC1Su7atqycBe519iNBia0yKjCs3GXoK2dhm9w1mQ8hENQXJQ8U5KB7Go+O
         2QIl4w8buCluuI2hsRhhFOymHNOf4vNSpkuFCPNbsQtflSp2edtr0vk4dfJtNlh1MAft
         hVI7IPPKtyibns/lJFBcyyriE4zSA7SWfeXd4lCc7fjgC6+LARb19Rgmcc/ENzeyssq/
         IwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771781564; x=1772386364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1btUeakV5x2bdwZTY0fXlY/DrEgaFMrytEHGtVsI2A=;
        b=bgz0jH4C3VtudqtV0HgceBZSzYiERJcRN68yQCzxvsUrVZKNjLkjjexe/sZcEG2nZC
         nNXgocuzSsOzNQx62ZhLfStszrE5yHNylbnkdM92iB8pyVLa9p7789s1PBKcqIgiaGO8
         gHmSlA6gXYkmCOzWLgn00AeHWRJx4LsnFqSomZHd+KHA5MklvMXkeZYZfhDSsa6uZHr1
         i2q9Ypc6HRnRNa436GnoqQmMLhYlO7xzdcZPO5jNXEv5tQwCshYdTY3eSOVzQSL21ku/
         R+jqbuZuPQ3BIqa8tpO08aVSxVlNvWsE0qsp6e29MM9jYbYMPDSAq8ksKgrflOkPTYnA
         LlPA==
X-Forwarded-Encrypted: i=1; AJvYcCX3HwbNgTchYM7Yy6CHt1ahdZ14UHsnNXlg9VuHV4+vKOh4tDwKGGx31n1qhaNmoGgvPOZ1KZReKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyWxN6RfRhQ/lKu0eMsQ2xPca/5YwRSjIvgBDVWK6moYtKvqm
	S9JpcR1WBA3gDy6UN7EXSAAoQH6bJp22Znrw0g3mHX5Mhyit8Zb7DCDC9mQEy3J8
X-Gm-Gg: AZuq6aJCsfeu9NbJQGZmcDPR5uBtxcLJOW6NX9mJoywRFPfI7Cp0IvPlDXnQqp3HZMx
	XtTa4DdxSaVer4JXki6BlYiYoF1AbtDVfd6r1KS/U455S78KzDb4PQ7Gdl+E+MMqLONNpdI4gV+
	oIBJ+IJA2vAgktyIw+xNKbCz/pF1/NPs9XDfDheg7nJyjx2ZTSfJniJDhHg9+vg36JmGoPG/lYN
	l9k74EHEnpA6BPrKsMiqDMjAFUpYAUq3joN9ReMvowbuB2A4skVTloV/LyvAJlWFVvolPIE8R4N
	DpO9HAzsEJEcPTsqknrc+X8hR43ypjX5n2Fv0kH7JE2ZnQYPm9eXKmo4TczWYGEf7a2GFWudPjI
	i46zoW9q7ayb/T4pOZ63E+bFglXmSmoxXAOGxq5XpLojYMMOYhTB8E08hpGA1X9E/MKdaGIZzgX
	OEhj0p9qGSzPLQETQuI8dDpp6PbgJ3dMJgHW25IyYNcNqWezmQXt45DVSUP6gW+7UI9lfkv5hpJ
	hGIpm+ibgAVZL3noDiXaj9lUS5M+fBg0K1S
X-Received: by 2002:a17:90b:268b:b0:356:7917:236 with SMTP id 98e67ed59e1d1-358ae8c6a26mr4779794a91.26.1771781563791;
        Sun, 22 Feb 2026 09:32:43 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b726cbf2sm5275750a12.34.2026.02.22.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 09:32:43 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	laurent@vivier.eu,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 1/2] power: reset: Add QEMU virt-ctrl driver
Date: Sun, 22 Feb 2026 17:32:24 +0000
Message-ID: <20260222173225.1105572-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
In-Reply-To: <20260222173225.1105572-1-visitorckw@gmail.com>
References: <20260222173225.1105572-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,0x0f.com,vivier.eu,vger.kernel.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-42979-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.com:url]
X-Rspamd-Queue-Id: 5B93D16FEEC
X-Rspamd-Action: no action

Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
(e.g. m68k). This device provides a simple interface for system reset
and power off [1].

This driver utilizes the modern system-off API to register callbacks
for both system restart and power off. It also registers a reboot
notifier to catch SYS_HALT events, ensuring that LINUX_REBOOT_CMD_HALT
is properly handled. It is designed to be generic and can be reused by
other architectures utilizing this QEMU device.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Add a reboot notifier to handle SYS_HALT.
- Implement virt_ctrl_write32() to handle native endianness.

I noticed devm_register_sys_off_handler() currently lacks a
SYS_OFF_MODE_HALT. Therefore, I registered a standard reboot notifier
for SYS_HALT, while keeping restart and power-off on the sys-off API.

 MAINTAINERS                          |   6 ++
 drivers/power/reset/Kconfig          |  10 +++
 drivers/power/reset/Makefile         |   1 +
 drivers/power/reset/qemu-virt-ctrl.c | 122 +++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..aa9eb8540637 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21441,6 +21441,12 @@ S:	Maintained
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
index f6c1bcbb57de..99e3334726a5 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -354,4 +354,14 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config POWER_RESET_QEMU_VIRT_CTRL
+	tristate "QEMU Virt Machine System Controller"
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
index 000000000000..f40d04afd4e3
--- /dev/null
+++ b/drivers/power/reset/qemu-virt-ctrl.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QEMU Virt Machine System Controller Driver
+ *
+ * Copyright (C) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
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
+	struct notifier_block reboot_nb;
+};
+
+static inline void virt_ctrl_write32(u32 val, void __iomem *addr)
+{
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		iowrite32be(val, addr);
+	else
+		iowrite32(val, addr);
+}
+
+static int qemu_virt_ctrl_power_off(struct sys_off_data *data)
+{
+	void __iomem *base = data->cb_data;
+
+	virt_ctrl_write32(CMD_HALT, base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_restart(struct sys_off_data *data)
+{
+	void __iomem *base = data->cb_data;
+
+	virt_ctrl_write32(CMD_RESET, base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_reboot_notify(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct qemu_virt_ctrl *ctrl = container_of(nb, struct qemu_virt_ctrl, reboot_nb);
+
+	if (action == SYS_HALT)
+		virt_ctrl_write32(CMD_HALT, ctrl->base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_probe(struct platform_device *pdev)
+{
+	struct qemu_virt_ctrl *ctrl;
+	int ret;
+
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ctrl->base))
+		return PTR_ERR(ctrl->base);
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_DEFAULT,
+					    qemu_virt_ctrl_restart,
+					    ctrl->base);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register restart handler\n");
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    qemu_virt_ctrl_power_off,
+					    ctrl->base);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register power-off handler\n");
+
+	ctrl->reboot_nb.notifier_call = qemu_virt_ctrl_reboot_notify;
+	ret = devm_register_reboot_notifier(&pdev->dev, &ctrl->reboot_nb);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "cannot register reboot notifier\n");
+
+	return 0;
+}
+
+static const struct platform_device_id qemu_virt_ctrl_id[] = {
+	{ "qemu-virt-ctrl", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, qemu_virt_ctrl_id);
+
+static struct platform_driver qemu_virt_ctrl_driver = {
+	.probe = qemu_virt_ctrl_probe,
+	.driver = {
+		.name = "qemu-virt-ctrl",
+	},
+	.id_table = qemu_virt_ctrl_id,
+};
+module_platform_driver(qemu_virt_ctrl_driver);
+
+MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
+MODULE_DESCRIPTION("QEMU Virt Machine System Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0.345.g96ddfc5eaa-goog


