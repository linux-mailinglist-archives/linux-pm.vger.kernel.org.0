Return-Path: <linux-pm+bounces-9290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCBE90A65B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1E2281FD1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5D190692;
	Mon, 17 Jun 2024 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4vDJqJ9Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE613190667;
	Mon, 17 Jun 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607656; cv=fail; b=e4SHy09RD/s9v1eX2E8c6ErTqY4nMIomj35z9Jgn5uQY6bL8X6LL91T+lJyF3jt8ORbEIHYSKV7QILWZ2pnyakkAACp972VRawynLRgzmypMPp9Dk8LaNbYbwX/ROk1dlZTvBYs0laWvXGS5BLppRcUnUGzgfuNcztuuLESUAsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607656; c=relaxed/simple;
	bh=vmW6DXdOx1bOXeQsIvO3dHMuSrFfDmSQzbv1hvhUzwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0dqFv4XdeuYUXKlklxjEwb/TckjlJDNSBy1iqvh/gC8CDdokryVyw5Ek3wBognTrPsLCGPg4Di22IqxQnKk5KK2faLgWRjrQax+6p8IVu8rpyl9NiChBDybU4G/2Lc9sWnesCjsI/4mzUrf5FphD6g3gjLZvaGrZi+qOffnBG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4vDJqJ9Z; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI1ZsAOTkMetjn1nDgQzh+mii6fiQSJAY2Fx85zVut40z7+FX0RnjQgz8xaXd0i1CzVf1IMMYOkLekeon5x969phzRmKNBMccLVUyVeMCS4jZPIOQTdVoFunw6222X7ku54MPTkvg/81jtgJ9ICiBGJQx3SIsKh/3ppBVW5e6QTqCQdy2VUavtS4fo6lwyK3g0DT1oFNUhY2Gme0qK9mhAZrccFm94BLtL/jbx6eEml+V8OHCCYOnPj7G8knQc8EI+PA1nSC8avqZM7j08OcmJEq9Ba/ozRmj+s4YIqhIIqLvcWdfJDUD3W8Z7g/q+cO10smRA2PEGW2L5WKhlsu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdJhyeou7sbQf5ocATfLbJqDZ0CE519ywL5kg5PN5/4=;
 b=T6y5f3on8fPbqKWB/0qQ8Z7qLuBNhHyh9iKpIjoqyZYIrszp2tsrgvJWDESPWzlHna5JmrmHTr8C3cn6S0sJDswW84ou3LS7yy/fqluadWbmaU31u7o26YxCfA7w/njX/nQkPunKv6BSpa47+ZxNdGdpDHpipJe7pAUhh5VapwEAVN08UPvJP/awsukipy+F+JNA1BITYHvax4ThrV3bp5KXZP+zCw9RbyDaIzwCJsahNikbLbd98/mCGrGopmHZ7I1A7LR/vOjtMQckVo8ppSBUmV4LSSLEC3OKkxgbjDzUFzOtDUV/Nr5MXWTIGy+kRD2MyrKUjGDicAg8oA7UEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdJhyeou7sbQf5ocATfLbJqDZ0CE519ywL5kg5PN5/4=;
 b=4vDJqJ9ZzHVApHjudU4uFgfE7aPE3Xdx2Y+LMLeycXLRlBUVcwb8W4KYUpUvm/sfmYAAhj0HwmSfKebKjStJRwHBCVJmjVIxDo2ybKYcZ5TIxnd80Z58fBvspgsC90F6wu8nzPSKdfw+kNiMsp9FPaFKRH0oOs5BqYl2sThXei8=
Received: from DM6PR04CA0008.namprd04.prod.outlook.com (2603:10b6:5:334::13)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:00:51 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::b6) by DM6PR04CA0008.outlook.office365.com
 (2603:10b6:5:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:51 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:47 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 11/11] cpufreq: amd-pstate: enable shared memory type CPPC by default
Date: Mon, 17 Jun 2024 14:59:13 +0800
Message-ID: <0700459b88b496963dd5914631eee753bcf0a560.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee39b2c-9313-4989-6676-08dc8e9b395d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2mzYi1emrgUOMBgMZ9gXQ9q4XCFiocAb6aTaARf3CCrDkZYS4WBT3kgPQDs?=
 =?us-ascii?Q?ycgzWcb+XttE7Qx0Gotub21SlIeB56oNuqvs/ErtAs5/9IMfzNxysh/QrlSq?=
 =?us-ascii?Q?luJ70d0W9Oby/X5+ePQNMzs0T0EGJXAf+eTsYZxhZIJxj0PQupDu7wm52yu+?=
 =?us-ascii?Q?fYJ5YYkW8ARA24/sYfbag7SOvjg10JBb69RqNIImviDaLsDifdc0Snz/9N1T?=
 =?us-ascii?Q?W7nhgtWkLXLVPQ2AlHSxqehc1zlu2h6hYJJHw4dZENoGpFwk8djsWyRt3M01?=
 =?us-ascii?Q?5OrGOil8jOIiPg3k9hCFZKV6ZZMDIdbuWFbHHXVwwDtgYLnw017lRG3TvFMY?=
 =?us-ascii?Q?HRdU+h4f44ulI9z0/8YhxgxqlFCqdbISLQoj4lRC/+X2UvyecL+EtgXwk0ER?=
 =?us-ascii?Q?pL8naIR+aacE9qtJqAMhSdTDpYfCB1dBfWH5SjQrESqQb/fkvqGw48g4WSxr?=
 =?us-ascii?Q?naRV+WP86WzNRTZhgFvZrdjz6A/EokfnuYRcnNWJaWR2I44w//Hqpi3LUGFt?=
 =?us-ascii?Q?cEIxJ/CaWI2E5JVZ+CJYNz31+EpVTfw4ztY344aRttmbm4dV5e1t3OyStGZn?=
 =?us-ascii?Q?mvR+bOjYH2f48md6kw+BCy0xOQ6HgB2rktRgMZfuDKy6jHMcbNEJ1GE1h8Id?=
 =?us-ascii?Q?aFAaymyJl5nF8Vo2Yg5+7Im61I4f49B8pkKTy4hafAhJweZXTiBx+Djo5DCk?=
 =?us-ascii?Q?DI+iq4rnRIVn0kkvLsgxtAf0Qa6b6CdpopA6DvvJxluHIh7eF2TS76sRZQnn?=
 =?us-ascii?Q?fCTNQH6xGFelbnkgLfwf4CTItqU4xHAZfQLeyesKMyPiwv0GrDg7j2+gSqL7?=
 =?us-ascii?Q?5qI8PLC9l73lcSxok4IDkziG+I0WzQO8bFzF3eAax6nd3kt+en+hApf6lY76?=
 =?us-ascii?Q?SDiv9J4icb7FOEU5xcPCiUii7CN32elONyRJMXlQZ4Au352RoSZxKfqiML1p?=
 =?us-ascii?Q?vJdtZaFxI9hu6FPjzknkSIlwnRax5wOUil+w6laVNZxTC0pVZb8yCA/JQ2QH?=
 =?us-ascii?Q?Ba9oVLh3wmBKpxDAeG9MO9/4MMOLAobPGG1uN3cgBLYMnt6a3XM9KizRmXRQ?=
 =?us-ascii?Q?0Pg3R4qkzM9qQuSZLF6ux9Hw8n/WuZ2JbcXeCkTOja7u2IIb/BiTlTOEMt7j?=
 =?us-ascii?Q?XycCBMN4KMUwvgdCFbRcsZZrMh4lO7RI07EAGbzsQRrALqvF3FgQHMc06IvM?=
 =?us-ascii?Q?uFp58lL1cf9Wc05uKt/R8k3Nqmp5TEBW7arO5oke4rV5DC2gG63ffuQCUgHM?=
 =?us-ascii?Q?024knchHtnNeGYmSDI7rcZP8q5y2dTpDP+/5QgqDxY+7j5dNrT/4UdCkeduZ?=
 =?us-ascii?Q?gY69aGpu2wSKupgXgXSA/QxHF9npI7i4FnULR98e1LEp7Xnvem5JkKHCTA3c?=
 =?us-ascii?Q?ruCPbGkzpMg6EauRKm9c42DxyKBJ9krUL+KdTHDjgxNniR3JRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:51.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee39b2c-9313-4989-6676-08dc8e9b395d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

The amd-pstate-epp driver has been implemented and resolves the
performance drop issue seen in passive mode. Users who enable the
active mode driver will not experience a performance drop compared
to the passive mode driver. Therefore, the EPP driver should be
loaded by default at system boot.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b48fd60cbc6d..eca2f7dcf7ce 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -96,15 +96,6 @@ enum amd_core_type {
 	CPU_CORE_TYPE_UNDEFINED = 2,
 };
 
-/*
- * TODO: We need more time to fine tune processors with shared memory solution
- * with community together.
- *
- * There are some performance drops on the CPU benchmarks which reports from
- * Suse. We are co-working with them to fine tune the shared memory solution. So
- * we disable it by default to go acpi-cpufreq on these processors and add a
- * module parameter to be able to enable it manually for debugging.
- */
 static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
@@ -1867,11 +1858,9 @@ static int __init amd_pstate_init(void)
 		/* Disable on the following configs by default:
 		 * 1. Undefined platforms
 		 * 2. Server platforms
-		 * 3. Shared memory designs
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
-		    amd_pstate_acpi_pm_profile_server() ||
-		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		    amd_pstate_acpi_pm_profile_server()) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
-- 
2.34.1


