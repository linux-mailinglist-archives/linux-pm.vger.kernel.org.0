Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C72E6474
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408280AbgL1PuY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 10:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632864AbgL1PuX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 10:50:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C2C061799;
        Mon, 28 Dec 2020 07:49:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b26so24742189lff.9;
        Mon, 28 Dec 2020 07:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zfb2Oj304hhOwNOrbWB2XftwVoXzBWq5pLB1bTxGch8=;
        b=iKAngwlt+W4NxAIhqG3ODUV2rL1VHbtt064egT/aLYXOjgxVVioyQMQPdfh9xqFnzW
         2j/7TLctY7/Jt/+zLn39D3TIWWiEHxZd46vbYzYHsv5mIgW5XRl0m5tqQlrrL7JY+iTG
         dTLC22cOtc+kENBLIZjGD7xvCZP3nAt26NJA2FiumScaMui6AW0oPSGO35BEOi9MQMke
         970Qd8GzgEFT9EfM6bneVleleEezvSil/17XxsxD6XMpKOLpuaZWd5l64enrOJ0d/HXM
         LsLNRmXCO1KqdWCT3uE6t7oM7ibVHHZi10/38/+P6rA39s69pZvDA4bkuvuQwKI2g2XY
         hB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zfb2Oj304hhOwNOrbWB2XftwVoXzBWq5pLB1bTxGch8=;
        b=ATiVll00SxJdq87OsrtYHPop4udFJyh94CaofjBH+yjtdC1FgZB3UZQ0RCqc74hx/m
         JIkBJq3LDbXiZoGGdzkl1KLsUzR+p34Ek2O88Kt8i28ZlVPfjnu2YNDFrVPp4Jz/kryf
         RoYp417Kov5FspcA7tF8DPkcn9pAUnwPWj1D8idME8TOxe4KOCTwozx2M7GlwDpwsebz
         cVEHr9e/7+nLl3mFmUJTGlQk75bG1oKuL0e+lKei7fYRgDqzfRxH2+87EaQa7CRriTGB
         WcGmfGsekhYrE0RsTCxOJDr6pPGg0y0oRlx/RkYPmmXYEz8fWWw+hSpMG1N4A6Ts9pOk
         Yh7A==
X-Gm-Message-State: AOAM530Ou/cxp3bUrSBQ0LkiZoHibCYiIdTVLsM6sb7bP9OUM4QCjUXU
        k7s9jpeRl9bkzsXvv1SKFQU=
X-Google-Smtp-Source: ABdhPJxG3IWIMT27oeVAaZqGgz4TA2twhb51FD6wTCGze7pM3+B5tX3hafbdwAiOVbMcB7IcbTK1rQ==
X-Received: by 2002:a2e:8e2a:: with SMTP id r10mr21685009ljk.237.1609170581530;
        Mon, 28 Dec 2020 07:49:41 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id s27sm6502262ljd.25.2020.12.28.07.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 07:49:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
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
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v12 2/5] memory: tegra124-emc: Continue probing if timings are missing in device-tree
Date:   Mon, 28 Dec 2020 18:49:17 +0300
Message-Id: <20201228154920.18846-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228154920.18846-1-digetx@gmail.com>
References: <20201228154920.18846-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

EMC driver will become mandatory after turning it into interconnect
provider because interconnect users, like display controller driver, will
fail to probe using newer device-trees that have interconnect properties.
Thus make EMC driver to probe even if timings are missing in device-tree.

Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index edfbf6d6d357..8fb8c1af25c9 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1201,23 +1201,15 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	ram_code = tegra_read_ram_code();
 
 	np = tegra_emc_find_node_by_ram_code(pdev->dev.of_node, ram_code);
-	if (!np) {
-		dev_err(&pdev->dev,
-			"no memory timings for RAM code %u found in DT\n",
-			ram_code);
-		return -ENOENT;
-	}
-
-	err = tegra_emc_load_timings_from_dt(emc, np);
-	of_node_put(np);
-	if (err)
-		return err;
-
-	if (emc->num_timings == 0) {
-		dev_err(&pdev->dev,
-			"no memory timings for RAM code %u registered\n",
-			ram_code);
-		return -ENOENT;
+	if (np) {
+		err = tegra_emc_load_timings_from_dt(emc, np);
+		of_node_put(np);
+		if (err)
+			return err;
+	} else {
+		dev_info(&pdev->dev,
+			 "no memory timings for RAM code %u found in DT\n",
+			 ram_code);
 	}
 
 	err = emc_init(emc);
-- 
2.29.2

