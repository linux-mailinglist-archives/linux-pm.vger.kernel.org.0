Return-Path: <linux-pm+bounces-9289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69490A659
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D561C2155C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3DF19066E;
	Mon, 17 Jun 2024 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P4XR7a/o"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA619049D;
	Mon, 17 Jun 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607653; cv=fail; b=ZF0ZwUw5lgRgDCnv0tpK65X90CaAOols+A6pq7gwwA0kvfbDIxryPYqqIG1SjLscpderfmsyNr0H6w/Eu0+4QiT0nvMWFnV41eeB8VSSZ1lsHnCU5Up2QjnZGhzbKosaxAsbOUrCvEGWElL8JkbU9Z5zcO5FIjHe5HRNAZh+jT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607653; c=relaxed/simple;
	bh=GL2efB/2PBLNHfflHusdOewRCRF3vzG/5yhNrrRDZW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLzPN7Rjg9rvdtENBk5U21NJPES8RBqe9zqFibCyPf2qXJACN3BkxKCybrnYgsfDuHffDQH4M+8JmFxQzyiAf9UIYUhQbiRCIozbe6Y81MYGIt96Ar95aA2vJbOOXdad+Ur46c2x3ux07YAjy0SBYexzDqZgjixl5riEW8snvAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P4XR7a/o; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpEAWs4hjkxXxo3ydZFWKdY/szCCUyGyUnCCgKbeHO/1+8urEozE7t5Cgc1Iwg2SgCVyp+uIrQX7B0UlicezaR2xhPWVGQiNzeZTzrV/UjQqr7JQKnYGb3cWu+X9AE+nG7D1EqQ8ZP5Dc+cfnwiQ0aEgQlOseVAfEaT1UryD7CxzUsluYp3nYiaT9WYT8FwzktedCLyr5b8Vvi3GadQBNOQL9o9exZkUieu7WIT2Y+cewOnQdYhBs3vVDHavyAkdbOJ2vd7qOuW6ejFhMUoU6ztwp3yI0Ouwm1hGWTxcFa20yMhMMPdqjn4fW1uPH+fJfll8G2Y/TYjMU5ctJq1HHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKbAm8NYAxJq5S5T2C68cJXzedNk+bP6HiFR5mkxFkI=;
 b=KXyn2DjQR3jmXjr/UxhpiXh0w6R5zt1FyTeYUGUBtJeqX7i3UXzaQeDSrOnh5/Z9aKfF3Sa9tcpp9RAy8tyFijohGD23ONpI8LiYWZ5AmAs6TuSZbiIPbjESttHO71nIfyYlaIFPXx3yTR6nqrdeGhI6cqDQDHeMJc+OKEbrJYbPPSdE6wRo/91rm3ajEBYHg0LJOKY2r8uEXqhaNHFA5m9/Dbpk4TIwxhQYmrvWGm7yForl8Ey+iezQsq40Sc3veuTTb2RuM58VdtM9Gs08sO0h3EItCZkgs2el2WT/0lM+PBBWdgW/ahNKsnBlpjyLLeDDqYJTYQi5HUYRR6Eyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKbAm8NYAxJq5S5T2C68cJXzedNk+bP6HiFR5mkxFkI=;
 b=P4XR7a/o0JZNODWCOC5LkfOuakZEoKMxR/9xwGnm/mv4GMwQySxuQXxtmub2j4HmCbvnhY2uHZ4BIjkKvXzn7Tri0OKMifoQZRbkSbrJWi4S528GeQ7N8SVqZcA62SBO2/xiam6tUvWWR9QSYdo8YhfA+n5AD5uJh+0rYbbAVL8=
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:00:48 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::be) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:47 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:44 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 10/11] cpufreq: amd-pstate: auto-load pstate driver by default
Date: Mon, 17 Jun 2024 14:59:12 +0800
Message-ID: <0a4699e224e1931c09d6ede2620d585382b7d168.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bf42f2-6f9b-4071-27a5-08dc8e9b376b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?weIoQJ/IPF7sysBWwCPx3EtjzVBJov2FUwot+pVrv1qJhbmTz3MmbEntIVUm?=
 =?us-ascii?Q?ul1pxqW6S4gXJZOclTV0QbKKTqA8oVXLlNfdJ+MvRAdNk/Kq3nJcmfTgL3jX?=
 =?us-ascii?Q?kZsOE9F+up4kPQ00nbgjvaiHtwMIaHwKSgI86DNoIc4tBnEKfY/4OtXZ0oY6?=
 =?us-ascii?Q?FNdN0U36Q3ioi0v3eI9IlNYEc8b++iStyamzLkoJPT3fwV/sJVA7vvas8KfS?=
 =?us-ascii?Q?NwTqnS1/tYD33dBjW9x381/cpdfAQhVtaU89x0gPIokn4ccePE8ShhORYF59?=
 =?us-ascii?Q?NvPa2AGB0b7UobeE2mgVg8GfpfRawRvmYqEf1kyIa6Ye7yRIEM9dCTmlteoz?=
 =?us-ascii?Q?cBb9nd+kI+WfRfS8mIknFP8YSQD/Vg2fIX4xQhi80lg2Eniw5QbSR9UT6t8x?=
 =?us-ascii?Q?yHOkihWn6hG6iWL9GhJNEcSXslXpXSgG5kojMktXas+vlcqS7NQswv+1Y2Tr?=
 =?us-ascii?Q?X3jzglxqIuvF9xM3xLIeflmswjqt9hA2Wlk2A64AZdB0NrQokF9mFihNXwWo?=
 =?us-ascii?Q?WGPMrfrHoMTCwsINbA2rHe54aFD5TYKjgHIu2+zXMuYWwS8d8uKzqYKbPkUM?=
 =?us-ascii?Q?xWekGuALvhSCOevLrhonK4uFSIWUrgUwgRMW1sPwby82i8vEURhgVPEyNEgS?=
 =?us-ascii?Q?lqW+7efv4T1jC7j91w449d8Poqbf4Ic4HoPC4TKOWU1dTH0wHWDqduDgBeig?=
 =?us-ascii?Q?JGKH5X5q4I+FJsigsCendBdKEo/abevPvguJxoA0JA+WnVimrfuSlybg081d?=
 =?us-ascii?Q?ZuJfHVsr2sNgOB45CBs2L8JR7pK2evvpATIbiLyJvxY1Rh//kkXQ+H6giNWP?=
 =?us-ascii?Q?pV4Nk9ctbnTZNoQ/3FjrXSJz55ysdAjNmFtVFrMJxKUsE4XHck8JjiLOLwRJ?=
 =?us-ascii?Q?S4mzKq8aqJfSZVYC+QlvBAOwgiHdeBcqbfjYIts6ZcaaW6kucoT6X8jP6Yb1?=
 =?us-ascii?Q?OveLAieBs73zYAEZ8yktapxR/7FJGAUPxDJ23DqZie4dzwVulZHgU0n29Dru?=
 =?us-ascii?Q?XWU8Ll7MbQOFdH8Mx+enmwV9O+pOCKYsXyHnLL68kpZQ5iaDU+P6C5snaJtF?=
 =?us-ascii?Q?imzRPA0CWOCqp2Fo1yWt7YVaFTHT/0pbGctKN12XN7ro+HBujt6+BLbhvi8y?=
 =?us-ascii?Q?dRuNu10XyLMNvd+JRe51xEBqRkqAyDxh/Lgyu56r5jmJov4GyZ0lZ936PEP3?=
 =?us-ascii?Q?hPOnLOySZAKMwjX/FjO2lwYJmA90nZzbG0W5QPzkH/ACBp4Lq7BQECLkE9u5?=
 =?us-ascii?Q?jSJyj2+BZYh9pI1w4FV/gfsS6kLzeNB2Lxsz2lE0vZbwtADK6sB2djjsU+Xz?=
 =?us-ascii?Q?dO+YHmFPvlsmThNoVyNw1b/06pYQAdal5n0UbuLY4ED6Z1T1NbrnOHB3kAgD?=
 =?us-ascii?Q?TJjUj68=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:47.9518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bf42f2-6f9b-4071-27a5-08dc8e9b376b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

If the `amd-pstate` driver is not loaded automatically by default,
it is because the kernel command line parameter has not been added.
To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
function to enable the desired mode (passive/active/guided) before registering
the driver instance.

This ensures that the driver is loaded correctly without relying on the kernel
command line parameter.

When there is no parameter added to command line, Kernel config will
provide the default mode to load.

Meanwhle, user can add driver mode in command line which will override
the kernel config default option.

Reported-by: Andrei Amuraritei <andamu@posteo.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cf68343219d1..b48fd60cbc6d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1857,8 +1857,13 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
-	switch (cppc_state) {
-	case AMD_PSTATE_UNDEFINED:
+	/*
+	* determine the driver mode from the command line or kernel config.
+	* If no command line input is provided, cppc_state will be AMD_PSTATE_UNDEFINED.
+	* command line options will override the kernel config settings.
+	*/
+
+	if (cppc_state == AMD_PSTATE_UNDEFINED) {
 		/* Disable on the following configs by default:
 		 * 1. Undefined platforms
 		 * 2. Server platforms
@@ -1870,15 +1875,20 @@ static int __init amd_pstate_init(void)
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
-		ret = amd_pstate_set_driver(CONFIG_X86_AMD_PSTATE_DEFAULT_MODE);
-		if (ret)
-			return ret;
-		break;
+		/* get driver mode from kernel config option [1:4] */
+		cppc_state = CONFIG_X86_AMD_PSTATE_DEFAULT_MODE;
+	}
+
+	switch (cppc_state) {
 	case AMD_PSTATE_DISABLE:
+		pr_info("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	case AMD_PSTATE_PASSIVE:
 	case AMD_PSTATE_ACTIVE:
 	case AMD_PSTATE_GUIDED:
+		ret = amd_pstate_set_driver(cppc_state);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
@@ -1899,7 +1909,7 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable with return %d\n", ret);
+		pr_err("failed to enable driver mode(%d)\n", cppc_state);
 		return ret;
 	}
 
-- 
2.34.1


