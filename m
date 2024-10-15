Return-Path: <linux-pm+bounces-15697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4F99FA32
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B08A1F23693
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E81F76B1;
	Tue, 15 Oct 2024 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mrxv6UYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D718B48D;
	Tue, 15 Oct 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028250; cv=fail; b=fH33udT/sW5SSQYbeQEOkMvQj8ZXVy+kQ48PtNp8ATS9oR92LLut73aQ1yondBO3l1GjmK0Qtybn6O7U5ZKDZOKGj1fYoac77E7gEK5srjwMCJYJ0XoDj4fd95/HyUkioL8y7MsdLJAP0+EMwJkMtOTTXS5ISOBbUCwWIEjD8Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028250; c=relaxed/simple;
	bh=YtPkiuEk9ICcjWJZhranlmsUCr+5Cz4Ujkfu8CcT/FU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS0dxE99Dxf8e+o2CmT7ILIeddWR0Igp005YXEch2eO8fyxKExnpHNi7SUPkjXU87g0EcoTux6iS4b/2jerJXmNYlKDkB8dgTUK5m2lPVxvhoUiKulSkSQ3jc0GftX9mjj+R6b80GM0l6EwalfOfPDNP46SXBn9MUYG17f3mrsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mrxv6UYj; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqM5DbRpgRg2A2uZHlM9C2rPkDARehu1qifWMMC9pw75MCulxmf1iPw0lotMcVvCuGX9dDuVnA1iIdOTk4Q+LzNRoDzVX/HtOYKvqDpWDIPphJa1N7fynm4agPcIbqfj4pgEZMjz1wh3euB5X0iIAZFvYmU8Tx1CkyslwxWKbCfz6Rkx929ib2CoEGxbOZxLUHV8g8Ls7KLX+sDKyC0qlKwZGd94PD/4Y/SiApmjxtvDJw4rrHONd/1Jy1XbENKXeKQaycBp29vzNHC5yNPjKRFr1pHV1en/2hmGQAI7dyJ7ORVl6ug91cfzlb96UXWQvoJCyje8VnpQI7LY6uQ4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A4fXpLOiLhKDt1Wm4z4lPpMrc+C7HWy2pJbouxQ6qE=;
 b=M8bp0S+dX2mKir0diy5Yhtv2zQP+j3OMtuzbRziRn9oaKLiZhlFyWqTd+27AIsUm9KWMEqxmrPDlNbFOhKpVANiMBL78dEnA4pGpSoUvOUwpV3qGzr/krZ4anUV2ocDt1ZW8B/57sHdNcOL4qsl89uLwyoiu0uBFZdBx9e65I5XpfKhXJSlkYNaLyePNfgLGMDBIMMN6nzIdqJwqfUWW4Lcn3W0UBj7LNxf7ZWklB2S9CLWDbddydoTzfUv9NKpQwPqoFtxNLI8T70A51pdtcTijfWfjqczOeEw76CWRBEBb4kLyyxHhRnuPfAdTiutcy/JiFidizZPys3EfIfxo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A4fXpLOiLhKDt1Wm4z4lPpMrc+C7HWy2pJbouxQ6qE=;
 b=Mrxv6UYjXFrG2iUOPMadHcrXfGk0p4+ThdUOhmxkKki3CSR5W8fT9/3p//PDmUMSXa9KTkCdl5c/8rWQ06z8CkhOdfOnDid5a+BDk5am5m04M/ahYVCMorMtTLjy+wGUtUeK2OP7f79d7rBadJBnlfv91KoQVWpBiITsE14t/io=
Received: from MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 15 Oct
 2024 21:37:24 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::53) by MN2PR02CA0007.outlook.office365.com
 (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.29 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 02/14] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Tue, 15 Oct 2024 16:36:33 -0500
Message-ID: <20241015213645.1476-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR12MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 405087c7-f23a-4120-d0ee-08dced618ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?li++vZk+hVLdiAgHYVQjv3I9VtspLBzIRAmwziQOUZEBGLzVvr3RlATXjojL?=
 =?us-ascii?Q?hB9QtcWFLcnYI4TmKhOFmT8/gdGTD6sL+ccJdPZaXM7l1+rdTWYdUPkntcZJ?=
 =?us-ascii?Q?B5xjLEDpEjrfudcwJRKF3nkQXGAiNyWGYmLuiLKce6Zi+TaH2ozG4tOMZYys?=
 =?us-ascii?Q?EzywRLbVFetVPjWfULPd/WGFyzBC9EEownXfiih4N3MYk3SPIiIBxwHeFXj5?=
 =?us-ascii?Q?j812ZXom8iSY7FoDZ+NJHAha6gq5GyBZV6ENlA6ZVtk6CaIYqSPxrHPbINXR?=
 =?us-ascii?Q?s7KzKSe6Q6ezEYb8H+VZurJQLANWJUiUKrlVk65nmaCS35EhnORneaBdS1uf?=
 =?us-ascii?Q?GHdwUT64e+g+C63+TfkCc361orNyMbJAC0TppGamdyVcMFp3u4IEvUd2GxCI?=
 =?us-ascii?Q?VHQHKWjSF0QyiMZqmytaiyBGqwH1sScoz7Wt+ru4w1Pl5Jjh6qB9E/sRVHOt?=
 =?us-ascii?Q?yrmtkIH38hjn+jvIicuu6/4ITFN4kZ1zV1Hk+w5u6dkqOI3eeqkcePR5y5EQ?=
 =?us-ascii?Q?iIEiSdqfmnFS3S2CQaF5xxrPIyY3ox7TOPUpI/vvcLQxwmSSwPMghbXcHqeP?=
 =?us-ascii?Q?5GnRptDBIu7Pj+viJ1PxaymDnDsr/cHYFUeW2lbdWXdE8ROAQcKCKYx1/J8x?=
 =?us-ascii?Q?BGk3vMHMg8rfCyPDv4ozu+GbiN1+bDKjoEq1JU63xfKqZkLpq2K2BjEiRudx?=
 =?us-ascii?Q?UnNDi9oMFLpPBj5TZYAMuCmc5c0/E7I4jqAhM0qgd1Pf9P9RSIgVvs5lHCpR?=
 =?us-ascii?Q?TuQo+/2aUEkQMsN6W7BMDN53RvLtQYlC3asidg6zUMVLzXPqnu6amzd4UqRM?=
 =?us-ascii?Q?b103XP7s5Nb8qaEApUvkawkUEz+nQgPzuyQwotvAbnqNj251+nWRj4JDOgGC?=
 =?us-ascii?Q?G/7uGYTfBWfLSURk/orZaPLMOXBV/Ma1JL5qYsdWswiIO86Klfp+Zb154tVz?=
 =?us-ascii?Q?MKC8ZinBwgjobRuYTULqrPmS2PpLFmVaU6hbFiMgDc3tB6btpKCaqLSToPT4?=
 =?us-ascii?Q?TKucS7bW53NHa0hQjQ5TeOf2nOTyGdvbBZrvyZJ0ip1sDIX8GnPSBXn4+18C?=
 =?us-ascii?Q?NEdAEmhK3YNJaNpT3l8xm0uH438BgMxyivYNA6q0uoSivPFIvnQRlwdyNZAb?=
 =?us-ascii?Q?Bt/0OyEOgHXzwXagfd9mvr0JdSvd0xbk5445lRKmtIZHxEiE3VDGKDJHMqIB?=
 =?us-ascii?Q?UcIABRrllImWt2iNNDGoVjEiZraAQytncAP3xex3/UeDGS/fekodZ+KPcr8O?=
 =?us-ascii?Q?Y0G4WjfMitvcqlq99ohUL9DZtJcWcDWCEEzowzM8ACJiPXuT2fLXbtLDXqow?=
 =?us-ascii?Q?b/kDxNi6LQEOUXCjtnAMhNjX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:23.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405087c7-f23a-4120-d0ee-08dced618ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Mario will be responsible for the maintenance
and Perry will assist on review of patches related to this driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..90094e064d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1083,6 +1083,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp.c
 
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	Documentation/arch/x86/amd-hfi.rst
+F:	drivers/platform/x86/amd/hfi/
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-- 
2.43.0


