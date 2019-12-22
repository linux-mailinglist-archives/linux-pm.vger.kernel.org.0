Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489C8128F86
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLVSur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42615 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfLVSuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so7691401pgb.9;
        Sun, 22 Dec 2019 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Ke6kqD8tx5FW4sG+uR1d5yqGchz/JTf5FhvZT4do5s=;
        b=pA1DVikadxBfRY27jeihducxVZcsjiRL9ghBfctBvs6ZO4Nzw9RcFo8JL+vI3Ob2qO
         kfIWVtELyEWwbBFrmQuS9TlUXJoI2ZXaMgUjM2+QNtQs4gAxN39H09VpPJORgdD3S+ae
         UJ/S6SJGnD9CQnsPAL9ZW6q8lDL8kN+6/dMakPkxmTf6qZKTASfCXAnE6acSiGCsjfzB
         YGsQ6Wdm+2dRzZuiUnASU3cJQ8W/hVWCvSgoHW8d1VY8rb/FdZlFx+sm2T91etppHTAC
         zmb2tZ4GKc3cf2UlfJNNAy4JooFD/sozpspHVhsH6swJLMP25eGYU25CYBDdskeJKtIR
         /oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Ke6kqD8tx5FW4sG+uR1d5yqGchz/JTf5FhvZT4do5s=;
        b=Kx8ydbSf6sUVOPlcnIfUbM1GWyUvmGNIPF39njZgx061ppKyah0HBbhRnGxEJXq0d0
         wJZQHXyAKx67/CKaRTpDtpInMb9QVuN0HGToAdvtkzqQ0KsOp7u27Y/ru9zJAx8H6xUE
         2dTOAp+MHQtLwcXz6CIfu0/DLd3CSqcW6ElXXBJ8AydnWLb2lpEXzq+F3uJ9QjWeNQSS
         KSqBgb2tt8Zv74NkqjWFrAvix54JTQi+3WQYirtThIjlS/B2qykfApA7uZMozAOYBMIY
         3ivdAl0Zv8+dMUzoIAbgTQHc6RgQKq/9t9uzL5wxaiCxoghnjzRHMzRq3SNiAZ2UAlPW
         wG5g==
X-Gm-Message-State: APjAAAXLpga9xj9K+D4jwzsV4biJvGKegLklFISqKojQ7/R1zzk4csBA
        MPpkwhtIHnPPgapVJkO0t5U=
X-Google-Smtp-Source: APXvYqwpM2sa3hdG1WNZtPR1Q7FDppkkNNMGcWgtij5ugBsoXwFPTfryKohmVTiLz+00EJ9OPdBpLA==
X-Received: by 2002:a62:2643:: with SMTP id m64mr14416885pfm.123.1577040645578;
        Sun, 22 Dec 2019 10:50:45 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s24sm11628635pjp.17.2019.12.22.10.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:45 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ssantosh@kernel.org, paul@crapouillou.net, matthias.bgg@gmail.com,
        rogerq@ti.com, tony@atomide.com, lukasz.luba@arm.com,
        kgene@kernel.org, krzk@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, allison@lohutok.net, tglx@linutronix.de,
        yong.wu@mediatek.com, jroedel@suse.de, evgreen@chromium.org,
        rfontana@redhat.com, digetx@gmail.com, pdeschrijver@nvidia.com,
        john@phrozen.org, alexios.zavras@intel.com, sboyd@kernel.org,
        kstewart@linuxfoundation.org, info@metux.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 5/9] memory: fsl-corenet-cf: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:30 +0000
Message-Id: <20191222185034.4665-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222185034.4665-1-tiny.windzz@gmail.com>
References: <20191222185034.4665-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/fsl-corenet-cf.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index 0b0ed72016da..2c62312ea513 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -172,7 +172,6 @@ static irqreturn_t ccf_irq(int irq, void *dev_id)
 static int ccf_probe(struct platform_device *pdev)
 {
 	struct ccf_private *ccf;
-	struct resource *r;
 	const struct of_device_id *match;
 	u32 errinten;
 	int ret, irq;
@@ -185,13 +184,7 @@ static int ccf_probe(struct platform_device *pdev)
 	if (!ccf)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
-		return -ENXIO;
-	}
-
-	ccf->regs = devm_ioremap_resource(&pdev->dev, r);
+	ccf->regs =  devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ccf->regs)) {
 		dev_err(&pdev->dev, "%s: can't map mem resource\n", __func__);
 		return PTR_ERR(ccf->regs);
-- 
2.17.1

