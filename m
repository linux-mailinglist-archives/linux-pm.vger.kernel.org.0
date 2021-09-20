Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB464127AA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhITVEe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 17:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhITVCc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 17:02:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1FC059361;
        Mon, 20 Sep 2021 10:23:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i25so71362352lfg.6;
        Mon, 20 Sep 2021 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cA9wCB4pJs3LwykWyuF6E7GswKKTAqR9cFJTGNkwFK0=;
        b=ZmnX5lSP/OyvwfdTBy8gpdpR/T5W8S884Yg6Y3NRfliyKE23Let6UeaW228GDvGqeZ
         rkVgtroX2/5ES0zc1SAVM+aNGEvn3HfJk8p4djXsqFTv8G2XVt6DfLGOGKJrGrWC0ly5
         JOViUGyXKQH7vWrnCSGWz5JdBSkOl9pcMkJL9GDRgh6A1IKslgEDV6gRUibgTamXvbap
         ci8EdfYtutR2NctkgGVb1ito0ocnXyZRubDyO7YB6bHPVvk9ruEK2FmI/WjaBG+argbY
         ByCCrqQ5Ds6jTvzC2NZNkcIKEalfpQmF6qWisDmG1Vo8x9wfIYL2kw5Lo0WlTG4YTfCd
         aZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA9wCB4pJs3LwykWyuF6E7GswKKTAqR9cFJTGNkwFK0=;
        b=MVT+wxc1P9IKHSLeZMWvBXd1QXDfHmerJtPMq2r/JypwzFQAPTsyOb6VHwQCgBqrdO
         /8MvXlMXoQSmdYCs/CdfoK0YBQgCx3MQu4nwYBoTRomCpvB6+bYcqlT/MTQvVZ2EPHc2
         HqotA/7dhS9ac25f5r5ZBurRRH9bsanOeaJSpQK6ZhnfErSQkP7WpUML41S4gKRqyO37
         uokv2MBAJsb7e29bhSLmLePPuRj6E04aOWE0ZuWCqpr6cZynT6fcYdBHW1BhxV7tspj1
         pzkb5j35p1UTEKZ+Py4TJfoYGk3u/SzETj4Mk5dpzOBDPJXtYGPpWQgmLfcQfSN5jZ1W
         t1Cw==
X-Gm-Message-State: AOAM533bsn67UvWmtlh+17Pl+tKpJGiFJIqKRsKHLN8ChLpm1LNGYQOY
        Mn41UO+DnoQdKzN8rLE8muJSf75y7w0=
X-Google-Smtp-Source: ABdhPJxAUfQjb/JVjl/EG+/PWAmCAeGicXjmL2WmSdcU3VEse5fhbinIjrHAFmdAdJi8jxSNEdy5zg==
X-Received: by 2002:a2e:9e53:: with SMTP id g19mr1719816ljk.478.1632158596408;
        Mon, 20 Sep 2021 10:23:16 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id t13sm1311038lff.279.2021.09.20.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:23:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/4] PM / devfreq: tegra30: Use resource-managed helpers
Date:   Mon, 20 Sep 2021 20:22:48 +0300
Message-Id: <20210920172249.28206-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920172249.28206-1-digetx@gmail.com>
References: <20210920172249.28206-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use resource-managed API helpers to simplify driver's probe() function,
making code cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 107 +++++++++++++-----------------
 1 file changed, 46 insertions(+), 61 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 10661eb2aed8..d83fdc2713ed 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -178,7 +178,6 @@ struct tegra_devfreq_soc_data {
 
 struct tegra_devfreq {
 	struct devfreq		*devfreq;
-	struct opp_table	*opp_table;
 
 	struct reset_control	*reset;
 	struct clk		*clock;
@@ -789,6 +788,39 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.event_handler = tegra_governor_event_handler,
 };
 
+static void devm_tegra_devfreq_deinit_hw(void *data)
+{
+	struct tegra_devfreq *tegra = data;
+
+	reset_control_reset(tegra->reset);
+	clk_disable_unprepare(tegra->clock);
+}
+
+static int devm_tegra_devfreq_init_hw(struct device *dev,
+				      struct tegra_devfreq *tegra)
+{
+	int err;
+
+	err = clk_prepare_enable(tegra->clock);
+	if (err) {
+		dev_err(dev, "Failed to prepare and enable ACTMON clock\n");
+		return err;
+	}
+
+	err = devm_add_action_or_reset(dev, devm_tegra_devfreq_deinit_hw,
+				       tegra);
+	if (err)
+		return err;
+
+	err = reset_control_reset(tegra->reset);
+	if (err) {
+		dev_err(dev, "Failed to reset hardware: %d\n", err);
+		return err;
+	}
+
+	return err;
+}
+
 static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
@@ -842,38 +874,26 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	tegra->opp_table = dev_pm_opp_set_supported_hw(&pdev->dev,
-						       &hw_version, 1);
-	err = PTR_ERR_OR_ZERO(tegra->opp_table);
+	err = devm_pm_opp_set_supported_hw(&pdev->dev, &hw_version, 1);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
 		return err;
 	}
 
-	err = dev_pm_opp_of_add_table_noclk(&pdev->dev, 0);
+	err = devm_pm_opp_of_add_table_noclk(&pdev->dev, 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
-		goto put_hw;
-	}
-
-	err = clk_prepare_enable(tegra->clock);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Failed to prepare and enable ACTMON clock\n");
-		goto remove_table;
+		return err;
 	}
 
-	err = reset_control_reset(tegra->reset);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to reset hardware: %d\n", err);
-		goto disable_clk;
-	}
+	err = devm_tegra_devfreq_init_hw(&pdev->dev, tegra);
+	if (err)
+		return err;
 
 	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
 	if (rate < 0) {
 		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
-		err = rate;
-		goto disable_clk;
+		return rate;
 	}
 
 	tegra->max_freq = rate / KHZ;
@@ -892,52 +912,18 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&tegra->cpufreq_update_work,
 			  tegra_actmon_delayed_update);
 
-	err = devfreq_add_governor(&tegra_devfreq_governor);
+	err = devm_devfreq_add_governor(&pdev->dev, &tegra_devfreq_governor);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
-		goto remove_opps;
+		return err;
 	}
 
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 
-	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
-				     "tegra_actmon", NULL);
-	if (IS_ERR(devfreq)) {
-		err = PTR_ERR(devfreq);
-		goto remove_governor;
-	}
-
-	return 0;
-
-remove_governor:
-	devfreq_remove_governor(&tegra_devfreq_governor);
-
-remove_opps:
-	dev_pm_opp_remove_all_dynamic(&pdev->dev);
-
-	reset_control_reset(tegra->reset);
-disable_clk:
-	clk_disable_unprepare(tegra->clock);
-remove_table:
-	dev_pm_opp_of_remove_table(&pdev->dev);
-put_hw:
-	dev_pm_opp_put_supported_hw(tegra->opp_table);
-
-	return err;
-}
-
-static int tegra_devfreq_remove(struct platform_device *pdev)
-{
-	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-
-	devfreq_remove_device(tegra->devfreq);
-	devfreq_remove_governor(&tegra_devfreq_governor);
-
-	reset_control_reset(tegra->reset);
-	clk_disable_unprepare(tegra->clock);
-
-	dev_pm_opp_of_remove_table(&pdev->dev);
-	dev_pm_opp_put_supported_hw(tegra->opp_table);
+	devfreq = devm_devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+					  "tegra_actmon", NULL);
+	if (IS_ERR(devfreq))
+		return PTR_ERR(devfreq);
 
 	return 0;
 }
@@ -967,7 +953,6 @@ MODULE_DEVICE_TABLE(of, tegra_devfreq_of_match);
 
 static struct platform_driver tegra_devfreq_driver = {
 	.probe	= tegra_devfreq_probe,
-	.remove	= tegra_devfreq_remove,
 	.driver = {
 		.name = "tegra-devfreq",
 		.of_match_table = tegra_devfreq_of_match,
-- 
2.32.0

