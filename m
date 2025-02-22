Return-Path: <linux-pm+bounces-22711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B6A40558
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 04:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE642555D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B411F9F70;
	Sat, 22 Feb 2025 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F5YaHt1R"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6E4A05;
	Sat, 22 Feb 2025 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740195466; cv=fail; b=WZbx6GzKunqlLQsYvTx/WMjHUE9NlNV9/KAcvYTAqT6o8bBjoKsc19A/teIeyiaZ3/CSl6ajh6S0Iog2ajfZ8QiE41hdOHUTtGgOeBQDKuhZb20ZKyuwfX9O7m+7B1oEl/1oWWbeNZrxo0/I1ry1S8Gg2O2sFnRSpB+UYZYI/TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740195466; c=relaxed/simple;
	bh=WLzlddcUJ/m2BPLR+U+EvqKKuzIrjimzp6Ubn/B14Rs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mdf4Iovd5MuJ/9wcShxwXGUjbOY5FTYHD1OfJYfdc0pOeEUBwZAKMH/MLe1Y93f1MpA5y+8t1Xr65Z+mu1D7X3wXMGxdtch0YgvULt5k/Ppeswgj2OFWRI4khQLvwjSCFm1SJ/YenJidhcqWeWPPZ1Ji13OSwoi3Hv7BlXlg24Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F5YaHt1R; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4RMe7Mk0ehPV8FEgd99keEW686B/hIwZHfNEkTF5MaVd0UaGpkTjKx7nxHUt71nUQ4d6ApVKwM1wxcOXQhX7NyDLQJg93zpM1/PFhkit28ERa6KBjG/2vafL8f5veJxdcOPVK3P3SjqTVR0HpNfVbXoybezYwLNnvu9LPrDddlt0nAjS0dncgveZ/r+9VkwUyKm4F//VPCj+3fnbEKBQ78A4bK4i/xXhaq0xHLACG0w5+HzDTT/ptiPWCXhXDnN6m2K0O7F+I7CgTnz7A8LQ+l3D2UgpoFJMsfPc47RrOM5m1hRIc0TNL9Ht4e7PveJ2rC4LN/xmeQt/7/q4Ddzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me55RN6joNUwpVb+2Q55/QbRjbHgBUxjvuwydlLc7aQ=;
 b=KuXb9EY8i1qFoDN8/75VRI1/mjc5lWZJntMHgTB2tE7/vvKnFmJo7GL16NM+NAVuZL2tnf0hbt4qQlF2iHhaaflCNU+4XmQ5spR+qJbknr2Lo5YXlZeOoXKBbKUCUmDg7Mai9CC/lFOQVKVZvVAtwplU09iRzS+b0O4pRkjfOBYr7c1DzWWTM3bctOymg2KQS2cRMRTaP4zyhCRXSbgiboH1WuAyp9Pop6d2/ai12sA64AJkOcexaBx3G23+zIdu1w9uKuhxW5yhRYVO/8RllxZNxBSr6dcWEpzjDNqZXbOwTCKU7t4V2gfI47XtSZcgNkXYKpWh/Ja6hjU+gOPMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me55RN6joNUwpVb+2Q55/QbRjbHgBUxjvuwydlLc7aQ=;
 b=F5YaHt1RpjjOatCzNrPAk5gqgGTtdFDtl5YJmqsSuZPzRdY35ZN9ttznnvRnhAmTNvZ7HhklgLjVfawETx5RiGfR1t5qINqkivC8b1XVplTQdsrgMrT8mbpuQmw3waljLJH9yBB3j7cZgEZFzvkANABgwHez1kFSrVeGhmLbRVg=
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 03:37:40 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::30) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 03:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 03:37:39 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 21:36:16 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix the clamping of perf values
Date: Sat, 22 Feb 2025 03:32:22 +0000
Message-ID: <20250222033221.554976-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 46215292-df30-425b-e417-08dd52f241b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8JmvdUOHAjxCM0fwoEKC5ZO2Bb1qJbVsicUspnK/RKqy60a63DsnqodR59GT?=
 =?us-ascii?Q?FAabEqT0FIB3OYDJdG9eW8IZeQZOssiq26E1e9WLl44Ukbpa/gkobcbdtjMw?=
 =?us-ascii?Q?mc15Z/DjUev+PrdjurPhHXegu9JSJmITDdGIiZWK/0ipoofoV9NLHC3hamQu?=
 =?us-ascii?Q?x1k0VERVTIOJZHqsekH9FToufqNMbknpZUccIXVw5oIW6RQiD7h8EfwpsiMj?=
 =?us-ascii?Q?K037StWtUZtMtxqrXLixssxDmen7vkBWzz0gFMZErNeqkrllV1EcUqelM6/Y?=
 =?us-ascii?Q?1LxouLv6va+GMWlerJe0+rwUuOOZ+8s5wyt8xUOg5uDgWSEaOXQjjtzyKCR6?=
 =?us-ascii?Q?3reqq7S2i7o7zUKOHb5CL3QiwLrKO/k7abDiBQ8KtiwjntwyRpxzrN2Cdu69?=
 =?us-ascii?Q?BXPaWYFHtVQj4eIHTGm+xPCo5/S4aDzveJJVs2rRevAi5AEV7ps+lJafjq9K?=
 =?us-ascii?Q?gNOKpSiZdNBSHQwhs4DiqtdlOQY+O2UhmBo8TadyRI2Z6EmuGIOAUbdFZ6Mt?=
 =?us-ascii?Q?f/1CJNh1AFRw8/eOZh0ZFlcrSQkpwvaYeSnJoEkQrNKhev04ggM3J6eOSqyc?=
 =?us-ascii?Q?+oHzA+cw0ZcJR/f0oluyBA7vA+5jxbuXPKZHEUupY0TyVflFb7H/drd+uQo3?=
 =?us-ascii?Q?9+m7/gW5mCAPm6IFMPFHOJUQKxCzmBSrQQalVzPr/EzzdwOPwlclvhlKRl8v?=
 =?us-ascii?Q?YKWIydLsdaZ7WtJBCIAS64vUMj2fGzYmFKsgJkxYnwaZfFMyxE1xH8PYsdj+?=
 =?us-ascii?Q?+0g+QlH9YIxEKNePgcqsMLn9HcBmQQcU8l/GbcEyu2+bCaf9B5DoDsKWp0Z8?=
 =?us-ascii?Q?xqbGXPy4nR6q5wgnX+igR4FR/4qidM4vqeJXak5i5Q8cXVv/KM5wrBSR3RZL?=
 =?us-ascii?Q?B346r9nnB+Y+TfAKPvw244EwCtP/K4Z2Px8LwnUtRNYS4k6BFETYtpGgCLZX?=
 =?us-ascii?Q?Uho1QnHX/mnYXMwjUq3fY3DzIG4Ohd0y/V0SqmaVVxTZ226is7EUT0r/L4VL?=
 =?us-ascii?Q?ecmc6rqIbxyNsy+r4Z05byZEU/AhchP3bbcOpeWOpp4svOBujawfHRRPVRmp?=
 =?us-ascii?Q?le5MrAhnihkize2bBWAZAP5Eiyim8C9GpDNx4sSxkznBPNK0MUozvHVHWWIV?=
 =?us-ascii?Q?xRHMZ40wEK1YZSovnKIrhJ6PpcDvtATeB1yTippeeJIFqZn6jt4ZcCGIys15?=
 =?us-ascii?Q?wrlDnIdwAiamN+ytWMFhPWAuy2JmsBD9PU+zcki82PEf5dVK151h6pIAziFq?=
 =?us-ascii?Q?mdyYYtDJlFzPt94QBJP+sIRWddKuJ+ObbIKlcm4IU2Q29VRr29t+2veUA9j7?=
 =?us-ascii?Q?wTkZweTH3HPwP7O/5gCtRC7b3k2gJQtpWO5QK3Cd5cSQ4HsblNBzUbkDEgS3?=
 =?us-ascii?Q?u/0DgijBgKCqLQTXFg8QQsNAJK3fGvLY0uXA+gQSLvMSZ2bHutJN4E/sD5ga?=
 =?us-ascii?Q?WRA7sga7wq/GKzY3T2tt6axejlVAz94FPf4D06onMq/CWIZrft4WG1MgI1Hb?=
 =?us-ascii?Q?IkrfU4GwA3rZq0k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 03:37:39.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46215292-df30-425b-e417-08dd52f241b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943

The clamping in freq_to_perf() is broken right now, as we first typecast
(read wraparound) the overflowing value into a u8 and then clamp it down.
So, use a u32 to store the >255 value in certain edge cases and then clamp
it down into a u8.

Also, use a "explicit typecast + clamp" instead of just a "clamp_t" as the
latter typecasts first and then clamps between the limits, which defeats
our purpose.

Fixes: 305621eb6a8b ("cpufreq/amd-pstate: Modularize perf<->freq conversion")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ab95ec1f828..4705a644db6d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -144,10 +144,10 @@ static struct quirk_entry quirk_amd_7k62 = {
 
 static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
 {
-	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
+	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
 					cpudata->nominal_freq);
 
-	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
+	return (u8)clamp(perf_val, cpudata->lowest_perf, cpudata->highest_perf);
 }
 
 static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
-- 
2.34.1


