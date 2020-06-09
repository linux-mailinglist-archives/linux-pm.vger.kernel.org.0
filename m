Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDE11F3BAB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgFINPq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgFINPH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8555C08C5C4;
        Tue,  9 Jun 2020 06:15:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a9so21432232ljn.6;
        Tue, 09 Jun 2020 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBJCplGhLIr24UMQ5QWC+yX2Aq7GS8Qdhh51vOCv+Fo=;
        b=YfdrmR8+bDHqkjeC4uKTJ5SfBXCYYq9tKkjD6LLQ/KWTgLvccoblWEZvVMmOJgNUQW
         yhna0ZQ2wTmP0zb72B313sOCkye+v8ngFV0ACPv63pDPymxM9EV1I/BB6XAk+jw4AEnw
         8ziPfrb3maHCNCLZvCIoaYXpoXwGdKWtdvk7L3fA69n+mdFZIxDzNI4RQ+NlbTiZyLLY
         zgdGFkpK0LFJlAh6+kHzsloU/uiyQn/7vSdehhWuN6CHy/8D59reGUo7szSdY2d9NymF
         BnT//xnb6SwkF9pQHNC+8H/6MQuaRKC0T/qUPu9WuJZ4UDx2Q7XpwQCjYYx/U/FbRcHj
         KWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBJCplGhLIr24UMQ5QWC+yX2Aq7GS8Qdhh51vOCv+Fo=;
        b=RWGxIf49HThndNskARaAum4CZnQekNNPzsxUeX0gRjpb12Xtyw0IbYQL+JBqfPXGei
         gvUL6yUdoVMe/FXYNuf91XhNrwEcC0JEgHdItPlIQUM+511K5ftxMtCICVXuw9BHeYy/
         HQhCvuh2m3zJpPTMSwGz65A3GlTCmYMdxSk4av5yFhWUmyPKGpWr6jRVev7b+Gq6vFTn
         R2MLczeaAd0qr+ZiEt5Rj545gegFGO7c/EYoIXpSVqw1MOTlx1Z/evB2W2a6PFyr6/6z
         2Rk15RsiNWzvoB7deCoX0QaQOkpJ7bLwueXC4TRyJcU7WMSnIpeheRVPLnpMxzUn0E4u
         o1ug==
X-Gm-Message-State: AOAM5306SXrRF8FrrDOPAy1ZIh4+88bz2ynHKSfimzD0p2+oP1lkuRPx
        a4YF9VvYbvFOy26lg39Lo9s=
X-Google-Smtp-Source: ABdhPJzNyecHovhlUVhrBdJOpBTvH0mJxqq/5f5UqhaEKubxRG53/Ij7m4LrZV7osBBZOUCPJsDegQ==
X-Received: by 2002:a2e:1311:: with SMTP id 17mr13650703ljt.122.1591708505387;
        Tue, 09 Jun 2020 06:15:05 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:04 -0700 (PDT)
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
Subject: [PATCH v4 33/37] memory: tegra30-emc: Continue probing if timings are missing in device-tree
Date:   Tue,  9 Jun 2020 16:14:00 +0300
Message-Id: <20200609131404.17523-34-digetx@gmail.com>
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
 drivers/memory/tegra/tegra30-emc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 85d4effb8e6f..f6c688bfe41f 100644
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

