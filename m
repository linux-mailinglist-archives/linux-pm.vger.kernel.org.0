Return-Path: <linux-pm+bounces-16126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA79A71BD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECA51C21E53
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1F1FA24C;
	Mon, 21 Oct 2024 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LTUFzBZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6D1F943A;
	Mon, 21 Oct 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533806; cv=fail; b=Ua6aQHJdjvnQiThUhSVbD0PJ8QeIaVH3jrp7UBVd7GsZ1mwUSfQsG8RbGsUoeGreQsrzRsCycjg4hdGlPTVxefIusNeBbhPW0QoSO5Rar5XE5Ht5T3JeM8keJfgDShxIu+0x9PnCZlC8K++UxHr6AO76H2e74sjn808bjakZ7Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533806; c=relaxed/simple;
	bh=gA62LSLm/Ugj/RsJqJmdrDhXZI4T51gf5dVZUqTxMR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSUeNC6hvmKERc67oP5gA5yhT5Hxe4MG1ffvT9iCr1cyMCWouX2e+cf7kRGzbUJQDnWUnt3zio70lkiDhWdz9E3+IKbKQplcEAXmHYOHI/rEM1LDrIJG3bn9eRPxpdZHM2lolUbceOoDJAiK9P5SEtuY159ovq4QJkOndkFSU1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LTUFzBZs; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZARLeAq2uEijYMCnkO5dugWr09QNVH4Y+XNgpdd4n9BmclUcXk35V9vAxLxmdPLMqqbUoY5S7EcB5k6Nw6MAtWXLX5dnglLJOvpAGejlyD4g21KDlVvuTZBuRmfSX4WnAtFRsoVxQie2QOqH7olkX97ujBGjeUvxmuyCFokOvjoCV6AzdacubtKe0wrEYPLhZTGYPZR76XajSEwQLlOu/FWYPvWpdZq4rlpWb5OyFhVsx+CoqDjXVpd0PwGrzX4Ya/T1+rlzGCNyvhpQcxa3Z7XQ43OaVLinHoruOKrqPcstBGF7DYSBaK/m51tk+Bh5es259I/2Nts1H0ulSGMxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lPPDC2j9oFivZ9+BluFvMWfSnLHcATGH3L7Y4tOdoE=;
 b=NG+tTv1UbL9ec8/Hvw3YmggozkvmLrSu/4dsjafI1+DXVyNqvvdp+3p6iAD5+MyJqO4jXPk06Wgi5yER1M9FOcDgumvfpEnDvpBAVbo95SNLdofwcbf1ObG/Rp+WuxBNuV1YqEEht4+Y2HvpyhbzmAvChfSrWSmH3Ll41fP+40sRaA0l7j1y+m+1H8EhF7PNWtB9SgxPIHCwHJYZI4be8yZ/m5ggqmkzJRZV1bupPBqx+B2fQ69sIM5iC+OoYP70n0cKPt2ttSL8zZbN9dmrTpZVobC8jddhSzZgEoWu3sYpN4tDWVsWytydmbd5rZsIiGLgf7iaChBlHekyNwwmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lPPDC2j9oFivZ9+BluFvMWfSnLHcATGH3L7Y4tOdoE=;
 b=LTUFzBZsvHis6xORy2CHYwlkg2TneAPM6PEUrC32ImUNb2On53qTj2og/PWBUVoRGtkZUGUo5KjsfkOzohGlJlu3m2GlWHedkL424HHulrHkJKPaFgXLLBBtjSh8vLnS5/9DCzRV22lJasKpGMJgBaovcdwi63wf/IoJ/wa1L/o=
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:18 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Mon, 21 Oct 2024 13:02:41 -0500
Message-ID: <20241021180252.3531-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a779ae7-6cf8-4771-aa40-08dcf1faa4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CF72yuqpYttPrJftw+Bq6IJb87X8ZDwdo37er6Qc9JE1Lqr1mUqH+7imYp0m?=
 =?us-ascii?Q?K4H8TwFVnxq6yQSRA3az7mcZrnqo23thElA8ely5NfW4ucVX1MjffI44O9TN?=
 =?us-ascii?Q?QynOQIKjRt8C03Js0c+Gufli2q29kHU617RPVIZ1H4DkLbsdMGwthUD42t5v?=
 =?us-ascii?Q?ioOR5/6SipbaL1iEovQdcSTZn9gZvdNj39xXPRo+MMvDEzJhYroli/rjX9mX?=
 =?us-ascii?Q?7BPw/n+BFfWEGzSt61v5+rqCdV3VO95U3TVZLf8E+Pj5EwMpwDvwmpW6vaw6?=
 =?us-ascii?Q?4d1rOMmnP1iApNzoV/0+tFrO2f/L03UlNTkfFOK51J7v5Phc/DhTJrp9baLp?=
 =?us-ascii?Q?GmTMuptPvO41QrPHqzjigR9lhWwgkhSW7vbGk2gVAffdFGpDEcjpUDj0ZYZa?=
 =?us-ascii?Q?tPEQJHIidkOXNZ1MDVG50ZNGYkpD1TUnRcM284B+Rl4zSx4ZNCF3yx66I0uo?=
 =?us-ascii?Q?4x//Oif8oTzlqZRjalm6T1ei+D4NYB2R6izcoDzVUhvroMveu5pGyzJXcgXL?=
 =?us-ascii?Q?ZXiuwDbxhwOWapk58YvKQQwRlI1wLQXF25vvqppKRE16Bo6ZrNaW0FiGOVS6?=
 =?us-ascii?Q?t4enYXNnjX6hlHHn0d6b7geQV6V12QPdM5tPMx78htls/CFu8T2A8DUJuXmG?=
 =?us-ascii?Q?el0cSo0j0uG8aJH3C3+tCUFbe5M2c44z8syeCwvcwE/B1JXsFUQai9th9NAw?=
 =?us-ascii?Q?9wdadj0gRin0/UauHrzC7DPabGDzm4IwwTW2xd5Q68c2pEkHkjJfDPTHf7Do?=
 =?us-ascii?Q?W74PrtJ9b9Vgu9S1jo8QIvbaDtnCMMhDmexlErdPF+lHYWKDSrofYRk/UV/A?=
 =?us-ascii?Q?2iw7T9xJXbYplkM23id32qYpvi5Iv2dT4PHX5iBKZyxeEB5cibM6SSRRekLY?=
 =?us-ascii?Q?hyEnLb8XtvKDRO+C/GmbUu7+NrgqAYZlZyUbkpFEjHxlTsZBY5XoXrrHXM72?=
 =?us-ascii?Q?a5G7T8AR4P674Eda/JNdVLBU1Tk7H8YFsMFxpOWvwXP5kTkKJ8YO5rSATB/c?=
 =?us-ascii?Q?AcfbSi19K91pL174aNwcYEynVnW4tavvemcuQej/EFypcqUOzu0+VL/JIY5e?=
 =?us-ascii?Q?G5Ypvy+8glaO3SlB48KX+oI2vVD7dVPSXw3jtP92WlSAqBskLTrITUU1d9Mi?=
 =?us-ascii?Q?JHb1FRYL4IxPosJVIkHgRPCYVA8toT+MeWybQOXQ9WG7jW1GfG8/vwOqLYLg?=
 =?us-ascii?Q?CZylstWDX2vkQFSYGM5z56ej88c6r33SZ0fZIy64mpIgwgZWoF9Cf9T/zS2o?=
 =?us-ascii?Q?Gsj3oeDb1Ut2wquDqcHVVI1SOytznEhvfkNjC1mriGkUge5y6H0DDyzbWQ0R?=
 =?us-ascii?Q?hDpa6BBGczou6OALkytEZw1idMTzo1Y1vkiQmddkk1zFqwUHDm2kl+s05gSu?=
 =?us-ascii?Q?OTIVzBw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:18.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a779ae7-6cf8-4771-aa40-08dcf1faa4ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

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
index a097afd76ded4..90094e064d94a 100644
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


