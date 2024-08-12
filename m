Return-Path: <linux-pm+bounces-12082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000EA94EE8C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576F2282F0B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDE17D373;
	Mon, 12 Aug 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qMKPyIIO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832B17C7D8;
	Mon, 12 Aug 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470287; cv=none; b=qyBiPJbiw1i+5sUVh5hWpzuL0K87b+dH//26K+jRvrQByQiOe41AsNAYJZ0N/4Hf9AjKMvSTj6SyNleYBUnFqEn5b0Jql+ZXDWWCAOhQUUhgppfbCvax4XdDDGJ4QpRcUEJdNHzE6smahrH1jz6tBZvbTytMsfi8+eyTvN5ITo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470287; c=relaxed/simple;
	bh=kpd3wxrRKwx58XwylsuukHoarjHENJgXKGxxPxoZ588=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuS3lzZrCc0/cUPSd0jio/8LvXEynJSk2gRMd4fjZOr96hUV1/ExyAbxqi0DRHKQWM07Pb/3kupyWND937qufEjvWUE7hp5Motppjza5YiOK3Gh6D2ILgY+wD0FmFgvDgEpc2XtSHZvyVAizh+94tOTvF+LpZaU68pwTV9tH3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qMKPyIIO; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 520eac09825f50c6; Mon, 12 Aug 2024 14:44:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3076B6F0D80;
	Mon, 12 Aug 2024 14:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723466683;
	bh=kpd3wxrRKwx58XwylsuukHoarjHENJgXKGxxPxoZ588=;
	h=From:Subject:Date;
	b=qMKPyIIOV4Qb9GGYxuNoTw7wz0oJ/oeHgw5rCXNUuGvu0WLPwpC8suM2BuRVIkMJ7
	 hQYSXJmvfYsFlD0hAmHi1tRi+CyLmFOWWPfu+DeeQXwzb7g7zzmps5fY/garJ6HJr4
	 JdiFmPS42EjYNmDfVjq3z9/fpL+GRuYUm5eO80grCEP7bXR8FtwqR6EPkK5XENc4bD
	 sLjuJrnWz2qveaxYvey/X2eEl1nzL0YtoJgFmp9CXd0y6/pgu04tDNyMlwNIOCgqFx
	 Qx/DUsHztfs1qmYJzndzwmcfjPOx7ynBkhzcmVCQG7+Hbt9ZJXsvJq+Xgm8woteLg8
	 UeDT8k4+x9cIA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v2 1/3] x86/sched: Introduce arch_rebuild_sched_domains()
Date: Mon, 12 Aug 2024 14:37:02 +0200
Message-ID: <2335352.ElGaqSPkdT@rjwysocki.net>
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

Add arch_rebuild_sched_domains() for rebuilding scheduling domains and
updating topology on x86 and make the ITMT code use it.

First of all, this reduces code duplication somewhat and eliminates
a need to use an extern variable, but it will also lay the ground for
future work related to CPU capacity scaling.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

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




