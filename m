Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28D05AF189
	for <lists+linux-pm@lfdr.de>; Tue,  6 Sep 2022 19:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiIFRBk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Sep 2022 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiIFRA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Sep 2022 13:00:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4302EF37
        for <linux-pm@vger.kernel.org>; Tue,  6 Sep 2022 09:47:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b17so3005960wrq.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Sep 2022 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=Th8YiUXJY8DYoYMTJhR7p6ct3jT3QTtfDMxrkwLP8mHuq0wFkSJzpxAEDdL7/+Rckr
         xbF1yZrk4nZD/Sy59+HkqI1nOavbwIyllvxPYclSUz3lV+PC7rmUoBciWw/7mBsjLc45
         tv2AUdE+JPxVr8DzsLY+m/nLOYThFqeLQjs7FVy7UAtT1JgD7VJJ7qFosyAnsBSI0ku8
         f8pKVc/KWQ2qg390fNi3MI9MJOjkf/2Tun+FAzLo0OD7hYLG5TLUUaSSt1AXgEq7EYbE
         anieUPaJYTGO+QoxQRJ9Vgx6whb/DaWG2jVMS02iWhqyXrc0LrRaJx0iLZ1s9tOl/YBr
         nvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=L8S/R7PXtFxvguSy0Oma89tDcuilIqzRECSblfs2ZJoxu6Wdr2LJZjCtk9jfU3sTfS
         U+mpYartAZWvCSHmi8JsPCibMXus3b+pMGl/3dxyClXfUdKdW3yvi0Wm2wnA5H40EXrj
         I9/Mge5nYF1I7MicU+V2JR+hv3WIrxkKgSyRNDYh9d8U3GmS9uoWlrsbKLNN9xZr84RL
         jUZ9fCc4EjtymdA8Bf0+soUUcgcKphkWpF5rxHne9PgDPACZlUMziwQcV7YMskIhDG5h
         OAAqvqDOjhIPhySVzptQr9W7LMV2gWK5ttErXeAiB/uGg5kODAfh2tgLRs3AsXMIQnf4
         LHPQ==
X-Gm-Message-State: ACgBeo1lA7ZUuOC/gZcbXLb1D+sa/spN//9GpWUQ0E29xaf+hn8TuOyI
        un3/tpe4AURzZd/1bUUDMsXHuA==
X-Google-Smtp-Source: AA6agR7wINrCePHeVs2TMkvqGiR/IRUfgMtH5I4tZVRbaGeKyMht9ahIL1Pvt2KiIEak8VBoyVlboQ==
X-Received: by 2002:a5d:58cb:0:b0:228:dc7f:b9b3 with SMTP id o11-20020a5d58cb000000b00228dc7fb9b3mr1426297wrf.98.1662482873002;
        Tue, 06 Sep 2022 09:47:53 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v3 12/30] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Tue,  6 Sep 2022 18:47:02 +0200
Message-Id: <20220906164720.330701-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

