Return-Path: <linux-pm+bounces-12157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6D95079B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334E5B28FB5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47119D088;
	Tue, 13 Aug 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Gvkp1tcb"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BE19D085;
	Tue, 13 Aug 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559377; cv=none; b=LEF3yNFYB8OkGoiL2uQfoZm31nOCWLhb1IHqQP7Ly7xUmXnRBGobHvJ3N5P9JndUQl8uL1tEVbXU5IUlmitR94k1eNXU7QDAxe8IZO7Wo724va5cLgmwoFJT86Uypyp7K62qymMmnnkGkT/BAIxv19b/DEW8W8BenhdTz54XrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559377; c=relaxed/simple;
	bh=vyM2fA16LJrP9OVcGZqbYqkThW+wMsHSi2s0W/9M4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOG/JRK8sJxruAKYMt1L6MaEB7WsgnlnqwlPnHrRRHo1aZ5D7DRbSwZNLfcby0Sx/TcpWGvb8ASn9olvdiE+trmbYjBXZc0n2AuCWEAbghtfsnTGAc/k8Toe4yI2VHQXOoP+5ABQkDuzuYRBbv0tqQdopPBGpXFiXicGHIYHED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Gvkp1tcb reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 04688625b4e6996d; Tue, 13 Aug 2024 16:29:26 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3506C6A89B8;
	Tue, 13 Aug 2024 16:29:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723559366;
	bh=vyM2fA16LJrP9OVcGZqbYqkThW+wMsHSi2s0W/9M4BI=;
	h=From:Subject:Date;
	b=Gvkp1tcbQ657HG2RBh4wWa2tRf4gI5g+2C2bqtrPvjWBjXzU9DY2XKDhhG3kQVbKa
	 XQ9cjopxSgE0QlPJEtvAQyUctQfDmzjU+t/xbkLcUzppN0PxbEAZcw/kZDJi2bnOju
	 89eYROzrTgRPYLvYENtzYb7z1+lOD60VaEPZjjuuiNwfLP3fSkmRIlYNo8rRAnT23W
	 yj+znvNx25KPp40xywZhRo2kWsfbZd3c5zKMJOn9M8yM7tTduegKMmSQGjvZdXa5u3
	 b5rTeK3MzderIuBK63ojIguucMaLl4Fv88emMqRq21lwauCADse2ONhNJ72YTXCqYH
	 WhNsDpeOL5JSQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject:
 [PATCH v1 4/4] thermal: gov_bang_bang: Use governor_data to reduce overhead
Date: Tue, 13 Aug 2024 16:29:11 +0200
Message-ID: <2285575.iZASKD2KPV@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohep
 uggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhesphhiihgvrdhnvght
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After running once, the for_each_trip_desc() loop in
bang_bang_manage() is pure needless overhead because it is not going to
make any changes unless a new cooling device has been bound to one of
the trips in the thermal zone or the system is resuming from sleep.

For this reason, make bang_bang_manage() set governor_data for the
thermal zone and check it upfront to decide whether or not it needs to
do anything.

However, governor_data needs to be reset in some cases to let
bang_bang_manage() know that it should walk the trips again, so add an
.update_tz() callback to the governor and make the core additionally
invoke it during system resume.

To avoid affecting the other users of that callback unnecessarily, add
a special notification reason for system resume, THERMAL_TZ_RESUME, and
also pass it to __thermal_zone_device_update() called during system
resume for consistency.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   18 ++++++++++++++++++
 drivers/thermal/thermal_core.c  |    3 ++-
 include/linux/thermal.h         |    1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -86,6 +86,10 @@ static void bang_bang_manage(struct ther
 	const struct thermal_trip_desc *td;
 	struct thermal_instance *instance;
 
+	/* If the code below has run already, nothing needs to be done. */
+	if (tz->governor_data)
+		return;
+
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
 
@@ -107,11 +111,25 @@ static void bang_bang_manage(struct ther
 				bang_bang_set_instance_target(instance, 0);
 		}
 	}
+
+	tz->governor_data = (void *)true;
+}
+
+static void bang_bang_update_tz(struct thermal_zone_device *tz,
+				enum thermal_notify_event reason)
+{
+	/*
+	 * Let bang_bang_manage() know that it needs to walk trips after binding
+	 * a new cdev and after system resume.
+	 */
+	if (reason == THERMAL_TZ_BIND_CDEV || reason == THERMAL_TZ_RESUME)
+		tz->governor_data = NULL;
 }
 
 static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
 	.trip_crossed	= bang_bang_control,
 	.manage		= bang_bang_manage,
+	.update_tz	= bang_bang_update_tz,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1692,7 +1692,8 @@ static void thermal_zone_device_resume(s
 
 	thermal_debug_tz_resume(tz);
 	thermal_zone_device_init(tz);
-	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_governor_update_tz(tz, THERMAL_TZ_RESUME);
+	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
 
 	complete(&tz->resume);
 	tz->resuming = false;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -55,6 +55,7 @@ enum thermal_notify_event {
 	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
 	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
 	THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
+	THERMAL_TZ_RESUME, /* Thermal zone is resuming after system sleep */
 };
 
 /**




