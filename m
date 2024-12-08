Return-Path: <linux-pm+bounces-18752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEFF9E83F2
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D6B165C30
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AD1487FE;
	Sun,  8 Dec 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvgv5nay"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40F3C463;
	Sun,  8 Dec 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639465; cv=fail; b=eR33LCS+dW7xqbmTk/xfeAub+ttuYjZ3rjr6qogl4qkFAbnaHczbYvVoSsGKjyZ5hUgmeeFlieVl4NKl8y50yrF73PxgcdH8CyV8tDokYiSIfIjmLjPSDuL7DtwIqmEk2Zuqu1VhJswwuptHvaCe7wxEDpy7jfWoc6xXHsB+NAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639465; c=relaxed/simple;
	bh=cMivOQWZogQBB05LU5VTBgcnzLFViRdZ6a1taO7j+7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz1BgRC+9QHNCKtq9bUkKz1+U5VOJnGuKRRu3Bhc15fbeNEdkowcEOm6v8CA51bvpF0trRBdAiWuFjXbxZ6m8R2g/g88AbXbC+0Gz0bGmoYZCY1YED8uKNCslwieHQ+IC5DkXmQdBCr1Hst//nQ2OILY5vjubst4tl8Pc+cK1gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvgv5nay; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWFMa9xPRs3ZojqVdz+WnzSuAZNBPjGB8mpNk/2AljIMKrq5M7Tb8zAA9r3KMPrqv1ArY07B5YJISx2Ydv/GDvoe51FqddWJqST1PnBNIzeuxJqnop+SOk/ofVQHRyzH3Ku57tPz0E3j2OrDeeN9xxr4f6rAnv0Ymq4N1Kx+L5aShlk9W9C0k2iRjXJInjK68k+Bg+WAwq+rR0L55xLXj1d+oMbpk4xlFaNdP8OtHBESjgjJ1hbcGCUc/iMOo30OsqQGUTpynq3Ad4tVsR+ZM5DgBQd6QBiwhO5ir2ueuQvzlMu/KTz18eMVr0B7N85Nz9wBWoioGGYsSlIlO/qi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCd4s0IPHxRfilvupvmiDEaJQouGx2yoyCLixWtybzk=;
 b=LspVZUzlo6z3kKm88PozK+AGVrHrlLTeKlEyi6uP+Tp4e+HuVzvY4xdyhf7+bRQcmg/wHG7oncoT5Y/i36fdhiiM/fSRk+pt9qOQ5UzhzZP/CRyCvVp5hnnmXp1klyxV2lPcIOoc84BpMoM2p9z/ztidtYit9nfghkVx1osg8TCe/cR4JyigfsJmCaRsWdcyxQ9OHsBOz8hO9SgSAKQMOjuPaqTUu1tJ19HDpbhVQieD3b5v+Osx1FE8d6d3U6t6TmmlUGLqnS8giVEF+pJFHoiHwBM4JiZEC9jruIn/7EeFEacqMnDF0t1PbVasnigNTCD7CJRBXObkVNpUtTyihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCd4s0IPHxRfilvupvmiDEaJQouGx2yoyCLixWtybzk=;
 b=jvgv5nayNvxV4oFzqMoJzx5KX1+2Xn71XgxNFQyqwL9uQG6vCeoA84lZulAeQ/dyAOBf+Xx01gcKsmALSqR+4lGvqgkoMcVFwP3QyuptpodfGyvSJyquW4VueV8JtEBcG+05bf2J2PRkNe578J8Apxlm+rDI84dUHBagyus3Q+8=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Sun, 8 Dec 2024 06:31:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::c9) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 09/16] cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
Date: Sun, 8 Dec 2024 00:30:24 -0600
Message-ID: <20241208063031.3113-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208063031.3113-1-mario.limonciello@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 84af7816-0a79-4030-d606-08dd1751e173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dK3br9Z11K7Ow1HCXvhG1lTSby3rSwhKdf1TAvz7PMMFcDjREINjAKgRPbiv?=
 =?us-ascii?Q?U5P7DblTbMo77f1tCGT70vOjTj17SlRuQlfS6QaXrQXml0xYYZnPncwVZnlF?=
 =?us-ascii?Q?pnzQAncOYg9cViLTxC6dU5NH7evehLvHQ3lNwCpibpU2r5zbVsUnpW8eJslD?=
 =?us-ascii?Q?3+6LUb+njUK9SySGWceQwyOnH6BjwmBzi9a+HNwHZVK3X+W4Mi9R+20WVAW1?=
 =?us-ascii?Q?9uECPWJVhciNYciVMAlszdBr7ngWWFGIkoUGZ1MgcDQikh22TSeZeCTBfbmZ?=
 =?us-ascii?Q?/kR2CZ2r8amscFue6/0V2rEAXvQMpX0H9vxa8XCa38SD/4CZuCZgf9gUiya1?=
 =?us-ascii?Q?37b6GVBT2C1wL0QLXs11s/u9Y3l1W/hucXf4E8qAO8AQgnVzdcqeCPRHxfDD?=
 =?us-ascii?Q?L1bPaIVPy0sPhIwZ368o1CSlBxglFvCKNr459PqS7AX6BtBJR+jsy2ALkTdg?=
 =?us-ascii?Q?mQShMW8eczLUsMyn45m/aAHrlPzYVABmkhvC8rOZL+2y5TG19XO+o5fRkHje?=
 =?us-ascii?Q?d5EuzQfaW8uSq6hvYhFNnR4nLflLrzexpxFnG+KRcontVmI0KDnih6xYugFe?=
 =?us-ascii?Q?LDGogAr7drkGLp6zHct9LwwL+ry/mjdJ6JH/TpBm9zKY5Tm1kyVczOWVPIa/?=
 =?us-ascii?Q?kGVrkE0p2XqqeLle7CF4wNUZW3KlXTodjA4bjYvOsxp0SAbcSSIDBdII5WMu?=
 =?us-ascii?Q?UA7CCKI+MhaEJI715gcZd5ly4K89ByrLFfpo7JBnUBDomqy0ZKvPSuZviO68?=
 =?us-ascii?Q?I3lPl4SkOdG3sZouarT/SMA06Bnw80hFKXzEM9WYAJJdRBf9gV1FL0AOn0Nd?=
 =?us-ascii?Q?dnUw3UmeKJ5CcUoIiL5ThzM53JYdjeX9abl9gXrhJwBFurmlCkxub5Hw79k5?=
 =?us-ascii?Q?tODcdam5iuGQK//e0pPIX/WUA5oFP30JmgrJexi/EDWciqOKb3ZPQ4IU5j7h?=
 =?us-ascii?Q?4CpY//bnWlvLDcZxueBRKOn4lvjBzY5PIM4854i0NZA6Lru0KEMCLVQDeeSj?=
 =?us-ascii?Q?h7nIf/5H6o8aLR150oiBC7urHmQYRfyRfxevOIZAbCEY0PgkmFu0WRpR8Lzq?=
 =?us-ascii?Q?bUJGydNYgJ5P8hQ+d/ekwSvTO4kOCpRwzVQCUAETZFQsRKn2oNJkXNhOtk8F?=
 =?us-ascii?Q?+rmjR5CTNz/qxmXzxx5a8phTNio7ozz8nYxSYprc93I33aQHDPlOvfgi35kx?=
 =?us-ascii?Q?ETjTKnhByitJbv18kcBZ0jQkfQt1p4Sr8Yf8JMgTamO0VmkJnQ/dLfwAhQGQ?=
 =?us-ascii?Q?K1HcKttD9ZdObCc0jfl/ahgam/04csSSx5salf7gMxzUgZftJlNLCUnIpZCf?=
 =?us-ascii?Q?1lsm1briJ4ibaxJkil4/PJtOuygpipoJ6qoUj+YfzTfq/Z1yb9GWmblwtYbn?=
 =?us-ascii?Q?Us+dMmtZadYs2VB1WaN1h5p5mPBfnLtgV5ayeegmv3kQRwsxTqludIZvt4H6?=
 =?us-ascii?Q?OtvEoappr+aYU2S6OYZB/CCSU5NXxdgH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:59.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84af7816-0a79-4030-d606-08dd1751e173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961

As msr_update_perf() calls an MSR it's possible that it fails. Pass
this return code up to the caller.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8a173359c2754..3a3df67c096d5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -251,24 +251,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
 	return index;
 }
 
-static void msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 			       u32 des_perf, u32 max_perf, bool fast_switch)
 {
-	if (fast_switch)
+	if (fast_switch) {
 		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
-	else
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-			      READ_ONCE(cpudata->cppc_req_cached));
+		return 0;
+	}
+
+	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			     READ_ONCE(cpudata->cppc_req_cached));
 }
 
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
-static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
+static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
 					  u32 max_perf, bool fast_switch)
 {
-	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-					    max_perf, fast_switch);
+	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+						   max_perf, fast_switch);
 }
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
@@ -480,7 +482,7 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static void shmem_update_perf(struct amd_cpudata *cpudata,
+static int shmem_update_perf(struct amd_cpudata *cpudata,
 			     u32 min_perf, u32 des_perf,
 			     u32 max_perf, bool fast_switch)
 {
@@ -490,7 +492,7 @@ static void shmem_update_perf(struct amd_cpudata *cpudata,
 	perf_ctrls.min_perf = min_perf;
 	perf_ctrls.desired_perf = des_perf;
 
-	cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	return cppc_set_perf(cpudata->cpu, &perf_ctrls);
 }
 
 static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
-- 
2.43.0


