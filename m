Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2D2B02D6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 11:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgKLKkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 05:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgKLKkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:20 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D9DC0613D1;
        Thu, 12 Nov 2020 02:40:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i13so3819841pgm.9;
        Thu, 12 Nov 2020 02:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuFh7v4DZWLJYDeYz2BQitAp+sMw0pW2PYhG2t9htnw=;
        b=IcWuSIKCZLcksR9lrAahz2mPNwRkx/fSgQeArXLiTuXXLAl3oHRhYeUpL4nifwyh92
         /XtfUTYAc4OETWVvkn+hPoBFSFDI8kDnMLW0K1AXo62qdowJ+l8SNEV0TRRxbtdSwyvf
         CtNd0l8nuXPnqsmrFpe/d/nT+s3ywg/CyxlWmog0yWc/Q9Hws+tg9vdVg8mhJwRi2sAx
         qvglKCskEiedDOTkdlvMJprn29ohhOeQogZpMqlnxIDvb2pifE59NDpmoIod34DgiKGJ
         NribVN3EpfsfDjFG8/uwDhnWeCp9oV+aKp70wQie6cXcrLeJswKex1Xw5BPWnelV/kL5
         59gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fuFh7v4DZWLJYDeYz2BQitAp+sMw0pW2PYhG2t9htnw=;
        b=XNi16Y9S4kO7z7/K1bC/wY5oCRTEDAWzNWyCpvrnb0kYmxDO3f5Ow/cF7b3fr4oOsA
         YCOizG0P3YAn89/E0HtHaf+qhfjU65Wqatmm1DCo8hwvQwC1W6kO0QbWG3muM1oaKkLY
         kx+wkgd3wonW88mgtE5dJ+qKY1lGneLMEGIFBmw0nsdWFAYPVLAPem2L2CZnP+ozLrc0
         +keR1CCYXhfuEZldHYxN5HQMlAFwjCz+YfuAbQ19YpT2/FgXJzMLwam/dKoyevbdtery
         3LMcrj/9F2c+xNO92eS6AOT/XW2RtLndiXO1E2NQTGQ4w2pVgrFgBrBKQfmfLhBnGiIH
         dr6Q==
X-Gm-Message-State: AOAM533dmnWvOh/cvBWr3yezWLW0NIHp8Wfo4j5s5RjZlbpOMHTNZpBn
        7cZS+RfqyQtemgb/5i+pfR4=
X-Google-Smtp-Source: ABdhPJw3cjZGAPK5XbQoBb0M17MOCtgKgaYhpxCg582yemDVGdn/EVDpUPFOUS6KnfxvVbEr1cPsXw==
X-Received: by 2002:a17:90a:ef8f:: with SMTP id m15mr8801957pjy.33.1605177619640;
        Thu, 12 Nov 2020 02:40:19 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:19 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
Date:   Thu, 12 Nov 2020 18:39:51 +0800
Message-Id: <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
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

