Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFBE393840
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhE0Vpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhE0Vpi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4AC061343;
        Thu, 27 May 2021 14:44:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a5so2332394lfm.0;
        Thu, 27 May 2021 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUIhc9uggXHCPJQoAO/4UpzdPZReard7z2PxwHsBSd8=;
        b=Yczfx/RsfoFRSToQRTHR7l8rYFxZ2D097g20XQV1Gh7sL4WXVwLFc36qhbXnV9Lc2B
         T9CPi2+EhRQhZ0SRUGFCpLCfy/tI3AkXghvbZ/czt61zKav1TCRzwVyR9ddGtwQPSR8b
         DP56QQoMSyVi/1N34FrYW07xJ5er8l2jgmXlbs7fWgOAIcaBbNrnNul4FSEvM08Dfqab
         eEN2t7LqF7UV82x6xuV5n7H7zDHExGJQ2piSIAB0+XnmtW/xa7V8D1Z4aZcmN1sZdIu0
         X0JuT41lhaKz4lIGtYW2jvzPrdtOYXG5X4ZARCkjetHKVXEsOP1cw9oJUnePSDSfl/EI
         PyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUIhc9uggXHCPJQoAO/4UpzdPZReard7z2PxwHsBSd8=;
        b=kEZgL01c+h4Uhctp+2+Lp0dk70TB3fH/P/2Q3bgp0OCl9GThUHIJ6IsEAkGHmCfFoO
         y0ft1jhbAWJO+VYs3pwTVMTFshX1HjOqaoNEsDWVCHG/awkUZOaTiF74aqz22oEIwJHU
         lnOGc/6cteim3or+rMiW1yVOPtTaUx6XSONhUQm+NV9WaT+nq+y6ZS/kn/fJo8z35puB
         tpi7a/Faq61KRF5OMg0eVMIyvt8CZ02xSUiLTa3XZZ2w5sgo5XWxCtKV5ZAzpz/6wKNT
         PGeLNmXi1CbN5jEELpaQdneXrEKZhggqcRbytiVVV/HNvbrsMMB/xNmA/5XadVKh1O/0
         GqPw==
X-Gm-Message-State: AOAM531bze0VbPeBDbd8qk0YStLJDJWDBDDuQWWRXgnPTTbQOSFS4PXf
        Rds89Qid5xUzUIKIuc1fyPU=
X-Google-Smtp-Source: ABdhPJyRXlDgXJAcRDhXIu4xBSDCKdFbroHX+LIR24o0iZXhlvS7lUy1yjttlY4Ytv4E15ErfLiwmQ==
X-Received: by 2002:a05:6512:3d20:: with SMTP id d32mr2326845lfv.459.1622151840867;
        Thu, 27 May 2021 14:44:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:44:00 -0700 (PDT)
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
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 10/14] memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table()
Date:   Fri, 28 May 2021 00:43:13 +0300
Message-Id: <20210527214317.31014-11-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use common devm_tegra_core_dev_init_opp_table() helper for the OPP table
initialization.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

