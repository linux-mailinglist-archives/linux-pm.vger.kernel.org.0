Return-Path: <linux-pm+bounces-42788-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB50JaS8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42788-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226414F7C8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF64130151D6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AB374733;
	Tue, 17 Feb 2026 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fma+ALVE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD3285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355299; cv=none; b=SoPPwmLer4Aj4QcyIBPiwH9pQh7NilCdKAnlrKLFTbvt28AvHklzqmL+X8cBVxGoXBxVLAxQBDf+FQ+xxG7tKDOJIV3Vofvm044ANjWyyZXc8yHPxoKv63ilQg+ZOJu8jmNTQvPULgylMrJS0xbwvKo3ACrApY7b3LJokm3+5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355299; c=relaxed/simple;
	bh=ppI+tyAeHLYNQP6u3j9RDBiIWN/cg/jk9y0azX/BtEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7O1JlvWWSoAFCrZzO3nMZG2liU5wHs9UyPOCZuI2BcLRuvMOuzay04co5V2oa682uM7u+isoDf3IH+4yHQ0ciRB7joeBK8SdUIBQC7gDh/O4qez0Gvlm0WAsIZmrJ7hr6mzhkwbwSWodtaLQUnx5wfql79IZ74QR4O/8UCdw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fma+ALVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629E6C4CEF7;
	Tue, 17 Feb 2026 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355299;
	bh=ppI+tyAeHLYNQP6u3j9RDBiIWN/cg/jk9y0azX/BtEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=fma+ALVETUvkDJmvJiWCeDdDrjH9g735aVFapVTF11hJhPKNrZV+4E4lRMbvMpgN/
	 jMZgsL56DWQyny3iht43UsmAS2xp6RAMxxsx9HrgyARtTYVyyQpnGnqVfnBabH+QyN
	 +UG/eSjUeQ2R2c68If+jf8v2UpYrP9PqqVa9ADfGX1TiYJ8N5uu0FVxDMmLSVfh8D+
	 FJfJsdsBXBLaVfVB6tnRlcewquICBDt/5ec6/5NptZ4OVEIERownsF1YaRWeAWzmh8
	 Zw0B4XG+NSEL0BCgA9V4+J1/bmDq1ReOopzU+8Op5TI11pGx3OL0uFm/cB5Tyn2GWm
	 dHAhs6MMa7L2Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/23] tools/power turbostat: Favor cpu# over core#
Date: Tue, 17 Feb 2026 13:04:11 -0600
Message-ID: <a2b4d0f8bf07a4a4fe8a526e10c45e593c7a3bf0.1771354333.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42788-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 8226414F7C8
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Turbostat collects statistics and outputs results in "topology order",
which means it prioritizes the core# over the cpu#.
The strategy is to minimize wakesups to a core -- which is
important when measuring an idle system.

But core order is problematic, because Linux core#'s are physical
(within each package), and thus subject to APIC-id scrambling
that may be done by the hardware or the BIOS.

As a result users may be are faced with rows in a confusing order:

sudo turbostat -q --show topology,Busy%,CPU%c6,UncMHz sleep 1
Core	CPU	Busy%	CPU%c6	UncMHz
-	-	1.25	72.18	3400
0	4	7.74	0.00
1	5	1.77	88.59
2	6	0.48	96.73
3	7	0.21	98.34
4	8	0.14	96.85
5	9	0.26	97.55
6	10	0.44	97.24
7	11	0.12	96.18
8	0	5.41	0.31	3400
8	1	0.19
12	2	0.41	0.22
12	3	0.08
32	12	0.04	99.21
33	13	0.25	94.92

Abandon the legacy "core# topology order" in favor of simply
ordering by cpu#, with a special case to handle HT siblings
that may not have adjacent cpu#'s.

sudo ./turbostat -q --show topology,Busy%,CPU%c6,UncMHz sleep 1
1.003001 sec
Core	CPU	Busy%	CPU%c6	UncMHz
-	-	1.38	80.55	1600
8	0	10.94	0.00	1600
8	1	0.53
12	2	2.90	0.45
12	3	0.11
0	4	1.96	91.20
1	5	0.97	96.40
2	6	0.24	94.72
3	7	0.31	98.01
4	8	0.20	98.20
5	9	0.62	96.00
6	10	0.06	98.15
7	11	0.12	99.31
32	12	0.04	99.07
33	13	0.27	95.09

The result is that cpu#'s now take precedence over core#'s.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 123 +++++++++++++++-----------
 1 file changed, 69 insertions(+), 54 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9fdb41410f15..5239fd971b66 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2187,20 +2187,6 @@ struct pkg_data {
 #define ODD_COUNTERS odd.threads, odd.cores, odd.packages
 #define EVEN_COUNTERS even.threads, even.cores, even.packages
 
-#define GET_THREAD(thread_base, thread_no, core_no, node_no, pkg_no)	      \
-	((thread_base) +						      \
-	 ((pkg_no) *							      \
-	  topo.nodes_per_pkg * topo.cores_per_node * topo.threads_per_core) + \
-	 ((node_no) * topo.cores_per_node * topo.threads_per_core) +	      \
-	 ((core_no) * topo.threads_per_core) +				      \
-	 (thread_no))
-
-#define GET_CORE(core_base, core_no, node_no, pkg_no)			\
-	((core_base) +							\
-	 ((pkg_no) *  topo.nodes_per_pkg * topo.cores_per_node) +	\
-	 ((node_no) * topo.cores_per_node) +				\
-	 (core_no))
-
 /*
  * The accumulated sum of MSR is defined as a monotonic
  * increasing MSR, it will be accumulated periodically,
@@ -2392,6 +2378,8 @@ struct platform_counters {
 	struct rapl_counter energy_psys;	/* MSR_PLATFORM_ENERGY_STATUS */
 } platform_counters_odd, platform_counters_even;
 
+#define	MAX_HT_ID	3	/* support SMT-4 */
+
 struct cpu_topology {
 	int cpu_id;
 	int core_id;		/* unique within a package */
@@ -2401,7 +2389,7 @@ struct cpu_topology {
 	int physical_node_id;
 	int logical_node_id;	/* 0-based count within the package */
 	int ht_id;		/* unique within a core */
-	int ht_sibling_cpu_id;
+	int ht_sibling_cpu_id[MAX_HT_ID + 1];
 	int type;
 	cpu_set_t *put_ids;	/* Processing Unit/Thread IDs */
 } *cpus;
@@ -2458,27 +2446,38 @@ int cpu_is_not_allowed(int cpu)
 int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pkg_data *),
 		 struct thread_data *thread_base, struct core_data *core_base, struct pkg_data *pkg_base)
 {
-	int retval, pkg_no, core_no, thread_no, node_no;
+	int cpu, retval;
 
 	retval = 0;
 
-	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (node_no = 0; node_no < topo.nodes_per_pkg; node_no++) {
-			for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
-				for (thread_no = 0; thread_no < topo.threads_per_core; ++thread_no) {
-					struct thread_data *t;
-					struct core_data *c;
+	for (cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
+		struct thread_data *t;
+		struct core_data *c;
+		struct pkg_data *p;
+
+		int pkg_id = cpus[cpu].package_id;
+
+		if (cpu_is_not_allowed(cpu))
+			continue;
+
+		if (cpus[cpu].ht_id > 0)	/* skip HT sibling */
+			continue;
 
-					t = GET_THREAD(thread_base, thread_no, core_no, node_no, pkg_no);
+		t = &thread_base[cpu];
+		c = &core_base[GLOBAL_CORE_ID(cpus[cpu].core_id, pkg_id)];
+		p = &pkg_base[pkg_id];
 
-					if (cpu_is_not_allowed(t->cpu_id))
-						continue;
+		retval |= func(t, c, p);
 
-					c = GET_CORE(core_base, core_no, node_no, pkg_no);
+		/* Handle HT sibling now */
+		int i;
 
-					retval |= func(t, c, &pkg_base[pkg_no]);
-				}
-			}
+		for (i = MAX_HT_ID; i > 0; --i) {	/* ht_id 0 is self */
+			if (cpus[cpu].ht_sibling_cpu_id[i] <= 0)
+				continue;
+			t = &thread_base[cpus[cpu].ht_sibling_cpu_id[i]];
+
+			retval |= func(t, c, p);
 		}
 	}
 	return retval;
@@ -6168,7 +6167,7 @@ static int parse_cpu_str(char *cpu_str, cpu_set_t *cpu_set, int cpu_set_size)
 	return 0;
 }
 
-int get_thread_siblings(struct cpu_topology *thiscpu)
+int set_thread_siblings(struct cpu_topology *thiscpu)
 {
 	char path[80], character;
 	FILE *filep;
@@ -6206,8 +6205,11 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 				if (sib_core == thiscpu->core_id) {
 					CPU_SET_S(so, size, thiscpu->put_ids);
 					if ((so != cpu) && (cpus[so].ht_id < 0)) {
-						cpus[so].ht_id = thread_id++;
-						cpus[cpu].ht_sibling_cpu_id = so;
+						cpus[so].ht_id = thread_id;
+						cpus[cpu].ht_sibling_cpu_id[thread_id] = so;
+						if (debug)
+							fprintf(stderr, "%s: cpu%d.ht_sibling_cpu_id[%d] = %d\n", __func__, cpu, thread_id, so);
+						thread_id += 1;
 					}
 				}
 			}
@@ -6229,30 +6231,40 @@ int for_all_cpus_2(int (func) (struct thread_data *, struct core_data *,
 		   struct core_data *core_base, struct pkg_data *pkg_base,
 		   struct thread_data *thread_base2, struct core_data *core_base2, struct pkg_data *pkg_base2)
 {
-	int retval, pkg_no, node_no, core_no, thread_no;
+	int cpu, retval;
 
 	retval = 0;
 
-	for (pkg_no = 0; pkg_no < topo.num_packages; ++pkg_no) {
-		for (node_no = 0; node_no < topo.nodes_per_pkg; ++node_no) {
-			for (core_no = 0; core_no < topo.cores_per_node; ++core_no) {
-				for (thread_no = 0; thread_no < topo.threads_per_core; ++thread_no) {
-					struct thread_data *t, *t2;
-					struct core_data *c, *c2;
+	for (cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
+		struct thread_data *t, *t2;
+		struct core_data *c, *c2;
+		struct pkg_data *p, *p2;
 
-					t = GET_THREAD(thread_base, thread_no, core_no, node_no, pkg_no);
+		if (cpu_is_not_allowed(cpu))
+			continue;
 
-					if (cpu_is_not_allowed(t->cpu_id))
-						continue;
+		if (cpus[cpu].ht_id > 0)	/* skip HT sibling */
+			continue;
 
-					t2 = GET_THREAD(thread_base2, thread_no, core_no, node_no, pkg_no);
+		t = &thread_base[cpu];
+		t2 = &thread_base2[cpu];
+		c = &core_base[GLOBAL_CORE_ID(cpus[cpu].core_id, cpus[cpu].package_id)];
+		c2 = &core_base2[GLOBAL_CORE_ID(cpus[cpu].core_id, cpus[cpu].package_id)];
+		p = &pkg_base[cpus[cpu].package_id];
+		p2 = &pkg_base2[cpus[cpu].package_id];
 
-					c = GET_CORE(core_base, core_no, node_no, pkg_no);
-					c2 = GET_CORE(core_base2, core_no, node_no, pkg_no);
+		retval |= func(t, c, p, t2, c2, p2);
 
-					retval |= func(t, c, &pkg_base[pkg_no], t2, c2, &pkg_base2[pkg_no]);
-				}
-			}
+		/* Handle HT sibling now */
+		int i;
+
+		for (i = MAX_HT_ID; i > 0; --i) {	/* ht_id 0 is self */
+			if (cpus[cpu].ht_sibling_cpu_id[i] <= 0)
+				continue;
+			t = &thread_base[cpus[cpu].ht_sibling_cpu_id[i]];
+			t2 = &thread_base2[cpus[cpu].ht_sibling_cpu_id[i]];
+
+			retval |= func(t, c, p, t2, c2, p2);
 		}
 	}
 	return retval;
@@ -6391,10 +6403,13 @@ int mark_cpu_present(int cpu)
 	return 0;
 }
 
-int init_ht_id(int cpu)
+int clear_ht_id(int cpu)
 {
+	int i;
+
 	cpus[cpu].ht_id = -1;
-	cpus[cpu].ht_sibling_cpu_id = -1;
+	for (i = 0; i <= MAX_HT_ID; ++i)
+		cpus[cpu].ht_sibling_cpu_id[i] = -1;
 	return 0;
 }
 
@@ -9579,7 +9594,7 @@ void topology_probe(bool startup)
 	cpu_affinity_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
 	CPU_ZERO_S(cpu_affinity_setsize, cpu_affinity_set);
 
-	for_all_proc_cpus(init_ht_id);
+	for_all_proc_cpus(clear_ht_id);
 
 	for_all_proc_cpus(set_cpu_hybrid_type);
 
@@ -9624,7 +9639,7 @@ void topology_probe(bool startup)
 			max_core_id = cpus[i].core_id;
 
 		/* get thread information */
-		siblings = get_thread_siblings(&cpus[i]);
+		siblings = set_thread_siblings(&cpus[i]);
 		if (siblings > max_siblings)
 			max_siblings = siblings;
 		if (cpus[i].ht_id == 0)
@@ -9748,8 +9763,8 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 	if (node_id < 0)
 		node_id = 0;
 
-	t = GET_THREAD(thread_base, cpus[cpu_id].ht_id, core_id, node_id, pkg_id);
-	c = GET_CORE(core_base, core_id, node_id, pkg_id);
+	t = &thread_base[cpu_id];
+	c = &core_base[GLOBAL_CORE_ID(core_id, pkg_id)];
 
 	t->cpu_id = cpu_id;
 	if (!cpu_is_not_allowed(cpu_id)) {
-- 
2.45.2


