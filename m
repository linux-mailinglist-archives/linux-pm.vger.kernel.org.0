Return-Path: <linux-pm+bounces-7779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8C8C47BC
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74C7285740
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFA762E8;
	Mon, 13 May 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOL0Uh43"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E678285
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629280; cv=none; b=YpuTlIDDw2EFT53xVMpeQ8jP/w2nTcd6NaPQxm669IXT6l0xsldmd0PdWqjyox2mxuugCZhFtiM9DNXI2mPs2tX1wnYxCBfQohADs0EzFGP2aOg333yKeAoPfIMbUcp7u/SS8i6/azxOBSJdewY9GJ0xory6tDfDB5GVPHdccQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629280; c=relaxed/simple;
	bh=VRSZ88cnGLWiyL2k/djHaxVF3dTmDpdboQu3zSQjNiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdaNh0vvvnkJy8Mw/DZc0GkB2F5cWbJ2z/uNndPXkvmd/DdkhjuOiOx7IKbPkAUeNUauxJzOth3iUGOZ0+6UjyVllRfgfNlyJErEeJtNj3FcVtUUDB9DC7C7r5Mn4XSr6+BI89g5fAsHTqmyaGnAxxbUSxkoAbIGgUgaHIduZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOL0Uh43; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6202ad4cae3so40733517b3.2
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629278; x=1716234078; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUks17SSPeeP21k8+K+tfeq9+GBuyp+ZkthiS+zyU1U=;
        b=nOL0Uh43hlrKW3Y/G64UGi3kGTg+yFyiTRnucwUN4RMX5DxfK2PSMlXcjDzM+MyMle
         WAWZY+x268RoJbDBrayNdBndDKXyJfLapsawG6bPqIbLgWmBM9Yf3/rjyrvIAK8BIMFA
         9pQblJ0duOTrNfiUOX/x0ExnTbArZaOu9KlWbvUWxwCxOlQuVqiF04Me6/FvR6hUo2fb
         NqM4TdU2bs4gACOPIJRK1plNt+1ROTCNQWzZkhMqFF03esCcbkHQM+8qANzDFtRallwt
         1fnUurGO2+GB0tWchLgrtX9pBRG8gAufp3ipYPYgByt3zTKYYPPtFvqQSD+wmu+jvQbO
         bAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629278; x=1716234078;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUks17SSPeeP21k8+K+tfeq9+GBuyp+ZkthiS+zyU1U=;
        b=jfUHGXb5HoaPQOVdL28GmvtSDMk0d+AB8uX7U3rG6hhCs1GS+57SsuiWpCztCHD+kF
         zSGkdfk8DrQWUo6gFLIEqPtrP3snCDzwpJR4sqU41PxV4YTXevrEOXr9WQ7onUddP4zR
         c6k4HWC+whEdk+cm0cOHZrCX/w9orWqmvm0/mTz/uGwQ8gcinNEE4sq90avS2Zkl4Wqp
         rjs1QiAzULxY8TOii7ncr239W86WLJ5z4dYjlXNVIf0Rd9dgwPTKEpriDzANGI0YwKYS
         ozjr2oBv6mPCB0WJuuBmJ8fP35q8d6E8IqTAvRvBu5MeNKAxo/1nrTW5bNimlv3Iwizd
         WfkQ==
X-Gm-Message-State: AOJu0YyTHtHBPkLfycdpQNI7Hta8Ig7v9m9lLmJ5g7c26LokfyRYtrNG
	lo3z2z/DXmsJzkDwTLdYkgxS6lVU/gAIqewtxXwivgYOA7S3Sn+psfNNyg==
X-Google-Smtp-Source: AGHT+IENVA2SvYwQmKSFz8TzfIGjavfbGZe7X4J2AjTAZOJAde2OL1b7QJ3J1tS/zzuXW3+O+Di2fw==
X-Received: by 2002:a05:690c:6e05:b0:61b:3304:b724 with SMTP id 00721157ae682-622aff45b09mr122174227b3.10.1715629276575;
        Mon, 13 May 2024 12:41:16 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:16 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 10/15] tools/power turbostat: Avoid possible memory corruption due to sparse topology IDs
Date: Mon, 13 May 2024 15:40:46 -0400
Message-Id: <69881a20ee54d34a4020a733dd6690ce4f2e4646.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Save the highest core and package id when parsing topology to
allocate enough memory when get_rapl_counters() is called with a core or
a package id as a domain.

Note that RAPL domains are per-package on Intel, but per-core on AMD.
Thus, the RAPL code effectively runs in different modes on those two
product lines.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3bf9bb6145f3..66c0c64b4494 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1052,6 +1052,7 @@ struct rapl_counter_info_t {
 
 /* struct rapl_counter_info_t for each RAPL domain */
 struct rapl_counter_info_t *rapl_counter_info_perdomain;
+unsigned int rapl_counter_info_perdomain_size;
 
 #define RAPL_COUNTER_FLAG_USE_MSR_SUM (1u << 1)
 
@@ -1451,6 +1452,8 @@ struct topo_params {
 	int allowed_cpus;
 	int allowed_cores;
 	int max_cpu_num;
+	int max_core_id;
+	int max_package_id;
 	int max_die_id;
 	int max_node_num;
 	int nodes_per_pkg;
@@ -3425,15 +3428,18 @@ void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_info_t *rci
 	rc->scale = rci->scale[idx];
 }
 
-int get_rapl_counters(int cpu, int domain, struct core_data *c, struct pkg_data *p)
+int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct pkg_data *p)
 {
 	unsigned long long perf_data[NUM_RAPL_COUNTERS + 1];
-	struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain];
+	struct rapl_counter_info_t *rci;
 
 	if (debug)
 		fprintf(stderr, "%s: cpu%d domain%d\n", __func__, cpu, domain);
 
 	assert(rapl_counter_info_perdomain);
+	assert(domain < rapl_counter_info_perdomain_size);
+
+	rci = &rapl_counter_info_perdomain[domain];
 
 	/*
 	 * If we have any perf counters to read, read them all now, in bulk
@@ -4257,7 +4263,7 @@ void free_fd_rapl_percpu(void)
 	if (!rapl_counter_info_perdomain)
 		return;
 
-	const int num_domains = platform->has_per_core_rapl ? topo.num_cores : topo.num_packages;
+	const int num_domains = rapl_counter_info_perdomain_size;
 
 	for (int domain_id = 0; domain_id < num_domains; ++domain_id) {
 		if (rapl_counter_info_perdomain[domain_id].fd_perf != -1)
@@ -4265,6 +4271,8 @@ void free_fd_rapl_percpu(void)
 	}
 
 	free(rapl_counter_info_perdomain);
+	rapl_counter_info_perdomain = NULL;
+	rapl_counter_info_perdomain_size = 0;
 }
 
 void free_all_buffers(void)
@@ -6573,17 +6581,18 @@ void linux_perf_init(void)
 
 void rapl_perf_init(void)
 {
-	const int num_domains = platform->has_per_core_rapl ? topo.num_cores : topo.num_packages;
+	const unsigned int num_domains = (platform->has_per_core_rapl ? topo.max_core_id : topo.max_package_id) + 1;
 	bool *domain_visited = calloc(num_domains, sizeof(bool));
 
 	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
 	if (rapl_counter_info_perdomain == NULL)
 		err(-1, "calloc rapl_counter_info_percpu");
+	rapl_counter_info_perdomain_size = num_domains;
 
 	/*
 	 * Initialize rapl_counter_info_percpu
 	 */
-	for (int domain_id = 0; domain_id < num_domains; ++domain_id) {
+	for (unsigned int domain_id = 0; domain_id < num_domains; ++domain_id) {
 		struct rapl_counter_info_t *rci = &rapl_counter_info_perdomain[domain_id];
 
 		rci->fd_perf = -1;
@@ -6603,7 +6612,7 @@ void rapl_perf_init(void)
 		bool has_counter = 0;
 		double scale;
 		enum rapl_unit unit;
-		int next_domain;
+		unsigned int next_domain;
 
 		memset(domain_visited, 0, num_domains * sizeof(*domain_visited));
 
@@ -6616,6 +6625,8 @@ void rapl_perf_init(void)
 			next_domain =
 			    platform->has_per_core_rapl ? cpus[cpu].physical_core_id : cpus[cpu].physical_package_id;
 
+			assert(next_domain < num_domains);
+
 			if (domain_visited[next_domain])
 				continue;
 
@@ -7198,6 +7209,8 @@ void topology_probe(bool startup)
 		if (cpus[i].thread_id == 0)
 			topo.num_cores++;
 	}
+	topo.max_core_id = max_core_id;
+	topo.max_package_id = max_package_id;
 
 	topo.cores_per_node = max_core_id + 1;
 	if (debug > 1)
-- 
2.40.1


