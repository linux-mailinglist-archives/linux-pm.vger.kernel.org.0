Return-Path: <linux-pm+bounces-41992-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOYGKcYrgmlxQAMAu9opvQ
	(envelope-from <linux-pm+bounces-41992-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:09:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C471DC87B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B7C0302DF40
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE33BFE5C;
	Tue,  3 Feb 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2j8z48n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FC3D3D03
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138522; cv=none; b=Bc7mxTh+cpjRNGSKmq+3tUxUxOg3ZGGGQPt2CoWO1kmdp/89Sv3QdFB+v2ZYpl+XpKkSMAI3LMl9EQy0cq7EMlRjYO8uLCqLMQ4UpXloYb5ZGF3lULCop6udui7f5xlAS/v2yTYesOshiFQpY1wCnkb5OMinQJHALlYHJDK5K+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138522; c=relaxed/simple;
	bh=/fH3+b9yDcS1GIgeZS0m79tZEAT4nkei8lSgwKowqvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhJ7iTTa/hv7LZjeyKdRBeK6FXwzfbVj+8EeyFE1UP5kTUyVCtlD3U1sZEHz09uAVm3535kfj/rQ8F9JakuX4qxtvoVPtE/tDcrB/RtNr0i6XRsHc2NRtnnInWTF9bu2AR2aB6jUNW0aE9OyG3z+hLAznioDtOH2xhZEMOTpXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2j8z48n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c62239decbeso2307711a12.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138520; x=1770743320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTHfF0XW7B+7Ih5DzZqFm1iLafo8D1AWNlp8qH8D6r0=;
        b=I2j8z48n3ENz9QK6bZcO5Hbm/22Xc6BJSTSYi8fn+bEl4PGqk5QtgBD8X/YI8IfnIa
         X8xF2hK1BkN4YxKSHs0iMfOrGL1E1UOtwJgbsnKVqdjKmZQpLa752n7nxbNMKBfpbZxI
         5/Ctl1wpidldvr2eweAiECrGnxo52rdZoNMU5Tiou+v/xxSGfWCTPy3WoPAyBvMIoEBK
         jTjce1TxS1ZZZgnV1Ur3+oqKxADjKQ0220j2jITFjDfavQSQ8GAsoYZZNsspoMM+JKTZ
         dQPFVYNUPoTjn8TMiqihBXVf8ITdU66pUsQcVbUAjKBknIPEExgnDP6H3Lgeeir1K9Lq
         X//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138520; x=1770743320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTHfF0XW7B+7Ih5DzZqFm1iLafo8D1AWNlp8qH8D6r0=;
        b=YB49aRbW7nKw2PWw1d0oHiIOT737FBSLQxoith0y3+PqK6cXWVqiYdytgCRu5rpeqG
         GCSFVDBTkKCSGHvCwPlqfy3F8YqASlzX+sCjGodziUM2PweSSmEEnco2xNKMhi1c364t
         Ix3svN6jSjIX9Q9f8NLerhIumJGo7c6+3BTKEYA2GPspYQBbC3h2pfGCAjY/rYx3GRnk
         XE1U650wfBlpd+zbVrpfwIZgRIAM7xscSsdKQCXA/CV97Fp5kdNLNApeIZPJ0quzotzq
         cyB2dQ33RtPToEl0KYg6KYyUYsCMLTsKQaN13p3kLYPm3jlY3BGspVd9ClGcyu+HUlGy
         bg7g==
X-Forwarded-Encrypted: i=1; AJvYcCWfYSUNOGthCpdlv0+mzqbjQCxl0WkDv0WiLwr6HknSFci9NYpgsV0dwi22NM0mpXso50akuDofwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG52UTW3hdLDL/QMjLGocWL/DoXsl7EKUCOD/UyjFpQ4AJjv57
	0yzXPfdkxMA7lxBRaTa/NpBSlmi6B5XcihuXUDDDDPvtJLPyEWOBCTKA
X-Gm-Gg: AZuq6aIl1pskwikp1mkZtfJcbeDtenBtfU1a6l1zw0Qsr591O2kLGKOeuStS9Dwpg61
	8Z9qsXYVnP3R3gtjftwo/MdBabYb1J3PqYFikEQp0TLwZJ1HZE/J/9YzX1VPekJTsNwzcednIiv
	37+4G5CLMJ7qbpK9U4+JiPqFJrMEsBXdv8YdOS5d6YQraHgIHh+cbCXwwMaBgPFHwi6Xfrc9IRu
	K9V9PrjX2sMPK/y9kQTGJIZyk+ctev1okzMohOpxbUq6RnDcr7jP+ZLMcQ9tKfKT0ZMtm/rMRUD
	gomg6FeSYjgg5Hyt3mBjtJp5Yw2jiiqzECKlFzkQoO59XfDUVz/6wC+Rwq8CBecKKkoPF6mVplF
	nHQF6idEMB/dprmxcVRe4Mqlu8S4kVbJlhm5Yei7Mqg6Q9EXlwZt3DY6sT1ofW+EsXdz8fOwlFy
	wm6pEdJXYEMi2Wd+vqcsz35qcuP4VLknOOV42OVnPIVk9vUDl7TR0rlQnF14BnQ84kiZOovsa/L
	Lm600ovE01yFxYAumPkwyotyaA=
X-Received: by 2002:a05:6a21:a4c9:b0:38d:f08d:b349 with SMTP id adf61e73a8af0-39372427382mr82350637.43.1770138520086;
        Tue, 03 Feb 2026 09:08:40 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (118.239.201.35.bc.googleusercontent.com. [35.201.239.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548633616csm177520a91.17.2026.02.03.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:08:39 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/2] power: reset: Add QEMU virt-ctrl driver
Date: Tue,  3 Feb 2026 17:08:23 +0000
Message-ID: <20260203170824.2968045-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
In-Reply-To: <20260203170824.2968045-1-visitorckw@gmail.com>
References: <20260203170824.2968045-1-visitorckw@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,0x0f.com,vger.kernel.org,lists.linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41992-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2C471DC87B
X-Rspamd-Action: no action

Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
(e.g. m68k). This device provides a simple interface for system reset
and power off [1].

This driver utilizes the modern system-off API to register callbacks
for both system restart and power off. It is designed to be generic and
can be reused by other architectures utilizing this QEMU device.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Use devm_register_sys_off_handler() instead of register_restart_handler()
  and global pm_power_off.
- Switch Kconfig to tristate to support modular build.
- Add .id_table to platform_driver and use MODULE_DEVICE_TABLE() to correct
  module auto-loading.

 MAINTAINERS                          |  6 ++
 drivers/power/reset/Kconfig          | 10 ++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/qemu-virt-ctrl.c | 89 ++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0efa8cc6775b..57b403dae375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21190,6 +21190,12 @@ S:	Maintained
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
index 000000000000..2192ead56ca0
--- /dev/null
+++ b/drivers/power/reset/qemu-virt-ctrl.c
@@ -0,0 +1,89 @@
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
+static int qemu_virt_ctrl_power_off(struct sys_off_data *data)
+{
+	void __iomem *base = data->cb_data;
+
+	iowrite32be(CMD_HALT, base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_restart(struct sys_off_data *data)
+{
+	void __iomem *base = data->cb_data;
+
+	iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
+
+	return NOTIFY_DONE;
+}
+
+static int qemu_virt_ctrl_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_DEFAULT,
+					    qemu_virt_ctrl_restart,
+					    base);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register restart handler\n");
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    qemu_virt_ctrl_power_off,
+					    base);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot register power-off handler\n");
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
2.53.0.rc1.225.gd81095ad13-goog


