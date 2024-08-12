Return-Path: <linux-pm+bounces-12089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36494EF0D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B59E1C21411
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F517DE10;
	Mon, 12 Aug 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gzDCXpcF"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88617C7B9;
	Mon, 12 Aug 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471182; cv=none; b=W7NfCRP9XGHcfFkkDbbzbJwqcifFwDfv3/jqGet+4fyoixwRIAb5i3kA9u8lFP92S3vP/WMulxkj+B23wieG9wwaZnhtatsr2iwHJCXP6lpd4YDRHtJImffhVuqBlWK0mQbo4DPIhgbURfXki4uvK73IJ9gohGgQ5fPiYoJzNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471182; c=relaxed/simple;
	bh=PQZfqROqtpDTEWyeo1BsXJCb+xzrICxEm9yickmYEKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL4myXs8QFCoBW9a6vf+8gl42z0AxzaeGi6mlWywCkLL2KGm0A075AWEKDq3X3a4iYKd98/cF1ic0mdHjpRCTAvcVM9er6iwHA+KkEdOOQ/qN/jvSyz0fE7bmQg9QSIWpl8DjWZLnbyaE4R5gSa6Yv/XjRcjI930I3/CoXGx2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gzDCXpcF reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 02ca37e7f5719184; Mon, 12 Aug 2024 15:59:38 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C0C136F0D63;
	Mon, 12 Aug 2024 15:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471178;
	bh=PQZfqROqtpDTEWyeo1BsXJCb+xzrICxEm9yickmYEKY=;
	h=From:Subject:Date;
	b=gzDCXpcFA1e9jQycMZijghwJ/fy0eVez37+T6OnkOhFogBRMbGkREOn5dCcqHPLF/
	 Xp3CD+tI5gtHlLSwxU1Xq7YZsl1KbIwiz5z8wAhy/JwDlGH4QJ+HeZso0a4h6VhKNU
	 UlyLCJ/8ezd4U5inFpJ2Ww8qIKGKzm+l2K+F3ywyQ9dGHrksqTBgbVKK1+qoVJ2ulX
	 wOarn8jLpNbzZo1Pbyox1Ui5m1IaDGvb3qFHlUzs3ZPWb+wUZqtjl2OIaU3eNvBfDz
	 gec+cm/Bp/OuBcWvueLT2cbuzlDY+8xQnTXMmLc0qRUQnpXabkcMNslxeKyOXPeosy
	 zDumjmCpv1acA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 02/17] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
Date: Mon, 12 Aug 2024 15:53:06 +0200
Message-ID: <5491953.Sb9uPGUboI@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

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

v1 -> v2: No changes

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




