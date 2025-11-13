Return-Path: <linux-pm+bounces-37977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E56C59A18
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE09135096E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7253191DE;
	Thu, 13 Nov 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Yac05re/"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D331961F;
	Thu, 13 Nov 2025 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060805; cv=none; b=MXCkkbsXxdeFc/Y3fVREBrPsR5xpnMk2jR5yBAIAu57FycODbigH2iCMMJ98tlXsFEnnVMbcgZil3uKppYDXGc3vr9RUO7UlMPgVDivyKi7sFoKHkWL849AdLZ3kF8+T/X/KZv639gNMGOIKGQ6w+xo5JmiA0f0OmVj6Sj2pQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060805; c=relaxed/simple;
	bh=U4EhmV2PN5Yp0pSdaEb4ukrPp7hCwT8GdTlgZ0mf/nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXF+6HxSMGhkKFjkrbNd11S5NzZgWthtDmhB9FJFzGImp6nMduaEwj12b7bTVEmRoQIZuxBm9tFWIeeBdikrM/R6qQrr+BnBFEAwmd5OueHqtfHzJ3gF5VaC9aqVYCXM+R1hHlmf181eUBzmWA7khMcUmqUeXSPpErYGxRYWhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Yac05re/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6751926712;
	Thu, 13 Nov 2025 20:06:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HaOQiSiThHid; Thu, 13 Nov 2025 20:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060800; bh=U4EhmV2PN5Yp0pSdaEb4ukrPp7hCwT8GdTlgZ0mf/nU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Yac05re/PnMSti66cgs4vw6VUIE1QXY00XoXyIKEgkivdbUaanI4Jd479+P5WNJ8D
	 lZ1rnEUNrO05lQ4jV9B98e83wVEO/eW/K2RPTPcUHOwZ8dmJVAHxVQO20R3HClt1Yo
	 sI1VJ69a3nEgCVa5iMHFgv3j3pCqprjSWUfqq5csNu7IBje8RngM7668cJWXgkWWCO
	 k87dLrNmSVH0wEPtQnim0/BdCBq4BVDlF9enBa4d9OSxTajAYONP2oaLHMlSrrLudW
	 nfF7Q2FzFbVLuHYqAj5y3tKM/UbUpGoMXtA49wrdSBMFXu/vSntSpUMP2zVmAsUVK7
	 6JeOwyuha1GpQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:07 +0530
Subject: [PATCH 06/13] mfd: sec-irq: add support for creating multiple IRQ
 chips
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-6-9e3184d3a0c9@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=12500;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=U4EhmV2PN5Yp0pSdaEb4ukrPp7hCwT8GdTlgZ0mf/nU=;
 b=7Z86uSdtT+4G9Y+0nAMDqJsSWX+sPiRTNtQtE9Cfjp70vqv3ni56UwDi/LutMe9hQdFi6ppfq
 CciBXf5AskwDgVHUNJrZhWjeTxRg+406Mu0ptj+kuHrJ+UEzUaPVjFt
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

The current state of the driver only allows creating only one IRQ chip
per PMIC. On some PMICs, such as Samsung's S2MU005, there are multiple
interrupt blocks, for which the current implementation stands insufficient.

Add support for creating multiple IRQ chips for a PMIC. Every IRQ chip is
given it's own index, which is used by sub-device drivers to request IRQs.

A macro is defined which states the maximum number of chips supported.
It's set to 1 as currently, no PMIC requires more than one IRQ chip. The
value must be changed accordingly on adding new PMICs requiring multiple
IRQ chips.

Moreover, adjust the s5m RTC driver to initialize IRQs with the
appropriate IRQ chip index.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-irq.c            | 163 +++++++++++++++++++++++----------------
 drivers/rtc/rtc-s5m.c            |  15 +++-
 include/linux/mfd/samsung/core.h |   5 +-
 include/linux/mfd/samsung/irq.h  |  14 ++++
 4 files changed, 127 insertions(+), 70 deletions(-)

diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index c5c80b1ba104..053c28f31ec9 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -181,25 +181,31 @@ static const struct regmap_irq s5m8767_irqs[] = {
 };
 
 /* All S2MPG10 interrupt sources are read-only and don't require clearing */
-static const struct regmap_irq_chip s2mpg10_irq_chip = {
-	.name = "s2mpg10",
-	.irqs = s2mpg10_irqs,
-	.num_irqs = ARRAY_SIZE(s2mpg10_irqs),
-	.num_regs = 6,
-	.status_base = S2MPG10_PMIC_INT1,
-	.mask_base = S2MPG10_PMIC_INT1M,
+static const struct regmap_irq_chip s2mpg10_irq_chip[] = {
+	[S2MPG10_IRQ_CHIP] = {
+		.name = "s2mpg10",
+		.irqs = s2mpg10_irqs,
+		.num_irqs = ARRAY_SIZE(s2mpg10_irqs),
+		.num_regs = 6,
+		.status_base = S2MPG10_PMIC_INT1,
+		.mask_base = S2MPG10_PMIC_INT1M,
+	},
 };
 
-static const struct regmap_irq_chip s2mps11_irq_chip = {
-	.name = "s2mps11",
-	.irqs = s2mps11_irqs,
-	.num_irqs = ARRAY_SIZE(s2mps11_irqs),
-	.num_regs = 3,
-	.status_base = S2MPS11_REG_INT1,
-	.mask_base = S2MPS11_REG_INT1M,
-	.ack_base = S2MPS11_REG_INT1,
+static const struct regmap_irq_chip s2mps11_irq_chip[] = {
+	[S2MPS11_IRQ_CHIP] = {
+		.name = "s2mps11",
+		.irqs = s2mps11_irqs,
+		.num_irqs = ARRAY_SIZE(s2mps11_irqs),
+		.num_regs = 3,
+		.status_base = S2MPS11_REG_INT1,
+		.mask_base = S2MPS11_REG_INT1M,
+		.ack_base = S2MPS11_REG_INT1,
+	},
 };
 
+#define S2MPS1X_IRQ_CHIP		S2MPS14_IRQ_CHIP
+
 #define S2MPS1X_IRQ_CHIP_COMMON_DATA		\
 	.irqs = s2mps14_irqs,			\
 	.num_irqs = ARRAY_SIZE(s2mps14_irqs),	\
@@ -208,85 +214,106 @@ static const struct regmap_irq_chip s2mps11_irq_chip = {
 	.mask_base = S2MPS14_REG_INT1M,		\
 	.ack_base = S2MPS14_REG_INT1		\
 
-static const struct regmap_irq_chip s2mps13_irq_chip = {
-	.name = "s2mps13",
-	S2MPS1X_IRQ_CHIP_COMMON_DATA,
+static const struct regmap_irq_chip s2mps13_irq_chip[] = {
+	[S2MPS1X_IRQ_CHIP] = {
+		.name = "s2mps13",
+		S2MPS1X_IRQ_CHIP_COMMON_DATA,
+	},
 };
 
-static const struct regmap_irq_chip s2mps14_irq_chip = {
-	.name = "s2mps14",
-	S2MPS1X_IRQ_CHIP_COMMON_DATA,
+static const struct regmap_irq_chip s2mps14_irq_chip[] = {
+	[S2MPS1X_IRQ_CHIP] = {
+		.name = "s2mps14",
+		S2MPS1X_IRQ_CHIP_COMMON_DATA,
+	},
 };
 
-static const struct regmap_irq_chip s2mps15_irq_chip = {
-	.name = "s2mps15",
-	S2MPS1X_IRQ_CHIP_COMMON_DATA,
+static const struct regmap_irq_chip s2mps15_irq_chip[] = {
+	[S2MPS1X_IRQ_CHIP] = {
+		.name = "s2mps15",
+		S2MPS1X_IRQ_CHIP_COMMON_DATA,
+	},
 };
 
-static const struct regmap_irq_chip s2mpu02_irq_chip = {
-	.name = "s2mpu02",
-	.irqs = s2mpu02_irqs,
-	.num_irqs = ARRAY_SIZE(s2mpu02_irqs),
-	.num_regs = 3,
-	.status_base = S2MPU02_REG_INT1,
-	.mask_base = S2MPU02_REG_INT1M,
-	.ack_base = S2MPU02_REG_INT1,
+static const struct regmap_irq_chip s2mpu02_irq_chip[] = {
+	[S2MPU02_IRQ_CHIP] = {
+		.name = "s2mpu02",
+		.irqs = s2mpu02_irqs,
+		.num_irqs = ARRAY_SIZE(s2mpu02_irqs),
+		.num_regs = 3,
+		.status_base = S2MPU02_REG_INT1,
+		.mask_base = S2MPU02_REG_INT1M,
+		.ack_base = S2MPU02_REG_INT1,
+	},
 };
 
-static const struct regmap_irq_chip s2mpu05_irq_chip = {
-	.name = "s2mpu05",
-	.irqs = s2mpu05_irqs,
-	.num_irqs = ARRAY_SIZE(s2mpu05_irqs),
-	.num_regs = 3,
-	.status_base = S2MPU05_REG_INT1,
-	.mask_base = S2MPU05_REG_INT1M,
-	.ack_base = S2MPU05_REG_INT1,
+static const struct regmap_irq_chip s2mpu05_irq_chip[] = {
+	[S2MPU05_IRQ_CHIP] = {
+		.name = "s2mpu05",
+		.irqs = s2mpu05_irqs,
+		.num_irqs = ARRAY_SIZE(s2mpu05_irqs),
+		.num_regs = 3,
+		.status_base = S2MPU05_REG_INT1,
+		.mask_base = S2MPU05_REG_INT1M,
+		.ack_base = S2MPU05_REG_INT1,
+	},
 };
 
-static const struct regmap_irq_chip s5m8767_irq_chip = {
-	.name = "s5m8767",
-	.irqs = s5m8767_irqs,
-	.num_irqs = ARRAY_SIZE(s5m8767_irqs),
-	.num_regs = 3,
-	.status_base = S5M8767_REG_INT1,
-	.mask_base = S5M8767_REG_INT1M,
-	.ack_base = S5M8767_REG_INT1,
+static const struct regmap_irq_chip s5m8767_irq_chip[] = {
+	[S5M8767_IRQ_CHIP] = {
+		.name = "s5m8767",
+		.irqs = s5m8767_irqs,
+		.num_irqs = ARRAY_SIZE(s5m8767_irqs),
+		.num_regs = 3,
+		.status_base = S5M8767_REG_INT1,
+		.mask_base = S5M8767_REG_INT1M,
+		.ack_base = S5M8767_REG_INT1,
+	},
 };
 
 int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 {
 	const struct regmap_irq_chip *sec_irq_chip;
-	int ret;
+	int sec_irq_chip_num, i, ret;
 
 	switch (sec_pmic->device_type) {
 	case S5M8767X:
-		sec_irq_chip = &s5m8767_irq_chip;
+		sec_irq_chip = s5m8767_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s5m8767_irq_chip);
 		break;
 	case S2DOS05:
 		return 0;
 	case S2MPA01:
-		sec_irq_chip = &s2mps14_irq_chip;
+		sec_irq_chip = s2mps14_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mps14_irq_chip);
 		break;
 	case S2MPG10:
-		sec_irq_chip = &s2mpg10_irq_chip;
+		sec_irq_chip = s2mpg10_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mpg10_irq_chip);
 		break;
 	case S2MPS11X:
-		sec_irq_chip = &s2mps11_irq_chip;
+		sec_irq_chip = s2mps11_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mps11_irq_chip);
 		break;
 	case S2MPS13X:
-		sec_irq_chip = &s2mps13_irq_chip;
+		sec_irq_chip = s2mps13_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mps13_irq_chip);
 		break;
 	case S2MPS14X:
-		sec_irq_chip = &s2mps14_irq_chip;
+		sec_irq_chip = s2mps14_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mps14_irq_chip);
 		break;
 	case S2MPS15X:
-		sec_irq_chip = &s2mps15_irq_chip;
+		sec_irq_chip = s2mps15_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mps15_irq_chip);
 		break;
 	case S2MPU02:
-		sec_irq_chip = &s2mpu02_irq_chip;
+		sec_irq_chip = s2mpu02_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mpu02_irq_chip);
 		break;
 	case S2MPU05:
-		sec_irq_chip = &s2mpu05_irq_chip;
+		sec_irq_chip = s2mpu05_irq_chip;
+		sec_irq_chip_num = ARRAY_SIZE(s2mpu05_irq_chip);
 		break;
 	default:
 		return dev_err_probe(sec_pmic->dev, -EINVAL,
@@ -300,13 +327,19 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 		return 0;
 	}
 
-	ret = devm_regmap_add_irq_chip(sec_pmic->dev, sec_pmic->regmap_pmic,
-				       sec_pmic->irq, IRQF_ONESHOT,
-				       0, sec_irq_chip, &sec_pmic->irq_data);
-	if (ret)
-		return dev_err_probe(sec_pmic->dev, ret,
-				     "Failed to add %s IRQ chip\n",
-				     sec_irq_chip->name);
+	for (i = 0; i < sec_irq_chip_num; i++) {
+		ret = devm_regmap_add_irq_chip(sec_pmic->dev,
+					       sec_pmic->regmap_pmic,
+					       sec_pmic->irq,
+					       IRQF_ONESHOT | IRQF_SHARED, 0,
+					       sec_irq_chip + i,
+					       sec_pmic->irq_data + i);
+		if (ret) {
+			return dev_err_probe(sec_pmic->dev, ret,
+					     "Failed to add %s IRQ chip\n",
+					     sec_irq_chip->name);
+		}
+	}
 
 	/*
 	 * The rtc-s5m driver requests S2MPS14_IRQ_RTCA0 also for S2MPS11
diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index a7220b4d0e8d..726915deff7a 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -668,7 +668,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	enum sec_device_type device_type =
 		platform_get_device_id(pdev)->driver_data;
 	struct s5m_rtc_info *info;
-	int ret, alarm_irq;
+	int ret, alarm_irq, irq_chip;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -684,21 +684,25 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 			regmap_cfg = &s2mps14_rtc_regmap_config;
 			info->regs = &s2mps15_rtc_regs;
 			alarm_irq = S2MPS14_IRQ_RTCA0;
+			irq_chip = S2MPS11_IRQ_CHIP;
 			break;
 		case S2MPS14X:
 			regmap_cfg = &s2mps14_rtc_regmap_config;
 			info->regs = &s2mps14_rtc_regs;
 			alarm_irq = S2MPS14_IRQ_RTCA0;
+			irq_chip = S2MPS14_IRQ_CHIP;
 			break;
 		case S2MPS13X:
 			regmap_cfg = &s2mps14_rtc_regmap_config;
 			info->regs = &s2mps13_rtc_regs;
 			alarm_irq = S2MPS14_IRQ_RTCA0;
+			irq_chip = S2MPS14_IRQ_CHIP;
 			break;
 		case S5M8767X:
 			regmap_cfg = &s5m_rtc_regmap_config;
 			info->regs = &s5m_rtc_regs;
 			alarm_irq = S5M8767_IRQ_RTCA1;
+			irq_chip = S5M8767_IRQ_CHIP;
 			break;
 		default:
 			return dev_err_probe(&pdev->dev, -ENODEV,
@@ -720,6 +724,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	} else if (device_type == S2MPG10) {
 		info->regs = &s2mpg10_rtc_regs;
 		alarm_irq = S2MPG10_IRQ_RTCA0;
+		irq_chip = S2MPG10_IRQ_CHIP;
 	} else {
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "Unsupported device type %d\n",
@@ -730,12 +735,14 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	info->s5m87xx = s5m87xx;
 	info->device_type = device_type;
 
-	if (s5m87xx->irq_data) {
-		info->irq = regmap_irq_get_virq(s5m87xx->irq_data, alarm_irq);
-		if (info->irq <= 0)
+	if (s5m87xx->irq_data[irq_chip]) {
+		info->irq = regmap_irq_get_virq(s5m87xx->irq_data[irq_chip],
+						alarm_irq);
+		if (info->irq <= 0) {
 			return dev_err_probe(&pdev->dev, -EINVAL,
 					     "Failed to get virtual IRQ %d\n",
 					     alarm_irq);
+		}
 	}
 
 	platform_set_drvdata(pdev, info);
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index d785e101fe79..dcd741c4f0d6 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -33,6 +33,9 @@
 #define STEP_12_5_MV		12500
 #define STEP_6_25_MV		6250
 
+/* Maximum number of IRQ chips in a PMIC */
+#define MAX_IRQ_CHIPS		1
+
 struct gpio_desc;
 
 enum sec_device_type {
@@ -69,7 +72,7 @@ struct sec_pmic_dev {
 
 	int device_type;
 	int irq;
-	struct regmap_irq_chip_data *irq_data;
+	struct regmap_irq_chip_data *irq_data[MAX_IRQ_CHIPS];
 };
 
 struct sec_platform_data {
diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
index b4805cbd949b..78eb894e350e 100644
--- a/include/linux/mfd/samsung/irq.h
+++ b/include/linux/mfd/samsung/irq.h
@@ -34,6 +34,8 @@ enum s2mpa01_irq {
 	S2MPA01_IRQ_NR,
 };
 
+#define S2MPA01_IRQ_CHIP		0
+
 #define S2MPA01_IRQ_PWRONF_MASK		(1 << 0)
 #define S2MPA01_IRQ_PWRONR_MASK		(1 << 1)
 #define S2MPA01_IRQ_JIGONBF_MASK	(1 << 2)
@@ -58,6 +60,8 @@ enum s2mpa01_irq {
 #define S2MPA01_IRQ_B35_TSD_MASK	(1 << 5)
 
 enum s2mpg10_irq {
+#define S2MPG10_IRQ_CHIP		0
+
 	/* PMIC */
 	S2MPG10_IRQ_PWRONF,
 	S2MPG10_IRQ_PWRONR,
@@ -183,6 +187,8 @@ enum s2mps11_irq {
 	S2MPS11_IRQ_NR,
 };
 
+#define S2MPS11_IRQ_CHIP		0
+
 #define S2MPS11_IRQ_PWRONF_MASK		(1 << 0)
 #define S2MPS11_IRQ_PWRONR_MASK		(1 << 1)
 #define S2MPS11_IRQ_JIGONBF_MASK	(1 << 2)
@@ -226,6 +232,8 @@ enum s2mps14_irq {
 	S2MPS14_IRQ_NR,
 };
 
+#define S2MPS14_IRQ_CHIP		0
+
 enum s2mpu02_irq {
 	S2MPU02_IRQ_PWRONF,
 	S2MPU02_IRQ_PWRONR,
@@ -250,6 +258,8 @@ enum s2mpu02_irq {
 	S2MPU02_IRQ_NR,
 };
 
+#define S2MPU02_IRQ_CHIP		0
+
 /* Masks for interrupts are the same as in s2mps11 */
 #define S2MPS14_IRQ_TSD_MASK		(1 << 2)
 
@@ -277,6 +287,8 @@ enum s2mpu05_irq {
 	S2MPU05_IRQ_NR,
 };
 
+#define S2MPU05_IRQ_CHIP		0
+
 #define S2MPU05_IRQ_PWRONF_MASK		BIT(0)
 #define S2MPU05_IRQ_PWRONR_MASK		BIT(1)
 #define S2MPU05_IRQ_JIGONBF_MASK	BIT(2)
@@ -321,6 +333,8 @@ enum s5m8767_irq {
 	S5M8767_IRQ_NR,
 };
 
+#define S5M8767_IRQ_CHIP		0
+
 #define S5M8767_IRQ_PWRR_MASK		(1 << 0)
 #define S5M8767_IRQ_PWRF_MASK		(1 << 1)
 #define S5M8767_IRQ_PWR1S_MASK		(1 << 3)

-- 
2.51.2


