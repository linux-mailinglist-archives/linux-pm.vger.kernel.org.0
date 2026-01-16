Return-Path: <linux-pm+bounces-40978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31521D2E70B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2148C303E6BD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57F30FC03;
	Fri, 16 Jan 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvx2vKsb"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0129B79B;
	Fri, 16 Jan 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554154; cv=fail; b=UU7h4NscY7GF9AtGJ4eXBcE6dv1pnpcd9zOPEQkb4MOnOLpwBmOykHjk0kJDeD2mqRbOp6c3p+qrZbq8AY5dCiMH9Gfy5m4xfGbdq9RweYRBFGojdMDCaJC0Gx4EA8HLOpe1KSwIZWQ7UbkVExMKOa+gOt+QONGWk2h7qNYAmyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554154; c=relaxed/simple;
	bh=h5rf7jMMhZ8CWMUtvIPNbWeRkVES5sGEMJxTf+Dr8aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lQ2o9tI6Cds6OprlDYaufMtJ3XCajVs33gZyK7IDI8hhqKEpC9zO4/4gvIQtevUuMW4kpy71SOVK38+AY6p7RynMKlDidgppW8ipc+Ca2y35XyyHzfEgto1qj1Iw6pzDe2xiESbHMTdYrxI1svsRiocIIibqX0TMq9j+ikUFFPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uvx2vKsb; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS0r8Wqk1cba6P7xW3FaWVSIjRRu59W99Wg1qAcVeALO72OiHi9Qc0ZU1XGeDo7EB96zxh4gIXtUj7ztxjiYN2v4asvdotzBzn31vCJ/vhBSScePDMZrakPFr2E3Yl8Wmqw/YNYOVI67L6DRufr6uEue5nxgYWipgt8T2iwSGJZrs1sbeAcd2vK40dPvHkT9Bp9mElP/6qXWXB5TKKeVd8XvjDeURwQ13QVRpTVoKw5yWU0xNDU7rLR2e0bxO/wbduZ7pkCNYppzLrYukKCz1hwMPn5LPzt97U7O+LAlqu2Wa1C8XtA8+1d8tDk2QVr6I4WcDHYkgb7nUuWitUC1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaVps8EaqB4X9iNWbhd3IY3BL8Ci8llVi4cSTEmRykw=;
 b=iYZn2nwwGJWUr4Yb6cEtxpNEt4ly8cwvcb6y6FsTSpVNUQZQl5HEmk4MafMhRHcrcQPWZvKrwpKaWCepUMF+ugFl3gKhaUGXpJHa8F5+mTua2nrbGJ6dIfMngcdVu40UbJ5a8p2XksR5kKXjh+gsra21NjZQB+eRWtFgMWV5FAOHL2rxzM6+mHvGS5yNNCjfloqIfK24eFF8mjrL34slSEKTC2+jn4dpGFnLrNyieD/vf0IfWLG8/Wp7Op9wP61kbGNa+fcqEgBDdt2nZIG+KM+DXpR9WVBQymNcI4MZjYUkj2iaDNB8N2+99R/CFiLjxhGVHxPIon4PiobqCAvf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaVps8EaqB4X9iNWbhd3IY3BL8Ci8llVi4cSTEmRykw=;
 b=uvx2vKsbTZNwpNbXEvWHtMt6qHk2D027WyXr/ydvxBt4a954PhkPwjoaTEcictp1BLhLJekbZYEwN5PrcTMyFkf6SiFVBdS169zECQ66tBMf+quIetsZp9j7LJ609cny8y12ZxIIDqCXdKKCRXgvN5vQobdz1y4G+eEZCYs0kw0=
Received: from MN0P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::30)
 by CY8PR10MB7368.namprd10.prod.outlook.com (2603:10b6:930:7f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 09:02:31 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::d7) by MN0P221CA0008.outlook.office365.com
 (2603:10b6:208:52a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 09:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:02:29 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:01:54 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:01:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 03:01:54 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G91iBS3029793;
	Fri, 16 Jan 2026 03:01:50 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Fri, 16 Jan 2026 14:31:06 +0530
Subject: [PATCH 1/3] cpufreq: dt-platdev: Add ti,am62l3 to blocklist
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-am62l-cpufreq-v1-1-63d062317ae9@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768554104; l=1061;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=h5rf7jMMhZ8CWMUtvIPNbWeRkVES5sGEMJxTf+Dr8aE=;
 b=J27W/6oiUlppHkPAuVIcYW+K8RIz+/HZfcPoxksVCSIHydVAPzRvoYbRc+lX6rMwsjB//t4UF
 dW+cLwyLBTgCjSgqMqkyHWJoAizAAiXNJGjwE0OAF1z8KG46XnTghan
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY8PR10MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 11568756-3be8-4f0d-4244-08de54ddfa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHRyR0dDWUJPdlhRemVsbEJrL2xUUStWV2hudG9ybVU0KzgvNnhBUWd1UE1W?=
 =?utf-8?B?WVFRSEZNUkwyZkpQZXg2QmdTL0xLbk9aZG0xWjN6ckdBMmpaNjlVSEFEdTh4?=
 =?utf-8?B?YUVuMmhmSU0wbTBlcFF4Z1kwMlFZRmpZa1M3L3JLZjJpUFIxeXgyaENDVm9u?=
 =?utf-8?B?Z3AyV2dxT1dMZmVId25xMFlwbGlaWXNQN2d5VEI5TmNIMlh1eGxKTm5UY2po?=
 =?utf-8?B?OCtOVHhKOVQ1WHlxeFBlRHFlM3ZZaTNsdnBlOWtMNXFWVVdtUUZXMFppeFRL?=
 =?utf-8?B?RkpCUWZzSjhhcEhzSjk3bm4yMmxsMzV3UW5ZcHN5TmNaQ3VBTk1LUU9RL2Z2?=
 =?utf-8?B?THlVdXlrK05uVyt4OFBUcmNzQnVOcHhnUldyYkpNbVJEb2Q1OVBwZVZac2lF?=
 =?utf-8?B?Y2VCc01pbG9ySElmcnFLdzNFQnpSMEFQUkR2ZkZuQm1rdUhXM0psdHRyclZI?=
 =?utf-8?B?THVkZEFiNVkvdHp1ZUZZckp3TEZKZ3pheWIzdVNSeEJkaXppQ1REOUxHTVpJ?=
 =?utf-8?B?eXoraGxZV0t5ckROdEVyNXBlKzdZMzBUVkNDWlVxeUYxT082bWdCQ2VGOGFR?=
 =?utf-8?B?KzJWa0ZWMmJqSTFVdTJ0QzBDdUhUdWNXR1FBVGViY3RLa2lwU1VRL2tHSG9p?=
 =?utf-8?B?NWlIalB2WjZZT2tZK3FuZ2Yycmg5S1B5Y1dXVDFia01XUVpBMTM4SUNKdThS?=
 =?utf-8?B?d00zRWpzZHJkZENsZ3RRR0pOSGZvMlZGV0dzZ2RaVnBjMzNLbXY1YWZrUUF4?=
 =?utf-8?B?Zi9IaC9oWEQ2bVRqY1lTZGZpVXZSSDhON2g2UmIzYS94ZjhHT2hsTkN4dkFn?=
 =?utf-8?B?YlcvRDdmeWM1aEpKcUxBeklJdUk1QUoyUEVQdTluZW5Dd29ibzNtNlNGSUpI?=
 =?utf-8?B?Z1B6WndESXcvaDFNaXdyUlZxQTk0Y1JiYzhGZUJKaDRRbGRzUHhYa3BUTDh2?=
 =?utf-8?B?NjhzVE5LWG1hOWhZaktZT3VaNjB4SG1HMi9GN1ZhV09YRmhWaWVuUmw5M0I5?=
 =?utf-8?B?Wkt1aXI3cENNZGprckhQY3JCUkVRS2JaZ1lzaHVVWFNuNmFOMzFOMnNqa1hh?=
 =?utf-8?B?Z3pESkwyQ2JYWUEzU3J0VVJNdWd5YjNYRittYkxTNERLbFAzQmc2bjR6b3dH?=
 =?utf-8?B?bmlhd2ltQ1VNTERYd2JXT3k1Y1NiWnd0emp2MEMrM21yLzJnb3FMbmNyaEI3?=
 =?utf-8?B?c2NqNkxDWDNINGJNOG5Ta1R0dWIwSjZiWi8rdXFkS1pPdTRrTUljaUtSOWU2?=
 =?utf-8?B?ZWh0TENMSUdzcDR1RXZaMVVmK2dseGpVZlRpbEg0aS8xRTJEdmtyWDRCVXlP?=
 =?utf-8?B?dHVIbEs2UWhrREFXY3RZcHgzSGRrU28vWVB2UXF1TzBBdVQwOXRVeE5QaENE?=
 =?utf-8?B?T0JzNmJDb1J5OXRJclQ2cGc1bnNZdlhvNlZXQUlwQ0NMK0VxZStNVHA4WTJ2?=
 =?utf-8?B?SW9SUHJDU0d5RVp6RDBYLzNOcW4waEVETjZhYjVvTW01dDFNK1o5UjRmeVVW?=
 =?utf-8?B?Y2oyN1pFcGU3dHNxQ1lXRFFPOXNJL3lUWGJoeVQ5SkZ4cnltanBqcmQyNjkr?=
 =?utf-8?B?cEhiVElDOExZU25IYXl6YVZyM20xdzZyRkhnRC94YmJQOG5leFlxTEJWSWly?=
 =?utf-8?B?MTJVMEFEZkJCQXhPdko1L05WMTd4VFc5aFhPSEFDQ2NWSWJBQnNCYklCRlVz?=
 =?utf-8?B?UmhLemJHSFIzK3RBRkU1YzBnT2dLSFFWMnZqcUN1U0VOcGlHZU80aVJEVUU1?=
 =?utf-8?B?T1BhOWNKTGNRUHFIOTU0dWNJL1FHQ1pJQ0haR3J6QjhDWG9TTkVJZTlnRU9U?=
 =?utf-8?B?V2xpZXZZUjg5Z25KcXRMTWNxcFU1aTFua3VFMjJKUi9RNGJHejZHMzZVdXRa?=
 =?utf-8?B?US9UKzZydHdmTjh6UVRLeWwxbzdjOHZBclBYZXNYcEZMR2YwUFFjU1pQMXRJ?=
 =?utf-8?B?dzM5M204OVY2WHFYVFB5WXZ1bjF4cWc1K3lqbU9YQmlpMlh5QWI4ZlcyZ29Q?=
 =?utf-8?B?RGFsbkNVYWdnSGFBejBjRzFFRmFxVndkZjltY3g0ekR2WStMYTZUdzRYa21u?=
 =?utf-8?B?VUpmalVBSzJkZHU2d0lXTXl4K2NWUFdWN0NJRU5paVZrbmtjbDcvZDBkMDBC?=
 =?utf-8?B?TUhBL1N6TFpSTXVtWGJaTmFjVEVWVkd3MFNJYXBNQlpYdTdIdGxJbFFJSXNW?=
 =?utf-8?B?bU01NmhwWjlrYzhPbmY1ZEV6aUdNTU5tcWF0Ky81KzZia2VySlFUQ3dYaWd1?=
 =?utf-8?B?WjBoQWhIemlra3BqdTU5YnhWWlVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:02:29.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11568756-3be8-4f0d-4244-08de54ddfa67
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7368

Add AM62L3 SoC to the dt-platdev blocklist to ensure proper handling
of CPUFreq functionality. The AM62L3 will use its native TI CPUFreq
driver implementation instead of the generic dt-platdev driver.

This follows the same pattern as other TI SoCs like AM62A7, AM62D2,
and AM62P5 which have been previously added to this blocklist.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1708179b2610bca6035d10f0f4766eee6f73912e..29122bac2e22f6e7a8e8294cc01923c8a13d53c1 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -194,6 +194,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62a7", },
 	{ .compatible = "ti,am62d2", },
 	{ .compatible = "ti,am62p5", },
+	{ .compatible = "ti,am62l3", },
 
 	{ .compatible = "qcom,ipq5332", },
 	{ .compatible = "qcom,ipq5424", },

-- 
2.34.1


