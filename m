Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1971971CD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgC3BKj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:10:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38988 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgC3BJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so6945021lfp.6;
        Sun, 29 Mar 2020 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4nV204hC2fwmDzQEKB7qIbLyFjMrEPQFeaJnZkMKlE=;
        b=R7kFkFZL6GQa6/p+lME2mLpX2W5dglEo3Y4GeoORp/vqCkVpf6z+ZPv39VaO1xXro4
         mQsaenLZx+2m/AT2NLRsaKlD8CBYxhTQgQgzHClo9305BMfGFgJxD4dkgzyh15zGWPCv
         /IzIQ00ewvfY0d063gwLr52+/gRpcmjkRIwDc2tqhtjLLIbHKv0FtGFI+LjP0HsKg+rf
         Rl+Zlv7YoJdhxKyyJ+g7Mv9QTB3wNZMQW0LtU6TlddjA8WCJ9ko4UnHy06YG5xtWVFku
         RfXAkeNAeblEcDc0KDdlgGHfUG2mmrp8FCN7juWdik7Qa6m1MbxKWSgtCBETnHrSi6cn
         52cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4nV204hC2fwmDzQEKB7qIbLyFjMrEPQFeaJnZkMKlE=;
        b=uaTkamlzKGHo0izX0OaaKQbxWpUBSbgGznmx5kCwV4/u7dFfIPpun+Hz0gjy3K5WrP
         D4puUNFX/n4RHmnDTiYnTqoTUOkcs90Q/tFmbvN373NPBMb2Q+80JJiQaOAbDeRt48js
         zfCWhwglM2u1MgUTqgsxPXy6zfvcvATCoj0r01U22LZaoqFtjdRBNKKIL3DfBaKSjxBw
         utZjbIxze6lOK2InCCSW3JJyhFeG0kB8uG1ZU79eAuxrY6qcuXhG3XtOwKoExnVGxOGM
         UhCrj4t0m1uduZfYBVJjtWCfzvHjkmiEFjJ6qx9tBtx6DFv0pPcORmpa8SX7FQ1JkpDm
         zJLQ==
X-Gm-Message-State: AGi0PuafkGjp6+ymHjtOZfq7V9rjuGJAV+q8Pmj2snRcchHN8h8H/G/C
        +769t3Ywiyg/vqlUEOsBVEA=
X-Google-Smtp-Source: APiQypI0tJdoYescE/nvG1PxhKj3scyF/qbpV/MJqUUuemjN7l29mlKc0xbwtcvYsD7sjXssHhQOsA==
X-Received: by 2002:a19:ed14:: with SMTP id y20mr6637613lfy.179.1585530587814;
        Sun, 29 Mar 2020 18:09:47 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 13/22] memory: tegra20-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 30 Mar 2020 04:08:55 +0300
Message-Id: <20200330010904.27643-14-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
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
 drivers/memory/tegra/tegra20-emc.c | 37 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index ef3abc18a3f4..3a6eb5cc5c29 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -383,6 +383,11 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	if (!of_property_read_bool(dev->of_node, "nvidia,use-ram-code"))
 		return of_node_get(dev->of_node);
 
@@ -451,6 +456,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -656,13 +664,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
@@ -670,23 +671,20 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
@@ -699,7 +697,8 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	err = devm_request_irq(&pdev->dev, irq, tegra_emc_isr, 0,
 			       dev_name(&pdev->dev), emc);
 	if (err) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", irq, err);
+		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
+			irq, err);
 		return err;
 	}
 
-- 
2.25.1

