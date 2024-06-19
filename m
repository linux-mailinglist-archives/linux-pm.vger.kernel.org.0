Return-Path: <linux-pm+bounces-9557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30690E6BF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC331C2031A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EC13212D;
	Wed, 19 Jun 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="foGE8V0d"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456613210E;
	Wed, 19 Jun 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788653; cv=fail; b=LxauD/AZuZnfP9FPIvLB3DyNKmHxj6uCOaIy2qm9t2+XSI3ZE9g5YUrmxd9d3tBfwpwMt9hbFHKULEIK7jx+r+sByWeV1wCY8syaETCnN/FUIw5oTRm29yO5oLAw6zgtbvZKJ7cPu5j/MnRQRRlPhva21/RIY1mWY/92jsAHndY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788653; c=relaxed/simple;
	bh=d6jqhrwByyd33I4vHBWKCtSeirEFSuvn7C2/Q2ZiN6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaV9L6JDJ9X2AqRqBPW0Ms1CH0iJHsMTngOReqtd06NZ/FEii4bitGXoD15nlYUpdn9ZcdWHb+OOnXXrNszVvYaha8JTDRyqVKUvkvvlsr9z2OWaxbPSIQ5dmwlNTBzriooFnz0cYFPol8r7zCYpx+wZDtx+868BvH4LhVzznis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=foGE8V0d; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCCihIQOgGQXTgVyJ+23AKK3JtKs3Rxznvl/sNBbMX6v3pA4YZGZXJnOOwpodIJECThCQ9KlEhXfT4vpCFXUV7gZtXx5EIw3DPyBrkLV1u3inWKfj7w02jEZ2x23HisdT5hE0uK2iu/HSI0pZ7YhQBEqb/2rhS6LyVmb3wLEzBaXw0yYkoiqdCpwfoA5Ts436Cva+po+C6F5QzwBpXKxCnN+prdgaxe6pwNegss7Kr8swkBL/ic0MxoDqrqC3SzdgISsBY6wdXEpYInH92bDBOOhX015tkof9/hiHiOf90F9rH/1h6mOiT7ervV/zoUXqFHXhP1b3PjbHYXzEMsXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/x6SR2JaxhlHKVmIOb3MpQpXcSb5R+h4OapRS5R4Dc=;
 b=XWj6LgJZYZxo/5ouilz4Thte3usvbP1Cnk8EAOUu95MdZi1m9ljmrgyVnMz3lRqMiFw7Q2xZixRRFVVHLS4t97V85DGo4Zwv1KmDYwG+B6wbN7vKV7JjNR5WP9frgArbKeVJ73FHzYjOsEbgw1cEYoa6Xy6THMWzlekMNyWh8UiEj8g8su8XwAyGyJKb16kUD5xHREFvn1d0M6i3xc3u/LJhb21kZSFFR3e3fXsInngsx2EWiFTgpp/2gOo3bXkcX4sZRsW63gmY8/5rqRTHqZXW06wap/Sktoi9Qj4Sv1GaAfe3xh7MtPB1gGZJLMn0gosGQxavqNVqbrZwCpLOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/x6SR2JaxhlHKVmIOb3MpQpXcSb5R+h4OapRS5R4Dc=;
 b=foGE8V0d9tkCLDF1TvL1+UH+WlyTG1JUm114hkv3rd2tyZwoKwr43v1uGP1RaFSfTyi12zAYoqREpl7wXngBVGkT9veeyfmgnnNhl1pb3uuX8L2uegRFJdBQp/PTv4cGgnJS4GMjNwRixWTAftE8uvS2GhFRE5CT3O6oTfgHSSo=
Received: from MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) by
 CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Wed, 19 Jun 2024 09:17:29 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::82) by MN2PR01CA0023.outlook.office365.com
 (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:23 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 9/9] Documentation: cpufreq: amd-pstate: update doc for Per CPU boost control method
Date: Wed, 19 Jun 2024 17:16:42 +0800
Message-ID: <6b705dc178d484dd4f99e6bd134bdf09ee0a879e.1718787627.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 016c75a0-014f-411c-b5de-08dc9040a468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kglPT/72QhzD9Ju0zU1WwxW+mQ0NjCi0/zntobF5m12A3348dPO5m/rqCUjm?=
 =?us-ascii?Q?D6NNu7uCZL1Keoi6r6JLGsbLI0z6sC0FzGDnJacbgZxZDR5Qme92FEXMVa/x?=
 =?us-ascii?Q?JdGVN48gIIUq9kE1sIbJdhaLNsln/4yNIpk3ADCX3ajHhZDj+eKzyi8uIa0Q?=
 =?us-ascii?Q?sW5Onnnl1GYvUpq5QUP5vUWe5ucV0tCuZCF/xKe7gVj60oayUdtv6lkbyAwV?=
 =?us-ascii?Q?wUhmaMlbfOXB+VKv52us/6Mv+AayZHAutXWHnOhrJtw8dUIKehurNJdMzOmH?=
 =?us-ascii?Q?Ul+RHPIe7q+Sz6o/PSHRkkzqn4/2R6N6ofintZheE6aAQHh0me9OI/O+0WV6?=
 =?us-ascii?Q?YSlcLGMTtXgGE2/uhCfuccjNkJ+KdfPm2eU7PFFqtWKjVEfl8DTg6kKNgqzA?=
 =?us-ascii?Q?bp5BZJFyoEsRkoTTBgkqcmsqGu+4s/SWzQuJcZIY2yDj8C3qkg2oHC9nSNRy?=
 =?us-ascii?Q?caqoSts7TZN4Qrs6bpOgYc8z19xt23kaEvqW/sDKkZ5mQyhE3qi8w1C1OCw/?=
 =?us-ascii?Q?O9KdEzLg7aMfXcZLOVSGuaYAFlc0Eb6/Bq8w1DXUMCw7oIVOxKosCc7zNEw3?=
 =?us-ascii?Q?oK0jisFQthw0pMoGZM5LL8ThzHnAeZbmTMRKPof/Y/0mNOliIhL1Kp+aKSYz?=
 =?us-ascii?Q?+P3IFm4OcqaCYbo4mV3kvitPPISSNm2GZPqyUMAQZ0TguUWfqxjIkVdjrSYM?=
 =?us-ascii?Q?xCd3uUgf8nzcKiZI8hX9272q3Z65OWJ1O0EhRCiwnXthiBC3RO0ooZw2wCUF?=
 =?us-ascii?Q?kCZE2fvntEPm+MO7IBPUGXLI5geP0eiC6OeyySHMilCdvPNhPLx+XhGwJwHb?=
 =?us-ascii?Q?DlnAri4KA4fydJxdbAPMdou0We0+Valf/U/c8Wjn6XSTdoWx3gYW7naKjwdX?=
 =?us-ascii?Q?X4nbJKcZQGQPUzFih01Sld3k6ivX+Qg5K+yrOvCSYUpKSZ9lyUAGChp7MWLP?=
 =?us-ascii?Q?xaDjw61baMaSomKJnMtciv2TtiJs0F7YnlAAK15u4b+o92cXL2l+ZzK26Vvl?=
 =?us-ascii?Q?KdBSvBKzsiOLWmN5NXiAi5bqB4ZYtfdebgnoOjL75wk7o0b49ifsYAaCV0Yc?=
 =?us-ascii?Q?tfrCY+JH5o/2h0R5EcqIIsSRwzrmEx+t7dc8kGJ6XtsSGHsUtOgmzX2+lpWO?=
 =?us-ascii?Q?1WehnKm921RipPwNZFSK+ukgpt18UuPFoAPhS8CXVdU3xePTDbdpkTv9lxqI?=
 =?us-ascii?Q?SGOY0JT9e6ZJN5ksbLNaY1fV4Wf3sq+6xlewsY6wn+eMLIeXCvAi9KGJmWzG?=
 =?us-ascii?Q?al7IGu28ebks4O6j6wPOd5D/O1T0RQzIB7ft68AplMEKTaO0gXorK+gJsHUZ?=
 =?us-ascii?Q?TIcagA8Wa1rJPQu2OCmWNn9ef8LaRdUGPG46KhLDmMNGfSmvnnl9H1BZlyh9?=
 =?us-ascii?Q?KCft9Vdq1J/rsJ4jKXQh1HhZ6o1n0pzHPY+kTSGHF2BkeZxMKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:28.9618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c75a0-014f-411c-b5de-08dc9040a468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

Updates the documentation in `amd-pstate.rst` to include information about the
per CPU boost control feature. Users can now enable or disable the Core Performance
Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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


