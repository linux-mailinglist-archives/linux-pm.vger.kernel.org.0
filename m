Return-Path: <linux-pm+bounces-12457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D9956FFF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC8B1F22688
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9DA16C87B;
	Mon, 19 Aug 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="i5IMZkE4"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137D8287D;
	Mon, 19 Aug 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084100; cv=none; b=F2Lxll+8uwysFs/hyOwVPIUNhz2EDGKTv2uXFI288MEbshhiu+kNRu7ZqFFf76UZsCBL/KjyGXtp9uKb8JirURRVIotwsq8DWQ0iHxA4aoxQsvjHR88Vzbe3hkK/+QKGuzj2xEAzaXzhNa5Ayu46ws/YENCL7mBTeweOtc3XzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084100; c=relaxed/simple;
	bh=yOoHzqLUTBFUQBVMxFx/zG8qRaSxgH7mXRaklGOOfrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK+JcZDSC4swE1WgABqSXukjVK7BmewKBUypzBMzWLtAV3/uIPB/9EmAvQKH2rQWutAGPkOJMWdvcBXcuJDDPQXfNosmDSeHxoHBvqd0P+aoHGXufv200hFAYJ2+74m6EtPtHWJVP3PjapESQl3aphV658HIwr6dHzELYy6L2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=i5IMZkE4 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 85c0a09860a87d52; Mon, 19 Aug 2024 18:14:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0E10C73B5D9;
	Mon, 19 Aug 2024 18:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724084096;
	bh=yOoHzqLUTBFUQBVMxFx/zG8qRaSxgH7mXRaklGOOfrc=;
	h=From:Subject:Date;
	b=i5IMZkE4TczYo9eG/IYN06fUzyEnlUvg/6j3VN+qQMatuY6Kv2EgMwLvUsOl01/Co
	 dB4/pYsBfQqc2LMeMmbBpooWkHzgqYe7C1hxmVI8F4j369TuVdushgzPXaKo8RDYg3
	 FQaodTraOmk7ClNrjIXAJCxr76+m67IqdAgDcVjC0wAGkXSXrd0hmvcE+Iw2gwjekq
	 Ku/fzcar+wiMDMFfReZa8bwq2R6m86k8e5u+4sMLMFOoYHwqKDczXgOiOHQWT7rico
	 kuvRTc43ynuPJm86IKy9XBieFON5gvOvjB2iJkHpNyICl8iJ7+4iHjh1hHLDFd/Bse
	 Vgd/PlfAfhXmw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 04/14] thermal: sysfs: Use the dev argument in instance-related
 show/store
Date: Mon, 19 Aug 2024 17:56:15 +0200
Message-ID: <1987669.PYKUYFuaPT@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two sysfs show/store functions for attributes representing thermal
instances, trip_point_show() and weight_store(), retrieve the thermal
zone pointer from the instance object at hand, but they may also get
it from their dev argument, which is more consistent with what the
other thermal sysfs functions do, so make them do so.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes (previously [06/17])

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




