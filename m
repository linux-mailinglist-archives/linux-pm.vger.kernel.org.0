Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380AD2AE569
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgKKBPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732618AbgKKBPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F268C0613D1;
        Tue, 10 Nov 2020 17:15:13 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so569214wmm.0;
        Tue, 10 Nov 2020 17:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjtsQsCJihSVkHPvVSyTh7Vo5P6YOsjZY4JHUUyWhBM=;
        b=qF7inbuZED40ZBEQgZcwkqESS4IjxsImcS2LNNhro247GdyhS6mRzfBj2+cwCOhgB9
         4nIJmO+mxfdP6vrPAljdcRNmyebyAFGRENHzzyVGH3qCfMsLANCqNmhy7YZJoL1yTOS0
         RYsTdfsSftdj/R+USlBrsoDaC/UiplaNwmVKBu8umu8ur9d0iRXQUWDFpqB8yEXwvbTj
         NnFEzT3C3mcUapMKQLMDqLrZ8QN8naKTBNY07osHlStGlUr3z45FILOnlDmU7LdUi0LB
         NjyxgInWCLa79c6IywQRax0SxuDEfFbgLEMxyEt5PDOtLzyUUVHOapmvbD23JTAlg4bN
         z0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjtsQsCJihSVkHPvVSyTh7Vo5P6YOsjZY4JHUUyWhBM=;
        b=AEfuTcX/jjMhzd8XXuaDDwjbmtxy+gwfz9T2FyWshu2qkbHVXiEmN9c7XHSag4lTja
         z7WRybC7WAq3DUn2Jc59igMVaBhMJhAFUYuEY28mc/TBdxLvZL+6JUz1WWGUg0sZsBjT
         dg5VI2hIQtVnfFGvXLukrlVuYBar87JVBthSywS9iHt3kwmb7I7PZtS53nZmdGiFXVkm
         IEoycBMJRbRwVvgGikDp01MYyimYDPDwhAPpPX5jgOHhCUkPQ9U2K4r9954YGrVLX4S6
         OS13WbHjVcZ+qJSY+lQ+7rtuNdYbJlSK4GHM78niNtRWCYV0objbL0NdpeA9fw2iMNLP
         ZhmA==
X-Gm-Message-State: AOAM530R/QSo0J8KETXHQ6KUyWvGduXEbasocVJbhZaZ1g1A1EV0Mql8
        H8KUmhbU0IKIx8XNPLLQ0wY=
X-Google-Smtp-Source: ABdhPJyZqr0B5HiYFrwPQUJcJTg6auyvSPy/3Lsois7R4I91PYn27QXinYePPmkAhhFSbVJzzb1LyA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr939369wme.0.1605057312178;
        Tue, 10 Nov 2020 17:15:12 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:11 -0800 (PST)
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 02/26] memory: tegra20-emc: Use dev_pm_opp_set_clkname()
Date:   Wed, 11 Nov 2020 04:14:32 +0300
Message-Id: <20201111011456.7875-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_opp_get_opp_table() shouldn't be used by drivers, use
dev_pm_opp_set_clkname() instead.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 5e10aa97809f..bb3f315c9587 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -902,7 +902,7 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 {
-	struct opp_table *opp_table;
+	struct opp_table *reg_opp_table = NULL, *clk_opp_table;
 	const char *rname = "core";
 	int err;
 
@@ -917,19 +917,24 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	}
 
 	/* voltage scaling is optional */
-	if (device_property_present(emc->dev, "core-supply"))
-		opp_table = dev_pm_opp_set_regulators(emc->dev, &rname, 1);
-	else
-		opp_table = dev_pm_opp_get_opp_table(emc->dev);
+	if (device_property_present(emc->dev, "core-supply")) {
+		reg_opp_table = dev_pm_opp_set_regulators(emc->dev, &rname, 1);
+		if (IS_ERR(reg_opp_table))
+			return dev_err_probe(emc->dev, PTR_ERR(reg_opp_table),
+					     "failed to set OPP regulator\n");
+	}
 
-	if (IS_ERR(opp_table))
-		return dev_err_probe(emc->dev, PTR_ERR(opp_table),
-				     "failed to prepare OPP table\n");
+	clk_opp_table = dev_pm_opp_set_clkname(emc->dev, NULL);
+	err = PTR_ERR_OR_ZERO(clk_opp_table);
+	if (err) {
+		dev_err(emc->dev, "failed to set OPP clk: %d\n", err);
+		goto put_reg_table;
+	}
 
 	err = dev_pm_opp_of_add_table(emc->dev);
 	if (err) {
 		dev_err(emc->dev, "failed to add OPP table: %d\n", err);
-		goto put_table;
+		goto put_clk_table;
 	}
 
 	dev_info(emc->dev, "current clock rate %lu MHz\n",
@@ -946,8 +951,11 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 
 remove_table:
 	dev_pm_opp_of_remove_table(emc->dev);
-put_table:
-	dev_pm_opp_put_regulators(opp_table);
+put_clk_table:
+	dev_pm_opp_put_clkname(clk_opp_table);
+put_reg_table:
+	if (reg_opp_table)
+		dev_pm_opp_put_regulators(reg_opp_table);
 
 	return err;
 }
-- 
2.29.2

