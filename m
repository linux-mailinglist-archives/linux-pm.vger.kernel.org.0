Return-Path: <linux-pm+bounces-40976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00293D2E6BF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B4630519DF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B573176FD;
	Fri, 16 Jan 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kmxlGStu"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B13126CA;
	Fri, 16 Jan 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554124; cv=fail; b=aoXJbcFwsoBJd8hc6uTbofFLAf8X3zhzLAon8WTg7Z6iol8KhjNcRu1hz0YpZdFlcyX/JgwvM1+dThibDSUKHx3eCNMzfSEEL736+dFxOqBm7pLD48t3Gx6AMx9t2RsVY2l2mwU8pxFZBQY/Zq0T9jBEJXEl0uzQmaLMTjznm/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554124; c=relaxed/simple;
	bh=q7saPXmVUtTjVLo1ZE59Q/lU5BafaPK95JrHgRGfai8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dH74nkQH9fEdAXI3eB6mKyy4CzDi2HiOWwyCJpFTyg/dd6TrngXimFMbq7QMnddmY+LmAH2FREArc7OUfER5RcNl9agtp37dNcAuMBgE4vZbRJGbRxsSVBQPQ/1g3p+Cfmx7+e6i8NtuMTYCAcpxj56BM3yav1qh6ZEczTfBg1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kmxlGStu; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/icch3F4k8XeofJoKD7WnQ60pIG7IlUBUFJmYXDF1ect8QxJfl56isAcQ9zGGSbDInUe9252qjS8s8gBCnloxPLmTdfKWNqzl0gfn97Hz+VfVz4KrZ6/cvFkLhBU6oMP6dl6HHf/RsDoMrQuPMPGmUhCT4V6C2vTjVhHnN4HbbtEXn/qYtqIhiMCpCwyLn7vy3ve+I7lbcdUJyPH/RfKMxJvXH8W+JQb5jE7D+WhaSDvuOmmuKQDIrZKCx0S+PK4S93JO+HgYGAckaCqbQvgySwAcM6XpYKUX+CDLCYbeO3+IQ+GVrCbsaA7OCQ6JTsFHBtMuLzWT0AfHYPjtR2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIuXXl60FN0W/I8NPzEfRIcTt99ayR7fMvGWusX/N0I=;
 b=JOJX3gpq0lXiJ8wYM4nq8C7Cnqj0qg+vQESSlgwfm89tjnDplabYFBRiIvq6Eu4+nkh/TGWevuuvmffbGD6v2znNmDB+M5rRvFEMvfGIgSa2r9A4GOlDilPWBNEoZ4lZgfKSeibhij1zV3oRh8Y1hlvXUyrmjNw2mwhnJ4Td3NCA847FQBC+NY4ynn/mKop/PjGdSxx1SFnFCYWalkI0zbXQMXMJdOEyE1rN7HTO2Xtf0k6cswASI+z+FgYyzqOW6T+kMGIr2gWzTR62PFxPxa90KCu6NsDaRDWTHfPUgU6bIlmqOeNc5w/MYxRx5QOAREAgXShrD/dgUpxYJ7+A0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIuXXl60FN0W/I8NPzEfRIcTt99ayR7fMvGWusX/N0I=;
 b=kmxlGStupS3gh5pttZgMchAWlBeVlXlQqEn+WQI3lKgQZ/LpI/w6NkLYorduLoD01DnE8I9XFxQXFJ0NLJHlkdnRSYQTsaWtZ+m2x8gfWBXoOWl/OY9ONG43aEIv2PjBeVklZiLAz9TGtf88a0IazJYVDzHvYhGkQaP3dRKcpeI=
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by DM3PPF311374B40.namprd10.prod.outlook.com (2603:10b6:f:fc00::c17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 09:02:01 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::e9) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Fri,
 16 Jan 2026 09:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:02:00 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:01:59 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:01:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 03:01:59 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G91iBT3029793;
	Fri, 16 Jan 2026 03:01:54 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Fri, 16 Jan 2026 14:31:07 +0530
Subject: [PATCH 2/3] cpufreq: ti-cpufreq: add support for AM62L3 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-am62l-cpufreq-v1-2-63d062317ae9@ti.com>
References: <20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com>
In-Reply-To: <20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>,
	Bryan Brattlof <bb@ti.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768554104; l=2880;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=q7saPXmVUtTjVLo1ZE59Q/lU5BafaPK95JrHgRGfai8=;
 b=RIezcHA7ub9KXDomDRT9kVjI28SxA/KH5GL/QLV7EpCtVm/WB+DuA0dA3ZYCxbQOgc/mVu7gZ
 JcPjAjND2rFDoEp2Mi7dtlY1DBM5FOoIW8F8EekOJSnXnan9P+cen5G
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM3PPF311374B40:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e11343b-e54b-4ac3-3856-08de54dde93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FlYS9IWHBVOGQrOWtkKzhYZEd4VmhaWnpYWTI3ZG1OaFZpdmtvRmErei8y?=
 =?utf-8?B?KzI0WUY5MzRCN1U5dUlOaHdyejl6YzBPMk1nWTM0R1N1aThmZmg1NEpLUE5U?=
 =?utf-8?B?SllLK3cybHB6MTJOYTJZbEQ4QzVQWmJJc0NzNngraGFkOFVsU1k5NjdqbG9V?=
 =?utf-8?B?anVWa25kNHB0RkNhUVBhU3lnZ1ZPWHNZWmphd0tvUDkydXo3MTNKbmh6UWt1?=
 =?utf-8?B?SkVrSklsVC9ybGI0dUNETGwwWkpaaW9tdUhyUk9uNEc4ai95c2d2ZUtLZURF?=
 =?utf-8?B?cHlGYmNQSHpqRXg2L0dJM1haamNJQVIrUmExMUJMT05Odk9YOEloVHhFYzF6?=
 =?utf-8?B?bTBGeTVjY2NZVG1yUzI3SWgyMnlNd0F2ZWJESncvM3JrTm50YXczVHkwMVQ4?=
 =?utf-8?B?VFpqMUo5c1lwU3AvQ093M2xzMXh2S3o0ZmNzS2hRREpSN0cydkx6TmYrWWJu?=
 =?utf-8?B?aGs1MlQ4em1YL2lWK2E0Rm96cXpZZGRGT2tSQk5GM1VlV28xZHgvT2hDM1Zq?=
 =?utf-8?B?aURXTWlJUmQrelBoUGVqUkwwcVFndHhQUThPWm5NODhSdWwwYW5Ibm9kY2tx?=
 =?utf-8?B?WFhiemcvZE5tbkFoTnlHT01TRXByWnlEZkM0UklJOFVJNUlMZHNUV3RtYkFB?=
 =?utf-8?B?bFBCVmtyWHhyM1Z2azlzdy80R05iM0ZPb084UldmK1JmYnhEMkFuTU9Scmc0?=
 =?utf-8?B?L1FRWm0yZnlRRGNGQittVDluQjhVdXlEU0M3T1BQSXFob0xTUTBPVU9EZjJE?=
 =?utf-8?B?dkNIMDZhQ09IUjJCbE1CanlRaHVzMlFSbnEyMnZqMEFPazNQc1dwcjVYRkRu?=
 =?utf-8?B?WjJBdDFKZWpIa0tMbFdSanA4RVZGQWtVK1pDZ3BGL2RQZGM1TmJnMFBwU3Bi?=
 =?utf-8?B?Q3J0cmkxS0p2eGhkSFN5NXphMlgyOTRyWktDWUozYTlYRWxZK2pSalNLc3Fx?=
 =?utf-8?B?aXJyZlNpMU95Y1BCQnBQUEw4N0Z0ZkxsSTE1bWVvK3pQb2l4VWlPbFhtWXl6?=
 =?utf-8?B?Yll6WURJQXg2QXo3RnNneStpVUF2VGFFakozSmw1RDlTdEg2ZjRYcDE3bk9D?=
 =?utf-8?B?ZVVOMGx2SGR5SHZRa1ljb3JEOCtNbEc1SzFTamdPaC9QaXpOcm1tUWUway9H?=
 =?utf-8?B?S016bXhtbStucDNwR0UvRGVtVW84YjNPQSs3UEk4TlREc0Z1UlpRNVhXRVBT?=
 =?utf-8?B?eXJBc0dFYkEyVy94RXE4djIyNnBCRHAxMXdHL3l6R2t2TXlEQkVpK2pVSXZB?=
 =?utf-8?B?RHpSSnJxbmxKcXpld1ByaUJZNmpyN2k2d08rMEpzeXFqTVYwTzhZSHlnQXVh?=
 =?utf-8?B?MzRRaVVRWTBxUUp2WC91Q2RLTzRSSTVyeWNITCtXNlhYaXI4VTBQSWp4TkpL?=
 =?utf-8?B?aU54Tm9XRi92N2hmWVNTVzhPNzJGLzF4b0pPRjdhUzJNQ0dkeGRFMS9zT2Vn?=
 =?utf-8?B?bnE2a2s5ZVA0QmtZdlR4ZnRSa0Z3b0RCSmZUZFFBemROS0JOQnlvaks0TGZn?=
 =?utf-8?B?QXRxL21KTU5EM1BiQk1VWWppYVV0QkR0TGFmZC93K2lZdjNLY0JGUUp3b1dL?=
 =?utf-8?B?alNtUFl3dmxkVHo5eEpONGo0Ukt1MnQzdlFteXZUUkoxRHBva0dydzRLU2cr?=
 =?utf-8?B?MXMzVjJLbEZwNS9XdTl4TmpjejY1Wm55M0dwb2JSd3BvSGdWTFRVN09FeElH?=
 =?utf-8?B?S1c2cW9EUkVZZk5KUXUzRHdmODkzUEpoTUJ3U0k4eGR2ckxKamxkaFlsZWFL?=
 =?utf-8?B?YTAvL0t6ZXlTNnJUWnpNNWpYSFI5OTRGQ3JNSlozTmNTUGp5dS95RnBiejlI?=
 =?utf-8?B?bjRxdk9vd1JjZHJkeE83TVI3UmRabXZDOU55QVdjdHU3SVBFbUt5Ti9RUm5Q?=
 =?utf-8?B?STVZMi8wS1RjekJiYmRKZ2dkdGZjRUNmcjRRSUliNjVrRW52cmJUV0ZSTUw5?=
 =?utf-8?B?bkpKVDJiTWNzTUlsZzdMbHgyTVVjMjFmVHBUeTF6QTlpbUVpTmQ0SHc3QlVt?=
 =?utf-8?B?eXdzVEFITVZMQVpoUmI3U0paNGJZZTFKNU5iK0ZmRzBFSytWc1M1TEpENkNo?=
 =?utf-8?B?TmZiMDB3KzNuRGRadVI3MFVzcUFLMDA4K2xBNFRpa1U1dGIrdmRGeDh2c3J2?=
 =?utf-8?B?eGpQRnU3ZTVKSUtqa1NiMkVIbWl4Y0g0MEFMcGxLdEZaUzFzQ1ZzMUFnU3NK?=
 =?utf-8?B?RytZbHZxdXUwV21kYWhNTTZMVnBrZUJnT2lhVkNITllSYTFtaHBpSHV1NnhF?=
 =?utf-8?B?bUxoMHZlZk1aZGZZNnpvaFVpeWtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:02:00.9868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e11343b-e54b-4ac3-3856-08de54dde93e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF311374B40

Add CPUFreq support for the AM62L3 SoC with the appropriate
AM62L3 speed grade constants according to the datasheet [1].

This follows the same architecture-specific implementation pattern
as other TI SoCs in the AM6x family.

[1] https://www.ti.com/lit/pdf/SPRSPA1

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 6ee76f5fe9c567b0b88797ddb51764a2a5606b16..8d8fdb068dcdc2caa0b656405f38a072c0700f71 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -48,6 +48,12 @@
 #define AM625_SUPPORT_S_MPU_OPP			BIT(1)
 #define AM625_SUPPORT_T_MPU_OPP			BIT(2)
 
+#define AM62L3_EFUSE_E_MPU_OPP			5
+#define AM62L3_EFUSE_O_MPU_OPP			15
+
+#define AM62L3_SUPPORT_E_MPU_OPP		BIT(0)
+#define AM62L3_SUPPORT_O_MPU_OPP		BIT(1)
+
 enum {
 	AM62A7_EFUSE_M_MPU_OPP =		13,
 	AM62A7_EFUSE_N_MPU_OPP,
@@ -213,6 +219,22 @@ static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return calculated_efuse;
 }
 
+static unsigned long am62l3_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				       unsigned long efuse)
+{
+	unsigned long calculated_efuse = AM62L3_SUPPORT_E_MPU_OPP;
+
+	switch (efuse) {
+	case AM62L3_EFUSE_O_MPU_OPP:
+		calculated_efuse |= AM62L3_SUPPORT_O_MPU_OPP;
+		fallthrough;
+	case AM62L3_EFUSE_E_MPU_OPP:
+		calculated_efuse |= AM62L3_SUPPORT_E_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
 static struct ti_cpufreq_soc_data am3x_soc_data = {
 	.efuse_xlate = amx3_efuse_xlate,
 	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
@@ -315,6 +337,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
 	{ .family = "AM62AX", },
 	{ .family = "AM62PX", },
 	{ .family = "AM62DX", },
+	{ .family = "AM62LX", },
 	{ /* sentinel */ }
 };
 
@@ -327,6 +350,14 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
 };
 
+static struct ti_cpufreq_soc_data am62l3_soc_data = {
+	.efuse_xlate = am62l3_efuse_xlate,
+	.efuse_offset = 0x0,
+	.efuse_mask = 0x07c0,
+	.efuse_shift = 0x6,
+	.multi_regulator = false,
+};
+
 static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.efuse_xlate = am62a7_efuse_xlate,
 	.efuse_offset = 0x0,
@@ -463,6 +494,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
 	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
+	{ .compatible = "ti,am62l3", .data = &am62l3_soc_data, },
 	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },

-- 
2.34.1


