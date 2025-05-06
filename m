Return-Path: <linux-pm+bounces-26752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1AAACEF9
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE24D4C8708
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7011F37D3;
	Tue,  6 May 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YwQlPv5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE01BC099;
	Tue,  6 May 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746564586; cv=none; b=TXdIgAJtwNYIBa4hwt81HjoskiTu3W7TOlupZVxcGUGW5YZ4+s+YIShP/jwkpo5hTo+G/KBrAfncLQtu3FXXr5FynJXOiLwwUGJVA15Wx7jSeE1BMgx2/C5xDxcM6A+lyGGq982C8hrg27PG317PY4N1iCpucTS2r8XLt8Hovvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746564586; c=relaxed/simple;
	bh=RpxsMctV1jrsDxcHCIc3Gn9iSl/41S+1uDF9v0s8jeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncT3STN2vHrAXC4dcMKJJqgBM0m6tcvfNryq35LPFXMmiHepc9N8f+IjTYj8Iz9dxWvq1nI/FadyX+zTYNt750Cf5OZh8zUsU7ksrtPDDxwidOhR1Ug78dsp7v5M6siRrdqhCiU3XvbAsbM0Mm5ASVJyLryZQpccSP2uc0xRfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YwQlPv5u; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3CB24666BB3;
	Tue,  6 May 2025 22:49:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746564577;
	bh=RpxsMctV1jrsDxcHCIc3Gn9iSl/41S+1uDF9v0s8jeg=;
	h=From:Subject:Date;
	b=YwQlPv5ukebRlsVl2efKN6GTenU9JpNZnvmJhKq+wJsa6HXdUQiX++My/3I+6b7vs
	 2nJus3ne6UhMvmKjJ36/0kKyAh3VH34Au6C/H7ielmAEF0b7IKSuzgZ0XUi20bQhbc
	 i1UmK94w7e6XQCdMgcEA90DIfqnInBtys3A5K38MYpyGYbyKZ8Ly4ELnqV/eHY5Sgd
	 zesgNxLUs6HZyiqYB5Bxt2BXmkMMHgAS3oTSk5XwvftwTHGTTCc7CA+2Z8kkvtjau+
	 BI/wt2KKbEqo+ngkPdMR1ZXDzpUnWh8LuHD1eCp+NoF8dYtwBto9MuCL88X64Joy9M
	 08DblzFhSwaKQ==
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
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v2 1/7] cpufreq/sched: schedutil: Add helper for governor checks
Date: Tue, 06 May 2025 22:34:31 +0200
Message-ID: <3365956.44csPzL39Z@rjwysocki.net>
In-Reply-To: <2999205.e9J7NaK4W3@rjwysocki.net>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a helper for checking if schedutil is the current governor for
a given cpufreq policy and use it in sched_is_eas_possible() to avoid
accessing cpufreq policy internals directly from there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

v1 -> v2: Pick up tags

---
 include/linux/cpufreq.h          |    9 +++++++++
 kernel/sched/cpufreq_schedutil.c |    9 +++++++--
 kernel/sched/sched.h             |    2 --
 kernel/sched/topology.c          |    6 +++---
 4 files changed, 19 insertions(+), 7 deletions(-)

--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -650,6 +650,15 @@
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+bool sugov_is_governor(struct cpufreq_policy *policy);
+#else
+static inline bool sugov_is_governor(struct cpufreq_policy *policy)
+{
+	return false;
+}
+#endif
+
 static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 {
 	if (policy->max < policy->cur)
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -630,7 +630,7 @@
 
 /********************** cpufreq governor interface *********************/
 
-struct cpufreq_governor schedutil_gov;
+static struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 {
@@ -909,7 +909,7 @@
 	WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
-struct cpufreq_governor schedutil_gov = {
+static struct cpufreq_governor schedutil_gov = {
 	.name			= "schedutil",
 	.owner			= THIS_MODULE,
 	.flags			= CPUFREQ_GOV_DYNAMIC_SWITCHING,
@@ -927,4 +927,9 @@
 }
 #endif
 
+bool sugov_is_governor(struct cpufreq_policy *policy)
+{
+	return policy->governor == &schedutil_gov;
+}
+
 cpufreq_governor_init(schedutil_gov);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3509,8 +3509,6 @@
 	return static_branch_unlikely(&sched_energy_present);
 }
 
-extern struct cpufreq_governor schedutil_gov;
-
 #else /* ! (CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 #define perf_domain_span(pd) NULL
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -213,7 +213,7 @@
 {
 	bool any_asym_capacity = false;
 	struct cpufreq_policy *policy;
-	struct cpufreq_governor *gov;
+	bool policy_is_ready;
 	int i;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
@@ -258,9 +258,9 @@
 			}
 			return false;
 		}
-		gov = policy->governor;
+		policy_is_ready = sugov_is_governor(policy);
 		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
+		if (!policy_is_ready) {
 			if (sched_debug()) {
 				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
 					cpumask_pr_args(cpu_mask));




