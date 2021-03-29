Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7834D769
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhC2Shl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 14:37:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64458 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhC2Shi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 14:37:38 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 182b48a7b900cf93; Mon, 29 Mar 2021 20:37:37 +0200
Received: from kreacher.localnet (89-64-81-131.dynamic.chello.pl [89.64.81.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 357E1669165;
        Mon, 29 Mar 2021 20:37:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Subject: [PATCH v1 2/5] cpuidle: Use s64 as exit_latency_ns and target_residency_ns data type
Date:   Mon, 29 Mar 2021 20:15:19 +0200
Message-ID: <1850839.PYKUYFuaPT@kreacher>
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

Subsequent changes will cause the exit_latency_ns and target_residency_ns
fields in struct cpuidle_state to be used in computations in which data
type conversions to u64 may turn a negative number close to zero into
a verly large positive number leading to incorrect results.

In preparation for that, change the data type of the fields mentioned
above to s64, but ensure that they will not be negative themselves.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/driver.c |    4 ++++
 include/linux/cpuidle.h  |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -49,8 +49,8 @@ struct cpuidle_state {
 	char		name[CPUIDLE_NAME_LEN];
 	char		desc[CPUIDLE_DESC_LEN];
 
-	u64		exit_latency_ns;
-	u64		target_residency_ns;
+	s64		exit_latency_ns;
+	s64		target_residency_ns;
 	unsigned int	flags;
 	unsigned int	exit_latency; /* in US */
 	int		power_usage; /* in mW */
Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -181,9 +181,13 @@ static void __cpuidle_driver_init(struct
 		 */
 		if (s->target_residency > 0)
 			s->target_residency_ns = s->target_residency * NSEC_PER_USEC;
+		else if (s->target_residency_ns < 0)
+			s->target_residency_ns = 0;
 
 		if (s->exit_latency > 0)
 			s->exit_latency_ns = s->exit_latency * NSEC_PER_USEC;
+		else if (s->exit_latency_ns < 0)
+			s->exit_latency_ns =  0;
 	}
 }
 



