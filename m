Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186E424D0D
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhJGGGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbhJGGGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994A0C061755;
        Wed,  6 Oct 2021 23:04:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z24so395099qtv.9;
        Wed, 06 Oct 2021 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQB/PnOQ9jEZSlqGGpfAjGbsGvYCB4Ti4A1tjQkA4Pg=;
        b=WJQWWwK2XIbvfEXBeN3WMVtH7Db82eSl84Ns0cQ/2v0K7z/thZyEsdIWdnPhyb+aA9
         ohxKQYgWVeYnJzF1ar7Mbowqnd7e8e4WD+NRrYDrRxcFrC9SivmDmDmWiEMDPl2ZibU7
         pU0pZo/TqyOGE0YSDITOzdpcAJo3Bjdz+S7z2S9yHVEXNB+vYUA+/Dx3FU29MA+fAr26
         sMcd+QhEFG+dpn6X9pRpuCO4n/LBZkSWaTx+yUGUwnnmEyP+x1KKMlXNWJnBISM+Rai4
         P8tHyD3QlQrq9Pca8z9vzRCyX8NAMXMg+T3Wu/PlpJFVf7AzSRPO+iwJo4wUsQvSYGXR
         7riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQB/PnOQ9jEZSlqGGpfAjGbsGvYCB4Ti4A1tjQkA4Pg=;
        b=5su3lbycjsXtB+tn45WXkYFW4/Ori73IdN+LRa0B7iKW3CLAie0/mNhhXRtB4c4mjN
         XFmPpNfgsDlsKAFFq/avTARYDhGoA1/Vim78fV9Z6wY131vlwJqtjZ/p1yrPVeJAk1k2
         UY/Ag4uC0b+HSJ8m5OQ0wpVerkbid4ZJGvP+VcdQ5rhvNBqIePz6ORR0xsmqtYb2ZE5o
         Cok/4xo4BryIi2gkxvDUMnqHZT8EQ00U+iqe7121MaRj8dl5hnG/tevKKeo6pDpUqXse
         n6p+RqleMSxBIefknKHzBt6j4oOmgvbpm38Oip70GBEwLnqDIO192oI/RoJQ7Dw//9IF
         azDA==
X-Gm-Message-State: AOAM5324/hguQKKaeKrelHxm25CWF7VxATK2So8XOIQ7460488aaFC2j
        XRNZrAH2kIYtsXMILQsSanI=
X-Google-Smtp-Source: ABdhPJycIDhLRrYRu49xiD+NCip1ZF/+RA0PJKuKRi8bnKHJQeXVEOiPGqZrOVMYEiQKUyHlaafbOQ==
X-Received: by 2002:ac8:6112:: with SMTP id a18mr2775450qtm.401.1633586666852;
        Wed, 06 Oct 2021 23:04:26 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 5/6] soc/tegra: pmc: Use devm_register_restart_handler()
Date:   Thu,  7 Oct 2021 09:02:52 +0300
Message-Id: <20211007060253.17049-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
References: <20211007060253.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use resource-managed variant of register_restart_handler() to make code
cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 50091c4ec948..dc9ad075ee4a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2859,6 +2859,13 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		pmc->clk = NULL;
 	}
 
+	err = devm_register_restart_handler(&pdev->dev, &tegra_pmc_restart_handler);
+	if (err) {
+		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
+			err);
+		return err;
+	}
+
 	/*
 	 * PCLK clock rate can't be retrieved using CLK API because it
 	 * causes lockup if CPU enters LP2 idle state from some other
@@ -2890,20 +2897,13 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 			goto cleanup_sysfs;
 	}
 
-	err = register_restart_handler(&tegra_pmc_restart_handler);
-	if (err) {
-		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
-			err);
-		goto cleanup_debugfs;
-	}
-
 	err = tegra_pmc_pinctrl_init(pmc);
 	if (err)
-		goto cleanup_restart_handler;
+		goto cleanup_debugfs;
 
 	err = tegra_pmc_regmap_init(pmc);
 	if (err < 0)
-		goto cleanup_restart_handler;
+		goto cleanup_debugfs;
 
 	err = tegra_powergate_init(pmc, pdev->dev.of_node);
 	if (err < 0)
@@ -2926,8 +2926,6 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 cleanup_powergates:
 	tegra_powergate_remove_all(pdev->dev.of_node);
-cleanup_restart_handler:
-	unregister_restart_handler(&tegra_pmc_restart_handler);
 cleanup_debugfs:
 	debugfs_remove(pmc->debugfs);
 cleanup_sysfs:
-- 
2.32.0

