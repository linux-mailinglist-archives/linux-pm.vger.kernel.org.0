Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF879EA2B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjIMN4Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbjIMN4Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 09:56:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1219BF
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 06:56:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D6C433CA;
        Wed, 13 Sep 2023 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694613379;
        bh=Q6WalZ8TpU7f6rAirYPjnlGFBA7Iavog/gfu/KD0rr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1ppQjTJo3S4b7S3L8DWA+RTwdkl4GgYwdRn2Wz7xSpS94DTcYJ0aueQoj25rWcnW
         RvxkdcF3S4m4fR542BA5h4YjMBec/nE0SkdYwORpEbWQZZqF2/FhDk3jeUWi9+ceh6
         jLZFUGpHIdl+970u+3SDTM/47ZV9gWaItYHKnMMDkx+9i+681QvACFkVV+kJ4hAsZg
         VEodejJjhDMsm1vvWYLLYJfWbHy1wWGu/A4U2EwZpIoWap4qYDz/EV6chOINuS8iTL
         ZXNARkfn/WYZT/hMY6ZorRbcDKS7IyorXtM+CGel6pBCoqnaUcyhR6ED63Oy0eA7kH
         fSKwdh6YUIE1g==
From:   Conor Dooley <conor@kernel.org>
To:     ulf.hansson@linaro.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        arnd@arndb.de, changhuang.liang@starfivetech.com,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Subject: [GIT PULL 5/5] pmdomain: starfive: Add JH7110 AON PMU support
Date:   Wed, 13 Sep 2023 14:54:28 +0100
Message-Id: <20230913-dude-imprecise-fc32622bc947@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4052; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5Q3tk4+W6UmElYB6O/7FZbKQ8pSZfsYJMQxdffVIkaw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmM+wW3FNppPxbr5vN92fxrQt807ne8/19t8l82e66pz +bCrOOGHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI3FVGhvOpse7Z846eTPN8 K1zNk1n764R3dNSNir33zQt+X/2cosjwv0LnqazhhosOOj3XXCte7Jg0WWWxw1/tsP2xcS8qNhj lcAAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Changhuang Liang <changhuang.liang@starfivetech.com>

Add AON PMU for StarFive JH7110 SoC. It can be used to turn on/off the
dphy rx/tx power switch.

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                            |  1 +
 drivers/pmdomain/starfive/jh71xx-pmu.c | 57 +++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d9e7d42412f..f1c34484c9b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20512,6 +20512,7 @@ F:	drivers/usb/cdns3/cdns3-starfive.c
 
 STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/pmdomain/starfive/jh71xx-pmu.c
diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
index 547cd3b9df11..2724bee7e85f 100644
--- a/drivers/pmdomain/starfive/jh71xx-pmu.c
+++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
@@ -2,7 +2,7 @@
 /*
  * StarFive JH71XX PMU (Power Management Unit) Controller Driver
  *
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
  */
 
 #include <linux/interrupt.h>
@@ -23,6 +23,9 @@
 #define JH71XX_PMU_EVENT_STATUS		0x88
 #define JH71XX_PMU_INT_STATUS		0x8C
 
+/* aon pmu register offset */
+#define JH71XX_AON_PMU_SWITCH		0x00
+
 /* sw encourage cfg */
 #define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
 #define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
@@ -159,6 +162,26 @@ static int jh7110_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 	return 0;
 }
 
+static int jh7110_aon_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+	val = readl(pmu->base + JH71XX_AON_PMU_SWITCH);
+
+	if (on)
+		val |= mask;
+	else
+		val &= ~mask;
+
+	writel(val, pmu->base + JH71XX_AON_PMU_SWITCH);
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	return 0;
+}
+
 static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
 {
 	struct jh71xx_pmu *pmu = pmd->pmu;
@@ -316,10 +339,12 @@ static int jh71xx_pmu_probe(struct platform_device *pdev)
 	if (!match_data)
 		return -EINVAL;
 
-	ret = match_data->pmu_parse_irq(pdev, pmu);
-	if (ret) {
-		dev_err(dev, "failed to parse irq\n");
-		return ret;
+	if (match_data->pmu_parse_irq) {
+		ret = match_data->pmu_parse_irq(pdev, pmu);
+		if (ret) {
+			dev_err(dev, "failed to parse irq\n");
+			return ret;
+		}
 	}
 
 	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
@@ -393,10 +418,31 @@ static const struct jh71xx_pmu_match_data jh7110_pmu = {
 	.pmu_set_state = jh7110_pmu_set_state,
 };
 
+static const struct jh71xx_domain_info jh7110_aon_power_domains[] = {
+	[JH7110_PD_DPHY_TX] = {
+		.name = "DPHY-TX",
+		.bit = 30,
+	},
+	[JH7110_PD_DPHY_RX] = {
+		.name = "DPHY-RX",
+		.bit = 31,
+	},
+};
+
+static const struct jh71xx_pmu_match_data jh7110_aon_pmu = {
+	.num_domains = ARRAY_SIZE(jh7110_aon_power_domains),
+	.domain_info = jh7110_aon_power_domains,
+	.pmu_status = JH71XX_AON_PMU_SWITCH,
+	.pmu_set_state = jh7110_aon_pmu_set_state,
+};
+
 static const struct of_device_id jh71xx_pmu_of_match[] = {
 	{
 		.compatible = "starfive,jh7110-pmu",
 		.data = (void *)&jh7110_pmu,
+	}, {
+		.compatible = "starfive,jh7110-aon-syscon",
+		.data = (void *)&jh7110_aon_pmu,
 	}, {
 		/* sentinel */
 	}
@@ -413,5 +459,6 @@ static struct platform_driver jh71xx_pmu_driver = {
 builtin_platform_driver(jh71xx_pmu_driver);
 
 MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
 MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
 MODULE_LICENSE("GPL");
-- 
2.39.2

