Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947D71F0E65
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgFGS6b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgFGS5z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC1C08C5C4;
        Sun,  7 Jun 2020 11:57:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so17764691ljh.7;
        Sun, 07 Jun 2020 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eu8MrObQX4qoANIG2fS7sLLDmIFV2OlYxi+5WWSLEXA=;
        b=AO2u+AL2md2fHE3/M+qhRZkJHkN57VNYPwF53yC0LlEiqDEayeGkoDRm4INYQiPTcu
         UILsBPr6RINt4PeXyF+jYKzk/q1onbl8mnOYntuXqnuGDQBbPJJ3Ha+AeuUrgLEXpeYD
         uU4rsDab0iIprBbs5g5bf79f69/B2lUe5Dv6y/VqKFHO1w73A1jMzWBSn0wEC+C7T67C
         LfRXy2lpoi+P57/z8WCIYUfRqAmmk6GzZZPgqfWABbsWV7A538i6yyUjKzRwePcilSv6
         wwctvG1COSVGw79IgfkVRmMYkKsr+JCQnFCr+u3Zolc/RmA526GV9Ac+c0Zdzlt31+MG
         qBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eu8MrObQX4qoANIG2fS7sLLDmIFV2OlYxi+5WWSLEXA=;
        b=JHb1dXPb5oT7gb+7OBYJ1r7dmFcNW40R6nk5bROOcF9L38vB66Xra4PKy1cQAz4y90
         aYvup6koJ69m2fEhfbzvgsaVh+C5KBSVgRvTO0mtPWzmOjsysH48J93kCoa0/baHZetD
         7D+TBlaw2HEqUwgUeiqPP1NagokjlvGsQXE9aZB2rlxUkw076f83xeXSubHjCbMUTyvC
         IVhPyjC3BsdFFcRcMSIcLdAoFqdxgCoeCJkn5zj5coz9hDXbWSn1Hf6o3GxNXlMg+Xpe
         hehpo9g5zdr8jXINxwDDE15rJIw1u2JdTYQuMOHRpSE7WAqISUfjPoLQcViLb4vb8GbV
         bTFA==
X-Gm-Message-State: AOAM532/To7cX6QVkxUejDmKmowXv5kMOTh2YrA7Ft1iWE0VSdLkvBJ6
        PinCWy0ZCsrQwvLcJ5dpqB4=
X-Google-Smtp-Source: ABdhPJxB9BKEMaHB4+bqRbgTmGzlOqU21Wm2fXMTV5IfItU+9t4fvRuXNVDEZLm5kaRBchxCjOoJAA==
X-Received: by 2002:a2e:4601:: with SMTP id t1mr8893308lja.82.1591556274043;
        Sun, 07 Jun 2020 11:57:54 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:53 -0700 (PDT)
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
Subject: [PATCH v3 33/39] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Sun,  7 Jun 2020 21:55:24 +0300
Message-Id: <20200607185530.18113-34-digetx@gmail.com>
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
 drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 205d8053fa75..76586edb34ee 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -988,6 +988,11 @@ static struct device_node *emc_find_node_by_ram_code(struct device *dev)
 	u32 value, ram_code;
 	int err;
 
+	if (of_get_child_count(dev->of_node) == 0) {
+		dev_info(dev, "device-tree doesn't have memory timings\n");
+		return NULL;
+	}
+
 	ram_code = tegra_read_ram_code();
 
 	for_each_child_of_node(dev->of_node, np) {
@@ -1057,6 +1062,9 @@ static long emc_round_rate(unsigned long rate,
 	struct tegra_emc *emc = arg;
 	unsigned int i;
 
+	if (!emc->num_timings)
+		return clk_get_rate(emc->clk);
+
 	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
 
 	for (i = 0; i < emc->num_timings; i++) {
@@ -1263,12 +1271,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
@@ -1280,10 +1282,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (!mc)
 		return -ENOENT;
 
-	np = emc_find_node_by_ram_code(&pdev->dev);
-	if (!np)
-		return -EINVAL;
-
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
 	if (!emc) {
 		of_node_put(np);
@@ -1297,10 +1295,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
2.26.0

