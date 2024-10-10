Return-Path: <linux-pm+bounces-15508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6599951E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB61C22E45
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA81EABA2;
	Thu, 10 Oct 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ucH3W9WC"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446C1C172A;
	Thu, 10 Oct 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598959; cv=none; b=DR8fZ0VAKHc5tYTD3z58hEh67jbDncRg/HTndtn5xjLIzRZRUE4dubytA8quk/C7XJj5DVE7Vu8xay3N+GyygMGIjKSFBgfJmpD1tfhn0XZGRWB+LpDvVzIQgjykfH+IE05LVSK3Tr9b/nl6yl4U3+CQg5Q/VO7ZkjbB+jv7FMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598959; c=relaxed/simple;
	bh=sbzkRocgHF+RLVRdsZm18wLCdz4OqurChzrAtJI9nk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzgewm2Kk4zgpLIXCNCh+WcXRXfV07X/WhHAei6e28gc3uapmgc13B1pWivmtBvy5CtGnPaG8rsauP7j7wDgwFqKQrBkSTxlSWkTIIVnpvV9/Jhb7hF6v0arxBJQZYSf6fzvAaQlmr6ryo24K7/v2HdoZ2pG/i+ZyDysX8Ehyt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ucH3W9WC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1f06392505035da9; Fri, 11 Oct 2024 00:22:25 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A49A169EF02;
	Fri, 11 Oct 2024 00:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598945;
	bh=sbzkRocgHF+RLVRdsZm18wLCdz4OqurChzrAtJI9nk4=;
	h=From:Subject:Date;
	b=ucH3W9WC3xecLxItzi8dYrRNGIC75szLlUwpFNHojI7dDujDpyDzbueWWMQdTHqNx
	 dzRojgqdSlglfTpP0ICIdWf8kkInWLNYlMYeW759w56fP2hMFQ9ltIKvAaYHy6WFSl
	 QkYTP6Jyqx4DWs10Xhvn6SFM6ztXYBWvsPbjJ1lFfMY3tQMOXWigtNW1QRpEBTs/8U
	 jcoQ92DEGE2T3pvHaRnjk4aVHxjlrutTZOZUKSu14otL48MStYrRaX9jzqUZoCEizN
	 5IdEgUtU/NHZoNyMFNtMXHRFnia6il4XieU5u9Z2NA+7vVesfKZkqbUgqG/zrn3dsI
	 23CHETi6jFv9Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 10/11] thermal: core: Separate thermal zone governor initialization
Date: Fri, 11 Oct 2024 00:20:56 +0200
Message-ID: <4408795.ejJDZkT8p0@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for a subsequent change that will switch over the thermal
core to using a mutex guard for managing thermal_governor_lock, move
the code running in thermal_zone_device_register_with_trips() under that
lock into a separate function called thermal_zone_init_governor().

While at it, drop a useless comment.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/2495577.jE0xQCEvom@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1343,6 +1343,25 @@ int thermal_zone_get_crit_temp(struct th
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
@@ -1407,7 +1426,6 @@ thermal_zone_device_register_with_trips(
 	struct thermal_trip_desc *td;
 	int id;
 	int result;
-	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
 		pr_err("No thermal zone type defined\n");
@@ -1505,21 +1523,9 @@ thermal_zone_device_register_with_trips(
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




