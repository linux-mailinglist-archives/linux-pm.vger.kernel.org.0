Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0B534E6A
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347212AbiEZLpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbiEZLox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:44:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13BD6818
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x143so1472360pfc.11
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpIXnp/tGO9yryIO5uLfqtwQ8qkcQ6bLFqmnA/PDaH8=;
        b=MFdcYu76oyCuRELMA/UT6I8+Uofdl+CvLDfOYzFOWIDdBxChsj2ZxhDT5WiAjixcEc
         aNbPSVIFjJFn0IADZdzVqnNa8KIpeqZTDGjQgmAOp0jJJipQREmct/n8fxQFoStBFY5O
         ceSwO/I0g+3z6RImm1ZiCxOvTwLgh1oUhAWmwSx6ih3HRTkHW2K21qXMkQV4A712055U
         f1AzYPZbCrF6UL5z47AxpwYGQmblPs75rpg/3QrmtQHVIlszkefIP1282rDXPOSLO8p7
         w2Bj7FcLCz5ojSB/RKKm3zJ1By1+iFemQNhw+4k/SRNI8mGMuEtgyUsXIso9qnsP1D4v
         nW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpIXnp/tGO9yryIO5uLfqtwQ8qkcQ6bLFqmnA/PDaH8=;
        b=dzqQrVZ21z3JBtEuTcEgYB+pQvvUNjLruqMzDOJcWKx/NFR1RZXZoF8VQ4GTWABFuM
         vSv8712fe2ja/ct8BSZlT/yi0e+2l/0uKSMoGN3BrW5PkpwrImM5FMvMnSNVCCNkb3Hl
         7zt2eUtnJYhssjskeSKWVWIEIqkKguL0RxwwhfqSoPV4S6JjRlcgUyIGyq9BBt+4B9MW
         +rFacQa9aEUyy4PXPoXYIiKRpx2Ku94YA1qDlAPxf7toMDpe9nRBC30AS451VWI8cIbY
         5ahTIBcauIKwRltsRrinyL3zv8ajWcpqRcD/3wXqYdCYeUZBr+QDufEEVqweqALXZxBD
         Cj+Q==
X-Gm-Message-State: AOAM530rmoslmyn2Omx4UycNPLdwbqx4nYOqFNoEemgw3p043hU5D+yI
        C1eNmVykLmljsJ1k1whOXXuZsw==
X-Google-Smtp-Source: ABdhPJz53ecZNA5N1GA7gWB/uJLUku58lnZBPmy2rotuPeH9S8qnNu4uShufq05gKx8Ahp/HIrEYxA==
X-Received: by 2002:aa7:84d6:0:b0:518:8b7d:bdad with SMTP id x22-20020aa784d6000000b005188b7dbdadmr24393258pfn.59.1653565474829;
        Thu, 26 May 2022 04:44:34 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902e0c200b0015e8d4eb260sm1256061pla.170.2022.05.26.04.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:21 +0530
Message-Id: <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/tegra/common.c | 8 ++++++--
 drivers/soc/tegra/pmc.c    | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 49a5360f4507..7ba15cb836e8 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -107,6 +107,10 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 {
 	u32 hw_version;
 	int err;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &hw_version,
+		.supported_hw_count = 1,
+	};
 
 	/* Tegra114+ doesn't support OPP yet */
 	if (!of_machine_is_compatible("nvidia,tegra20") &&
@@ -118,9 +122,9 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	else
 		hw_version = BIT(tegra_sku_info.soc_speedo_id);
 
-	err = devm_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	err = devm_pm_opp_set_config(dev, &config);
 	if (err) {
-		dev_err(dev, "failed to set OPP supported HW: %d\n", err);
+		dev_err(dev, "failed to set OPP config: %d\n", err);
 		return err;
 	}
 
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fdf508e03400..01ec76dd433d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1366,6 +1366,10 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	struct generic_pm_domain *genpd;
 	const char *rname = "core";
 	int err;
+	struct dev_pm_opp_config config = {
+		.regulator_names = &rname,
+		.regulator_count = 1,
+	};
 
 	genpd = devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL);
 	if (!genpd)
@@ -1375,10 +1379,10 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-	err = devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
+	err = devm_pm_opp_set_config(pmc->dev, &config);
 	if (err)
 		return dev_err_probe(pmc->dev, err,
-				     "failed to set core OPP regulator\n");
+				     "failed to set OPP config\n");
 
 	err = pm_genpd_init(genpd, NULL, false);
 	if (err) {
-- 
2.31.1.272.g89b43f80a514

