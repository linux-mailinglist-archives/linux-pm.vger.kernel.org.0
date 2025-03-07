Return-Path: <linux-pm+bounces-23653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAE7A57254
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BB16DEC0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E2257AD1;
	Fri,  7 Mar 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ELAXfuXQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0027256C64;
	Fri,  7 Mar 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376577; cv=none; b=lmcWQ+ewlaSxxmjhZ8rKcjXGd2gGZDyvrhoEmPlpo4W4TsWKO4BPf8nFzUboLOf5KMxCA6y/7kJC51JMJPppv9jJGfbTDm3xLBNvpeHUnf61sMUcUthE2Bovaegg/i+SRuix5hvlmUBpfonAKvd6251PVci1gBO4QR2uvccNkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376577; c=relaxed/simple;
	bh=25uNFJVAZnPmoWvltcPZLOgQK9aoLiwhfXgiuw3qxHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUTfjyhpeR5om72LIYEVdE/B78ZqIgklfsB6dH5LCuPRBLymOK5XFNF2scn62DmgkyUAxG1hitYXhcY/fHCXGlGhLgWzE9t5oQSn25sQdKZg+lPerGG1v/qV9EHDH57Nz/R/LTSnXv00LNAVjUR9/R89udKP330uDxtt2/L5rXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ELAXfuXQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 018cce7891fe7508; Fri, 7 Mar 2025 20:42:44 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6AE0C9A0BFB;
	Fri,  7 Mar 2025 20:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376563;
	bh=25uNFJVAZnPmoWvltcPZLOgQK9aoLiwhfXgiuw3qxHM=;
	h=From:Subject:Date;
	b=ELAXfuXQgEVAXvvswdzovxljFBYapZLrai339vgE5is+r9PSZ/m3cf0JS13IQTYUN
	 32eIXsA2Q6Hac+8ZGuUgMeRCvviHQjhxQN95/dNZIKshTGb5OE3B5Nckrjldjn/J7Z
	 R0fHeLxs485LG6lRTVrWLC3xQ861Ma+gGSNGXoPucWWmyDTYYsNgE2g0gwE9wbj38T
	 xzR+reMU/UCEqGwRp9WgbritoN/xmPDAOjTrilzPzf01exML6LYFAWuqMvnuySmydb
	 GA00K/18+ncJJh5wlOu0cNyqyxhXdXwjvtt3fujqCJuYWCmxXfpW83Qt0FqcdNPLwz
	 VJ7V4SlJwACiw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject:
 [RFC][PATCH v0.3 2/6] cpufreq/sched: Move cpufreq-specific EAS checks to
 cpufreq
Date: Fri, 07 Mar 2025 20:16:03 +0100
Message-ID: <2038066.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <22640172.EfDdHjke4D@rjwysocki.net>
References: <22640172.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Doing cpufreq-specific EAS checks that require accessing policy
internals directly from sched_is_eas_possible() is a bit unfortunate,
so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
into that new function and make sched_is_eas_possible() call it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   30 ++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    2 ++
 kernel/sched/topology.c   |   25 +++++--------------------
 3 files changed, 37 insertions(+), 20 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -3052,6 +3052,36 @@
 
 	return 0;
 }
+
+bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
+{
+	int i;
+
+	/* Do not attempt EAS if schedutil is not being used. */
+	for_each_cpu(i, cpu_mask) {
+		struct cpufreq_policy *policy;
+		bool policy_is_ready;
+
+		policy = cpufreq_cpu_get(i);
+		if (!policy) {
+			pr_debug("rd %*pbl: cpufreq policy not set for CPU: %d",
+				 cpumask_pr_args(cpu_mask), i);
+
+			return false;
+		}
+		policy_is_ready = sugov_is_cpufreq_governor(policy);
+		cpufreq_cpu_put(policy);
+		if (!policy_is_ready) {
+			pr_debug("rd %*pbl: schedutil is mandatory for EAS\n",
+				 cpumask_pr_args(cpu_mask));
+
+			return false;
+		}
+	}
+
+	return true;
+}
+
 module_param(off, int, 0444);
 module_param_string(default_governor, default_governor, CPUFREQ_NAME_LEN, 0444);
 core_initcall(cpufreq_core_init);
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1215,6 +1215,8 @@
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
 
+bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask);
+
 static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
 {
 	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -215,8 +215,6 @@
 static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 {
 	bool any_asym_capacity = false;
-	struct cpufreq_policy *policy;
-	bool policy_is_ready;
 	int i;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
@@ -251,25 +249,12 @@
 		return false;
 	}
 
-	/* Do not attempt EAS if schedutil is not being used. */
-	for_each_cpu(i, cpu_mask) {
-		policy = cpufreq_cpu_get(i);
-		if (!policy) {
-			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
-					cpumask_pr_args(cpu_mask), i);
-			}
-			return false;
-		}
-		policy_is_ready = sugov_is_cpufreq_governor(policy);
-		cpufreq_cpu_put(policy);
-		if (!policy_is_ready) {
-			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
-					cpumask_pr_args(cpu_mask));
-			}
-			return false;
+	if (!cpufreq_ready_for_eas(cpu_mask)) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS: cpufreq is not ready",
+				cpumask_pr_args(cpu_mask));
 		}
+		return false;
 	}
 
 	return true;




