Return-Path: <linux-pm+bounces-18852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE69E9E65
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CBC1887AFB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862BD198A17;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w36bWWlM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D91925AC;
	Mon,  9 Dec 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770400; cv=fail; b=cu/NbTUwphUpGwJIr5jltDfy4JfCWKqrQ+gdqKJw9Ki7wkP9XUZl/O+T1q5+ELw9kKwZzp4btWTWzo5UrJAlgFR4GawKtjatRwcXDqt7v03m/5SaS7JW2yjjiHVijWVXYs5qFIj/SH5H/TzMpbYhlLwHyW8JZ3Qft0ADokFYXAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770400; c=relaxed/simple;
	bh=1hJEV4TDhoGWDNUVBi1hBVjXPxwh22hJPz7IsiVQiEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7U5Jk0ItQcQrhvyhmQ14p1Iv2BgK7SlPw1BLsFR5rpe7mFTQAkl14pqvh5DrhzgbYRq7Lm5K44p1GxwMf9dvOHioCom9BiPA54MAcRph2Xa8upbTXewFWi+KEZcurRYe8831VmSC/spOBgKNnoXP/xzSbDu/HYqvBDAu81kwoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w36bWWlM; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAU5r+dbkj+MAjmh/83vmP3oKdhb5MKjaK6hLDg9XUQFSknhfhOoiaejEodH5vuHwQl0ZrR+BxHVgz+Gu87PH+SnhZdmBXJT5gJYo+t1Uh7AUuswFUQ7t/7FdHDiwETVSGkrCHhepmy3/pvAlI+Q/QG3+YYKTyDVVgupV2LSZCJPzJfmVngTfS2FzZgoQrwIuHw4I1qQ7GN+Vos7bGaYMde0x+oBHcKEZx4ayUQW3hL9yPB7d3hbRQc4t4m0UeOO2LISZqbfa5gZTSGX/5/fdHvXA5UdQ/T1nVtEAQPVnAXOWnM/MUgJAh19NfT+1Hf5tYzDpOzgSHfIa46NWbQoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucqe8HPLacp3VkKxDehsSMBwOsryPZmCHnwY2O0VS3Q=;
 b=RSI+yqAdj0yYTyZt6VKcQ8qEv8EtkZeCqsNns7hYq8/C2HgUpxO9TBjH5TaW1zCYmIozlg5yWoKqctbkTDBBbkaPXd3ZEDHitaicBxcoUbvTs8LvFHUVqHkD/0ul/P6HEkPqScDL36qtbhwlHRQyUE/xfJ9bh12T8EVCNxneYCP2zypBGsyzjG9hAOwc6jiFHrJDpi7LeVabGQOplnniWsIztu+S3kxgKefVyZRRiClG4/2DpOMU6JrnL+dW1AjW2vY5ZM8HNt/oUwO6+fr+dqVB6pnZyRVQ03Is7eLQ3DqV3nIPCVmjUZzq6UzNIzbpaz+fzLe3kk0ZN128AVHK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucqe8HPLacp3VkKxDehsSMBwOsryPZmCHnwY2O0VS3Q=;
 b=w36bWWlMVo98i+83kChrFMDc/BDNTUoGXZZt3njfIYLzDoMGHACxnPLHwL5XSlTpA5zcMmQFcanSTBSsQb52Pu6Rpl2oiXXfYdlQzAduCclKEeWznY+ArfQ4UhnJvHf4SQzECyvzGWPhVuPKtJhzkz0eRGq/7sGicdg7o17iT7U=
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:53:13 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::55) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:10 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 02/15] cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies
Date: Mon, 9 Dec 2024 12:52:35 -0600
Message-ID: <20241209185248.16301-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0e1ab3-491c-4861-6450-08dd1882bbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adSuj5qgR1obDd1DUedaC28FxhxB8rmM7W9VqJ8Ufe/CevUAXQMfvoXuKoLe?=
 =?us-ascii?Q?1gEgneGz8ymYl9cUBpuMuzUMAM9LyRTm5NXeYhyca/OO32XJXqYD77A7lJaq?=
 =?us-ascii?Q?1aq9FRssbBAQ9Cy+gd4D4TB+NnS2BPgneO2rWgXNK+sGXVa4q4xFR3gIwapU?=
 =?us-ascii?Q?ArTkcqL5G0WwQ+Rmm44ngjTsafY24tALaqUXtOfKEtByroGepaRCmtRxknm4?=
 =?us-ascii?Q?l3dolYtK8SsxawqGNOB0ZOHzUOigFWgNzTn/Yjbzlusp3MWVY4+L0OU2xXgA?=
 =?us-ascii?Q?SROCI3eT2GL/+CdNf/eH8Cs0al4b3BEuvt5+MqDjy9Hjjsus1tvklJ2IYkou?=
 =?us-ascii?Q?SS4LRbyag4UleHpbbuR/SI08qF/+FpfPoNxkG41h0mEJnt9dZwvgh++GMf8y?=
 =?us-ascii?Q?BHEKnQ+LEmpzqgxnk0a2QG4AhobBYpbixQqiWi0f6PK8rQ8w4dSyDCxMb7BJ?=
 =?us-ascii?Q?kH2PKRNJsfAvbkjg1iY0KjkcG0DAOY7l4VmFID9K14qEoPDSoNypmmOhZBQb?=
 =?us-ascii?Q?6pvj5o7Mk47StxtkoS7hz+E7DYwz39Yo9hwV/lCmpwhoEEtoP9hX+Onyrpeg?=
 =?us-ascii?Q?qu8Pc+6s2pJ1y1QnolAcKC4RsQAao5PMWku2OyzCKzFPkDee63np93zFrKx/?=
 =?us-ascii?Q?uCF8FHbEmybUwpxLONpW1hVSP14N4Vk8HDq1+ktQ4dvR0JL0zFbOYclkVZhU?=
 =?us-ascii?Q?UuTeF4zg+MeVhAaQ2PrHo8Zw/8v2xHs+EZi03mXfSwghZOD1nomk3SMytDQe?=
 =?us-ascii?Q?PMNerCuZqOFX7u3l2VeC4mdhftI/LL9dyZP6yP+ZuPJv93Q1oDnPRzFfs0Ir?=
 =?us-ascii?Q?rc5msjwCHpmVu2Dt09uuz5rNZoDIj1NT1lN2VWlERKs9UfT9Ksv9BDI9SJ35?=
 =?us-ascii?Q?hBMsqNgunvKZfeHTV/EHu1hvYwubolJylejHwCej2sdRAeeqUEqt8AZYb81a?=
 =?us-ascii?Q?0X4vaFl6Obu3sp1QYO3T6mZrUecw6JnL72BkP5BO0h0+ZAAMhe2U/HF2ScQW?=
 =?us-ascii?Q?3Cd5ThuOvXK1Cl8A3s+/WotRNH5Bm7tLMoGHfwRaRvddZu9q9Gv0alA5oB1Y?=
 =?us-ascii?Q?BNisG7J9lQmCBSZF0NN06j24n6jZuqFny1fVnY1nucXd8nLHU0AyL9eHilOY?=
 =?us-ascii?Q?aF2w+EpY8uD3fjCrJgA7vyfIv1y1C7tbNz9RABNtgiZaYFJcZFyRS+Wnnj+j?=
 =?us-ascii?Q?E7VQ77IjLes4EVE+f0vYV7yaeEwx1be68IrI+now2IKzyLR3jwDLlAEQu57E?=
 =?us-ascii?Q?LucagROrdG47q1QK6HPrZGTzeRwUNwgFgyDBBVF5Lv3TEEjEl0FOnDSGNAdp?=
 =?us-ascii?Q?5QOCbck8cuYwwRL5D6spIquv8KYBN4oGZ0p263y7g7eE2VKTmy2VLki5jkUv?=
 =?us-ascii?Q?enXx3F/mCkWGPdZc+Dom8r7C8dh/6+glxBTAgdJU9NTEFrDycN2X/sjpJtlX?=
 =?us-ascii?Q?kc9Ox078ORt8ZGJt6+h1LKCTOGE0v9QD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:13.0263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0e1ab3-491c-4861-6450-08dd1882bbbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

commit 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits
when boost is disabled") introduced different semantics for min/max limits
based upon whether the user turned off boost from sysfs.

This however is not necessary when the highest perf value is the boost
numerator.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Fixes: 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c51026fe636a9..5e0edb65de32a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -593,16 +593,13 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
+	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	if (cpudata->boost_supported && !policy->boost_enabled)
-		max_perf = READ_ONCE(cpudata->nominal_perf);
-	else
-		max_perf = READ_ONCE(cpudata->highest_perf);
-
-	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
-	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+	max_freq = READ_ONCE(cpudata->max_freq);
+	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
+	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
 
 	lowest_perf = READ_ONCE(cpudata->lowest_perf);
 	if (min_limit_perf < lowest_perf)
-- 
2.43.0


