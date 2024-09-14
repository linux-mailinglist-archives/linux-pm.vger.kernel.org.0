Return-Path: <linux-pm+bounces-14259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A8979011
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3EF2855D1
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE91CDA1C;
	Sat, 14 Sep 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nQBRqUDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756138C;
	Sat, 14 Sep 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311064; cv=none; b=oOshnNDQPzPebC2GStexCdlXHReirc6GQLULqzftCaLlKLkN2ADSnY0wBc9vl9+oT9KVuUAkAnmpkXYe/V5Z6y85ResxsuJmpsTLy0dimLZ/9Ppult8bGvdSEza8a48XGqjn5KJx050jVs92Uh8gMYD2cjVt4bXOVQAe1GEYqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311064; c=relaxed/simple;
	bh=OoicNfJK50cTdvLntxjnZVynjZjfdbu7WKyioFwc1YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0EdVtLxN5VXo3qAT+DVONLbYnXDojoWk3HnvX4kIiJHeYqKgHitemLHhLWvD+FaT8rz2GxKATki3xbs5zi9y2VWSz/0Ns+1VbdCngvFqDPQ7EiEtikedlm9+1zM2t5YXa3OtgbWd6rUqHwfcY3rTH4jHGAj+zDKlbum8gd1/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nQBRqUDX reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d0e4e7f6a0323e80; Sat, 14 Sep 2024 12:50:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6A2238532AE;
	Sat, 14 Sep 2024 12:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311052;
	bh=OoicNfJK50cTdvLntxjnZVynjZjfdbu7WKyioFwc1YY=;
	h=From:Subject:Date;
	b=nQBRqUDXby/UJVHDHPlUsiVabT3PqnYQmzWWoXXdgOXXFEY8afGF/OJq9S5ffviM4
	 /fjQE5xk+bHkL8woYfA+nL6gLmOxXFeIUxgHdg2E9ydvywx3EwDVW+hI2vIewJPXDT
	 kp+AlR8gSyhnHUvZFo+t92uPxOF9IW35DnYwZn4wvs7rWrKUzoj0hM9626XUR26q6Y
	 GDIp/ie2WGcQcc4xAggsznoTDmTj8si23V9MZ/E6+2UASjRIu1c66/Y1w4JnYo3cdj
	 kochoi3d4QSQbPPKGPiiEXViI6rmRP5BVFGDW+dqc6EwDAfZCltiRIu/gl+Y0zhfOQ
	 R8dkH0yDO3Z/Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 20/20] thermal: core: Manage thermal_governor_lock
 using a mutex guard
Date: Sat, 14 Sep 2024 12:50:15 +0200
Message-ID: <863177860.0ifERbkFSE@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Switch over the thermal core to using a mutex guard for
thermal_governor_lock management.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -123,7 +123,7 @@ int thermal_register_governor(struct the
 	if (!governor)
 		return -EINVAL;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
 
 	err = -EBUSY;
 	if (!__find_governor(governor->name)) {
@@ -162,8 +162,6 @@ int thermal_register_governor(struct the
 		}
 	}
 
-	mutex_unlock(&thermal_governor_lock);
-
 	return err;
 }
 
@@ -174,10 +172,10 @@ void thermal_unregister_governor(struct
 	if (!governor)
 		return;
 
-	mutex_lock(&thermal_governor_lock);
+	guard(mutex)(&thermal_governor_lock);
 
 	if (!__find_governor(governor->name))
-		goto exit;
+		return;
 
 	list_del(&governor->governor_list);
 
@@ -188,9 +186,6 @@ void thermal_unregister_governor(struct
 				 THERMAL_NAME_LENGTH))
 			thermal_set_governor(pos, NULL);
 	}
-
-exit:
-	mutex_unlock(&thermal_governor_lock);
 }
 
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
@@ -199,16 +194,13 @@ int thermal_zone_device_set_policy(struc
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
@@ -219,15 +211,13 @@ int thermal_build_list_of_policies(char
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
 
@@ -663,17 +653,18 @@ int for_each_thermal_governor(int (*cb)(
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
@@ -1345,20 +1336,15 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
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




