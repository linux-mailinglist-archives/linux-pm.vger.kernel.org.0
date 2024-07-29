Return-Path: <linux-pm+bounces-11563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199493FC15
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D562B22096
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959015EFD0;
	Mon, 29 Jul 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UGmdgrL7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E651DA24;
	Mon, 29 Jul 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273178; cv=none; b=oJEhDEkxzrRfZTapWF069MLDgUJSPXVUUSlxL3vkSaWCI8NrWSJJyaSwh0oa2hHrxkggk/Gxdk8sfmye2FG57AmZLSplxJbJ+1zqe6FfmsZpRnBi6YyhmXMMBpPJJZOFByR7Ki7EVy3du+lkMizNJtR1jJWNdLmvpOYhm6AU21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273178; c=relaxed/simple;
	bh=8CqqyTRjoVEA+VEaQqeZaA5XEW3Q0l4q+jOMCA9JOiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW2Bk4qLYfGb9bMnFgD/C7K1lc/5BamDwXeVEV2vI9FESE8d10Yu75YPNNdAVtC0NBj4LSu0OoOXHDcqK2X/9pbp6hMlKMx5buU/wWdaOWKzMQ3LpR74vsATBtVHlQoI70PpscxCelhFy3OCKfQE5njO1HXFkw4ECn16o+WE77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UGmdgrL7; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c66946e02c725f7c; Mon, 29 Jul 2024 18:12:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EA89277357F;
	Mon, 29 Jul 2024 18:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269574;
	bh=8CqqyTRjoVEA+VEaQqeZaA5XEW3Q0l4q+jOMCA9JOiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGmdgrL7TtpZ7GfjSRx4B9forD1HD8xIpuMNeDFhUiFT+1XKdxwUqIDU6NkIoPZlg
	 4qABb+KvO7sHCMSNNAg2Q+34ha0Wf6Cq8AJyq+ITxHq21f3XsAbK/Bubok+4SMzTJU
	 tiBK/Gr0kZVhpgung9xnHSJB6A0VQPRUqI88F9pPXM0YR8a8at4j/f2Tr59IOT+PCY
	 3Nhsg8wXJ2R/1OpLSZ12tKzKDycMvVHuO0iwpbnffcyUElO/Tr3eXkT1Y2DT6/tEf+
	 9G0tUZT8PTHVfiqbmN/yvdhk16HernU0m7yMJX54f66DSMibPE7G0nF6zCiLG97ZgX
	 JurshHrF59SLQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [RESEND][PATCH v1 8/8] thermal: trip: Drop thermal_zone_get_trip()
Date: Mon, 29 Jul 2024 18:12:45 +0200
Message-ID: <2220301.Mh6RI2rZIc@rjwysocki.net>
In-Reply-To: <2211925.irdbgypaU6@rjwysocki.net>
References: <2211925.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no more callers of thermal_zone_get_trip() in the tree, so
drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_trip.c |   14 --------------
 include/linux/thermal.h        |    2 --
 2 files changed, 16 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -108,20 +108,6 @@ void thermal_zone_set_trips(struct therm
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
 
-int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			  struct thermal_trip *trip)
-{
-	if (!tz || !trip || trip_id < 0 || trip_id >= tz->num_trips)
-		return -EINVAL;
-
-	mutex_lock(&tz->lock);
-	*trip = tz->trips[trip_id].trip;
-	mutex_unlock(&tz->lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
-
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip)
 {
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -202,8 +202,6 @@ static inline void devm_thermal_of_zone_
 }
 #endif
 
-int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			  struct thermal_trip *trip);
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data);




