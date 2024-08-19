Return-Path: <linux-pm+bounces-12460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357A957007
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00AF288581
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AFD171E43;
	Mon, 19 Aug 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="R8PSa6OP"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62A13C3D5;
	Mon, 19 Aug 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084188; cv=none; b=klptrEP1RF9goKb1mE0eFGtXxFcoKXEd/odTRgoWm/XBZ4q/elwi3eeibNhmCPLRPpz69zpdmUUAHU84nOAIJ/Mn2xGcw/RczfSsju19hgbWYvpGXKGeXZLvxC3mjfDQyZ0zP7v0QmToPteegDKLKzlQjJzDSsctlgNWepWKa0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084188; c=relaxed/simple;
	bh=ZuziA4nlWDx81O3fJaTlUss7+k/K6E4B59ehabNesQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CF+/IdBJXzkujxSgWEn+d8DMT6QWg8CX6Ew7CJYiTsQZRsC09dGX1VcL9jFvYiQXe2WTaLzm/F6bLh8zKo+0TG0S+idiFnjZyJaXC1FduJsqGTA7RyjkmYJLDbG3d5MnXfgVTpOGpYKDgJfNvgaeXdTbeD1R1X+XJQhCTKCt4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=R8PSa6OP reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b44314b0e680ed63; Mon, 19 Aug 2024 18:16:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 62CC573B5D8;
	Mon, 19 Aug 2024 18:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724084184;
	bh=ZuziA4nlWDx81O3fJaTlUss7+k/K6E4B59ehabNesQU=;
	h=From:Subject:Date;
	b=R8PSa6OPU7N36Pe1EZ226enB2Tc9ENKqMhVYqr1Q3Ar+U0mVE0oF5AQ8OMWakfNkh
	 jKU0zlY1E8dNeR/VTcGnwUzcZGvAY0aU7CVP8OOpg8CPmSt/I00KGn4WK71rGXWgZo
	 jInpiHd5EcJ/ELa1faDZBCUV69eumG7WemM8rrU2JDgtzJrzPvNJXA0skgIU2/hbZJ
	 ++smj+wyCj8456BgndOMKJfE9k65toc4n7BgORzz83Gga59MnjLlRJLgqEC2s2x5UQ
	 NXFogZVRBmHA8Y9XgE3dRbF2y1RNxq7Y9EZKnXnAoSvpZntffWRYxiEx1dUPZdaAzV
	 tvbyvja3wRn1g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 01/14] thermal: core: Fold two functions into their respective
 callers
Date: Mon, 19 Aug 2024 17:50:30 +0200
Message-ID: <2962184.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2205737.irdbgypaU6@rjwysocki.net>
References: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fold bind_cdev() into __thermal_cooling_device_register() and bind_tz()
into thermal_zone_device_register_with_trips() to reduce code bloat and
make it somewhat easier to follow the code flow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

---
 drivers/thermal/thermal_core.c |   55 ++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -991,20 +991,6 @@ void print_bind_err_msg(struct thermal_z
 		tz->type, cdev->type, ret);
 }
 
-static void bind_cdev(struct thermal_cooling_device *cdev)
-{
-	int ret;
-	struct thermal_zone_device *pos = NULL;
-
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (pos->ops.bind) {
-			ret = pos->ops.bind(pos, cdev);
-			if (ret)
-				print_bind_err_msg(pos, cdev, ret);
-		}
-	}
-}
-
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1100,7 +1086,13 @@ __thermal_cooling_device_register(struct
 	list_add(&cdev->node, &thermal_cdev_list);
 
 	/* Update binding information for 'this' new cdev */
-	bind_cdev(cdev);
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (pos->ops.bind) {
+			ret = pos->ops.bind(pos, cdev);
+			if (ret)
+				print_bind_err_msg(pos, cdev, ret);
+		}
+	}
 
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
@@ -1338,25 +1330,6 @@ void thermal_cooling_device_unregister(s
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-static void bind_tz(struct thermal_zone_device *tz)
-{
-	int ret;
-	struct thermal_cooling_device *pos = NULL;
-
-	if (!tz->ops.bind)
-		return;
-
-	mutex_lock(&thermal_list_lock);
-
-	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		ret = tz->ops.bind(tz, pos);
-		if (ret)
-			print_bind_err_msg(tz, pos, ret);
-	}
-
-	mutex_unlock(&thermal_list_lock);
-}
-
 static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
 {
 	*delay_jiffies = msecs_to_jiffies(delay_ms);
@@ -1554,13 +1527,23 @@ thermal_zone_device_register_with_trips(
 	}
 
 	mutex_lock(&thermal_list_lock);
+
 	mutex_lock(&tz->lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	mutex_unlock(&tz->lock);
-	mutex_unlock(&thermal_list_lock);
 
 	/* Bind cooling devices for this zone */
-	bind_tz(tz);
+	if (tz->ops.bind) {
+		struct thermal_cooling_device *cdev;
+
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			result = tz->ops.bind(tz, cdev);
+			if (result)
+				print_bind_err_msg(tz, cdev, result);
+		}
+	}
+
+	mutex_unlock(&thermal_list_lock);
 
 	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */




