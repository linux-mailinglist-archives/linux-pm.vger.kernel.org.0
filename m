Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42C2D861B
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 11:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438848AbgLLK6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 05:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438853AbgLLK6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 05:58:04 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE2C061793
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:23 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a8so17981906lfb.3
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sWX5eE1xOf9NUniflRKOxAe5PsjQfTfWOM1x60DKsqU=;
        b=FIDv0+pFTVraDrY/d9H67Yol4HuHm2qgwQeeEMLbAz66ji3a8JQiMdFJtaNJHcwnv0
         9MDWlTvXMTCRKIkMJEGaW8O2YhVJAuovnAOLU20T0IKXa0TnsZNWoSVWWBlJZB2C/h4k
         2i7wYfFZ3AFA7iHGhdX4OU+VGTJ5lT1fc5f/iQ16k0mJxqr1em46SZvhccjQr88l0YSL
         Ym6sSPy/47A3gdtYmSqlGrYtvkvyvEz53Eo2gc7QPl0SRPMcoPZMXOR0H3XhTlAdKQ1f
         wfbBRPXquwZc8PHL1mRwKu0cGwOMBICaIW6HqCz2omT1lPCzOusRE+UGyepQKw+poFRF
         g/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sWX5eE1xOf9NUniflRKOxAe5PsjQfTfWOM1x60DKsqU=;
        b=S89aB6Vb2GO2DMiRyWsYzlMopjPb+kDDV5LB7z1Yxn9cS2mbdfLYflEEn7+J2ru0wB
         3CEmCpH+oOJLP0t24GgyQ3YGlgFVI2s0vwQag2l3bmP6mVd7vTVLvGrHP282UhuLP2GO
         KmfouH+1gqp9ADkfFRjXL+WCAw9GV3bc0Rfd1Xo6VZyRayoP6+wwiY/UY8hnR+RqPOse
         QjwYjmg80ULx0IjiwCMuSeiHIzlcXYl2/rM0LsResbbTosCyVdcRWcbqs+67BlkGhxlz
         yqbVDjz1WNBOajra5utdvXkhA29bBnfqTEdhzPUPiBJAR5M1VLil5GkomeucCMI+r17m
         +FXg==
X-Gm-Message-State: AOAM5317GF5KAEneLLiEg+yjWUdk3h/wK/s+8vxr9AA2Yv4A7kVZ6LQC
        WF0Awu7++sXA8rLJr9emf78Obw==
X-Google-Smtp-Source: ABdhPJyQWEt2hwjblVdt0srRBjVgg9abAQv5xh0+flmcknO73tK1Ytg9fXLqcAAbxNkheHOdGHwFWA==
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr6962040ljk.150.1607770642475;
        Sat, 12 Dec 2020 02:57:22 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j2sm490674lfe.213.2020.12.12.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 02:57:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] power: supply: ab8500: Convert to dev_pm_ops
Date:   Sat, 12 Dec 2020 11:57:09 +0100
Message-Id: <20201212105712.2727842-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201212105712.2727842-1-linus.walleij@linaro.org>
References: <20201212105712.2727842-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch over to using generic dev_pm_ops since these
drivers aren't even using the special power state passed
to the legacy call.

Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c    | 19 +++++++------------
 drivers/power/supply/ab8500_charger.c  | 19 +++++++------------
 drivers/power/supply/ab8500_fg.c       | 19 +++++++------------
 drivers/power/supply/abx500_chargalg.c | 19 +++++++------------
 4 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 06b4247ebc45..1f8fded47b2e 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -936,29 +936,23 @@ static struct ab8500_btemp_interrupts ab8500_btemp_irq[] = {
 	{"BTEMP_MEDIUM_HIGH", ab8500_btemp_medhigh_handler},
 };
 
-#if defined(CONFIG_PM)
-static int ab8500_btemp_resume(struct platform_device *pdev)
+static int __maybe_unused ab8500_btemp_resume(struct device *dev)
 {
-	struct ab8500_btemp *di = platform_get_drvdata(pdev);
+	struct ab8500_btemp *di = dev_get_drvdata(dev);
 
 	ab8500_btemp_periodic(di, true);
 
 	return 0;
 }
 
-static int ab8500_btemp_suspend(struct platform_device *pdev,
-	pm_message_t state)
+static int __maybe_unused ab8500_btemp_suspend(struct device *dev)
 {
-	struct ab8500_btemp *di = platform_get_drvdata(pdev);
+	struct ab8500_btemp *di = dev_get_drvdata(dev);
 
 	ab8500_btemp_periodic(di, false);
 
 	return 0;
 }
-#else
-#define ab8500_btemp_suspend      NULL
-#define ab8500_btemp_resume       NULL
-#endif
 
 static int ab8500_btemp_remove(struct platform_device *pdev)
 {
@@ -1137,6 +1131,8 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(ab8500_btemp_pm_ops, ab8500_btemp_suspend, ab8500_btemp_resume);
+
 static const struct of_device_id ab8500_btemp_match[] = {
 	{ .compatible = "stericsson,ab8500-btemp", },
 	{ },
@@ -1145,11 +1141,10 @@ static const struct of_device_id ab8500_btemp_match[] = {
 static struct platform_driver ab8500_btemp_driver = {
 	.probe = ab8500_btemp_probe,
 	.remove = ab8500_btemp_remove,
-	.suspend = ab8500_btemp_suspend,
-	.resume = ab8500_btemp_resume,
 	.driver = {
 		.name = "ab8500-btemp",
 		.of_match_table = ab8500_btemp_match,
+		.pm = &ab8500_btemp_pm_ops,
 	},
 };
 
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 7e28ac1b171b..47f1ce1012f4 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3209,11 +3209,10 @@ static int ab8500_charger_usb_notifier_call(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-#if defined(CONFIG_PM)
-static int ab8500_charger_resume(struct platform_device *pdev)
+static int __maybe_unused ab8500_charger_resume(struct device *dev)
 {
 	int ret;
-	struct ab8500_charger *di = platform_get_drvdata(pdev);
+	struct ab8500_charger *di = dev_get_drvdata(dev);
 
 	/*
 	 * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
@@ -3247,10 +3246,9 @@ static int ab8500_charger_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int ab8500_charger_suspend(struct platform_device *pdev,
-	pm_message_t state)
+static int __maybe_unused ab8500_charger_suspend(struct device *dev)
 {
-	struct ab8500_charger *di = platform_get_drvdata(pdev);
+	struct ab8500_charger *di = dev_get_drvdata(dev);
 
 	/* Cancel any pending jobs */
 	cancel_delayed_work(&di->check_hw_failure_work);
@@ -3272,10 +3270,6 @@ static int ab8500_charger_suspend(struct platform_device *pdev,
 
 	return 0;
 }
-#else
-#define ab8500_charger_suspend      NULL
-#define ab8500_charger_resume       NULL
-#endif
 
 static struct notifier_block charger_nb = {
 	.notifier_call = ab8500_external_charger_prepare,
@@ -3658,6 +3652,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(ab8500_charger_pm_ops, ab8500_charger_suspend, ab8500_charger_resume);
+
 static const struct of_device_id ab8500_charger_match[] = {
 	{ .compatible = "stericsson,ab8500-charger", },
 	{ },
@@ -3666,11 +3662,10 @@ static const struct of_device_id ab8500_charger_match[] = {
 static struct platform_driver ab8500_charger_driver = {
 	.probe = ab8500_charger_probe,
 	.remove = ab8500_charger_remove,
-	.suspend = ab8500_charger_suspend,
-	.resume = ab8500_charger_resume,
 	.driver = {
 		.name = "ab8500-charger",
 		.of_match_table = ab8500_charger_match,
+		.pm = &ab8500_charger_pm_ops,
 	},
 };
 
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 56997353c175..ba8dba0d6395 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2942,10 +2942,9 @@ static void ab8500_fg_sysfs_psy_remove_attrs(struct ab8500_fg *di)
 
 /* Exposure to the sysfs interface <<END>> */
 
-#if defined(CONFIG_PM)
-static int ab8500_fg_resume(struct platform_device *pdev)
+static int __maybe_unused ab8500_fg_resume(struct device *dev)
 {
-	struct ab8500_fg *di = platform_get_drvdata(pdev);
+	struct ab8500_fg *di = dev_get_drvdata(dev);
 
 	/*
 	 * Change state if we're not charging. If we're charging we will wake
@@ -2959,10 +2958,9 @@ static int ab8500_fg_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int ab8500_fg_suspend(struct platform_device *pdev,
-	pm_message_t state)
+static int __maybe_unused ab8500_fg_suspend(struct device *dev)
 {
-	struct ab8500_fg *di = platform_get_drvdata(pdev);
+	struct ab8500_fg *di = dev_get_drvdata(dev);
 
 	flush_delayed_work(&di->fg_periodic_work);
 	flush_work(&di->fg_work);
@@ -2980,10 +2978,6 @@ static int ab8500_fg_suspend(struct platform_device *pdev,
 
 	return 0;
 }
-#else
-#define ab8500_fg_suspend      NULL
-#define ab8500_fg_resume       NULL
-#endif
 
 static int ab8500_fg_remove(struct platform_device *pdev)
 {
@@ -3244,6 +3238,8 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(ab8500_fg_pm_ops, ab8500_fg_suspend, ab8500_fg_resume);
+
 static const struct of_device_id ab8500_fg_match[] = {
 	{ .compatible = "stericsson,ab8500-fg", },
 	{ },
@@ -3252,11 +3248,10 @@ static const struct of_device_id ab8500_fg_match[] = {
 static struct platform_driver ab8500_fg_driver = {
 	.probe = ab8500_fg_probe,
 	.remove = ab8500_fg_remove,
-	.suspend = ab8500_fg_suspend,
-	.resume = ab8500_fg_resume,
 	.driver = {
 		.name = "ab8500-fg",
 		.of_match_table = ab8500_fg_match,
+		.pm = &ab8500_fg_pm_ops,
 	},
 };
 
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 175c4f3d7955..a9d84d845f24 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -1913,10 +1913,9 @@ static int abx500_chargalg_sysfs_init(struct abx500_chargalg *di)
 }
 /* Exposure to the sysfs interface <<END>> */
 
-#if defined(CONFIG_PM)
-static int abx500_chargalg_resume(struct platform_device *pdev)
+static int __maybe_unused abx500_chargalg_resume(struct device *dev)
 {
-	struct abx500_chargalg *di = platform_get_drvdata(pdev);
+	struct abx500_chargalg *di = dev_get_drvdata(dev);
 
 	/* Kick charger watchdog if charging (any charger online) */
 	if (di->chg_info.online_chg)
@@ -1931,10 +1930,9 @@ static int abx500_chargalg_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int abx500_chargalg_suspend(struct platform_device *pdev,
-	pm_message_t state)
+static int __maybe_unused abx500_chargalg_suspend(struct device *dev)
 {
-	struct abx500_chargalg *di = platform_get_drvdata(pdev);
+	struct abx500_chargalg *di = dev_get_drvdata(dev);
 
 	if (di->chg_info.online_chg)
 		cancel_delayed_work_sync(&di->chargalg_wd_work);
@@ -1943,10 +1941,6 @@ static int abx500_chargalg_suspend(struct platform_device *pdev,
 
 	return 0;
 }
-#else
-#define abx500_chargalg_suspend      NULL
-#define abx500_chargalg_resume       NULL
-#endif
 
 static int abx500_chargalg_remove(struct platform_device *pdev)
 {
@@ -2080,6 +2074,8 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(abx500_chargalg_pm_ops, abx500_chargalg_suspend, abx500_chargalg_resume);
+
 static const struct of_device_id ab8500_chargalg_match[] = {
 	{ .compatible = "stericsson,ab8500-chargalg", },
 	{ },
@@ -2088,11 +2084,10 @@ static const struct of_device_id ab8500_chargalg_match[] = {
 static struct platform_driver abx500_chargalg_driver = {
 	.probe = abx500_chargalg_probe,
 	.remove = abx500_chargalg_remove,
-	.suspend = abx500_chargalg_suspend,
-	.resume = abx500_chargalg_resume,
 	.driver = {
 		.name = "ab8500-chargalg",
 		.of_match_table = ab8500_chargalg_match,
+		.pm = &abx500_chargalg_pm_ops,
 	},
 };
 
-- 
2.26.2

