Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF7356E6E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbhDGOWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 10:22:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58500 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348287AbhDGOWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 10:22:08 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 56eab0b343ef86fc; Wed, 7 Apr 2021 16:21:57 +0200
Received: from kreacher.localnet (89-64-81-116.dynamic.chello.pl [89.64.81.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9AA4E669204;
        Wed,  7 Apr 2021 16:21:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Simplify intel_pstate_update_perf_limits()
Date:   Wed, 07 Apr 2021 16:21:55 +0200
Message-ID: <5450142.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.116
X-CLIENT-HOSTNAME: 89-64-81-116.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdeigedrkedurdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdduudeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohephihurdgtrdgthhgvnhes
 ihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because pstate.max_freq is always equal to the product of
pstate.max_pstate and pstate.scaling and, analogously,
pstate.turbo_freq is always equal to the product of
pstate.turbo_pstate and pstate.scaling, the result of the
max_policy_perf computation in intel_pstate_update_perf_limits() is
always equal to the quotient of policy_max and pstate.scaling,
regardless of whether or not turbo is disabled.  Analogously, the
result of min_policy_perf in intel_pstate_update_perf_limits() is
always equal to the quotient of policy_min and pstate.scaling.

Accordingly, intel_pstate_update_perf_limits() need not check
whether or not turbo is enabled at all and in order to compute
max_policy_perf and min_policy_perf it can always divide policy_max
and policy_min, respectively, by pstate.scaling.  Make it do so.

While at it, move the definition and initialization of the
turbo_max local variable to the code branch using it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of linux-next.

---
 drivers/cpufreq/intel_pstate.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2195,9 +2195,8 @@ static void intel_pstate_update_perf_lim
 					    unsigned int policy_min,
 					    unsigned int policy_max)
 {
+	int scaling = cpu->pstate.scaling;
 	int32_t max_policy_perf, min_policy_perf;
-	int max_state, turbo_max;
-	int max_freq;
 
 	/*
 	 * HWP needs some special consideration, because HWP_REQUEST uses
@@ -2206,33 +2205,24 @@ static void intel_pstate_update_perf_lim
 	if (hwp_active)
 		intel_pstate_get_hwp_cap(cpu);
 
-	if (global.no_turbo || global.turbo_disabled) {
-		max_state = cpu->pstate.max_pstate;
-		max_freq = cpu->pstate.max_freq;
-	} else {
-		max_state = cpu->pstate.turbo_pstate;
-		max_freq = cpu->pstate.turbo_freq;
-	}
-
-	turbo_max = cpu->pstate.turbo_pstate;
-
-	max_policy_perf = max_state * policy_max / max_freq;
+	max_policy_perf = policy_max / scaling;
 	if (policy_max == policy_min) {
 		min_policy_perf = max_policy_perf;
 	} else {
-		min_policy_perf = max_state * policy_min / max_freq;
+		min_policy_perf = policy_min / scaling;
 		min_policy_perf = clamp_t(int32_t, min_policy_perf,
 					  0, max_policy_perf);
 	}
 
-	pr_debug("cpu:%d max_state %d min_policy_perf:%d max_policy_perf:%d\n",
-		 cpu->cpu, max_state, min_policy_perf, max_policy_perf);
+	pr_debug("cpu:%d min_policy_perf:%d max_policy_perf:%d\n",
+		 cpu->cpu, min_policy_perf, max_policy_perf);
 
 	/* Normalize user input to [min_perf, max_perf] */
 	if (per_cpu_limits) {
 		cpu->min_perf_ratio = min_policy_perf;
 		cpu->max_perf_ratio = max_policy_perf;
 	} else {
+		int turbo_max = cpu->pstate.turbo_pstate;
 		int32_t global_min, global_max;
 
 		/* Global limits are in percent of the maximum turbo P-state. */



