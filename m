Return-Path: <linux-pm+bounces-41043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0738D388CC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 22:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6135E300ACAD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 21:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA73090CB;
	Fri, 16 Jan 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1eF+/GTo"
X-Original-To: linux-pm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C12D7DE9;
	Fri, 16 Jan 2026 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768599960; cv=fail; b=oC+Id9kESPbe2lR5NQzd0InTRsrd4e3SRKYpCJkL7KPMwniTDHdQA5XGXpiMMlQ4VrkE4dsRVyKZHPUjXL6QZCzRIHWRt+UEHheue4BA2be0BGacDN6/mO9r18VZsoYdZqxk0QnouCAi85dl9GF3UCUyBgf3RKy4DIR5D+Z4ib0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768599960; c=relaxed/simple;
	bh=7CKtM+qcmg/aOyPjOfsLqQVGyd1Ljfl4/ShdI+QE+hI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bGDYZk1bmt8uFTgaqyavRQwUN/0UKJ44B213ksVkvdnFjUTJ61ogkUuVJfSiWRcFVg45yggsT62wjerrGuMbl9pR7H4hC7wMNf17/Ou696myhj0dQ9cNOBVcHbtEch2IGWSHKrjlHk9tqpkblAzeKezrxFt0nZUf2SRvwpEB2kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1eF+/GTo; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKsGf/VTqInRgZp1XUtb3JIuwF8sXqGNUg5fHyTHuYKpIdJBc6I+sV/I03Jybi7TnDO0QCUBOOEnP4R6J22BbE5rPgXsJj0t6H6ASduMmegQm+vQF8NignXGciWAdZM1+n038aVrU+2c01uwedBM9VBL89O7UCOimfN4zBzXWAgmJDmphyljxqxbKeF6UFolsK157QAYrqZ9SBhrTj0RAHn5iOGIJtpVU9WxKpyUvK0qWqaEse5JShhfovebNAQjycOfoEnyofgF3jr0fGrrp5QgcuEvcHd8cNoLbe8yEW8rMeLKKib6Sljx65tYdP0Q/T3/iWS03k/wDE4OFx+jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2nLixL5av2BhUEhiBW3s8VMS5GAg3rfym2igcvq99A=;
 b=T7f5p/COnoNTLkCkUC5Ucqypf/7dPSSy04Xa8dgt/qxFhMmixOGIHmrtLNJ76JMBIYyA90lp1LutkLIeVFGkLs7WW60+VuQZSghGRmnBx7SYokNKV0zP/arUA0zXDhs7i47z63IMUs9eCMcNn+YCJj98CeVwVd3hYc4oq57RbY+8h5es5RmbNp9TrF+A3FSQ5PnArvHY4AXc1ZJwf3lq767jK219yya4hhUO5hlCpK7mVlUwAe6x432Kwf0niDvkonUepX27qwvwbvDeUm5sHdYaMoHm5EBWkcW3B5JMXORo1ZCmwQxe1l7a+M0BmPPlLKYeXRKn5pyv55m9iXqRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2nLixL5av2BhUEhiBW3s8VMS5GAg3rfym2igcvq99A=;
 b=1eF+/GToIOm5p13angYOxTEDgN2UIKkTl3SrgjYFCUrUtZZjgrPJsHina284hVzET5125kfq5umppL0mjmclTwQO9t7XyR/uZJV70K9LFuLnf50mamWQyyu5Pg+3wKfnSs9vth3sIUX+L1XXCSse2Ru9wyfhYWRsM7hPJ5vrqaY=
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 21:45:47 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::9c) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 21:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 21:45:47 +0000
Received: from AUSJUANMART02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 15:45:46 -0600
From: Juan Martinez <juan.martinez@amd.com>
To: <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <Perry.Yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <Juan.Martinez@amd.com>, <Kaushik.ReddyS@amd.com>,
	Juan Martinez <juan.martinez@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Add comment explaining nominal_perf usage for performance policy
Date: Fri, 16 Jan 2026 15:45:39 -0600
Message-ID: <20260116214539.8139-1-juan.martinez@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: c96e6e37-9827-4b2a-fdd4-08de55489be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F1uHi5cIYLGyu+W7i0BWf4yjrRx8c+6EJLe31lVLwSS/J63b2adXIomVqiOf?=
 =?us-ascii?Q?Tzv1c2Q4f5ceFlyNNaubBcFJd/l0MzS9k7M3zNgFS37hduDecXhvVkkaLl40?=
 =?us-ascii?Q?NZmloYwhlOr0sFlOVmp0xzEzdnvqtlRnzYjpFzJAPwu/VLNuHuMlhkJxdEkr?=
 =?us-ascii?Q?LstnRCsbeUa2j+tJfWUzrg62G3qkKcpIyys6sFUcEP+AwfHa8Rl7XeI0moik?=
 =?us-ascii?Q?hIuOodLQXLB94YILxA+A5EyC0MsINwuj9UTFR7/QaR45LpkBabZpa0IgPprZ?=
 =?us-ascii?Q?Eq5XlKFjzaQtyNcT31nJaI7eGE0LmXYdQGeH0Yr8ldHXEi1wt14l3S/woOya?=
 =?us-ascii?Q?TKBitH1wQLxstlyiMQsf1l+Ie2WfURlTUJu/W7hDSWdetObx7lBgC4GJ26nP?=
 =?us-ascii?Q?IMFu7LiHWejVmjtCbxU7MP9rlKDWXH6E/vX+PlpYtemPoPJI52RZPp0hJ5eP?=
 =?us-ascii?Q?2p59MS1mHlSNR1AD4CX9OdsKLYlefzcEL9YgW2bkvoV45byHQGeNu5DaoyIy?=
 =?us-ascii?Q?1NWnBns7AIh8K0lAnA8SUS5/L0GZfcLkS/qeIUbq54n2Db3j0UwF7B0X9O82?=
 =?us-ascii?Q?glnIAvtJ3lyzlrImaATVnaDsCpebJncInuLxNDjKUs6cbqQ0MK3RD4tA6Jlm?=
 =?us-ascii?Q?7SUhMItBLqLOFjsuvlqQjWyqAeEZxPcQ7l6f4yqMTCbYtMLjwP0lTBKDctHU?=
 =?us-ascii?Q?AtnJX813lQkIZngnKAcL6i5cabj0gJZ9Pr5atfDSZQj6izjHzRmbiEr8eI1M?=
 =?us-ascii?Q?hbtv+wjyS6x1POSWeTQXB7U3RADt8KDMEZGyWapOHJoV58K3RvoYFpfjM/Kl?=
 =?us-ascii?Q?r7zfkL8TQhyD9vnoxw9x9Fhxx4x2BSKR+B9iHY2kobhF28p7MXTFdGqP2LGt?=
 =?us-ascii?Q?A7gusB2T3edIztnXWQFF1z5kpVfvj6fPxoLn3jJBscyADfQ7wqTMyYaShwWf?=
 =?us-ascii?Q?KwkvjDAeCHY3js8mtkK300hKDqEB3oYaLRQ9bOBxdeS5p7JXd6u4NE5c23VH?=
 =?us-ascii?Q?mUD8mf/OV3RtACVlENLpRcdd1/Z/uMxp1LZbZGNNHUZkpzaIUpOMYaBMqUGc?=
 =?us-ascii?Q?WJwSLeYuC8QDWlztuBENIljAXlGeP06N5QLeEp+20+uFcyScLtK2k8KZ9cvy?=
 =?us-ascii?Q?bDSN/s94tyg+7ZS+JorlqcfaY21FnoDN6sjEs+tMZx5Oh8f26aeytKdz4FAu?=
 =?us-ascii?Q?wK/BsDqazyeAzqGSgpuu8xorpHJ8oNCqFSw+K0yy5bJ2PDHiL6HSsf6Ff6XS?=
 =?us-ascii?Q?Q+uOxRjJlB+ollRJEtKQAJeDmBsQL/JMiPkR7ZLl+gMc9XhQMASbrXpuuffQ?=
 =?us-ascii?Q?RAK8Cdd69fh/9qDYnR5qF/2jYq7jzSqx1QGrsbnSUORe0QSQFNcxlPsUyMiM?=
 =?us-ascii?Q?HfuQdAcB7IWROIW8wtFVCu10sQU5fdj1HxeuHl+OqOYoXhVtsFmOW2XXKfMq?=
 =?us-ascii?Q?nuL/9GOpS6z6kRHJbfpPd7tY2mH+TZawB07PJv/eiXUzKZKI+kLZwQnNu8m/?=
 =?us-ascii?Q?B9F+0bkpyX3q+e6ZNm+TbPWqwhxa7lRbDGb7ky62ECCsDwltkP7902Q7V7/M?=
 =?us-ascii?Q?l3vAYdF9JB1xhvfj/mSxnqEQ1KpkxyGqcgBbfs3ra9MEe+LTkLAGvJw7xPvk?=
 =?us-ascii?Q?kq6FT5RfayM5+AzD5Navh5zlDrZqKrJsTGzg6QQYz5iTCSFP/Y85YOifd4YW?=
 =?us-ascii?Q?jok4Eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 21:45:47.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96e6e37-9827-4b2a-fdd4-08de55489be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8

Add comment explaining why nominal_perf is used for MinPerf when the
CPU frequency policy is set to CPUFREQ_POLICY_PERFORMANCE, rather than
using highest_perf or lowest_nonlinear_perf.

Signed-off-by: Juan Martinez <juan.martinez@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c45bc98721d2..88b26f36937b5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -636,6 +636,19 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		/*
+		 * For performance policy, set MinPerf to nominal_perf rather than
+		 * highest_perf or lowest_nonlinear_perf.
+		 *
+		 * Per commit 0c411b39e4f4c, using highest_perf was observed
+		 * to cause frequency throttling on power-limited platforms, leading to
+		 * performance regressions. Using lowest_nonlinear_perf would limit
+		 * performance too much for HPC workloads requiring high frequency
+		 * operation and minimal wakeup latency from idle states.
+		 *
+		 * nominal_perf therefore provides a balance by avoiding throttling
+		 * while still maintaining enough performance for HPC workloads.
+		 */
 		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
 		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
 	} else {

