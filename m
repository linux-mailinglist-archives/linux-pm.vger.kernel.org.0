Return-Path: <linux-pm+bounces-7233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280118B4AED
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BF9281D57
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB41654911;
	Sun, 28 Apr 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAj062rq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8312EAE9
	for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714295517; cv=fail; b=cj1f5GP63uzwEtED+ajjuSrx8dvf/A+L/j2+tQw+W9sZO249VDm/bNif0EqPKaXrfPBKl0u2XHtKgtpSIcjjzmuvlPQmbbWEwnFmSsaYCtlAx0IMQj6ZEX4960H+e5qwhDbswvNzpZo3gYBRFLiAt6IWkbjoaalOg9GAk9ztEdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714295517; c=relaxed/simple;
	bh=OLKKB5zPlhMzilk3tDMs/jTu4Sd+5kLP7iwl20Pketc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6gEzUzuUEr8c+B9fvIx7B4dr1GpIkGyQQhJyGEG9uU2dbnip/ZrKj6GFnxqKHlO10EY8QB0VPlMlheAhm38Tk70pVNuN3LPlLRNMdGKNh8XkfV3xsdMbyOwlzfmNPdX7HQ+2S1KiG4j6UavlI3sHkWjsPDLnswBt2Xyi1pKlqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAj062rq; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJt40s0GQmrKcdEJHVal+2vpjgFy3pEbjFJ5LcU7O2H1dseE+yQ5k2aQLAYyVDGZqZXGoLQjEgnUAeEA67lghVvOg1NWf7YG09IsMtI45vC6RlHYsyXwLnqPK6yn2+oBKcTKr5ATtsFuGmHJ2ahrMdDepM/lZ92CoaZASw5E7gsFRiL31Lr2AfUpkDKl261oPh77sb7cPY6FJC6qn13DCN2Dm1ugexWZU+s9vdibVBW4DEhAWBkRr6UQF295cDHvCyYvhRP0DH8DjtwkU3RklVhSk6eWbny1uKvYXoHRIIxSQ5yPo5uMyk2z67WyI87+e0Rd+sd4MVKqytdMTp8GjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZbiXL+THXYrW1qJoG05M7et2V7EPvyRWwx0UEzHQeU=;
 b=TTXod5wkixdCetzalwy83MHQWTyjuRrgafLUYkBq7wryzYolx9bkZwSH10wSxOHXyDHxnT00jGnZGuv8ygLU2CqJXxyTHTTWemp3iYaQcXgRyhAGcoDE4dg8SzgwSD15EZMne/QTwa2vCPZqWYpkKu1eDamfpM0xvhcHoe4b0y7fiQxwHTmGK3xHBx4YQlU7OXd+KjMAEexoO7rv8shXBC27r9sgQ8ZTPut0ZDv6YbT2IhC2IxBqMbIFF9yvgNrYYj2j6wlqY/BLaqCbjDJEMnKcjnnz8JwxASCTChrVPvztsxqyq3x8zJGQQZIV5Dzfu2q/+WBanrBhGD+cVVOehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZbiXL+THXYrW1qJoG05M7et2V7EPvyRWwx0UEzHQeU=;
 b=KAj062rqwAaMuPzUAfot2aHHBxQdcIE4A4715TBO3tGby/IzgV/xGtPgRjodFa8w3hr/4ePQFgZS2HM4GQO0VR6PpFd/HH+QoApWAdqaNO4K97nXmNC8h9MfnLc1sSDSFbs8GN0H4s6LzFm8+V18rZyOx/IZvmiuvdieeeq6UOQ=
Received: from CH0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:610:74::13)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 09:11:53 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::e4) by CH0PR04CA0068.outlook.office365.com
 (2603:10b6:610:74::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Sun, 28 Apr 2024 09:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Sun, 28 Apr 2024 09:11:52 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Apr 2024 04:11:50 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-pm@vger.kernel.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <mario.limonciello@amd.com>, <ray.huang@amd.com>
CC: <Perry.Yuan@amd.com>, Perry Yuan <perry.yuan@amd.com>, Xiaojian Du
	<Xiaojian.Du@amd.com>
Subject: [PATCH 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Date: Sun, 28 Apr 2024 17:11:32 +0800
Message-ID: <20240428091133.592333-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: d04f614d-cfe1-40ee-c514-08dc67633ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0CnI2UMJd2sv8j304gA/PDiDMATXln4cE5WPqAqPlqlCRTo/UULI4Mzhif7?=
 =?us-ascii?Q?9KUWnIU9hyGjXB8kbUbX85PAYRgllpFOSzxW2M8AReROnKdWdef2FWpGgUbk?=
 =?us-ascii?Q?hhCo5BKBR2nImtii68zEebEjS9JuLmnZGUeRl1uMVfaTcMiAtqVBrqbRv2gc?=
 =?us-ascii?Q?vM2UD126mUEBNMmsyxmUErfAwnxFiz7OeRyCM1myvk2qUSekredGFkoW/XUP?=
 =?us-ascii?Q?ZaOiWtZyHWPj7ZAx8zvBMQ7OA0NrfrRwqtg9A2L7HO4wmR4LyTAE8R4mO9fU?=
 =?us-ascii?Q?k0LOiVSOn90E7jB3xFYI2tCFz8LNNh3i4eOPhCO7Dz3E5IADk3lFY+TX4A1J?=
 =?us-ascii?Q?v0nGjy2R4f7f9X3XHhu/x9p72j/GwSz0xhZvlMdVFCRHHEY2NmWBanhcBtQq?=
 =?us-ascii?Q?oXPfYYWiPop4Nz8YQuuJTJ3Ez8NxCeJE6KcFEblEGUuu897cZja4DEs1Iiag?=
 =?us-ascii?Q?Q6wP+yNJBrXwH/cwFc6EkQ9pcjify3GlUeD//4UBAsrjc8pYvgIucMrz9Fyr?=
 =?us-ascii?Q?hRUDamYD1U5T4DF60DPCbHXY/kzbVQCIZn99PTnfjk/QEgYB7BSWlxPuWYrW?=
 =?us-ascii?Q?2UdLTwFQsLSs+2hWZpFW6mY+4gS+jifjppXRdVbDFj8yaY5F5QVKcAqxj1LT?=
 =?us-ascii?Q?U+BQcwPDAr0CvtFG2K4+IhXYpHyDjV5aYt1FxqJtKLjV76IblUpNbXQzbnAK?=
 =?us-ascii?Q?pGBfemDEJoHfkq8MiUOpw+l7i1okDrbF9ltUAs3DbQya2LE3m7+hO86Uom2+?=
 =?us-ascii?Q?/Wcf+6H4sjBatKz0au4I+8X3NDA925o4Oa1AM1ZBsz6OfPH+MC4MIs8tHC6j?=
 =?us-ascii?Q?t8sNWGId9kk0OJdGIghVHcqlJvujLbHZcztKrMKQW0i6mOMx0v8MGn9LGxyR?=
 =?us-ascii?Q?2arvqAxIiECSU3z9ZwBSrGHQ+UO3HPhMedbG0tLND/Va/FRA3GLGQVvPlLkC?=
 =?us-ascii?Q?3sfV4Iss5gH2t9JeFu4YZpfDcmUwYKymBMLwDW09+kjRLWJ3BYgLYnnywvG0?=
 =?us-ascii?Q?fZBpXiSOvhU2UvsBEyBcA/Kh7rBUbf+kzhm7DB5g+jqpb2LDkdFh+ifEUPo0?=
 =?us-ascii?Q?Zq6+eAW+n6kUrNfo69+73EJIq5KWj8Jsh6TBZ/kzJ9jELjfrpBVvhFTWJB7z?=
 =?us-ascii?Q?zbHHpD53V4TO28kBXo2KjXvotQLFGRWxkAyGSxTedFYNwk7CaA79N9178lgK?=
 =?us-ascii?Q?tH9ib/rAdsFgSIhBpJZwMca21oq9bBjkIwc7yWRQbL2MCtA7VjNx44HHIIwE?=
 =?us-ascii?Q?9IxXLL/yiyKJ5aNLRhnrtTk89tbizvjaoD/B/PJA6RZNKqcgO3a1yMfDz6fC?=
 =?us-ascii?Q?xulgNAiZeK7gU7diy9lRqMZA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 09:11:52.9486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04f614d-cfe1-40ee-c514-08dc67633ea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

From: Perry Yuan <perry.yuan@amd.com>

Some AMD Zen 4 processors support a new feature FAST CPPC which
allows for a faster CPPC loop due to internal architectual
enhancements. The goal of this faster loop is higher performance
at the same power consumption.

Reference:
Page 99 of PPR for AMD Family 19h Model 61h rev.B1
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/56713-B1_3_05.zip

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..6c128d463a14 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9c273c231f56 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


