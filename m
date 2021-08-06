Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852DF3E2702
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbhHFJQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 05:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbhHFJQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 05:16:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B4DC061799
        for <linux-pm@vger.kernel.org>; Fri,  6 Aug 2021 02:16:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f42so16597812lfv.7
        for <linux-pm@vger.kernel.org>; Fri, 06 Aug 2021 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9jZjKgObn+5x57XzHmaAGp51SrNq/b1Up96pA7QkbY=;
        b=avasmMSEYZFhfXf4gy12LlgRjQ13oOmPw2HFy45ehyD045bWE2Rrf7cv8e4hawgJ+W
         ypCXjAu/bfZ3KJfMYd4WH4R3Qf72rLsZDzmcoo/LSnBJi61ZxWOVMXlZ/KyhrnmxW2CE
         PmungY8HryQtmkDzEaJNW2ho+WksmFvYZ+QdFwCMNr2sDbyU/r4Y34WUNT6nGJxu0OP3
         BlKscyRZliZdRj1iRuIJde0JbN5H32irl5A8e1kYOnGhKTxLqXBIJAxhpvgucFExCXus
         U67GxFqzXwqBJiCmfZl4tD6VZxlcRgp9IYVLaEb6GyVOR6be9z/uU71fQrpKvEIr7H15
         bkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9jZjKgObn+5x57XzHmaAGp51SrNq/b1Up96pA7QkbY=;
        b=WG0HcUoqtW9BT3FvYZ1JzZ6aV4/NZQ8Tn+xceNBRw7LLcUKk52CIjatAm9Xd0Htg73
         blWkIGQxcejtcLb04wUsceJ0X09zP8NBYDhtmOXM3p083kj3ojRGHb2i0HvM8aTq6Xxb
         Qo5qFotqt/9tjLkeJ7rBR8vtF4exu2+x6qZMDGpFgqmQJRxcUbOUQK3T8WRDSESePqHK
         DRwc3pizx0m57DPheZVh9g0u98N2Y2aMe57Fu4756wzZYc6bl2UyyRSyQJZulQsunisT
         bH/GHHFmacW55eSWr9Jx1WAs0MIjN78i+KbneENY+Br+xd24Frg1cEYJpJW745jOcSKh
         RdQg==
X-Gm-Message-State: AOAM531na/C5I/a7dKaHd2w6Affz2eHFYAitQFCvpYuVpsDjYZIGf2RI
        Gwoo80ql0380PlggsxZhpZt0pg==
X-Google-Smtp-Source: ABdhPJzpxbT7zHt60wJqeJOlFUeADILZg48RcUWs/ywH7VxTjJSLgO5CdNUM7oDqo1hll8VuTrHMag==
X-Received: by 2002:a05:6512:3b94:: with SMTP id g20mr7120669lfv.0.1628241367796;
        Fri, 06 Aug 2021 02:16:07 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r25sm633918ljc.118.2021.08.06.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:16:07 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2] mfd/cpuidle: ux500: Rename driver symbol
Date:   Fri,  6 Aug 2021 11:14:04 +0200
Message-Id: <20210806091404.3521189-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PRCMU driver defines this as a DT node but there are no bindings
for it and it needs no data from the device tree. Just spawn the
device directly in the same way as the watchdog.

Name it "db8500-cpuidle" since there are no ambitions to support any
more SoCs than this one.

This rids this annoying boot message:
[    0.032610] cpuidle-dbx500: Failed to locate of_node [id: 0]

However I think the device still spawns and work just fine, despite
not finding a device tree node.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use MFD_CELL_NAME()
- Collect Daniel's ACK.
---
 drivers/cpuidle/cpuidle-ux500.c | 2 +-
 drivers/mfd/db8500-prcmu.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
index a2d34be17a09..f7d778580e9b 100644
--- a/drivers/cpuidle/cpuidle-ux500.c
+++ b/drivers/cpuidle/cpuidle-ux500.c
@@ -117,7 +117,7 @@ static int dbx500_cpuidle_probe(struct platform_device *pdev)
 
 static struct platform_driver dbx500_cpuidle_plat_driver = {
 	.driver = {
-		.name = "cpuidle-dbx500",
+		.name = "db8500-cpuidle",
 	},
 	.probe = dbx500_cpuidle_probe,
 };
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 75049cf38832..2f4ba91c404a 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2951,14 +2951,13 @@ static const struct mfd_cell common_prcmu_devs[] = {
 		.pdata_size = sizeof(db8500_wdt_pdata),
 		.id = -1,
 	},
+	MFD_CELL_NAME("db8500-cpuidle"),
 };
 
 static const struct mfd_cell db8500_prcmu_devs[] = {
 	MFD_CELL_OF("db8500-prcmu-regulators", NULL,
 		    &db8500_regulators, sizeof(db8500_regulators), 0,
 		    "stericsson,db8500-prcmu-regulator"),
-	MFD_CELL_OF("cpuidle-dbx500",
-		    NULL, NULL, 0, 0, "stericsson,cpuidle-dbx500"),
 	MFD_CELL_OF("db8500-thermal",
 		    NULL, NULL, 0, 0, "stericsson,db8500-thermal"),
 };
-- 
2.31.1

