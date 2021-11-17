Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E068B4547E4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 14:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhKQOAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 09:00:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46060 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKQOAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 09:00:33 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 816f5c0f100f6a4a; Wed, 17 Nov 2021 14:57:33 +0100
Received: from kreacher.localnet (unknown [213.134.175.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B5E2066AB6F;
        Wed, 17 Nov 2021 14:57:32 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix active mode offline/online EPP handling
Date:   Wed, 17 Nov 2021 14:57:31 +0100
Message-ID: <2609364.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.214
X-CLIENT-HOSTNAME: 213.134.175.214
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdevgfetueetheekudeuvdduteelvefftdfftdejjeeukeffteeikefgiefghedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudejhedrvddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvudegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and
->online callbacks") the EPP value set by the "performance" scaling
algorithm in the active mode is not restored after an offline/online
cycle which replaces it with the saved EPP value coming from user
space.

Address this issue by forcing intel_pstate_hwp_set() to set a new
EPP value when it runs first time after online.

Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online callbacks")
Link: https://lore.kernel.org/linux-pm/adc7132c8655bd4d1c8b6129578e931a14fe1db2.camel@linux.intel.com/
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1006,6 +1006,12 @@ static void intel_pstate_hwp_offline(str
 		 */
 		value &= ~GENMASK_ULL(31, 24);
 		value |= HWP_ENERGY_PERF_PREFERENCE(cpu->epp_cached);
+		/*
+		 * However, make sure that EPP will be set to "performance" when
+		 * the CPU is brought back online again and the "performance"
+		 * scaling algorithm is still in effect.
+		 */
+		cpu->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 	}
 
 	/*



