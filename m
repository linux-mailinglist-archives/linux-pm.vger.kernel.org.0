Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8CF244227
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHNAIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHNAHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29101C061757;
        Thu, 13 Aug 2020 17:07:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z14so8123841ljm.1;
        Thu, 13 Aug 2020 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVHFz53kDMig8b/PTIMbWX4+rnZ9GeLoQIaKPe/jZpc=;
        b=R21TWmxxJ7H+jIL3Opm1UEXi3SokZUVbcoqbrVPiNcbb4G6bhlFWZBrDsIre8u4yTD
         ciDFHZdgxHEMoj1l3BgaoYx2RQzDlDkpkx3T89nL9kLamUrX9b0wV8Bg8ebp/84JDXm5
         cXrBIhk4LErnn2H89fWIG6ejyPcUUSXF2VwUSIueK6UHbLWjvoC+IBTyy/CQ28h2qcMA
         bl4e5/62FKcDT7rOEE4Bkw0EW726VSG5INd7NSS86QVmeXXZSzOtxYuBpXLnCaTMa7H/
         RPhynoSvLvDhCKUwNrUVHxLAKj6fpLka99A1ol6p7jxSHvXDvXQ+2cqiOdFQ0rAVa6Kn
         6rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVHFz53kDMig8b/PTIMbWX4+rnZ9GeLoQIaKPe/jZpc=;
        b=dFfnSg8icI/LZ7MpoAztNyoYc3x7q6rNZuze/58CGa2I88etsxdquguAiWqzgGdxE1
         +soVPpChR0l1xifVlhvTHG7J9zcYz+w5AG6yGfCsTRlMIBH2Z5PGTAxeKRWvCVplkmmD
         GIEOEpHZjZK9FOCR05AnzPessXwLYTEOZppIr1k1qKJx/RztY2YTLvA0yj8nliilybrt
         FRjavpAvLXkXMH5Ta/7q4lT4P+w7Z2p7bT8s9qejrVQZIIz+ypD/ts4QXPZVqyR4HuEm
         9sL9P4COVDYYPJMA6mY2690G1x2K1j+o9w36e5lgLHnFvKPIuhgmIdjyON6DquVPR1qf
         Jixg==
X-Gm-Message-State: AOAM531875glyx1i6XsLcGVNZotxnfebjElAE28lZwITGbpzsdlr7jzI
        F9+oG/Bf+ol4r/Qjn35WprM=
X-Google-Smtp-Source: ABdhPJwf/viuMUW6rG2BT5HAVAYPT3W7KZthL6vT4jLZj+09OiM4K8aCyVgLf7Vs4vOMj9lfozssvA==
X-Received: by 2002:a2e:7215:: with SMTP id n21mr118673ljc.242.1597363653670;
        Thu, 13 Aug 2020 17:07:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:33 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 29/36] memory: tegra20-emc: Continue probing if timings are missing in device-tree
Date:   Fri, 14 Aug 2020 03:06:14 +0300
Message-Id: <20200814000621.8415-30-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
index db6a4bcb92fb..89e077d797e7 100644
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
@@ -698,13 +706,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
@@ -712,23 +713,20 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
2.27.0

