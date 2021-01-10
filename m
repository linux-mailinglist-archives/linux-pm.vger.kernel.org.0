Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C142F0711
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 13:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbhAJMQO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 07:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJMQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 07:16:14 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA955C06179F
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 04:15:33 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u11so468582ljo.13
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBYAmMQjCUkh+NqqVNzBJgSH8GSy3bOZmGC5IQ6qttI=;
        b=OeD7d82sZV4gAPnDU6dLCsLpZJEFgYGqZr4q/zLcCaQaCeKeIcABUDnvBSsG5vkG98
         UJqcodW4A1jO3DE4yVNmQc01NQE4DBqtoPjhWdhhcvmksYO/JUiTE05Wo+Zo8tTJ+BdY
         ZCqoyKVafa3z2DmWmJYV94fbadXzNL0AEfcNhL0DWrQzGNngBSk+mOEYHm3O4J3xQu9v
         RA7iW9xRkd3ogXJH0cCmS2XJDU5EfM4U2UMU3XYWVnVlwdpcKU9f/k6BIMpFAHO/7w07
         r6lap3TsTyvdZLBTxybbfUYMsLzzhu4UXV2o5EJ29tKMdfA1fDiv64saJVBfMZSlHMT4
         mFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBYAmMQjCUkh+NqqVNzBJgSH8GSy3bOZmGC5IQ6qttI=;
        b=F8n7X1Lm1CIR2+CvX971QysZ+KtPxY3I694XctklXL7Zs0xMh9bqgD65vsV5ZjCDL+
         yGO29c5Llg8g2xI9j0UEwP3Ma5PUgHW2Yb8XurvqPHM/16DigNmIwVBeARI66LgTnb1o
         bua4WnTXC5Sf1CbVoB0c51WCqSvZ/IelCiqE/jNPZcoUnvG3/fGKWE6Q8Tn1whlsVAPO
         +pFAc0uIwx8DbjtGSTXbxitUnOrsYIxOwW8iTVI6XuuTrZhoQG9/syKj0F4L079GUpLJ
         bOgDhQM7d7tGKvJV8CQD9dkteNL/DcWOB6P/yYlG0cma6Bl6Q0PAxYO+bjChXTkWr14E
         4vsw==
X-Gm-Message-State: AOAM5305FyEtZvTM2eZSfKM23NjFaGtPXiO62g3UZdwHSqRm6Rq19Yxz
        mBL/fJtsC9MpfD8WGosOp+p0FJlT+oeVCA==
X-Google-Smtp-Source: ABdhPJyF7bi8wkRJ1WWMgPJFw0KhS8NUrQPwb/AkO8fvbSjHZ9jr6+RWN4krzxPcBygLJRtysg88Jg==
X-Received: by 2002:a2e:7813:: with SMTP id t19mr5675228ljc.87.1610280932294;
        Sun, 10 Jan 2021 04:15:32 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id a24sm2683007lfi.192.2021.01.10.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 04:15:31 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Alexander Kurz <akurz@blala.de>
Subject: [PATCH] power: supply: max14656: Drop unused includes
Date:   Sun, 10 Jan 2021 13:13:28 +0100
Message-Id: <20210110121328.81259-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver includes two GPIO headers but does not use
symbols from any of them, so drop these includes.

Cc: Alexander Kurz <akurz@blala.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/max14656_charger_detector.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 137f9fafce8c..3f49b29f3c88 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -15,8 +15,6 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
-- 
2.29.2

