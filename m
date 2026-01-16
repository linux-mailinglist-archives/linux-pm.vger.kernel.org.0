Return-Path: <linux-pm+bounces-40987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF4D2F785
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 675093009756
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0630BBBF;
	Fri, 16 Jan 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jdYIJXt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35A2DA77F;
	Fri, 16 Jan 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558927; cv=fail; b=MYUzMfSjohVdNDUjTu65QazzM6oDTMfSW/oHTq3VQ+Spg3SBlWqSQ+FznBXOqsLDjwwEnNC01HBa234J3ApQRtLoCiY7Jxp55z61pku4ieC3U1hVPOVcs1/S+uR9Jpc7XZioo43Y/RMgit5JwF8/gWza5iy2afF68bqWxKLg6to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558927; c=relaxed/simple;
	bh=yhHqojCOQx7eR3QjnNdz0qJYfrydUugbpiKtyxqoc1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p4OI55VjNSBaeZxM9TFd0MSuioHlCn5MJNjjYfKmKukHSbYzzhk+guSjRkXwx0Xx8ZluJZFe1LrIk9XAQk8MpIyClzQNpArPEWOUG6SsORWMY8NyQVuXCjypfwi1C9IjAfPzdNv6GLbnXLyfUkzlZi3JtX5NNCKgEq9rpSCpW3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jdYIJXt0; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weHQHKJjspguI+3IpUfZbHTjOP5nHY+5sxvQPnOCZC4SsEbev4ldbDLqa6c+4/t8/YbSCqZMIGwqKhcMo6swTAQ4JmEysIDWNc5Kucq323Vwl8DYF7eUgrkmv3vztrVwh72qwlB19jtS12ELwdd+UE42Qao0sMRPdyDRWQAeE7EbXhQXybJ0Afo6NnicGZUQyl3ELhMDNUgrEEZbqvTECkVGgpWeBB4oEr3yQjNDbq9ZERWzBPMrXntoa+5m9Z1Q51hCc3Y6q1XLCDaNB+pPaQZOPpliNNC0R3/TOOvc1ckTwiwKYtkxEVCQ+j1c8FZoMlztyEFG/fRgWOdJLYrH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqr2iRehvC2b97ZosXCyMrS8LnbBJHwHPknGL8VH82g=;
 b=OJNififLYLrO5YFGrQL7fSX51jk1ByKwsxrXM/wY8y+Omy7mW3EYHeULM8msfth4Yowy69+sxukKmGNr/HR1KPfutzGKbo5NTAHOjC04KjyWfT5+wv2w0svyAt6zrK3sMqjRErUJe4Gs76KeAJZ6YYMwfdsS1dMNgR77MIPRXixuQzzS41cJnDHWLm0zAJeLsp0kzZM+bQQXIxnamkvxGn2zV1YH7tgkl1OgOew77bFAwdyPsUD7jrfwMyYuDDK1Lo239r7AbVNyZhJEFsKu2+jlaTuzLOZkn9wh7zsYFYfyLE5ykCFo8w5Xqzb8zlGIcrNKx6gk/KsqoWlihzpwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqr2iRehvC2b97ZosXCyMrS8LnbBJHwHPknGL8VH82g=;
 b=jdYIJXt0J/veqQMJ57RYY5BmxfHK0SLJCI6dZ4JFO/mzFv2eQHeBEsDrJOVcxxqr9u5f7BEEpQBTnNewCq8px+kr5S0VrHdxLgmTwZICmyI7rTX4Dek+Bvg2rcv7H5BoHrU3PdHJcRPePk1dd4mhNPVB2RhRLnVPNlH1Z6O4doQ=
Received: from SN7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::8)
 by MN6PR10MB7543.namprd10.prod.outlook.com (2603:10b6:208:473::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 10:22:03 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::1a) by SN7P220CA0003.outlook.office365.com
 (2603:10b6:806:123::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 10:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 10:22:03 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:22:02 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:22:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 04:22:02 -0600
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GALnXW3128184;
	Fri, 16 Jan 2026 04:21:56 -0600
From: Dhruva Gole <d-gole@ti.com>
Date: Fri, 16 Jan 2026 15:51:29 +0530
Subject: [PATCH v2 1/3] cpufreq: dt-platdev: Add ti,am62l3 to blocklist
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-am62l-cpufreq-v2-1-eac7e2e78d29@ti.com>
References: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
In-Reply-To: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768558909; l=1057;
 i=d-gole@ti.com; h=from:subject:message-id;
 bh=yhHqojCOQx7eR3QjnNdz0qJYfrydUugbpiKtyxqoc1M=;
 b=AEn6AF2M3fWjg47uatIx9u4F9ibnS4z3BMfsxX8uJN37Dpg247Od4psxtPmmZ/P70NphUTwkX
 EXeIfec55PZCgaK6wpF8WC23lAacvO9nT+QZo90BDtsODUL+bstFUz0
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|MN6PR10MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5a5b04-ddbd-451a-f341-08de54e91788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|34020700016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZuOHl4eUVoM3JMNXFoZWh5UFF1RmUrQ2gzVzc5OU9DdEtYN2grazZHRzRw?=
 =?utf-8?B?Wngyak5Ea0tsRElSa0tlTEpoek5xTGFSNGxOQUhlbzVON1BOcTNoVmxPTCtL?=
 =?utf-8?B?UDFiWE5iQ0pFOUtaR0xra2tRWW1LbDdiOHBVQTFvc0cyZDcycFNpckoybENV?=
 =?utf-8?B?M3R4by9qeW9uOG4rcFR4ZWp1VXYwdWhKOERrU2piNDNFaVhud21pUEEzWURQ?=
 =?utf-8?B?dk9VNWZWSllaY0JpQXhkZ2dlQm5NRlA3WEhJWUtrMEVLWHBQVWg5bko3WE9y?=
 =?utf-8?B?aFRZcWIwai9mSWZqdFpiLzlhV3NJN3NtV2Z6RlNvYmZZVk13c1ZCMGNXMmxi?=
 =?utf-8?B?eUwvWFFoQ29CMnpjMnJwam05UTlpc3oxQkV6WWNVQVVTd2x3NE1HRkFVWEta?=
 =?utf-8?B?MHVnbWl6Z1BYb1V5Kzc4ZVFIWk5vMDNWTmZrU2YxdlRlbmZyeEJFblBzbEZO?=
 =?utf-8?B?Rk5IdEl1TXR4UjNvWlBZYnFzNm9hd0gzT3pHSThReWJoSVF6ZFM4R3FvT2pB?=
 =?utf-8?B?WDFXZmlNOEdmZ3VPOFpwa08rVGpoWEJicUtCSCtOVmJmTFhsbE9lOC92YWZC?=
 =?utf-8?B?ZDlmd004RU5zQWpuaDd2VkJGdlpCWnRteDkwRHV4SE1IeldZTlNpNWNOVkdy?=
 =?utf-8?B?VlNRWWYyMFlKK01WMzE2VEluUTdWOXR4aUNFbHhPcDZRMlJITlozNFJHQjNI?=
 =?utf-8?B?Wmorcm9Qdm5JcENpZEVKN3VaaXhxTU5pczhkcnZYYTVhSlhmVmhKMU1SLzU2?=
 =?utf-8?B?bVp0dFFyRitoMHUrVS9qVTg2YmlRSHY0T2VHOWc5U1VzbDBsZDBRTlNhbzlF?=
 =?utf-8?B?ak5sWlFCaHlwK1pCd2NENGxXNUFiS2p4c0ZDdktGTTJWa0tLRis5cHgyYWpa?=
 =?utf-8?B?Vmt0OEVpSWxYK3JickliU1dqL2xyK2kwdCsyQ29KMU9oRUJ6Y3ZLR2xrWlFz?=
 =?utf-8?B?Z1dBRzdCSVBYcXhkYnpXUVpZL0w0Y05rWGRrcEt3VXdIQWUwSXRyenBRQ01M?=
 =?utf-8?B?VzdIT2tYNkM0Z1dHUUwvZWtqd285RFNrcEZGVkxicVFZMVRiUUdJRUhHNHlD?=
 =?utf-8?B?MnE2cTdVVUpCazIwTzdVZ1BjeElFMUc4QXQ1K0IxM3F6MVJJWlF2M2NZYUIy?=
 =?utf-8?B?NnF0NXdlUkhmcDJ5cGQ4aENidzlVTnMveEVvWWtBSTJiV1ZzdW9uUW1LbWQ0?=
 =?utf-8?B?RWNuRDNwaTZvd3phQU1Kb1dwSkRzb0trSExlNnFyNVFtdlMzSDVKcnlwNDND?=
 =?utf-8?B?KzgxNlVSZi96SytTTThpcWFGVTMrQnBibXpKMWU3eTZFVzBPRU5kRExXK1lh?=
 =?utf-8?B?SG5QNVRiU0RTaWRRcjNFS2diQjlYdjc5NncxTDh0eENsaEUzWDNKclgvd3da?=
 =?utf-8?B?T2I3TnBvQ2xoUWsvWVJ0dWRlOXFyZU96TkYyQTl1L0UvU2JTRlpDMithazQx?=
 =?utf-8?B?QkZEcVpFSGlHUzZPTk1NRk9vb3BwNk5jaGI0ZFVJMUR0NGpHSzBKYVY4UGVU?=
 =?utf-8?B?bEZydG1HclRKRmxZUkVlSEdpRzZCMHUydUs2UHlmRTE2TEZJOURmQUE5YmI1?=
 =?utf-8?B?em5wcXZRUEtZTWMrcXoySmhCVHVNbURVVGRzaVgrdVNkb2NZcGwwZHBzVzZB?=
 =?utf-8?B?MEp5eEY3MWpoQlBTbXVFeVlEZ1Ivd3o3M1M3SXlvU2c4T2hvTHp6S1R6eEJz?=
 =?utf-8?B?ZDNpelFycE5qZTM5YjFaQkErWEl5Z2E4dURmaTFzOTdnWGJDeVJhSjg3N2tj?=
 =?utf-8?B?Nlh1dm15bEt5N25mQmxrUUhIWlp4VHRuM2x2VmtNTjFGNjZCM2JSNXJXZWw2?=
 =?utf-8?B?K2w2OU54dit1ZUdsUjlraTErUFNvTnNmRVRia21nMmlWMDdocCtCbUpCREFP?=
 =?utf-8?B?UmJubkI0RmNDTTFNa2NpbWc0RkNkQ0szRlk1STh5aE9qWUcwVmsrcXlzenYz?=
 =?utf-8?B?T2FjMng2WG9jaXkxbU50SklIcm5KM3RhT1E1bjhkYkpMbDBUQ0xsODIwY1U4?=
 =?utf-8?B?QzhRd0NPMWsrZUp0SzRNb1BCK2NUazV1RTczcDlZdEZDcUJ5MHpDUzgrb3pI?=
 =?utf-8?B?RDBIazB6T1E2L3NGcGsrTlRId0kwSVNkSjM5U1NZcWRLKzdEdGJyZnllcGxZ?=
 =?utf-8?B?anN0ZXdGbVlhaFZPOE5UL28xSVlqd09FL3RPeHdOL3RiaTg4Yk5BbFNDclFw?=
 =?utf-8?B?KzJDVEY5Z1JQNVhZcnF2VllnRVRreWUxRjEyWGdoYzlZdStaT2o4OHVHUkti?=
 =?utf-8?B?a0JnT3R1Nm9yOHJzOWdrY2VZMUxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:22:03.1834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a5b04-ddbd-451a-f341-08de54e91788
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7543

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
index 1708179b2610bca6035d10f0f4766eee6f73912e..16310e190d9ff96af3d20cc5d98dc0e4af4d1bf1 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -193,6 +193,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am625", },
 	{ .compatible = "ti,am62a7", },
 	{ .compatible = "ti,am62d2", },
+	{ .compatible = "ti,am62l3", },
 	{ .compatible = "ti,am62p5", },
 
 	{ .compatible = "qcom,ipq5332", },

-- 
2.34.1


