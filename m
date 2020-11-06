Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA62A9439
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgKFK0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgKFK0O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:26:14 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456EDC0613D2;
        Fri,  6 Nov 2020 02:26:14 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so913331pfz.6;
        Fri, 06 Nov 2020 02:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qvf5AIpXJgqzY8DsXinh6oVuEtLC89N/j7eeRIAQsYI=;
        b=f9vF4b9dp3uQme/w5xY/cT51qwABCSLiZX0aX49VsQm++wIeZYE407fmgwubudfJLk
         QJ8cNtrVP9/wy81aJxslXnfybgOWGAfQ9/sCET4KNNe2Uh85cVsVTs9Vo/HoubhjMjei
         ZfPAOgHbHITJIP9oNZTKf3UDBMYAfgH5pG8d8wsixp7qYnWWdDPk9CABZA2GfhMOKMNl
         CLvjJ/74CClkSSauGI20HLwvHkOwzfnE3ueFWjqysaL6/7jA/ooaXEUmGRMbE9oh/EzO
         1hTnboRRcmDRAA3+JYO3zMvWjcOpp8Cocu4mdv/vpCQ/6mZRt9+zVeg6b/Fu/96xWrmm
         v6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qvf5AIpXJgqzY8DsXinh6oVuEtLC89N/j7eeRIAQsYI=;
        b=AkNOBWyzCgfmkggUJoPPDdU1sdbuHN5k9I1umk/RRVYvyifkqrKA+vifLQ148jIYdX
         FGop/Sbq68A9ATZbkSrD/fJ5xHwxhDjIxT3zJKK9sJc4BRUrYrndHowZIepRPvxlh+jc
         3F37zLCSptDVW+qq77TSk2+4Fmm5RVjZ3rQ7jp5XaVAq7EPkjbU5TdACvnoJQwpSuOim
         mhvgmnBNR1MDrKBGD1X3u/o/fkQx10TDE9X0/8dOo5P2MwW1aQ15d7tIZhkJ8a0I+egq
         pUIvV/MC+ZC/UHaRgwuebkx+/JqCwKAeJQ6TTJGy0Yqv+HivyTiBwkCHaVrKt7vgK8Ms
         DATQ==
X-Gm-Message-State: AOAM531gVhel02mFbycggvwiHYHJ+LYwvan2HP9tTojhHjQxPg9nPr+n
        dnbqgdMP2Dgr9nhLDuChsEE=
X-Google-Smtp-Source: ABdhPJw3RoUtfD0nlIQkGpZcbnul2ZU/MO5sxigtfBfXTBbjasXQsPDV4OuFCere+q5Q5cbZ8qOq2g==
X-Received: by 2002:a17:90a:e2cb:: with SMTP id fr11mr1833112pjb.158.1604658373956;
        Fri, 06 Nov 2020 02:26:13 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.26.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:26:13 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 08/11] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Fri,  6 Nov 2020 17:53:49 +0800
Message-Id: <1604656432-10215-9-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 2356d99..de002fe 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
+		dev_err(ddata->dev, "Device not supported\n");
+		return -ENODEV;
+	}
+
+	ddata->chip_rev = info & CHIP_REV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_ddata *ddata;
-	unsigned int reg_data;
 	int i, ret;
 
 	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
@@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
-	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
+	ret = mt6360_check_vendor_info(ddata);
+	if (ret)
 		return ret;
-	}
-
-	ddata->chip_rev = reg_data & CHIP_REV_MASK;
-	if (ddata->chip_rev != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
-	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       0, 0, &mt6360_irq_chip,
-- 
2.7.4

