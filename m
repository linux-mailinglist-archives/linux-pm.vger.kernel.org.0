Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D45128F69
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 19:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLVSup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 13:50:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46163 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLVSup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 13:50:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so6309453pll.13;
        Sun, 22 Dec 2019 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zogEy1R5bHAzYb0JSK89rU9lJX3Wruc73hLWvRKN/jg=;
        b=IWvfa6cbF84MPkGoGhvjZjcoRqq4uO59BCTZeZG/vKbNza8MhOFdV5dpqdOq7FHmtn
         piFe9b6NPPyBI5IY4Cl+FYvpDwNgr94dUjj3j7lVDgHfkzRmsoukLUeXmQovUjSiJMnF
         vJ8FBnGPHmWYy/VsFOKNb78z+ZaEK4AAjVvEgk3tfth0ea3Q+ikx/oPCDxZT/3njhlYg
         bCVJZA6tvnmCmhhXN+q/DPlritdPq3ayfH9wus/5n0RKF2LiKYlRvvKj/6L5Gtv5WMaU
         7OBqrDoxyuurfeOCt04NsK6fJWfx7LOBZhGRHafGemQHEn7CZBxD6e2rgcmx4YvPx6dd
         9AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zogEy1R5bHAzYb0JSK89rU9lJX3Wruc73hLWvRKN/jg=;
        b=a3fUg6B+Qtj9tokuAKGzUtiPf+OAD1WeYI/f0Ijn/fu0G/E4ORobmrdHklSOelsDWw
         b2/0ZoSKh+nVw1GWY+4LvqRCwYLErOCeQCaw3uYHmZrN/As4GwqnRAzYIVw0B8hVcqPe
         P3ROgZC5FtSTGWwO/7UvjfktPaTHmpw+i8yBhOVkfz5sCqQiHdjEbaQT1dhPWRBOcW5Q
         nf5YwPpT7Tk1wMMGUde5n3DTn1WIQq4/RNfz3NelwA3TZ4webfENaticvdorPnysVDgF
         shR3KPqaYtd6u83QYakKlz6mkYMRuiXRtpbt1lbmm4ZtD9Y6rwaxMQiwMEklYTU/nQ/Z
         FvZQ==
X-Gm-Message-State: APjAAAUaTjE96tFrEkMqN1kjFI5ToliYatFX9HbGcCw58UTmLG6nGRdY
        luMp9X05F8PUE+tqM3FOnC4=
X-Google-Smtp-Source: APXvYqyKKfxfSyCuABzQ6eqEF5lsR+6vnx8hRy7dJwwQCFJClBYG8jWJoC5x8F/QV0jwvtIYirEEig==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr27401740pls.220.1577040644128;
        Sun, 22 Dec 2019 10:50:44 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id f8sm21035451pfn.2.2019.12.22.10.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 10:50:43 -0800 (PST)
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
Subject: [PATCH 4/9] memory: tegra: convert to devm_platform_ioremap_resource
Date:   Sun, 22 Dec 2019 18:50:29 +0000
Message-Id: <20191222185034.4665-4-tiny.windzz@gmail.com>
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
 drivers/memory/tegra/mc.c           | 4 +---
 drivers/memory/tegra/tegra124-emc.c | 4 +---
 drivers/memory/tegra/tegra186.c     | 4 +---
 drivers/memory/tegra/tegra20-emc.c  | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ec8403557ed4..71390d4ad809 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -593,7 +593,6 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 
 static int tegra_mc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct tegra_mc *mc;
 	void *isr;
 	u64 mask;
@@ -619,8 +618,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	/* length of MC tick in nanoseconds */
 	mc->tick = 30;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mc->regs = devm_ioremap_resource(&pdev->dev, res);
+	mc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 464f0ceaee63..2c73260654ba 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1085,7 +1085,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct platform_device *mc;
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	u32 ram_code;
 	int err;
 
@@ -1095,8 +1094,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 441213a35930..226d2b16036d 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -534,7 +534,6 @@ static const struct tegra_mc_client tegra186_mc_clients[] = {
 
 static int tegra186_mc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct tegra_mc *mc;
 	unsigned int i;
 	int err = 0;
@@ -543,8 +542,7 @@ static int tegra186_mc_probe(struct platform_device *pdev)
 	if (!mc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mc->regs = devm_ioremap_resource(&pdev->dev, res);
+	mc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 1b23b1c34476..d2efd0c658c0 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -482,7 +482,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	int irq, err;
 
 	/* driver has nothing to do in a case of memory timing absence */
@@ -518,8 +517,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.17.1

