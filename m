Return-Path: <linux-pm+bounces-40988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F6ED2F78D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 11:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EE0D300CEDA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A035BDDC;
	Fri, 16 Jan 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xs+sCej9"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C22701BB;
	Fri, 16 Jan 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558927; cv=fail; b=TltH2urGCQXdmGA3qb3KvdgY4UujLPIO12ExY51Q3gJHF1mRUbfQIItttnqFdj54aBj8SjfAdYDKY/zxR0xsfNCqZMBQzswNZb1e3eCZUX0G0k/G7IosR2WGrl6tRSWYQdr5FYJlDrh+YNEiEWBE5xdc8V3VV5spuKWrVodoGLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558927; c=relaxed/simple;
	bh=0R1g4/J4tS7xll2/Ghi06FFcDAecUWjEOjbJbwA0b/0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Ldd5LeDOz9dGfdvvRiyME2Oht4f+BVSdQLFJu4hVPEt1NxGzZvOGoJ/z27kaRcqVHYt7v9M1YA+1NlOmKLz5RQBJ4RGW94F1jJyks55FCgwBJWLXw53KxUuV9f11FpWs7twcqW8a37GbJOhEfEJOn8JjaPblggFIMn3YMEltzqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xs+sCej9; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BozG8RkRBo43xLCIP9uK3Mz59cnYF2Kq7HUDBHYq7ggFGO5RlIX7EtzNvtN704FBSQMydgrZYVLJBzmyzRYCsW5e3V2t+A2UizqcmEMR7EGuj8pQOcRhqh5SpQ+sD0fFVrN6BfMFWIyH2ci007F99KJ/4Z5mKxyXWxl01P/tBiqCjzRn3GTN2ZdLVPMvqTWuON9XrQIdMYOucCirHimeMrd1O0Z+gAS0SkC46FQ6GFtT5ZyHTFpNzJAMJMssSSa5kcZ3BPq2qjJklrONZ92bupZ0BbYe6SnYnLGBoRfXa27w1fjkelbzUw6bXDyxDqVIP0aaRa6M+a5ARVVmC0PJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Queg+BiQLQj3tkkfEUIAwYQIe+nobzBzmepkuiwlpg=;
 b=iYH80b+ejyiJBu0uhY88G+L/8mb6zk4btOgPOg6wNCW7l9V/m7QcYKQDZPVuvtirEDDUMYEYGCkRsAh/bEa0/HZM5u2WHu5B13poIG58w5w+EkxQCY2AtXUOmrb4FHxr6W1/dNVHR9oO81if/zqYhVhbGOoC24ktFga4e61A6vWH3YrchRDOMZAu2p4PrchOxUMzHQAgQGdQiNr62xKjTxvjIOj9aDqeYg47CEPz8H7cQ7ZQ0oT42aBNmtY2nhJbG6YkXijBgW3WBOqL9gZUr/hH+f7dIyxxwwcA8gJgvRW+09YapRUL1PxGLVGWNMWR2kKILH47MVzLLYns7KAPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Queg+BiQLQj3tkkfEUIAwYQIe+nobzBzmepkuiwlpg=;
 b=Xs+sCej9sYeGhJ0UQ0oKWWEvR9vW+d0sTodRU/TjqqHg3QDd23Obk7b+akeBJHV0duehR3LEV2E6EW3rxJF6wyxFRBfiNkDNcyRV+IW+pzZfv6SLDpdnUrGUkoSBadq7aI/e6/BQ3vzPkGlfrmmB06/cQNy1ItiMasDE0pfh4LY=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 10:22:02 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::bf) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Fri,
 16 Jan 2026 10:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:22:01 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:21:56 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:21:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:21:56 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GALnXV3128184;
	Fri, 16 Jan 2026 04:21:50 -0600
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v2 0/3] cpufreq: ti: Add support for AM62L3 SoC
Date: Fri, 16 Jan 2026 15:51:28 +0530
Message-ID: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgRamkC/3XMQQ6CMBCF4auQWVvTFjOAK+9hWDRlKpMIhRYbD
 endrexd/i953w6RAlOEa7VDoMSR/VxCnyqwo5kfJHgoDVpqlEqhMBPqp7DLywVaheraxsiLQYc
 tlM8SyPH78O596ZHj5sPn4JP6rf+kpIQUWA8Sda0aQ91t47P1E/Q55y+qUxP1pwAAAA==
X-Change-ID: 20260116-am62l-cpufreq-1987a04a6f68
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768558909; l=1457;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=0R1g4/J4tS7xll2/Ghi06FFcDAecUWjEOjbJbwA0b/0=;
 b=XQkpAglCzSu+6/YDAM+eSCizCAEk1KKPWcjeiAwMnBEkbKYvqy54uawuWAuQBIhixX6LT4UZM
 6axLfgI3uGxDQGl/qd7F9V0Q7d2lT5OPLtreJ4wcTGSf5Px+ufwUv+j
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA3PR10MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: deed02a0-e428-4b93-059c-08de54e91654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3BaTVA4TUowM04rcjdTN0l0K3IyMytTamkzZzY5TER1UzIwY20yN2tFYWlr?=
 =?utf-8?B?OWpvQnFIbC9TbFlNWEFXMnNaZVJoZmhEUkxZL0FHejVscnBlRGhzV0ZJVWI5?=
 =?utf-8?B?WGJXVUJ5WGtGb05oUEtNWUZpTDdKRDlreGJSYTk2QVMyRThqVlV1d3J3cFg5?=
 =?utf-8?B?MjdpMmN6QUpzZ3U4RkJCVzZ1WVIyWmtSZFNSRXg1M0Q1czF3SDRGdHB2ZklO?=
 =?utf-8?B?VTIzY0NrZ2x0L1Eyd2djam5JOXl3MVc1blNEY29FY1hULzJ2blc3Mk9MOE9S?=
 =?utf-8?B?Nm13aG82Nnd3b0FMVUd3b1c1RTBBaWtjS0pzOW1WL09jRW9OUzlyYmJYampu?=
 =?utf-8?B?Z0Y5cks2bEFYUkJLUnE1Ymxkek5MVWM1M3hkUFE2b2dFaWI4NEJFMnBHT21E?=
 =?utf-8?B?YTVuNnl1Z2xMVEkraWVVVUUxVXJqamRsd1hmVzdOQnpVMzlFVVU2M2xKTFZV?=
 =?utf-8?B?WnRhRVRGOUdaNEFTRUFjanFYN1cvOURFWUc5Y2l0dkQ0WFNEaEsvb1k3VXdO?=
 =?utf-8?B?amJBei9Da0JoaHhhQmFqRlVNenU3Wjh4UFVHcEYvQzE3K1NJd1h6NlViOUM5?=
 =?utf-8?B?Qk1PUzRkZDhQSmRTSVRxRVhxRnhpenVzSHRNNTNXOGt2K0hnMFd2eVA3Nldr?=
 =?utf-8?B?MGRjVjcxRGZPcThQa090NUJJOWFuYnhWREs2MFdqeVJFWjNJR0Y1VTZRb0E4?=
 =?utf-8?B?ZFJRSTdIeGtNVE9qUm8wVGF3YUR5aFFUbEZ2NXRTVVpONkVlbmQ4VHNPeEh5?=
 =?utf-8?B?YVVQaU5MYmpJWFVxMHI4RzhEZjhmMk5yVDFIWXBLbktGZ2JpSzNLVGR1TUpx?=
 =?utf-8?B?ZFk1aXQ0WVNkdXNheDU2clA4UzRPdHRWVEdqZ2hoeHA1dTdzbUNoWjNlVDFy?=
 =?utf-8?B?V2pKdWxBNkUrRzR6YUhCU0FDNC9EUmgxcDh6Z0hMSTBacHVuVDJKdHVHNzBp?=
 =?utf-8?B?L09LL2Z1eGtqTDhPcW5TbUJkWTFTVENvUTZqQjNBTGdhbE1ObEh0RkljMEJl?=
 =?utf-8?B?MlZ2UDlwY21kakFDNEJzbXhpaU1UUWU5R2xjdWtJdVkwZjJzMXN0UCtkYyta?=
 =?utf-8?B?Q090UFZ6WFQyblcvMk9LTHFPYUdhb2JKYUs2ZGt2OW5rVUFlSk56TUdsZXcw?=
 =?utf-8?B?QkpUbnEzb09vZFUrM2ZEWCtIb3ZtUUE1YXBEQU1STmU0WVlnb1lTbkkyKzNn?=
 =?utf-8?B?UXZ5Y2c5RnZObnZGbVBDTnRzZ3ZocVAvZkVLRTZVcW1jQXZJbUpCZ2liNElT?=
 =?utf-8?B?L2dDaEhEUitZZzlPTUowbGthM1Yrcm02YUU5Lzd5SHRqR0w2VFFQeG9GTlZa?=
 =?utf-8?B?UkkxMnBxNW1qNFIyMHNiaDdJWDFsNXh6b2c0RGtKRVJ2dW9lU0R1NzNJazAv?=
 =?utf-8?B?TUVUQXNmUW5iU05UbGxsVlh6WEZ3UVNVdFFGWGE1ZVdhVUQyN0VMU0VGWlh3?=
 =?utf-8?B?VXpXbkJpZHVGZG41N3VqaHBZZW03YmRXOFNza0hQWUY0R3RWQkhoQjU4L1Br?=
 =?utf-8?B?eWY2cXBtS1pqZHJmMjBUR1dyUVZ5VmYxQ3AzbU1xak1NRmFCRGpNdVhocS9s?=
 =?utf-8?B?R1B3RnFnRHhNa3Y4eS9ZMldSNEdMWFQ1UVkxZDYvd3NZQ3FVMndKeDNRd1J4?=
 =?utf-8?B?azhLcm42Yzh4eExrcWxUdmpmR2NQUE1ycmFtcEtrRkhzWnR6dVAyWkRGUElo?=
 =?utf-8?B?RHprSk9nOC82bkZuUkN2aDZyakZCanI0K0dkVHhwWjc3c00xbnVab1BFSkN5?=
 =?utf-8?B?QS9Nb1hJM1ZIZzBOcDhlci82Y0FucEFlc3VJTklXRllzNkFENmlXdjR5dEFG?=
 =?utf-8?B?Q3p0eTUza1cvRzY2N0pIbUdUNjZVdSs2ZlRtUmV5NlRHb2tZbW81dmxxQnJp?=
 =?utf-8?B?bEZqWHhBcU81UFNqdEgzZWRRNGZXenVwSzI4b3Z6eENVeGhEYTY0djRwMktl?=
 =?utf-8?B?R1JuVEthUVR1YjhoTlQ4VWZWbmVHT0lEMkhNTkhFOXF0R0VTRTVxZSt5OWtj?=
 =?utf-8?B?NWduRWlPVENVZnBTMDZrR3RSS2pkYTVMdHpkYysyUVBuaE9Pak5HN1htTVZr?=
 =?utf-8?B?MEVjVmdTYW1NcTdDS1hlb1kweXZ0cWpvRFBEeW5JWnRncHVmS3lnb3BtcXkx?=
 =?utf-8?B?K0NXMllDUFJ5cFNDV2lDcFFLdDdFRXNjdmplcVFUbWNKcGFhVHlKRUZUTVM4?=
 =?utf-8?B?WWZTWU1rSTBhWTFMVVNOaWtYcTFoZUYzUVhPcHN3dlJhRGtlQVZrZ21lR3hI?=
 =?utf-8?Q?IksE/0aCiF6Kch+NuhlNbHuZ9H69jnI+xyiY8kK8x0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:22:01.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deed02a0-e428-4b93-059c-08de54e91654
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420

Hello,

This series adds CPU frequency scaling support for the TI AM62L3 SoC.

The AM62L3 is a low-power, low-cost SoC from Texas Instruments. This
series enables cpufreq support by:
1. Adding the SoC to the cpufreq-dt-platdev blocklist to prevent the generic driver from probing.
2. Extending the ti-cpufreq driver to support AM62L3 speed grading by reading the efuse.
3. Updating the device tree with the necessary operating points and clock configurations.

Tested on AM62L3 EVM [1]

[1] https://gist.github.com/DhruvaG2000/6dcceb80cf7bbd1e624ec210532538cb

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
Changes in v2:
- Sort alphabetically while adding AM62L as per Krzysztof's comments
- Link to v1: https://lore.kernel.org/r/20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com

---
Dhruva Gole (3):
      cpufreq: dt-platdev: Add ti,am62l3 to blocklist
      cpufreq: ti-cpufreq: add support for AM62L3 SoC
      arm64: dts: ti: k3-am62l: support cpufreq

 arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 drivers/cpufreq/ti-cpufreq.c                | 34 ++++++++++++++++++++-
 4 files changed, 86 insertions(+), 1 deletion(-)
---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260116-am62l-cpufreq-1987a04a6f68

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


