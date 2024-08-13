Return-Path: <linux-pm+bounces-12138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FB9501BE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084162813A4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E76184537;
	Tue, 13 Aug 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HsofGCG1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3916DEAA;
	Tue, 13 Aug 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542940; cv=fail; b=KtdvBZaJgDY8YaMiYEHWXFbfPcA6LS2XbiFOfsFaPjTy2zi2UGihcgxgJcqs256IzShiBbg+7BjUWgfOGel/gZevOSWp97KHkH4tjt2D35MS38wVfu1FtJblNQFA0c8M9u9p0Ij3m+4jDmMf38LwxQm9Sa7mMZjfibN0J86owLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542940; c=relaxed/simple;
	bh=RRjru+KP4Zq9XJzDoL0RpSfT/fnt5p+JQ5eHEXqNUkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJm79hq5y83+uuJHRGB6UKJKtY0md5Wa/yuatNWcv1s3CxpS7xhjhvr+lOJN4e7+Vl0Xbb9MRryTBI0I+KkRosLQifSZBUZ2q5AMMCDoXjg7/H2S+lCODShUengAVOu7gCoMLxsPpE9CwxJ9E3it7LLgzPduwY0viqNYHKH39vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HsofGCG1; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ka02kog49Xw2/B0rWePMMhG4FOOMbAIMuwMql75w/Rffi7h5sltggyeB/69mlVOR4pWSenR2pD1Xi3inBisBhGEsAlycuUASMP+mlDQIQZxnnkFmP7/EG4xnVxpIKjDwb2bVx+u3nPGNNHQA176+MSOjrQeImEOrxALUZ+AE+KudiyjkzPTrNFpBW4PSgBmD+qmcp0Cs+sRBVmNRbUG6b7mMElU9ZY/Pk87EGPxa8FBYSAhwEjCtpNnewScLD5U3KTtt5OWaXuB1n6aEBx9F3VmmuFByN8n5pnU7aSGmEWJp3G5mXyqJTRbGjS/uG/L3CDgL1B7ahrbO3nvqgNJahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhZwVD3hKwQ5Z0IB/kRLMzCGJ7bXOzagxFjV/8oy7HQ=;
 b=SgwGEVp/m/ZB7cKhAc185Ppo1qxQOq9RAmz4BZOKLGDmYS9v/sa6XE2bwKvVs9nzroxXmC30SD2iU45v5z4Y4sOnyt3Ezhf6RhA9zRJqrI5nanPTEfU35BZtmkrypdmxedFr764PYkttPwdurpvFUEdcI/9irSkonbEz00gwdID1Rx/XG21eiUFyEnW8bLTjMGyuDL44oylTO4R/abbcHASL17nKk/lkUkgc66bCLn01BLOA+GHXKRetyJDd8axKWMyW0zYUlg2v9lxIp1oGveym/4CYNewd3q4JyyU3bUslMBPwu9zimmfqfASVBRh9mV/tpK+O5sGwJcDGbLfoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhZwVD3hKwQ5Z0IB/kRLMzCGJ7bXOzagxFjV/8oy7HQ=;
 b=HsofGCG17G+8bjcIqvwdQChd1iCyWVl8GQPvuwlms6HKrY/N4WHwhI5puAEMh+G5Po6mntQ1+l6dVGjijIEhCTYRbJGzzSmE4qH6/Oew9qsZ1LDuRwbNOVJpkdbAVaTPonSNQsAS/126m591Hdm+csh8+3D1H8jsYpOUkcxx4Zk=
Received: from SA1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::28)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 09:55:36 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::d7) by SA1P222CA0021.outlook.office365.com
 (2603:10b6:806:22c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Tue, 13 Aug 2024 09:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 09:55:35 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 04:55:32 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Perry Yuan" <perry.yuan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 3/3] cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on Zen1 and Zen2
Date: Tue, 13 Aug 2024 15:24:59 +0530
Message-ID: <20240813095459.2122-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813095115.2078-3-gautham.shenoy@amd.com>
References: <20240813095115.2078-3-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: c799e75e-35d5-4a39-0732-08dcbb7e1442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnNkyeMNvUoZ5AdN9cRVDxLuCOLr9vHC2rMrGrooju01VgElH/SqreszXcVm?=
 =?us-ascii?Q?AC12/3u0NCXlM5zBlSRGS64H/wiet67EgUjUPpOmO9DAqal+CIlq0mQWF+I/?=
 =?us-ascii?Q?r91aYtt2hUYa2w3PcL+P+hOJj3IEIJtQBHTTWM+cOiXpjC/fX3YgNCitjYzj?=
 =?us-ascii?Q?vJd0julV0fFQymw0r0TEOy437Pq3i52JNUaRv/pSlDhZHRY7flNTURzTD0ik?=
 =?us-ascii?Q?y3cXI9iNNjYIp06KMEuj19buz7muEUn0iIAYMkSK42x70qRSuL2DIfsQr3sl?=
 =?us-ascii?Q?x67u214LvQ+4eqWN5/hMY5c7LvxmdysxgwIDG+LpEy5z/KdJlkO0AvfnS5/d?=
 =?us-ascii?Q?sqd89PArtMPBX3Nv8icN5Vcote5lOihF2eAQCbYNg9wawU+mn3beTuXAslMC?=
 =?us-ascii?Q?/ou8+mDNpYg5XFjcGzz1Se2AQjSV+0wKw7v2WyNnmCeJH6FU4+fFMeQG6xWy?=
 =?us-ascii?Q?J5CYHow8CBsIxh/+CmGfuoqV4N4g6hOUAUg4qH6RmTe3uKvwQpc3z1V4co2Q?=
 =?us-ascii?Q?myDIxFdN+y/dNNaoKnm9KkQ47igRsoYPI90k7jXoawXssTXzwOOaHxIastbI?=
 =?us-ascii?Q?PHdPGhyJkp8gNTpojTuThif1ty2Z13AvIFAm8YHpzXFVjJ3tEhjS7ysMDQtG?=
 =?us-ascii?Q?cb6hWpyCTMJ2QoR28cLDWptnAeNa8B0diN/TsI4vc+txO9mhoDMJuoaX3SvV?=
 =?us-ascii?Q?dz1lE59tNpV43IRKRzOoALSGtnnYfOQehYBSoOLHBs+d2JHtLK7Datcv/vH3?=
 =?us-ascii?Q?hppwZXkQJV98TLQnBPe4tl+zwXjc54WXUUTk1qu8pQYsePKbvON4+V9kj8Jo?=
 =?us-ascii?Q?byRqAMubwHQ+2+d/2ZSf2G+KvtaKFRyUz4dT2IX1bAyCQ8XBP5SwdMKWzmLq?=
 =?us-ascii?Q?VStAvo4rysyY3U082gDHeOYzNxMZzqe0h6XQw5O5B1F/mwoiSI4PdaXkow4o?=
 =?us-ascii?Q?zVyuBdhB1bwxpkMKKtFqinr8LPEgVA5P7TUm602qwVj4LREIrwTKLcLDM4bH?=
 =?us-ascii?Q?gVkndry5HSJRUunMBzYpD8vUtI2K21TtuVSgPNpsaFOHJBKz93LUuaXMxOLX?=
 =?us-ascii?Q?8XQGpkchFrQqEQ7eOpG8ELjNvGzKaPTg5UgJCOv/RDvDREz22kUc0sDKwfRF?=
 =?us-ascii?Q?Rw9EhOeqm9UwYEsdlrzghjkRnrXXhFZlucHq9FkHz+Olmgx4jK3l5ffEEJkk?=
 =?us-ascii?Q?4bQf9FjC0T5APEC+TMgNND03hxfwsXfliQj0ibhxqCPk5KmnlQG5AZg7oKLl?=
 =?us-ascii?Q?PFXtl/ttuxxGMb+6TCzROlFEtEDIGby+VO+quWWOT5dStRn4ZdBzZ0qK7Kos?=
 =?us-ascii?Q?7rtFWtyuZApoq5Nsg7GPiBPs6XyZt/vdGJGPlFLKKRlFbPRrjmIJHwg5OKlF?=
 =?us-ascii?Q?VT06whfP+LCtO85SjcOxA5SxRhnAa51AZQuk34PwxBAHPrmvBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 09:55:35.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c799e75e-35d5-4a39-0732-08dcbb7e1442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

commit bff7d13c190a ("cpufreq: amd-pstate: add debug message while
CPPC is supported and disabled by SBIOS") issues a warning on plaforms
where the X86_FEATURE_CPPC is expected to be enabled, but is not due
to it being disabled in the BIOS.

This feature bit corresponds to CPUID 0x80000008.ebx[27] which is a
reserved bit on the Zen1 and Zen2 platforms, and is expected to be
cleared on these platforms. Thus printing the warning message for Zen1
and Zen2 models when X86_FEATURE_CPPC is incorrect. Fix this.

Fixes: bff7d13c190a ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/lkml/20240730140111.4491-1-00107082@163.com/
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 89bda7a2bb8d..66002718397c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1841,10 +1841,8 @@ static bool amd_cppc_supported(void)
 	 * the code is added for debugging purposes.
 	 */
 	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
-			if (c->x86_model > 0x60 && c->x86_model < 0xaf)
-				warn = true;
-		} else if (cpu_feature_enabled(X86_FEATURE_ZEN3) || cpu_feature_enabled(X86_FEATURE_ZEN4)) {
+		if (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+		    cpu_feature_enabled(X86_FEATURE_ZEN4)) {
 			if ((c->x86_model > 0x10 && c->x86_model < 0x1F) ||
 					(c->x86_model > 0x40 && c->x86_model < 0xaf))
 				warn = true;
-- 
2.34.1


