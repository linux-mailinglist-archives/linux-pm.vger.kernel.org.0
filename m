Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EFD407F82
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhILSrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbhILSr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 14:47:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65BC06175F;
        Sun, 12 Sep 2021 11:46:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c8so16187587lfi.3;
        Sun, 12 Sep 2021 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cA9wCB4pJs3LwykWyuF6E7GswKKTAqR9cFJTGNkwFK0=;
        b=ebGIUHhU/O3xwyDCfIyt78Idq3t7nmsldhA3xOCNUQUm0W+O+25Xx9UxvEv0tnGcxH
         /GQ4hKlJsfCyJTaosNtrPLsTkPWJaS7jvHOiz+iXEUtECZCX6BQW4Te3Q8vcInRIwdMo
         Eh0G7H/G2CFFBBaORNtrN82GXKMEy3DwSyMgrp+dRgKDU9DdnDybtUhxeVfBPDaUXvvE
         W0Q/lMpvPPGVJe0I7pNMPgc3QYIOPg8y8J0bHAC57GpXHfMoSXZIXVwEErQ1onwqTp0W
         g/DPUMDqxD1syBYmyq6xsdiqLpJNQ+rXEyQDGRRhaVa1rNtWxrRmNFLfmvMImhYfDzrp
         qwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA9wCB4pJs3LwykWyuF6E7GswKKTAqR9cFJTGNkwFK0=;
        b=Zk4i2vpnd84dkWvAQt6eP6r7q3XwtpXrpekstgaeS34km9m8vF4M81pEMA7qpF7adp
         YxrHLyH8u/LC1Sa1vzxuV1g+IBNFno6O1EOXG/MsNCtHFNeQpnoUKql5nCpDZvpFY1yh
         RZfjj7bjx21JNsTl7ZreAPH1cBlBUYPgsqzMsGLnhZV1lzjKlWiFRgYrpm5Rt3sj3gZ8
         TvxUky4L2N1EBVLnA4zUFuVuuQNRw7lxGmd92Lu0NoSql8NMn3Mxd3E59daTG+cnqtBS
         fKXRNqxT8Rb5t6ts5k+V8ZmcUmqUyFcjprozPWieyyAQRatC76OAA6hcF2MxvxInnME+
         N9eQ==
X-Gm-Message-State: AOAM533mGFprNDQ3Nji3NUBc+AwfbTAFinKggA4ei07TdGgmKIxwOvBh
        f3glAcAOanBpoWbi3gf/7oE=
X-Google-Smtp-Source: ABdhPJxs+Y1nLxWOSYcrF26pzuzYbCdwnhV7GWyzXdd1pPVwJm+WVLqVoZI5c/5I3IuH1CMZYYoyfw==
X-Received: by 2002:a05:6512:96f:: with SMTP id v15mr6020534lft.455.1631472370361;
        Sun, 12 Sep 2021 11:46:10 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id q5sm588570lfg.36.2021.09.12.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:46:10 -0700 (PDT)
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
Subject: [PATCH v1 3/4] PM / devfreq: tegra30: Use resource-managed helpers
Date:   Sun, 12 Sep 2021 21:44:57 +0300
Message-Id: <20210912184458.17995-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912184458.17995-1-digetx@gmail.com>
References: <20210912184458.17995-1-digetx@gmail.com>
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

