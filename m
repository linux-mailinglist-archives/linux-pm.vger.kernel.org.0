Return-Path: <linux-pm+bounces-35484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14714BA4A9B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC60176CD5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6512FABE6;
	Fri, 26 Sep 2025 16:34:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C323506F;
	Fri, 26 Sep 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904476; cv=none; b=s1TyUQy/x/tgPFGsw2oDvkoxbyqto5XJIKwN4tDWXJXY4zY6UxnfRltY6h0xkz3MlUGsUKbGFicsFjEkuTnd6ONvCXO6dLkGZ+xnV/9tcnJnyUlxtW5kROqYamFCX20SYdUbKcgNBaf64Yt8XMEMVpJ38znPkO6HhlkRt8P2trE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904476; c=relaxed/simple;
	bh=AZlUcOk3yWypTJbdqtn01NgPo10tnHCQOEM37R4XTQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fS6KWBDIKYtOD3oRHyozOAa60OFLpDD9n/DF5Ys2ucqaqmnpiiDhaWTEFzDAY0aNR0xj1WlCJSeWCDr/uU2W6MN3d9ikOTZ1J17roKRGXp6DvA5UOsTeWTCXQTUaz5iuhQByFlb+FncdsuuiYQn/GsFvdsqpt2iPAr8BfU04uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id C1BF61C24F2;
	Fri, 26 Sep 2025 18:27:08 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf8:0:ec51:b786:a581:3dd1])
	by srv01.abscue.de (Postfix) with ESMTPSA id A85EB1C2509;
	Fri, 26 Sep 2025 18:27:07 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Fri, 26 Sep 2025 18:23:26 +0200
Subject: [PATCH 4/5] power: reset: sc27xx: Add support for SC2730 and OF
 match table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-sc2730-reboot-v1-4-62ebfd3d31bb@abscue.de>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
In-Reply-To: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Add register definitions for the SC2730 PMIC. Introduce a new struct
sc27xx_poweroff_data for passing register information to the poweroff
handler. Implement device tree matching to distinguish between SC2730
and SC2731 and to probe the driver automatically.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/power/reset/sc27xx-poweroff.c | 67 +++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 20eb9f32cb2b99adeb16502172adf9d6257cd05f..5937f40021817ea38453705fcef6485ce79ac14c 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -7,16 +7,33 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/syscore_ops.h>
 
-#define SC27XX_PWR_PD_HW	0xc2c
+#define SC2730_PWR_PD_HW	0x1820
+#define SC2730_SLP_CTRL		0x1a48
+#define SC2730_LDO_XTL_EN	BIT(2)
+
+#define SC2731_PWR_PD_HW	0xc2c
+#define SC2731_SLP_CTRL		0xdf0
+#define SC2731_LDO_XTL_EN	BIT(3)
+
 #define SC27XX_PWR_OFF_EN	BIT(0)
-#define SC27XX_SLP_CTRL		0xdf0
-#define SC27XX_LDO_XTL_EN	BIT(3)
+
+struct sc27xx_poweroff_reg_info {
+	u32 poweroff_reg;
+	u32 slp_ctrl_reg;
+	u32 ldo_xtl_en;
+};
+
+struct sc27xx_poweroff_data {
+	struct regmap *regmap;
+	const struct sc27xx_poweroff_reg_info *regs;
+};
 
 /*
  * On Spreadtrum platform, we need power off system through external SC27xx
@@ -45,12 +62,14 @@ static struct syscore_ops poweroff_syscore_ops = {
 
 static int sc27xx_poweroff_do_poweroff(struct sys_off_data *off_data)
 {
-	struct regmap *regmap = off_data->cb_data;
+	struct sc27xx_poweroff_data *data = off_data->cb_data;
 
 	/* Disable the external subsys connection's power firstly */
-	regmap_write(regmap, SC27XX_SLP_CTRL, SC27XX_LDO_XTL_EN);
+	regmap_write(data->regmap, data->regs->slp_ctrl_reg,
+		     data->regs->ldo_xtl_en);
 
-	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
+	regmap_write(data->regmap, data->regs->poweroff_reg,
+		     SC27XX_PWR_OFF_EN);
 
 	mdelay(1000);
 
@@ -61,10 +80,18 @@ static int sc27xx_poweroff_do_poweroff(struct sys_off_data *off_data)
 
 static int sc27xx_poweroff_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap;
+	struct sc27xx_poweroff_data *data;
 
-	regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!regmap)
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regs = of_device_get_match_data(&pdev->dev);
+	if (!data->regs)
+		return -EINVAL;
+
+	data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!data->regmap)
 		return -ENODEV;
 
 	register_syscore_ops(&poweroff_syscore_ops);
@@ -73,13 +100,33 @@ static int sc27xx_poweroff_probe(struct platform_device *pdev)
 					     SYS_OFF_MODE_POWER_OFF,
 					     SYS_OFF_PRIO_DEFAULT,
 					     sc27xx_poweroff_do_poweroff,
-					     regmap);
+					     data);
 }
 
+static const struct sc27xx_poweroff_reg_info sc2730_pwr_regs = {
+	.poweroff_reg = SC2730_PWR_PD_HW,
+	.slp_ctrl_reg = SC2730_SLP_CTRL,
+	.ldo_xtl_en = SC2730_LDO_XTL_EN,
+};
+
+static const struct sc27xx_poweroff_reg_info sc2731_pwr_regs = {
+	.poweroff_reg = SC2731_PWR_PD_HW,
+	.slp_ctrl_reg = SC2731_SLP_CTRL,
+	.ldo_xtl_en = SC2731_LDO_XTL_EN,
+};
+
+static const struct of_device_id sc27xx_poweroff_of_match[] = {
+	{ .compatible = "sprd,sc2730-poweroff", .data = &sc2730_pwr_regs },
+	{ .compatible = "sprd,sc2731-poweroff", .data = &sc2731_pwr_regs },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sc27xx_poweroff_of_match);
+
 static struct platform_driver sc27xx_poweroff_driver = {
 	.probe = sc27xx_poweroff_probe,
 	.driver = {
 		.name = "sc27xx-poweroff",
+		.of_match_table = sc27xx_poweroff_of_match,
 	},
 };
 module_platform_driver(sc27xx_poweroff_driver);

-- 
2.50.0


