Return-Path: <linux-pm+bounces-18550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A04E9E3D8D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 16:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00538B3EA04
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606820C031;
	Wed,  4 Dec 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ppwUK5D"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5B20C016;
	Wed,  4 Dec 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323802; cv=fail; b=U4ZWFAXzx+2we8ZmjMjBDNjVpW84o2cRnoBun9dZ5yue4WZBIYrM2s4yPvUCMajYhqLRmKd40cZec0JoqCrdZVg+MymFyQo2brUeSRigGuClkyTyKQ5DC8vUllhVi9Eavo6Sf//+PgdE+N8eFJXlL4GipwP+HkZL7IDaugdWD48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323802; c=relaxed/simple;
	bh=a7dm4YUq3nNQ0u9LVyA2tFX099cqxEyq5H9ddizcdeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFAmqFe25V+vRRHTKXKmz3U6DJ39vYH2iQIXTMp5wi6ZJ0WJNiRnUrbk1zKfn6JoRAT9GXr6uOeQz/1BThaDMoxgbRBDT7cjQGZe4geo9Tu6zmdoSwnEKGDDKZEN2629TbpRRG7vktf51MIf/oqj9L2gJU6vfEF5b2xHREIQaqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ppwUK5D; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqDDLM/fDibDo1Q+YpVtFfBdDoSh2aWcJZkoLcfFkWaFLzjgQR6zmEYS9ntwtvKnsgTVovwg2Vn7SHWIS+CvWYV62BMn+OJLuB/xBK7f4G+dQt+MQ2fuQWMHGKnR5p4mPJGnNR7J4z533dEGVY5mtJJPptN8SFBrldYg89Bpt9cDn39x2+0GAi3cx35dIIfnPNEjhNOGuh0vozg3F5RpvdA0yxARxf8NyMs87p1w9shafj7T5IxRXgwxMyEH96dC4Wo+nvUQhN6w4GJil7V9c+os8GHDHchMj336H0So1W3ymq4Stt+bf2dYBiiInPxZQqs4P7RT8f4K5yqQ4tYcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82wORTNPxN1Rv3PCtL+sh3L2Ph/kRjlqIdLO4Orbm6I=;
 b=pXLpshXoU2v5yMBUK5DsAxqZj5Ca4m5RhunOr0ylUm3cDMzSjYUMvqR3rPAzPfAKD6lJYJ3X6fs47TuezRvfEJy+26KEdTb7lMu/igI8fJgSSn8JX73titiwbMAdqi2WjwZgZfDYTCWc6ea0Qy35OAl324BQN5kTrRyj98ZYjze6ioOskyBLpau98VjxuRtvjiAXfvydx+mTrm7FLYJQ7JIbidRXjJxbVMuy6ezYWod+7Xb5LdkigWqE+FreRqBcVHBXXbOyqZc0B62AFU0H/HMe4R7yPflv0tfkzIvxsyIYoQNaLrEyLgfFcB43bf3t9hpWRQbiNau44E0+Ny566A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82wORTNPxN1Rv3PCtL+sh3L2Ph/kRjlqIdLO4Orbm6I=;
 b=0ppwUK5DAazBt3OwAWnagVI2JzwBUmnb3KyvCtBrCs0c3IPWQlzRLnjnVbkRjX+5heLZJMwhWc80uw0OHwy5RvO/FfvxVrQp9Aq02Th2DrmsxkhOvO456uEZ4WlGs2KYDHSYGc6PX/INN60SsyBcN/QddN6ASl9R2Xyx703hKoA=
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 14:49:57 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::a0) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 14:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 14:49:56 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 08:49:53 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 2/5] cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
Date: Wed, 4 Dec 2024 14:48:39 +0000
Message-ID: <20241204144842.164178-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dfe545-a86e-4a83-a703-08dd1472eb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCeP06T1BsSEjUbwx/8G94jiyhIeqS9WVBWRHGdrYGo88VePqt5KvMtgHeuW?=
 =?us-ascii?Q?UXvfSAXFJlvlks68zjXqfsCZNJBAz7+Ql4vmsvzCPu2byu53LZxcIQHzuMdJ?=
 =?us-ascii?Q?ONTa7m6YXFDrKnZcrEONHC5/FZaQ0PaQLALUTATFORdQJYWHCrQmiCOghNoB?=
 =?us-ascii?Q?Qisjyf0ltDNS8mCXTenhDTNK+hROTDTdP1dQW3uSmbMaNG8L5XUYz34T0JH9?=
 =?us-ascii?Q?4Cw2E1NsZOwGoslDdpiEud1IZaTTeyJTBsbBRm9dOZEgo/AQbnvrMqpFQS9q?=
 =?us-ascii?Q?g889abPrjR6fGw2wYkhUe4D3ZBhMUSsaQUhQQSeA/T7XyGjKAFbwTHYQOFDC?=
 =?us-ascii?Q?0qY9ixTClUPeUp64XSdSYUBO1WTrq0DVyqVmwxv8szI1Usldtyef/1oxaC5c?=
 =?us-ascii?Q?IWth9X9aaPIZhIaErgHmS0bNjy3yilG7sfu3i8/clDM3ao6Ra0mUx800CmGw?=
 =?us-ascii?Q?jAEEsdRLhntYoddf7JDNLSUu5bFmRVO3Q6UQeghoIg3Sv+OSLYIykoTw0wrj?=
 =?us-ascii?Q?H+02ZJlpHH3agiHCoGsrTDmkzgFNM/007uVhJcZna7frQQhIYSOZFV2/A7vN?=
 =?us-ascii?Q?kysHERVzR/VKTGU4c4oPrrOq8FaNJd5/TsFVQakOjxcPys9EN9JY83Y1yWmZ?=
 =?us-ascii?Q?7SGytcUeTLg50UqifMHBmu5gXYa4C+gJsiaka6YlVdhyhBe3tuS7HSmRc0U2?=
 =?us-ascii?Q?yM75gi8HB8CDRXraOwRmDvQO6Mw8bpiGHX+xmUGx9cV01AAUhoDywXEdcMa6?=
 =?us-ascii?Q?B9gwe7NyLFx/QPHGy5FJYkEPinEBf79v0WT+8fIFwfF9fohfRGgcC5fMuvCH?=
 =?us-ascii?Q?xpYWV2VLPkDnXznCJCqMy9HPNij6lxHL8HO29/14qV38ACTKO9QQp/UB841L?=
 =?us-ascii?Q?Z4RcxiBdTD0mWywPXAPuPbeLvdwgvSQe4Z33HDY44zAgP/zspzFiiymP52rh?=
 =?us-ascii?Q?e3TQlP/9lNBrLxv5ISXLjqf8R1i4kgZhw+xtUbxKVRqpjN/vMPuku6rjMEch?=
 =?us-ascii?Q?+lWpSSPtQx7xWDMypZSGoeyVg/ykv2AXzpUHbGD1tPtMaxND+t9KPtNaVFBt?=
 =?us-ascii?Q?bDdFlIXz6d2/TVV/i5tT185+g3TGgFcdnzohAPQEQGV34fT0Ul6Q8ZwBZtDe?=
 =?us-ascii?Q?Nl7sFzteCV+dDoNK4O02dOpHt58yYhyu1Ftmyd4GQLGt8u19MTPlSAdaHK7s?=
 =?us-ascii?Q?+z4dsj9QduughSralhQ/4KhLw5FOSzRyYjM+EkVKcd33Ja764PXuJTjjyMoD?=
 =?us-ascii?Q?6RDkJ9EHmrIXM6aiUFQNgDQIUyCN1DjqBujMy6q1sDMd7RBcbLvpcR+ENKE2?=
 =?us-ascii?Q?C9YHGnosYyoeQ+t2k/+i2JLqwj3xcK7/+co0xXxTroyTidZgHWnVIAIRdNrh?=
 =?us-ascii?Q?0XHSronvw9g8g6JdjXvH9PedkN+P9AP3MFfNh3lOuLQ2btpEq/8eena8/Pts?=
 =?us-ascii?Q?I2VNu+dRHYWAKdHDEXCGbkg4pSazc0BE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:49:56.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dfe545-a86e-4a83-a703-08dd1472eb7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702

amd_pstate_update_perf() should not be a part of shmem_set_epp() function,
so move it to the amd_pstate_epp_update_limit() function, where it is needed.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d391e8cafeca..a1b2393cef22 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -296,9 +296,6 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
-				     cpudata->max_limit_perf, false);
-
 	perf_ctrls.energy_perf = epp;
 	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
 	if (ret) {
@@ -1598,6 +1595,10 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = 0;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
+			       cpudata->max_limit_perf, false);
+
 	return amd_pstate_set_epp(cpudata, epp);
 }
 
-- 
2.34.1


