Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90A238DDE0
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhEWXPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhEWXP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38574C06138A;
        Sun, 23 May 2021 16:13:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b26so21939508lfq.4;
        Sun, 23 May 2021 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUIhc9uggXHCPJQoAO/4UpzdPZReard7z2PxwHsBSd8=;
        b=sPuVNjklWazPz5UI6/nYXY/nYJbA5etlJj8eT/8zgkfQ3QV31vWKcJFsPmgwu8PjbL
         FRuhuFaK0bqAVfBB7p1bXXZ9/afWi6YuiyX02iyvaxVALqhhSp5yrvbDVHrZvjSf1eSc
         Y/jYcwDWwlG42JDEP+A94dzAXNwe1UcC/2/LWklNIDkOME/LYWJLYv6hG6oeQNl42cCP
         Kr4/cLbEp2dg6aSfU0/qnEv3QF3VQ8524Rr2P6nuOzCgFZnvp8Yt9KluZuWz8NxnPc2I
         XjBtd7/B9VNHlAPkDvjgzziPOgs0VPP+xAEjarT0UALZixHmWPjouRo3+RdArr6qon3j
         +xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUIhc9uggXHCPJQoAO/4UpzdPZReard7z2PxwHsBSd8=;
        b=ozLuMjoEfpq+mjESQjHi1LnvHeFhfWj7kj2EG1JizQIhANQYjTh0iWkvRCdZlja8sP
         PAsJ2hvzzJBpTzQ8u95rSINcav4r9FRtaUmzbcEIqbs/pmFpuX7g4Xe+Yvs1+SJOIfxw
         68a2c0SxU8YCYBAJPwIxgKRHO6csJudPhtAMAdyBcxtpmeTV2WvhjLdFw+YnICWZOzut
         5dPjmd1ExaD1AdoTjgf9hvHT0htjFz91VBGFDySDrVZpm+aq1YdhxFbcW3UXooplCdUA
         VuJPQ9Fc322v7S8NabF18ewYpKEUAbzx5/wWSLjaL69YoT9so8KaTYPOx9K5go3QyGlP
         aOCA==
X-Gm-Message-State: AOAM530bcMMZMbhwZytafSCfQLoeKfuYJyi6xTUpzkfji3HzBuhD4aYM
        K2BfVpUxMyTX7cMKGGo/dd4=
X-Google-Smtp-Source: ABdhPJytLc6PgenMaqeme2OHkrPqIVo7yxUr//ng0ctdYT/h+eF5e5v2H1uoH2uGaYcjTINFjH+SdQ==
X-Received: by 2002:a19:7108:: with SMTP id m8mr8712898lfc.404.1621811636628;
        Sun, 23 May 2021 16:13:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:56 -0700 (PDT)
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
Subject: [PATCH v2 11/14] memory: tegra30-emc: Use devm_tegra_core_dev_init_opp_table()
Date:   Mon, 24 May 2021 02:13:32 +0300
Message-Id: <20210523231335.8238-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210523231335.8238-1-digetx@gmail.com>
References: <20210523231335.8238-1-digetx@gmail.com>
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

