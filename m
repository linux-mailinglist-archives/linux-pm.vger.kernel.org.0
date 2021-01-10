Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133822F0780
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJOEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 09:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJOEo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 09:04:44 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3BC061794
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 06:04:03 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o10so23143228lfl.13
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLjbjqwTG6XEAazNOXknqaBgeFZRwnpR9bYyyAV3nHw=;
        b=Wgz8RLsmSPzqlDJoHKYia63FUD9V1Yx2bJ6GPoiBLqlKiTv887lHUdHzyM5QXQQP1g
         r7/nM3LgXNRZFjdQMhgfKgxxA9zWEE5BgFc9L6rpCnfv0VQAOeyPJ32NDlp1z+8wxjRq
         XFYdFCxiN0SW8RS5n9Uq6Zf5B6b5Lh2oSQlKhn/Z0r6KytGWXPN38XTMCW8BcPTcPwlf
         tikx5l7FQ4ub8jJAfNe4Yg2qFanix0+0PSR0F7TI++/EFOT6qGYMBaVT2cJTENuPjbCB
         LxPnv5A1immC5vfC3G5fPRuZ4lErGDaNraXQzcLVfEIkA4UrkUieeT5H3KTymnrbbljl
         dQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLjbjqwTG6XEAazNOXknqaBgeFZRwnpR9bYyyAV3nHw=;
        b=tB+wGOwcW3M3b7hVZ6iBkaCxQf1J6Xh2ZVJHxwYcbYzx/dUfmdjKwmS/mshGpZPZWn
         MgE+wnuflXIvLRh/lyZoI2AnLy0q9bX1LOy0DZEkm7XGdUlhf5spmiQ+zmkrrBttDwTh
         6bQeWYqZM7yWkoLDu0plwTPh9z8cRJvwGJquYnLoZ/xjuL2P4/Zh32FqJFEfJR4/vWOe
         kJDHuI0a1KllnjnEMp+ln/o9Juu44ZSnWJJjMeyPihW6IBOvXCQVXQbyIAVSR+KVE7W7
         +1St6aQBVLoQSM/xp+xdSLbWoK35ZRlWs8IyuoKwW+2hhSS7t+1zld5P01qtxW336utK
         ipRQ==
X-Gm-Message-State: AOAM531pDtVHXCnTuZw+TB9fpS9SuNamrYxUvxO563v6AS3DWC1kdYjt
        i4Gsw43mD3dXf3i74dZwPO7ZnA==
X-Google-Smtp-Source: ABdhPJxjGsOKjdWPZcG5wEkINcd9NLjjbOXNLjjscFUdHttN5t6+hHt2JExcDxvZb8qOwnmplzdyWA==
X-Received: by 2002:ac2:4149:: with SMTP id c9mr4196944lfi.385.1610287442404;
        Sun, 10 Jan 2021 06:04:02 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id y26sm2981150ljh.63.2021.01.10.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:04:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Chris Lapa <chris@lapa.com.au>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 1/2] power: supply: max8903: Absorb pdata header
Date:   Sun, 10 Jan 2021 15:01:59 +0100
Message-Id: <20210110140200.127123-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The platform data header is not included by any other file in
the kernel but the driver itself. Decomission the stand-alone
header and absorb it into the driver itself.

Cc: Chris Lapa <chris@lapa.com.au>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/max8903_charger.c | 32 ++++++++++++++++++-
 include/linux/power/max8903_charger.h  | 43 --------------------------
 2 files changed, 31 insertions(+), 44 deletions(-)
 delete mode 100644 include/linux/power/max8903_charger.h

diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index 0bd39b0cc257..ab1aa7df985e 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -15,7 +15,37 @@
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/platform_device.h>
-#include <linux/power/max8903_charger.h>
+
+struct max8903_pdata {
+	/*
+	 * GPIOs
+	 * cen, chg, flt, dcm and usus are optional.
+	 * dok and uok are not optional depending on the status of
+	 * dc_valid and usb_valid.
+	 */
+	int cen;	/* Charger Enable input */
+	int dok;	/* DC(Adapter) Power OK output */
+	int uok;	/* USB Power OK output */
+	int chg;	/* Charger status output */
+	int flt;	/* Fault output */
+	int dcm;	/* Current-Limit Mode input (1: DC, 2: USB) */
+	int usus;	/* USB Suspend Input (1: suspended) */
+
+	/*
+	 * DC(Adapter/TA) is wired
+	 * When dc_valid is true,
+	 *	dok should be valid.
+	 *
+	 * At least one of dc_valid or usb_valid should be true.
+	 */
+	bool dc_valid;
+	/*
+	 * USB is wired
+	 * When usb_valid is true,
+	 *	uok should be valid.
+	 */
+	bool usb_valid;
+};
 
 struct max8903_data {
 	struct max8903_pdata *pdata;
diff --git a/include/linux/power/max8903_charger.h b/include/linux/power/max8903_charger.h
deleted file mode 100644
index 02f94a1b323b..000000000000
--- a/include/linux/power/max8903_charger.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * max8903_charger.h - Maxim 8903 USB/Adapter Charger Driver
- *
- * Copyright (C) 2011 Samsung Electronics
- * MyungJoo Ham <myungjoo.ham@samsung.com>
- */
-
-#ifndef __MAX8903_CHARGER_H__
-#define __MAX8903_CHARGER_H__
-
-struct max8903_pdata {
-	/*
-	 * GPIOs
-	 * cen, chg, flt, dcm and usus are optional.
-	 * dok and uok are not optional depending on the status of
-	 * dc_valid and usb_valid.
-	 */
-	int cen;	/* Charger Enable input */
-	int dok;	/* DC(Adapter) Power OK output */
-	int uok;	/* USB Power OK output */
-	int chg;	/* Charger status output */
-	int flt;	/* Fault output */
-	int dcm;	/* Current-Limit Mode input (1: DC, 2: USB) */
-	int usus;	/* USB Suspend Input (1: suspended) */
-
-	/*
-	 * DC(Adapter/TA) is wired
-	 * When dc_valid is true,
-	 *	dok should be valid.
-	 *
-	 * At least one of dc_valid or usb_valid should be true.
-	 */
-	bool dc_valid;
-	/*
-	 * USB is wired
-	 * When usb_valid is true,
-	 *	uok should be valid.
-	 */
-	bool usb_valid;
-};
-
-#endif /* __MAX8903_CHARGER_H__ */
-- 
2.29.2

