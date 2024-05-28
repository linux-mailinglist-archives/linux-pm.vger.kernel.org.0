Return-Path: <linux-pm+bounces-8262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D658D2203
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6C2B244EC
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14414173352;
	Tue, 28 May 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FC+N34PE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9A172BD5;
	Tue, 28 May 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915266; cv=none; b=iFL8PJvU4iKlkE1HizyKel7zFGYOthmlQwaGgUebYoaeiYtk6tIIbh9NzedXTKlUniIUDeNonOPYhtVHJMAsDVtH5qR8GqcBmWiWrVt+9yNaTkrA0XyfFEoR94erqx+yyJQSrwCE4yxDay8PWCa5vEcXQvHeqo50XhXbW1t0rCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915266; c=relaxed/simple;
	bh=8XIYogP3QOocTXaYFjvA1ITRN9o8M4WWA9w3jjM1ifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isixggLuW7IOUck4MYt80p5HGPUJV9rYWMC8TY4itXerBmEl5h2XRvLp+q6I844M1zEhL6yDkfEH6oW7Q6jP2H/OgXOnaiPQ1W7R1BpVuJ8oYKr6ir/KuSafsJAz8m7ruesEhNop2qkNJUnGgGGnDe61qj0emHSWbtodLWVvjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FC+N34PE reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 5c2a131d28357f4b; Tue, 28 May 2024 18:54:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5C7E66A5036;
	Tue, 28 May 2024 18:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716915261;
	bh=8XIYogP3QOocTXaYFjvA1ITRN9o8M4WWA9w3jjM1ifQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FC+N34PEHvn0DUdSE9pceaXChjVgRnrzzFHpKNiuWrNjoQS8VDUnUAZ2AvV/lbFO4
	 c20/SUjPmxj/jFGmqgKdDQ1OOJrk/olhC2lrLAFzRbmg+64NKHHUgCCi3URM9XR760
	 OFrMW2WnEIce8NbaJjEMJ8rp80Ezyi6uaTTcJeA9d1z69DE7FkzbjxqiMiFbpuRfdY
	 V0iZuUiXvsim/B0YzItGd7eNFb5nkdyKAE+P9GlP8Nbe58iUQq+i6eec+LDf8sjkf6
	 blcXcHxMAr3Wl+ywMLFDERyXIFDwWuG56VSQ10a7R94u6ktu25aJYgprdYDKY/khJP
	 MXxbnHBpZbPuA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 3/5] thermal: trip: Use READ_ONCE() for lockless access to trip
 properties
Date: Tue, 28 May 2024 18:52:13 +0200
Message-ID: <1902136.tdWV9SEqCh@kreacher>
In-Reply-To: <12458899.O9o76ZdvQC@kreacher>
References: <12458899.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When accessing trip temperature and hysteresis without locking, it is
better to use READ_ONCE() to prevent compiler optimizations possibly
affecting the read from being applied.

Of course, for the READ_ONCE() to be effective, WRITE_ONCE() needs to
be used when updating their values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_sysfs.c |    6 +++---
 drivers/thermal/thermal_trip.c  |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -139,7 +139,7 @@ trip_point_temp_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
+	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.temperature));
 }
 
 static ssize_t
@@ -163,7 +163,7 @@ trip_point_hyst_store(struct device *dev
 	trip = &tz->trips[trip_id].trip;
 
 	if (hyst != trip->hysteresis) {
-		trip->hysteresis = hyst;
+		WRITE_ONCE(trip->hysteresis, hyst);
 
 		thermal_zone_trip_updated(tz, trip);
 	}
@@ -183,7 +183,7 @@ trip_point_hyst_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
+	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.hysteresis));
 }
 
 static ssize_t
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -161,7 +161,7 @@ void thermal_zone_set_trip_temp(struct t
 	if (trip->temperature == temp)
 		return;
 
-	trip->temperature = temp;
+	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
 
 	if (temp == THERMAL_TEMP_INVALID) {




