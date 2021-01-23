Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B63018AE
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAWWUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbhAWWUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:40 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD3AC0617AA
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:31 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f19so1862022ljn.5
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDw2Zywr4IODkv/lha2OrxYzfa5j2Qq3VpSO78JP/jI=;
        b=wxlZkpLKQypG9keotJoMSErJwz4HsGAkAPy0XhgVe3QNxXFrGVc4XYS5TaJOEAeYQ4
         wGqtn+yXkX/hcGLgBjByRtpp1+xe+Ol4OJPn0kNbCfWJJbT4PeoD+EKpej17cpPhiTgL
         FNKqtWNdKV2LMNcr7RbKVO9YJwg8j+D8+NSCGC9oh9+tb9yf/N5tCPCRGXc18KlDTRYR
         YEPkoKH8MoN7zB1jJz4oy6QGJeqZGLuy+Flj8RPTAqRagTXrFmyETGRn+h7ANMvpn9Z2
         c+ac+pPTxG60TGLafo7Bb3ztG5sLxHYnJxVN//H/cv7VpdDedWOrrQmzASGXYr9YbhET
         LpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDw2Zywr4IODkv/lha2OrxYzfa5j2Qq3VpSO78JP/jI=;
        b=HU7+8HzMLTv8DqsnB0AhWp4fnAuJJL+WF2BZY2Dsyr6W6wEI5pYUlDfgt2R0JBhPVl
         tIUVC/hBa6z/oIBAu/4NgWyRNDnfNiujmaLXP3bBqrIEu4GCJcUZUio9yGWaevqHAglV
         r5SFrOjZWYvVyNVMaW2BamRR0DbFuMG5vpEDblE35UT/4+4Q0UFX7DobqISGIp+I93OW
         FvQicDBkEXD618Kp5EWqUHBkCZxq0aJ+dLtdaGIy2X2/yD/P9CupC244MMtJc4jQanTg
         /fFXmfRqj0zaL3HKIH0DNAEQBYPGsto6hhQ6PBqbXVYW5d8HdsuKodR0/BN8+eujNNZQ
         2Pig==
X-Gm-Message-State: AOAM532fQGKeDuxRRqnE/PtoMRfuNhRj9yTvRxBhi4FI2ZqQWjcYoRnJ
        L9X2U0S5NydiJNcqnyKjQBFoDMPWsEqogCv/
X-Google-Smtp-Source: ABdhPJzf/Ak91Eje43oKXcg6c6+DJT6NnXaSrNoLtCwdCbaiHFHL4dMZMdL0m1vmCRkn5dbRUefLoA==
X-Received: by 2002:a2e:585:: with SMTP id 127mr135724ljf.131.1611440369780;
        Sat, 23 Jan 2021 14:19:29 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/10] power: supply: ab8500: Enable USB and AC
Date:   Sat, 23 Jan 2021 23:19:06 +0100
Message-Id: <20210123221908.2993388-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The vendor code tree supplies platform data to enable he
USB charging for AB8500 and AB8500 and disable the AC
charging on the AB8505. This was missed when the driver
was submitted to the mainline kernel.

Fix this by doing what the vendor kernel does: always
register the USB charger, do not register the AC charger
on the AB8505.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h      |  2 --
 drivers/power/supply/ab8500_charger.c | 24 ++++++++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 012595a9d269..871bdc1f5cbd 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -507,8 +507,6 @@ struct abx500_bm_data {
 	int bkup_bat_v;
 	int bkup_bat_i;
 	bool autopower_cfg;
-	bool ac_enabled;
-	bool usb_enabled;
 	bool no_maintenance;
 	bool capacity_scaling;
 	bool chg_unknown_bat;
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 158131ed8b80..832e01f56a62 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3511,7 +3511,14 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->ac_chg.max_out_curr =
 		di->bm->chg_output_curr[di->bm->n_chg_out_curr - 1];
 	di->ac_chg.wdt_refresh = CHG_WD_INTERVAL;
-	di->ac_chg.enabled = di->bm->ac_enabled;
+	/*
+	 * The AB8505 only supports USB charging. If we are not the
+	 * AB8505, register an AC charger.
+	 *
+	 * TODO: if this should be opt-in, add DT properties for this.
+	 */
+	if (!is_ab8505(di->parent))
+		di->ac_chg.enabled = true;
 	di->ac_chg.external = false;
 
 	/* USB supply */
@@ -3525,7 +3532,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->usb_chg.max_out_curr =
 		di->bm->chg_output_curr[di->bm->n_chg_out_curr - 1];
 	di->usb_chg.wdt_refresh = CHG_WD_INTERVAL;
-	di->usb_chg.enabled = di->bm->usb_enabled;
 	di->usb_chg.external = false;
 	di->usb_state.usb_current = -1;
 
@@ -3599,14 +3605,12 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Register USB charger class */
-	if (di->usb_chg.enabled) {
-		di->usb_chg.psy = devm_power_supply_register(dev,
-							&ab8500_usb_chg_desc,
-							&usb_psy_cfg);
-		if (IS_ERR(di->usb_chg.psy)) {
-			dev_err(dev, "failed to register USB charger\n");
-			return PTR_ERR(di->usb_chg.psy);
-		}
+	di->usb_chg.psy = devm_power_supply_register(dev,
+						     &ab8500_usb_chg_desc,
+						     &usb_psy_cfg);
+	if (IS_ERR(di->usb_chg.psy)) {
+		dev_err(dev, "failed to register USB charger\n");
+		return PTR_ERR(di->usb_chg.psy);
 	}
 
 	/* Identify the connected charger types during startup */
-- 
2.29.2

