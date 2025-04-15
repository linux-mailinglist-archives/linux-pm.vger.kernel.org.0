Return-Path: <linux-pm+bounces-25457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED68A899A3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF130177688
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8E28DEF1;
	Tue, 15 Apr 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="K+KrZHow"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80128B4F0;
	Tue, 15 Apr 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712261; cv=none; b=dn+S0hYFt64JsO7LRAb7UKe3VDxRctjpLPWRhdy/hy0UgktjMiRBvXxmRrc4p0xNqv1xrT79pBsbypDL4Sl0MXDVJVWlkw4/YwblOh82wOhsrcL5xKb1+FtVBXHYQxio7YKaa3xyuwDtj7u6KoY3ueAI+Fo5fysyJ4a1S8PFUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712261; c=relaxed/simple;
	bh=68OXra1Dp9DBMRyBvdCpFfLAw1vqwtRy9di/sd4TVG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVUucCmrvulqWwfccvBTpJfpMQs/ktN4DummCUzXJjzW58pBYCAYYQGGoCh/sZaZgM0wdgEHHWJZhsCqFsBuNfS6KYSFUQmN0fPWH9uwD54ySXRXvs0+DMlSonnuFXG+82+fGYRTqnn8xbCSxBPksnrktbc+o+iRS1o61Tr6eAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=K+KrZHow; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 95FC0662669;
	Tue, 15 Apr 2025 12:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744712255;
	bh=68OXra1Dp9DBMRyBvdCpFfLAw1vqwtRy9di/sd4TVG0=;
	h=From:Subject:Date;
	b=K+KrZHowyeP1rTpFLhZOnQ3hoXooHVexHpcYnC4bhcFhx/mui/HRTU1x49Nym1hUC
	 /lsscjxmUUmRdZ6dVyrCRx3kI7BPizTL2UCZ05h4R62YFwHFTit49lirbitxcZLVgj
	 9x9h1ak7WU02OhPklyObSTorykrQSDEsF7fnDUiD1AUdTm8DS+1FuS1UU4HHI7ijGe
	 WQQrCFcfJ0Lw/Ppm0UunSzKC6B5gmBdWbY7TGIS7yIWtr+S5tTqMgu0aIei7bKtfq7
	 snNRiXkh24JcLUjB8K37fSmoc4UFBPch+8PZaOc0NAzlPJaZPjPiPk5JhLKb4Zfttj
	 8q1+3XWa95lIQ==
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
 [PATCH v2 4/6] cpufreq: Rename __resolve_freq() to clamp_and_resolve_freq()
Date: Tue, 15 Apr 2025 12:02:04 +0200
Message-ID: <2024183.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <6171293.lOV4Wx5bFT@rjwysocki.net>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for subsequent changes rename a function in the cpufreq
core as per the subject and while at it, clean up some white space
around the declaration for that function.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

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




