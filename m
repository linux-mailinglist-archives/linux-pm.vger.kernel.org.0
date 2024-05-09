Return-Path: <linux-pm+bounces-7694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1B8C1549
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57192831EA
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E94E7F7DB;
	Thu,  9 May 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kUmRIt4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3ED653;
	Thu,  9 May 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282271; cv=none; b=HTk9RJiV/MUFu4ilKV03PBBmTRqE5x3D0oq7jeNsAe2PKg9HaUDXiwVzuHPGR+ESkV6zqbVVJDtoEEcsNB89C8Z0BSGgdZd6YmmA6bc96ra9gLA+EEHLJ+r68mLe+LpPdz2lFcZXBsHfms+WM820aSNPsvV7J0Knf44WgoNXnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282271; c=relaxed/simple;
	bh=TsOA66Gxd9P6ysQ1zUnV2UVgf3AWyGQEfUnpoMtH47U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTKPQjT/q+iuoegMYV1Feu/QN5LMxOQkqEvfwCaZxMnSfDXIZrndRmf/1SATTAeknptY0n8EUhYVb6DHeZ4Ub9CT0KJr1mAtFUeFrMeq6y+f1wLtIqxwph0SbPn++ktT1En8qEREpFV9T7Wy/oK79FqOqf8h7WjOUlpcSCp7TXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kUmRIt4R; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 99a7b61e84f11913; Thu, 9 May 2024 21:17:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CD22BA524E7;
	Thu,  9 May 2024 21:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282261;
	bh=TsOA66Gxd9P6ysQ1zUnV2UVgf3AWyGQEfUnpoMtH47U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUmRIt4RYlSxxlAIvKiABrMyj8MMmrFeSsDoBtXDcuTM4hnKpPy7I1+bGhny3Ih+x
	 BuOz+rwk29f6OEwKnel+pERJA1YLxNgpfvxlGzftmyOR+DuXpzb2X8NWx2saQ0qWcc
	 m54skSN48mTpP8Em6n6ewYryZlZ0UaTPFkEVkRzs7JrZrIsFPaCfhuB7un7ZXMA/lp
	 gQUhiJwz3F00hMzXrdqF8D+Zd+jmFAnINTD+U+CKwIL1ewsIjCbfLaqe0IsoPPSkht
	 HOPK05I4I2DDizL7UTUXnmvIGA/+0AMtI10hWkFgBzeEuB1zvrH18cXSG6jJrkRA2a
	 x7WBsWGq5nvPQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 7/7] thermal: trip: Use common set of trip type names
Date: Thu, 09 May 2024 21:17:25 +0200
Message-ID: <2272195.iZASKD2KPV@kreacher>
In-Reply-To: <12438864.O9o76ZdvQC@kreacher>
References: <12438864.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use the same set of trip type names in sysfs and in the thermal debug
code output.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h    |    2 ++
 drivers/thermal/thermal_debugfs.c |   10 +---------
 drivers/thermal/thermal_sysfs.c   |   13 +------------
 drivers/thermal/thermal_trip.c    |   15 +++++++++++++++
 4 files changed, 19 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -9,6 +9,21 @@
  */
 #include "thermal_core.h"
 
+static const char *trip_type_names[] = {
+	[THERMAL_TRIP_ACTIVE] = "active",
+	[THERMAL_TRIP_PASSIVE] = "passive",
+	[THERMAL_TRIP_HOT] = "hot",
+	[THERMAL_TRIP_CRITICAL] = "critical",
+};
+
+const char *thermal_trip_type_name(enum thermal_trip_type trip_type)
+{
+	if (trip_type < THERMAL_TRIP_ACTIVE || trip_type > THERMAL_TRIP_CRITICAL)
+		return "unknown";
+
+	return trip_type_names[trip_type];
+}
+
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data)
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -240,6 +240,8 @@ void thermal_governor_update_tz(struct t
 #define trip_to_trip_desc(__trip)	\
 	container_of(__trip, struct thermal_trip_desc, trip)
 
+const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
+
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -88,18 +88,7 @@ trip_point_type_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
-	switch (tz->trips[trip_id].trip.type) {
-	case THERMAL_TRIP_CRITICAL:
-		return sprintf(buf, "critical\n");
-	case THERMAL_TRIP_HOT:
-		return sprintf(buf, "hot\n");
-	case THERMAL_TRIP_PASSIVE:
-		return sprintf(buf, "passive\n");
-	case THERMAL_TRIP_ACTIVE:
-		return sprintf(buf, "active\n");
-	default:
-		return sprintf(buf, "unknown\n");
-	}
+	return sprintf(buf, "%s\n", thermal_trip_type_name(tz->trips[trip_id].trip.type));
 }
 
 static ssize_t
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -774,7 +774,6 @@ static int tze_seq_show(struct seq_file
 	struct thermal_zone_device *tz = thermal_dbg->tz_dbg.tz;
 	struct thermal_trip_desc *td;
 	struct tz_episode *tze;
-	const char *type;
 	u64 duration_ms;
 	int trip_id;
 	char c;
@@ -818,13 +817,6 @@ static int tze_seq_show(struct seq_file
 		if (trip_stats->min == INT_MAX)
 			continue;
 
-		if (trip->type == THERMAL_TRIP_PASSIVE)
-			type = "passive";
-		else if (trip->type == THERMAL_TRIP_ACTIVE)
-			type = "active";
-		else
-			type = "hot";
-
 		if (trip_stats->timestamp != KTIME_MAX) {
 			/* Mitigation in progress. */
 			ktime_t delta = ktime_sub(ktime_get(),
@@ -840,7 +832,7 @@ static int tze_seq_show(struct seq_file
 
 		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d |\n",
 			   4 , trip_id,
-			   8, type,
+			   8, thermal_trip_type_name(trip->type),
 			   9, trip->temperature,
 			   9, trip->hysteresis,
 			   c, 11, duration_ms,




