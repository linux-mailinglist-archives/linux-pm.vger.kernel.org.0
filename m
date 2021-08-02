Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4553DD2A8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhHBJLX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhHBJLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 05:11:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FDC0613D5
        for <linux-pm@vger.kernel.org>; Mon,  2 Aug 2021 02:11:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t9so19505706lfc.6
        for <linux-pm@vger.kernel.org>; Mon, 02 Aug 2021 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHYGauWDsrZ2HlePLC28Pt6z1sM76N+EjvyU9BFXlYo=;
        b=nzEe/dplqrTZYCAJZeyHaVfCuBCcbIBbI4yqT40m89VrvGBXIz3Bj+VhpPlji1e08I
         6XscaZWQbt2yli+zx219tZT4u3XvJ+rGz5KXP4h3MD2Rq2wIEBu4IgsMbHYuRVSLF3In
         GVMQ57R9NyHk7bAF8ZQG/wBiv/Q8/iMIvgGDqnbLZvXHnVrBWC/7laJ2fFt1zbkg56tG
         6W13cxxSOLfxUBjZgx/x+Z6rB7oYrmzID/hFJTIAnaEwsIPRLSiSjG9+A6Q45oZNvYUy
         ze8JKAPyvRewz2u5iTi5h3UmKpE3GCKUjpDf84mc/Bo1WFvMSXUgTj6KPFDT3KY81Opl
         4eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHYGauWDsrZ2HlePLC28Pt6z1sM76N+EjvyU9BFXlYo=;
        b=BTqzYQIsoTxXX3bmxvEVBRontVxg9mTaYJO5Z35+ED3Z/0DRRSwRph5lsSX23jBczJ
         1rvBl6Czs4CoeMPOXIzPN1oSFf89Lx2ceqSrUwp3VBJ3dTx07to4jmBqDmg3pSMmtGog
         hAmK3S5z4yI0o0CNs2SmuBALY1ntQkLyiBGo7RSdkvBVe+D/Ehvl4fIbItPJ04Tk9Ton
         EceksBQ8zpV1da4WQ6gIsL7Rih7H6EMivTv2K0E+dXeKZWSG9kvBpY86IFMFsns4nGaD
         BTVWd0s4ogovyFBZThTQ+s3YRBspWOnPPkfCmpYJSCxmMmmRf/N4j0XQ4j67cyu2yqd+
         iJRw==
X-Gm-Message-State: AOAM530nxIFPmYI8F+HRSZ3SMZ+aZrrLj+eZ+KNBNoCk3sbyuT4b/wKk
        RDvlYl6QaTWp44evxj1fu6WSkA==
X-Google-Smtp-Source: ABdhPJxJV0BW4030/O3dJxjHERyR35BHyeeMRS3ltMHAXXpOVt4oTEYJFcZPWrq67vEwIQ2pFOYlJw==
X-Received: by 2002:ac2:5461:: with SMTP id e1mr8316977lfn.61.1627895472051;
        Mon, 02 Aug 2021 02:11:12 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id f1sm796340ljj.39.2021.08.02.02.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 02:11:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] mfd/cpuidle: ux500: Rename driver symbol
Date:   Mon,  2 Aug 2021 11:08:59 +0200
Message-Id: <20210802090859.3237509-1-linus.walleij@linaro.org>
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Rafael/Daniel: it would be perfect if one of you could ACK
this so that Lee can just merge this into the MFD tree as
a non-urgent fix.
---
 drivers/cpuidle/cpuidle-ux500.c | 2 +-
 drivers/mfd/db8500-prcmu.c      | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index 75049cf38832..64dd4f9a1e49 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2951,14 +2951,16 @@ static const struct mfd_cell common_prcmu_devs[] = {
 		.pdata_size = sizeof(db8500_wdt_pdata),
 		.id = -1,
 	},
+	{
+		.name = "db8500-cpuidle",
+		.id = -1,
+	},
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

