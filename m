Return-Path: <linux-pm+bounces-16538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831239B2266
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB981F2173C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634E190472;
	Mon, 28 Oct 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YbcBoiG8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B4189918;
	Mon, 28 Oct 2024 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081002; cv=fail; b=YnAdm6g84/VjKG44tIm8ycEuECxtNiCoDJ7Ah2p0o6hqzuRb17aICQtvHE3W49r1BRCLH5ey48lxr0cgWRxCs8t+tcxsYwxeQ+Pj04pDaaiKlLS+R05ZIJ5lz3WX7ZMOMJ3xBOPXa2v6gQhTvhLxHY5wH/5RW736IPHorsktbMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081002; c=relaxed/simple;
	bh=6/GNpT2p5G0nMQWNGh63AxQqGIghyA/swYKFuepemJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4DWB4knOwUEK+uP14cJPGPEGdASRG1VRMUUaIhySuHA73nj2EcM8PcDNPlZj0awh4uiDg3VA1XPhl2YhJFuQlNpLuyGnYdgfNcPx25txtYQf7O8nv5AdJwRcuc/ccr1RD3FvExKS2qsBttNdu7Oy/A2jJkYkYXcKr1LdqVAAIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YbcBoiG8; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKpKHwuhHeSXuotvnUOF9u77WbeiseYgHXa7w+K8Y1G17ia+PZ6ahWPG+BFC1mFBIKS4d+c7uGRxQ8ulIXAzQK2Ieb8t8OyLE8GjwdAlaQrE2LsEplzRWorZmFxCH849OPwpRLa/pJObImmWH3jI9dfug8b91qvue+x9HKcMobarlXqzpvBDsfJ/l59GLmHvOZdsWuFi5jtcXpb558IDk7KP+RBfl6KgV+rjqmxpnnZLyeWblB4569BPLJs+DJv9g9J51aOxfvlbR2vQE08FnzMwbPf8NtJy0nf/SDDffMhS/nt4drg4+v0nqHO2o4gfObFk0ohPC3MgkqkX4sNTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=T+YnyB4FvyMZRZGC/CY4g7RFYcz2jzUf529IV8CMKpYhlKLMUXvdZi5ZS9SgJDwtiCaQzOEp90PZIRzAnEIq2TeOh3F5ngY7rlzcRCoiUmCy4T57bp7oWswirM7fGbXov9W2fsqkoQy6p1vE9wL0GQlI2F0t/gJCqHi89t/IZxNBcfK9RhzpEUJAUhIrGRSdqpgRTaYuOUKw2TUaxP7rGwhh1/vvHYfMwPUHw+Wkgsj8Nds5KXmi478Yqt8iO+m5WrgSbehrBRSL7gaUr8YosewkSu4uR3xrAa+a6aFZUdgpy1qq2CMNHiNv0/hxO54WRzyABvmCdnAhfYJ/9+a0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4bqI2kTIwrrtnwYodnqVtCHNR2bI5U4bV4Sc3i77M=;
 b=YbcBoiG8JLlpG/jMm5dWF3cm62xE8WyRG1Oj0a01eeSg5Au1c04Y/iEzjo6AYb/V+y/83zvK3T3QAvN+1AtMzRzaDHDs6fIw7E9qa2z00IVp706eGIP9BWIBAcjW74PgI6uMpkttHFapiIEf1kwB85NgTGrywbRC+QvYjTt9mI0=
Received: from MN2PR06CA0013.namprd06.prod.outlook.com (2603:10b6:208:23d::18)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:03:16 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::4d) by MN2PR06CA0013.outlook.office365.com
 (2603:10b6:208:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:13 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 04/13] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Sun, 27 Oct 2024 21:02:42 -0500
Message-ID: <20241028020251.8085-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a6bdaf-5df8-44c5-f829-08dcf6f4af8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Jxh3DSewsjOMxKl1Y3r9aKsexnFaLfGS1FLTDgF4K/ctF7XExWK4INGE/AK?=
 =?us-ascii?Q?qRP/5eCZ6sRAtB1ycVkbZZSUguIGX8TGZTsjCaGdVfYdLWd4D90lHiUbhwGt?=
 =?us-ascii?Q?AA3zw0Vg26jnMGLvkOM8hyR5fEeEmpgN96+UAENKpvYiRiseznA+E5a1dX+c?=
 =?us-ascii?Q?pn43Xi5melUZGoINVSXj6zH6141wqsRcBoWPLryWmBoY736bfoWU5riGI6lp?=
 =?us-ascii?Q?yX+UlNenFHXhVqsUMiB6dcqc1LDLjlFaFRvYLGqH93Kd/UUtOoValntG0O6w?=
 =?us-ascii?Q?pBOqt69Cna0BitMoVk9biVraeJkysL6PKqqKaEUEg/rZ0J7V/NNqYuV1ssTc?=
 =?us-ascii?Q?f5I4g7f3b+bY1abty/EIZi4uQDWyEWtXEaYxfH+dHbniSC/842X1VjTzP2AE?=
 =?us-ascii?Q?EaGbfPFm9LZenB0g8+dX1dCeNaimMkyk2sybGEzkbfvBqRegcXGrYKyrOl2e?=
 =?us-ascii?Q?FC5nb8/wcebNalpHFpi5xKAti433m1QHgueEnx4/tMRx2LW/My7x5fBqSMVa?=
 =?us-ascii?Q?/YtiV5l+dvI8+Xx5uL2/YqKxiuYltSea0yWICpBhQNGm8zW9MPFeHMd/E47g?=
 =?us-ascii?Q?tuTJfA6TR7DWVvAaYldFKyn1FRIOqJmGLcS2iLPB4g5vRIIfxwjzlOK9ZkMv?=
 =?us-ascii?Q?1FJcoTqnrKsnxTSq70TsXI9gL1XWEL6R5Udvr7CBXynFmzm7SEErRDDP3PYx?=
 =?us-ascii?Q?1/pKAChLzbGhDdFuaOUmqPAKXYrgS5W/415hiISWEeR2w/BKvnnFqvdnCDwe?=
 =?us-ascii?Q?bFBIMovG9bEiEr62aEMs+S5q3A32gbPXDeOzHFAoiArFfyDllk281SYUO9PZ?=
 =?us-ascii?Q?Ly8keFhx8uY1MP9HOqqOXoASqqGQSTHcOOzJhZ8RtqCEI2hvJ+VWv5r/NVry?=
 =?us-ascii?Q?6SPkNxOhDLMAF4tibQxo1JX1ENATl/Xpy/p49Fz46R6s92oQzqLpSChIhWiu?=
 =?us-ascii?Q?vHQDy3TyrkUNQS4N2ktOMNOX862gLA5o4DNoKWhjwZ6L6CnUkDYGGXJNy+VK?=
 =?us-ascii?Q?R+wPJH1iUj2juKToFxsh+AG6uf7VVZCk6BsBOSsMiizDOn8awZlNTQpOkUGE?=
 =?us-ascii?Q?BgDPXCrDVd11itJoeCpLWw+jCFPgBKoklO9RA2rVkzd1oUGa8asFO7vm0I/l?=
 =?us-ascii?Q?tggiHm+effNETK6R/To+kLBlZcbv0rX7zIlC05Kp0SI/vscLdzYdJpIk+8Ma?=
 =?us-ascii?Q?CTAkjEjTADu4jhoMfSRwJzRHyQUWftwpXSBk/zVlo7oelD0TGooLdgS4b+FW?=
 =?us-ascii?Q?DNwx+JBmKkMI5rhmTYRgiS33NRM52UlM9iuUVhnDffN/FM/pMX9LZbgOArCS?=
 =?us-ascii?Q?3/bVGfi2O26hdL7t+D/AsLuO1gsHv5k8zH+Nxn8aJRusjO4f5dIR9Ak7dl6E?=
 =?us-ascii?Q?eEp+wOgjWNqgYlsItCAsUemKq4wPYKlB7h7Ff5f9xzheKy4rUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:15.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a6bdaf-5df8-44c5-f829-08dcf6f4af8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

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


