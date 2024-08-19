Return-Path: <linux-pm+bounces-12453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D1956FE7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6744C1C22CA4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D62171E43;
	Mon, 19 Aug 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hxLRArNu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CA13B5AF;
	Mon, 19 Aug 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083980; cv=none; b=sm1cknB20NY3SShsTfmlAuF2ZwtLhzKRk+F2BZNodv3nNMklzwbzlhVZWB79jX60NsY0j6JTs17bA6WqO+TCslQn9byTTS40pgBanwVFCOuzqUJSBwI+qj65nBjQBpOAlCZPElWQpvrNNYOn1Kuwvl8Qcy7xXoW9JrfsOIoWTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083980; c=relaxed/simple;
	bh=Zb6109j0Bj3H4tOwPJxMq23sSAYxZGF9FEvKaHyjcAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo9dcX405wEMNWOOxFe+XW1fj+wxQbXDrmkPTrtHjOWK1b7BPxaaliu4skwgLqLXzMs2gbVRjxozUsgxWwlO6ectIpja67PFA4lthUxigG0ONtOKPg/Nay+4IZ0ZPNrlQmm+wj9A63NGQ+5CYvZYKo4hgNv/g7tfmNE+VdFBWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hxLRArNu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 506cac52ca7c0934; Mon, 19 Aug 2024 18:12:50 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B153773B5D4;
	Mon, 19 Aug 2024 18:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724083970;
	bh=Zb6109j0Bj3H4tOwPJxMq23sSAYxZGF9FEvKaHyjcAg=;
	h=From:Subject:Date;
	b=hxLRArNugnPTs0sA2YHnYp722sz0QoJEgNh/TQU3zVwobZlMTygmRRwxnENqhMRyC
	 uKSE7rAY5y4KbFoqwnPL8tJwx2zwTZtjJ0XJ5uWSRTvX1fLK0kn4ErOQfelsDWa0Zh
	 bNCxTHg2/iB0M85nQGD4NqYlS88oCIFo65l4UgTzLTV6GgVWJZNyeDbcGgP6yr36bH
	 sZXO8vdCP6OPMPRfDTH61ncNieaVTZm1oXQ7Xj8+Ik+jlGzcEt+Lz5wy+3HtqMheDD
	 JpV/RkeP9gDusQgic3izBRyrFGMhNOlFDajSInoFWS9C3eRiZOOapjaCRIzQM6uR/1
	 wdmKCCGdM14KA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 07/14] thermal: ACPI: Use the .should_bind() thermal zone callback
Date: Mon, 19 Aug 2024 18:02:44 +0200
Message-ID: <1812827.VLH7GnMWUR@rjwysocki.net>
In-Reply-To: <2205737.irdbgypaU6@rjwysocki.net>
References: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the ACPI thermal zone driver use the .should_bind() thermal zone
callback to provide the thermal core with the information on whether or
not to bind the given cooling device to the given trip point in the
given thermal zone.  If it returns 'true', the thermal core will bind
the cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

This replaces the .bind() and .unbind() thermal zone callbacks which
allows the code to be simplified quite significantly while providing
the same functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes (previously [09/17])

This patch only depends on the previous one introducing the .should_bind()
thermal zone callback.

---
 drivers/acpi/thermal.c |   64 ++++++-------------------------------------------
 1 file changed, 9 insertions(+), 55 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -558,77 +558,31 @@ static void acpi_thermal_zone_device_cri
 	thermal_zone_device_critical(thermal);
 }
 
-struct acpi_thermal_bind_data {
-	struct thermal_zone_device *thermal;
-	struct thermal_cooling_device *cdev;
-	bool bind;
-};
-
-static int bind_unbind_cdev_cb(struct thermal_trip *trip, void *arg)
+static bool acpi_thermal_should_bind_cdev(struct thermal_zone_device *thermal,
+					  const struct thermal_trip *trip,
+					  struct thermal_cooling_device *cdev,
+					  struct cooling_spec *c)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
-	struct acpi_thermal_bind_data *bd = arg;
-	struct thermal_zone_device *thermal = bd->thermal;
-	struct thermal_cooling_device *cdev = bd->cdev;
 	struct acpi_device *cdev_adev = cdev->devdata;
 	int i;
 
 	/* Skip critical and hot trips. */
 	if (!acpi_trip)
-		return 0;
+		return false;
 
 	for (i = 0; i < acpi_trip->devices.count; i++) {
 		acpi_handle handle = acpi_trip->devices.handles[i];
-		struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
-
-		if (adev != cdev_adev)
-			continue;
 
-		if (bd->bind) {
-			int ret;
-
-			ret = thermal_bind_cdev_to_trip(thermal, trip, cdev,
-							THERMAL_NO_LIMIT,
-							THERMAL_NO_LIMIT,
-							THERMAL_WEIGHT_DEFAULT);
-			if (ret)
-				return ret;
-		} else {
-			thermal_unbind_cdev_from_trip(thermal, trip, cdev);
-		}
+		if (acpi_fetch_acpi_dev(handle) == cdev_adev)
+			return true;
 	}
 
-	return 0;
-}
-
-static int acpi_thermal_bind_unbind_cdev(struct thermal_zone_device *thermal,
-					 struct thermal_cooling_device *cdev,
-					 bool bind)
-{
-	struct acpi_thermal_bind_data bd = {
-		.thermal = thermal, .cdev = cdev, .bind = bind
-	};
-
-	return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &bd);
-}
-
-static int
-acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
-				 struct thermal_cooling_device *cdev)
-{
-	return acpi_thermal_bind_unbind_cdev(thermal, cdev, true);
-}
-
-static int
-acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
-				   struct thermal_cooling_device *cdev)
-{
-	return acpi_thermal_bind_unbind_cdev(thermal, cdev, false);
+	return false;
 }
 
 static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
-	.bind = acpi_thermal_bind_cooling_device,
-	.unbind	= acpi_thermal_unbind_cooling_device,
+	.should_bind = acpi_thermal_should_bind_cdev,
 	.get_temp = thermal_get_temp,
 	.get_trend = thermal_get_trend,
 	.hot = acpi_thermal_zone_device_hot,




