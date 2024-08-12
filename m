Return-Path: <linux-pm+bounces-12080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4894EE89
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938481C21AE2
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3417C9FA;
	Mon, 12 Aug 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PQ6R2FIh"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB517C7B9;
	Mon, 12 Aug 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470285; cv=none; b=nyfTzmFLtZzJk3RqhtdeqNngWFQVcarphjFGBWZU6G4mew8c2qzfVEn7RZCzh3Fxt3D2h6kB8hHiBr5ba+DtEDFxEC+ARHft4e+up5zBBbRT92Ih5elxdnpvFlEn+YmabjsFw1YsRRQFQYvEzbIJbgW8Y34ZorjpIiEvesD+SK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470285; c=relaxed/simple;
	bh=iIufjcgGtpUjJVRP7Ol9ZIuMvVSgYnQutX7gorMPP7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD2bL9xvn+qVNs8a6SC3N6qwe5P/0Lkm3m5+JbuLQlpa52d99hgGwvupiDKmXwIEMpUnw1eLgpjTrkmBBlbVykJ5RYzOKFe7+sgCdBJHGd8gdEQ1jHuAhUyXrsgrVBQvOOqRO6h9VBWA86kzGaJHMqi7sJz8bXJqPIxeymt5qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PQ6R2FIh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5a12cf236ae3d380; Mon, 12 Aug 2024 14:44:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 47A386F0D80;
	Mon, 12 Aug 2024 14:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723466682;
	bh=iIufjcgGtpUjJVRP7Ol9ZIuMvVSgYnQutX7gorMPP7k=;
	h=From:Subject:Date;
	b=PQ6R2FIhkIP4vEfEfJMHDJsOaXRmbv5A+nsMbOAMgIS8g4j7hFczZSRpAQPdGXSca
	 XiwkPz2+M1pYNrfbL6b7mkJl+JkifahSYfvIu1KlIPHDppzMzbCtAc/rTIjAjwmjya
	 49HluW3o3Muq7Jw4RbCuPBpd9VVivMm/CYjmVIlmUlSN1Ch4YNKPdnTWu+WDBXA/Oq
	 ozZBFcsA+YMUOdTjg8buhziGbQ4ue+vHwacK3pUdlM2/jO348vML5aAfM0Lq27V5yi
	 jKCaMfB77xeDq/9TA33ngUYnMWLNgb12dsIkJmEiFqItw9VTgf2tFrAPoZRf0oCXdN
	 JUodnnvV60tbA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v2 2/3] x86/sched: Add basic support for CPU capacity scaling
Date: Mon, 12 Aug 2024 14:42:26 +0200
Message-ID: <13573795.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <4941491.31r3eYUQgx@rjwysocki.net>
References: <4941491.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
 rggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhm
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

v1 -> v2:
   * Allow arch_enable_hybrid_capacity_scale() to succeed when frequency-
     invariance is not enabled and do not disable capacity scaling in
     disable_freq_invariance_workfn() (it is not really necessary to do
     so and the code is simpler without doing that).  Having done that,
     move arch_hybrid_cap_scale_key definition closer to the code using it.
   * Replace WARN_ON_ONCE() with WARN_ONCE() (2 places).
   * Fix arch_enable_hybrid_capacity_scale() return value when hybrid
     capacity scaling is already enabled.
   * Fix arch_set_cpu_capacity() kerneldoc comment.

---
 arch/x86/include/asm/topology.h  |   13 +++++
 arch/x86/kernel/cpu/aperfmperf.c |   87 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)

Index: linux-pm/arch/x86/include/asm/topology.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/topology.h
+++ linux-pm/arch/x86/include/asm/topology.h
@@ -280,11 +280,24 @@ static inline long arch_scale_freq_capac
 }
 #define arch_scale_freq_capacity arch_scale_freq_capacity
 
+bool arch_enable_hybrid_capacity_scale(void);
+void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long base_cap,
+			   unsigned long max_freq, unsigned long base_freq);
+
+unsigned long arch_scale_cpu_capacity(int cpu);
+#define arch_scale_cpu_capacity arch_scale_cpu_capacity
+
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
 
 void arch_rebuild_sched_domains(void);
 #else
+static inline bool arch_enable_hybrid_capacity_scale(void) { return false; }
+static inline void arch_set_cpu_capacity(int cpu, unsigned long cap,
+					 unsigned long base_cap,
+					 unsigned long max_freq,
+					 unsigned long base_freq) { }
+
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
 
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
+ * @cap: Capacity of @cpu, relative to @base_cap, at its maximum frequency.
+ * @base_cap: System-wide maximum CPU capacity.
+ * @max_freq: Frequency of @cpu corresponding to @cap.
+ * @base_freq: Frequency of @cpu at which MPERF counts.
+ *
+ * The units in which @cap and @base_cap are expressed do not matter, so long
+ * as they are consistent, because the former is effectively divided by the
+ * latter.  Analogously for @max_freq and @base_freq.
+ *
+ * After calling this function for all CPUs, call arch_rebuild_sched_domains()
+ * to let the scheduler know that capacity-aware scheduling can be used going
+ * forward.
+ */
+void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long base_cap,
+			   unsigned long max_freq, unsigned long base_freq)
+{
+	if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
+		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
+			   div_u64(cap << SCHED_CAPACITY_SHIFT, base_cap));
+		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
+			   div_u64(max_freq << SCHED_CAPACITY_SHIFT, base_freq));
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
 	u64 freq_scale;
+	u64 freq_ratio;
 
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




