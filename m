Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E597E298440
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417150AbgJYWUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419320AbgJYWS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A823C0613CE;
        Sun, 25 Oct 2020 15:18:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l2so9444321lfk.0;
        Sun, 25 Oct 2020 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jRV+Ge/0FrEm/wxRvR+gNzSwx2bUBqPH09slknOwXo=;
        b=oDKG3ReKisrCCsGCm1z8oLkUuQj9ppyA6XLlS0hkLlu+jK4/V3a8UHV+gB0Qxg0MUN
         dtRadVJ8ozwwerqvzThpZVPQ9EmOJNEf91bXLhD2gyvYYI8nqT+DhsSu4zpsi7hD3u0L
         WUIoQ4fuOtLn9unEk96xoHRupkg1cSv5/qbWoU43J3aeVY0HI0iUkCYxzozsZ2QLv1hn
         ntz6kTi42sGO69Y8pqKIA47QXFSAmW/nNCDL1i0Dj4isLfsxgd7Jo5BdczsWxkm0U8Pt
         NGQD5PxuKzXAJmvLfHnqyVrEX3vZLELveDM37DlmAdI0Z49p+5j5KbQ7kgYntltHPosx
         /ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jRV+Ge/0FrEm/wxRvR+gNzSwx2bUBqPH09slknOwXo=;
        b=thk/p2vyE9Xuzu48l96xcJ/sL/82NLqCzt7qplOt/0aSGOPw47bO/W6THmIoILHpJq
         uf/ri4f8tPq0HxwBwJ7OYH9lFC+AZm+FRQ9j9n2rdrr02aQU/FTeaVkqJTfh3cL24Mlr
         HcZ9YR1l4i0YgkA+TmFNoOukHgnFw8R4eDgWIPnRD0HjMvSqCN33HSgOZamIyX5W0N5x
         lro4lIYMeQmPPD0/4ap/NaMdW+SAx347xVgHVYkOQppKa9kMxF/X8H0mR6OnIgmkssrw
         h4BE+cXBXuqQIyoZCtvNJ3QzlOY2nTqFMxA32JxOPiYf8MaqyYkZSncayUlZEDCA3Y+v
         k/OQ==
X-Gm-Message-State: AOAM530X9goSzblpUDx2DUkPkt5dbDgB+9yG/dwscTaO89NUhnkRfEOX
        DqeXBK/TIEUj7fVVwv7UMpU=
X-Google-Smtp-Source: ABdhPJyzXZ/71/6zmWx3dSH8wypJmJ3GGGIfb/zgO8yO+rx2N7FQt7bSGnYsYkVPeCjOF87PecVYTA==
X-Received: by 2002:ac2:4ed0:: with SMTP id p16mr3783557lfr.554.1603664304954;
        Sun, 25 Oct 2020 15:18:24 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:24 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 32/52] memory: tegra20-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 26 Oct 2020 01:17:15 +0300
Message-Id: <20201025221735.3062-33-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index ce22ca7cfb77..34085e26dced 100644
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
-- 
2.27.0

