Return-Path: <linux-pm+bounces-8953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A5903F35
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02411F23CAF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495111712;
	Tue, 11 Jun 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fSZ7DrEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21D1AACC;
	Tue, 11 Jun 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117494; cv=none; b=MNxHT92iDUBLBB2p/C9tCGOPrTFWamptnMSqc1XZfgtkz3fOtCWe9GIoUMOL2NW0w7EmqspQ9sZm9A83LaBsiNe4RSxxJPYzlr6ab02r7Y/ZWCJ2jrif6KaG6zIko+htpeMnirdce60o+z1VZKaQCtBRWhpSWY4WYW3WftT3JmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117494; c=relaxed/simple;
	bh=kxw6FNZ6sZ3ddv1CP5tIqd/k6ancUNeVg3HhsR4Dapk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uRzz7woGU0CT/P09mm1waIb2IYJkqLmF8xMA/EMZvvsUfZLLKxzVlKuTrbEcLrHpYNAlpYYWcP+BeUdR0mQScge96j9YGrHAly5mZl+5NEv0Tr5NWXzp56KTNGFa6vTcLMrvtHL183qHN2M+kpKpxYT/P1boJe9S+5aRs+d+PYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fSZ7DrEn; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 2654bdd0c242fc7a; Tue, 11 Jun 2024 16:51:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B18E87F46D3;
	Tue, 11 Jun 2024 16:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718117484;
	bh=kxw6FNZ6sZ3ddv1CP5tIqd/k6ancUNeVg3HhsR4Dapk=;
	h=From:To:Cc:Subject:Date;
	b=fSZ7DrEnAvBxDMBYFQAdb88D11pP3POjdemG/yLpr8FUQ5WZC5SeVRJyOk8vh4JL4
	 9iquczrORaF2kER82LthvSOsQYcw3Ozv06ixhiCDSLvUV84ZRwA2SvxERpZWcKXcJb
	 uEXpFBh22FMB2crTl3pl0KxQr2+fGKqt05SB0ijpojfReh05o75G5MFkuCYmwyA6Sy
	 76WbfviQWGfRY4WBt1ybnAia/CTnmj2ye0mWLOMqbvKozHw+My/OkXl7VkCWv/C2Ko
	 N8JJW4ha3jeP5dmcQU5M/hEWjX4a8FCkSpwH/y4CsU1mZhHPgG5YsB7Ou0MU8um8BQ
	 MVG6+OSizRJ8w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v1] thermal: gov_step_wise: Restore passive polling management
Date: Tue, 11 Jun 2024 16:51:23 +0200
Message-ID: <12462322.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegr
 rhhmrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Consider a thermal zone with one passive trip point, a cooling device
with 3 states (0, 1, 2) bound to it, passive polling enabled (nonzero
passive_delay_jiffies) and no regular polling (polling_delay_jiffies
equal to 0) that is managed by the Step-Wise governor.  Suppose that
the initial state of the cooling device is 0 and the zone temperature
is below the trip point to start with.

When the trip point is crossed, tz->passive is incremented by the
thermal core and the governor's .manage() callback is invoked.  It
sets 'throttle' to 'true' for the trip in question and
get_target_state() returns 1 for the instance corresponding to the
cooling device (say that 'upper' and 'lower' are set to 2 and 0 for
it, respectively), so its state changes to 1.

Passive polling is still active for the zone, so next time the
temperature is updated, the governor's .manage() callback will be
invoked again.  If the temperature is still rising, it will change
the state of the cooling device to 2.

Now suppose that next time the zone temperature is updated, it falls
below the trip point, so tz->passive is decremented for the zone (say
it becomes 0 then) and the governor's .manage() callbacks runs.

It finds that the temperature trend for the zone is 'falling' and
'throttle' will be set to 'false' for the trip in question, so the
cooling device's state will be changed to 1.  However, because
tz->polling is 0 for the zone, the governor's .manage() callback
may not be invoked again for a long time and the cooling device's
state will not be reset back to 0.

This can happen because commit 042a3d80f118 ("thermal: core: Move
passive polling management to the core") removed passive polling
management from the Step-Wise governor.

Before that change, thermal_zone_trip_update() would bump up
tz->passive when changing the target state for a thermal instance
from "no target" to a specific value and it would drop tz->passive
when changing it back to "no target" which would cause passive
polling to be active for the zone until the governor has reset the
states of all cooling devices.  In particular, in the example above
tz->passive would be incremented when changing the state of the
cooling device from 0 to 1 and then it would be still nonzero when
the state of the cooling device was changed from 2 to 1.

To prevent this problem from occurring, restore the passive polling
management in the Step-Wise governor by partially reverting the
commit in question and update the comment in the restored code
to explain its role more clearly.

Fixes: 042a3d80f118 ("thermal: core: Move passive polling management to the core")
Closes: https://lore.kernel.org/linux-pm/ZmVfcEOxmjUHZTSX@hovoldconsulting.com
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -93,6 +93,23 @@ static void thermal_zone_trip_update(str
 		if (instance->initialized && old_target == instance->target)
 			continue;
 
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
+			/*
+			 * If the target state for this thermal instance
+			 * changes from THERMAL_NO_TARGET to something else,
+			 * ensure that the zone temperature will be updated
+			 * (assuming enabled passive cooling) until it becomes
+			 * THERMAL_NO_TARGET again, or the cooling device may
+			 * not be reset to its initial state.
+			 */
+			if (old_target == THERMAL_NO_TARGET &&
+			    instance->target != THERMAL_NO_TARGET)
+				tz->passive++;
+			else if (old_target != THERMAL_NO_TARGET &&
+				 instance->target == THERMAL_NO_TARGET)
+				tz->passive--;
+		}
+
 		instance->initialized = true;
 
 		mutex_lock(&instance->cdev->lock);




