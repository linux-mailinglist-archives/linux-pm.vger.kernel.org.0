Return-Path: <linux-pm+bounces-7831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C352C8C4F73
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F096B20FF7
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1E13FD7E;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UPHX7Vni";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Am66dfrp"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C01272D5
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=YPdcPza35NVVAW0tgQL6pVtD4JoUavqjh4FL076WlKXn0RQAfOizs9eBl5jARQIpraIQMfvro8r07KQabdN0w7O5cvyq5PQzOYEXpZN28P7FZCyTfpSeaOuke6s6BO0vT8w/Hj3kJIGILOuz6jxOPGSgI1o5IKhA97WW+OVSV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=jsVcDf+G0pewYbOrdfH58YV/t/34DimW3RnJkNEkOLw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aklPXHXrUHOd9IkiGHwKCcmNgkpUxYtXmRP/7Y7Zy4vQjRXcspW+al/d2HzTHchHnYfT+E/edxgLjP6v2dmZ4P/HdcnRC4eHVgTyOJAZljEYWKQZ33hKA7SGuMv81eWu+OW8cLzHB1lArGFo4ChbU2cu/2S/lOGRalSh9nFYuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UPHX7Vni; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Am66dfrp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CN931T3nCMMbnTCNz2RzXKaVCj9yvep8hHtXhY+xxhI=;
	b=UPHX7VniVvafa7U8NsDRpbo7YRAJ/RBJvma59rmo4QfJidBMh+FIFBkMtiolNWxwY+0ZFe
	dOCVd57ot0kxdyrliwFssnmpuYC46oPpcjvkl6+xNNIR1rEmLV/RtdYvhFjI2EV/Qbiqi/
	S3MeBc8RZ1g9MJPGPS9o4nujseKqsfsbkNTXIU/1KOkY8XawTxO5kbDeoUxpIy4jMZS0aZ
	spGUVW5a+6fWZaiZTR9Q2Yqfjp9Q7uOGhyVzfNQuOfzKIkwF7B9WgzgxNCHEd8xpBAKVJX
	wgqoY4TGy+09p5HPDBlHGk4kSiJpvmSaa80puJP5vsnbm738QUDzUtJtnRUVZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CN931T3nCMMbnTCNz2RzXKaVCj9yvep8hHtXhY+xxhI=;
	b=Am66dfrpq3LtvyW09gUTmaGVbqOSHg4t0PV/kxHWanQ4w3XxDf080D+3aood5HQlayUpSi
	M91XNo6GiN+fgKBg==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: core: Rewrite comments in
 handle_thermal_trip()
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 rui.zhang@intel.com, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193670.10875.3180482624461107163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     f99c1b87a902fcc81df569f2ff939d47880cd741
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f99c1b87a902fcc81df569f2ff939d47880cd741
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Tue, 02 Apr 2024 20:59:01 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 16:01:20 +02:00

thermal: core: Rewrite comments in handle_thermal_trip()

Make the comments regarding trip crossing and threshold updates in
handle_thermal_trip() slightly more clear.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fc6ff0a..c4bc797 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -368,6 +368,13 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 	if (trip->temperature == THERMAL_TEMP_INVALID)
 		return;
 
+	/*
+	 * If the trip temperature or hysteresis has been updated recently,
+	 * the threshold needs to be computed again using the new values.
+	 * However, its initial value still reflects the old ones and that
+	 * is what needs to be compared with the previous zone temperature
+	 * to decide which action to take.
+	 */
 	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
 		/* Initialization. */
 		td->threshold = trip->temperature;
@@ -375,11 +382,9 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 			td->threshold -= trip->hysteresis;
 	} else if (tz->last_temperature < td->threshold) {
 		/*
-		 * The trip threshold is equal to the trip temperature, unless
-		 * the latter has changed in the meantime.  In either case,
-		 * the trip is crossed if the current zone temperature is at
-		 * least equal to its temperature, but otherwise ensure that
-		 * the threshold and the trip temperature will be equal.
+		 * There is no mitigation under way, so it needs to be started
+		 * if the zone temperature exceeds the trip one.  The new
+		 * threshold is then set to the low temperature of the trip.
 		 */
 		if (tz->temperature >= trip->temperature) {
 			thermal_notify_tz_trip_up(tz, trip);
@@ -390,14 +395,9 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 		}
 	} else {
 		/*
-		 * The previous zone temperature was above or equal to the trip
-		 * threshold, which would be equal to the "low temperature" of
-		 * the trip (its temperature minus its hysteresis), unless the
-		 * trip temperature or hysteresis had changed.  In either case,
-		 * the trip is crossed if the current zone temperature is below
-		 * the low temperature of the trip, but otherwise ensure that
-		 * the trip threshold will be equal to the low temperature of
-		 * the trip.
+		 * Mitigation is under way, so it needs to stop if the zone
+		 * temperature falls below the low temperature of the trip.
+		 * In that case, the trip temperature becomes the new threshold.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);

