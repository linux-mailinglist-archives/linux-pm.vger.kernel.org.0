Return-Path: <linux-pm+bounces-25400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFEDA88D60
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9167E3B4FE5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33901F0E58;
	Mon, 14 Apr 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M4e5jaTS"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD01EB5D6;
	Mon, 14 Apr 2025 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663960; cv=none; b=gUIY07UeptYUYWIuPxSgtd/RoPbe8L7J50RqB1kOauGPo8qMSJuLgPHuClKsjTSZ2kk8zrWFrNptSjTIsGsjg4tBwF8lAHLS1mq0XxUtpKCEAxgXOBas3/sfuT+5Aj4jgzuRfD40D8i4Y+u533kjgwbX8izyvW2Bgi8SOIMCIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663960; c=relaxed/simple;
	bh=nXmokx4zsrPOcbRyjM4FeJRr/pD4smrvip028fQHIoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+8DmE5agzlOliwWOQgmOy2xcDailiMz7aAN7sNpzUTDOzpjVIBO9IAUQg+RCs2CXrWc0qYTXcRrAm928Q8HC3pQejCPh0XI2IqcVNVyAzbNJksiWat7J2DcB3LQqJWSLK6kEls56T8PC1jBL3mByylzPQKW7M253bX8RMoJ4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M4e5jaTS; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 559E56625C7;
	Mon, 14 Apr 2025 22:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744663953;
	bh=nXmokx4zsrPOcbRyjM4FeJRr/pD4smrvip028fQHIoI=;
	h=From:Subject:Date;
	b=M4e5jaTSPihhj0hS5+tQx+bGdbRnup1YqrhgUBFhYvc/Xg0sja5JfXRoUgcg1ljhk
	 ryYUCv9cSIOWaaY214z/oz87NYqNdP8X2zwWibJhitzkb+OEfg0kzdYiQv8zmnrx9/
	 f79cYHL0XwmvgHAtzPLc5UWrLxXIG8wLHbPCfYN0OwzAlWbLdB93t/f+rzrfrtrLc2
	 tWa93hPGlfiWzQ91ftPBRRoJgSxf+4b4S04VU1+Mqhq/THfDHxyR58Kq5dZuPymwVL
	 7Nnjpw/sF9lHlnf4p7Zdq+3t4iYssbkyShnydzh7T6oQG04MxJS1FGkZsJTvYmbUPj
	 DXYcyMhWHPrQw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Sultan Alsawaf <sultan@kerneltoast.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Subject:
 [PATCH v1 3/5] cpufreq: Rename __resolve_freq() to clamp_and_resolve_freq()
Date: Mon, 14 Apr 2025 22:46:29 +0200
Message-ID: <3642289.iIbC2pHGDl@rjwysocki.net>
In-Reply-To: <3364921.aeNJFYEL58@rjwysocki.net>
References: <3364921.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for subsequent changes rename a function in the cpufreq
core as per the subject and while at it, clean up some white space
around the declaration for that function.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -490,8 +490,9 @@
 }
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
-static unsigned int __resolve_freq(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
+					   unsigned int target_freq,
+					   unsigned int relation)
 {
 	unsigned int idx;
 
@@ -520,7 +521,7 @@
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq)
 {
-	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
+	return clamp_and_resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2338,7 +2339,7 @@
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = __resolve_freq(policy, target_freq, relation);
+	target_freq = clamp_and_resolve_freq(policy, target_freq, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2634,8 +2635,8 @@
 	 */
 	policy->min = new_data.min;
 	policy->max = new_data.max;
-	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
-	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
+	policy->min = clamp_and_resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
+	policy->max = clamp_and_resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
 	trace_cpu_frequency_limits(policy);
 
 	cpufreq_update_pressure(policy);




