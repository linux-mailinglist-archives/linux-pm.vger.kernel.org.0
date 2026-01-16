Return-Path: <linux-pm+bounces-40977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EFD2E7D9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85B530F84A3
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96E319608;
	Fri, 16 Jan 2026 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UNCZp94c"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543A318142;
	Fri, 16 Jan 2026 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554131; cv=fail; b=cvf4tEuqdfhdsdwZiZ4UlfEe9EiI3XjCAOATkfaKauAvcRjg6dOtEfqkpNy9C2Qn5c3EoSHEPcTqr/SbBvJssZQj9AgOHr2Ay05Geo3ekGlRmxVbGMCPKpRjQpa9voeGmrVxysM4/n7ZcHJQDk7O41vdmRV65Qs70REt78t2hIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554131; c=relaxed/simple;
	bh=z2M0We1QuRJn2unXQpzgE2daNzDDB1ZrTBJBdjpT/So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SHzFCxptRi+SYnAZUuT1xRXJOeNJDI6hsnlBUG8fCpG3E2JFJl/TZqQ3HFdPtlj7UUHWE1CMhqAqkS5dyhD4GHDoQ1m33BaZvOolT5QmYHlBp6S5dpqTUmSb/PGAq19NaTa2QCVJo6DwvwpfyiPtbSaSKx8eQNRf5BL9+7n1Pug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UNCZp94c; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImlSNnWGsArjMPaggq6w5qasdUIbXJHliTG+OLHaYstP1hTnc63pK6X2p7SbNZfwqkSqaFsyvvSQ6LQ7c/BDFw5+st/bNmWF/lgszh9De+Dg6Lzve7JN25RCxm6tzeYYHwYCEjlOUwYSDXY8ER2FX5UKtHsQIqQsNK59a/hRFDU+QI2SA8wDk6RVCtD5wyr4cARFNFT4jFjpzs9apaVYuBWXOHDJyoR9FMXfKMGKOfxguswbH25icLYLq0TrjisTLO3++i0ejIr9qeSwP5FaKgVRSDJp/LaPbOZ+3u8AEm2lX1evgeq3XfXVkQ0hQH6QjVL7yXzGDtQx36WD59HHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eikradmCaZ9as0Q3XUD8DEaV9yfIz+7j7Pz5Sf6CNY=;
 b=g0ldQOCzUEzpfsOBFXVzFtR4/6f0YtYYFkW8nGof7yS2MWY3alCwcOUgnv9h3f9ibDi2MDphz6k34SCsXq7+Y1fAWJ1vfW2rpS35MdiwFeV/WbN5SY1xh23lLQszLEqzYNBVpgya61+rNQ95x5pg1SmKuDvq2ozo9PYigmlhK1tDpPeyiosUgvHmNsrdi9mG0rEKgMTFsITr0/b2rPHerlDlMBLzx6xJvHwQqC4ASJlrI0Jy3hmKBrjZuofUsa80GjAuo7cHAnUbNy0nIh3jGKe6DIC9XQHvjglNGQPVBT5TLpITzBtphEyUCGSdVtZlBqQwxgPnqK16MjCDg5K8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eikradmCaZ9as0Q3XUD8DEaV9yfIz+7j7Pz5Sf6CNY=;
 b=UNCZp94c1wICfoMdTnUDklZE0CqUf5tflsJ6h1LxKT2Eh0kwuYx1nwh4eLiTtW+ruTblgcCxQCcpkUFciDqleu4nmIonhDXeB3SVtxKG5JmE53Pc8tKXMvUVecrA8j5yD0HyO1fV7SSg+MH1D6zySNff5ASQerEvQWWOqjxDniA=
Received: from DS7PR03CA0332.namprd03.prod.outlook.com (2603:10b6:8:55::19) by
 CH3PR10MB7330.namprd10.prod.outlook.com (2603:10b6:610:12f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Fri, 16 Jan 2026 09:02:05 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::a5) by DS7PR03CA0332.outlook.office365.com
 (2603:10b6:8:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 09:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:02:04 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:02:04 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:02:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 03:02:04 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G91iBU3029793;
	Fri, 16 Jan 2026 03:01:59 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Fri, 16 Jan 2026 14:31:08 +0530
Subject: [PATCH 3/3] arm64: dts: ti: k3-am62l: support cpufreq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-am62l-cpufreq-v1-3-63d062317ae9@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768554104; l=3167;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=z2M0We1QuRJn2unXQpzgE2daNzDDB1ZrTBJBdjpT/So=;
 b=uS26icG25R8XCmGzRmpPuXG+Cb+miudPFwXr1Cn/A+VQxh/SgZfRODB+tepLqZrwbOQzffLJQ
 YlxQvYgcBILAYlPQzKJx8j2AEHzS/7jXNcGcmTI42CHd8Nu+RWwsJ7s
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH3PR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: d36d905e-dcca-484c-74d6-08de54ddeb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUFjbjUxTGJhUXZ3dEh2ZEhMQmo0Nm5qMWxVUzZGQjBiTklrZ1loYzFobGl6?=
 =?utf-8?B?NkhSeEVtRkVFZ1poQUh1b0tyYWhDRWltbWIydE9FaG01SEFneTl0d2hYOGtK?=
 =?utf-8?B?ZDhxNndTRXhaQVBja2pZZVl1STJGcURjRmpkelZDb2lEK3F0aFJRQXI1Zitk?=
 =?utf-8?B?YXJFbnVvSFFHT2laZmIxdWNtYm9nTUM3UU00cDBCL1A1UzdSa2tBZEVyQVcv?=
 =?utf-8?B?ODFxdENPemU0Nzd5YytOckd5Z1VkYm9BUFc2eEV5cE5OMnk2T0w4WjZ2eldz?=
 =?utf-8?B?N2h5OHNnUVBwdjk2c3F6UEdjUTlreE1oSnZKU0NqQmxkbGwrMkpQT2hlY1Ns?=
 =?utf-8?B?WUlxM245V2pld2xuUWZFVVhpdmZkVGRlK2RSTU5PK3JYWlkycTFLMXUrNWpN?=
 =?utf-8?B?Vnc1aHFFaW91Vk11UXJGUXlRNHBTdTdRZ2cwbXpHT1IxYVJkWU5RYmI5RVRF?=
 =?utf-8?B?QzlOS2d4bTdtWm1FRWJkU3VvUi9zdG9Xc1RnOGZ5UEpPUzdmSzlCSmdhc3Na?=
 =?utf-8?B?aFIyVHRTaDRaQks1Qi9ObWUreVA2Qi9rSGZ4NGpwSVNJSUxaMk9tWEZIYXM0?=
 =?utf-8?B?d0FWL1BVWm1tdFJzUGdYYUdpRmRFdkRVZmNwaXBKSmVyY09TT01sQmFWZ0lq?=
 =?utf-8?B?MzdzZHI1NjZEODE0YlNuaktwWnN6alNGVXNYbFNZMmMzSmE3amd2R2FPMWlw?=
 =?utf-8?B?Wlg4VlljcXptQWwyVVRHR2ZGcmtja01acWZtZnJEa0tFZy9SZTIvRkhpalVC?=
 =?utf-8?B?ckRNU1RvYjVRNE9yU1NkaS91VlV5S0JjTjdvemxZM0RzQWVRYmlGK0EycHNS?=
 =?utf-8?B?VGRaYnRrRmVjVkx2cUFTR3M1TDZZUysxKy95aFZLeVhOSWdHbFkvc3B3RWFD?=
 =?utf-8?B?UHNtSExVMk9DdTVyeDZvWXR4YWMvdk1rbFlRTk54WUhEK1RpcHJveWNNL2Rp?=
 =?utf-8?B?WmdORFlYTjh0YThTck1wM2RIdFdmb05OWUJCUlBUbFFuaXZkWisyU2wrWCti?=
 =?utf-8?B?SDZISGdzZnkzc1B5Z2NqTTVVVFNzMHZQeFFkcG5qNGtpRUN2MWpaNGNITGFF?=
 =?utf-8?B?K3RlczFNQXlEZjRwUFhFV3RoWGNQdjRNRnNHS0FIOXJNa1c0RWFJM29CblhJ?=
 =?utf-8?B?eFRPRnhRZjBrekxBNGpSWUFSczVRWGFzTDVVcDY5SWJvUzRQdVAySm8wTm5k?=
 =?utf-8?B?K2JvaTNVUHNKQnhJWkRoWkh5OEpKeDBaV1U4Yi9TVld0clg5U05yak03Zjlx?=
 =?utf-8?B?ZS9nMFhRQ3I3NHlSRzlBRjRUS0hNQWorRGxxQlJBb0lKNmRWL0FBMzVHd2l1?=
 =?utf-8?B?dzh5dERReTc5TUg2aHNYZWdLWU1SVVlnZVZoZEpZblZOZ01YUUw4MWRzb0cz?=
 =?utf-8?B?R1ozV2pJNkVpQkhCc3VoeXBSeVlnM21PcjdkZmx4cmp4Tnp6MFo2UVVSL2Jh?=
 =?utf-8?B?dkpUWnovc0FVak9LMnBNL2laZ3I5cWlCQ1ZBMUdEQTdpVTF5UGVjVFIrRUFx?=
 =?utf-8?B?TGhDYUFGT2VsdzVBVlNpbjd1d041OUdUN09QbGlBdFBVbWpTQk5WSmN1SVRW?=
 =?utf-8?B?ZlJFNUZmUzg3eDUreWliaEhmTkVFS2ZRVzlHQUx5bzh5S0VxeXlaWXNMeElI?=
 =?utf-8?B?L3R0U0U5Um4rUEFaZGxZd2lhVWx2ZHUxSkpXRUZaSWVsNWl0UW5icXIxSkpV?=
 =?utf-8?B?U2xjbVVIYy9IVUF6UGZTUktRbmg3b1dmUTlGbEthaG1uZ25icFVmd21sa0lB?=
 =?utf-8?B?SDRIdTgySDR5cFR2alZVRmFqVFAwaFZFMzh6R0g0clZ3aXFPQ3B4M2JlVnRO?=
 =?utf-8?B?OHpkWFZIeGRDWjVEdjdtbUhJU2RLVmt0T2dxN3ljcVNaL0tlWUlZckZVMDZ6?=
 =?utf-8?B?dDZTTjlIc1EwYmU2dTFCcnRjV2lFM0tQMi9VQ24zYkJ1ZzBCTS9aY0F2MVI5?=
 =?utf-8?B?cFpyNWY5bGdmM3EyZ3FROE16bnloZFlFTE9nT1N2c1hQN2RCWXlWZFdRdmcv?=
 =?utf-8?B?Y0o3OCtjcUNvMWE0MENlaWxIQzVsdGpDRzJjTjhEYk92L25ydlZYMXhYUXNw?=
 =?utf-8?B?a0l3U2FQZHVQTkpFK2NGSVdxelBHWVcrc2pRNm1EQmUxTEVnTE81M0VtUHFQ?=
 =?utf-8?B?OXJOcHhNeC9Mc0hXQ0FEa3d3cW1tWFdKQ3dqUmozVDVGV0RVV0t1NThzNS9X?=
 =?utf-8?B?VGZuT2dOT0k5cStYMHdFZGVLejFSVnZhUjBnQzQ4cjAvSUtFVmZtU0RUQ25L?=
 =?utf-8?B?QXhSZk9VQ3RwTlo5TDlia1Y2NytRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:02:04.8901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36d905e-dcca-484c-74d6-08de54ddeb92
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7330

Enable CPUFreq support for AM62L SoC by adding the relevant OPP efuse table
syscon to k3-am62l-wakeup.dtsi for speed grade detection.

Add the operating-points-v2 table with CPU frequency steps from 200MHz to
1.25GHz to k3-am62l3.dtsi

Configure CPU clocks to reference the SCMI clock controller for frequency
scaling

This enables proper CPU frequency scaling capabilities for the AM62L SoC
using the ARM SCMI protocol to interact with the power management firmware.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
index 61bfcdcfc66ea8d802a36ed43cd01fbbf3decc70..a42ccd0d2fcc4d204cae81508f839c44ce83f558 100644
--- a/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi
@@ -127,6 +127,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@2000 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x2000 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
index da220b85151227c63f59b2b8ec48ae2ebb37e7bf..f7146421918f7037c6a192cc4765e8814a508afc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62l3.dtsi
@@ -39,6 +39,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&scmi_clk 356>;
 		};
 
 		cpu1: cpu@1 {
@@ -53,6 +55,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&scmi_clk 356>;
 		};
 	};
 
@@ -64,4 +68,47 @@ l2_0: l2-cache0 {
 		cache-line-size = <64>;
 		cache-sets = <256>;
 	};
+
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&opp_efuse_table>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0006>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0003>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
+		};
+	};
 };

-- 
2.34.1


