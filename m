Return-Path: <linux-pm+bounces-24583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45AA751A3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D1F16ED38
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A71E7648;
	Fri, 28 Mar 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ti0CLPod"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6453E545;
	Fri, 28 Mar 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194953; cv=none; b=CELGQqq/OvH9FYjwsQTty9hhOSVqP3JShF/mQDk+rsmCNt51P+bQ6xulB0pUSTDUG6KgWFvanTTdLCmVzQm5a/NNc+6sM5OduWzsOzWSw+2rmWX809rv2MVqDVvLjVwQSQlpoBbk/chN+3VWGVRMoL6gjCT37yB34YazgKoNPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194953; c=relaxed/simple;
	bh=g7RMliEMabcpLtBmo+l3wn5Zu7NC8J3yDDeIBr9ndeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgeWNcPUYH7QU8XEHomuDmJ6L14n/1cWKwkd5F8bwDZ8GHg2MoaTwDNarvKKzdqJqX6L1TqA2xJ5D9tjPUcdqb5jf3OnPDfubwQ7j1BOPtBTJ0S9UCRfJ03Fd1cn/eTUX5W1jczt8Uzes+d25jtuL9B+6mfwTcJB6q2OfM/rxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ti0CLPod; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 039c0c9098c45059; Fri, 28 Mar 2025 21:49:03 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A773A7F0283;
	Fri, 28 Mar 2025 21:49:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743194943;
	bh=g7RMliEMabcpLtBmo+l3wn5Zu7NC8J3yDDeIBr9ndeY=;
	h=From:Subject:Date;
	b=Ti0CLPodRIt+kE2BvX8FZSkAjmzkNidp/ZhgXbAqYyd/Nie47grB1VI6SQPkGEbyk
	 zZ2daP9YY7GesWWKIq1nnMEKprUFfX06n+Ht6cC30K7kRiWCz4LlTLlkFyfO0oSS2f
	 wX/5Hg5Vs3i/Xl/4j1E3XcbtL3sr2/P8sXmKBVNTpZaQ86ef600QtMGEhDS6h4h4ih
	 Go6N0PJ7fuZ2CMbva+8zLaCK553cP1n0PWsk/jzK/oCaKcFz+xrPfmN0HIqUcBqZLi
	 d/LcZzUELCwatBMb0iDKtKuPmpMUBXJUjQ0W2ZpIgtPuvuaHC4dlNeNI2P3RpCGsDg
	 sQpBP9yNNhOuw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 10/10] cpufreq: Pass policy pointer to ->update_limits()
Date: Fri, 28 Mar 2025 21:48:54 +0100
Message-ID: <8560367.NyiUUSuA9g@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since cpufreq_update_limits() obtains a cpufreq policy pointer for the
given CPU and reference counts the corresponding policy object, it may
as well pass the policy pointer to the cpufreq driver's ->update_limits()
callback which allows that callback to avoid invoking cpufreq_cpu_get()
for the same CPU.

Accordingly, redefine ->update_limits() to take a policy pointer instead
of a CPU number and update both drivers implementing it, intel_pstate
and amd-pstate, as needed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/amd-pstate.c   |    7 ++-----
 drivers/cpufreq/cpufreq.c      |    2 +-
 drivers/cpufreq/intel_pstate.c |   29 ++++++++++++++++++-----------
 include/linux/cpufreq.h        |    2 +-
 4 files changed, 22 insertions(+), 18 deletions(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -821,19 +821,16 @@
 	schedule_work(&sched_prefcore_work);
 }
 
-static void amd_pstate_update_limits(unsigned int cpu)
+static void amd_pstate_update_limits(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 	u32 prev_high = 0, cur_high = 0;
 	bool highest_perf_changed = false;
+	unsigned int cpu = policy->cpu;
 
 	if (!amd_pstate_prefcore)
 		return;
 
-	if (!policy)
-		return;
-
 	if (amd_get_highest_perf(cpu, &cur_high))
 		return;
 
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2741,7 +2741,7 @@
 		return;
 
 	if (cpufreq_driver->update_limits)
-		cpufreq_driver->update_limits(cpu);
+		cpufreq_driver->update_limits(policy);
 	else
 		cpufreq_policy_refresh(policy);
 }
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1353,14 +1353,9 @@
 		cpufreq_update_policy(cpu);
 }
 
-static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
+static void __intel_pstate_update_max_freq(struct cpufreq_policy *policy,
+					   struct cpudata *cpudata)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpudata->cpu);
-	if (!policy)
-		return false;
-
 	guard(cpufreq_policy_write)(policy);
 
 	if (hwp_active)
@@ -1370,16 +1365,28 @@
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 
 	refresh_frequency_limits(policy);
+}
+
+static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+
+	policy = cpufreq_cpu_get(cpudata->cpu);
+	if (!policy)
+		return false;
+
+	__intel_pstate_update_max_freq(policy, cpudata);
 
 	return true;
 }
 
-static void intel_pstate_update_limits(unsigned int cpu)
+static void intel_pstate_update_limits(struct cpufreq_policy *policy)
 {
-	struct cpudata *cpudata = all_cpu_data[cpu];
+	struct cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	__intel_pstate_update_max_freq(policy, cpudata);
 
-	if (intel_pstate_update_max_freq(cpudata))
-		hybrid_update_capacity(cpudata);
+	hybrid_update_capacity(cpudata);
 }
 
 static void intel_pstate_update_limits_for_all(void)
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -399,7 +399,7 @@
 	unsigned int	(*get)(unsigned int cpu);
 
 	/* Called to update policy limits on firmware notifications. */
-	void		(*update_limits)(unsigned int cpu);
+	void		(*update_limits)(struct cpufreq_policy *policy);
 
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);




