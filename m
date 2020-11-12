Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989D2B02DD
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 11:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKLKkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 05:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgKLKkb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF8C0613D1;
        Thu, 12 Nov 2020 02:40:31 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so3807629pgg.12;
        Thu, 12 Nov 2020 02:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sie6Ok4mlr9HWDpV1MC03OrgT3qnjwcXYjtFoY6fZME=;
        b=D9P9G1EN0gBjFJZ20r3j443MLAy90bjBcHZLPm6smgG9L7aWDPg3zdv3AF3oLppBAR
         mQhNjeF1uXbsA4JM8PjDFysG4Lj6tLVYz2nqZBeB+FF8n7d5rE14rhF6aB2Z8kS3W9s9
         gGLuirLw5zt4OXsjQmkluM6J+psGCDbNumtclcN+u49JArpQhUtyfdBh0SJuTh5rG58L
         l5SOMFT8e/kgvPkwEKyxaSmzNqry+FpBW6SM/LNlF2yTjXHPFaeAFltbtgHhrBCbW8lr
         PBbDhqOJSixtXqhY50oA2e4dnT8qfS300JV7BQU8bkKTk/ynMdJUEzLJhviYEPNFSz93
         EpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sie6Ok4mlr9HWDpV1MC03OrgT3qnjwcXYjtFoY6fZME=;
        b=pZ6Z3nEfq9dWzPOS+vvRIS8VF+F/5bo9EmtLJ1OIwl5owzghhk4snl9u+jSGrXT3kd
         OiFvBK7zqep5v3dPgVsa2F+Zlmg2x8WLj0UhQC9+qs930NKL/+EVr46aNVmrw2UmhiXC
         0R8eTEHPaHOB8JkyofY4mV8OlNc+1XNiF6Yh/cEchLplOdfiHyEHHvBCiPxHUZ5XjT5k
         wKpxH93ckfk/Ql7+yYoqa5IXfGQx9adKVa/rNjFRfTWXDBG71cy/KTt/o7f7Q2cLpWx8
         wScm/W+X1IVEjDjMOI6tMq4XQ1ngYlfyqft7TY3JAjT5+nZmhAKVFm7aUiPvGcFDhsmK
         zTmw==
X-Gm-Message-State: AOAM5303fCfRWIRZyLhjS+fUyipYIbM0JA/F5o/46DMBIXNU1kCDR3ac
        Ly6aBSIk5jBjsU9w4glDFAI=
X-Google-Smtp-Source: ABdhPJy3nqPyjYyErPxYPd056molaMzmU3FDWGZuUnK7QDSMkTSHTLqvBq9Zase7O8PNkTQt872JBQ==
X-Received: by 2002:a62:7656:0:b029:18b:c0f:1b7a with SMTP id r83-20020a6276560000b029018b0c0f1b7amr27239846pfc.80.1605177630745;
        Thu, 12 Nov 2020 02:40:30 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:30 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 07/11] mfd: mt6360: Remove handle_post_irq callback function
Date:   Thu, 12 Nov 2020 18:39:54 +0800
Message-Id: <1605177598-23501-8-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
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

