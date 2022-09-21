Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B55BFB73
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiIUJo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiIUJn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 05:43:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63092F75
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bq9so8932514wrb.4
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1g7iD3leIss4w6BJ5qO+L1jz4YwsNBVACOWMBVjZgpk=;
        b=zQbmfBmegjos4DstNIyh4h3OfgjszA3bL7nsBwXGl/h1Rh1x03+MeT9QU8UpnjjUrv
         MB4FZYymJ9XdqFI5WTo05b2iK/TyqXb/IbvqFsoc8Dj1Ow8qlyiHsQ3Vt2FuJe5uR492
         fOC068b6lAjpy9eQ8R7bcM4+UQyY3Kyiz2DHxz3xLqt1RELb0RVRhso6JbQqYpF5BgqN
         fEpI+FpSF1dyhxqrFLcIyLbx8nIZin0jG4VXiBDFlJU/9Ir9+UaIAjqSJztcgVBtnHG2
         ShmfOqw644YZqLiRvOAzigLsm9XFbFNsEqehgBYa9hj7na3+xCxQ511pw7LY7RDiUUNP
         AkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1g7iD3leIss4w6BJ5qO+L1jz4YwsNBVACOWMBVjZgpk=;
        b=gOn0wueA6QGoMw5p6R1lmgaZ9McoSMD4i1R9mQnSc2tK+SBFFBUh2PidYHjak1xyUq
         QYfviFq7Vi+60PqGWPXFEoY6smQl0uO5p/IBzWz6CM9ZIiA4XkMc0H9MvgF+4uYSKIn4
         PZDb8KSQh0N/wxmWVj42skXKw/go6vkivTkVzCXSWhG80YI8NIyHxXNzzO9/0EhheCBc
         9UZxXPFFTFWus2vwbOUQhtN7cHeRLiOV+F7bInc9jiRY8e7RbLzgTcO/uhJyZVrpqizH
         X6rE09Ev/2yt0yaYC5uxMU2q2tT9zSMP78oLmBTWsfIZVICFvm582ObSO8fEIx55IzUW
         GiwQ==
X-Gm-Message-State: ACrzQf0m6RQqyatMUDxGuDW7M71VPwA5NBjGUUHDcDZh9IJYxKF0jVhE
        8G0d0GW8Jeq5KTr4/0LO0BQbTw==
X-Google-Smtp-Source: AMsMyM5Fy5rsKtsYjouyAotA7L+Pne0w+FWVZ0x6QfNVNWl4vzzA09eOpseqiZdhv/eLWnoKGpc7AQ==
X-Received: by 2002:a05:6000:1866:b0:228:e373:ad68 with SMTP id d6-20020a056000186600b00228e373ad68mr16155764wri.605.1663753434825;
        Wed, 21 Sep 2022 02:43:54 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v4 23/30] thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:36 +0200
Message-Id: <20220921094244.606948-24-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 49 +++++-----------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 4df42d70d867..003457810072 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -278,52 +278,16 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
-				      int trip, enum thermal_trip_type *type)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
-				      int trip, int *temp)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*temp = MCELSIUS(90);
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 };
 
 static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
-	.get_trip_type	= rcar_thermal_get_trip_type,
-	.get_trip_temp	= rcar_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .type = THERMAL_TRIP_CRITICAL, .temperature = 90000 }
 };
 
 /*
@@ -531,9 +495,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
-			priv->zone = thermal_zone_device_register(
-						"rcar_thermal",
-						1, 0, priv,
+			priv->zone = thermal_zone_device_register_with_trips(
+				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
 
-- 
2.34.1

