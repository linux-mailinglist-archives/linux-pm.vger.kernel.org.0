Return-Path: <linux-pm+bounces-8918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFD90371D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C621F21EFA
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472E176AA9;
	Tue, 11 Jun 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RAONRvYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DD176254;
	Tue, 11 Jun 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095974; cv=fail; b=rEj+NRgzsbAjxaRQcHHgZiNx6FsMHnK/Y/ZN+Dct3Fzsy3Zvf/DAilEoB//xZHUhtURMrGd96XgU1VlVR4qVDH9J8WQYxhiHbxd3OIxgny6UOreaJM4zxcUREpoNBBrb9h0WssUjvFCo1jzxkYjXlhTpy5+0/YAG6zpb/nkmDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095974; c=relaxed/simple;
	bh=mO2rJwD5SQq+6+yWjz798sXPsyoAFbLwSsPFF4K3qrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC3RVE7M8wzc/mKeg0T97Bvve7F9AiGaQQM+7j2UGjnbPHNbh0rqSn/U52Z1HvUsbG7N6tGOdFVCW1nQZDv36cAhTypheLuEWHIHhqfDweWTR3+nIXMIHqzY81dsjQ8aTKdF1uPP1kXt6GLcCc+tRMuvdIeJ60I8XE3OD9VFCb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RAONRvYU; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx/dMLEH+N2Z1iPWXPVHTju/m59YtpMftz4i++Uv5t8CgiMPu728jdczRXt5AXpU7Aj4A3VAdDzMZNefq12Wqn3hsvW+F9HTq/vrlOdxyW5Mj5YNCeAk7mhKcZSfY/+Qt+oyno7aTpDwBguEEh+tyeFYP4lt9OCQfnMZmqJyulFaOB+NCnFNnUSNR+9J+drabUzm3wsOJ9FgFV+8PVXWvu8iu9wwjXpH5LLUH825V7tMxEGS2ptzPJokGkxHOHXS2UdmRRaeoKVXUns8JizAb59tVbxH4WEo2A2nVSShf9RMmQO7Od6PKQLKUhKl4UgCK4r2d4KlhMQj1eY7BQsoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu2vqfpSGOUEgE2QyBtFvickCWxM0Ihv8YUjSYxv0RU=;
 b=nrbGECQtpb4D7be69yW/NFnJR7Q/Fwj3iK7nr26DflcQdo5SsaqKiyCmglU5XY+AZ98p4Wwx1r6u23OgTNMZNMY4vpNtoW7aj7u2qAlf6Jqb5fUXCQktKUj7aAMsXHyTb4E1lgXpg3N4BV9U4geZDrgyS4kgGEO3hDnHSYZmnn18BZd44y06l0jR8tMD8g8Z6TkUiLbweW+u2rAmHM+rmPgcBxNnFI7xH+INWOdkVlLQuJ6qKzwDnrIgQsckWLdijtn8Tx0phO4cGzywmFEiyipZ5fF/UYxVrkriWxu5DuF5EqY5YHbAQaYFt3rC3dmdRvBiF9ylwOvkw28i4P6VFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu2vqfpSGOUEgE2QyBtFvickCWxM0Ihv8YUjSYxv0RU=;
 b=RAONRvYUgGkMvIv71jiziwLSH3HDAqlOk0Xn1Ai+CTorcXRCKpQoX3Y1AGoZvZIuLP7TD6wgIYxrUkbMe1YhalpVO7YdJBrdbuVsiJa/bBFpbW2QN5/4DXci+vYt4AKfJNuAn5idA1VDl/lAOuVZr1OSxjc7hXV9TfFK/dTyAOI=
Received: from SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::28)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:52:50 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::5d) by SA9P223CA0023.outlook.office365.com
 (2603:10b6:806:26::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 08:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:52:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:52:46 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/10] cpufreq: amd-pstate: remove unused variable nominal_freq
Date: Tue, 11 Jun 2024 16:52:18 +0800
Message-ID: <9278090e44050a43692173461eb7a915c123618e.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 52889120-865a-4807-ac76-08dc89f3df65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DR8YwJT4HVTu2tkH2putH83zpLkudkQ3zyszBzdL86bnC06DRNM66vPOKDdb?=
 =?us-ascii?Q?ME2DJbIz+Q/ovvKyubZzHzivOViSwBcipfs8aFImcHSFnWpav7PFpFSzp3z6?=
 =?us-ascii?Q?5BLcC5bQ+DYqZnOpbrgjELn7Z/dVrL4BNe53lDti0fw0TjiDb+YJlrPJfjSf?=
 =?us-ascii?Q?Iiyilb3VbljWvtbT3EVUrh4nRBDZPoHcpVO3Cr1/iWdpFzpr90oCDFAu+fzi?=
 =?us-ascii?Q?8liCwYkUIWh1eSidFiUQUCET+0+b/5Xf2f1p19LvKzftJKpVC3T17EZIgIcC?=
 =?us-ascii?Q?j/h6/DCqrv0bRF0KVOvrvXJzPJhc5eA4QzTn2PVsqa4axaJuigyIdxLyfC1F?=
 =?us-ascii?Q?m86fQkhrUe6B+qMphnnCV00L1iHTZBN5VKBpiyF5TvpeK5sXglCzrAmugXdG?=
 =?us-ascii?Q?TuTxjeNxpyr2LeZVqv+Rg/eUHvLqVbws8fWQ4rkyQ63gwDOGXNvQUALwqsym?=
 =?us-ascii?Q?Oe/ODhC9kRg2+5/7Pfrs0sMg8cr6T2/o4JkE4UMShozuE6UoY2BKeZg03dEb?=
 =?us-ascii?Q?cA9tf+j4O3VIdhQIqo1wTQ6ljB7+m74gz0fgqAn26ngq/pHvTB28JxPhVy5e?=
 =?us-ascii?Q?zWKI4Iz6XAkQIXWDppsN6XL7J3yDyC8RVynLBD1Ylv4krKp0NzisrVSjfduk?=
 =?us-ascii?Q?OjkPMY0L0kMee2DbMfV6SDtauYnJnAnxww2A22XKawjLzcDbTTc9dVuGHGH0?=
 =?us-ascii?Q?u8uvqv/qo/J7QrI0nnXVqtjXpYqnkbE78SD+y5rtp9oZcVH5mpsBVzkFKiiy?=
 =?us-ascii?Q?muJOs4J64p3vWunaW62DStbDBOwe8p6+MPYgwVCV3C3VpsU3N+Q1V3fELEfr?=
 =?us-ascii?Q?/mrSHax1r7XYsuOIOStACVoxHvgQkQq/kVJk/THaaO+jb1Lg4yNVuVNz6twL?=
 =?us-ascii?Q?hHGzboTXIJP4q+ndmP9fup1xson80gRyESy3f6PUt6WkNLarssIATG3MyODO?=
 =?us-ascii?Q?bRrQaJr68fFk4pJ2VNJ4VzVWz0FtJ3rFiJF5UvTUtBPy0SIWk5AO9tJsRBps?=
 =?us-ascii?Q?ZfWZNVrVPEbK8e2ZYsOgd9vtglhdA+RlNWc8F+j17N4I5b4ph62ZNf0zMkjD?=
 =?us-ascii?Q?3QIcZtbZjz06RmttkxzfSL7ouAVuz3afY1W8FQnxmxKH72Zih+S/foZaoxmu?=
 =?us-ascii?Q?RYNLZMShkBmcwyV//sToQo28/tCbNgp9wmaQ/lVw1LHLAt/CreBcuPO38d0w?=
 =?us-ascii?Q?MhO8NG7/DngwGIHsxIO7L0ODxX5tvBP5H7u4pfLzcdqMH1GwQhKnvx3D7MfO?=
 =?us-ascii?Q?gLczgbNdmrEiAmEXt4jP+RuPkkfBfI2zrJdzz2clE1n3jFUdGjaVg1dJG2jK?=
 =?us-ascii?Q?Hk0htjcx3lKpGY3cdVMjPm76XKCEZmssqtMnS0jvKR3XQqLtNwokLB24AHZa?=
 =?us-ascii?Q?RwRivNJK7733Oh+UrpOBAXBVL9oQ/N3MVecQK19cQ4+cN/vyIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:52:49.7027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52889120-865a-4807-ac76-08dc89f3df65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

removed the unused variable `nominal_freq` for build warning.
This variable was defined and assigned a value in the previous code,
but it was not used in the subsequent code.

Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 37fce0569d06..36b1964ca8d3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -944,7 +944,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct device *dev;
 	struct amd_cpudata *cpudata;
 
@@ -975,7 +975,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
 	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
@@ -1395,7 +1394,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, ret;
+	int min_freq, max_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
@@ -1428,7 +1427,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
-	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
-- 
2.34.1


