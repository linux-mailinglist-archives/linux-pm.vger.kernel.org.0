Return-Path: <linux-pm+bounces-10716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC3928DE4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 21:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA33BB20F69
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13D71B25;
	Fri,  5 Jul 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Fdx95Ees"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78681E;
	Fri,  5 Jul 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208797; cv=none; b=Yo//TvCg2L3XMGF/AKhXckSmb2H4yx0upm591eIipworz5dpN0XO+tYqBBcv3rMLcDB6rQM/Vagxk1v8dmYHL8zQZVZDfYyrDm0GMtkrNql16mHOIuzY5IAzOZyQFl8/RoeEmlzCxDlIdnsPTk/cKiwzU01qPDsySz6sD0k5d40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208797; c=relaxed/simple;
	bh=+Hnc0W3VFjT04dRzb+V+EIXQp3/8mibNcLKXb6XAYuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoIUFwdOn1YPHocW8yTwMxP7CHmC1X2IA4wjzPMD25mKXJrg6ICAS1DaizLYWlTNuCRqFad1xDyC61H6mc6r3sNa8AJBBBtGd9ssvFoZwNxhtLxMSd3+NTol7i1zuz0eihd0t+Eb21esoGzMFV8a901oDoLVdXdG8RudfSlF2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Fdx95Ees reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 512e5ef9af243a9b; Fri, 5 Jul 2024 21:46:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 91CB27F5774;
	Fri,  5 Jul 2024 21:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720208793;
	bh=+Hnc0W3VFjT04dRzb+V+EIXQp3/8mibNcLKXb6XAYuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fdx95EesRkYkh3+t2/+muioHxJMN3+RXFdvWR1waKCe7FSL6WDa6wjMqTYkXrIsbw
	 w5XULUwxQsrOORKTOz7PZZV+apYHSTdP921CwHCzrxVRsACkf0heX0GiiQSLeeRzEt
	 RNPE+O7oOoOsw3G7c6Usq5S4y4GTXa7LcDaCHVitB+YJxNF0NtoKzc5L3UV5Iv2vp7
	 OJE0IbLWJRn7LIT2ZVhDB7xVv1zYNra4EcsycIJQ+4QL30jwql6b1zCcPtbjcIyA3V
	 lYSaDo/bhKbEOc6hGPouDi8UumIrsB2jbt6Dn8PMPX1hrogRxxb3rBvLNIWVMw7tUb
	 YDwY/bhlsVJjA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v2 2/2] thermal: core: Add sanity check for polling_delay and
 passive_delay
Date: Fri, 05 Jul 2024 21:46:26 +0200
Message-ID: <4940808.31r3eYUQgx@rjwysocki.net>
In-Reply-To: <2746673.mvXUDI8C0e@rjwysocki.net>
References: <2746673.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If polling_delay is nonzero and passive_delay is 0, the thermal zone
will use polling except when tz->passive is nonzero, which does not make
sense.

Also if polling_delay is nonzero and passive_delay is greater than
polling_delay, the thermal zone temperature will be updated less often
when tz->passive is nonzero.  This does not make sense either.

Ensure that none of the above will happen.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: The patch actually matches the changelog

---
 drivers/thermal/thermal_core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
 		td->threshold = INT_MAX;
 	}
 
+	if (polling_delay && (passive_delay > polling_delay || !passive_delay))
+		passive_delay = polling_delay;
+
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
 




