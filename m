Return-Path: <linux-pm+bounces-12313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5669543B9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDF1F23970
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8DF8563E;
	Fri, 16 Aug 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr3ywX73"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612A823AC
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795969; cv=none; b=upsq3aaKLiI/MEC7QRYpadMI9vDlYm2nwrsgjK+9weka50BOj6gC53FxIBAPiZ9nz7jVVHcsM5fFIuUwGx8iXexwvjtBopRvaPGwtTay9I5bVw/MHu+2EMLKS6it/IUHRZUwW+1h3G7gJirRcCW6Wq97L3Ztc/xaKMmN3QHvtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795969; c=relaxed/simple;
	bh=6ODmSx/BqX1DAmg0Nvvx6v6RGpABj/Zp5OzjuzzjVcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDl9343twvVBjq2edeWQauZfXgvogF0+H75ltX3jYPIqJqb8qKlz7s4DWVLGCAb0Ibh2TeIVjZquDY3ih4LpNcuruqp6zA5FVXWHt7sb+okUB46Gxc4O/Sa46gbXqRFrRYgXqemypOcqUkYoIrAmon/SJOZTesRG4HQnCcs2u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kr3ywX73; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428243f928fso17316665e9.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795965; x=1724400765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7YISoiooozOIq4w+X12WtyZF015lSfecgxPxzmXkaM=;
        b=kr3ywX73MQ8GBbHv5gBgIB4WKHMKa6Cw4EDAt0jKoywqPRmNMWE4HhHoDttjMvAcSN
         Qq9UiuAeGvvQQCJim0Cc/szVvPgcax2uw1ATRy2OR7CdbyHfeQK75fOhvs1WPVd++Aya
         0Q+ZG77++CXz11F998VHkzVn+g1POPnj72mehM9fJ7rWV1cKCAYYBhVouq0VvtYtZnhl
         i8yahlmtitTYgTPmIrit68PNiZrN4WnpHQg8Ps2HoQs864wiJ8PzggZUZVRAkfwfngDC
         AGtxn7KRgohnHN+HafSulKarSL4wMJE1899nhHM5zHpHzvcFiLkhC9GTtvY3ExgLe8Td
         POhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795965; x=1724400765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7YISoiooozOIq4w+X12WtyZF015lSfecgxPxzmXkaM=;
        b=xQK09jlaDVobI3PkF8s2XKJIbRrDOkf8o4m/0W0QmGZsRlJajLDFett8HxFdlyzm+I
         M03QseECBPYKoUHDaQ8ezTQnS0mS35fCkgCSLD1wfyHpOE6UgRy9Oj6pa1jyvu3HeoKG
         GRFEgH5SRs6ROF8u6nJDzVcIE7fHTY7baVIdPTYSWhJpGSYXQAd0AxyiDXlwUV3M8Piu
         YEyGjoCT4rnhs3m2XjnOd53d1J2kAKuDq4+xN0YOfFCplUgipp6dt+lvX6wtH86rPX6T
         z658wo0JhYnK3FYR/2YdSNOzYWgJxd+46V2hupkJ5SsMIOGwwKjPKVeYR4lDBBP798Vn
         l8vA==
X-Gm-Message-State: AOJu0Ywu0DJp2FFkSBy4Sr+Oj2dP4iRaO58C+DJdQDfXW1g6YVqiQNAV
	48HAy/3FhtmBTGoWWNdsEiHv1hohDCrXTncdJJ1edb9HO2InVmi56MjjgZwqs/s=
X-Google-Smtp-Source: AGHT+IF+N5KmMjzEAFpZMmAvI8cg8nQMGZEInMqCWMeL9EWr+nlwerecmyeqSUNUGeAT2sYNyaKJLQ==
X-Received: by 2002:a05:600c:5487:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-429ed784142mr15219635e9.3.1723795964780;
        Fri, 16 Aug 2024 01:12:44 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:44 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 1/7] thermal/core: Compute low and high boundaries in thermal_zone_device_update()
Date: Fri, 16 Aug 2024 10:12:32 +0200
Message-ID: <20240816081241.1925221-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to set the scene for the thresholds support which have to
manipulate the low and high temperature boundaries for the interrupt
support, we must pass the low and high values to the incoming
thresholds routine.

The variables are set from the thermal_zone_set_trips() where the
function loops the thermal trips to figure out the next and the
previous temperatures to set the interrupt to be triggered when they
are crossed.

These variables will be needed by the function in charge of handling
the thresholds in the incoming changes but they are local to the
aforementioned function thermal_zone_set_trips().

Move the low and high boundaries computation out of the function in
thermal_zone_device_update() so they are accessible from there.

The positive side effect is they are computed in the same loop as
handle_thermal_trip(), so we remove one loop.

Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 12 ++++++++++--
 drivers/thermal/thermal_core.h |  2 +-
 drivers/thermal/thermal_trip.c | 27 +--------------------------
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 95c399f94744..166f48071487 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -547,6 +547,7 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	struct thermal_trip_desc *td;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
+	int low = -INT_MAX, high = INT_MAX;
 	int temp, ret;
 
 	if (tz->suspended)
@@ -580,10 +581,17 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for_each_trip_desc(tz, td)
+	for_each_trip_desc(tz, td) {
 		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
 
-	thermal_zone_set_trips(tz);
+		if (td->threshold <= tz->temperature && td->threshold > low)
+			low = td->threshold;
+
+		if (td->threshold >= tz->temperature && td->threshold < high)
+			high = td->threshold;
+	}
+
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
index 06a0554ddc38..1d43ab52e86a 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -61,25 +61,8 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
 
-/**
- * thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
- *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
- *
- * This function must be called with tz->lock held. Both tz and tz->ops
- * must be valid pointers.
- *
- * It does not return a value
- */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	const struct thermal_trip_desc *td;
-	int low = -INT_MAX, high = INT_MAX;
 	int ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -87,14 +70,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	if (!tz->ops.set_trips)
 		return;
 
-	for_each_trip_desc(tz, td) {
-		if (td->threshold <= tz->temperature && td->threshold > low)
-			low = td->threshold;
-
-		if (td->threshold >= tz->temperature && td->threshold < high)
-			high = td->threshold;
-	}
-
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;
-- 
2.43.0


