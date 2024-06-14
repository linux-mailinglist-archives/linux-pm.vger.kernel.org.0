Return-Path: <linux-pm+bounces-9198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F18908EAE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D699F28141B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB615FA73;
	Fri, 14 Jun 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="b1OF82qy"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC115ECD0;
	Fri, 14 Jun 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378801; cv=none; b=Yqf6PcNuN6dHYbKUOgY0ck1j3r0iwYMiCNzOFl49Ho3OgY30yG1t1680HwB5u8KeL8h0LRb1vCbrOPwL2kAy+kxCjDQ21NZXi8isl/TaBXI6lEvFVP7d2J1PXJ9Z66jek/XWwct9oW2YMEydoyc2WWYljVpFIkzGTSvRK3heTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378801; c=relaxed/simple;
	bh=cjl0bkjeAO5Vua+9MaTkaLsH8+alieQpslyVDPvkcN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxTPDX72JVjUP+56W8ur9Pfc++GTNig5fpCjCkRDkqNick7L7D+ZL2tB1mTbdUgkHCtxxYagQlJhJsFV9CQgj9wUEX5z8owJRFNnArUILoiCSIPf5B4ICeWV53OeUx4xbsnCR5H6CL89Prf/ACuQ3aALGLSSxrt+wBksBYm247g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=b1OF82qy reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 13d1a6cfb4bcd6ae; Fri, 14 Jun 2024 17:26:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0649E6A7417;
	Fri, 14 Jun 2024 17:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718378789;
	bh=cjl0bkjeAO5Vua+9MaTkaLsH8+alieQpslyVDPvkcN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b1OF82qy4GvveuAegebT30EZmtNITmka/xRb6eK6KlVCaIGEn6X5iPgJsYkcnrVjH
	 7nYH6odlfEayW2LzXFFrXOo0Yz/nAnnHLGzKNlgzYDyT9fMaBGvOC/nqpnflrZBil5
	 JQfwZvqhzgfFfk/ZNMyOJdkLfzoBCx/bYXlqWSIPo6id+TJwXNuL60kO9Iapp2tEZ3
	 a4B+YUVnOJDQ6br5nMVigvK8EjcVBYNp1OVNNiskROZCHif1TnBCD0exWfqrBBaKSe
	 5cahNCrasC7dAkB6EBGPsIMCE3FXCRnvsGO1u7e8oASIMpq1EOBV9nC1CK3He7uZ0J
	 EIVYqIU7wQBrg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, fhortner@yahoo.de
Subject:
 [PATCH v1 2/2] thermal: core: Change PM notifier priority to the minimum
Date: Fri, 14 Jun 2024 17:26:00 +0200
Message-ID: <3317718.44csPzL39Z@kreacher>
In-Reply-To: <6070114.lOV4Wx5bFT@kreacher>
References: <6070114.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggr
 segrrhhmrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that commit 5a5efdaffda5 ("thermal: core: Resume thermal
zones asynchronously") causes battery data in sysfs on Thinkpad P1 Gen2
to become invalid after a resume from S3 (and it is necessary to reboot
the machine to restore correct battery data).  Some investigation into
the problem indicated that it happened because, after the commit in
question, the ACPI battery PM notifier ran in parallel with
thermal_zone_device_resume() for one of the thermal zones which
apparently confused the platform firmware on the affected system.

While the exact reason for the firmware confusion remains unclear, it
is arguably not particularly relevant, and the expected behavior of the
affected system can be restored by making the thermal PM notifier run
at the lowest priority which avoids interference between work items
spawned by it and the other PM notifiers (that will run before those
work items now).

Fixes: 5a5efdaffda5 ("thermal: core: Resume thermal zones asynchronously")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218881
Reported-by: fhortner@yahoo.de
Tested-by: fhortner@yahoo.de
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1710,6 +1710,12 @@ static int thermal_pm_notify(struct noti
 
 static struct notifier_block thermal_pm_nb = {
 	.notifier_call = thermal_pm_notify,
+	/*
+	 * Run at the lowest priority to avoid interference between the thermal
+	 * zone resume work items spawned by thermal_pm_notify() and the other
+	 * PM notifiers.
+	 */
+	.priority = INT_MIN,
 };
 
 static int __init thermal_init(void)




