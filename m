Return-Path: <linux-pm+bounces-14266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F98979023
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F99FB22265
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D61CEEAB;
	Sat, 14 Sep 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="peEt8jP8"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4885635;
	Sat, 14 Sep 2024 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311488; cv=none; b=qujEPOB78x6e7FXt9vUoaXoBRyPEJTE1GfRuDZ+qoEIuVTlwTuLZcslTKGlpw1/e66IDmu7NvIbPskAy0oCdbeZ9ja4CN4IrxWiu2a1SCi7YDNpS4cFsf4HCOP6gfsYRBEf9to5lACd69gveHhDFZKPqcu/cUnNx+X5mCiO8G0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311488; c=relaxed/simple;
	bh=JZzx1172XcqWvR1UQZF0WI04VQXPhB3F9mKK19knqDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQtFpM7DGerAvSZcKlqmEn9vDGR1fxAa93cIPWGmPOv09HbGdRwLGWd8vMXDO1KaXyRnElXEjec5nrJDcCiXr0uhAqWebkrTxv7UUD8aH6XslhiE/NGIduj2bp5OtoarTFMI1AWswESYo+8fQFarlOE4XorAdtP4gx/FI6nUs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=peEt8jP8 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 6ed451219db4accd; Sat, 14 Sep 2024 12:58:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 78B498532AE;
	Sat, 14 Sep 2024 12:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311484;
	bh=JZzx1172XcqWvR1UQZF0WI04VQXPhB3F9mKK19knqDE=;
	h=From:Subject:Date;
	b=peEt8jP8CrAvxU39LOOYcnt5pegi3H6JK8Fue2hKUAo+qGMkT2pHeEqNDOtAh7ech
	 nG4pemubZTVe3jOs3qpvagcwQK/Lk3t1qtefaQBZXiD/6g/ciDmmqNaPoYlV9adaC5
	 UCJALMT/8hJBInYq2/3ZM81cN6oUVWOH2PesinWWMThe1Lq6aPNWmixhsK3WxYtfnY
	 kQ3s27oayWIbZH9eP1rfxOmNbgVSK+V1p660dhwDYanPqqfqJOC9A79q5r42SXIi8u
	 Z2gSdGDlUXpcw5KhxHoxPYGDV3UL5Dlq2etQj0wksZ9H14SE4s4Wz5kwXajzZPDSMf
	 8EwE82bBxYF+Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 14/20] thermal: core: Introduce thermal_instance_add()
Date: Sat, 14 Sep 2024 12:43:24 +0200
Message-ID: <2641944.Lt9SDvczpP@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To reduce the number of redundant result checks in
thermal_bind_cdev_to_trip() and make the code in it easier to
follow, move some of that code to a new function called
thermal_instance_add() and make thermal_bind_cdev_to_trip()
invoke that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   46 ++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -736,6 +736,28 @@ struct thermal_zone_device *thermal_zone
  *				     binding, and unbinding.
  */
 
+static int thermal_instance_add(struct thermal_instance *new_instance,
+				struct thermal_cooling_device *cdev,
+				struct thermal_trip_desc *td)
+{
+	struct thermal_instance *instance;
+
+	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
+		if (instance->cdev == cdev)
+			return -EEXIST;
+	}
+
+	list_add_tail(&new_instance->trip_node, &td->thermal_instances);
+
+	mutex_lock(&cdev->lock);
+
+	list_add_tail(&new_instance->cdev_node, &cdev->thermal_instances);
+
+	mutex_unlock(&cdev->lock);
+
+	return 0;
+}
+
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
@@ -754,7 +776,7 @@ static int thermal_bind_cdev_to_trip(str
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *cool_spec)
 {
-	struct thermal_instance *dev, *instance;
+	struct thermal_instance *dev;
 	bool upper_no_limit;
 	int result;
 
@@ -816,23 +838,15 @@ static int thermal_bind_cdev_to_trip(str
 	if (result)
 		goto remove_trip_file;
 
-	mutex_lock(&cdev->lock);
-	list_for_each_entry(instance, &td->thermal_instances, trip_node)
-		if (instance->cdev == cdev) {
-			result = -EEXIST;
-			break;
-		}
-	if (!result) {
-		list_add_tail(&dev->trip_node, &td->thermal_instances);
-		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
-	}
-	mutex_unlock(&cdev->lock);
+	result = thermal_instance_add(dev, cdev, td);
+	if (result)
+		goto remove_weight_file;
 
-	if (!result) {
-		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
-		return 0;
-	}
+	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
+
+	return 0;
 
+remove_weight_file:
 	device_remove_file(&tz->device, &dev->weight_attr);
 remove_trip_file:
 	device_remove_file(&tz->device, &dev->attr);




