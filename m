Return-Path: <linux-pm+bounces-40975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95755D2E7BA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3530730C825C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97178315D28;
	Fri, 16 Jan 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="djkiWIyq"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F029B79B;
	Fri, 16 Jan 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554115; cv=fail; b=BrDjMn1Gt9x2z4/zHi/5StA+RCG9YReY3G8aIi80XOikzjx2nzdD03beIns5EPSuwfCglmvxE/fZq2Rc6w9zbp2VatkUYjwNPoAnfTaN+BTfnGL3hZUQO5kuI45XthTs2j0Z1XsHeHXnyG7OBN+oK4Z0M/3EHTN0DRHd/2Xra+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554115; c=relaxed/simple;
	bh=ESIa03Uz3TkAXivT8pe7A1X49ed11+CcO8WM4fmeWws=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PPlwKZVBTn/LLIq7uy+Wrg3+1fbx3B9Az/DQ+1GYGI3nwkSi5mtARu+FhWpcdJLUXhhXXKJYEc94RBPWbWaVnYnjxrPGel4kRJ8A5z0NzwTzClsjmndE3Qofbq3n+/mvDtitd9SJAQbkE/Hsqeat7389oHvY5y/SHVBJ/1hB7jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=djkiWIyq; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oppUCHzDwVrnfJVXoKzP/NzGQyjqMoktUzykeN1Cb0I5ppT48SeXnoXZvTSMcpdGdbjI8G50GgOpUnyfJIBhV8VjFyp3gdCHVukYT0I/bz3aDejKHtceGJ6nR2Nm4LPp4PWxp5Ot30EZpDFLvnkbNytNw0Wwf/LVe2iehK0mrpUAxFqLxGaQJ34aouXYUAXHtDXQidOagkbVh7BY1uHZG3ixZjrUJfZ4ebLLO+Tl3PNCvenhJfIgZDOfDzw2gKWFmiNli+5mDQobTZxY4W4Twm4M9IdgfvxJV2rWBJLj7HwLHCaAAV9dzctolk4ibr46EtWvGdQ1rzZm6odCz5DQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsLvk/uvlzhTROwB0KIRWNRS6jWKzjjZx4kYBw5lWyQ=;
 b=Yyx1OWtOWKZOrD+BCUpJd7nFOPJ9x6laW0dLZtpn2TTX6/3i1n6bVsrD2MCxEYVkq9EmooUnaVXUTEWoISgzt3dyHuZhr1xMdlNyA7LyNsMmk0Lxk9kLj23l4TBqEVAh1nZ/kQUTKVyGVt3wsb53Bhz5JXORsSpSH/w3FbhGmz4+h48kbSIUfHdGJL+kgTTxMKOLHh80mRZZ1c2v4kkX5hqdUIXBQRAFtjPxMhs2n86nI0W6fgQd+NdfJ9I+e8sQ9XfZfCFLeaRLWxdAYIWlO6e2+HH131h/NJAP5DgR3Ut9LMzG05pKpfgVMHIHQvWN+XtlQ+PK/AN/ykbJNbuPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsLvk/uvlzhTROwB0KIRWNRS6jWKzjjZx4kYBw5lWyQ=;
 b=djkiWIyqM3t4pYJeB5F4VghKm22pHVDyY1Ghg3KrtopIoGp0Qp8XJd58ICs6SdUtiGdgYSvX3Bovv6hS2993IxG+qiVLUlvcqZmrAWzpG4OLxYGL0/zsr9c6iTMuBF//WtaSiFEJLiJL2HOq49YSDJiaVQgSi/o0+LW/X0ktU/Y=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by IA1PR10MB7514.namprd10.prod.outlook.com (2603:10b6:208:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 09:01:50 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::c1) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Fri,
 16 Jan 2026 09:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:01:50 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:01:49 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:01:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 03:01:49 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G91iBR3029793;
	Fri, 16 Jan 2026 03:01:45 -0600
From: Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 0/3] cpufreq: ti: Add support for AM62L3 SoC
Date: Fri, 16 Jan 2026 14:31:05 +0530
Message-ID: <20260116-am62l-cpufreq-v1-0-63d062317ae9@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFL+aWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Mz3cRcM6Mc3eSC0rSi1EJdQ0sL80QDk0SzNDMLJaCegqLUtMwKsHn
 RsbW1APh9bvVfAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768554104; l=1259;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=ESIa03Uz3TkAXivT8pe7A1X49ed11+CcO8WM4fmeWws=;
 b=Jkj1u+NLifRAjAmwEeVZ5I//UJiGaiOU9oWSMt0n3pdbq+QJboUBrlT4M1sSYUVsPcrdQryr6
 RzldAK5iIxzBomf9psTjzG3zVA8EvqgDpu1kNg0XXeknMTbcxwDeNfi
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA1PR10MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 633dec68-165a-4947-1a0f-08de54dde2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGR1Ums2bitWM2FQMkNRc3pGaVdEb251OXo3anpNTXc5cmlJcEUvVk04cFc1?=
 =?utf-8?B?UXhuTlE2bVc2MDZGdnl5YmdNeHVjbE9mdjJSZDduUXE0elZZVjhsNDNBMzcw?=
 =?utf-8?B?WWNLVEZ6Z2l3aG5nWmtUOHM3Y3JFcHNNZ25zNHg4d3hqZi9IeWFpTm04Rjds?=
 =?utf-8?B?ZmRtRjVFQkJMSk94aUg0MGROdVJObmFlZks0VlB0MTNBU0YwNzZrYWdWZzJy?=
 =?utf-8?B?RzZmcnV0ZG1ONjZjZXM3VHhENUJSdVJSZUJndU1DK1dzZE9VV1p3N1NlWFdw?=
 =?utf-8?B?UXBaaTZ4KzVEREorb3lWK2kzM2tHNUl6d2UxNU5PejJBQzhlUmk1NVlLSkNR?=
 =?utf-8?B?c1BVR3hHTWZxZjFpV1hQeUptZCtDMWxoS3VETVQxZGl2VitpNUtmd3Zrbk02?=
 =?utf-8?B?S0IxTW9IMjZDcDc1N0IzZVlxaXMxK29KdmVaMW5JZkRhZTU1OTNjdGpCZXhm?=
 =?utf-8?B?UDdMM0Z4TWVYa1ZrTytpQlNFaUtabGVMUXBPK0s1Z1A1UkJudlpPOFhTT0Fz?=
 =?utf-8?B?d2wxaWFwRTF3K0dzY0lkcmhRQnhKa0grSW9odStWa1puc0t3alVKQUZPbTYr?=
 =?utf-8?B?STk3U2xDOFROQ1Fhd2piRUZIemJWeE9FdEhIVUJZSDZxRGpxc1FRUUpVdWcr?=
 =?utf-8?B?ektMdzdwSXY0K2lRcXc5ZzB3Z2lkcXVETnVhTXdmcVV2bDl1RDhzemI4Smov?=
 =?utf-8?B?UGsxem5sVkMwUEN3NzhOUy9Lc0xTR09TdllpNnJsS2FXenNGY2kzUk9IalpN?=
 =?utf-8?B?TFI4aHp0YjZrMkFpOHI5YW4xdVNPR3R2Q2VIUEJYdk5QVUE3VlRoZXdTOVpy?=
 =?utf-8?B?bjBhcTlyVzBZQlROTVlVWStZdng3VlJ1Y1JXTG1UM3M1VHRnVmRRWC85VXFE?=
 =?utf-8?B?VTQ4eSsvTWV3NTBPZjNheDVUanUyczNiTTRDQjI4bWxsNkxsclAxcGdHVmRV?=
 =?utf-8?B?bCt5SVlsZzRReXJ3UldueEtUNW1obkhFSmtQaVN2em5JUU81eGUxZUpaU0dp?=
 =?utf-8?B?YWVzTlkxZFlMbTJhdGVDQk1GVmpRMWk1MWdSN3ZPcnNNR1Y2dW5SRTZUNjN0?=
 =?utf-8?B?Vm84Zmtzb21HOU9TUVlDc0dSUnZYRlNpemEwSUlUNmlOR2ZDYUtGbWtUQ0Iy?=
 =?utf-8?B?NXZIUnFiR3RQVXAycTB5dWRqMW5PNE02Njgzbm9Qa1FvTkxXY1pOSDNxK2Ja?=
 =?utf-8?B?czE5M2duVXZKTmJxcU9QMS9wQ2hFS0hlVlJZOG9CQWY1UXJERXhiWnI2bzB2?=
 =?utf-8?B?K1AzRk02MTZKY25ieVBTM2k5U3J1YTMzaUY1cHRLZWVQblNhNTlvRVA1RzR4?=
 =?utf-8?B?NldiTlRjS00xN2ZDYXI3eHYwQnN0RDZPZ0xScmpFT3FWZnNLaE4zYzNzYmVL?=
 =?utf-8?B?WnlGejQyb1ByRTRiYWNvZEJxQXMyVUNQMitVNU5scGJUZG9vTHpCWlRURzEr?=
 =?utf-8?B?RjFHQlRQMSt0RjQxRmJkQjh3dkZ2U2tza1ZPTVpDbFpaOEF4eE9NVThkRnFu?=
 =?utf-8?B?Smh5L09NTlBKaTBnNWlreFh4OFlPcDlTK0hVT0tCK3VRb3A4V3VMQ2tRU2pr?=
 =?utf-8?B?RHJMaTl0R3VsR0l5Sm80QU9yOXV5Qy9aRlBxUnl4ZXA2M2FFRzU0YW12Mm4x?=
 =?utf-8?B?bjJSRjNCU2M0RENPZ1RpZjBRTXVxQnBDZ3dZYlFtUm8yL2pESUpnRm50bHN6?=
 =?utf-8?B?K2s2UkxvWnV3bVNacnRiaVJhZXMzaGNXSHNTMXhHWkNyTldselUrUjdSSitM?=
 =?utf-8?B?Qk52cGlsaWFaa1dXVG1Bbm1SemtHcUdjU0gvcG9rbDFMR3ptREV2ZjIyZk9F?=
 =?utf-8?B?ZXQrbVR6TEpUQ0VSTGJOU1o4VUZXbEZEUWQxVmxNcUVnaWxCRkVaUGVKWDNE?=
 =?utf-8?B?S0RKVUZBVGVZeHBkemJ4VlZYYXFDZnNSNjMza3FHNjcrUDRUekcrT1hKbFlr?=
 =?utf-8?B?SUI4bTkyS1hmZitDZU9kTW9XNldzVFlKWElES2RLcGt4UGRJUWhWYkFxS1Rx?=
 =?utf-8?B?R2FwV0FMaW15c1BCL1d3QTBSNGhWeDVBemdZMkJNNUZXb2s3a1FwS1BSMkpF?=
 =?utf-8?B?anNMeEVxZVEyQktON2dScVJaQ3lRV3JRc2sxOUxXYjFISkN3SUlqR3BjekRT?=
 =?utf-8?B?N29iNlhqUzd5aWlZMnZtUE5YSUkzQ2N3Q01TZFQ3QUdHR3RBTklubWh5NjU1?=
 =?utf-8?B?SEJaWU5VeGlnSFo1THNmTVdtRlgxSEI2cHVqcHBPaHVCNTJVY2RrTlhzTk1V?=
 =?utf-8?B?NDg0ZXpLQUhLZ0R3eDdjMnBhMS9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:01:50.2310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633dec68-165a-4947-1a0f-08de54dde2d9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7514

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
Dhruva Gole (3):
      cpufreq: dt-platdev: Add ti,am62l3 to blocklist
      cpufreq: ti-cpufreq: add support for AM62L3 SoC
      arm64: dts: ti: k3-am62l: support cpufreq

 arch/arm64/boot/dts/ti/k3-am62l-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62l3.dtsi       | 47 +++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c        |  1 +
 drivers/cpufreq/ti-cpufreq.c                | 32 ++++++++++++++++++++
 4 files changed, 85 insertions(+)
---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260116-am62l-cpufreq-1987a04a6f68

Best regards,
-- 
Dhruva Gole <d-gole@ti.com>


