Return-Path: <linux-pm+bounces-43168-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDecCkr5nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43168-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2318BD44
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6801230730AD
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769E3AA1B6;
	Tue, 24 Feb 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="g58LrI8T"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1329DB64;
	Tue, 24 Feb 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960563; cv=none; b=kKOQyoVWXul+4D97Bu9W0tszuELD0OMtIN1lkK+hG5Nz9OQRgBRpsXkNmOEGibrbHwf1BT5gO6SMj2Ln/KMlQXPQkNqYmCMOmWY6F8DI8nOXcG/ff08Qi0DhMQ+ojD9/RpCr1iE98To4xbTQiai6oAOrsWSXCmVD4ljZI3NLUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960563; c=relaxed/simple;
	bh=N3bK+kDkqLpnnL/zlOjhzjQk2v7Cnhs1I9AlfX9Tnlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUpkJbZJZwMdRGncS2vCS2s4AvJyVUCu9Xsdh+CK8RQ4na8vkeo6znUU9tPPCo2HnB0gJnyS3wNLhkuV7BV0XgTD5G//LmXaC2adzUe94HWbAhbC0nyygrjSOq0HxK6DBC+daDWT23gT4cyVso+3ADxi1inXQoJsDujfILVyNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=g58LrI8T; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BDE152696F;
	Tue, 24 Feb 2026 20:15:59 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xb4hdYZ39PB9; Tue, 24 Feb 2026 20:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960558; bh=N3bK+kDkqLpnnL/zlOjhzjQk2v7Cnhs1I9AlfX9Tnlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g58LrI8TETlMpUZ3wghh5IrWLbbUZGoNYvxpf8f4ASsAsT9e65yAStQZkuDUVuNGp
	 gsZIU68OJ2SoM38UqEBrPwxkU5KMl3YxgIx+TXPrigILwYfeTw0guH4elOWvdNGVYN
	 /FRY+wZXCPOz20f7VvN42je3Db1yQqL6GpOfa6h9ZaRmAkrS4aXoSvHxyTEzwBSFkz
	 r5JoSeSMyyf2VOKOPEQtPIdup5Llp3BHWAKOeja2KR6dIT/1GqyCtbtx6TQ/t1JGE5
	 dTavEpxNhqUy4uAUToSt7bHAVNoVQZ2MUShBTCRx6gbQKBjJxthzs5cZlUK4kkBhzn
	 1Xlt1QDNWSBhA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:08 +0530
Subject: [PATCH v3 06/13] mfd: sec: add support for S2MU005 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-6-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43168-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 3FF2318BD44
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
 drivers/mfd/sec-i2c.c               |  29 ++++
 drivers/mfd/sec-irq.c               |  74 ++++++++
 include/linux/mfd/samsung/core.h    |   1 +
 include/linux/mfd/samsung/irq.h     |  66 ++++++++
 include/linux/mfd/samsung/s2mu005.h | 327 ++++++++++++++++++++++++++++++++++++
 6 files changed, 513 insertions(+)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index bd8b5f9686892..b3268516bf75e 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -105,6 +105,18 @@ static const struct mfd_cell s2mpu05_devs[] = {
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
@@ -250,6 +262,10 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
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
index 3132b849b4bc4..d8609886fcc80 100644
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
+	.cache_type = REGCACHE_FLAT_S,
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
index 133188391f7c2..91a2922463fb6 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/samsung/s2mps14.h>
 #include <linux/mfd/samsung/s2mpu02.h>
 #include <linux/mfd/samsung/s2mpu05.h>
+#include <linux/mfd/samsung/s2mu005.h>
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/regmap.h>
 #include "sec-core.h"
@@ -223,6 +224,65 @@ static const struct regmap_irq s2mpu05_irqs[] = {
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
+	case S2MU005_REG_CHGR_INT1:
+		return irqf_regs[index];
+	case S2MU005_REG_CHGR_INT1M:
+		return mask_regs[index];
+	}
+
+	return base;
+}
+
 static const struct regmap_irq s5m8767_irqs[] = {
 	REGMAP_IRQ_REG(S5M8767_IRQ_PWRR, 0, S5M8767_IRQ_PWRR_MASK),
 	REGMAP_IRQ_REG(S5M8767_IRQ_PWRF, 0, S5M8767_IRQ_PWRF_MASK),
@@ -337,6 +397,17 @@ static const struct regmap_irq_chip s2mpu05_irq_chip = {
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
@@ -442,6 +513,9 @@ struct regmap_irq_chip_data *sec_irq_init(struct sec_pmic_dev *sec_pmic)
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
index 4480c631110a6..6191f409de945 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -47,6 +47,7 @@ enum sec_device_type {
 	S2MPS15X,
 	S2MPU02,
 	S2MPU05,
+	S2MU005,
 };
 
 /**
diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
index 6eab95de6fa83..19d0f0e12944f 100644
--- a/include/linux/mfd/samsung/irq.h
+++ b/include/linux/mfd/samsung/irq.h
@@ -408,6 +408,72 @@ enum s2mpu05_irq {
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
index 0000000000000..07f4ae664950d
--- /dev/null
+++ b/include/linux/mfd/samsung/s2mu005.h
@@ -0,0 +1,327 @@
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
+#define S2MU005_CHGR_STAT_DONE		8
+#define S2MU005_CHGR_STAT_TOPOFF	7
+#define S2MU005_CHGR_STAT_DONE_FLAG	6
+#define S2MU005_CHGR_STAT_CV		5
+#define S2MU005_CHGR_STAT_CC		4
+#define S2MU005_CHGR_STAT_COOL_CHG	3
+#define S2MU005_CHGR_STAT_PRE_CHG	2
+
+/* S2MU005_REG_CHGR_STATUS1 */
+#define S2MU005_CHGR_DETBAT		BIT(7)
+#define S2MU005_CHGR_VBUS_OVP		GENMASK(6, 4)
+
+#define S2MU005_CHGR_VBUS_OVP_OVERVOLT	2
+
+/* S2MU005_REG_CHGR_STATUS2 */
+#define S2MU005_CHGR_BAT		GENMASK(6, 4)
+
+#define S2MU005_CHGR_BAT_VOLT_DET	7
+#define S2MU005_CHGR_BAT_FAST_CHG_DET	6
+#define S2MU005_CHGR_BAT_COOL_CHG_DET	5
+#define S2MU005_CHGR_BAT_LOW_CHG	2
+#define S2MU005_CHGR_BAT_SELF_DISCHG	1
+#define S2MU005_CHGR_BAT_OVP_DET	0
+
+/* S2MU005_REG_CHGR_STATUS3 */
+#define S2MU005_CHGR_EVT		GENMASK(3, 0)
+
+#define S2MU005_CHGR_EVT_WDT_RST	6
+#define S2MU005_CHGR_EVT_WDT_SUSP	5
+#define S2MU005_CHGR_EVT_VSYS_VUVLO	4
+#define S2MU005_CHGR_EVT_VSYS_VOVP	3
+#define S2MU005_CHGR_EVT_THERM_FOLDBACK	2
+#define S2MU005_CHGR_EVT_THERM_SHUTDOWN	1
+
+/* S2MU005_REG_CHGR_CTRL0 */
+#define S2MU005_CHGR_CHG_EN		BIT(4)
+#define S2MU005_CHGR_OP_MODE		GENMASK(2, 0)
+
+#define S2MU005_CHGR_OP_MODE_OTG	BIT(2)
+#define S2MU005_CHGR_OP_MODE_CHG	BIT(1)
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
+#define S2MU005_CHGR_WDT_ON		BIT(2)
+#define S2MU005_CHGR_WDT_OFF		BIT(1)
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
+
+/* S2MU005_REG_MUIC_SWCTRL */
+#define S2MU005_MUIC_DM_DP		GENMASK(7, 2)
+#define S2MU005_MUIC_JIG		BIT(0)
+
+#define S2MU005_MUIC_DM_DP_UART		0x12
+#define S2MU005_MUIC_DM_DP_USB		0x09
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
+#define S2MU005_MUIC_VSET_3P0V		0x1f
+#define S2MU005_MUIC_VSET_2P6V		0x0e
+#define S2MU005_MUIC_VSET_2P4V		0x0c
+#define S2MU005_MUIC_VSET_2P2V		0x0a
+#define S2MU005_MUIC_VSET_2P0V		0x08
+#define S2MU005_MUIC_VSET_1P5V		0x03
+#define S2MU005_MUIC_VSET_1P4V		0x02
+#define S2MU005_MUIC_VSET_1P2V		0x00
+
+#endif /* __LINUX_MFD_S2MU005_H */

-- 
2.52.0


