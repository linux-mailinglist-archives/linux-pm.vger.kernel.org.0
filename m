Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E244610FFC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ1Lqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 07:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1Lqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 07:46:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D041C8123
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 04:46:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j4so7929705lfk.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzfotkAl9WA/C5Amwds50josaEmg6lDNRxVHKP+Q30o=;
        b=Q2XvxgJcvC//vsl4QjrthkErdyrf27NxB7J9weI6WHIAplvJIvImJU68R3U0pP7xYd
         JCunjkkZqjPlCuiAzyP5yRneDqv0RrqtxTeRMArDKqFd8AI5WNxz4UJdYiIoliQE55ZP
         U7Nv1UUnE52jVNDsyJW18yEsgD9azx+vbKp0QilZi1LCVOZD/Szbl6H08tY6VcTuMPJO
         dCw/kH+PNqW7EYO5P3EHTh9RlXnB+ovdsXczafqQyr10pX/gZ1HHnJTAtuHN4l0S32ER
         F0BIN4eT2LXxlaOGtocFef9q3fIBiw0PpWtiWCj1qwOOo2/LCZp9bF52gShvFo4E3sAg
         gdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzfotkAl9WA/C5Amwds50josaEmg6lDNRxVHKP+Q30o=;
        b=oyofMQEUyaagCJKQe1UhwOTqwfBmx3pkH19XUifNdYMTwqQWzeC4mMX/Fqge/yzVei
         nIHbeBbT4Ut0qtPjJYrVUEGZAkFCxukOEQT2N2S2pH8P3HN9Tt8voIib//4lm6QfkKh0
         saO3f+rWOMT8hWLB4sj2FTMUe5qhdUio/e0gI9YdFlZ1Q6wxMzocdZb78qxNOYxDHd35
         ggbjoOJWcS3ew/Fv9vRanpwoMHwVUOm+M89JGhDS/G9efRsI4Cv90SGO0O4M7D6Jb6yQ
         on8PMAntMOpYMNEIiH0r2iZ379AQEGwEpzsgPerhINia/ibd6/sNo+TWvs2uGZ5JN4CB
         a1Gg==
X-Gm-Message-State: ACrzQf3nkudqb11Q+Ddhuubd/HnOHTdAOS4SgPQYk6e82mtPXjPnu/86
        a2IZtEQU1W7G/4C05SgIvnjA4g==
X-Google-Smtp-Source: AMsMyM4/+pt/G/eVYArAjcUaKhqexcZbhqibXnp85yAAATJuonbwY10m2DcNi1x72CDtVNMKSZo/3Q==
X-Received: by 2002:a05:6512:3f14:b0:47d:e011:f19b with SMTP id y20-20020a0565123f1400b0047de011f19bmr19015737lfa.427.1666957596141;
        Fri, 28 Oct 2022 04:46:36 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d26-20020a2eb05a000000b0027709706194sm608182ljl.49.2022.10.28.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:46:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] thermal/of: Accept but warn about TZ without trip
Date:   Fri, 28 Oct 2022 13:44:33 +0200
Message-Id: <20221028114433.51839-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The thermal OF core used to accept the creation of thermal zones
without trip points, but recent changes made it error out as
thermal zones should according to specification have trip
points.

Relax the requirements so we still create those thermal zones
but make a request to update the DTS in the kernel log.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/thermal/thermal_of.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..f683cbb4a72a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -592,8 +592,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	struct thermal_zone_params *tzp;
 	struct thermal_zone_device_ops *of_ops;
 	struct device_node *np;
-	int delay, pdelay;
-	int ntrips, mask;
+	int delay = 0, pdelay = 0;
+	int ntrips = 0, mask = 0;
 	int ret;
 
 	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
@@ -610,7 +610,9 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		pr_err("Trip points are compulsory for thermal zones, please add them to the DTS\n");
+		trips = NULL;
+		goto out_register;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -636,6 +638,7 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 
 	mask = GENMASK_ULL((ntrips) - 1, 0);
 
+out_register:
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
 						     mask, data, of_ops, tzp,
 						     pdelay, delay);
-- 
2.37.3

