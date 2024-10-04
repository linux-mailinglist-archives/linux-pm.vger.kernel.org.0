Return-Path: <linux-pm+bounces-15170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5B990FF1
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CC281A9B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782C1E2849;
	Fri,  4 Oct 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kW2VDnhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A61E04B4;
	Fri,  4 Oct 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070995; cv=none; b=ugJ+lJl9LWF2o+0O0YEl+Vha6QE/TKkuQkRw/WCu769X+G88UJuGWtYYL3j9EOTY3D061WSvlwHD3FP1sEgnRnckP3/OQKIUuQbbSVeEai2NjpvLp9nVlbwkUVqY7w5Ahp/6DcYvRGv0CfGYCBMrgY/WZHQZppoNf9w6ImTErwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070995; c=relaxed/simple;
	bh=0P2WxnUpd1AyHHvrMH196mT7Oa6TA2+VCu5CwDH3EHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPL4ss9bR/jJAravPCqeoq9pKB9RdKWxOKnPponJW7CKjp86/Zt2sTg8EpzDU0kGiB08k9dLY76b7rGLMd7eAmKsiqraRuOKSn8RPPA0TWsjH3hmDXk2EsKIvbABp6zEVWBkn6q7gfNGBBZa6DVXl7/7LmjiD+lcFWzo9/BDDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kW2VDnhy reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 974918518edb54b4; Fri, 4 Oct 2024 21:43:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B12B76A9505;
	Fri,  4 Oct 2024 21:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070983;
	bh=0P2WxnUpd1AyHHvrMH196mT7Oa6TA2+VCu5CwDH3EHo=;
	h=From:Subject:Date;
	b=kW2VDnhyQwQOcey/bOFd8nuhVmqF4pPrrWOb+529WlA4B03S04luBlvT25Vsw+5am
	 SdBBNQqYv00mWnqBdKYTdBQGR+T+CGmKqlznKkzQY3RO3uclHwWLvilRrgcjjm+edN
	 Fyk1iuOtJrkGbX5L7z8FYEW/6kUsFL7lepogRp50VmY3L6+nRcfS8+CpsaAW+JfFhl
	 1eRzEt81NPArvex3FE34l3fBg9mq8QTkicc8TXi1LGu44uBKJ+rOw91zKf+yZF0QOd
	 2+1VxYrWxDN4gPOjbog7l0yoO/Qscxdz2FTwtR6sGWHCKmRx2EbZmZilPfRqfO/6OS
	 C69C2uhFUyvGw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 09/12] thermal: core: Update thermal zones after cooling device
 binding
Date: Fri, 04 Oct 2024 21:33:28 +0200
Message-ID: <2226302.Icojqenx9y@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
References: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a new cooling device is registered and it is bound to at least one
trip point in a given thermal zone, that thermal zone needs to be
updated via __thermal_zone_device_update().

Instead of doing this with the help of the need_update atomic field in
struct thermal_zone_device, which is not particularly straightforward,
make __thermal_zone_cdev_bind() return a bool value indicating whether
or not the given thermal zone needs to be updated because a new cooling
device has been bound to it and update thermal_zone_cdev_bind() to
call __thermal_zone_device_update() when this value is "true".

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/3603909.iIbC2pHGDl@rjwysocki.net/

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -933,13 +933,14 @@ void print_bind_err_msg(struct thermal_z
 		cdev->type, thermal_zone_trip_id(tz, trip), ret);
 }
 
-static void __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+static bool __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
 				     struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
+	bool update_tz = false;
 
 	if (!tz->ops.should_bind)
-		return;
+		return false;
 
 	for_each_trip_desc(tz, td) {
 		struct thermal_trip *trip = &td->trip;
@@ -954,9 +955,15 @@ static void __thermal_zone_cdev_bind(str
 			continue;
 
 		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
-		if (ret)
+		if (ret) {
 			print_bind_err_msg(tz, trip, cdev, ret);
+			continue;
+		}
+
+		update_tz = true;
 	}
+
+	return update_tz;
 }
 
 static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
@@ -964,7 +971,8 @@ static void thermal_zone_cdev_bind(struc
 {
 	mutex_lock(&tz->lock);
 
-	__thermal_zone_cdev_bind(tz, cdev);
+	if (__thermal_zone_cdev_bind(tz, cdev))
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_unlock(&tz->lock);
 }
@@ -991,7 +999,7 @@ __thermal_cooling_device_register(struct
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos = NULL;
+	struct thermal_zone_device *pos;
 	unsigned long current_state;
 	int id, ret;
 
@@ -1067,11 +1075,6 @@ __thermal_cooling_device_register(struct
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		thermal_zone_cdev_bind(pos, cdev);
 
-	list_for_each_entry(pos, &thermal_tz_list, node)
-		if (atomic_cmpxchg(&pos->need_update, 1, 0))
-			thermal_zone_device_update(pos,
-						   THERMAL_EVENT_UNSPECIFIED);
-
 	mutex_unlock(&thermal_list_lock);
 
 	return cdev;




