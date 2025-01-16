Return-Path: <linux-pm+bounces-20582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC9DA14253
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A65188A27F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81B231C8B;
	Thu, 16 Jan 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qLOskdVY"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E922D4C3;
	Thu, 16 Jan 2025 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055932; cv=none; b=DRE4kr1m51jVvL6B5Ssd2DmD4D+w/JQ32x8Q2Tk3TVc5St6byqqJC86++naYGAFDQvQv6dlMH6VbM2SVEKKk9aQVmeBv8/t9TarAReZQ9KX1HvCZuuDClM5yrazFvkXR9HAP85/ISHaOgZv7ag9u2die+jPhgvKQ91OodiUCIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055932; c=relaxed/simple;
	bh=InTjOGXMdMmWfQ1igh6UvrRsQ9+skFaRH4B8Xvqev9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQBKPlwkVImFiVQVLiVVPkFgpOHAFESSmZsQ83tZvazq2NO9JtMTFa5JNvD3k8T/PJi8qiaIUeEKxjbuej3p/oa+GOGeudkrXQyq+FuuHgRKzr2PydhTO8AJOVuf5T98HcPKtn6wA7Q94U1pBKOxyT9Qb02HVjyr7dGZUFcGWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qLOskdVY; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6fc857fda82aa2a0; Thu, 16 Jan 2025 20:32:08 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 67A0E8E0B61;
	Thu, 16 Jan 2025 20:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737055927;
	bh=InTjOGXMdMmWfQ1igh6UvrRsQ9+skFaRH4B8Xvqev9c=;
	h=From:Subject:Date;
	b=qLOskdVY12FqGyWfSBRbzSFqGZybaVLH53LmeUVw7Emqwut95VSUmy22GCui5UR9R
	 h+selmUSXkh8l+tXhcAmHmzMMA3E8zrt/hYZ95gE8LpRFAjFkz6wTPYWsDy7ROkPew
	 6eqyJA5w1EQUhSMQt8paXJMZP589hD4QsrStoK8ewKSu7d8REAtk6Q/tpOUbpIvAnJ
	 QwJjwzuNDsIB0WP6N1Qit3Fl5WUDwgEjaLYIv1NrogLxHXuRpkQB6mucGMQwlFTcM0
	 H4Gh8KpyjabDp4QdzrULwORtAVK41pxSgHCUWjiuWY9rOiIfc51PUOZ7BVAeJ4UM1f
	 ygnyBL9WjMX4g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 2/3] thermal: gov_bang_bang: Relocate regulation logic description
Date: Thu, 16 Jan 2025 20:31:11 +0100
Message-ID: <4987649.31r3eYUQgx@rjwysocki.net>
In-Reply-To: <2772026.mvXUDI8C0e@rjwysocki.net>
References: <2772026.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the regulation logic description from the bang_bang_trip_crossed()
kerneldoc to the preamble.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   43 +++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -7,6 +7,27 @@
  *  Based on step_wise.c with following Copyrights:
  *  Copyright (C) 2012 Intel Corp
  *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
+ * 
+ * Regulation Logic: a two point regulation, deliver cooling state depending
+ * on the previous state shown in this diagram:
+ *
+ *                Fan:   OFF    ON
+ *
+ *                              |
+ *                              |
+ *          trip_temp:    +---->+
+ *                        |     |        ^
+ *                        |     |        |
+ *                        |     |   Temperature
+ * (trip_temp - hyst):    +<----+
+ *                        |
+ *                        |
+ *                        |
+ *
+ *   * If the fan is not running and temperature exceeds trip_temp, the fan
+ *     gets turned on.
+ *   * In case the fan is running, temperature must fall below
+ *     (trip_temp - hyst) so that the fan gets turned off again.
  */
 
 #include <linux/thermal.h>
@@ -38,28 +59,6 @@
  * @tz: thermal_zone_device
  * @trip: the trip point
  * @crossed_up: whether or not the trip has been crossed on the way up
- *
- * Regulation Logic: a two point regulation, deliver cooling state depending
- * on the previous state shown in this diagram:
- *
- *                Fan:   OFF    ON
- *
- *                              |
- *                              |
- *          trip_temp:    +---->+
- *                        |     |        ^
- *                        |     |        |
- *                        |     |   Temperature
- * (trip_temp - hyst):    +<----+
- *                        |
- *                        |
- *                        |
- *
- *   * If the fan is not running and temperature exceeds trip_temp, the fan
- *     gets turned on.
- *   * In case the fan is running, temperature must fall below
- *     (trip_temp - hyst) so that the fan gets turned off again.
- *
  */
 static void bang_bang_trip_crossed(struct thermal_zone_device *tz,
 				   const struct thermal_trip *trip,




