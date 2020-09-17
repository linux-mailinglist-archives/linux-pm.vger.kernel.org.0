Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7F26D1B1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 05:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIQD3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 23:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIQD2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 23:28:09 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AEC061224
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e7so768344qtj.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyquXDsI5PpUswweH/QuIkj+hc4Cb9K+5Ghm5R3vs34=;
        b=TMVcDNfEewcm+Zlud5OWrLGCMtmG1XeduU2v6C81w3F27mDgOu5Dyjif/uvvhdsYNA
         ZF8agjfrxmavZWYFccuoVVZlNqDx0D0M8v89KjTasVKsAGJ0woopsXMrlfQW6hml+tj7
         HbYKk+7NjJA1wjTkgwVq8paXmKSU7anwXtDDTxJ6UI0n9HIBv1l/7FIFf3nujZ/cMksP
         D30K4FMm77sR/DQzZYi3o8+kiBT5hGNj53VO3GKFGrms6Ft+lOz/pPXHxlP5KppRbvmu
         gvcisGJ/2G+AGfGNjBI+cqLJF6D8VAqNrlUesqay0E9Wqa6RHukc2cdU2ZZifdEo+a52
         uZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyquXDsI5PpUswweH/QuIkj+hc4Cb9K+5Ghm5R3vs34=;
        b=nrfhiro5yuwbExozXGoHqDGF1RMtoqUVUcEevQe8HhQ60772Z+/AmJAyfRJruBE/j2
         Xb0Zs8shhnSE4VPBE1++B2DIITPfWhIacysZQE8qUOSBml3vvytCtw9cCm8Kk51NumCI
         wdQgEUjxp2tiuNPN25ZnaQu7QgAKWpmBRJbHBhCDUwgh/dV1+EA8mtbKJbwe9VrxKxz1
         /C5sQ5Yn/NDLME/R4M1+ocw7XtHAqRKJs0muTqn/SFkpRuf+96B9MJhy7BkCx1q3FF9w
         7vz4/jgDVuGXL8GDhduMiyt+MbvjcHLnMCJCIdOxv977ouaW+TTU5lZtLrQAWXXKxC3G
         LWwQ==
X-Gm-Message-State: AOAM531E/ohjP02K5pJFS+BE1xm5jeqGdiCXazKfeMx0Ii3XUXstgtYL
        4mBipHugfq7ORPLVP4VSIMGQfw==
X-Google-Smtp-Source: ABdhPJyKE5XKI9TJVppgF3SUV9hJyConQ72DMtIOPoTixmFeCTdqRn/0DKS2tG949jP/2DuCt8Ac/A==
X-Received: by 2002:ac8:1108:: with SMTP id c8mr13557566qtj.323.1600312952482;
        Wed, 16 Sep 2020 20:22:32 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:32 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 5/8] thermal: gov_step_wise: Extend thermal step-wise governor to monitor falling temperature.
Date:   Wed, 16 Sep 2020 23:22:23 -0400
Message-Id: <20200917032226.820371-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From the step wise governor point of view, the policy decisions
that has to taken on a thermal trip point that is defined to be monitored
for falling temperature is the mirror opposite of the decisions it has
to take on a trip point that is monitored for rising temperature.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/gov_step_wise.c | 62 +++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 2ae7198d3067..c036ff7b4fb2 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -35,7 +35,8 @@
  *       deactivate the thermal instance
  */
 static unsigned long get_target_state(struct thermal_instance *instance,
-				enum thermal_trend trend, bool throttle)
+				enum thermal_trend trend, bool throttle,
+				enum thermal_trip_monitor_type type)
 {
 	struct thermal_cooling_device *cdev = instance->cdev;
 	unsigned long cur_state;
@@ -65,11 +66,24 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 
 	switch (trend) {
 	case THERMAL_TREND_RAISING:
-		if (throttle) {
-			next_target = cur_state < instance->upper ?
-				    (cur_state + 1) : instance->upper;
-			if (next_target < instance->lower)
-				next_target = instance->lower;
+		if (type == THERMAL_TRIP_MONITOR_FALLING) {
+			if (cur_state <= instance->lower) {
+				if (!throttle)
+					next_target = THERMAL_NO_TARGET;
+			} else {
+				if (!throttle) {
+					next_target = cur_state - 1;
+					if (next_target > instance->upper)
+						next_target = instance->upper;
+				}
+			}
+		} else {
+			if (throttle) {
+				next_target = cur_state < instance->upper ?
+					    (cur_state + 1) : instance->upper;
+				if (next_target < instance->lower)
+					next_target = instance->lower;
+			}
 		}
 		break;
 	case THERMAL_TREND_RAISE_FULL:
@@ -77,14 +91,23 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			next_target = instance->upper;
 		break;
 	case THERMAL_TREND_DROPPING:
-		if (cur_state <= instance->lower) {
-			if (!throttle)
-				next_target = THERMAL_NO_TARGET;
+		if (type == THERMAL_TRIP_MONITOR_FALLING) {
+			if (throttle) {
+				next_target = cur_state < instance->upper ?
+					    (cur_state + 1) : instance->upper;
+				if (next_target < instance->lower)
+					next_target = instance->lower;
+			}
 		} else {
-			if (!throttle) {
-				next_target = cur_state - 1;
-				if (next_target > instance->upper)
-					next_target = instance->upper;
+			if (cur_state <= instance->lower) {
+				if (!throttle)
+					next_target = THERMAL_NO_TARGET;
+			} else {
+				if (!throttle) {
+					next_target = cur_state - 1;
+					if (next_target > instance->upper)
+						next_target = instance->upper;
+				}
 			}
 		}
 		break;
@@ -117,6 +140,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 {
 	int trip_temp;
 	enum thermal_trip_type trip_type;
+	enum thermal_trip_monitor_type monitor_type =
+					THERMAL_TRIP_MONITOR_RISING;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
 	bool throttle = false;
@@ -130,9 +155,15 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		tz->ops->get_trip_type(tz, trip, &trip_type);
 	}
 
+	if (tz->ops->get_trip_mon_type)
+		tz->ops->get_trip_mon_type(tz, trip, &monitor_type);
+
 	trend = get_tz_trend(tz, trip);
 
-	if (tz->temperature >= trip_temp) {
+	if (((monitor_type == THERMAL_TRIP_MONITOR_RISING) &&
+	     (tz->temperature >= trip_temp)) ||
+	     ((monitor_type == THERMAL_TRIP_MONITOR_FALLING) &&
+	     (tz->temperature <= trip_temp))) {
 		throttle = true;
 		trace_thermal_zone_trip(tz, trip, trip_type);
 	}
@@ -147,7 +178,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		old_target = instance->target;
-		instance->target = get_target_state(instance, trend, throttle);
+		instance->target = get_target_state(instance, trend,
+						    throttle, monitor_type);
 		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
 					old_target, (int)instance->target);
 
-- 
2.25.1

