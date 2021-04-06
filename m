Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF3354C50
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 07:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhDFF2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbhDFF2n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 01:28:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AABC061574;
        Mon,  5 Apr 2021 22:28:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v8so6834988plz.10;
        Mon, 05 Apr 2021 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oweqSXI9zzLcLYaaBGVQHnx3tRUf+Pnu2/QTPajj5oE=;
        b=qZoLxtZxOYpze1aHGbkzm1qGMDAEqWEVmmNZOIHSm2gUVCGCYUaz191PXDKjW6Luou
         MzFpfGFjWtzUjlVhiy3p3T9QgcdsCCDrEdTODJBT7fdPLxTWzHNZ1r4LXx4UjiePq6LM
         SfUBnmBoURvFdE1QFKYNXrXZC3CGJ0+OE7VnIpm9mhaJuP2crha/shCGKpm3lFQKfjpU
         gZmNIjtFmboyeHSDbPTMuqrW0A+nmsA0HhxQUPYw9vF6TTeKbw7GtAPGNNhmCf545GgI
         WiTi312RkKmiXubsKNwrFtqiTGac6Dem7fSF9OLacQTNT/hwHOfWz0lVL0owhBrtZSaH
         2Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oweqSXI9zzLcLYaaBGVQHnx3tRUf+Pnu2/QTPajj5oE=;
        b=ZMs81fbUoVMDpQ86mEmd9AAihszeWiIchQhbx2FMu6BGxzCu9j/HamBto3nF1spw5H
         Da9cpPqjRkCfbdVjcCewxPRm1UL44pZvIHcgPiK1vQQaaAcl9pUhAkF+sVFEc+7Gfttb
         7/DuylzeGraSNqPZpwevQpG4We5VYhPvVi3YSgP3p6prGklbu7/fEanIa7kqBYgxBvMt
         QcnM6anmfv10/Zgr6PGpnwjVQ4CmUO5YM+R6j16yopygtuyuOgeiqIKL5Om7SbgIQk1Z
         Sc6hjt09VR289N2IkG16M/khAnnu4IxHiuv5cL4ZWV9oLKzOT7tCmr9YvL2U6Tx28tH+
         +K1A==
X-Gm-Message-State: AOAM533bRn7PBNxUhCpPaZFeVArdjHzbB/ezq8tZRB/dtFLeW1JgvE1L
        r+1gyFTqR2uM18n2lNvGFlg=
X-Google-Smtp-Source: ABdhPJzPepd+G668LiY+hmPGYRAYQwovSmQ3ea1n4Eda3CF0xIIIyAMuqKnCj0zMJ+E3v32i4gz8QQ==
X-Received: by 2002:a17:902:d3ca:b029:e9:175c:c8ad with SMTP id w10-20020a170902d3cab02900e9175cc8admr6991459plb.4.1617686914652;
        Mon, 05 Apr 2021 22:28:34 -0700 (PDT)
Received: from localhost.localdomain ([96.44.140.50])
        by smtp.gmail.com with ESMTPSA id r11sm1061533pjp.46.2021.04.05.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 22:28:34 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] power: supply: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Tue,  6 Apr 2021 13:28:29 +0800
Message-Id: <20210406052829.22826-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Coccinelle noticed:
 1. drivers/power/supply/pm2301_charger.c:1089:7-27: ERROR: Threaded IRQ
    with no primary handler requested without IRQF_ONESHOT
 2. drivers/power/supply/tps65090-charger.c:303:8-33: ERROR: Threaded IRQ
    with no primary handler requested without IRQF_ONESHOT
 3. drivers/power/supply/tps65217_charger.c:239:8-33: ERROR: Threaded IRQ
    with no primary handler requested without IRQF_ONESHOT
 4. drivers/power/supply/lp8788-charger.c:502:8-28: ERROR: Threaded IRQ
    with no primary handler requested without IRQF_ONESHOT

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 drivers/power/supply/lp8788-charger.c   | 2 +-
 drivers/power/supply/pm2301_charger.c   | 2 +-
 drivers/power/supply/tps65090-charger.c | 3 ++-
 drivers/power/supply/tps65217_charger.c | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index e7931ffb7151..397e5a03b7d9 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -501,7 +501,7 @@ static int lp8788_set_irqs(struct platform_device *pdev,
 
 		ret = request_threaded_irq(virq, NULL,
 					lp8788_charger_irq_thread,
-					0, name, pchg);
+					IRQF_ONESHOT, name, pchg);
 		if (ret)
 			break;
 	}
diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index ac06ecf7fc9c..a3bfb9612b17 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -1089,7 +1089,7 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	ret = request_threaded_irq(gpio_to_irq(pm2->pdata->gpio_irq_number),
 				NULL,
 				pm2xxx_charger_irq[0].isr,
-				pm2->pdata->irq_type,
+				pm2->pdata->irq_type | IRQF_ONESHOT,
 				pm2xxx_charger_irq[0].name, pm2);
 
 	if (ret != 0) {
diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index 6b0098e5a88b..d55bcc341854 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -301,7 +301,8 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 
 	if (irq != -ENXIO) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-			tps65090_charger_isr, 0, "tps65090-charger", cdata);
+			tps65090_charger_isr, IRQF_ONESHOT,
+			"tps65090-charger", cdata);
 		if (ret) {
 			dev_err(cdata->dev,
 				"Unable to register irq %d err %d\n", irq,
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 814c2b81fdfe..cba3967ff275 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -238,8 +238,8 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq,
-						0, "tps65217-charger",
-						charger);
+						IRQF_ONESHOT,
+						"tps65217-charger", charger);
 		if (ret) {
 			dev_err(charger->dev,
 				"Unable to register irq %d err %d\n", irq[i],
-- 
2.17.1

