Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16A3DBAC3
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbhG3Ojn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 10:39:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46184 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbhG3Ojl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 10:39:41 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 846070bec0f569d8; Fri, 30 Jul 2021 16:39:35 +0200
Received: from kreacher.localnet (89-64-81-8.dynamic.chello.pl [89.64.81.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 78DF7669F3A;
        Fri, 30 Jul 2021 16:39:34 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/2] cpuidle: teo: Fix alternative idle state lookup
Date:   Fri, 30 Jul 2021 16:38:07 +0200
Message-ID: <1794352.tdWV9SEqCh@kreacher>
In-Reply-To: <4336554.LvFx2qVVIh@kreacher>
References: <4336554.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.8
X-CLIENT-HOSTNAME: 89-64-81-8.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrheehgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdekuddrkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegushhmhihthhhivghssehtvghluhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are three mistakes in the loop in teo_select() that is looking
for an alternative candidate idle state.  First, it should walk all
of the idle states shallower than the current candidate one,
including all of the disabled ones, but it terminates after the first
enabled idle state.  Second, it should not terminate its last step
if idle state 0 is disabled (which is related to the first issue).
Finally, it may return the current alternative candidate idle state
prematurely if the time span criterion is not met by the idle state
under consideration at the moment.

To address the issues mentioned above, make the loop in question walk
all of the idle states shallower than the current candidate idle state
all the way down to idle state 0 and rearrange the checks in it.

Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -397,32 +397,46 @@ static int teo_select(struct cpuidle_dri
 		intercept_sum = 0;
 		recent_sum = 0;
 
-		for (i = idx - 1; i >= idx0; i--) {
+		for (i = idx - 1; i >= 0; i--) {
 			struct teo_bin *bin = &cpu_data->state_bins[i];
 			s64 span_ns;
 
 			intercept_sum += bin->intercepts;
 			recent_sum += bin->recent;
 
+			span_ns = teo_middle_of_bin(i, drv);
+
+			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
+			    (!alt_intercepts ||
+			     2 * intercept_sum > idx_intercept_sum)) {
+				if (teo_time_ok(span_ns) &&
+				    !dev->states_usage[i].disable) {
+					idx = i;
+					duration_ns = span_ns;
+				} else {
+					/*
+					 * The current state is too shallow or
+					 * disabled, so take the first enabled
+					 * deeper state with suitable time span.
+					 */
+					idx = last_enabled_idx;
+					duration_ns = last_enabled_span_ns;
+				}
+				break;
+			}
+
 			if (dev->states_usage[i].disable)
 				continue;
 
-			span_ns = teo_middle_of_bin(i, drv);
 			if (!teo_time_ok(span_ns)) {
 				/*
-				 * The current state is too shallow, so select
-				 * the first enabled deeper state.
+				 * The current state is too shallow, but if an
+				 * alternative candidate state has been found,
+				 * it may still turn out to be a better choice.
 				 */
-				duration_ns = last_enabled_span_ns;
-				idx = last_enabled_idx;
-				break;
-			}
+				if (last_enabled_idx != idx)
+					continue;
 
-			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
-			    (!alt_intercepts ||
-			     2 * intercept_sum > idx_intercept_sum)) {
-				idx = i;
-				duration_ns = span_ns;
 				break;
 			}
 



