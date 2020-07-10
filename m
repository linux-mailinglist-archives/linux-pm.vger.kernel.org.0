Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1121B732
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGJNwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgGJNwA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:52:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AECC08E6DC
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:52:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id u8so2551344qvj.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Hf2EQhK7szwaDYevZJPMqkaBsz8dSW+eokQabw43h0=;
        b=OFVDGDmDk2rsL22Q4OLH5sVL2ZMmlniVU/Ydrcah/Q7eV5oVyW+i2owNIXJhdUgzu4
         oJL8XGEIhQIMoMQKKk24I/CCznLtco1zHe/7pSq0RjsXKN7TUI3dW8OEs7hGHrHaE0w2
         gk4mkcdbZGQHm3gd8DYfTS3DKBkKfQuhlLQm3W3tAmhQ81D4Szi55btLM8eufONuYmBB
         Hc3g972A2kAj/pbdHNI06mO7dqcLMtyMo5MMFDwcMyYrghUJvMDovI2b200HTnqv/aPJ
         pj7VCHr2BRDkIQUVek+yXbOzYf8eUdWVo3SDjYkgjCuv/kLO1R5doaaaqyFYovc0wxYz
         ZtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Hf2EQhK7szwaDYevZJPMqkaBsz8dSW+eokQabw43h0=;
        b=EUJD83169rmnizQsj4wRrK27orOsKivKNTLoIob1apPxBeKEkwNJ8yp1kY5zOGBlIb
         zgVirWkyqO/x0Ohit/ro6yQHgNeDnJ81I4BUiA0lkojTA/bRFoJlMI4IB2oQOM6E8qAM
         kCCZIW1Dc4XO/fZs/ANUqPXfwoC8jFyvSUmOizK3MAajDIS6EkqgvZvCaazv60MNpbdC
         yDF0RCq5BNHsXnALm+40AQylIUYkotYGhLonq7GjgPi7wvZQZrPkCFWmyMk63mncu80+
         KJErULS+9QradN6nUtIg0pS/xC8DCxY8UNRLWryn8mR8RfA88hQ0E7doQ+rC079yOhOz
         s8rQ==
X-Gm-Message-State: AOAM530U3+e5K3la5yPc1gbF0Zk/LIIG3DZmoSjLWVFbmGc6Sjp9I+A7
        8bSbwJIiQIKaVQD7nDuZPONJVS5w2FU=
X-Google-Smtp-Source: ABdhPJyT7tn4WEZFeacs3EYP5s7Vp7u4rKrWmDOwEG+adxnG7MuVKgK6qtBxsQbVh5TyHGVe6O87UQ==
X-Received: by 2002:ad4:504a:: with SMTP id m10mr55427983qvq.172.1594389119450;
        Fri, 10 Jul 2020 06:51:59 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id h197sm7574059qke.51.2020.07.10.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:51:58 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] thermal:core:Add genetlink notifications for monitoring falling temperature
Date:   Fri, 10 Jul 2020 09:51:53 -0400
Message-Id: <20200710135154.181454-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710135154.181454-1-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add notification calls for trip type THERMAL_TRIP_COLD when temperature
crosses the trip point in either direction.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 750a89f0c20a..e2302ca1cd3b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -429,12 +429,21 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip);
+		if (type == THERMAL_TRIP_COLD) {
+			if (tz->last_temperature > trip_temp &&
+			    tz->temperature <= trip_temp)
+				thermal_notify_tz_trip_down(tz->id, trip);
+			if (tz->last_temperature <= trip_temp &&
+			    tz->temperature > (trip_temp + hyst))
+				thermal_notify_tz_trip_up(tz->id, trip);
+		} else {
+			if (tz->last_temperature < trip_temp &&
+			    tz->temperature >= trip_temp)
+				thermal_notify_tz_trip_up(tz->id, trip);
+			if (tz->last_temperature >= trip_temp &&
+			    tz->temperature < (trip_temp - hyst))
+				thermal_notify_tz_trip_down(tz->id, trip);
+		}
 	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-- 
2.25.1

