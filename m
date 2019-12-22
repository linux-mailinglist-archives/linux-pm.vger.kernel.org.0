Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E17128F80
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLVSvH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:51:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44635 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfLVSut (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so6311476plb.11;
        Sun, 22 Dec 2019 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbA/SxZM7arQJSBxpfLhl1W8O2cnxPsWXhCTQaV8bqw=;
        b=XMuF8azLQN02i51bK7MY+jsZOPuqljSFDQgTsKdhh/pVSDPy/Tc4Gonb84B+avBTxQ
         c+o5IEggvioE6o134w67CrN1EyeSkThBdEfhNJP4Wb1GBH1Ss5BKT4NL3ne5lNCTGXLS
         xS6D3cR8dWbtXmiz1R6o4g7L+MltNoUyyYBDpVKhhubsWNrxgTi0WZHa4pQ5Xg42aS6w
         teG+bEYZpVdyQh+ds0QAnXz8ja1v38+nAUm8w1vSfjCQeg7wTryA9jaK2I4YRRyknGYb
         H4R32GOSUf7Dn7CNRQ25OkWuDyniKGfpp//nxHF3E1GORs8KP2h2vgggNn+zldhjXWEA
         Y7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbA/SxZM7arQJSBxpfLhl1W8O2cnxPsWXhCTQaV8bqw=;
        b=g0mlvZBf0suIwkho0ORr/fsXaADQXs/M9jXsOfs58XDfrmv9c1niQkswJUABdZMHaH
         U8M9AI7Pq6Q1lvseMRRTUJdMBIY1o8m8sEKQSUHaYSLM2TiMjfpq7XOfJrjrkrDV6/y+
         pDrKRn6xG5KkcKOYzCKrs+k2XxSHZa5Fgs0O119uXOb8YNzLFGzfxb6/6uVLC96aV3tH
         +OShZLnTqxckxpvZBEy9VrUa8zm/klcS+JnJoCSxbHTYi8YxNUXWQkf7EFtyRvvJtcG4
         bUa7p/PvQrWVK4dk3bV469jsJJey5bzinoffRvbkilB7Yc8QxjmQ7q/vm3r7VT1IkfRA
         sevw==
X-Gm-Message-State: APjAAAWM/UFqjjAGm5OFCStOBG7ymU7MMFbKOb+K7jhwQ+7cEUY+ZdhG
        cLa34aKs9yYaU5eE2iEIN40=
X-Google-Smtp-Source: APXvYqwGfChxQFCRaBEjK6UXxlwsQA4EJFSFKV8mJBq+/pqe5eDbStpHvTiuLM5YyMNnYuew2Vtf+g==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr27974553plb.130.1577040648012;
        Sun, 22 Dec 2019 10:50:48 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m6sm12090747pjn.21.2019.12.22.10.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:47 -0800 (PST)
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
Subject: [PATCH 7/9] memory: samsung: exynos5422-dmc: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:32 +0000
Message-Id: <20191222185034.4665-7-tiny.windzz@gmail.com>
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
 drivers/memory/samsung/exynos5422-dmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 47dbf6d1789f..81a1b1d01683 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1374,7 +1374,6 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct exynos5_dmc *dmc;
-	struct resource *res;
 	int irq[2];
 
 	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
@@ -1386,13 +1385,11 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 	dmc->dev = dev;
 	platform_set_drvdata(pdev, dmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmc->base_drexi0 = devm_ioremap_resource(dev, res);
+	dmc->base_drexi0 = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmc->base_drexi0))
 		return PTR_ERR(dmc->base_drexi0);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dmc->base_drexi1 = devm_ioremap_resource(dev, res);
+	dmc->base_drexi1 = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(dmc->base_drexi1))
 		return PTR_ERR(dmc->base_drexi1);
 
-- 
2.17.1

