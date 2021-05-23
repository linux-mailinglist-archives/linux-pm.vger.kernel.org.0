Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1D38DDD5
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhEWXPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 May 2021 19:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhEWXP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 May 2021 19:15:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9EEC06134A;
        Sun, 23 May 2021 16:13:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s25so31124365ljo.11;
        Sun, 23 May 2021 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iV9WsCaJBCveviAJl/4FdlzG92k3/7giwze1EtuzJCY=;
        b=QfVhdIFPN0mTsYknJiDggYNwyf5dvrxOUOZd3TmpbKqpu5Z7gv/ab1XOp7UB3rx7en
         r/ptTyc/lDjQXHpJ2pCg9CTbRVW4jqXV/QyF1YPB8iNkMffByc4Fydkz4zrb81aA1FOW
         YvGzFmMxvhtQrvbL+Xnq5G+C68YDDl+3VcSOS4BqDwc69eIZO5AdD6AVE8eJrhAwIS10
         SZRmEoAuBdZf6UEnI/gOt6p6pjtReQo0RsbaVxOugoTs0hWrpayw+zCko6YqjabbieQj
         N5S3PDSz35dL9ZjU5L/94CRT3cHfJKNSGzIzu3S0sOsrD0zBRowUg7JFjvY6TMoHCmeg
         w4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iV9WsCaJBCveviAJl/4FdlzG92k3/7giwze1EtuzJCY=;
        b=qCR7HUnY7OhiI8+9tJuIerZ7bdBKW1nsdabK/cHBjqQC4otJnU54WcsP9YNPGDZoVx
         aSylVAn8EcQQiflb21J7dSrFzlHyHMH7pTmuzGhvVxxzAUYXjc57LKKWuxtpmE5TqpoW
         FZJF5kGdoUhtxV5vtjGapGDa8WwGfCopyFqll5xfC3p+SdbqFZDmWIhr7Pkm0hS4/pqW
         2B9f8PBO9dnnn4Lag+9wF//6Psqw2peArKSCbRgImKL0coQ/BUwIZmSfILQdRgef6vAi
         DBfezK4WEaQZVZ+lXxdg4JdBlQoUkqXkU73ZQNTgzIbHGrB8a3t155IAdxJn86qOZDgl
         mKSg==
X-Gm-Message-State: AOAM532syoiPyrhDH52E27JMlHCnZzU6NB24QpljUV3+nbraCdUSKMBq
        l+qkQrT/MTmEV5Lt3WqCLtY=
X-Google-Smtp-Source: ABdhPJwk0wMeyd5GCDHBjWhXZ2eNJO85HKcGbMNk+g+tUIkxtXtnRDYpBvHV/EB2U1Mnno/D3FaDng==
X-Received: by 2002:a2e:9c08:: with SMTP id s8mr15102528lji.64.1621811635724;
        Sun, 23 May 2021 16:13:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-110.dynamic.spd-mgts.ru. [109.252.193.110])
        by smtp.gmail.com with ESMTPSA id p7sm1268619lfr.184.2021.05.23.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 16:13:55 -0700 (PDT)
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
Subject: [PATCH v2 10/14] memory: tegra20-emc: Use devm_tegra_core_dev_init_opp_table()
Date:   Mon, 24 May 2021 02:13:31 +0300
Message-Id: <20210523231335.8238-11-digetx@gmail.com>
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

Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 48 +++---------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da8a0da8da79..a534197a5fb2 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -908,49 +908,6 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 	return err;
 }
 
-static int tegra_emc_opp_table_init(struct tegra_emc *emc)
-{
-	u32 hw_version = BIT(tegra_sku_info.soc_process_id);
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
@@ -1077,6 +1034,7 @@ static int tegra_emc_devfreq_init(struct tegra_emc *emc)
 
 static int tegra_emc_probe(struct platform_device *pdev)
 {
+	struct tegra_core_opp_params opp_params = {};
 	struct device_node *np;
 	struct tegra_emc *emc;
 	int irq, err;
@@ -1122,7 +1080,9 @@ static int tegra_emc_probe(struct platform_device *pdev)
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

