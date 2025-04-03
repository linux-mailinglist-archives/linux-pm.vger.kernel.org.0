Return-Path: <linux-pm+bounces-24767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F45A7AF4D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D031898082
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA1253B62;
	Thu,  3 Apr 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RPXWsdw0"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C202512CE;
	Thu,  3 Apr 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707992; cv=none; b=lIZRykkob9VKTaPcoCx7/u7hlc6g8x2aVwkJU2yIYpw4Esh7LTcCuxIX1lVuBJcoAD0t1R7BvZL2tVhDr+dKHBpxJuhjoWh5Vwng9zCkqC0tyfJMv3sg4uFP35dhQ+WVuZWfe6T6JTu8ejfaQRxkAKsdtquKqafhM6lkeiCHQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707992; c=relaxed/simple;
	bh=uPpUnikI6V5BZQyx2/t+prng46nejSRfS5Mgvb/auw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFM2SiJ0ggqkSeQAyHppG7xqAJWTVQTIu1C1SjiQF36Fmq37M2DWon9BDzynggMGoXLY7EjQE0aiJ5tYlb0M7pUAp/IJKu0sPeo2IdYQClgvT1qo0qUKPWZJc3g7Voo/bsMlIr4/elwqVS2ET7CeXZ7GFCTCgipOS3KQY/W/XEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RPXWsdw0; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id c2c9616ba3bbde8e; Thu, 3 Apr 2025 21:19:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 912619014E8;
	Thu,  3 Apr 2025 21:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743707982;
	bh=uPpUnikI6V5BZQyx2/t+prng46nejSRfS5Mgvb/auw4=;
	h=From:Subject:Date;
	b=RPXWsdw0a+vIwjm/6lop6uh0ejJMTyc6IUyX1aVNUFzzfGYYerrcPdzZu/h2vbDnN
	 LLcRRwSzUIVcMWE46NrL3Mhq7CzTZa+hO4NZDOvfKzdMe41ibGekEz6j9oVWAKA1du
	 T2qCy3Ry65bip5gr/R0PwLEcxSUWECgZbiUEhKPX8wazD1FOF2YsqsWTF+KlKz9PbO
	 BPEAeyaq4C/yAEvhBoU+Dx2NTjGzIy9dPzwnzR9wKErsmXGwB1Hlhv9Pn2zByvmnQk
	 P/PrVlKDG88QER8dc6wTxasf9hXlp22ytX/QJf+ubGSsIEKnmq6Uq4W5ryWV8N6keM
	 gtXfwgNboJKCA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v1 2/2] cpuidle: teo: Refine handling of short idle intervals
Date: Thu, 03 Apr 2025 21:18:38 +0200
Message-ID: <2239639.irdbgypaU6@rjwysocki.net>
In-Reply-To: <4661520.LvFx2qVVIh@rjwysocki.net>
References: <4661520.LvFx2qVVIh@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeelfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make teo take all recent wakeups (both timer and non-timer) into
account when looking for a new candidate idle state in the cases
when the majority of recent idle intervals are within the
LATENCY_THRESHOLD_NS range or the latency limit is within the
LATENCY_THRESHOLD_NS range.

Since the tick_nohz_get_sleep_length() invocation is likely to be
skipped in those cases, timer wakeups should arguably be taken into
account somehow in case they are significant while the current code
mostly looks at non-timer wakeups under the assumption that frequent
timer wakeups are unlikely in the given idle duration range which
may or may not be accurate.

The most natural way to do that is to add the "hits" metric to the
sums used during the new candidate idle state lookup which effectively
means the above.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   99 ++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -261,11 +261,12 @@
 
 static int teo_get_candidate(struct cpuidle_driver *drv,
 			     struct cpuidle_device *dev,
-			     struct teo_cpu *cpu_data,
-			     int idx, unsigned int idx_intercepts)
+			     struct teo_cpu *cpu_data, int constraint_idx,
+			     int idx, unsigned int idx_events,
+			     bool count_all_events)
 {
 	int first_suitable_idx = idx;
-	unsigned int intercepts = 0;
+	unsigned int events = 0;
 	int i;
 
 	/*
@@ -277,8 +278,11 @@
 	 * has been stopped already into account.
 	 */
 	for (i = idx - 1; i >= 0; i--) {
-		intercepts += cpu_data->state_bins[i].intercepts;
-		if (2 * intercepts > idx_intercepts) {
+		events += cpu_data->state_bins[i].intercepts;
+		if (count_all_events)
+			events += cpu_data->state_bins[i].hits;
+
+		if (2 * events > idx_events) {
 			/*
 			 * Use the current state unless it is too
 			 * shallow or disabled, in which case take the
@@ -316,6 +320,12 @@
 		if (first_suitable_idx == idx)
 			break;
 	}
+	/*
+	 * If there is a latency constraint, it may be necessary to select an
+	 * idle state shallower than the current candidate one.
+	 */
+	if (idx > constraint_idx)
+		return constraint_idx;
 
 	return idx;
 }
@@ -410,49 +420,50 @@
 	}
 
 	/*
-	 * If the sum of the intercepts metric for all of the idle states
-	 * shallower than the current candidate one (idx) is greater than the
-	 * sum of the intercepts and hits metrics for the candidate state and
-	 * all of the deeper states, a shallower idle state is likely to be a
-	 * better choice.
-	 */
-	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum)
-		idx = teo_get_candidate(drv, dev, cpu_data, idx, idx_intercept_sum);
-
-	/*
-	 * If there is a latency constraint, it may be necessary to select an
-	 * idle state shallower than the current candidate one.
-	 */
-	if (idx > constraint_idx)
-		idx = constraint_idx;
-
-	/*
-	 * If either the candidate state is state 0 or its target residency is
-	 * low enough, there is basically nothing more to do, but if the sleep
-	 * length is not updated, the subsequent wakeup will be counted as an
-	 * "intercept" which may be problematic in the cases when timer wakeups
-	 * are dominant.  Namely, it may effectively prevent deeper idle states
-	 * from being selected at one point even if no imminent timers are
-	 * scheduled.
-	 *
-	 * However, frequent timers in the RESIDENCY_THRESHOLD_NS range on one
-	 * CPU are unlikely (user space has a default 50 us slack value for
-	 * hrtimers and there are relatively few timers with a lower deadline
-	 * value in the kernel), and even if they did happen, the potential
-	 * benefit from using a deep idle state in that case would be
-	 * questionable anyway for latency reasons.  Thus if the measured idle
-	 * duration falls into that range in the majority of cases, assume
-	 * non-timer wakeups to be dominant and skip updating the sleep length
-	 * to reduce latency.
+	 * If the measured idle duration has fallen into the
+	 * RESIDENCY_THRESHOLD_NS range in the majority of recent cases, it is
+	 * likely to fall into that range next time, so it is better to avoid
+	 * adding latency to the idle state selection path.  Accordingly, aim
+	 * for skipping the sleep length update in that case.
 	 *
 	 * Also, if the latency constraint is sufficiently low, it will force
 	 * shallow idle states regardless of the wakeup type, so the sleep
-	 * length need not be known in that case.
+	 * length need not be known in that case either.
 	 */
-	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
-	    (2 * cpu_data->short_idles >= cpu_data->total ||
-	     latency_req < LATENCY_THRESHOLD_NS))
-		goto out_tick;
+	if (2 * cpu_data->short_idles >= cpu_data->total ||
+	    latency_req < LATENCY_THRESHOLD_NS) {
+		/*
+		 * Look for a new candidate idle state and use all events (both
+		 * "intercepts" and "hits") because the sleep length update is
+		 * likely to be skipped and timer wakeups need to be taken into
+		 * account in a different way in case they are significant.
+		 */
+		idx = teo_get_candidate(drv, dev, cpu_data, idx, constraint_idx,
+					idx_intercept_sum + idx_hit_sum, true);
+		/*
+		 * If the new candidate state is state 0 or its target residency
+		 * is low enough, return it right away without stopping the
+		 * scheduler tick.
+		 */
+		if (!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)
+			goto out_tick;
+	} else if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
+		/*
+		 * Look for a new candidate state because the current one is
+		 * likely too deep, but use the "intercepts" metric only because
+		 * the sleep length is going to be determined later and for now
+		 * it is only necessary to find a state that will be suitable
+		 * in case the CPU is "intercepted".
+		 */
+		idx = teo_get_candidate(drv, dev, cpu_data, idx, constraint_idx,
+					idx_intercept_sum, false);
+	} else if (idx > constraint_idx) {
+		/*
+		 * The current candidate state is too deep for the latency
+		 * constraint at hand, so change it to a suitable one.
+		 */
+		idx = constraint_idx;
+	}
 
 	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;




