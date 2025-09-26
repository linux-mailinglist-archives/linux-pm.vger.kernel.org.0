Return-Path: <linux-pm+bounces-35429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6466CBA2431
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9697AC57F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09392641CA;
	Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZDCcHJ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BC262FE5
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855267; cv=none; b=ay5a10eGjZGRmQpx3tQJqG20xEL1W+3cv71jGed4PDDDNsJ9ejKzXyr0ywQ5Y2OIuQleLd2uBhqcvEWwcbVVn0zMQ2m9ZySUdY+04JIhqNsGn/jYLxg4+dULn7KAtVqCj2W+FV3EYgN3kc6UxNYGaxW9Qbw8+uS+BXvu+lHeAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855267; c=relaxed/simple;
	bh=zJ99xua2tHT/BUYbdGugzjq8vqWUBnTjpwmizcpMNO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYKYjp9lOeoj2s7lSVPkUWqnOTxhcCP6WvERoOSt48DXN3k7gdT+HIktA+qxTNAXgWWMbqkOkf19DxNCph30rjQB06gUq07NvD4D27tBQcZSoqLCp15nu5kndBSR7AkcmDUgX9XlCEiYvtWPbjAMYrI303QpL552FUHV5NbguT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZDCcHJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B141C113D0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855267;
	bh=zJ99xua2tHT/BUYbdGugzjq8vqWUBnTjpwmizcpMNO8=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ZZDCcHJ+I0IFQvMElKG5ugCLOYCPaHe5eAdPwulh+kiJwJ+2XWOA78+SiB6R6OQ1K
	 mZOsk4SyDfbuCuvxEUDyQekunm/pzxv7O+825CYC24R68Suq8pKSrJ+jtw2w+W5Nxm
	 bYHEs/YPF2r2dOX28ixmXh4qRIk6zmfTje26U5t1fVuE43QAMwIEvDdM0vdcMTjvL8
	 h0ym4YaPa8tT+BSfqFxPGWIGZpiAyTyLQMmxUisrvMLOk9YK7AFm39eodoPFwpWS8U
	 n8IoB+1MUxuqkinTBZ58OjZC6FYlVEfgaZGSXkNK6CDhhbdEYbrkG7i98db4Hj6JXd
	 ogVX7lzdHXhzg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 1/7] tools/power x86_energy_perf_policy: Enhance HWP enabled check
Date: Thu, 25 Sep 2025 22:51:03 -0400
Message-ID: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250926025422.73800-1-lenb@kernel.org>
References: <20250926025422.73800-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Verify that all CPUs have HWP enabled, not just cpu0.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 44 +++++++++++++++----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ebda9c366b2b..822539a06cfd 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -4,7 +4,7 @@
  * policy preference bias on recent X86 processors.
  */
 /*
- * Copyright (c) 2010 - 2017 Intel Corporation.
+ * Copyright (c) 2010 - 2025 Intel Corporation.
  * Len Brown <len.brown@intel.com>
  */
 
@@ -517,7 +517,7 @@ void for_packages(unsigned long long pkg_set, int (func)(int))
 
 void print_version(void)
 {
-	printf("x86_energy_perf_policy 17.05.11 (C) Len Brown <len.brown@intel.com>\n");
+	printf("x86_energy_perf_policy 2025.9.19 Len Brown <lenb@kernel.org>\n");
 }
 
 void cmdline(int argc, char **argv)
@@ -1312,6 +1312,17 @@ void for_all_cpus_in_set(size_t set_size, cpu_set_t *cpu_set, int (func)(int))
 		if (CPU_ISSET_S(cpu_num, set_size, cpu_set))
 			func(cpu_num);
 }
+int for_all_cpus_in_set_and(size_t set_size, cpu_set_t *cpu_set, int (func)(int))
+{
+	int cpu_num;
+	int retval = 1;
+
+	for (cpu_num = 0; cpu_num <= max_cpu_num; ++cpu_num)
+		if (CPU_ISSET_S(cpu_num, set_size, cpu_set))
+			retval &= func(cpu_num);
+
+	return retval;
+}
 
 void init_data_structures(void)
 {
@@ -1326,21 +1337,38 @@ void init_data_structures(void)
 	for_all_proc_cpus(mark_cpu_present);
 }
 
-/* clear has_hwp if it is not enable (or being enabled) */
+int is_hwp_enabled_on_cpu(int cpu_num)
+{
+	unsigned long long msr;
+	int retval;
+
+	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
+	get_msr(cpu_num, MSR_PM_ENABLE, &msr);
+	retval = (msr & 1);
 
+	if (verbose)
+		fprintf(stderr, "cpu%d: %sHWP\n", cpu_num, retval ? "" : "No-");
+
+	return retval;
+}
+
+/*
+ * verify_hwp_is_enabled()
+ *
+ * Set (has_hwp=0) if no HWP feature or any of selected CPU set does not have HWP enabled
+ */
 void verify_hwp_is_enabled(void)
 {
-	unsigned long long msr;
+	int retval;
 
 	if (!has_hwp)	/* set in early_cpuid() */
 		return;
 
-	/* MSR_PM_ENABLE[1] == 1 if HWP is enabled and MSRs visible */
-	get_msr(base_cpu, MSR_PM_ENABLE, &msr);
-	if ((msr & 1) == 0) {
+	retval = for_all_cpus_in_set_and(cpu_setsize, cpu_selected_set, is_hwp_enabled_on_cpu);
+
+	if (retval == 0) {
 		fprintf(stderr, "HWP can be enabled using '--hwp-enable'\n");
 		has_hwp = 0;
-		return;
 	}
 }
 
-- 
2.45.2


