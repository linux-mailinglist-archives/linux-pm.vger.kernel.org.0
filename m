Return-Path: <linux-pm+bounces-12096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF594EF34
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC19B23B84
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0517D354;
	Mon, 12 Aug 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="A/Zth7Bl"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1D17C9E7;
	Mon, 12 Aug 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471857; cv=none; b=a4SrpaZJZ6xchPSh0Bin0ZJDcLhmIsMb6FoE635bigH3GA8e/0Sn7Fbtu2WMqL3/gjdplIP1UZTqR+hjS30WCZOcmWabVYwAOUuoeoieGzD6boXl2aanDwOnP57CY18D/ZIvK7dq9GmhMeV3m5nFQv//2tfiDhlp5L4pr2ReY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471857; c=relaxed/simple;
	bh=Vj11V9cPyKv8V73lV+OhKwvwLWxQ3B6nsPfi+nAIpfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEu0bDq9+TGw/yd0ZNn4mGyLImJcmkziKp5lJO97pDay0cGnX6eZwyDdyBPDoAgjb0Uhiyby9DH4LTGP+ZgxRMbp5+C9YH55nBDFjl9lgZ2/lrlH2buBwmV2r2PvppZ25ZXhvHxuq0Cj6kUEJfubQx7KAjqpfTv0IHx8S3bNACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=A/Zth7Bl reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 51762d4e74808ab9; Mon, 12 Aug 2024 16:10:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 964986F0D6A;
	Mon, 12 Aug 2024 16:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471854;
	bh=Vj11V9cPyKv8V73lV+OhKwvwLWxQ3B6nsPfi+nAIpfI=;
	h=From:Subject:Date;
	b=A/Zth7Bls97EUDsTtLzHZkkc2eB7Zrwi8WcVLHFy3vZThFV4FOcZ4YXV9Vfv/INIe
	 NJFVb680RNuP7n/IdJ4djl83lFbTXp/qXnK5MFdJHkkINuL8G2gyEZbpztGvtFiLsU
	 91XSHVsOyIWwB/ff5SeewzVi3sEacNJYZm4ZrpUI4IHjQgX0BRFymigS7T3KlhiUvC
	 ZPgMPI5RIrjrVmLB2X3CN7llqGpdkisUgB7928O/hzLdTUvpO9daj9w9lZq5c+vDv/
	 kZAIb0hVl2f3SaEGvKfyP04yrt4xGzSF6p2CLiymDDLIM5r1u22DSE+M3hhWXK3VRo
	 W85MgDVuFOI+g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 06/17] thermal: sysfs: Use the dev argument in instance-related
 show/store
Date: Mon, 12 Aug 2024 16:02:52 +0200
Message-ID: <9369885.rMLUfLXkoz@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two sysfs show/store functions for attributes representing thermal
instances, trip_point_show() and weight_store(), retrieve the thermal
zone pointer from the instance object at hand, but they may also get
it from their dev argument, which is more consistent with what the
other thermal sysfs functions do, so make them do so.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_sysfs.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -836,13 +836,12 @@ void thermal_cooling_device_stats_reinit
 ssize_t
 trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_instance *instance;
 
-	instance =
-	    container_of(attr, struct thermal_instance, attr);
+	instance = container_of(attr, struct thermal_instance, attr);
 
-	return sprintf(buf, "%d\n",
-		       thermal_zone_trip_id(instance->tz, instance->trip));
+	return sprintf(buf, "%d\n", thermal_zone_trip_id(tz, instance->trip));
 }
 
 ssize_t
@@ -858,6 +857,7 @@ weight_show(struct device *dev, struct d
 ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_instance *instance;
 	int ret, weight;
 
@@ -868,14 +868,13 @@ ssize_t weight_store(struct device *dev,
 	instance = container_of(attr, struct thermal_instance, weight_attr);
 
 	/* Don't race with governors using the 'weight' value */
-	mutex_lock(&instance->tz->lock);
+	mutex_lock(&tz->lock);
 
 	instance->weight = weight;
 
-	thermal_governor_update_tz(instance->tz,
-				   THERMAL_INSTANCE_WEIGHT_CHANGED);
+	thermal_governor_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
 
-	mutex_unlock(&instance->tz->lock);
+	mutex_unlock(&tz->lock);
 
 	return count;
 }




