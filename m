Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36FD36718C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbhDURld (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 13:41:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51594 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbhDURlc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 13:41:32 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 31b07786e97dcc5f; Wed, 21 Apr 2021 19:40:57 +0200
Received: from kreacher.localnet (89-64-80-44.dynamic.chello.pl [89.64.80.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A8DFF669387;
        Wed, 21 Apr 2021 19:40:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: intel_pstate: Use HWP if enabled by platform firmware
Date:   Wed, 21 Apr 2021 19:40:56 +0200
Message-ID: <2602702.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.44
X-CLIENT-HOSTNAME: 89-64-80-44.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddtkedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppeekledrieegrdektddrgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeggedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It turns out that there are systems where HWP is enabled during
initialization by the platform firmware (BIOS), but HWP EPP support
is not advertised.

After commit 7aa1031223bc ("cpufreq: intel_pstate: Avoid enabling HWP
if EPP is not supported") intel_pstate refuses to use HWP on those
systems, but the fallback PERF_CTL interface does not work on them
either because of enabled HWP, and once enabled, HWP cannot be
disabled.  Consequently, the users of those systems cannot control
CPU performance scaling.

Address this issue by making intel_pstate use HWP unconditionally if
it is enabled already when the driver starts.

Fixes: 7aa1031223bc ("cpufreq: intel_pstate: Avoid enabling HWP if EPP is not supported")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.9+ <stable@vger.kernel.org> # 5.9+
---
 drivers/cpufreq/intel_pstate.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -3229,6 +3229,14 @@ static const struct x86_cpu_id hwp_suppo
 	{}
 };
 
+static bool intel_pstate_hwp_is_enabled(void)
+{
+	u64 value;
+
+	rdmsrl(MSR_PM_ENABLE, value);
+	return !!(value & 0x1);
+}
+
 static int __init intel_pstate_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -3247,8 +3255,12 @@ static int __init intel_pstate_init(void
 		 * Avoid enabling HWP for processors without EPP support,
 		 * because that means incomplete HWP implementation which is a
 		 * corner case and supporting it is generally problematic.
+		 *
+		 * If HWP is enabled already, though, there is no choice but to
+		 * deal with it.
 		 */
-		if (!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) {
+		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) ||
+		    intel_pstate_hwp_is_enabled()) {
 			hwp_active++;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;



