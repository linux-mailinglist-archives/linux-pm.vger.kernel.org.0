Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C22A9446
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgKFK0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgKFK0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:26:11 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF60C0613CF;
        Fri,  6 Nov 2020 02:26:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h6so606745pgk.4;
        Fri, 06 Nov 2020 02:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sie6Ok4mlr9HWDpV1MC03OrgT3qnjwcXYjtFoY6fZME=;
        b=BicWgc2skITP6pCnRp+XYsBk/xqMSnzp7eK/v1Lu8Ftv82GrJTw3f8yEN0u/AdQw3C
         M37EzjjnJL425kb1Qhdmh5+ToMRA+C6EeOzRUd1hBN3JwJptJMyWHkYzE9Ushr50TLPB
         i41g7xbhZBlOFKiUFoqTmkdydxxHJ7+1+R+4SbBtR5boQnr00JdwCMulxASZC2xjdxGH
         wSMhJdWgQnEBJeJuAjrRDQH0faPd+NiOUMNSWIEeK0t0GKiLINpdvxGgXGLa/ZB3RxO5
         lnyMHgp+9uR8YT4LWCbXkpyexMezOm+VbbqiQjtllMNvkDXhbHClP7Pd53K2gS2zJzSM
         wPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sie6Ok4mlr9HWDpV1MC03OrgT3qnjwcXYjtFoY6fZME=;
        b=bEM+YnMtTIoCA1k9sdI211pdrTi3htsW0XPktyzzQxWpyuoDBm0XXSfGtYNsA/HGbG
         5HOOXbqsVrdghA2NMqLpv/pLIRU83RIvPZkIb3UdL4bPgbJ9BVwxWq3Pm70x7+SNp7cC
         z6vlFgNg5rHDVyHYZMwWfokOptM6WtKUOGSmV0wFkbcOifbPjhA2wXs2VPPKStnjPZGB
         FRnvdYu1Z9SBHAfKqKzvEO/Lr1abA9SY/dbZA9SAPjKlqRo7vT1HTAuJezYtb+QLgIyo
         AaGEyVhJA4otALJxtxZZSAY8b6VUcQakWUkefQCD/Y+/XVKwjwbZqRdsZuNXVkCqnx/B
         t2WA==
X-Gm-Message-State: AOAM533BqeYxam5aaoNzoHMG+tgOAfbilyb35xx/xaTMu6Arhc0qmhsf
        NAE4flofvBKNEFt1U1GUddA=
X-Google-Smtp-Source: ABdhPJxPb7Om9zddm/hHGndM/SdO0Qc71uSJYj8yWOvW/RYvx4INQsCpmbc3l5/cR5K5ejAGsNNyzA==
X-Received: by 2002:a17:90a:fa93:: with SMTP id cu19mr1854974pjb.117.1604658370559;
        Fri, 06 Nov 2020 02:26:10 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.26.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:26:10 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 07/11] mfd: mt6360: Remove handle_post_irq callback function
Date:   Fri,  6 Nov 2020 17:53:48 +0800
Message-Id: <1604656432-10215-8-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove handle_post_irq which is used to retrigger IRQ.
Set IRQ level low trigger in dtsi to keep IRQ always be handled.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c  | 17 ++++-------------
 include/linux/mfd/mt6360.h |  2 +-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index f75122b..2356d99 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -208,15 +208,8 @@ static const struct regmap_irq mt6360_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_LDO7_PGB_EVT, 8),
 };
 
-static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
-{
-	struct mt6360_ddata *ddata = irq_drv_data;
-
-	return regmap_update_bits(ddata->regmap,
-		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
-}
-
-static struct regmap_irq_chip mt6360_irq_chip = {
+static const struct regmap_irq_chip mt6360_irq_chip = {
+	.name = "mt6360_irqs",
 	.irqs = mt6360_irqs,
 	.num_irqs = ARRAY_SIZE(mt6360_irqs),
 	.num_regs = MT6360_PMU_IRQ_REGNUM,
@@ -225,7 +218,6 @@ static struct regmap_irq_chip mt6360_irq_chip = {
 	.ack_base = MT6360_PMU_CHG_IRQ1,
 	.init_ack_masked = true,
 	.use_ack = true,
-	.handle_post_irq = mt6360_pmu_handle_post_irq,
 };
 
 static const struct regmap_config mt6360_pmu_regmap_config = {
@@ -339,10 +331,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	mt6360_irq_chip.irq_drv_data = ddata;
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
-				       IRQF_TRIGGER_FALLING, 0,
-				       &mt6360_irq_chip, &ddata->irq_data);
+				       0, 0, &mt6360_irq_chip,
+				       &ddata->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
 		return ret;
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
index 81bca7c..ef8257d 100644
--- a/include/linux/mfd/mt6360.h
+++ b/include/linux/mfd/mt6360.h
@@ -230,7 +230,7 @@ struct mt6360_ddata {
 #define MT6360_PMU_MAXREG			MT6360_PMU_LDO_MASK2
 
 /* MT6360_PMU_IRQ_SET */
-#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
+#define MT6360_PMU_IRQ_REGNUM	16
 #define MT6360_IRQ_RETRIG	BIT(2)
 
 #define CHIP_VEN_MASK				0xF0
-- 
2.7.4

