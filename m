Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33F334D76A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhC2Shl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 14:37:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48772 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhC2Shh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 14:37:37 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 43deede600701cc8; Mon, 29 Mar 2021 20:37:35 +0200
Received: from kreacher.localnet (89-64-81-131.dynamic.chello.pl [89.64.81.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5454F669165;
        Mon, 29 Mar 2021 20:37:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Subject: [PATCH v1 3/5] cpuidle: teo: Adjust handling of very short idle times
Date:   Mon, 29 Mar 2021 20:19:03 +0200
Message-ID: <7219614.EvYhyI6sBW@kreacher>
In-Reply-To: <2764850.e9J7NaK4W3@kreacher>
References: <2764850.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdekuddrudefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudefuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghp
 thhtohepgidvtddulegtfihmsehsthhfgidrtggr
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

If the time till the next timer event is shorter than the target
residency of the first idle state (state 0), the TEO governor does
not update its metrics for any idle states, but arguably it should
record a "hit" for idle state 0 in that case, so modify it to do
that.

Accordingly, also make it record an "early hit" for idle state 0 if
the measured idle duration is less than its target residency, which
allows one branch more to be dropped from teo_update().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -117,7 +117,8 @@ static DEFINE_PER_CPU(struct teo_cpu, te
 static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	int i, idx_hit = -1, idx_timer = -1;
+	int i, idx_hit = 0, idx_timer = 0;
+	unsigned int hits, misses;
 	u64 measured_ns;
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
@@ -174,25 +175,22 @@ static void teo_update(struct cpuidle_dr
 	 * also increase the "early hits" metric for the state that actually
 	 * matches the measured idle duration.
 	 */
-	if (idx_timer >= 0) {
-		unsigned int hits = cpu_data->states[idx_timer].hits;
-		unsigned int misses = cpu_data->states[idx_timer].misses;
-
-		hits -= hits >> DECAY_SHIFT;
-		misses -= misses >> DECAY_SHIFT;
-
-		if (idx_timer > idx_hit) {
-			misses += PULSE;
-			if (idx_hit >= 0)
-				cpu_data->states[idx_hit].early_hits += PULSE;
-		} else {
-			hits += PULSE;
-		}
+	hits = cpu_data->states[idx_timer].hits;
+	hits -= hits >> DECAY_SHIFT;
+
+	misses = cpu_data->states[idx_timer].misses;
+	misses -= misses >> DECAY_SHIFT;
 
-		cpu_data->states[idx_timer].misses = misses;
-		cpu_data->states[idx_timer].hits = hits;
+	if (idx_timer == idx_hit) {
+		hits += PULSE;
+	} else {
+		misses += PULSE;
+		cpu_data->states[idx_hit].early_hits += PULSE;
 	}
 
+	cpu_data->states[idx_timer].misses = misses;
+	cpu_data->states[idx_timer].hits = hits;
+
 	/*
 	 * Save idle duration values corresponding to non-timer wakeups for
 	 * pattern detection.



