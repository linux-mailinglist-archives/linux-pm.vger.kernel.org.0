Return-Path: <linux-pm+bounces-23652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519BA57252
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276451898E6E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049052571DE;
	Fri,  7 Mar 2025 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="N1RWcxwA"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAB256C63;
	Fri,  7 Mar 2025 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376574; cv=none; b=Mf81nRq8kzcrRRSvzq1qbdXt0/4jikBsyF7bTz0eJ8bjGQQyCSTPld0kf5mc/jJNTLQr6AL7x/AXBmn11h5lI1LuAl8NlYa1saw1gYpr16KHgVyUYiKCJOIL8r082tkuUDHx5vKr5VlCompERnx1OZzyAsJRqaBqiG7FbwWbbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376574; c=relaxed/simple;
	bh=1y59WxewAlScMgxwdnWQ5QLkGAO48EMO5UaovuoTGnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYnvvS6KT+6g7bcSfqsgZGMc8ArqJ/fs6H4OtFLO0G17Y2PTyPpX2QEXk3koLXPBOf/1JB/IUNLH99aGGPqg/1G83OJqonO2lYiEd+U3D2Vw36io8iiEelZbV5N9KGN8DdkYIa3zXYbY4z5d35l+P2MK8hpeYYzSt5NExZ1418M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=N1RWcxwA; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id b9301e00359c0706; Fri, 7 Mar 2025 20:42:45 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8824C9A0BFB;
	Fri,  7 Mar 2025 20:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1741376565;
	bh=1y59WxewAlScMgxwdnWQ5QLkGAO48EMO5UaovuoTGnI=;
	h=From:Subject:Date;
	b=N1RWcxwAi+uD3EAvZmNKq86mE4KaJaYeIh3z6QpLZSt8nP9Vuxgr42l4k9PY6ieT4
	 BR+UibhephL7j7Xz4tFZsUmbA+9yfxkba9jLv37evbCr0mRZp8GeNHnjYVVrG5GADm
	 s9Xsb6Yhm2rZ7G6wQRCrATBMgqeHPTVgfaMg1XjGylTfAFXoyZJec2pFbQWfZFgtaR
	 uCZAqnTZJkAOjqIzJZKLbcILRqCVzF0fYMRWzuptMaTKhGGArHRD2FnNO27TZVVw9P
	 lWRzFWox2L2lfNGpueRmPrhkmCdsYCMwNqpWQJEHLfI2A+ODFh5ILPEDaCzoftmCYq
	 oWS0Io7FAjSHg==
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
 [RFC][PATCH v0.3 1/6] cpufreq/sched: schedutil: Add helper for governor
 checks
Date: Fri, 07 Mar 2025 20:15:42 +0100
Message-ID: <1840739.VLH7GnMWUR@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a helper for checking if schedutil is the current governor for
a given cpufreq policy and use it in sched_is_eas_possible() to avoid
accessing cpufreq policy internals directly from there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/cpufreq.h          |    9 +++++++++
 kernel/sched/cpufreq_schedutil.c |    9 +++++++--
 kernel/sched/sched.h             |    2 --
 kernel/sched/topology.c          |    6 +++---
 4 files changed, 19 insertions(+), 7 deletions(-)

--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -641,6 +641,15 @@
 struct cpufreq_governor *cpufreq_default_governor(void);
 struct cpufreq_governor *cpufreq_fallback_governor(void);
 
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+bool sugov_is_cpufreq_governor(struct cpufreq_policy *policy);
+#else
+static inline bool sugov_is_cpufreq_governor(struct cpufreq_policy *policy)
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
@@ -604,7 +604,7 @@
 
 /********************** cpufreq governor interface *********************/
 
-struct cpufreq_governor schedutil_gov;
+static struct cpufreq_governor schedutil_gov;
 
 static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
 {
@@ -874,7 +874,7 @@
 	sg_policy->limits_changed = true;
 }
 
-struct cpufreq_governor schedutil_gov = {
+static struct cpufreq_governor schedutil_gov = {
 	.name			= "schedutil",
 	.owner			= THIS_MODULE,
 	.flags			= CPUFREQ_GOV_DYNAMIC_SWITCHING,
@@ -892,4 +892,9 @@
 }
 #endif
 
+bool sugov_is_cpufreq_governor(struct cpufreq_policy *policy)
+{
+	return policy->governor == &schedutil_gov;
+}
+
 cpufreq_governor_init(schedutil_gov);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3552,8 +3552,6 @@
 	return static_branch_unlikely(&sched_energy_present);
 }
 
-extern struct cpufreq_governor schedutil_gov;
-
 #else /* ! (CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 #define perf_domain_span(pd) NULL
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -216,7 +216,7 @@
 {
 	bool any_asym_capacity = false;
 	struct cpufreq_policy *policy;
-	struct cpufreq_governor *gov;
+	bool policy_is_ready;
 	int i;
 
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
@@ -261,9 +261,9 @@
 			}
 			return false;
 		}
-		gov = policy->governor;
+		policy_is_ready = sugov_is_cpufreq_governor(policy);
 		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
+		if (!policy_is_ready) {
 			if (sched_debug()) {
 				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
 					cpumask_pr_args(cpu_mask));




