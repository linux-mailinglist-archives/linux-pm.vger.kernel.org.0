Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19992A944B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKFKZ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgKFKZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:25:57 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C1C0613CF;
        Fri,  6 Nov 2020 02:25:57 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so912670pfz.6;
        Fri, 06 Nov 2020 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=ADBSOuu5+RnTrJMu2JFScnn1lupC9Qpr98EKW+sFCRB/iyNTcmycd++3XsS5badlx5
         cZ63ZZnjBnEvctAmrVciN/Zxdn/UoQ6/THkDUpkIMmoFqS+bEHbrCIKIbuk9tBX9sVt3
         6xQAN24i3ZWvdr+dv2x55SjAtC67ulNMe4XiKEHEkq76W4KXTAp6cDFTyRx5Ibj0lGO4
         IefgxPWOhzcsTP9gdQWj6T2k6rttE1TS0bv0VSbs3yd+q7XHO/sReL2JIxM+aGBt+0tO
         CPyhp1UmLYWVnMWUjfvf+AkpuU9pLwh1oNbEIG0slAOrAnFk4rjhCtWpK5UQJgEGCbnY
         IDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Joo9G8dpZiV+ukJjlPwDuzRh/fKHk3sZ/ezTEfq1J4w=;
        b=PaZlzvlthk7B8QDD6e9LiGcxe0nSHSqx9pi50iQrGXZgIXU+vPAvaEne7o7Q7TLJva
         0MuqyIgRKyAZSrs4i6NomDB8WqbCj2eZcTUoUtOJzE76pSFP6SojeVO7V2ypltCXUxxQ
         5exbhhHJB1GaN2zpkB+hzWKq6O44ed+pTDrDfpYHXSnD7v1v1R8O/mcURHQrn1mhGbpp
         v3oaJUHR5SXA8xKy5n4dcFAwQwenP9NyJ5n7tsFaoRO3vIJXmekTOeNXpkJzC739z/Jl
         Xidghoy4eADWdFd01UCJ0S4GCsvc51N8w+OU7o06SSenINjP1uOYAbYu96oPeeT0Glib
         gG+g==
X-Gm-Message-State: AOAM530K94CWCti9q/Fp5WijwRAyMs88ikXdytX3PpRWvx9iNoMulXj5
        SLzziGk6O0cNgB6jgl0vzH8=
X-Google-Smtp-Source: ABdhPJwDw1g9l1Dk4zO9BznC3YRYdFgm86kmCLKvigqSg0L0ZtfYcEW0oSDfLrD1kggsd38y8ALvlQ==
X-Received: by 2002:a17:90a:ead3:: with SMTP id ev19mr1903770pjb.208.1604658356734;
        Fri, 06 Nov 2020 02:25:56 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.25.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:25:56 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 03/11] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Fri,  6 Nov 2020 17:53:44 +0800
Message-Id: <1604656432-10215-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
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

