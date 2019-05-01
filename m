Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06911047
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEAXmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56027 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEAXmJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:09 -0400
Received: by mail-it1-f195.google.com with SMTP id i131so327437itf.5;
        Wed, 01 May 2019 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Slbek9V2dfN38nP5SDKBqpG9La7gfuORa6TNt82wFs=;
        b=XvysVq/qhBjP1JLxnRZYh2kTSaul1A0LJPSa9iSYrZXT5RcHzETWX62zXCCem28acy
         Ezm7/2KN0CXSvjW5SG7bxIaArsvfBfTzMKjRj0JZloMBWzLY0LQcACw3ElAcZmm8/ksC
         0wjIPMwNu4b5Uz8wnFYjVQ+vhMPLmHKH6Dd7EWnT7JZuy0VREJ4/8H1bjOaEiMN860I6
         ekZJSdKSmSzb90xNqXlbqiQgovQQ7XgxDiH+Mj8rm7r9IYrrKoyZSd8veZ17gsj/QJF1
         ggyT54antUwScI7zvAkQQCQnKEPl0Sy6m/NSBhkFqMqlYAmHoTYG4qsy/RqjhSSQZ/jN
         xxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Slbek9V2dfN38nP5SDKBqpG9La7gfuORa6TNt82wFs=;
        b=sntatvMMSq2sbuvo4fYnIwGMyJw+U8JxbSzvuOAkonm8J9LSVJvPQQaB0Jjbq5YTyG
         yFwOq5FJmq2Bky0yEsq6HF0XHzVaxs1+QeKsNTCpp4qeytqp45zbE5CqpTQEsGtz6cBu
         HzOZeuoR59UKX2TJjO/clyRB0MCCM5LPLM0j4gKDSIv5Qf/7tv6rEIe6z13UiEUsCf7b
         WHj3KaeNpx6yuONwia/Gly3AqICrBz4pPy19ZtMNvV7A9DhV0aodQm0sw6yMhv00nTIX
         wYoo9SNHiBrAX6SrYmjWRACbOSSq/c852c1rUCn8/JekNvQ+ytHqS2U3J80Y+FAf9Sb3
         gwUg==
X-Gm-Message-State: APjAAAUq6m1iYVR7na36msghT6OMmbxfOAQYorBWNYPLwvPInnJS1b4d
        wBXUl67q4rl/wSYHWrFhNcU=
X-Google-Smtp-Source: APXvYqx108GRg4cFAQ0MWjE7KPNS7xiZrAC8Q2dZ685dropJiopjs9L1E52Z4deLa5CxtrqQGU+fkA==
X-Received: by 2002:a05:660c:20e:: with SMTP id y14mr202652itj.17.1556754127925;
        Wed, 01 May 2019 16:42:07 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/16] PM / devfreq: tegra: Move governor registration to driver's probe
Date:   Thu,  2 May 2019 02:38:10 +0300
Message-Id: <20190501233815.32643-12-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need to register the ACTMON's governor separately from
the driver, hence let's move the registration into the driver's probe
function for consistency and to make code cleaner a tad.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 43 +++++++++------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 65b3a7c72293..40ce9881f144 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -695,6 +695,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		goto remove_opps;
 	}
 
+	err = devfreq_add_governor(&tegra_devfreq_governor);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add governor: %d\n", err);
+		goto unreg_notifier;
+	}
+
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devfreq_add_device(&pdev->dev,
 					    &tegra_devfreq_profile,
@@ -702,7 +708,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 					    NULL);
 	if (IS_ERR(tegra->devfreq)) {
 		err = PTR_ERR(tegra->devfreq);
-		goto unreg_notifier;
+		goto remove_governor;
 	}
 
 	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
@@ -718,6 +724,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 remove_devfreq:
 	devfreq_remove_device(tegra->devfreq);
 
+remove_governor:
+	devfreq_remove_governor(&tegra_devfreq_governor);
+
 unreg_notifier:
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
@@ -735,6 +744,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
 
 	devfreq_remove_device(tegra->devfreq);
+	devfreq_remove_governor(&tegra_devfreq_governor);
 
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
@@ -760,36 +770,7 @@ static struct platform_driver tegra_devfreq_driver = {
 		.of_match_table = tegra_devfreq_of_match,
 	},
 };
-
-static int __init tegra_devfreq_init(void)
-{
-	int ret = 0;
-
-	ret = devfreq_add_governor(&tegra_devfreq_governor);
-	if (ret) {
-		pr_err("%s: failed to add governor: %d\n", __func__, ret);
-		return ret;
-	}
-
-	ret = platform_driver_register(&tegra_devfreq_driver);
-	if (ret)
-		devfreq_remove_governor(&tegra_devfreq_governor);
-
-	return ret;
-}
-module_init(tegra_devfreq_init)
-
-static void __exit tegra_devfreq_exit(void)
-{
-	int ret = 0;
-
-	platform_driver_unregister(&tegra_devfreq_driver);
-
-	ret = devfreq_remove_governor(&tegra_devfreq_governor);
-	if (ret)
-		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
-}
-module_exit(tegra_devfreq_exit)
+module_platform_driver(tegra_devfreq_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Tegra devfreq driver");
-- 
2.21.0

