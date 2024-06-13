Return-Path: <linux-pm+bounces-9058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC4906506
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A5B286D4E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E513CFB0;
	Thu, 13 Jun 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1/fdTwwp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07E13CFA3;
	Thu, 13 Jun 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263575; cv=fail; b=Cm12zmwKx59WHz9Re4POz0rTc57tb6yTXsI3FRpT8yZ6HhNWFwss4rWhRwcfJH4mgsZsh6K8p34Ni3HPkNXYyKNGyIMgECQzQMSWB6XVTOeTP9UX+5oI3/1NRnVxkDiV0yb0H80U6WNOTPH1BCvMXaKW/KN/GtrB+vK2gbgrOfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263575; c=relaxed/simple;
	bh=591R1c5qWNY+ywR8H9LuF3YeddORv0F+tC41BSUsTms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpdAuaayRG04bNxZfgqQGRLOMQBg1FmxZ5TXpZeJ0d+qfgngvims8IUpW8SuVWnPJNvPmaPTMSzfH8/0+D+B2vwBS1FQ5uEvE7+eUjmeMUig8P/0DmahyOsW5R2Q8so8MvQtlBbsOxKtQ8Qt0TiCPvwXNF4lxEYkwrizA2qz5lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1/fdTwwp; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZNeiKe6Pr0YWHRBThmpqvzIFcyJaQT5dLyjx2/rU7F9mFpprzdFhozCpcNlFL61h422vtdzPYR4c8Wq3QlvnJcWXuxhn1V+IS6F0d71bx41kyQSbrjyat1qx4tRWAhSjSxJn79YBQXgphiwVgliAPuilXZtTzUsF9Qr5ZsTRDdFaCekHHMw1+/2rlA1r7zydqmV3RKIezAogMR6yj6bEqQGHdi/YwVqt4YpTrb+HjMs+bAOCkoeX7cQS8Sso2Mh/o0k+ne9TXONWzCZYmQpAB9tMEZu7wjEC94UP/XT+k5ABQqJHGV5CoWOufc36lg/a92Gqf7HI39msXdVMXiJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94xdj5VxKlsKg7KcTOXiwELEZ8njjN5NlNAXdX4qank=;
 b=TXbUkGt+hUjAiBstmTpVo1USp8meDi1D7iCGMFF3hfJei2NpBmtbEzeMLhZ+M9z82YbAjtH718PTm+s6krUYBVSfATzT7w3vufooQD/nFtn8kfS4S98r0N15vu4wxIpWh2EFejGH9ob6dE6mmi/4h0nglrQqqRspZ0uJau4LsheICbnyVqTCBi+w/lw1pffkVjQj2xpLoFrzg7iTd4I9KeRQk9GciyoRYC2FfyfxZssEUKT2SXUWH+ZZaOiPdoLo2cANO2jXdngaR7H2xfp6mEYfOZg2VdtO52/O/hz66aMNUY6iyf1rAQX3WxvWHmHO1l2C5ngS03NdX5x0QJlhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94xdj5VxKlsKg7KcTOXiwELEZ8njjN5NlNAXdX4qank=;
 b=1/fdTwwpIobBInIuI1uhkGu5JgvXWrtScS4EMxdiq9zSS2PeJN0ofYblpnAzMSr2NAw9tgaZZZKLPVH8ahhShUynqtFMtPbxfXf67R6G+ZsFvvOXRmwJFUS9tROFGRePN4orlSu6JrncpyO+q3g8lL53FDn8LSAWLJLLVS/QtyQ=
Received: from MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43) by
 DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Thu, 13 Jun 2024 07:26:09 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::c9) by MN2PR01CA0030.outlook.office365.com
 (2603:10b6:208:10c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 07:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:26:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:26:05 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 9/9] Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
Date: Thu, 13 Jun 2024 15:25:21 +0800
Message-ID: <f0c47cba673261c7d868d5236d3ffb15ae092e74.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: b498a994-0267-4b10-5543-08dc8b7a18c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rdUMl9VwhXtF+UEslQBmjXzH0iXhffCtnOa3BU31N60OFqGiZK+3SsOvY0Uf?=
 =?us-ascii?Q?0KPw31NBCr08rF19ROw5MVgJqQcRC74zLdsWTqLsNXwSHLK02gFJ6bSsVjOe?=
 =?us-ascii?Q?bA8n84e750NxEpUs/J/Pu/328EAY99/1rNyMHloxlsjK/zPWvyKVGgxzp15G?=
 =?us-ascii?Q?2DT02Ts5cBhKKKa9ipFy2mdRuAXOQjGNGDqwUrm/KQGSXl0xwq1PZBQjvysP?=
 =?us-ascii?Q?cuvtAlr/xTxeVQcG95n++rt1aL626qxuMDDZCPmK/DYhLwmOp70xkkDWl1Mj?=
 =?us-ascii?Q?HOLS7fpOhrpIjOO7bAgALbVdVWl8pOHN8ElfMOIa86fTdhMkKt625b8JnoVE?=
 =?us-ascii?Q?LJK9PjUEkR+DmwLFyh02H4GssP9adg/edkq+YFjImJiweRCxPgrV3qlTtt37?=
 =?us-ascii?Q?bLGEd4cTKW9Nv72erIYTre4mmQ9tvHad6EkoilyXfdv8MdkGLXpIDHoGQsdA?=
 =?us-ascii?Q?E2bzAlXPM+FwIh5nGK6p7FH3n/ntG8fDnwARq85rnasmjF1VqusWqK8e9D9q?=
 =?us-ascii?Q?NiluTaOwwR9W5Ex2pZUAByyUvPgmFUF3hMrutpkxiP+OTORhe2qza6zSjHEZ?=
 =?us-ascii?Q?WWhODcXsl0mrmYRC4WgjqFGLRJhigOqsU6Dt9CQDMst3RWaSoipRvut6VJ3P?=
 =?us-ascii?Q?ieUFAlngu3UhOi3MOZNax04ytQWPTFcRVMeHv+4MHRTy98Szz15e8D6YzQme?=
 =?us-ascii?Q?8fdRPJn3K4h2fBufuBh92XNvD5PSNqfoKNNgifdNyvX/p4DLm/G1UhGOS30r?=
 =?us-ascii?Q?oKB50GwGsHZuLsjxsbxgWpjOgDDll0W6FZOe5q5OFP+nHvOMwDc6duDD4V/5?=
 =?us-ascii?Q?xDrP8QN71EWVhuQnbG4QHqCUEY4O99bCTHjId+cPFqGPtOY1s2qmB4K1gMjn?=
 =?us-ascii?Q?nmIpO4E/cLhefYxGCgblR32SpgR9BCFvyirmQt5TjhQ/aire6H2UpVS10NQP?=
 =?us-ascii?Q?3x5aUjXui7WsGldwEam9NZW/FQR11tlwTSPwKDrKmw2wGi3r8kIkJrBdpivX?=
 =?us-ascii?Q?gZ/8k6t2mZTBN+vJWEL3qa3T3Zl10VAdEr3K8W9QaijNxLmogePwi+XOcx6S?=
 =?us-ascii?Q?L5Tk4txyGoR1wWH02H9J+ciuAEAx5W+PYLaSmamjE0WyvJeQuWz0Hbf/9Fc8?=
 =?us-ascii?Q?SXvfYDUWhM1SULlHvNNi+ohsSwPZA8jjNix48DGCkDns85E8//5GL/acY0+n?=
 =?us-ascii?Q?vNZkIxHwCvClwCdqIjJyyGZV9GrbJIUXr5ZRiOLpDnUvYsen+6SWzj/evDlj?=
 =?us-ascii?Q?SqbjmNdH+qn82Msy9i22ibIY0bxDW6qpIoElg5CyIXjmDs8mN60f9lFXTCp8?=
 =?us-ascii?Q?e8aLLZkE/O25/ffEqSrm68qCnqrqw0GFHFVxv1c9h3y/plHCEKOQu1ryawRx?=
 =?us-ascii?Q?f/5OOb31Ur0MAep8PtseX8eejVIttXnTCGsTAVKFsCG0/gaI8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:26:09.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b498a994-0267-4b10-5543-08dc8b7a18c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

Updates the documentation in `amd-pstate.rst` to include information about the
per CPU boost control feature. Users can now enable or disable the Core Performance
Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index bcc0d9404c18..98e43c53c387 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,26 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
 firmware, if EPP feature is disabled, driver will ignore the written value
 This attribute is read-write.
 
+``boost``
+The `boost` sysfs attribute provides control over the CPU core
+performance boost, allowing users to manage the maximum frequency limitation
+of the CPU. This attribute can be used to enable or disable the boost feature
+on individual CPUs.
+
+When the boost feature is enabled, the CPU can dynamically increase its frequency
+beyond the base frequency, providing enhanced performance for demanding workloads.
+On the other hand, disabling the boost feature restricts the CPU to operate at the
+base frequency, which may be desirable in certain scenarios to prioritize power
+efficiency or manage temperature.
+
+To manipulate the `boost` attribute, users can write a value of `0` to disable the
+boost or `1` to enable it, for the respective CPU using the sysfs path
+`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
+
+It is important to note that modifying the global variable
+`amd_pstate_global_params.cpb_boost` will override the individual CPU settings.
+
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1


