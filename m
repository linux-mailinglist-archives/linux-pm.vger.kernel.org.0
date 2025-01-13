Return-Path: <linux-pm+bounces-20371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B8A0C0CB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1827A3217
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F01CB51B;
	Mon, 13 Jan 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Hs5PfmEE"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B824022B;
	Mon, 13 Jan 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794345; cv=none; b=uVekIvhUkn7cSGh952MJkeYOxw44xqgB5QQnZ1IOybgHd0c7dZy67xxlOekq2FI4SrdmjAg35tRI2zcWfJSrAcr7RgzCmWgsmo4PhhDRKlel1ugUmEOTnULf5Ti9Dfn7Dw5Jjps4yi0VE3XdlynVkxd0m12GKsXpECLNCPkTSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794345; c=relaxed/simple;
	bh=BTTD/da48hVW8QK4C/ryWf9OAujsqMUhhv6qpvmD8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4RcTtYgEF1R3p0mydnSTW/FGKOHwiFuVkEws0BVI92XTv6YH6QPboiwr/0bfdnuPXsaS8GxXK9aNSrjUQq4PIimNC9WbNsDAPXkK4Xf0oAGafUQbLPg3rlDz2z4C/EVU2wbc/PAWuf28eb3Z+kpyNMFuViFZ1oYrSTXAtD7cN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Hs5PfmEE; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id b5713ab5b96b9531; Mon, 13 Jan 2025 19:52:16 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9F0EC8E0A24;
	Mon, 13 Jan 2025 19:52:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794336;
	bh=BTTD/da48hVW8QK4C/ryWf9OAujsqMUhhv6qpvmD8/k=;
	h=From:Subject:Date;
	b=Hs5PfmEEdZdALgCjbksTpfUlW8/70MiUs4XiaQJL3QJi3jCaMGjn14V95UMSUFK0f
	 xL3m+lJn86hroe9EOZ1U/qhyhfxJ5Tqbd0mt6VUUog930bO2dYrKMBdXT6nySAAHRk
	 nSLE7URnJunaN7QripRCBV+Cm9Mnc5nOsp/nkAsam95nX9ugVbnkAyzu60MR9vhJ0W
	 3xkMmk3PZt3gjv8uHqX2WuswpQwhobldvlctkB0sie54jOO+n86iaK7yeo2k3edFCA
	 zWnI5ZR+5rJ0HyHDh5tb+zIPVVUOFRMcYLex7MIzXCjFtmefBNV/+ag1fheesVGwtK
	 XzWMewHNtqezw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1 6/9] cpuidle: teo: Simplify counting events used for tick
 management
Date: Mon, 13 Jan 2025 19:45:50 +0100
Message-ID: <1987985.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <6116275.lOV4Wx5bFT@rjwysocki.net>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhdprhgtphhtthhopegrrhhtvghmrdgsihhthihuthhskhhihieslhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the tick_hits metric with a new tick_intercepts one that can be
used directly when deciding whether or not to stop the scheduler tick
and update the governor functional description accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   49 +++++++++++-----------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -41,11 +41,7 @@
  * idle state 2, the third bin spans from the target residency of idle state 2
  * up to, but not including, the target residency of idle state 3 and so on.
  * The last bin spans from the target residency of the deepest idle state
- * supplied by the driver to the scheduler tick period length or to infinity if
- * the tick period length is less than the targer residency of that state.  In
- * the latter case, the governor also counts events with the measured idle
- * duration between the tick period length and the target residency of the
- * deepest idle state.
+ * supplied by the driver to infinity.
  *
  * Two metrics called "hits" and "intercepts" are associated with each bin.
  * They are updated every time before selecting an idle state for the given CPU
@@ -60,6 +56,10 @@
  * into by the sleep length (these events are also referred to as "intercepts"
  * below).
  *
+ * The governor also counts "intercepts" with the measured idle duration below
+ * the tick period length and uses this information when deciding whether or not
+ * to stop the scheduler tick.
+ *
  * In order to select an idle state for a CPU, the governor takes the following
  * steps (modulo the possible latency constraint that must be taken into account
  * too):
@@ -128,14 +128,14 @@
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
  * @state_bins: Idle state data bins for this CPU.
  * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
- * @tick_hits: Number of "hits" after TICK_NSEC.
+ * @tick_intercepts: "Intercepts" before TICK_NSEC.
  */
 struct teo_cpu {
 	s64 time_span_ns;
 	s64 sleep_length_ns;
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
-	unsigned int tick_hits;
+	unsigned int tick_intercepts;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -207,38 +207,21 @@
 		}
 	}
 
-	/*
-	 * If the deepest state's target residency is below the tick length,
-	 * make a record of it to help teo_select() decide whether or not
-	 * to stop the tick.  This effectively adds an extra hits-only bin
-	 * beyond the last state-related one.
-	 */
-	if (target_residency_ns < TICK_NSEC) {
-		cpu_data->tick_hits -= cpu_data->tick_hits >> DECAY_SHIFT;
-
-		cpu_data->total += cpu_data->tick_hits;
-
-		if (TICK_NSEC <= cpu_data->sleep_length_ns) {
-			idx_timer = drv->state_count;
-			if (TICK_NSEC <= measured_ns) {
-				cpu_data->tick_hits += PULSE;
-				goto end;
-			}
-		}
-	}
-
+	cpu_data->tick_intercepts -= cpu_data->tick_intercepts >> DECAY_SHIFT;
 	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
 	 */
-	if (idx_timer == idx_duration)
+	if (idx_timer == idx_duration) {
 		cpu_data->state_bins[idx_timer].hits += PULSE;
-	else
+	} else {
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;
+		if (TICK_NSEC <= measured_ns)
+			cpu_data->tick_intercepts += PULSE;
+	}
 
-end:
 	cpu_data->total += PULSE;
 }
 
@@ -286,7 +269,6 @@
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	ktime_t delta_tick = TICK_NSEC / 2;
-	unsigned int tick_intercept_sum = 0;
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
 	unsigned int idx_hit_sum = 0;
@@ -365,9 +347,6 @@
 		goto end;
 	}
 
-	tick_intercept_sum = intercept_sum +
-			cpu_data->state_bins[drv->state_count-1].intercepts;
-
 	/*
 	 * If the sum of the intercepts metric for all of the idle states
 	 * shallower than the current candidate one (idx) is greater than the
@@ -477,7 +456,7 @@
 	 * total wakeup events, do not stop the tick.
 	 */
 	if (drv->states[idx].target_residency_ns < TICK_NSEC &&
-	    tick_intercept_sum > cpu_data->total / 2 + cpu_data->total / 8)
+	    cpu_data->tick_intercepts > cpu_data->total / 2 + cpu_data->total / 8)
 		duration_ns = TICK_NSEC / 2;
 
 end:




