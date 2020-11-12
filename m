Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92D22B02EC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 11:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgKLKk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 05:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgKLKkq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:46 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE281C0613D1;
        Thu, 12 Nov 2020 02:40:44 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id z1so2558404plo.12;
        Thu, 12 Nov 2020 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=algkSlHd9xkfYBolwCg/NlFH/Qse31ebTNBvgmeLrlQ=;
        b=p8bk+nmKSFWkl2/QhMWBU8QPK/uYeIgIKtq5OMDQUj2mMyQioK5Nk83g7qvV+im28+
         bn4Abg42K2nHukiyzYR2FWxIDx2m4rlRaRaS6zEkzpsTeWYmUXYUXf+gHmX6SZgB9GF2
         yepJ0pZZyGYbJQO06A5cKs6jUuQUu0lI0uQHPvLwSLph4X9xlqSWt4R1WUhRdUSMM0bs
         d2dVV8JleS6d1UG/BYiwton/HxI3ytdE81WzHAN9spVyEWFsHpkPAYDX1jOpNrsFLoZW
         mJVbg43uU/SwBlHkpM4nR9eF/OlsycnbKlZUhHY9JnrDxUuw+jLEQ+C2Aa5q9eqI0Ji4
         zhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=algkSlHd9xkfYBolwCg/NlFH/Qse31ebTNBvgmeLrlQ=;
        b=pYt5Y1RcnrWrwNlp/L5qjQ5HnN+gEqc21AUeiY7TQJJ1SKYqAwC7pkK4uKXTAKhnCn
         7i8WnzdwitgmMLGoUtYSMz9Shy0lL2q8b21xS9IfVEuSKYBjW71L2k8FeVE2g4or5igi
         ASfRRacIOaB0AlUeAkMLQjyO8Q5h1LP8a5DeMcua0ZU4fyT0++SPTW/6PqYiL8o5OYDX
         dP2WyCGuyPh7+4BYi/JCbd3HFvkRRjCE+c3rU43G9zrDyszvEjXFZ7uKafHwIEic4D69
         VdqlxPbl6t3hJhpFqHAyF9kyzk/Rqux+NKmDePYVB4T0SSjRpQUSmGVrE/L3E2yuD7gH
         kAHg==
X-Gm-Message-State: AOAM530t/67DbKIr5QWEI0H1856UAqHKnml/7/8vhazw39cqerRYh7TS
        ftIVmx+saCE2hXcpfhL0I8c=
X-Google-Smtp-Source: ABdhPJzaiS/rMlHBIj6j/OIZ7fIO3SYXFG15fig7ahQKNClWWUniD2E2NwKxev/dJVEOS1c8rPg55g==
X-Received: by 2002:a17:902:8303:b029:d7:eb0d:2ffd with SMTP id bd3-20020a1709028303b02900d7eb0d2ffdmr519608plb.78.1605177644610;
        Thu, 12 Nov 2020 02:40:44 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:44 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 11/11] mfd: mt6360: Remove MT6360 regulator of_compatible attribute
Date:   Thu, 12 Nov 2020 18:39:58 +0800
Message-Id: <1605177598-23501-12-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove MT6360 regulator of_compatible attribute because
MFD device should just instantiate the platform device.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 4bcfa7f..3b6490c 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -339,8 +339,7 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-chg"),
 	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
-	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
-		    NULL, 0, 0, "mediatek,mt6360-regulator"),
+	MFD_CELL_RES("mt6360-regulator", mt6360_regulator_resources),
 	OF_MFD_CELL("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
-- 
2.7.4

