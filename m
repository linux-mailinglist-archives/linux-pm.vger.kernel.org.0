Return-Path: <linux-pm+bounces-12893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCEF95F6F4
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF87D1C21EA9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD8197A7F;
	Mon, 26 Aug 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qwFsMVXN"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE353197A7B;
	Mon, 26 Aug 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690562; cv=none; b=TUQcYY4WVOWKA2umOdCHhlNEEk7OWRnACisKz+Xed7mSOtwUHjt8eXDUMAur8s3PvDgTOHvGJuaC3LINJ8HATr3sTh571YxfAit+89YNGYRwbDTaaZ/v96EgtMWyAIkq4DPj4BNFgUKHnEe3rDNkd8l/rLlugN/dccrRKNpH3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690562; c=relaxed/simple;
	bh=yjDrcAP6qTSEx6Q/HdDxHt9ilmkpo2bKge5/Yiqn7Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXUPpkKkX+rQUWvO0dzb6wfcBSxp7HD8J17RC/kuqW5R5cHpHeYLPjHrypAMTLYcdMaEKddPUBvy2K6d7Epq6VtMnJosX11KzWvSGVduqgBzEZr2IATm0j/ln2cvmHg1att1b2FUe03iF5cVspelRmjy90p4ns6CI1uqFixXnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qwFsMVXN; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 42adb13f24de3ae9; Mon, 26 Aug 2024 18:42:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7907C921951;
	Mon, 26 Aug 2024 18:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724690558;
	bh=yjDrcAP6qTSEx6Q/HdDxHt9ilmkpo2bKge5/Yiqn7Cg=;
	h=From:Subject:Date;
	b=qwFsMVXNgrDNm/fqHYbXcgUlUaJCZiq3HviQwpqTZiIWtiy81AuJwXwBnW02Ei/iN
	 8q9cUZFnQTacM/DKRQhTDZf39JyME3o9GkZjXJkj/XTK5PoWvp0Ue9ZM+XlA2pCciT
	 w3J7i7fzXN3wtzNbXA169nCCHu0JTeibKLJW88cM0/QruzKumLRRNnSHw1xUQNcvCe
	 K9zA4PYFvQ/e9VuJN5i0vLRZrFxw/9pKn2ldVuUi0+cL60BJaZO5iW0xBD/ovmsSzy
	 Nh+mCqkX+gtC58JJGOBEoTnTdhBwY9XjXYb4UcHU/0m0MYruJp4Kaq8+5ZgVoAwtsY
	 +eZw+ViT48Bgg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v1 1/4] thermal: core: Drop redundant lockdep_assert_held()
Date: Mon, 26 Aug 2024 18:30:42 +0200
Message-ID: <3341369.44csPzL39Z@rjwysocki.net>
In-Reply-To: <2979211.e9J7NaK4W3@rjwysocki.net>
References: <2979211.e9J7NaK4W3@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhhuhhishhonhhgsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Along the lines of commit 24aad192c671 ("thermal: core: Drop
redundant checks from thermal_bind_cdev_to_trip()") notice that
thermal_unbind_cdev_from_trip() is only called by
thermal_zone_cdev_unbind() under the thermal zone lock, so it
need not use lockdep_assert_held() for that lock.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -891,8 +891,6 @@ static void thermal_unbind_cdev_from_tri
 {
 	struct thermal_instance *pos, *next;
 
-	lockdep_assert_held(&tz->lock);
-
 	mutex_lock(&cdev->lock);
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
 		if (pos->trip == trip && pos->cdev == cdev) {




