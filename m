Return-Path: <linux-pm+bounces-40060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC0CEABA6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 22:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3542D300EA27
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 21:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B55283FEE;
	Tue, 30 Dec 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NqP9HAP2"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED622301;
	Tue, 30 Dec 2025 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767130657; cv=fail; b=GTEzyAFIF514nK4TfNs4BRyIMiHRdQHrVAe72jt+2fM8fQZmAKl+QrdohlM/4hX+J+BdCTZfC87a+SgxVywCPRU1wAox6rKb/CjV92gcX5BGfockzlYPiUcTo71LA4Sv4dlsJaZfSOdkappJ68LVVvEZBgquhLcb3RGNFQP8JCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767130657; c=relaxed/simple;
	bh=MZMhUYWr2cCT0JSBZm/cF+0daxKfqlqG0tEVLoeXUFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YzUagC36Ajyj+5TDHgwoYQ0Nz4Ou3+wFCj0+uni72QmPVzKQ9qkg+smch/TPvCTtPx2lANrjpLBGS4RrOYUu1qtCVIpjvT/Bq1OqKZUBj/pYTqSzT4vjFUe0TgCcnGjV3vdfyFwNKiI3YxLpDpGWEVmhC4nW8xrRqnl5EK+jK+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NqP9HAP2; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaIXRQHC7BrIjQZA6tyY5eIQVwZvhymTXvvegxhhMEqKh/0Nvmmrvy0rQcUM4+gb3nTz/AaZT7KFq8J+Bt91xZ2nl9SIpxoqKiicqC7+UigciQQXxrzRdn3qbd1KOQGM8w5dAD4LtST0Qq5O1xzMk0Z5eCQ3ZCFBzDG4KJBGLuwYiLNbIkzltytNaxubkhzfWzWYZJRlbOoPIBo/UXoJ8gNPQ59mqIQqsX4skOFJS1voa4khYgBFV3Dur9TgTgMtqr4nEOMN9SlTwxk8w7Jbt5yvQtrjdfX4H+H4qdmktZdTNahGFBvov4AEp4We+/GZgzmDY2JHkvFljRRs+7FkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n68Q1FMNLBoPuZVtzKO7HiitXU7WT9FSjD/n0pMXlYo=;
 b=RC6S3JAwKSczZ+CuvQCRlZZzICd1MlhGzSjwHn5ltxPd0hJbwKBruA/h2Y6wit4iYLMEObYXyxuWEUjgaFipmYTz5OiP/6+6XzC4mUG8rRA5PcqcsVZoj+ZexUvDWo9pwvU40r6nGHA9hrIzMm38byc5PVHTM4plW6Bw1AFe8QUk7Ut0mNm2vz4k7DESMPOqOsCvECanq0c0fE/q7FZ3C/89j88lmPgZXCPOiDG+0fP1bEorKH9z6o6DrWhCylNNh2DOboUbL/P72gYWKPzBpzP50JRWugBUpuRbZKxmiPWE04D/Ejye914ZoEySC+O6/zJUVzT/YBVDb/V6jjSveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n68Q1FMNLBoPuZVtzKO7HiitXU7WT9FSjD/n0pMXlYo=;
 b=NqP9HAP2xUyI6UN8e9qLPQ3W5Qyw4B+EigUPIz3zDFHWBUZoqNR6QZV+aHaROSQ2jqy4m7k8IBLs5wpG0kEQX1k9cwQzcwd13313GhI7vrlgKVagVBl9Y/6HGYeurY8JbK/KM9vJ8dxDD2u5B7xlcTgzxGB74IJtnbt8GJKGO3c=
Received: from PH8P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::9)
 by SJ5PPF0687F9010.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::786) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 21:37:32 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::79) by PH8P221CA0004.outlook.office365.com
 (2603:10b6:510:2d8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 21:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 21:37:30 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 15:37:27 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 15:37:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Dec 2025 15:37:27 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BULbRGN1397183;
	Tue, 30 Dec 2025 15:37:27 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 30 Dec 2025 15:37:18 -0600
Subject: [PATCH] pmdomain: ti_sci: handle wakeup constraint for out-of-band
 wakeup
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251230-pmdomain-v1-1-3a009d1ff72e@ti.com>
X-B4-Tracking: v=1; b=H4sIAA1GVGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2MD3YLclPzcxMw83VRzw6TUFMskE4M0CyWg8oKi1LTMCrBR0bG1tQB
 WH4KKWgAAAA==
X-Change-ID: 20251230-pmdomain-e71bed9b40f8
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
	<msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
	<s-kochidanadu@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Kendall Willis
	<k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767130647; l=2796;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=MZMhUYWr2cCT0JSBZm/cF+0daxKfqlqG0tEVLoeXUFo=;
 b=uxd4O4nfqzN+XcA2V4inx+miUCSACdRXk8T1392PhARiGNqQtvUMliuAPxiyIBaKzHe55LAgj
 XwJ6UTEKYflDN+poMKbIu2hGKkhmDEdPnBIj31kQxN61DAxYRo3MZ5D
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SJ5PPF0687F9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 08aa8d81-7e13-42fd-dc50-08de47eba2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkFkZllsWTdoNHNxRHIvZ1dTNG1LTzV1WmV3Y25PaWMxNlkrc1VLdURlZG1h?=
 =?utf-8?B?eWl1TUlYdHlqMEJqR2oxSlROQm1MSTZrV0JoTWFjYzI2NFdtTlZ3MWwvdFZm?=
 =?utf-8?B?dkhjc2xoZmNUMWppM3VPV2tYbWFMZjB0QXZjRXJDUUVhZ2pJL1BnRWlwUkFm?=
 =?utf-8?B?bzM5U1orTmlYdmJCY0ZRbUFiQndjOCtvOWtyV2ZzMG1TcGlsWVZzbXVGK1J1?=
 =?utf-8?B?dE9kcmpzd3MvSWJ4aTBpaEx5VjFoVy92aU01T3o1eEtDYk5jeDJtZlk4eHlj?=
 =?utf-8?B?TGhlRWtTNGVBdnFvYkUvay9nNi92aHMyamFpdFA2WUM2WWU1cmNrcnpLd2E1?=
 =?utf-8?B?T3dMSmRCNFUwWEdiWU1BV2dBNnZmdmNIOGF4cWRzb2h3TmRmRWVZTExXbTdh?=
 =?utf-8?B?a2JLWVFYSzN1RHNHM0dFKzEyeENFazJxMXFVT25ibjFHUGgrZkNlU0l6L0xl?=
 =?utf-8?B?YlNyVDEvUHlxQTZ2U1dBMy9BbFlqUkxDMmJEYWVKZ25nVk9KTnFTVUM4NzlC?=
 =?utf-8?B?RmR6ZUhpbTEzWFdKdS9JdHp0UGxTcWhCK2thKzlRWUhsdnZwZC9yZ0RXb21C?=
 =?utf-8?B?dTdHWHZTcjVyUThPcm5ZckhjUXpOVmxDdUMya3Bpbk1TcDFPM2Zpdk5KcjFL?=
 =?utf-8?B?NjlYMUh1MDFPS3V1S1BhZFg5dktxczhLRGF4T01kamhXR1k3R0JNQWFjaFRo?=
 =?utf-8?B?andxRGRIdHhMYUJ6YWdPK3hzQmsvdktTZ1ZHZDZ2WGlZdDYyZmlwL1JFdm5x?=
 =?utf-8?B?YzBETTN0c3dYV3orOUtBano0Z1dZdWU5N25WREpaRTUxMWR5bzMzRWR2Mk1s?=
 =?utf-8?B?NHY2UU01d2I4VldDaFJrVGNpM1BvSEpOditMeXM5V0dHVC9WQUl6eHpwZ0xy?=
 =?utf-8?B?VHlwYlRFVCt6ZFdxYVZiSVVGcXVIZkVaZWp5VTBDUVRLb3UzK2JjbHN4UmJv?=
 =?utf-8?B?NzR6ME5za1NRSnJmVTBCNnlXUm0xdnIyZzhRaDFGa2doQVovSWxRTXJqVCt4?=
 =?utf-8?B?cXB0KzVNalU1bFhYanVDMVZ6WWRHZmc4TG1GbENUckMzcHkrcXhyQUFlcGlp?=
 =?utf-8?B?dUExdC9ZS1Bqa09yVEg1V044OUIwMzBvYmpRRTRWVTdSNHhmdW14bUkzNkVw?=
 =?utf-8?B?MnIvcmN5a0VTUEZDWFJ2cEdUQ3o0Q2pUZDlmR1JuS1ZWUm9PV0k4ZzhkYktW?=
 =?utf-8?B?OS9ONXBEaUV2eXZqb3c3WTZjcVc3UFQzY1J5SmcrcTVOSi9MY3M0K0crTHlK?=
 =?utf-8?B?Ujg2bURhdlk2R1d4TkF6L1hvQjd6SGhneG5qZm54ZklReENUOUZ3MzA3WUsx?=
 =?utf-8?B?V2k3VUNQMTFFTUFJNnlpUkt6OTAyb3A2aXBWcWp6cWNLOGViQllrR09oR0J1?=
 =?utf-8?B?UHBwdzh0RlA4VVFlSWZkZjRTc3JwSlVNUjVKN2I2SFFwVDZyNmVjYzQzT25u?=
 =?utf-8?B?MktxK0lWMHRMb1BvOGx3WnRBaGMrakhldEFZbWc3enZySTcvcjQ4NDNHOFJx?=
 =?utf-8?B?L1FrdkJtdmkyV0J0bytiQnZHbG9yc3pxamhKWUFpaGpuNE5ZVDJDRDM3a1Bz?=
 =?utf-8?B?NkVHOUJSS1Nwa0ZKSnhCR21nRnFjRlM0ZGltUVorYzMzVlArK3lPSWM2dU1S?=
 =?utf-8?B?SEd4US9uTGdnSVBSKzMrdGx1MThmNDZFWHNDQTZQd3l3Mlk2TmcrSDNnM3ov?=
 =?utf-8?B?OFNrRU9IWnNTWHRmbjZpZVYvWFRjcGRhUDREK0JIWWdMR0M5REpwZGdiTVJF?=
 =?utf-8?B?dDRVd2lnWFZJZjNqaEVPaU5NbkQyREJESGNLck5sWVNob25GU0tEMU5Wc0Rx?=
 =?utf-8?B?NXZRTXhCN3FQdUw2WS9Yb0NhQ25DdnR3Z2podDR3UnloMDBxNnpkNTM0T3Ft?=
 =?utf-8?B?dy9MbUhvcUNsbjJHekpUZEFFbHRUVzZaTDBEbC9EcDZWZDNNQkFnTldGYmJh?=
 =?utf-8?B?VzQrM1crSUJMRlVULzVOUFM3d0FnWElGZ1lCTFlOUVlTTDNsengwZ01ZLzhp?=
 =?utf-8?B?SFVKYVdOZmNJbWtReS9rWGJ6QTBEQkZMVWRrYkl1Tm81NU9NUjJEaHZTNTRS?=
 =?utf-8?B?aWJZMnVJN0VWeDdPUEMyVjJreU13dFNkdElvZmRaNkxqOGNLdXdzckJEaEhi?=
 =?utf-8?Q?HDJo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 21:37:30.9626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aa8d81-7e13-42fd-dc50-08de47eba2f3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0687F9010

For devices capable of out-of-band system wakeups via I/O daisy chaining,
prevent sending wakeup constraints to the PM co-processor. This allows
the system to enter deeper low power modes, as the device is not marked
as requiring power.

Replaces the logic from commit b06bc4727991 ("pmdomain: ti_sci: handle
wake IRQs for IO daisy chain wakeups") since checking out-of-band wakeup
will cover the same functionality.

Detect out-of-band wakeup in the suspend path, and if it exists, skip
sending the constraint.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Implementation
--------------
This patch is intended to be implemented along with the following
series. This patch has no dependencies on any of the other series:

1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup"
   (this patch): Skips setting constraints for wakeup sources that have
   out-of-band wakeup capability.
   https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain

2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists":
   Implements out-of-band wakeup from the UARTs for TI K3 SoCs
   https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
   functionality to wakeup the system from the Main UART
   https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts

Testing
-------
Tested on a AM62P SK EVM board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

This github branch has all the necessary patches to test the series
using v6.19-rc1:
https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/all
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index e5d1934f78d9ee0a02eb05aa1301cd5a59e134d6..18d33bc35dee1b3bf6107af1e414db377d515199 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -91,8 +91,9 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 		 * If device can wakeup using IO daisy chain wakeups,
 		 * we do not want to set a constraint.
 		 */
-		if (dev->power.wakeirq) {
-			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
+		if (device_out_band_wakeup(dev)) {
+			dev_dbg(dev, "%s: has out of band wakeup, not setting constraints\n", \
+					__func__);
 			return;
 		}
 

---
base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
change-id: 20251230-pmdomain-e71bed9b40f8

Best regards,
-- 
Kendall Willis <k-willis@ti.com>


