Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC715943F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgBKQD6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 11:03:58 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35636 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgBKQD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 11:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581437025; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxhdVQMuODyhj8Ef1OMGPYNtTlY3IQiUcj0GELNasU4=;
        b=aS9S3lr0RX/TZHUDSfSMyjljjgL6X7fGX0B/FV4bcp7eOErZXfYDigSnFOe7UXe/T5aufw
        bptWWqlgAXme/vwC2h/JJe7J5q60EROG4LV46T+mHPIqM9uqGnDp+frhwbj2FqzmrA2VWV
        QluMd154+yb1J0ZFtL8hNPmE8Oezbew=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [RFC PATCH 3/3] mmc: jz4740: Use pm_sleep_ptr() macro
Date:   Tue, 11 Feb 2020 13:03:21 -0300
Message-Id: <20200211160321.22124-4-paul@crapouillou.net>
In-Reply-To: <20200211160321.22124-1-paul@crapouillou.net>
References: <20200211160321.22124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the newly introduced pm_sleep_ptr() macro to simplify the code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index fbae87d1f017..09554f9831de 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-static int jz4740_mmc_suspend(struct device *dev)
+static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
 {
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int jz4740_mmc_resume(struct device *dev)
+static int __maybe_unused jz4740_mmc_resume(struct device *dev)
 {
 	return pinctrl_select_default_state(dev);
 }
 
 static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
 	jz4740_mmc_resume);
-#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
-#else
-#define JZ4740_MMC_PM_OPS NULL
-#endif
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
@@ -1124,7 +1118,7 @@ static struct platform_driver jz4740_mmc_driver = {
 	.driver = {
 		.name = "jz4740-mmc",
 		.of_match_table = of_match_ptr(jz4740_mmc_of_match),
-		.pm = JZ4740_MMC_PM_OPS,
+		.pm = pm_sleep_ptr(&jz4740_mmc_pm_ops),
 	},
 };
 
-- 
2.25.0

