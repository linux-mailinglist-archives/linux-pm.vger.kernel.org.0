Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384255EC65D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiI0Oep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiI0Odc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA7C1B9119
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z6so15344016wrq.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kNTESOeVOVH9BHNMsa7BlHA2jeppHM3L2UNE800z/X4=;
        b=nEOyEWualKGhABEekiag1SSavoS9Rl4I+gJxc2YJ9i4ybO/GjsIYlEONNZ9buB1EQK
         4CO/BnIO0cZfJlE5DYI0kgVX3KPXJJS22ndoBS+XpY/4lipY+CnXwsFI2rQ/n7DeJrK3
         smj4PUgCZIz1zZFTWULC7Wh4Qt5FfI4IdUpG/yHPcSxUl4h/A0Zv7M32zrvPbEcxtxpu
         gQd7cHgStmj8vsGH982m7DUcSuWTWrcp01dNX007WkWYpb3Rh9EnocbO/A8bdUgs/lvQ
         wfias6XNV19bj8CljLiAbpCzw9c++JIaq+RfCmUQdLkfWjMvB/htlKa0OF8fVaCVSMhE
         KcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kNTESOeVOVH9BHNMsa7BlHA2jeppHM3L2UNE800z/X4=;
        b=W9W1xQfRvtaHboE2dFRtOxb9G70FssaJ71R7oe3ebDB0qICAst+2vH9Jr8yozQ8CIC
         pMsjWXZYnSY9T7U3O6Me6egMdsQqb08ssyaOs71Ppwxc/tMTvN2sIui+KaAeI9IT6U0G
         dng383xkCPNVqXvN+V+RTqjWN6OWEFJ07L16wxMhYelq5K05v9ABHbVf3Lp85uFMAoMG
         /1uI06hSzWIX7xEYwA6XJZNsxB059gRvB55l5/YryAMtmLjevHVRjTCFTNeq5mMWyd6/
         nE7VM2hY+VrPJ+l8k+uT4/nLHPNlUWkC1/GTpp87vdAolXSXXaSPt0NnWjQj5s6dS8c6
         UsWA==
X-Gm-Message-State: ACrzQf3GrbStSpEqHbtcomrp1CTJWsAYsgmcE0BUoDXGO7YWT6zsTE8o
        Oulj9KEc+rQ/tq//AURP/JyRBw==
X-Google-Smtp-Source: AMsMyM4xuNwwIQYh6JJ+WEqOVQSXFrGLIYMyvJPxPUQGNfv9xlxd3SwqxfJqM8ZwP+9E6bjwJXKCAw==
X-Received: by 2002:adf:e841:0:b0:22a:cb58:f8c1 with SMTP id d1-20020adfe841000000b0022acb58f8c1mr17426219wrn.173.1664289204893;
        Tue, 27 Sep 2022 07:33:24 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 24/29] thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:34 +0200
Message-Id: <20220927143239.376737-25-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
 drivers/thermal/da9062-thermal.c | 52 +++++---------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 180edec34e07..1e163e90d6b6 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -120,44 +120,6 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
-					int trip,
-					enum thermal_trip_type *type)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_HOT;
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
-					int trip,
-					int *temp)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*temp = DA9062_MILLI_CELSIUS(125);
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 				   int *temp)
 {
@@ -172,8 +134,10 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 
 static struct thermal_zone_device_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
-	.get_trip_type	= da9062_thermal_get_trip_type,
-	.get_trip_temp	= da9062_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .temperature = DA9062_MILLI_CELSIUS(125), .type = THERMAL_TRIP_HOT },
 };
 
 static const struct da9062_thermal_config da9062_config = {
@@ -228,10 +192,10 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register(thermal->config->name,
-					1, 0, thermal,
-					&da9062_thermal_ops, NULL, pp_tmp,
-					0);
+	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
+								trips, ARRAY_SIZE(trips), 0, thermal,
+								&da9062_thermal_ops, NULL, pp_tmp,
+								0);
 	if (IS_ERR(thermal->zone)) {
 		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
 		ret = PTR_ERR(thermal->zone);
-- 
2.34.1

