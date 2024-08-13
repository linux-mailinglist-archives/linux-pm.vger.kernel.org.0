Return-Path: <linux-pm+bounces-12159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D69507A2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AA8B238F4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC2119D086;
	Tue, 13 Aug 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="V8tP2ChE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91516DEA9;
	Tue, 13 Aug 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559452; cv=none; b=tX32xZ2jBaA9Aj4ldPFLJE4obr09al50S57yFkg1ZtuPLrYr8NwO8rTc+DF01Q+BUg624kOxiVInYpk+HyZnGBtmE/DrKCuq3U+Bw6UlWC46ZqT5ONkgEvhwdQOFr6hdEeUYrdP3UGEcMBXVh/uz6K0OtMEQjIy44jMf9GvQxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559452; c=relaxed/simple;
	bh=G8ANgsojX6Q8Ryh6XWoRWtQeiZsBVAQMaxxk0GWN3t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItFCoCob7V2+QC+4MKCBME2hXhfNbgQDe4G4ZBiLQvuB1v30xXZwg/q55IWIbU4tjHfcgg9djmVM3fdbPfzRpdpVQtwM1ytbi/YE13NXSHYWz7DblAfrDoP+0mDe8MgQ81tMSwfRAJvuCe1x0eBX458094W4T1ThCoUWgHOLTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=V8tP2ChE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c89ba3403cdacc95; Tue, 13 Aug 2024 16:30:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2A4286A89D1;
	Tue, 13 Aug 2024 16:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723559448;
	bh=G8ANgsojX6Q8Ryh6XWoRWtQeiZsBVAQMaxxk0GWN3t4=;
	h=From:Subject:Date;
	b=V8tP2ChEZCgc41eR/bROtc5eWuTzJzz5UQsX4H1Pdu3AYVnI0v+3rNU0HNo4K7OUN
	 xcIoZixtVzJvvW+BEguN7tui6GBZj1XVBRdES+UWPRcHPhCe7tl+dQWzs8V9ngJE/S
	 8MGxAUfWNWIkG90GruDZn5juxVRq39iPPFVEDYp1DmlU7DYJ9RLdmhj1cTVpyaih85
	 qOwssWTA8xoUwV6qC5osYHmflMm3QnJK/TLh5gdjWn9NYUaPHOrk1xGJoJNEiIlTTA
	 AgO9s+jUWyN5pS2dqCmrrjyxmPOkYc76xRUxnhh9CuGTHysYyZsEqfexvSSnFgdKlM
	 FnO8ebTKZAXCg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject: [PATCH v1 3/4] thermal: gov_bang_bang: Add .manage() callback
Date: Tue, 13 Aug 2024 16:27:33 +0200
Message-ID: <8419356.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <1903691.tdWV9SEqCh@rjwysocki.net>
References: <1903691.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhl
 uhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvth
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes, the Bang-bang governor may not adjust the
initial configuration of cooling devices to the actual situation.

Namely, if a cooling device bound to a certain trip point starts in
the "on" state and the thermal zone temperature is below the threshold
of that trip point, the trip point may never be crossed on the way up
in which case the state of the cooling device will never be adjusted
because the thermal core will never invoke the governor's
.trip_crossed() callback.  [Note that there is no issue if the zone
temperature is at the trip threshold or above it to start with because
.trip_crossed() will be invoked then to indicate the start of thermal
mitigation for the given trip.]

To address this, add a .manage() callback to the Bang-bang governor
and use it to ensure that all of the thermal instances managed by the
governor have been initialized properly and the states of all of the
cooling devices involved have been adjusted to the current zone
temperature as appropriate.

Fixes: 530c932bdf75 ("thermal: gov_bang_bang: Use .trip_crossed() instead of .throttle()")
Link: https://lore.kernel.org/linux-pm/1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net/
Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -26,6 +26,7 @@ static void bang_bang_set_instance_targe
 	 * when the trip is crossed on the way down.
 	 */
 	instance->target = target;
+	instance->initialized = true;
 
 	dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
 
@@ -80,8 +81,37 @@ static void bang_bang_control(struct the
 	}
 }
 
+static void bang_bang_manage(struct thermal_zone_device *tz)
+{
+	const struct thermal_trip_desc *td;
+	struct thermal_instance *instance;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip = &td->trip;
+
+		if (tz->temperature >= td->threshold ||
+		    trip->temperature == THERMAL_TEMP_INVALID ||
+		    trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->type == THERMAL_TRIP_HOT)
+			continue;
+
+		/*
+		 * If the initial cooling device state is "on", but the zone
+		 * temperature is not above the trip point, the core will not
+		 * call bang_bang_control() until the zone temperature reaches
+		 * the trip point temperature which may be never.  In those
+		 * cases, set the initial state of the cooling device to 0.
+		 */
+		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+			if (!instance->initialized && instance->trip == trip)
+				bang_bang_set_instance_target(instance, 0);
+		}
+	}
+}
+
 static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
 	.trip_crossed	= bang_bang_control,
+	.manage		= bang_bang_manage,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);




