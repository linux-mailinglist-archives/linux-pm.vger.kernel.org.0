Return-Path: <linux-pm+bounces-7525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BCC8BCBD9
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD34280D62
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F1142E93;
	Mon,  6 May 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TQJ+YOb5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F8142E64;
	Mon,  6 May 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990835; cv=fail; b=SNfDuv5m1ujQBnQtQdsPxbg3bZAU4NpBYmiQw7bHwXUBfClupA22RKNIN0xlA1dwNIMDWm9QC/zJthDehtYuHm6M4QtQmc6LUfse0S2Vt2+x2LOpRFXnyz63BwMbJd7r9Rl55XcqXkBJRg8TavMZhybzer2ogJXo4pKVU8kzrAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990835; c=relaxed/simple;
	bh=aj+jVm5Y66yLkhCotmOflseLcnj7xeRrxtuzD4R8NmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mG7zCT9qylW+NDFkXos2lypzi4Ieg31ybBW9FXpsYdGaHBTkRQIZR1Bf6R0OvbBPfR+nqKuiGkNNx4/Jc9MDRJjquFgRtlSbrpgcPwqmFMZauyqQnX4lBWvVGLp1H4qppo5KuqXAfi/jEXaMuNf+W5EudKIt+fmaYHmzBs1QRXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TQJ+YOb5; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXc0pVxdQaH9lxNPeR8DBJdbsPSoPQCglfUn8Nj7KVMXgImv/ttYi/DILrxc+P8VSNaR3BGQuadHZLA1WuTWBB0ARy6sK4pzUSIX32c4gj5FgE82cFYp+w9T37ndFtGp7Nt75duQV8tAvd/p1osNvfL03RbYpn5tjDLRl3aOjHKHU7aMdWmc+qo67923TzKs7YaTdKKxxSi3aIlW3cBafAP6m+9TtYWtgP8Jumss37cB45foxsK5jia9l79PBrbPQqvXYuRgGOs8JMBAXxDnce2OTCgeBjWPoFuzkdTrUsbXpmrwu/gPthcszzlzq2831wsM2YzWGArFvmju3aDKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2+kQZEikSpTsYjgg4K9mRMLS7fHH+01BY367aQ2EI0=;
 b=NXB2ZLZwPmewGjYaN/il63gYYl+Qfx2ns5ntxuuF0dKJusq5A+mMtHStfsYBBSyof/HGbP3Wq1kKZSrjGIVLgYutF5V7wb3ALTlZvJ8pDJra2ZuFGVuVXhKvI+6bZCYilUlgeoAA++Rvkj8wPYW+q5Xv8sHw+0RHGpOD0BSKYOkZFc66TXT3xXg6rfVFL3asn3WYYRTHvthCloNqERld8fcKrfoq4RNGcaYQ+8OLD4JMK6se/0iCwpsFY76Fr7Q64fYf2YnyE8Bvf9vTTPtq0yeJTOA0RghVNhqAMG64yCw4+sKVP4s3aYgIiHkVP8VM/lmzM4APN7s088D+U+3Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2+kQZEikSpTsYjgg4K9mRMLS7fHH+01BY367aQ2EI0=;
 b=TQJ+YOb5mFxQi2NRkU1LgxYmTEROKYjxFXrOVNgjsXpZEjOt9KGhoqX+6yJGBQyArMYgYDRyFLvuGpEIwM055L9DNFXdbVNsOtW+OT3QuEa271edecvRkuUF7k265/5KMIpSyYjwg00xJj/b6T7SSs42Pk/fXEHfsajYWynIBDc=
Received: from BN8PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:60::27)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:20:29 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::32) by BN8PR12CA0014.outlook.office365.com
 (2603:10b6:408:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 10:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:29 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:25 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/7] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Mon, 6 May 2024 18:19:56 +0800
Message-ID: <08f1feb0ca38d603b8eef54b2e4db3a1cf35f272.1714989803.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714989803.git.perry.yuan@amd.com>
References: <cover.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e98250e-e68e-4168-a00a-08dc6db62760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j0Zhl3OG4MslFXZq0bCxdRN+FpQqFwkHXPv75klpcbfiiIArvoNCr4a9dkRD?=
 =?us-ascii?Q?NCUfXYxMCmsXNNx82alqSDj8nI2YA0nG+yPrjx2plhQQeIkB1Hv7SASr9hcA?=
 =?us-ascii?Q?GT2kOj9MpmfjKSUXB4Q1p41g4cdYFqNMXp+vvp6zL7+b3XsqJngssqSIzMR4?=
 =?us-ascii?Q?+wccqjmwLwCF3a53CqDTnO2fwrXvNgnuvvNBy9GdKblIfeFUtQGaHO+yaQuH?=
 =?us-ascii?Q?rBcHtch/eTYDtw+e3Mq2zb2wlCosvsqvVnZQP7qFKRXwD0j6LzcpnBwkzVPO?=
 =?us-ascii?Q?s6c0rkXVbaAN2VvjpoOqprCN/SL4I2xLbCEYcvjDXHFsdrYstsay3YX43X7g?=
 =?us-ascii?Q?l++N4UEl0wrk4zhNY8bU5Vo/0mxrmrBE1vWBP5EdXkDe9P8dm3JH5na0V6qb?=
 =?us-ascii?Q?EmcMz2PlSj1QwyR+90eMAvGSEOhRxUHMFpkLILFuuzHw/C911iuUDCIKsJsR?=
 =?us-ascii?Q?c4XniK9110d6zTrsT8vxMfo2tcZpaXThgMHyfXQL2BRWAq1VI67qzzdpMwtu?=
 =?us-ascii?Q?ZJ7enYbivfd6EA3EjJcv3rsu92ne0jH6I7t1XVoamvsvyShaE4cKlAEydX1t?=
 =?us-ascii?Q?0lKhzdlWWGdgTAKGu2m43hoPkK5u/VGtKPR8WD/eBXF5ofb9oL640Pr4oKiC?=
 =?us-ascii?Q?bG61YVX7JHQNLC0mNGAdbPtvHNrLuw+GCRSxSaozcoRowB5qkl8RB6p0CL6R?=
 =?us-ascii?Q?v5rAX+NoY4a3kuUmu14fNWj29MLK7T9x6IFX/dLOu1QFlnC9ONSTJrV3AFjG?=
 =?us-ascii?Q?pCpOJqN4hkbDrIsUo1FforuHbtsnQueJJdW5GnBrSA0oRkpJC9SYHQK9y5YS?=
 =?us-ascii?Q?Pvrx1HQDWGGfgmFO7BdkADHfxSgAMY7CiauACbeM233buRaKobIzpnGaonIE?=
 =?us-ascii?Q?RfwkiR4zXuz30nj6eLOwbgVoroUU3YobiIaj4G9nRi9aXes/9PGaq3mhZJhm?=
 =?us-ascii?Q?+H7hK6UjJ1v+uoaIbHffVyX1R9fhCFg8V3bwFgcIzxX4pKtER2X1DgzRdxII?=
 =?us-ascii?Q?oH9AVhizp7o4XGWZAh8pdjgYAG/EomQv3E9kSAffmHmyOuRX/ToVxkv+Ne58?=
 =?us-ascii?Q?LbZUhayDCIT3eqZPZjrHuXESBE4ZODkQU3SpjcwQCi06oswVI00xUkU2UbpM?=
 =?us-ascii?Q?BSe5pg/vperHp/m+7Rc6Lc79tkFaTuHnQNhnUfVfKdPe8ACuQ5vQ5yJAMIKK?=
 =?us-ascii?Q?XcFMO333GIpej5owHqP9ZSBmo5tO3lNCLQRY1n4/VF+rOqWw8KaaRPjIUYvr?=
 =?us-ascii?Q?MCBbixWDuClItRgGVJET6/Q+zqwpGTkx2EfifkF/XBrVwHVNCd/p0vxh69l7?=
 =?us-ascii?Q?0aTyo2e+9F9JIxpnQ1pFrzbPebc6Rmxx6WyhRs0fF6tURUCiWw1K0Xj4Zs7a?=
 =?us-ascii?Q?D0pDtJXvf1sDu5SgSctbmKk/LzVV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:29.1418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e98250e-e68e-4168-a00a-08dc6db62760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here it needs to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f81fd61dd2a9..11bce2c1db32 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,6 +476,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -495,6 +496,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


