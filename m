Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE485EC655
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiI0Od6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiI0OdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:33:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C86B155
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so15313056wrb.6
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=XpDZF33EE05uIngBWvaB9h8R9rb9f1/0oqiaz46R/MC+bZp32EXGqmDwvGUVDw3STw
         ug8Tmjebv8p30ixOK43bIUQPqnNS/q8y48axCr2YfaQWU8iy8QIcz5Csdq1fIG1K5lyN
         Qr3HtuD2TwMPsp6T+ni3H638UquEajgMyZPjkjIjW1oSRlnJy/03nhihdHspmtzz4lI1
         bCLUnZlYrVxVRyrgnZ1sTGsPUq7slfsG84lWycRqu/Ehk4woS/BS5Ha4tk66MHUIs47g
         cGUGkfbW5M3CwxyPKYG9FzO4PYrYxUh5GtFsZPUxZ25ZFgvpao40TihjmiOhdnVt2ujo
         mTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=Jifoo0XVcyPaVbCGob07XmCN7fbGhVuwZ/l3UToJ93wsIJtksD8QzzCCctmOmSd4Gf
         s07JvMgRJajy62I3S7sVmLEJZdYg5VbEn80gZE0WP6NjYTkUZPWS/0K5n0qOYnzYPSVT
         2sQnD4u4lsKQ6bXRCfCJ3PwFo9SlE/6gM4cchEMBdE+Gb2uUPnSs/j7sYnUUbbwaRLpr
         smCvgSVkw1qfOl0FkraKs/5Ur2tifFUxNVLh5p/cZaDcM+5GJdGoTXKNQXKTjtHH+ay2
         3P6CBTAaZejHDh/jTjk0x+1BrRGfM0CAo67yDKJxRDmEpGLfipkL449aObS6f7mg7S3d
         OLdQ==
X-Gm-Message-State: ACrzQf2EZKHQHauUpDSf9M2mIJjhFjWqAskvu5J5LjsQH1eoseoSwkNi
        vls0aFfWjjobtqVH4OJmNQ9fWA==
X-Google-Smtp-Source: AMsMyM6/RN9mXaJDzlUEuh6QRQ3y5A7USoF8Z3eA2/qD/SMsGfNyXN8jxDxtubAvUwWKcX3k6jKo0Q==
X-Received: by 2002:a5d:50c1:0:b0:228:d77e:4b33 with SMTP id f1-20020a5d50c1000000b00228d77e4b33mr16694877wrt.677.1664289187297;
        Tue, 27 Sep 2022 07:33:07 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Amit Kucheria <amitk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v6 11/29] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:21 +0200
Message-Id: <20220927143239.376737-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/thermal/uniphier_thermal.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4111d99ef50e..277ae300c5b1 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,8 +248,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct device_node *parent;
 	struct uniphier_tm_dev *tdev;
-	const struct thermal_trip *trips;
-	int i, ret, irq, ntrips, crit_temp = INT_MAX;
+	int i, ret, irq, crit_temp = INT_MAX;
 
 	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
@@ -296,20 +295,18 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	/* get trip points */
-	trips = of_thermal_get_trip_points(tdev->tz_dev);
-	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
-	if (ntrips > ALERT_CH_NUM) {
-		dev_err(dev, "thermal zone has too many trips\n");
-		return -E2BIG;
-	}
-
 	/* set alert temperatures */
-	for (i = 0; i < ntrips; i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
-		    trips[i].temperature < crit_temp)
-			crit_temp = trips[i].temperature;
-		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
+	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
+		struct thermal_trip trip;
+
+		ret = thermal_zone_get_trip(tdev->tz_dev, i, &trip);
+		if (ret)
+			return ret;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL &&
+		    trip.temperature < crit_temp)
+			crit_temp = trip.temperature;
+		uniphier_tm_set_alert(tdev, i, trip.temperature);
 		tdev->alert_en[i] = true;
 	}
 	if (crit_temp > CRITICAL_TEMP_LIMIT) {
-- 
2.34.1

