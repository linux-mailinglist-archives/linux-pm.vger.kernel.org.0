Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFE2A9431
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKFK0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgKFK0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:26:00 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E6C0613CF;
        Fri,  6 Nov 2020 02:26:00 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so574045pgg.13;
        Fri, 06 Nov 2020 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuFh7v4DZWLJYDeYz2BQitAp+sMw0pW2PYhG2t9htnw=;
        b=XWZnoAnwIDjQYp2IpX38lwNk1lT8pCUa7EHvuc6n5L4gTVgt5Lub40ihU/sA9Ko4ls
         DQpn4gTLkh4AwnVPuQZ8yfEXBR0VowaGhzTCKaiF1jM0w7ylT62YfnZcPD33KCqUcstm
         7nZShXc8vOG0fs3a9ytA1U1yhBYCKEZi5eLk8GbGYmT9wZxFGIfSKUEB3eApr0CpXPIc
         0O/Ez6mapBaHXgOC6aqOou9+cHL2XEIy8zJgTLrjSvnhYgWLQJT8QHNaWqYURR5n1uHR
         uyAdGeV7dYouozaUrBc8S9zRu8+JQxn2QZsKH0wllhhXVxmxo9A814/Krc04IgEJKbLU
         jmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fuFh7v4DZWLJYDeYz2BQitAp+sMw0pW2PYhG2t9htnw=;
        b=k152L6nOFZ487AKz1QzUJRMBEV9d27wQUs5e2HE9yt4WLcMRQl1qGo6g9SbeQrkzVt
         L4UEwP0RMprpRICliZMz6fu6vtUXNa/1gHodbPHrX1seI0XPcPBBtaclxDZyG7NPDNVJ
         RPFR1z05I5c5HHCLyp2fyRsRLQks998gzz54rPQt02B3ewlesrbV9HG7xBo9oNrESNx6
         z1P+5dj5vya2aw3FMjsWRpGE0n4XYZ85ebhJ7ONxeM1ADaXyZYeE9aKjFhITv3d+3X+c
         jKHtD6UQ0aEA5HbkD5qjTj+A++d7QnG27sT5UlkQG+tPFFqCosX7X5/2NFNZOPRG3saJ
         EkTw==
X-Gm-Message-State: AOAM531uZ8qwq/P6GS3h95bPk0oI1MBdEnttcWZ/B1Dl7DQX3TUITloM
        sEV3TBqPlpFDC17P/Q5mS9sg5nfqVLU=
X-Google-Smtp-Source: ABdhPJyhCMDQFDtdya5cGi/9aSMCufl+wRVtBNsdnZ38043nELmi95m21T/BFPpJWSserEN4c04vGA==
X-Received: by 2002:aa7:8d05:0:b029:18b:6f5f:1ea with SMTP id j5-20020aa78d050000b029018b6f5f01eamr1326589pfe.38.1604658360209;
        Fri, 06 Nov 2020 02:26:00 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.25.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:25:59 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
Date:   Fri,  6 Nov 2020 17:53:45 +0800
Message-Id: <1604656432-10215-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Combine mt6360 pmic/ldo resources into mt6360 regulator resources
to simplify the similar resources object.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 692e47b..5119e51 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
 };
 
-static const struct resource mt6360_pmic_resources[] = {
+static const struct resource mt6360_regulator_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
@@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
-};
-
-static const struct resource mt6360_ldo_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
@@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-chg"),
 	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
-	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360-pmic"),
-	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
+		    NULL, 0, 0, "mediatek,mt6360-regulator"),
 	OF_MFD_CELL("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
-- 
2.7.4

