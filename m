Return-Path: <linux-pm+bounces-16297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB49AC7D8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC358287DE2
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC8E1A256F;
	Wed, 23 Oct 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e/zmVWRo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA31A08C1;
	Wed, 23 Oct 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679094; cv=fail; b=Ct9NWBWZwy2ffSH1290BXbI0J2FCxtOC6uPxU7K8KRHNsiLD140/pkxDl7Ynx1cL+gHprX5lN69DdHsXTSth3jkt5AGstfhVeVuJn+jwfCfTbWGMNChrr6C3g0L6ltLYnHlgXBfG1rrXc5KVw/ezJpRmxX0sVuPhNFdDxIiyXpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679094; c=relaxed/simple;
	bh=0JEo+b6HvpQASt1eV5HQ2SQgB++eN8MQS8Kf6uPAF5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syte50X1yGYewy0WXypGbmgwOksOAkNRrqatlO9pcvfrPwsYCj81656g6qbxHZr5AgSuEAg8B3TOqwTb1cc4NMs3IOWvf7MEfq4aHHiG5D20w6nCi6zkDGI4G7ss39tiddyhDBNaK1xNNleAz49Rz8OaoQXCeOrpOAlKJtKSPO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e/zmVWRo; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMPFOY8IsswaeOvtbrUN+mom4vzGVtjJ7l9L0huOFJw2y2s6BYpE9KYs3lbdLHSlBQPXYy5QkSi7AXqbsMz5pSbpuVim1+hNYIeoChyco75LVNBmkSMYJmEBw7V0CEuD2Gs9Q6AvvJFMhCtvHokrwzsVFIlQRJZefkWnAOOxILqsBBiNK7lg5u3TBi02HPO6boAebnw2f0eMuCkOSGefUSXdKTbgpqsV3QhKPeq+Bq1VDJwnK5rR+0dal4vp5LuV8qgR/CjUesbr7e8lpbHFa6QJcCRjlod5fxI/GLHpBw6UzJHA1GGM6KEZYs7y0XxQBz3QipoqpLEcEa9mHSRvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilGe5cgFINQ/DZExJT5cwZs35VhO0PfRj2woeEncUUQ=;
 b=sYOSfbhsTTESpFO1bFxmvfnx/wq0+dBCK/aKKVFpMAyPkehcVjsVll1aum9MA7+jBkxOyqx5TviGDlycJJcl5AHmVnwr9N8Oa4smJZJFeizeXma/fWdTIpLoBndJGSM5Uw+XpQU7AAVji+YBWUB+/+8pLT98kzVSgrseokD675EARyRU7R7cVfIZ6UUQQ9pDMAbvdDbtRDOijE1jEGfA/rsxAtXa1YppldG4L0E5w4bOxJsIGYt4okJSQoNRYpZeUnPlPVjmoikvByT0GIRVOYa03knA+XyVfZ4KPGTEBg6ysRv2Wr959HBarzKM19d4Ng4cqmJ5P3a8ONQqVJwfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilGe5cgFINQ/DZExJT5cwZs35VhO0PfRj2woeEncUUQ=;
 b=e/zmVWRowLd4vR5sMFipXgYGOSVXPTKJXPM5vE1kXP2IMrsg3s15SWP43EsYJCc63NfTupxAESmf4X7SPYWED22xhglmIcsRbKq6/H+uY07DQa3+XTwy1BNMVhyRWic9jgocxqoUKsSRN8e2FCyurx0y9BZmKirmT6DFNx2RoKs=
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 10:24:49 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::a) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 10:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:24:49 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:24:46 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 4/4] cpufreq/amd-pstate: Align offline flow of shared memory and MSR based systems
Date: Wed, 23 Oct 2024 10:21:12 +0000
Message-ID: <20241023102108.5980-5-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 550af205-4ea9-45fa-c0ca-08dcf34cecaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVskrTNQyQ4rWqu1hQZuCLeNk2cVB+V9Ic533TBcYKZPjkxYQ2Xkqv4+E286?=
 =?us-ascii?Q?0AF8xZ3IF9p/cySSXYMYQ5YQRmjgTBafLM2t8WT6oUiCZ9sJi7hV16R8IcJp?=
 =?us-ascii?Q?7H3if9JFMvj5v0bsycGtXUmefRI+7CGj841fwzo2ZuBhmix6/2XP3KlTwV7g?=
 =?us-ascii?Q?gsHt6USi1sT/w7pqT5+PblAhVIH0LXWUEECy87WTwW2cCYJexzU7YDgpvV4B?=
 =?us-ascii?Q?u8QkcwvFh2wFqjXq/B3f+XzkDjTpUkA5Z3OMtZlMapydkpSF0Xyr5fvMr523?=
 =?us-ascii?Q?AYg/2h7MLnXge6Bg8l5hezIuOLxZ1PAsZybuhBxUtx0IKR6MLuOrCpGfYnki?=
 =?us-ascii?Q?ZxLOuvEDYiuuhTLHScYDhQqoy7rktcx/9AwGhrCyVPhtZZpfd0EhyZRbiOeO?=
 =?us-ascii?Q?8Yp42ABcpBsD94kcm1/WUGh97NkAmJv39/g+sQV2oHg85G6We4cKR4bXrrRW?=
 =?us-ascii?Q?8Nf/+xWsb9XvrPhvJ3lvlEfkH2+gyjARONME2FsmKfjyMYjUrwBx4hl8Z/Pv?=
 =?us-ascii?Q?4D1xpjkuqla6sVx3Go6uwYhw/dQPZtcvveeRzHEePLl80payUo+n8kNcW9wW?=
 =?us-ascii?Q?24gPJf4XOX5aGK+oboi1l9xbxg59w4lth7n6LBCxMlJ3+zY8L3RQ7OFxmoKD?=
 =?us-ascii?Q?olBWTtfeHRcFYgd+vbgXRGh9U19tPqYhLlJdJei/3iU/Uwt9xE6lAOjK8XGQ?=
 =?us-ascii?Q?65uTI4HV+hULzm6LyR+vemwsg1qJ/svW13AmCTdRkWSuV9TI93GuGpMJ1lUp?=
 =?us-ascii?Q?TRfZvkD1yyuXOCly69zwVXZL7Xp1Iflaj68JjZcab2atgMVF5xKkjEiiwtcm?=
 =?us-ascii?Q?FWrHDdOPPMR/WbNAQMv64w9xLLqOT8U3o9imi9kQVw9syBNZeZBn3wsPeWI9?=
 =?us-ascii?Q?YZWopk+vUAZVaRRu1vqAcIgc4va0VuodPdEF77zQ06p2hL1JQ+KyX6wVr3MP?=
 =?us-ascii?Q?xt6gDlrkdu0dkbByE3/JzryIzLvd1CegHyyDomDIja8m37wfPfmVbkXtOC1i?=
 =?us-ascii?Q?vPMvCa1yBTZVKfOrfrsPSnB6ggSNY7MxRq1oMJAjUKs/BZp0oo5Q8VilUbNA?=
 =?us-ascii?Q?vvh9UnWAI8a9B8+3M+5DvXex0tdZ1uLtDl/MoqThtnaGm+sWGVqYK6M0XdE0?=
 =?us-ascii?Q?p4gTZZxf6NB4NzMqc6gngAsih85zUnZG8N+VtcuYNLkScS1QkU/yqMY5y3Iz?=
 =?us-ascii?Q?T38O4O4AFpq60/6IXr8ROupFAjIG3eC7Hc0l9QTdCbwZX/dVPBhFXTi3TTZV?=
 =?us-ascii?Q?WUsrhnAZ1nnddewr2H+v5wGb93Wc/pqCtl67AOh2xcpgRJSXz0Q964c1UzjN?=
 =?us-ascii?Q?/+M1vzVQ9qbeBmZW5WUqTsNTaEf1Cdub33PnGYMFfilWj6bPtZ7lFV6UIRKr?=
 =?us-ascii?Q?wgzD/apJsAQY71RjUyf/+bseWWiZC0aIofFkQPvEpAbfU95dYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:24:49.2820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550af205-4ea9-45fa-c0ca-08dcf34cecaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

Set min_perf to lowest_perf for shared memory systems, similar to the MSR
based systems.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bbeddce90823..206725219d8c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1658,6 +1658,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.desired_perf = 0;
+		perf_ctrls.min_perf = min_perf;
 		perf_ctrls.max_perf = min_perf;
 		cppc_set_perf(cpudata->cpu, &perf_ctrls);
 		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
-- 
2.34.1


