Return-Path: <linux-pm+bounces-12459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447CF957005
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D411F23473
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19E15D5DE;
	Mon, 19 Aug 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fn6+SOUs"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0045014;
	Mon, 19 Aug 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084188; cv=none; b=rgSMC9owWwLsdELV0yH36s1ko8mh/8WWxM0Dxm7Ppn2bqM1K6Ruexxbpe83EnrxtfdckTiWdWgCNeVfE7rz2qdMuHrG1PLkIC7gbjATtPD8MZYBuNTa1ai+OqGfwEwMB37LCtP64X0FeqUswhclvNdPv5NqZiZ60bkTTyo7rlbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084188; c=relaxed/simple;
	bh=THPv9/fPA2QG12y+078bp8D4iXKn4j2zPQ/L+kYc2e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DklrjqzON638/87UI4t5wiGBB/6Ui1zUQIdDfcME2aMTwfZ7rXJg0LWAiJTx9Yqr75n2AD/UEo12a+Ib/t6tGrPasOrEfWSVamR0V+cHinG/wO1msgU+9QwfSL1d4ltAIDPwep+I5oytmUmBuMUnA5WCvdDaIHykuwuy7SYfjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fn6+SOUs reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id edaf8323739d5f8b; Mon, 19 Aug 2024 18:16:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 869BB73B5D8;
	Mon, 19 Aug 2024 18:16:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724084184;
	bh=THPv9/fPA2QG12y+078bp8D4iXKn4j2zPQ/L+kYc2e4=;
	h=From:Subject:Date;
	b=fn6+SOUs/WegDUBwVM572Dx+UR6kUxEIpQo/Azx5xzXHX2Z4dZAwkLs5cCB9LKczP
	 +YPP1wgtV142qENO9mMJduzX81RyI0XeR4ROAbFNrvoX7PQg7RSpDTVzbCcM8ONxYt
	 mkVajJzvj3RCK+/lR5sQXAgRIrh/VjPrrGTStXyFY0LHJgm5dPN4UYNiDtsUWkqicB
	 78mGl+sLmosumzmjglyIgxDnIqA1LEz5RG7IvnOfTx7KLlgj69SMS2wPyiii+dgFE4
	 8KmL0OhGaV4ZjN/ke4daCq69mb3/hiqwP0nBrg1P5O2JgAKFmI2ou4JF9q1J9ptCGa
	 l57YGADhlQQvg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
Date: Mon, 19 Aug 2024 17:51:36 +0200
Message-ID: <3324214.44csPzL39Z@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to look up the thermal zone and the cooling device
in the respective global lists to check whether or not they are
registered.  It is sufficient to check whether or not their respective
list nodes are empty for this purpose.

Use the above observation to simplify thermal_bind_cdev_to_trip().  In
addition, eliminate an unnecessary ternary operator from it.

Moreover, add lockdep_assert_held() for thermal_list_lock to it because
that lock must be held by its callers when it is running.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

---
 drivers/thermal/thermal_core.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -781,25 +781,17 @@ int thermal_bind_cdev_to_trip(struct the
 {
 	struct thermal_instance *dev;
 	struct thermal_instance *pos;
-	struct thermal_zone_device *pos1;
-	struct thermal_cooling_device *pos2;
 	bool upper_no_limit;
 	int result;
 
-	list_for_each_entry(pos1, &thermal_tz_list, node) {
-		if (pos1 == tz)
-			break;
-	}
-	list_for_each_entry(pos2, &thermal_cdev_list, node) {
-		if (pos2 == cdev)
-			break;
-	}
+	lockdep_assert_held(&thermal_list_lock);
 
-	if (tz != pos1 || cdev != pos2)
+	if (list_empty(&tz->node) || list_empty(&cdev->node))
 		return -EINVAL;
 
 	/* lower default 0, upper default max_state */
-	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
+	if (lower == THERMAL_NO_LIMIT)
+		lower = 0;
 
 	if (upper == THERMAL_NO_LIMIT) {
 		upper = cdev->max_state;




