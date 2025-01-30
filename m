Return-Path: <linux-pm+bounces-21115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626AFA229DB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BD03A5E25
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B011B0434;
	Thu, 30 Jan 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1f1fAyt+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603318FDC5;
	Thu, 30 Jan 2025 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227239; cv=fail; b=I8FVJYk7UUD9WdghNPKFZ70m/ezySuKGdGUy4jYQzLQUkqn3VH8Adx6FKstQYCbGwVdtD5JwkZsT0SR1NeG32INsWbMURdvBGDqlnhBOOQmOHMfj2rIsmky0NJ+Wc9nqjriUsd2rcJS8cTpkpQYFdInq1X0rsjkLpnGvldOCfhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227239; c=relaxed/simple;
	bh=CgKxenlH17Nm+1BRzF+ZZQuMsYXwMnNInRu86kSIJWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3pTmRnjeOJ3sqOLCDKiPATVq3rjl83JryVMQzbplF7sU2pK8WZqftgxhBo5gXTotEDXVftBccOibsGvD55JeEyQoTse0Y2dROqXlAxIwTZDRq6Uf6OhyHs0pdRXBvmRghvgNyHqtd0O616d46PKcDqvVtp0fpTPJTd66DpNsro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1f1fAyt+; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZVNTKixDi5WrY+iwxFNGlo4I/PYTu7CDunBaR+BtgCt6rQsoDN3a3YTADpxLwtWLxSN49IZG/SgXEUIixOwo6Vo7NuCsV+bNHxCHlcSogcDVPiqe30imQ6GcFJ2k0/f7ehg7H2/JryHGtH26PCI02kQzbWlRr4lPFeuqRc6jB6Wi3+l9RAq8fzM5hBsCD6kR888LntwdmHBSJ2CfxynFDRFEL5alup3tJUMOcdkra8CI8D0+yJDatTrWf3kp912f+Q58lzekvICDIjyJ6gy5pIXPXV9SWkczd3ItqqTBgCpRNHmroOs1HlXZQnhTW7FHjq0KIhRGZktsn3AT53OTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjv2VuLPPxxBd7ilIO85c6vLhF3YNWhgPFOmBl7eCr8=;
 b=IwbwdUODX7Glp5+6y7XOcF/FR4PkXIvu1v3d/K9TktOOK0xghTB1YYZnT3SmXXpBckc7Z0Wx0+81llb8LeJRzqH/5RPl2Qc7HQZZu3S88PI9R0fkOQOQpirCphyOQlla4fw7X44yCISvOcB+VjwE/4MDltbgq043lzf8oPW/DS8SlG6hwMRdeS2DTxIfyD1NIDzh+2sEob9s+9EsQIXQWKDC6UjEeZhTP1Cg9312Jprq4lDnQ3iN9bA9J6brJ7/sGr3q0TNVuwUd3mGtOlApvsnE/L3S6ydA6GAMDUtYl1Xx+VFcTnFOH6E1eJBic/2MLlAtLbF1trEopOlKqlfCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjv2VuLPPxxBd7ilIO85c6vLhF3YNWhgPFOmBl7eCr8=;
 b=1f1fAyt+DEgh1B/dAxvc/S/sFTsM0w75LBYfgDWtuH1matyX/w5/BTJxFyjybnPkKHLiig/L09VRK2+6IlnBcL9sJsx85yLl17iMODBlkzngKb1d1R/casbQk0pzR0poVbK2UG3+c2lIdEpNVnjxiHe/DsuuytGRC1/7Kn0hsvE=
Received: from SN6PR04CA0088.namprd04.prod.outlook.com (2603:10b6:805:f2::29)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 08:53:54 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::66) by SN6PR04CA0088.outlook.office365.com
 (2603:10b6:805:f2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 08:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 08:53:53 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 02:53:50 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Remove unnecessary driver_lock in set_boost
Date: Thu, 30 Jan 2025 08:52:52 +0000
Message-ID: <20250130085251.155146-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 259d03bf-e21a-4a91-9fa7-08dd410b9fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppMlpEGCop7SIVwaPWqIIsK5gQfAY2o4jvzirbZ5XNwvBgp3mtyIpi0XSiLI?=
 =?us-ascii?Q?gQbk1/YnMrqciRTQMZyUQjqYsiBvQu5onw0zLOSXQz//5sDLmoTKoD6CX91w?=
 =?us-ascii?Q?VTJXaUjoyFI/6S6Tar0Yw9EQ2/1PZU4QO39p4jgzfLaNEineQvRr8IosWbNP?=
 =?us-ascii?Q?rQ3lm9rsNabxyAWcB6NGOVFx38cR91wPZFGA6MQfMvWL4Eg/mnTXE/cW+Ryt?=
 =?us-ascii?Q?d0uHSnqQulVoS5WPa/NfoMIDqAQTJh2582vubapRw4qcuapcA6d5uxqBhV+G?=
 =?us-ascii?Q?pkfP0H+0P5OTYlzEb6f470tL81rH3gjfXOBU2Hv3F2STj9tzc9ixwqLZv0S5?=
 =?us-ascii?Q?vNy8qkCDBrpT6F0xIN2ixZCwrBxoWiBOKUt93x3PMhjiFwF2NElVArgnbvi6?=
 =?us-ascii?Q?CawkzxUYLO6SwdDEsF78bv4LtFC0zxsdZxJuH/d+qKV4Zp6Z56pU/zn04TUj?=
 =?us-ascii?Q?1OJq6nYqQEoSmK7341fqodSCDqSpILs4oHubt131fPDlsgEb1UYl4l6+o3Sa?=
 =?us-ascii?Q?mrm8+L6q4DwR4rTDM7Ll6iVJqokA7d1DnCH3pM03xbznr5TLz8UMHjabO6bF?=
 =?us-ascii?Q?P33MaXlZDIO+aX4hWlVcEOtQ1mT5ZsV42U9VgDBdBH4+Jj4xk8+D7i6LhS/Z?=
 =?us-ascii?Q?tbVEw2m3LjbI2bUT1XdKUky7KalrHedMbywFcEPj79i2f+c/hTFb5oEFQT7v?=
 =?us-ascii?Q?bKVXMSIpzmhYWd/oLxXTiG2RQF2fJ1d7cPxCo7HOkgF/iTl8rohvxsl1spwd?=
 =?us-ascii?Q?UD82JCqj5tmC1N+aAffKGoHDuPRR/Kl0gPFju6Tlv02jPUgnS7CkjXzziqfA?=
 =?us-ascii?Q?ScOup+ImxFd49mXrB0v/IfH/le18HmyDst8lSlCipqmBebNlGxzn218bHVLv?=
 =?us-ascii?Q?imCUhTzBASlG3LAA5gjDwF3/pjhg8yDZGc1a9qgvEvkIQFyQuPQWFwtVqWot?=
 =?us-ascii?Q?UqWljbfOie+oYDOGJWYaYmDvtnOr6i2YuWXyaVspVFe3m+UDx45yQ7doIzL7?=
 =?us-ascii?Q?oUc70GNfVQ9zOHbbkMVb1CcvX3IbOWOTFd8YUqk619cYH7Ce1KBWastMQaMT?=
 =?us-ascii?Q?66zKTGat3Baeamektzica0m3iBJjYAAOKEsGPegT8+Io1Cd7fvgGOrn3wdhD?=
 =?us-ascii?Q?WEcDautmmeUgoCMyZI98PzCIX+hvXBj0VeVdguJOTtgvIU0BWQDVBR+QB/XY?=
 =?us-ascii?Q?sHwnwZb7ZZk/KS6P8KH9HX3BHuxFOcFi93Wwr5RzsO7VeV+9ODJXbn7PcWfR?=
 =?us-ascii?Q?Enz7rzqQBSQ6nk5WHQZUd5PgAp8zN3rnGbrjr/O3D9HP2Mg81+J46dlOj3EU?=
 =?us-ascii?Q?ExegoPoQj2Stwk/nOQlZAhOCdyAyjzIcCq454gEnUJduj64YiwXBK2Ev8K4T?=
 =?us-ascii?Q?+RKb/msXxHQGIjOdkgH/Q1BWgJqEzsNqSltyo5RAr0z9WRtGyc0CLks8ioqe?=
 =?us-ascii?Q?nJuXOw13ahv1NzH0bNFEJ69SQzOs75W8X49OFDXaY0AhPveK4fPyPR9Fn9/j?=
 =?us-ascii?Q?2gZF3OtcPpVgP5E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 08:53:53.7064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259d03bf-e21a-4a91-9fa7-08dd410b9fcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

set_boost is a per-policy function call, hence a driver wide lock is
unnecessary. Also this mutex_acquire can collide with the mutex_acquire
from the mode-switch path in status_store(), which can lead to a
deadlock. So, remove it.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
PS: This patch should ideally go before [1], as that patch uncovers this 
bug and actually leads to a deadlock when switching the amd_pstate driver 
mode.
[1] https://lore.kernel.org/linux-pm/e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org/
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d5be51bf8692..93788bce7e6a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -740,7 +740,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	refresh_frequency_limits(policy);
-- 
2.34.1


