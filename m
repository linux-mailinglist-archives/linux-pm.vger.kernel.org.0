Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27F122CDB8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgGXSZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGXSZU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:25:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B899220737;
        Fri, 24 Jul 2020 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615119;
        bh=J8z6oVAg3btfniOa2wnidzkIdsuFVW7F3x0Ka94YABs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnA/D46Bizoe+ctnQKNGUrfUejSOEzP/vDhyKoS5C99/7PTwMsSSgcgAujh++pmrz
         B0pagyHbuQEvnepwsRzCxyE3kEjt5D9z9HsXbma2TyLzMZjT+AsUQLk34Larw8WF5T
         ROuIDPDjEXI9a7IOHgSWq+a6Ods4cZej2GFqC2do=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/16] memory: samsung: exynos-srom: Correct alignment
Date:   Fri, 24 Jul 2020 20:23:27 +0200
Message-Id: <20200724182328.3348-16-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Align indentation with open parenthesis (or fix existing alignment).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/exynos-srom.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 6510d7bab217..e73dd330af47 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -47,9 +47,9 @@ struct exynos_srom {
 	struct exynos_srom_reg_dump *reg_offset;
 };
 
-static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
-		const unsigned long *rdump,
-		unsigned long nr_rdump)
+static struct exynos_srom_reg_dump *
+exynos_srom_alloc_reg_dump(const unsigned long *rdump,
+			   unsigned long nr_rdump)
 {
 	struct exynos_srom_reg_dump *rd;
 	unsigned int i;
@@ -116,7 +116,7 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	}
 
 	srom = devm_kzalloc(&pdev->dev,
-			sizeof(struct exynos_srom), GFP_KERNEL);
+			    sizeof(struct exynos_srom), GFP_KERNEL);
 	if (!srom)
 		return -ENOMEM;
 
@@ -130,7 +130,7 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, srom);
 
 	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
-			ARRAY_SIZE(exynos_srom_offsets));
+						      ARRAY_SIZE(exynos_srom_offsets));
 	if (!srom->reg_offset) {
 		iounmap(srom->reg_base);
 		return -ENOMEM;
@@ -157,16 +157,16 @@ static int exynos_srom_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PM_SLEEP
 static void exynos_srom_save(void __iomem *base,
-				    struct exynos_srom_reg_dump *rd,
-				    unsigned int num_regs)
+			     struct exynos_srom_reg_dump *rd,
+			     unsigned int num_regs)
 {
 	for (; num_regs > 0; --num_regs, ++rd)
 		rd->value = readl(base + rd->offset);
 }
 
 static void exynos_srom_restore(void __iomem *base,
-				      const struct exynos_srom_reg_dump *rd,
-				      unsigned int num_regs)
+				const struct exynos_srom_reg_dump *rd,
+				unsigned int num_regs)
 {
 	for (; num_regs > 0; --num_regs, ++rd)
 		writel(rd->value, base + rd->offset);
@@ -177,7 +177,7 @@ static int exynos_srom_suspend(struct device *dev)
 	struct exynos_srom *srom = dev_get_drvdata(dev);
 
 	exynos_srom_save(srom->reg_base, srom->reg_offset,
-				ARRAY_SIZE(exynos_srom_offsets));
+			 ARRAY_SIZE(exynos_srom_offsets));
 	return 0;
 }
 
@@ -186,7 +186,7 @@ static int exynos_srom_resume(struct device *dev)
 	struct exynos_srom *srom = dev_get_drvdata(dev);
 
 	exynos_srom_restore(srom->reg_base, srom->reg_offset,
-				ARRAY_SIZE(exynos_srom_offsets));
+			    ARRAY_SIZE(exynos_srom_offsets));
 	return 0;
 }
 #endif
-- 
2.17.1

