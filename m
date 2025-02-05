Return-Path: <linux-pm+bounces-21385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD9A2893D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA09162F98
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954322ACF2;
	Wed,  5 Feb 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYNbkx/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325E22A7EF;
	Wed,  5 Feb 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754906; cv=fail; b=GT78jO9ACqdUtgLkBL7hk9uD7belpUJH4K3JO1FuU2WG5awBmLIOYTuGmzuMaGayWnuoFNq+73Hpbcg9bK57cpjKsYHVbZnb1WqS8XfzGMp9FbGgzJYGu7QyDk60xJ9bbh595+uWrCiZ1nP6G6OIxJakk/T6vx7S7vE7iofF8uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754906; c=relaxed/simple;
	bh=BvvhyCXkmkuJlPF+dPWWWSt7tkL+CnyW2RbiOoEGE5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIJkTeIYNFDvluJLdLiLVYGfhr5nkfr0rN2Qhd/CRBwOCL3wy84dLzWH2CrYm2QhbrxQoZd1+G0wqotTqbtr3DK25BkjUrH6y5CjI39dkqhlmnATrswFPyJ94BVZploWv59+PMVzMcZ+Rq68H58E+90HnAs5BLNFV5OrPjB1eqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYNbkx/U; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWtIP7I5kHInDVlYonhMiGuTwoN+suEZPadJyuju65tJMDMDw4wUG1MA6odmi14NAI4Z8HtSyX/O6VyIbANfTXm/ISqDqPShMf5vo+eeIb+VMFPhfZE1sPeupFIFeUQq0uagBPAn0gNdb530crOeVLrda0FbuMy/0RQdhmd187gau5qDVbNw0Swg3m+o1Zctcd9YkwJr9WVPLy9KcHXLGdHzd6nLF9tBE3GI8pkro1E7dKSbvUdF1iL0l1x/HdhOLBXX3kK5p9yswqWGMo+m4gthfEJ6Tvd52omub8r4LMtSj1jGINEgIEVepiO+9ZNHPS7X9d3TZqmN10iRo0ijaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHT3In+gwK3ezqHvinLssQaWhveVYDsByG6mBRVbrGI=;
 b=lb2yJklYENiPBpYjIntu0n8iu/uWV03V48ElD0TmR1Vag0kwrIWbsAw4GkoOgkQWzG2Imsu1loDIgJAj7vEm9WuItcoHw+dIqsq/txiLx0OLcpkhV5IQhF7KjyBB07hIMTBUlsuDQl4doP+gsADh3DKRm8MzHhqWUZdwHD+88iGkXeDh1I9vbwPlR/ctIcJEylW3nmq1D6s2g3K2zHaZa3RgpgYKoHftTtczPZdTExpxQHoLLYS3oW8wW35edeFGkCTlQ2qL2onCDRvkG69P0ZZyl+23eFXe2m1HmA/fqZBKF5hJ4rZQv2RyfEwWpAFxdZCqVy/6tciwmsXN9QTx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHT3In+gwK3ezqHvinLssQaWhveVYDsByG6mBRVbrGI=;
 b=xYNbkx/UXoSe655wiau4LqxqNqY+AL+zVrB6Dt10TrWbcwmefMuSITnkRX1L7In0mNn1Tro+KLj5RKnx+kWHXnzXHAmi6ZCu+Uw3HnSlMdSCn0hxTwWZyJ+YMfMFOwMjYHjtSOhl3/Y9L/f39ha/jMkRo3tHm+J4+lrOV54dgkU=
Received: from BN8PR15CA0001.namprd15.prod.outlook.com (2603:10b6:408:c0::14)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 11:28:22 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::48) by BN8PR15CA0001.outlook.office365.com
 (2603:10b6:408:c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 11:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:28:21 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:28:18 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 10/12] cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
Date: Wed, 5 Feb 2025 11:25:21 +0000
Message-ID: <20250205112523.201101-11-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c603354-15b3-4663-53fd-08dd45d83243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aWzYmXcFps3taeyeaQriXad7Pd97tihDWIU5u6KF1USRR0V4oMMKuGYiqdhL?=
 =?us-ascii?Q?D0tCHD4OYDGjCfB8xWQehF6GMjdouBqP5mzdLLKVuNNkBKGOQhmO9MritYEo?=
 =?us-ascii?Q?kNGEabP8qEPDSv8+dgKDBDnXqiYZvJb6XOe8K+Zfl7xgB6faES5zPb03VBzD?=
 =?us-ascii?Q?IE6MadYj0xqWcEk+mf2I/q+VbrVUBYqeei2u8Lv4XpepyN+RJinU0jDObhUn?=
 =?us-ascii?Q?lCPX/fsZMX0+xokNOfHYgNWGiIf7tvMq8RLbx6SVipGYzPbwDGmo9sQUO/l1?=
 =?us-ascii?Q?z0YE9WAPA1dSOUNLZauhMfWPkkTIsvE0bHgvCVH/bLGQnLNbXCtO/4461yuc?=
 =?us-ascii?Q?f/nFLVYmbUE1yN1PpkTnMg1hHaRD6E2MtQldUgfBrW3p86hXwoutK4zqE2cy?=
 =?us-ascii?Q?gUaPmSpgOy7JfQ2NnF6lJ7KG7dVlYGJeeKjZ+S11y/iFD5fGbNGVWY3e8ywL?=
 =?us-ascii?Q?+5yH2AVlGlhldIKs99waJeruFfT4cVLfSqPlY/LZcddrF/Oo8sY3D70YNmxA?=
 =?us-ascii?Q?j32x1rKMNYuvx86KAU+hSHKZUdVZQyboOnqI4puPR9TuupMD+pi2Ye8SEke2?=
 =?us-ascii?Q?Nhz6nAXrwwd8RiIRG1rXfTyjjz/Q7Xui90aOTyBPO0wuwwm7Fw57/ipirbGc?=
 =?us-ascii?Q?MpuylWnTx0GXu/aZlpI36QFEwDhtBKA8FukHUwdWewVzQfW8aM3xwbJYswf1?=
 =?us-ascii?Q?Avl6fihhwaAfRR4qAd7uAm0bZry1w1Ny5CxUsCUqDY7URcJPv/WpjAlF4Spd?=
 =?us-ascii?Q?OpwDBxTwuYfOd1pLJ1ThI9Dh6nq2C8/6F4yfh5OU+TVlZIHQWoh2JzVlnkhT?=
 =?us-ascii?Q?1RXuLaj6HjaiNA5zR4AnSg1Re1XZbt/L9AWf2uxd2jq2NCsnwntjrFXMeuGj?=
 =?us-ascii?Q?zeWb/1Cwxg0GDoNaGV/Z9mdggWQ9DFPDRSzBD57dpeZQA2pPGxqgBWcrdUNy?=
 =?us-ascii?Q?ZDpyWH6Toe8GZMGamuaHI5u1/59ZjWl03iZD7WZ8to2n+kJjYd3s1/Uv4WmZ?=
 =?us-ascii?Q?OCQ4UNDfDRl3v9xRtTNzl2RweRB5pLdp2hWYj23orl3aRj3G8/ECyBNZ3NSa?=
 =?us-ascii?Q?8Nb4cElEYyML0WtqiiHsSGvJvYXFLhxHWIYn2LMMscPF0guARuOkTJoXZkxv?=
 =?us-ascii?Q?Q1xe3VkYuP6KcnE+4Jon6Y5HTObY+vt9br54BuHWc1PT/I0pSXyEkDCnV8Ga?=
 =?us-ascii?Q?46EDDaBU9M4F9Ftek8mRhyVuNKOI+2l/8BXG5nsPgsce9f7ke4VI42lmaBz6?=
 =?us-ascii?Q?a4OXwfP5S46F+IP5ClI1Q64J12D3070Xq7hpM8n/EDpUH5aApvSvoJmHVZY+?=
 =?us-ascii?Q?cnYhVQiJvSCee6iLewzdeLu+WkdMNSBGwT7kUCZaq/UM+ecUhG5Iey5/nwhy?=
 =?us-ascii?Q?OQrOX52OIVy4AZDz4I1bgQAk2BfVkt3PuFVdDeQzRk7gSDEU3K54k4MYjVci?=
 =?us-ascii?Q?SyTtBs9Vez6/mReMK5Xhya3PP8GgM5Zkrn4N42OVisnQY+DxBb85O2T/QjUw?=
 =?us-ascii?Q?EaACUO1bTxi8vlg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:28:21.4379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c603354-15b3-4663-53fd-08dd45d83243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711

Check if policy is NULL before dereferencing it in amd_pstate_update.

Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9c939be59042..6a604f0797d9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -551,6 +551,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
 	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
+	if (!policy)
+		return;
+
 	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
 
 	policy->cur = perf_to_freq(cpudata, des_perf);
-- 
2.34.1


