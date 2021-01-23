Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA73018AD
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbhAWWUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbhAWWUk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C174EC0617A7
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a8so12572281lfi.8
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CksNMLgJxQqZTGvVoyYFDLCuLf1sggTOdB/wwyAbMc=;
        b=g+doe8cnX4AH/zqBgFiZLGkj/6fvpGOj5vh8JVDHl4lCTEjJG8acnX+rgAzu3V50YH
         I9wGtscjnSn9xzfyLbLi1OxMCJV/Z0uuOOzddkczj2qP29kmJli5f31LduCyzreJNzH9
         c09KUX/9aNaymJIckKAu9krYNhrEoILsP6RckvI7kw1HZlc3dWU0mRTXbRved/QmHpcw
         cV9xCu/Wt317gU87+F/fEBC3Kp5IfVFsovxRaEb1wUp/DXdW2y7caxumNpOdm6fzV06P
         wb0syQvYwhQANVXZjiwy8xn7oC6MbsSFq23a4nkZrs6zFpy1Nw8MN2V4KL8QVx05T8RZ
         8EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CksNMLgJxQqZTGvVoyYFDLCuLf1sggTOdB/wwyAbMc=;
        b=O2rzXV2q7Gr1FByUOtdnjv0GNEitj94pcNp04tqa1lzYWkhasIvQBQ24HAo8vKyHjR
         J2AVnngBRytZFkPPo8fxkpwZhyRRO3KFNnt7qBeTv/6BvwdTieTsTiJDDe3nMf4Bknl3
         /v4rnn4jfyzbY/PBqvTJzjwAbKFoLUqmZ3zcQLOasTyUgI/KhEhFecMucRK+lKHgSppg
         PHCo17orCdobL35E5M5RPO96XtmkbdyEogoWgBCDI6WRvqutQwuzUsrsKlIBr8CDaj5o
         z9WSFLEgaPiPTOdAT+NcGcMIcwX5yatCdfyAbuiYoq1AosRoqzu34QNG8vOkps/IUz0F
         bBLQ==
X-Gm-Message-State: AOAM533jFrpfGJi9pJ05LnRSZdpTbaNtHzrXHpXc+mj0b3oslwi+xmrH
        4MgMhtZlc1oVNXbLvGSP8qksLg==
X-Google-Smtp-Source: ABdhPJzNoWRNQMfWUTPFMvUxn1NBMjyTUMBA/PZHBMKtPU9QvQL2CyIgljHm4hswKh3vosLEDEJlUA==
X-Received: by 2002:a19:3811:: with SMTP id f17mr285263lfa.28.1611440368260;
        Sat, 23 Jan 2021 14:19:28 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/10] power: supply: ab8500: Avoid NULL pointers
Date:   Sat, 23 Jan 2021 23:19:05 +0100
Message-Id: <20210123221908.2993388-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sometimes the code will crash because we haven't enabled
AC or USB charging and thus not created the corresponding
psy device. Fix it by checking that it is there before
notifying.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_charger.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 704006bf554c..158131ed8b80 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -415,6 +415,14 @@ static void ab8500_enable_disable_sw_fallback(struct ab8500_charger *di,
 static void ab8500_power_supply_changed(struct ab8500_charger *di,
 					struct power_supply *psy)
 {
+	/*
+	 * This happens if we get notifications or interrupts and
+	 * the platform has been configured not to support one or
+	 * other type of charging.
+	 */
+	if (!psy)
+		return;
+
 	if (di->autopower_cfg) {
 		if (!di->usb.charger_connected &&
 		    !di->ac.charger_connected &&
@@ -441,7 +449,15 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
 		if (!connected)
 			di->flags.vbus_drop_end = false;
 
-		sysfs_notify(&di->usb_chg.psy->dev.kobj, NULL, "present");
+		/*
+		 * Sometimes the platform is configured not to support
+		 * USB charging and no psy has been created, but we still
+		 * will get these notifications.
+		 */
+		if (di->usb_chg.psy) {
+			sysfs_notify(&di->usb_chg.psy->dev.kobj, NULL,
+				     "present");
+		}
 
 		if (connected) {
 			mutex_lock(&di->charger_attached_mutex);
-- 
2.29.2

