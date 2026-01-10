Return-Path: <linux-pm+bounces-40595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76BD0D40D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FBB3009F9F
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jan 2026 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118002C11C6;
	Sat, 10 Jan 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1n8yt3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE935965
	for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768037354; cv=none; b=erQaCJFQmRz2tVeACOeJI55arGVI8oEZViWq08rTct3U7iVf70yLEVMLUQ6Ey3HoX0zCPKd+mFYwBHSYURPt26WKXqb5yo1bbF2iTbf28MJArGDyGBur6c1lQsJdQafla97Ae3XvxDK1taVpMqz5ZTHBdfBUX59kSID0Zig7Kqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768037354; c=relaxed/simple;
	bh=wodfZrquL/rfuEM7QOOgX1DVDqQAtjuosTSATgAneNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hu1r/69fX/IJRl3o3iGONoSMkSoiihWgDH5fuENohWKBoDuWNoHF3hJVvzAg3xDH0B07L0gt8DrCMC4tCzayyKSotYNZhO2Rlmrz2re8hs77BOMKbXaP6U+ix1H/ISZ7SQ51P+WGRfL100rDzVGawcj6LaiYkU8uKj8icMMFLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1n8yt3v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso5058032b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Jan 2026 01:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768037352; x=1768642152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GADQ+AdsmrR4+12B/Ji3V/4sL0DG8cy9cAdCGB5FWhc=;
        b=D1n8yt3vucAqOmS8h3Fy0YQhYsjOtGtZCaTRCHNL+MuB8T6DTxrnIIZXETqpWbN6nH
         N5kfYl+ZZoGdgEQ1xmVBsRx0C//8dqglRj7t8+D/E40G3on+v9fekahgFJ/U0wFR+LXk
         fx4nSNvW7lxigYub6A2Yp433Gq78OpTUc0MMnG5i8/X4RRr/GxDFS1gb4NV/T7lmnsAj
         uCc8vTrUIR746ZdxYs6PgxwAq2DDF3xbQz608pUmGYN9vIUHd6GTUYENi3cHw53fsCVv
         unZ/1sZuYJJuhUbI08uG/tWZmm4ohDUyUZ3h8F7FFiGT5kgTd3CyED32xh4SH8soJFY3
         xoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768037352; x=1768642152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GADQ+AdsmrR4+12B/Ji3V/4sL0DG8cy9cAdCGB5FWhc=;
        b=T1ABTbGqgUDmSuf13/ms7PeVQQRzfSKwseVfPrgiH9hv3AErTerqLV8vNGJZgmrk51
         hlfzDXl9vLe9+HFZ3OPb55dQAE+0+J5BDSd31wYhTfWUDSsrMYVZDwNqt7n95LDKniid
         7OpCP7XMPSj8MDBIMeAHeAMWlmFR8Ijl0SbyHbnXGglxxd8ZxcuAU1HozCtDYltbxu/m
         6Wlutm2UBZD8TRnIoqdNinZv4ceT9rVwI8rhr5FWs2T8SxvCa6ThW5B1IVLJUbpdHxQ4
         22ewgeuc5/b8FRmuncEsJQLSHcxs2Vv8W3qRtnar55oQCPaflwsuyi2a+TCUCKOzmcDO
         /qsg==
X-Forwarded-Encrypted: i=1; AJvYcCV6kphpePMoG5UkOGzEj7mlN2gxFqbd4W/E67S63qwZf0GHkiyEm3I6m6f9EW2xspgny9wpPBRcZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkRIWb+35irhpn0/Y/Uzquf6XAzrmU9FVxbpaPaN1j0/aMzZX
	A0MVjLs+skfXXw1EcdzBzzVHPDBSKOacf4mHNZeRKJGwdummWzcomobM
X-Gm-Gg: AY/fxX7ROUUryucUZ0eogM65FyzRMEVzoqRE4aRkKqhRejpNqsKVPSwFpscMIn1x0tt
	tGcnoIhyH4jEGHmi4U4lndWm9ZaQrwISOxi2wkOMtRCtHy6fKjVTYPrF9oasTfKLFoRCgJWb9AU
	1bZ0XujIKwZbIQeU25WmFqKoBsq5hcdHGFi5Z40YjqmUYmTx3t89HCnztwhMJdmZvOSxuRXUUX+
	eCgqCVTyCojvP6Cn1crf2/MV2/M850rHMh3EznrRRDW6IE/akIGuUSjh+POpEf1dhtgyViE2vK6
	OJIBksb4ZctVmGkvLkTQh9DgfECrqSCG29tXCCoCfzHIN30N0mqJDsPaY4bAES6NB/McZobzEHX
	rr0/f1Ibbcu12pP5nwoXYVlDAWEq2JG4nMQxUFOOplaDnVG10STDLual9xDT3bXeuegPb74CwyJ
	UqzmAzGOJJBsJkikQ=
X-Google-Smtp-Source: AGHT+IHyhlUqvmNa4cKaQk2G5m3is31iYQGifXh4ftvRDkp3Sn8Eu+XtXXwZ3Vq1nKKBCDDJ1ibtQA==
X-Received: by 2002:a05:6a00:6c87:b0:7f7:13bb:8f20 with SMTP id d2e1a72fcca58-81b7fdc34ffmr11037851b3a.50.1768037351642;
        Sat, 10 Jan 2026 01:29:11 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:5089:d5e0:85cd:c96c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81eaeda5145sm3211071b3a.28.2026.01.10.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 01:29:11 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] thermal: Replace sprintf() with sysfs_emit() for sysfs show functions
Date: Sat, 10 Jan 2026 14:58:51 +0530
Message-ID: <20260110092851.9078-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all sprintf() calls with sysfs_emit() and sysfs_emit_at() in
sysfs show functions. sysfs_emit() and sysfs_emit_at() are preferred
over sprintf() for formatting sysfs output as they provide better
bounds checking and prevent potential buffer overflows.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/thermal/thermal_hwmon.c |  4 ++--
 drivers/thermal/thermal_sysfs.c | 36 ++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 64cc3ab949fe..faf1d0083890 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -63,7 +63,7 @@ temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", temperature);
+	return sysfs_emit(buf, "%d\n", temperature);
 }
 
 static ssize_t
@@ -84,7 +84,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", temperature);
+	return sysfs_emit(buf, "%d\n", temperature);
 }
 
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d80612506a33..26b8b340fbe6 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -29,7 +29,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
-	return sprintf(buf, "%s\n", tz->type);
+	return sysfs_emit(buf, "%s\n", tz->type);
 }
 
 static ssize_t
@@ -41,7 +41,7 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 	ret = thermal_zone_get_temp(tz, &temperature);
 
 	if (!ret)
-		return sprintf(buf, "%d\n", temperature);
+		return sysfs_emit(buf, "%d\n", temperature);
 
 	if (ret == -EAGAIN)
 		return -ENODATA;
@@ -57,9 +57,9 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	guard(thermal_zone)(tz);
 
 	if (tz->mode == THERMAL_DEVICE_ENABLED)
-		return sprintf(buf, "enabled\n");
+		return sysfs_emit(buf, "enabled\n");
 
-	return sprintf(buf, "disabled\n");
+	return sysfs_emit(buf, "disabled\n");
 }
 
 static ssize_t
@@ -97,7 +97,7 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_trip *trip = thermal_trip_of_attr(attr, type);
 
-	return sprintf(buf, "%s\n", thermal_trip_type_name(trip->type));
+	return sysfs_emit(buf, "%s\n", thermal_trip_type_name(trip->type));
 }
 
 static ssize_t
@@ -142,7 +142,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_trip *trip = thermal_trip_of_attr(attr, temp);
 
-	return sprintf(buf, "%d\n", READ_ONCE(trip->temperature));
+	return sysfs_emit(buf, "%d\n", READ_ONCE(trip->temperature));
 }
 
 static ssize_t
@@ -188,7 +188,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_trip *trip = thermal_trip_of_attr(attr, hyst);
 
-	return sprintf(buf, "%d\n", READ_ONCE(trip->hysteresis));
+	return sysfs_emit(buf, "%d\n", READ_ONCE(trip->hysteresis));
 }
 
 static ssize_t
@@ -213,7 +213,7 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
-	return sprintf(buf, "%s\n", tz->governor->name);
+	return sysfs_emit(buf, "%s\n", tz->governor->name);
 }
 
 static ssize_t
@@ -260,7 +260,7 @@ sustainable_power_show(struct device *dev, struct device_attribute *devattr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
 	if (tz->tzp)
-		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
+		return sysfs_emit(buf, "%u\n", tz->tzp->sustainable_power);
 	else
 		return -EIO;
 }
@@ -291,7 +291,7 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
 									\
 	if (tz->tzp)							\
-		return sprintf(buf, "%d\n", tz->tzp->name);		\
+		return sysfs_emit(buf, "%d\n", tz->tzp->name);		\
 	else								\
 		return -EIO;						\
 	}								\
@@ -505,7 +505,7 @@ cdev_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 
-	return sprintf(buf, "%s\n", cdev->type);
+	return sysfs_emit(buf, "%s\n", cdev->type);
 }
 
 static ssize_t max_state_show(struct device *dev, struct device_attribute *attr,
@@ -513,7 +513,7 @@ static ssize_t max_state_show(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 
-	return sprintf(buf, "%ld\n", cdev->max_state);
+	return sysfs_emit(buf, "%ld\n", cdev->max_state);
 }
 
 static ssize_t cur_state_show(struct device *dev, struct device_attribute *attr,
@@ -526,7 +526,7 @@ static ssize_t cur_state_show(struct device *dev, struct device_attribute *attr,
 	ret = cdev->ops->get_cur_state(cdev, &state);
 	if (ret)
 		return ret;
-	return sprintf(buf, "%ld\n", state);
+	return sysfs_emit(buf, "%ld\n", state);
 }
 
 static ssize_t
@@ -638,7 +638,7 @@ static ssize_t total_trans_show(struct device *dev,
 		return 0;
 
 	spin_lock(&stats->lock);
-	ret = sprintf(buf, "%u\n", stats->total_trans);
+	ret = sysfs_emit(buf, "%u\n", stats->total_trans);
 	spin_unlock(&stats->lock);
 
 	return ret;
@@ -664,8 +664,8 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
 	update_time_in_state(stats);
 
 	for (i = 0; i <= cdev->max_state; i++) {
-		len += sprintf(buf + len, "state%u\t%llu\n", i,
-			       ktime_to_ms(stats->time_in_state[i]));
+		len += sysfs_emit_at(buf, len, "state%u\t%llu\n", i,
+				     ktime_to_ms(stats->time_in_state[i]));
 	}
 	spin_unlock(&stats->lock);
 
@@ -846,7 +846,7 @@ trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	instance = container_of(attr, struct thermal_instance, attr);
 
-	return sprintf(buf, "%d\n", thermal_zone_trip_id(tz, instance->trip));
+	return sysfs_emit(buf, "%d\n", thermal_zone_trip_id(tz, instance->trip));
 }
 
 ssize_t
@@ -856,7 +856,7 @@ weight_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	instance = container_of(attr, struct thermal_instance, weight_attr);
 
-	return sprintf(buf, "%d\n", instance->weight);
+	return sysfs_emit(buf, "%d\n", instance->weight);
 }
 
 ssize_t weight_store(struct device *dev, struct device_attribute *attr,
-- 
2.43.0


