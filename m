Return-Path: <linux-pm+bounces-10078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E58919965
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2732832EC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44A161314;
	Wed, 26 Jun 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LrrdVFaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DB1E886;
	Wed, 26 Jun 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434866; cv=fail; b=UWLu6byCB3cOC6+//gKNuEcRo8TybYhmxOA3aXrCGDGu4GqSKhLn2jJHQcs7JBErbaoWoGMmRCC0tyi7KnwaZQlHAKDE+hJHQQb4nAYvcMtdtuNSSUp2QH4kRsKPtg/E1e2t3Owdajf9OPsEAOJ4KjSR+dzZ5HcuRYlGsTRvA1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434866; c=relaxed/simple;
	bh=nxgkacYRRSYwkBHgw5fbfGPRaTEKDU2zGpt3z/LDy4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lknqCoQoRMvzfN9/Lx1ge1R8JAtK9nSw2ad9fdKrJQ8krP7LmOFNpLjS8siLsFn5fM50EVZUIYyFanHOhBcTZLWr87aAJV6dtuklAMgPb6R5IjfP8hQdYHdKEv8VkQcXI88UWueHDhffUYQr0QZDAu9cA22SviwCjnpnwH92ezY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LrrdVFaI; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQtFANUsJsWa+M3f4+BPtd09UPjkdlkNBnytN3kfrk+EtzVOYKwlnWdSSHhIsO1N9S3d0rNgb4grjSC2gUynT8MuBAn9Dr7aDCsLfbHE+uLLOqshBet1bhiQv0Fnx7pboZZO5ZXkc68msnfxlGdnGQbb9JhP9bXvA82DfjgNzywTGkywxW9DA7dgbHQAwmQIheRFni4cXH4ECEkk7omIMkfjYOW+z3LwLv2t9AziUjieWQaWoy4QqD7oEuuc1phIMVpi+CBpoCdHGeaISOsKIpbgXWey/YbdkycJiHXbYO8jVRo28yMthfbbreSWgeYK0wFvzAvH5YanIxzgHY4CrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USjEuIYgyxlWapKM73a62DnjoFBKEaLKbiEGtS8lCA8=;
 b=LCeB6cxks7Oy8nd/Uwyywl1usy8hhYH6L1DIgjlgz2/u+UImUxpUY3Jgox6KqMnvTg4OcaMijDLU7f2Sm4S1y6AQThaIyPx5d/iZxy0p6dGvu9buWRwdiLkEmjtbeSokR9D0PwWR/bCkB1E0Bi3BHrZSMF0ThEtzou8hJqcjPKzoYwBeZf932MW9PLKF6yn7Vved/U59ZMKBJk6/54/HhLESnx4MhyU3ozztmmxOTXchVqZ0+hFjKCouZVk0Lu/fCp7T4XieCPYaLZfwJCBgRv/LKk/hAtug72IAUKwc9SnvR7sTVv80OGGcua4Zfu1RcyYLaSx8Q9iJ6HnHZTY5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USjEuIYgyxlWapKM73a62DnjoFBKEaLKbiEGtS8lCA8=;
 b=LrrdVFaII7Vh8AdYoVKjv1vAVKE47vpfWBhSTTKcbvF01UOhqFtIc0mSW0MxOlYaIP0esikOCkgJ4c/fv7okjCzep3noWK1hw+ZzD1NYK9SYps/kGGY1FR8uW+0yCqM/r5wgPSY05exqlkPH4b/yFMwvb2rLxXROxS6SQDtVFVo=
Received: from BLAPR03CA0120.namprd03.prod.outlook.com (2603:10b6:208:32a::35)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 20:47:41 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::36) by BLAPR03CA0120.outlook.office365.com
 (2603:10b6:208:32a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 20:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 20:47:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 15:47:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Sibi Sankar <quic_sibis@quicinc.com>, "Dhruva
 Gole" <d-gole@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Yipeng Zou <zouyipeng@huawei.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 1/2] cpufreq: Allow drivers to advertise boost enabled
Date: Wed, 26 Jun 2024 15:47:22 -0500
Message-ID: <20240626204723.6237-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: a368f5c4-e92b-4917-f6f5-08dc96213902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yf3AIjmtwgRUns1SM+6dK+fHntdEJqKprIUNthTgK3Je0EjKh42yaa3S+p7N?=
 =?us-ascii?Q?sDi3SWc5IYjcXLXvQL6RdBgrW3GB1XTXteLW3gw2On8OUuY0mkY1dHpJPZZo?=
 =?us-ascii?Q?RUM2nrKNEBzT6SvyAentmAGirjcx9RY9t2wTEuzpv0YsVMNCcWkkVm1JeGKY?=
 =?us-ascii?Q?je5fHXhAzLRz0rC6UTLp0i/tOW3XDH0NGoSsSXyLhhjsr1jAdBGTwmj1VpNn?=
 =?us-ascii?Q?Gb+PUq/uai4sj3Cr6Ls2jSekIl0xQFWQJid44BMYGo21golm1V8kzuCVsFH4?=
 =?us-ascii?Q?sW4NOOECvstK7PJgxArTLucjMcSbvM7+GAiQEjo1QHkOslvKj3NZjUb+Uk1H?=
 =?us-ascii?Q?15ZPF03ECrJkIjbg7AupfiIHsjRuwgEFITnkkCRwhcy2CVJjHWcgG6oulo+f?=
 =?us-ascii?Q?X0dzqjq+SgVaMfvdDXkZiFDdmv/epTz+ehFXQnZhTazI9TYBQn/tox3MrKaB?=
 =?us-ascii?Q?DVgGlTV3bGXwqiZej/1sQSPjOeA6Kj9qLSZc63hI3h49/dpbKsb4rmTiIR+7?=
 =?us-ascii?Q?+ceB11SyM5xi6onAImsvwHjWbrvzVY6Oa40Yv2l2E5hVcyzyyB7Ht8SuZrlS?=
 =?us-ascii?Q?mskj+IFPBt/BpZDz1dHXgg3UK6NarImrqNJTSucEMfYHRN1yx+FrBQkO8RpY?=
 =?us-ascii?Q?PI0Za60Yt02DooC8EVmkCQugjB4kJFrTB1LIf/AKuaCyITTjNjq859diGZ9b?=
 =?us-ascii?Q?Uv0MOZTlgsYfDnx9oHxzYDXwo0qBofL+7WYxRAB3BUaIvMJLQw6ycn3VqXVV?=
 =?us-ascii?Q?h2MVjoIE3BjZJG0m41Kcz249uiYvBh1UuFVWLWDx2DeERCn3ZahBF1QhqqbP?=
 =?us-ascii?Q?DSr9iXR9na8MThJQ/l9Z/HnNXoFD3H3J/g9czrllqM8Zpd3pBYKFzA5mvfdz?=
 =?us-ascii?Q?1tT9uvn1RI5oQSg5+sLZQYTRV0i8qDWtiuRJjgBPzfoF4Euw9yWJGRzSrNas?=
 =?us-ascii?Q?PPH6DvZ8mxHp5HIAuCS3gTl6eJbg/qmSTGHfyBZlnKry22nRNI4OyY3RlIpE?=
 =?us-ascii?Q?HYtcoEeSWIYBgEZ3Pqa7FEcRcDpUxde+lcMHtMYWLcyGL7sWgbKRT5bDjw8P?=
 =?us-ascii?Q?fnD0Vd42tYMzhmAvpcqJkAa0ZnEtkV3tG4Fp6U3Mo1CygaWJ4vFlsaOZick6?=
 =?us-ascii?Q?ULfT2DWxf7wejowy3crd1YUVdSEvUKMyBfUXEj5cjb+LKpodzI3Bus6DzndE?=
 =?us-ascii?Q?FabmCjzwk3/3H5PrAK5QHDhlz49IrjQEFUPcM5tJfi8aYtg5SlaSQLSLz4y1?=
 =?us-ascii?Q?KSsSyH1DdRKlNnIWDdGXbu6yRRvAq2bgEoIeN/INhpFB6Pm7DU0LVCO/O8qP?=
 =?us-ascii?Q?wMiKayoSzm9noblYWT25nxbhAiSDIjHniuCwdoyjohp7wmccINCNR+vk0cXx?=
 =?us-ascii?Q?E0/UL92L7+OGuXwgmEJ9b/dDXvkzJxiFCk9KAxhLdxtbVikAJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:47:41.3725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a368f5c4-e92b-4917-f6f5-08dc96213902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
policy incorrectly when boost has been enabled by the platform firmware
initially even if a driver sets the policy up.

This is because policy_has_boost_freq() assumes that there is a frequency
table set up by the driver and that the boost frequencies are advertised
in that table. This assumption doesn't work for acpi-cpufreq or
amd-pstate. Only use this check to enable boost if it's not already
enabled instead of also disabling it if alreayd enabled.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
v1->v2
 * Pick up tags
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1fdabb660231..270ea04fb616 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
 		}
 
 		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
+		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
+			policy->boost_enabled = true;
 
 		/*
 		 * The initialization has succeeded and the policy is online.
-- 
2.43.0


