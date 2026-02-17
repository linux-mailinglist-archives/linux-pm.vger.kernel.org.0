Return-Path: <linux-pm+bounces-42784-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPz8K5+8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42784-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5514F7AC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6283C301061C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C037473B;
	Tue, 17 Feb 2026 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJuotUFI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0A372B44
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355292; cv=none; b=mSNbYfIp6O3MnhF0ZdXB/WbtiaJ9ISkIZvOQ/XiTISzMv0TCpJkMM+BqZrBH/Qui7DHyCknBJrh6q3DBhN1Pht1Dsg5j4eObE5+A3GLh1zQqXwLrnkp2zHqiqynujNSweWXpjAXeiWDGZyGNs/qqevmA9cwf4AT2rIVzvLmi47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355292; c=relaxed/simple;
	bh=HBruUP+NafMvThWMy5YUWRjgirEZK45rsT3R3NawMjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsJ3jttYzwove6az8bWGbCzLXdua/NCNHq+24ZcEiHSfhw3qxVberYkKfEu+PtPckK4VGRqZxaB4CFCprg1boKxg3ITTNwQwbJfLt+ElhSFH42+lHc7egvHr291vCn2qXYGAvpJR0CgVByDCeSiAbgCgGZKqQTr43drlUyG7AOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJuotUFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF40FC19425;
	Tue, 17 Feb 2026 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355291;
	bh=HBruUP+NafMvThWMy5YUWRjgirEZK45rsT3R3NawMjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=eJuotUFIxUQDQCwUKH/BOzIEAqgh9cAYfpjsG92qq0I+fpLbaoh3OuBmmIU4qzywu
	 R9hAgc4khyll2UgaSPeSxnpv5bxnk6qq2fFkN1hDSKHU4zPBeKATabFmPiskr2uChx
	 Ss+BqR8FVYAEUV9yQOvC6QYb2o/W6kCknZF5Witlz2OvSDk4YYu9kZy96PewY00xAn
	 sbl3HaPhS38S7qTyjFP6Fvmy+S60hW+AEpZJovCAFQyVXkxf8OKux9pMMFrV6oGrE5
	 VFpWs1oh/3E3NA6YzkavhPyJODmOg1a8G2hk8PFInosudoW1kjAjJOUmtRMH0fQCIq
	 PdkRcaKfcTZvw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 16/23] tools/power turbostat: Unify even/odd/average counter referencing
Date: Tue, 17 Feb 2026 13:04:07 -0600
Message-ID: <a854684986b7056dd1be8730ccce24d0d5a413e9.1771354333.git.len.brown@intel.com>
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
	TAGGED_FROM(0.00)[bounces-42784-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 99C5514F7AC
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Update the syntax of accesses to the even and odd counters
to match the average counters.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 82 +++++++++++++--------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b3b697e669a3..d37f36852f0f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2133,7 +2133,7 @@ struct thread_data {
 	unsigned long long counter[MAX_ADDED_THREAD_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_THREAD_COUNTERS];
 	unsigned long long pmt_counter[PMT_MAX_ADDED_THREAD_COUNTERS];
-} *thread_even, *thread_odd;
+};
 
 struct core_data {
 	int first_cpu;
@@ -2147,7 +2147,7 @@ struct core_data {
 	unsigned long long counter[MAX_ADDED_CORE_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_CORE_COUNTERS];
 	unsigned long long pmt_counter[PMT_MAX_ADDED_CORE_COUNTERS];
-} *core_even, *core_odd;
+};
 
 struct pkg_data {
 	int first_cpu;
@@ -2182,10 +2182,10 @@ struct pkg_data {
 	unsigned long long counter[MAX_ADDED_PACKAGE_COUNTERS];
 	unsigned long long perf_counter[MAX_ADDED_PACKAGE_COUNTERS];
 	unsigned long long pmt_counter[PMT_MAX_ADDED_PACKAGE_COUNTERS];
-} *package_even, *package_odd;
+};
 
-#define ODD_COUNTERS thread_odd, core_odd, package_odd
-#define EVEN_COUNTERS thread_even, core_even, package_even
+#define ODD_COUNTERS odd.threads, odd.cores, odd.packages
+#define EVEN_COUNTERS even.threads, even.cores, even.packages
 
 #define GET_THREAD(thread_base, thread_no, core_no, node_no, pkg_no)	      \
 	((thread_base) +						      \
@@ -2382,11 +2382,11 @@ static void free_sys_msr_counters(void)
 	sys.added_package_counters -= free_msr_counters_(&sys.pp);
 }
 
-struct system_summary {
+struct counters {
 	struct thread_data *threads;
 	struct core_data *cores;
 	struct pkg_data *packages;
-} average;
+} average, even, odd;
 
 struct platform_counters {
 	struct rapl_counter energy_psys;	/* MSR_PLATFORM_ENERGY_STATUS */
@@ -3142,7 +3142,7 @@ int dump_counters(PER_THREAD_PARAMS)
 {
 	int i;
 	struct msr_counter *mp;
-	struct platform_counters *pplat_cnt = p == package_odd ? &platform_counters_odd : &platform_counters_even;
+	struct platform_counters *pplat_cnt = p == odd.packages ? &platform_counters_odd : &platform_counters_even;
 
 	outp += sprintf(outp, "t %p, c %p, p %p\n", t, c, p);
 
@@ -4800,7 +4800,7 @@ void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_info_t *rci
 
 int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct pkg_data *p)
 {
-	struct platform_counters *pplat_cnt = p == package_odd ? &platform_counters_odd : &platform_counters_even;
+	struct platform_counters *pplat_cnt = p == odd.packages ? &platform_counters_odd : &platform_counters_even;
 	unsigned long long perf_data[NUM_RAPL_COUNTERS + 1];
 	struct rapl_counter_info_t *rci;
 
@@ -5973,21 +5973,21 @@ void free_all_buffers(void)
 		perf_lcore_set = NULL;
 	}
 
-	free(thread_even);
-	free(core_even);
-	free(package_even);
+	free(even.threads);
+	free(even.cores);
+	free(even.packages);
 
-	thread_even = NULL;
-	core_even = NULL;
-	package_even = NULL;
+	even.threads = NULL;
+	even.cores = NULL;
+	even.packages = NULL;
 
-	free(thread_odd);
-	free(core_odd);
-	free(package_odd);
+	free(odd.threads);
+	free(odd.cores);
+	free(odd.packages);
 
-	thread_odd = NULL;
-	core_odd = NULL;
-	package_odd = NULL;
+	odd.threads = NULL;
+	odd.cores = NULL;
+	odd.packages = NULL;
 
 	free(output_buffer);
 	output_buffer = NULL;
@@ -9687,50 +9687,50 @@ void topology_probe(bool startup)
 
 }
 
-void allocate_counters_1(struct thread_data **t, struct core_data **c, struct pkg_data **p)
+void allocate_counters_1(struct counters *counters)
 {
-	*t = calloc(1, sizeof(struct thread_data));
-	if (*t == NULL)
+	counters->threads = calloc(1, sizeof(struct thread_data));
+	if (counters->threads == NULL)
 		goto error;
 
-	*c = calloc(1, sizeof(struct core_data));
-	if (*c == NULL)
+	counters->cores = calloc(1, sizeof(struct core_data));
+	if (counters->cores == NULL)
 		goto error;
 
-	*p = calloc(1, sizeof(struct pkg_data));
-	if (*p == NULL)
+	counters->packages = calloc(1, sizeof(struct pkg_data));
+	if (counters->packages == NULL)
 		goto error;
 
 	return;
 error:
 	err(1, "calloc counters_1");
 }
-void allocate_counters(struct thread_data **t, struct core_data **c, struct pkg_data **p)
+void allocate_counters(struct counters *counters)
 {
 	int i;
 	int num_cores = topo.cores_per_node * topo.nodes_per_pkg * topo.num_packages;
 	int num_threads = topo.threads_per_core * num_cores;
 
-	*t = calloc(num_threads, sizeof(struct thread_data));
-	if (*t == NULL)
+	counters->threads = calloc(num_threads, sizeof(struct thread_data));
+	if (counters->threads == NULL)
 		goto error;
 
 	for (i = 0; i < num_threads; i++)
-		(*t)[i].cpu_id = -1;
+		(counters->threads)[i].cpu_id = -1;
 
-	*c = calloc(num_cores, sizeof(struct core_data));
-	if (*c == NULL)
+	counters->cores = calloc(num_cores, sizeof(struct core_data));
+	if (counters->cores == NULL)
 		goto error;
 
 	for (i = 0; i < num_cores; i++)
-		(*c)[i].first_cpu = -1;
+		(counters->cores)[i].first_cpu = -1;
 
-	*p = calloc(topo.num_packages, sizeof(struct pkg_data));
-	if (*p == NULL)
+	counters->packages = calloc(topo.num_packages, sizeof(struct pkg_data));
+	if (counters->packages == NULL)
 		goto error;
 
 	for (i = 0; i < topo.num_packages; i++)
-		(*p)[i].first_cpu = -1;
+		(counters->packages)[i].first_cpu = -1;
 
 	return;
 error:
@@ -9831,9 +9831,9 @@ void setup_all_buffers(bool startup)
 	topology_probe(startup);
 	allocate_irq_buffers();
 	allocate_fd_percpu();
-	allocate_counters_1(&average.threads, &average.cores, &average.packages);
-	allocate_counters(&thread_even, &core_even, &package_even);
-	allocate_counters(&thread_odd, &core_odd, &package_odd);
+	allocate_counters_1(&average);
+	allocate_counters(&even);
+	allocate_counters(&odd);
 	allocate_output_buffer();
 	for_all_proc_cpus(initialize_counters);
 	topology_update();
-- 
2.45.2


