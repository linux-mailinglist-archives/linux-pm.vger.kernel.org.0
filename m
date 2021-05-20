Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D304338BA29
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhETXKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhETXKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85433C061761;
        Thu, 20 May 2021 16:08:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w7so8410033lji.6;
        Thu, 20 May 2021 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ueM1JtdL2WEXVwCBbL9rRWyabHSIsAzV58fGIccOqXs=;
        b=ScRQ6CA087L27fm3HJWgN4uDimqch4eVaPGIfcXsl0wqhX9m6Suje7Hhzhvu+YEXat
         lFsr6sqxZ5flPlmywvWEaMAHhBofQj1VwM0TxP7wfoJyew80ewG/5kNu9wxXvH4go8AI
         Bcf2qdUAiPl8e4/nrRIrH80gsxTvpYe1/29jlMLg18+UZfdS7kfjIhZxAjMLmEgqvmgI
         yICCE8aFjTqkLjrDZ8bFUaJveh1HEpDuLr4NoUh3vy1J09xomamzQHxLP7mpScDlp8+O
         DRXhj5VnaRzJTLuHZBG+ume8Hfx6VLYqy6CD0K41Og1QyKVRKpSk5lF1wRONiHcj/Vzq
         h28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ueM1JtdL2WEXVwCBbL9rRWyabHSIsAzV58fGIccOqXs=;
        b=ejaT54Klv7TmO2CEKfWPYvac9MFANTHZKGmnMZ7NOnWnYBUOM55hd9xcbfdHdcRHtq
         bhHPr2JEGvylEoVjfi1KLmluHI+f6vtZIIFSZHm1f5jspLeTDnc+XsduySE1HmQgvQH8
         JHK2cXrRQfm5G5MHaLfsJVuwB+UW3BbDlBY63mBs3knsT4TP4QJAfLBR2Rx0d4ObJO6/
         gIbKOMLhBcwgegwB9p4FjabZd0k7QcCjxZyzWkjFQEAPkuEbDn5vKDbIFZg1a9sExrRZ
         AOReVeg5jVJvWPBI6hWZY8QSOkJ9TLAGADi2hcmiN5HcYIcIsd2xC5Rmght/fYvRbLuF
         I08w==
X-Gm-Message-State: AOAM5338shWrmBY8QA/nhg3K4J4HNzsKTCBGHne19wqYCWBIyYJ7g8vt
        3pamSV9mZYvW+YMUBb+jYDU=
X-Google-Smtp-Source: ABdhPJxtYewR6f5gVCXQzz+EP35CO4z7YrCr0YJ+FuWki0bPT+0Cvvgcszs2YMxR3hhTUAopfCyE+w==
X-Received: by 2002:a2e:9d59:: with SMTP id y25mr4461068ljj.399.1621552127936;
        Thu, 20 May 2021 16:08:47 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:47 -0700 (PDT)
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
Subject: [PATCH v1 09/13] memory: tegra20-emc: Use devm_tegra_core_dev_init_opp_table()
Date:   Fri, 21 May 2021 02:07:47 +0300
Message-Id: <20210520230751.26848-10-digetx@gmail.com>
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

Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
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

