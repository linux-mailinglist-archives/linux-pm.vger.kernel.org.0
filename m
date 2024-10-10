Return-Path: <linux-pm+bounces-15492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4532C9992AE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0FC284312
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB11EABDC;
	Thu, 10 Oct 2024 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jc/EO7T1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90C1EABA6;
	Thu, 10 Oct 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589079; cv=fail; b=MKN/JX4vRvUuy6izm+1xNyVr5qWJoBCz+Ck9QoHxeppEGe/2cr4yGOlrCQN5PwrOBuHuQBqZGpO6bkk9Kx251jgeIsAmFuLjcmXOKRcAM7MlFAwUEc9kpu9GUH69THT4xX4Fs8sPpDFkObn7h2jF20Zzqa6hhFZtPlByQI4CS7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589079; c=relaxed/simple;
	bh=UQKR5+GcmqFzl6sl7Pwi8P4c9Xti5ZbCc2ekKsjHmTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHFJ+om6+Jfe2ywEc6jLwiIP7yGhOufsS72KIOSrLzsiiCIEvQR/TJDgr75f0pUjoW+hrIYijhYtg8TM/yXmEsqOXC+lgWcXHwiocYoMB+yAVQ1TZPZY+bM++mw7xy1L0jeoUAeXuLaGMsY39c+VjIkc4H4HAMNcLBBopf6fQLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jc/EO7T1; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK2uMqo79bErS7WpndvPsd77fXCEkEK31ycGlTzS7rM6TNNizca2GoeWYTA9vXolHkh+r6NRRbUO0Bcx22aCEsV6TxOgUhPwhQiDBjtkfZ1IZLADANLUdjfJVqSNpMO66WeGSJ/wetJag129H3beHaO3ih27vpVG7xNHQAOqtTh5IgmbchKFzEN2D8Iq/7NVnCuakZizosg0JOHllhNabgliMkRzXIpT1YeuxEAa3qzZCTbQ/JKjo1yHQUkmtBf37Y/GBwOqgw2+giVFLAloQOA6z75NKPe3uKrUQ/1QtLA+qMEJ72eiEZIRVWK/wzF0kko5c7xqtV7iE4EvanNzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Sjoe/LUmiAvjgmyQdQbG7DUvQ25d1VWA899eurarPU=;
 b=osMVLowasBohpl1sUV2SzJxj614+Iczlk0jwf/rnO5zXeSX+PS0lIVOaoESgR7a2fUXvD/Khq/xJ8UKljRUWFaBj+nT2K3h3SrO69gBSMq6dO3bWhNizW9Xz7GtFoEJj76rFyafrg5A8a8Cx3cV+ag54OieKBkVdrN2BF9VGA8uifuaKKMD4efPV9ZHMMJabSP5ay0iAvhpufeMJOCgUhSP8RrnGF6VBCPSYaE3Fh2UVBoDWxx9aJwfQPSPANcrAWlusYqplKYNXw7O70A69D067RmS+UedsrtHodfGowf6ffcqaptyly3I0Ma2+vze3FZF8Z+ZLUurPu0nmR9IqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Sjoe/LUmiAvjgmyQdQbG7DUvQ25d1VWA899eurarPU=;
 b=Jc/EO7T1Hfyj9Mki59hd1xQ7EwPBXIc2BzGa6yA1pWmvaedPHhaELN1k2dU8Emo6Z+Afwx3MAIaz5pVfKtwmUpQgTUvOPALydStojkkLrwuTVmWxPHR6LGu9J+v8ikYeALbKHQ8OZ4YEak0XYh1AA5UMSvkGTohPWNRcNQIyFsY=
Received: from SA1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:2ce::6)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 19:37:51 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ca) by SA1PR04CA0006.outlook.office365.com
 (2603:10b6:806:2ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:48 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 10/13] x86/cpu: Enable SD_ASYM_PACKING for DIE Domain on AMD Processors
Date: Thu, 10 Oct 2024 14:37:02 -0500
Message-ID: <20241010193705.10362-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aff80c1-5765-407f-a541-08dce96306c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6Q3fReQxGnsgimihTNYp/nH+hMgGz4wVVIOamIxwK1sDF8pwuzXCtdujcrl?=
 =?us-ascii?Q?IfeBkPrwlQTtkGIwyQ8fyos0pOJMB4Gp/TlPrg8wCOCR0eoIGGIKCj+YJlbO?=
 =?us-ascii?Q?pmD8YKquP8f/6eW8PDS//zLiG67N2oZ5w2037vHkKUaZdmlEoN9ePCZuPIRc?=
 =?us-ascii?Q?5ANW60iRw0r8xqhAjhgUQDrOqUm0zqttadPCVkDLHliRyA+TrBgbmT8Hi4Jn?=
 =?us-ascii?Q?SYHcTU5vtDWrAStcKlCjfL1N6vfo4KjMDgcHy7nBjmcgGRAhq4+MZY9Fb1jk?=
 =?us-ascii?Q?p8/7NSTye0G+sg1kgzaXWfIBFOBnb1O+ZSSMaCCiLaVrvsQe7Y8Na8qUeqih?=
 =?us-ascii?Q?BRui2QehdyiAT8tZUsOJktJw1Vw775rnUN3+3UXh4tpQPLruF95GSX3RplFV?=
 =?us-ascii?Q?g9fguE+0tsekidzt7ruYyCFG5PtrZZhUBO100nj8+R31Qze9QqwbXpDsJT+L?=
 =?us-ascii?Q?x+dUkWODhI5LQHZHKmMzHMSSyIBQplz5lHB2GYp0Lv8Gqryf6iV85KObhq0m?=
 =?us-ascii?Q?0ht6TkZ0A45NWuhrFHGiqABvDNC2j8qMgFnh80jsbRX3+GuiFPhoGwV4T2Gd?=
 =?us-ascii?Q?88c2k6ngVexgoxO2bboDzPVoo/sbPEG3sCN+McHGDOx0PCDOeZe51gqsVR/j?=
 =?us-ascii?Q?ttbtyZ67qz6op+Xw+R2RihXelIuqd92PvHNJfFhweGGv/VaIbRmHKGdINqRL?=
 =?us-ascii?Q?c9XHrh5/QqdCz3lY9EIQm+FHmkvEOyOYBmJrimGGFXJxVSmapiCOvly3WuZp?=
 =?us-ascii?Q?InveaSqyXL/d4BEri8j9VVNS/J2mZ8giMZLvOotugFxE7KrxQEQOflFFYlTr?=
 =?us-ascii?Q?UlG0FTt0T++qWQwpnksr74HjqGaQLfb1uOSOjjEYkV5KNxt7rUsH8adcmlaF?=
 =?us-ascii?Q?pmBAZnI/EJa1+ORW4SYqVPVvYtloajfCBIEFRoCdbl8+7W1wPkaq3RDcwBOE?=
 =?us-ascii?Q?Qdggg8KkschV0NpSZmlm1BaFbjiwdncLS7Tqp+wQcdu6NoIGKSTo4sfBdXjS?=
 =?us-ascii?Q?5+Vz0TdpjYDw48lnxeJY1bxbfct73ZFe0jjpj8XauNfuBkZHr+EGllFZjvRF?=
 =?us-ascii?Q?o8ym3WzMjBOA1qNGHkQps3Qfv4r2xxpeXPxIt+tW41F78GRbaLCyBhYFq0fo?=
 =?us-ascii?Q?Zek7tMVQy6fJ8LeK2UmdsOnZGznrqW7qFC+4PYFoAD3oa5clvhNL0qszzzkV?=
 =?us-ascii?Q?HncasCjk0ZabeQfk8H13t8KLzAMz/tQxezvQtdu/AsUYe05PbsY2WiJ/BKIw?=
 =?us-ascii?Q?45M/uYlbM8wgGhITi/bbej/bSne8nXobd31l+hHnInG/T3XvzwmImDATVxse?=
 =?us-ascii?Q?SCjSrQMIoixiAkSQjqZ2U8pXNT2WDyL8UeRjycbRHt6FTE5sUCsNmC1/wUKb?=
 =?us-ascii?Q?Nk2bCWjgOXFB2AOeiS4QsZCfbW2M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:50.3571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aff80c1-5765-407f-a541-08dce96306c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413

From: Perry Yuan <perry.yuan@amd.com>

Enable the SD_ASYM_PACKING domain flag for the DIE domain on AMD
heterogeneous processors.
This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Whitespace
---
 arch/x86/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 766f092dab80..c01bb75d0375 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -497,8 +497,9 @@ static int x86_cluster_flags(void)
 
 static int x86_die_flags(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-	       return x86_sched_itmt_flags();
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
+	    cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
+		return x86_sched_itmt_flags();
 
 	return 0;
 }
-- 
2.43.0


