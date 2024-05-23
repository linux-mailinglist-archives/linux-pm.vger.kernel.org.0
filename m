Return-Path: <linux-pm+bounces-8083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FE8CD811
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763601C20C25
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EBB20335;
	Thu, 23 May 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="X6VZI3uW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09870111AA;
	Thu, 23 May 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480323; cv=none; b=XKv0GvvXlz/vb8NSroOA1Va8DcxHXGoqmDKgYuTXZ3DjjHo1Nui609pKdZnJenjS7uFZJT36lCdR4lbOo2YYFVqAdsnzQqD5gdcJJThtzSy1F3UWUlq9mcvWK9ymXKsfNl+XGGNV0EWz49FR1cRfRdmeqUGnpm8mBe9sWvi1zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480323; c=relaxed/simple;
	bh=aHU0Dj74soaJ/vBUBHdYftzV9Ctsq41ZYO7C2uCE3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udGS9guhGu7Y11yMGJJySfqv8bXfdX0UBUass/Yb9JQHEBCsuiUCUpfcelE0kTG2J4zyr2ge0VZTGFFksGoUI/qyNcCu+nqrM2hpk3LhCPlPeVR4ncvCYrZ20Gm0igFYhfB92svlUASIZw3eU4Bb/NjAwidGnX86k1xTwC4d2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=X6VZI3uW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 90909aeb67f4c744; Thu, 23 May 2024 18:05:13 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9677A6A4927;
	Thu, 23 May 2024 18:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716480313;
	bh=aHU0Dj74soaJ/vBUBHdYftzV9Ctsq41ZYO7C2uCE3fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6VZI3uW3KkuNGnes948TD1SpHO7Sjsdnq4V4wRY/D3c/aUhL/qOdRkKxi7+znvM5
	 2E1RZROH5sG7d/gltmh2RdLr/eWaKixs9kHiAJLP2tamKMi6rHEryMct5T1J/5LxLO
	 LYg8wbWGPy6U++6YcZju4lAZE8/3kK8sP2PD17avc9Ecqwt6sNH6LhmwCoPlOV/Wsy
	 NG8ym/c/cdab3DimUsSOZYsvFFpfwfQBLhIt7q5blTLCg7VkYF6w6Nr71K7tHU/0Jt
	 GJbis8l9C+RAhjWojEGkEOGPITek2FmA1kTB3eyF2Agf74/+zdzPVNBX8Kf2HwoCRW
	 EBn8aC9N7//KA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 1/4] thermal/debugfs: Print initial trip temperature and hysteresis
 in tze_seq_show()
Date: Thu, 23 May 2024 17:57:21 +0200
Message-ID: <4918963.31r3eYUQgx@kreacher>
In-Reply-To: <12438941.O9o76ZdvQC@kreacher>
References: <12438941.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The temperature and hysteresis of a trip point may change during a
mitigation episode it is involved in (it may even become invalid
altogether), so in order to avoid possible confusion related to that,
store the temperature and hysteresis of trip points at the time they
are crossed on the way up and print those values instead of their
current temperature and hysteresis.

Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -91,6 +91,8 @@ struct cdev_record {
  *
  * @timestamp: the trip crossing timestamp
  * @duration: total time when the zone temperature was above the trip point
+ * @trip_temp: trip temperature at mitigation start
+ * @trip_hyst: trip hysteresis at mitigation start
  * @count: the number of times the zone temperature was above the trip point
  * @max: maximum recorded temperature above the trip point
  * @min: minimum recorded temperature above the trip point
@@ -99,6 +101,8 @@ struct cdev_record {
 struct trip_stats {
 	ktime_t timestamp;
 	ktime_t duration;
+	int trip_temp;
+	int trip_hyst;
 	int count;
 	int max;
 	int min;
@@ -574,6 +581,7 @@ void thermal_debug_tz_trip_up(struct the
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	ktime_t now = ktime_get();
+	struct trip_stats *trip_stats;
 
 	if (!thermal_dbg)
 		return;
@@ -639,7 +647,10 @@ void thermal_debug_tz_trip_up(struct the
 	tz_dbg->trips_crossed[tz_dbg->nr_trips++] = trip_id;
 
 	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
-	tze->trip_stats[trip_id].timestamp = now;
+	trip_stats = &tze->trip_stats[trip_id];
+	trip_stats->trip_temp = trip->temperature;
+	trip_stats->trip_hyst = trip->hysteresis;
+	trip_stats->timestamp = now;
 
 unlock:
 	mutex_unlock(&thermal_dbg->lock);
@@ -836,8 +847,8 @@ static int tze_seq_show(struct seq_file
 		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d | %*d |\n",
 			   4 , trip_id,
 			   8, type,
-			   9, trip->temperature,
-			   9, trip->hysteresis,
+			   9, trip_stats->trip_temp,
+			   9, trip_stats->trip_hyst,
 			   c, 10, duration_ms,
 			   9, trip_stats->avg,
 			   9, trip_stats->min,




