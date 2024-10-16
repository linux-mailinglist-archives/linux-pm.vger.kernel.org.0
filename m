Return-Path: <linux-pm+bounces-15767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834779A088B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337F61F23A3E
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97898208D71;
	Wed, 16 Oct 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ovtVzU9e"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA0207A10;
	Wed, 16 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078633; cv=none; b=ljt7rXLJJGftmn9yAInl5Txzut9U/nIMK7qikJaR2cLNL7R4uRuUbkfQlhAOP0GQ8fwDn/xhTffN9rFBuLAFO/jgVt4YNVddIlOIEescKM+vXUeG7ULu7IMcnEbcZfyineNJbN/v4Fyo3YXW50a9EVdpqeY4QS711oscI40nNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078633; c=relaxed/simple;
	bh=+IWjNL+/5z93DZM/IY4hMGHmNMClcNBj981ne4LwJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL+iw01aTNvzYil8NBtjTYdUJ48MXbMyvqbJLOHBWyJqcqOlwt5jeb8LwkANvQYh5e3+te5UK50jFq4mSQ8JkfhBD90JEFJDUoJYZNh5gy5O4MyUXkidREpNbQ7UG80k/as16AyK/1ricSinFVEhIhKiYkdN4SlQRNb0yI9TQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ovtVzU9e reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a5553dbf070f50d8; Wed, 16 Oct 2024 13:37:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AF3ABA93969;
	Wed, 16 Oct 2024 13:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078622;
	bh=+IWjNL+/5z93DZM/IY4hMGHmNMClcNBj981ne4LwJMM=;
	h=From:Subject:Date;
	b=ovtVzU9estYbvNQk7wC7k0jNYU5xWz+7hDcNjG0pOvwv/ZJYZBakyXNguY9sS8EEU
	 ZcS0gPW5xhZt319QC08DCC7+8oSTb3rXppNLchmc8hkkFyQVQ4JKxUoWX6Z9t2qTVL
	 oqf5inLJjUL52eZM7bvcp7JDyIMBCDcvwLqKrfx3HZ8jdgAmkSx1deIkGhpsBsDUxP
	 zxUoGxu0Qg0L345YAVWKLxyFshg3tTQGnceq8k4efDOr7doz7skFf/gt8xxVBu716C
	 trIUQMupulYjyVrqnTyy4vHtgqRSA8Ij7AxzbbibigBBHJjP/QmxP3kjJ0i6IG4zGL
	 DBi4YoWZj2rvg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 02/10] thermal: core: Rename trip list node in struct
 thermal_trip_desc
Date: Wed, 16 Oct 2024 13:23:27 +0200
Message-ID: <2201558.irdbgypaU6@rjwysocki.net>
In-Reply-To: <4958885.31r3eYUQgx@rjwysocki.net>
References: <4958885.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the list node field in struct thermal_trip_desc is going to be
used for purposes other than trip crossing notification, rename it
to list_node.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   10 +++++-----
 drivers/thermal/thermal_core.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -414,13 +414,13 @@ static void add_trip_to_sorted_list(stru
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
@@ -586,10 +586,10 @@ void __thermal_zone_device_update(struct
 
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
@@ -31,7 +31,7 @@ struct thermal_trip_attrs {
 struct thermal_trip_desc {
 	struct thermal_trip trip;
 	struct thermal_trip_attrs trip_attrs;
-	struct list_head notify_list_node;
+	struct list_head list_node;
 	struct list_head thermal_instances;
 	int notify_temp;
 	int threshold;




