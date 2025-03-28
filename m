Return-Path: <linux-pm+bounces-24584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC42A751A5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A92B1892F0B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404A1E8357;
	Fri, 28 Mar 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="bBB9k8ra"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CCE545;
	Fri, 28 Mar 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195105; cv=none; b=luxjjkLo65JTtzF6jbYcxXLxlS5aqmmubwsRsp+DwRW+R8nXYpr0B6Ly3WlB5ruY+SJSC4Zp7WsBfXgbXlc69QMbEnOVVcTFZsIxpMooo2U+Of2yviAPlF6BWTrrd85skrpiI7Wmwkbc1+eSV0diii37w5AzNtb++y/ayTH7sUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195105; c=relaxed/simple;
	bh=MQZZ3TmtYmYcQaVaYPEoNBH2OXH61DqFYYdTK0HxYJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3BRaq+KEbOCpn6Jq+hjRGN2lSsA4cRZl3dlqHq8xmXvluelp3vBbtHLhAYKw4tedu0ZeFeBiux2yU6/OJKeWq1gIEdWI/buKcIxEEymm7HAu8otkXRfjABV8ACp9FR/yEJYFgcst2rHZP95RIkjbUAa4zggEVagnCLB7jP1AYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=bBB9k8ra; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 563c1f317e1126b2; Fri, 28 Mar 2025 21:51:41 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 70AC97F0283;
	Fri, 28 Mar 2025 21:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743195100;
	bh=MQZZ3TmtYmYcQaVaYPEoNBH2OXH61DqFYYdTK0HxYJs=;
	h=From:Subject:Date;
	b=bBB9k8raFIRc2A/TDXhyMMpqhNxZBIVCVW9tMCKKF7MkMf+NUOX5g1ELwBrtnPU31
	 uaJ6+2USSovJQgAUWdDcRiQz2sWApk1CiWMV8ekiRzo2h9x8zEAZ7pTHa9qzcx2uZS
	 UHsc1tqPd+cT3FyMgt6qSAfFxZzpECDDW04iSRzsgKOZL7+fkxCF9AOrAo0qIptTPw
	 V19aqgiMP0Nb/Ad0CMwGr4iT9ajC+BsmmlOVfYk5TJHhr0TZ7uHgXekyFouqfxJJxO
	 ysEkfqs3S9eGocvzu1jnJ3UpbfpASCfy4Ve8FlUnnv4r+tuIeRjVgXjgVIEzAGpvEX
	 qSkza2XA8G4xg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 09/10] cpufreq: Introduce cpufreq_policy_refresh()
Date: Fri, 28 Mar 2025 21:47:31 +0100
Message-ID: <6047110.MhkbZ0Pkbq@rjwysocki.net>
In-Reply-To: <4651448.LvFx2qVVIh@rjwysocki.net>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since cpufreq_update_limits() obtains a cpufreq policy pointer for the
given CPU and reference counts the object pointed to by it, calling
cpufreq_update_policy() from cpufreq_update_limits() is somewhat
wasteful because that function calls cpufreq_cpu_get() on the same
CPU again.

To avoid that unnecessary overhead, move the part of the code running
under the policy rwsem from cpufreq_update_policy() to a new function
called cpufreq_policy_refresh() and invoke that new function from
both cpufreq_update_policy() and cpufreq_update_limits().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2689,6 +2689,21 @@
 	return ret;
 }
 
+static void cpufreq_policy_refresh(struct cpufreq_policy *policy)
+{
+	guard(cpufreq_policy_write)(policy);
+
+	/*
+	 * BIOS might change freq behind our back
+	 * -> ask driver for current freq and notify governors about a change
+	 */
+	if (cpufreq_driver->get && has_target() &&
+	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+		return;
+
+	refresh_frequency_limits(policy);
+}
+
 /**
  * cpufreq_update_policy - Re-evaluate an existing cpufreq policy.
  * @cpu: CPU to re-evaluate the policy for.
@@ -2706,17 +2721,7 @@
 	if (!policy)
 		return;
 
-	guard(cpufreq_policy_write)(policy);
-
-	/*
-	 * BIOS might change freq behind our back
-	 * -> ask driver for current freq and notify governors about a change
-	 */
-	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
-		return;
-
-	refresh_frequency_limits(policy);
+	cpufreq_policy_refresh(policy);
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
@@ -2725,7 +2730,7 @@
  * @cpu: CPU to update the policy limits for.
  *
  * Invoke the driver's ->update_limits callback if present or call
- * cpufreq_update_policy() for @cpu.
+ * cpufreq_policy_refresh() for @cpu.
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
@@ -2738,7 +2743,7 @@
 	if (cpufreq_driver->update_limits)
 		cpufreq_driver->update_limits(cpu);
 	else
-		cpufreq_update_policy(cpu);
+		cpufreq_policy_refresh(policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 




