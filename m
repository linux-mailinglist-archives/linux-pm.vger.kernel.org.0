Return-Path: <linux-pm+bounces-16539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855649B226B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40032281FC6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E80190678;
	Mon, 28 Oct 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PUtLqMLI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4618A92C;
	Mon, 28 Oct 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081003; cv=fail; b=CcPU7zj/doIpym7ydhMyzlfqxVzsJ97zC3FC/AQqILOFYzDgzUqkgNu/Y0KzTnJFa7bfuIhF+qm0XiG5hfFqsnD/1vUVoQwRORdQ6/MZfLCEZB0pjq962E46ZPNOmiBQnZwI4aOTME+0ACgkfQg8GgNCEsl2kFisOpEtFFnKx+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081003; c=relaxed/simple;
	bh=QdHxzDBwqLPbjz8ikUa6cXymAnUz/qVkAinCUCshOe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FL7E/TBYW7DaUjcZKGuCRQ0HJaIbx9Bv6cb4Gt+9HNbRu72TsGplDs9S9gF73/iLsoW4And2SEUF9gaSW8JMZI6FWgzwqPih/hkudQb74vLanW5MXkN2UQsQnoJhhlWwQRnk224t85NSM9MzCSzS8xR3pZoaYZZH+/uda14ITCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PUtLqMLI; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkomvkUbWPF3WM3+/Fzv1sSLwWURBm/NY7yOc57tSbytAL43iBIoouiZdXBX/quLWYpwPHvaaFB3mZxhUXZyZxNLl+1KRmwulm9xzOGEMhGEJ9HVJ6BFgvv65tXIvBpu6vcAMUZMxcFvKsJl5f6mHXysFJ3PE+GEc+jHDyh2FDxgzTRxxlroxdSuxmz4QPQfALFXZKVM60UPMWYGUalXZMNKPcoz0/xaebTrowoijRUYSZo/towYdhM/rN/iJE7PakdXryjZVW9jh4zNzMj3WxJo9MhedUJ2CdmBswN6vWELJl6EbCwouqjrxBJ8AEwdO3TFVIH0faQ+XJ2Qewm4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzfK7HBjuR0XVqwV0/ERsJPvnfHftLVOFwIxVzsvjJk=;
 b=qgcwj/vipqAPqF5yiuCJ9SGCQtv85B3wRnSpvAnfAXu/sfilM0EK/piPm/vb0CbbAWxCKBdyOjAYWfJ3a1JeHqSyDZ+xFc3INBe367GoctCkDGUeweDMOsvDigLtkOXA5LJbZslMQTnQOWwGJsJrBNqDAi7URoDgccLvQ1MX5qkDIkdLJSLH7jSq+y6GWhYpAhcSOTzAHAb8zxLeVk8gJ+2sPSKVE7kJMEQ4ibVSIarRoxga78DkZTjwV6r/FeO/5eck+KJ4z/FuRIa4LZXhxX0OwSn7OFV4sqOYs656l4dsW2SLOU4/jLrhQd0NpkWFYFwwz7nmP66+xfwAnDcoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzfK7HBjuR0XVqwV0/ERsJPvnfHftLVOFwIxVzsvjJk=;
 b=PUtLqMLIU0H3jR3KhlA10ffBTOd8gcUuusbA9VZK0jpacLhHKp4t/xDH6GS0uBYABYGLN4ODYCdBki0Kgj5lLxftPQqekHq9XxXZ7YuLASwnECrW8//ZNPmSAem1YULjizcO+4k+aMMy14C6dK+xfAQSTxi+D6BZVaxEmJy8OAs=
Received: from MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:03:13 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::a5) by MN2PR06CA0019.outlook.office365.com
 (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 02/13] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Sun, 27 Oct 2024 21:02:40 -0500
Message-ID: <20241028020251.8085-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 10094992-ca0d-4b91-b990-08dcf6f4ae2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKR850gQsxWu3TOijv9AbEV2gQXDc8YAl+OqqZaJMNkN2P6+I77kYxEexTJg?=
 =?us-ascii?Q?K/2LPbP5WXdQZ3DcmDJ2M8Y23R2mLcfnU2Rqlm7ZtUyDGnj1RPz7cVjHLppl?=
 =?us-ascii?Q?Fmjr4czIVU7Om3VTZHUu2Q6Oe7zbO2CMyPxLc+WPFy7sOTp6Bl6fOJBpUAxN?=
 =?us-ascii?Q?nY+2JZvRteqlhU7RSE2DqNXacBvesoeo2ynsAFhdD0mDmtqmXZV8toTI8NMs?=
 =?us-ascii?Q?GgHeXVw0JHOoDPFh7o2m/V6s6WxZbb/USU1EWIHnIXQUDGU+idZ662CYkkhg?=
 =?us-ascii?Q?85+T6Ut32nx05oLHvZrS71KPA5RI3tQpyfsS7/KbUxGkWt6D3CtNjPlc1uUq?=
 =?us-ascii?Q?LTBBe/1toLlmRaoIJ3yv95z/sSAnb8FJOo0vEv9xuM2xsLjqu2TZ6R6FunFg?=
 =?us-ascii?Q?6Riv3Q3IwUdCKfIYgFPUiKuyMYY5JXSUb4msQM4X+auX0UpKrXD34ziZuDf8?=
 =?us-ascii?Q?agvxwubFjp5RYf5yIORZPof9uT0lR8RCiJHz5LRRN8bTAGxLYwmHu+4DEGNp?=
 =?us-ascii?Q?65AHVA/muMyenTAghxMMx600VQlz4eHkNpn1ZXAOGh9SzOTCJUoTCVAWTN5M?=
 =?us-ascii?Q?oHlXWM2Ob4W1f79BS0jnKOcnOFJ526r1tLLdN5FEgOZIbg2otIQSDn+2eVYi?=
 =?us-ascii?Q?wMey5yAabsnY0oTGkzxh0wUc29WdM4MeI1KSDtUFXO4AveDrNlNlgO30hI3P?=
 =?us-ascii?Q?mSVnw3bXtQOXuXcTSN/3taqB3BfoOYggeAu5d08J7W0MF/I7+3T96MV6/VaC?=
 =?us-ascii?Q?Cd8HY5s6FY32uLvjK8op6fLr68PWr2UdrkOeJsnIpTfzYPSfaKi09nOZ7eY0?=
 =?us-ascii?Q?BuinbFh+zVIckPEMAS8fm/HMkq+qEGxMwSfy39y+abbEsaL72gZ4gX7uAZEA?=
 =?us-ascii?Q?Z5NBNqTJP3YQsHV3wh5mWR05loW7JoElXefj1kXY0DAbxGYM1u/4wpffNp0S?=
 =?us-ascii?Q?l4KvL48+4+OEsvT5p1sN7lKGBx4VjyOY/Aeop+xlTjSRgYFKT1JRgF2+2+xE?=
 =?us-ascii?Q?iVH29Mj+Lzu8Neb+i4U/dkL7/Xt6LapyFSNArTNzq5p9jVAtJGVj+a71oyHs?=
 =?us-ascii?Q?TGGicCnVezCaHoD5psb5WT2P/20d88LPmwv8UTMtNGlNvfiSAHXn77iDXHAm?=
 =?us-ascii?Q?PTIv9h+VeMYmWWgk/40RxzyKZo6TwtaXHHiPT6uEhzDwLa6kakiSilIsdiHO?=
 =?us-ascii?Q?Y5q6bwsFy+nNd/p56XSE9rzgjGeBK59uXArDanDqozYMKWt6jD0Hxjp+81iy?=
 =?us-ascii?Q?DBnUOtSVqtkOwxe8AYggZqU2x88yMGw3brXpJCQWvNkyPwgnA98PHH5a6mP6?=
 =?us-ascii?Q?jmf1dwmPX9nzdpl6SJeGHHaYgr4MMMJL22k3KT6RrfEZ8sVJILrHpZR7hjxu?=
 =?us-ascii?Q?vWyjSaU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:13.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10094992-ca0d-4b91-b990-08dcf6f4ae2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

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


