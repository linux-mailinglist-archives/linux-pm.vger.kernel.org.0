Return-Path: <linux-pm+bounces-9559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11C90E6C1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8401C21326
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C5135A6E;
	Wed, 19 Jun 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hh91KuyP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670E13211C;
	Wed, 19 Jun 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788654; cv=fail; b=qfKjr8p5B1m5WPb0BEKR6x8+3lovSIvenVwe3GP8lxXDgKAnyrTUSIrZEXfTGYef3iP93bUc2tJI/4j73mWISfh527MOtER6NJg3OB71cVxQZcb/LLj8QYGAGpszAbFh9D3DmubSdWb1jR+ZHBpf6SJkt84gak/1vFIckIvkTWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788654; c=relaxed/simple;
	bh=vOx7APFMQKTWzH0fcKao7F5BePINrchpiC2wQfgg9I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rylwX0j4+myPnaudxuoNEFlyCB9EEme3zt5pacMgBdCyQ5Z3+XZgzED18eDs2nwczov7/QjNucIh4fND9qmTj7OWSJpJ22oCtjcRbmkK5WSvj+QALGRIVjeJ9//r1BjMlw9EKOiACkohBqHlYgnPAcxcWOYkxBrqsRMdzq/XYj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hh91KuyP; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhPK1Kfq6VfnGfuIDB+9io+9PkEcnAZ+VZUh7vHw5NigVn4IiVUSxRzRl2xWu+S8SmO/wu9v02Q2pRq77nlclGu7gBv6zOjuVtYHj0t2D48yUoiRkr7V5LZq3oVgh1CAAfNcfqP338NRnfsIY6aB7qpvdYF2ZJkkc1NEsThCapAiwiuiIQIvgxM4pf8smW1DS33ZWkqd/16dpA3GOybhGutNB8Q86T0x/xFzIF1hYA8VwinGlTHcKQ62UYovnf++enNdlNHDNUiwxRCuEz/vYV53iveXplh6RqNYzajpY9NrsKq1SMSwc6qhjrZHT1bCfCMeD4hVmFj7PIcgwH4J4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkQeqMaZlxIESHrqzZCIv9oro0+A+xA2RZ7re3l6+KA=;
 b=IGhza0Z/OJIDBAARcQCHvmcmAl2YbsSR8gckgWBl/HyF5xn/G6JlWsNPZBc3/1F6MHHo4TvpPoMOyPFI/lyzuIvg8xh4Y/tqWEaKz6NhcrcHj5MWRKUyJ2vWKaoV5j2/LOJKcSvESNyonz7FJSfeQdAZLD9CvGGj7umJzfE2wF7Nq7MVODFpTSIObeoHFh3GEqqNqrHbUTL2wdvdvNrOD8/oo+/0Vf3f5ailwy6mxXDl7z13qkf64o1LlpdxsDZaJCKF7p7YmjYdSSSw9VbB/ZTmYKJgB4POOO4pJERyd81Z4dR+Y58qx1d9QVoTskZHyUm6BwLSe230U5RVLYo5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkQeqMaZlxIESHrqzZCIv9oro0+A+xA2RZ7re3l6+KA=;
 b=hh91KuyP6ccMtquHRMY2QbTy9zmZ16ofPm+cR8iGES6XZbrNVEqulnKmCp8CqzdJUGU/E/8zHyniiRk7YJbva16qHu9ZDgavW6YuDAOzAQQWEimCIq/QNc9lCEgEupQsF8BrWOlu7WmDeAR79SPcLiGmlormp9Lgqpx6pfhHwXY=
Received: from MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17) by
 SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 09:17:28 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::2b) by MN2PR01CA0004.outlook.office365.com
 (2603:10b6:208:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:27 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 8/9] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Wed, 19 Jun 2024 17:16:41 +0800
Message-ID: <933b90997624cf7dd788ea770e5529b77ba7be0c.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8217a16d-2603-4351-2311-08dc9040a373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlKqXZxH1LKPwhexOLBYwLV9B/lfm09x6fgyGJG75S4lLjhQOoLni4chxV2A?=
 =?us-ascii?Q?cyqxQP5CVl+LIXlcnjLVOKK7mKmPW6JsRSCWdhlH8pr8dD8j6uMYiYoBejYt?=
 =?us-ascii?Q?1GuVcTbZJxImQ1f0uPJzVtJTBQVXesrkBhonT3NHNXmb8PrAds/724rQFdnp?=
 =?us-ascii?Q?lTsS9RSpKeOdStZcswF36qpfiR1FNXNJeeC7mV+BrzvgHwpDyjtcU0dYHihj?=
 =?us-ascii?Q?FWUZRCHnybv1glia9Vag2hyTwCFdizTEYf8518L5ngBfpaDjWZR4E9h2nRla?=
 =?us-ascii?Q?yxy57lfawc8YPCO+8lfpza4fNkEjtzDQNlYb4qQ6Aml1M+U4srI50DyY3RMf?=
 =?us-ascii?Q?cvuvmRBw2Ran6A+pKXST63JNb2eXRGY3FHK94R4SbDMlVuvpj6/1XZJRIxQZ?=
 =?us-ascii?Q?nhMsSZ1VqdEOyu14NUJb6Usb59C/A5r6fbXLxSv/2CvUIctMbtI9Nsa3D0hZ?=
 =?us-ascii?Q?LjGaR8w2YjancenKNY8FrMRfzVB28HIsj8JJO+hrSURhCRlNYXahysXWhCIb?=
 =?us-ascii?Q?dSnq8O3eQVOJu17rpsiVAO0GwKTSJNCAp0vF+TqiYd+EEjl1I/IU0q39Tlfw?=
 =?us-ascii?Q?RtJVoefogv5OXdJHrZF9a5+f7/zmbW8PRXy+3hSnAuCJNbxE78szh8jEVByO?=
 =?us-ascii?Q?H+7FABdQFgGLwm+7oXgdVY1OopSBgNfowylL13/1ASyOAlDxQPOSudAgSLYk?=
 =?us-ascii?Q?Y5afH8noWlXa7HMBpv2+OB+YGs0wWPnC18oV3CJ4PCf3p0uPRNVyP7xAxfsG?=
 =?us-ascii?Q?FYR+BIXgKvOZ2nxNPGZwzyfHP37WOZzpgN6VbU2m+JJtSkkromTTdLV7sgGF?=
 =?us-ascii?Q?c2XSNK4YAjbXq160yaUDq0l/wGZOY/A4tSl/HAN9A1zHxtqIA8iV2rTe4PO/?=
 =?us-ascii?Q?ddKnq+MVXTvobX/jKO8wbe3V/zpq4lHjlgUIXkqZkfV0KdmbR/LN31ojDZB2?=
 =?us-ascii?Q?LUAHZhyDcRzQUYBbawNU6u440ZtYUgeUEIHV/EZFsHPJyPlNWWkGWPwIZ04l?=
 =?us-ascii?Q?XhfMJjy7Mwvoln03gZaJGmu71hgVOmw2CZuapMxgqPmqP0fdDah81/FqhTa6?=
 =?us-ascii?Q?FrDSGIkzl1+ifXtPkf3aLJfZHoMxlyq9dZ7AL6Ky3L+2mKjPxkuLiN40cYo8?=
 =?us-ascii?Q?m0a+W9m1LYbO61LOOlu+SFD6Pe4TZm1dzabn8Asmwwt811ahkUiVqvHEzt3/?=
 =?us-ascii?Q?ATqnm4YywNrmmyeYfwT+tdT+L75PMnzAVJCKPaFyQEbNsLwxEXUcJC1ugZp3?=
 =?us-ascii?Q?Me/mGppdkJ+9dC9jDdvpkamLy5IHgFjBW3+/uczR/cIqv0DyYgzUJMty6xKF?=
 =?us-ascii?Q?cAUyrKWIP81ydaGdbNW122WjQmRycn/goVmQ8cn0Zg/MoQqRs55QEFP8q/ea?=
 =?us-ascii?Q?Ya7HZEyrSxtB13zS1tFAguyL8ThlGpxSnvP/TU+gHouBap3RMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:27.2743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8217a16d-2603-4351-2311-08dc9040a373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..bcc0d9404c18 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,16 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this attribute file which allows
+        user to change all cores frequency boosting state. It supports all amd-pstate modes.
+
+        "0" Disable Core Performance Boosting
+        "1" Enable  Core Performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


