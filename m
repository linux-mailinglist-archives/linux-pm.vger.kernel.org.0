Return-Path: <linux-pm+bounces-15502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E8999516
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E468B21C87
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E621E7C0A;
	Thu, 10 Oct 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LhfVwLpG"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA511E2839;
	Thu, 10 Oct 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598958; cv=none; b=FxaxVlW6e8XpHY/7EO+v3PuSZbDXPzRZZ+gRkdJf2DAu/sHDnp8MpvZmjo8VAqbAzk4hKGX/A++EwaeZ+a6J1VGKES2o3k/Hgiq9bd/egDDPh62JUls6v+6Y2OvHRXSex1CFfAWL1nvbCx5usNQnFI0H3BiWQMw8O5m0381FThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598958; c=relaxed/simple;
	bh=5pddGAizdZOfh46IVItjtqcdjuhZEc7jTA3e/PXusBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5n8WLk8qvbC7JmtNE9cvfxWHeUMK0nCr7hP7GpH05HgbeYXkywMbkDZyBbnLkgpZH8hQlc+xDoCCPYBBRjcMMcN2Gr2kB246NJrcLNmAbE2FtNnngxBS0anNTPao17BSXe5TYkYlIPmt9cuDMKoDamNsDq/6El7+d1g1qdXkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LhfVwLpG reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id f9e406277601a325; Fri, 11 Oct 2024 00:22:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 68CB269EF02;
	Fri, 11 Oct 2024 00:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598948;
	bh=5pddGAizdZOfh46IVItjtqcdjuhZEc7jTA3e/PXusBE=;
	h=From:Subject:Date;
	b=LhfVwLpGzF9G/0d1nQ2ZcG/VazpWq+REcU3sI/NGHv6u7Q4nfWc41pSDDFWcHedfx
	 WE64aDBkjAlro2vMwvuue4zcjjv4275VSYcSY8Rl6IcdWHW5/noAuK3eiOD4RyXDqZ
	 flxBmX8kNMwqPFH0AgXnHdOvm41CK3FcoJ2R77l+/7YiDaujGx68n2W4JUB0t4lrvU
	 8O/PXLaCuzIeZqLKwi9g6auyjPFbZWClvAwQ1sSp84Fcf3GR60793eYM7hCS8kY0m6
	 G6jUwLX1zELkOCXMn3N7I4PQmPczaVfqtoMlQ/BmP6ryRF5c5NcJnCAzM+93xEGt9/
	 JSqqXZS9M/JIw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 03/11] thermal: core: Separate code running under thermal_list_lock
Date: Fri, 11 Oct 2024 00:09:18 +0200
Message-ID: <10572828.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To prepare for a subsequent change that will switch over the thermal
core to using a mutex guard for thermal_list_lock management, move the
code running under thermal_list_lock during the initialization and
unregistration of cooling devices into separate functions.

While at it, drop some comments that do not add value.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/1822468.VLH7GnMWUR@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |   64 +++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -965,6 +965,20 @@ static void thermal_zone_cdev_bind(struc
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
@@ -987,7 +1001,6 @@ __thermal_cooling_device_register(struct
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos;
 	unsigned long current_state;
 	int id, ret;
 
@@ -1054,16 +1067,7 @@ __thermal_cooling_device_register(struct
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
 
@@ -1274,38 +1278,42 @@ static void thermal_zone_cdev_unbind(str
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
 




