Return-Path: <linux-pm+bounces-12732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF395BA39
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA66B270A8
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB51CDFA1;
	Thu, 22 Aug 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="P+n1/efy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA101CDA1C
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340508; cv=none; b=MNBFUQDluRYVOrS/1ehMt3cVLGK4xtBaaQ0eDaXTzXPbW3fcFX+oNJEKL7oI1KcG7NE1stWlq/k/h1CtXmGe2ngtIemqBGqRyYZdGDEZLi/3LqzV2ypJrinOOU/JX/0BGMpOebVtgHmCKm18Y7ofPsB5PZpzu75OVb9gcDNHYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340508; c=relaxed/simple;
	bh=+npf8sqx1TsaaMkEzhbJBWj+d9glTP2f3WsOgcb1NU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP/ekgh3yL3Mr9IrwW5rvy78acEzjglNgwe2wCjp+qCEqzEcwXNDauDO9oxIMDAXltEYNBlqnIJ13l/vz4W9Ka9ODdpPdRjQgA0oik58PI6SoxVntGUl2zfrqTW0eRclNVfLVnhvP0VWQv7D9KJKxfUru1DrbpSARsU9eqVPZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=P+n1/efy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so1320755a12.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340504; x=1724945304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9DOBqvnZ/STjSdrebzztVFaplbBr0hBrOhxjpVMxCw=;
        b=P+n1/efy9JMGmwSBitQv4YqwYu4KAbPb1QMyVtTRxtQMXY8nItoc8J6oZSJnyGABD7
         G9LdGSwh8Zz3WagfqrUUB17Y8w9YTGXzrW+c9cnDAtH5ldcGM0CkRArJ0W+HakrLxAmt
         RXd6tkxTlQ24c1n45yk/xCrvVm0lrCYzFDVC3hdaLViEf9xQAqWqo7VOVC5oxQMyECiM
         I3r17W1j9Isf30+J7p8C1FSZlQh4eoViHoi6BUQhXUckXy3KWYWP3Y/NpGXERjaSfAIm
         t/FtFx+qSKfl5R/toR3gtaontt4gLnxIMMj6mctEXgRo89Fyg5+dYfxcFW6Tls06lbw2
         o4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340504; x=1724945304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9DOBqvnZ/STjSdrebzztVFaplbBr0hBrOhxjpVMxCw=;
        b=UAQXsif0LZLTdCV7IGl3wQq91gk0hetcSCQg/jid173+ZVNhSz7OdjYA219XIKh2Au
         6ah0CELHmLuIAEYNdt5/NzcwL+u2H1iLowQBNQFdR8xhSSZwnOjSGlQ6vTcUbp8SBp/Y
         YjC7Rf1ad2DAKkka2k8unRxPMrw4sC4L5b4fC+Drrc1C32yiS1H7SWnGUNlr/O4k2nit
         uLBSf5errIQfTBXJYDhIs7Bfucp3/SVMkeXFhozEfLqEU97NjkZQSrVNMg9/WGBZ9d79
         dXgr2Hw8rEU5iqYnju98dcQ6PSFvoDMmh3h1YH6+8RpOIROlzOc49+QXUNrZqh8RgOoT
         G7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXbs/+K4vGdXpclMxCSxmceDExChc1TvbtI/wNoAZgQqh/oNmrncZtXR8C6XFe/gmwVviIeIv7NPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxykkUCds9c6ubZAufzr1QutxEyhmJM0MshO8ZYrbpKsVUhzt6w
	+dW3w1Ga09ipqIH12aXWN+4JE9UvZ5Ife+AaefO3YpVVMcmR/4SR0bdofm4mFRA=
X-Google-Smtp-Source: AGHT+IFlSIRkRZTOFLNyPatfUw5Y174bZy9lMxma4FnpCObFSnO03fmX9lo7w0eBmJXtveDmWb0cnA==
X-Received: by 2002:a17:907:7f25:b0:a7a:b561:3564 with SMTP id a640c23a62f3a-a8691cb98f9mr188865766b.61.1724340504353;
        Thu, 22 Aug 2024 08:28:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	ulf.hansson@linaro.org
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 04/16] soc: renesas: Add SYSC driver for Renesas RZ/G3S
Date: Thu, 22 Aug 2024 18:27:49 +0300
Message-Id: <20240822152801.602318-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ/G3S SYS Controller has 2 registers (one for PCIE one for USB) that
need to be configured before/after powering off/on the PCI or USB
ares. The bits in these registers control signals to PCIE and USB that
need to be de-asserted/asserted after/before power on/off event. For this
add SYSC controller driver that registers a reset controller driver on
auxiliary bus which allows USB, PCIE drivers to control these signals.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Hi, Philipp, Ulf, Geert, all,

In this series the control of USB and PCIE signals was implemented
though a reset control driver. This approach was chosen as a result
of looking though the HW manual and trying to understand how these
signals behave. HW manual can be downloaded from [1] (download
manual hardware button -> confirm -> extract archive ->
Deliverables -> r01uh1014ej0110-rzg3s.pdf).

The description of the USB and PCIE control registers is as follows:

SYS_USB_PWRRDY Register (Signal is called PWRRDY), Chapter 6.3.83:

Controls PWRRDY terminal of USB:
0: PWRRDY
1: PWRRDY down
When turning off the USB region power, set this bit to 1.
When turning on the USB region power, set this bit to 0.

SYS_PCIE_RST_RSM_B (Signal is called RST_RSM_B), Chapter 6.3.84:

Controls RST_RSM_B terminal of PCIe
0: RST_RSM_B=0
1: RST_RSM_B=1
Set RST_RSM_B=1 after PCIe power is applied.
When the power in the PCIe region is turned off, set RST_RSM_B=0
before turning off the power supply.

From this description I understood that the control of the USB PWRRDY,
PCIE RST_RSM_B signals and the power control for the domains
the USB, PCI belongs are different things [A].

As of Figure 41.1 (Power Domain and Power Supply) and Table 41.1 (Power
Domain to which Power Supply Pins Belong) the USB and PCIE belongs to
PD_ISOVCC power domain controlled though PMIC [B].

The USB, PCI signals are also reference in HW manual in the low power
consumption chapter describing the transition to different power
modes. E.g., chapter 41.6.1 (ALL_ON to VBATT), Table 41.8 (Example
Transition Flow Outline from ALL_ON Mode to VBATT Mode) says at
steps 6 and 7:

6. USB PHY PWRRDY signal control (if using USB) SYS_USB_PWRRDY
7. PCIe RST_RSM_B signal control (if using PCIe) SYS_PCIE_RST_RSM_B

Meaning these signals need to be controlled before going to VBATT
power mode (where the power supply to USB is turned off) [C].

Due to [A], [B] and [C] I chosed to have the implementation of these
signals though a reset control driver.

Other option I explored was though power domains as follows:
1/ registering one domain for USB, one of PCIE
2/ passed the domain ID to USB though device tree
3/ attach from USB PHY control driver to the USB power domain
   with dev_pm_domain_attach_by_name()
4/ and controlling the SYSC registers with
   pm_runtime_resume_and_get(usb_sysc_domain).

Please let me know what do you think about this!

Thank you,
Claudiu Beznea


[1] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzg3s-general-purpose-microprocessors-single-core-arm-cortex-a55-11-ghz-cpu-and-dual-core-cortex-m33-250

 drivers/reset/Kconfig                        |   7 +
 drivers/reset/Makefile                       |   1 +
 drivers/reset/reset-rzg3s-sysc.c             | 140 +++++++++++++++++++
 drivers/soc/renesas/Makefile                 |   1 +
 drivers/soc/renesas/rzg3s-sysc.c             | 113 +++++++++++++++
 include/linux/soc/renesas/rzg3s-sysc-reset.h |  24 ++++
 6 files changed, 286 insertions(+)
 create mode 100644 drivers/reset/reset-rzg3s-sysc.c
 create mode 100644 drivers/soc/renesas/rzg3s-sysc.c
 create mode 100644 include/linux/soc/renesas/rzg3s-sysc-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 67bce340a87e..fbdf860b2293 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -218,6 +218,13 @@ config RESET_RZG2L_USBPHY_CTRL
 	  Support for USBPHY Control found on RZ/G2L family. It mainly
 	  controls reset and power down of the USB/PHY.
 
+config RESET_RZG3S_SYSC
+	tristate "Renesas RZ/G3S SYSC reset driver"
+	depends on ARCH_R9A08G045 || COMPILE_TEST
+	help
+	  Support for SYSC reset found on RZ/G3S family. It mainly
+	  controls reset on USB and PCIE.
+
 config RESET_SCMI
 	tristate "Reset driver controlled via ARM SCMI interface"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 27b0bbdfcc04..ee5ca21acc44 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
+obj-$(CONFIG_RESET_RZG3S_SYSC) += reset-rzg3s-sysc.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
diff --git a/drivers/reset/reset-rzg3s-sysc.c b/drivers/reset/reset-rzg3s-sysc.c
new file mode 100644
index 000000000000..56af03f1d8a2
--- /dev/null
+++ b/drivers/reset/reset-rzg3s-sysc.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3S SYSC reset driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/soc/renesas/rzg3s-sysc-reset.h>
+
+#include <dt-bindings/reset/renesas,r9a08g045-sysc.h>
+
+#define RZG3S_SYSC_USB_PWRRDY		0xd70
+#define RZG3S_SYSC_PCIE_RST_RSM_B	0xd74
+#define RZG3S_SYSC_RESET_MASK		0x1
+
+/**
+ * struct rzg3s_sysc_reset_info - SYSC reset information
+ * @offset: offset to configure the reset
+ * @assert_val: value to write to register on assert
+ * @deassert_val: value to write to register on de-assert
+ */
+struct rzg3s_sysc_reset_info {
+	u16 offset;
+	u8 assert_val;
+	u8 deassert_val;
+};
+
+/**
+ * struct rzg3s_sysc_reset - SYSC reset
+ * @info: SYSC reset information
+ * @radev: SYSC reset auxiliary device
+ * @rcdev: reset controller device
+ */
+struct rzg3s_sysc_reset {
+	const struct rzg3s_sysc_reset_info *info;
+	struct rzg3s_sysc_reset_adev *radev;
+	struct reset_controller_dev rcdev;
+};
+
+#define to_rzg3s_sysc_reset(r)	container_of(r, struct rzg3s_sysc_reset, rcdev)
+
+static int rzg3s_sysc_reset_set(struct reset_controller_dev *rcdev,
+				unsigned long id, bool assert)
+{
+	struct rzg3s_sysc_reset *reset = to_rzg3s_sysc_reset(rcdev);
+	struct rzg3s_sysc_reset_adev *radev = reset->radev;
+	struct rzg3s_sysc_reset_info info = reset->info[id];
+	unsigned long flags;
+	u32 tmp;
+
+	spin_lock_irqsave(radev->lock, flags);
+	tmp = readl(radev->base + info.offset);
+	tmp &= ~RZG3S_SYSC_RESET_MASK;
+	tmp |= assert ? info.assert_val : info.deassert_val;
+	writel(tmp, radev->base + info.offset);
+	spin_unlock_irqrestore(radev->lock, flags);
+
+	return 0;
+}
+
+static int rzg3s_sysc_reset_assert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
+{
+	return rzg3s_sysc_reset_set(rcdev, id, true);
+}
+
+static int rzg3s_sysc_reset_deassert(struct reset_controller_dev *rcdev,
+				     unsigned long id)
+{
+	return rzg3s_sysc_reset_set(rcdev, id, false);
+}
+
+static int rzg3s_sysc_reset_status(struct reset_controller_dev *rcdev,
+				   unsigned long id)
+{
+	struct rzg3s_sysc_reset *reset = to_rzg3s_sysc_reset(rcdev);
+	const struct rzg3s_sysc_reset_info info = reset->info[id];
+	struct rzg3s_sysc_reset_adev *radev = reset->radev;
+	u32 tmp;
+
+	tmp = readl(radev->base + info.offset);
+	tmp = !!(tmp & RZG3S_SYSC_RESET_MASK);
+
+	return info.assert_val ? tmp : !tmp;
+}
+
+static const struct reset_control_ops rzg3s_sysc_reset_ops = {
+	.assert = rzg3s_sysc_reset_assert,
+	.deassert = rzg3s_sysc_reset_deassert,
+	.status = rzg3s_sysc_reset_status,
+};
+
+static const struct rzg3s_sysc_reset_info rzg3s_sysc_reset_info[] = {
+	[R9A08G045_SYSC_RESET_USB] = {
+		.offset = RZG3S_SYSC_USB_PWRRDY, .assert_val = 1, .deassert_val = 0
+	},
+	[R9A08G045_SYSC_RESET_PCIE] = {
+		.offset = RZG3S_SYSC_PCIE_RST_RSM_B, .assert_val = 0, .deassert_val = 1
+	},
+};
+
+static int rzg3s_sysc_reset_probe(struct auxiliary_device *adev,
+				  const struct auxiliary_device_id *id)
+{
+	struct rzg3s_sysc_reset_adev *reset_adev = to_rzg3s_sysc_reset_adev(adev);
+	struct device *dev = &adev->dev;
+	struct rzg3s_sysc_reset *reset;
+
+	reset = devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->radev = reset_adev;
+	reset->info = rzg3s_sysc_reset_info;
+
+	reset->rcdev.ops = &rzg3s_sysc_reset_ops;
+	reset->rcdev.of_reset_n_cells = 1;
+	reset->rcdev.nr_resets = ARRAY_SIZE(rzg3s_sysc_reset_info);
+	reset->rcdev.of_node = dev->parent->of_node;
+	reset->rcdev.dev = dev;
+
+	return devm_reset_controller_register(dev, &reset->rcdev);
+}
+
+static const struct auxiliary_device_id rzg3s_sysc_reset_ids[] = {
+	{ .name = "rzg3s_sysc.reset" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, rzg3s_sysc_reset_ids);
+
+static struct auxiliary_driver rzg3s_sysc_reset_driver = {
+	.probe		= rzg3s_sysc_reset_probe,
+	.id_table	= rzg3s_sysc_reset_ids,
+};
+module_auxiliary_driver(rzg3s_sysc_reset_driver);
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 734f8f8cefa4..74c72ac46f91 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SOC_RENESAS)	+= renesas-soc.o
 ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
+obj-$(CONFIG_ARCH_R9A08G045)	+= rzg3s-sysc.o
 
 # Family
 obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
diff --git a/drivers/soc/renesas/rzg3s-sysc.c b/drivers/soc/renesas/rzg3s-sysc.c
new file mode 100644
index 000000000000..e664d29ce5c3
--- /dev/null
+++ b/drivers/soc/renesas/rzg3s-sysc.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3S System controller driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/platform_device.h>
+
+#include <linux/soc/renesas/rzg3s-sysc-reset.h>
+
+/**
+ * struct rzg3s_sysc - SYSC private data structure
+ * @base: base address
+ * @dev: device
+ * @lock: lock
+ */
+struct rzg3s_sysc {
+	void __iomem *base;
+	struct device *dev;
+	spinlock_t lock;
+};
+
+static void rzg3s_sysc_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct rzg3s_sysc_reset_adev *reset_adev = to_rzg3s_sysc_reset_adev(adev);
+
+	kfree(reset_adev);
+}
+
+static void rzg3s_sysc_reset_unregister_adev(void *adev)
+{
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int rzg3s_sysc_reset_probe(struct rzg3s_sysc *sysc, const char *adev_name,
+				  u32 adev_id)
+{
+	struct rzg3s_sysc_reset_adev *radev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	radev = kzalloc(sizeof(*radev), GFP_KERNEL);
+	if (!radev)
+		return -ENOMEM;
+
+	radev->base = sysc->base;
+	radev->lock = &sysc->lock;
+
+	adev = &radev->adev;
+	adev->name = adev_name;
+	adev->dev.parent = sysc->dev;
+	adev->dev.release = rzg3s_sysc_reset_adev_release;
+	adev->id = adev_id;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(sysc->dev, rzg3s_sysc_reset_unregister_adev, adev);
+}
+
+static int rzg3s_sysc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rzg3s_sysc *sysc;
+
+	sysc = devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
+	if (!sysc)
+		return -ENOMEM;
+
+	sysc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sysc->base))
+		return PTR_ERR(sysc->base);
+
+	sysc->dev = dev;
+	spin_lock_init(&sysc->lock);
+
+	return rzg3s_sysc_reset_probe(sysc, "reset", 0);
+}
+
+static const struct of_device_id rzg3s_sysc_match[] = {
+	{ .compatible = "renesas,r9a08g045-sysc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rzg3s_sysc_match);
+
+static struct platform_driver rzg3s_sysc_driver = {
+	.driver = {
+		.name = "renesas-rzg3s-sysc",
+		.of_match_table = rzg3s_sysc_match
+	},
+	.probe = rzg3s_sysc_probe
+};
+
+static int __init rzg3s_sysc_init(void)
+{
+	return platform_driver_register(&rzg3s_sysc_driver);
+}
+subsys_initcall(rzg3s_sysc_init);
+
+MODULE_DESCRIPTION("Renesas RZ/G3S System Controller Driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/renesas/rzg3s-sysc-reset.h b/include/linux/soc/renesas/rzg3s-sysc-reset.h
new file mode 100644
index 000000000000..813cbe82a68a
--- /dev/null
+++ b/include/linux/soc/renesas/rzg3s-sysc-reset.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SOC_RENESAS_SYSC_RESET_RZG3S_H
+#define __SOC_RENESAS_SYSC_RESET_RZG3S_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/spinlock_types.h>
+#include <linux/container_of.h>
+
+/**
+ * struct rzg3s_sysc_reset_adev - SYSC reset auxiliary device
+ * @base: base address
+ * @lock: lock
+ * @adev: auxiliary device
+ */
+struct rzg3s_sysc_reset_adev {
+	void __iomem *base;
+	spinlock_t *lock;
+	struct auxiliary_device adev;
+};
+
+#define to_rzg3s_sysc_reset_adev(a)	container_of(a, struct rzg3s_sysc_reset_adev, adev)
+
+#endif
-- 
2.39.2


