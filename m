Return-Path: <linux-pm+bounces-15578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125299B674
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD77D28341B
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40186189BA6;
	Sat, 12 Oct 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="re2dTQLf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3C152160;
	Sat, 12 Oct 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755162; cv=fail; b=R4SSPI7bbF5sWGTIgtQiqyeGXEFW8RnG45/TvrHJGwI/rNwcBMWBRZQyX7TTnTKsvJ9iAme/m7x2fmEHqeV9lUBA/YqVCBUA4ew85tl5biX7I4wh2Ktq2Mh721iONOtUmawymk4GmPJXTmD7tuypBa2dy6j6RDqOV1Q9D535dcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755162; c=relaxed/simple;
	bh=hSSkhkYGvEI7Zo+OvaL1hrv0yoW3h/RnsVE648jQXRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sG5s1IrvTtCU2dql2a4G0aRWRNLeY6deoBTybjgTsja71tCSPEzdXARKSxYdPz80qAMQx+OsxNYYGYd2v23dFKdN6pR+gpNHKPmM6GZTO/zVqdTD5M/qbVRgscOReEKUn/duUh197p7Gj7w/UMavxPgba3ACfQEiPnbdYVJ8/Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=re2dTQLf; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/dAzY5LZ8SK2rFQOdDkir6P+w3Ha3SRblZ3xcuSHmCUNGNIwRo0Mx+bt/i6lalDbZ6frCZTK5NSTERAIrDM4xXZObQ0jWs60qn0Q2en9KGq0W7GQ/K2MA10uYrnOvxo4Qs+NASoHsDOyUVLphUdzSDlMGg6TNPdfoW7WLjdV+A0y5GvVglDXXVVJutWaATrBGFcBnwCc3xPazWN8TLusS2gyKyV1LyX/reqArbqxK1VxTlOTuyVZ62Qd1GuJdwfo7/LZSqJbQy0MM7i7c1+4JLRgz5J0aRHDMFM/M/LLoV+h7piktxrfA78hdaBknnBnWAjHin5+cktKcJT434LkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVvjzGwVNEsPRrdZ45fv02JROZg6rU7BqYkSWWIZyMw=;
 b=xITNvAaAh7R8K/zysfatl6htdPRPp7dvD1CYqtqff4DaD94nNWRxBhkbobcyInrMFZxfj7HEp1iY1gzXq9zWcNHLI5f3md3r+pJ+6rszD6h6AYcdvwScAIcltk/BxcJarTfR7QqfOzVhml9n+lql7swaFit92h4pF3DcyJfyMbucpk+cqFRm5CoRic0tDcDl/iru6FW1fA82J1Ybafgy7LjX+PCXwfPGXmdaeFjTeZrJm8zC9TvbG2wVmWtpRYkMfigqAZh7oBhdi3VC9ZGVAVBDv0GaPaS0h/2S7YsVZgePVXoDOqojzQiEBGOxEbhV5GMZ7Mf6Q3P8QxhDbFo2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVvjzGwVNEsPRrdZ45fv02JROZg6rU7BqYkSWWIZyMw=;
 b=re2dTQLf1dZf6I+v5YXh16oREAOV7K0jwUXZv2SK2ai9ytTLgdhaiYhtX2EiR3S7E0N0ITOLs/bviC0mVoUuQezi6Pmq4PN8jTnD/iSiAoL6jCj8BwqBDFj+MbsxxclbZIgGfB0KWvVlbbGwSnXD9JTG2CEaYwMGSA85RdoCTP8=
Received: from MW4PR03CA0131.namprd03.prod.outlook.com (2603:10b6:303:8c::16)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sat, 12 Oct
 2024 17:45:55 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::78) by MW4PR03CA0131.outlook.office365.com
 (2603:10b6:303:8c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Sat, 12 Oct 2024 17:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 17:45:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Oct
 2024 12:45:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] cpufreq/amd-pstate: Drop needless EPP initialization
Date: Sat, 12 Oct 2024 12:45:19 -0500
Message-ID: <20241012174519.897-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012174519.897-1-mario.limonciello@amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: c31d0665-5624-44fd-24c1-08dceae5b8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m7/cHcXErDMHPS//PuNpVGzI0lAZirWDNy4GXnzfyZS2yXkKJLMwKgAIDXqd?=
 =?us-ascii?Q?yJYWRhLf7vNAT7iQSbBfG7OOnsWrX7IhrNW1t5L67sVzw9Ya7pXXiIHK4uJj?=
 =?us-ascii?Q?23WApRxgO+Y8YookjnSyUDIjVrF0tVLLOLN61UfW5JAYgdaddIYtoh+0Zk1T?=
 =?us-ascii?Q?P+Ltf1Ki1j9LXP0ymA2p2q0J+I5lfkjw8PXgQdJ2hWgVwMLas0CKWO8vT/CK?=
 =?us-ascii?Q?LJonyKxXLiZmUsWFNnNUyoJrWYBRCSJMLz0ddwewdLrmqNtWzMTIlCqR9EsL?=
 =?us-ascii?Q?9AkkoNN6ndZi7X4HaTQxhNR9D5ukobz+c0t6KsflxIxECnRAl9aoKsZbwvj5?=
 =?us-ascii?Q?klUvydq2oHJ4aOP1VK31GAYnHSob35TXuMJ6+c3CYtOLxqoMk7OOqweoF4EL?=
 =?us-ascii?Q?/K3k919Y41BcBM7Cc092Yjyr1bfylFlPynX8paLFEH5x2aGWLhdRWHuzAlPY?=
 =?us-ascii?Q?e562dXtKLh13lxnEWbXhOjn0U6GP1bK8mdZyjUre6Sy2b5WT9ITKo7iDd+/9?=
 =?us-ascii?Q?4+CZhbWrBK9kzPpF/lgHn6xM2teIYjEHApV1FWlpxW9hyt6R0bEzYxoXkfl8?=
 =?us-ascii?Q?gB36GdG8hKXFmeo2VGNEAmSs1w+BJK4YKPqMW0BVKG3+faP84RB6UQ/Ang+e?=
 =?us-ascii?Q?x/cJHrhtKD3C+9C0CVsvd22LRbreUl8EEOhlPtUCCvu9E61oRKjnW60gWv2M?=
 =?us-ascii?Q?GdUY6sx+oSLppmJZ0p8m4eTI0s4sX+jK/qDhPAwuhkDKwDDZ8+MGK2eaU+Jl?=
 =?us-ascii?Q?5WShScwUBtqMGh1U4I5FjJdoSTygGxwiDftbsuKcrpnt8XJlVCciKf7wMBUl?=
 =?us-ascii?Q?uv7Ll85Y81AUkRK24JY5+N8qb/hvS5UA3QshI7BWiN6h6l5CA0QOKPUzRSip?=
 =?us-ascii?Q?Kz+cMkxY0JAY7BR07diyE85UBqokjMibKpnTKgyD+Qtc1e7j3xtJcxREd+XQ?=
 =?us-ascii?Q?kb8uNhY2KgJP2jc0fuobCYYvHwg/YWRhnJrXfDona6UcgEdFA3GMq1vCSMhg?=
 =?us-ascii?Q?shsssW1cfOVZMAubdjao0RPcvhYjrJqV8dCeneIrdY8HineCY/GYsuxsH2xH?=
 =?us-ascii?Q?pkYBQaNEsbbaVU/hVXUyz8KKMuR9h52C6EFXHs1CVXq9T9aZwnAhQGS6fXSd?=
 =?us-ascii?Q?dvEkmU65W5JccVy2FwsbMsoJsAxDTegqxnB2ru+vhVms1ZxN/Sjog69yLQ/s?=
 =?us-ascii?Q?cjaAF9hu2DEjHnDE0JCbIHUMKLk6R7fKW4wL5JgahFUEsr2LwTutGKWtKvPo?=
 =?us-ascii?Q?w+SnPpvbNQlC+TU0XFBlclQVQkr/uK3i1juaaKziNaL546IBm857pLYxklY0?=
 =?us-ascii?Q?/T/JzHKaawSYMzUUBqO/Iqz/QUblLmI63/+mahXygjHQfqaq3Rqz2xw38nPP?=
 =?us-ascii?Q?PlYs8sfp5u06/qRwf2IUfx5gr9v1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 17:45:54.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31d0665-5624-44fd-24c1-08dceae5b8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

The EPP value doesn't need to be cached to the CPPC request in
amd_pstate_epp_update_limit() because it's passed as an argument
at the end to amd_pstate_set_epp() and stored at that time.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d2541f2c74b..90868c8b214e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1528,12 +1528,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		epp = 0;
 
-	/* Set initial EPP value */
-	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		value &= ~GENMASK_ULL(31, 24);
-		value |= (u64)epp << 24;
-	}
-
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	return amd_pstate_set_epp(cpudata, epp);
 }
-- 
2.43.0


