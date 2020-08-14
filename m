Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F66244220
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHNAIa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgHNAHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C7C061757;
        Thu, 13 Aug 2020 17:07:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so8092672ljc.10;
        Thu, 13 Aug 2020 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8yAUvmC7dB1AvZufMoltXCEKaZJYFALPQadvIxchYtE=;
        b=nZnuIFn4NQ7251gwYTws9nLSOUpePnWTN0wUR3sYcp5FQ9RWkjtClffkh7lFP53eh8
         ugWvszqZJIIGDUX4I3Y1FZgdXBimv4gOIrfNH2l+zxC4vj+5RsroRnqxON7cW4RVu/jQ
         gqp23VL7L0+kGSefSR5HudzGvkDgywh0nkcZ3fVzjkmILhkUf1/Lnlv3GZnkKG4HPQv9
         f0e9uWIE3vUCTO6C+/tXTKWmmquU9N7AeonqQqCVzPfg8ZrRoAIcdwQjF34x9TkNh5UV
         mMmm4YDoocFJlQCkhpPc+17BnKW7mTsThNqB55qwge+Qkdc5zlH4V/kg1uhEk1Ovug+O
         8V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8yAUvmC7dB1AvZufMoltXCEKaZJYFALPQadvIxchYtE=;
        b=hxOBbVBDhr+MLj/q4yFLh4+vxIRhzvWAmHq6V6FLrpzUBj6g37f6+npfwo9nh9B0+o
         lbop9M93tYThlk2VjP/HPeHo4EY1RO6N+wPhrGoR0BO3nigiIUQdkkp6p7sUtNxpp8Me
         RtR4UdVzSLZ3TKKCFlKKm8xSZBIdYz7r8shG7JKDSKPEkLE2cabHSW2A9mMk+hWa03DQ
         bhNsTdHv92TX2QwszEZ2iw1Hy7ttaJlaaxJs8LVTqCcHwWRJl7mZ/80wvS6WnwQ8YcQo
         797BN5s7ga2xTjGjSroM1Ec3M4k+eAF7M+YT9cp+xCo4nMUn8jSXH2CE+rrK+itGapDC
         nTMw==
X-Gm-Message-State: AOAM531+/BL3zxgH1w6u/DvOLrOX5Rv2Vrj8sfNOeqxouKpCP/AhueOd
        V3Nq2N+1KbfUIQNaqKXQRFI=
X-Google-Smtp-Source: ABdhPJwiHCAsmpwTHY7fxXYOvVp2r9Jve/fNJ/xQBu7FZzCkI2bJBYxqcixmLnYy4dsrjOhGDpzE3A==
X-Received: by 2002:a2e:9010:: with SMTP id h16mr114446ljg.316.1597363657009;
        Thu, 13 Aug 2020 17:07:37 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:36 -0700 (PDT)
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
Subject: [PATCH v5 32/36] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Fri, 14 Aug 2020 03:06:17 +0300
Message-Id: <20200814000621.8415-33-digetx@gmail.com>
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
 drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index f3082964cfb6..0cd39bf5f393 100644
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
2.27.0

