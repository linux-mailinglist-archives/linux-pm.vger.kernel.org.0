Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892C034D76C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhC2Shl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 14:37:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58862 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhC2She (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 14:37:34 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 74fd3ee51afe9a10; Mon, 29 Mar 2021 20:37:30 +0200
Received: from kreacher.localnet (89-64-81-131.dynamic.chello.pl [89.64.81.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9C724669165;
        Mon, 29 Mar 2021 20:37:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Subject: [PATCH v1 5/5] cpuidle: menu: Take negative "sleep length" values into account
Date:   Mon, 29 Mar 2021 20:37:12 +0200
Message-ID: <7927358.NyiUUSuA9g@kreacher>
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
Subject: [PATCH] cpuidle: menu: Take negative "sleep length" values into account

Make the menu governor check the tick_nohz_get_next_hrtimer()
return value so as to avoid dealing with negative "sleep length"
values and make it use that value directly when the tick is stopped.

While at it, rename local variable delta_next in menu_select() to
delta_tick which better reflects its purpose.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_dr
 	u64 predicted_ns;
 	u64 interactivity_req;
 	unsigned long nr_iowaiters;
-	ktime_t delta_next;
+	ktime_t delta, delta_tick;
 	int i, idx;
 
 	if (data->needs_update) {
@@ -280,7 +280,12 @@ static int menu_select(struct cpuidle_dr
 	}
 
 	/* determine the expected residency time, round up */
-	data->next_timer_ns = tick_nohz_get_sleep_length(&delta_next);
+	delta = tick_nohz_get_sleep_length(&delta_tick);
+	if (unlikely(delta < 0)) {
+		delta = 0;
+		delta_tick = 0;
+	}
+	data->next_timer_ns = delta;
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
@@ -318,7 +323,7 @@ static int menu_select(struct cpuidle_dr
 		 * state selection.
 		 */
 		if (predicted_ns < TICK_NSEC)
-			predicted_ns = delta_next;
+			predicted_ns = data->next_timer_ns;
 	} else {
 		/*
 		 * Use the performance multiplier and the user-configurable
@@ -377,7 +382,7 @@ static int menu_select(struct cpuidle_dr
 			 * stuck in the shallow one for too long.
 			 */
 			if (drv->states[idx].target_residency_ns < TICK_NSEC &&
-			    s->target_residency_ns <= delta_next)
+			    s->target_residency_ns <= delta_tick)
 				idx = i;
 
 			return idx;
@@ -399,7 +404,7 @@ static int menu_select(struct cpuidle_dr
 	     predicted_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
 		*stop_tick = false;
 
-		if (idx > 0 && drv->states[idx].target_residency_ns > delta_next) {
+		if (idx > 0 && drv->states[idx].target_residency_ns > delta_tick) {
 			/*
 			 * The tick is not going to be stopped and the target
 			 * residency of the state to be returned is not within
@@ -411,7 +416,7 @@ static int menu_select(struct cpuidle_dr
 					continue;
 
 				idx = i;
-				if (drv->states[i].target_residency_ns <= delta_next)
+				if (drv->states[i].target_residency_ns <= delta_tick)
 					break;
 			}
 		}



