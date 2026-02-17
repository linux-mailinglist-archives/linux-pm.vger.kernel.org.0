Return-Path: <linux-pm+bounces-42781-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C//HL28lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42781-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B0014F803
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFE530584B1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660337473A;
	Tue, 17 Feb 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9U9rAs4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C6374733
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355287; cv=none; b=my1y91jaR8odgtHchHdtZTCa92ysx1FXvkx+xqV+TI6XnYfKbkLufsrQlK+DMo2eapWq0u65UkvVdZJoWzWELDBvFfeR+hVWbHf6Jlk3ZusHSZyiNkh0HmJgQ/VueVfkmmaZSIP32gP9he9Ko7PirQyRsLHteQj3bAVip6NVS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355287; c=relaxed/simple;
	bh=UcELr7GAWyjBnZTALHn16ODRFfu90B9T24hqVisMNHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpmXwOe03j9HdGCDlTlPHRtdJjZEPLe32omecaQvbEcQOSuzEGfi8iB3IeSgd9cgLnlXeu2C3S6Ms/s/KwR6P5825zP6deuNw4aVPiFypUyl93iW++YWKYM9ehqqdqP485Q3NoMYp9KkiVn+8Dbbmn84MxkHPz8u7RCWLTvtWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9U9rAs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03BBC4CEF7;
	Tue, 17 Feb 2026 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355287;
	bh=UcELr7GAWyjBnZTALHn16ODRFfu90B9T24hqVisMNHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=P9U9rAs4XPEP8T5LmTyJ1A1yMW7EeTH/6Tc4yTLhWiCfsRUW7G+qMuJgP3xHJbYTc
	 CydGHHxCsRovBezCiTD3nuY5H4AVvEx+pPWpKilpfThdIcWv9aAZe30/yAN3ilwo/z
	 SKoM5f8jrRypz1dP6dAdkFhnYN6J03JCZ7tUfnH6RG1mp0dX7W6vMbRl7J3mDv6fYW
	 m8owtzLiGBAN1uNSHlbf/HkbpXoDo1wz5kGDMz88plsS38NjtM0FiOuiU9Jsp7om6r
	 6wmqkaAVbF+HiU5kYfX+03KafFGI1XmNzyZm7z0Jvfi8LPzDg3nMkXTYP6rEFMdC2l
	 YjbLmaIk3au0w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/23] tools/power turbostat: Rename physical_core_id to core_id
Date: Tue, 17 Feb 2026 13:04:04 -0600
Message-ID: <5e160646f4dbca7cf9cc09abc31a22931e362b8a.1771354332.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-42781-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 21B0014F803
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

The Linux Kernel topology sysfs is flawed.
core_id is not globally unique, but is per-package.

Turbostat works around this when it needs to, with

        rapl_core_id = cpus[cpu].core_id;
        rapl_core_id += cpus[cpu].package_id * nr_cores_per_package

Otherwise, turbostat handles core_id as subservient to each package.

As there is only one core_id namespace, rename
physical_core_id to simply be core_id.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 74d9f9e21e94..9f93efafbf94 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2394,13 +2394,13 @@ struct platform_counters {
 } platform_counters_odd, platform_counters_even;
 
 struct cpu_topology {
+	int core_id;
 	int package_id;
 	int die_id;
 	int l3_id;
 	int logical_cpu_id;
 	int physical_node_id;
 	int logical_node_id;	/* 0-based count within the package */
-	int physical_core_id;
 	int thread_id;
 	int type;
 	cpu_set_t *put_ids;	/* Processing Unit/Thread IDs */
@@ -2658,7 +2658,7 @@ unsigned int cpu_to_domain(const struct perf_counter_info *pc, int cpu)
 		return cpu;
 
 	case SCOPE_CORE:
-		return cpus[cpu].physical_core_id;
+		return cpus[cpu].core_id;
 
 	case SCOPE_PACKAGE:
 		return cpus[cpu].package_id;
@@ -5180,7 +5180,7 @@ static inline int get_rapl_domain_id(int cpu)
 		return cpus[cpu].package_id;
 
 	/* Compute the system-wide unique core-id for @cpu */
-	rapl_core_id = cpus[cpu].physical_core_id;
+	rapl_core_id = cpus[cpu].core_id;
 	rapl_core_id += cpus[cpu].package_id * nr_cores_per_package;
 
 	return rapl_core_id;
@@ -6216,7 +6216,7 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 			if ((map >> shift) & 0x1) {
 				so = shift + offset;
 				sib_core = get_core_id(so);
-				if (sib_core == thiscpu->physical_core_id) {
+				if (sib_core == thiscpu->core_id) {
 					CPU_SET_S(so, size, thiscpu->put_ids);
 					if ((so != cpu) && (cpus[so].thread_id < 0))
 						cpus[so].thread_id = thread_id++;
@@ -8948,7 +8948,7 @@ void cstate_perf_init_(bool soft_c1)
 			if (cpu_is_not_allowed(cpu))
 				continue;
 
-			const int core_id = cpus[cpu].physical_core_id;
+			const int core_id = cpus[cpu].core_id;
 			const int pkg_id = cpus[cpu].package_id;
 
 			assert(core_id < cores_visited_elems);
@@ -9629,9 +9629,9 @@ void topology_probe(bool startup)
 			topo.max_node_num = cpus[i].physical_node_id;
 
 		/* get core information */
-		cpus[i].physical_core_id = get_core_id(i);
-		if (cpus[i].physical_core_id > max_core_id)
-			max_core_id = cpus[i].physical_core_id;
+		cpus[i].core_id = get_core_id(i);
+		if (cpus[i].core_id > max_core_id)
+			max_core_id = cpus[i].core_id;
 
 		/* get thread information */
 		siblings = get_thread_siblings(&cpus[i]);
@@ -9683,7 +9683,7 @@ void topology_probe(bool startup)
 		fprintf(outf,
 			"cpu %d pkg %d die %d l3 %d node %d lnode %d core %d thread %d\n",
 			i, cpus[i].package_id, cpus[i].die_id, cpus[i].l3_id,
-			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].physical_core_id, cpus[i].thread_id);
+			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].core_id, cpus[i].thread_id);
 	}
 
 }
@@ -9731,7 +9731,7 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 {
 	int pkg_id = cpus[cpu_id].package_id;
 	int node_id = cpus[cpu_id].logical_node_id;
-	int core_id = cpus[cpu_id].physical_core_id;
+	int core_id = cpus[cpu_id].core_id;
 	int thread_id = cpus[cpu_id].thread_id;
 	struct thread_data *t;
 	struct core_data *c;
-- 
2.45.2


