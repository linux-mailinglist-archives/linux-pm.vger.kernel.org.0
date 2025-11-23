Return-Path: <linux-pm+bounces-38410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398C7C7DE22
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 09:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5703A9A9F
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95A2C326F;
	Sun, 23 Nov 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/QC1nEc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03352C0262;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886985; cv=none; b=TGiJg+G5nHSacrQTaXpHJppiA2YpqXmLu7l9azuoBjY+aIhkbw2XoScaRQER8NHLROXK7vKa0s5d44dds+MFr6Pf/hdl5LYakBtrvBxJksH/xhN+Qxv6H5qjlMbvQ4s7qTY8U8KhhWzyCWVQbFVoR4re5cGxrNyZ/tbluKggYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886985; c=relaxed/simple;
	bh=XywpMBorThuIKgeGhgmqKn4VVOL6JzS6r+Dw3Lm+3d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D42z/BJzcy4L6H0NVC3X011r/Jsy+/zQLNNd3IcYjVVG2iRhdDhsUQlqo+/MntR94eXZHXiBuUR/rYf5ZItSxi0yEYt9xADwmRQWsqhyDhEl6RLmfsaU3Abx3m5BhQZ1uHfEzJvFqUWkI/uPHRAjGM8gI89VXyezWXZPWFQoqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/QC1nEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9161EC2BC9E;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886984;
	bh=XywpMBorThuIKgeGhgmqKn4VVOL6JzS6r+Dw3Lm+3d4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V/QC1nEcPQTwG9JdsiEwRV0U1JqdLDptZqAMBYHB41kEtyX3L2fYB6kUwlPgaKzuv
	 hGm05S2fVwgOU/FJNUz6usHvdAEp99DiRqTGm4QciJftBSkuH5we9RhCdOylSXokkj
	 RJ/7/hTKxxwJHNMwys0y+vuAat6uguT+jc94V5YZAGgxVve2VOUGfNc726P8OlcDMC
	 MqujKW1zAKq1bAL04pECILC8ebsP8LS1/5DMNKDkbt/rULH5QcwmppN45kHUYTs680
	 Jyi9YRy786cco16qnjR7HCWbwy/pVoUKrf21bINyH2qS6YFEmp3+3Kvfvg4Ak2YDzo
	 GKwR7bq83sLFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86336CFD313;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sun, 23 Nov 2025 08:35:51 +0000
Subject: [PATCH 4/6] mfd: max77759: modify irq configs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-max77759-charger-v1-4-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
In-Reply-To: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763886983; l=4037;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=ydOm266hojKPbD6WEKQRUV3ZGSm1ejU3wNAfglGRhno=;
 b=V5F8mWlubDiqVeB/Qx2PXvLfFRy1bZXHPRhI1RFtIE+oJ0pFc2cLyPkBnE4Kufu8NvwJsgyWT
 q5sdtKQKd+JDkFRFS2KdOYsKLKdNAoQm0EpFjoOIr8sEAt7k5C0bEGV
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Define specific bit-level masks for charger's registers and modify the
irq mask for charger irq_chip. Also, configure the max77759 interrupt
lines as active low to all interrupt registrations to ensure the
interrupt controllers are configured with the correct trigger type.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/mfd/max77759.c       | 24 +++++++++++++++++-------
 include/linux/mfd/max77759.h |  9 +++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
index 6cf6306c4a3b..5fe22884f362 100644
--- a/drivers/mfd/max77759.c
+++ b/drivers/mfd/max77759.c
@@ -256,8 +256,17 @@ static const struct regmap_irq max77759_topsys_irqs[] = {
 };
 
 static const struct regmap_irq max77759_chgr_irqs[] = {
-	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0, GENMASK(7, 0)),
-	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1, GENMASK(7, 0)),
+	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_1, 0,
+		       MAX77759_CHGR_REG_CHG_INT_AICL |
+		       MAX77759_CHGR_REG_CHG_INT_CHGIN |
+		       MAX77759_CHGR_REG_CHG_INT_CHG |
+		       MAX77759_CHGR_REG_CHG_INT_INLIM),
+	REGMAP_IRQ_REG(MAX77759_CHARGER_INT_2, 1,
+		       MAX77759_CHGR_REG_CHG_INT2_BAT_OILO |
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC |
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV |
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO |
+		       MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE),
 };
 
 static const struct regmap_irq_chip max77759_pmic_irq_chip = {
@@ -486,8 +495,8 @@ static int max77759_add_chained_irq_chip(struct device *dev,
 				     "failed to get parent vIRQ(%d) for chip %s\n",
 				     pirq, chip->name);
 
-	ret = devm_regmap_add_irq_chip(dev, regmap, irq,
-				       IRQF_ONESHOT | IRQF_SHARED, 0, chip,
+	ret = devm_regmap_add_irq_chip(dev, regmap, irq, IRQF_ONESHOT |
+				       IRQF_SHARED | IRQF_TRIGGER_LOW, 0, chip,
 				       data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add %s IRQ chip\n",
@@ -519,8 +528,9 @@ static int max77759_add_chained_maxq(struct i2c_client *client,
 
 	ret = devm_request_threaded_irq(&client->dev, apcmdres_irq,
 					NULL, apcmdres_irq_handler,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&client->dev), max77759);
+					IRQF_ONESHOT | IRQF_SHARED |
+					IRQF_TRIGGER_LOW, dev_name(&client->dev),
+					max77759);
 	if (ret)
 		return dev_err_probe(&client->dev, ret,
 				     "MAX77759_MAXQ_INT_APCMDRESI failed\n");
@@ -633,7 +643,7 @@ static int max77759_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, -EINVAL,
 				     "invalid IRQ: %d\n", client->irq);
 
-	irq_flags = IRQF_ONESHOT | IRQF_SHARED;
+	irq_flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW;
 	irq_flags |= irqd_get_trigger_type(irq_data);
 
 	ret = devm_regmap_add_irq_chip(&client->dev, max77759->regmap_top,
diff --git a/include/linux/mfd/max77759.h b/include/linux/mfd/max77759.h
index c6face34e385..0ef29a48deec 100644
--- a/include/linux/mfd/max77759.h
+++ b/include/linux/mfd/max77759.h
@@ -62,7 +62,16 @@
 #define MAX77759_CHGR_REG_CHG_INT               0xb0
 #define MAX77759_CHGR_REG_CHG_INT2              0xb1
 #define MAX77759_CHGR_REG_CHG_INT_MASK          0xb2
+#define MAX77759_CHGR_REG_CHG_INT_AICL          BIT(7)
+#define MAX77759_CHGR_REG_CHG_INT_CHGIN         BIT(6)
+#define MAX77759_CHGR_REG_CHG_INT_CHG           BIT(4)
+#define MAX77759_CHGR_REG_CHG_INT_INLIM         BIT(2)
 #define MAX77759_CHGR_REG_CHG_INT2_MASK         0xb3
+#define MAX77759_CHGR_REG_CHG_INT2_BAT_OILO     BIT(4)
+#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CC   BIT(3)
+#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_CV   BIT(2)
+#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_TO   BIT(1)
+#define MAX77759_CHGR_REG_CHG_INT2_CHG_STA_DONE BIT(0)
 #define MAX77759_CHGR_REG_CHG_INT_OK            0xb4
 #define MAX77759_CHGR_REG_CHG_DETAILS_00        0xb5
 #define MAX77759_CHGR_REG_CHG_DETAILS_01        0xb6

-- 
2.52.0.rc2.455.g230fcf2819-goog



