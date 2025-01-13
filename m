Return-Path: <linux-pm+bounces-20365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C814A0C0C0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDBA3A0830
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D781C4635;
	Mon, 13 Jan 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FAB82vtt"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C31BBBF1;
	Mon, 13 Jan 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794343; cv=none; b=HC5Xw/UR4OFp0zrbtpsizUOl4gBt+UVb0eSsM1k44iNsWrl2R9KDS67uwLUsRssp9ucyJ2wklY2My8ToSPSywNkXnA4ipauDPzinMzQyt/AkuUBLDYSghRzYA6rZo+wg52iMyMQ4t4ci1zywBgfpIwpofU7PGE3pvGOPHs4D4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794343; c=relaxed/simple;
	bh=K0/NvcBRhOF8aM7fJ96ka2xUNcKZ8cQ4UPZWHnqcwpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6Hm5IMv0bomMqvxssZCVOEGoxnKEVfx9iz8Hqnj/trZLYkHCcZJ9u8pLwNmr+eyDC4NZeh2PLaI8tJ4Q9tXS2mZFxzRmuHpsF2l4Hi7LYYFAvVgo+5+F43aNkAAyKwawE4WDi1k+qtn0LEOioOmr46BkXxojfNgr61nFPcCd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FAB82vtt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 7fd3717602d15474; Mon, 13 Jan 2025 19:52:13 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6C5DA8E0A24;
	Mon, 13 Jan 2025 19:52:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794332;
	bh=K0/NvcBRhOF8aM7fJ96ka2xUNcKZ8cQ4UPZWHnqcwpc=;
	h=From:Subject:Date;
	b=FAB82vttX+nV9VxkKf/IqB/8biHM6VX/fv8BO9rtdZ37bm4EDiXDJgaPJTpyTkmkA
	 TwxveTVAivzKMQJdcO9pfhuePmAUkIUy1FH0E4avc3p61A4WeHrqJMmGYhFoJ00Ayp
	 xYaGPGnc5QcbHypPthyf9vuVZ7n9osmJxHNeRVAA5Jh+SDRJ0a5gAw6cRtyFQcdm2G
	 AbEUHaP0ZN5GAYvGPdXP7W1TedYLLwyvk9eW6CiFWm6KzzDbDzZ4/pQybV8KENAIY9
	 2teduQSd2d/w5SdVuBK+KWtsLTDpD9yjm7CgP/LOr6gQyW+jnReVJQyUKtKg2MO4Kf
	 I9KAZnz8fup2A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1 9/9] cpuidle: teo: Replace time_span_ns with a flag
Date: Mon, 13 Jan 2025 19:51:59 +0100
Message-ID: <6010475.MhkbZ0Pkbq@rjwysocki.net>
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

After recent updates, the time_span_ns field in struct teo_cpu has
become an indicator on whether or not the most recent wakeup has been
"genuine" which may as well be indicated by a bool field without
calling local_clock(), so update the code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -124,20 +124,20 @@
 
 /**
  * struct teo_cpu - CPU data used by the TEO cpuidle governor.
- * @time_span_ns: Time between idle state selection and post-wakeup update.
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
  * @state_bins: Idle state data bins for this CPU.
  * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
  * @tick_intercepts: "Intercepts" before TICK_NSEC.
  * @short_idle: Wakeups after short idle periods.
+ * @artificial_wakeup: Set if the wakeup has been triggered by a safety net.
  */
 struct teo_cpu {
-	s64 time_span_ns;
 	s64 sleep_length_ns;
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
 	unsigned int tick_intercepts;
 	unsigned int short_idle;
+	bool artificial_wakeup;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -156,7 +156,7 @@
 
 	cpu_data->short_idle -= cpu_data->short_idle >> DECAY_SHIFT;
 
-	if (cpu_data->time_span_ns < 0) {
+	if (cpu_data->artificial_wakeup) {
 		/*
 		 * If one of the safety nets has triggered, assume that this
 		 * might have been a long sleep.
@@ -165,13 +165,6 @@
 	} else {
 		u64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
 
-		/*
-		 * The computations below are to determine whether or not the
-		 * (saved) time till the next timer event and the measured idle
-		 * duration fall into the same "bin", so use last_residency_ns
-		 * for that instead of time_span_ns which includes the cpuidle
-		 * overhead.
-		 */
 		measured_ns = dev->last_residency_ns;
 		/*
 		 * The delay between the wakeup and the first instruction
@@ -286,7 +279,6 @@
 		dev->last_state_idx = -1;
 	}
 
-	cpu_data->time_span_ns = local_clock();
 	/*
 	 * Set the sleep length to infitity in case the invocation of
 	 * tick_nohz_get_sleep_length() below is skipped, in which case it won't
@@ -504,17 +496,16 @@
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 
 	dev->last_state_idx = state;
-	/*
-	 * If the wakeup was not "natural", but triggered by one of the safety
-	 * nets, assume that the CPU might have been idle for the entire sleep
-	 * length time.
-	 */
 	if (dev->poll_time_limit ||
 	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC)) {
+		/*
+		 * The wakeup was not "geniune", but triggered by one of the
+		 * safety nets.
+		 */
 		dev->poll_time_limit = false;
-		cpu_data->time_span_ns = KTIME_MIN;
+		cpu_data->artificial_wakeup = true;
 	} else {
-		cpu_data->time_span_ns = local_clock() - cpu_data->time_span_ns;
+		cpu_data->artificial_wakeup = false;
 	}
 }
 




