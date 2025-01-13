Return-Path: <linux-pm+bounces-20369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA14A0C0C7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC641887047
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DFC1C5F2A;
	Mon, 13 Jan 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="bVRNL3+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A191C3F36;
	Mon, 13 Jan 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794345; cv=none; b=eFNxbjEXLrUzDDCcnHNYytc5nZi+A+e2NnhgfHHiziVs1EDLEbQU1GNk3Nq6Z9XBWXL3L1QeOrUfL1tdCNRNViB1vIqxKDnardFqgLcD/rozYmIZYTFGa7koTSUES9TW59f2vjCXB+Tcsv4avT2B0EcGW13quBlkRqGX5vRuE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794345; c=relaxed/simple;
	bh=PfckwYxulT9gsmWNE2ZV2wINeZKYKi555RVpe9CcScg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaCKK1pE7/XmmgJN5lfhCrraJo5VrpljVLZTQ5ZLZJ7VAYo4L00Lo9g7manWVw1oZcCGpozAfxo1dShYVGNmlRoyUznSeT5Gy0khVQAvioOKrT/fDzTZWlKjmB8+f9LmBo2xx4dLwTxBW8ZQonDzzBhB9uBjoU3UNqyIEdJKeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=bVRNL3+K; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6ab48c513c231119; Mon, 13 Jan 2025 19:52:15 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 65BEE8E0A24;
	Mon, 13 Jan 2025 19:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736794335;
	bh=PfckwYxulT9gsmWNE2ZV2wINeZKYKi555RVpe9CcScg=;
	h=From:Subject:Date;
	b=bVRNL3+KMOWXGvTXBq7U2c0BCse6TBfYzbsNhaU8qRfGR1wqXK68A7SaqgiS4CgsR
	 gym/qt5wxwrl88yovzHwz7fWrzLkRelgF8T0onUW9B4LF7RylTBuYCE1fO/ypyn+Jq
	 FxkyS6yjEdG0MJ0RPowBUlE+AiFX+2qfRbIGFVUbQXBBtfHjGarFC9IpBdLoRsbPLI
	 ihxfg4vUASVWTjpT57YyJCuRpmdvYTS717vBaNDadir3k5A8UGoqD8wurryZZaJtqB
	 m5482fk+iU3zp5uXdK9de6yq9Qjqdz8i3bmRx3MSX0w7i4uYpESSGKKBabY3gBAlnI
	 dFrunA1HujzkQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1 7/9] cpuidle: teo: Skip getting the sleep length is wakeups are
 very frequent
Date: Mon, 13 Jan 2025 19:48:47 +0100
Message-ID: <3851791.kQq0lBPeGt@rjwysocki.net>
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

Commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length()
call in some cases") attempted to reduce the governor overhead in some
cases by making it avoid obtaining the sleep length (the time till the
next timer event) which may be costly.

Among other things, after the above commit, tick_nohz_get_sleep_length()
was not called any more when idle state 0 was to be returned, which
turned out to be problematic and the previous behavior in that respect
was restored by commit 4b20b07ce72f ("cpuidle: teo: Don't count non-
existent intercepts").

However, commit 6da8f9ba5a87 also caused the governor to avoid calling
tick_nohz_get_sleep_length() on systems where idle state 0 is a "polling"
one (that is, it is not really an idle state, but a loop continuously
executed by the CPU) when the target residency of the idle state to be
returned was low enough, so there was no practical need to refine the
idle state selection in any way.  This change was not removed by the
other commit, so now on systems where idle state 0 is a "polling" one,
tick_nohz_get_sleep_length() is called when idle state 0 is to be
returned, but it is not called when a deeper idle state with
sufficiently low target residency is to be returned.  That is arguably
confusing and inconsistent.

Moreover, there is no specific reason why the behavior in question
should depend on whether or not idle state 0 is a "polling" one.

One way to address this would be to make the governor always call
tick_nohz_get_sleep_length() to obtain the sleep length, but that would
effectively mean reverting commit 6da8f9ba5a87 and restoring the latency
issue that was the reason for doing it.  This approach is thus not
particularly attractive.

To address it differently, notice that if a CPU is woken up very often,
this is not likely to be caused by timers in the first place (user space
has a default timer slack of 50 us and there are relatively few timers
with a deadline shorter than several microseconds in the kernel) and
even if it were the case, the potential benefit from using a deep idle
state would then be questionable for latency reasons.  Therefore, if the
majority of CPU wakeups occur within several microseconds, it can be
assumed that all wakeups in that range are non-timer and the sleep
length need not be determined.

Accordingly, introduce a new metric for counting wakeups with the
measured idle duration below RESIDENCY_THRESHOLD_NS and modify the idle
state selection to skip the tick_nohz_get_sleep_length() invocation if
idle state 0 has been selected or the target residency of the candidate
idle state is below RESIDENCY_THRESHOLD_NS and the value of the new
metric is at least 1/2 of the total event count.

Since the above requires the measured idle duration to be determined
every time, except for the cases when one of the safety nets has
triggered in which the wakeup is counted as a hit in the deepest
idle state idle residency range, update the handling of those cases
to avoid skipping the idle duration computation when the CPU wakeup
is "genuine".

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   58 ++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -129,6 +129,7 @@
  * @state_bins: Idle state data bins for this CPU.
  * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
  * @tick_intercepts: "Intercepts" before TICK_NSEC.
+ * @short_idle: Wakeups after short idle periods.
  */
 struct teo_cpu {
 	s64 time_span_ns;
@@ -136,6 +137,7 @@
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
 	unsigned int tick_intercepts;
+	unsigned int short_idle;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -152,12 +154,12 @@
 	s64 target_residency_ns;
 	u64 measured_ns;
 
-	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
+	cpu_data->short_idle -= cpu_data->short_idle >> DECAY_SHIFT;
+
+	if (cpu_data->time_span_ns < 0) {
 		/*
-		 * This causes the wakeup to be counted as a hit regardless of
-		 * regardless of the real idle duration which doesn't need to be
-		 * computed because the wakeup has been close enough to an
-		 * anticipated timer.
+		 * If one of the safety nets has triggered, assume that this
+		 * might have been a long sleep.
 		 */
 		measured_ns = U64_MAX;
 	} else {
@@ -177,10 +179,14 @@
 		 * time, so take 1/2 of the exit latency as a very rough
 		 * approximation of the average of it.
 		 */
-		if (measured_ns >= lat_ns)
+		if (measured_ns >= lat_ns) {
 			measured_ns -= lat_ns / 2;
-		else
+			if (measured_ns < RESIDENCY_THRESHOLD_NS)
+				cpu_data->short_idle += PULSE;
+		} else {
 			measured_ns /= 2;
+			cpu_data->short_idle += PULSE;
+		}
 	}
 
 	cpu_data->total = 0;
@@ -419,27 +425,35 @@
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
-	if (!idx) {
-		/*
-		 * Query the sleep length to be able to count the wakeup as a
-		 * hit if it is caused by a timer.
-		 */
-		cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
-		goto out_tick;
-	}
-
 	/*
-	 * If state 0 is a polling one, check if the target residency of
-	 * the current candidate state is low enough and skip the timers
-	 * check in that case too.
+	 * If either the candidate state is state 0 or its target residency is
+	 * low enough, there is basically nothing more to do, but if the sleep
+	 * length is not updated, the subsequent wakeup will be counted as an
+	 * "intercept" which may be problematic in the cases when timer wakeups
+	 * are dominant.  Namely, it may effectively prevent deeper idle states
+	 * from being selected at one point even if no imminent timers are
+	 * scheduled.
+	 *
+	 * However, frequent timers in the RESIDENCY_THRESHOLD_NS range on one
+	 * CPU are unlikely (user space has a default 50 us slack value for
+	 * hrtimers and there are relatively few timers with a lower deadline
+	 * value in the kernel), and even if they did happene, the potential
+	 * benefit from using a deep idle state in that case would be
+	 * questionable anyway for latency reasons.  Thus if the measured idle
+	 * duration falls into that range in the majority of cases, assume
+	 * non-timer wakeups to be dominant and skip updating the sleep length
+	 * to reduce latency.
 	 */
-	if ((drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
-	    drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)
+	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
+	    2 * cpu_data->short_idle >= cpu_data->total)
 		goto out_tick;
 
 	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 
+	if (!idx)
+		goto out_tick;
+
 	/*
 	 * If the closest expected timer is before the target residency of the
 	 * candidate state, a shallower one needs to be found.
@@ -501,7 +515,7 @@
 	if (dev->poll_time_limit ||
 	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC)) {
 		dev->poll_time_limit = false;
-		cpu_data->time_span_ns = cpu_data->sleep_length_ns;
+		cpu_data->time_span_ns = KTIME_MIN;
 	} else {
 		cpu_data->time_span_ns = local_clock() - cpu_data->time_span_ns;
 	}




