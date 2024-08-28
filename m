Return-Path: <linux-pm+bounces-13028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2925962660
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7121B1F23C77
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F4171E5F;
	Wed, 28 Aug 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fe667xe8"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAD16CD2D;
	Wed, 28 Aug 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845960; cv=none; b=aa+2Lm+9P3oL7sHgdBUVNSqLseGZxhZTZ1lzPMji+kTYQvdOv9MlRx2tz+Gsx8etsOiIYr2qVn9P2UboMuRn3RdTazJveSedliTZROuquIMUKnuwBnGi4RpmXU8VZ5GVngDv+MMJZg8bFi8YL9FZxSNYcHUrpdgM5ZPOlL5sccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845960; c=relaxed/simple;
	bh=iSUS5HIvEhKi9Ecnk37neCq8fdzuNlVbNBofKG2Qycg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsTO6mRpcvi/eVU221Wshkk6Utd8lpifWU1zGqDFK9CTlVjHiwF/nF39VWDUlQMy6ARW1oGgXYwpgmN3mrn3HpqdwwUlmVb/20/oisBS3y3CC5mrSMmCfkgNhnC7zjP2vpce79Ro+mg8aD2Ie9/Wbs9FbDCGaWbp7G3Pb/oVGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fe667xe8; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 806c4d6aa3f694e3; Wed, 28 Aug 2024 13:52:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A7F5B923483;
	Wed, 28 Aug 2024 13:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724845950;
	bh=iSUS5HIvEhKi9Ecnk37neCq8fdzuNlVbNBofKG2Qycg=;
	h=From:Subject:Date;
	b=fe667xe8IovRNBV6O4KTfXlyZ0ZQ1jXYFvjkm55OyHpSWJ5XRl52S5Zs+IHUa6aDq
	 S9Q5LtbOotj4VWhL14O1KdIVvv0lIC1eTuBMofdROd3tNs1JZaIo72JfCrM6iRwg+f
	 QXvHktwqGscI3BSnFrk4eumbvEc9kQqQniBaL7ik8WV9iKxqnWaH5Xhr5GwIcdbJ4Q
	 TdnkUGRubmIbwO1SlO6HsI9XsMm5SOBwjj3gtUWI1ziBU3MtjIqdYDLXk9tGedZDu+
	 Z1Q7ioZ1aurDDIhoc5J+8te+tGCIjMEtrACJky8zfyNNxnv3GtvDw1hM1qU9Hpzyww
	 TfNuqaIPjV3MA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v3 1/2] x86/sched: Add basic support for CPU capacity scaling
Date: Wed, 28 Aug 2024 13:47:25 +0200
Message-ID: <10523497.nUPlyArG6x@rjwysocki.net>
In-Reply-To: <3310447.aeNJFYEL58@rjwysocki.net>
References: <3310447.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohep
 phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order be able to compute the sizes of tasks consistently across all
CPUs in a hybrid system, it is necessary to provide CPU capacity scaling
information to the scheduler via arch_scale_cpu_capacity().  Moreover,
the value returned by arch_scale_freq_capacity() for the given CPU must
correspond to the arch_scale_cpu_capacity() return value for it, or
utilization computations will be inaccurate.

Add support for it through per-CPU variables holding the capacity and
maximum-to-base frequency ratio (times SCHED_CAPACITY_SCALE) that will
be returned by arch_scale_cpu_capacity() and used by scale_freq_tick()
to compute arch_freq_scale for the current CPU, respectively.

In order to avoid adding measurable overhead for non-hybrid x86 systems,
which are the vast majority in the field, whether or not the new hybrid
CPU capacity scaling will be in effect is controlled by a static key.
This static key is set by calling arch_enable_hybrid_capacity_scale()
which also allocates memory for the per-CPU data and initializes it.
Next, arch_set_cpu_capacity() is used to set the per-CPU variables
mentioned above for each CPU and arch_rebuild_sched_domains() needs
to be called for the scheduler to realize that capacity-aware
scheduling can be used going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Rebase after dropping patch [1/3].
   * Rename arch_set_cpu_capacity() arguments.
   * Add empty line to arch_enable_hybrid_capacity_scale().
   * Declare local variables in scale_freq_tick() on one line.

v1 -> v2:
   * Replaces WARN_ON_ONCE() with WARN_ONCE() (2 places)
   * Fix arch_enable_hybrid_capacity_scale() return value when hybrid
     capacity scaling is already enabled.
   * Allow arch_enable_hybrid_capacity_scale() to succeed when
     frequency-invariance is not enabled.
   * Fix arch_set_cpu_capacity() kerneldoc comment
   * Do not disable capacity scaling in disable_freq_invariance_workfn().
   * Relocate arch_hybrid_cap_scale_key definition.

---
 arch/x86/include/asm/topology.h  |   13 +++++
 arch/x86/kernel/cpu/aperfmperf.c |   89 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 2 deletions(-)

Index: linux-pm/arch/x86/include/asm/topology.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/topology.h
+++ linux-pm/arch/x86/include/asm/topology.h
@@ -282,9 +282,22 @@ static inline long arch_scale_freq_capac
 }
 #define arch_scale_freq_capacity arch_scale_freq_capacity
 
+bool arch_enable_hybrid_capacity_scale(void);
+void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long max_cap,
+			   unsigned long cap_freq, unsigned long base_freq);
+
+unsigned long arch_scale_cpu_capacity(int cpu);
+#define arch_scale_cpu_capacity arch_scale_cpu_capacity
+
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
 #else
+static inline bool arch_enable_hybrid_capacity_scale(void) { return false; }
+static inline void arch_set_cpu_capacity(int cpu, unsigned long cap,
+					 unsigned long max_cap,
+					 unsigned long cap_freq,
+					 unsigned long base_freq) { }
+
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
 #endif
Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/aperfmperf.c
+++ linux-pm/arch/x86/kernel/cpu/aperfmperf.c
@@ -349,9 +349,89 @@ static DECLARE_WORK(disable_freq_invaria
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);
 
+static DEFINE_STATIC_KEY_FALSE(arch_hybrid_cap_scale_key);
+
+struct arch_hybrid_cpu_scale {
+	unsigned long capacity;
+	unsigned long freq_ratio;
+};
+
+static struct arch_hybrid_cpu_scale __percpu *arch_cpu_scale;
+
+/**
+ * arch_enable_hybrid_capacity_scale - Enable hybrid CPU capacity scaling
+ *
+ * Allocate memory for per-CPU data used by hybrid CPU capacity scaling,
+ * initialize it and set the static key controlling its code paths.
+ *
+ * Must be called before arch_set_cpu_capacity().
+ */
+bool arch_enable_hybrid_capacity_scale(void)
+{
+	int cpu;
+
+	if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
+		WARN_ONCE(1, "Hybrid CPU capacity scaling already enabled");
+		return true;
+	}
+
+	arch_cpu_scale = alloc_percpu(struct arch_hybrid_cpu_scale);
+	if (!arch_cpu_scale)
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(arch_cpu_scale, cpu)->capacity = SCHED_CAPACITY_SCALE;
+		per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio = arch_max_freq_ratio;
+	}
+
+	static_branch_enable(&arch_hybrid_cap_scale_key);
+
+	pr_info("Hybrid CPU capacity scaling enabled\n");
+
+	return true;
+}
+
+/**
+ * arch_set_cpu_capacity - Set scale-invariance parameters for a CPU
+ * @cpu: Target CPU.
+ * @cap: Capacity of @cpu at its maximum frequency, relative to @max_cap.
+ * @max_cap: System-wide maximum CPU capacity.
+ * @cap_freq: Frequency of @cpu corresponding to @cap.
+ * @base_freq: Frequency of @cpu at which MPERF counts.
+ *
+ * The units in which @cap and @max_cap are expressed do not matter, so long
+ * as they are consistent, because the former is effectively divided by the
+ * latter.  Analogously for @cap_freq and @base_freq.
+ *
+ * After calling this function for all CPUs, call arch_rebuild_sched_domains()
+ * to let the scheduler know that capacity-aware scheduling can be used going
+ * forward.
+ */
+void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long max_cap,
+			   unsigned long cap_freq, unsigned long base_freq)
+{
+	if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
+		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
+			   div_u64(cap << SCHED_CAPACITY_SHIFT, max_cap));
+		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
+			   div_u64(cap_freq << SCHED_CAPACITY_SHIFT, base_freq));
+	} else {
+		WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
+	}
+}
+
+unsigned long arch_scale_cpu_capacity(int cpu)
+{
+	if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
+		return READ_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity);
+
+	return SCHED_CAPACITY_SCALE;
+}
+EXPORT_SYMBOL_GPL(arch_scale_cpu_capacity);
+
 static void scale_freq_tick(u64 acnt, u64 mcnt)
 {
-	u64 freq_scale;
+	u64 freq_scale, freq_ratio;
 
 	if (!arch_scale_freq_invariant())
 		return;
@@ -359,7 +439,12 @@ static void scale_freq_tick(u64 acnt, u6
 	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
 		goto error;
 
-	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
+	if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
+		freq_ratio = READ_ONCE(this_cpu_ptr(arch_cpu_scale)->freq_ratio);
+	else
+		freq_ratio = arch_max_freq_ratio;
+
+	if (check_mul_overflow(mcnt, freq_ratio, &mcnt) || !mcnt)
 		goto error;
 
 	freq_scale = div64_u64(acnt, mcnt);




