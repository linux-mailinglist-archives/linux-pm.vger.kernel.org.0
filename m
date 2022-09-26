Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE05EAA4C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiIZPTq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiIZPTL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:19:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5048275F
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so5018530wml.5
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=sqO/O1aFXJtFOKef2CLDy2KKoGo8mS1jDc0v38LlO4RsfpXxavOpN1TxtCAobC4yO3
         kNv2B00br95zTYjJS9brJ+w5p6aI1B2nSj1JtpnHAoQqcKTO+B3NZht/kub2MfdwOxet
         Evm4oMZyp6uCsSlcx+dSf7ZvAADUW2jSacn8Y74kT7yhK8gG5sL92VCKetIy/uef5lNI
         0MkUVZCHihEcwswFI6nNmpVOJ8Ke0AgMDB+K5q3xHGBwtIYohPQtlDZg1/kDkpndeiVw
         Jhih4H1DDmdVMIr+2pSA9TCh9m1wGYQGKyVGAJiAsyXkbcBmaVWQoPmZJb0sZA/2SvDE
         b/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhkHfGU+506U13gs0KttMlfYYtmPZTAW+1/ApMCut14=;
        b=lGQfwsr22cNMMwJA9oXPe/LLoTfcSbh8rmseWC8+cY8AVyB+tFkw8Veg9l5kffPWDA
         IUEZuzInpJ5mmk46igZFUmk/R49QnO23P4P/GQmvkJ/OdEBe8eF3IVJ6CD7HNzIUJmRk
         sEqbhhF1UVW3MbLtZkgEsJ8bPqkCcVpNgm5AQQaNYXpm7/EgC6W2pvGu1rGWsKleN9nK
         polFxF9W3sQxOkk/sb/BEJ9O2VFZSC5/63Vw+5uEWZ6kBVeTOtkSSj15LA6W6Ot5QxOz
         SikkmihgRXyXuNXCNz5WUGTP3uNAyZU6B17ujWaFTyxNtbOByvhM5U8D7zobLW+fRdaW
         s85w==
X-Gm-Message-State: ACrzQf0Z5nCvHmJLlQJ4ptvxuRG7wsDKVIAGpqdaFte/AEbRRYpAWTK1
        0tY22b2RiLjpRNay0WNmswFSPg==
X-Google-Smtp-Source: AMsMyM6HXTifdgRuNXtogg59dwFlxvk/9EzRjUIZBwKpxkvtUZNRBVRRWpFOp6S2LnET4G2WYaRKQw==
X-Received: by 2002:a7b:cbc4:0:b0:3b4:fd67:d70d with SMTP id n4-20020a7bcbc4000000b003b4fd67d70dmr16957755wmi.98.1664201193975;
        Mon, 26 Sep 2022 07:06:33 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Amit Kucheria <amitk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v5 12/30] thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:46 +0200
Message-Id: <20220926140604.4173723-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

