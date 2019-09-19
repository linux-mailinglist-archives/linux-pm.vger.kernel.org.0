Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB38BB7183
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 04:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfISCSd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 22:18:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43535 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfISCSc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 22:18:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id c3so2275469qtv.10
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 19:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H7D4s+CkAmLBeZ/6zlhP2G8xuIQDDKxrEeqdqHuDSaE=;
        b=YilbaR6jBv62EnsBExQZKzQiV2/klUvm9VFz1WjN6yvxoRyUNArOCv19ThV/q2dUji
         S+8nzP58nrfXl7hAMWWWHjrsALTqpfZ/TIsX9ziepgrgVanl9SnDa/S3yNLgnGMZRgBZ
         KMld+X7eTF2dvMCg7AqNTCXvetYubo4gUKztyJVRKCvdeD+AM/dga7wURid/ufYhNz+H
         24iP7Bch7ZDyI8ENMW4xZYkSaaLVeLH1BuILTVq7H9KIxcC7iB2xbLc8imybqDNyHpjJ
         LOtCrLOrcCKeiIlBlRdkCGCyeTRG7825WQo5/Uv3J/M713IsjmD9U/l1dKn5XmTSGZwU
         eZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H7D4s+CkAmLBeZ/6zlhP2G8xuIQDDKxrEeqdqHuDSaE=;
        b=qYWQ8bj5Hu1QQb6EpXo0jS5vAJEdFanjNQ9udi8JYAgYJFWctUezRZb3Ez9oIErsfI
         ++zSBjyc6D7zn/juVyb5rHYbPm5vMW8xQYZOyl3eak1xgP5ZzKsZNO4r+sr+S/OTz+C3
         tJRiMVDyRKYPcXdT0q2sJ/Ao/2u4T99iFwaEPhCXgimMimoZZ2GMvpx9FOmjVMvqmpmv
         5ubcRHza6V5OvFx5yB5DMylWNCf5RQJDncroPvQ+yfggmm1ppgwtSOa/oUbw3sZUf1d8
         MhPnXyO59LxLmjWP7gbS4PF4l9Bq4KtpBFOVKSx2TMkTAfFsjqHqE0d/u9glmL6n8J8J
         13GQ==
X-Gm-Message-State: APjAAAX3Zggr2NfJZFc0VZiJ7jxh7hWfhCGj1EpjNNvNUmnFWrwg0ZqA
        zvJkU8Ce1hPTIs4cbYXYhYFxSQ==
X-Google-Smtp-Source: APXvYqwXaeBcVyAp1JNYBKDS7In10ssdhrlNkNgEMbkiLJMfzw7ZWi1vOYe4JONKg6yntHxCTwyi0w==
X-Received: by 2002:ac8:4612:: with SMTP id p18mr886307qtn.94.1568859509919;
        Wed, 18 Sep 2019 19:18:29 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id o52sm5261275qtf.56.2019.09.18.19.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 19:18:29 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] thermal: step_wise: Extend thermal step-wise governor to monitor falling temperature.
Date:   Wed, 18 Sep 2019 22:18:23 -0400
Message-Id: <1568859503-19725-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From the step wise governor point of view, the policy decisions
that has to taken on a thermal trip point that is defined to be monitored
for falling temprature is the mirror opposite of the decisions it has
to take on a trip point that is monitored for rising temperature.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/step_wise.c | 59 +++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 6e051cb..aa8e0a0 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
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
@@ -65,11 +66,21 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 
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
+				if (!throttle)
+					next_target = cur_state - 1;
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
@@ -77,14 +88,23 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 			next_target = instance->upper;
 		break;
 	case THERMAL_TREND_DROPPING:
-		if (cur_state <= instance->lower) {
-			if (!throttle)
-				next_target = THERMAL_NO_TARGET;
+		if (type == THERMAL_TRIP_MONITOR_FALLING) {
+			if (throttle) {
+				next_target = cur_state < instance->upper ?
+					(cur_state + 1) : instance->upper;
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
@@ -117,6 +137,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 {
 	int trip_temp;
 	enum thermal_trip_type trip_type;
+	enum thermal_trip_monitor_type monitor_type =
+					THERMAL_TRIP_MONITOR_RISING;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
 	bool throttle = false;
@@ -130,9 +152,15 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		tz->ops->get_trip_type(tz, trip, &trip_type);
 	}
 
+	if (tz->ops->get_trip_monitor_type)
+		tz->ops->get_trip_monitor_type(tz, trip, &monitor_type);
+
 	trend = get_tz_trend(tz, trip);
 
-	if (tz->temperature >= trip_temp) {
+	if (((monitor_type == THERMAL_TRIP_MONITOR_RISING) &&
+	      (tz->temperature >= trip_temp)) ||
+	      ((monitor_type == THERMAL_TRIP_MONITOR_FALLING) &&
+	      (tz->temperature <= trip_temp))) {
 		throttle = true;
 		trace_thermal_zone_trip(tz, trip, trip_type);
 	}
@@ -147,7 +175,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		old_target = instance->target;
-		instance->target = get_target_state(instance, trend, throttle);
+		instance->target = get_target_state(instance, trend, throttle,
+						    monitor_type);
 		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
 					old_target, (int)instance->target);
 
-- 
2.1.4

