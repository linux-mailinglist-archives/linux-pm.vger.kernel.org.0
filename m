Return-Path: <linux-pm+bounces-18657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0189E609C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217BF16A8C0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E520FA86;
	Thu,  5 Dec 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IwFqRJoh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B11DEFFC;
	Thu,  5 Dec 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437758; cv=fail; b=ibSjfQvBloq/3QdqXIV7d9rDxTYRuR0uvVWwjJSAkM/+KRjtaS9GVphFFVouPmOfSKUa2JBGvxb9Tm7S3pBRipX8F8TkagPN8nag1g8c5ZVmo+4QmFLYm56HVhfwadIIfc7Z3rn3iRjfGnHlTsA5y08aFQtob8AbZlATI1B61EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437758; c=relaxed/simple;
	bh=1NMf0VK4G//HpJSSoBJ6slW6hvX0Iyb/Vg/8Qzh2Ii4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBzLGC5HiM1xYi1hY8XSJ9mJsO778tvh+XSa0rGaziOSmxntRQdrWbVILFcOwSVeWfT4FN3NYUp5vYgQ/T0xOoC9W3qOBJxeh4r2wHWv9wAMvvWOygbIjB2A2953Z/+vMmQPLzPKmVvN6Y8R7F964ahwAWmMPuqUDuD3M3wO9gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IwFqRJoh; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1YxgMLblh2XNEhJK2vJyrBTuzq5yTGH/iFYI9SsPBc1nZNdpDMWlJp7lboCshnxgvVLr1RmplGy22+VTOzg6o2kR9t93MJpRUaNH4IdNbBVZ0ZmIgOLkOkqPmdoQMPJ+d0GIVT/0jzRZUo91K+D7BrXok0LwbfJDUQrg1jdI4XmEVg3ZNuyN3LUtEqDajz2IYlcBKg8/8YFD32n9x0TUpO4igDGxnIV5xbckKtTCbcCROP4TONqgwcAW7H2mmSNIedWdnEH/uY558llBZuy3BkZm3Oi/HuyQ513iNb0ZwXxwYv9etBUbhyHVBSnARSELayQo9d5q/58A/4Sv/a+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1Gv9SjxitfDdt+xGIbHQH5FekAdbg1jqUMtPgKxucQ=;
 b=OzK2ueA//IDs/XqoFUmhLu37V8OSOZugGBUXcDVHSu6XER9Tkayz10Fjh7/2hWLPsb0+h4nj0e4ZsD6Ii9QY+ynmABwBaLN14YKtTCJfv2N66D6MtD6kWF3qJSEo+Twgo4EatrTLDY0D3YjhfthUZot6LOvY9B6YutHAKmlPCVyvJpJZIIDaOW6veVXgUvv8ggUKNFm2lPrT9M12KPKxxpQQ7G1JVNNLvY7HAP0VdVQg44pBXaaPS6yZoI8q233hxf0nHjFXBhUV+h08vhG5rVeiEZIfa02X7XWSeVmED/lFjjWkAqeb7zD19GU4OQUg+ZnXIeke5UhWoHRucr+UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1Gv9SjxitfDdt+xGIbHQH5FekAdbg1jqUMtPgKxucQ=;
 b=IwFqRJoh2wO0de/UFuSz+z39ELJj2IGeu0MSlGBmV8G61k6f4CBhEG1YKMiVx8iO1VVFohfcvlhA3XseLcRIB9OUazqxvCEbkfaZ8D7kz9WzUrSzFh6Lnv61C+OseC8dcVWJVjhIEgrQybBJhWIY6EZxcTjKH7rIJnTy6hBqbao=
Received: from CH0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:610:e7::25)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 22:29:12 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::25) by CH0PR03CA0230.outlook.office365.com
 (2603:10b6:610:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:06 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 12/15] cpufreq/amd-pstate: Always write EPP value when updating perf
Date: Thu, 5 Dec 2024 16:28:44 -0600
Message-ID: <20241205222847.7889-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 3950fe58-0c56-48e1-3b73-08dd157c3e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hT9Sjgcpiexn+rwtMFrqRs2t1xc1B+ifwzASJi7GxPW22/KdT6Q8M7/23UIv?=
 =?us-ascii?Q?i4zFLQARn7OolH1fOpJ/gUXS3ygs9iB8ODcJBqfaqSIF43eP+o1ilZli87k0?=
 =?us-ascii?Q?Ho6n1eizDPARnqsyRLSiejO1dm3KmZamT8MqnssNZ2yLBBde4e1dBjW6X1es?=
 =?us-ascii?Q?VqlE8BIAsgV7VVJ0F0oLAz9SCq9cjVmFBKmng0aDknYFb3usMeNIkW9JIAd7?=
 =?us-ascii?Q?7kJlP1OJssW6qUSYLkFF4fgfzv6y0O6p3li0ViCwofYywuhgfKdCUFCCscUy?=
 =?us-ascii?Q?HFp9VtFHeJ7g8Y0e9QDyNChGjjhjejvLkyAEgh2szMjGTXys2fwfp1YoK86G?=
 =?us-ascii?Q?tSTbbmcLi6Q6CwSdscc90WyWpl8YfhzVb4XwTgoIVfOFYvF64H3fj+/ZuNDr?=
 =?us-ascii?Q?SL14Il3VcWRilFTjrzsgnuWx9mNGkmPx5vkPAk1lFv0p9na0QNDeUVl3tNik?=
 =?us-ascii?Q?IlQLTZS8II73QNVL7Wl1frxPrYQu+Ac3rj70NixNYMvPNAvvpIMEUL9lHZE+?=
 =?us-ascii?Q?8GjUt18fArHk4noaq/jvtrqRVirzaFybS/tkrxHaA1mf1QzzA/CDpKMeMd47?=
 =?us-ascii?Q?hOw3yUlpFyVYBaUeiWhZFaEBqrrKIjKrSjJBBubl/8i73OjEfy4A9ANT/e1W?=
 =?us-ascii?Q?4SeggVOYGIx7ptYlSLaHjzljo2UnKfa0O+sufDs9MkyJy9KB+rvMruTMEwu5?=
 =?us-ascii?Q?eZlTyWgGUma21oKyY9zCw174KtDI/WjS0cUPxNSfXYvzUjn5stcf9O8tk/ki?=
 =?us-ascii?Q?DlvzfbWYRus65oF/JSpu4VQ9iQa3dfiN2IdnX0pIO7kJensXcONjGdwv8qDq?=
 =?us-ascii?Q?BEgS0uS6gfD7NntL/nBWir6fNPNO3Dwrsv6AyPjdO7/Jdm4BQEPz09xluV7W?=
 =?us-ascii?Q?VIyHU4IRuthfeotuMirwSMi1HzacmzgYGZ9uGy4jJTFkiU7yC5ozIr8EJpFJ?=
 =?us-ascii?Q?3XArBtLqIril7nQbc3efYDMFCyZakal51HWN5YVkQ/0yMO+RD5gl/hG91Ts3?=
 =?us-ascii?Q?doaeSNjS9okN2Kbp0MlLO7bYjKf/5JiFugr7l6QQUNFEWt0MhiyZMntKHgHN?=
 =?us-ascii?Q?9rnnwS/tFqMvxQdQG8cpMnTVV1TovGvIM+gOpI9ZJOT0fM0jl6TM/E8ISYTz?=
 =?us-ascii?Q?Y+1ojBM4Ny7M6pKE3/HJHoL5Wb8snPJZrKUvgnr3gZ5JE+RuwdyrXQPI9xfI?=
 =?us-ascii?Q?gO8lm2ObcB5Ha8NthnYQmyP9Jwbbtd2+FQnWmN9f+CQQAewhLkcM9Sb/2Ng8?=
 =?us-ascii?Q?HXmHKN/7iGNJhwsbVKXMoXfsjEeQwREMOIhZRnM+8/M/hqAeBiDK/e5yFoPU?=
 =?us-ascii?Q?p+pedzJiwyXplFtsrf+dmP+6tsQCn6ATJBOdozuBieeI5rQ//CbBBGoY277c?=
 =?us-ascii?Q?HMi0H4rehfCg7uFlvAhPKp0vEQRZ2vGPgYNJpkbzYSzoTohYL55gDP/uCxuS?=
 =?us-ascii?Q?QABuQlgqertUSoo7/xzRH0sh+FnGRLiC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:12.1245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3950fe58-0c56-48e1-3b73-08dd157c3e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

For MSR systems the EPP value is in the same register as perf targets
and so divding them into two separate MSR writes is wasteful.

In msr_update_perf(), update both EPP and perf values in one write to
MSR_AMD_CPPC_REQ, and cache them if successful.

To accomplish this plumb the EPP value into the update_perf call and modify
all its callers to check the return value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 20de3a9fd992d..8598f50e18b58 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -222,25 +222,36 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 }
 
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			       u32 des_perf, u32 max_perf, bool fast_switch)
+			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
+	u64 value;
+
+	value = READ_ONCE(cpudata->cppc_req_cached);
 	if (fast_switch) {
 		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
 		return 0;
+	} else {
+		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+					READ_ONCE(cpudata->cppc_req_cached));
+		if (ret)
+			return ret;
 	}
 
-	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-			     READ_ONCE(cpudata->cppc_req_cached));
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+	WRITE_ONCE(cpudata->epp_cached, epp);
+
+	return 0;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
 static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
-					  u32 max_perf, bool fast_switch)
+					  u32 max_perf, u32 epp,
+					  bool fast_switch)
 {
 	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-						   max_perf, fast_switch);
+						   max_perf, epp, fast_switch);
 }
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
@@ -459,12 +470,19 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static int shmem_update_perf(struct amd_cpudata *cpudata,
-			     u32 min_perf, u32 des_perf,
-			     u32 max_perf, bool fast_switch)
+static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
 
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		int ret = shmem_set_epp(cpudata, epp);
+
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->epp_cached, epp);
+	}
+
 	perf_ctrls.max_perf = max_perf;
 	perf_ctrls.min_perf = min_perf;
 	perf_ctrls.desired_perf = des_perf;
@@ -545,10 +563,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
-	amd_pstate_update_perf(cpudata, min_perf, des_perf,
-			       max_perf, fast_switch);
+	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
 
 cpufreq_policy_put:
+
 	cpufreq_cpu_put(policy);
 }
 
@@ -1547,6 +1565,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value;
+	u32 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
@@ -1559,23 +1578,19 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, cpudata->min_limit_perf);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		WRITE_ONCE(cpudata->epp_cached, 0);
-	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, cpudata->epp_cached);
-
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
+		epp = 0;
+	else
+		epp = READ_ONCE(cpudata->epp_cached);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
-					  cpudata->epp_cached,
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
 					  cpudata->min_limit_perf,
 					  cpudata->max_limit_perf,
 					  cpudata->boost_state);
 	}
 
-	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
-			       cpudata->max_limit_perf, false);
-
-	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
+	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
+				      cpudata->max_limit_perf, epp, false);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1606,7 +1621,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 {
 	u64 max_perf;
 	int ret;
@@ -1624,17 +1639,19 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 					  max_perf, cpudata->boost_state);
 	}
 
-	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
-	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
+	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	amd_pstate_epp_reenable(cpudata);
+	ret = amd_pstate_epp_reenable(cpudata);
+	if (ret)
+		return ret;
 	cpudata->suspended = false;
 
 	return 0;
@@ -1658,10 +1675,8 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 					  min_perf, min_perf, cpudata->boost_state);
 	}
 
-	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
-	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
-
-	return 0;
+	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
+				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
 }
 
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
-- 
2.43.0


