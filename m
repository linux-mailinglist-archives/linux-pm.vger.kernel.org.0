Return-Path: <linux-pm+bounces-9807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E998D9133F1
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 14:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6265C1F224D7
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F116D9B1;
	Sat, 22 Jun 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="q7bqYF4y"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B114C586;
	Sat, 22 Jun 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719059297; cv=none; b=NWTyRMilF0vDntknkXdlEQSNaI4uYJEoZiIY2DvoyBlZ0f3giaTUNJLFsgY3SEPxsVRAAJ2idj5Va5lz8ZtcBRSXtt6EppvW/Wo1vEb38JAacqosfm5Kp9/Btr6+IKyN8ByYU1jdXQklVJ5dmFKnTgi6dAC2Lv+huqMxRv+46UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719059297; c=relaxed/simple;
	bh=JCw0SeShyq5JuY+nLwC3mKit0gG9UnY3JT535OxbXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JgRx3wcBfk7Yf7AvR6ef8jWfO3ZMAwDgnQhLgC4cZiHpdH21oDVEQt70TGLxYSiyDfr3AG2LS17SMKZoaIwERGYbTSF9+pXoFhuu8GkQ4y/Q21sfYGYm0ETufNw7guRXntFhnDbI01flUSDIUokDiJ1NSwqPt3N9qflF3lUHGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=q7bqYF4y reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ec57d1a1ba72cd01; Sat, 22 Jun 2024 14:28:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C8C176A7379;
	Sat, 22 Jun 2024 14:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719059287;
	bh=JCw0SeShyq5JuY+nLwC3mKit0gG9UnY3JT535OxbXbo=;
	h=From:To:Cc:Subject:Date;
	b=q7bqYF4yHXFXd7bujkorWNo99xWgbn7Ykh9cJuIzGTvUuhatvCW9ppy+94+/ue7WT
	 //tGyTCsoYNuql9AhVVRYpBtIvaoUqFFVjaj0fAVhTyCWK59w1Gls0Cj1N4RVYIuJd
	 cFiiqyRketdxLuc8QZ8hmBoAo8eR6OyJsT0AUAHGGZpz1iDZ3sYlC7Nhyp92/lm+lI
	 m2mlMrQHXB4cOpbrli644/RwkeCtLha+bFpk4KqDFv8XEXDQ0MkAZ9K6w5vvu1/0EA
	 PKr4cBmajloOFwDNvcTf7hKr3nvhMmfxvzudHfupGVP5SpPjx2j9ARX5hRulYG0Pk6
	 srO+OlhRHwMIw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Steev Klimaszewski <steev@kali.org>, Johan Hovold <johan+linaro@kernel.org>
Subject:
 [PATCH v1] thermal: gov_step_wise: Go straight to instance->lower when
 mitigation is over
Date: Sat, 22 Jun 2024 14:26:33 +0200
Message-ID: <12464461.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeefiedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegr
 rhhmrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit b6846826982b ("thermal: gov_step_wise: Restore passive polling
management") attempted to fix a Step-Wise thermal governor issue
introduced by commit 042a3d80f118 ("thermal: core: Move passive polling
management to the core"), which caused the governor to leave cooling
devices in high states, by partially revering that commit.

However, this turns out to be insufficient on some systems due to
interactions between the governor code restored by commit b6846826982b
and the passive polling management in the thermal core.

For this reason, revert commit b6846826982b and make the governor set
the target cooling device state to the "lower" one as soon as the zone
temperature falls below the threshold of the trip point corresponding
to the given thermal instance, which means that thermal mitigation is
not necessary any more.

Before this change the "lower" cooling device state would be reached in
steps through the passive polling mechanism which was questionable for
three reasons: (1) cooling device were kept in high states when that was
not necessary (and it could adversely impact performance), (2) it only
worked for thermal zones with nonzero passive_delay_jiffies value, and
(3) passive polling belongs to the core and should not be hijacked by
governors for their internal purposes.

Fixes: b6846826982b ("thermal: gov_step_wise: Restore passive polling management")
Closes: https://lore.kernel.org/linux-pm/6759ce9f-281d-4fcd-bb4c-b784a1cc5f6e@oldschoolsolutions.biz
Reported-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -55,7 +55,11 @@ static unsigned long get_target_state(st
 		if (cur_state <= instance->lower)
 			return THERMAL_NO_TARGET;
 
-		return clamp(cur_state - 1, instance->lower, instance->upper);
+		/*
+		 * If 'throttle' is false, no mitigation is necessary, so
+		 * request the lower state for this instance.
+		 */
+		return instance->lower;
 	}
 
 	return instance->target;
@@ -93,23 +97,6 @@ static void thermal_zone_trip_update(str
 		if (instance->initialized && old_target == instance->target)
 			continue;
 
-		if (trip->type == THERMAL_TRIP_PASSIVE) {
-			/*
-			 * If the target state for this thermal instance
-			 * changes from THERMAL_NO_TARGET to something else,
-			 * ensure that the zone temperature will be updated
-			 * (assuming enabled passive cooling) until it becomes
-			 * THERMAL_NO_TARGET again, or the cooling device may
-			 * not be reset to its initial state.
-			 */
-			if (old_target == THERMAL_NO_TARGET &&
-			    instance->target != THERMAL_NO_TARGET)
-				tz->passive++;
-			else if (old_target != THERMAL_NO_TARGET &&
-				 instance->target == THERMAL_NO_TARGET)
-				tz->passive--;
-		}
-
 		instance->initialized = true;
 
 		mutex_lock(&instance->cdev->lock);




