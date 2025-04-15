Return-Path: <linux-pm+bounces-25459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A16AA899AC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6C03BB009
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D528E610;
	Tue, 15 Apr 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qin2wJru"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219F28DF14;
	Tue, 15 Apr 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712264; cv=none; b=l8BVNOMwb7mSCmKqbPuAmnOpq1ST85blUKbZ3Kp6UtXqbE8VVYAeRaOKgsFiD6AytBVhw2V4QG7Xr43RAHTTm+eww0zBqAy8w1qFvkNNnlJvki9AjY/lJc5zm/9YwBgRBQIQzfY4TKUpMkRL4YIgfjjqHZvwZ3gne7TfAyassY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712264; c=relaxed/simple;
	bh=OblOeeP2J+XD6Bwadli1Fx0x3GrdHKJhYb8cr0j/ohQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlwplJaJGdk6Ng17uQBc8o0jyAThVOMXr4hnUBhmPNQSQeI1kGmHojUP9YQFASf0ARagoweswFM+/mdjsiRqN2hAijq2YPA1FB1Cr/IFaqN+4Yfzb4Daalm5t/1qhjlpRAyiWg2YZLQh6KrWcV5mgzG39BwZ/3++0sa7T/ku2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qin2wJru; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CB42F66266B;
	Tue, 15 Apr 2025 12:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1744712257;
	bh=OblOeeP2J+XD6Bwadli1Fx0x3GrdHKJhYb8cr0j/ohQ=;
	h=From:Subject:Date;
	b=qin2wJruoS/mHMufsjJpphRcplxPhpwQXF3pdy0RyWY3mu8pH5TR6Ycrse1ojDGV3
	 DDxWGyUYBmghrBM409WU8V3y0s9QQgO8yD7pcVHE5HCjZMuQFdsEYUypBPPDyOAOl0
	 gATDyruW8Q1HCyixoDIBHHW2powp4HNW9U3TbqYezXHI0L9AlgWjW7ck/Vc1GI7lId
	 gHvUChHYvJPpALNsGvyI1KeEbY5PTjaOjlWzFE6AhK33vDBgRialtKoxZsbYIisY6h
	 6VTSWJ7g9V6l6nmcsBkrTZeYY++t8xKhuX+KRz3RnLUoIj/3HJWzFkIxb3qQA0LUql
	 8uU/iTUHIpG9A==
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
 [PATCH v2 2/6] cpufreq/sched: Explicitly synchronize limits_changed flag
 handling
Date: Tue, 15 Apr 2025 11:59:15 +0200
Message-ID: <3376719.44csPzL39Z@rjwysocki.net>
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

The handling of the limits_changed flag in struct sugov_policy needs to
be explicitly synchronized to ensure that cpufreq policy limits updates
will not be missed in some cases.

Without that synchronization it is theoretically possible that
the limits_changed update in sugov_should_update_freq() will be
reordered with respect to the reads of the policy limits in
cpufreq_driver_resolve_freq() and in that case, if the limits_changed
update in sugov_limits() clobbers the one in sugov_should_update_freq(),
the new policy limits may not take effect for a long time.

Likewise, the limits_changed update in sugov_limits() may theoretically
get reordered with respect to the updates of the policy limits in
cpufreq_set_policy() and if sugov_should_update_freq() runs between
them, the policy limits change may be missed.

To ensure that the above situations will not take place, add memory
barriers preventing the reordering in question from taking place and
add READ_ONCE() and WRITE_ONCE() annotations around all of the
limits_changed flag updates to prevent the compiler from messing up
with that code.

Fixes: 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change")
Cc: 5.3+ <stable@vger.nernel.org> # 5.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase on top of the new [1/6].

---
 kernel/sched/cpufreq_schedutil.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -81,9 +81,20 @@
 	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
+	if (unlikely(READ_ONCE(sg_policy->limits_changed))) {
+		WRITE_ONCE(sg_policy->limits_changed, false);
 		sg_policy->need_freq_update = true;
+
+		/*
+		 * The above limits_changed update must occur before the reads
+		 * of policy limits in cpufreq_driver_resolve_freq() or a policy
+		 * limits update might be missed, so use a memory barrier to
+		 * ensure it.
+		 *
+		 * This pairs with the write memory barrier in sugov_limits().
+		 */
+		smp_mb();
+
 		return true;
 	}
 
@@ -377,7 +388,7 @@
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
-		sg_cpu->sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_cpu->sg_policy->limits_changed, true);
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
@@ -883,7 +894,16 @@
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->limits_changed = true;
+	/*
+	 * The limits_changed update below must take place before the updates
+	 * of policy limits in cpufreq_set_policy() or a policy limits update
+	 * might be missed, so use a memory barrier to ensure it.
+	 *
+	 * This pairs with the memory barrier in sugov_should_update_freq().
+	 */
+	smp_wmb();
+
+	WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 struct cpufreq_governor schedutil_gov = {




