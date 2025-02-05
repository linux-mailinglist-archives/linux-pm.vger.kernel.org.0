Return-Path: <linux-pm+bounces-21375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C75A28922
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBCF3A1E41
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE621C180;
	Wed,  5 Feb 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oq4lmOVl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3E15198E;
	Wed,  5 Feb 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754750; cv=fail; b=P0jfxtscKB9COPaOEyfThLZH34m7Qxf/VKyOmS03RovNn82MnOVLcmWdzaG/CmdcoWVbmhkgXBm4FVnRetiBMAkjjmMg5LMCDnpmhgjCNFH6ziNYGBWzcQMVjRou6O5HWcXuju0nkSDAz3Cwp9FD+TA1S4K6fIlzN++Q/lFvROU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754750; c=relaxed/simple;
	bh=oi+Vdu3Xo1T1RoU9K9Rc3VGS2Uo9xwxoEmgwQOfqIPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHPlyFpvpUohfJmIyJV4MW11/0gnGlFNoGLnfLT/XRvgHpbnvbtJV6/Ig+lF878SQKGO51HSxYllYO69SXdHvcYGXmjwLuQSmW+s9Z8C7KTR2FRDEncJrmZxBKbohVF3BYNMQr4zGu/koxqfOwrtTUJVk6KDf1yFpza7U3ghBDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oq4lmOVl; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xejRPdmk/JOKBLHTOtKAAfKdHy+gvePSn4DRFclclK4jfH+qiMT8V/edCu9XzgV2+QuFa7kR/F2JhegZUk+fbGb/GLUVI9E8HIvFKJbl86Uf7h11SB8Z8Qqg2LOtoAkb5+jzI4PTcijkeOizMJ0Xj/2zLBPHvt4R9jLZSh1HZ6qu4Ge8xsYDL7VWFS76pVTUGj6f26MNthSjNLncfOLtHB5B6VTQMcc0cbw+fCI4wXC8GcbSgO7ZLwzfnBsksbnsCRyECqenNSm7c29EQpw06wSEEfNjSe2RgtdS8kgkqA9fuRr8y1dVrNv/5+7cWCwO74WekDA8JUpecp9ICHyLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lafs1gilyQ4Qk6vv0mqHW9JgI0MDKtJuvwXFgWffea8=;
 b=NlPtMOC6Nr5Ybbl9Fsx913Og1sQNyWVbU2KDtx/ogeuU3T/iKkF6XDpWrA4dse4eaHLfCPe/q3SGNibDTGhgC9ZkG6vcE2uuIVDDjIjtZFGhL6X+teOlEYCfOpqnFCMFrZKVLYQtjcGvDU0UMI1N0FdzW7CQ0f4uTRK25jJHjh5bBbQZjgLVUvj0u7rf1qTCAAkTad0ctJqkBJAeVlWrKxpJmkqftEdBp9FLHokYZUZbgDp+yZvncE4BkWkBC89VYKq6AO7MXIPU0NGOQYwYx4x8tF/EH7Xold9/SzjUJW/r/mjprVxJWBHEsmf82mSGMFQdtb0fRTtxAh4gANz9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lafs1gilyQ4Qk6vv0mqHW9JgI0MDKtJuvwXFgWffea8=;
 b=oq4lmOVlxPZQu/FvF3rHHMM4CFMlXJSe3pWGLhr9FjVCY6NTSfMbA1GYrGYqqvLBNpXs79L4sx6GuadG5fZiiLEaE1wIKTc7dKSg0HMgoH1rB8i1EPNaQ5M5pwYSV5MhQ4eqtSPfxEvsDK3kjdx1p7HmWyzen87ufjiHJXaQiYY=
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 11:25:43 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::f6) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 11:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:25:42 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:25:39 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 00/12] cpufreq/amd-pstate: Fixes and optimizations
Date: Wed, 5 Feb 2025 11:25:11 +0000
Message-ID: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afe1218-b0cc-4804-f063-08dd45d7d373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlsZGrYuPOMIValj2CNnCFpIPy2ixUVE4vBxCbhyiC08OX72dk5mCCvS4hVi?=
 =?us-ascii?Q?vvad58LV3c78tBirS2dcLX4y8FIhSK8GEhsyOqvu4FdXBGr99HRq48SRraEk?=
 =?us-ascii?Q?EfpCVi4V0oQfqoG5dwueh+Sve1aGnoae/jioT+iZo8XYd3z/lomIx1pXSPcE?=
 =?us-ascii?Q?ehad4ePP+j7286ckm4JnHjw9Vo+yAYUwRqSHL4vk5i1V+AO3xveg5lgIZSmI?=
 =?us-ascii?Q?nlpyuoj0rV2inUszEeGPaT9H11ikvjwHumpJ9ekr3Hb0iW/mKAQTeKIThdl7?=
 =?us-ascii?Q?hYhQnknx4UJ7fMf1tHCfkiu3aqx5HeuoBQFAk7Vry7hOwfUYyQzPgnReGWM/?=
 =?us-ascii?Q?ZYIoqyz+IgE7wh5XAOUlEnzICoYL1qiApB0nX36QenNrvxGPwMZ2TAlzYJNf?=
 =?us-ascii?Q?n04r7i9vfDiZH0SAYAZnNU7uCXr3dGPYz4PxRSqcPwF5lcGNTVtILG1dScCi?=
 =?us-ascii?Q?DHriDSvrH1vLcZ7Zuk0twbMDsmI/np3CgI+ff5uVx9WOzHE2gpJZw6J+Wxm7?=
 =?us-ascii?Q?QuQdpoiLXLUuBdWrbq4f+/GwEhqZ/DDS5/l8ztfGdqFH5CT6kuLW/LvsFnnz?=
 =?us-ascii?Q?Cb59Z+3CiSypdYnjc89JuXjwUJw0pEo/nZ9w6OrIeOIA7FkwO0VxZpYzibpn?=
 =?us-ascii?Q?SR7S/b5j6EE7u4LP3nZDymccyT3IG5Lf2PxrgsPBjdVZxliXJrhQQfWglxyn?=
 =?us-ascii?Q?voO3l+ti3HooW/r5t2Z1y8X6uITiYk0Na7q+d0bfW3sG4CMrPMdxUDKRXf7Z?=
 =?us-ascii?Q?YQ07UmodmSxDs3vkUMv1JLI3Rn/hOrBm9RmgnjYEZlgBTlk6dp0SrCfm9jkP?=
 =?us-ascii?Q?i4PmXT2VBcYER2AI2zPqNO+S/Qx3pHtRoiwDpUHKCX2KAv/HT5g7CeGtpS/e?=
 =?us-ascii?Q?YGC8BDMKgNRsj00+4kdZ1uLnXQwMk6fIK8kn5ItnPb5Njde4Q+A7fVgVvfSF?=
 =?us-ascii?Q?rbAZizK0h/ZnQHV2Ou2a6w0hUkz3jatGD5wVGExNpDgrKmi59ESXdjSNaoif?=
 =?us-ascii?Q?lRPnznqhOAclABtThc+PEx5n3RSNWDNnfD0ETV1fvKOLAJmrP6XYc/GrTCJL?=
 =?us-ascii?Q?by9XXuZ3Wv7chNZy48/j8NMS5/XrHWwOFFjkR2zwdkePd28FzcIk+U0r0OD3?=
 =?us-ascii?Q?uo3qdPclo8r3Sz3oGI2ZogLPoPyELNH9jyT04mQaYmKCK/+BCpGdQNeUYfNK?=
 =?us-ascii?Q?ExJjOYV1CNgZB6AfhV8heTLxnlBMKX3vuKXFoXM42m1Y0ZFjfStuSYoYR2U/?=
 =?us-ascii?Q?eL64KsI1/0gNG6BY0xIVg4z6GnjMsVTvKUmY6C2Aiy+16DHZNra1KRhm8zUU?=
 =?us-ascii?Q?8OrUJUcE6uXRbFhnNzpjs2rGB0M39flc/jVkGMmdfeNOM0gbTBdDSe3Eer0E?=
 =?us-ascii?Q?dwd/dck4YVaYWDqWbEthEr/yxOKJv57SMHtbIo699TpPBw6GKtsu91u34ZXp?=
 =?us-ascii?Q?RCyEWrbx0/2GglhoHuw3x3f2T+yCuQ4KCdLzptQbw/Oy9pTUfa05VZpEsC1R?=
 =?us-ascii?Q?bLaZItEtuiwC7W8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:25:42.3260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afe1218-b0cc-4804-f063-08dd45d7d373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

Patch 1: 
* Remove the goto label in amd_pstate_update_limits, as the mutex
  has been converted to a scope based (guard) cleanup.

Patches 2-4 (adjust_perf changes):
* In amd_state_adjust_perf, max_perf was being set to highest_perf which
  was leading to max_limit_perf value not being honored, fix that.
* The min_perf has a hard lower limit at lowest_nonlinear_perf,
  instead set the hard limit at min_limit_perf. This gives the user the
  freedom to set min_perf lower than lowest_nonlinear_perf with schedutil.
* Pass the correct perf limits to amd_pstate_update() in adjust_perf.

Patches 5-6 (Modularize perf<->freq conversion):
* Convert all perf values to u8 datatype.
* Create two helper functions which carry out all the perf<->freq 
  conversions throughout the code.

Patches 7-12 (Fix amd_pstate_update_limits() and add scope based cleanup 
for cpufreq_policy ref counting):
* Fix a missed cpufreq_cpu_put in one of the exit paths and remove
  unnecessary cpufreq_update_policy call.
* Add a missing nullptr check in amd_pstate_update.
* Add a scope based cleanup macro for cpufreq_policy ref counting.
* Remove the unnecessary driver_lock in update_limits.

Base: superm1/bleeding-edge

Dhananjay Ugwekar (12):
  cpufreq/amd-pstate: Remove the goto label in amd_pstate_update_limits
  cpufreq/amd-pstate: Fix max_perf updation with schedutil
  cpufreq/amd-pstate: Modify the min_perf calculation in adjust_perf
    callback
  cpufreq/amd-pstate: Remove the redundant des_perf clamping in
    adjust_perf
  cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to
    amd_pstate_update
  cpufreq/amd-pstate: Convert all perf values to u8
  cpufreq/amd-pstate: Modularize perf<->freq conversion
  cpufreq/amd-pstate: Remove the unnecessary cpufreq_update_policy call
  cpufreq/amd-pstate: Fix cpufreq_policy ref counting
  cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update
  cpufreq/amd-pstate: Use scope based cleanup for cpufreq_policy refs
  cpufreq/amd-pstate: Remove the unncecessary driver_lock in
    amd_pstate_update_limits

 drivers/cpufreq/amd-pstate-trace.h |  46 ++++----
 drivers/cpufreq/amd-pstate.c       | 167 ++++++++++++++---------------
 drivers/cpufreq/amd-pstate.h       |  18 ++--
 include/linux/cpufreq.h            |   3 +
 4 files changed, 113 insertions(+), 121 deletions(-)

-- 
2.34.1


