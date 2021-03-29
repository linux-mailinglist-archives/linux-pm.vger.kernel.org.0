Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1234D776
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhC2SiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 14:38:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55068 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhC2Shp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 14:37:45 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id bd3a92e6c8355cdb; Mon, 29 Mar 2021 20:37:43 +0200
Received: from kreacher.localnet (89-64-81-131.dynamic.chello.pl [89.64.81.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4091E669165;
        Mon, 29 Mar 2021 20:37:42 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Subject: [RFC][PATCH 1/5] tick/nohz: Improve tick_nohz_get_next_hrtimer() kerneldoc
Date:   Mon, 29 Mar 2021 20:11:49 +0200
Message-ID: <1775695.tdWV9SEqCh@kreacher>
In-Reply-To: <2188825.ElGaqSPkdT@kreacher>
References: <2188825.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdekuddrudefudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudefuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghp
 thhtohepgidvtddulegtfihmsehsthhfgidrtggr
X-DCC--Metrics: v370.home.net.pl 1024; Body=13 Fuz1=13 Fuz2=13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Make the tick_nohz_get_next_hrtimer() kerneldoc comment state clearly
that the function may return negative numbers.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-sched.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -1124,7 +1124,11 @@ ktime_t tick_nohz_get_next_hrtimer(void)
  * tick_nohz_get_sleep_length - return the expected length of the current sleep
  * @delta_next: duration until the next event if the tick cannot be stopped
  *
- * Called from power state control code with interrupts disabled
+ * Called from power state control code with interrupts disabled.
+ *
+ * The return value of this function and/or the value returned by it through the
+ * @delta_next pointer can be negative which must be taken into account by its
+ * callers.
  */
 ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {



