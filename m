Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5703CC547
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhGQS0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhGQS0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30057C061762;
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v6so21608595lfp.6;
        Sat, 17 Jul 2021 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oahTHnDPuRKVMxkoilhRCRaRgS46Q75QLsZx7nz1p8=;
        b=DNxeSDBL7K4KBQcJd0eSSUXf5VVWYYlP4/RS0R77Ua8Vfv3bRUUOS60owl1Kg95f2u
         1uz2wourtbvLAIFVOHuGc2Xeau0kL3YuVSEqFSjOf/wZABTogaHBEtp/ntOdBSazF4Fo
         VzejZdC4FJhMAOnmzb5PUpDi2j2WmlcBUKFGjAieHRBQknyoYTpHyxd3j3DOdT6wFNGB
         an/CVwU5GGIZCAREjjhKGOuWj7f3wQNCbW91br0ytJL4inkXgeTIi+ydpIpSJGFo4F1k
         rR7BtmUCkRwHnYh8u+l/7woqycGITNM9qZvDAGHiQPiwfASthQ6UKdVq7ATIs913FXSI
         nPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oahTHnDPuRKVMxkoilhRCRaRgS46Q75QLsZx7nz1p8=;
        b=ckGZgqudqp0nVf3BihrF4dVS//02i2aJAr3v95VZSbZaDKPo8ABhIpqZIh37hmLhlR
         s42eSQ2nftlkJUYiBwXsH9GRuvoReBHaOrPgEfXbxVQHvGX0vvvJa3RokOzLWsbGIodl
         CepkMRJx5ReKEpXibTKpsKWqy9xE2ZFvVz/7XNxzQRpNvpjgYevgT2Oi69fAl5slXzm+
         SbKfcXuUS2zaqMHjzXkhhyD4vql0e1fS6NCSKW+Kr1DyfqVkZsb+0NO/pG2unKdHi8dq
         idbEFCB+dAWjah6HDsD2jZH2yMV/kMBJyMhNSAxnzggJXWNbd2KVyZNI+yma6DCv2Luv
         xvsg==
X-Gm-Message-State: AOAM532YDv+iSgwP/tc1DTO4RHLSV4yw4jD3Qv/UNKJPSFS2JxRsI2F8
        4T+PKbBIbR3Rl1j+omO3qxg=
X-Google-Smtp-Source: ABdhPJzwO7z/sPR86OYZj+fOZeAXXRi4Tt807J9o7FKXlX7wsObnWRP9XwYzDpLQJ5NllW+uaBAtew==
X-Received: by 2002:a19:5e04:: with SMTP id s4mr12734581lfb.314.1626546184080;
        Sat, 17 Jul 2021 11:23:04 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:03 -0700 (PDT)
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
Subject: [PATCH v5 03/12] soc/tegra: pmc: Expose USB regmap to all SoCs
Date:   Sat, 17 Jul 2021 21:21:25 +0300
Message-Id: <20210717182134.30262-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
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
index 3d31abb0ed71..5085106c4f53 100644
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

