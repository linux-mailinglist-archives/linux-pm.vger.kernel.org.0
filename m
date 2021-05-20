Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD338BA2B
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhETXKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhETXKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A792C0613ED;
        Thu, 20 May 2021 16:08:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i22so26750172lfl.10;
        Thu, 20 May 2021 16:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQZHp644leGBiDoAtLsi0NO5CZsR01CseaLHVTdWn24=;
        b=DC/NS5/fjRqY4P5RwjLArBd/yN7tuNIB7QP0vuhQDqY1tpm2B86mAoQezhHawLFZXb
         j5y4uATVLu8pg3mKDPsePE3hdQxm/qgBC3ux8tUSpJX5Ngt0g+QYvirh6NWfWd4hSMOd
         f9KjBIVq0FczJzTIsW4zs9XqYGAoyHCVGYJzXSMD4wN0Yt12rMeJsh6DQawJMcMcQ5uN
         UHVBZaySJXHhGDTpmfc0i+xUEfvB834j8wZlw0m1yDA7/Pv2VObHULM1YSJ855uC7bLk
         02aK06w2AWCDHExXSACZDn3qkS8WQflrOZ1PtuegwamaDSJOoJeXMmJDTR49xpuiIjuo
         CA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQZHp644leGBiDoAtLsi0NO5CZsR01CseaLHVTdWn24=;
        b=ZyYGCaCZDsmVwp2LpyE3R8I0gJBGA33sBWJuJXaN4kegMOBV9/L2w3+h+Ho/bO7m1B
         AVcSYT/XJkHUuhKCKkc+A2c2vwEEmYPOk0HXKQlvVn+2AXPFsVuhuQd+Mu/NLruC7jV+
         66Z7z49NgaWdoISd1axtlIlzDIhmkURUNteC0DUnnmUTnrsW/usouZmfsTtUzQYqtR/q
         KQsvmcLYPbtbxAdqmgvajDyKi37ksrygk/5gF5wJZIeBagY3UXijkvShijRhxvZQ/Vjz
         SB4JSCAkM1VObgjdKiu8r0nZWzPDuCFBK975T8rRHBsWDHgnnRHejXuoxAZLytZqbMqJ
         Ilbg==
X-Gm-Message-State: AOAM533TtmxH2s4aKRiRvK/3J90yn0YVe4SrTXLLJX1hZqI9R0y4H70n
        zsMAjnf4WOrS9U5esqOrHKs=
X-Google-Smtp-Source: ABdhPJzZIRhwpVPcm8RDIoNjTCqbSkpC4hfwuDEGDcAgk/UxPLLisMtWaSaFHAZSZARTMeKfgEAGIw==
X-Received: by 2002:a05:6512:2107:: with SMTP id q7mr3585526lfr.95.1621552128976;
        Thu, 20 May 2021 16:08:48 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 10/13] memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table()
Date:   Fri, 21 May 2021 02:07:48 +0300
Message-Id: <20210520230751.26848-11-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use common devm_tegra_core_dev_init_opp_table() helper for the OPP table
initialization.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 48 +++---------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index a2f2738ccb94..63e1983f8a0d 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1480,49 +1480,6 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 	return err;
 }
 
-static int tegra_emc_opp_table_init(struct tegra_emc *emc)
-{
-	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
-	struct opp_table *hw_opp_table;
-	int err;
-
-	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
-	err = PTR_ERR_OR_ZERO(hw_opp_table);
-	if (err) {
-		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
-		return err;
-	}
-
-	err = dev_pm_opp_of_add_table(emc->dev);
-	if (err) {
-		if (err == -ENODEV)
-			dev_err(emc->dev, "OPP table not found, please update your device tree\n");
-		else
-			dev_err(emc->dev, "failed to add OPP table: %d\n", err);
-
-		goto put_hw_table;
-	}
-
-	dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
-		      hw_version, clk_get_rate(emc->clk) / 1000000);
-
-	/* first dummy rate-set initializes voltage state */
-	err = dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk));
-	if (err) {
-		dev_err(emc->dev, "failed to initialize OPP clock: %d\n", err);
-		goto remove_table;
-	}
-
-	return 0;
-
-remove_table:
-	dev_pm_opp_of_remove_table(emc->dev);
-put_hw_table:
-	dev_pm_opp_put_supported_hw(hw_opp_table);
-
-	return err;
-}
-
 static void devm_tegra_emc_unset_callback(void *data)
 {
 	tegra20_clk_set_emc_round_callback(NULL, NULL);
@@ -1568,6 +1525,7 @@ static int tegra_emc_init_clk(struct tegra_emc *emc)
 
 static int tegra_emc_probe(struct platform_device *pdev)
 {
+	struct tegra_core_opp_params opp_params = {};
 	struct device_node *np;
 	struct tegra_emc *emc;
 	int err;
@@ -1617,7 +1575,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = tegra_emc_opp_table_init(emc);
+	opp_params.init_state = true;
+
+	err = devm_tegra_core_dev_init_opp_table(&pdev->dev, &opp_params);
 	if (err)
 		return err;
 
-- 
2.30.2

