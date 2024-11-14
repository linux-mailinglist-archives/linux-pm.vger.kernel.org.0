Return-Path: <linux-pm+bounces-17566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88AB9C8FB5
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FA1F2184F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE856198E9B;
	Thu, 14 Nov 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lDxfjffK"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7E1990CE;
	Thu, 14 Nov 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601520; cv=none; b=OHyaIXy/Ac6NtMMfUl5iWd1qfVSPH/xRuQwRRl++9XPqETPSlkFz/7MIdtmcRD0en240mDYwOsECB8RujY3j1XoTxlALe1z5+JIhyaw+VptTqO+lqhXThyW2fODYHvbl61Xdf9lc9r+40/6U0tq7xLli6TJtqF7j1kF3Y8UcyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601520; c=relaxed/simple;
	bh=HIhFtVC67XZTLBR55y/ol83UpV/3VL2tA6VCAsKRWgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GNXPZIIOnRvQFio5Ry1RU523Nsss2r7ZtUCPGx00d8q1x3U6xszDQiy5+2ZlhH69uqqOV98kD76cC9CykkAfx2U03Dt/yWWHhxI/ggstT8SdlScXca6ZVY1MWWvWsrvNdwsmh4K52SK8Scytco41TXxsk5eyL3ZnzoP/25sIIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lDxfjffK reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 0351580d4d3771fb; Thu, 14 Nov 2024 17:25:10 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 20180665CF6;
	Thu, 14 Nov 2024 17:25:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731601510;
	bh=HIhFtVC67XZTLBR55y/ol83UpV/3VL2tA6VCAsKRWgk=;
	h=From:Subject:Date;
	b=lDxfjffKTX3F0iZ1GW80YF8W1HwRKAEQ3EGziBA2fdMBw+Y5+8c5AKHd0Pm0wvwhD
	 KtZPUi1ZpkI4QPoPNNZ6At5E4OuVCYU2xRKOJhZu3sqKVK3dtywH7kqrOXuXpNPBvw
	 NIdhr11CuorfiKFaUY0CdOUZDREkvb+FgKN1B7rFRA2Vc2IB2fPnkVglCgbLAOF1lC
	 S6m07EcHTgUlY5dLDe7/pX2xvUVKWgxjc5MEfX+ZoWF7l5VbVtLp7BydRdtkNza5I7
	 V4gERccc7+mua9yMJ9Ri/XmFLR7Onr+r/AdzarqU+I/eyxhS6MPGTKr1EeHuqCKzqC
	 cQFGm/4Bbm31A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject:
 [PATCH v1] thermal: testing: Initialize some variables annoteded with _free()
Date: Thu, 14 Nov 2024 17:25:09 +0100
Message-ID: <12576267.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 0; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Variables annotated with __free() need to be initialized if the function
can return before they get updated for the first time or the attempt to
free the memory pointed to by them upon function return may crash the
kernel.

Fix this issue in some places in the thermal testing code.

Fixes: f6a034f2df42 ("thermal: Introduce a debugfs-based testing facility")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/testing/zone.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/testing/zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/testing/zone.c
+++ linux-pm/drivers/thermal/testing/zone.c
@@ -185,7 +185,7 @@ static void tt_add_tz_work_fn(struct wor
 int tt_add_tz(void)
 {
 	struct tt_thermal_zone *tt_zone __free(kfree);
-	struct tt_work *tt_work __free(kfree);
+	struct tt_work *tt_work __free(kfree) = NULL;
 	int ret;
 
 	tt_zone = kzalloc(sizeof(*tt_zone), GFP_KERNEL);
@@ -237,7 +237,7 @@ static void tt_zone_unregister_tz(struct
 
 int tt_del_tz(const char *arg)
 {
-	struct tt_work *tt_work __free(kfree);
+	struct tt_work *tt_work __free(kfree) = NULL;
 	struct tt_thermal_zone *tt_zone, *aux;
 	int ret;
 	int id;
@@ -331,8 +331,8 @@ static void tt_zone_add_trip_work_fn(str
 int tt_zone_add_trip(const char *arg)
 {
 	struct tt_thermal_zone *tt_zone __free(put_tt_zone) = NULL;
+	struct tt_trip *tt_trip __free(kfree) = NULL;
 	struct tt_work *tt_work __free(kfree);
-	struct tt_trip *tt_trip __free(kfree);
 	int id;
 
 	tt_work = kzalloc(sizeof(*tt_work), GFP_KERNEL);
@@ -387,7 +387,7 @@ static struct thermal_zone_device_ops tt
 
 static int tt_zone_register_tz(struct tt_thermal_zone *tt_zone)
 {
-	struct thermal_trip *trips __free(kfree);
+	struct thermal_trip *trips __free(kfree) = NULL;
 	struct thermal_zone_device *tz;
 	struct tt_trip *tt_trip;
 	int i;




