Return-Path: <linux-pm+bounces-42780-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEVwAbu8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42780-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E614F7FC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7ACE3026154
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDF372B44;
	Tue, 17 Feb 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+fwqrYC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46E285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355286; cv=none; b=LSjapi3HHH7C/Sk/pk3pWWs7HT5s1//OzSe0pDZxxfGePSZI6AJMQBgQL3mVdIcTCjlHf7dipMd5hvwnFtIv4LQAs53dCg1aIytWk31StGzx1/q0zwNVNMEaFxd5TzRwI/PNYMf2TwDegYp5XWpaGmU/gyLLnQ9rVWj7pbaSORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355286; c=relaxed/simple;
	bh=fT4busmGxdN1ThCpLeGa05A9DGr9+E3Feh63ZbFf0Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHcbZjlL+nEicJ60Gx1rOeJ1yjguW/oossYsrsgU0a7p65ESUIPGr99TEblymePLTPUIBwGCtArqrTMboAGDDxIbR+E9BJTR+3nCNoditnHbU7wiWNXur2GNFVH4NCG+pVQV58uup9XBguLQQ+VB3fib5H3mQe3cloxXyhRLwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+fwqrYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69EDC4CEF7;
	Tue, 17 Feb 2026 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355286;
	bh=fT4busmGxdN1ThCpLeGa05A9DGr9+E3Feh63ZbFf0Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=c+fwqrYC3AeARwsggGSml8utsoOmufiasbhkddmu5/9dUrG7rk8pHnLt6vGa1O0A4
	 SMFKIaiQLnGYJP2JoaS/ITrUpiSSbmKyZWKX1Y4Vf0JNRbhKfsT7zZVOoGw5rKXKTh
	 tgH8lQ4Y8CRMTHtZoEdQ/MU12Niecr2SB4FWNguwtBbAfjmWmjl5u0RFML6rtoKreP
	 aDnKj2LzxbPnkGe+avguFkRaOwn+MogYS1lu9YTx1f320IDsPXxGieihtGl+ia5ah+
	 qEMsx9vftcQzg1ZNYjx3sz8Cxrjz6JCiGrax70elYgfrGyM3wqMzHFcxZG2NjkNq36
	 186ob3jQjWjkg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/23] tools/power turbostat: Cleanup package_id
Date: Tue, 17 Feb 2026 13:04:03 -0600
Message-ID: <4aaf7d07a089696e16e1ca70c2d501dc8a2224a4.1771354332.git.len.brown@intel.com>
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
	TAGGED_FROM(0.00)[bounces-42780-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 8A6E614F7FC
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

The kernel topology sysfs uses the name "physical_package_id"
because it is allowed to be sparse.

Inside Turbostat, that physical package_id namespace is the only
package_id namespace, so re-name it to simply be "package_id"
in cpus[].

Delete the redundant copy of package_id in pkg_data.
Rely instead on the single copy of the truth in cpus[].

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 52 ++++++++++++---------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2c603990c0d3..74d9f9e21e94 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2171,7 +2171,6 @@ struct pkg_data {
 	long long sam_mc6_ms;
 	unsigned int sam_mhz;
 	unsigned int sam_act_mhz;
-	unsigned int package_id;
 	struct rapl_counter energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
 	struct rapl_counter energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
 	struct rapl_counter energy_cores;	/* MSR_PP0_ENERGY_STATUS */
@@ -2395,7 +2394,7 @@ struct platform_counters {
 } platform_counters_odd, platform_counters_even;
 
 struct cpu_topology {
-	int physical_package_id;
+	int package_id;
 	int die_id;
 	int l3_id;
 	int logical_cpu_id;
@@ -2662,7 +2661,7 @@ unsigned int cpu_to_domain(const struct perf_counter_info *pc, int cpu)
 		return cpus[cpu].physical_core_id;
 
 	case SCOPE_PACKAGE:
-		return cpus[cpu].physical_package_id;
+		return cpus[cpu].package_id;
 	}
 
 	__builtin_unreachable();
@@ -3199,8 +3198,6 @@ int dump_counters(PER_THREAD_PARAMS)
 	}
 
 	if (p && is_cpu_first_core_in_package(t, p)) {
-		outp += sprintf(outp, "package: %d\n", p->package_id);
-
 		outp += sprintf(outp, "Weighted cores: %016llX\n", p->pkg_wtd_core_c0);
 		outp += sprintf(outp, "Any cores: %016llX\n", p->pkg_any_core_c0);
 		outp += sprintf(outp, "Any GFX: %016llX\n", p->pkg_any_gfxe_c0);
@@ -3366,7 +3363,7 @@ int format_counters(PER_THREAD_PARAMS)
 	} else {
 		if (DO_BIC(BIC_Package)) {
 			if (p)
-				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), p->package_id);
+				outp += sprintf(outp, "%s%d", (printed++ ? delim : ""), cpus[t->cpu_id].package_id);
 			else
 				outp += sprintf(outp, "%s-", (printed++ ? delim : ""));
 		}
@@ -5180,11 +5177,11 @@ static inline int get_rapl_domain_id(int cpu)
 	int rapl_core_id;
 
 	if (!platform->has_per_core_rapl)
-		return cpus[cpu].physical_package_id;
+		return cpus[cpu].package_id;
 
 	/* Compute the system-wide unique core-id for @cpu */
 	rapl_core_id = cpus[cpu].physical_core_id;
-	rapl_core_id += cpus[cpu].physical_package_id * nr_cores_per_package;
+	rapl_core_id += cpus[cpu].package_id * nr_cores_per_package;
 
 	return rapl_core_id;
 }
@@ -5328,7 +5325,7 @@ int get_counters(PER_THREAD_PARAMS)
 	}
 
 	if (DO_BIC(BIC_UNCORE_MHZ))
-		p->uncore_mhz = get_legacy_uncore_mhz(p->package_id);
+		p->uncore_mhz = get_legacy_uncore_mhz(cpus[t->cpu_id].package_id);
 
 	if (DO_BIC(BIC_GFX_rc6))
 		p->gfx_rc6_ms = gfx_info[GFX_rc6].val_ull;
@@ -5352,9 +5349,9 @@ int get_counters(PER_THREAD_PARAMS)
 		char *path = NULL;
 
 		if (mp->msr_num == 0) {
-			path = find_sysfs_path_by_id(mp->sp, p->package_id);
+			path = find_sysfs_path_by_id(mp->sp, cpus[t->cpu_id].package_id);
 			if (path == NULL) {
-				warnx("%s: package_id %d not found", __func__, p->package_id);
+				warnx("%s: package_id %d not found", __func__, cpus[t->cpu_id].package_id);
 				return -10;
 			}
 		}
@@ -5366,7 +5363,7 @@ int get_counters(PER_THREAD_PARAMS)
 		return -10;
 
 	for (i = 0, pp = sys.pmt_pp; pp; i++, pp = pp->next)
-		p->pmt_counter[i] = pmt_read_counter(pp, p->package_id);
+		p->pmt_counter[i] = pmt_read_counter(pp, cpus[t->cpu_id].package_id);
 
 done:
 	gettimeofday(&t->tv_end, (struct timezone *)NULL);
@@ -6050,7 +6047,7 @@ int cpu_is_first_core_in_package(int cpu)
 	return cpu == parse_int_file("/sys/devices/system/cpu/cpu%d/topology/core_siblings_list", cpu);
 }
 
-int get_physical_package_id(int cpu)
+int get_package_id(int cpu)
 {
 	return parse_int_file("/sys/devices/system/cpu/cpu%d/topology/physical_package_id", cpu);
 }
@@ -6083,7 +6080,7 @@ void set_node_data(void)
 	for (pkg = 0; pkg < topo.num_packages; pkg++) {
 		lnode = 0;
 		for (cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
-			if (cpus[cpu].physical_package_id != pkg)
+			if (cpus[cpu].package_id != pkg)
 				continue;
 			/* find a cpu with an unset logical_node_id */
 			if (cpus[cpu].logical_node_id != -1)
@@ -6096,7 +6093,7 @@ void set_node_data(void)
 			 * the logical_node_id
 			 */
 			for (cpux = cpu; cpux <= topo.max_cpu_num; cpux++) {
-				if ((cpus[cpux].physical_package_id == pkg) && (cpus[cpux].physical_node_id == node)) {
+				if ((cpus[cpux].package_id == pkg) && (cpus[cpux].physical_node_id == node)) {
 					cpus[cpux].logical_node_id = lnode;
 					cpu_count++;
 				}
@@ -7206,7 +7203,7 @@ static void probe_intel_uncore_frequency_cluster(void)
 	}
 	for (i = uncore_max_id; i >= 0; --i) {
 		int k, l;
-		int package_id, domain_id, cluster_id;
+		int unc_pkg_id, domain_id, cluster_id;
 		char name_buf[16];
 
 		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", i);
@@ -7215,7 +7212,7 @@ static void probe_intel_uncore_frequency_cluster(void)
 			err(1, "%s: %s", __func__, path_base);
 
 		sprintf(path, "%s/package_id", path_base);
-		package_id = read_sysfs_int(path);
+		unc_pkg_id = read_sysfs_int(path);
 
 		sprintf(path, "%s/domain_id", path_base);
 		domain_id = read_sysfs_int(path);
@@ -7238,7 +7235,7 @@ static void probe_intel_uncore_frequency_cluster(void)
 		 */
 		if BIC_IS_ENABLED
 			(BIC_UNCORE_MHZ)
-			    add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
+			    add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, unc_pkg_id);
 
 		if (quiet)
 			continue;
@@ -7247,7 +7244,7 @@ static void probe_intel_uncore_frequency_cluster(void)
 		k = read_sysfs_int(path);
 		sprintf(path, "%s/max_freq_khz", path_base);
 		l = read_sysfs_int(path);
-		fprintf(outf, "Uncore Frequency package%d domain%d cluster%d: %d - %d MHz ", package_id, domain_id, cluster_id, k / 1000, l / 1000);
+		fprintf(outf, "Uncore Frequency package%d domain%d cluster%d: %d - %d MHz ", unc_pkg_id, domain_id, cluster_id, k / 1000, l / 1000);
 
 		sprintf(path, "%s/initial_min_freq_khz", path_base);
 		k = read_sysfs_int(path);
@@ -8952,7 +8949,7 @@ void cstate_perf_init_(bool soft_c1)
 				continue;
 
 			const int core_id = cpus[cpu].physical_core_id;
-			const int pkg_id = cpus[cpu].physical_package_id;
+			const int pkg_id = cpus[cpu].package_id;
 
 			assert(core_id < cores_visited_elems);
 			assert(pkg_id < pkg_visited_elems);
@@ -9612,9 +9609,9 @@ void topology_probe(bool startup)
 		cpus[i].logical_cpu_id = i;
 
 		/* get package information */
-		cpus[i].physical_package_id = get_physical_package_id(i);
-		if (cpus[i].physical_package_id > max_package_id)
-			max_package_id = cpus[i].physical_package_id;
+		cpus[i].package_id = get_package_id(i);
+		if (cpus[i].package_id > max_package_id)
+			max_package_id = cpus[i].package_id;
 
 		/* get die information */
 		cpus[i].die_id = get_die_id(i);
@@ -9685,7 +9682,7 @@ void topology_probe(bool startup)
 			continue;
 		fprintf(outf,
 			"cpu %d pkg %d die %d l3 %d node %d lnode %d core %d thread %d\n",
-			i, cpus[i].physical_package_id, cpus[i].die_id, cpus[i].l3_id,
+			i, cpus[i].package_id, cpus[i].die_id, cpus[i].l3_id,
 			cpus[i].physical_node_id, cpus[i].logical_node_id, cpus[i].physical_core_id, cpus[i].thread_id);
 	}
 
@@ -9717,10 +9714,8 @@ void allocate_counters(struct thread_data **t, struct core_data **c, struct pkg_
 	if (*p == NULL)
 		goto error;
 
-	for (i = 0; i < topo.num_packages; i++) {
-		(*p)[i].package_id = i;
+	for (i = 0; i < topo.num_packages; i++)
 		(*p)[i].first_cpu = -1;
-	}
 
 	return;
 error:
@@ -9734,7 +9729,7 @@ void allocate_counters(struct thread_data **t, struct core_data **c, struct pkg_
  */
 void init_counter(struct thread_data *thread_base, struct core_data *core_base, struct pkg_data *pkg_base, int cpu_id)
 {
-	int pkg_id = cpus[cpu_id].physical_package_id;
+	int pkg_id = cpus[cpu_id].package_id;
 	int node_id = cpus[cpu_id].logical_node_id;
 	int core_id = cpus[cpu_id].physical_core_id;
 	int thread_id = cpus[cpu_id].thread_id;
@@ -9760,7 +9755,6 @@ void init_counter(struct thread_data *thread_base, struct core_data *core_base,
 	}
 
 	c->core_id = core_id;
-	pkg_base[pkg_id].package_id = pkg_id;
 }
 
 int initialize_counters(int cpu_id)
-- 
2.45.2


