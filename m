Return-Path: <linux-pm+bounces-35481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BE2BA4A77
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724724C0AB9
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC262ECD13;
	Fri, 26 Sep 2025 16:34:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FE2BE7A0;
	Fri, 26 Sep 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904475; cv=none; b=JY6OqOnRGrbxKNID5FQawRYJzOOMLmoo6tpiq1tUV/KuAyrBcgipDOoCK1nplElLtfP91MbVKW9fanRxvwuCIaQ/BDy8qtjqdNV1KHYnFk9VTbcxZYyO8jDYz55rUN9jmeRRj7+9GGImlZwrLKb2rXM5f6qaQ2bRECtUV2GyPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904475; c=relaxed/simple;
	bh=FtRZJ7yjU3jMPC+zB+Ol2wV3rFXTZyfaPut+5IasyA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6TWs/qN0DA0qEuN19f8lwoNSz7hGOe/HQEdnYMS0dbun96RYQMrovbyUgHklovmIpSFP4a6LOqZuBJx3rg2rF1Kjz6ZHjwRglZtOAOJFY3vBfH6AX6Af4i7OzGuA53blh186alRheD7z838HL8yOyGI4t826DN5Y0tu5lzFTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 863DC1C250B;
	Fri, 26 Sep 2025 18:27:08 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf8:0:ec51:b786:a581:3dd1])
	by srv01.abscue.de (Postfix) with ESMTPSA id 29CD31C2507;
	Fri, 26 Sep 2025 18:27:07 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Fri, 26 Sep 2025 18:23:25 +0200
Subject: [PATCH 3/5] power: reset: sc27xx: Use
 devm_register_sys_off_handler
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-sc2730-reboot-v1-3-62ebfd3d31bb@abscue.de>
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

Use the new device life-cycle managed register function to remove the
need for global variables in the driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/power/reset/sc27xx-poweroff.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 90287c31992c4889f9241e82a21a1949ecca7702..20eb9f32cb2b99adeb16502172adf9d6257cd05f 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/syscore_ops.h>
 
@@ -17,8 +18,6 @@
 #define SC27XX_SLP_CTRL		0xdf0
 #define SC27XX_LDO_XTL_EN	BIT(3)
 
-static struct regmap *regmap;
-
 /*
  * On Spreadtrum platform, we need power off system through external SC27xx
  * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
@@ -44,26 +43,37 @@ static struct syscore_ops poweroff_syscore_ops = {
 	.shutdown = sc27xx_poweroff_shutdown,
 };
 
-static void sc27xx_poweroff_do_poweroff(void)
+static int sc27xx_poweroff_do_poweroff(struct sys_off_data *off_data)
 {
+	struct regmap *regmap = off_data->cb_data;
+
 	/* Disable the external subsys connection's power firstly */
 	regmap_write(regmap, SC27XX_SLP_CTRL, SC27XX_LDO_XTL_EN);
 
 	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to poweroff system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int sc27xx_poweroff_probe(struct platform_device *pdev)
 {
-	if (regmap)
-		return -EINVAL;
+	struct regmap *regmap;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
 		return -ENODEV;
 
-	pm_power_off = sc27xx_poweroff_do_poweroff;
 	register_syscore_ops(&poweroff_syscore_ops);
-	return 0;
+
+	return devm_register_sys_off_handler(&pdev->dev,
+					     SYS_OFF_MODE_POWER_OFF,
+					     SYS_OFF_PRIO_DEFAULT,
+					     sc27xx_poweroff_do_poweroff,
+					     regmap);
 }
 
 static struct platform_driver sc27xx_poweroff_driver = {

-- 
2.50.0


