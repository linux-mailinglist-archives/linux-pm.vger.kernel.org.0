Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32138D7BC
	for <lists+linux-pm@lfdr.de>; Sun, 23 May 2021 00:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhEVWzA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 May 2021 18:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVWzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 May 2021 18:55:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5CC061574
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w15so28490760ljo.10
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHvJEBm/jJCUA1ytculivxOPCbU5Hy0vjkQqfQevm/Y=;
        b=yYmFOJCcX7JSGQJbxH6lOQhQD7Ry3UmZkkVx5uPW72Pn3huYOiHBGYc8/mcPxhQRV9
         CJMZspTLeITrciVFxtp08Mn2NLjoDKHw1XWR5Mg1I8iB+/7dkmsl/jJRLJO28dWjuiGL
         ECV4KBT1iSoWVwZ/v/2FDfy2xwVCmGyimY2BNPihyKxk0aFi7ZfF9dectO9ULPchhTJZ
         WurJrFxNZtUzz52vJRVaxlrm5RSfRRQq44BYIS77RGrWEa1JwawDfnlPRADErPxstl/0
         54qEEPW4VrIm/cyZyzn/WaxYyzi3dswoQ8ToflCnm7rAs6kDBDWrWf8DQmzo2NLJ1DV0
         Xxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHvJEBm/jJCUA1ytculivxOPCbU5Hy0vjkQqfQevm/Y=;
        b=HYJtsJLmHPQllCtbC5faBbsgH5xa60ana4QVUZ9nNU6S8nKhzMUvxYn/QUfBWNKtSs
         7fuZyupH7+w9xxAb9Apln1ugBuoZ5Em3m76FIRnr5T3kXMQ1KI9c1lsgj6ompZ2zfWwB
         A6+nZTVOcV6O3CaNlD1V5bS0INP6rHTL8RoWd6zCNzfrjIPTEcKiHSK0OuWNNJcES+aX
         7l/PgKnfZeFzTh6UGobDpC7M0Q/IGmN/imDyDKIuk1DVqR6lE94Ug/qQQdG4+NeYs5SE
         eBnQ26wbwIePI4Wwzh2T2c6nPfz3paWEuYyVgg+NEAdsuRF2l9q9koijIVpv0K87Jcyk
         LZDQ==
X-Gm-Message-State: AOAM533G5GXELj4xtQTRbxHbz1ae/Db5Q03mMfLKlls5F/asssqgAQHP
        q2A0S1xflkyaA34/BG5P2zSSVw==
X-Google-Smtp-Source: ABdhPJy/ubzkU6p5EJ43w03usrvwLbQOdMzrByn12hiJolJPV1uWDRHJ1OTjw0ekHzxz4OnJDe4cyA==
X-Received: by 2002:a2e:9d09:: with SMTP id t9mr11345264lji.506.1621724012682;
        Sat, 22 May 2021 15:53:32 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id p14sm1136883ljc.58.2021.05.22.15.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 15:53:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5 v2] power: supply: ab8500: Enable USB and AC
Date:   Sun, 23 May 2021 00:50:42 +0200
Message-Id: <20210522225043.1004103-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522225043.1004103-1-linus.walleij@linaro.org>
References: <20210522225043.1004103-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on v5.13-rc1
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
index 57fbfe3d8c03..e6f23ae05f95 100644
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
2.31.1

