Return-Path: <linux-pm+bounces-39267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F209DCAAB4D
	for <lists+linux-pm@lfdr.de>; Sat, 06 Dec 2025 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3572930A0847
	for <lists+linux-pm@lfdr.de>; Sat,  6 Dec 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B226FD9A;
	Sat,  6 Dec 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mSzcXALd"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DA237713
	for <linux-pm@vger.kernel.org>; Sat,  6 Dec 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765043105; cv=none; b=WN7NxQQqX/RxON1qfSkkzctwm8MLotiMOZ6ZZiDETXcpkKIYc7VcrRWD7hXPXcNSbNl0Hou4Euumwar5VWTB1iyXtwdK2PImy8UJcgfeB+VvMi2s0nOVlx1ciJHf62poqVvs1P7vwpYFVeeriCnFxw+oPHRQxkM47RvsYXoLLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765043105; c=relaxed/simple;
	bh=qswf3Tb+Q9pb83Y7WJ37Ch6qQmgONgcUqch58+s2XMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epoXkouXraOFajhpgErN/dFNHxCL8A58CCxjhI+RgWo+1b0O8xD5/VliPIe3N/cmbfTPTfd0uWz6cG9oeyaPLN9Apx6mq3DDNIvYvVWpD6h9DLCOSr8rdceuYgDmWGgY98Mb5Oun2AAG2uFeA4u9MeEFhhQb/h9ebLTZttrJTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mSzcXALd; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765043091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pxZyHJEELq7EvWTolS5dAbDs7d83TO9QGKdDxI0rYC8=;
	b=mSzcXALdBFsgnErTPMEiPgVla8MkhvQ5ybJpfR7XM5v4ZyP5VWs0lMbJDBH5N22z1igr4m
	RTuX0JPrq0YQ/WYATUXmF0/5w1i+LOzuiHCy7lgTNxiDQs+GG2CcVZl6XauLZ26S4qEAeC
	XRGoY3HCnXWANEwtXhebEHm2pVzV/Y4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: core: Fix typo and indentation in comments
Date: Sat,  6 Dec 2025 18:42:45 +0100
Message-ID: <20251206174245.116391-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/tmperature/temperature/ and adjust the indentation of the @ops
parameter description to improve readability.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/thermal/thermal_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 90e7edf16a52..dc9f7416f7ff 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -500,7 +500,7 @@ void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 	WRITE_ONCE(trip->hysteresis, hyst);
 	thermal_notify_tz_trip_change(tz, trip);
 	/*
-	 * If the zone temperature is above or at the trip tmperature, the trip
+	 * If the zone temperature is above or at the trip temperature, the trip
 	 * is in the trips_reached list and its threshold is equal to its low
 	 * temperature.  It needs to stay in that list, but its threshold needs
 	 * to be updated and the list ordering may need to be restored.
@@ -1043,7 +1043,7 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
  * @np:		a pointer to a device tree node.
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
- * @ops:		standard thermal cooling devices callbacks.
+ * @ops:	standard thermal cooling devices callbacks.
  *
  * This interface function adds a new thermal cooling device (fan/processor/...)
  * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


