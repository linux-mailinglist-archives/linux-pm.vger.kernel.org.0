Return-Path: <linux-pm+bounces-12458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4C957001
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1631F1F218B3
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89165175D46;
	Mon, 19 Aug 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fls4rCyk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E316BE12;
	Mon, 19 Aug 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084101; cv=none; b=t1dCbmS8KWNsyZM8KnM3OveN0rR1c4J3oK0zbSTtNuCuXuPUVpioXG1yPB+U5G/RlTvyAePDUP3L5/74cQerXPzB9r/FBOA/iWbW88MhrGQq2BPDgitF6tAiAxyGu6p7Wx5f4V4gE7azatKAR1So7d63WwAwa2V0H5fDZhisAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084101; c=relaxed/simple;
	bh=HCgOWSQCCBzkeP3zaF6i9wijyR7clYrRmaAhKIl9ljU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVCu7cIGUdNqeUfFs7LuBPaJtuTh0cAc7fO0xf3ciL7R1+tK3lkNAekzC7NYNR7BA7XlZCLLu9pWQKl9On1tljQT+y+Wol/E3UuxRigVrIkNCpVcy0kzJXp/KOr4Le9yw1aabYu1UZumjirm8td/JWt6YIAC386ePGddikEisO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fls4rCyk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 4886f3b060cfae50; Mon, 19 Aug 2024 18:14:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D9E4273B5D8;
	Mon, 19 Aug 2024 18:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724084097;
	bh=HCgOWSQCCBzkeP3zaF6i9wijyR7clYrRmaAhKIl9ljU=;
	h=From:Subject:Date;
	b=fls4rCykyyEQsuo9Po7GrAwm6kvkHkzkoPPh1go2zGoUr1Y1zzREeW67zEbpjAeHW
	 QYTSTjpbHYAZL32wvDshdhk/xIwycMDt42HSChKB1ELpUmfYGkcDgCMPWxHLUMOXVi
	 81fM5nH2Wky0eu41xfiXOqSwgjQqYD5+9jcyrGrktFcBS5s4ttiVc81W9G/4XPWHyf
	 gYR/pI9QdtcIxfYJt7aty8eO8eZJvb3OWCchvx2bo6D0nwQVk7RvthniYlf2nrEYP/
	 ddfCl5K0F1LKcILWfoLIfiyM2ikYNggpBXNJN9EPTClEyb3SI81bE94K8Uz24cLNGJ
	 7Xr7kKV6ZMGAg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 03/14] thermal: core: Drop redundant thermal instance checks
Date: Mon, 19 Aug 2024 17:52:54 +0200
Message-ID: <10527734.nUPlyArG6x@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the trip and cdev pointers are sufficient to identify a thermal
instance holding them unambiguously, drop the additional thermal zone
checks from two loops walking the list of thermal instances in a
thermal zone.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

---
 drivers/thermal/thermal_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -850,7 +850,7 @@ int thermal_bind_cdev_to_trip(struct the
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+		if (pos->trip == trip && pos->cdev == cdev) {
 			result = -EEXIST;
 			break;
 		}
@@ -915,7 +915,7 @@ int thermal_unbind_cdev_from_trip(struct
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+		if (pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
 			list_del(&pos->cdev_node);
 




