Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1853058ACBF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbiHEO6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiHEO6R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 10:58:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D2A4E601
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 07:58:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso4089747wma.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EuxOLdlH6ukJvNo3hmlu21EvGbHSW4uY/PP2kfnfWLQ=;
        b=mqK+SNIFxqd9jKVN3Hmt1q9lbAw78BALX+y/tfQ1sRuSn5eEFfpCEGzwDklw5j2dTh
         v9UfoVZ+JJ5kj//QbI67ZCwuVA1+Yy/v6cX5GFB6H+6mcP/NBcr2+VJN121NM/G1MLHr
         cgQCI6p8WUaHFmxVepoWBevid28K2jJqWc0ArUgAJi3HDC8g6RpbLC4S1uZIZRkyVH7v
         XNaFQGM5swwaq93Teq+svz8yW72FiUDQ6tRmBJgMTL5c7fJx66RnJ8jeLzyc7+u4300o
         3Dh7Mx3QTIOmUb7HPVNwshAHwe0BTTyyhTKD8FIUrB7w4V2vNDBml9Gyiac62Jf1RnVl
         uLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EuxOLdlH6ukJvNo3hmlu21EvGbHSW4uY/PP2kfnfWLQ=;
        b=aO/bP02KkXKO06NVFz8JuRyK5w8KdIIHqFmHaG2R8KXEFq//Y+hjXjQ3IFi4n+4dA5
         Dz14h45G9r4ocfLT2yK4cFIkgcBF0amDnUeHaZ5jHv+f0uaQcjB/ERhmqWq3Jn6mEcVQ
         y/ezWQxWFOPi3hW+FJYrzdcjm1BmcO4Ak09NJofpQ4Nt/kt1ibEU3N2ICOnvqbDBdcJ5
         E4/zJIDiDssM59XwXU66KViRFlGsd6BBT9S3bgpaP+TVq5pfaRYfuniZEcWBzcN5+JYe
         TwQpl1r5nJk7nizfmHkNwZVfcblnNJIj8z/3Zwjra3rFtAZn6PasP2Du/v8skjcsiWW6
         9zcQ==
X-Gm-Message-State: ACgBeo0iUvK0utG7ugmvt0TuOVS5kO3C+EzNHJ5l6Jqwzci/teQwOOk3
        MG1GuO3OTzzMwbNBNVq6oy8KLA==
X-Google-Smtp-Source: AA6agR7NsJ1d0P03i4BXcvQ0NUsSXwE5jywTzyMkL/Mfq8vdWMXR0NkeEd3i5OOoeHEMt6TvXH6wjA==
X-Received: by 2002:a05:600c:3582:b0:3a3:3b00:cb25 with SMTP id p2-20020a05600c358200b003a33b00cb25mr4963947wmq.170.1659711484095;
        Fri, 05 Aug 2022 07:58:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 14/26] thermal/core/OF: Remove unused functions
Date:   Fri,  5 Aug 2022 16:57:17 +0200
Message-Id: <20220805145729.2491611-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the dead code: of_thermal_get_trip_points()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  7 -------
 drivers/thermal/thermal_of.c   | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 194e98a5b102..04565746afbf 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -145,8 +145,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #ifdef CONFIG_THERMAL_OF
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
@@ -157,11 +155,6 @@ static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 {
 	return false;
 }
-static inline const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return NULL;
-}
 #endif
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 8b68b6b94beb..c675d6b72802 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -54,23 +54,6 @@ bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 
-/**
- * of_thermal_get_trip_points - function to get access to a globally exported
- *				trip points
- *
- * @tz:	pointer to a thermal zone
- *
- * This function provides a pointer to trip points table
- *
- * Return: pointer to trip points table, NULL otherwise
- */
-const struct thermal_trip *
-of_thermal_get_trip_points(struct thermal_zone_device *tz)
-{
-	return tz->trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.25.1

