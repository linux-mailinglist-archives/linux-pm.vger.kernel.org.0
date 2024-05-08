Return-Path: <linux-pm+bounces-7631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466438BF6F2
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D82FB22DA9
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA43A8EF;
	Wed,  8 May 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jg8N0pf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2373D0B3;
	Wed,  8 May 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152907; cv=fail; b=e4usKxFWscaRdUMVxbd0zSoBJwHztRzzVQYQzkDdDyMEB3xGecVXt5Iu5pX3kfjAwDNpzvJcPfupvthQd6hFHKIiL5sp/nvJYiF0KSkJK4YpWvYeZdQZS7LHsO0XxlvCeHDCDsFdLdto/gHFSohcWUprO7T9JLPgYWwAFbSB0r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152907; c=relaxed/simple;
	bh=aj+jVm5Y66yLkhCotmOflseLcnj7xeRrxtuzD4R8NmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZZb/tLNaObb1+lwz5McH6QgaAxkmF1mzMu1253pJzbP4v/H0MqS+24y7bcqJC5NjMezILYjTzElE8xjPjFxckafZwTL7qG4PzgRDGKk8Yys53QZ+8mE9o82/LdRyOpwy2aTNItULZzgd14y1IoJecFIDteF2qJPEZjFTBc7Xao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jg8N0pf; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2j9+Fy2SjdbQRYzvy3cIKJt4ureOUMe+RcWS3c+iaGBmpCN5ireG67yrI0JjQUIJW9KXEN1QHrtJZrWTwXaJBgIJxTIKk86aG1VrfpmKiiVABilniwUeknVHp3RRD3C8NSVky9wAYQ44Gg+VvANyzSEv2fb0CG3Nzi/mDZfhXQJwHI1NIFi76+98eyeImwh2mphr2+Lhh7LvyfR003W8ON7qE9uiEZNUax1oZS9mB0eunZDVNStVBHeqmfEYUKJfNZCue/IPng/YQx+PEUxlwIdzOJ0JdhBNRFNind7kXlxDNMu7KrjDXo1SseZkf+WkVeAH8AmHAZyWU2WNYLfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2+kQZEikSpTsYjgg4K9mRMLS7fHH+01BY367aQ2EI0=;
 b=iux3W/HJcCMrNCmpaxDOq05rjmk8qzDH6gyNW32flbfPykTCqve0BjMMvjDYuiQIjzEmR3C4X+1DSI8Zevr2/NeBi+JkXhHvE3+gGIGX+DxiNGr9RV8NU8eA4S+cx54KFG4Y6Ot4XqfKjgPAwbpFVqpwO9bwiV2aMc+yu5cMf8faFitj+Zwd6Vv11vQ16/QudZWwjd3AvccmsqPzCTuOlgo3fhtmTEKqyvmy9G6IZUtmTIafZca/lKCwEXkLfhtOkF8c0rLtqNF7HAER6GUlnOKdYKGnEOJZD6HLZTDb5TF8LGyLm3eUW7f3hLl56hNHXNP0tSaGjCKQbaCPHtP0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2+kQZEikSpTsYjgg4K9mRMLS7fHH+01BY367aQ2EI0=;
 b=5jg8N0pfnXLZ7E06OwWuBcvQMVs1gomZWUz3o66n3ohHzlyn2owatT51P4BqhrAId6wxH1g3SIhkbhwwaWBT+UBFPDnE4UV4QhQxFHCWk8VkJwzh6CDb8ru882LTN5hlTOdmvlatAhSdoq8+sWZofEJBPNnYhAr8ouAzVEi7vb8=
Received: from BL0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:2d::42)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 07:21:42 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::b0) by BL0PR03CA0029.outlook.office365.com
 (2603:10b6:208:2d::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 07:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:39 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 4/7] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Wed, 8 May 2024 15:21:09 +0800
Message-ID: <0422737dd49ea6cd6644d8f20f46245682add4a4.1715152592.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f7657d-40cd-4106-8500-08dc6f2f82b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLyWYngsF+g8XIJezRYgY/nzt+ASoJuhGrlPHuiTtObPQDiy0XUbcey0qW1i?=
 =?us-ascii?Q?TTs55INoZZGHAHaU8V4l4rME5d7MokWTYHQu0NZUcqx663d+hZuQFN6pihPP?=
 =?us-ascii?Q?402ID9FLKHhNiGOiHfUknbzoqBxlsi4+2TR2DrPY9S/yudzC8vE2dPAZs7eW?=
 =?us-ascii?Q?YZ+4ptwVWUq6tJ1pzTOfM39QrV4etV1eE6nOTIbqloth3NHwTgL8z1HEKG2w?=
 =?us-ascii?Q?UDCv9WOSAJ6QssGahTzHH+7Mn2w3V1nuX1jrNxW3E7TVflDkpx2dUbgHP//a?=
 =?us-ascii?Q?S27JAWfuHmU9E09eNj/Rog4w6fLGXeO0f/BcgrODH8Mf45tbNvugm53Hpf2N?=
 =?us-ascii?Q?Q3Vt/vmvzDVwMTFQXZX9s7C2RjIf9nGLUQdwuIOO4Hq1wgE7YNZ64YzC00kv?=
 =?us-ascii?Q?Oxb8zpNFJORRwKZ3naLPohsSPsNykgl3Ee7XeWuosCHTeNdPUPQOAEgnw7bX?=
 =?us-ascii?Q?etp+JKHs0o3N/OTlxkB21Lyro/rgRl3gC5WeOP/URExJ5rAHw1mBxaac7CSB?=
 =?us-ascii?Q?Q3dFfcEAkfhLPCN1qqwwLWK24yQeq7rYS+++EjBo3GEzrW/FBQp/q+Y+8BVm?=
 =?us-ascii?Q?p/VKvt1SJmgnOVnUeM+Yym9taX4VCOxYSMG/tFR0hUjNHmGqFS7Ah0AGAPRh?=
 =?us-ascii?Q?Y6gMfO0xxXPHhJQuzBug9HORQXuHLS3rkiOplaiZiEkvWzyCs8WqvCoTfDsm?=
 =?us-ascii?Q?x2z4f+1WEWk4CMd7tE9ZvmGfsUq2aVxTvn84WhAIlY28qbbAlpYT6gnJjrsj?=
 =?us-ascii?Q?iiNnFHJaykCKekWcNZc16dgYEgpyKbpMifugQ+E4oKIKuN35aBsNJJLopm5U?=
 =?us-ascii?Q?+KNsXp3fSYXNU2GFcOr3rnXbbKiX1UR+hQuBOkPxMgycdcgvQVdH7m09lotp?=
 =?us-ascii?Q?eMktS8dlKlMH5RBEVb1EgKnCkAj1Dp599a8m+TpYWvSyuKLYEZ0ZA7C2215P?=
 =?us-ascii?Q?KIZf4X5G0QH9WfLsSeyO2dzE/mXW4Wk3Byn0J/XqABzAurT4j+Y2APsVhxbw?=
 =?us-ascii?Q?Nn28i0i+z7NkUOMScnE1fvzZXX8Yz0/X7ENIHkx3mZov7cSZCDjcQWRrhTXr?=
 =?us-ascii?Q?JhQHYFBD3b3tlrwOSoKHnCP1he4tf1hDcjGO5LBwe0Vy6GFQr0eGEWUlFbNh?=
 =?us-ascii?Q?PAKkJ7eWZ4/R45oQf2+pWu1bb4dl+XeKB7ZIUOU2tMeUk0tcINphK1THptzI?=
 =?us-ascii?Q?GOIq7ZD07yAgTnCcp3MFr2nI8zuG0xJFNwP4ODpxQp2qxkWPWDwJiXkx9cuj?=
 =?us-ascii?Q?+YOk3kpsu6TlcaBLlQ9CTBAfW2DoHEKRpQG+OzvOT8xE2NvJow0pEC2o2XF1?=
 =?us-ascii?Q?hexaodPZFDgmamEq/4QKf9w8g/wjiOHQH6tXsLLRDqPkT3rqoIjK0VPUk4p6?=
 =?us-ascii?Q?NjtMVP4iNdu0nUhnskIuCtTx3RMi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:42.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f7657d-40cd-4106-8500-08dc6f2f82b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

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


