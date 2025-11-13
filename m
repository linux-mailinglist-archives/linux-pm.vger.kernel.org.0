Return-Path: <linux-pm+bounces-37986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFFC59B6B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DAD3A96B1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE931A072;
	Thu, 13 Nov 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="n8VdyySn"
X-Original-To: linux-pm@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF13016E4;
	Thu, 13 Nov 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061439; cv=none; b=TYcMv/Z7YiTfIPxwZPm5oODim7igEBBx9/PFJ9T0Et5F/5H5hD0SOJDO2pa4YWcJhXryo2HOKQPq1pj/tJcy1RXnKip0g1CkQRTgjhdzUCsxBvceo1sHb6YeYQ++v7ut817mPEK/YH2zVt1kJHEm4oe2jlLD2xJIPAi4jnnHPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061439; c=relaxed/simple;
	bh=6NwhSO+gKWxEVF8Pphy6+Dp0esQbGYELR6wiz7GCmlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGceJZW/a2GTaJuIB83+3QbKO/7jL2JHSxrVoIBGfI0nJF83gp8XCLVPcuykOIlKQq/OqDsKOVSFdIsFSDG/nMAu/zMAlpm7YUkz+1lpzRxrSMzXKfj7E5hqB85pE1QpyBRnjJ81oLqRy1fDgQ7Q2fQJnihuhyuwyCDuP0PI+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=n8VdyySn; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763061438; x=1794597438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOZsE0lR82ixCRjzxwkNCOOyiwybM0SwFsGVQdPuIIk=;
  b=n8VdyySnVKEU6Mn0u+7b7ZijB2R86sS3FrfMt8VUlh4/ydKyhjKuSPfX
   h7TEwD1qy4Cy6WQBQu0yU9lnRXKE9V9TdNHu9VdPbWVweS6z9N3m7OXAF
   MGz6JxRp+kcMWDsPUwX//Essc11ZOxN6po4c2VUGn86hhEsDBFioFHj7l
   7e4QSM4I70s6lCntbYetWKb3XFAYHZrcafnGTLfMo9yOXQS4buAAOipN2
   +IijMd4VcbTxSTtKsUoA3R/q/V9H2QW0klJ3Yra900q5li4hq8VeVgLpD
   SBIeynSg7KapI/iQmmFhqveLSj4ZG+fpX6caSO0GEKWApk8NdOw6aKr9N
   Q==;
X-CSE-ConnectionGUID: n//Qy0InQtWpsrvMGQd69Q==
X-CSE-MsgGUID: xRHy3baoRBKl3gj78BkniQ==
X-IronPort-AV: E=Sophos;i="6.19,302,1754956800"; 
   d="scan'208";a="6858548"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 19:17:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:21284]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.83:2525] with esmtp (Farcaster)
 id ee00218b-b232-4a7e-910e-2b199a7f44d0; Thu, 13 Nov 2025 19:17:15 +0000 (UTC)
X-Farcaster-Flow-ID: ee00218b-b232-4a7e-910e-2b199a7f44d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 13 Nov 2025 19:17:14 +0000
Received: from dev-dsk-ehemily-1c-401a2257.eu-west-1.amazon.com
 (10.253.103.254) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 13 Nov 2025
 19:17:13 +0000
From: Emily Ehlert <ehemily@amazon.de>
To: <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Emily Ehlert
	<ehemily@amazon.com>
Subject: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP calculation fails
Date: Thu, 13 Nov 2025 19:16:09 +0000
Message-ID: <20251113191609.28574-2-ehemily@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113191609.28574-1-ehemily@amazon.de>
References: <20251113191609.28574-1-ehemily@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Emily Ehlert <ehemily@amazon.com>

turbostat uses hard coded features for CPU families and expects access to
RAPL (Running Average Power Limit) MSRs. When RAPL or power info is not
available, turbostat reads PKG_POWER_INFO MSR to calculate TDP with
RAPL_POWER_UNIT MSR. If TDP calculation results in 0, no zero check is
performed and the 0 TDP is used in division, resulting in an invalid
rapl_joule_counter_range. This variable is later used in msr_sum_record()
as a timer parameter to timer_settime() syscall, causing issues.

Fix the issue by:

- Introduce zero check for tdp in rapl_probe_intel() and rapl_probe_amd()
- Introduce global variable no_rapl which is set to true if zero check fails
- Skip RAPL-dependent functions when no_rapl is true
- Add assertions and guards to prevent RAPL operations when disabled

Signed-off-by: Emily Ehlert <ehemily@amazon.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9a2be201a3a6..9c6ee0acbe12 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -531,6 +531,7 @@ static struct timeval procsysfs_tv_begin;
 int ignore_stdin;
 bool no_msr;
 bool no_perf;
+bool no_rapl;
 
 enum gfx_sysfs_idx {
 	GFX_rc6,
@@ -3119,6 +3120,10 @@ int dump_counters(PER_THREAD_PARAMS)
 
 double rapl_counter_get_value(const struct rapl_counter *c, enum rapl_unit desired_unit, double interval)
 {
+	if (no_rapl) {
+		return NAN;
+	}
+
 	assert(desired_unit != RAPL_UNIT_INVALID);
 
 	/*
@@ -4696,6 +4701,8 @@ static size_t cstate_counter_info_count_perf(const struct cstate_counter_info_t
 
 void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_info_t *rci, unsigned int idx)
 {
+	assert(!no_rapl);
+
 	if (rci->source[idx] == COUNTER_SOURCE_NONE)
 		return;
 
@@ -4706,6 +4713,8 @@ void write_rapl_counter(struct rapl_counter *rc, struct rapl_counter_info_t *rci
 
 int get_rapl_counters(int cpu, unsigned int domain, struct core_data *c, struct pkg_data *p)
 {
+	assert(!no_rapl);
+
 	struct platform_counters *pplat_cnt = p == package_odd ? &platform_counters_odd : &platform_counters_even;
 	unsigned long long perf_data[NUM_RAPL_COUNTERS + 1];
 	struct rapl_counter_info_t *rci;
@@ -5147,7 +5156,7 @@ int get_counters(PER_THREAD_PARAMS)
 	if (!is_cpu_first_thread_in_core(t, c, p))
 		goto done;
 
-	if (platform->has_per_core_rapl) {
+	if (platform->has_per_core_rapl && !no_rapl) {
 		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
@@ -5213,7 +5222,7 @@ int get_counters(PER_THREAD_PARAMS)
 	if (DO_BIC(BIC_SYS_LPI))
 		p->sys_lpi = cpuidle_cur_sys_lpi_us;
 
-	if (!platform->has_per_core_rapl) {
+	if (!platform->has_per_core_rapl && !no_rapl) {
 		status = get_rapl_counters(cpu, get_rapl_domain_id(cpu), c, p);
 		if (status != 0)
 			return status;
@@ -7650,6 +7659,12 @@ void rapl_probe_intel(void)
 
 	tdp = get_tdp_intel();
 
+	if (tdp == 0.0) {
+		no_rapl = true;
+		fprintf(outf, "RAPL: Could not calculate TDP (TDP: %.0f, MSR_RAPL_POWER_UNIT: %llx)\n", tdp, msr);
+		return;
+	}
+
 	rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
 	if (!quiet)
 		fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.0f Watts\n", rapl_joule_counter_range, tdp);
@@ -7680,6 +7695,12 @@ void rapl_probe_amd(void)
 
 	tdp = get_tdp_amd();
 
+	if (tdp == 0.0) {
+		no_rapl = true;
+		fprintf(outf, "RAPL: Could not calculate TDP (TDP: %.0f, MSR_RAPL_POWER_UNIT: %llx)\n", tdp, msr);
+		return;
+	}
+
 	rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
 	if (!quiet)
 		fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.0f Watts\n", rapl_joule_counter_range, tdp);
@@ -11215,7 +11236,7 @@ int main(int argc, char **argv)
 
 	turbostat_init();
 
-	if (!no_msr)
+	if (!no_msr && !no_rapl)
 		msr_sum_record();
 
 	/* dump counters and exit */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


