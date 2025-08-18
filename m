Return-Path: <linux-pm+bounces-32499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05DB29B45
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BE81899EE4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98F286D75;
	Mon, 18 Aug 2025 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="k4Qhiueg"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19768286D49;
	Mon, 18 Aug 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503388; cv=pass; b=BcHiurYUZ7tapa8G0W7ezu/HUdox2mLjkIdQzrwOoQTEkRVpEQ4d3+qcsI14xtM93ffES1WanVthzUqWGEYdYKG1Lz9L3IhQVmKRh7L6GpnNyCVM86pv4bSrCPjxCINxKhhnz/wnPgeJlmBrFhGe+GGuty+10xHFopPPD2mxChU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503388; c=relaxed/simple;
	bh=ACf4r7Qngk3dd9Er6SsBBuKCjXlRI22RwQgN2pXOl/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZLE8UVfkB6MzQKKfe7dIns0IfbRbtUm2nPxbXb/Sodwqx9t3qLb0OgKbvmPsRjRgJqpSYGQkY+RSdthiCsUxAmWqjPjOmjyGyMacanRN8KYRd7B5HbyQjh7yTDIQjsy5ugmE61jNQkqtgbgEvSIOXeYewEpcH29rvmD0J27M38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=k4Qhiueg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755503374; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X032uvCgpoQTIviV7My3PYMDvdbfmyxrOehYKxeioFUO7KQ/aZ9abRKNasky+b3SBtd1JKRNa+cdcMJSp1q5qlDc5qKOHYXzR/q8rpSJp1UwvuEXhq3Jct+Lh+n7lnCJ1CdQnaLLaekOGWX0BV3ZdNCplX1W5ZS7CUonTyBSkzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755503374; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UedmDzyvf5l65qW+hQfIQJ8Xd28PzjRNYITRMIOAHbE=; 
	b=JUc8L0gaccDunSIVZUel4Z+xTSGE8NXgu0rzLkQ47kRSkGyjopGsGFAcD+LHE3vq9cIVm0ZNnCdlYgCda/iq68E+sYVUnsIRISFVbxT3UbSkbgXx60/Fjzup8pQQU5SxtwOwgDpRmJG9qzHdOqyQxPGmFWA2T7RT/iFL28GCOEg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755503374;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UedmDzyvf5l65qW+hQfIQJ8Xd28PzjRNYITRMIOAHbE=;
	b=k4QhiuegKR1KjzI+AbcmK5swtDTs1eGRuKJoq3iZ5yDsNG4iKCTXgL+Z4oJGEJwb
	qQ3wdnShysWsdzhtBbwkMepF1oYABlAghFQuEu1Rlv74wxIy+rYxfKAN8LHvvi5fBOx
	F1kdoH98xdny8jzJ1AfoOEyDMFRO+Ravl5MHwRM8VTzgXmEsZvZ5b4kbiIDFzIYo/kn
	a3bHknIG+nZNgSoRKvTthRaAPSW6ZgfviDjESAjHiievc5yzHatbE54H9PPPD2D+JsL
	7YLJh0EO+PiRbHngtbdDaHyILXJyARQKubyyrXmy2LZBVhbhQK7tblA4VBhfoV3mRzl
	2ueR0TLUfQ==
Received: by mx.zohomail.com with SMTPS id 1755503371096963.652409830932;
	Mon, 18 Aug 2025 00:49:31 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] driver: reset: th1520-aon: add driver for poweroff/reboot via AON FW
Date: Mon, 18 Aug 2025 15:49:05 +0800
Message-ID: <20250818074906.2907277-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818074906.2907277-1-uwu@icenowy.me>
References: <20250818074906.2907277-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This driver implements poweroff/reboot support for T-Head TH1520 SoCs
running the AON firmware by sending a message to the AON firmware's WDG
part.

This is a auxiliary device driver, and expects the AON channel to be
passed via the platform_data of the auxiliary device.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 MAINTAINERS                             |  1 +
 drivers/power/reset/Kconfig             |  7 ++
 drivers/power/reset/Makefile            |  1 +
 drivers/power/reset/th1520-aon-reboot.c | 98 +++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/power/reset/th1520-aon-reboot.c

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6..e138a1e96ceea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21730,6 +21730,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/power/reset/th1520-aon-reboot.c
 F:	drivers/power/sequencing/pwrseq-thead-gpu.c
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 77ea3129c7080..8248895ca9038 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -225,6 +225,13 @@ config POWER_RESET_ST
 	help
 	  Reset support for STMicroelectronics boards.
 
+config POWER_RESET_TH1520_AON
+	tristate "T-Head TH1520 AON firmware poweroff and reset driver"
+	depends on TH1520_PM_DOMAINS
+	help
+	  This driver supports power-off and reset operations for T-Head
+	  TH1520 SoCs running the AON firmware.
+
 config POWER_RESET_TORADEX_EC
 	tristate "Toradex Embedded Controller power-off and reset driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index b7c2b5940be99..51da87e05ce76 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
+obj-$(CONFIG_POWER_RESET_TH1520_AON) += th1520-aon-reboot.o
 obj-$(CONFIG_POWER_RESET_TORADEX_EC) += tdx-ec-poweroff.o
 obj-$(CONFIG_POWER_RESET_TPS65086) += tps65086-restart.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
diff --git a/drivers/power/reset/th1520-aon-reboot.c b/drivers/power/reset/th1520-aon-reboot.c
new file mode 100644
index 0000000000000..8256c1703ebe8
--- /dev/null
+++ b/drivers/power/reset/th1520-aon-reboot.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD TH1520 AON Firmware Reboot Driver
+ *
+ * Copyright (c) 2025 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/firmware/thead/thead,th1520-aon.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+
+#define TH1520_AON_REBOOT_PRIORITY 200
+
+struct th1520_aon_msg_empty_body {
+	struct th1520_aon_rpc_msg_hdr hdr;
+	u16 reserved[12];
+} __packed __aligned(1);
+
+static int th1520_aon_pwroff_handler(struct sys_off_data *data)
+{
+	struct th1520_aon_chan *aon_chan = data->cb_data;
+	struct th1520_aon_msg_empty_body msg = {};
+
+	msg.hdr.svc = TH1520_AON_RPC_SVC_WDG;
+	msg.hdr.func = TH1520_AON_WDG_FUNC_POWER_OFF;
+	msg.hdr.size = TH1520_AON_RPC_MSG_NUM;
+
+	th1520_aon_call_rpc(aon_chan, &msg);
+
+	return NOTIFY_DONE;
+}
+
+static int th1520_aon_restart_handler(struct sys_off_data *data)
+{
+	struct th1520_aon_chan *aon_chan = data->cb_data;
+	struct th1520_aon_msg_empty_body msg = {};
+
+	msg.hdr.svc = TH1520_AON_RPC_SVC_WDG;
+	msg.hdr.func = TH1520_AON_WDG_FUNC_RESTART;
+	msg.hdr.size = TH1520_AON_RPC_MSG_NUM;
+
+	th1520_aon_call_rpc(aon_chan, &msg);
+
+	return NOTIFY_DONE;
+}
+
+static int th1520_aon_reboot_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	int ret;
+
+	/* Expect struct th1520_aon_chan to be passed via platform_data */
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF,
+					    TH1520_AON_REBOOT_PRIORITY,
+					    th1520_aon_pwroff_handler,
+					    adev->dev.platform_data);
+
+	if (ret) {
+		dev_err(dev, "Failed to register power off handler\n");
+		return ret;
+	}
+
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART,
+					    TH1520_AON_REBOOT_PRIORITY,
+					    th1520_aon_restart_handler,
+					    adev->dev.platform_data);
+
+	if (ret) {
+		dev_err(dev, "Failed to register restart handler\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct auxiliary_device_id th1520_aon_reboot_id_table[] = {
+	{ .name = "th1520_pm_domains.reboot" },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, th1520_aon_reboot_id_table);
+
+static struct auxiliary_driver th1520_aon_reboot_driver = {
+	.driver = {
+		.name = "th1520-aon-reboot",
+	},
+	.probe = th1520_aon_reboot_probe,
+	.id_table = th1520_aon_reboot_id_table,
+};
+module_auxiliary_driver(th1520_aon_reboot_driver);
+
+MODULE_AUTHOR("Icenowy Zheng <uwu@icenowy.me>");
+MODULE_DESCRIPTION("T-HEAD TH1520 AON-firmware-based reboot driver");
+MODULE_LICENSE("GPL");
-- 
2.50.1


