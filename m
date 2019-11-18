Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB6100CC0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKRUGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:06:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39277 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfKRUFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id f18so2543743lfj.6;
        Mon, 18 Nov 2019 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elZWeE6UcuQp3DEzgdQgaL5jKLTt+cOSPUtF3y9TNa4=;
        b=bdAg91BC7ySUYH4sCX/GvLhlH61/SVZBlLXA+AgeAWMbPzQ0WUMiXN1C//dc774oBe
         0RlnlfFVzOCWhVgpOc+W+vMK7nCmF2auinzsygXORlxIe+MuqtgczrPzZFcLBKF/jBhI
         HJbogqZbGxbFOyC7nh+PyQ7MVpKLwSyMMyPDEp70t8veTacmaBkmisXAxE8RoyxHGacD
         iaKBk8MiKcCilSx09+6ya9laXjQC/RTYtiBFth/R22JjINQzQ3y/DXv/5SpAfY1UH78o
         ROHWKltjPZ7/jkhz1vUYzS3LOyaBksnJ+EY9/lg5nuzvGw5QaWIoZRCwN9eTZ2ZSw5WU
         usfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elZWeE6UcuQp3DEzgdQgaL5jKLTt+cOSPUtF3y9TNa4=;
        b=JHxX37TSmHbx74MFz9JREiUQgTdpPYhj4J7rmUpE5sRaBHafQ1mWlU3nKFauAKyse5
         6PQ26JgcscKlzdjfunaoTONZVgERLYKjizpZ4pRL7yNQ8Yqvlfz4LNCpYltZ+6rjjPq9
         ffCj90CmdNHE+cfZxcvskNJGGZxBvsAzfXm5VV5q4rCTkaFatQmMsbcQfeIeb6PMVvuJ
         e9blAMoJjlD5VSRuoaVScTKJL/YRY6M6IcLF2xX7uVVXqFuT4i+YxQFddYOPNnjvJv7H
         X5UKRFFSbOQfTdNew1/CgFCg4lKdR2jaGPy3Q0/zq08K42oCAPaR3MvD5GC2U5DGu8p6
         YqUA==
X-Gm-Message-State: APjAAAWwuO4xGhZz6af23IggMYAKGUjzi2StrmJmPTf25wNoudIEG8vg
        8mhuHllTnO93+dxsmh6gaA0=
X-Google-Smtp-Source: APXvYqzeJRAE++Yzki9UJ98MMjtqUsLFff7ZYuUVv6qYq5NYvloMtXahcKAZxpKSThtQeJfpU/MEiQ==
X-Received: by 2002:ac2:4a8a:: with SMTP id l10mr816734lfp.185.1574107548766;
        Mon, 18 Nov 2019 12:05:48 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 18/29] memory: tegra20-emc: Continue probing if timings/IRQ are missing in device-tree
Date:   Mon, 18 Nov 2019 23:02:36 +0300
Message-Id: <20191118200247.3567-19-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after making it interconnect provider
because interconnect users like display controller driver will fail to
probe using newer device-trees that have interconnect properties. Thus
make driver to probe even if timings or IRQ are missing in device-tree,
the frequency scaling won't be available in this case because there will
be only one frequency available, the frequency that is left from
bootloader.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 61 +++++++++++++++---------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index d2efd0c658c0..28bd9fd4c3c9 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -381,6 +381,11 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	if (!of_property_read_bool(dev->of_node, "nvidia,use-ram-code"))
 		return of_node_get(dev->of_node);
 
@@ -449,6 +454,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -484,38 +492,21 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct tegra_emc *emc;
 	int irq, err;
 
-	/* driver has nothing to do in a case of memory timing absence */
-	if (of_get_child_count(pdev->dev.of_node) == 0) {
-		dev_info(&pdev->dev,
-			 "EMC device tree node doesn't have memory timings\n");
-		return 0;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
-		dev_err(&pdev->dev, "please update your device tree\n");
-		return irq;
-	}
-
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
 
 	init_completion(&emc->clk_handshake_complete);
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
@@ -525,11 +516,21 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = devm_request_irq(&pdev->dev, irq, tegra_emc_isr, 0,
-			       dev_name(&pdev->dev), emc);
-	if (err) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", irq, err);
-		return err;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "interrupt not specified\n");
+		dev_err(&pdev->dev, "please update your device tree\n");
+		dev_err(&pdev->dev, "frequency scaling disabled\n");
+
+		emc->num_timings = 0;
+	} else {
+		err = devm_request_irq(&pdev->dev, irq, tegra_emc_isr, 0,
+				       dev_name(&pdev->dev), emc);
+		if (err) {
+			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
+				irq, err);
+			return err;
+		}
 	}
 
 	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
-- 
2.23.0

