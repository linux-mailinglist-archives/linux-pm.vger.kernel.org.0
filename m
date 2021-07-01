Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67F13B993E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhGAXbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhGAXbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BCC061765;
        Thu,  1 Jul 2021 16:28:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f13so10772261ljp.10;
        Thu, 01 Jul 2021 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DByxmYrfYSoFtOXvgezAULCD+kJQTte6BMf4Jj2BLw=;
        b=IyY9IJkajgob5/6uiA3dJZZOwAlwoF5a2OenrCfuwzof+vwSxfggxSPUyvrw9HY14p
         l8WIbQk1JpgXE0UcqFufaMzXTp+N/UTO3zOitpXX4YHj6mVvAmRtyykI2Sdps0lwMpjY
         WVidEhoF9aEMEDje0jBOIS80MHbcIArPrt7oxRrHBr8SAcUYfZoG5+xebDMw41BJ0Q+i
         AhiTrICXsOfRiXflvtOhhVhgknBH9KDcj1TOGhctmRiQAa2r/F5TGrOgnfm6pJK3OltJ
         weA+8YBxHY5EL2bvOGBVZ0qe8voPUKo2F+zwd9/V93g9duJLM0G3RN7ivozWPhQCJCI1
         yu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DByxmYrfYSoFtOXvgezAULCD+kJQTte6BMf4Jj2BLw=;
        b=I4liqj1321dtByFPIFMTvSKtNOEUmUzjyu2iaIKHUmeaGYYeKaPOOxZAmGGh/NBwqW
         hXRxwpZykYhBIgzSZdW29DXgbZ/NCCYAtbHfrctQ8ETIf0e3FJb5rxpLsyrH8dPIDMlv
         tzLZJ5K4k3iZoXTmu01btekNQ/ZniJ8jLdnI+Sr9HL9z8MJ/feIp1ch63G7lcfmqxjCp
         zLfO7RiEv2OEO0HUo/6/NKZeG8wSi3HcPVKcLSDyG+gq2gyWMuwKXzX63NSunLSWW2LA
         I4Ai132aB6kTdHKYzFbQEe2utF0V0qbyKsXomYPcYhSkylpcWPdj5X9R/fWzJjcWhuZX
         B7zg==
X-Gm-Message-State: AOAM530lZWBMN9BuApElEgD3fSSrWB5ofItxF/g3lSx6mT6v2b0AD0VE
        8b+seFI/xQF/J90cqbFx3c4=
X-Google-Smtp-Source: ABdhPJyGD4x3fV5UTZqG8S5sHrMDuLGq4yPbUGaXALPZU5QCVl0twJSS9LvqKKIy27oPC49mFdqm0Q==
X-Received: by 2002:a2e:b708:: with SMTP id j8mr1524001ljo.285.1625182132342;
        Thu, 01 Jul 2021 16:28:52 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 37/37] soc/tegra: pmc: Enable core domain support on Tegra20 and Tegra30
Date:   Fri,  2 Jul 2021 02:27:28 +0300
Message-Id: <20210701232728.23591-38-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All device drivers got runtime PM and OPP support. Flip the core domain
support status for Tegra20 and Tegra30 SoCs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ebafb818b08e..1f6872f7b211 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3177,7 +3177,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3238,7 +3238,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
-- 
2.30.2

