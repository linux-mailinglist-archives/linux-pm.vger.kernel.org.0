Return-Path: <linux-pm+bounces-17284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED89C3217
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 14:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD8E1C2097B
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298B156F3B;
	Sun, 10 Nov 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="meN+kTZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5214B950;
	Sun, 10 Nov 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731243982; cv=none; b=K5Un8VLJHrxBRoBuKLXSU/RLzLAHLky7W9sCuuDTfDsPK2EsD50aozGvp7Tpaci7Vn0QQh5q77T0WDN2yUv8nCdTWEz0P7U3+Zew+ipxKL+efo4hEFJ5h+Ti9iomNylZFkda3cE1cJt+eqyUIB8ujFZmWKnotz9+fmC7Lbg7P7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731243982; c=relaxed/simple;
	bh=A8ev2ELsBLbtZvE8ahafVzzrImQv06hPgjFiEGNScUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXuy36mnZVUsRPiTHj8KNNwWEN5mykTiN4d0xE7KsFQrgFmkyULN/Am7JuR3q3b6Ihpq8x3dtuSi8Y+1FtpR5fKCR+AEf7wURTFBdyxozTNpVj+XeEqBS7ut+5u/uKMQQxdw+YxJKwUufbxdaf/J7ZJTEoFVlONnpTGMuw0WrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=meN+kTZY reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id e07dc5f86fe5de4c; Sun, 10 Nov 2024 14:06:11 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1C5B2838538;
	Sun, 10 Nov 2024 14:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731243971;
	bh=A8ev2ELsBLbtZvE8ahafVzzrImQv06hPgjFiEGNScUo=;
	h=From:Subject:Date;
	b=meN+kTZYAJkgP9wPmK1Fx3f1Fn70k+qaiI9G0vxoUAPk8FYfSKyZI4XjVtWVQWzWf
	 lXCPLNwwuTVIvKKUWTO5AzUI54qNP64UbyQjxGoSwtgJXZPg2uDCspwfI3OILjddXx
	 qf3FKA0xaYU7umwuH4oIJm+go8TuhLkLAfTd2PJ8XaHyxLLaK7YwcsOrroh9ZN+LRP
	 RAG6aTZm7qCPBFskV4YYQ4WG2ED+tBLmFi1g7eXgPubQschmAXkEOxgke19d0i+K4H
	 bCPJqCYyIhrhqUxnor1eJQJrno6qw7ixqKVEOAvxUeee9OMnr3c2yYpRyu2+Qa6Ays
	 zq0CE8lAyF5+w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 2/2] thermal: testing: Use DEFINE_FREE() and __free() to simplify
 code
Date: Sun, 10 Nov 2024 14:06:01 +0100
Message-ID: <4628747.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <12569620.O9o76ZdvQC@rjwysocki.net>
References: <12569620.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordh
X-DCC--Metrics: v370.home.net.pl 0; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use DEFINE_FREE() to define a __free function for dropping thermal
zone template reference counters and use it along with __free() to
simplify code in some places.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/testing/zone.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/testing/zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/testing/zone.c
+++ linux-pm/drivers/thermal/testing/zone.c
@@ -305,6 +305,9 @@ static void tt_put_tt_zone(struct tt_the
 	tt_zone->refcount--;
 }
 
+DEFINE_FREE(put_tt_zone, struct tt_thermal_zone *,
+	    if (!IS_ERR_OR_NULL(_T)) tt_put_tt_zone(_T))
+
 static void tt_zone_add_trip_work_fn(struct work_struct *work)
 {
 	struct tt_work *tt_work = tt_work_of_work(work);
@@ -327,9 +330,9 @@ static void tt_zone_add_trip_work_fn(str
 
 int tt_zone_add_trip(const char *arg)
 {
+	struct tt_thermal_zone *tt_zone __free(put_tt_zone);
 	struct tt_work *tt_work __free(kfree);
 	struct tt_trip *tt_trip __free(kfree);
-	struct tt_thermal_zone *tt_zone;
 	int id;
 
 	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
@@ -345,10 +348,8 @@ int tt_zone_add_trip(const char *arg)
 		return PTR_ERR(tt_zone);
 
 	id = ida_alloc(&tt_zone->ida, GFP_KERNEL);
-	if (id < 0) {
-		tt_put_tt_zone(tt_zone);
+	if (id < 0)
 		return id;
-	}
 
 	tt_trip->trip.type = THERMAL_TRIP_ACTIVE;
 	tt_trip->trip.temperature = THERMAL_TEMP_INVALID;
@@ -361,7 +362,7 @@ int tt_zone_add_trip(const char *arg)
 	tt_zone->num_trips++;
 
 	INIT_WORK(&tt_work->work, tt_zone_add_trip_work_fn);
-	tt_work->tt_zone = tt_zone;
+	tt_work->tt_zone = no_free_ptr(tt_zone);
 	tt_work->tt_trip = no_free_ptr(tt_trip);
 	schedule_work(&(no_free_ptr(tt_work)->work));
 
@@ -420,23 +421,18 @@ static int tt_zone_register_tz(struct tt
 
 int tt_zone_reg(const char *arg)
 {
-	struct tt_thermal_zone *tt_zone;
-	int ret;
+	struct tt_thermal_zone *tt_zone __free(put_tt_zone);
 
 	tt_zone = tt_get_tt_zone(arg);
 	if (IS_ERR(tt_zone))
 		return PTR_ERR(tt_zone);
 
-	ret = tt_zone_register_tz(tt_zone);
-
-	tt_put_tt_zone(tt_zone);
-
-	return ret;
+	return tt_zone_register_tz(tt_zone);
 }
 
 int tt_zone_unreg(const char *arg)
 {
-	struct tt_thermal_zone *tt_zone;
+	struct tt_thermal_zone *tt_zone __free(put_tt_zone);
 
 	tt_zone = tt_get_tt_zone(arg);
 	if (IS_ERR(tt_zone))
@@ -444,8 +440,6 @@ int tt_zone_unreg(const char *arg)
 
 	tt_zone_unregister_tz(tt_zone);
 
-	tt_put_tt_zone(tt_zone);
-
 	return 0;
 }
 




