Return-Path: <linux-pm+bounces-10003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC63917746
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DA3284091
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8613AD28;
	Wed, 26 Jun 2024 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FWfETUaI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12566175BE
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376096; cv=fail; b=h8uYQQGIYODEMDrwCD5c7211DGyZC/VlLNpZJ0GRw4HcXC3MM1CqLIy80ePjVhEbO+fBtlhYG+WIN25Fx2CqEi+Pt16TEl5cpMQJr0i8rV00Eo66B/TCU6hUwqgb19CucKWgNKUpWbf52sUQPz0wvdmuWcYcJ+Q+uaCyUqYtmEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376096; c=relaxed/simple;
	bh=ipLIitLZYtnfhsv6GaTjy4yPkCi2+qQV0gv/pgbxyL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRfLAtWjHDl9M+6JKQajpYWs6fE+nFctz0C5c3wJhbctc3U+PuxHkc+mA5lkoahwt/t/CC5DWKh6cBVFjm8zfwTAEztScyLJJI2XwKVEPs4mQDOWsd+Vb/4wUV3X/sTKKKbOVWgFFPpCX/cjKUhyGMIuizH14SrUQuweCIych74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FWfETUaI; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m59U3Dl5LBE9iM7KrlCiLGax9kWEfk2UQGLn0Y8h2NDtmneCMs+MYww6Z2o4rr2nGEUz+quhham87Gyju4naz3XCszww+K4Sg/z9JeItLPbBIgpc2w4QGmc0fdGpvafs8bQDrS5wXYnDJQL6xEy192IxJc/WLGatqocS0pSPryuRilxZQFztd2onVnPraKTJAEb8l+rsiQeZCHvEHMCxR5zp1+WVayaDMe55WGzGdBz2q50Whp4pKMIa4NzmgaXPAr8OEhWRIFZRlpVxxAxzo0JCeVgoGaj3EhJiPZFREGiYfM01E39Mv4LRPvYSQZ+Pz4yVEvsDCc+ml0ZkXeRTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf7UKvr2A+bHUT40t8nkE+WAwzck17QHsmmC5/Abzy8=;
 b=Q/d+Mv6X/QGJlUM+wdslvy8czTPIjlRYjFrsLd9LB5utvH6hHIPZBy7tr6r0F7LqHsJ4KbEHn0qKE+t9Mgn5D2Pj4lFryi8lbZ5OyHGQh0QG97ry9EdRh6/uJwaNZ4Y84Go390Fi4ly0YypGv3gkQX5Efzw40lC2wJ4tqbUn5sM0SDhOqyKH9UuajM70yEkLK31mqHdS4PX6ceWYVbMI7UBnjoBYeHJB7NBOU5S19nmACAHF2ahBU0aUXgVYM1yUxRy2wYGLemacOw8Um0jlAVI+JnGXhfPq0sCKofvIqIoW22lZgvsY2a66qGbfF4ym7JSce+y562cStH5qHKEcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf7UKvr2A+bHUT40t8nkE+WAwzck17QHsmmC5/Abzy8=;
 b=FWfETUaIbX+AOr9q7sXE0/GVYlUBeCmvFMRiDJ+faHIeIWeh+EUH6zzDBj+Wk58tA+skJ/7HHURsPsnzePFmiEC2MQCLp9ziZfWkg0ftftFKjMbK2G0vCJbIEZKAJZMNgOVZw7xn78linsnTIzIIUcnWzSFu0GN1pVlVRXf+ohk=
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 04:28:12 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::83) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.18 via Frontend
 Transport; Wed, 26 Jun 2024 04:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 04:28:12 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:28:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <perry.yuan@amd.com>, <gautham.shenoy@amd.com>
CC: <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v15 4/4] Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
Date: Tue, 25 Jun 2024 23:27:33 -0500
Message-ID: <20240626042733.3747-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626042733.3747-1-mario.limonciello@amd.com>
References: <20240626042733.3747-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e102380-9ef1-4847-4db8-08dc95986419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43HI1uGdTKmJrT8Zi/Mp5/YjCaARxF/LdkEaSpRdjM99kfCJe9xW18AVbSIM?=
 =?us-ascii?Q?36SOskTgNcBtGALeekbk+wEEBty7HmE5XcaOsgpz+NVlavvw0dpdnuUHKITh?=
 =?us-ascii?Q?3im5VnkNiZWx1nQIaEB5F29I9UBPdfNdGaL6mUNVJtE229l1pp+sYp65nG8C?=
 =?us-ascii?Q?7ez7EGTUfjFh0WMShS9nDKOpG3mc//djEV5rOVjI6zeRKg5NLOZrvN5VId3J?=
 =?us-ascii?Q?FSfHBktPph2jQAIjACMjzC6bpKfcWWWTtTuhR6wWr6ns0mr6NGcWur5b2Z5/?=
 =?us-ascii?Q?LluLmkgA90FTuW5jbETz3fImBBjWOBFgrrCFCW9Z5LPoEeydH+Vb2rPcyeMr?=
 =?us-ascii?Q?mJFhcPxzW3QCXAudyuRrt39KzLNPhQr417x8qKonGozA+VJm22u0VbgyllcG?=
 =?us-ascii?Q?ersem1Eq5sswUjgrLsJNiQvAgVrU5LOI/FoIsbyg7VlXPsh8cRYjDedjFXRF?=
 =?us-ascii?Q?P/TMgLz55gzAesMTYaU/NF3Bn/+m5wQvkX7/uqCJt4+pptcZoeLahYg0xNk8?=
 =?us-ascii?Q?HQxz8aNSHII+5vhQxBfExMNotiyY96bWz6eUvswiuOCFkJzsnaTktAzeSnrW?=
 =?us-ascii?Q?XH2nn0HC/GulpKamf7ibzpJS4RoBfkdgqM29lrxzFjDJSGucwaZlAuUveK1u?=
 =?us-ascii?Q?cskggEZr6w+9SDDg9jSFZafSWbPgSWjzDtGU0jrKaOQQlba5pp/qoxoCPrGy?=
 =?us-ascii?Q?7SBezSmiydJFqaqqE8vkfwCbsdV3n8t4gW/qZ3X+CWw5RSqlkHBgiagULOSF?=
 =?us-ascii?Q?4hI8xlvr993L/IOrOVxmWAfr0oeF11k6z9IKPkj6YSeOtc0Tykdn9gfgLSM/?=
 =?us-ascii?Q?GtgVlOYDaeN8YCP2eTRbObwpXTI93jdSmSlYshltO9cdBnPJ8UyaDbiSGoKG?=
 =?us-ascii?Q?VV04eaaI0e7YtWHOpoKjn4lux+6B18esLRSJmcZhc9Tcy+eYvTqaIA1UE5ov?=
 =?us-ascii?Q?lQ+OvisuQJYjkgDtwZsOL1lfPU0ndtma5cRSiARlsyMUUcjJ1IBiGZsyeiOz?=
 =?us-ascii?Q?GpAdDxK2TONb5wbUNfrsGemFiNbuEzh5nKAVvN1xdkHhnEyZq6k2SGHwukmd?=
 =?us-ascii?Q?VDnsdTCz7a6DPxpgvCd5vKiX6oh3cQapnfxifMF14KHm3T7KrBkySj0xfPtO?=
 =?us-ascii?Q?RmId0ZjvTIj/CdiZGbbLvZvAzVQcBfNxSgCZs804NNpHpoRR+HBwcTZDA/of?=
 =?us-ascii?Q?b5lawueM2KlYupPNrDY8hA/wUf18Mycq03KgVhj46nzg3SYEWFaMsoaP3U8H?=
 =?us-ascii?Q?akKzUif3MC4p5PiJkcVC9jYCbmnfqhdIEu8dPZtxQtQAltpq2NK5ttTbqOpU?=
 =?us-ascii?Q?7Nj7r1YFH9p7Od6fAWJH+2q5A/Wdxe+VxajLo1Nj0ZvRyoQaapVIEqtmdPZ2?=
 =?us-ascii?Q?lcgsuE/jd96Gv9hBDYBkDK8173dFmIcJiiub0KCNnDLBx9czDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:28:12.5777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e102380-9ef1-4847-4db8-08dc95986419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249

From: Perry Yuan <perry.yuan@amd.com>

Updates the documentation in `amd-pstate.rst` to include information about
the per CPU boost control feature. Users can now enable or disable the
Core Performance Boost (CPB) feature on individual CPUs using the `boost`
sysfs attribute.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v14->v15:
 * Add tag
---
 Documentation/admin-guide/pm/amd-pstate.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index f5ee81419a93..d0324d44f548 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -281,6 +281,22 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
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
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.43.0


