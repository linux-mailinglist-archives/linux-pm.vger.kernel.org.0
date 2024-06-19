Return-Path: <linux-pm+bounces-9556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FAE90E6BB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FB6284888
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AE12FF64;
	Wed, 19 Jun 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6EAJFYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646EA80038;
	Wed, 19 Jun 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788647; cv=fail; b=NUYvtfZjrn56kn5REHjgBDRAcg8k/1xs8MZeqfaCq2dEjwQEZOOIO58dP3VsGf5hO+qKX5dHIyzN7g9gktudE6j0yGLen4A2wXGDhd99s964YcEiMBqgUcTy/Prs+PbVGsyN4mHWK/as99HkDL3yiP7q7ww3fN1yl6xPvprp6q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788647; c=relaxed/simple;
	bh=murZ4D/2GSSFakHZaLag8S3VmW8uU0ldRE2WUAJt5Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGP90kHsyHFRNCCjgkKe2mWCYVeJxJlPZKPUIeBywik9QovOGWWUvo+8vhsSRXmN8Nx8xTeyf6/m1BdizovGYIawSllpMUlsNiZbnv2KkLBdNU+EHK6JyLZ6vAvXU9xl85I3UW/aJ0L/KPuNNkf5wKDjvGl2/L5vE/aFNnjW7fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6EAJFYA; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwKbqDycdRnsYzL+BhMB1EjY6NRi7c//EuPjrKwj2559XxA7+Pv1QdjDOXUgOKwMwsQ1vPmc8t+YrQlb5NrxH3WuGK5/urf8gf3sTIX8MTmO6WL8JhlkB/JKBY0byPjqjM4FOHYouey4b/57TEQKIjQw75KmplPMUnuXZo3m96hgMyNf913o9tD8RCqofudAdrds0UZeJigXR4zv0LoOZ0EXYjGbXq4BkJXPa9IyRrm7VHE8WXfxi3WS3wOFJosGgf9e02/Z/ZOY8IdnlTpqlkG7OofmO5rUetbYqBgmo2pCcCtyn8lHZ/DIwHZiW9vCKzwjcNQbNtP6kny+4qy0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkZpnHgGt68CHweAlPPjdvQLR6rAkBv2WsQGUI6/ZT0=;
 b=EYzbmTbUhQvdE07v7SriqPRJLLo0OmoRpxj/Cuc+WX5iTrlso9XkO9WSn5iLxbfNbxuJvAFRDz08jcqI5yerFT5eKHdB0PRtllxKmhzxN9TO54usqwvnRMEpsi7dAG61nsuClRu+23ZlGjO+tAeDtfqCPuLISdrczPcKHsWzzf+HrU/tj9lEQIBIlEvlTPbjbTu2Lb09TCAWfGJzaxX6Mk2ezSbfEvewVWURb48W8LVNiIW1d95x4C6EOhdtR1IGBcui//+zu3IkLS2wSgVP0HSH8sygdfwVG1g/rS0BoOnaAWhSrhbybOjEORWwuc3ctT6jnHu+xi4VPXa3NvjKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkZpnHgGt68CHweAlPPjdvQLR6rAkBv2WsQGUI6/ZT0=;
 b=H6EAJFYAnO/XgHebGbb0LaLikvs2zxPkTtcB2Sfb7/hY5Oibz34FkSds74c4skAGFUbUfmchjc1hVhfwli7yE+kOVnhghLjb099lNWNy/nxgcmCBp0iP4iahN2necUC+8EGGZvLxY/BMvKFkGG/fYbHqzHKfBe6fGxA3caNaKkI=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Wed, 19 Jun 2024 09:17:24 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::e4) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:14 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 6/9] cpufreq: amd-pstate: Add set_boost callback for active mode
Date: Wed, 19 Jun 2024 17:16:39 +0800
Message-ID: <851f4e8b2495f35f2ee1e848844dbaabb55411f4.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: e0babfb4-8a3a-43bd-84cf-08dc90409e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6uadmlDj5pHJqF58RaUdnokUbT/Y/fJwL92MfcQuPk45ZwxwgFNcTnkyU0S?=
 =?us-ascii?Q?1zkrHcLO4mutLvf4XTdw0iSoZFeyGePF+t/vs0fRiCKvhHOi5ZZf5uvJjmYo?=
 =?us-ascii?Q?a3qsEUq+lJofR8hCSOl6MrRCk3rcxirTbThcHA5xygg+LI6epsWLMgCnAQci?=
 =?us-ascii?Q?mqzpAQQZNBIvvIq56HOI+jUpX7ylCwhl1hr+pnccoS6BcL8CktfO6rRu2tWi?=
 =?us-ascii?Q?D1TwEgIFdnHT0RPv4X3hQ76NVTTPu7rcdxgnZ8yOXecmtmSc3HsMJ7CpzzRM?=
 =?us-ascii?Q?+wSlkQ16wPQUKuyebLfA9cJf35zErUyOPhEMN/cbuP3VDpylC54WJZAxdWc3?=
 =?us-ascii?Q?KU1A+z8p8CH2PmkJJWxrsByyueVf3cnyf6SBVOmXwz311+S/YfZu7KpkbGRN?=
 =?us-ascii?Q?6H3EjZWUkmosOgGHvH+w9v22wJ4lYs4Yqap4YfBgsRxhBTr+iGaJR+mNnwv4?=
 =?us-ascii?Q?Hrh3Ny2sCvJNIg3jBu7+My+BUUMDwHiThqphKY8WdO+oLgcr/U+enj9mrLFY?=
 =?us-ascii?Q?y7OPlO7nGGpBD9aqY8pycyb/6ii4cD6nU0yur8nUZCnESvfAsoIGBLhyrd2w?=
 =?us-ascii?Q?EyIWbPzsiPqG2kaZPEKgnTL1FePFcxGe8gAv+83zpU96AMhS2oKEKpi0/oSY?=
 =?us-ascii?Q?5WgZezk4BQ27jc+U1QhbFkuRCUdMIqzDMR5LBbvhXBhGXZyA03ppWw8+gB2y?=
 =?us-ascii?Q?8bpTwoRtA9yIwcbw2tRwCYRzNBJwDsDRxPW8p5BTaK7zDXuqKYRY0cSKDYUm?=
 =?us-ascii?Q?DATID4YJvT04H93DpkG8deDmkjfEnHtPHPcwg8fPe0INH13MYExsL7f0HxIG?=
 =?us-ascii?Q?aOu1cJVk4kSr655VqEJPbq2nh2YCudoxvt5mLYvLoiOpnexMAeP6hM7bLkdS?=
 =?us-ascii?Q?7M8zl6JqRZKiXBDn/LrI4wIbPuENFz8tpLSN7ds0PKoxil7yHuyQXngZrE0v?=
 =?us-ascii?Q?XgxVHiV9YtJX7oN2Bf/oRaNWM+svVo1XDe7xloOzMJ5AMWduUKjVKi3bLNBh?=
 =?us-ascii?Q?PBmqd6NIaQsnd1ZiqQTj9A0qpYhfSdiUYFXN1P1PCj3wMQwjtwgTLNTWi6Nu?=
 =?us-ascii?Q?Fqq0EEkC9A7xZjlxjSNcFZj2HnV76UWmXrU2p5rWI9enVwO26raPbtDST6r9?=
 =?us-ascii?Q?D8nqo2oU3ZIe+dR0ZpbEvJjUpfwBWyIfpPao6tBfUjsgtf2+AJrnj0rE4lQX?=
 =?us-ascii?Q?esd4VCYDLmXP5CvPFVIizt6oNPDWWPVmU4ctEkZGyaIDhfEY0dPYCrMKjUQy?=
 =?us-ascii?Q?0hiX3OVIrWAfSzLD+VWVE/PPxW3gVCf/3dMTL3o2Zm9uB1AtaWBdUe/GbVAW?=
 =?us-ascii?Q?GjxY0eCT4MHyK3PlRo8TYL/QRU4kW4K2+1jf5DzD6Sh6EOW6D8ZvYo6DvHvL?=
 =?us-ascii?Q?5cb6wSKirFE27TkHMa6tH7F73wIecyir7GNsdx4EMUDF9zm+Cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:18.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0babfb4-8a3a-43bd-84cf-08dc90409e45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658

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
index 1c2320808ae1..299e52d4b17e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -699,20 +699,11 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
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
@@ -1868,6 +1859,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.resume		= amd_pstate_epp_resume,
 	.update_limits	= amd_pstate_update_limits,
 	.init_boost	= amd_pstate_init_boost,
+	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1


