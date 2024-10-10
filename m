Return-Path: <linux-pm+bounces-15498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A001E999510
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55B4B2182A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF411E490B;
	Thu, 10 Oct 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eNapYM1q"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA201BDA9A;
	Thu, 10 Oct 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598957; cv=none; b=UZf12Z/i6PauxMLuj7xU4WxrAXttNmD7HRLKJv6qAOrvdCEBDi3u8sq9daq3GWhxm09v9CkctgjWDMHELiq0XBNYJnImHP45kPcW/bmeshgcoC15P8akDxZrFAvZQQ/jSSv5TzeL6dWRnL4f3yoa78qdIABybeuz2f6n9lPN6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598957; c=relaxed/simple;
	bh=/ZCMzvsyY8AkHkTgqfvOe0987FpFdTCSBezdckfQuss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmSQ9w7al1cxYKaiQ1kVAEINGaNIPO8GzEkashKchuGrX+dx/3mE7yYmKiappdcHY2pFyKVvjhoWV2GEQb4BMvd3H6wvlqtKgK2SQbdvT6CMt5qJOTptWlaJ02qejl83+4nQ5VZr1Nt7Hq07P4FefoDFfaWl5AVg9TAStLlpKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eNapYM1q reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 92e9b709ea85c6a5; Fri, 11 Oct 2024 00:22:25 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3507369EF02;
	Fri, 11 Oct 2024 00:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598945;
	bh=/ZCMzvsyY8AkHkTgqfvOe0987FpFdTCSBezdckfQuss=;
	h=From:Subject:Date;
	b=eNapYM1qme+moj8TNyhiVf4tEjaInNKOgRCi8MFoH+lGDtX1ZOVkXUqMAAoqyZnfC
	 JbkfRgKN2wxnpWii7oiMEdIhrT/XC9BXR4ck+tGA4Sa2js34kCZh7E6IZh/Glkz5X6
	 4yi+EHSdr1lfBqjuuST+Rzo3iNOsJ4YLgbv0eL5mZGqM09fCOawRNu/453u8dqU/Ur
	 bjkMLlDp94UDpU3fQMqrlwkHuDWgAx/g1BEpfDIQHOb0PefmEdyVC6+noS5pYEYJIx
	 HI+aq4/LlaT7X15MW5elTWkFd4tsnZ3k6UOrf4X8V/y2eGumVBJG2bILKxeCk1LSkz
	 7lr0Zgeijvpjw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 11/11] thermal: core: Manage thermal_governor_lock using a mutex
 guard
Date: Fri, 11 Oct 2024 00:22:09 +0200
Message-ID: <3679429.R56niFO833@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Switch over the thermal core to using a mutex guard for
thermal_governor_lock management.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/863177860.0ifERbkFSE@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |   40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -124,7 +124,7 @@ int thermal_register_governor(struct the
 	if (!governor)
 		return -EINVAL;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
 
 	err = -EBUSY;
 	if (!__find_governor(governor->name)) {
@@ -163,8 +163,6 @@ int thermal_register_governor(struct the
 		}
 	}
 
-	mutex_unlock(&thermal_governor_lock);
-
 	return err;
 }
 
@@ -175,10 +173,10 @@ void thermal_unregister_governor(struct
 	if (!governor)
 		return;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
 
 	if (!__find_governor(governor->name))
-		goto exit;
+		return;
 
 	list_del(&governor->governor_list);
 
@@ -189,9 +187,6 @@ void thermal_unregister_governor(struct
 				 THERMAL_NAME_LENGTH))
 			thermal_set_governor(pos, NULL);
 	}
-
-exit:
-	mutex_unlock(&thermal_governor_lock);
 }
 
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
@@ -200,16 +195,13 @@ int thermal_zone_device_set_policy(struc
 	struct thermal_governor *gov;
 	int ret = -EINVAL;
 
-	mutex_lock(&thermal_governor_lock);
-
+	guard(mutex)(&thermal_governor_lock);
 	guard(thermal_zone)(tz);
 
 	gov = __find_governor(strim(policy));
 	if (gov)
 		ret = thermal_set_governor(tz, gov);
 
-	mutex_unlock(&thermal_governor_lock);
-
 	thermal_notify_tz_gov_change(tz, policy);
 
 	return ret;
@@ -220,15 +212,13 @@ int thermal_build_list_of_policies(char
 	struct thermal_governor *pos;
 	ssize_t count = 0;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
 
 	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
 		count += sysfs_emit_at(buf, count, "%s ", pos->name);
 	}
 	count += sysfs_emit_at(buf, count, "\n");
 
-	mutex_unlock(&thermal_governor_lock);
-
 	return count;
 }
 
@@ -668,17 +658,18 @@ int for_each_thermal_governor(int (*cb)(
 			      void *data)
 {
 	struct thermal_governor *gov;
-	int ret = 0;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
+
 	list_for_each_entry(gov, &thermal_governor_list, governor_list) {
+		int ret;
+
 		ret = cb(gov, data);
 		if (ret)
-			break;
+			return ret;
 	}
-	mutex_unlock(&thermal_governor_lock);
 
-	return ret;
+	return 0;
 }
 
 int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
@@ -1346,20 +1337,15 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
 static int thermal_zone_init_governor(struct thermal_zone_device *tz)
 {
 	struct thermal_governor *governor;
-	int ret;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
 
 	if (tz->tzp)
 		governor = __find_governor(tz->tzp->governor_name);
 	else
 		governor = def_governor;
 
-	ret = thermal_set_governor(tz, governor);
-
-	mutex_unlock(&thermal_governor_lock);
-
-	return ret;
+	return thermal_set_governor(tz, governor);
 }
 
 static void thermal_zone_init_complete(struct thermal_zone_device *tz)




