Return-Path: <linux-pm+bounces-12767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858595BEED
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E31282724
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14931D1F61;
	Thu, 22 Aug 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="V0CVEONm"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93251D1F5B;
	Thu, 22 Aug 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354888; cv=none; b=gMS09JGLDyIX6JrGOcXQdWH/5JjXoGkp5ArjKzGcpos7WjzVAdSqmN5yPkXHTUWY/+XU1n3puZCQvSZOowcleiZHJv3ZH/I0FS9bC4oNyFN9kBWjlX0KFxQCDZBhJlWqk2ZdMy4N4LQJ71yoVhhgKcYyYeocmzsFYqhKMzjshfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354888; c=relaxed/simple;
	bh=O1LyoxRjSU7nj8gurish0iiSeLufBj+YJzvu5eUsPHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw5u3qrlMv+XjLOxwyPRm1DsTwEE8BJDQdDEVH6WEUQH+rxmNywmrNG0D0jdBAWbTx+6WrECoOVozXBTNMQzDTyJFUwGjy5Juk+oz7pMaMf4omrsGnrXhADyZI/b3FHRcl6SZMyCtGt3lPt7SPCfDwrdaxKEdYpvgC+Ge9kopfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=V0CVEONm reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 839bece893722ce0; Thu, 22 Aug 2024 21:27:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CF95F6F0E2D;
	Thu, 22 Aug 2024 21:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724354878;
	bh=O1LyoxRjSU7nj8gurish0iiSeLufBj+YJzvu5eUsPHE=;
	h=From:Subject:Date;
	b=V0CVEONmAZ0tODP2P7I1S77jldzH3jXIjJ+mWmbLbPKJX4YmVGu37ZKvcV/OuFJjr
	 JbJaIdPzLtdjep2072pYq68IBsh9++hv8qwhNHJdExpmWVj0Cg0kK6RRsQSvwNKwtu
	 fBARwMr+qVewze8On9MK1zTOK/twGx9qL3M1pEScbDHz+UqWC8/a/ANXS9K+MSfl56
	 qnCg0AzsTSqlqgCZuJq50zE1AeGU6uTt76nDESgxXSCvIpasi8IT7a/BuploVmYej6
	 /GzQlTGz072k6bxEHMMJWMCfQOFImemGR4Sh4NDBy0NCd2dnHCwqpPKzmPqnwa3Pa+
	 bzXSOnwY9lBVw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject:
 [PATCH v1 3/3] thermal: core: Drop tz field from struct thermal_instance
Date: Thu, 22 Aug 2024 21:27:06 +0200
Message-ID: <4934182.GXAFRqVoOG@rjwysocki.net>
In-Reply-To: <12516814.O9o76ZdvQC@rjwysocki.net>
References: <12516814.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdr
 lhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes, it is only used for printing a debug message
in __thermal_cdev_update() which arguably is not worth preserving.

Drop it along with the dev_dbg() statement using it.

Link: https://lore.kernel.org/linux-pm/4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    2 +-
 drivers/thermal/thermal_core.h    |    1 -
 drivers/thermal/thermal_helpers.c |    2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -213,7 +213,6 @@ int get_tz_trend(struct thermal_zone_dev
 struct thermal_instance {
 	int id;
 	char name[THERMAL_NAME_LENGTH];
-	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *cdev;
 	const struct thermal_trip *trip;
 	bool initialized;
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -181,8 +181,6 @@ void __thermal_cdev_update(struct therma
 
 	/* Make sure cdev enters the deepest cooling state */
 	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
-		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
-			instance->tz->id, instance->target);
 		if (instance->target == THERMAL_NO_TARGET)
 			continue;
 		if (instance->target > target)
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -792,7 +792,7 @@ static int thermal_bind_cdev_to_trip(str
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
-	dev->tz = tz;
+
 	dev->cdev = cdev;
 	dev->trip = trip;
 	dev->upper = cool_spec->upper;




