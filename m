Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863263DC74B
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhGaRjL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhGaRjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F012C0613D3;
        Sat, 31 Jul 2021 10:39:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h14so24913064lfv.7;
        Sat, 31 Jul 2021 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXMoaxYyUFyeBQf/z4hD/RbH6NiurueNUmtWOBswMCg=;
        b=nxJf7RheO/stMR+RezGMKcmcK0oDekk2Vh4y7QU29nSNwI+nvNlA64ox/zit7I54Gk
         QksHfFWlPPlyf+qhbUE5uGYNS6yPSwMTh6Mm07+oP2K4MvIdQ6/MwHH56bbrU+BgsXi7
         DdPuSDkQiasLiQKnj2Bbr/lVjfkpk+iNOGfcMZHP1853ntTy0+43wVuTplzMW+juf71Z
         LWIxt4TF7bGBsXzPGGsWh1jDZniW0zgA+mFk8Gg2DTZW6IUoAHOWqublbX8rj5SfmiEM
         tq0TKMtWVumccTVAcHCexHko6Gu38tTDIip7e5mAko495/kZFxI36rxdPW0WsAsInf5/
         ukIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXMoaxYyUFyeBQf/z4hD/RbH6NiurueNUmtWOBswMCg=;
        b=RGDG5CbIcGrd7VqTXY+2gMCiGmI5j/kGQ0kWrE5vcsn2NyJ0OPZS6Yh7kB081uxab6
         HZx0vMAxctL6ZwIMhIi6dQUuADPVrM8LVLw3if2Jsp7eD6La5IYLUPFVcLSRxrOFZXtQ
         ZuMisYMxN+J4fiROBTkmpy4keA3nRg64QzBT/j/DJX9iEZCTlE4Ios9wDTFXcDOWNGDb
         vr/GUYkq1EAEooeyPAAnAawPdtMK7Zc29BpBT43vgb0daXKm0b9bnemsX3ks7VSEfsTo
         9nCIaPFbW/Cb2xvGf1OIk971thx9Ssi3a5t1t7numlwVYjA/VI+NSeb73YSL1URF9S/M
         fbNw==
X-Gm-Message-State: AOAM532Q3gjXckoIHG40vE3FjR3rmP+1Go662sIuUqPm0Gd/MFGyQOGC
        HY7hUZQLkLnXnWVJHD5LaIo=
X-Google-Smtp-Source: ABdhPJwi5j5iTxuXyKI+2kUzkdXGXA1hWANqhzCes4StUiYdW3Uto9B4T+VD57J24tdskvyTwJfc2Q==
X-Received: by 2002:ac2:5cd9:: with SMTP id f25mr6295419lfq.79.1627753139751;
        Sat, 31 Jul 2021 10:38:59 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:38:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 03/12] soc/tegra: pmc: Expose USB regmap to all SoCs
Date:   Sat, 31 Jul 2021 20:38:33 +0300
Message-Id: <20210731173842.19643-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
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
index 59ae7277fdda..81d1f019fa0c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3214,7 +3214,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3275,7 +3275,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3332,7 +3332,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
-	.has_usb_sleepwalk = false,
+	.has_usb_sleepwalk = true,
 };
 
 static const char * const tegra124_powergates[] = {
-- 
2.32.0

