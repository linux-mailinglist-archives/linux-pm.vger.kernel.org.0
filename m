Return-Path: <linux-pm+bounces-12891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886B95F6D9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4218282C8C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8186719884C;
	Mon, 26 Aug 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hZDdeeg5"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D65476B;
	Mon, 26 Aug 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690365; cv=none; b=iIW9PYKOyUNWlKg6ka/wFEYkWfNcEnB57KePa0Uq6QfrLPYzBJc+8OBQ3FpOdGR/TQqFS77G4Kb/ym7nI6kYcYUalAvYApTEcbvHArXijHo2Wi1kDc0nbPAwJxUFB0PpqzpMQYrnUTIXEpe3goJOJDe3HadhoyanWOf27KXmPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690365; c=relaxed/simple;
	bh=c06AXLQtSCDEtudeOfQinE8psYkbBOM3p1kMOn0vIh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlDNziLQfaZ5rbBoSyjzqRHcXUcXYRZ7UfM+7FkAYUpxP975iZanhWlKqmCjwsKzE7DAn39ru2/a+FbPMQqeViKRJTWaAhPqqt2kCCoRAOEEIr1ikc5VD+lzGfJPbz5+a6xJ5lMr3WSoVziQQl7ZpBdm385Qpd6NLk0Mp6WIyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hZDdeeg5 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id f92a6affd5e871ed; Mon, 26 Aug 2024 18:39:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A8DED921952;
	Mon, 26 Aug 2024 18:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724690361;
	bh=c06AXLQtSCDEtudeOfQinE8psYkbBOM3p1kMOn0vIh4=;
	h=From:Subject:Date;
	b=hZDdeeg5AFPGnvKAL9WJ7VhS1jvXYbnI8GfoSy6HQlojFiIGDGQ+BGSoAQrkMMwf4
	 DtNxgg7bTHU8qYCOY8PI4dmFIMkSQNkdk55rg65kLopqUKVWGJ4oVIVGEU5LcmNoR5
	 cSBKnnAloQwxCwQhYeNX+aQJPyZGKf+ZCsCYbLtGVY9ZnKe+H0znaJz+2m1KR4Taor
	 XhbvaL1B+rUmb8PB503w4jpToNh8A1RbHo+WZ8xCgjiQFo3yN435ZGuWIqmdMfpHEK
	 zegoGGSwy41JgpDq9KPTFch/tZ8MZWGnc5boQNedRCRI/OjN1/OvOtvwDlUSKoRG8b
	 i5pnBlU/pSjzA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject:
 [PATCH v1 3/4] thermal: core: Check passive delay in monitor_thermal_zone()
Date: Mon, 26 Aug 2024 18:32:36 +0200
Message-ID: <2004353.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <2979211.e9J7NaK4W3@rjwysocki.net>
References: <2979211.e9J7NaK4W3@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhhuhhishhonhhgsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only case in which thermal_zone_device_set_polling() is called
with its second argument equal to zero is when passive cooling is
under way and passive_delay_jiffies is 0, which only happens when
the given thermal zone is not polled at all.

If monitor_thermal_zone() is modified to check passive_delay_jiffies
directly, the check of the thermal_zone_device_set_polling() second
argument against 0 can be dropped and a passive_delay check can be
dropped from thermal_zone_device_register_with_trips(), so change the
code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -323,11 +323,6 @@ static void thermal_zone_broken_disable(
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    unsigned long delay)
 {
-	if (!delay) {
-		cancel_delayed_work(&tz->poll_queue);
-		return;
-	}
-
 	if (delay > HZ)
 		delay = round_jiffies_relative(delay);
 
@@ -364,7 +359,7 @@ static void thermal_zone_recheck(struct
 
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	if (tz->passive > 0)
+	if (tz->passive > 0 && tz->passive_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
@@ -1411,13 +1406,8 @@ thermal_zone_device_register_with_trips(
 	if (num_trips > 0 && !trips)
 		return ERR_PTR(-EINVAL);
 
-	if (polling_delay) {
-		if (passive_delay > polling_delay)
-			return ERR_PTR(-EINVAL);
-
-		if (!passive_delay)
-			passive_delay = polling_delay;
-	}
+	if (polling_delay && passive_delay > polling_delay)
+		return ERR_PTR(-EINVAL);
 
 	if (!thermal_class)
 		return ERR_PTR(-ENODEV);




