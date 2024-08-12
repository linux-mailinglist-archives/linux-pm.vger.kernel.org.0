Return-Path: <linux-pm+bounces-12088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610E94EF0A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012FB1F22F5C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F62217CA1F;
	Mon, 12 Aug 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="i94VqTM2"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85B17C230;
	Mon, 12 Aug 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471181; cv=none; b=lHEOBGUfELFW6Tfm58bNpmIS+xgCiUKtCYffZ3KcVGI4l7rk3SK/uViQGYpO5gP1MxnQ0cUHaCUNy7cLFeUQB3nPDPAhmqZV+fc1itJSNrTOuRGLW3z1Of6FvtSGI0Lcsu2Mcf1pdrNqvjuKO4QO8HDj96QiNPD9OophVIE1pAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471181; c=relaxed/simple;
	bh=+LDp9pftu1CyEMR+OQOK9+1vnYCGty270st7d2AvTEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOejxZaxKSoQ7Y9nvUvjIaNCyLuHlzcMTYt9UxlNf+8peHcR5j64yjtMiuQ0iOin1o5ZgVBvPVywN7cDm1QiBkuWx1NyQBkeku7NndBhJHtuEwPrNmQl1KgnGGmHGpfvZ+c8AM/G3x1MZ7mxFgAGjaIRVn/QlgTcqk5noOy3/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=i94VqTM2 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 93076ac956817fa7; Mon, 12 Aug 2024 15:59:37 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 04A216F0D63;
	Mon, 12 Aug 2024 15:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471177;
	bh=+LDp9pftu1CyEMR+OQOK9+1vnYCGty270st7d2AvTEc=;
	h=From:Subject:Date;
	b=i94VqTM2R21uwP8Eaq91y5y4ifOgMBpGDFjv9mlyqMl8nEaIU1qsPJAyOePol5RUE
	 Jy2nXSt2EPcLzPEVQlZsmNO0RWpLMxzmRUa1cn/NMbBY560f+vT8gKtgJiWq0NzIed
	 h/Z2xg0k3s61dsbWOS7Ll2XrDvsLi6azXqzHqMvosaCJxzvL/JKUHShE8cFRjnSYt6
	 5vQ8BmPFCU7T3atwpPHRQdAYOn2Xqoclp1UghEiGvsXWYIfk5f1VRCLEq3KSUOlsML
	 cTvd/oadEXS6OJ0MpUonqM8HNuZJNmYo2hOpisH+IhZjRcab1UaErC6tPO790ix3TH
	 ju6GrchvqcGhg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 03/17] thermal: core: Drop redundant thermal instance checks
Date: Mon, 12 Aug 2024 15:54:36 +0200
Message-ID: <2157531.OBFZWjSADL@rjwysocki.net>
In-Reply-To: <114901234.nniJfEyVGO@rjwysocki.net>
References: <114901234.nniJfEyVGO@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the trip and cdev pointers are sufficient to identify a thermal
instance holding them unambiguously, drop the additional thermal zone
checks from two loops walking the list of thermal instances in a
thermal zone.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Fix typo in the changelog

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
 




