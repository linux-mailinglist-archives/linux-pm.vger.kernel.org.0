Return-Path: <linux-pm+bounces-13945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793097343A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAA028CEEC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B354194C89;
	Tue, 10 Sep 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dD5Z2zPW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E3194091;
	Tue, 10 Sep 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964546; cv=none; b=A4LqECgEDyl7H6MERmll7l1nj2ZC/xLKCEao6E+ZMHSetQ6qBC0a532uvbc1nRq+rnqUCjYG6ea8nOe01PbZIWfF3IHNXhPhhSmmegFW+po/U3VDS9Zs0eAguJ9ULhAHJVjF11jGoFcTGMc01BonTI7RZvKnR5fNXQQzsSTYDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964546; c=relaxed/simple;
	bh=BFmiL4dTfjhPZodclFXsXNY9e9GWPt/7f2C7f21bUPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2XHYKeEHei977rvb3xyIiwbgqdEm8Ltu9R/kDyZxWOgdMV1u5SC+WEb2JSoBb+kOPykfC8f2f6OT3wIYaKuHm5G8QpVO+V+VYF1gGpPbJ5uiRRNBqYzaN5LE2NXFpER3LQTFCDjGqGa9i5DumcLS6bCzl6+sYDwbN0jNRLGpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dD5Z2zPW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a006a526e2ca53cc; Tue, 10 Sep 2024 11:35:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 82EC46B836A;
	Tue, 10 Sep 2024 11:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725960941;
	bh=BFmiL4dTfjhPZodclFXsXNY9e9GWPt/7f2C7f21bUPw=;
	h=From:Subject:Date;
	b=dD5Z2zPWRS4tv6EACgZN9J26dvmEX7T9DOGkntPCkseWCjrESwxvixNpM7TyxArF3
	 daPo653wQ0sNum3oCgMLJYI4mtbxERRO2XHzvtAlyfYceZ2dBR/ML1nKZeBg/K7WIx
	 pFQHbaP4dn8GybCYZSSbgSVjk+ccQiynNumJXPGGjEhUPVr1o7Vm9i52u509QGzGqo
	 fhQHwnAJ2fnMy1XmVAAALkcWHpFzhfL+Jv3sS2a3iMg1kDIec46XMu2ZyPZsDD3319
	 +he5BJF9n6HrO4JHf67E0q9CZbLBJvp+Lne/GC3SP8abxLKI5wfSlQ7t4CD2YaFblO
	 kLlu50OvPjM/g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 5/8] thermal: core: Rename trip list node in struct
 thermal_trip_desc
Date: Tue, 10 Sep 2024 11:32:10 +0200
Message-ID: <1978487.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <4920970.GXAFRqVoOG@rjwysocki.net>
References: <4920970.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the list node field in struct thermal_trip_desc is going to be
used for purposes other than trip crossing notification, rename it
to list_node.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   10 +++++-----
 drivers/thermal/thermal_core.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -426,13 +426,13 @@ static void add_trip_to_sorted_list(stru
 	struct thermal_trip_desc *entry;
 
 	/* Assume that the new entry is likely to be the last one. */
-	list_for_each_entry_reverse(entry, list, notify_list_node) {
+	list_for_each_entry_reverse(entry, list, list_node) {
 		if (entry->notify_temp <= td->notify_temp) {
-			list_add(&td->notify_list_node, &entry->notify_list_node);
+			list_add(&td->list_node, &entry->list_node);
 			return;
 		}
 	}
-	list_add(&td->notify_list_node, list);
+	list_add(&td->list_node, list);
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
@@ -596,10 +596,10 @@ void __thermal_zone_device_update(struct
 
 	thermal_zone_set_trips(tz, low, high);
 
-	list_for_each_entry(td, &way_up_list, notify_list_node)
+	list_for_each_entry(td, &way_up_list, list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, true);
 
-	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
+	list_for_each_entry_reverse(td, &way_down_list, list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, false);
 
 	if (governor->manage)
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -29,7 +29,7 @@ struct thermal_trip_attrs {
 struct thermal_trip_desc {
 	struct thermal_trip trip;
 	struct thermal_trip_attrs trip_attrs;
-	struct list_head notify_list_node;
+	struct list_head list_node;
 	struct list_head thermal_instances;
 	int notify_temp;
 	int threshold;




