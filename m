Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88114A2AB2
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbiA2Avo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344713AbiA2Avl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292CC06173B
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:40 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t7so11297876ljc.10
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoOAtPH/fXOUReCmqOSwuBXwddLTHKASzGZg/Pg2jSY=;
        b=Scs9ztIuQtd/WoPPINVXxPxYurlC2BB82pLJR7kcgmyI1NmssvpaC4a7doNGQ8oyad
         B4+RZ7Yt0lsC7JAKvrkp0yMETg7gTqmDmrxDczIcZFGVIKD143zfm4kJOZstPrkIjXFl
         5URSDF1S0autq3n3Fwqf6Ym/wuawV1QWFzAIC3Uq7PGPD5nIg1rFlKU80XcBFNxbiusD
         /zEIK0zDJI8xBnBHLD+XxKbYZxJX02aiE25zmyME5Qudja5nAITk1s3kblegrQmur/9K
         vOLZF3FSPvno2dKHbcwTlA3/A8rHlEtoerA+zp/8ysWvIySs+mPi+rmetljbsKPmdsFK
         ePxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoOAtPH/fXOUReCmqOSwuBXwddLTHKASzGZg/Pg2jSY=;
        b=Oluz4gfNaFAo8tTdKKpW1eFzgBGnSqjz5N0mq54YkRh4N5j0UfXvvBLs88MYgOioLH
         IJGOgsFyOMCQ44OmgQuE/11T/5T0lazFXO6bKEnhDlm0yDPOSkQOT8Zf2tg0wGNbtbcz
         xkJRgFXuXTX+p8+Dlv1DM2iX6DdYeU9WcqNswi4w/cF3iecdchvkBr1UsgOo0Q7ZEqGc
         SuhYVY35vlW7FM7oil9XccuDhNzJeCxU1DSLHtgHhTjm6FIIN0d2T+P4OU/gvXaEvhRc
         pJMf8CPD7IULiNQPSz/9krpOcoU8ItTf2iikhzJF8DSH+fCDj/Hw3dRLZD6nMgri7Vm1
         XCrw==
X-Gm-Message-State: AOAM532LevmvaHe3xIbmaAs4TtCn6VvJtmcjkjgk2IoQtufbwgJ1gWcl
        6jh5ZOaIwqp+XOTHT8IZYdCkew==
X-Google-Smtp-Source: ABdhPJzpT8ywR12BcSL9yOW7IugYYG8UtsDPr7V+Js7y/oYXi5CUa/To0eRc2KL6YvcvRddwWuHUyQ==
X-Received: by 2002:a2e:bd83:: with SMTP id o3mr7630140ljq.51.1643417498411;
        Fri, 28 Jan 2022 16:51:38 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:38 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/11 v2] power: supply: ab8500: Swap max and overvoltage
Date:   Sat, 29 Jan 2022 01:49:16 +0100
Message-Id: <20220129004925.639684-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We should terminate charging when we reach the voltage_max_design_uv
not overvoltage_limit_uv, this is an abuse of that struct member.

The overvoltage limit is actually not configurable on the AB8500,
it is fixed to 4.75 V so drop a comment about that in the code.

Fixes: 2a5f41830aad ("power: supply: ab8500: Standardize voltages")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500_bmdata.c   | 8 +++-----
 drivers/power/supply/ab8500_chargalg.c | 2 +-
 drivers/power/supply/ab8500_fg.c       | 8 +++++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 7133cce6a25a..62b63f0437dd 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -186,13 +186,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	 * fall back to safe defaults.
 	 */
 	if ((bi->voltage_min_design_uv < 0) ||
-	    (bi->voltage_max_design_uv < 0) ||
-	    (bi->overvoltage_limit_uv < 0)) {
+	    (bi->voltage_max_design_uv < 0)) {
 		/* Nominal voltage is 3.7V for unknown batteries */
 		bi->voltage_min_design_uv = 3700000;
-		bi->voltage_max_design_uv = 3700000;
-		/* Termination voltage (overcharge limit) 4.05V */
-		bi->overvoltage_limit_uv = 4050000;
+		/* Termination voltage 4.05V */
+		bi->voltage_max_design_uv = 4050000;
 	}
 
 	if (bi->constant_charge_current_max_ua < 0)
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index c4a2fe07126c..bcf85ae6828e 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -802,7 +802,7 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 	if (di->charge_status == POWER_SUPPLY_STATUS_CHARGING &&
 		di->charge_state == STATE_NORMAL &&
 		!di->maintenance_chg && (di->batt_data.volt_uv >=
-		di->bm->bi->overvoltage_limit_uv ||
+		di->bm->bi->voltage_max_design_uv ||
 		di->events.usb_cv_active || di->events.ac_cv_active) &&
 		di->batt_data.avg_curr_ua <
 		di->bm->bi->charge_term_current_ua &&
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index b0919a6a6587..236fd9f9d6f1 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2263,7 +2263,13 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 {
 	int ret;
 
-	/* Set VBAT OVV threshold */
+	/*
+	 * Set VBAT OVV (overvoltage) threshold to 4.75V (typ) this is what
+	 * the hardware supports, nothing else can be configured in hardware.
+	 * See this as an "outer limit" where the charger will certainly
+	 * shut down. Other (lower) overvoltage levels need to be implemented
+	 * in software.
+	 */
 	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_CHARGER,
 		AB8500_BATT_OVV,
-- 
2.34.1

