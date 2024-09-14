Return-Path: <linux-pm+bounces-14269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D952979039
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6069B2510D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534941CF29F;
	Sat, 14 Sep 2024 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GVgeQPDo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8261CEE8C;
	Sat, 14 Sep 2024 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311661; cv=none; b=kXnt4feX61uT06U5J1XI4Q8yYJJ+iAwvgaYfHywEmS5KTgnToS1la1RWO7jZ+d+aJJvqvSxJ95UKthM0N88ET8FiP/f+aicCiyupfoFe5wguR9Ot174HPNFQw7JzzDB1bGXjmRhPp6KtFFHux+WBE6rt2TPquBR1Ftu/mLT7uro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311661; c=relaxed/simple;
	bh=eKYWlUEHH3T71gG6bcwOEKdxRBpyOQ8hCMDOWgZtYF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ0+GutMBsyVPhbNe5C7oAkyDV8WPoHrkmSvISC5fWZP3nry60g85xf2vEb0xyW3prPDBbXgV0q9J2lyf9uuPWe5GsN9W+eGttcnVUdzyKIPrU2f8cFkEVo3SMu9c3W+dPt1AjnzCA51iY8D0eyeU8Kv7HKf79oKoiLYZMnj3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GVgeQPDo reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 28d1cc1dbb2baddd; Sat, 14 Sep 2024 13:00:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 98B0C8532AE;
	Sat, 14 Sep 2024 13:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311657;
	bh=eKYWlUEHH3T71gG6bcwOEKdxRBpyOQ8hCMDOWgZtYF0=;
	h=From:Subject:Date;
	b=GVgeQPDoA7qz8Qjkad4iXp+z8H7zqTev6ORpn11w9OD4z/3H8CwuKcOtDnRCWjAIR
	 6sR89y5cSBhXJrK7XjXx1X8cXBG9YnKqkQvsqcn+iFNG412S4wQY9bX8iY35qrEdAj
	 oTCC1VHzOm+YBjTxdApdJ/VIfkGxatva7bDyddDL9HHM92APVROMT2mH3BnmVrIqXX
	 xU72vn/iqzVZfmaw4IgmGzOwdLXDFQYcYAQ3PqDl6YlSfuj3wXhtQfOUq/M8lNuct1
	 dxEomDWbcg8h5inGjBRemhXf2ynQyWf8mRWNSdn09p58bareObDu4jKNKOMjorlnse
	 JtxLWKbvWePVw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 11/20] thermal: core: Separate code running under
 thermal_list_lock
Date: Sat, 14 Sep 2024 12:38:45 +0200
Message-ID: <1822468.VLH7GnMWUR@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=20 Fuz1=20 Fuz2=20

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To prepare for a subsequent change that will switch over the thermal
core to using a mutex guard for thermal_list_lock management, move the
code running under thermal_list_lock during the initialization and
unregistration of cooling devices into separate functions.

While at it, drop some comments that do not add value.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   64 +++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -959,6 +959,20 @@ static void thermal_zone_cdev_bind(struc
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
+static void thermal_cooling_device_init_complete(struct thermal_cooling_device *cdev)
+{
+	struct thermal_zone_device *tz;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_add(&cdev->node, &thermal_cdev_list);
+
+	list_for_each_entry(tz, &thermal_tz_list, node)
+		thermal_zone_cdev_bind(tz, cdev);
+
+	mutex_unlock(&thermal_list_lock);
+}
+
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -981,7 +995,6 @@ __thermal_cooling_device_register(struct
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos;
 	unsigned long current_state;
 	int id, ret;
 
@@ -1048,16 +1061,7 @@ __thermal_cooling_device_register(struct
 	if (current_state <= cdev->max_state)
 		thermal_debug_cdev_add(cdev, current_state);
 
-	/* Add 'this' new cdev to the global cdev list */
-	mutex_lock(&thermal_list_lock);
-
-	list_add(&cdev->node, &thermal_cdev_list);
-
-	/* Update binding information for 'this' new cdev */
-	list_for_each_entry(pos, &thermal_tz_list, node)
-		thermal_zone_cdev_bind(pos, cdev);
-
-	mutex_unlock(&thermal_list_lock);
+	thermal_cooling_device_init_complete(cdev);
 
 	return cdev;
 
@@ -1268,38 +1272,42 @@ static void thermal_zone_cdev_unbind(str
 	__thermal_zone_cdev_unbind(tz, cdev);
 }
 
-/**
- * thermal_cooling_device_unregister - removes a thermal cooling device
- * @cdev:	the thermal cooling device to remove.
- *
- * thermal_cooling_device_unregister() must be called when a registered
- * thermal cooling device is no longer needed.
- */
-void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
+static bool thermal_cooling_device_exit(struct thermal_cooling_device *cdev)
 {
 	struct thermal_zone_device *tz;
-
-	if (!cdev)
-		return;
-
-	thermal_debug_cdev_remove(cdev);
+	bool ret = true;
 
 	mutex_lock(&thermal_list_lock);
 
 	if (!thermal_cooling_device_present(cdev)) {
-		mutex_unlock(&thermal_list_lock);
-		return;
+		ret = false;
+		goto unlock;
 	}
 
 	list_del(&cdev->node);
 
-	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node)
 		thermal_zone_cdev_unbind(tz, cdev);
 
+unlock:
 	mutex_unlock(&thermal_list_lock);
 
-	device_unregister(&cdev->device);
+	return ret;
+}
+
+/**
+ * thermal_cooling_device_unregister() - removes a thermal cooling device
+ * @cdev: Thermal cooling device to remove.
+ */
+void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
+{
+	if (!cdev)
+		return;
+
+	thermal_debug_cdev_remove(cdev);
+
+	if (thermal_cooling_device_exit(cdev))
+		device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 




