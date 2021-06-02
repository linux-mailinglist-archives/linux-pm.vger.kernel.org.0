Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFA399264
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFBSUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 14:20:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52162 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFBSUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 14:20:39 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 50290cc59ac973a4; Wed, 2 Jun 2021 20:18:55 +0200
Received: from kreacher.localnet (89-64-80-45.dynamic.chello.pl [89.64.80.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8EF1E6697FA;
        Wed,  2 Jun 2021 20:18:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/5] cpuidle: teo: Cosmetic modifications of teo_update()
Date:   Wed, 02 Jun 2021 20:15:10 +0200
Message-ID: <7254865.EvYhyI6sBW@kreacher>
In-Reply-To: <1867445.PYKUYFuaPT@kreacher>
References: <1867445.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.45
X-CLIENT-HOSTNAME: 89-64-80-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddrgeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Rename a local variable in teo_update() so that its purpose is better
reflected by its name and use one more local variable in the loop
over the CPU idle states in that function to make the code somewhat
easier to read.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -117,7 +117,7 @@ static DEFINE_PER_CPU(struct teo_cpu, te
 static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	int i, idx_hit = 0, idx_timer = 0;
+	int i, idx_timer = 0, idx_duration = 0;
 	unsigned int hits, misses;
 	u64 measured_ns;
 
@@ -156,14 +156,15 @@ static void teo_update(struct cpuidle_dr
 	 * states matching the sleep length and the measured idle duration.
 	 */
 	for (i = 0; i < drv->state_count; i++) {
+		s64 target_residency_ns = drv->states[i].target_residency_ns;
 		unsigned int early_hits = cpu_data->states[i].early_hits;
 
 		cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;
 
-		if (drv->states[i].target_residency_ns <= cpu_data->sleep_length_ns) {
+		if (target_residency_ns <= cpu_data->sleep_length_ns) {
 			idx_timer = i;
-			if (drv->states[i].target_residency_ns <= measured_ns)
-				idx_hit = i;
+			if (target_residency_ns <= measured_ns)
+				idx_duration = i;
 		}
 	}
 
@@ -181,11 +182,11 @@ static void teo_update(struct cpuidle_dr
 	misses = cpu_data->states[idx_timer].misses;
 	misses -= misses >> DECAY_SHIFT;
 
-	if (idx_timer == idx_hit) {
+	if (idx_timer == idx_duration) {
 		hits += PULSE;
 	} else {
 		misses += PULSE;
-		cpu_data->states[idx_hit].early_hits += PULSE;
+		cpu_data->states[idx_duration].early_hits += PULSE;
 	}
 
 	cpu_data->states[idx_timer].misses = misses;



