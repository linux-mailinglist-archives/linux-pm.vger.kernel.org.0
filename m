Return-Path: <linux-pm+bounces-28230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F9BAD13AD
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3425D18898C1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727C1C5D5A;
	Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elv3iGy6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61091B85FD
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406736; cv=none; b=iNwlr6nSpLE/yga4vVbf+Us8LKAJfNi2Igv99F1cYWnw49i1nCHn50qfVbFJHWO20+ypFJByk/yOtoSbfpguCbNsd3IBzD79opIgOrMW31FrLs9VOHliWPkA8lFWYBD/kEnhg8VEEK6O0tgNyV8y1yWdaMcTsRfO+jewXd+AoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406736; c=relaxed/simple;
	bh=MGBlw2VuvKd9mMLjmalGsVWFgCc/cy75JR6OczEdjvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djnaKUhEyehy0Xl/gBh5Pk9gwzUo6BXkG1mgOPy52NOXCagcD6Ot2/JucuhYKkEgbUJoykaeFbdfYHsJTepevsbO4ETY6uobtxsCgFm4U4M7yU6/sH9M1HBzCkLFT4BpcZjj0eTOxftzZoCbtHtIOm8hGvsdQKovK8lWWOgioaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elv3iGy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A101C4CEEE;
	Sun,  8 Jun 2025 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406736;
	bh=MGBlw2VuvKd9mMLjmalGsVWFgCc/cy75JR6OczEdjvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=elv3iGy6wKW31eVUGfmasJBk8GhEIO3CBric4p/OmvtocPTw+1+wTRsH8rPeDdQ3P
	 Pa7wE7/bSxHVExtpPZmos7AHXs+0FqzmS8QXgXSS7bIKmAg1ZgVZ8XsWQJVpMmddfC
	 wzdtDkiUuspTctvR1BGodytfwL0DDr/KVjb3lCUr8ULuReuvZjOu2aZ9Hix0Xst5KQ
	 a8YUTDH69Azr4H7in8i+4KExHsdMuttml3q52g8r8gmxffH5fpwrMqtKqC6ZStLmIE
	 rH3RmzoTonRgmqh+1dmdeetyuES79iEWuZmDqwggS5emZ/34rFjSy1EDv6s8o1eS5s
	 YGWxA21kmBgCA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 05/18] tools/power turbostat: Fix AMD package-energy reporting
Date: Sun,  8 Jun 2025 14:17:04 -0400
Message-ID: <1ed2e02e04889381e74ed03908107dacddf5c201.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

commit 05a2f07db888 ("tools/power turbostat: read RAPL counters via
perf") that adds support to read RAPL counters via perf defines the
notion of a RAPL domain_id which is set to physical_core_id on
platforms which support per_core_rapl counters (Eg: AMD processors
Family 17h onwards) and is set to the physical_package_id on all the
other platforms.

However, the physical_core_id is only unique within a package and on
platforms with multiple packages more than one core can have the same
physical_core_id and thus the same domain_id. (For eg, the first cores
of each package have the physical_core_id = 0). This results in all
these cores with the same physical_core_id using the same entry in the
rapl_counter_info_perdomain[]. Since rapl_perf_init() skips the
perf-initialization for cores whose domain_ids have already been
visited, cores that have the same physical_core_id always read the
perf file corresponding to the physical_core_id of the first package
and thus the package-energy is incorrectly reported to be the same
value for different packages.

Note: This issue only arises when RAPL counters are read via perf and
not when they are read via MSRs since in the latter case the MSRs are
read separately on each core.

Fix this issue by associating each CPU with rapl_core_id which is
unique across all the packages in the system.

Fixes: 05a2f07db888 ("tools/power turbostat: read RAPL counters via perf")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 41 +++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 018f0fe96691..743db19a13c2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4773,6 +4773,38 @@ unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
 	return (value & value_mask) >> value_shift;
 }
 
+
+/* Rapl domain enumeration helpers */
+static inline int get_rapl_num_domains(void)
+{
+	int num_packages = topo.max_package_id + 1;
+	int num_cores_per_package;
+	int num_cores;
+
+	if (!platform->has_per_core_rapl)
+		return num_packages;
+
+	num_cores_per_package = topo.max_core_id + 1;
+	num_cores = num_cores_per_package * num_packages;
+
+	return num_cores;
+}
+
+static inline int get_rapl_domain_id(int cpu)
+{
+	int nr_cores_per_package = topo.max_core_id + 1;
+	int rapl_core_id;
+
+	if (!platform->has_per_core_rapl)
+		return cpus[cpu].physical_package_id;
+
+	/* Compute the system-wide unique core-id for @cpu */
+	rapl_core_id = cpus[cpu].physical_core_id;
+	rapl_core_id += cpus[cpu].physical_package_id * nr_cores_per_package;
+
+	return rapl_core_id;
+}
+
 /*
  * get_counters(...)
  * migrate to cpu
@@ -4828,7 +4860,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		goto done;
 
 	if (platform->has_per_core_rapl) {
-		status = get_rapl_counters(cpu, c->core_id, c, p);
+		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
 	}
@@ -4894,7 +4926,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
 	if (!platform->has_per_core_rapl) {
-		status = get_rapl_counters(cpu, p->package_id, c, p);
+		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
 	}
@@ -7877,7 +7909,7 @@ void linux_perf_init(void)
 
 void rapl_perf_init(void)
 {
-	const unsigned int num_domains = (platform->has_per_core_rapl ? topo.max_core_id : topo.max_package_id) + 1;
+	const unsigned int num_domains = get_rapl_num_domains();
 	bool *domain_visited = calloc(num_domains, sizeof(bool));
 
 	rapl_counter_info_perdomain = calloc(num_domains, sizeof(*rapl_counter_info_perdomain));
@@ -7918,8 +7950,7 @@ void rapl_perf_init(void)
 				continue;
 
 			/* Skip already seen and handled RAPL domains */
-			next_domain =
-			    platform->has_per_core_rapl ? cpus[cpu].physical_core_id : cpus[cpu].physical_package_id;
+			next_domain = get_rapl_domain_id(cpu);
 
 			assert(next_domain < num_domains);
 
-- 
2.45.2


