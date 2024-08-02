Return-Path: <linux-pm+bounces-11847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5D946309
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239DC283871
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B3175D53;
	Fri,  2 Aug 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="f/V6Vghw"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBC15C15D;
	Fri,  2 Aug 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622926; cv=none; b=O25HowTx88aJOZa2KHPEmQdQSBj1JWrM0OnaamvSkILv2xttD0B2iAuAhAgcyEhGMiL9pf7+RgD68OFtiQU3ysZSz72snijwakb36oAWNcaFSV8VXgub7Is/FMDw2g2wRY9lbPAgVElEeGlIqR3fBLjdx5zog7bFwofiNCi8riA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622926; c=relaxed/simple;
	bh=H36+ANriL1BHT8EJ8fXzIZhPt9HqxP4EVTcec1v8TJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfeAAVQ0XJCivAouj4DBe1MBMVJuL11SL+a3LoqYD3NYyI7ZAKsyqV0BL6y5rinlD3AupbnlC8xtqz4hlC7G0aYyRLFfX0SSEH9l6U3D4qBM0kgivw0QZbnkya4e9EAWZZqUxGxj1MRY0FNC08DPzlaLHh5ZZqJ4HNMu4Rlksio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=f/V6Vghw; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e4062f9b974f24c0; Fri, 2 Aug 2024 20:22:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C7E0573B540;
	Fri,  2 Aug 2024 20:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722622922;
	bh=H36+ANriL1BHT8EJ8fXzIZhPt9HqxP4EVTcec1v8TJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/V6VghwphxhKHr0UGnkvLvShK9vZiAsdZzfqH2ErhkDX1fs02sGnFviWpQCXShPG
	 lTE5R+oC7INTax+Gti4gTEkR33xfq1NNRryI1hQKdONyzaR3f3ZBV411vimxzScSdd
	 6n89PFxfSLQGhQ9xooI06OGexCzNkAdjuPoUQB1j84tJzmnaS1KmYPRI9Kw+AM4/qH
	 T2AjtBl1YWi6HDY6rm9QlwXTgl+MoprgM4BqDOMpSuwANyjkKSJjqka5XBfI55FFoY
	 lLY0zlTMSGm/OvUYus+5RHMD0DIhu+Ze8WLnnBZc2taCC7DZ31UodheOG0Chcf6jk2
	 NkG54X9VYFJ7Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v1 1/3] x86/sched: Introduce arch_rebuild_sched_domains()
Date: Fri, 02 Aug 2024 20:16:37 +0200
Message-ID: <2189204.irdbgypaU6@rjwysocki.net>
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

Add arch_rebuild_sched_domains() for rebuilding scheduling domains and
updating topology on x86 and make the ITMT code use it.

First of all, this reduces code duplication somewhat and eliminates
a need to use an extern variable, but it will also lay the ground for
subsequent work related to CPU capacity scaling.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/include/asm/topology.h |    6 ++++--
 arch/x86/kernel/itmt.c          |   12 ++++--------
 arch/x86/kernel/smpboot.c       |   10 +++++++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

Index: linux-pm/arch/x86/include/asm/topology.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/topology.h
+++ linux-pm/arch/x86/include/asm/topology.h
@@ -235,8 +235,6 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
-extern bool x86_topology_update;
-
 #ifdef CONFIG_SCHED_MC_PRIO
 #include <asm/percpu.h>
 
@@ -284,9 +282,13 @@ static inline long arch_scale_freq_capac
 
 extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
+
+void arch_rebuild_sched_domains(void);
 #else
 static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
 static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
+
+static inline void arch_rebuild_sched_domains(void) { }
 #endif
 
 extern void arch_scale_freq_tick(void);
Index: linux-pm/arch/x86/kernel/itmt.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/itmt.c
+++ linux-pm/arch/x86/kernel/itmt.c
@@ -54,10 +54,8 @@ static int sched_itmt_update_handler(str
 	old_sysctl = sysctl_sched_itmt_enabled;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
-	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
-		x86_topology_update = true;
-		rebuild_sched_domains();
-	}
+	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled)
+		arch_rebuild_sched_domains();
 
 	mutex_unlock(&itmt_update_mutex);
 
@@ -114,8 +112,7 @@ int sched_set_itmt_support(void)
 
 	sysctl_sched_itmt_enabled = 1;
 
-	x86_topology_update = true;
-	rebuild_sched_domains();
+	arch_rebuild_sched_domains();
 
 	mutex_unlock(&itmt_update_mutex);
 
@@ -150,8 +147,7 @@ void sched_clear_itmt_support(void)
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */
 		sysctl_sched_itmt_enabled = 0;
-		x86_topology_update = true;
-		rebuild_sched_domains();
+		arch_rebuild_sched_domains();
 	}
 
 	mutex_unlock(&itmt_update_mutex);
Index: linux-pm/arch/x86/kernel/smpboot.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/smpboot.c
+++ linux-pm/arch/x86/kernel/smpboot.c
@@ -39,6 +39,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/export.h>
@@ -125,7 +126,7 @@ static DEFINE_PER_CPU_ALIGNED(struct mwa
 int __read_mostly __max_smt_threads = 1;
 
 /* Flag to indicate if a complete sched domain rebuild is required */
-bool x86_topology_update;
+static bool x86_topology_update;
 
 int arch_update_cpu_topology(void)
 {
@@ -135,6 +136,13 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
+#ifdef CONFIG_X86_64
+void arch_rebuild_sched_domains(void) {
+	x86_topology_update = true;
+	rebuild_sched_domains();
+}
+#endif
+
 static unsigned int smpboot_warm_reset_vector_count;
 
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)




