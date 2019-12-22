Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE75B128F7D
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLVSvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:51:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39398 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfLVSut (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so8079519pfs.6;
        Sun, 22 Dec 2019 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2mMsPo8M3x876TJIPv/V9kMTnJlbEepMVzpgXqdmw0I=;
        b=ZpEDu81zRHBqo3RV+PuHNZpFGIZ0wGCPWy0hCPcLUTHwoe6j+6Tx2+RBVyksDlngTK
         myaP/2Gs758aoeYWPfu+UwIVsRkdRh2WRHJJyVIsT7SjBgdU7nrLOVzdkap7wePcNF65
         51ANI8s4JJowIaPkgDAgKgcHJxo9wbPnrF7Ym5oE7or4f8qY7FDW17B4k+Dlz5gzBAsB
         4an4A++rTJeqU75iqy9JoNdAXj+vCb4XLdhvt7NKIL26hxzEjqKLOa1p5Kg3Ia1AUxMB
         Vnq+ZdjHbajAsFP/w/hTbmnry1R/ur7tTeDdaXUVtwEWnLybI/lMITQ/Ostu/yvnJ7TJ
         OGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2mMsPo8M3x876TJIPv/V9kMTnJlbEepMVzpgXqdmw0I=;
        b=G6/gxngHHnbJXf1rf7uP3A/UL174Sm2ptQeB5ifXnr4ABRfx/5qOqplwwKbCcVLkSj
         iJmX190QGkWQ5lyGuIPO3Lsly2yDA0SZZvXWkDWaV39t3pzPCbe3fceLV24Frb5YprNp
         LbNVdq5tZLVmi6a1J5hgI7o/vXBQ2PjdIPRAU2gkIvcGxwo+0PcH+D/oaOwXOrVJ8AXU
         /h/hOZ8GPnGsHCHZU4x0IB4kVUdlYbo5PpWX8FPfs7PES1yaDBfwSbX2+VZ9/2JM2EAr
         qOr1zontoCpl4rmltQzv6BTcdn+yeZ/48KEUnkMZT1+AuoeEmEq6eH94xfkQNJivh1rF
         Cx7A==
X-Gm-Message-State: APjAAAWBC1eG4oP/mQWxPIgyNl1gaJVutU/zkkUFFC9/DRuRvzOZQRNc
        eSH6RERbViPG7EZINmf80uA=
X-Google-Smtp-Source: APXvYqy/rBMV+0mmOMQ2OMs4KFh2sPHwhPOhJ+NSHNisuaZbPxtgXlTivp/vRnvcVVkI8GuQChVzcg==
X-Received: by 2002:a63:f64a:: with SMTP id u10mr26539866pgj.16.1577040649079;
        Sun, 22 Dec 2019 10:50:49 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id a12sm18584043pga.11.2019.12.22.10.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:48 -0800 (PST)
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
Subject: [PATCH 8/9] memory: mtk-smi: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:33 +0000
Message-Id: <20191222185034.4665-8-tiny.windzz@gmail.com>
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
 drivers/memory/mtk-smi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index a113e811faab..1cc5d94036a2 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -269,7 +269,6 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
@@ -279,8 +278,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	larb->larb_gen = of_device_get_match_data(dev);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	larb->base = devm_ioremap_resource(dev, res);
+	larb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(larb->base))
 		return PTR_ERR(larb->base);
 
@@ -419,7 +417,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
-	struct resource *res;
 	int ret;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
@@ -453,8 +450,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * base.
 	 */
 	if (common->plat->gen == MTK_SMI_GEN1) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		common->smi_ao_base = devm_ioremap_resource(dev, res);
+		common->smi_ao_base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(common->smi_ao_base))
 			return PTR_ERR(common->smi_ao_base);
 
@@ -466,8 +462,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		common->base = devm_ioremap_resource(dev, res);
+		common->base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 	}
-- 
2.17.1

