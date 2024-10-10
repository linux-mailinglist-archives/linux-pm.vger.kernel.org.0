Return-Path: <linux-pm+bounces-15493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432D39992B3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E7F1C226C8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA011EB9FB;
	Thu, 10 Oct 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pw0cmUHX"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AD1CF5C3;
	Thu, 10 Oct 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589080; cv=fail; b=odxIi6w7PlHVRcEf8xX3984lDuszS6rNDuhvuT62W62Mmru+MilvvxMYKEh0v9i92acGXY1HNMFQHxjfW1qKUQj6BLGGTDPZV+1tMmXu4fOLXhrjJKJvvvyHNwktjohzo7vWiwY6NmSRvhl3YTQ5Zt7AvHPIC0724NdU4e/1x44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589080; c=relaxed/simple;
	bh=vq6PyZvHUSYtHDOnH5JX8QiULks8YPaXPgLvmkgN0/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqUKXMv72ZK8Rbsn8SV61W86sfjsfhr1h2eSCo6WDX2M8Jg+EzBXJMByKeRNoGTBawcacFIOqnLtquckf4uQRvpHhGV9F/nTCdNaAsXnTZlbvv2ZgZCouRqTFn+N8Args5HwALoRyHrYK8aUNoIGvAn3S9CgjWrDIfqnx1m0kKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pw0cmUHX; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEecSPe5mcfTGiz+TkdmQFdZaIihJpGhyUXg67fcUcWD93hCV18+dUt01rnweWWJciNnsOBNvNcifE1fpNsY1HMcqB/NGk5jFm9GBmnpepS/c++jhv0u5BxcQtUFIqnR+jeNAgqHpPm3Yq0537U3u1V0swNWmYF7yU5xKTThNtBu80tRV0WP7e0UTtYqR4l6mtCP7RgFFgWVDKM7BNDKxGD8pOeBqyRpGqrRTTdw3u1prC2uh+6l81oT0oeN1RdrPY0t2AgCP5eFEn/s16WsLK+FAENJNjgH0oHWFlHLLaW7GUe/vWQirMl4eqjZPhOhdZakme9Et7sb6yeAqITeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfwreEnEewYS0pE9jStWIsLZJZhnleuZNICQAsz10yA=;
 b=N6oeO8POyMxoVKkQToGlZjQUN85gE13/oC9PShFWXAdgx0DbIvICLBxXo+PwuA8pEtehWiX9+Uj6pxC5WIJ2IDo4ttoSoXXib/G5MKpchFWg8xChN5cGxUUbjS+LTCVZmxwjbopWBYOStZLJhQcLXhJE4sOgVRAjsiBcR+StE7EbGNCjuhOr7Wyq7tqNJ/9YBCWbCRdSVJWSDaiF374S0PsaoC1+wmfmKMSodkQXi6xqz+067b2UQ86KY6c5rfARTIugP7QBaZ5tBk81RzZ0xr8J1wf/6ECx0EDFTj/iGAGa9pzLpEmM3ykuG/ALIwD/Ad14ZeWMXTgOcptYpJbUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfwreEnEewYS0pE9jStWIsLZJZhnleuZNICQAsz10yA=;
 b=pw0cmUHX/+nfd0nLVkqSEiLyshsQXCK1FzI7JTTpvyhWXezd7Xq0+5aS1J0sI17t2UKHBToj2M4Her3OPLOkWv2L4xSaGhBdXa7H89dNQOIk8orqAhb4e7XRrx30C5X70zqJ7yTqA0a/9S4HLsBLX2AKwX5naa6fxtlmwSN9CnA=
Received: from SA1PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:2ce::19)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:54 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::8b) by SA1PR04CA0013.outlook.office365.com
 (2603:10b6:806:2ce::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 12/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Thu, 10 Oct 2024 14:37:04 -0500
Message-ID: <20241010193705.10362-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: f35635fe-6677-4975-7931-08dce96308df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oHUZj2RZHOurvBQJKQsOp9GH4QCI8Eleis3evidIq1i0mN4hjK6ekf6/J+ay?=
 =?us-ascii?Q?I/SKSDOT+3VPreKPdg/OsLuuTmcbAWkdt0upzGGNfuz1G6xShUO85fGmCi+n?=
 =?us-ascii?Q?CVcKGu8jYDk4HkldiBlQIWMCsQpKEok9b5b9BpGHzrGbrYiZJVsM5/iX3r1h?=
 =?us-ascii?Q?lojwkNZ+YuhjNuhCcKzBWd7XNvlKq19zK1zg7MHcXUvVIfd8GB60eEYJFoJ2?=
 =?us-ascii?Q?kepnK70lIb92ZV1XlCKKk3gBXkGAMMKB5Xpqw6/55Udtjk5x/ZYLJGx/rQJv?=
 =?us-ascii?Q?oBtKAGxBo57Yyt3mPjXeNJKlbKzRGWrumwBMgkm1h7Oa/ZteRiEmTTrtKAaA?=
 =?us-ascii?Q?oqY0tk2Jp5gP3oP7CeMdSNhKjZciykLtx3vBYwR+326zODu3k1btSZa493Pr?=
 =?us-ascii?Q?HDo4Ah3+3o7Ni5+Kgufu+XJfallExPOTge1E+I7dMBJPKMfhTsESNJtgUKMj?=
 =?us-ascii?Q?j5CI1l1Zg+PY4XpuRmrYOKCIegZEnNmUunb4UAXzoEuZOttOcCjtP/nTp98j?=
 =?us-ascii?Q?axGe2UKJOVOzKlJNplymASyVGsidTdmME0Huf65khPbFghp5R7SsRs7sqrHe?=
 =?us-ascii?Q?P2hF10rLMR/sq7SqMhr4n/C1sAiIMy5KrNWrcHBOB6Pq56acGkyO+dk5V2Y6?=
 =?us-ascii?Q?OUffClC9rjo2D2mKUu1qcBLMJVLvLzQDGDEErD4qnh8eTHFk3cOMJEg7oT+K?=
 =?us-ascii?Q?6ClgCwMo8ZlDnQ78SkQAT1c1sFAcp7xB7GE5FRaQ8OuypW2JJTzYZwZIA63j?=
 =?us-ascii?Q?IZHmWhJ4hlnNGsAdbdpmr3erkQkNZAsZCHs8E6kcEhN0x0kcIY4uUIh+trHR?=
 =?us-ascii?Q?sr1+pqBiJyboCYvM5BJR54jcZ5C5A7KrqJXBTH/2s2wVdEHZrjIYYJVTETaX?=
 =?us-ascii?Q?+KGG5KaamJUqz9VmZnl4Lhe/u7Kl1CsaVomCzFQqjptHsCo8m1YywbRrn82U?=
 =?us-ascii?Q?j90+w3eZyyXfbg7WJiz/RxasbuwQOJYeCZ5gSCZeA4fuNUB9bvNuoXn9Tm36?=
 =?us-ascii?Q?LWWdh1taKjwlfutSaF9XNHb/2vwApaor+ic/Fa+1QVlRz8rBNVKQhwJnfcit?=
 =?us-ascii?Q?b45c66FnKeAdTv6Cw0RTZA1luQ/yqq5awK91yf7CkTBcRfnRgVwzugLgE7ZL?=
 =?us-ascii?Q?sJq72MVY2yoMCqhlaOEAdT0bf1jI4LufJRcSkAmY6gz4DnPSlEdj3VwxkdEA?=
 =?us-ascii?Q?k/ULV6QcLkAmj/2GvgFZ1u0yqsGFam1wNYI/V5ulktgMPBal36VG6ikDfU8R?=
 =?us-ascii?Q?ImdNeWa+wCW4oNZ3zToJolzhcOK4pcosXjIsOFhI/zV0qUa+K5Ev9sWFdlnw?=
 =?us-ascii?Q?1VBYMgmN4+VC2p6ASDg39RLkPw7pNLxuyTKIpGP7633llyhCcQucr/hAMVPu?=
 =?us-ascii?Q?gmpdh7QAR6hKPIocV7zi5JICv9/9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:53.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35635fe-6677-4975-7931-08dce96308df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 30415c30d8b4..0751579ef06c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -780,6 +780,10 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI))
+		return;
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0


