Return-Path: <linux-pm+bounces-18854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ADB9E9E68
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D9D282729
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206E1991D8;
	Mon,  9 Dec 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nIDbaPsG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D52196C7C;
	Mon,  9 Dec 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770401; cv=fail; b=ujImfTSgn/tePv4pF7FHyAAJxmD+DbQdrwpyHDl8E5QMir5bgx2rOD4rdgL/AHsVfp2A0Jt+jY1BombKt1O6lJdJlwOsoFnbi51l6brhcOF5k1wqrhlfc2LbNzo61No/YdwZdWAjb9kQJfr2V3/8Am0dqJ8i3BBRwQ/vj8FryPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770401; c=relaxed/simple;
	bh=AwZXjv+db6RTp0lU5VLcJiWHv2AG9kP+T4CZKHiGgRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDwHmY1pFCL3bw9JldXNjjfT1V5RbvY826sw5nNxpN6bpw2xk/FRxLEn59lgoaW2fMrlhJZd4lUKdnJclba8vQ4crao4p0T5mbvlz87BH+2yJdtPvdIY4LQeiq0zDu1hvZnIGFBtr79tpu64etLoBRuY+fXuxaVuNGyuZLRiLWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nIDbaPsG; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZAUTssTvV+gFx6yx/SFSUWPSnCDeyAyc/3MTEwy/e0uSVGiuZT/Ix8NfAK3BMRrtCV6f/AkfaQLT+dhQkO02a8hv8fhGK6J9w3k99xkJLzxWmAm99OthmskZc0QAD9knNMIOSSV0odMo2uqwuntbgPXGIHq2pVBMnA81LrXCNAXWkAJ5IMS/xwSN986VI7GAGIFYlBMwP9UVDTenZK7tCnhZBa/2ke/NGmSfOcVsTncMrNnYa0/1kA1MMa5rFa+/XTWt8vWOMl2VYsJpm0YmkX2b9t3sSXduvKA4E9/8/cPwCaPVmoubmRrnZZY5iLCDcaDoi8GTtxsJFxjnCPtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1Rs8gVhH+rT2+4S+fdyTLEdm4k86DuUXXfVda7IC34=;
 b=k4qunucMwWHr+KcJ4IcaJ5fXGUkZVXCo20U4N6/aRWvR+qobgwBBvtxCKQc0GCm/r+Vp/36C90XOKuqgLzozl0SJtm3YvlD+2PouKEIHOjixBYMnu9nHZUPlEwIy5Ovz3QPMUQFQwjm7QtCghwborC3Eki/xZUptstfJk28z4etaJBwKYsh78Z8XSfsCY6wT2JH3npNGoO4HKrObUlWfHIwA7qznT3jeYMfrWZzqNuE42Ard0kQ7RxCCZWeR0vFo3qzsTc1EW5Ix7XJHCXNTR8ZaIGRK+sefwg8gVUTieR1ap6aoP9FHktKo0N4JyggTNleo9rhZ2OMbRAUqZ/ACaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1Rs8gVhH+rT2+4S+fdyTLEdm4k86DuUXXfVda7IC34=;
 b=nIDbaPsGimZTwv1oGRtSDGPGaAsvR4xvtkPDX8TCQ/rXHiyaoOWvEkjPW0OSlA73EwiRR1gDi5NKmEkLha2/jcO53pdCS9haGHHs6UMRDVpDpyaYOHgV7ehYketI60HhXEQ7DsDJo3bljNJbMBqfRD3RfLs6mKial8HJYwlWMHs=
Received: from CH5PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610:1f0::28)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 18:53:15 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::fc) by CH5PR05CA0018.outlook.office365.com
 (2603:10b6:610:1f0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.11 via Frontend Transport; Mon,
 9 Dec 2024 18:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 10/15] cpufreq/amd-pstate: Move limit updating code
Date: Mon, 9 Dec 2024 12:52:43 -0600
Message-ID: <20241209185248.16301-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: e20f7c69-14d3-4c2d-2af2-08dd1882bd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX7pbdOHck4DZcPpjD2mES6ftIZI1OSIxCad7vB9HxYrOYXnqsp/DQq8Ia7g?=
 =?us-ascii?Q?0/bsFN+5BBTDtFnKKbkozaIY4Hqxspm6YGW2Q5PPtemWN0at1gEoCc36OugN?=
 =?us-ascii?Q?8UN/+x2xby3ifRD8gul5Q2fKd+sijWBjo/tAzmsEW3hlgnNoeKifQ7YgCKYh?=
 =?us-ascii?Q?FbTwq+wlL70F60JxsE4zrj61k2tKhVOXP4KW3HzJ6hhd676Dzbft38QunOyi?=
 =?us-ascii?Q?jTpYoQ7TswrBwPlwuoj9JCnnYr9LowfwfaadzA1iJACUzuZxBsNrhhJghLSw?=
 =?us-ascii?Q?4Kw403DPx/VINc1guAlA/rkuDrUgX9hCPQZLXFK9QlLDqX5xsZKX2Ugcyv+l?=
 =?us-ascii?Q?99EGZ1XnHoS+inSioq7g6pF1d3iv0GR6+WkDzhdLM2CZG53wfVDSk2NteSWe?=
 =?us-ascii?Q?+UsSs600mGadx5lXlsXgOJCxF9vLMXkxsKZLKkx/gDOWw9jFsxgtrGAiM2cb?=
 =?us-ascii?Q?L6+hg8OPXWh1f3WmWLM0yQgzrMQtp+0jNL+OyNQDF9ZWwNmvn7/foqxq8zfJ?=
 =?us-ascii?Q?JCRgjzza1nuIw9PkCu0di2B25MFG2VU73/+SKm7s+aj/jITES4p2UfapRuO3?=
 =?us-ascii?Q?OgSec2TWo9mjDmNJnrjii9B6HDpJbp4u94psWBIrqFLOMiIAxgVzehF+eI/H?=
 =?us-ascii?Q?vvfQ2tlbOhCLGxMpUZ6gXhLw72xaE59acKH4WvJ+wAv0TTeozUkxrqL1E2mP?=
 =?us-ascii?Q?x+7gTMy4MaF8EUUOYU7nPjBv1vvWnWixJCb9VFdTQWkSjyIyiX51eleI1HiS?=
 =?us-ascii?Q?MaqhxXQFOL99sleb/DVJUluiT9tLw7ffonknV5rzX+JU5E3EcFQl2MUmpSpz?=
 =?us-ascii?Q?0X3vvODO2ZH63jCbC3Ieg8iA0cALxfj6N7r9Kl6OTNha6dj4vAEz16qGVlex?=
 =?us-ascii?Q?tSLZ1QiUN7u4Jx+wyFU4s+T3Cj7yeAsb0Hcs2n21vK971BZqtnIM3Md6PDiB?=
 =?us-ascii?Q?0doMlnFbKokGF2JTCmAvZNQrpAxJDl/Iaf5ZD/e0maIuc+VKOiW+GqNQqTuH?=
 =?us-ascii?Q?ijLF/op58ndZ+sP9A1v5POdlTn5ZRhv7QPemicAIHBLg8hET8eW47hPhDXHq?=
 =?us-ascii?Q?TeDgS1jKxW4Qx5iMrQagwWsQ+eX/oACQADdZzOvBgWJAkUMFnYvZGnaJWnT5?=
 =?us-ascii?Q?XA6Cnv6hBVHVpsIGp8xmRLstF3Kkj/MgtCICHWtEwI07PdubRv9aTJSt3FHS?=
 =?us-ascii?Q?gWPlSsT/zp1N91cHWcJle3OtsgRB8lxvOhUINAlM0jQJ8FKFZXOYqKsMRZm3?=
 =?us-ascii?Q?Ln7A60jPK+33MQ1ZuUTmf1Vcn2GQOoA1q5TdC5HogB7MuFUwcespAIGf9MWP?=
 =?us-ascii?Q?eHOaD75FMs3yoSB2DhMgNfj8pY01n/sfM/vyCSvtq2nsx6uUjFB9+6Ef7JVF?=
 =?us-ascii?Q?uXwjRwFCJijH9fDoik9ra4weJEWosyRl92pATXTG2NHSZT2xJCPn+PfehX6Q?=
 =?us-ascii?Q?u6jZhaICPgvr0HFc/irUeXuJGWqVi9z+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:15.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20f7c69-14d3-4c2d-2af2-08dd1882bd49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

The limit updating code in amd_pstate_epp_update_limit() should not
only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
so other callers can benefit as well.

With this move it's not necessary to have clamp_t calls anymore because
the verify callback is called when setting limits.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Drop lowest_perf variable
---
 drivers/cpufreq/amd-pstate.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3a3df67c096d5..dc3c45b6f5103 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
-	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
-	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	max_freq = READ_ONCE(cpudata->max_limit_freq);
@@ -607,7 +603,7 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
+	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
@@ -615,12 +611,8 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
 	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
 
-	lowest_perf = READ_ONCE(cpudata->lowest_perf);
-	if (min_limit_perf < lowest_perf)
-		min_limit_perf = lowest_perf;
-
-	if (max_limit_perf < min_limit_perf)
-		max_limit_perf = min_limit_perf;
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
 
 	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
@@ -1562,28 +1554,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
 	u64 value;
 	s16 epp;
 
-	max_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_perf);
 	amd_pstate_update_min_max_limit(policy);
 
-	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
-	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		min_perf = min(cpudata->nominal_perf, max_perf);
-
 	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
 		   AMD_CPPC_DES_PERF_MASK);
-	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
 	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
-	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
+	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
 
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
-- 
2.43.0


