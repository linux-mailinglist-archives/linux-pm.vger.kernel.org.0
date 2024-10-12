Return-Path: <linux-pm+bounces-15575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69F99B66E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62231F22406
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5DB4F1F2;
	Sat, 12 Oct 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzK6GAR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF517579;
	Sat, 12 Oct 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755158; cv=fail; b=TnW8ANo0RIVikXrzL+Aw+y3kLp2j7y7eR1GrcY1M8VhjMpurQ55XHk/a7aQ5ah5gGnowJP/iJ6uVs2M5K6rcb5E9Dw/YGirCzr+Ms+2+UDRUsfEbdjA4q1MU9NfokAvvf+BcnJKY7FqKY/e0C89siH8gyHCF5BpRkLVQqqm1TSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755158; c=relaxed/simple;
	bh=Rws0x9OTrZrU9iu4g0s3ECprm+SsDyl52nAu2LSxSk8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IIszE7PxRk5qeKH3gWndO+p7zVGkfPAoDbm3sreNtWceJ98K7uosjsgv1O9skl6WxJaN0iOqyDTWEdGAOe5awlnr4Wv4obimLLfbyzHOytC+ac7n1pYThxxFVfTv/xD41VhI1waM9LgVNNoKDEEx5/CAlbqBQLMXNQNboH2RZvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zzK6GAR4; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMDFj6FdwsBaSIeIWuT/3wyE57EbXsR32k103Rj2tyVJnmzfWmznQEjghpm5eC7nh7a2otUf4+6XLeMB+XSeCgAwAnK6u0+Fw5+KZjn3Al9Niib+u1kiWotxrSPxRcPa4UuxCA96/gLzYoDQ6CW+g/j0yO4CBKY2HDAGDqa2nGv1IfO8VVDASNAAPRmHMkl9eUq/nF4jad0QIMUAh4ryHdWNJNbIaSGxh2WzzDAhwBpWeV5LtV7lq61ekA9O9unimnjfc71cz289q6D+7njjdONlkJIs5pDtU7zZFlvvM9dVPjja51/PbY6f83CaOD30TU/Os1XwO/sg2OetdvVltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe8wpd5Ju0riSwsXApkWKKcTYOnpimsaFc+E+fA4Bm0=;
 b=v3xD+exNqWr+fMKS/E7axRqzVaHyIUQ+vOum6ATvMch/T2P70NMzaV7ymwgQY8i/9b8zPhZoJ3hnV+Fg4ZW4KmwPBWPOEVPJJjEfzLUVIR6N4pBlPCavDt7GX9p1kmGU1i7T0UHkMavQAl8XArhkwS55fLzUvxUbNzG8JeE+dA6e0s7jAwCFqWgZbGluZprV+46pbkz5f3w+Qqkr5HmwF+XPnLp9xAMfSIuzMKFbf3FfRN22mVYa5Fi2L3BtWhFcoUgfkfbG+MsKOuCd3F+nz3XbsBdPOoGme/5+RW0uhsBUqn++Pfro167qkboZD0m6+3Teos6C6ftd7epctAxWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe8wpd5Ju0riSwsXApkWKKcTYOnpimsaFc+E+fA4Bm0=;
 b=zzK6GAR40PewZRQ2Hu9FNPylDc2ObTbDrobI2mU9dtmD/DMMuHXQAYxjhmr9s6JALEVmTGZXD+N0UKZRsKUq8IaR4vB0tYrYdsjXL1BFOCsb6mtATV8LRKUuBRLdrakGaOMutJ7cHd7rnhIVNY0M2Ts2yQsKUF/clmard7ylJsY=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 17:45:52 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::2f) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21 via Frontend
 Transport; Sat, 12 Oct 2024 17:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 17:45:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Oct
 2024 12:45:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Peter Jung
	<ptr1337@cachyos.org>
Subject: [PATCH 1/4] cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled
Date: Sat, 12 Oct 2024 12:45:16 -0500
Message-ID: <20241012174519.897-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eed917a-ea3c-4c6b-24d6-08dceae5b732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jYM5FjYOalzUxAaGFQ9GppbB3HQYR5G385mzIHgu7Wj8Q0Ur79AO06mMvhdD?=
 =?us-ascii?Q?RlUVc1xwkq427BkgNC3diQikPDomIdZMxhvIuCJRPdiZlAHtD3YIDa3FarTQ?=
 =?us-ascii?Q?OJg6OIPw8NMLfN3PqVytp5qzlEco6M/ttA18xjBPNLpq8QOSCbQhtbR3S3a6?=
 =?us-ascii?Q?f93FePkDTjxZ2DPsIhwxd9f7kzXufWM7EuY2xn3H7QYHb6YfY+JJdScSo26Q?=
 =?us-ascii?Q?smpkk6kHLWzk7rVjV1ed7STBDIvWMCCkvWTFy3nJCNV5g3n97MLg25pe7Lan?=
 =?us-ascii?Q?PToYLNfB+LEMamqV5EUesz56fx1gf2foCWIiwCuN3LFRiBBagPpW4wtjC3/Q?=
 =?us-ascii?Q?K+tdBH8Oqoo1Miohq22Ko04/zdShQlJrLKMtGzCYb9SQm/QZHy/M52IWyS7S?=
 =?us-ascii?Q?u9dgjHyWxSLkCSmFgMB12wMF/SL5uGHyDcQFVSb6SIbVVgcAaFoQVAHuRGcO?=
 =?us-ascii?Q?pRVIKow8KWysdgpbOM8T8JOh/XFnw0gv1M+uJNxdxkoHBqruNGina1zoakdQ?=
 =?us-ascii?Q?veB79dX19R193bbXf8HtFyWr8fpTglwrgQhJxin4ohUMHkF9ivLCVgHF9tzx?=
 =?us-ascii?Q?itO2BV0/cEdDRq4lrO9Iz7bpMlSpnvJTpv+FLC//FcngP4S+zniDvH14MZFh?=
 =?us-ascii?Q?tUIrJSCZND5lbDMYjH7JM3Au4Lx20dH4xcOqryYmKv8vy2MAS00hThIO+4qs?=
 =?us-ascii?Q?1QqOS4wqyiKFHJx2WjRpYBYzLFU1Yc6PAB1EcY+nSU4Nr7xrOe4bDzjYJbnS?=
 =?us-ascii?Q?GrXlBWOQnxSnsPSI1E7QT7z2HebolTcbqMfYonERWfhk6GDY+6xNBxYasf6W?=
 =?us-ascii?Q?KFhLUvUddavPQMPuO7S90rjG2Xe8qSt+Ci4PP9/5TMd5+gRSYAZvXkfJmwGJ?=
 =?us-ascii?Q?yTykDGcmX3RAEyG8tdx1cfhDDkN920TfGA83RjEsKAgENbjUhKXMBqhdHZrj?=
 =?us-ascii?Q?AMj2T0+8EqxuK7y4fGILI1wU6xk0WER9xVgkl0ficvNqN4y6pJh6IN4OFuVo?=
 =?us-ascii?Q?lijc4J01tcmsomPKKJkfoardD7rn9CHu+zA+67GoVEC7kxaICFKFUZAc6gz3?=
 =?us-ascii?Q?zyViNe4XshkKT+KK2OaONahskl1VtauxUF7oMq4EZtO5NkUDw+g+Hh/S3dWE?=
 =?us-ascii?Q?pyC0ptXe78gns7L+e9bUTer/S2MEPHlMTXujilkAFYlU3mSATVzW48OsPagR?=
 =?us-ascii?Q?kJYZgCX2JWs7AvkeCspbnrcl1HbUzsXm2T34ze7ypYN7E2fhwerTBuXlMyn3?=
 =?us-ascii?Q?+T8q9pe1Q0GtP9DNPTEgusaMUxYor6/LHsjs2xw0FA4fD/+jgHRfwx4OBsEG?=
 =?us-ascii?Q?BMjMn1cJUSFfDpPGfHT7WLqLI2KAJEfC+S5svYWIGzCeUePo8/IYouvevf8D?=
 =?us-ascii?Q?wVJEm7UMK8E7bnELbkXnrQzxoXQG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 17:45:52.0288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eed917a-ea3c-4c6b-24d6-08dceae5b732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

When boost has been disabled the limit for perf should be nominal perf not
the highest perf.  Using the latter to do calculations will lead to
incorrect values that are still above nominal.

Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
Reported-by: Peter Jung <ptr1337@cachyos.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219348
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 30415c30d8b4..dfa9a146769b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -536,11 +536,16 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, lowest_perf;
+	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
-	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+	if (cpudata->boost_supported && !policy->boost_enabled)
+		max_perf = READ_ONCE(cpudata->nominal_perf);
+	else
+		max_perf = READ_ONCE(cpudata->highest_perf);
+
+	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
+	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
 
 	lowest_perf = READ_ONCE(cpudata->lowest_perf);
 	if (min_limit_perf < lowest_perf)
@@ -1506,10 +1511,13 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	u64 value;
 	s16 epp;
 
-	max_perf = READ_ONCE(cpudata->highest_perf);
+	if (cpudata->boost_supported && !policy->boost_enabled)
+		max_perf = READ_ONCE(cpudata->nominal_perf);
+	else
+		max_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
-	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
-	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
+	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
 
 	if (min_limit_perf < min_perf)
 		min_limit_perf = min_perf;
-- 
2.43.0


