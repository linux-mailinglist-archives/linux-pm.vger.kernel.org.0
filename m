Return-Path: <linux-pm+bounces-14273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288EC979044
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97808B20EA0
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6CC1CF29F;
	Sat, 14 Sep 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nrYeQpi5"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508A1CDFD5;
	Sat, 14 Sep 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312030; cv=none; b=GODhNhIKEuMxdhklRLJ27SNrc8jHaJMAxlwz7eoj7yQvtDCEBi8mnNOdlOhVPhAWahqzk3FbySlfBd97KdnzkLs/z6BnjLwmEp7VaEHLyQje5DxAVuUWu1ieYLV1+NiedbtBI4Dn+RquJq4kkjFW0Ei26nhuMeHyML2wqFjUszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312030; c=relaxed/simple;
	bh=pbuB+DXAFqYaCx2qxAElUt1m641oVTnWEEOF+ktc0N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIAdITGcrMdEk/trDc65TrlAGnSUIER5Ib09HIvSiqdX7SUxcS7FVGpa9zsTPOtAXitC/xpIx2MXtMUP8X0Z4BJhUt66/a/IaWaMaXqTAsXpa6//h+019klgwlPPGy26KFMCz2ss+qGFz34ZN5Dmra/vixwXLvdar1lDvaYb7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nrYeQpi5 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9133f7438f486c6e; Sat, 14 Sep 2024 13:07:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7C1708532AE;
	Sat, 14 Sep 2024 13:07:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312026;
	bh=pbuB+DXAFqYaCx2qxAElUt1m641oVTnWEEOF+ktc0N0=;
	h=From:Subject:Date;
	b=nrYeQpi5LSq/fe7en8vGuGm80zICtUU24v//RZboPJ7n3YZ36Vi6SSrzzGzmY7ms8
	 k1lEIQLPKGm6evkgAIfkXQoMv/eJF581EeHBz31P09b2XJUa1spHzonQEQ9rZo52eA
	 gK5A88p4prxIMjoF5BuN2IE5KGRdKtpyalcNitebTGoV9lWGbDhuJDaWU+yeQ0+227
	 ps/lUT1yT3vDUATYK/cvN4W+IoSv/VArvoHFvKKax29ZhlfprXo81qesg+HrmqybFi
	 Mgu0eNFWEGKj9xjTTaqAYDuWu3sRY/RueQySo0EhKRh/31UF4EUCR2l9yl3pV0jntC
	 vwPgBhSw8mtCw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 07/20] thermal: core: Mark thermal zones as exiting
 before unregistration
Date: Sat, 14 Sep 2024 12:34:06 +0200
Message-ID: <1997536.PYKUYFuaPT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=30 Fuz1=30 Fuz2=30

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with a previous change in the thermal zone registration code
path, to ensure that __thermal_zone_device_update() will return early
for thermal zones that are going away, introduce a thermal zone state
flag representing the "exit" state and set it along with deleting the
thermal zone from thermal_tz_list.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    5 +++--
 drivers/thermal/thermal_core.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1563,10 +1563,11 @@ struct device *thermal_zone_device(struc
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device);
 
-static void thermal_zone_del_from_list(struct thermal_zone_device *tz)
+static void thermal_zone_exit(struct thermal_zone_device *tz)
 {
 	guard(thermal_zone)(tz);
 
+	tz->state |= TZ_STATE_FLAG_EXIT;
 	list_del(&tz->node);
 }
 
@@ -1594,7 +1595,7 @@ void thermal_zone_device_unregister(stru
 		return;
 	}
 
-	thermal_zone_del_from_list(tz);
+	thermal_zone_exit(tz);
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -65,6 +65,7 @@ struct thermal_governor {
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
 #define	TZ_STATE_FLAG_INIT	BIT(2)
+#define	TZ_STATE_FLAG_EXIT	BIT(3)
 
 #define TZ_STATE_READY		0
 




