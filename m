Return-Path: <linux-pm+bounces-9840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F2913DF6
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 22:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C393E1F21783
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C6184113;
	Sun, 23 Jun 2024 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FdxGJAbf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16C74420;
	Sun, 23 Jun 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719173378; cv=fail; b=D0wnZ35ACkjB/uvbON2FLKSqFC6BHoQ8W3gB5HtCEyKv/d3OBGFwukk3HTtxGYag9++0SQpYfdo3BgxxPz4Hjq1tEATnv6Cg7lD5zDVhOM6mx/mDbKM4i1tNi8BgHby4tdHr77/aGW338JLtyrrVGIhSfZUechllHQCGKBEkkV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719173378; c=relaxed/simple;
	bh=heI+dc3UitqxWpRhcHPi03OaQGwubYfVSo6kVBKOnD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WHYOWkarfZ/yCmH8HPiOs1/Geik5FXJVAfhcfxLPOm9x6de9yesCSktcUEx/yheXzto61EwFRgWeirCJ1WHNOduVDNbVhfM9XbIXIFtaK34XgcYJRhc3KHdYR3ciaekBmPlMcSBzIe2cXVkW1ptG6WSUHTiubSZ9+B0KlN9KNC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FdxGJAbf; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp16OVEvhDBfiM6WTChu9QoRHTyG7Uft9oeU893x/OqREhbkN8VgEgLineV4XVPTfGGnS55p5W5DBOlNJ7rKqgw5ow2CXhaj50CHSWOF5O1w9eJrZLl4WfLAFMQaHT3HzF9MV8gQOjNWhc5xBHMTUmgrssy1wBn4yR1OKAIzpoS0OVbs1UzItemWcsZUwhl4wNuN0LTc8kwiXwrJl7xY522z04taDx3o95Y7UcfPZ2auxg1ShRo5bWCQu70pelUqbcJLCK5ybGF218BkfmqY6ZARA/f9On1ogHXI20f4dFE6LI7KIQ0tuJGtJN0RQSAdmIb5uS6ucKKzRXtPzuiqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hQiw4gYxAMC9gTtiZAY60SvNZ6NCAnIvXjjxxaa7oA=;
 b=ZeNpHtrv5ylQeCChKT0ngb0ziH9yEquQ2OPVVB45JIRUl62hirzcPUEP4BhRflGs9vfx3YE7fYoeVyyGWONz8JvPMLI0z2aA26Q14hr7qaqVHZxmoojgDhqipjVaUqT9zF7ikW91GPBHVAlLvuCWv0s+If2oM1NvwgZF2eHAGgI8V/l7BFEcPVu0eseGes4PrUHgFxkWULeCh/ZtA/k5yuPc0rrAdZdTXn/u4L/YKIJRH01MFEP3QeZi2cQmK5fMeTME7CYc2CbAJf5au7SBJGUQz3bJx7AIgR9XRwNtrzLzyGXtYESNYqfoGSDZWP5D23Y/rFXb6NacNtiCW8NEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hQiw4gYxAMC9gTtiZAY60SvNZ6NCAnIvXjjxxaa7oA=;
 b=FdxGJAbfagEbOUYO1trHCCpFFVB/T4MlOvaGjga2n5NJvTqlgAqTptnrnMUw6kNbl9JyPOWrkBzfhSXJV4scH9D2r4JQA4grLYPqXkluxDTWFFXFkoVVZwIYntovajFA19RsfPdXQbIStPiyGXd7/YBpngKFeELRzA35nL/VeGs=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Sun, 23 Jun
 2024 20:09:34 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::62) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Sun, 23 Jun 2024 20:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Sun, 23 Jun 2024 20:09:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Jun
 2024 15:09:32 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, <alex.s.cochran@proton.me>, "Peter
 Jung" <peterjung1337@gmail.com>
Subject: [PATCH] cpufreq: amd-pstate: Don't create attributes when registration fails
Date: Sun, 23 Jun 2024 15:09:18 -0500
Message-ID: <20240623200918.52104-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4350f23c-98e1-4825-891b-08dc93c06669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?osT37FrD4/9boZkqcz8hPfVioiRDxRb+NjZjuabVtzDKp0gLPbH/mmn6W/Sb?=
 =?us-ascii?Q?Lth0fPl51j+0zvKzS6CBuCC1sFZyizSRCqiGF/Q79XnCdOs9ebAe8Q2D3uT/?=
 =?us-ascii?Q?stAYFjGgLMr7gUi+NOEbmzDiJkj823gcIGr3BnRLluKz/FdK2MiRxCSlnV3X?=
 =?us-ascii?Q?XqDaHlBkkKiTOO4Am9PEWs8gLkpc5soXXB8S9jBq724Fum/rg41iGDmW1wYG?=
 =?us-ascii?Q?MFxj33XJzAjfnIN5ZIh3mfdY7wzSsRgT6w0tdBgEq5DyYIG4xETy2TrYgIRd?=
 =?us-ascii?Q?COPpEG4GeaWEY6zwPKSQGKL/cm5uMvBl7b4wWNR99/4jC16LgiIYK7WzqyYm?=
 =?us-ascii?Q?JAINqqfeLIU7hI/jjhyRvx/tUG6BJltL4qTyxI27C6WQsStCzk0oeWEcGFq6?=
 =?us-ascii?Q?cs7QJcTTz5E4JYaBtAzO2UjFvBcVvdMc50PbT1DxSfGjea+1o0cjOczIjsTg?=
 =?us-ascii?Q?IQ6le9EJYi24CeR2/2frZj6NYOlyVi77wzjJKJ3f2fQKvGfjUchm5cgz89/A?=
 =?us-ascii?Q?ZBy6gY6rFzulEwuFwboUiUzLPEDmLq1+7mt72Ewx8AwmVRKA85u43+EGev7b?=
 =?us-ascii?Q?zFoGVQL7u+qtucQrH5jzoCWlD+iBF1hp8OCvOxboFP4aqBRQX8X7ZHxSW1VP?=
 =?us-ascii?Q?t/pT5Pn612Neu2Z2qqdhy676HZqVkZLObU3noFBOuA7NXtUXvtUm4BNc/x6Y?=
 =?us-ascii?Q?nzLwbt9V3vGEc6k8goYReOlKtBMz2sCAGsxGfCNeX6sMCPQjLH3O3CFuR2rA?=
 =?us-ascii?Q?yRujNxHplbe3J7SNXvHYFAfEOOkcwmkcRtgLSCH4VLXb8xEqyYUbfbRQHMpx?=
 =?us-ascii?Q?WvfyAwUYjwpFM4VmC2lQLKRIF6vw882ma1qcA+2nXqsQIve9Jjq9CUBh47Be?=
 =?us-ascii?Q?6GeA0JrDcs8MjacylMCEDBfBpAfQtPAB+d8Gugp5Zrs8OyZYTvwX4+j157Oi?=
 =?us-ascii?Q?aKA16SJ00SfyO6P1Mlmwi6upmOQFFDExptmyF7/inBPLCXuimu3fbLzltagh?=
 =?us-ascii?Q?wu8pGnwVjA3mRI7Jk5Tx5JdAr6YjX4opzrNRqrMXZfwNV8o5GPxvk1lchndY?=
 =?us-ascii?Q?zFFCZzPpk6hjfQ8GvKLLjMj4H4EclLpBKv1fSvBgOMjvR9zE6waP/F6vJEOH?=
 =?us-ascii?Q?/21p9ex8tBoFLDH423V2FmLlE4Fj7qCEjRGqkksJbMA2dZ9/R/92tXiFKJhs?=
 =?us-ascii?Q?DYM45rrKXRKx3eNqUDm3gPTYzTnSQQ6xTpNeZZjEfH8518zTpN0dACWu7dJ7?=
 =?us-ascii?Q?60kzhIkb+g9khMewnVEhS54IzFgeXWZOa0lI9HlSun3W5h4FsnHPqyzbvI+a?=
 =?us-ascii?Q?PRaNHiby2f32HtdAmKe7BIE3bar+XWvBeBD1vGGamVBihXuSdASQDQFZ/D9I?=
 =?us-ascii?Q?YOkz6ZVggwsGWxungTa4AJi3J0/OhsBHgESg7mKbybEMyz48dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2024 20:09:34.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4350f23c-98e1-4825-891b-08dc93c06669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

If driver registration fails then immediately return the failure
instead of continuing to register attributes.

This fixes issues of falling back from amd-pstate to other drivers
when cpufreq init has failed for any reason.

Reported-by: alex.s.cochran@proton.me
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Peter Jung <peterjung1337@gmail.com>
 drivers/cpufreq/amd-pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 05e80d2f8803..7195dfa98cc5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2030,8 +2030,10 @@ static int __init amd_pstate_init(void)
 	}
 
 	ret = cpufreq_register_driver(current_pstate_driver);
-	if (ret)
+	if (ret) {
 		pr_err("failed to register with return %d\n", ret);
+		goto disable_driver;
+	}
 
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
@@ -2047,6 +2049,8 @@ static int __init amd_pstate_init(void)
 
 global_attr_free:
 	cpufreq_unregister_driver(current_pstate_driver);
+disable_driver:
+	amd_pstate_enable(false);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.43.0


