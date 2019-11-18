Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536C2100CB1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKRUFy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40125 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKRUFx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id v24so3986168lfi.7;
        Mon, 18 Nov 2019 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVZm4+AsGt54/AHvdx3eAP7bC+QNmdTq1ECOejtB9ug=;
        b=Hl4MRFvNVFbaRCKT3CL7dUguz78YD7SwWlyB85FyaU+RDhrmRuvO25hyr5/hQKRArl
         bUtGu9gLcx03HQI+jESFcZox8afMHtY4vJHEo3caH5Yzhf/JFVlDV6+taKaJWkTy6WKU
         EWf4fMlgrsY4OGqInmYbsl+bGcnSQu9ZD4rnfK4+NASsdTi0u8f3P2qCQAukgyAid0nO
         tGUy948DNz9O0fQLbuznx0NjIg7Nr9JV94oJ0Emrdb8tmL1M+tBKFtvwGfnTCRAa7+ja
         k4AlGAReHCuXrLvpqeoULiJSMIB6D/K4saUGtIY0TzeIUc+k+Gm36+aoFXi8RffNgkx7
         zgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVZm4+AsGt54/AHvdx3eAP7bC+QNmdTq1ECOejtB9ug=;
        b=R5CTLrjqx1YpHR1d8/hQMIIClStNRV0lR7JwWGI8IyG3B1rNMu2KpLsOiepaFgAtpn
         R/WMlaxfdxaunK6uLaEK0Y3t4yd/J6lCMXs07IQbC4YS956qwz4gZamJ6AfZnB0PhDjG
         1KjGizQubi6/a9V2ODUuy7G15flXUJw4AveT2XsrCe7bLsiJk3ONxWC/Mo9PvXO8jU1+
         Xus60xRiM90mWUa0S6djGECaBpvjZZCW8RrVJaVLGRXYtAdf6uG5qCebyGk7JJ6+RZBO
         ijOB8+RfLlDEwLV5FIsa0DidxlgmHC06leMbB3yyb7isYzveRjPGizl3imq7ReOLj5yn
         zo9A==
X-Gm-Message-State: APjAAAUYTqRcUTNHCAqpGhqYXje34bbHf/uJIov8Ct53KPaTA3vx/HsP
        d3mIaMoCvL4WyjuWPUreg3U=
X-Google-Smtp-Source: APXvYqzk8qaHiHHwXkRhrrIE1sEeZDnQkjSy/cXco/zY2jqK1B4NhcEaAJRIhsbVtVbWItOdvoICRw==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr938614lfr.32.1574107550658;
        Mon, 18 Nov 2019 12:05:50 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:50 -0800 (PST)
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
Subject: [PATCH v1 20/29] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 18 Nov 2019 23:02:38 +0300
Message-Id: <20191118200247.3567-21-digetx@gmail.com>
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
make driver to probe even if timings are missing in device-tree, the
frequency scaling won't be available in this case because there will be
only one frequency available, the frequency that is left from bootloader.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 0b6a5e451ea3..ee194e8ed521 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -985,6 +985,11 @@ static struct device_node *emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	ram_code = tegra_read_ram_code();
 
 	for_each_child_of_node(dev->of_node, np) {
@@ -1054,6 +1059,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -1090,12 +1098,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct tegra_emc *emc;
 	int err;
 
-	if (of_get_child_count(pdev->dev.of_node) == 0) {
-		dev_info(&pdev->dev,
-			 "device-tree node doesn't have memory timings\n");
-		return -ENODEV;
-	}
-
 	np = of_parse_phandle(pdev->dev.of_node, "nvidia,memory-controller", 0);
 	if (!np) {
 		dev_err(&pdev->dev, "could not get memory controller node\n");
@@ -1107,10 +1109,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (!mc)
 		return -ENOENT;
 
-	np = emc_find_node_by_ram_code(&pdev->dev);
-	if (!np)
-		return -EINVAL;
-
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
 	if (!emc) {
 		of_node_put(np);
@@ -1125,10 +1123,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	emc->clk_nb.notifier_call = emc_clk_change_notify;
 	emc->dev = &pdev->dev;
 
-	err = emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
+	np = emc_find_node_by_ram_code(&pdev->dev);
+	if (np) {
+		err = emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
 
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
-- 
2.23.0

