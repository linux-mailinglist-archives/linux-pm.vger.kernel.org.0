Return-Path: <linux-pm+bounces-37978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19109C59ABA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2C454E62C4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980BA31A7FE;
	Thu, 13 Nov 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YkNpc+IS"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDC315D44;
	Thu, 13 Nov 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060822; cv=none; b=LZvancoVoOpn/uaZAHwKtXDXylHt478OaHA6OvR29KtovAsMyTsUCR+kqI1trYGAimtIbc4Ce1dsfVHkj5vh065NJpSXcpdcCP7ih2cTo8P7S+CxGMe698PReNdaM9DZ1zR+K2NJc33+/pc8iIak21iH//P0Hk/9k9NIpnSgX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060822; c=relaxed/simple;
	bh=SpIdSb31KB8gZ86Fb3llMRwCTikHg2PXz/Esd/uLdtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1ceS/cA7Ck3ktEH8R+qQ3+5HJJ732EdvjTotuUFytg3i3QzT0ZedEkb31QyXCIXm+8xRPJY0YIvb9c8PakMvTC7W3pSKi1JVLxXrAR7oGEZ78czxbWBYcNCuY4D+jiV3xgVySdXj1GNE3rkpqv9xdmFFjDdPqk7hM7DMSa95Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YkNpc+IS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 860AC2657E;
	Thu, 13 Nov 2025 20:06:58 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTfkuvGQPuTq; Thu, 13 Nov 2025 20:06:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060816; bh=SpIdSb31KB8gZ86Fb3llMRwCTikHg2PXz/Esd/uLdtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YkNpc+ISmXg/A0bI0lFck2w7aqK8QuRFVa5FW8btlixBKhY/A/2ghK4vQgPfXHscj
	 anrpwHoQk3ReR3ybfjHUPM/0/HaKu6wehmDN2h2w53KPaKOBIQ7lJPR+Ln20sBGBXq
	 nAewewfN7IjGKWKmgQFnt9n/j5oHs5qK8w/KOQAoQNN9jQoJWDp7gDUqcJQixU8NdB
	 1qB7NYgZtHieWFb4gHdDCUoI+t/H8pcVmqmuJnWakVs+rWoiAVjOV8kMtpw9orhfJs
	 Qg/EJTpbAJCIuslaeplphuaucT1m5rtDtz1mNzuTpxy0fAU2GiW7WCBkxqAvD2Z42T
	 PZla6lT2usYEw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:08 +0530
Subject: [PATCH 07/13] mfd: sec: add support for S2MU005 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-7-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=22904;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=SpIdSb31KB8gZ86Fb3llMRwCTikHg2PXz/Esd/uLdtQ=;
 b=SfJ+QKZIfkcg6H/vxisR0Mmu4cNyxsEJWO8JzxxChR+aYOiMGI8KUOVlE/DEXZkrMcWDRguTh
 /upxrd+Nm7+Das5DKg4soNjYyVDcs00oE4ZcflUogQc3YeeyuaBz1Xh
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Micro
USB Interface Controller), and flash and RGB LED controllers.

S2MU005's interrupt registers can be properly divided into three regmap
IRQ chips, one each for the charger, flash LEDs, and the MUIC.

Add initial support for S2MU005 in the PMIC driver, along with it's three
interrupt chips.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-common.c            |  11 ++
 drivers/mfd/sec-i2c.c               |  29 ++++
 drivers/mfd/sec-irq.c               |  71 ++++++++
 include/linux/mfd/samsung/core.h    |   3 +-
 include/linux/mfd/samsung/irq.h     |  80 +++++++++
 include/linux/mfd/samsung/s2mu005.h | 328 ++++++++++++++++++++++++++++++++++++
 6 files changed, 521 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 42d55e70e34c..4c5f4dc2905b 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -79,6 +79,13 @@ static const struct mfd_cell s2mpu05_devs[] = {
 	MFD_CELL_NAME("s2mps15-rtc"),
 };
 
+static const struct mfd_cell s2mu005_devs[] = {
+	MFD_CELL_OF("s2mu005-charger", NULL, NULL, 0, 0, "samsung,s2mu005-charger"),
+	MFD_CELL_OF("s2mu005-flash", NULL, NULL, 0, 0, "samsung,s2mu005-flash"),
+	MFD_CELL_OF("s2mu005-muic", NULL, NULL, 0, 0, "samsung,s2mu005-muic"),
+	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb"),
+};
+
 static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
 {
 	unsigned int val;
@@ -214,6 +221,10 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 		sec_devs = s2mpu05_devs;
 		num_sec_devs = ARRAY_SIZE(s2mpu05_devs);
 		break;
+	case S2MU005:
+		sec_devs = s2mu005_devs;
+		num_sec_devs = ARRAY_SIZE(s2mu005_devs);
+		break;
 	default:
 		return dev_err_probe(sec_pmic->dev, -EINVAL,
 				     "Unsupported device type %d\n",
diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index 3132b849b4bc..bc5ad8b1c432 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/samsung/s2mps14.h>
 #include <linux/mfd/samsung/s2mps15.h>
 #include <linux/mfd/samsung/s2mpu02.h>
+#include <linux/mfd/samsung/s2mu005.h>
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -66,6 +67,19 @@ static bool s2mpu02_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool s2mu005_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case S2MU005_REG_CHGR_INT1M:
+	case S2MU005_REG_FLED_INT1M:
+	case S2MU005_REG_MUIC_INT1M:
+	case S2MU005_REG_MUIC_INT2M:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static const struct regmap_config s2dos05_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -130,6 +144,15 @@ static const struct regmap_config s2mpu05_regmap_config = {
 	.val_bits = 8,
 };
 
+static const struct regmap_config s2mu005_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = S2MU005_REG_MUIC_LDOADC_H,
+	.volatile_reg = s2mu005_volatile,
+	.cache_type = REGCACHE_FLAT,
+};
+
 static const struct regmap_config s5m8767_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -203,6 +226,11 @@ static const struct sec_pmic_i2c_platform_data s2mpu05_data = {
 	.device_type = S2MPU05,
 };
 
+static const struct sec_pmic_i2c_platform_data s2mu005_data = {
+	.regmap_cfg = &s2mu005_regmap_config,
+	.device_type = S2MU005,
+};
+
 static const struct sec_pmic_i2c_platform_data s5m8767_data = {
 	.regmap_cfg = &s5m8767_regmap_config,
 	.device_type = S5M8767X,
@@ -217,6 +245,7 @@ static const struct of_device_id sec_pmic_i2c_of_match[] = {
 	{ .compatible = "samsung,s2mps15-pmic", .data = &s2mps15_data, },
 	{ .compatible = "samsung,s2mpu02-pmic", .data = &s2mpu02_data, },
 	{ .compatible = "samsung,s2mpu05-pmic", .data = &s2mpu05_data, },
+	{ .compatible = "samsung,s2mu005-pmic", .data = &s2mu005_data, },
 	{ .compatible = "samsung,s5m8767-pmic", .data = &s5m8767_data, },
 	{ },
 };
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index 053c28f31ec9..fc82893fe6b7 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -15,6 +15,7 @@
 #include <linux/mfd/samsung/s2mps14.h>
 #include <linux/mfd/samsung/s2mpu02.h>
 #include <linux/mfd/samsung/s2mpu05.h>
+#include <linux/mfd/samsung/s2mu005.h>
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/regmap.h>
 #include "sec-core.h"
@@ -158,6 +159,42 @@ static const struct regmap_irq s2mpu05_irqs[] = {
 	REGMAP_IRQ_REG(S2MPU05_IRQ_TSD, 2, S2MPU05_IRQ_TSD_MASK),
 };
 
+static const struct regmap_irq s2mu005_chgr_irqs[] = {
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_DETBAT, 0, S2MU005_CHGR_IRQ_DETBAT_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_BAT, 0, S2MU005_CHGR_IRQ_BAT_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_IVR, 0, S2MU005_CHGR_IRQ_IVR_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_EVENT, 0, S2MU005_CHGR_IRQ_EVENT_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_CHG, 0, S2MU005_CHGR_IRQ_CHG_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_VMID, 0, S2MU005_CHGR_IRQ_VMID_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_WCIN, 0, S2MU005_CHGR_IRQ_WCIN_MASK),
+	REGMAP_IRQ_REG(S2MU005_CHGR_IRQ_VBUS, 0, S2MU005_CHGR_IRQ_VBUS_MASK),
+};
+
+static const struct regmap_irq s2mu005_fled_irqs[] = {
+	REGMAP_IRQ_REG(S2MU005_FLED_IRQ_LBPROT, 0, S2MU005_FLED_IRQ_LBPROT_MASK),
+	REGMAP_IRQ_REG(S2MU005_FLED_IRQ_OPENCH2, 0, S2MU005_FLED_IRQ_OPENCH2_MASK),
+	REGMAP_IRQ_REG(S2MU005_FLED_IRQ_OPENCH1, 0, S2MU005_FLED_IRQ_OPENCH1_MASK),
+	REGMAP_IRQ_REG(S2MU005_FLED_IRQ_SHORTCH2, 0, S2MU005_FLED_IRQ_SHORTCH2_MASK),
+	REGMAP_IRQ_REG(S2MU005_FLED_IRQ_SHORTCH1, 0, S2MU005_FLED_IRQ_SHORTCH1_MASK),
+};
+
+static const struct regmap_irq s2mu005_muic_irqs[] = {
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_ATTACH, 0, S2MU005_MUIC_IRQ_ATTACH_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_DETACH, 0, S2MU005_MUIC_IRQ_DETACH_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_KP, 0, S2MU005_MUIC_IRQ_KP_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_LKP, 0, S2MU005_MUIC_IRQ_LKP_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_LKR, 0, S2MU005_MUIC_IRQ_LKR_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_RIDCHG, 0, S2MU005_MUIC_IRQ_RIDCHG_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_VBUSON, 1, S2MU005_MUIC_IRQ_VBUSON_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_RSVD, 1, S2MU005_MUIC_IRQ_RSVD_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_ADC, 1, S2MU005_MUIC_IRQ_ADC_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_STUCK, 1, S2MU005_MUIC_IRQ_STUCK_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_STUCKRCV, 1, S2MU005_MUIC_IRQ_STUCKRCV_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_MHDL, 1, S2MU005_MUIC_IRQ_MHDL_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_AVCHG, 1, S2MU005_MUIC_IRQ_AVCHG_MASK),
+	REGMAP_IRQ_REG(S2MU005_MUIC_IRQ_VBUSOFF, 1, S2MU005_MUIC_IRQ_VBUSOFF_MASK),
+};
+
 static const struct regmap_irq s5m8767_irqs[] = {
 	REGMAP_IRQ_REG(S5M8767_IRQ_PWRR, 0, S5M8767_IRQ_PWRR_MASK),
 	REGMAP_IRQ_REG(S5M8767_IRQ_PWRF, 0, S5M8767_IRQ_PWRF_MASK),
@@ -259,6 +296,36 @@ static const struct regmap_irq_chip s2mpu05_irq_chip[] = {
 	},
 };
 
+static const struct regmap_irq_chip s2mu005_irq_chip[] = {
+	[S2MU005_CHGR_IRQ_CHIP] = {
+		.name = "s2mu005-chgr",
+		.irqs = s2mu005_chgr_irqs,
+		.num_irqs = ARRAY_SIZE(s2mu005_chgr_irqs),
+		.num_regs = 1,
+		.status_base = S2MU005_REG_CHGR_INT1,
+		.mask_base = S2MU005_REG_CHGR_INT1M,
+		.ack_base = S2MU005_REG_CHGR_INT1,
+	},
+	[S2MU005_FLED_IRQ_CHIP] = {
+		.name = "s2mu005-fled",
+		.irqs = s2mu005_fled_irqs,
+		.num_irqs = ARRAY_SIZE(s2mu005_fled_irqs),
+		.num_regs = 1,
+		.status_base = S2MU005_REG_FLED_INT1,
+		.mask_base = S2MU005_REG_FLED_INT1M,
+		.ack_base = S2MU005_REG_FLED_INT1,
+	},
+	[S2MU005_MUIC_IRQ_CHIP] = {
+		.name = "s2mu005-muic",
+		.irqs = s2mu005_muic_irqs,
+		.num_irqs = ARRAY_SIZE(s2mu005_muic_irqs),
+		.num_regs = 2,
+		.status_base = S2MU005_REG_MUIC_INT1,
+		.mask_base = S2MU005_REG_MUIC_INT1M,
+		.ack_base = S2MU005_REG_MUIC_INT1,
+	},
+};
+
 static const struct regmap_irq_chip s5m8767_irq_chip[] = {
 	[S5M8767_IRQ_CHIP] = {
 		.name = "s5m8767",
@@ -315,6 +382,10 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 		sec_irq_chip = s2mpu05_irq_chip;
 		sec_irq_chip_num = ARRAY_SIZE(s2mpu05_irq_chip);
 		break;
+	case S2MU005:
+		sec_irq_chip = s2mu005_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mu005_irq_chip);
+		break;
 	default:
 		return dev_err_probe(sec_pmic->dev, -EINVAL,
 				     "Unsupported device type %d\n",
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index dcd741c4f0d6..fc07f7944dcd 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -34,7 +34,7 @@
 #define STEP_6_25_MV		6250
 
 /* Maximum number of IRQ chips in a PMIC */
-#define MAX_IRQ_CHIPS		1
+#define MAX_IRQ_CHIPS		3
 
 struct gpio_desc;
 
@@ -49,6 +49,7 @@ enum sec_device_type {
 	S2MPS15X,
 	S2MPU02,
 	S2MPU05,
+	S2MU005,
 };
 
 /**
diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
index 78eb894e350e..b3a51b74aa59 100644
--- a/include/linux/mfd/samsung/irq.h
+++ b/include/linux/mfd/samsung/irq.h
@@ -309,6 +309,86 @@ enum s2mpu05_irq {
 #define S2MPU05_IRQ_INT140C_MASK	BIT(1)
 #define S2MPU05_IRQ_TSD_MASK		BIT(2)
 
+enum s2mu005_chgr_irq {
+	S2MU005_CHGR_IRQ_DETBAT,
+	S2MU005_CHGR_IRQ_BAT,
+	S2MU005_CHGR_IRQ_IVR,
+	S2MU005_CHGR_IRQ_EVENT,
+	S2MU005_CHGR_IRQ_CHG,
+	S2MU005_CHGR_IRQ_VMID,
+	S2MU005_CHGR_IRQ_WCIN,
+	S2MU005_CHGR_IRQ_VBUS,
+
+	S2MU005_CHGR_IRQ_NR,
+};
+
+#define S2MU005_CHGR_IRQ_CHIP		0
+
+#define S2MU005_CHGR_IRQ_DETBAT_MASK	BIT(0)
+#define S2MU005_CHGR_IRQ_BAT_MASK	BIT(1)
+#define S2MU005_CHGR_IRQ_IVR_MASK	BIT(2)
+#define S2MU005_CHGR_IRQ_EVENT_MASK	BIT(3)
+#define S2MU005_CHGR_IRQ_CHG_MASK	BIT(4)
+#define S2MU005_CHGR_IRQ_VMID_MASK	BIT(5)
+#define S2MU005_CHGR_IRQ_WCIN_MASK	BIT(6)
+#define S2MU005_CHGR_IRQ_VBUS_MASK	BIT(7)
+
+enum s2mu005_fled_irq {
+	S2MU005_FLED_IRQ_LBPROT,
+	S2MU005_FLED_IRQ_OPENCH2,
+	S2MU005_FLED_IRQ_OPENCH1,
+	S2MU005_FLED_IRQ_SHORTCH2,
+	S2MU005_FLED_IRQ_SHORTCH1,
+
+	S2MU005_FLED_IRQ_NR,
+};
+
+#define S2MU005_FLED_IRQ_CHIP			1
+
+#define S2MU005_FLED_IRQ_LBPROT_MASK		BIT(2)
+#define S2MU005_FLED_IRQ_OPENCH2_MASK		BIT(4)
+#define S2MU005_FLED_IRQ_OPENCH1_MASK		BIT(5)
+#define S2MU005_FLED_IRQ_SHORTCH2_MASK		BIT(6)
+#define S2MU005_FLED_IRQ_SHORTCH1_MASK		BIT(7)
+
+enum s2mu005_muic_irq {
+	S2MU005_MUIC_IRQ_ATTACH,
+	S2MU005_MUIC_IRQ_DETACH,
+	S2MU005_MUIC_IRQ_KP,
+	S2MU005_MUIC_IRQ_LKP,
+	S2MU005_MUIC_IRQ_LKR,
+	S2MU005_MUIC_IRQ_RIDCHG,
+
+	S2MU005_MUIC_IRQ_VBUSON,
+	S2MU005_MUIC_IRQ_RSVD,
+	S2MU005_MUIC_IRQ_ADC,
+	S2MU005_MUIC_IRQ_STUCK,
+	S2MU005_MUIC_IRQ_STUCKRCV,
+	S2MU005_MUIC_IRQ_MHDL,
+	S2MU005_MUIC_IRQ_AVCHG,
+	S2MU005_MUIC_IRQ_VBUSOFF,
+
+	S2MU005_IRQ_NR,
+};
+
+#define S2MU005_MUIC_IRQ_CHIP			2
+
+#define S2MU005_MUIC_IRQ_ATTACH_MASK		BIT(0)
+#define S2MU005_MUIC_IRQ_DETACH_MASK		BIT(1)
+#define S2MU005_MUIC_IRQ_KP_MASK		BIT(2)
+#define S2MU005_MUIC_IRQ_LKP_MASK		BIT(3)
+#define S2MU005_MUIC_IRQ_LKR_MASK		BIT(4)
+#define S2MU005_MUIC_IRQ_RIDCHG_MASK		BIT(5)
+
+#define S2MU005_MUIC_IRQ_VBUSON_MASK		BIT(0)
+#define S2MU005_MUIC_IRQ_RSVD_MASK		BIT(1)
+#define S2MU005_MUIC_IRQ_ADC_MASK		BIT(2)
+#define S2MU005_MUIC_IRQ_STUCK_MASK		BIT(3)
+#define S2MU005_MUIC_IRQ_STUCKRCV_MASK		BIT(4)
+#define S2MU005_MUIC_IRQ_MHDL_MASK		BIT(5)
+#define S2MU005_MUIC_IRQ_AVCHG_MASK		BIT(6)
+#define S2MU005_MUIC_IRQ_VBUSOFF_MASK		BIT(7)
+
 enum s5m8767_irq {
 	S5M8767_IRQ_PWRR,
 	S5M8767_IRQ_PWRF,
diff --git a/include/linux/mfd/samsung/s2mu005.h b/include/linux/mfd/samsung/s2mu005.h
new file mode 100644
index 000000000000..32ad35dda661
--- /dev/null
+++ b/include/linux/mfd/samsung/s2mu005.h
@@ -0,0 +1,328 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#ifndef __LINUX_MFD_S2MU005_H
+#define __LINUX_MFD_S2MU005_H
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
+/* S2MU005 registers */
+enum s2mu005_reg {
+	S2MU005_REG_CHGR_INT1,
+	S2MU005_REG_CHGR_INT1M,
+
+	S2MU005_REG_FLED_INT1,
+	S2MU005_REG_FLED_INT1M,
+
+	S2MU005_REG_MUIC_INT1,
+	S2MU005_REG_MUIC_INT2,
+	S2MU005_REG_MUIC_INT1M,
+	S2MU005_REG_MUIC_INT2M,
+
+	S2MU005_REG_CHGR_STATUS0,
+	S2MU005_REG_CHGR_STATUS1,
+	S2MU005_REG_CHGR_STATUS2,
+	S2MU005_REG_CHGR_STATUS3,
+	S2MU005_REG_CHGR_STATUS4,
+	S2MU005_REG_CHGR_STATUS5,
+	S2MU005_REG_CHGR_CTRL0,
+	S2MU005_REG_CHGR_CTRL1,
+	S2MU005_REG_CHGR_CTRL2,
+	S2MU005_REG_CHGR_CTRL3,
+	S2MU005_REG_CHGR_CTRL4,
+	S2MU005_REG_CHGR_CTRL5,
+	S2MU005_REG_CHGR_CTRL6,
+	S2MU005_REG_CHGR_CTRL7,
+	S2MU005_REG_CHGR_CTRL8,
+	S2MU005_REG_CHGR_CTRL9,
+	S2MU005_REG_CHGR_CTRL10,
+	S2MU005_REG_CHGR_CTRL11,
+	S2MU005_REG_CHGR_CTRL12,
+	S2MU005_REG_CHGR_CTRL13,
+	S2MU005_REG_CHGR_CTRL14,
+	S2MU005_REG_CHGR_CTRL15,
+	S2MU005_REG_CHGR_CTRL16,
+	S2MU005_REG_CHGR_CTRL17,
+	S2MU005_REG_CHGR_CTRL18,
+	S2MU005_REG_CHGR_CTRL19,
+	S2MU005_REG_CHGR_TEST0,
+	S2MU005_REG_CHGR_TEST1,
+	S2MU005_REG_CHGR_TEST2,
+	S2MU005_REG_CHGR_TEST3,
+	S2MU005_REG_CHGR_TEST4,
+	S2MU005_REG_CHGR_TEST5,
+	S2MU005_REG_CHGR_TEST6,
+	S2MU005_REG_CHGR_TEST7,
+	S2MU005_REG_CHGR_TEST8,
+	S2MU005_REG_CHGR_TEST9,
+	S2MU005_REG_CHGR_TEST10,
+
+	S2MU005_REG_FLED_STATUS,
+	S2MU005_REG_FLED_CH0_CTRL0,
+	S2MU005_REG_FLED_CH0_CTRL1,
+	S2MU005_REG_FLED_CH0_CTRL2,
+	S2MU005_REG_FLED_CH0_CTRL3,
+	S2MU005_REG_FLED_CH1_CTRL0,
+	S2MU005_REG_FLED_CH1_CTRL1,
+	S2MU005_REG_FLED_CH1_CTRL2,
+	S2MU005_REG_FLED_CH1_CTRL3,
+	S2MU005_REG_FLED_CTRL0,
+	S2MU005_REG_FLED_CTRL1,
+	S2MU005_REG_FLED_CTRL2,
+	S2MU005_REG_FLED_CTRL3,
+	S2MU005_REG_FLED_CTRL4,
+	S2MU005_REG_FLED_CTRL5,
+	S2MU005_REG_FLED_CTRL6,
+
+	S2MU005_REG_RGB_EN,
+	S2MU005_REG_RGB_CH0_CTRL,
+	S2MU005_REG_RGB_CH1_CTRL,
+	S2MU005_REG_RGB_CH2_CTRL,
+	S2MU005_REG_RGB_CH0_RAMP,
+	S2MU005_REG_RGB_CH0_STAY,
+	S2MU005_REG_RGB_CH1_RAMP,
+	S2MU005_REG_RGB_CH1_STAY,
+	S2MU005_REG_RGB_CH2_RAMP,
+	S2MU005_REG_RGB_CH2_STAY,
+	S2MU005_REG_RGB_TEST0,
+	S2MU005_REG_RGB_CTRL0,
+
+	S2MU005_REG_MUIC_ADC,
+	S2MU005_REG_MUIC_DEV1,
+	S2MU005_REG_MUIC_DEV2,
+	S2MU005_REG_MUIC_DEV3,
+	S2MU005_REG_MUIC_BUTTON1,
+	S2MU005_REG_MUIC_BUTTON2,
+	S2MU005_REG_MUIC_RESET,
+	S2MU005_REG_MUIC_CHGTYPE,
+	S2MU005_REG_MUIC_DEVAPPLE,
+	S2MU005_REG_MUIC_BCDRESCAN,
+	S2MU005_REG_MUIC_TEST1,
+	S2MU005_REG_MUIC_TEST2,
+	S2MU005_REG_MUIC_TEST3,
+
+	S2MU005_REG_ID = 0x73,
+
+	S2MU005_REG_MUIC_CTRL1 = 0xb2,
+	S2MU005_REG_MUIC_TIMERSET1,
+	S2MU005_REG_MUIC_TIMERSET2,
+	S2MU005_REG_MUIC_SWCTRL,
+	S2MU005_REG_MUIC_TIMERSET3,
+	S2MU005_REG_MUIC_CTRL2,
+	S2MU005_REG_MUIC_CTRL3,
+
+	S2MU005_REG_MUIC_LDOADC_L = 0xbf,
+	S2MU005_REG_MUIC_LDOADC_H,
+};
+
+#define S2MU005_REG_FLED_CH_CTRL0(x)	(S2MU005_REG_FLED_CH0_CTRL0 + 4 * (x))
+#define S2MU005_REG_FLED_CH_CTRL1(x)	(S2MU005_REG_FLED_CH0_CTRL1 + 4 * (x))
+#define S2MU005_REG_FLED_CH_CTRL2(x)	(S2MU005_REG_FLED_CH0_CTRL2 + 4 * (x))
+#define S2MU005_REG_FLED_CH_CTRL3(x)	(S2MU005_REG_FLED_CH0_CTRL3 + 4 * (x))
+
+#define S2MU005_REG_RGB_CH_CTRL(x)	(S2MU005_REG_RGB_CH0_CTRL + 1 * (x))
+#define S2MU005_REG_RGB_CH_RAMP(x)	(S2MU005_REG_RGB_CH0_RAMP + 2 * (x))
+#define S2MU005_REG_RGB_CH_STAY(x)	(S2MU005_REG_RGB_CH0_STAY + 2 * (x))
+
+/* S2MU005_REG_CHGR_STATUS0 */
+#define S2MU005_CHGR_VBUS		BIT(7)
+#define S2MU005_CHGR_WCIN		BIT(6)
+#define S2MU005_CHGR_VMID		BIT(5)
+#define S2MU005_CHGR_CHG		BIT(4)
+#define S2MU005_CHGR_STAT		GENMASK(3, 0)
+
+#define S2MU005_CHGR_STAT_DONE		FIELD_PREP(S2MU005_CHGR_STAT, 8)
+#define S2MU005_CHGR_STAT_TOPOFF	FIELD_PREP(S2MU005_CHGR_STAT, 7)
+#define S2MU005_CHGR_STAT_DONE_FLAG	FIELD_PREP(S2MU005_CHGR_STAT, 6)
+#define S2MU005_CHGR_STAT_CV		FIELD_PREP(S2MU005_CHGR_STAT, 5)
+#define S2MU005_CHGR_STAT_CC		FIELD_PREP(S2MU005_CHGR_STAT, 4)
+#define	S2MU005_CHGR_STAT_COOL_CHG	FIELD_PREP(S2MU005_CHGR_STAT, 3)
+#define S2MU005_CHGR_STAT_PRE_CHG	FIELD_PREP(S2MU005_CHGR_STAT, 2)
+
+/* S2MU005_REG_CHGR_STATUS1 */
+#define S2MU005_CHGR_DETBAT		BIT(7)
+#define S2MU005_CHGR_VBUSOVP		GENMASK(6, 4)
+
+#define S2MU005_CHGR_VBUS_OVP_OVERVOLT	FIELD_PREP(S2MU005_CHGR_OVP, 2)
+
+/* S2MU005_REG_CHGR_STATUS2 */
+#define S2MU005_CHGR_BAT		GENMASK(6, 4)
+
+#define	S2MU005_CHGR_BAT_VOLT_DET	FIELD_PREP(S2MU005_CHGR_BAT, 7)
+#define S2MU005_CHGR_BAT_FAST_CHG_DET	FIELD_PREP(S2MU005_CHGR_BAT, 6)
+#define	S2MU005_CHGR_BAT_COOL_CHG_DET	FIELD_PREP(S2MU005_CHGR_BAT, 5)
+#define S2MU005_CHGR_BAT_LOW_CHG	FIELD_PREP(S2MU005_CHGR_BAT, 2)
+#define S2MU005_CHGR_BAT_SELF_DISCHG	FIELD_PREP(S2MU005_CHGR_BAT, 1)
+#define S2MU005_CHGR_BAT_OVP_DET	FIELD_PREP(S2MU005_CHGR_BAT, 0)
+
+/* S2MU005_REG_CHGR_STATUS3 */
+#define S2MU005_CHGR_EVT		GENMASK(3, 0)
+
+#define S2MU005_CHGR_EVT_WDT_RST	FIELD_PREP(S2MU005_CHGR_EVT, 6)
+#define S2MU005_CHGR_EVT_WDT_SUSP	FIELD_PREP(S2MU005_CHGR_EVT, 5)
+#define S2MU005_CHGR_EVT_VSYS_VUVLO	FIELD_PREP(S2MU005_CHGR_EVT, 4)
+#define S2MU005_CHGR_EVT_VSYS_VOVP	FIELD_PREP(S2MU005_CHGR_EVT, 3)
+#define S2MU005_CHGR_EVT_THERM_FOLDBACK	FIELD_PREP(S2MU005_CHGR_EVT, 2)
+#define S2MU005_CHGR_EVT_THERM_SHUTDOWN	FIELD_PREP(S2MU005_CHGR_EVT, 1)
+
+/* S2MU005_REG_CHGR_CTRL0 */
+#define S2MU005_CHGR_CHG_EN		BIT(4)
+#define S2MU005_CHGR_OP_MODE		GENMASK(2, 0)
+
+#define S2MU005_CHGR_OP_MODE_OTG	FIELD_PREP(S2MU005_CHGR_OP_MODE, BIT(2))
+#define S2MU005_CHGR_OP_MODE_CHG	FIELD_PREP(S2MU005_CHGR_OP_MODE, BIT(1))
+
+/* S2MU005_REG_CHGR_CTRL1 */
+#define S2MU005_CHGR_VIN_DROP		GENMASK(6, 4)
+
+/* S2MU005_REG_CHGR_CTRL2 */
+#define S2MU005_CHGR_IN_CURR_LIM	GENMASK(5, 0)
+
+/* S2MU005_REG_CHGR_CTRL4 */
+#define S2MU005_CHGR_OTG_OCP_ON		BIT(5)
+#define S2MU005_CHGR_OTG_OCP_OFF	BIT(4)
+#define S2MU005_CHGR_OTG_OCP		GENMASK(3, 2)
+
+/* S2MU005_REG_CHGR_CTRL5 */
+#define S2MU005_CHGR_VMID_BOOST		GENMASK(4, 0)
+
+/* S2MU005_REG_CHGR_CTRL6 */
+#define S2MU005_CHGR_COOL_CHG_CURR	GENMASK(5, 0)
+
+/* S2MU005_REG_CHGR_CTRL7 */
+#define S2MU005_CHGR_FAST_CHG_CURR	GENMASK(5, 0)
+
+/* S2MU005_REG_CHGR_CTRL8 */
+#define S2MU005_CHGR_VF_VBAT		GENMASK(6, 1)
+
+/* S2MU005_REG_CHGR_CTRL10 */
+#define S2MU005_CHGR_TOPOFF_CURR(x)	(GENMASK(3, 0) << 4 * (x))
+
+/* S2MU005_REG_CHGR_CTRL11 */
+#define S2MU005_CHGR_OSC_BOOST		GENMASK(6, 5)
+#define S2MU005_CHGR_OSC_BUCK		GENMASK(4, 3)
+
+/* S2MU005_REG_CHGR_CTRL12 */
+#define S2MU005_CHGR_WDT		GENMASK(2, 0)
+
+#define S2MU005_CHGR_WDT_ON		FIELD_PREP(S2MU005_CHGR_WDT, BIT(2))
+#define S2MU005_CHGR_WDT_OFF		FIELD_PREP(S2MU005_CHGR_WDT, BIT(1))
+
+/* S2MU005_REG_CHGR_CTRL15 */
+#define S2MU005_CHGR_OTG_EN		GENMASK(3, 2)
+
+/* S2MU005_REG_FLED_STATUS */
+#define S2MU005_FLED_FLASH_STATUS(x)	(BIT(7) >> 2 * (x))
+#define S2MU005_FLED_TORCH_STATUS(x)	(BIT(6) >> 2 * (x))
+
+/* S2MU005_REG_FLED_CHx_CTRL0 */
+#define S2MU005_FLED_FLASH_IOUT		GENMASK(3, 0)
+
+/* S2MU005_REG_FLED_CHx_CTRL1 */
+#define S2MU005_FLED_TORCH_IOUT		GENMASK(3, 0)
+
+/* S2MU005_REG_FLED_CHx_CTRL2 */
+#define S2MU005_FLED_TORCH_TIMEOUT	GENMASK(3, 0)
+
+/* S2MU005_REG_FLED_CHx_CTRL3 */
+#define S2MU005_FLED_FLASH_TIMEOUT	GENMASK(3, 0)
+
+/* S2MU005_REG_FLED_CTRL1 */
+#define S2MU005_FLED_CH_EN		BIT(7)
+
+/*
+ * S2MU005_REG_FLED_CTRL4 - Rev. EVT0
+ * S2MU005_REG_FLED_CTRL6 - Rev. EVT1 and later
+ */
+#define S2MU005_FLED_FLASH_EN(x)	(GENMASK(7, 6) >> 4 * (x))
+#define S2MU005_FLED_TORCH_EN(x)	(GENMASK(5, 4) >> 4 * (x))
+
+/* S2MU005_REG_RGB_EN */
+#define S2MU005_RGB_RESET		BIT(6)
+#define S2MU005_RGB_SLOPE		GENMASK(5, 0)
+
+#define S2MU005_RGB_SLOPE_CONST		(BIT(4) | BIT(2) | BIT(0))
+#define S2MU005_RGB_SLOPE_SMOOTH	(BIT(5) | BIT(3) | BIT(1))
+
+/* S2MU005_REG_RGB_CHx_RAMP */
+#define S2MU005_RGB_CH_RAMP_UP		GENMASK(7, 4)
+#define S2MU005_RGB_CH_RAMP_DN		GENMASK(3, 0)
+
+/* S2MU005_REG_RGB_CHx_STAY */
+#define S2MU005_RGB_CH_STAY_HI		GENMASK(7, 4)
+#define S2MU005_RGB_CH_STAY_LO		GENMASK(3, 0)
+
+/* S2MU005_REG_MUIC_DEV1 */
+#define S2MU005_MUIC_OTG		BIT(7)
+#define S2MU005_MUIC_DCP		BIT(6)
+#define S2MU005_MUIC_CDP		BIT(5)
+#define S2MU005_MUIC_T1_T2_CHG		BIT(4)
+#define S2MU005_MUIC_UART		BIT(3)
+#define S2MU005_MUIC_SDP		BIT(2)
+#define S2MU005_MUIC_LANHUB		BIT(1)
+#define S2MU005_MUIC_AUDIO		BIT(0)
+
+/* S2MU005_REG_MUIC_DEV2 */
+#define S2MU005_MUIC_SDP_1P8S		BIT(7)
+#define S2MU005_MUIC_AV			BIT(6)
+#define S2MU005_MUIC_TTY		BIT(5)
+#define S2MU005_MUIC_PPD		BIT(4)
+#define S2MU005_MUIC_JIG_UART_OFF	BIT(3)
+#define S2MU005_MUIC_JIG_UART_ON	BIT(2)
+#define S2MU005_MUIC_JIG_USB_OFF	BIT(1)
+#define S2MU005_MUIC_JIG_USB_ON		BIT(0)
+
+/* S2MU005_REG_MUIC_DEV3 */
+#define S2MU005_MUIC_U200_CHG		BIT(7)
+#define S2MU005_MUIC_VBUS_AV		BIT(4)
+#define S2MU005_MUIC_VBUS_R255		BIT(1)
+#define S2MU005_MUIC_MHL		BIT(0)
+
+/* S2MU005_REG_MUIC_DEVAPPLE */
+#define S2MU005_MUIC_APPLE_CHG_0P5A	BIT(7)
+#define S2MU005_MUIC_APPLE_CHG_1P0A	BIT(6)
+#define S2MU005_MUIC_APPLE_CHG_2P0A	BIT(5)
+#define S2MU005_MUIC_APPLE_CHG_2P4A	BIT(4)
+#define S2MU005_MUIC_SDP_DCD_OUT	BIT(3)
+#define S2MU005_MUIC_RID_WAKEUP		BIT(2)
+#define S2MU005_MUIC_VBUS_WAKEUP	BIT(1)
+#define S2MU005_MUIC_BCV1P2_OR_OPEN	BIT(0)
+
+/* S2MU005_REG_ID */
+#define S2MU005_ID_MASK			GENMASK(3, 0)
+#define S2MU005_ID_SHIFT		0
+
+/* S2MU005_REG_MUIC_SWCTRL */
+#define S2MU005_MUIC_DM_DP		GENMASK(7, 2)
+#define S2MU005_MUIC_JIG		BIT(0)
+
+#define S2MU005_MUIC_DM_DP_UART		FIELD_PREP(S2MU005_MUIC_DM_DP, 0x12)
+#define S2MU005_MUIC_DM_DP_USB		FIELD_PREP(S2MU005_MUIC_DM_DP, 0x09)
+
+/* S2MU005_REG_MUIC_CTRL1 */
+#define S2MU005_MUIC_OPEN		BIT(4)
+#define S2MU005_MUIC_RAW_DATA		BIT(3)
+#define S2MU005_MUIC_MAN_SW		BIT(2)
+#define S2MU005_MUIC_WAIT		BIT(1)
+#define S2MU005_MUIC_IRQ		BIT(0)
+
+/* S2MU005_REG_MUIC_CTRL3 */
+#define S2MU005_MUIC_ONESHOT_ADC	BIT(2)
+
+/* S2MU005_REG_MUIC_LDOADC_L and S2MU005_REG_MUIC_LDOADC_H */
+#define S2MU005_MUIC_VSET		GENMASK(4, 0)
+
+#define S2MU005_MUIC_VSET_3P0V		FIELD_PREP(S2MU005_MUIC_VSET, 0x1f)
+#define S2MU005_MUIC_VSET_2P6V		FIELD_PREP(S2MU005_MUIC_VSET, 0x0e)
+#define S2MU005_MUIC_VSET_2P4V		FIELD_PREP(S2MU005_MUIC_VSET, 0x0c)
+#define S2MU005_MUIC_VSET_2P2V		FIELD_PREP(S2MU005_MUIC_VSET, 0x0a)
+#define S2MU005_MUIC_VSET_2P0V		FIELD_PREP(S2MU005_MUIC_VSET, 0x08)
+#define S2MU005_MUIC_VSET_1P5V		FIELD_PREP(S2MU005_MUIC_VSET, 0x03)
+#define S2MU005_MUIC_VSET_1P4V		FIELD_PREP(S2MU005_MUIC_VSET, 0x02)
+#define S2MU005_MUIC_VSET_1P2V		FIELD_PREP(S2MU005_MUIC_VSET, 0x00)
+
+#endif	/* __LINUX_MFD_S2MU005_H */

-- 
2.51.2


