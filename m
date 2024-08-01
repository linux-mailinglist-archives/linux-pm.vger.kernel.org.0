Return-Path: <linux-pm+bounces-11780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D7943BCE
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 02:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B365E281D50
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8FD19E81F;
	Thu,  1 Aug 2024 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXPv72Ne"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7F19E7E0;
	Thu,  1 Aug 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471316; cv=none; b=Q8K66EZMD2Z0JxrShWMWjANEkJwgz1pwWZ/1xuCvQ9QSXIeI0UQK7uA6081igu5r5JCmtT6BNQjTmt0rc9u2/6KA8av46BVEV1ndFX6xHpOkk65jOjU4Ok0a1EBd6ciGadjxJlLuQCiiBf++nQ9V1LOLjXDIXQVGKfTfRhqeZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471316; c=relaxed/simple;
	bh=5w0TJjkEXqc0xjswndtA5rGb+JrXTD0QKhS0orsixp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwOGkCIvVLxbSw40BNSRRdvyKLFSi68tv7mSUEcyIf3iuePsGNo8errAaStwoZrJ0p4vAYhjL2m5kkR2oWdBKR8NiDE74yVrIEBXwB4t9b+iSeilkZJQT8FTDf+TDVKPzQV0a7XD2hUCuT4c5Xw0jnz20cR5ClAtEkaZwSCnxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXPv72Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95575C116B1;
	Thu,  1 Aug 2024 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471315;
	bh=5w0TJjkEXqc0xjswndtA5rGb+JrXTD0QKhS0orsixp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXPv72Ne7w40y72dQhyRYoCo2e4KYZjDyYF+qjHaWDYC+wG5DhwQXDrUa9L7X88mF
	 UEUzlJvzVU9WWXams2Yirf2shO7AGmmJIllfKVLESiutFCuG6jnzga4nhn2z33vXkH
	 p7Avr2oGGLK8wBM+y2jSy71Dce3DJNCH75xeRNL1pgy5lXFfu/iYH0EEpu3czK4xGz
	 3EVCbnaNsgi4JpSie83l7Jh3DHhY+qntDQ5AWwVdUEyE/5BYFFrKi3gjlmY/zDNTX3
	 rVILXZvsOWKNFFIBlgX/aXNcdpPmRY2q6RR9RV6vIpWQfMdVIonq0ZlRqvAht1IMRq
	 xA79VQmm4QlUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 069/121] thermal: trip: Use READ_ONCE() for lockless access to trip properties
Date: Wed, 31 Jul 2024 20:00:07 -0400
Message-ID: <20240801000834.3930818-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit a52641bc6293a24f25956a597e7f32148b0e2bb8 ]

When accessing trip temperature and hysteresis without locking, it is
better to use READ_ONCE() to prevent compiler optimizations possibly
affecting the read from being applied.

Of course, for the READ_ONCE() to be effective, WRITE_ONCE() needs to
be used when updating their values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_sysfs.c | 6 +++---
 drivers/thermal/thermal_trip.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 88211ccdfbd62..5be6113e7c80f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
+	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.temperature));
 }
 
 static ssize_t
@@ -174,7 +174,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	trip = &tz->trips[trip_id].trip;
 
 	if (hyst != trip->hysteresis) {
-		trip->hysteresis = hyst;
+		WRITE_ONCE(trip->hysteresis, hyst);
 
 		thermal_zone_trip_updated(tz, trip);
 	}
@@ -194,7 +194,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
+	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.hysteresis));
 }
 
 static ssize_t
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 49e63db685172..b4e7411b2fe74 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -152,7 +152,7 @@ void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 	if (trip->temperature == temp)
 		return;
 
-	trip->temperature = temp;
+	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
 
 	if (temp == THERMAL_TEMP_INVALID) {
-- 
2.43.0


