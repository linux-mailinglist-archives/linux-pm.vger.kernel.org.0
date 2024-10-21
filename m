Return-Path: <linux-pm+bounces-16070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4509A629F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CD31F2151D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B581E2840;
	Mon, 21 Oct 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZKrof3Kk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D01E2849;
	Mon, 21 Oct 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505989; cv=fail; b=I0uypGhXnnmsPoMWcg84I/YfkmV/qCMeFLRPU4uzJNd3G1zY4Z3IJG0RxoWPD+30bKBGHhaFoeobCpuTBzUAloN4qXULiEc87jcSWcO3Ay3qSH7bA2gNOBx3WoPMRHfkfeeEc/EP8zZ4eNcGrfnbE+PrhVwf5Pc+j1afSh2h14c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505989; c=relaxed/simple;
	bh=1ActTH8cxm7yu7NNRKWVICl9A9eW8SjMufPOadcUcE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvSbPZ/nZRhLOtxdaRbee3i0DO6fZOblXxREisWZZn88aTc8ZM5y69UE3wYuWt98dgqGGvuOlh2Lw9wGYI09R/BbaPloM9S7B0QxESHNSmcSuno+xSH5gKyL+6wfprZdtlGiclh0ODDzTC9PgOMaZj6fF1zpJAphpoAEWw4RPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZKrof3Kk; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKjJb92HIDRCTRwVGPyIJzZPX6eOMtMJuz1cXnBYyYxrfz4BO/htR8lSedFWtU5Vvk4mh6ub0kyKZrWqCCDtwCafIJaYdKR3zOKmW28pTu0b2GN4CqxwURI6qlJfhHWD7ZzwzRaVTn0pMxq/kYPi43qSNULyNkVIGUMsbl7bdJFxwP+Qs6WqIbfkM2ixFiOBmXu7kAjt22kQf+iMpsWXAQ0rrHX97xl6spDp7QfurKfrtoA8zb8puLn/nK2JgjRDXwCZwb0VXRwjFL5Rd58sBWESQJlJMkweCE/bJdNJPCptMWYUn4i2zLg3ZIFlMiBfliHRpW7aRQ3/ZcjmPcpaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cOBxUTije/Yt4LPZfvJ+1ByvQuJAqhd2lDCwTINpjI=;
 b=g20/oDyI+rbeiJAWAlZR/qeNXesU3Hff7i7nS4pfBFfQcspP1Qrksg0pR2VVJvfINB6SyCpICb66cJCN2BMJmjLHWUN++tcJ8icg5aXJT/RDDeCwbECv8/R0/ALq1RZ4EhSnjmmgSM0DHQv7wBopubOpDvHxDdpyWFyNfFlzj1DVAO9CNAsL8CF2soeTp1wX013XIng8aK22xe20Ayj8ctK6pH/ul1g7YEQ6WBtJj9pxxkJn/Y3M2bm1UTGwJYCSfgFyJdgKScGyQ/ljUGRUv3RXs/O1HpT12POavFommlskPlDZ/mxX4Z4jxQh4meBXkgRKBNJSowHayCJKWuBr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cOBxUTije/Yt4LPZfvJ+1ByvQuJAqhd2lDCwTINpjI=;
 b=ZKrof3KkJLbyABtWGJkC3FtVi3gGOmt92ihmNl3lymf6Zb+e5MGrrqqU8rwUS+E3EWnAwecUOht/GKO+E6JWOyLUvJ/RMdBgVZatfjcifqnhoh1K47nRydb6UxeWJQYk9iL6KmGnwPcKTEuOcgzsz85qHMnEEjZlaypWjT8y04s=
Received: from PH1PEPF000132F1.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::34)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:19:43 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH1PEPF000132F1.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Mon, 21 Oct 2024 10:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 10:19:43 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 05:19:39 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 2/2] amd-pstate: Switch to amd-pstate by default on some Server platforms
Date: Mon, 21 Oct 2024 15:48:36 +0530
Message-ID: <20241021101836.9047-3-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021101836.9047-1-gautham.shenoy@amd.com>
References: <20241021101836.9047-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8301eb42-d83b-454a-d495-08dcf1b9e19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWtavyfg60UE7yKeB/tJdbkHd3Wg0+l17y838x0WNzAtuH9o97/U4jAUyhWC?=
 =?us-ascii?Q?8Hl7vpGhOxze3xnzZEkOzk7EZ9fjx/5OpbJuscTGFjLIKOk4MmhjH9197EQn?=
 =?us-ascii?Q?wSz24g9ZrMbNWygdhhHxfDqOyPakfScbXhSKH9f4VHsYzdH98JM6wYLPSJTA?=
 =?us-ascii?Q?yj3Bx+4+Zc5Qyl6tolOtTntxWsbflJOsu7mKiPcV8OCQ9RNH4LfQttRp1/Bd?=
 =?us-ascii?Q?z4qvI+CmpL1bq8928bG5IuSB0S0EZo5NSD2Dph5XmyVkPKQau4kkJhm7J7ra?=
 =?us-ascii?Q?UEOiIB4V1mhENgqzT2CD5LKx4DXDsdW2bGgmCkVeUtlilWRIjKWr1vVpx/A5?=
 =?us-ascii?Q?Mcngllft5tilX9+lWPIrg8pwZy6PZGKYo3XbP+6BRE7VBNhD1PEl1yWM2gMb?=
 =?us-ascii?Q?ySAYGTRlMg9Mjd2Z+b6QKYLwvjNcxkiLwepHpGfKG+BMxIjqrFrR7ocowMkc?=
 =?us-ascii?Q?8+lF7pdHTZkka5WOMLy5ufhGscVO0VxdcoC6CEOizOSqK7LbptWUlOXRHdyO?=
 =?us-ascii?Q?sHYy1vdmoPP52k7CmamaVmNtFHE2vKdYr+6h0jMzCG9jSnkXBvaaDZXXUDK0?=
 =?us-ascii?Q?wIje1gC65Cbv/Xf0eA86ns8+lkezfswWdaIm/3Yle0uhdIma5wVSbqGzBF3W?=
 =?us-ascii?Q?y1KHtrLZb50iJ8iXZLe8h9iOxbf5/c2RPP7jXKZeMtBR7OQ3D+0oepA4KVkK?=
 =?us-ascii?Q?h2bw2wtVTvdGVetw8/HrV/gLWg4N31S1Y2b73Nt9D5lLtWR3KpOha0AtSNdb?=
 =?us-ascii?Q?Yw1GWD4b1zjM3oItmZLscBdTX3XaSs7DAMp72b7iS8M5dfLRrPYWDegAk2hQ?=
 =?us-ascii?Q?/guEmJHxFQhEs1kERrUE76WZwRU4vucYPSqcs5wRuSbP/SZxuXkJyMMw0Rt0?=
 =?us-ascii?Q?yxl4Fx1uPvDdyak888t+2by2zRWqSYVTj9DsY/JjgWCmoigka+j4A98X6V+W?=
 =?us-ascii?Q?745tSPPGcEDBoMDRDThmTrX1yQ6usfz4dXyi02/XClEjyt+50nx00toDo+Bz?=
 =?us-ascii?Q?nyDoXNdLCdyVNBAqLx2ngmD+kq9ZtZw8LPBXDn89HKBr/FUDc+rIoKduiI3W?=
 =?us-ascii?Q?tLZnSW5MWUywnoIyX+7L0NdXca4uJ7HsQgNXLoVAop2UU7WNkK2ZS2g4WAZe?=
 =?us-ascii?Q?+ZtbgHnMOapJ7Vib7lzknEYcVYu/lo09ffC03E6PjXm+Nf/p5d86c1XUI56u?=
 =?us-ascii?Q?/MEk65N4T0HQCKXxbqSFLOCnuVK2W2/4zYyNO9ZEWT3FgpO3vAUrHSiyM+7z?=
 =?us-ascii?Q?jtQA5ZFzEX1EnxQrkZlonpZkALgKh4QhjjQhDsfW5YfMcNPtwddCu9ig74NK?=
 =?us-ascii?Q?cqg7xg6MKzcmEoaC1GPlrNNNp+I6GcdBTAvj2x2NSDaMl3CmFMNOA2iRSJxx?=
 =?us-ascii?Q?EKSMEa1klsfQKiQ+SIJ5WWTPGaHBslAAY5d2XvlBZyLjVsuisQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:19:43.4731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8301eb42-d83b-454a-d495-08dcf1b9e19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

Currently the default cpufreq driver for all the AMD EPYC servers is
acpi-cpufreq. Going forward, switch to amd-pstate as the default
driver on the AMD EPYC server platforms with CPU family 0x1A or
higher. The default mode will be active mode.

Testing shows that amd-pstate with active mode and performance
governor provides comparable or better performance per-watt against
acpi-cpufreq + performance governor.

Likewise, amd-pstate with active mode and powersave governor with the
energy_performance_preference=power (EPP=255) provides comparable or
better performance per-watt against acpi-cpufreq + schedutil governor
for a wide range of workloads.

Users can still revert to using acpi-cpufreq driver on these platforms
with the "amd_pstate=disable" kernel commandline parameter.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 23349f50c83e..3c14962adeb2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1832,10 +1832,10 @@ static int __init amd_pstate_init(void)
 	if (cppc_state == AMD_PSTATE_UNDEFINED) {
 		/* Disable on the following configs by default:
 		 * 1. Undefined platforms
-		 * 2. Server platforms
+		 * 2. Server platforms with CPUs older than Family 0x1A.
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
-		    amd_pstate_acpi_pm_profile_server()) {
+		    (amd_pstate_acpi_pm_profile_server() && boot_cpu_data.x86 < 0x1A)) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
-- 
2.34.1


