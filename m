Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2811F0E78
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgFGS6r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgFGS5v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F51C08C5C3;
        Sun,  7 Jun 2020 11:57:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c17so17728940lji.11;
        Sun, 07 Jun 2020 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udNeen0ssD3fcWOv0b71XhfmKyQZQt4wAjykvZdMbYc=;
        b=mMCbq5ZDBmUQVzGo6jXjAMGCRnYqZ4TGBQlJC6QjMCJWvUiyQTfE5IZzMoJD9y7mRP
         3rOIE9J8QBY1SfcVSqG6SCu+yl7+xqHB5AwhrOOUbzxVL/i4rDOwve48OGhCGqNwdeCI
         veub+G4fEIGZx2C6CAuHONwCZbYBiToVBnTgcfHvhRYY12goWyrvwXpWoP2XHPAM7Fq2
         ETwiqBIzeXFR7Km1WwyWGKvWuP/SOPBwUZj/z4iiknRBt+Iq0847gDqrIX6/G6ZTHqL2
         1ZWZVdkyZcQ4rOYre8uoJ2/zXcnpq4nEnMiXAKx8KbkuXkYMTFYlVAC1CWhM3mybvu8j
         CCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udNeen0ssD3fcWOv0b71XhfmKyQZQt4wAjykvZdMbYc=;
        b=PFyNqQ4xnxPrAVAqxVTPE2I4hAZrWYUIeaZSgPMf7Xc62FyPwcE7D3ykymwNi1W8tc
         5Sf0PWt1yegwD9WIapn61rLHDTRPiGZgfV1dbBJkCW6CpqOyr0Px4bh8h/WJlGkvR4D0
         rk4QlLH16MkT5nNqCmBMagBzQdBbrPTKhQRmBFBLYWWHrqGYTqrPbttnrVF8G1kPk/IU
         1SSAnOSihMXzylZSgg46G4jTQd7KH5WAWPhOdrEpegm2kBgXHLVTDylRwXVXmJ3SB/aL
         Q6IASPSq3iOC+qdEenh4OImzevw9616E81YQuPyCpq8GT84ZFdkGvhv1RdRFalm5vuz+
         9UkQ==
X-Gm-Message-State: AOAM530eJLjubX6hwVtQOQNK9f4evQvlYnYrsJPCavdrT5e7/KAKP8CT
        OPs1zCjlNZhIHQz2lo2SU739zZux
X-Google-Smtp-Source: ABdhPJz0L4FkfrZB8WfqX+H2+IfrueRlzOv2rQYR4IWaKbNTrN5C8Lviz3xUu5O4MDQrfxi1Hj0t+g==
X-Received: by 2002:a2e:6f13:: with SMTP id k19mr10268625ljc.364.1591556270092;
        Sun, 07 Jun 2020 11:57:50 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:49 -0700 (PDT)
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
Subject: [PATCH v3 30/39] memory: tegra20-emc: Continue probing if timings are missing in device-tree
Date:   Sun,  7 Jun 2020 21:55:21 +0300
Message-Id: <20200607185530.18113-31-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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
index 79fdae042b57..8d1967f4b4aa 100644
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

