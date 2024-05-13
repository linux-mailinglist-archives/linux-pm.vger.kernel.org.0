Return-Path: <linux-pm+bounces-7783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B28C47C0
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D851F2483F
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B37CF25;
	Mon, 13 May 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX9QsX2Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E07BB13
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629283; cv=none; b=QHwH5cu3wzXyMWdfCG+w0YVEUtMwvOLiU3f0Ar9ALgngqIfnGLD6twCw++hwNLQuDLSry9n40KMrmpV7l0WC8CDlxiCMLDWdauQcM/6IDGOYRqleb+RSynweTAtn/+cjBdMQskSM10dzpLKkjMeq4EyWIyx+NDGfCB+lExdeshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629283; c=relaxed/simple;
	bh=4e5O/ONblZaBFeBWSMcyXTCFpY8HKEO9sLFQV8ysjYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5SYG9sQqzJZhdG8mkpIixZmLWIGTDW90iw4o0zmQm7SixN0hLKAssTzFBxA7u/nEwoRhVX0Az/9LwxzeMnws5LLXV29TK6hy5X+eaOP12LpCbrv98Xg2Hb4+FSXX4HI7sNhKXB4GhVOrWiFwBtL9tKDolnpIajoFZQAiO0Ap7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX9QsX2Z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-622e32414ffso16649777b3.1
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629280; x=1716234080; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwfEqa9RJrurdrI+45fooNjZUYm55KZHrlA7HqPg3Xk=;
        b=SX9QsX2ZWbk1s8H7EutIl4E7Y0f3KcTPTAdcNrUTSu82a0xOx8kdCcuSRfayMa2k03
         7Vp+yzGqZ77jZT7Nv3/eTRAKHzo8gaErM5YF78ws7jkm97F7WpYWGeTvPqReL8cB5u47
         qVFDt+T7eIqKZJWYK2y3aN52tFiad8H8Zb0QPJ5F5lP75j9bjxGotI/Qzz759hH65fmc
         3snlpLw6DVC2st9aE/01RIjOVvVHF22PSUFst5D922kMtMsfFSp9IFDAwZtBhcP1mLqK
         7iDPZo0jh62zQvGG/iUywAimKz33AEwththyzIlZHCWM3L6/pmgRgHGcg1YTPwwUxury
         shOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629280; x=1716234080;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwfEqa9RJrurdrI+45fooNjZUYm55KZHrlA7HqPg3Xk=;
        b=GZcmOkpqIYzlFg6rpBypeU629S6uMyx2+NMkKwro18eXXuRHiVknojqXdkL5SPLK5I
         HPtkefeempgAkobWNGSW7t20zm1GR2S/aSgW1Wq5vi7883+rKJthDFtrxueXPLEvrOwZ
         9jwMKbU/WRQxH+YqbdhJmFLIzrjt2n4d1HdL+2uS4MVALYshMjYbGFQUyy0fiHn1i6EE
         ghRtYxCyKCdi/ps9YvrqOFLwv4OwEbiL2WLJ/4w5DoOIWDqa52TtGIMJ3B+GBRBohgyn
         THMMuwPKQzhghqIscJx1ZcvknAzRLsBRDMZFXaAwB1scQRxh6ZL6ZdlzcoQXShuJb2mp
         tmlw==
X-Gm-Message-State: AOJu0Yz5oUzKYdQXJjiCmys00CWmd0vVE6spRlz0W8nJDS6OpQGspZvx
	vZfZ+2eVaRqvjd7w8WngpQiOiVGQxbfpWN9I2jiOicjh1FfDKuRK6O1plA==
X-Google-Smtp-Source: AGHT+IGi7V+iUNyMbtgkMYq0UxqRFgbjsJYCk4aqSbmO3suo2fjH4i5bhTSTja8nq6wb6lPw7EM/LQ==
X-Received: by 2002:a0d:ca4a:0:b0:61b:3304:ce04 with SMTP id 00721157ae682-622afff981amr143361527b3.34.1715629278887;
        Mon, 13 May 2024 12:41:18 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:18 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 12/15] tools/power turbostat: Read Package-cstates via perf
Date: Mon, 13 May 2024 15:40:48 -0400
Message-Id: <ffc2e3d90e6f9bcbf978ed815ecacf22b8980d79.1715628187.git.len.brown@intel.com>
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

Reading the counters via perf can be done in bulk with a single syscall,
making the counter values more accurate with respect to one another by
minimizing the time gap between individual counter reads.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 374 +++++++++++++++++---------
 1 file changed, 244 insertions(+), 130 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 030e0f8692a6..1ae13e30a366 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -224,6 +224,28 @@ unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC
 #define BIC_NOT_PRESENT(COUNTER_BIT) (bic_present &= ~COUNTER_BIT)
 #define BIC_IS_ENABLED(COUNTER_BIT) (bic_enabled & COUNTER_BIT)
 
+/*
+ * MSR_PKG_CST_CONFIG_CONTROL decoding for pkg_cstate_limit:
+ * If you change the values, note they are used both in comparisons
+ * (>= PCL__7) and to index pkg_cstate_limit_strings[].
+ */
+#define PCLUKN 0		/* Unknown */
+#define PCLRSV 1		/* Reserved */
+#define PCL__0 2		/* PC0 */
+#define PCL__1 3		/* PC1 */
+#define PCL__2 4		/* PC2 */
+#define PCL__3 5		/* PC3 */
+#define PCL__4 6		/* PC4 */
+#define PCL__6 7		/* PC6 */
+#define PCL_6N 8		/* PC6 No Retention */
+#define PCL_6R 9		/* PC6 Retention */
+#define PCL__7 10		/* PC7 */
+#define PCL_7S 11		/* PC7 Shrink */
+#define PCL__8 12		/* PC8 */
+#define PCL__9 13		/* PC9 */
+#define PCL_10 14		/* PC10 */
+#define PCLUNL 15		/* Unlimited */
+
 struct amperf_group_fd;
 
 char *proc_stat = "/proc/stat";
@@ -1190,21 +1212,30 @@ enum ccstate_rci_index {
 	CCSTATE_RCI_INDEX_C3_RESIDENCY = 1,
 	CCSTATE_RCI_INDEX_C6_RESIDENCY = 2,
 	CCSTATE_RCI_INDEX_C7_RESIDENCY = 3,
-	NUM_CCSTATE_COUNTERS,
+	PCSTATE_RCI_INDEX_C2_RESIDENCY = 4,
+	PCSTATE_RCI_INDEX_C3_RESIDENCY = 5,
+	PCSTATE_RCI_INDEX_C6_RESIDENCY = 6,
+	PCSTATE_RCI_INDEX_C7_RESIDENCY = 7,
+	PCSTATE_RCI_INDEX_C8_RESIDENCY = 8,
+	PCSTATE_RCI_INDEX_C9_RESIDENCY = 9,
+	PCSTATE_RCI_INDEX_C10_RESIDENCY = 10,
+	NUM_CSTATE_COUNTERS,
 };
 
 struct cstate_counter_info_t {
-	unsigned long long data[NUM_CCSTATE_COUNTERS];
-	enum cstate_source source[NUM_CCSTATE_COUNTERS];
-	unsigned long long msr[NUM_CCSTATE_COUNTERS];
-	int fd_perf;
+	unsigned long long data[NUM_CSTATE_COUNTERS];
+	enum cstate_source source[NUM_CSTATE_COUNTERS];
+	unsigned long long msr[NUM_CSTATE_COUNTERS];
+	int fd_perf_core;
+	int fd_perf_pkg;
 };
 
 struct cstate_counter_info_t *ccstate_counter_info;
 unsigned int ccstate_counter_info_size;
 
-#define CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD (1u << 0)
-#define CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY (1u << 1)
+#define CSTATE_COUNTER_FLAG_COLLECT_PER_CORE   (1u << 0)
+#define CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD ((1u << 1) | CSTATE_COUNTER_FLAG_COLLECT_PER_CORE)
+#define CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY (1u << 2)
 
 struct cstate_counter_arch_info {
 	int feature_mask;	/* Mask for testing if the counter is supported on host */
@@ -1214,6 +1245,7 @@ struct cstate_counter_arch_info {
 	unsigned int rci_index;	/* Maps data from perf counters to global variables */
 	unsigned long long bic;
 	unsigned long long flags;
+	int pkg_cstate_limit;
 };
 
 static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
@@ -1225,6 +1257,7 @@ static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
 	 .rci_index = CCSTATE_RCI_INDEX_C1_RESIDENCY,
 	 .bic = BIC_CPU_c1,
 	 .flags = CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD,
+	 .pkg_cstate_limit = 0,
 	  },
 	{
 	 .feature_mask = CC3,
@@ -1233,7 +1266,8 @@ static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
 	 .msr = MSR_CORE_C3_RESIDENCY,
 	 .rci_index = CCSTATE_RCI_INDEX_C3_RESIDENCY,
 	 .bic = BIC_CPU_c3,
-	 .flags = CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	 .flags = CSTATE_COUNTER_FLAG_COLLECT_PER_CORE | CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	 .pkg_cstate_limit = 0,
 	  },
 	{
 	 .feature_mask = CC6,
@@ -1242,7 +1276,8 @@ static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
 	 .msr = MSR_CORE_C6_RESIDENCY,
 	 .rci_index = CCSTATE_RCI_INDEX_C6_RESIDENCY,
 	 .bic = BIC_CPU_c6,
-	 .flags = CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	 .flags = CSTATE_COUNTER_FLAG_COLLECT_PER_CORE | CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	 .pkg_cstate_limit = 0,
 	  },
 	{
 	 .feature_mask = CC7,
@@ -1251,7 +1286,78 @@ static struct cstate_counter_arch_info ccstate_counter_arch_infos[] = {
 	 .msr = MSR_CORE_C7_RESIDENCY,
 	 .rci_index = CCSTATE_RCI_INDEX_C7_RESIDENCY,
 	 .bic = BIC_CPU_c7,
-	 .flags = CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	 .flags = CSTATE_COUNTER_FLAG_COLLECT_PER_CORE | CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY,
+	 .pkg_cstate_limit = 0,
+	  },
+	{
+	 .feature_mask = PC2,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c2-residency",
+	 .msr = MSR_PKG_C2_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C2_RESIDENCY,
+	 .bic = BIC_Pkgpc2,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL__2,
+	  },
+	{
+	 .feature_mask = PC3,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c3-residency",
+	 .msr = MSR_PKG_C3_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C3_RESIDENCY,
+	 .bic = BIC_Pkgpc3,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL__3,
+	  },
+	{
+	 .feature_mask = PC6,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c6-residency",
+	 .msr = MSR_PKG_C6_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C6_RESIDENCY,
+	 .bic = BIC_Pkgpc6,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL__6,
+	  },
+	{
+	 .feature_mask = PC7,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c7-residency",
+	 .msr = MSR_PKG_C7_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C7_RESIDENCY,
+	 .bic = BIC_Pkgpc7,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL__7,
+	  },
+	{
+	 .feature_mask = PC8,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c8-residency",
+	 .msr = MSR_PKG_C8_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C8_RESIDENCY,
+	 .bic = BIC_Pkgpc8,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL__8,
+	  },
+	{
+	 .feature_mask = PC9,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c9-residency",
+	 .msr = MSR_PKG_C9_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C9_RESIDENCY,
+	 .bic = BIC_Pkgpc9,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL__9,
+	  },
+	{
+	 .feature_mask = PC10,
+	 .perf_subsys = "cstate_pkg",
+	 .perf_name = "c10-residency",
+	 .msr = MSR_PKG_C10_RESIDENCY,
+	 .rci_index = PCSTATE_RCI_INDEX_C10_RESIDENCY,
+	 .bic = BIC_Pkgpc10,
+	 .flags = 0,
+	 .pkg_cstate_limit = PCL_10,
 	  },
 };
 
@@ -1641,15 +1747,8 @@ int get_msr_fd(int cpu)
 
 static void bic_disable_msr_access(void)
 {
-	const unsigned long bic_msrs =
-	    BIC_SMI |
-	    BIC_Mod_c6 |
-	    BIC_CoreTmp |
-	    BIC_Totl_c0 |
-	    BIC_Any_c0 |
-	    BIC_GFX_c0 |
-	    BIC_CPUGFX |
-	    BIC_Pkgpc2 | BIC_Pkgpc3 | BIC_Pkgpc6 | BIC_Pkgpc7 | BIC_Pkgpc8 | BIC_Pkgpc9 | BIC_Pkgpc10 | BIC_PkgTmp;
+	const unsigned long bic_msrs = BIC_SMI | BIC_Mod_c6 | BIC_CoreTmp |
+	    BIC_Totl_c0 | BIC_Any_c0 | BIC_GFX_c0 | BIC_CPUGFX | BIC_PkgTmp;
 
 	bic_enabled &= ~bic_msrs;
 
@@ -3493,7 +3592,7 @@ static size_t cstate_counter_info_count_perf(const struct cstate_counter_info_t
 {
 	size_t ret = 0;
 
-	for (int i = 0; i < NUM_CCSTATE_COUNTERS; ++i)
+	for (int i = 0; i < NUM_CSTATE_COUNTERS; ++i)
 		if (cci->source[i] == CSTATE_SOURCE_PERF)
 			++ret;
 
@@ -3598,9 +3697,16 @@ char *find_sysfs_path_by_id(struct sysfs_path *sp, int id)
 	return NULL;
 }
 
-int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_data *c)
+int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
-	unsigned long long perf_data[NUM_CCSTATE_COUNTERS + 1];
+	/*
+	 * Overcommit memory a little bit here,
+	 * but skip calculating exact sizes for the buffers.
+	 */
+	unsigned long long perf_data[NUM_CSTATE_COUNTERS];
+	unsigned long long perf_data_core[NUM_CSTATE_COUNTERS + 1];
+	unsigned long long perf_data_pkg[NUM_CSTATE_COUNTERS + 1];
+
 	struct cstate_counter_info_t *cci;
 
 	if (debug)
@@ -3609,35 +3715,72 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 	assert(ccstate_counter_info);
 	assert(cpu <= ccstate_counter_info_size);
 
+	memset(perf_data, 0, sizeof(perf_data));
+	memset(perf_data_core, 0, sizeof(perf_data_core));
+	memset(perf_data_pkg, 0, sizeof(perf_data_pkg));
+
 	cci = &ccstate_counter_info[cpu];
 
 	/*
 	 * If we have any perf counters to read, read them all now, in bulk
 	 */
-	if (cci->fd_perf != -1) {
-		const size_t num_perf_counters = cstate_counter_info_count_perf(cci);
-		const ssize_t expected_read_size =
-			(num_perf_counters + 1) * sizeof(unsigned long long);
-		const ssize_t actual_read_size =
-			read(cci->fd_perf, &perf_data[0], sizeof(perf_data));
+	const size_t num_perf_counters = cstate_counter_info_count_perf(cci);
+	ssize_t expected_read_size = num_perf_counters * sizeof(unsigned long long);
+	ssize_t actual_read_size_core = 0, actual_read_size_pkg = 0;
 
-		if (actual_read_size != expected_read_size)
-			err(-1, "%s: failed to read perf_data (%zu %zu)",
-				__func__, expected_read_size, actual_read_size);
+	if (cci->fd_perf_core != -1) {
+		/* Each descriptor read begins with number of counters read. */
+		expected_read_size += sizeof(unsigned long long);
+
+		actual_read_size_core = read(cci->fd_perf_core, &perf_data_core[0], sizeof(perf_data_core));
+
+		if (actual_read_size_core <= 0)
+			err(-1, "%s: read perf %s: %ld", __func__, "core", actual_read_size_core);
+	}
+
+	if (cci->fd_perf_pkg != -1) {
+		/* Each descriptor read begins with number of counters read. */
+		expected_read_size += sizeof(unsigned long long);
+
+		actual_read_size_pkg = read(cci->fd_perf_pkg, &perf_data_pkg[0], sizeof(perf_data_pkg));
+
+		if (actual_read_size_pkg <= 0)
+			err(-1, "%s: read perf %s: %ld", __func__, "pkg", actual_read_size_pkg);
 	}
 
-	for (unsigned int i = 0, pi = 1; i < NUM_CCSTATE_COUNTERS; ++i) {
+	const ssize_t actual_read_size_total = actual_read_size_core + actual_read_size_pkg;
+
+	if (actual_read_size_total != expected_read_size)
+		err(-1, "%s: failed to read perf_data (%zu %zu)", __func__, expected_read_size, actual_read_size_total);
+
+	/*
+	 * Copy ccstate and pcstate data into unified buffer.
+	 *
+	 * Skip first element from core and pkg buffers.
+	 * Kernel puts there how many counters were read.
+	 */
+	const size_t num_core_counters = perf_data_core[0];
+	const size_t num_pkg_counters = perf_data_pkg[0];
+
+	assert(num_perf_counters == num_core_counters + num_pkg_counters);
+
+	/* Copy ccstate perf data */
+	memcpy(&perf_data[0], &perf_data_core[1], num_core_counters * sizeof(unsigned long long));
+
+	/* Copy pcstate perf data */
+	memcpy(&perf_data[num_core_counters], &perf_data_pkg[1], num_pkg_counters * sizeof(unsigned long long));
+
+	for (unsigned int i = 0, pi = 0; i < NUM_CSTATE_COUNTERS; ++i) {
 		switch (cci->source[i]) {
 		case CSTATE_SOURCE_NONE:
 			break;
 
 		case CSTATE_SOURCE_PERF:
 			assert(pi < ARRAY_SIZE(perf_data));
-			assert(cci->fd_perf != -1);
+			assert(cci->fd_perf_core != -1 || cci->fd_perf_pkg != -1);
 
 			if (debug) {
-				fprintf(stderr, "cstate via %s %u: %llu\n",
-					"perf", i, perf_data[pi]);
+				fprintf(stderr, "cstate via %s %u: %llu\n", "perf", i, perf_data[pi]);
 			}
 
 			cci->data[i] = perf_data[pi];
@@ -3651,8 +3794,7 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 				return -13 - i;
 
 			if (debug) {
-				fprintf(stderr, "cstate via %s0x%llx %u: %llu\n",
-					"msr", cci->msr[i], i, cci->data[i]);
+				fprintf(stderr, "cstate via %s0x%llx %u: %llu\n", "msr", cci->msr[i], i, cci->data[i]);
 			}
 
 			break;
@@ -3671,12 +3813,21 @@ int get_cstate_counters(unsigned int cpu, struct thread_data *t, struct core_dat
 		out_counter = cci->data[index];			\
 } while (0)
 
-	BUILD_BUG_ON(NUM_CCSTATE_COUNTERS != 4);
+	BUILD_BUG_ON(NUM_CSTATE_COUNTERS != 11);
+
 	PERF_COUNTER_WRITE_DATA(t->c1, CCSTATE_RCI_INDEX_C1_RESIDENCY);
 	PERF_COUNTER_WRITE_DATA(c->c3, CCSTATE_RCI_INDEX_C3_RESIDENCY);
 	PERF_COUNTER_WRITE_DATA(c->c6, CCSTATE_RCI_INDEX_C6_RESIDENCY);
 	PERF_COUNTER_WRITE_DATA(c->c7, CCSTATE_RCI_INDEX_C7_RESIDENCY);
 
+	PERF_COUNTER_WRITE_DATA(p->pc2, PCSTATE_RCI_INDEX_C2_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(p->pc3, PCSTATE_RCI_INDEX_C3_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(p->pc6, PCSTATE_RCI_INDEX_C6_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(p->pc7, PCSTATE_RCI_INDEX_C7_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(p->pc8, PCSTATE_RCI_INDEX_C8_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(p->pc9, PCSTATE_RCI_INDEX_C9_RESIDENCY);
+	PERF_COUNTER_WRITE_DATA(p->pc10, PCSTATE_RCI_INDEX_C10_RESIDENCY);
+
 #undef PERF_COUNTER_WRITE_DATA
 
 	return 0;
@@ -3738,7 +3889,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		t->smi_count = msr & 0xFFFFFFFF;
 	}
 
-	get_cstate_counters(cpu, t, c);
+	get_cstate_counters(cpu, t, c, p);
 
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &t->counter[i], mp->sp->path))
@@ -3803,34 +3954,6 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		if (get_msr(cpu, MSR_PKG_BOTH_CORE_GFXE_C0_RES, &p->pkg_both_core_gfxe_c0))
 			return -13;
 	}
-	if (DO_BIC(BIC_Pkgpc3))
-		if (get_msr(cpu, MSR_PKG_C3_RESIDENCY, &p->pc3))
-			return -9;
-	if (DO_BIC(BIC_Pkgpc6)) {
-		if (platform->has_msr_atom_pkg_c6_residency) {
-			if (get_msr(cpu, MSR_ATOM_PKG_C6_RESIDENCY, &p->pc6))
-				return -10;
-		} else {
-			if (get_msr(cpu, MSR_PKG_C6_RESIDENCY, &p->pc6))
-				return -10;
-		}
-	}
-
-	if (DO_BIC(BIC_Pkgpc2))
-		if (get_msr(cpu, MSR_PKG_C2_RESIDENCY, &p->pc2))
-			return -11;
-	if (DO_BIC(BIC_Pkgpc7))
-		if (get_msr(cpu, MSR_PKG_C7_RESIDENCY, &p->pc7))
-			return -12;
-	if (DO_BIC(BIC_Pkgpc8))
-		if (get_msr(cpu, MSR_PKG_C8_RESIDENCY, &p->pc8))
-			return -13;
-	if (DO_BIC(BIC_Pkgpc9))
-		if (get_msr(cpu, MSR_PKG_C9_RESIDENCY, &p->pc9))
-			return -13;
-	if (DO_BIC(BIC_Pkgpc10))
-		if (get_msr(cpu, MSR_PKG_C10_RESIDENCY, &p->pc10))
-			return -13;
 
 	if (DO_BIC(BIC_CPU_LPI))
 		p->cpu_lpi = cpuidle_cur_cpu_lpi_us;
@@ -3889,29 +4012,6 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	return 0;
 }
 
-/*
- * MSR_PKG_CST_CONFIG_CONTROL decoding for pkg_cstate_limit:
- * If you change the values, note they are used both in comparisons
- * (>= PCL__7) and to index pkg_cstate_limit_strings[].
- */
-
-#define PCLUKN 0		/* Unknown */
-#define PCLRSV 1		/* Reserved */
-#define PCL__0 2		/* PC0 */
-#define PCL__1 3		/* PC1 */
-#define PCL__2 4		/* PC2 */
-#define PCL__3 5		/* PC3 */
-#define PCL__4 6		/* PC4 */
-#define PCL__6 7		/* PC6 */
-#define PCL_6N 8		/* PC6 No Retention */
-#define PCL_6R 9		/* PC6 Retention */
-#define PCL__7 10		/* PC7 */
-#define PCL_7S 11		/* PC7 Shrink */
-#define PCL__8 12		/* PC8 */
-#define PCL__9 13		/* PC9 */
-#define PCL_10 14		/* PC10 */
-#define PCLUNL 15		/* Unlimited */
-
 int pkg_cstate_limit = PCLUKN;
 char *pkg_cstate_limit_strings[] = { "reserved", "unknown", "pc0", "pc1", "pc2",
 	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "pc8", "pc9", "pc10", "unlimited"
@@ -4410,8 +4510,11 @@ void free_fd_cstate(void)
 	const int counter_info_num = ccstate_counter_info_size;
 
 	for (int counter_id = 0; counter_id < counter_info_num; ++counter_id) {
-		if (ccstate_counter_info[counter_id].fd_perf != -1)
-			close(ccstate_counter_info[counter_id].fd_perf);
+		if (ccstate_counter_info[counter_id].fd_perf_core != -1)
+			close(ccstate_counter_info[counter_id].fd_perf_core);
+
+		if (ccstate_counter_info[counter_id].fd_perf_pkg != -1)
+			close(ccstate_counter_info[counter_id].fd_perf_pkg);
 	}
 
 	free(ccstate_counter_info);
@@ -6905,30 +7008,43 @@ static int has_amperf_access(void)
 	return 0;
 }
 
-int add_cstate_perf_counter_(int cpu, struct cstate_counter_info_t *cci,
-			     const struct cstate_counter_arch_info *cai)
+int *get_cstate_perf_group_fd(struct cstate_counter_info_t *cci, const char *group_name)
+{
+	if (strcmp(group_name, "cstate_core") == 0)
+		return &cci->fd_perf_core;
+
+	if (strcmp(group_name, "cstate_pkg") == 0)
+		return &cci->fd_perf_pkg;
+
+	return NULL;
+}
+
+int add_cstate_perf_counter_(int cpu, struct cstate_counter_info_t *cci, const struct cstate_counter_arch_info *cai)
 {
 	if (no_perf)
 		return -1;
 
+	int *pfd_group = get_cstate_perf_group_fd(cci, cai->perf_subsys);
+
+	if (pfd_group == NULL)
+		return -1;
+
 	const unsigned int type = read_perf_type(cai->perf_subsys);
 	const unsigned int config = read_rapl_config(cai->perf_subsys, cai->perf_name);
 
-	const int fd_counter =
-		open_perf_counter(cpu, type, config, cci->fd_perf, PERF_FORMAT_GROUP);
+	const int fd_counter = open_perf_counter(cpu, type, config, *pfd_group, PERF_FORMAT_GROUP);
 
 	if (fd_counter == -1)
 		return -1;
 
 	/* If it's the first counter opened, make it a group descriptor */
-	if (cci->fd_perf == -1)
-		cci->fd_perf = fd_counter;
+	if (*pfd_group == -1)
+		*pfd_group = fd_counter;
 
 	return fd_counter;
 }
 
-int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci,
-			    const struct cstate_counter_arch_info *cai)
+int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci, const struct cstate_counter_arch_info *cai)
 {
 	int ret = add_cstate_perf_counter_(cpu, cci, cai);
 
@@ -6941,8 +7057,9 @@ int add_cstate_perf_counter(int cpu, struct cstate_counter_info_t *cci,
 void cstate_perf_init_(bool soft_c1)
 {
 	bool has_counter;
-	bool *cores_visited;
+	bool *cores_visited = NULL, *pkg_visited = NULL;
 	const int cores_visited_elems = topo.max_core_id + 1;
+	const int pkg_visited_elems = topo.max_package_id + 1;
 	const int cci_num = topo.max_cpu_num + 1;
 
 	ccstate_counter_info = calloc(cci_num, sizeof(*ccstate_counter_info));
@@ -6954,13 +7071,20 @@ void cstate_perf_init_(bool soft_c1)
 	if (!cores_visited)
 		err(1, "calloc cores_visited");
 
+	pkg_visited = calloc(pkg_visited_elems, sizeof(*pkg_visited));
+	if (!pkg_visited)
+		err(1, "calloc pkg_visited");
+
 	/* Initialize cstate_counter_info_percpu */
-	for (int cpu = 0; cpu < cci_num; ++cpu)
-		ccstate_counter_info[cpu].fd_perf = -1;
+	for (int cpu = 0; cpu < cci_num; ++cpu) {
+		ccstate_counter_info[cpu].fd_perf_core = -1;
+		ccstate_counter_info[cpu].fd_perf_pkg = -1;
+	}
 
-	for (int cidx = 0; cidx < NUM_CCSTATE_COUNTERS; ++cidx) {
+	for (int cidx = 0; cidx < NUM_CSTATE_COUNTERS; ++cidx) {
 		has_counter = false;
 		memset(cores_visited, 0, cores_visited_elems * sizeof(*cores_visited));
+		memset(pkg_visited, 0, pkg_visited_elems * sizeof(*pkg_visited));
 
 		const struct cstate_counter_arch_info *cai = &ccstate_counter_arch_infos[cidx];
 
@@ -6972,23 +7096,29 @@ void cstate_perf_init_(bool soft_c1)
 				continue;
 
 			const int core_id = cpus[cpu].physical_core_id;
+			const int pkg_id = cpus[cpu].physical_package_id;
 
 			assert(core_id < cores_visited_elems);
+			assert(pkg_id < pkg_visited_elems);
 
 			const bool per_thread = cai->flags & CSTATE_COUNTER_FLAG_COLLECT_PER_THREAD;
+			const bool per_core = cai->flags & CSTATE_COUNTER_FLAG_COLLECT_PER_CORE;
 
 			if (!per_thread && cores_visited[core_id])
 				continue;
 
+			if (!per_core && pkg_visited[pkg_id])
+				continue;
+
 			const bool counter_needed = BIC_IS_ENABLED(cai->bic) ||
 			    (soft_c1 && (cai->flags & CSTATE_COUNTER_FLAG_SOFT_C1_DEPENDENCY));
 			const bool counter_supported =
-				platform->supported_cstates & cai->feature_mask;
+			    (platform->supported_cstates & cai->feature_mask) &&
+			    (pkg_cstate_limit >= cai->pkg_cstate_limit);
 
 			if (counter_needed && counter_supported) {
 				/* Use perf API for this counter */
-				if (!no_perf && cai->perf_name
-				    && add_cstate_perf_counter(cpu, cci, cai) != -1) {
+				if (!no_perf && cai->perf_name && add_cstate_perf_counter(cpu, cci, cai) != -1) {
 
 					cci->source[cai->rci_index] = CSTATE_SOURCE_PERF;
 
@@ -7002,6 +7132,7 @@ void cstate_perf_init_(bool soft_c1)
 			if (cci->source[cai->rci_index] != CSTATE_SOURCE_NONE) {
 				has_counter = true;
 				cores_visited[core_id] = true;
+				pkg_visited[pkg_id] = true;
 			}
 		}
 
@@ -7011,6 +7142,7 @@ void cstate_perf_init_(bool soft_c1)
 	}
 
 	free(cores_visited);
+	free(pkg_visited);
 }
 
 void cstate_perf_init(void)
@@ -7020,7 +7152,7 @@ void cstate_perf_init(void)
 	 * but we need APERF, MPERF too.
 	 */
 	const bool soft_c1 = !platform->has_msr_core_c1_res && has_amperf_access()
-			     && platform->supported_cstates & CC1;
+	    && platform->supported_cstates & CC1;
 
 	if (soft_c1)
 		BIC_PRESENT(BIC_CPU_c1);
@@ -7032,27 +7164,6 @@ void probe_cstates(void)
 {
 	probe_cst_limit();
 
-	if (platform->supported_cstates & PC2 && (pkg_cstate_limit >= PCL__2))
-		BIC_PRESENT(BIC_Pkgpc2);
-
-	if (platform->supported_cstates & PC3 && (pkg_cstate_limit >= PCL__3))
-		BIC_PRESENT(BIC_Pkgpc3);
-
-	if (platform->supported_cstates & PC6 && (pkg_cstate_limit >= PCL__6))
-		BIC_PRESENT(BIC_Pkgpc6);
-
-	if (platform->supported_cstates & PC7 && (pkg_cstate_limit >= PCL__7))
-		BIC_PRESENT(BIC_Pkgpc7);
-
-	if (platform->supported_cstates & PC8 && (pkg_cstate_limit >= PCL__8))
-		BIC_PRESENT(BIC_Pkgpc8);
-
-	if (platform->supported_cstates & PC9 && (pkg_cstate_limit >= PCL__9))
-		BIC_PRESENT(BIC_Pkgpc9);
-
-	if (platform->supported_cstates & PC10 && (pkg_cstate_limit >= PCL_10))
-		BIC_PRESENT(BIC_Pkgpc10);
-
 	if (platform->has_msr_module_c6_res_ms)
 		BIC_PRESENT(BIC_Mod_c6);
 
@@ -7311,7 +7422,7 @@ void process_cpuid()
 
 static void counter_info_init(void)
 {
-	for (int i = 0; i < NUM_CCSTATE_COUNTERS; ++i) {
+	for (int i = 0; i < NUM_CSTATE_COUNTERS; ++i) {
 		struct cstate_counter_arch_info *const cai = &ccstate_counter_arch_infos[i];
 
 		if (platform->has_msr_knl_core_c6_residency && cai->msr == MSR_CORE_C6_RESIDENCY)
@@ -7319,6 +7430,9 @@ static void counter_info_init(void)
 
 		if (!platform->has_msr_core_c1_res && cai->msr == MSR_CORE_C1_RES)
 			cai->msr = 0;
+
+		if (platform->has_msr_atom_pkg_c6_residency && cai->msr == MSR_PKG_C6_RESIDENCY)
+			cai->msr = MSR_ATOM_PKG_C6_RESIDENCY;
 	}
 }
 
-- 
2.40.1


