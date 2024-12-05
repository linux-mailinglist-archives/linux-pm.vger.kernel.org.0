Return-Path: <linux-pm+bounces-18651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79289E6091
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9E1884844
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F361DDC33;
	Thu,  5 Dec 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gatPYLn1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79D1D5AA0;
	Thu,  5 Dec 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437754; cv=fail; b=I2TucJrZoSFDTFUUbuIkp0UoPwY+2iSDwsWh1EgMmOETUD4OXf8OI1eJlSWJtMsn263tEsMT5fBbe991OMULP86X2q+MlsQzYTGsRyKF6q5VpcCbom5CScXR9jeNMj4GdTPNIo3akuak9glrWbWcAqBjqM5L8ucXIBPTUXbmIa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437754; c=relaxed/simple;
	bh=EQLshVMaycjeUNdIqlK420hfCQtukgEMCunu8u2J1to=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBLPT0XFhW4C3/8OFnhQOn4NXsjRgz6DyPIRDm+LA5TAV22Z57VJhe4TrhKg9aQib2RG1OMDx+btwcC0AlQDmZo8Am3bjOlAHskjWMJL9jT8tMybh4kfcNEGf4GhGyeGH15mlv/xGdwi9Fh7MaNNgIWcmT2PSEj7FRmGNTmlJWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gatPYLn1; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYkucAALEVsI+xbbt1UNYnkmSFy+0K/CS5k6KwAkBpw4FEf/ThzSEt29gbN2S2qfKwXIYCbldFBCOMwEOv2MwamHYKvo+7zBTQvyWFS8H8+3qOLIX9anBmD8GAqcODHEHWnR/qE+JPB7oAUEhY07BxRZEBRGVQGjCS+n/1K48WtuA0S7BOl6Ylkcyd0uQ/chKSDv+y5L8nM54YXaDIS5EHliEc9pbFSWMJmghWV0VVsNPacvtDsEk4NMyALwkW9VDWHBUbu3w9a30unzp1RtchbfMtdQDEbmimuiO+2X8IRWJXuQGjm2m8/I9eIaDyuTIITXHl4YwvdJD+xrJQlbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCqscFL6iUHHRyLiU8OMhbG3Zjdd6/wZV2DAPHGPnLI=;
 b=PqfzoYMu1/L7qQLsPDyaf/LZcEhrmHIbtS6THMDlzaOGr2gQD0ni6YEfX9hqU+s35JXJpneIwwpWX7y/6GNoLAiiIagHfugNLcDwRxWVgTXZiORA1vgEdQoV6a/l0xROzW9kjJge/Dp4JeuLk7zYN7PZsGj+7pzKNBGkOt6ZDv/5hDN/5hOxSxukEYYtf07i4PPDWdugtcqM1LqNo//QqpD2kuDJQBJtY0DjHM1SfI77colWjNLKMflAKrHISkjrZMnLOCjoi503q/0iA/jJjp2F3HncWFo8lWz+DE993pp6VldrpByCK1ViMvmpHW4WA1088En05CCEntEfxzXbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCqscFL6iUHHRyLiU8OMhbG3Zjdd6/wZV2DAPHGPnLI=;
 b=gatPYLn1hM7u3DsX6VO7BSA+F8o8FRp9ViRsEvG92uGHLCitRSUvlx0VphMYsfCvC/NLMmBYeGRQq9Z84pWeZ1of+aF06qkxCAW3zgDcBrLLsB8eMBD6oKZF9XZWqoLLYypGM/U58Nyl0HVFt6sX2IISY3NOU+7SMJfmq1awjak=
Received: from CH0PR03CA0221.namprd03.prod.outlook.com (2603:10b6:610:e7::16)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 22:29:09 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::64) by CH0PR03CA0221.outlook.office365.com
 (2603:10b6:610:e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:04 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 07/15] cpufreq/amd-pstate: Only update the cached value in msr_set_epp() on success
Date: Thu, 5 Dec 2024 16:28:39 -0600
Message-ID: <20241205222847.7889-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: af32b759-4cfa-4926-3ca1-08dd157c3c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6TNHE7GSgPOmKx4bIG0NX8OLAvnXLr9ftkWqGuvgPauJ3ciLxXEqhMb6jjiN?=
 =?us-ascii?Q?+V/1Abz/fVR6Dpcx/+p++081J7bQdQRK46icFMQ/RMaY79JFFpK9JxdyKICf?=
 =?us-ascii?Q?r+N4XAHJJuGue4Q/TWONFYQ0gtaGR/7TzUJxFJzxvC3iTZQT+nNxzi/8BU+4?=
 =?us-ascii?Q?SXSwnI+g3uEs6OXo+a1kgvlGxN+TlYPKLGuyWVOsOsoTnVHkCVkq6G+pTQ++?=
 =?us-ascii?Q?TPeKyuMHJQSLIuXGiXwMB7YpCofMWU4O8/GnOt5gsk6LWHPvoURRvm5ageCw?=
 =?us-ascii?Q?pZBNuV4+oMKvsvNBkJl5pMiBgRbNJEQixBJTHySE7RAJW+kQ/4Jc/wTFXT/Q?=
 =?us-ascii?Q?KZSMP1tzKbARkSq2tOhtpaiFGeHdOoymWsS44bzo3XZbt0fOd9JTSFd6Sh8m?=
 =?us-ascii?Q?u8uOBx58u/fhhRSnfg/mccPWmEDR43a7COPZIWVGyG8FCVjhLmcuSSgxfvwi?=
 =?us-ascii?Q?uodYkSccUK1ykxuAa5mSuoJ0nBja3TVZXITsvMcFW78U3pysXIPqyZol71T9?=
 =?us-ascii?Q?Q9mxwYtOTDF+U1pRAVPoxW5hId9Bzl59FwqBcHuYV50kq9RW1h7kyW9c2FB4?=
 =?us-ascii?Q?MFC4QK4oiS1unhFFC6reOiYaTyb6yiJtkd7hv8NmQcLuj1AeLnd7U+Dv5kq+?=
 =?us-ascii?Q?gskLMhN80c0O73gHS8VU1DtAZtbn1adwrOHLbv3P10qocypMB3TbuALtjnE3?=
 =?us-ascii?Q?2XhjlHuWois7vWivG3U5dcqPUVffzX6Gs50GXKCR7TlFp9gMy5tXxF070y6K?=
 =?us-ascii?Q?B96ddOwK8ec1TuusjSKcn6lMXGIcwgkzUYAiU+42wkIpw17+0Sn+jAEw5lzY?=
 =?us-ascii?Q?OABYmmAx2galj4z6dS5cvFfJMlc9cWi8pwtGJCG6G3pJlkZU9t8EGwWIMfbm?=
 =?us-ascii?Q?OAcWtotYLhQfEB8acPO2yBWcNWjikCRIzfQO23IMerap7AmrS0ntfqWYCuYp?=
 =?us-ascii?Q?FCUC/aBKk/eTe3MTxWqlzNpILT/oIzEIArYhNbZ1zQvYAoPRbnMkfsJl/FBo?=
 =?us-ascii?Q?e0Qu38ZHMJ0EMq3vHXHrrormy0lEdRHSjWmgs7H3FlEg484xtRbsMtR8TlH1?=
 =?us-ascii?Q?nQA7cKR/1x2xJ1Gg671+6u3wIh+fDrF738OihSc5lUREOhf9AhGAANECQPY/?=
 =?us-ascii?Q?sHJjyvpzmmjvTyi6te6dA4oDjPr6QzsB3YNXFtAiEPGomfTZ+PlI81Lt4gMR?=
 =?us-ascii?Q?0FSp9/Zrg++slozOQQf/YmFC7a9NTzhn1QtsL1S+4iCinV04rfV5nZPqufWF?=
 =?us-ascii?Q?tb5HG1fzTMgDf8XvbunRh3YzGPs0dY8RzYQGhXgZuK2ZNaTEf0fzHKgy3Ukt?=
 =?us-ascii?Q?pXTJ+jGcsrftsSSEpX/z2TDHnGQhYA+5c5o8GM4GgKb1wIB9P5kUzSIVFSv+?=
 =?us-ascii?Q?OVY9fiRan70h3MpK+7i/5diJzHKTmrLeG0IX+Eb8fCl6Zgas287y4jVs4Lh/?=
 =?us-ascii?Q?3hoJ78+KNNeSJt0M6d3Stys/AklMqb2y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:09.1558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af32b759-4cfa-4926-3ca1-08dd157c3c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

If writing the MSR MSR_AMD_CPPC_REQ fails then the cached value in the
amd_cpudata structure should not be updated.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 14bd6faa3d730..ce70d1bfa55d0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -278,11 +278,15 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 
 	value &= ~AMD_PSTATE_EPP_PERF_MASK;
 	value |= FIELD_PREP(AMD_PSTATE_EPP_PERF_MASK, epp);
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	if (!ret)
-		cpudata->epp_cached = epp;
+	if (ret) {
+		pr_err("failed to set energy perf value (%d)\n", ret);
+		return ret;
+	}
+
+	cpudata->epp_cached = epp;
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
 	return ret;
 }
-- 
2.43.0


