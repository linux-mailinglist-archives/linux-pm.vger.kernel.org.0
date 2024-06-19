Return-Path: <linux-pm+bounces-9607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B290F276
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F7E1F2529C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB315749E;
	Wed, 19 Jun 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iyZw7Dtu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5315748F;
	Wed, 19 Jun 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811668; cv=fail; b=GxGBi8wqzrr5DYj/inW3dX8QVp44o5iEUmqOaO4l2FzRyQ+X0V8SqQmte8zLka8Fc39TY/thnIq4J2IokZ+K6rFjJNaZawEYzuCiE1ASbFhKr1O7IeeLXM/9te/UvWzxnb4x+nZ+Pc3DdmNg3mvXvA1Z6f0gx1aYbe2eQUigyDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811668; c=relaxed/simple;
	bh=MqqjjlbpEoe/hMWQmt5e6k6TkVxL9smuKXDQll/cBn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yyzn48nBUAHgkKSSbPAOqIKwol7jYO801a5wCrjkZfkhNz+los/w9pwuTpaBPFTGzaf4SRPd9Rfhi54y3p9m42COzdHXV39TmRK+HrcChbQEqoXpAZ6Om7DkD5SwI8sZtVA7WCFUCy1KsS2BasFWyj17NtRdDwZOz4x+q0sPp34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iyZw7Dtu; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5MkfFIDdQszmgDzTVnXoSezLVN2H+MafUvRdpn7GAcUsvs+LInyJGDZbIGUm8nu/EmFItYsTHaUTzquaPjnX81RKBhModTYxKEFVhLbJUS2PDEh4pgPFI6cY93epZ77nUuwYUqHLsfgzJAcfjxOBiV6OczbJ1sFFco625IGZEtzUiYuZKmN5Lpj+hAiKfYzYihGLjRtqVQIQHe1fr9X34lPJ+40OPOhJhdL7xXSFKZidFh8XuQ62JEoQdTQexUVDEmIRX/YctWhVeyCnUPhgf0nePi3t4V2fBtqFrQY9sh0dENXcZ+ihkRq901CNYQxrDimZCTq29uTZpKsitl+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7FMMGVltoryByZHgzUsMpJIisVaRGm1ZelwyRhPK8A=;
 b=Q8ZiYpnYE2ZOOEkMlYvu1SegiNERoIGtTLCIEr9SxB5BZ5owCjqjtQadoFN+mpZbXxbMD5hptA+XirdRxw5wgyfEFcUNumMIAfD141P/Ok0juoO3viK/JUgJAIUlEBhgNRQn7iL0giqf+wbANwYkMj+SbR0pUfCKyVSktac5CNaPNe6ma/M2Ln5IlHTXiSgy4vqr1YhrtexA84007uv35RjJ3c1yh4JlpXP/7TInVGkBlfcXbnvuDZuOQ8p7v9V3UHR7z88AbiBPJ5454ZQNaz6oxDC9zm4kdGR23IOGP9NIUnl+57bprp11XwlT1xnfB7S29mAQNMazau9lUR8bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7FMMGVltoryByZHgzUsMpJIisVaRGm1ZelwyRhPK8A=;
 b=iyZw7DtuCm7H/Rx9wW1PZgXCg4b/IicOR2XOkiEi78UXmSnLiW8xZTgzwamuOM9YcCpZe0hrdpBf1RFA/6L8NeOsYUYPVpek8E7diWjCO0heKQNnypLJVo2mKHspQzswKw6XTEmzWED3RjBlSgNA1auyOLeky4Vp2BC32pDSjvU=
Received: from CH2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:4e::21)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:41:02 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::97) by CH2PR02CA0011.outlook.office365.com
 (2603:10b6:610:4e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 15:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:41:01 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:58 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 8/8] cpufreq: amd-pstate: auto-load pstate driver by default
Date: Wed, 19 Jun 2024 23:40:19 +0800
Message-ID: <83301c4cea4f92fb19e14b23f2bac7facfd8bdbb.1718811234.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f4c0aa-53e3-4077-7b0c-08dc9076392b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xTOO3/7lahKNI/8R3brmm0cwc4Kxnd16XuRPBkKfPO2xg6gvuYSKarrfgtR?=
 =?us-ascii?Q?kLRNfq3u58YbY2486hFOq58Kr0vopv14RIA+ABNFoO4bgLr3JpvtfHZS3VYJ?=
 =?us-ascii?Q?Mr9/xoL9xQJuTUuQTa0EnaepGRpYcYZ+JGYqQjY2v8Urg0LT5S/NKAMFUbN+?=
 =?us-ascii?Q?WUlHzdoGn+N5hxDxSlYQdgzxCyXVJtfKVpjEsHS4Z0owwEEupkA57Jb8iD2L?=
 =?us-ascii?Q?Hi1ZMxprpLoWB3HnuS0BaQQQhXGacPjSQs9CWCWWt3dRVC3UxrMPBSB9qcxY?=
 =?us-ascii?Q?KLm8uRj8T0WJFSj/TYSQhm/mCtDBd3vRv9/LM+QOljtO3FF2ZTih+PKe03SE?=
 =?us-ascii?Q?wURUms/c1TfsoLOcTK9jAssAGx4+EP1WP/XB3hFektvIuZuoDaOpb++aFP77?=
 =?us-ascii?Q?0SNOEKYoORvjHM/6ACs8XrleUZhR23ei7QKCxu8TbEaJ1GhAMLkM1ARoZE9z?=
 =?us-ascii?Q?JWGmHoY+05VqPuHO0r7VvaOUb0AJk1lLMThZahFHkwcKT+NPOZTAcd+mk/27?=
 =?us-ascii?Q?1mUmbonhh0K3+xwZS4zxDGI1clie40qw653oJn4+e/ptVVrUHQYFic5QAM9s?=
 =?us-ascii?Q?1sIdHeAj5gUSXRhrW7BtlcBV6oFXAbJTENiCP87YqY8/flOE37xuEmWwLRws?=
 =?us-ascii?Q?CVaTht/tD5pWzHlNJioQd++jkuy4SQ6y6fNADmWOWTRp00knN6lZN3W4EdAM?=
 =?us-ascii?Q?MmbVpWqMHDeycLx/2lkPze9DH1HXZ+CAvNTV5RvS0b8162qY6mdmIAPOA7Ka?=
 =?us-ascii?Q?hAIIQwlCAtviI3CXAHyiK6Re9ueCwNIJRK1WZklUmdLEGTUs5HyYRBcjoK33?=
 =?us-ascii?Q?B2TUy+luOqkhVw9HNYbvc3ZqoMTvQ2nmINiU7/Czz5Gf4CkAcJaANKv8xYP+?=
 =?us-ascii?Q?wHmnIjUpN5uTCfa0LC6i/hJX8OfXFzbyjlNCykHPZHn+vr9sXf74mui1MqjL?=
 =?us-ascii?Q?zzLoFhEWEIKRT7qUEiE+9Gej2+IvF0WeGUcrAsrQ2eshtZCaQ+Bv0VyuWFtc?=
 =?us-ascii?Q?6+kV014weqwQUGSQ3NYaJRhEc0FUOOvYQ8mEYaqJUf2Rr5xTnCOG3gWmD7uC?=
 =?us-ascii?Q?+PWERv/O1spi8IV8yRANXjevjHXbcpdg05tHg0O3Pm1Hc6t2zCWy9OJxVl1J?=
 =?us-ascii?Q?K8dQvh+jU2Oryc6pS5aucNv5DLGnWP6LuWQCpDemLx38LpCgyc/I7XkieDLs?=
 =?us-ascii?Q?zch2GLVNvJAyNKCLoAa4m+ZnRXIzfh7vNkRRni7Ukp2fXnXPLT1kFHPcQuOo?=
 =?us-ascii?Q?fT8f/IhFdzXqrxiYpgiyy6mIJKVbU9RVdzCk8CNC6MAzhTAVNz9VratQSnrm?=
 =?us-ascii?Q?m1KxKLN2lqugIT610cnqddRKwBq6RvgOWQOvCyfu28b/ebMXyxWwJ1lRREFX?=
 =?us-ascii?Q?846FC30=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:41:01.8521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f4c0aa-53e3-4077-7b0c-08dc9076392b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

If the `amd-pstate` driver is not loaded automatically by default,
it is because the kernel command line parameter has not been added.
To resolve this issue, it is necessary to call the `amd_pstate_set_driver()`
function to enable the desired mode (passive/active/guided) before registering
the driver instance.

This ensures that the driver is loaded correctly without relying on the kernel
command line parameter.

When there is no parameter added to command line, Kernel config will
provide the default mode to load.

Meanwhile, user can add driver mode in command line which will override
the kernel config default option.

Reported-by: Andrei Amuraritei <andamu@posteo.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218705
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0f8ffbc0dc2a..a96ad7d10a4d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1801,8 +1801,13 @@ static int __init amd_pstate_init(void)
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
@@ -1812,15 +1817,20 @@ static int __init amd_pstate_init(void)
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
@@ -1841,7 +1851,7 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable with return %d\n", ret);
+		pr_err("failed to enable driver mode(%d)\n", cppc_state);
 		return ret;
 	}
 
-- 
2.34.1


