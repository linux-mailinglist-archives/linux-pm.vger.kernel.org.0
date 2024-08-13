Return-Path: <linux-pm+bounces-12137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191C9501A1
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 11:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00496B245E7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C013BADF;
	Tue, 13 Aug 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ymwl4LL0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9116BE01;
	Tue, 13 Aug 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542756; cv=fail; b=V5IN3P8pDzqnQpy8OVVxj1c/77LcryqKgtyPwPp4MXc0sKGvs/LzfZvvo3ns9yZYpPRYIbcwM3e10zNpifu1Imn5pmvPNJ0TtLGXhveDDtIUHWttBVHix8DjhU827+PSgmhz3EywaIe78Vl812/SziEqtTkrQOAuk8F7sK26Wqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542756; c=relaxed/simple;
	bh=QiBJsvud8seYfmegU1/9/NvaAjYS6H4sQIwvxqZ6ces=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKKdJAhoG6TnatMgxRU+6QV+nD7hIRnIJAz1SOpW++70YRlLsn7mXiu8JoyZ1UyQKNlWEg21U2Q8OmxezAM298qvoNmpOgAq3ZStH9NBLJJgOcHZDZ24bkOCTBfw3Zjqn1vILRhH6zef0Jh5jxcXkSxSUq2Zkm5qXHnBdLAktcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ymwl4LL0; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+ecwBnnfVSoJe+cwnZZtiXjjqyj9sg/CT14cLMf3s9lh9aB9rcMnYK2RLko6YnvWzRrW9I9x/7oNi/BMTJZRmNAKI8lywM8vAgWJzZGOJ+IL2H1om+ukcKanFOZ5HCHvN4zYX+x0ABLecdXP+vm6KL1WP+Y6h18CfOFjgITx9rD46+w37rCPuN5dr/FqBPtBDLAwHuKKlu3pLvqADKv46Me0X+k6e43D0ZSyUrEZFccxwjFOm6C8nJNEt+IBmNv+NYM4DobqVGoNC7y961Z8TP6hLi6dprpBZcNP7h0wuY5JV30PeUYnDJ6XGKX2W2+OytVc+Rd8OwjXBaeKhghwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpOE2YWC4Lp1idNMm7Wv2bOabW78XnWA4nPk78H65eY=;
 b=EF/TNqT6LRuCYJyaZKGmRI6O3pYdyDP4hxXi3EhmaKA642WG2/HECcOLmPacZoDIZTT7kc4B9fX+SoEFCqHPixH0MjLQ3kpFAFDK6QYfpEQ7BTYLlDuulNENrAlYCqo1+b+lixe2WdwWqvy/5UO5R54IzqzsnrHiMiHRYY3LuRyQF9KKc0EPfmD0ZGNT5SsqXCtEsYJjP2tIhA0YlwXEY4gnkL2V1I4BV8NNyYjJGb4FmKhlEtU27bFFTCU0XV1w/+KRlrrMBvueZbEh0xyHJqIs/TGS8xF4Ri6+oVUMsP1JBZbB7XYm5MjwtIRXCVqPjNJcnprSDYxM8HmExEwThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpOE2YWC4Lp1idNMm7Wv2bOabW78XnWA4nPk78H65eY=;
 b=Ymwl4LL0R5LFte+oCly/L52flF0iAbR5oHtGPEMzP8o5qdSAYXlAedepe0FTWwqfLlcJkIBc5oMprbVzRl7wRJbujRoEb/Mz2s8bRmwwEhszuZVUwtAsjs3J6H5ZUaXbgOlySNStrUa6xtUkyHvEp74Emn/BrGRTlZKcG37O4/g=
Received: from SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::13)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Tue, 13 Aug
 2024 09:52:31 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::89) by SA1P222CA0192.outlook.office365.com
 (2603:10b6:806:3c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Tue, 13 Aug 2024 09:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 13 Aug 2024 09:52:31 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 04:52:27 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Perry Yuan" <perry.yuan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, David Wang <00107082@163.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] cpufreq/amd-pstate: Use topology_logical_package_id() instead of logical_die_id()
Date: Tue, 13 Aug 2024 15:21:14 +0530
Message-ID: <20240813095115.2078-3-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813095115.2078-1-gautham.shenoy@amd.com>
References: <20240813095115.2078-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: eb78a7c7-4603-4f8e-b9e6-08dcbb7da61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqZC3UAG/GLV+xQg51nxOAU4OLpehtncze83fC9nnIqubH0G7EbbzpjqNFaT?=
 =?us-ascii?Q?zTgCCLJ4/oh0pauBZqik1OUexAjtj364O3Cxvp2HNyhUimpN8eknWhjEy30z?=
 =?us-ascii?Q?tiBhqdLBhaP9H/1n2GlXhg4GTbRfuvGBXunhj/vRQ/HWqYPdd0q7NC/WmLLB?=
 =?us-ascii?Q?/g9sdSpbCixD79cZHbQwkp+2Mbh3SzWb4k9EKjjEoVw8RlRWH9f3iMBk+x09?=
 =?us-ascii?Q?+Typh8NYJ9fLLYEvYJ/ge4Sj6owz75eIY9adlVjm5aDu1IbEGwEn/ncWCFV7?=
 =?us-ascii?Q?5Oz6HaTHytY9ewVn55rK3HKG4WTHL8C3BGH9E8TCTJYpAz+68KhQBdjlex5C?=
 =?us-ascii?Q?A0YfrLWHkHnbfNv98yV4eTLXF8EerO0dckgmIr/5KC9dDt/QubdCemnI7bAB?=
 =?us-ascii?Q?hj4QdC8HnzRNvj12eRmuXMEGIIbkcsfa+GBqZ+BRLVJi0yxdRdN1pT4edk3U?=
 =?us-ascii?Q?E6JpHKA6T4MrvFnZmOuhWQCQ7j6xtUyXH0D8aMTYLO2RphcfNoJtOkSpiwZv?=
 =?us-ascii?Q?K9WMCoPKExYHkpZtOLHv6ZT/8YXHHwHcPdZWJN0A2DiAO0ZSsG9FGSmkjf9F?=
 =?us-ascii?Q?ox+72szY+KSNrPg/TtM5QBTDHFAKAM+yLs+fOL965VKhKZfjxJcE1nngDy5z?=
 =?us-ascii?Q?+5SkXgPSXCF+vLd2QEzh7+Au+59iCzm8GCB0FmX3WK/ic7OErzNiWbgSS2B+?=
 =?us-ascii?Q?sOF/ZyN9ZU8WpvYg6HgOipo+EeQlducQ4JJbuG/8mHxEFw3TSOSq/oZ2uVNW?=
 =?us-ascii?Q?iQf47pTqepzfWI5xryBwa4Qq9LA295Xro85tHGxz8cGK75LJZRNVZ6oqdgMP?=
 =?us-ascii?Q?aV6jqLgJ+4JNF2jAIQo5E06WDXt48aX77hBtCRbGC6cN0SPvRcvJpdmBFn80?=
 =?us-ascii?Q?Ta6g4SKLYxIzVNfq9qQqG/pMzR/0IjjV5WQT7aN3JRi68NSq/L893cuUf0iG?=
 =?us-ascii?Q?GOIZgDrX8RQmOgS7C+bJXYT9VeNhgfGe9e8VLmnpc9GJA2+ahh9wnd61TokJ?=
 =?us-ascii?Q?WICPNayxrD2pu4q4o6OlH9TE8umIpctEYKpJrQhf0z97kwfiu++iq3kBQmM7?=
 =?us-ascii?Q?n5YK3zTRMwmOrhGHEk6wagWXdR4SDn4wUwycgq18whGIYzjkgnnt+KlbzZyC?=
 =?us-ascii?Q?DtMQs5wCqNe/DJalz311GRTlEfj2fWiHEBFGTLKbfrdREs3jPedmeAVpwPYO?=
 =?us-ascii?Q?pP0y0vGH8VdtvAkSAQJX0KGnn+9lD5WPvkANtte58iP7u6X4L/pVOmX4J9Oh?=
 =?us-ascii?Q?oXI5GD8FF6qzSiwqjHul2rsDaN2TpOO/AwXjRKJlxsjLmdaZX96K+BK21KV8?=
 =?us-ascii?Q?6qB1a/7qsUhRtTuxYCvtuQb/ukZV2OYS0xU9AyDn9kDlbVluC4ODQjpl+zDy?=
 =?us-ascii?Q?Ge2pLW7rVnGdD0Tj+AoD9Wp+r2ADyJh5GSfDiJqb4SK2evzKZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 09:52:31.1102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb78a7c7-4603-4f8e-b9e6-08dcbb7da61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223

After the commit 63edbaa48a57 ("x86/cpu/topology: Add support for the
AMD 0x80000026 leaf"), the topolgy_logical_die_id() function returns
the logical Core Chiplet Die (CCD) ID instead of the logical socket
ID.

Since this is currently used to set MSR_AMD_CPPC_ENABLE, which needs
to be set on any one of the threads of the socket, it is prudent to
use topology_logical_package_id() in place of
topology_logical_die_id().

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
cc: stable@vger.kernel.org # 6.10
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Link: https://lore.kernel.org/lkml/20240801124509.3650-1-Dhananjay.Ugwekar@amd.com/
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 358bd88cd0c5..89bda7a2bb8d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -321,7 +321,7 @@ static inline int pstate_enable(bool enable)
 		return 0;
 
 	for_each_present_cpu(cpu) {
-		unsigned long logical_id = topology_logical_die_id(cpu);
+		unsigned long logical_id = topology_logical_package_id(cpu);
 
 		if (test_bit(logical_id, &logical_proc_id_mask))
 			continue;
-- 
2.34.1


