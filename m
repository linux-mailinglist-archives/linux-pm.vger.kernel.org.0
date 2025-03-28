Return-Path: <linux-pm+bounces-24585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6025A751A6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 21:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E2B1892E9D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F031EB5CC;
	Fri, 28 Mar 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LDgyNqz5"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E971E7648;
	Fri, 28 Mar 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195105; cv=none; b=dq9YInljpjUMAV+Az4ldf6w3nURId3vatbGYQmhAwHjaRbSstqjvcbUMTAAxYfgDkEViQlGMFYEJPIWZmhAmDmtxn8Mq2oEbKxPBD8InXqBDxNJZtDB6+9WMBU+ORm94JCCr8Ua7SxhCLMzU8YZCsTQh4NwDiXr0AxKHAgPkpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195105; c=relaxed/simple;
	bh=+Ts4n9FPKfhFVYnmMDHNk/hMsfS8W0mva29P6FXp2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrb+r4MwSrVZUKprMn7x5gMzvsc1+LYi2R587+zzWni5sGPu2eEY50WmSaaYtMqqFOWJkrVpnKiM/uvbt/VJOUGyPjjTTqjddsqkdYcXIO6o5JJU/ntYaaX7NRrzb3Qornzks/7ugQVQqGTl32P1OGB/wQwlyO15mBRdHOEQmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LDgyNqz5; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 954f041a9d4142f9; Fri, 28 Mar 2025 21:51:41 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 31FD17F0283;
	Fri, 28 Mar 2025 21:51:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743195101;
	bh=+Ts4n9FPKfhFVYnmMDHNk/hMsfS8W0mva29P6FXp2xo=;
	h=From:Subject:Date;
	b=LDgyNqz5572T2P3+cqxmrntrtVHKhvU9B6xxdtrPNdxty021PytRAfEkdJaYUn3YO
	 Vi3lSjv/ovj/rimDs4ou5a5uCyU5m+gAHATKiXByHO1JFnxMayICRcVkJG6rqh9bQt
	 W/o7fkm054y0ukk4YCFdiryqFhAsVNFET+GfknS07srNbMW9bmBOr9UnIlTRLpxapa
	 SMl98E9a7cxkn0uEPCiFSbgu5jDcALr01JJ8D9wxtjXBK1is1s60y6i5mEiJQtGTVL
	 f8Zu49Qb65CIJHQkUhLpqPwnk8OL6OWc9eutId+wz/UnmWd1nckCBXu8PhcWWr0EbY
	 4vBKXpuLiFHeA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject:
 [PATCH v1 08/10] cpufreq: Use __free() for policy reference counting cleanup
Date: Fri, 28 Mar 2025 21:46:22 +0100
Message-ID: <9437968.CDJkKcVGEf@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use __free() for policy reference counting cleanup where applicable in
the cpufreq core.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   57 ++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1790,27 +1790,26 @@
  */
 unsigned int cpufreq_quick_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy;
-	unsigned int ret_freq = 0;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
 	unsigned long flags;
 
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 
 	if (cpufreq_driver && cpufreq_driver->setpolicy && cpufreq_driver->get) {
-		ret_freq = cpufreq_driver->get(cpu);
+		unsigned int ret_freq = cpufreq_driver->get(cpu);
+
 		read_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 		return ret_freq;
 	}
 
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	policy = cpufreq_cpu_get(cpu);
-	if (policy) {
-		ret_freq = policy->cur;
-		cpufreq_cpu_put(policy);
-	}
+	if (policy)
+		return policy->cur;
 
-	return ret_freq;
+	return 0;
 }
 EXPORT_SYMBOL(cpufreq_quick_get);
 
@@ -1822,15 +1821,13 @@
  */
 unsigned int cpufreq_quick_get_max(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	unsigned int ret_freq = 0;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
 
-	if (policy) {
-		ret_freq = policy->max;
-		cpufreq_cpu_put(policy);
-	}
+	policy = cpufreq_cpu_get(cpu);
+	if (policy)
+		return policy->max;
 
-	return ret_freq;
+	return 0;
 }
 EXPORT_SYMBOL(cpufreq_quick_get_max);
 
@@ -1842,15 +1839,13 @@
  */
 __weak unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	unsigned int ret_freq = 0;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
 
-	if (policy) {
-		ret_freq = policy->cpuinfo.max_freq;
-		cpufreq_cpu_put(policy);
-	}
+	policy = cpufreq_cpu_get(cpu);
+	if (policy)
+		return policy->cpuinfo.max_freq;
 
-	return ret_freq;
+	return 0;
 }
 EXPORT_SYMBOL(cpufreq_get_hw_max_freq);
 
@@ -1870,20 +1865,18 @@
  */
 unsigned int cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	unsigned int ret_freq = 0;
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
 
+	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return 0;
 
-	scoped_guard(cpufreq_policy_read, policy) {
-		if (cpufreq_driver->get)
-			ret_freq = __cpufreq_get(policy);
-	}
+	guard(cpufreq_policy_read)(policy);
 
-	cpufreq_cpu_put(policy);
+	if (cpufreq_driver->get)
+		return __cpufreq_get(policy);
 
-	return ret_freq;
+	return 0;
 }
 EXPORT_SYMBOL(cpufreq_get);
 
@@ -2538,7 +2531,8 @@
  */
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 {
-	struct cpufreq_policy *cpu_policy;
+	struct cpufreq_policy *cpu_policy __free(put_cpufreq_policy);
+
 	if (!policy)
 		return -EINVAL;
 
@@ -2548,7 +2542,6 @@
 
 	memcpy(policy, cpu_policy, sizeof(*policy));
 
-	cpufreq_cpu_put(cpu_policy);
 	return 0;
 }
 EXPORT_SYMBOL(cpufreq_get_policy);




