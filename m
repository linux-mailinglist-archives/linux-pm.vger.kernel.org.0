Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24AE44487A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 19:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhKCSq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 14:46:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57168 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCSq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Nov 2021 14:46:27 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id d43e149fe9a20e37; Wed, 3 Nov 2021 19:43:49 +0100
Received: from kreacher.localnet (unknown [213.134.161.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A3DEC661F93;
        Wed,  3 Nov 2021 19:43:48 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] cpufreq: intel_pstate: Clear HWP desired on suspend/shutdown and offline
Date:   Wed, 03 Nov 2021 19:43:47 +0100
Message-ID: <2619739.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.207
X-CLIENT-HOSTNAME: 213.134.161.207
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrtddvgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeiuddrvddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedurddvtdejpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehjuhhlihgrrdhlrgifrghllhesihhnrhhirgdrfhhr
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit a365ab6b9dfb ("cpufreq: intel_pstate: Implement the
->adjust_perf() callback") caused intel_pstate to use nonzero HWP
desired values in certain usage scenarios, but it did not prevent
them from being leaked into the confugirations in which HWP desired
is expected to be 0.

The failing scenarios are switching the driver from the passive
mode to the active mode and starting a new kernel via kexec() while
intel_pstate is running in the passive mode.

To address this issue, ensure that HWP desired will be cleared on
offline and suspend/shutdown.

Fixes: a365ab6b9dfb ("cpufreq: intel_pstate: Implement the ->adjust_perf() callback")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Tested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1006,9 +1006,16 @@ static void intel_pstate_hwp_offline(str
 		 */
 		value &= ~GENMASK_ULL(31, 24);
 		value |= HWP_ENERGY_PERF_PREFERENCE(cpu->epp_cached);
-		WRITE_ONCE(cpu->hwp_req_cached, value);
 	}
 
+	/*
+	 * Clear the desired perf field in the cached HWP request value to
+	 * prevent nonzero desired values from being leaked into the active
+	 * mode.
+	 */
+	value &= ~HWP_DESIRED_PERF(~0L);
+	WRITE_ONCE(cpu->hwp_req_cached, value);
+
 	value &= ~GENMASK_ULL(31, 0);
 	min_perf = HWP_LOWEST_PERF(READ_ONCE(cpu->hwp_cap_cached));
 
@@ -3003,6 +3010,27 @@ static int intel_cpufreq_cpu_exit(struct
 	return intel_pstate_cpu_exit(policy);
 }
 
+static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
+{
+	intel_pstate_suspend(policy);
+
+	if (hwp_active) {
+		struct cpudata *cpu = all_cpu_data[policy->cpu];
+		u64 value = READ_ONCE(cpu->hwp_req_cached);
+
+		/*
+		 * Clear the desired perf field in MSR_HWP_REQUEST in case
+		 * intel_cpufreq_adjust_perf() is in use and the last value
+		 * written by it may not be suitable.
+		 */
+		value &= ~HWP_DESIRED_PERF(~0L);
+		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+		WRITE_ONCE(cpu->hwp_req_cached, value);
+	}
+
+	return 0;
+}
+
 static struct cpufreq_driver intel_cpufreq = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.verify		= intel_cpufreq_verify_policy,
@@ -3012,7 +3040,7 @@ static struct cpufreq_driver intel_cpufr
 	.exit		= intel_cpufreq_cpu_exit,
 	.offline	= intel_cpufreq_cpu_offline,
 	.online		= intel_pstate_cpu_online,
-	.suspend	= intel_pstate_suspend,
+	.suspend	= intel_cpufreq_suspend,
 	.resume		= intel_pstate_resume,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",



