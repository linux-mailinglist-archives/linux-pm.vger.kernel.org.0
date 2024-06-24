Return-Path: <linux-pm+bounces-9920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953A915918
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224FB1F2441A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE91A0AE9;
	Mon, 24 Jun 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ssAzoVOZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576DD1A0AEC
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264867; cv=fail; b=tXGGNTOay+UGtFSAkkK/6VIPu57Jb6L127x8AaXKMhYv9M1ZFV1hmysBpfpA/tBb9EKUh1y+NOfQ0p5Ufb3ArTOeIsXpxakr6H4bDitdR5etf8LEUFD9VV6JBSTehULiGoLUBkJ8fOmcmcWBqsYv91HtRnOV5763tdfn+nFvUMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264867; c=relaxed/simple;
	bh=psv1xb56pjNACleoFZjR1T053nYSiewV3QNZuySrHRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua6xiqXnMlbdUHXCRbbyIF5IsiOQ0Ua7zsixiLEAxVX/iRGG141Eb+NLw8C/0EWoOp5iLtDQqUjs1HGXZQKm6LoEVSaOhjc6yGveNwjILvruaFBR4izv3qALgA0bqRA9MURmMjhftHG54Eh6ri13y+pAwZBVLSnM80e6z5sZ1g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ssAzoVOZ; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/IV0pOvkPLRcVHVl/7DMc7pwsi6wLpeBiWwKbj6uhfswOzD6pX7vSjLaeDnFJ7Wn9+Pp8HRjufOJJKJIW2Y9sC0oho1jmuN/E4EAz4EmboG5WAagTYlV2blMEpmJ4JOwX4iMXxbjBMa3VVOtJYiQVwwV1Gd1li9e1yJz213E0OlpZB1mxg1e2W296ugh2572ZETgKGwJtIJdNCQOcfJj8HfzCaX5B3/KMd3APZr2nzNLiAVUFtf7NrSK8c2ERvKYe+xFaITfQyt5a/voz6iDWTdlnD06teDMDqwMUivHJLD6IksVXr0ecYivLAadu74GaS1NMW3DSIRbD5RzMFQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzA+KLXWOcCdtnAQMcEpQ2WXtyLRkgpFa6hv7QhNRe0=;
 b=YwGDahuBovGKLRZXJzzBmEH6kb1iJNa6LUO0Ccxa52aei5U5fZp3g7+sfAElARE1cjrLLtCqrjeV4vXq39zLpOEb68AgdVQhLkURrg7ED2ZxfhkcKiZUchPeGco0SZiK1CuW9YM3fg4vi63J7iz8pxw5+u4HblkIpdo5LNJjrYZq28RK9PUI+SkxlQ9lfqqUILmNJLrNy0lzyhPYFooD0D45lmcvgU0r/jR38g0dvMohf8XTouEhMZMRUF7McCQjShBhOd9fYKKyZhNMHzQw2v70Jg3fVPVHVV9wiU3HDwcHQMZhDe36LbzoYS/LvwXQ0oBdzP7H8wc/qkHfviT2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzA+KLXWOcCdtnAQMcEpQ2WXtyLRkgpFa6hv7QhNRe0=;
 b=ssAzoVOZVbVLqiOJM4F9aqrvug+LZzLlhnmgPPCmX7EJabANKyXl6nQ1Fkl4yU7+eD4wuP6KzjaubWAM47M3+lOWdsvdrWVU0txbGJjpFGorG4xLqg7XBS/mRLepSmaBPskQ97r1PTFMc1/j+CCrQPJY5ipjyugh92cc2pX+2ek=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Mon, 24 Jun
 2024 21:34:21 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::c3) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:34:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:34:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>,
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14 3/5] cpufreq: amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is off
Date: Mon, 24 Jun 2024 16:33:58 -0500
Message-ID: <20240624213400.67773-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624213400.67773-1-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7cd158-d994-4e68-3c11-08dc949568bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B4a1SPZE15Ebj+NZWOlCajc4gabH+iViYX9E6+1m+b8bf8WDN3CWExVbVDka?=
 =?us-ascii?Q?OoTcWNlhNVRMfXUXBVbugfvpAVDmjwMuR2X3hS69i4WwKnBLu5GCo4Wdwvgb?=
 =?us-ascii?Q?KB98rXdDXVvcgTKBbuXAlEMd+Xvq0iOVEoBf/TWyT0iej2tZUubI+ipPxSnW?=
 =?us-ascii?Q?S0YaA73UIAWIPDdwG/ucgPxKhuzdfQvOTO1JOQBoVpGNrkSWiup9eE4fjSnq?=
 =?us-ascii?Q?dkvGX92Bhm5GPD3ITOPRTXDz5K7jDMer6hTnp5X9IRK/A2fTVkEmuuLfxhOv?=
 =?us-ascii?Q?gRaHw9Me0UUHTqnmojxQpJLxge8ioi8jclBRV+wp34hQ4FYJxM0utf+bjy49?=
 =?us-ascii?Q?9Sr1PJxdazLQuUlKVxSWygbdRpZrkTQYTJkrrDe3tEkNBwUlitThESV4kIi1?=
 =?us-ascii?Q?9RKN+LaQb1horXltZIIrZSoJd1QsGijjq5YZEKRmdvYoEKyuMrfZ3c/XEPih?=
 =?us-ascii?Q?2UhLsJyYCv4E3psrCdRxDe+Y1IQ+lurAR5BJ36PTv5kKQCT0kx/exdsZkdkl?=
 =?us-ascii?Q?lZ9SMAU8lnC7UFkagM3U+lzGb/oSP+yWE1kYfCmG7SgPGVFwRpKjzBL5QClJ?=
 =?us-ascii?Q?VHT45AX29qU5Jv8nxgA+HOcyJhDZ/C8XhaTwIZAXtpyCve8pU3tSCILBgkPe?=
 =?us-ascii?Q?74Obf6v66ouzQVJHW7XLXNE4iOAENj+z8dlLG4V0oFXxlVx456y6Euez3l4t?=
 =?us-ascii?Q?RJ+sYkvjVUz7WBToce49632/SsGKLNCjYuoHUCHTvA4UJDmT2xTO72MFYd25?=
 =?us-ascii?Q?89E8AwlKjnEy6NhYjpX2dyK5bz26s0gGUtfzoINnTWLFpeVfP/viF+KxGap2?=
 =?us-ascii?Q?b26nzZ4ZJRkK74d0HGsv4z2+UlaerVGHVNKpM2AulGSnxTURsMX8ISOc6TOw?=
 =?us-ascii?Q?TBK4xHtqE8jvZzii7Y1MYeRJY+3//gjAn8M3/oFYhs0SrQyrK7bdgYuJWCOc?=
 =?us-ascii?Q?pajC3cFk+7pCDLHJRJ7ns4DxAGVHL/kPKO53tP/Q+MOaKcFxz8yQI+6WdIeu?=
 =?us-ascii?Q?TYsTu/jtROCDT6aG/eHjamTD7RTLwx3Pe2avu6jUnHPZ9SMhEQWe//4QJqkw?=
 =?us-ascii?Q?zCI+8yrLLuKRighWn3zfoGhZtQjRQyZ/Ik0E+ykfZD6N7WVopHZmEKRd72wQ?=
 =?us-ascii?Q?v7CEx/KWmtlQhhATBd/i2MdDBlhEbcmYUvQJ3Mtd4jiazU6DcHUFpQGtKhc+?=
 =?us-ascii?Q?3tpyDb5NBMusTqDYLr3XGN/2b2auH1s4JcPwqbTceakpkumQxVfnuH3Ga97F?=
 =?us-ascii?Q?qGW8AubjQJHBKsxQbHIewc5pbIM1apc9ibI1d/PeTSIbulmda7QMgTb/vVSp?=
 =?us-ascii?Q?do44KsnuSGfc6kt1z2wQ2L5uGD9XfaepZa6TkzxOLwXe5LwQveLNC7fYZRMQ?=
 =?us-ascii?Q?CwWgQZg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:34:20.6787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7cd158-d994-4e68-3c11-08dc949568bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

From: Perry Yuan <Perry.Yuan@amd.com>

When Core Performance Boost is disabled by the user, the
CPPC_REQ.max_perf should not exceed the nominal_perf since by definition
the frequencies between nominal_perf and the highest_perf are in the
boost range. Fix this in amd_pstate_update()

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Link: https://lore.kernel.org/r/66f55232be01092c423f0523f68b82b80c293943.1718988436.git.perry.yuan@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 10cce7023208..6992f6169919 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -514,6 +514,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -536,6 +537,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!cpudata->boost_supported)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.43.0


