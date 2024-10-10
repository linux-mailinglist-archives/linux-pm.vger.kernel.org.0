Return-Path: <linux-pm+bounces-15500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBF999513
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC091C22B9C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F531E6310;
	Thu, 10 Oct 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="IB9tjF2x"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EE1E2849;
	Thu, 10 Oct 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598958; cv=none; b=FL0zcPrqMrD1yKADrSeq2rEyr4Ve700WeScZffLw2S47/lhcUGoOqOlZWWiwDP9ulZNuswaIxX8gKXk7LxLtzUQZDJipZHa4qsh1wWMYbW/zoiTe8+5KFuY7lMs4U1Z/heWrlwQtosnxGQlGeRlOuuKbTb4TwwiFD0m0htwg7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598958; c=relaxed/simple;
	bh=0xg0YJNIIEJ5JTLVeYlNX5t8osucXRuu0n2qu/DnKBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8EluVzloddG89eiMx8vYbLo02iJkDBlb/JZ4I8a0/ZJYntJEfepbJNseL9jqqbZ6/II2pxIdFYvFYfmAVhxuXKuTkxiHVPPtQnSXjDAE5ZN4th398RGM7+RN5oBDTjvIWwZIcufZITTqpH7rwBgf87d/ZHnh/IEvthXyzYq2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=IB9tjF2x reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id fc105c4cef1a743b; Fri, 11 Oct 2024 00:22:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A806369EF02;
	Fri, 11 Oct 2024 00:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598947;
	bh=0xg0YJNIIEJ5JTLVeYlNX5t8osucXRuu0n2qu/DnKBY=;
	h=From:Subject:Date;
	b=IB9tjF2xBSv11b9RcPYH68RwHxHKFgx9jQhYXoTgRRjCnNDuvzdhtLF7KoX6BK8pl
	 0x74k+kDunqPGRRYS5ozGmQfVKXAcmZkzGxBtBf9V6tnT+aAp/rv1AFjKEXqHxkAcg
	 0Y40qkWqy1qPOuC5EoNQ3AWTxS5B1l+1n9qRMsNj5rGHBmjUhoydWLMRYYMWyWJHVW
	 3KoDxxTTPgGYCPV92PkNaviJJWhw1coYMEIiIn6NCLz1S6KDDE3ob97IEV90Xy8jmD
	 MxLXq4FLEpTG2HRk2xJ1sYpSWDAdPt7c/KaJSKXICVfKyzp15gPrPw7s3Xo3inPhbh
	 mk9oWMxNlcMnA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 05/11] thermal: core: Call thermal_governor_update_tz() outside of
 cdev lock
Date: Fri, 11 Oct 2024 00:12:11 +0200
Message-ID: <7749552.EvYhyI6sBW@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Holding a cooling device lock under thermal_governor_update_tz() is not
necessary and it may cause lockdep to complain if any governor's
.update_tz() callback attempts to lock a cdev.

For this reason, move the thermal_governor_update_tz() calls in
thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip() from
under the cdev lock.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/1921484.CQOukoFCf9@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -832,13 +832,13 @@ static int thermal_bind_cdev_to_trip(str
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
@@ -873,9 +873,6 @@ static void thermal_unbind_cdev_from_tri
 		if (pos->cdev == cdev) {
 			list_del(&pos->trip_node);
 			list_del(&pos->cdev_node);
-
-			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
-
 			mutex_unlock(&cdev->lock);
 			goto unbind;
 		}
@@ -885,6 +882,8 @@ static void thermal_unbind_cdev_from_tri
 	return;
 
 unbind:
+	thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
+
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);




