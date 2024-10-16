Return-Path: <linux-pm+bounces-15763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58EC9A0881
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8DD1C2278B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1AB207A35;
	Wed, 16 Oct 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sQW3sOh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE2206E92;
	Wed, 16 Oct 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078631; cv=none; b=eaeT+6D9ST9QezK+SrrlxAvNAg8wtj/O/az5fvxjY9OVvwzDz5D1KD+6+n7buWod5n1ynS5FG7BO7sI7K8GA5xTee3VecsGtLYi97J1oKu7dOcGb8lJ7kd8ZRWf2S1JtdyLZOHXfIodnJfcU/wtAZ+MphxJmyOD45/hjawFqk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078631; c=relaxed/simple;
	bh=dhkcwHcy1qf8BqFwZpE/80n76Nr/JxMr0kW9TvKncw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ih+8nvS3GUxLltROaCF0uCDydh+smrQmg1BnhU6OCDS/aSkpJOizUUZ4YHqXlO0Vqpn+o4jlyA+ILAG3Q5vmi2U+lX5J1JUB/N4CpEhLGtuEtFy77mPGRfeScja21a7kwudl0mHO5thI1/g1EHJso4EHdCHTdiunhNRqO+9WsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sQW3sOh3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 4e92effa67a29842; Wed, 16 Oct 2024 13:37:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 04683A93969;
	Wed, 16 Oct 2024 13:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078622;
	bh=dhkcwHcy1qf8BqFwZpE/80n76Nr/JxMr0kW9TvKncw0=;
	h=From:Subject:Date;
	b=sQW3sOh36cP/a9wK3LE0GuzH9JIb5u32gEjEKLVOdjNfX4bMVtChEk3UpgFaxcBnl
	 n2QWUW9A5UEE3PPSVqQIQMakn4d75U2vAIRO1N+XzHaiT8zpRQG1KzzS18/wS0HRRo
	 jX7df9FyR/8KrDZ4ZkmNMAdGHZk7K+TZGpvR5UilYIFqP5gtDhRwhao5yFsEIs+m+s
	 q2D6aZlpU2ne9R4VNp4J9aCx7pxB5rPaHs2MHHUKxOtxXOCn/92IQ27RiXYPxgQEp0
	 MapYG00nLsRcQcN9grzmCD8BifGR9z/pmxmmTedrbBtJ/gyZXlHgj65stDKjjaxYzC
	 08mXPs6YpyXYw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 04/10] thermal: core: Rearrange __thermal_zone_device_update()
Date: Wed, 16 Oct 2024 13:26:20 +0200
Message-ID: <3323276.44csPzL39Z@rjwysocki.net>
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

In preparation for subsequent changes, move the invocations of
thermal_thresholds_handle() and thermal_zone_set_trips() in
__thermal_zone_device_update() after the processing of the
temporary trip lists.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -588,10 +588,6 @@ void __thermal_zone_device_update(struct
 			high = td->threshold;
 	}
 
-	thermal_thresholds_handle(tz, &low, &high);
-
-	thermal_zone_set_trips(tz, low, high);
-
 	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
 		thermal_trip_crossed(tz, &td->trip, governor, true);
 		list_del_init(&td->list_node);
@@ -602,6 +598,10 @@ void __thermal_zone_device_update(struct
 		list_del_init(&td->list_node);
 	}
 
+	thermal_thresholds_handle(tz, &low, &high);
+
+	thermal_zone_set_trips(tz, low, high);
+
 	if (governor->manage)
 		governor->manage(tz);
 




