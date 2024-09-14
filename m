Return-Path: <linux-pm+bounces-14267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF4979025
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958E81C22CB3
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D11CF2AC;
	Sat, 14 Sep 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vl51TOjn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6577115;
	Sat, 14 Sep 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311490; cv=none; b=YnCZkg/BQeMCRLwrnHIucHV7cP6ayhnMTXG72R9GNhg4QoAYyb/WCi2qqcSWo1YX/sc6x9V0owgwHlNXINP5BlhIx6knbdPElSGnmceT3Ynhe5J5GdS7jAjLaFV1GGAH4J06dMHP+MHM612xJCy08BCINyshdH6XxBNNRP6j8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311490; c=relaxed/simple;
	bh=d6kU/oDJbmlVAoois5dft3LLP1DBvbyCs5QgRNeLxLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHAH/31lMxWP2zqbye/6w+MV6k2zplbE+42sVR/KNDEhkRP8zU8FhdR/yBn+iXghtBciPFBwpP0uS5aSRwL1Oomstp9v9I55g4kED2NsAls2XSQ8b4hdpTVgUquYtpujtRoK/ykSuRvQ4uE4FVAfKV+WeukFO1HlEyghl3SNpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vl51TOjn reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b2a62219cf34ebf7; Sat, 14 Sep 2024 12:58:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6A62A8532AE;
	Sat, 14 Sep 2024 12:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311485;
	bh=d6kU/oDJbmlVAoois5dft3LLP1DBvbyCs5QgRNeLxLo=;
	h=From:Subject:Date;
	b=vl51TOjnvw5xUW8pIgbYl4KcgamVpjZpwDHtxYx/Zul8iY32SGr1lSBchb43JfPVN
	 8T2C+wrkIKJk8TPtLTKGhcCPfkjJS/xRHdeAz1YSPn4ReKPHMgoaY2YCOlnIGwl38z
	 We70Y2Fq/oDatKaIpOgOOk0DzASG9mB2WJn33XRp+cqDlCMKA+yRZ0gJ/TVsOOsEKe
	 KkdLPE1L6yFykZH0IvA8hgcXEsrtMdQm81NEtc26VXHH0nh5H3udGip8h4D1+j58ey
	 Y4bQf26d+fuM0HUj/JFGJn20xtFxvw3dVzIfCqxmabFbbLpka+87Ml/xEAmIb52EN3
	 YUCd8zG+b2e+g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 13/20] thermal: core: Call
 thermal_governor_update_tz() outside of cdev lock
Date: Sat, 14 Sep 2024 12:41:54 +0200
Message-ID: <1921484.CQOukoFCf9@rjwysocki.net>
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

Holding a cooling device lock around thermal_governor_update_tz() calls
is not necessary and it may cause lockdep to complain if any governor's
.update_tz() callback attempts to lock a cdev.

For this reason, move the thermal_governor_update_tz() calls in
thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip() from
under the cdev lock.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -825,13 +825,13 @@ static int thermal_bind_cdev_to_trip(str
 	if (!result) {
 		list_add_tail(&dev->trip_node, &td->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
-
-		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 	}
 	mutex_unlock(&cdev->lock);
 
-	if (!result)
+	if (!result) {
+		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 		return 0;
+	}
 
 	device_remove_file(&tz->device, &dev->weight_attr);
 remove_trip_file:
@@ -866,9 +866,6 @@ static void thermal_unbind_cdev_from_tri
 		if (pos->cdev == cdev) {
 			list_del(&pos->trip_node);
 			list_del(&pos->cdev_node);
-
-			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
-
 			mutex_unlock(&cdev->lock);
 			goto unbind;
 		}
@@ -878,6 +875,8 @@ static void thermal_unbind_cdev_from_tri
 	return;
 
 unbind:
+	thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
+
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);




