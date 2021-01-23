Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F963018AC
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAWWUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbhAWWUi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FCDC061797
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:28 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p21so7485948lfu.11
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxqWGsq2hPGcNNxUeBx801l+y29+EGYn44iLZgztEcc=;
        b=Jh4pVBjD18QjyZSpN0luJQcK+55TPY0fmXyzNbIb8795EBbL0ZARlsiGRyWXxZr8ub
         /rN/aal9hdGaj5OsSwGXTAAvE712ALnSmv+fj+ebv4NEn0KvRYIj0ZdqB+P2k1Td1HEu
         LKbd+i46W/3O8lWM/N7stxHKfLcC904Nb788FCs+1j9Uwn4sQqEyB875+AGrQuVQKAQy
         m68aNznvhh/yqwQ1vawM+/y6VB7iwnuwZIPm2uZ4OXm/KU50q884VFHePqE2qfn4N5cr
         NO5leAWHTz7UnnsahbjJVUpd2qBsTxBs1O6XAkXtakJSY8saa7RKTgL9EiQqDKoSnSQn
         8hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxqWGsq2hPGcNNxUeBx801l+y29+EGYn44iLZgztEcc=;
        b=Sdzes8MjgCfKMV+WtgZtjg2l3+dWf3YAU95ZuHdc1dyqpqHu04bo1jtN60FBd/ReT/
         WELX5m8JL2qlqunG+goTMeUflsdG75NXouisXryl0UpYfl9uAIOoU4oFaH+e6vq04sei
         cy4+QYhvVaBboxnBCDI9Wy0e6kVfb0V6Qx2X8Gm0NqrUnUveKIFk148TTaXGelxjxAYd
         BiGNbdMFCvpu04X8IyvT/d/ln5rKj6picXqcoJo9rOZoAPDVfYZSE42W8Q/01pK/G7zB
         4kbwZ3++IUc6+3B2hooF4runj+oSHFXl9EQV6+6EUc7tlzJpAw0lT8ReeJN4jkr2yZIy
         7eBA==
X-Gm-Message-State: AOAM533TcAAaDh83PbCDSd7bFU5njf8jp1S/ujXlRITxyLoMnNi8jUvg
        Sr0HN+6ulnQoKRsnmL44O/8aV1ZP3wEOU52E
X-Google-Smtp-Source: ABdhPJzK17QXNf/GwMudOWBULs63tepDGS9RVPRr1SlyBe2CJAOAN34dsCRGmJYghFDu+kuZ792dmw==
X-Received: by 2002:a05:6512:786:: with SMTP id x6mr1587357lfr.643.1611440366671;
        Sat, 23 Jan 2021 14:19:26 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:26 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/10] power: supply: ab8500: Call battery population once
Date:   Sat, 23 Jan 2021 23:19:04 +0100
Message-Id: <20210123221908.2993388-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code was calling ab8500_bm_of_probe() in four different
spots effectively overwriting the same configuration three
times. This was done because probe order was uncertain.

Since we now used componentized probe, call it only once
while probing the main charging component.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c    | 7 -------
 drivers/power/supply/ab8500_fg.c       | 6 ------
 drivers/power/supply/abx500_chargalg.c | 7 -------
 3 files changed, 20 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 3598b5a748e7..5b664d2f6b82 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -983,7 +983,6 @@ static const struct component_ops ab8500_btemp_component_ops = {
 
 static int ab8500_btemp_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct power_supply_config psy_cfg = {};
 	struct device *dev = &pdev->dev;
 	struct ab8500_btemp *di;
@@ -996,12 +995,6 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 
 	di->bm = &ab8500_bm_data;
 
-	ret = ab8500_bm_of_probe(dev, np, di->bm);
-	if (ret) {
-		dev_err(dev, "failed to get battery information\n");
-		return ret;
-	}
-
 	/* get parent data */
 	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index d9dd13164d28..74d55e9c23bc 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3058,12 +3058,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 	di->bm = &ab8500_bm_data;
 
-	ret = ab8500_bm_of_probe(dev, np, di->bm);
-	if (ret) {
-		dev_err(dev, "failed to get battery information\n");
-		return ret;
-	}
-
 	mutex_init(&di->cc_lock);
 
 	/* get parent data */
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 883e3810a22c..8b3a2d883a2d 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -2002,7 +2002,6 @@ static const struct component_ops abx500_chargalg_component_ops = {
 static int abx500_chargalg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct power_supply_config psy_cfg = {};
 	struct abx500_chargalg *di;
 	int ret = 0;
@@ -2015,12 +2014,6 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 
 	di->bm = &ab8500_bm_data;
 
-	ret = ab8500_bm_of_probe(dev, np, di->bm);
-	if (ret) {
-		dev_err(dev, "failed to get battery information\n");
-		return ret;
-	}
-
 	/* get device struct and parent */
 	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
-- 
2.29.2

