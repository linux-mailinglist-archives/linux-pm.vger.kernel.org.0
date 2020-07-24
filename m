Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28F722CDBC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGXSZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGXSZY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:25:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520FA207DF;
        Fri, 24 Jul 2020 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615124;
        bh=mzqyDslgXyru9ThgDEx6mSS2S/hN5QaatlIUgMTpLls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdkiyoX2t7hVc/xNS97HZkMxePcYUwXRHyIbBaSPKAfm6X910GkHTfQbkOEXxlZDg
         ceJacWRxRsWIotLp8cQawCUJ9QXvhq8wtmmANLdjznV4ECvSwfDrRhUucBxAdYHfrD
         zlNFZC/Ydw3PmIA9EkDjRyo+Ehp/uDzNI2OEhbnQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 16/16] memory: samsung: exynos5422-dmc: Correct white space issues
Date:   Fri, 24 Jul 2020 20:23:28 +0200
Message-Id: <20200724182328.3348-17-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unneeded blank line and align indentation with open parenthesis.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 0388066a7d96..62a7193e3904 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1394,7 +1394,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 		return PTR_ERR(dmc->base_drexi1);
 
 	dmc->clk_regmap = syscon_regmap_lookup_by_phandle(np,
-				"samsung,syscon-clk");
+							  "samsung,syscon-clk");
 	if (IS_ERR(dmc->clk_regmap))
 		return PTR_ERR(dmc->clk_regmap);
 
@@ -1473,7 +1473,6 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 		exynos5_dmc_df_profile.polling_ms = 500;
 	}
 
-
 	dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
 					  DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					  &dmc->gov_data);
-- 
2.17.1

