Return-Path: <linux-pm+bounces-16130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3929A71CC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A3D1F2198E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FE1FB3E6;
	Mon, 21 Oct 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="43zFlWv4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673C1FAC3B;
	Mon, 21 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533809; cv=fail; b=Wp4Q5WEFKnom4C3VmCg5vhTU5qXJIuAyQA3MjmYtJTG4exQLcKCMJGX9WxLdCesxE7WZTYc1/f5wUmBF/QW039XFQY8WqJqNLOe4u134xQ2aLMRT5cAPucb70qB2cHsDE+wtf5Rx7u69/7JqaBiVnu8rerJ6noKZJXePNWlBGO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533809; c=relaxed/simple;
	bh=6/GNpT2p5G0nMQWNGh63AxQqGIghyA/swYKFuepemJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLZ4Ll6z7huWQUDeEtPIYrvwAX5R5MrYmWfFYCsVhvH5YywZro8ZGvmrO148ev9W2jxdPYNw2K0iDAHBBCJP4z1HkTSktUPNRzDZwv//MsgHpgkpKxn0uTIjfxzrZeFmoJCqBpBNDrVnTXFJUY+nDWHTSULv8Ab0a9wdzkso95g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=43zFlWv4; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUGKj7pEegvTN0WTKwYNntfMvyPg8F59NoSz/QrsaREeE4cIgzXwk1TwsCduTVxAkf8oY65IsXjtIFONNWGZmR5r8M/PnbOOD3HrgrJGeDMuVw1Suj9UcAQL6umbgCV1AWlId3iheVkz698zTb7rZA0+m2jRaLdepmlXmpW/JK0w1OqmOAYhXn5ZY+6ZA7Te0UXMhvHaa0C6CtXPBMhN4cwuot4E4X5MEvIyQ2rdZc5wFDexq3LR3OuGbuwnNDHOlIDb2vTmmG6kWL+HpT6UmJSqGCpX1tK3aSk0jKRz1BH8EVbAThN1N3wwOJV7GeCblWZ3/+1FdVhbe5AYXogcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=FZo6WeTJYS7SkbH7JrcMTk/FkO6pqaYIeug+JeHrsuqoDh5zyTGgzCnfyJsYcOPYVMMwe1crqCDnu2LvvcO6fonoc0nr0SJ4NLTqlTLLTaBF3LEwCmXP8h3dtPjyoAZHilQt7r41QZHg+vUq5Cu2U7o89uOVc51TmGfHIvv0+5hBvAJkf7rDRPSn9GO+4lajkMxNHV58QRC7iolDNJGRN4eRpXCMiM0vf/Vy1iwCxfKi6bpGqRfmIrgzX+eqgDL53v3HehILI53gXnzqNpplBAM/+VUTFJcak1+Wxe8BC0nq68Ev783+zayID3jFTQr9vCivxobzplMVTQemqh8Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=43zFlWv4PI21P9VfbI20mtJDEyxqjfL56pGF+VZiIpOALgEt5m1qBKwz5bsfkaZCqHP/EIiRidpkxBuB47bqKBGkYCTUOFK23tcn7kDLc+8kKHKma+btAqPB3Fr0hfe7SCkYRfC7MwVbe++YwGgit3C0Pg9NPWx1oY21OkDTz8A=
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:20 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::5b) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 04/13] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Mon, 21 Oct 2024 13:02:43 -0500
Message-ID: <20241021180252.3531-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e79b3b1-c9cd-413d-796b-08dcf1faa580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ohL2zAN7BM+9VamhhrrSs/a7YfcR9zPZK7SJeFEw9uhCyXPiYUeyrSFAoYF?=
 =?us-ascii?Q?jFQqBsxKnk6370nuKEz33sFdJrlmbsR2GUCmlB2VUPV4VmYfBlABLGZx1omZ?=
 =?us-ascii?Q?gCWuUTpEG4T9UqEAi5Du/RZxauxvLxBtj00J09/iCTgdwGqW1m/I4QHeHptO?=
 =?us-ascii?Q?p321eLtdlUx9av5GnfJ68KjfTNyyRjpskGx442su4ijW9MWn9AlB1ywdjRc9?=
 =?us-ascii?Q?lNnsGvlFVfn085sM75nEwusw7qN023C9YKlaMzeMiVDfjVOt1pSxdzDSna+U?=
 =?us-ascii?Q?KeF3KKN8nBn+ure81kBTAiUPTh+jMMRylJ9UTV3olMhvFpbXzB26qUSjDVLR?=
 =?us-ascii?Q?nDnU6K8lCL4bdsdUlgF/et8tagj3FtEl2J44ETWznARU59aQbmCLIP1H8EO5?=
 =?us-ascii?Q?NG8NrX8Dp4TRnvmkgAvszMNb2ZJPFGPrLoefKAUg0KQ0Eo42BptmEYXXNB0i?=
 =?us-ascii?Q?I3GDPWH00cVcSnEueppOoh+1hRhFp9bPedGdhozT08SFMkCBxfZ5DxwO1cXX?=
 =?us-ascii?Q?dLE0iuh4zVMh28oQNru/1u3v4YmvxMx4hz00SkVfi1ZmWz3UxrqwCiUtsCHC?=
 =?us-ascii?Q?ao6Qq04CpZIDxJgZU+sCVs6qodVJmQNxPBuqlsdT0OF0Ti3cxXQXnyoVhdSw?=
 =?us-ascii?Q?C199Z+VhvEM93v3Zpo34b2ZX1P9PGeR02ZxgqY6LiriX9dXTyTusPqXlWEbc?=
 =?us-ascii?Q?ghwm3sfIquKH9Dg+6u3DMgc8Ji2F27/1XVziKwQPRliAleR9Xdy/U6w7E6oY?=
 =?us-ascii?Q?Wvn+JMQHx7pPVXg0LOxBmoWvKp8fKKdUEGtYNyE1LIxKT8WtZ2T8JJvm6Ba5?=
 =?us-ascii?Q?6XMaKVBFy4CNx1Q9+gdAD6pC9/xqYW76ldJuG+k+bmHhiF3HTHD6nrCH1qgm?=
 =?us-ascii?Q?300i11SQlmXwkv/iRd85Kts6S+X5P/RmCg1KPtD2/qGPo8RVZtCx6PDQlr0j?=
 =?us-ascii?Q?DwZaRjKp9S26hM5mkQLWmMJPh04s4a2dqOCHPsLwnWsg0TMBwCWfdYvkJN9M?=
 =?us-ascii?Q?d2dHYra4rZ4QY7q0s3MP2FdcvdNbxTjnTLMAjxf+zVBbzwBelTDKA66QpbxF?=
 =?us-ascii?Q?uN3BeRotbL4nlt46ZhyEGNx6eBISUcmUTbfg5tNzNChm3k0ulb6c/p9wDnSo?=
 =?us-ascii?Q?M5VfqCrzMVAGTwSe6BJj82+SH7/o4aBvnqncy151kcy0pc4anr0eIhdljlBL?=
 =?us-ascii?Q?hoqFAr9JXL9EtUc/ZM5pLH2vQFVkrNycoAnWwIGvq6896iGFvjbsXPJJApLN?=
 =?us-ascii?Q?k8tTqrH8JWi+7pnBEdIBqeWdF+RnbBLhgOSkhyELym53ncQap5IRmuPT/6Ci?=
 =?us-ascii?Q?vHTvph/2Uk+17FCYF9BH7gwF5CDi1STWu5Bzx5OHGz+sBS7yw0YWyWlCgBK0?=
 =?us-ascii?Q?DxgLite00pQV60dJO1quqdap6HrlFqz5XD6DKwq73O0kIvjORQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:19.9139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e79b3b1-c9cd-413d-796b-08dcf1faa580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

From: Perry Yuan <perry.yuan@amd.com>

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6db..0cd5ffe50f4a4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -712,6 +712,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.43.0


