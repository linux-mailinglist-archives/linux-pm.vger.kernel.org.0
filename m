Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7323BAF7B
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGDW6p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhGDW6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC805C061574;
        Sun,  4 Jul 2021 15:56:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f30so29071359lfj.1;
        Sun, 04 Jul 2021 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drgCVcT3wmtQ8t1tY3NB542KKKZdZqJ23O6KgQby8Tg=;
        b=W/qdVSVGCftMXXcNojYGZegQmHBu5jdT6wPs0NfWKUSNtCs5+Y48mHjJXD98YTW2K9
         0ZHD30Zk/iWyOAo/bx1bmq5HYjM8xlJLNwEsWq6NSPXytAVquYfui3GngWipmSwHOR2r
         JWq5h1A7kkvT1VF81PhS9zjPbYmPel5LhOAQSjRaQoc4hNIncDAc2whT2i0EEAWXX29d
         XeCLI3p9fFTMrQ974VYf4STekZKPgvw5ndBep478Nml8O4umsmsIFAn0KDYtSQpSYYiC
         bIwAzOyr9sep9xLZIRoCrfKcLlL0ELkKZWRI4/d9bX/YS2vuSFjnwwLd6DS5nGrjnDyW
         fo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drgCVcT3wmtQ8t1tY3NB542KKKZdZqJ23O6KgQby8Tg=;
        b=Al+P9Oq7ZI0qFcdnuMPl1n+L7XMYrWw62f3a4BxqjzDIAkaTQeYhn77grUYqop1EOC
         BQ/agoNV6BwFg2TUzz/un39y54Mil/VBMk3p/q+lU4PYii0nIOC/Z/UBW2tLMgmaPUDi
         I8EyUlRNeVw9pc3vKlL13TeUDiGT4T7/5PRCpp4TOqy3WHQTeOTRXxPrcU2tbT/Jrag1
         nyE+59sXgXqgumq6IyfR1x7bnHLu1G06ZhrnqG4a2HpW7GBwwTxzYML3YuNbTpBT3Xkr
         p2qCmbi9fG5ghkr0J6h8UhbqiIqsK3LqvPvWrZxoXPRiPd1Gm9RzeACd9WcGKI3H1sKs
         /9ng==
X-Gm-Message-State: AOAM5314ytO5IeQJ8ZOKMYONEDs+CXfcddqjBYT2qQnzIPNO64o+oK0l
        0c+/2BZdOyKLIAf+geRhqLM=
X-Google-Smtp-Source: ABdhPJwPMx1QllFTrGzHiFWZp5qgQ7R15sSWceRBBPHLYWKbnZ5ml42sZo6hX/4EBlm+EckwhOEvDg==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr7971164lfu.531.1625439362147;
        Sun, 04 Jul 2021 15:56:02 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 03/12] soc/tegra: pmc: Expose USB regmap to all SoCs
Date:   Mon,  5 Jul 2021 01:54:24 +0300
Message-Id: <20210704225433.32029-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All Tegra SoCs prior to Tegra186 have USB power controls within the Power
Management controller. These controls need to be configured by USB driver.
Expose the regmap to these SoCs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1f6872f7b211..73ba4982ba6d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3202,7 +3202,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3263,7 +3263,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3320,7 +3320,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra124_powergates[] = {
-- 
2.32.0

