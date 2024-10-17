Return-Path: <linux-pm+bounces-15849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B744F9A1F6F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0F21C21404
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240921D9679;
	Thu, 17 Oct 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tSiFOr8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D91D89F5;
	Thu, 17 Oct 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159647; cv=fail; b=RbURD0nAlvhJiVi1tCWes9alDMnJsM4vVRa9YWLm/YuZEun+h1+RVXV5df0x2ek+dUE1HhsYPUUgAIoSRxpmD9wSvNzWIuFbUeX9vgcSmhllHYBM41ilfRme14dryVcJQeY8bQfqczUNoO8eAqbHhKtRsH1oChy9ULjDhZF9wqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159647; c=relaxed/simple;
	bh=aEyCR64eDAWG6JAglbHOR/9g4tGl7WqfkHzgL4yFnJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATVAb2wFYARQH8dBwuCwMXFbTWFDB17nr2AZuoDL9rqu2AIMB0uQsYdu242npwO/28b75IiDFMGfgVVfvIlUonU1dfgjzz39O6WkGiVTd4Cz8RqRLNFUxbatbRnkkJ7SjHKuOiMkQhurlMM5C6bBvzdyB4e3wfU48R20UBu7XEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tSiFOr8A; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwQ/6v6931LLOVoenC5LJiaQ9IyCD+lpytzPuVHjnu8p/hsIUkIgmB8bEzIgfT+nmDmNwsk3stuQbYcuot3KQ9RBjzwqLVnaRm1lmxsyjkLVpsnFddHcAW5tZlk2s6P+K0hqyWsXdB08C0+9JNeS1Uc9f8zzYKLDibG08ST7QcihviKB8xpJepS3HV4/GXMM6SyF2Nx22BeiZfvCFDvIqoeyMnEv2opVtxu6WclQ9FEdH4PLtUh/32rhydjX04Y2oaxuBQC5iS+k4RO/dMp4vTuc/hMyrhetgBFgKwky3pen9jKn9i3u7oZx4tzaHx2HIWOC7uSYdl6tgObQW7Fl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8KQgEi9h2Fbcj/8I6vq0G04ump/+7AMYvEJ0TyYGr0=;
 b=ZJDEQW5vdhM31J1KBxGIAlN/xwTT/Rr+XCLNbVgDPCuqkAg98Z6+HLKJStmnlJKGLv/wvu56l3M++zToCteAIb35Q5szIyRNtd3KXqwpcXPFaDKYAcxx67AS1Drc67PwuiQDJqonVJnAJ/491fqVjGlX0VwAmoQliByrilKNd3c47SiegP271CSO0zc8h3bN/RQdQeRksGQqCzyuccxihk9PXtoPo2lV0F4vAat8NLksTB5LvjZhjrqo71Yc2/OThSLQy0l2BxG2aenHyxSB7gg9D7YTYQWPc0r50hklJ6w90IqLdShi8fZ0SfKyVO5awfcM4RyP2Newxsz3yCbYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8KQgEi9h2Fbcj/8I6vq0G04ump/+7AMYvEJ0TyYGr0=;
 b=tSiFOr8AP/nAXQJn3r0A1yfeIaGslXsucvwEtIBcRavn+GeXRFwxIpm2ZNvLX8xsU3n897Ip53JF3zfVA0zgq0hzUR1q3iHEZf+2fxP9syvbRHMu73/Kwinv2LCz/vWJdBuiBZL8GHIhaEZftVw0SJRAbhwXH+KUwXfIBOxwtoA=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 10:07:19 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::3e) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Thu, 17 Oct 2024 10:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 10:07:19 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:07:15 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/4] cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
Date: Thu, 17 Oct 2024 10:05:27 +0000
Message-ID: <20241017100528.300143-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
References: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: e32fd990-532b-4055-18e2-08dcee937c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFmPJYwmky/WWDkD3sKpZo7chRo9sOtDU0hTGWq5kC1spd5TseeORJ/lwHct?=
 =?us-ascii?Q?3wdOHwb5M4K7o0ppbGdoqou9YDqnfQ/L+TpCWF+3csCUTQBSTSzoC5kdG6Gq?=
 =?us-ascii?Q?dvN1XG8AMKNX6Xhl+fRO7pfTLRQKETiAKSBrPVVAy2x1ifoU1R/sZCBPMZ7M?=
 =?us-ascii?Q?4NdgUty9Uk+7rZPUvBohC5DkS5X/7WOXVzLl+60tK0TwcdgcAdUO6FdYw9on?=
 =?us-ascii?Q?8wfzpRITzlPl8ybQRLfd4ZzeqMm7oP9AheiN/6KiLR2ZU38N9wC09mOBpE0k?=
 =?us-ascii?Q?4SlOrxbIIlR99bzRkmnZfC6qALu7MYnrazheQj98vbiNqsvUqoyWfSOibGdj?=
 =?us-ascii?Q?rc5nzhfEorZrEy17BMioL/34Hv0KHj7X/jvDGiLpBq4hZqsveuhhMc2zmat0?=
 =?us-ascii?Q?+TV5t/MMmeQPyshgn8SgSG289GdjuTbDfNaVsUStWXXn6EJqaL8PNTnUH7I8?=
 =?us-ascii?Q?O2n0GMEGFUQZUAjuNC3M1NNPv9QhzfK3BA/ZYGRxfRQzQfJEHtTs60TM+6/A?=
 =?us-ascii?Q?BfnK0skdzN3QGcESoFU1N1V0UV0LRPsTZlt6LIFJxeYXrvpyMM56JPcaN2hA?=
 =?us-ascii?Q?j9dxZdgglJ8TybglIdU5mVFk8Mt6C6UrTNU8xGqFmOqivc7zLqsdevTMRsJp?=
 =?us-ascii?Q?qKb9SWzgqpX8HkJGx8IRJsIQHs6wrWpKUyaskj+jHDk1eip8vJONLa6rB7MP?=
 =?us-ascii?Q?qDRaiYoPUuDFxDZefMMR6yNhZL7H78ho7gFJs4lXSmqzO5LMH8lVj+jMdvNG?=
 =?us-ascii?Q?nHs2b4iJz3QQP/Gpm7sgv9eizCxXKUylm7bKjpQZQbmMADkT2VwAONH0o6y4?=
 =?us-ascii?Q?o5hz/JZqrAOPbGVmKiMaoy32OjZmJQXQSAYofyz5uS+1XTNpcU8ZokzTChgH?=
 =?us-ascii?Q?GetyMo4nmSB2dEnMffSgGBZ3kXdjpi84bIV8jUiO4FiMVD+Lfa/ZMTf75ruS?=
 =?us-ascii?Q?X0mFeFi0u/wLbslprRAjQLTIKni246IrD8gZInnizP9Bqh6jKB6OAwi/UUyp?=
 =?us-ascii?Q?KIx6z31sh6jCsYoO15PmnaASOOT19F/U4/KvIHIb8HPlJ5XTAJjE5F0d7peG?=
 =?us-ascii?Q?XoaMwgICbCYkfJj8GP+XUX33hzM1PxDBH0sAB34oRMoCWTPtaX4vRlOjMVK4?=
 =?us-ascii?Q?zik1l7vIq476PvlL8SWJz30EkmZZAFonXjmRUNH5+u8rvQurtO6fKKlKTSs6?=
 =?us-ascii?Q?TUyYeWY4vpNgtIwpw/Uwu4dIVTjvVcT1XalZWvl89M2x6ZPAwk1pyuE8W06h?=
 =?us-ascii?Q?z08y7lLCl8AMlunZBdGr9SWTcx/aKPctQ15capRUG3JWkvBO9xBiyUB1zjmM?=
 =?us-ascii?Q?QFU3VlBWyc7+a782luy+qev+Lz2UxtMnDMSYC44FBouHokGomAITNn3R6xyP?=
 =?us-ascii?Q?U9nML8J36WtwRxpLJOf46nc89Cowln7MuhLYV7RbPOrvgKiEnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:07:19.2823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32fd990-532b-4055-18e2-08dcee937c6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

Replace a similar chunk of code in amd_pstate_init() with
amd_pstate_register() call.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b0a1c472cc3b..856f0d11983e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1879,17 +1879,10 @@ static int __init amd_pstate_init(void)
 			return ret;
 	}
 
-	/* enable amd pstate feature */
-	ret = amd_pstate_enable(true);
-	if (ret) {
-		pr_err("failed to enable driver mode(%d)\n", cppc_state);
-		return ret;
-	}
-
-	ret = cpufreq_register_driver(current_pstate_driver);
+	ret = amd_pstate_register_driver(cppc_state);
 	if (ret) {
 		pr_err("failed to register with return %d\n", ret);
-		goto disable_driver;
+		return ret;
 	}
 
 	dev_root = bus_get_dev_root(&cpu_subsys);
@@ -1906,7 +1899,6 @@ static int __init amd_pstate_init(void)
 
 global_attr_free:
 	cpufreq_unregister_driver(current_pstate_driver);
-disable_driver:
 	amd_pstate_enable(false);
 	return ret;
 }
-- 
2.34.1


