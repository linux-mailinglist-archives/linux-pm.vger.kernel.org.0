Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC803DBAC2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhG3Ojn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 10:39:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57384 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbhG3Ojl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 10:39:41 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 2a845c5bd94e4d5e; Fri, 30 Jul 2021 16:39:33 +0200
Received: from kreacher.localnet (89-64-81-8.dynamic.chello.pl [89.64.81.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EA4C6669F3A;
        Fri, 30 Jul 2021 16:39:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/2] cpuidle: teo: Rename two local variables in teo_select()
Date:   Fri, 30 Jul 2021 16:38:52 +0200
Message-ID: <12823871.uLZWGnKmhe@kreacher>
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

Rename two local variables in teo_select() so that their names better
reflect their purpose.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -382,8 +382,8 @@ static int teo_select(struct cpuidle_dri
 	alt_intercepts = 2 * idx_intercept_sum > cpu_data->total - idx_hit_sum;
 	alt_recent = idx_recent_sum > NR_RECENT / 2;
 	if (alt_recent || alt_intercepts) {
-		s64 last_enabled_span_ns = duration_ns;
-		int last_enabled_idx = idx;
+		s64 first_suitable_span_ns = duration_ns;
+		int first_suitable_idx = idx;
 
 		/*
 		 * Look for the deepest idle state whose target residency had
@@ -419,8 +419,8 @@ static int teo_select(struct cpuidle_dri
 					 * disabled, so take the first enabled
 					 * deeper state with suitable time span.
 					 */
-					idx = last_enabled_idx;
-					duration_ns = last_enabled_span_ns;
+					idx = first_suitable_idx;
+					duration_ns = first_suitable_span_ns;
 				}
 				break;
 			}
@@ -434,14 +434,14 @@ static int teo_select(struct cpuidle_dri
 				 * alternative candidate state has been found,
 				 * it may still turn out to be a better choice.
 				 */
-				if (last_enabled_idx != idx)
+				if (first_suitable_idx != idx)
 					continue;
 
 				break;
 			}
 
-			last_enabled_span_ns = span_ns;
-			last_enabled_idx = i;
+			first_suitable_span_ns = span_ns;
+			first_suitable_idx = i;
 		}
 	}
 



