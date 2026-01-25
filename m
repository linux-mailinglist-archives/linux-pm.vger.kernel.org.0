Return-Path: <linux-pm+bounces-41430-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEhfMdJqdmkuQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41430-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:11:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E1B81FC4
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F25C300D174
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A2D2F1FEA;
	Sun, 25 Jan 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HJbQaU7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111022F0C78;
	Sun, 25 Jan 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368107; cv=none; b=gvCSdAQwmcE+S/qMYpKlgaj5lBZsLVYEHmpha5rvebJC746xyi9De5HByXp9wYM3d+NSC8pzYTKSwziVNrl5zs5FKw9E0xJI9VahgqSWRB+Tjxq5ncoSrXJs88nU11R3NF1vQ52hGx58hkTsNxDEaEPdfe+lXwx8X/IZxl7zqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368107; c=relaxed/simple;
	bh=DZSMV0gohpZBSDAPOJEnnJhDmgN21hMhSTPno/RQGic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmESmRnycUTr/EnuAuBZ8PLAeZldU7ZQfHBJUWumpV26UqfszfWG0m2PtGUMBWeQgC83l1AHyXjFGIhlPJbFowBIvvML7CjsNZegeiV2ar94qo8MTSwf+0AQs8BnRM3zm8SvCN6sFfI2eVQIKscWYpGUWL4EBqKa0ko197V3eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HJbQaU7A; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3F58B2807E;
	Sun, 25 Jan 2026 20:08:23 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0Lbm0QIjWVH; Sun, 25 Jan 2026 20:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368101; bh=DZSMV0gohpZBSDAPOJEnnJhDmgN21hMhSTPno/RQGic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HJbQaU7A7H5fibeuf8n+yH1j+J/Tajbau6z4VY3s6pnVogRvcExW1/4/+Jslb9LRz
	 Ke3+IBBGGqTH17sqyBZO2NSAq91VfgyTVhk7giP8RJAzWbYcxrF/u+I9oE0QzPd0qJ
	 XqfUcvqbQq/VbQRHreYRtyWY656WtXUsg+kfW6KsRvdS+a74cLs+xQLL3w91N/JPZi
	 NXtznndT82ft1hUfouRuLJnLq70MmJ0/eOV9UW1SnhtPIgn5DsozkIWFQYq1Xbdwn5
	 8uIS/PBRIypg/tQaqaD3A1Q4pRYyUWRkt/9yXpqam+Qd9Js97hFpKdSL3ORJ+ddAQ1
	 NHyNjpJffGRrg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:13 +0530
Subject: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41430-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 47E1B81FC4
X-Rspamd-Action: no action

Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Micro
USB Interface Controller), and flash and RGB LED controllers.

S2MU005's interrupt registers can be properly divided into three regmap
IRQ chips, one each for the charger, flash LEDs, and the MUIC.

Add initial support for S2MU005 in the PMIC driver, along with it's three
interrupt chips.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-common.c            |  16 ++
 drivers/mfd/sec-i2c.c               |  12 ++
 drivers/mfd/sec-irq.c               |  74 ++++++++
 include/linux/mfd/samsung/core.h    |   1 +
 include/linux/mfd/samsung/irq.h     |  66 ++++++++
 include/linux/mfd/samsung/s2mu005.h | 328 ++++++++++++++++++++++++++++++++++++
 6 files changed, 497 insertions(+)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 0021f9ae8484f..bc2a1f2c6dc7a 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -99,6 +99,18 @@ static const struct mfd_cell s2mpu05_devs[] = {
 	MFD_CELL_RES("s2mps15-rtc", s2mpu05_rtc_resources),
 };
 
+static const struct resource s2mu005_muic_resources[] = {
+	DEFINE_RES_IRQ_NAMED(S2MU005_IRQ_MUIC_ATTACH, "attach"),
+	DEFINE_RES_IRQ_NAMED(S2MU005_IRQ_MUIC_DETACH, "detach"),
+};
+
+static const struct mfd_cell s2mu005_devs[] = {
+	MFD_CELL_OF("s2mu005-charger", NULL, NULL, 0, 0, "samsung,s2mu005-charger"),
+	MFD_CELL_OF("s2mu005-flash", NULL, NULL, 0, 0, "samsung,s2mu005-flash"),
+	MFD_CELL_OF("s2mu005-muic", s2mu005_muic_resources, NULL, 0, 0, "samsung,s2mu005-muic"),
+	MFD_CELL_OF("s2mu005-rgb", NULL, NULL, 0, 0, "samsung,s2mu005-rgb"),
+};
+
 static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)
 {
 	unsigned int val;
@@ -235,6 +247,10 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
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
index 3132b849b4bc4..3f1d70cc3292b 100644
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
@@ -130,6 +131,11 @@ static const struct regmap_config s2mpu05_regmap_config = {
 	.val_bits = 8,
 };
 
+static const struct regmap_config s2mu005_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static const struct regmap_config s5m8767_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -203,6 +209,11 @@ static const struct sec_pmic_i2c_platform_data s2mpu05_data = {
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
@@ -217,6 +228,7 @@ static const struct of_device_id sec_pmic_i2c_of_match[] = {
 	{ .compatible = "samsung,s2mps15-pmic", .data = &s2mps15_data, },
 	{ .compatible = "samsung,s2mpu02-pmic", .data = &s2mpu02_data, },
 	{ .compatible = "samsung,s2mpu05-pmic", .data = &s2mpu05_data, },
+	{ .compatible = "samsung,s2mu005-pmic", .data = &s2mu005_data, },
 	{ .compatible = "samsung,s5m8767-pmic", .data = &s5m8767_data, },
 	{ },
 };
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index 4c0faf4c99893..44a1eb074a082 100644
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
@@ -164,6 +165,65 @@ static const struct regmap_irq s2mpu05_irqs[] = {
 	REGMAP_IRQ_REG(S2MPU05_IRQ_TSD, 2, S2MPU05_IRQ_TSD_MASK),
 };
 
+static const struct regmap_irq s2mu005_irqs[] = {
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_DETBAT, 0, S2MU005_IRQ_CHGR_DETBAT_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_BAT, 0, S2MU005_IRQ_CHGR_BAT_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_IVR, 0, S2MU005_IRQ_CHGR_IVR_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_EVENT, 0, S2MU005_IRQ_CHGR_EVENT_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_CHG, 0, S2MU005_IRQ_CHGR_CHG_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_VMID, 0, S2MU005_IRQ_CHGR_VMID_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_WCIN, 0, S2MU005_IRQ_CHGR_WCIN_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_CHGR_VBUS, 0, S2MU005_IRQ_CHGR_VBUS_MASK),
+
+	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_LBPROT, 1, S2MU005_IRQ_FLED_LBPROT_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_OPENCH2, 1, S2MU005_IRQ_FLED_OPENCH2_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_OPENCH1, 1, S2MU005_IRQ_FLED_OPENCH1_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_SHORTCH2, 1, S2MU005_IRQ_FLED_SHORTCH2_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_FLED_SHORTCH1, 1, S2MU005_IRQ_FLED_SHORTCH1_MASK),
+
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_ATTACH, 2, S2MU005_IRQ_MUIC_ATTACH_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_DETACH, 2, S2MU005_IRQ_MUIC_DETACH_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_KP, 2, S2MU005_IRQ_MUIC_KP_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_LKP, 2, S2MU005_IRQ_MUIC_LKP_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_LKR, 2, S2MU005_IRQ_MUIC_LKR_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_RIDCHG, 2, S2MU005_IRQ_MUIC_RIDCHG_MASK),
+
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_VBUSON, 3, S2MU005_IRQ_MUIC_VBUSON_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_RSVD, 3, S2MU005_IRQ_MUIC_RSVD_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_ADC, 3, S2MU005_IRQ_MUIC_ADC_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_STUCK, 3, S2MU005_IRQ_MUIC_STUCK_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_STUCKRCV, 3, S2MU005_IRQ_MUIC_STUCKRCV_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_MHDL, 3, S2MU005_IRQ_MUIC_MHDL_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_AVCHG, 3, S2MU005_IRQ_MUIC_AVCHG_MASK),
+	REGMAP_IRQ_REG(S2MU005_IRQ_MUIC_VBUSOFF, 3, S2MU005_IRQ_MUIC_VBUSOFF_MASK),
+};
+
+static unsigned int s2mu005_irq_get_reg(struct regmap_irq_chip_data *data,
+					unsigned int base, int index)
+{
+	const unsigned int irqf_regs[] = {
+		S2MU005_REG_CHGR_INT1,
+		S2MU005_REG_FLED_INT1,
+		S2MU005_REG_MUIC_INT1,
+		S2MU005_REG_MUIC_INT2,
+	};
+	const unsigned int mask_regs[] = {
+		S2MU005_REG_CHGR_INT1M,
+		S2MU005_REG_FLED_INT1M,
+		S2MU005_REG_MUIC_INT1M,
+		S2MU005_REG_MUIC_INT2M,
+	};
+
+	switch (base) {
+	case irqf_regs[0]:
+		return irqf_regs[index];
+	case mask_regs[0]:
+		return mask_regs[index];
+	}
+
+	return base;
+}
+
 static const struct regmap_irq s5m8767_irqs[] = {
 	REGMAP_IRQ_REG(S5M8767_IRQ_PWRR, 0, S5M8767_IRQ_PWRR_MASK),
 	REGMAP_IRQ_REG(S5M8767_IRQ_PWRF, 0, S5M8767_IRQ_PWRF_MASK),
@@ -259,6 +319,17 @@ static const struct regmap_irq_chip s2mpu05_irq_chip = {
 	.ack_base = S2MPU05_REG_INT1,
 };
 
+static const struct regmap_irq_chip s2mu005_irq_chip = {
+	.name = "s2mu005",
+	.irqs = s2mu005_irqs,
+	.num_irqs = ARRAY_SIZE(s2mu005_irqs),
+	.num_regs = 4,
+	.status_base = S2MU005_REG_CHGR_INT1,
+	.mask_base = S2MU005_REG_CHGR_INT1M,
+	.ack_base = S2MU005_REG_CHGR_INT1,
+	.get_irq_reg = s2mu005_irq_get_reg,
+};
+
 static const struct regmap_irq_chip s5m8767_irq_chip = {
 	.name = "s5m8767",
 	.irqs = s5m8767_irqs,
@@ -358,6 +429,9 @@ struct regmap_irq_chip_data *sec_irq_init(struct sec_pmic_dev *sec_pmic)
 	case S2MPU05:
 		sec_irq_chip = &s2mpu05_irq_chip;
 		break;
+	case S2MU005:
+		sec_irq_chip = &s2mu005_irq_chip;
+		break;
 	default:
 		return dev_err_ptr_probe(sec_pmic->dev, -EINVAL, "Unsupported device type %d\n",
 					 sec_pmic->device_type);
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index c7c3c8cd8d5f9..43e0c5e55f5d3 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -46,6 +46,7 @@ enum sec_device_type {
 	S2MPS15X,
 	S2MPU02,
 	S2MPU05,
+	S2MU005,
 };
 
 /**
diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
index 8402a5f8e18ab..936369a733a1c 100644
--- a/include/linux/mfd/samsung/irq.h
+++ b/include/linux/mfd/samsung/irq.h
@@ -303,6 +303,72 @@ enum s2mpu05_irq {
 #define S2MPU05_IRQ_INT140C_MASK	BIT(1)
 #define S2MPU05_IRQ_TSD_MASK		BIT(2)
 
+enum s2mu005_irq {
+	S2MU005_IRQ_CHGR_DETBAT,
+	S2MU005_IRQ_CHGR_BAT,
+	S2MU005_IRQ_CHGR_IVR,
+	S2MU005_IRQ_CHGR_EVENT,
+	S2MU005_IRQ_CHGR_CHG,
+	S2MU005_IRQ_CHGR_VMID,
+	S2MU005_IRQ_CHGR_WCIN,
+	S2MU005_IRQ_CHGR_VBUS,
+
+	S2MU005_IRQ_FLED_LBPROT,
+	S2MU005_IRQ_FLED_OPENCH2,
+	S2MU005_IRQ_FLED_OPENCH1,
+	S2MU005_IRQ_FLED_SHORTCH2,
+	S2MU005_IRQ_FLED_SHORTCH1,
+
+	S2MU005_IRQ_MUIC_ATTACH,
+	S2MU005_IRQ_MUIC_DETACH,
+	S2MU005_IRQ_MUIC_KP,
+	S2MU005_IRQ_MUIC_LKP,
+	S2MU005_IRQ_MUIC_LKR,
+	S2MU005_IRQ_MUIC_RIDCHG,
+
+	S2MU005_IRQ_MUIC_VBUSON,
+	S2MU005_IRQ_MUIC_RSVD,
+	S2MU005_IRQ_MUIC_ADC,
+	S2MU005_IRQ_MUIC_STUCK,
+	S2MU005_IRQ_MUIC_STUCKRCV,
+	S2MU005_IRQ_MUIC_MHDL,
+	S2MU005_IRQ_MUIC_AVCHG,
+	S2MU005_IRQ_MUIC_VBUSOFF,
+
+	S2MU005_IRQ_NR,
+};
+
+#define S2MU005_IRQ_CHGR_DETBAT_MASK	BIT(0)
+#define S2MU005_IRQ_CHGR_BAT_MASK	BIT(1)
+#define S2MU005_IRQ_CHGR_IVR_MASK	BIT(2)
+#define S2MU005_IRQ_CHGR_EVENT_MASK	BIT(3)
+#define S2MU005_IRQ_CHGR_CHG_MASK	BIT(4)
+#define S2MU005_IRQ_CHGR_VMID_MASK	BIT(5)
+#define S2MU005_IRQ_CHGR_WCIN_MASK	BIT(6)
+#define S2MU005_IRQ_CHGR_VBUS_MASK	BIT(7)
+
+#define S2MU005_IRQ_FLED_LBPROT_MASK		BIT(2)
+#define S2MU005_IRQ_FLED_OPENCH2_MASK		BIT(4)
+#define S2MU005_IRQ_FLED_OPENCH1_MASK		BIT(5)
+#define S2MU005_IRQ_FLED_SHORTCH2_MASK		BIT(6)
+#define S2MU005_IRQ_FLED_SHORTCH1_MASK		BIT(7)
+
+#define S2MU005_IRQ_MUIC_ATTACH_MASK		BIT(0)
+#define S2MU005_IRQ_MUIC_DETACH_MASK		BIT(1)
+#define S2MU005_IRQ_MUIC_KP_MASK		BIT(2)
+#define S2MU005_IRQ_MUIC_LKP_MASK		BIT(3)
+#define S2MU005_IRQ_MUIC_LKR_MASK		BIT(4)
+#define S2MU005_IRQ_MUIC_RIDCHG_MASK		BIT(5)
+
+#define S2MU005_IRQ_MUIC_VBUSON_MASK		BIT(0)
+#define S2MU005_IRQ_MUIC_RSVD_MASK		BIT(1)
+#define S2MU005_IRQ_MUIC_ADC_MASK		BIT(2)
+#define S2MU005_IRQ_MUIC_STUCK_MASK		BIT(3)
+#define S2MU005_IRQ_MUIC_STUCKRCV_MASK		BIT(4)
+#define S2MU005_IRQ_MUIC_MHDL_MASK		BIT(5)
+#define S2MU005_IRQ_MUIC_AVCHG_MASK		BIT(6)
+#define S2MU005_IRQ_MUIC_VBUSOFF_MASK		BIT(7)
+
 enum s5m8767_irq {
 	S5M8767_IRQ_PWRR,
 	S5M8767_IRQ_PWRF,
diff --git a/include/linux/mfd/samsung/s2mu005.h b/include/linux/mfd/samsung/s2mu005.h
new file mode 100644
index 0000000000000..32ad35dda661d
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
2.52.0


