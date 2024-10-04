Return-Path: <linux-pm+bounces-15167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D9990FEC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D812E1C22BC6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A51E261A;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UflJ92E+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E61E04B5;
	Fri,  4 Oct 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070994; cv=none; b=B9I+fMp5Ym6uWFjYzIaq7UOza2vXDDVDTa9KfzgnADE+5/SrehYlGAimrDCObb3fb0Bpo4XYT8H8YYpRX0GstmSivnasqE4XYtPcSM+66+u7uqdx+9L6wTBbP1H2SabuKmBHM2SlBQjLFoJiRuR6np/BXNS9pC2ObNHehivRuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070994; c=relaxed/simple;
	bh=RvElTQ4H7eYyI818MMB6dDqmpeYAKR0WEPM4hHiWSvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWZktQDjEHbAw7F9OOyYCJMHzLO+gvBBqE1XqGZ0kOu1E9Gwww2pSn6WbaKdQZSrd7QPb0QssQ4nwQfxNFH9I2kSSuLh1hqcoxnT0SnuVjKFDvcXwAXnv72W6NJy7wlwXsss8MXAUPY0paqEtQqVq1H+PG5xUotxrkplICfmvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UflJ92E+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1513be72712f9a15; Fri, 4 Oct 2024 21:43:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B8E1D6A9505;
	Fri,  4 Oct 2024 21:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070984;
	bh=RvElTQ4H7eYyI818MMB6dDqmpeYAKR0WEPM4hHiWSvY=;
	h=From:Subject:Date;
	b=UflJ92E+eLG7fKwEKy1yaevWf95oFh2H+rnGalT/WErMcGGRSpFcazjgxB+mM8sN6
	 j+c+mJ282zOCWl7Kk+L1F/lPaDBDd2K63MVadN2h6fgH9aH7SR/bGVWmzyixECRT57
	 Wcms3kR3fBavqq8VBfeYylySFAuXkxG5tdHLpyq/0vvTUdvW7j6SSw6AG3BDRpYlF4
	 TvAmcO5typorXyXnnWVowj073og2Fvamfg/dFK9TZgyvUNyhx5Kq9VGV3WgeeTXeRM
	 qPE0HMBWhtfgbQEOPOhY2LTMNxotXaWcaBILvAR9UP/b+mEJ70FqwtFw4FeCVP7dco
	 1k3/4zGX0ttmg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 07/12] thermal: core: Mark thermal zones as exiting before
 unregistration
Date: Fri, 04 Oct 2024 21:26:12 +0200
Message-ID: <4394176.ejJDZkT8p0@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
References: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with a previous change in the thermal zone registration code
path, to ensure that __thermal_zone_device_update() will return early
for thermal zones that are going away, introduce a thermal zone state
flag representing the "exit" state and set it while deleting the thermal
zone from thermal_tz_list.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/1997536.PYKUYFuaPT@rjwysocki.net/

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c |    3 +++
 drivers/thermal/thermal_core.h |    1 +
 2 files changed, 4 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1613,7 +1613,10 @@ void thermal_zone_device_unregister(stru
 	}
 
 	mutex_lock(&tz->lock);
+
+	tz->state |= TZ_STATE_FLAG_EXIT;
 	list_del(&tz->node);
+
 	mutex_unlock(&tz->lock);
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -64,6 +64,7 @@ struct thermal_governor {
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
 #define	TZ_STATE_FLAG_INIT	BIT(2)
+#define	TZ_STATE_FLAG_EXIT	BIT(3)
 
 #define TZ_STATE_READY		0
 




