Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748F02B02F1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 11:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgKLKlH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 05:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgKLKkS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:18 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA8C0613D4;
        Thu, 12 Nov 2020 02:40:16 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d3so2573178plo.4;
        Thu, 12 Nov 2020 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=czMr9crAC8WMcP2/QbgsRI+K4Ts4D3inkQI5zWQNVM/JK1i7wEy6hXYfg0Wz2Ml3S5
         ldH+6yEjqD50Cb10R8EAc2IpU72fzEyMJyRWEfFZ3GG/KueZ/Wln3t578DdoSY2a8XfB
         qjggAiEffdKX8w/msTfORYXhndxrUSYlHvDbq+3TJIO8x3WAdhq7tZfY/kCSgw+IuomT
         RqGLHhlM8GKCtGAMzka+PCORAAOMhomQ8FV/ZdokA9FuhWxGfxaF+2EP6W2V/BDEpx6i
         Vp1juQRPo1OzoCXUdg+HdhfjjeeGHbgT0GAfn4GcilneuTvhCEX8CeWuske+jdqQBU5a
         uwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=k/sXzaJAk9myI5LBpx/zU4Om8stG/xMt3nT2Xf7HDn8Ozmob1ivBme28swcksqRcyI
         +fpzSKxoCvzBbbkzUefkdxx0fVtcu6VgYTvbGZI/vpg4MAakV+9C2du0JHF7LH3AP+7q
         n1xhHQN3Bj5BcMRafn6YUZFOR6FylmdN6xSWZfcgRw7XlJ4qsyCzpuicQnsj4P8xdBeZ
         6XsiByNzopnHnDWFG1XN4eT/0KmVlyjBb+I/PZSj9VGolTR4whHvjl4i2h5S/w0lV55F
         PreWtdV+kmw2sjtvEZTy+dS1WU1FPNUZOn/FSkmbAuaXjzED4Ar8Hm2yP1F23hIikrUL
         RgvA==
X-Gm-Message-State: AOAM530oOypeux90jnrnK5mY0Agi84z6Fnzr7WYVdZb/y0VhVfnQ2Bgw
        LFh9RJZrH0j0jOk8toKou8E=
X-Google-Smtp-Source: ABdhPJyXWp7+YEx8zS4eMR0ZOG+1ERxpsJYGed4QYsgO5CG7iquGGk9Mr+y2+wPghWzKIRq9hmd4dg==
X-Received: by 2002:a17:902:c254:b029:d6:ac10:6d50 with SMTP id 20-20020a170902c254b02900d6ac106d50mr26694127plg.48.1605177615949;
        Thu, 12 Nov 2020 02:40:15 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:15 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 03/11] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Thu, 12 Nov 2020 18:39:50 +0800
Message-Id: <1605177598-23501-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Indicate sub-dev compatible name by using "-".

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index befee70..692e47b 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -292,18 +292,18 @@ static const struct resource mt6360_ldo_resources[] = {
 };
 
 static const struct mfd_cell mt6360_devs[] = {
-	OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
-		    NULL, 0, 0, "mediatek,mt6360_adc"),
-	OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
-		    NULL, 0, 0, "mediatek,mt6360_chg"),
-	OF_MFD_CELL("mt6360_led", mt6360_led_resources,
-		    NULL, 0, 0, "mediatek,mt6360_led"),
-	OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360_pmic"),
-	OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360_ldo"),
-	OF_MFD_CELL("mt6360_tcpc", NULL,
-		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
+	OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
+		    NULL, 0, 0, "mediatek,mt6360-adc"),
+	OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
+		    NULL, 0, 0, "mediatek,mt6360-chg"),
+	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
+		    NULL, 0, 0, "mediatek,mt6360-led"),
+	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
+		    NULL, 0, 0, "mediatek,mt6360-pmic"),
+	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
+		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-tcpc", NULL,
+		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-- 
2.7.4

