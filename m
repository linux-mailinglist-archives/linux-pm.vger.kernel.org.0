Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D721F3BC4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgFINQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgFINPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E0C08C5C2;
        Tue,  9 Jun 2020 06:15:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so12442448lfd.7;
        Tue, 09 Jun 2020 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjaYnAqjyjheQetecbUGv3UZQxy0uIJMeCJISYF4wkc=;
        b=la6aiy/tmkvG9zzTPQIvQi4FNpnzVNSe+Y8auZSSVIhD/rrGpKXFOCTwXFVlqTjiKD
         yAw0kCzR7UHvrpzVwCRENQECL1cumqGSCV1tL8riWJ1ogCDWKDkMiEIw7ojm0nUUXbK+
         B2+MlOp676KEiPrtRgps3HtaBpTjYHO9EAAHwe9ybTivC8hz74PrNHpMC7OU/ycoG0ry
         i00R3l/2NiDPRIe3w6Jjf6LBxwkf7UJ+PdwKXv7FRSg/FXJv4dl4FRoyttLvXhv/ZiEa
         FtrubEn1DI3olHkJMkqtRMMfx8lonhFpAw3cI5I728UBqh0WzA7wf4GUI1ZzUu6i1KRE
         dy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjaYnAqjyjheQetecbUGv3UZQxy0uIJMeCJISYF4wkc=;
        b=Sy14zLcCnRuoh19HoPuUXBM+iHjmyyEmafR0P1w6BUr3ezwvfkNw6cJ7cuhkHrmXQS
         VuXEhV0Fr0LJcqb9+mRPwweKpAh2oZZC+RFTwbMFb3Pf1b2ggRgmru/KHfUOAe5BAoNt
         4y+DS+1Ssf5/NYy3yd/NkNgJhI2UYlYPRKAGfUKNJAbcRW134fnA6wgC7GyNiv/Aydqj
         OXet+yw9YSKbnTVCDnoyJounXLASH0r1iBpbeFV4YgPw864r3MDPch7tgeabFvw3Ian6
         fQPOBfnW1LgtLflkFBkUnuoVATlocfbtDpT6cWQpFlXx99lSuNjN8cNezgfea2uzQ4Wu
         Tm+w==
X-Gm-Message-State: AOAM531kkZMHJW54PbF2kZ5OQRBDF3OXjMyvk5gF82Gtw6qhdf+XGrIy
        w6HExqSBMj56PaDedk1ZUNk=
X-Google-Smtp-Source: ABdhPJx/RMhptAxbYbxkouVi2PFiyvVGpkv7BrphTZAhBPJKZzi+UwPIIYIow2R7qRfBqwnyB6QJpQ==
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr15497175lfn.153.1591708501827;
        Tue, 09 Jun 2020 06:15:01 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 30/37] memory: tegra20-emc: Continue probing if timings are missing in device-tree
Date:   Tue,  9 Jun 2020 16:13:57 +0300
Message-Id: <20200609131404.17523-31-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after turning it into interconnect
provider because interconnect users, like display controller driver, will
fail to probe using newer device-trees that have interconnect properties.
Thus make EMC driver to probe even if timings are missing in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 34 ++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 507065c2f452..6cd3d50145dc 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -386,6 +386,11 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	if (!of_property_read_bool(dev->of_node, "nvidia,use-ram-code"))
 		return of_node_get(dev->of_node);
 
@@ -454,6 +459,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -691,13 +699,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct tegra_emc *emc;
 	int irq, err;
 
-	/* driver has nothing to do in a case of memory timing absence */
-	if (of_get_child_count(pdev->dev.of_node) == 0) {
-		dev_info(&pdev->dev,
-			 "EMC device tree node doesn't have memory timings\n");
-		return 0;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "interrupt not specified\n");
@@ -705,23 +706,20 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	np = tegra_emc_find_node_by_ram_code(&pdev->dev);
-	if (!np)
-		return -EINVAL;
-
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
-	if (!emc) {
-		of_node_put(np);
+	if (!emc)
 		return -ENOMEM;
-	}
 
 	emc->clk_nb.notifier_call = tegra_emc_clk_change_notify;
 	emc->dev = &pdev->dev;
 
-	err = tegra_emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
+	np = tegra_emc_find_node_by_ram_code(&pdev->dev);
+	if (np) {
+		err = tegra_emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
 
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
-- 
2.26.0

