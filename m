Return-Path: <linux-pm+bounces-12890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951FE95F6BD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079E2B2101D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A5194AEC;
	Mon, 26 Aug 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kxbYTWBz"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF8143C7D;
	Mon, 26 Aug 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690249; cv=none; b=XWf1z89q10arTJWUKkUxb20OlDZxSwUIgRFR5h+pX24l+FU6Hoogiuqv79HQfmALuVcc3yw4Z31BH7Qi0rhKkA5Ath+I7i8u6moGM0y92Kko9jFvrrK4XYvylisoMs8TS5wPtm4GVd6zs0/n8qSnmwW9CELG9Ql1s8+tvDhPfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690249; c=relaxed/simple;
	bh=7YZKPwCtQxcL4xgnfnjvMt8lmgcWeXktoVDEPvRCGb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5Z66PE1J0jvwtmEuHKFqIRmz18hivEkW0Ztk4AkTSl/tPuIOhIQs0alEZx1OjP+4i5Jvd7/VyjQnOIwmYltiir8ZzDP5YWFO04D9PdM8JiGTgsSANrPmZ9p2yN0fCSEdnIdkqvL0y9j5GzCt3G8geJLZwcXabsfNDnFv2epZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kxbYTWBz; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e4d1ef758a5236b4; Mon, 26 Aug 2024 18:37:25 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7E119921952;
	Mon, 26 Aug 2024 18:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724690245;
	bh=7YZKPwCtQxcL4xgnfnjvMt8lmgcWeXktoVDEPvRCGb4=;
	h=From:Subject:Date;
	b=kxbYTWBzzEOnfQ5iRA02urCV+HL3RrCNSldCKtYTh38kjmczu9V4sl3uFIOQOId6n
	 VJe6fj5eoI4sRt2fYr9z64Ct7fg+OAyGu6zK2/2Yjq785uUNRThGk7dgPB54kUGzFx
	 CA/lFis87rDBUp6Zap0vv4TdcqjeBKVCkxF+HB+4AMehkpZqfW0WDPKY9iy9QDReDa
	 3pL87zzabqkdMQRrQ2A9WFSPoWJQVNlWTooVZXibTUwWQUGceVJyM8Fc7I0G0CGDGT
	 xO9ICfDIreF4+8+8I288/rLoOSS0MikY7nCGOmIWQpkWuPsA4aK1cgCxlTghxfLa3R
	 U8C9NMQF463Wg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v1 4/4] thermal: core: Drop thermal_zone_device_is_enabled()
Date: Mon, 26 Aug 2024 18:37:16 +0200
Message-ID: <9353673.CDJkKcVGEf@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhhuhhishhonhhgsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are only two callers of thermal_zone_device_is_enabled()
and one of them call is under the zone lock and the other one uses
lockdep_assert_held() on that lock.  Thus the lockdep_assert_held()
in thermal_zone_device_is_enabled() is redundant and it could be
dropped, but then the function would merely become a wrapper around
a simple tz->mode check that is more convenient to do directly.

Accordingly, drop thermal_zone_device_is_enabled() altogether and update
its callers to check tz->mode directly as appropriate.

While at it, combine the tz->mode and tz->suspended checks in
__thermal_zone_device_update() because they are of a similar category
and if any of them evaluates to "true", the outcome is the same.

No intentinal functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c  |   12 +-----------
 drivers/thermal/thermal_core.h  |    3 ---
 drivers/thermal/thermal_sysfs.c |    2 +-
 3 files changed, 2 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -547,10 +547,7 @@ void __thermal_zone_device_update(struct
 	int low = -INT_MAX, high = INT_MAX;
 	int temp, ret;
 
-	if (tz->suspended)
-		return;
-
-	if (!thermal_zone_device_is_enabled(tz))
+	if (tz->suspended || tz->mode != THERMAL_DEVICE_ENABLED)
 		return;
 
 	ret = __thermal_zone_get_temp(tz, &temp);
@@ -652,13 +649,6 @@ int thermal_zone_device_disable(struct t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
 
-int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
-{
-	lockdep_assert_held(&tz->lock);
-
-	return tz->mode == THERMAL_DEVICE_ENABLED;
-}
-
 static bool thermal_zone_is_present(struct thermal_zone_device *tz)
 {
 	return !list_empty(&tz->node);
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -284,7 +284,4 @@ thermal_cooling_device_stats_update(stru
 				    unsigned long new_state) {}
 #endif /* CONFIG_THERMAL_STATISTICS */
 
-/* device tree support */
-int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
-
 #endif /* __THERMAL_CORE_H__ */
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -53,7 +53,7 @@ mode_show(struct device *dev, struct dev
 	int enabled;
 
 	mutex_lock(&tz->lock);
-	enabled = thermal_zone_device_is_enabled(tz);
+	enabled = tz->mode == THERMAL_DEVICE_ENABLED;
 	mutex_unlock(&tz->lock);
 
 	return sprintf(buf, "%s\n", enabled ? "enabled" : "disabled");




