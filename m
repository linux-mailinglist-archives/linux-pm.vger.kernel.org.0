Return-Path: <linux-pm+bounces-12092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744AB94EF29
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E973D1F223D5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D317D8A3;
	Mon, 12 Aug 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="q/vTtReP"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E317D354;
	Mon, 12 Aug 2024 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471773; cv=none; b=nvnZVLO+uSENP7DjYTSqoSUj97fmaCIE8QxF4dV5wp2e72pWDHjdFrN014g4ikKb+EgfzUct0LjeQuVE8hoKZaUlSYc4GZuDoakbYt3w0E+ljwg8cwgsFA8v0jrsOcpVGm2k/o7d+0oRlosfhS5ZEiW0PVNiCWg6nKRGvFxyW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471773; c=relaxed/simple;
	bh=8LwGkz5sxH7Hm1lIM1/2jbKypKgpB+kFFq4SU3csxz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pO1XiSEJ9baDapbyCcm97EEPYfh/gNPxbqlA0XO4tRgoMSKjJgRPoEmjj3Xs8YXdTcLjJesrgOFL6gw5o7demcbp5yvs0G/9781UoMXuFfGQASB4lH/Nwf9l8/AWIbQEuJaS/SiPHSW/MaP1eRBzcMsmYm1R+IRiFt5LfvwwBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=q/vTtReP reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b9a1835cdea4ecd6; Mon, 12 Aug 2024 16:09:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 873526F0D6A;
	Mon, 12 Aug 2024 16:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471770;
	bh=8LwGkz5sxH7Hm1lIM1/2jbKypKgpB+kFFq4SU3csxz4=;
	h=From:Subject:Date;
	b=q/vTtRePrIWDkYutbP+Xa30ovycTa4nMP2xLzw0ReJweIsL5iZrqO1oswQIsJquBK
	 igXfckX1deQC824yq9szOePzXYZHT583XHuZnJTVC8CIJx5KK3qAcdHgLzyqP8Z4pt
	 5ly7J25IMCWM2lJPOxjr4Mm55z+RPXo8cjBGAjU9Cn6LuHuMkEQ0c/LPvDHccPIdKv
	 +yH1uuDWxCDnkXicNPCjn/q18oWsUrDLXIVck33Jn8PvDPe2rW/XV3xEv40bSL5M3B
	 k57LQN2T9s8eD36RmXlgjmQg8UEBuSw3CfJ9EPwVua9PkyK/oMStApTej1p6KsO/XW
	 EL9e+K6TSIJyg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 10/17] thermal: core: Unexport thermal_bind_cdev_to_trip() and
 thermal_unbind_cdev_from_trip()
Date: Mon, 12 Aug 2024 16:09:08 +0200
Message-ID: <2120480.KlZ2vcFHjT@rjwysocki.net>
In-Reply-To: <114901234.nniJfEyVGO@rjwysocki.net>
References: <114901234.nniJfEyVGO@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
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

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |   10 ++++------
 include/linux/thermal.h        |    8 --------
 2 files changed, 4 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -777,7 +777,7 @@ struct thermal_zone_device *thermal_zone
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
+static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
@@ -883,7 +883,6 @@ free_mem:
 	kfree(dev);
 	return result;
 }
-EXPORT_SYMBOL_GPL(thermal_bind_cdev_to_trip);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip_index,
@@ -919,9 +918,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  struct thermal_trip *trip,
-				  struct thermal_cooling_device *cdev)
+static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+					 struct thermal_trip *trip,
+					 struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
@@ -954,7 +953,6 @@ free:
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
@@ -246,18 +246,10 @@ const char *thermal_zone_device_type(str
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
-int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-			      struct thermal_trip *trip,
-			      struct thermal_cooling_device *cdev,
-			      unsigned long upper, unsigned long lower,
-			      unsigned int weight);
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
 				     unsigned int);
-int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  struct thermal_trip *trip,
-				  struct thermal_cooling_device *cdev);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,




