Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0493A38D7BA
	for <lists+linux-pm@lfdr.de>; Sun, 23 May 2021 00:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhEVWy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 May 2021 18:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVWy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 May 2021 18:54:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5683C061574
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so28485200ljr.7
        for <linux-pm@vger.kernel.org>; Sat, 22 May 2021 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1J8DNFlNNGZ2pgPF3S+fP9F3pb5C/EHqPpuU1Grs2o=;
        b=NsMpzqxOG6eNGoAE+N9bMjsCNj0dXDTCHxB5bLphjpCxMcF3F4XYLfM4/TLaTecLgZ
         0kaCJhpfCXJQQLDVAZ5LoArus6RPmsXOym9eh5RZ8XtG3+KFk9K4oP4VjmL5i/uchzsy
         gUsM7gkyC6jfQxNB6PktiC92b6ppQ/rByT2mMiXRkK2Fiz4B/ODAdCG7DwGMfAuUWn4p
         rsBSxhO6Mnd4GrbKJVaJgJIQvDtLsrxW/w0k3nQzSIuPVHTLBPWfEJm7Ix+CeGoFhXB6
         chHQRHHG3o4+CL+dg0XK4mtVhZMWsosIPD8gXJuDqcWhfx0CmG+Q35/p1tU/xiQWYhqA
         qGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1J8DNFlNNGZ2pgPF3S+fP9F3pb5C/EHqPpuU1Grs2o=;
        b=ecMLGT6o/5+WEjIP5uqCki5chvDxKwF9eB2WELBjc8pZj9KByYloY81gtVXKNRUyJ6
         zx54LZFW0Pey9buzDeUtlyxi4in0MXpRPjf5f7s+Gz/9f7n1tXG9fjcsc07hnetkKioZ
         nXYUURdLYknXCYXL0iTOY9qGJlfPWyzrQV+N752iX7L0U1Qfbn7VHz4hG+6U4AnUfwos
         8aGOj8Ht9KO3tBN9Ma/UkaX+lpoIILdS9i5Li+feopgOF/KdHjsKDDNKT3eF+6gkY9xp
         65MlbIQMcy11CyVtkXDPZiRzIQ0OPDBV8Pmd3K2KIyTTAOhQObheKxS1aIHBtLseDRDT
         V3Vg==
X-Gm-Message-State: AOAM532lMH+tFqQ38FeLFIQ/SLdpRQYKOsbydepQk/y2vPB/CBUyS7JU
        LGXue/xQmWnpb9DFcSnzz5SrunnePl5Nmg==
X-Google-Smtp-Source: ABdhPJxkju7EACmkVvgP02Ml7+GHnAtW4IsTx/IrtzMpjGMR9wwvvGMKm+vFm2qo+n+dAUMuUEql2A==
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr11658900ljg.83.1621724010102;
        Sat, 22 May 2021 15:53:30 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id p14sm1136883ljc.58.2021.05.22.15.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 15:53:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5 v2] power: supply: ab8500: Call battery population once
Date:   Sun, 23 May 2021 00:50:40 +0200
Message-Id: <20210522225043.1004103-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522225043.1004103-1-linus.walleij@linaro.org>
References: <20210522225043.1004103-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on v5.13-rc1
---
 drivers/power/supply/ab8500_btemp.c    | 7 -------
 drivers/power/supply/ab8500_fg.c       | 6 ------
 drivers/power/supply/abx500_chargalg.c | 7 -------
 3 files changed, 20 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index b7b3653a204e..30c7334b3f1e 100644
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
index acf0f2471c0b..8c5ce6474358 100644
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
index 599684ce0e4b..a17849bfacbf 100644
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
@@ -2013,12 +2012,6 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 
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
2.31.1

