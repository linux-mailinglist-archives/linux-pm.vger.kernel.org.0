Return-Path: <linux-pm+bounces-9200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78452908EBC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F37CB296C9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3D16D9D7;
	Fri, 14 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VZJkEp42"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161415FA96;
	Fri, 14 Jun 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378804; cv=none; b=acIUPJ/zfILVQJrJiRpt+J7VVcFZi8mVr/9mTEvSyrD9gtmBMvxg/kpzsXqNPygVP/gUpvna8rFQuol4BZLT9K6vMwFZYsAcj1KRmxm2gbvdzvCZ3rEe7TSy9fYYI+fDoP/19zHyCXyxd3z+O6MGNri/4vP2xPndaUcMn6WXj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378804; c=relaxed/simple;
	bh=xkm7TOfE+0Lij82Nq9O/l46tHzduMTcUqYKjBJC6MeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiI4aLsCh0/2Xmv8mwluj3ve9yTpm7CDBfS/QqP2IE72JL4iUbOXXm8+9v+eUcX3wFi0fRf+Bcd97C0RtdAZMwJucWe50MROy0fgyVjPSRyxqN2Kx/pPfYBSLpIeRjzdVZFabsbswEFASRclLizESgAvs8h9oYI+NsT5Esj7meg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VZJkEp42 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 6ef55ecccd86ff32; Fri, 14 Jun 2024 17:26:34 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1FAF16A741D;
	Fri, 14 Jun 2024 17:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718378793;
	bh=xkm7TOfE+0Lij82Nq9O/l46tHzduMTcUqYKjBJC6MeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZJkEp42w9TC/S8Rmws36AZO7ucAbv4I8RhKoVaPLOX7BDIG+Mr9YTAypBQU4veyD
	 9WJjfoWId0GpByicz++c5PTi7NdE9lzFfMjMEXd9NpisXBUcBjNX4ltB9R0BGz5Wjh
	 9qrHh8aWQ06RXhvOiZamqWexjK6qG1Ka9LBsIjwy/usdSTu1LBIryaVf3vlKjmtVkc
	 1tcvw66mXV58JbHrCsWBmL1/E/d/T1G9WI3diB/AY+wMS/cpQjvGN8N5aZWkkA27+z
	 i5ai4+PJF7Tla2ZfyVO1TBauaYEwLlm4Dfyk0dN380RLv1yBZA+G9rBT/niano/afB
	 8ZeAcJq91hzfg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 1/2] thermal: core: Synchronize suspend-prepare and post-suspend
 actions
Date: Fri, 14 Jun 2024 17:22:25 +0200
Message-ID: <2202941.irdbgypaU6@kreacher>
In-Reply-To: <6070114.lOV4Wx5bFT@kreacher>
References: <6070114.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehsrhhi
 nhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 5a5efdaffda5 ("thermal: core: Resume thermal zones
asynchronously") it is theoretically possible that, if a system suspend
starts immediately after a system resume, thermal_zone_device_resume()
spawned by the thermal PM notifier for one of the thermal zones at the
end of the system resume will run after the PM thermal notifier for the
suspend-prepare action.  If that happens, tz->suspended set by the latter
will be reset by the former which may lead to unexpected consequences.

To avoid that race, synchronize thermal_zone_device_resume() with the
suspend-prepare thermal PM notifier with the help of additional bool
field and completion in struct thermal_zone_device.

Note that this also ensures running __thermal_zone_device_update() at
least once for each thermal zone between system resume and the following
system suspend in case it is needed to start thermal mitigation.

Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   21 +++++++++++++++++++++
 drivers/thermal/thermal_core.h |    4 ++++
 2 files changed, 25 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1406,6 +1406,7 @@ thermal_zone_device_register_with_trips(
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
 	init_completion(&tz->removal);
+	init_completion(&tz->resume);
 	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
 	if (id < 0) {
 		result = id;
@@ -1652,6 +1653,9 @@ static void thermal_zone_device_resume(s
 	thermal_zone_device_init(tz);
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	complete(&tz->resume);
+	tz->resuming = false;
+
 	mutex_unlock(&tz->lock);
 }
 
@@ -1669,6 +1673,20 @@ static int thermal_pm_notify(struct noti
 		list_for_each_entry(tz, &thermal_tz_list, node) {
 			mutex_lock(&tz->lock);
 
+			if (tz->resuming) {
+				/*
+				 * thermal_zone_device_resume() queued up for
+				 * this zone has not acquired the lock yet, so
+				 * release it to let the function run and wait
+				 * util it has done the work.
+				 */
+				mutex_unlock(&tz->lock);
+
+				wait_for_completion(&tz->resume);
+
+				mutex_lock(&tz->lock);
+			}
+
 			tz->suspended = true;
 
 			mutex_unlock(&tz->lock);
@@ -1686,6 +1704,9 @@ static int thermal_pm_notify(struct noti
 
 			cancel_delayed_work(&tz->poll_queue);
 
+			reinit_completion(&tz->resume);
+			tz->resuming = true;
+
 			/*
 			 * Replace the work function with the resume one, which
 			 * will restore the original work function and schedule
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -55,6 +55,7 @@ struct thermal_governor {
  * @type:	the thermal zone device type
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
+ * @resume:	resume completion
  * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
  * @trip_type_attrs:	attributes for trip points for sysfs: trip type
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
@@ -89,6 +90,7 @@ struct thermal_governor {
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
  * @suspended: thermal zone suspend indicator
+ * @resuming:	indicates whether or not thermal zone resume is in progress
  * @trips:	array of struct thermal_trip objects
  */
 struct thermal_zone_device {
@@ -96,6 +98,7 @@ struct thermal_zone_device {
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
 	struct completion removal;
+	struct completion resume;
 	struct attribute_group trips_attribute_group;
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
@@ -123,6 +126,7 @@ struct thermal_zone_device {
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
 	bool suspended;
+	bool resuming;
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif




