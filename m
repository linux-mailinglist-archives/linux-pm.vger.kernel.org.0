Return-Path: <linux-pm+bounces-28543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B2AD7041
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5FA188A034
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6561EC018;
	Thu, 12 Jun 2025 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="evVY+ja0"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DC1B0416;
	Thu, 12 Jun 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731070; cv=fail; b=u0DGrUlpH+zxbAV3rQXLzGV9xu0kdvkk38gEorsE6lIx5bgyyZ3ruNoo2N/ovjHIRZXHhpOF3pEkp8FZUIG/1GjnwaBkypMqCOGMSfATcqvQmZKJh3eefLHfaMtnTLWELokUg7I7XMyqd2kC0p6T46nXQmz02uTlN+kzs8JEW9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731070; c=relaxed/simple;
	bh=G8zP+Z28VGhghrrGCHpvZGM04q4c5FfyB7stehn9/0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFv/C1ZXFi6jyweAm3DtlEO1tY+Bj0kmmU31BJ7Ksbg+SIptst+c/v6o0kkQRj4R+xyfe0gpOandywzPaq3+AMYsHAH4Y2nSVzT1RtxQNz7i9021/kRfpL+CPGMSmX6Sf3Mx35LuCrKJ8+dHJ9J65HZ2XvamPqR72WuWyFvnXWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=evVY+ja0; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHv9OiqjkO21IbsEO5cCF4A1R9Euy2riYzybYmkpxyABHgKIg9l4zfMAYvea/fqCqLMtBH0uBc6PW3QMiN+wHSkP/yeTSTEIBrh6eXM6d3Hdus6lSw0TDsGg5n2ZRxj8SE+2JYbSu+bYLWXk5yCHy6UzuVeG4Y8QyhX+ASxZv6DaTXDmRPZ+ZugYXLKLYeFCp35EgH5ZM2J3FENl6P6nq77Ccno2pFDePPreG/RWJkXCtJtq8vPA0n0IuQK25BKog9T6kKzIAJC/k6IJvN5+76IsF3CgGQt5y9Kr6U/cgu137zCRiLLMbwqMvbIjvwVAUAB6bZ7e44YmEwZyeI5n0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9+wUCQrFL13U0p0s1uo8XY8Qf4w1sPujXkHxXnR/bA=;
 b=OQRIbDgtL3m22v0iPFqj5ScuEWYEfCMvbZNXQIvWdcFHRe8StJmINYOxrdO0OXD5Hnv6Yf74n9gwcskK48ldsuJ7PMdVd/gokjTGGKW0OBzR+RlTrkWZVNbHnGdjb8N2niz8RF8YromxUQvNrRtg+onJvqa1c5QuVOW7qM9W/qdWwZV/9bgqrWWXpsvv33ynnzYLGtrr7TTR7iCRiXXVaSQD6l4232W+DRwnGiGNmcKy9BXYhTnd+dl4079qgduRukKZHhPUlky3V9YH6PI4mZb3NaxPrQ850ISvPhpgD/45gUlFYazdktxJRsjElFhmNSGWaTvErEsQWjJ1qkXX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9+wUCQrFL13U0p0s1uo8XY8Qf4w1sPujXkHxXnR/bA=;
 b=evVY+ja0hFJvaxqnXDgWzmaiCQw4Hgmesy0jbU4XnCI261VREinRTbsBq3h2oghAN9FJDu8hNRsksFJW9XZtnZfii9Tl+fWd0eYvZEE4bTRVJ4ViBzbPVKzeUXRdhUddfcGxLe1EslTrFn62pdnT+6k1FY1xVu9BfwOpNLVqCFM=
Received: from CH2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:4e::20)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 12:24:21 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::43) by CH2PR02CA0010.outlook.office365.com
 (2603:10b6:610:4e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 12 Jun 2025 12:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:21 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 07:24:17 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, "John B
 . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 0/2] pm: cpupower: Couple of fixes to the cpupower monitor
Date: Thu, 12 Jun 2025 17:53:53 +0530
Message-ID: <20250612122355.19629-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a45dc6d-09d3-4867-da7f-08dda9ac0f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1nsmJy3tFWxhhNuf4HO5vv1txczICPfwqKQtvg0wviP1u8ROVD/WgVyFKTs?=
 =?us-ascii?Q?2bGEC0yTQhxEoR+hhTl87gkkj82SkKujXctfmFepYJiJXa6kbhagNzqI8Okh?=
 =?us-ascii?Q?cYMLOgJw5tJTNw1rKftdWb+/B8uPC/4gt7k64wAHADiOqayLB44S48icq9oK?=
 =?us-ascii?Q?D+ATrFKC5i4IRSlqFK6y7AdRrQurvYhJW1FKl4Z3hXa4f/uALbeOUdL7uk6V?=
 =?us-ascii?Q?dCJOyfx2BK45+RnrR3GiUYG6IYGiWhIuMUNmZ5YS2zW9bCCa3BcgUtZVfQb9?=
 =?us-ascii?Q?KjKIQBl5KRiIoBaTA3Ta/9VQmsIwX2Wegs8BDj4saV+Yp5kcxbHEQLI74gf+?=
 =?us-ascii?Q?aHSmGYoXZqN2A3BdLWDXypdpjqmR1X78KHvaWaM9qMt8z2X3QCzwPRafV/TP?=
 =?us-ascii?Q?vkq5kKPaUsifcwCb5uX+Wtemj/SfbHdaAM0KvY61ITDt+k1NnY0StXkL/Teu?=
 =?us-ascii?Q?W4J7TAYar/IKIMPbwx6wXsCBHxTKtgiMOeABaj1dihNGjb1LrOPKhMNLlgYL?=
 =?us-ascii?Q?bKipRvdX2UryoxNdXOoKfly5TBSv31KTyzwsaOwW/vQrURIHmB9G+bSCvvGA?=
 =?us-ascii?Q?FmYDbcdG2A9GYoLaOx79WUQMMU4OyOUKZWc+dKu04yxh0BCEV4AhTgBN+omI?=
 =?us-ascii?Q?65mEze87j4FMQCPvCy6OCMFCZPFfX7Fl2FBd6EoLCV7IHJ+cYtYVDAFewC9n?=
 =?us-ascii?Q?hBLy1/KspVi1d48m36EL1Ij8AzERMr1+zQ1NO3BlnzImURW1cFqnhGt1gXF7?=
 =?us-ascii?Q?lzMYt6jPr3wtw59xgJZciIejUrTaOK3rL8HK3Ci+of0ehWDhaFSxdUsKMSPl?=
 =?us-ascii?Q?mbAAUEBtcVAFAZBKHv06EMLhmuYqc/DyNst/bFDx4YsIZLgqoHiRT7js+MRQ?=
 =?us-ascii?Q?Bm1tehQ4HspGZT3DyY1ruW4GYL5AN3t+t6PrJJNwkt22Fru5yr8BB1RiU1Al?=
 =?us-ascii?Q?1TeQyxmXqp0r06A1inNAeBAv1SQqdv0rA0a7dFa4ZZ1pQ3utnB9uYP6z/lC0?=
 =?us-ascii?Q?eOiGOpEkA1ta1ynwx9tUljUEWyAJ4R7p810uSnyo/xcG4VuYD6ci3vwzORx6?=
 =?us-ascii?Q?jZTS7TnkW93dtqJtGOeU8BMQ5Px0A+fvd0HywALT9D2ZOx3WY1P4sj6jVJWY?=
 =?us-ascii?Q?w4N+fuulExaLybFK9OFYxCCZ/I2XzZmuSYq56adr5z/nxHm43glgRBAqTwEn?=
 =?us-ascii?Q?umKBa6nb00fvxN659i6Rna5eVWx6OgsDHC/qFq97u77JofmxpZ65sKn4Xxiu?=
 =?us-ascii?Q?MR99SLftjui2Q6ITy+HPChNuMtqNch2fvFynnbOHYM0N8BGJTAUlqw9Ir2lX?=
 =?us-ascii?Q?L7W9MJZg+Wi31cYvAM8aCMt/2ZBgicVZ4w75VH7ueD4I6Wil2ry+PGLPk9TR?=
 =?us-ascii?Q?bBo19Cuxu6fMCLQNEPTYG4TgCJSEtkz7COXZe2D/LQgyQwTjAeKKLBa3tDAQ?=
 =?us-ascii?Q?K4deE5LGenmHO9n19SyeDM5SYUL9NmNR/pUBheD48+ProB1Iqh51idIzlZgJ?=
 =?us-ascii?Q?WhksQ4W2siNVWdWsgWMoBpTHZgGE6b+TnTDe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:21.7009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a45dc6d-09d3-4867-da7f-08dda9ac0f97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Hello!

This patch-series contains a couple of fixes to the cpupower monitor.

* The first patch ensures that the C0% printed by the mperf-monitor is
  100% when the core is fully busy.

* The second patch ensure that the CORE and CPU fields are printed in
  the cpupower-monitor output for multi-socket systems. This has been
  broken since 6.15.

Gautham R. Shenoy (2):
  pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_stop()
  pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor

 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 4 ----
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.34.1


