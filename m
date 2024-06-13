Return-Path: <linux-pm+bounces-9055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A69064FD
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102631C2294C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C222513C693;
	Thu, 13 Jun 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hlDGVmhF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EF13C66A;
	Thu, 13 Jun 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263567; cv=fail; b=W6ECJtLxhbg4/AFOS+EmJhHXdaKYCHc+jGR9Qv73OaDVoYu62Rj3quCdESB2P2ap7weXJNlY/cmnU6EMws26EIvoETMpHJwPZfYznZ/+nLhgsKUyd5xSDYAaC68D1mEwL5IatkHO5f3HL0ywjFo95bW26P/VPVnsarbo+o4lz84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263567; c=relaxed/simple;
	bh=Xd7yYN6Eg/Yx+TvQiH0gNJGgpDV7LIhEVrOPkcdFcqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6ATNojYuh1a7/hPa/mEpPr11GCao/o5R6TY3cat9LjZ6smYUwY5DkmxkgQ7F09O+Xu7deeEPtfdt2mqHq2ncWGhuisd8fzAvFBd4/729KzeXqPNlG6lN4fS7pSdZcn9HrpYQyZmgb+l4oFdR1JGiguAXyplXVqCvIiHin3A+V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hlDGVmhF; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeP83COv12bXvUoWMhJXSG694sjDzqjO3A/8/j5KnMM6WphonLMneNzqEYwBBFd2z3apJ4VJ/xpusuiP0+BiP9IMwWycOCpc5UWlG2T2x08PsWqRqYaaBOUCfWJvMhQtjbpl63UJzQi1VAKqCnJhFqqhpUZ5TNmff4uk7g0DoMCx4FpMZPatg0/Blk8PdAiaaRk4ACH/KuP1fIIxiUgtUs2atcPjHcroo0C9Pxsfjn9TgRkXvYEf1buIB3I3PqCd8VUX2DtrAek3K74QcHG5k3rSwnexyK4vDQCNB3hE8objhR1WCHLf+RWFiAgkvruxPqhptBbjeVYKM67TLx+EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aae0L8ILzTshpplInxDjSkfRm901kluJXUlcE39Znw4=;
 b=U1h7VAJv0BCa8ujO2dJBtNXl4e69biNL5JpZNwV348lKYvwjpgNaw0mjWurHkuo3U3FlML5hkerdXcnGKSIhHwSUEuxVyoVCMok9DnyFQ1lgbKhSJUDP3v0H8Ql2dc9yIwAxYSaECtECLxO76781jbY721gM1dRwRzV7ttDoUhFYq4pAWdOVqfd+A7xdH5b1VRy+kYr3X/CSrjOsUnlfv0rna9me2zQwG2K5np4AFNdP4tKSIHt90xe86xp073xg8McWNkzugxN6/T+uaTaPrKi0BDjogyDuh/PBDtOvOPd+inX+gf74WmyHTMDjaqJRUozI+89wf2CMNnZf9Uc3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aae0L8ILzTshpplInxDjSkfRm901kluJXUlcE39Znw4=;
 b=hlDGVmhFShnLa6EUCpR11jPUrnmXfoRHocGicIR4AO2JCR9zHvzlLAkNg9t20eB/aa3dPAfgN3yVF4UBfm4j54RbTJztQ4Iw29IiqKjazW6MFvWRjvqpc8k7eeoQQDpz3l48oYY63/HbsNXMIEcVw/wozRyh6Pl4V3Xfu+W3hv4=
Received: from MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Thu, 13 Jun
 2024 07:26:00 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::a7) by MN2PR13CA0002.outlook.office365.com
 (2603:10b6:208:160::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 07:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:26:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:56 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 6/9] cpufreq: amd-pstate: Add set_boost callback for active mode
Date: Thu, 13 Jun 2024 15:25:18 +0800
Message-ID: <c46eb6d79bd8e7068955cf993ffc6b726d86eb92.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: ad030fc1-0e6a-4e3f-a24f-08dc8b7a1312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|36860700007|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dtuLZ4XkK8fsSXAhqQdiSERbSvtBZtkWAxAJAyH18p59O1ovThn5rsHjlbx7?=
 =?us-ascii?Q?PryxoPlT0z1K/XNVC/e0Lg1Y6Puv9F1+mgXWJOHVXoz7r4iIFYJSI5etOqRt?=
 =?us-ascii?Q?nwwykW0hrOtNq0pXAOieMBXnWWybLttX4moAZNFepaXf+pTDWwK//apvMjQP?=
 =?us-ascii?Q?yzcgmuawXq/8ILHfERQB5jlm6WQK2S/7QsW1p9aAT5RM1hXDK8ssA/l7bxdE?=
 =?us-ascii?Q?1kjv+m4PcnCTypQSobFySAnnot3htV19Xir5NIHMxnvJ9+m+mreA3/K3i7Dw?=
 =?us-ascii?Q?OAjIJlhX5CbJicSqx/DOjG30K38DXTTgmIuQqWT0oOptzc6Q4AhXcqf68hl/?=
 =?us-ascii?Q?L9XmhGirRgjf8jZM+i2MqCCc8hITCuu+V2XGAg4TATmrEKkO4nyQaL9rTly8?=
 =?us-ascii?Q?i7JsjwlD1jziRnrWI+iR3BbvkZEk/m0cKjU4+Htx9xYq71WGGcwmJoGcaujW?=
 =?us-ascii?Q?gpTdNFICEPF/7gQY/T4aOjta9836gltP6y0T1QZpSvkZX5OVSjlPDr+ww99L?=
 =?us-ascii?Q?KfGMD0Z58nSXiuCyILmPalkkk6DHJNGex2MAcJvxbrzXNuCT8AoQ55Uyy4lp?=
 =?us-ascii?Q?kJgNwflqnCSWXp6NTsQBVairHeoF1v8kdlx462OkZJyMgX4FIdqBC5PrAN3l?=
 =?us-ascii?Q?CktGnGN/jKUvpNnsvGXc5O9+Fr8+n8UOoSnfipCWly4mdXxOjl1JYb2LZOP2?=
 =?us-ascii?Q?WivKF2OdSTRK0rFYug0+/GnFg6t2lm6mwgHhRN56rGZ/Ud/O4vff5+azxhFy?=
 =?us-ascii?Q?ZUEtq1cGsTR9X+T2SQC4xkVJzGwYgKvpk7eBmRHrjMaE+1yEXc1OhYidAXGu?=
 =?us-ascii?Q?RsYSCrRHFl6VfXyvSHoEj2zSPIRJP3KkoqNuwGQykHzPekInVNnc4RhiG2PL?=
 =?us-ascii?Q?6Ypa4eZ2DXXsEVY5d7s5GgVVF9xmeRZM1WrJ3EARyPRVunLn7NAm4RFMqSZF?=
 =?us-ascii?Q?5SHGDltU3G2BEf12EUzQttBYKNManM0QaWGzqVowubAZCNj3CmnfNnyn74Gf?=
 =?us-ascii?Q?u/YYSRsecO6dSPABqlZwRqzcFoG7gJoKCapHHzr72CtB22sQCQ/q+HLehPQC?=
 =?us-ascii?Q?jFInM4WgsN3LtaIUMh+MTcfB/YE0xkA6u3eAqFpv7pFXOoE9O7OEFYXpkpSb?=
 =?us-ascii?Q?3ozmxk5NQc4TtOJ3tfqKZvUasxhV2ae2Kvec4L70G5opjdQLsrU7pe5jsEu+?=
 =?us-ascii?Q?RgLVx16vSN/4NYRZOuGmWoJiYe8eaSlONUZbBWf7JAHu8w7oQplM6lCHNwF8?=
 =?us-ascii?Q?Po0hYatDZmC4QikWJnyJ5DQ2dRHo69RBwdKLlDh9gi6OcbQQ45R/3DmcUXoA?=
 =?us-ascii?Q?+jYOcfHN1vgUOFnuL/XvRQvYD5tElqIUe52rC17SCkDmL5gVXa12JsU4g4kV?=
 =?us-ascii?Q?7/EKFA7f5MX8QaYJQPwfHRQafWKLKap3/+gQsI1hWfhkW52Lpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(36860700007)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:26:00.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad030fc1-0e6a-4e3f-a24f-08dc8b7a1312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

Add support for the set_boost callback in the active mode driver to
enable boost control via the cpufreq core. This ensures a consistent
boost control interface across all pstate modes, including passive
mode, guided mode, and active mode.

With this addition, all three pstate modes can support the same boost
control interface with unique interface and global CPB control. Each
CPU also supports individual boost control, allowing global CPB to
change all cores' boost states simultaneously. Specific CPUs can
update their boost states separately, ensuring all cores' boost
states are synchronized.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fe7c9d3562c5..d07f09dd7eab 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -701,20 +701,11 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -ENOTSUPP;
 	}
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_cpu_boost(policy->cpu, state);
+	mutex_unlock(&amd_pstate_driver_lock);
 
-	if (state)
-		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
-
-	policy->max = policy->cpuinfo.max_freq;
-
-	ret = freq_qos_update_request(&cpudata->req[1],
-				      policy->cpuinfo.max_freq);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 static int amd_pstate_boost_set(struct amd_cpudata *cpudata)
@@ -1875,6 +1866,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.init_boost	= amd_pstate_init_boost,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1


