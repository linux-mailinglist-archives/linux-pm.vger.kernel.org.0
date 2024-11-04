Return-Path: <linux-pm+bounces-16982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27D9BBC7B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44151F231F9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369EE1CACE1;
	Mon,  4 Nov 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBzDDWcq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695C1C4A1F;
	Mon,  4 Nov 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742886; cv=fail; b=j0sXQ0tatVTAZdiFWTtskpRxWyM/nFJWdNRC8h1v8cX4kqdWAq4tiaH4G/IX3YuxsNcn9K8NcW9OUmkaNIGhJ1He4Dx3C+uRk6zvh+TqpzwwCXOJhH4smVQSPOkSbjwJfKjCJ03AOYBaYog1xo5DOTzFurpVLo3Lc3OA0Lgbgvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742886; c=relaxed/simple;
	bh=QdHxzDBwqLPbjz8ikUa6cXymAnUz/qVkAinCUCshOe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXmW4rGsnNrECRNSFCylA97lbzc5sZ55/zIONmA6/wt3qOOVV543xsHhoSbW+lQBvnfXIyfCFQ3TX1Y7ICetZ9PMZO4WnXMJ+Vh2cMsCEAe4zaGCZQ2DY4bPXFeOcJD7g/4+bgrOrdzCHgpizf5BA3mtIi7l2GPKyaT8h5QRJEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBzDDWcq; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHGY1vqYOkng3ZtkpDNPC5VhuK3/coyYlPN8QSE3lzrWBHibjPfuGQ3oBrmK8VljW+Uy4W2mdtVNYa/eCKpEUJn0rypn78X/u6Q3mGRoPOyDvrgxIWmWh/TBY2gLW9OIn1BF5Bid4eN3dVr0nCEbTOV93y02lei+sO4bk4WCl77ieqSA3v6jX28OviO1nCXb+aK0ZCnOH+nLUF2MXWHK1UfgmiiOxa2mpu8TtkPJDhVKspAT+qcSnpK/6wt+g9G9WYlyVGFbpG43eIcksNqQHvNlDc1A9TQEsQXuadul8tFgnqG1sN5vLUPSNX+vsi3nrDhXaTc10p5AkZ8sgD8x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzfK7HBjuR0XVqwV0/ERsJPvnfHftLVOFwIxVzsvjJk=;
 b=lbwL9cAESeYXX4ZqSBfiqs7mvGntnMR8/y1VSDVXPKEvUO7gIlYaBun6Z+Lv0QxjEbDRe+j0TNO0uz7wPDH5AFwOZ9Ol9c8vLyEgvsKs2D1Mt9JnkLxs2ThlGXbfV/J8uZ3j0ngUIQnsP4LjBui4gCcndddYCJZjAaE3+1/+Ud8/d/m90+hY2dGxAPybbpq/S9WbcvKcaheesrCJnXfMp9TF1XCKwlkkR+kpqSpAl+2HRhtW6ZmuaHl/m6FS2St5jhbq8uIeDi5NmJvivk+K5t+V8XlvTgACYHeUabOwnQbqwVFj3pfH9+ZCaX39sbCOiGKSjbZg3I62Ro0E+CTfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzfK7HBjuR0XVqwV0/ERsJPvnfHftLVOFwIxVzsvjJk=;
 b=KBzDDWcq2Z/WmlgIx5MNYtldfanouH5lxs1kOsGqF6x8neEgs1mE+nlN4r3zKgrTouzDsSqeL5qxxRnesI2GDq2qqBoXeHjF6APnCStTZbFdrtnoJuDSKaSDOjqhy0YYLOFwXWcMsf+ZSkj2yiuqQiMs83p2JlQy5uuxwKZFs2o=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 17:54:41 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::49) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 17:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 17:54:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 11:54:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v6 02/12] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Mon, 4 Nov 2024 11:53:57 -0600
Message-ID: <20241104175407.19546-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175407.19546-1-mario.limonciello@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: ce65cd0e-be51-4d61-f14b-08dcfcf9c209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YmSgx5WRSigOrnNdVv5cfwk4Ww8JL6gO6F6a+xBgEXKYAuGVSuhnqS+qo8Uo?=
 =?us-ascii?Q?kEVmk1dJKPr5x5JTFldJ8oapDZkoD5+XpYj62ua1rvGybEH8Ey03XyM87O0i?=
 =?us-ascii?Q?9eJ/1LvpvWyfNYjVdMTjJfFNimfC041i9ydKm42J7vdUEZraMjRQImh2BzvQ?=
 =?us-ascii?Q?gy/myBhrmFaKIw10HCi5i5zNwML5E6/tmNwFLPsQY7GUa1dz4AWaY3byVbYl?=
 =?us-ascii?Q?s9ti+b6VAOXML1pGb958gBGTnt4Gwt92R6J2ZwzSZ+eNOcb06kT2WEG6aHTS?=
 =?us-ascii?Q?4qFaj0D7yqcYaO7u9XNluBzyfr2wLwpQ5LggW57Zdwo0Jumwi9ppKX96n2yz?=
 =?us-ascii?Q?Kc9GVYqcsrMBTId6q/2XT4nT/Vfm2qdL1tgK2vXVSRhgY3db2N5TgeWqiy68?=
 =?us-ascii?Q?YAMPi6uMurPp8oj2yWIPI9T/WMBxUqTdvj0sDaKm0Dd2q4nscF8jtZaAoTir?=
 =?us-ascii?Q?GuAzshJYqr9OcnOHjkhTEhc4Fo191KR5dRvTWkjQVD+mPVFpBUkfvzVy9znW?=
 =?us-ascii?Q?wkq5GR2AtLMTUHsyQvwysjG+1F1ujQLC06iS7jMx3GnCXh1HB4rojeJQr2ws?=
 =?us-ascii?Q?V0RCrczeHWX3chT4lMs73bxge+vmTFMUhQ5aJ+Ov8kPO5ZUN2zaEzeVu6UJG?=
 =?us-ascii?Q?7T7yNx646C+8h+whnarXXKvd4TOJboSMvMJQHO0mf8MNwaBFwG2teaoAJBCG?=
 =?us-ascii?Q?iTXVfYmLEVTEXi9kIpAM+V4gj1Biwn897XMME7DVVElCHu+dotIhufU+k9sN?=
 =?us-ascii?Q?JTQTA7uGnq9GegWdL5CMgrH6hzuLxeIxKnCTn/boN6V0tAboSV84X6mNEimV?=
 =?us-ascii?Q?t9/lF+Hn+/L0UUymEhOt0G8MRcvCIN1eZKwWYjsRXuC7kmlfC6S8PeT4ZUN8?=
 =?us-ascii?Q?mO1Xcr4JhkR3p5IXQ3xuL5UpjS/CdKUMu7LO4Kut/LsH1G11WPvd9LVj9gp4?=
 =?us-ascii?Q?34F/aOtmSR8gDn4ki/gn+hKvJ+X9fuSd+0+ZnC4VuabGBRBmGOhQEq+4A9CQ?=
 =?us-ascii?Q?Hdk1J1TMJWtl9RL2k+yIZBhSTsXBzLbz1jq3iQ3n4/Tzz7s4LVyIFPxOQVdO?=
 =?us-ascii?Q?HMkFbbNT7SJilZsRAFSNV4fyjpgLPyybxASLqQu7RZ787VvRkba8gpVAzO4u?=
 =?us-ascii?Q?sAFyFN01RkwVxpIFcEvyQXOa4l4hCwH14cUMSrNgTKyJM/oEfwecV7+1WgzO?=
 =?us-ascii?Q?1/pFT2nSAmZqIVWj6dLKlohZCjg7wdEKVkhQTJA3vwM5UBQ+2ozxCiJ6kKlm?=
 =?us-ascii?Q?AZ1qkHqTe0sYuYeFeEc69rLwVidZzh/zUt/Aht5d+JPaqV3T08BsJeBdH0Na?=
 =?us-ascii?Q?4b58jWd7hHRNStjk37AOUOYWQZji10WVXQlZwFgM8gCb0jhz6b1vGYIHmdRK?=
 =?us-ascii?Q?5ThjGI0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 17:54:41.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce65cd0e-be51-4d61-f14b-08dcfcf9c209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

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
index c27f3190737f8..4554cbf3dfa16 100644
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


