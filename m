Return-Path: <linux-pm+bounces-12452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E2956FE5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A97B286FBA
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A816C874;
	Mon, 19 Aug 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="abTHxC65"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9E8287D;
	Mon, 19 Aug 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083979; cv=none; b=FtTQ01o9FBZTqVziL+rutm1cfKuJTCMWFXi7pJ1zbd11a2UDAVgksHoiaYHUHORbU3OcSVvtzna21UeAFUlwll0ioIfr7CemrOFRx0q0zVARA9G3PE9FOpiSDPNLvzv/mXNjHVuOCS93EX/CXxcKHus42KUoDZoHiLXlODtrsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083979; c=relaxed/simple;
	bh=opnKoOemKF8dn1y+j+0t5VxBvo8rIgVyOiVcsuAwSWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fa3HnFIWbXjb1U663NkivWfIMKO/+8OkPG3S22bApZ6Fjd8KaMlEDUyisb26TfK/YOEgMq6ovtYlc0HDN6tEg35GO5wdFT7iAPHgd5Ude+IyZfy4F+Agq0NJQOgHmdbBHrvaZ3163hIlxrKdkgYR7Qdr6SBslRWSbRQWvnz8lEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=abTHxC65 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id af93debbe7a88a5d; Mon, 19 Aug 2024 18:12:49 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B1AF673B5D4;
	Mon, 19 Aug 2024 18:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724083969;
	bh=opnKoOemKF8dn1y+j+0t5VxBvo8rIgVyOiVcsuAwSWI=;
	h=From:Subject:Date;
	b=abTHxC65cOPvdoezatpbMEu3eKiRqRgu0YfaCnW0zOp0o1MfPLB5FU5OOXVUeRjQR
	 xSmb4hSvcnXihzYYNOK8uEeH07lwu677wO3SEZ1IYSmCsrKSiSa10IWvZ1fm0m98Gg
	 eBAPsu5MPt0naKfxemRp/ZtVUVp5BLwprtmoMWVZ/OktsyH3TYXyMXLI6Ncc0dDC5e
	 UxuhpljM5IxbMdkAdqm/VAXfkxFAjimdQXx+vWxD9FlzUQdlf9LUI0RaIliW6vIWue
	 4bzRLZ2mPvcMQ8DaF/rpSMq3fURV5uI6TKnMILbJWHjerPSN0tqsfIi6fqlmA83nLB
	 39kiCwvkRIVuQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 08/14] thermal: core: Unexport thermal_bind_cdev_to_trip() and
 thermal_unbind_cdev_from_trip()
Date: Mon, 19 Aug 2024 18:05:00 +0200
Message-ID: <3512161.QJadu78ljV@rjwysocki.net>
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

Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
are only called locally in the thermal core now, they can be static,
so change their definitions accordingly and drop their headers from
the global thermal header file.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Rebase after dropping patches [04-05/17] from the series

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |   10 ++++------
 include/linux/thermal.h        |    8 --------
 2 files changed, 4 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -773,7 +773,7 @@ struct thermal_zone_device *thermal_zone
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
+static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 				     const struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
@@ -877,7 +877,6 @@ free_mem:
 	kfree(dev);
 	return result;
 }
-EXPORT_SYMBOL_GPL(thermal_bind_cdev_to_trip);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip_index,
@@ -913,9 +912,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  const struct thermal_trip *trip,
-				  struct thermal_cooling_device *cdev)
+static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+					 const struct thermal_trip *trip,
+					 struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *pos, *next;
 
@@ -945,7 +944,6 @@ unbind:
 	kfree(pos);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
 
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 				       int trip_index,
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -247,18 +247,10 @@ const char *thermal_zone_device_type(str
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
-int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-			      const struct thermal_trip *trip,
-			      struct thermal_cooling_device *cdev,
-			      unsigned long upper, unsigned long lower,
-			      unsigned int weight);
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
 				     unsigned int);
-int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  const struct thermal_trip *trip,
-				  struct thermal_cooling_device *cdev);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,




