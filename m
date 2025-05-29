Return-Path: <linux-pm+bounces-27799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97FAC7A66
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E417A220B
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F563215798;
	Thu, 29 May 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwCjaK0f"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C7347B4;
	Thu, 29 May 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508733; cv=fail; b=cILauYzv+HI6B9qqZKt4ZRn98gESLg2aaSdZyTVMLD6lIfbGTmeft38YOr8aUNEd4OK9JHcloqU3gMGJkEbrMFJoayZDCezqYarBcoz7sNFND3oLjc3shMR06VdSeOryQJWhCN5BhQz5doYJuoA7KEcmG5xkD9j2NOJwmL7zV2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508733; c=relaxed/simple;
	bh=/blevvzc2PdLKsQlphXZPoPSc4b1cAfdtkeWmD99RYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eexY1MaLQ9WL6LIEsHBLgtKZOyoUGElZ6HO08njAdkFkdZaH7jkcKrK3M+KIEP9a4+cozdC11a9XUw+meq01dXE6864iONIAGkPdNdj9cFJL/maOzRktLcu8eo4RFPuvlmGeiY5q/XyYCv8adVjGql9GaD4K6Z2Ih0nNPxmN2eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KwCjaK0f; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRetkbp/Xj98PXck86WpJpUx+4l/wkYs6mvfkR+3LKoAjdkJDSqT2EO+ogE8EQLKZlyzDn8ZND0gGbEkp67cXAWlObxQPE/iMsmG5iWfw8uQoFAjavA3zG3Ji8Djq4XgX8ntJ/kkaL36cfdZTBaPYvCRBpj7UibHYuwCGwYMVkfx9ULzVsvfDuTdTD2n5203MsGIoBGf1G1lUJe7mgenpY53DVDySjIhJJo7hDg3gpGnphVHtP3UYo7JcN1+OvCYGyIid5fP115emnvrhe6C+VrwwW9W7s9ICu8i7IjZKNmqZKOwvzo/ggg3f7Qxft333EbWLh7AxqsMGCDOPmzLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdhf9us2KnTt9m4yregEFLinRY7Ev4Nz51E8i2LUYr0=;
 b=BusIvZQ/z/WhshRnUiUHed9+1YKgTO2O19BM2K1VYEhvpF+M+RiZ44hSlrZpOhouLQ+MNskHbeBjKkcXGraxUYuFtmgMbeRTCcPXRF4lrsBRgebkL44J39APmToO6LDQJEL/bloHsKFVn9IWzlFoav/LNUlC/I7ihCu49SGURLlw7Dk9WvF9RVqdIKBwcharmDLJKXJMZyLwVEzS2DCYZNUELsOH1yy79GyzMojBdCaxeRHJbW4FrVEdGTNH1Q2PMx38vE3LZdgzTGrIoDlR6Lb0uSAknzDQAIG3EQ4x26Yar8F7dmMRaauoTe/tSiAAQp0zbqUj6QWYOSSkTWSjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdhf9us2KnTt9m4yregEFLinRY7Ev4Nz51E8i2LUYr0=;
 b=KwCjaK0f0bpotuJaSaGYgPQ89MCpy5Pq1PteoZFfrHWnr0nUrRv5OWFaa7pUAJ6CvvVIm5SYvRgywvvufbw/c2QSHMGhXX+0R1it71AmC8XPaePAu9AqQa0bI3Z2WfWmqiHWyCgNLp8G23hMiRBeJuHPkUzB/RmQUQ+opNsdEbw=
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 29 May
 2025 08:52:07 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f7) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 08:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Thu, 29 May 2025 08:52:06 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 03:51:59 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>,
	Manu Bretelle <chantr4@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()
Date: Thu, 29 May 2025 14:21:43 +0530
Message-ID: <20250529085143.709-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 00144a05-df53-48da-9f80-08dd9e8e16dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+06YKrLISKPx5q/9zAI+6iz7yf/AwX45PwyrK3tnc3varuCb5PL/YT4WO4py?=
 =?us-ascii?Q?6eiDJWuh8O+/edz7/PKtSXjZ00kbOnAhnDpFusPFSkXA5VYOGJ3b3ypqasWU?=
 =?us-ascii?Q?LqrGmOkEtYpQBoX254ZQgABIPrUELGE4kXEo1lQ+NeH/au/c82yUXoVqlXVK?=
 =?us-ascii?Q?X+UsPfieYgaoqqmfWHe9Ku2kinTFBewoBO77+fSY1qbqpQL8pk7OVZgmLdnh?=
 =?us-ascii?Q?HOtjICn1qfdUfwS19psbMXiuPPuD22pryyAv1LD1FC4WxAF9n0fD6V1M9pew?=
 =?us-ascii?Q?YRLzdKQTRsnIki+UWF/bx8kV8F25v8Oq2cPoQHaNRRih+ileD5zqM6VRmmAc?=
 =?us-ascii?Q?DvNBgtQlhsKvq7eSM2T5VnAcAJJNaK6pkftdYly8EtDzg69oyIlHFZtGhvoH?=
 =?us-ascii?Q?invQRnLSmD0Vi7itF/Gceoo+6Na+n+kmcgrxzXyGm+Em2iaKznLD4xxBuJSn?=
 =?us-ascii?Q?33+pd4K13LGFhfXCMk/bRrfXtb/imAHZpjD9yt5W4M6pQ4X/EOEbxW29tU5Y?=
 =?us-ascii?Q?fiEEdvJ2WTIj5E3yz/Ebe+jts+r32yDupH5sXG4IsS5T0YXTUHnIhV9/Fu5B?=
 =?us-ascii?Q?V/L7MQpJM3kvDsoFSK8w1oHF+kWHLBfuBufSKyEnLa6siP4kf2nwRlpWMgcI?=
 =?us-ascii?Q?HgThhhULoDlTwGQDYdHFWMsm2YrV0Ku+n7wfMUxS6foGf2SkP4EnGp/vREM0?=
 =?us-ascii?Q?dtVRtVC8fS8lC86zTT/3HKwIJ5BvQr1DVkp3YJdqL4CwrDXHMqQBo68gEJQH?=
 =?us-ascii?Q?ztk81GZ70HCyvzC7klBwRy8otW2LfdqaPxEYIWFH46XXD2UkSpsMzy/iBfOM?=
 =?us-ascii?Q?7xb7wX8ZR2JxwPHCfszezIdn+8D5INMKEOXZmdl+opvraiur3Rnf/vtnQFlG?=
 =?us-ascii?Q?hCxUzkhl9BmPCryxL1oC5Lg8ZGmSS7uixuxSuJcHysXKiJ1wKGloSM4Z75d5?=
 =?us-ascii?Q?xAl3VoBMm6L6k12O0Og5zcegdu7DVfK9k684zoteTzdNPpJqm/dbwQzpzN7h?=
 =?us-ascii?Q?OFKT7wTQ7etI6J/KpDN0rM4AU3jGqaUH5vqZFpXKKhmu2POYwpSqq8GwyCJ7?=
 =?us-ascii?Q?Ue90FUgdL7zKcF2DM/YPj0e3H732T2P/hjRA4WGcsw9gPtQOFtl8rLiO0xo+?=
 =?us-ascii?Q?f0uakFCE+71K52h3T9p2ayfUGabS21U8aejroR2NphNliAAlA8Jvu2kuvcga?=
 =?us-ascii?Q?5V0X3zzb+ZPILhLSAPP8L6R5wyS+yClbAJioJd3Pd6fMib/XFYLkXu7Pxl6R?=
 =?us-ascii?Q?/pIKp16rDELTNvz4hmQE9G62H0Zo/htcDiSEzBFaV4RpplcZ6PTucwRq1inT?=
 =?us-ascii?Q?VOJbc2nSgYNVH7cnKlfzt9TT8e3ahNeuRseLLabUJH//BAElxob2/QpjewMO?=
 =?us-ascii?Q?t8hlQYgGu6XvlphvzI25emZWZXENa2Pxk25LMOFbsYCDc14p6secy47XfD+2?=
 =?us-ascii?Q?j6kBG0h6+I3gNM7+Qwx9x9wCgaK06Q0bV03+G4XCdt0MraHZFFHuv0wzNYnF?=
 =?us-ascii?Q?+AFQUgwzLIjx94Ir6K+Qhd7GxtoazZbiB8G8usqA4151uBRmgk7ue8KK1A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 08:52:06.1122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00144a05-df53-48da-9f80-08dd9e8e16dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

commit 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
modified get_max_boost_ratio() to return the nominal_freq advertised
in the _CPC object. This was for the purposes of computing the maximum
frequency. The frequencies advertised in _CPC objects are in
MHz. However, cpufreq expects the frequency to be in KHz. Since the
nominal_freq returned by get_max_boost_ratio() was not in KHz but
instead in MHz,the cpuinfo_max_frequency that was computed using this
nominal_freq was incorrect and an invalid value which resulted in
cpufreq reporting the P0 frequency as the cpuinfo_max_freq.

Fix this by converting the nominal_freq to KHz before returning the
same from get_max_boost_ratio().

Reported-by: Manu Bretelle <chantr4@gmail.com>
Closes: https://lore.kernel.org/lkml/aDaB63tDvbdcV0cg@HQ-GR2X1W2P57/
Fixes: 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d26b610e4f24..76768fe213a9 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -660,7 +660,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (nominal_freq)
-		*nominal_freq = perf_caps.nominal_freq;
+		*nominal_freq = perf_caps.nominal_freq * 1000;
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
-- 
2.34.1


