Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1176F38D7BB
	for <lists+linux-pm@lfdr.de>; Sun, 23 May 2021 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhEVWy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 May 2021 18:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVWy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 May 2021 18:54:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2DC061574
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f12so28520195ljp.2
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=or/aJ9cUCVlgkGbVDYelKbGCCFYUXfIWIGVlXfrFOGk=;
        b=Gjm1qswY/38QE5k6L+n/6DRp+oyPhknR0nEBnzwLAxu0hNnNDu6YVF6nmjRMzPN0n/
         hWOQID1AM26H2f+DejxOHDt+7dQYkc91ySfz0VNjMKCNAaoD4VsfIR7ZrXSGgtIu9uM8
         j5I6QO1VYL7wDMXqAlWkTNQfStws3NekYIRTsxrjZVlu7kzbCQ4mbRbQLDqoASsrAMIs
         Ot728tVSiAouk435cke/0fh1uH7Rz6JVwUtvfRf/0wcMbS7dTVlXL3RdJjjOCkmeLGYL
         LUkBxi8oVcbp0fmznjXONbmu85NP3IfX02txSNlBcYAGxAz1EfXl5XP+bVZyk7aHz9AO
         OmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=or/aJ9cUCVlgkGbVDYelKbGCCFYUXfIWIGVlXfrFOGk=;
        b=Z/7baY+bYEmYu2jMdIpyKDJQzfYjG8C3IH++v/1XI5noDBA22wT01rw2h/Lh53Fuu2
         00T4KRWy61KwUumZMfUSY7MGkfcJ43QZ7/y6J0KoCMQaV4nmHDgJa8jX1ZJ4fklNkv/M
         rCK9gyKoPXWdkgEoaGMyVapCTE2MburV1b18uBdHcCNrdP09gxD+s5JNcekDh0grRptW
         myy6PAt7Xdl9mmjfso+Dte0r5QRBLRCa2iWlLtzuAvl3+sRVnR0zyxBY2soCfdrYODNv
         CBF7DXhtwlyjnAV9smuZwpX1JO5KOekOOUfzcRvP2tEDfd2JTdcrzOcMF55AbfuvjEdg
         C+sA==
X-Gm-Message-State: AOAM531M0HwjXGKfNl36Wj9UuCXnwdB4pRkaGYeIs1evdsJrF0K/fOjx
        aG5Y/gRuQjefZXv8Ji64O8L1PA==
X-Google-Smtp-Source: ABdhPJzclIElsth5BoC572f2zdjQ+ZW/8scW8nMLh904KFZR76qjmGXySEm4vAgbN+H27jEo5HDnbA==
X-Received: by 2002:a2e:8e66:: with SMTP id t6mr11653034ljk.481.1621724011304;
        Sat, 22 May 2021 15:53:31 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id p14sm1136883ljc.58.2021.05.22.15.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 15:53:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5 v2] power: supply: ab8500: Avoid NULL pointers
Date:   Sun, 23 May 2021 00:50:41 +0200
Message-Id: <20210522225043.1004103-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522225043.1004103-1-linus.walleij@linaro.org>
References: <20210522225043.1004103-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on v5.13-rc1
---
 drivers/power/supply/ab8500_charger.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index af32cfae9f19..57fbfe3d8c03 100644
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
2.31.1

