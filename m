Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABA21A665E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgDMMcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 08:32:33 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38334 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDMMcc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586781134; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVWhGN40RSlSv5uwpog3K158+gjiBbBlgbkIIpZ+xZQ=;
        b=YPJ7DoQISxOOPlHi9Czzn/d0KYRrVte1bRSD9EUo1tXaDntVEfroaVsTcEw1zRZo6ES3X3
        5vzT4s3fkdUd/Vzfn0FqLV48c19ZVNzVYhTCMeQ4nxDPKgYl80X8kwHF5Db4ssRWaXEqRC
        4tOSzgQktT/TXGd/p8vWu9KWzf1efec=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     od@zcrc.me, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] mmc: jz4740: Use pm_ptr() macro
Date:   Mon, 13 Apr 2020 14:32:07 +0200
Message-Id: <20200413123207.74552-3-paul@crapouillou.net>
In-Reply-To: <20200413123207.74552-1-paul@crapouillou.net>
References: <20200413123207.74552-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the newly introduced pm_ptr() macro to simplify the code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Use pm_ptr() macro instead of pm_sleep_ptr()

 drivers/mmc/host/jz4740_mmc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index fbae87d1f017..2d41e7e5ec43 100644
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
+		.pm = pm_ptr(&jz4740_mmc_pm_ops),
 	},
 };
 
-- 
2.25.1

