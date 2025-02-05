Return-Path: <linux-pm+bounces-21387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8688CA28947
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBADD3A441D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4D22B8A9;
	Wed,  5 Feb 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Smq/YD67"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF522CBC1;
	Wed,  5 Feb 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754943; cv=fail; b=hQZZ9HaONXo/sLOnUwc+UlCiZe1YJmR9KqPjhSwXAkETRydght4P0PeeltkIjsttmcRZ86j4J4/kZ2xUBb2fmJJGlPskXiNMgFVnu6v/gjDzVFR1qfBwevmhnhxzlnziJHjTNFcLHT4bCqvu98sPNk5VGsQd+zD4B/vixohK004=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754943; c=relaxed/simple;
	bh=NNkvG8fjTQh143975pwtjLRJZX8Q3UdJEqoVk5ELndk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i319fre8Vqxji6j9Hpb6l3sQL+SZVRE/5JYvs05KTkQrpfRpYq5zccd3E5sm346Nbx6LjDwIY32EuRvFag2FuwSodJIW4pEAibKnE93XbNKD+KkBYGUTcFdrUQLz2a9IzofR0FJ5IkBxjr6un9MMQtx07dAZ/n7poJFqOoVF06k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Smq/YD67; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXts22GNH1/H2Kc9yQTm4CsySvfID01QKRiChsR1f9Iw5IYhkoKXzOlUHlh2hYl6M6iqU70STBD350SEXQq9hVDs4TXIj85XWZ0l0DlhIg2gjP+laVpc+oT1F6g9uzaSDvm+58EnsIf98VuidnkgqNDlO/CAm6W+zwxRNVAngyQYp49QlbAqXBJwYhtOW/WAbGyH/cgKxhOIB88ljEB8h9igN741f+ZN2p+uS5viDub4iuzNCZgD0S759Vmww9e/u+FkyIKSR1Ao5YNoJ5ak01fSjYjaRzlYp/SFGojzavqpfDDXgL1RArAiHV8hqkFW5UwwLVo1SRzsECRoSuhb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNZLuiJ3UwXP4RTV5fFsAa3LYNE78pVCXFjThAfL8Ww=;
 b=UBQqtAODP7bMtsEw/I/g2st+mgQEQjJUpf2OPtlnyevYxeg5B50v3uWEfMHMTEht/fwzd9+iY2ZmkM6KvNVLN5TNNq/WmeKDlrISUDrVqpvZPgBQE1LcmA7bzwGzpqsd/ccqntoCsm0hhKD0JVyk0p1xsUOeecmzp01gosjT7qWOuLxyRuq6+cwzgIuwQmVlDZj0S3djF9pqlovC08Kd5Jo5NMEA2Wac1b/hil37bIL47rudFwDmkeXUp6j/IKY5CW/gVGsZlPGI6EvJJ3IpJztaUI6dGotaKCiYcqhWividivqdEjJ3xAlHsUTf3ld6Udk9I2AgqGFcy5hv88FPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNZLuiJ3UwXP4RTV5fFsAa3LYNE78pVCXFjThAfL8Ww=;
 b=Smq/YD67cqyhU551grtsttzF+PhD80gxO4ZFMlIl/vIvABAhQ/NmUyMakIw918nj4GSQXHC/bPX5I9M0WCwi32sKO7XaSuc4FdDhEuGTPjg95287oSwBrfrrsMlXxuPDb8Xur5wge6yac0Hk2v1fIM1RA3/0FmpuQm/q16xPdP0=
Received: from MN2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:208:23b::11)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 11:28:53 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::22) by MN2PR11CA0006.outlook.office365.com
 (2603:10b6:208:23b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 11:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:28:53 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:28:50 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 12/12] cpufreq/amd-pstate: Remove the unncecessary driver_lock in amd_pstate_update_limits
Date: Wed, 5 Feb 2025 11:25:23 +0000
Message-ID: <20250205112523.201101-13-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f1e624-f806-449d-3717-08dd45d84533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ergN/J0gVUYanWnI0jXtjJldosHjID4aSauzZ9t2Q0oIGGB/it1JAy41lab?=
 =?us-ascii?Q?RZH/qcwKC5dpMw3WxC3aaJq2dezrQaH+ct/rgCff05vq0VntT3mxK2vmfnp7?=
 =?us-ascii?Q?/TjjYIv8G0mPQY3zmccfgIUdZzhXSRnROLK2iPbmZ8iVjpHu2N917cGxpqlx?=
 =?us-ascii?Q?boBWlTbf18BMbW1sm4kNeChHfQV5Nk7naItuBKGw4jCDDuj7HaXgPgyv1dyT?=
 =?us-ascii?Q?H2N64gPfuoq6MB9e0xr7Bny3H7PMyAOMR17/iPey2nBVgGhReb4WRNlTZnkr?=
 =?us-ascii?Q?Dy98tssOda0r9TUx8KrgeEyys3Rhl/pGth+xDjr5Oii4AMTM5M13DPFlVSEf?=
 =?us-ascii?Q?LMD8ZfhYJsSi1kB1aJmkPV1cXZwc0wUWFIzRx038fhv3l5RV2ectHrqUTUaQ?=
 =?us-ascii?Q?NCZP/aY2xRmhqGEufY/hRBNR3T86Ab8LRWo1WdJdBuL7N9iZRpwzufaw8t8b?=
 =?us-ascii?Q?lTXitIkHBJHfT7IrsmTVWF99utp8Tkh12FN7hRp8x8w71+OWeJy6N1pHsOr+?=
 =?us-ascii?Q?tma2obvYTBu0fPIB7v7E5qKRODWkVteR4ZQK+AbIx8MkOVIvIrXjIacQg+Hx?=
 =?us-ascii?Q?ZVwHQnNV+e8EVThs0FH46E9Hcnybjk/vfS+Z5krjDcq7aT8QkhMfARJz8Pq4?=
 =?us-ascii?Q?JqFqAPGRPcny6yZpu+9wrGA/Pgbv1f7bHO2tAQoTIhrrhcsCYnIFBgj1Um8q?=
 =?us-ascii?Q?nTmW2PZ15vtPRcD2Nu8hAkLG34HeOjku3tlulp69+dRGfqi5qa/lAhfUu3JB?=
 =?us-ascii?Q?ZwnkFJk6HpmNbga64Z8T4cnJCEOxSir73GX/YfzHOD8v/t95Wg7IdYun4SIa?=
 =?us-ascii?Q?6Q1Ilna6uZQxtqMZDtk8/EP0/bOh0CNDkpNjNTq2Mbxfdp5abqdMEFOWwBFL?=
 =?us-ascii?Q?CSgjjidu0Qw3Vg/zFd78D8MzV4AvOJsbR4l2O1BcfyF0JCsvh3wgxFObiGQ9?=
 =?us-ascii?Q?Ag1kTaYLVF7cch0YaTdEgSIcH9VERap1B1l67Vim0u2ckpzzvfFXR07oep2a?=
 =?us-ascii?Q?dTNrmLifeGAoSYbZkoaB9mD4VzaFqOs5HRS7tY5504RnFmX/qqDftFWBR2CC?=
 =?us-ascii?Q?NOjKtCxs9AEiNvJhFgaylg5w1xnMt1lGKqNiptqs3YBN9Xw391uG8vWA3VTi?=
 =?us-ascii?Q?f79lS5zNomv7fFN57SY7c4CfpcL20gvSbwWrcRXXIl6d7cSMhL4xZWuVwvLD?=
 =?us-ascii?Q?/+96+L3yDSkVJTL7Ws0UsKoFwLVPaY1bzW8FczwwEEknZaWEtnzxvwg6wtQ9?=
 =?us-ascii?Q?a4sYTWJcAWLVbc5wQtFdCAheF43ayf9rNgcBoq0FYfe7U6YDzTRcwn6DqPGM?=
 =?us-ascii?Q?PNVnmryDt2C7sGexlobDUuKEPAKFheSLfiMs3BZKTgSR8mnxxV/svFyU6Ap6?=
 =?us-ascii?Q?eKlWTRNiD3DNGqkYETWlEb0Oqsd5fJYVjBYsmQoz3ZRIJblrXW6mEK102bve?=
 =?us-ascii?Q?8zM3Y7tJKFQSCT1Qm251Jl+GQSsD6gX9Z69cm/PLLWfNzVSG+saLA7vmfuA4?=
 =?us-ascii?Q?AIQLWlXgaU/HIpo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:28:53.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1e624-f806-449d-3717-08dd45d84533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

There is no need to take a driver wide lock while updating the
highest_perf value in the percpu cpudata struct. Hence remove it.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ee7e3f0a4c0a..08ae48076812 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -832,8 +832,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	if (!policy)
 		return;
 
-	guard(mutex)(&amd_pstate_driver_lock);
-
 	if (amd_get_highest_perf(cpu, &cur_high))
 		return;
 
-- 
2.34.1


