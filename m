Return-Path: <linux-pm+bounces-9993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FAE917724
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2EC1C22762
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3D13541B;
	Wed, 26 Jun 2024 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s8FdAUiG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33688770EC;
	Wed, 26 Jun 2024 04:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375121; cv=fail; b=WfP+uqmDrpTbPnSq/zsDYDjcr8ycrH/3SsdWIaLd+67SQE/MjzZx8KPSBD7MFCoXTifCvdeWTjfq3/l4oXxavPirRBizxMGjza0rnPZuiWrz+kSuB1A8b3eHh1Vl2OyNEp9Ki4bZg+AXS7jcRWQBHp3vPDrvm3RR+JuUfab5+Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375121; c=relaxed/simple;
	bh=Ac/TFhXwHbvls+qbaQw5Gqpoxyb/A7a4QcGXudxsXRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pdoSN/HdGMNv5MWpbDeF5nP6RQqd5MO57uiwMwS9YMgBJbTB6Vd1Pd0Hw2T2EMDW5F58bdCjunQsPWzf/CGGxGKDJDfixmPvctVtKjNe3kmDGDfgIRm15kuWO28BoOffe0c3CcgnWrcyZCsgTIHIgn5cE6CYYt3ZsjaGUIVXUkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s8FdAUiG; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtyTZSMRvuhyyR4c3FI2MeKDHaLk+G8WV5dHsC4Iis0eguPDiDGhyAhwViJNRe9GfDb6EIiZFBXhW8X2D6iDyTyPe5JZbL3RvBkKb0BV1fQ6t7YWywFF105YPbb3BClneAKdQ8RbKKD1K3+Qne9B5VkhrBxzHhDijpuS6LVX87QJM22XeoMZGKa0LJj8Rv5ZBQZEq2A5uSZIHZh6yeGr0O/CE9fXbQ/9QPzpPmS0098AcOtVzH1POWKugmOp5W7mQQddgKyDupcjn5TC9yHy401pEJ2McUz/S0NRh2nhgejcwfqObNnohIlBopynhfDpZchXVBgMr7WwvEOgH8DEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFo4DxYrQUSCPHCRDjdg2gmtpC+4uOaIh3/K6I5Vh20=;
 b=hUek3WSbqYUucYq0v6wJJKc9tHBnM7Htb3I6OC3AO8jG55n2eDLSNC0Cm1kVGFes61udlyj/DQUiGBNZCxnBEC3a2PPZWaiD5YdIXjHosGxSmOrCHfK4Tgnw6Sx/lr3q6MtnpgpQpy+ow6fRUDFW/Al6427aOt7yukisOFJC+w19GgQrvqNVgHtNk/oWz3oHgjdJaZc8HeCrcXpPkqPMjudOsrEwHLpRfH5t2tokpenkkUd053WjlWW4FI0xu3KgQPp8wFGwCfpZ5th0SL0qiuirjGF3S/TSHjCwyRE6hNlMc+jjSwn7fBHqytqwx1l1tNzjcvoEdm/DgFLrsQN/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFo4DxYrQUSCPHCRDjdg2gmtpC+4uOaIh3/K6I5Vh20=;
 b=s8FdAUiG/GHrR7nWtGeBJ0zQYgBIg0EzgIoV/S4ZuZYAp7Cx2j5P1GxMJ7uS1UKHXD5iAtYH6IGW48kZQ5X8TdcLFK6Slfaxf58WQ3604iZkA/BemEaNKv/PedIp8g694hWEK7WtB3sI6dGQcqMytkde41gXI+0aKs2fVyWai/I=
Received: from SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::16)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 04:11:57 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::c1) by SN7P220CA0011.outlook.office365.com
 (2603:10b6:806:123::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 04:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:11:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:11:55 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fixes for boost enablement
Date: Tue, 25 Jun 2024 23:11:33 -0500
Message-ID: <20240626041135.1559-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c0fd46-6df1-46ee-9a1b-08dc95961e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8UY2eyjRr/73chC3qdVmHnCFh5t5EhgNsZL/A97wUfanr/WMT9hJpHkbpiTe?=
 =?us-ascii?Q?LuAfJMhsg3/qdqazk6LTSooXTGWFceBJ8m9pJEhLOl924F0lc01q8HuCpM2U?=
 =?us-ascii?Q?3J0Z/MQzayQ1CG8Qo3Y5kO7Ey7SGqes3DVE6pcmDT17chuGgoWeXIzDmMQZw?=
 =?us-ascii?Q?yiOX+xlXZoV08TQmsVp0nsaWsYpjbHXHGNw8ysL3zJDBOTV9ui0nxNewNP+W?=
 =?us-ascii?Q?Mrr3J371+wS95GMRQreuBJUsG65qILZ876OpHlSns4sjuWEl9/eSP7KqbCJy?=
 =?us-ascii?Q?i6pxA2y1nk1aTQDdwEWVeHVmMaL86LTz14TIRP5Pu937ZMsdHmPFXtxnjt7/?=
 =?us-ascii?Q?3e/ruTQXm1NP39Q3sajHitiSogIKk7UaD6Fdl4OC0VY/FjBTG5ik9gqUInGp?=
 =?us-ascii?Q?NlGZEOqiA4iiRyJlobxpzYws1XbEVnLznWsBQ1cILxzslKhRXtiUlZcxnJhQ?=
 =?us-ascii?Q?8Wd9idWP3w+2rM5F9viH/26qHl1CGhsSWVbjF08f7SYsIwo0+AOEJG+EFFhZ?=
 =?us-ascii?Q?qv6UPbEhW0PTcDuZRQuHAv18uRWtbd57ukEFvSd5lJrFEjmR4jRE0V0Nxmrx?=
 =?us-ascii?Q?KtKmQJiQl34imTmI1mtvvP8BGPz7gtVM2CxmYooBNLfgY3FrKK8pcTBuip0N?=
 =?us-ascii?Q?fAc71bYIAN5x2xs9Ku86GQmtBFQKNxjg6UJZ5eBqVc2Fy+Nzp9VCE2Zsg+go?=
 =?us-ascii?Q?fJ0EZ2jSUUIqxMgW30MB6Fs54AcjNr+6l2dYhiqL5r56TkqfSBOPaVccJ5dp?=
 =?us-ascii?Q?K6i8Ii5alv/YSE7rsom3oH3KPFMOHUIfk6087FXJW3QgNQorSgOsSZyW+jsM?=
 =?us-ascii?Q?nex3uYBe2K1YEgn7iZmPh8TMmn0ujuSiMd7smHZeDyFS9SWFlcYn+wIDgIPE?=
 =?us-ascii?Q?6fAL0r7QjpnvuG9y5Ps5W+c0Em2mI/rr9KNxwiuP+QSCuNeFkl36c6dgEPZR?=
 =?us-ascii?Q?bU9Ve21QxxrvjGixDuVg5c4y+42mo5va7wB6NqozIqJxlf5kuB+h3YLh/imL?=
 =?us-ascii?Q?zr23OHklUFz6xXzlQmS+Xai6OknqDVAqEjML6uROhW8TI5Ra9OF+fsTOKbqq?=
 =?us-ascii?Q?mdrsBsOZvUsehwORGyuBjlyUlgCdGq3+LKudknePc+IITkfvoHLHD8hTDHZI?=
 =?us-ascii?Q?fzdoeDNHQ2bvvS2dFe3gddPNQRMGBqRi1OpPd++erednw9ZNdnVSok237TKl?=
 =?us-ascii?Q?pWPTlkLEOjc189mkNcEFZEvBZGV5jclxx+eYOCcWQmgrbiMdfl4zNLhgPjp8?=
 =?us-ascii?Q?xZ8XYHL4n5265y+s2KXxYdI3w0OvX1H32t0WGlu5ytQssmB+fYT53v+hN3TB?=
 =?us-ascii?Q?iY0VuIkF4oDhge6aWpJ8NGpVog2pGdwXuEU2CtIfzRGDvaZ/DZoNK8slsu9E?=
 =?us-ascii?Q?Ghf0Q991uug4vbuP8DbhUgOjdwkxK7J+17kR0wMJFL48fcMIvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:11:56.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c0fd46-6df1-46ee-9a1b-08dc95961e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308

This series is split up from the amd-pstate CPB development.
It's two fixes related to setting up boost that should be targeted
towards 6.10 if possible.

Mario Limonciello (2):
  cpufreq: Allow drivers to advertise boost enabled
  cpufreq: acpi: Mark boost policy as enabled when setting boost

 drivers/cpufreq/acpi-cpufreq.c | 1 +
 drivers/cpufreq/cpufreq.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0


