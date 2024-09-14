Return-Path: <linux-pm+bounces-14260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B5979012
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17E62855D8
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5961CEE8E;
	Sat, 14 Sep 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BMtcHzQi"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CB2BB09;
	Sat, 14 Sep 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311064; cv=none; b=jeXOkaeg0ao1v0UElqW98ghXeE4Awg8TCMIZiClu8o+svllMjAlSN2Qibimw+fo/9T2ysJZYmnmnXk25VdoOV1HQigLZGensP/qJ80eQONGxakk/NJ7mKFwYQO8OesdRDUHAixb9ILKqi0KF95QJ1T47XBEl/OYJJJ2cRgAi3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311064; c=relaxed/simple;
	bh=mkycwVK0EqE+tg/RGLbOtF4efoV6gUkcxA6iWq166NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+KUwPTx4eoaTJdYuSIPMff6w0+d4fE7i9OTZ8BR0YOOS5PBBpblME688KBfpZt/TEwTNfFSF3IVOsjfKQhdqbMsgl25SYXTvaf8TNenGsMxhKTqHbsLA7X1qUZh16Cu3lHF5vk+2cjAoYB3Nv93lKnSObqSzqZpT53AB6eLUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BMtcHzQi reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c4b8d7d304967b42; Sat, 14 Sep 2024 12:50:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3FC0E8532AE;
	Sat, 14 Sep 2024 12:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311053;
	bh=mkycwVK0EqE+tg/RGLbOtF4efoV6gUkcxA6iWq166NE=;
	h=From:Subject:Date;
	b=BMtcHzQi27HxFB4ZS9f55MPnMMc3/si0ttKknjw6iZkVU3Rf4O4g56oyT8pleAfq4
	 sRFpjqIDx+t942KJ1nlFSAVd8lm5CCbLSJrhhoZ2aCadCxzUFGqiy/uQ/JNtRbVzUp
	 9ZMjnX4DZNe5s7NhuO+egs/D3v75f6BnQy3nSjK1TJLtwA6YMxkQ1fKcOcq+yM91RK
	 9VE31TSzqPLoc/gKb39HUwJww1W+Y73Nkm1VfMu4oC2NNJhPnJ6oA0LnkeT1Tk6vRh
	 Sdj7dmkuBdtT4KfyaZzcIkvdRfkvQkIodbgO717xowrMOHvO8WWQC5jczWCChRW25h
	 bZLPM+uo53cxg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 19/20] thermal: core: Separate thermal zone governor
 initialization
Date: Sat, 14 Sep 2024 12:49:17 +0200
Message-ID: <2495577.jE0xQCEvom@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for a subsequent change that will switch over the thermal
core to using a mutex guard for managing thermal_governor_lock, move
the code running in thermal_zone_device_register_with_trips() under that
lock into a separate function called thermal_zone_init_governor().

While at it, drop a useless comment.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1342,6 +1342,25 @@ int thermal_zone_get_crit_temp(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
+static int thermal_zone_init_governor(struct thermal_zone_device *tz)
+{
+	struct thermal_governor *governor;
+	int ret;
+
+	mutex_lock(&thermal_governor_lock);
+
+	if (tz->tzp)
+		governor = __find_governor(tz->tzp->governor_name);
+	else
+		governor = def_governor;
+
+	ret = thermal_set_governor(tz, governor);
+
+	mutex_unlock(&thermal_governor_lock);
+
+	return ret;
+}
+
 static void thermal_zone_init_complete(struct thermal_zone_device *tz)
 {
 	struct thermal_cooling_device *cdev;
@@ -1406,7 +1425,6 @@ thermal_zone_device_register_with_trips(
 	struct thermal_trip_desc *td;
 	int id;
 	int result;
-	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
 		pr_err("No thermal zone type defined\n");
@@ -1502,21 +1520,9 @@ thermal_zone_device_register_with_trips(
 	if (result)
 		goto release_device;
 
-	/* Update 'this' zone's governor information */
-	mutex_lock(&thermal_governor_lock);
-
-	if (tz->tzp)
-		governor = __find_governor(tz->tzp->governor_name);
-	else
-		governor = def_governor;
-
-	result = thermal_set_governor(tz, governor);
-	if (result) {
-		mutex_unlock(&thermal_governor_lock);
+	result = thermal_zone_init_governor(tz);
+	if (result)
 		goto unregister;
-	}
-
-	mutex_unlock(&thermal_governor_lock);
 
 	if (!tz->tzp || !tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);




