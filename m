Return-Path: <linux-pm+bounces-11846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5C946307
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 20:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC5D1C21841
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DB175D32;
	Fri,  2 Aug 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="TkhnJTm9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25C15C156;
	Fri,  2 Aug 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622925; cv=none; b=T6XxmI6yZ/KeimLCOJaAIqAGI1/JJMeqg7ndOB67UHDTgIbpIkUshvb68TVykG6ggMXuhV4FZ2dFu5/i3JWIqxuICNK1IU4O3Lwg+w6qeY/i6a+xTFzpEZpSWzgbxtV0kXmcJ2wsddhYIJqavleB0Im4U/llo6gm6EcLbmQ/M4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622925; c=relaxed/simple;
	bh=aP6Gg9+Jnivonz04qjklwItWAXtgzvLiwyGo+Gmfa8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGP0ueuw4eofhBBNqI4NQnxsRrANf6zmvnBV+ir7IzPM67ts4Bp4HtgbrbjCy26xKwiKVv/lph8sFKNJBRiTqEW829PAITp90SRiSbnHNjK/tsxNthhWIyhQ6ly7YH+1D9UUFyaFxjeek6jrOukbk05Nqnc+1o32EpMaz+OpWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=TkhnJTm9; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 7aee8a2d45229686; Fri, 2 Aug 2024 20:22:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id ADB3C73B540;
	Fri,  2 Aug 2024 20:22:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722622921;
	bh=aP6Gg9+Jnivonz04qjklwItWAXtgzvLiwyGo+Gmfa8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkhnJTm91Td6Ql6vdDXTdg013EbjOqdyWi3R1dGHecqLAXKeoYe3Qu8c8cuyexIyE
	 XJDmAOci2HOQSTXQxXi8Q03Q64VxBnT83G3CEIslwu66wAM0uVdNtAH29v78SOyJ7R
	 Ror15Z8YKfzWA6FXpQrk58PDAiIve3a8qZ05tG93zIfQNMsvGWykiJyr6xF0qeT1bI
	 an6eixDyYXYMwO/nam3GuAYU9To+ojlllB235BCOUC5Gvls/U+YXswAoArdXnRQuh5
	 l6rr1oEQMXqe122iEygfZi7VL03kOGa2HxZy0bcptWV4OTcdewqVtQisJx6SpGwHaP
	 6wD/5VF9HY76Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v1 2/3] x86/sched: Add basic support for CPU capacity scaling
Date: Fri, 02 Aug 2024 20:18:57 +0200
Message-ID: <3300400.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <4908113.GXAFRqVoOG@rjwysocki.net>
References: <4908113.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhig
 sehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnhhnsegrrhhmrdgtohhm
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
 arch/x86/include/asm/topology.h  |   13 +++++
 arch/x86/kernel/cpu/aperfmperf.c |   91 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 1 deletion(-)

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
@@ -300,6 +300,8 @@ static void register_freq_invariance_sys
 static inline void register_freq_invariance_syscore_ops(void) {}
 #endif
 
+static DEFINE_STATIC_KEY_FALSE(arch_hybrid_cap_scale_key);
+
 static void freq_invariance_enable(void)
 {
 	if (static_branch_unlikely(&arch_scale_freq_key)) {
@@ -332,6 +334,7 @@ static void disable_freq_invariance_work
 	int cpu;
 
 	static_branch_disable(&arch_scale_freq_key);
+	static_branch_disable(&arch_hybrid_cap_scale_key);
 
 	/*
 	 * Set arch_freq_scale to a default value on all cpus
@@ -347,9 +350,90 @@ static DECLARE_WORK(disable_freq_invaria
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
 EXPORT_PER_CPU_SYMBOL_GPL(arch_freq_scale);
 
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
+	if (!arch_scale_freq_invariant())
+		return false;
+
+	if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
+		WARN_ON_ONCE(1);
+		return false;
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
+ * @base_freq: Frequency of @cpu at which APERF and MPERF count.
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
+		WARN_ON_ONCE(1);
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
@@ -357,7 +441,12 @@ static void scale_freq_tick(u64 acnt, u6
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




