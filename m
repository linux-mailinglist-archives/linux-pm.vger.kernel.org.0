Return-Path: <linux-pm+bounces-15506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B999951C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE779284CF9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D481E906F;
	Thu, 10 Oct 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="p6vxYdUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E01E2029;
	Thu, 10 Oct 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598959; cv=none; b=BZegMlteA1X9MCJjQkEWT+ZE9C83dOAA3eDAGCMnavb/sbWbe71aT8YH3T6+Vx6JAVXWkuiCs99qnaGtTeTfIxQCk8iyRB+1YxiL1FN38NGWo5ffob61nEQn7koiU6drBOelP7xb+QXCKlMGYGtQNAcAeOXqunIjQs8xPQ1bJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598959; c=relaxed/simple;
	bh=xjilEsLX+G8kf8JRPFeXyzM3RwuC/YiY5ih1BDEWdZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlB2V7NPCPma6ZlME0vDvUkDkbHKwd0u4RUQ5OzBDZMvsFuSNE/Bkh7TSEtSYsJAIri1nRYGi6bHRWta0i7reilAXdK3g+FLyLnQDNpXvuoZmWHzIKgiy8KyOlrVNzo0AVMyAnH+8aJznP5VuiBoXkp3myeiDwlzwxU/ECfDoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=p6vxYdUn; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c8883fc4938e307c; Fri, 11 Oct 2024 00:22:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DED5C69EF02;
	Fri, 11 Oct 2024 00:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598947;
	bh=xjilEsLX+G8kf8JRPFeXyzM3RwuC/YiY5ih1BDEWdZ0=;
	h=From:Subject:Date;
	b=p6vxYdUnrVEzbz4V31Kv3NQtX+8J6yRyETKOqnwQho8ukgmFBm6vKaVPJRs2OrEde
	 99eEJHq1+7CTE6Cm+pf1R2dWMUbTbKFKmtZVkmqJj+PI1kqpNiPr+Gzh6FT3aRMF6N
	 YyYmQ4NaEb2zHnGQfSPNI3mJsHHQnoho0vKBTQnDjuMUyNbQzbEEoYQpi1WymRvcP8
	 fECHN3ucBI0hDUxu4EZsOTfx3nrAzhjktPCVxHuTSjPR8P92xisROM0PSNozWRdPNv
	 zAYfcTVp1cij6XGtwlXLWofBLdElCAEpFOaKopPB62H3CPC1pW1wlk5zzrwc2q2O0n
	 UGOmJUgUo7w9Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 07/11] thermal: core: Introduce thermal_instance_delete()
Date: Fri, 11 Oct 2024 00:15:22 +0200
Message-ID: <3275745.5fSG56mABF@rjwysocki.net>
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

It is not necessary to walk the thermal_instances list in a trip
descriptor under a cooling device lock, so acquire that lock only
for deleting the given thermal instance from the list of thermal
instances in the given cdev.

Moreover, in analogy with the previous change that introduced
thermal_instance_add(), put the code deleting the given thermal
instance from the lists it is on into a separate new function
called thermal_instance_delete().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/2224279.Mh6RI2rZIc@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -866,6 +866,17 @@ free_mem:
 	return result;
 }
 
+static void thermal_instance_delete(struct thermal_instance *instance)
+{
+	list_del(&instance->trip_node);
+
+	mutex_lock(&instance->cdev->lock);
+
+	list_del(&instance->cdev_node);
+
+	mutex_unlock(&instance->cdev->lock);
+}
+
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
@@ -882,16 +893,12 @@ static void thermal_unbind_cdev_from_tri
 {
 	struct thermal_instance *pos, *next;
 
-	mutex_lock(&cdev->lock);
 	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
 		if (pos->cdev == cdev) {
-			list_del(&pos->trip_node);
-			list_del(&pos->cdev_node);
-			mutex_unlock(&cdev->lock);
+			thermal_instance_delete(pos);
 			goto unbind;
 		}
 	}
-	mutex_unlock(&cdev->lock);
 
 	return;
 




