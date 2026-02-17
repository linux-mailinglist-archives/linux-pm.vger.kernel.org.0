Return-Path: <linux-pm+bounces-42786-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKtRO6G8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42786-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1E14F7B4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BAC13012239
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CC37472C;
	Tue, 17 Feb 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COTO6ftq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE2285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355296; cv=none; b=hwLmVlgRdewcIqNE199TlurEoj6moVuzSlcahd0kUbtlQn93Kvf13+j6TnJWHmylH9pB5T5+z/dUrF0WgpyBWobITAkgsQvFT5J/IWwNh3wqEpoOxrLr+G2d9Enipx9eAPKDbOVBXDC/ZqcUDIBt/k3fMap5beE9poV54OamHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355296; c=relaxed/simple;
	bh=7Pc6B+3KGI5aJQGM9Znil7HCNHrMoQVJX5Dqx0v6uY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmeFlqN4NV9b3nA+/n9iJshEloEKa/EU5m+YqhU26zpF0u5waslOGg0RYp4JRO/gTWBeD57l64PrYAZhDYDyfSLxjxSDefiAmvigtaPtQNnfdXXKF4cw01Y3rxLPlF4r0bHBDlZkkvi+a+pKaxAHi05kZM6Ee5d/sI4kRzvd8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COTO6ftq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81905C19421;
	Tue, 17 Feb 2026 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355296;
	bh=7Pc6B+3KGI5aJQGM9Znil7HCNHrMoQVJX5Dqx0v6uY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=COTO6ftqCVhDKaTkYz7yP2x2jgH/x39LB+YfCC2NSFTTe8ia43ujOIgdiZPJTwDme
	 O/Yco/d+z3P4vE+7lUD5c6AnbD/QH6UZgupt+z8Jtkfz/7HCXByx/JiCzH/6Q7F/13
	 MAfjiDaHAmyTR1GjsZ2pVUPFH2dJjIcgW6upUrMRGtvftUPFIP89d/M9Kls113Bxm7
	 paVROabi/gvykVxf+omPbzPnKkpvuQQnicitqCqBqV1zOtNs9GYMBnvcAIvmuKp3Nn
	 QZTnpgy2+npaQ51I93kURi4NMNdcpMAx47SyqTqB9wqpgt/eNQ5WzNZOlgesrMt+3U
	 Dmzs3oU9CAwkQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 18/23] tools/power turbostat: Enhance HT enumeration
Date: Tue, 17 Feb 2026 13:04:09 -0600
Message-ID: <070e92361eeca21407ce90b582698a877ece5694.1771354333.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-42786-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: A1E1E14F7B4
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Record the cpu_id of each CPU HT sibling -- will need this later.

Rename "thread_id" to "ht_id" to disambiguate that the scope
of this id is within a Core -- it is not a global cpu_id.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 34 +++++++++++++++------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6091d0117994..12d5f8112c92 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2400,7 +2400,8 @@ struct cpu_topology {
 	int logical_cpu_id;
 	int physical_node_id;
 	int logical_node_id;	/* 0-based count within the package */
-	int thread_id;
+	int ht_id;		/* unique within a core */
+	int ht_sibling_cpu_id;
 	int type;
 	cpu_set_t *put_ids;	/* Processing Unit/Thread IDs */
 } *cpus;
@@ -6179,8 +6180,8 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 	int thread_id = 0;
 
 	thiscpu->put_ids = CPU_ALLOC((topo.max_cpu_num + 1));
-	if (thiscpu->thread_id < 0)
-		thiscpu->thread_id = thread_id++;
+	if (thiscpu->ht_id < 0)
+		thiscpu->ht_id = thread_id++;
 	if (!thiscpu->put_ids)
 		return -1;
 
@@ -6204,8 +6205,10 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 				sib_core = get_core_id(so);
 				if (sib_core == thiscpu->core_id) {
 					CPU_SET_S(so, size, thiscpu->put_ids);
-					if ((so != cpu) && (cpus[so].thread_id < 0))
-						cpus[so].thread_id = thread_id++;
+					if ((so != cpu) && (cpus[so].ht_id < 0)) {
+						cpus[so].ht_id = thread_id++;
+						cpus[cpu].ht_sibling_cpu_id = so;
+					}
 				}
 			}
 		}
@@ -6388,9 +6391,10 @@ int mark_cpu_present(int cpu)
 	return 0;
 }
 
-int init_thread_id(int cpu)
+int init_ht_id(int cpu)
 {
-	cpus[cpu].thread_id = -1;
+	cpus[cpu].ht_id = -1;
+	cpus[cpu].ht_sibling_cpu_id = -1;
 	return 0;
 }
 
@@ -9575,13 +9579,13 @@ void topology_probe(bool startup)
 	cpu_affinity_setsize = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
 	CPU_ZERO_S(cpu_affinity_setsize, cpu_affinity_set);
 
-	for_all_proc_cpus(init_thread_id);
+	for_all_proc_cpus(init_ht_id);
 
 	for_all_proc_cpus(set_cpu_hybrid_type);
 
 	/*
 	 * For online cpus
-	 * find max_core_id, max_package_id
+	 * find max_core_id, max_package_id, num_cores (per system)
 	 */
 	for (i = 0; i <= topo.max_cpu_num; ++i) {
 		int siblings;
@@ -9623,11 +9627,12 @@ void topology_probe(bool startup)
 		siblings = get_thread_siblings(&cpus[i]);
 		if (siblings > max_siblings)
 			max_siblings = siblings;
-		if (cpus[i].thread_id == 0)
+		if (cpus[i].ht_id == 0)
 			topo.num_cores++;
 	}
-	topo.max_core_id = max_core_id;
+	topo.max_core_id = max_core_id;			/* within a package */
 	topo.max_package_id = max_package_id;
+	topo.num_cores = (max_core_id + 1) * topo.num_packages;	/* per system */
 
 	topo.cores_per_node = max_core_id + 1;
 	if (debug > 1)
@@ -9669,7 +9674,7 @@ void topology_probe(bool startup)
 		fprintf(outf,
 			"cpu %d pkg %d die %d l3 %d node %d lnode %d core %d thread %d\n",
 			i, cpus[i].package_id, cpus[i].die_id, cpus[i].l3_id,
-			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].core_id, cpus[i].thread_id);
+			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].core_id, cpus[i].ht_id);
 	}
 
 }
@@ -9727,14 +9732,13 @@ void allocate_counters(struct counters *counters)
 /*
  * init_counter()
  *
- * set FIRST_THREAD_IN_CORE and FIRST_CORE_IN_PACKAGE
+ * set t->cpu_id, FIRST_THREAD_IN_CORE and FIRST_CORE_IN_PACKAGE
  */
 void init_counter(struct thread_data *thread_base, struct core_data *core_base, struct pkg_data *pkg_base, int cpu_id)
 {
 	int pkg_id = cpus[cpu_id].package_id;
 	int node_id = cpus[cpu_id].logical_node_id;
 	int core_id = cpus[cpu_id].core_id;
-	int thread_id = cpus[cpu_id].thread_id;
 	struct thread_data *t;
 	struct core_data *c;
 
@@ -9744,7 +9748,7 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 	if (node_id < 0)
 		node_id = 0;
 
-	t = GET_THREAD(thread_base, thread_id, core_id, node_id, pkg_id);
+	t = GET_THREAD(thread_base, cpus[cpu_id].ht_id, core_id, node_id, pkg_id);
 	c = GET_CORE(core_base, core_id, node_id, pkg_id);
 
 	t->cpu_id = cpu_id;
-- 
2.45.2


