Return-Path: <linux-pm+bounces-12160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8BB9507A4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB7F1C20E9F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1FA19D8BD;
	Tue, 13 Aug 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="D/epZo6t"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDA17C7DA;
	Tue, 13 Aug 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559453; cv=none; b=Qh8TJrng8u0/Pw1iwZK4+TJZ1228aoX5wOyOIuBS/rWZErL8iDiwedJ4NqSKO0Z4WQg5LixJvYSp1AwMkb0Y1F8knlsmRBDwvofCburZWU1SXlyYy0xbI3H4l/pFFJ24bXdVa4iV+naRFmcpU8v29ZmzGtdtHiB8jasZGSZJK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559453; c=relaxed/simple;
	bh=iubmN9bnmkGj0va0jRwRvC5tc8Z0ZasKGs9/yKI9A5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkjsZmsaQwGYKSASRlLHk/vI0ZkX99oC/0OQnh3WsqpN1U43xjIl9VOMT+agMFkqr5WgkO0O7I+GwLao6t1QT6kEWHVV0VXq2W1l0aMNaJMQf+r+0wpfRvE6ZEgY2IqNqsmX2AcltMdhVxJkNdY1H5DRvrcj9Ut8UcVPei68AYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=D/epZo6t; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9160ae81a290a80e; Tue, 13 Aug 2024 16:30:49 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1211C6A89D1;
	Tue, 13 Aug 2024 16:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723559449;
	bh=iubmN9bnmkGj0va0jRwRvC5tc8Z0ZasKGs9/yKI9A5Q=;
	h=From:Subject:Date;
	b=D/epZo6tvdQVeHLEXnX4WrJTTQIrDBXfy7jARSkxkOTUEVmguEh+kv2tPp06Jo/X9
	 VPF+XHbjDgBuSzCZyl1cSam4iY/ZxAc/tEkb8oguN9Ld0RRUkIfgwsLoYiv8dYcvFG
	 Z/HAe5q6O1mjPqfSvuurK0idBTcgqerCwu88yidJK5JbiA70hR800anGzHZd/OtGKP
	 BU/zZxcqHgWwmu3NzmJxeU+fJO/+QfqDTgkC8BY5K3KgQN2gp6Aq19gqUk/q0IJ7qx
	 ZmqKpNnk4dMk/dn/Tg1hw9F0j2P72lXQghSv8hU61S8J+FHnSnX3OeYrSgcRj0N7qs
	 Wq2H+jkMQiDeg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject: [PATCH v1 2/4] thermal: gov_bang_bang: Split bang_bang_control()
Date: Tue, 13 Aug 2024 16:26:42 +0200
Message-ID: <3313587.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <1903691.tdWV9SEqCh@rjwysocki.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohep
 uggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhesphhiihgvrdhnvght
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the setting of the thermal instance target state from
bang_bang_control() into a separate function that will be also called
in a different place going forward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   42 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -13,6 +13,27 @@
 
 #include "thermal_core.h"
 
+static void bang_bang_set_instance_target(struct thermal_instance *instance,
+					  unsigned int target)
+{
+	if (instance->target != 0 && instance->target != 1 &&
+	    instance->target != THERMAL_NO_TARGET)
+		pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
+			 instance->target, instance->name);
+
+	/*
+	 * Enable the fan when the trip is crossed on the way up and disable it
+	 * when the trip is crossed on the way down.
+	 */
+	instance->target = target;
+
+	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
+
+	mutex_lock(&instance->cdev->lock);
+	__thermal_cdev_update(instance->cdev);
+	mutex_unlock(&instance->cdev->lock);
+}
+
 /**
  * bang_bang_control - controls devices associated with the given zone
  * @tz: thermal_zone_device
@@ -54,25 +75,8 @@ static void bang_bang_control(struct the
 		tz->temperature, trip->hysteresis);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
-		if (instance->target != 0 && instance->target != 1 &&
-		    instance->target != THERMAL_NO_TARGET)
-			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
-				 instance->target, instance->name);
-
-		/*
-		 * Enable the fan when the trip is crossed on the way up and
-		 * disable it when the trip is crossed on the way down.
-		 */
-		instance->target = crossed_up;
-
-		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
-
-		mutex_lock(&instance->cdev->lock);
-		__thermal_cdev_update(instance->cdev);
-		mutex_unlock(&instance->cdev->lock);
+		if (instance->trip == trip)
+			bang_bang_set_instance_target(instance, crossed_up);
 	}
 }
 




