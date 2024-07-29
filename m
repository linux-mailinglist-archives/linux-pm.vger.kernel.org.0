Return-Path: <linux-pm+bounces-11544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517993F8FC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB7D1C22191
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731C156880;
	Mon, 29 Jul 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqFknS4k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279F155A39
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265417; cv=none; b=s7gt2qiMnLCtqJuiixnhEFLb90P3xcBeW1W6ytUxgJLVhsJNQllnJB5dGuAQOyRSC7KRjTJqb1UjtcIa1QJDnn2t3mFnQpCgBSbvCwJDSnC0Bmdz5+cpMP81aEpyPxzd/sFzGUis5umnGU+Kq9KhxbKnrDa69PkAf8aU3bUuuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265417; c=relaxed/simple;
	bh=7LXIWhTFm6GfmS9Iv05xdMKiiBD3dYnnr6onqC+/POU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCq1DbBgwEMTZ6TaftUB7RSxZpuXoAjbsSC/b2ln2+Sj8DpXtm3Q4459uyMABpgA/A7nuBNbNFcukWr6XVUu2Zbqf1cbWLABigQOeELvGwbUVTdyqt4DmjNEGj+JPYND2dbKbtaYOQtokv7YA4+7X3jT3iesIOnVfGl0P2ZUHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CqFknS4k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428119da952so17342115e9.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722265414; x=1722870214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m5Inhdd//pDP4jvzaIA3RP1dMT0kGuSI0wQZgb4n7k=;
        b=CqFknS4kTAYe6pxQuH/YtYQw3Ak/58hNaoIPaj/1gNLD6RAAVc3X0PENdcfgwUYErM
         hXipeIPB5TF1ntAlJG9Q/fHAfXvywVn8HELYqfdvR5pk9UwzbxytigFeT4xns8zu9oXg
         v2J1pLNntTBGm3iO9TXeMlIrDqvFbVVvLTFY6RJq5oyoQZRGQ0Pjen0o7fsXn55GmQJO
         QXImWbaVcbcNidr5NSWSLnfF6ulWd5CObVfrF5rhtWvPmFFHjozDzDt6MjXSgoVei8/6
         EZSySdwMkDLjX0Di862v+bZOqzIQF7qgV+OslN29euRiLojy/EMydgapYAVUfekFuzFo
         L16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265414; x=1722870214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m5Inhdd//pDP4jvzaIA3RP1dMT0kGuSI0wQZgb4n7k=;
        b=sO4mWK8DJmeC36OGuzckiWCL1l8TQcdDItEuW7pfrHVSGxKo6qbqZiZefWB00Lt1Sj
         cofSDBRgaegtaS/hbPuSLDZ5K+Kf2txhzOUqRPJ1HF9drILJ/NEOU60/JEChqsj2nR0R
         5aD0pWpROdJQdT+OUcRXUpwdgqRJ+No9YVz7b80z9a3hdP2xAR7PUtl23BOnCcr2bbR7
         jCazsclU2kozwfFyxrNbGaAAG45FJAnPX6AaYM3e3f5QEAMOptrOzjeHC2LdSjTlNAb5
         y3+izGlc6Zuc1jxz7u50BKcX/p6PxIBGFngMMQzfw2RBfnYHsK75maffgzc4s1tip54B
         08VA==
X-Gm-Message-State: AOJu0Yw6rC2UKiZeQJqTDae0Zz+uXM8kPiA93BLTWwzRzrtLeT4kmnCG
	WZDuK2hShYMEuTI3XTVdqFXPfd3i6P3uWRji0G8askUg9RHI+CdJTks/hubVqn0=
X-Google-Smtp-Source: AGHT+IEDyiEoHwGgYkmOe2Bf/G87Pgo3Dyh5koW5qh80LjWF34ZSMZl26t599p6kgFbWT6MIB35eyg==
X-Received: by 2002:a05:600c:458f:b0:428:16a0:1c3d with SMTP id 5b1f17b1804b1-42816a07e88mr46166695e9.19.1722265396720;
        Mon, 29 Jul 2024 08:03:16 -0700 (PDT)
Received: from mai.box.freepro.com (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm12652803f8f.107.2024.07.29.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:16 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v1 1/7] thermal/core: Encapsulate more handle_thermal_trip
Date: Mon, 29 Jul 2024 17:02:50 +0200
Message-ID: <20240729150259.1089814-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to set the scene for the thresholds support which have to
manipulate the low and high temperature boundaries for the interrupt
support, we must pass the low and high value the incoming thresholds
routine.

Instead of looping in the trip descriptors in
thermal_zone_device_update(), we move the loop in the
handle_thermal_trip() function and use it to set the low and high
values.

As these variables can be set directly in the handle_thermal_trip(),
we can get rid of a descriptors loop found in the thermal_set_trips()
function as low and high are set in handle_thermal_trip().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 104 +++++++++++++++++++--------------
 drivers/thermal/thermal_core.h |   2 +-
 drivers/thermal/thermal_trip.c |  12 +---
 3 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 95c399f94744..5cfa2a706e96 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -425,59 +425,74 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
-				struct thermal_trip_desc *td,
 				struct list_head *way_up_list,
-				struct list_head *way_down_list)
+				struct list_head *way_down_list,
+				int *low, int *high)
 {
-	const struct thermal_trip *trip = &td->trip;
+	struct thermal_trip_desc *td;
 	int old_threshold;
 
-	if (trip->temperature == THERMAL_TEMP_INVALID)
-		return;
+	for_each_trip_desc(tz, td) {
 
-	/*
-	 * If the trip temperature or hysteresis has been updated recently,
-	 * the threshold needs to be computed again using the new values.
-	 * However, its initial value still reflects the old ones and that
-	 * is what needs to be compared with the previous zone temperature
-	 * to decide which action to take.
-	 */
-	old_threshold = td->threshold;
-	td->threshold = trip->temperature;
+		const struct thermal_trip *trip = &td->trip;
+
+		if (trip->temperature == THERMAL_TEMP_INVALID)
+			continue;
+
+		if (tz->last_temperature < old_threshold ||
+		    tz->last_temperature == THERMAL_TEMP_INIT)
+			continue;
 
-	if (tz->last_temperature >= old_threshold &&
-	    tz->last_temperature != THERMAL_TEMP_INIT) {
 		/*
-		 * Mitigation is under way, so it needs to stop if the zone
-		 * temperature falls below the low temperature of the trip.
-		 * In that case, the trip temperature becomes the new threshold.
+		 * If the trip temperature or hysteresis has been updated recently,
+		 * the threshold needs to be computed again using the new values.
+		 * However, its initial value still reflects the old ones and that
+		 * is what needs to be compared with the previous zone temperature
+		 * to decide which action to take.
 		 */
-		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			list_add(&td->notify_list_node, way_down_list);
-			td->notify_temp = trip->temperature - trip->hysteresis;
+		old_threshold = td->threshold;
+		td->threshold = trip->temperature;
 
-			if (trip->type == THERMAL_TRIP_PASSIVE) {
-				tz->passive--;
-				WARN_ON(tz->passive < 0);
+		if (tz->last_temperature >= old_threshold &&
+		    tz->last_temperature != THERMAL_TEMP_INVALID) {
+			/*
+			 * Mitigation is under way, so it needs to stop if the zone
+			 * temperature falls below the low temperature of the trip.
+			 * In that case, the trip temperature becomes the new threshold.
+			 */
+			if (tz->temperature < trip->temperature - trip->hysteresis) {
+				list_add(&td->notify_list_node, way_down_list);
+				td->notify_temp = trip->temperature - trip->hysteresis;
+
+				if (trip->type == THERMAL_TRIP_PASSIVE) {
+					tz->passive--;
+					WARN_ON(tz->passive < 0);
+				}
+			} else {
+				td->threshold -= trip->hysteresis;
 			}
-		} else {
+		} else if (tz->temperature >= trip->temperature) {
+			/*
+			 * There is no mitigation under way, so it needs to be started
+			 * if the zone temperature exceeds the trip one.  The new
+			 * threshold is then set to the low temperature of the trip.
+			 */
+			list_add_tail(&td->notify_list_node, way_up_list);
+			td->notify_temp = trip->temperature;
 			td->threshold -= trip->hysteresis;
+
+			if (trip->type == THERMAL_TRIP_PASSIVE)
+				tz->passive++;
+			else if (trip->type == THERMAL_TRIP_CRITICAL ||
+				 trip->type == THERMAL_TRIP_HOT)
+				handle_critical_trips(tz, trip);
 		}
-	} else if (tz->temperature >= trip->temperature) {
-		/*
-		 * There is no mitigation under way, so it needs to be started
-		 * if the zone temperature exceeds the trip one.  The new
-		 * threshold is then set to the low temperature of the trip.
-		 */
-		list_add_tail(&td->notify_list_node, way_up_list);
-		td->notify_temp = trip->temperature;
-		td->threshold -= trip->hysteresis;
-
-		if (trip->type == THERMAL_TRIP_PASSIVE)
-			tz->passive++;
-		else if (trip->type == THERMAL_TRIP_CRITICAL ||
-			 trip->type == THERMAL_TRIP_HOT)
-			handle_critical_trips(tz, trip);
+
+		if (td->threshold < tz->temperature && td->threshold > *low)
+			*low = td->threshold;
+
+		if (td->threshold > tz->temperature && td->threshold < *high)
+			*high = td->threshold;
 	}
 }
 
@@ -545,6 +560,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	struct thermal_governor *governor = thermal_get_tz_governor(tz);
 	struct thermal_trip_desc *td;
+	int low = -INT_MAX, high = INT_MAX;
+
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
 	int temp, ret;
@@ -580,10 +597,9 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for_each_trip_desc(tz, td)
-		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
+	handle_thermal_trip(tz, &way_up_list, &way_down_list, &low, &high);
 
-	thermal_zone_set_trips(tz);
+	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 4cf2b7230d04..67a09f90eb95 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -259,7 +259,7 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
 
 const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
 
-void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index c0b679b846b3..af0f9f5ae0de 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -76,10 +76,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
  *
  * It does not return a value
  */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	const struct thermal_trip_desc *td;
-	int low = -INT_MAX, high = INT_MAX;
 	int ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -87,14 +85,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	if (!tz->ops.set_trips)
 		return;
 
-	for_each_trip_desc(tz, td) {
-		if (td->threshold < tz->temperature && td->threshold > low)
-			low = td->threshold;
-
-		if (td->threshold > tz->temperature && td->threshold < high)
-			high = td->threshold;
-	}
-
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;
-- 
2.43.0


