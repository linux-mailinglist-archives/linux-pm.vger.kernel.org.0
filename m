Return-Path: <linux-pm+bounces-15164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13A2990FEA
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C78281774
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2A1E25FE;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FWl2ii+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A01E04AC;
	Fri,  4 Oct 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070994; cv=none; b=kfbFGBpstAc981T/rh+g041IcpwzxRJIqYS45qb51r6BIaZTZf1Pps5gozl0PzOiczNSBIV+ocg27stDs5L+PoqMD83z8dqDEh5Wcbe4Q8y6F/zpJqsvImu3iwC27sC0zBV58GxQK47ASstSmm5s42+6cxloM3UIrtJVEw4yLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070994; c=relaxed/simple;
	bh=SP2LqI+kjSAviE0zBp9D61PWBSCXxvORO4Tr/lochTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPUcTDSq88i08EFHoqz5ugD0d7qf2Ujs9ZG2KatZjY63UxFqNUi40tGmQpcS4nEFzq1tVEGDcNCUZna4etCx7r2oQ+CXvQhV1ErpfLHcMS3G3eO5wQZAA0eFcS4GgnY+KyqpZW70cKxvlO3yycHQvESnO50SnuUn8fCD4cZrbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FWl2ii+J reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3f226a37cbbad1de; Fri, 4 Oct 2024 21:43:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 692526A9505;
	Fri,  4 Oct 2024 21:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070988;
	bh=SP2LqI+kjSAviE0zBp9D61PWBSCXxvORO4Tr/lochTM=;
	h=From:Subject:Date;
	b=FWl2ii+JAWmGTQP/2/qeiLsYkth43Lr4+aQafeQ5EskioYc1Rp4CB47NfWxn9tyEM
	 jBtX4gaXAxpCJ9/r5E1fvnhId+gCFC0h/F+u32BENF+z8WugB6uTon964vZMBH9ZaE
	 /wXEXm4BqKmRRQvCm9emLMdi9Fnu78cY5/Wpi5x1LMDdWIdSRra4Qbk8azmnT3RM7o
	 jIcCPYnQFZZq4/xpMdrL/eXp4Nwpv+lAGFFbAFgnx0uyeM5nQ3UCVJwO9ZhN2O4j91
	 GLeJyLTO4Dn4ELXNJROm8dX2IjyD5Fj5m7bZbWXCzr+Vkmj5jKESAJ7eALYS9VBFwr
	 ys0skxZwvD4Dw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 01/12] thermal: core: Initialize thermal zones before registering
 them
Date: Fri, 04 Oct 2024 21:05:49 +0200
Message-ID: <3336146.44csPzL39Z@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since user space can start interacting with a new thermal zone as soon
as device_register() called by thermal_zone_device_register_with_trips()
returns, it is better to initialize the thermal zone before calling
device_register() on it.

Fixes: d0df264fbd3c ("thermal/core: Remove pointless thermal_zone_device_reset() function")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/10527854.nUPlyArG6x@rjwysocki.net/

v1 -> v2: Fix typo in the subject

---
 drivers/thermal/thermal_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1465,6 +1465,7 @@ thermal_zone_device_register_with_trips(
 		thermal_zone_destroy_device_groups(tz);
 		goto remove_id;
 	}
+	thermal_zone_device_init(tz);
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
@@ -1503,7 +1504,6 @@ thermal_zone_device_register_with_trips(
 
 	mutex_unlock(&thermal_list_lock);
 
-	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);




