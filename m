Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFD3B8C1F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhGAC1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhGAC1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612AC0617AD;
        Wed, 30 Jun 2021 19:24:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u20so6115307ljo.12;
        Wed, 30 Jun 2021 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCwohtIz3sCtyYyXBVentwmefpHY5XVxUVHIc+3K8pk=;
        b=XxV2PXccub5gL4UFzOEf2lkunHDZ6JDQIsv3Pkr16ah73RBm7xcGYlqWEolys4Ur+r
         3tkygAmQYHm+q3gdEMA1GrL7qb7Tjrz8jupGkjQDhPIv5lqWZ1qIaVhwCzNbLeHVjj7u
         AFxRblkyWF6IYcT446qkn4INxKWeqJBcccZCppYkka6l4qRdbuA7Kf9bx414LlK7elB7
         dcXySBbrzNaOFCLFlqWZTweNHtgMqjDsvpEs1b5dJlspMqUkHN3/d+ilqcd+d+fJwB3J
         IpsK1ZNI3jpOF3+QYzoPDNMbZnH1kW844FlAb5CbFD8ufqKfxQkfaCd5u/xDerBT7Gg4
         zR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCwohtIz3sCtyYyXBVentwmefpHY5XVxUVHIc+3K8pk=;
        b=tIXyyCcASkC/SYoibNhB+c37Vx08yDcDiLQS7vthfnyIX7Fd60bPIzIrNDfbYvrueg
         EMnrXhweo+EIr401AxbFzTtX6gefIdqqVyjj99no56y7+SANiH2zZZoQU4X58B2ZYjIb
         Llab23CC9xmS+fFRVBA6eDkLcJhY/4h2f6jyLa2ZnQogHVv3eUSwR52EPZ+Hrxhhgbqe
         V+4J3QioUcIMMJ06keDhyk9MNc5uq+MHG/uhZq2Fg+3hkJWPqPgPaxyA0yB9RCzkhrD0
         ZhDIG6OTDFha3PHwFAA/AtDzSr1UMsDeTeO1EHvDfAvUmCnXcXlc25OJ5gmyR7gWVXse
         6+OQ==
X-Gm-Message-State: AOAM532H99JMaHWkqLux5ucHkSZuyGUTn1JiFXB1GMXIEOiRwe1KJHLh
        YaVgBR7S3iWyuyZQsgr9kBI=
X-Google-Smtp-Source: ABdhPJyMARDiyQ+EZ9AIx/bYIcUlMrTrOT7a1tX7E9FK7PHW8cPpFgduAmN2JM1n/Pjyuh6AKkUB6g==
X-Received: by 2002:a2e:502:: with SMTP id 2mr10228083ljf.36.1625106286623;
        Wed, 30 Jun 2021 19:24:46 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:46 -0700 (PDT)
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
Subject: [PATCH v1 03/12] soc/tegra: pmc: Expose USB regmap to all SoCs
Date:   Thu,  1 Jul 2021 05:23:56 +0300
Message-Id: <20210701022405.10817-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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
index b5a924baef4e..f8fcfc9750f9 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3212,7 +3212,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3273,7 +3273,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3330,7 +3330,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra124_powergates[] = {
-- 
2.30.2

