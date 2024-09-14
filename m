Return-Path: <linux-pm+bounces-14264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4E97901F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B57A1C21829
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D671CEE80;
	Sat, 14 Sep 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GnQnfFlP"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBD1CDFC9;
	Sat, 14 Sep 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311273; cv=none; b=pdE2RwtfmZrsnrCttTgGt/bzG+2Qh83TGHhlD9enSVEVIs69X3SXBfLvVwoP8CC/UBWuxiwRWyyD746nPfrup4SkMfu1PDnYgdMjngEpGDj1Ifl0LMf+pnsz7dC3hx7wHDsflZ/MXGbx+dvelqrk5WQ4nQTNrY+q+1mpBvijozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311273; c=relaxed/simple;
	bh=Q1b4oAf4RY7+AGRjijufw8nL7I6skFPw85rKWRxfJdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnsnrFE10Fwxok0fOJSN/QzmHeCb2EvXvWu40uwde9hVWkodvs8R3qrhAy8J3CunM0sbAVE0yNPdadzCg1ECbQMGWV5fo1ucKTmpApUoRLwZQfomC37dKMOGLNCaZpSS42dEk8ElTNaMzogSCsUd5Pq+grlcgo0ZvwqpemSjiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GnQnfFlP reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c31bb94f3ee72160; Sat, 14 Sep 2024 12:54:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6206E8532AE;
	Sat, 14 Sep 2024 12:54:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311269;
	bh=Q1b4oAf4RY7+AGRjijufw8nL7I6skFPw85rKWRxfJdY=;
	h=From:Subject:Date;
	b=GnQnfFlP307Jkw2q9xleM2mO9gkuxmXqFifViaHZM2Vo7V7wKZreXfXiCXLrfc1+7
	 8GvagmfQS7XRMoSR74SZfJTe7KovWnYWwdzWiO5gm8DQRe3hFtLCpZlXI8KBfE2lfg
	 tTaEo4/sTKvyld4l0CEtsKCR3o5g/oxgZZtdM1nCUM5xNMwxkg4F450TGYDwzkG7uv
	 VNkm0cZOPRWzJomgHGdnmwMcpfRQeSfPhq48bTTxaFrF8xySUgGoBWmbuFqU2yKGcZ
	 ExpTx4anJ/aMEqiopEdFiOB3PvMQNsIALqGqCb4kb+4cAUsae/zxhOz0KZX/v7ci0A
	 XCbnoK5QQJ3fg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 15/20] thermal: core: Introduce
 thermal_instance_delete()
Date: Sat, 14 Sep 2024 12:44:45 +0200
Message-ID: <2224279.Mh6RI2rZIc@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

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
 drivers/thermal/thermal_core.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -859,6 +859,17 @@ free_mem:
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
@@ -875,16 +886,12 @@ static void thermal_unbind_cdev_from_tri
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
 




