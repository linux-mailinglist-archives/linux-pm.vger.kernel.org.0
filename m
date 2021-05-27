Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC5393842
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhE0Vpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbhE0Vpi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747CC06138F;
        Thu, 27 May 2021 14:44:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f12so2744934ljp.2;
        Thu, 27 May 2021 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iV9WsCaJBCveviAJl/4FdlzG92k3/7giwze1EtuzJCY=;
        b=XkNSu94YJD7JhuCQ2L7qzYnGHLGhI6wrRAvzfHwWiZOVX3dQYJOus7s9pdwR65yRDU
         r0gn9e3NUM1/j6px5X63xDWxPCCsCdSRTh3V53i34e1PJb6C/vjQNulrUHglZi3DSSL7
         UK9zw6NVZOcNdbhF4EfmA4ZhcQK/xfQWjiKbpdlZvJcGcXpal/Iq/wyRQ/soRALkBjsH
         zrDZXDUxU6NNe/YdlPcOccUUzXkws/hBJSmqMpxiMi3DwUnJYkdZ0QlCRZSzBaixsR9W
         k7RDbwqi2mSqenQ793PWYjK2e5CHXwVslwBsiaDX1MItjji0Pwn/lCaYlTCLl0P/kiZo
         nh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iV9WsCaJBCveviAJl/4FdlzG92k3/7giwze1EtuzJCY=;
        b=sy6RAs3u8EFrTn816x4xgaRBh4wk9LGS3ryfwZ5qI+aA+ZQaQY8BsGJCnLXDGDiPfQ
         4lkqCFpcLhSeRa/lTV2m2TFdhE7Au24V8AqH6snDca03+u4Z8eMkckiR/9L4SJc2y9HP
         dHA89XmX0/QJQP5A/35+uLZRSFcX7CNdlBa0qKgJDwfv6vEDIE/BVfrU8/EszrsoqnIE
         vqe6DmhS5psb5axrauUgEWZ6b8xawiOiFnmM/Vy2W3W/GRkt+dzlPBYLC9oUmUlWAuKb
         VaO0BrsocCejcpJ+NEh9Oou39I44f460ScxJmp0/6DSlFk3Sp4E5s8PEBcVzX4G2HmJj
         0aSQ==
X-Gm-Message-State: AOAM532RujLg8mw7Yw+FjpeZluVbb5fXpy9rf6xqesCaZ3d+5YRsRLZS
        LmuBr5s+M4f2gin73FQdfj8=
X-Google-Smtp-Source: ABdhPJy1Tfd6+d+7deDi2AsD8qMARALgRwBmArAOGrinzU2smSfd5b4c8KAndHtiwhiYAdynN2UpBQ==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr4100349ljg.176.1622151839899;
        Thu, 27 May 2021 14:43:59 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:43:59 -0700 (PDT)
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
Subject: [PATCH v4 09/14] memory: tegra20-emc: Use devm_tegra_core_dev_init_opp_table()
Date:   Fri, 28 May 2021 00:43:12 +0300
Message-Id: <20210527214317.31014-10-digetx@gmail.com>
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

