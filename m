Return-Path: <linux-pm+bounces-41042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30DD38836
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 22:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51758305A2F9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFA2EBB81;
	Fri, 16 Jan 2026 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m9NeShhd"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679102D7810;
	Fri, 16 Jan 2026 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598168; cv=fail; b=dPYGojT0Kfz3nflgNWAOCzE4pbQmbrn/PO+CMpyg4TJ+tHb3oS0AMuqv9sKTmmeKco+CAohrOa5miKYSm/rXX6w58CsPxCTLDnbQZ9XyqwHfQu0YPU40t69LIaD4TgkIfLmKdpWoR21WcDLjm9su/Q7tOqRRkdH5AJxJW3S2Ua4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598168; c=relaxed/simple;
	bh=BlHixBhhsuJjxrGGCMh0L0ggT1N0VgYkbL3+39uHtTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e9X3grSzXxe+YHBUyddD3oSBbt70zDX+h5zIzEpHP5hS4HATMZCPXC2w7HKeTIeDm6U32uz7akXpfbHE331eHaApwrPhvELPzF1fMyRL4x/fJs/EhIjVToCLGm5QNyqjBgUK4VQN9axDb4p0IDIcD7dNBrEgz+tvEMFM2jDGIYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m9NeShhd; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cde68PTr/LBF/nj6KxqHcos7Ubnkhwbt/RZHVynjMJaVqihRL99959ABZ+IkXBO0JHdIFNfO0LR4vM6eBGJ33cG3LEMNOr6j7EnW2j3WgD71GpeWvpam00NuH/dW0o0WMBbkn+2VdVXTDNBl7BbkfewWUirhLVmy8L0qM142B1xjHf2pgsBDvXZFGbOBfXob1Xc77936bQL+F0VB9GYtFVJyagaQP5Ijv6dvUUXxWnIdPT37ZyFankR3zSw/e/fsv2f91Hpjq+Jn2F/D40iyWO6nHK04NWN9UKf2d0zehuzNe/MMBFwye979JS/OhrTIauBhjh8THw6tsOk8whZ9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+GebyZuLUebByb7BSRjC1COW71jYd49+xf8BTbDSSY=;
 b=XGI+f7YmZJgaEI00s2p44a0hBjmWkHoOhTclD+CIHc/nCj0HcnnYgnYcbGbkTqNc/RPcjuVeo2RGrmsUzz+QsS0EySWc0cyZu1FHv+mmh7CNwRLSXy4RAMLvKz2mm/VJ7pzzHwQdZZDW3wPfquboOXbtKZ8ZD/tjREvm8u+ei/M4QI8wGA1s/VZmhltCDuk3zkCbHqlFCoWdhTXPbStqTF3SXhgJ44e34nW4VNNl5c4yJfTXTuGviW5rhIwoNB++LbdMQa07wDu0I4CU+gtu7BPsS2bN1KYQ5ErKqYB6DxWh8GhplJbXVglSwSSJlJFVmHcPWarJaYceYcLN09xLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+GebyZuLUebByb7BSRjC1COW71jYd49+xf8BTbDSSY=;
 b=m9NeShhdWQfDPQI4w9YGiVkg2leuhdo27cB24RNEMc+tZEajyLr8VgYfWHfCCGb6SAJ/Qs3AO81stGvhfFx1h/dnx+YbD9YVKmFLuj20Y8DvcokiTaY4KAUkM/NPrJA8HJcmcph1S3QyXldE+xQn6E93vO5eGzRBmRUAs84zIVQ=
Received: from SN7PR04CA0068.namprd04.prod.outlook.com (2603:10b6:806:121::13)
 by CH4PR10MB8227.namprd10.prod.outlook.com (2603:10b6:610:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 21:16:03 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::60) by SN7PR04CA0068.outlook.office365.com
 (2603:10b6:806:121::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 21:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 21:16:01 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 15:16:01 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 15:16:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 15:16:01 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GLG1iL3898297;
	Fri, 16 Jan 2026 15:16:01 -0600
Message-ID: <c4ab2e7a-6d58-4ab0-a063-23a779e1c1ab@ti.com>
Date: Fri, 16 Jan 2026 15:16:01 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq: dt-platdev: Add ti,am62l3 to blocklist
To: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
 <20260116-am62l-cpufreq-v2-1-eac7e2e78d29@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20260116-am62l-cpufreq-v2-1-eac7e2e78d29@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH4PR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 716bacaf-d323-46e6-a842-08de554473b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2FqMXlOL1ZOVXFQS1o4S1NRV1BWQnJkVmYzR2VTVW54bHcyRWdHTzBrVEdz?=
 =?utf-8?B?aUVWTVpxWjNmRGlwVWJGWElqVWx1NEZIYlk3SVN3b0pOVnViMVIyRnRZTng2?=
 =?utf-8?B?bkxHTUxjMXJFYmtrRlM5WXJzeEUzanVDbC9LcGFFalZRK1F6SitxUTRrdVo0?=
 =?utf-8?B?T21oMUovZjhFT1l4d0RlSmhIeWcxVUNsdkF6aHloOW9IWWRWTFJhRFA4WXh2?=
 =?utf-8?B?S3U0cE5PUlBoQ1NuTTJzakgwekpxVkExRGROanl5VTZ2TzB5SUFjTk8xODBJ?=
 =?utf-8?B?ZUQ2RVlUWmc4SE50dThrR0xUSE1Ob2pBcFY2b1NEVXRLVzVyWUpGUmU1Q1I2?=
 =?utf-8?B?R2pVTXF1V2U0WnFjeDcvYnRIa3JQZDVNSUFLSEVWQVo2QzJBVUpZdENIQzVV?=
 =?utf-8?B?QjIzVzkrV3E2UC9WNmkzTlc0dkhwb0RSd0lGUmZyUHZsQzZQbGRKV3g3Mm9p?=
 =?utf-8?B?THllU3NBOHk2NytMZWkyelU3VlQxRTN0em9tKzdsSDErcmpUaC9TMURXamVl?=
 =?utf-8?B?SHpPakh4VVhsOGdua3UxWTE4Y1RNV2Z3YWNvcnJRaHpQYWxnYXFGOEVHYi90?=
 =?utf-8?B?bzBEaWRpRHM3M3J6aXJsdGlyVTR2MXFYNHVaV25TbDFjQy9zbzRJSmZ1SllV?=
 =?utf-8?B?clZtWUNxOTVuWnRoYXNzU29kTVlXY0dSREI5c1A4NlFRaEFWdGtOeDNwbDky?=
 =?utf-8?B?Y201N2d5bXFZbVd1SVRSSUpxVXVBODhFb3lhNTlOSWdaaVN0cllGY1RDQmZw?=
 =?utf-8?B?WVJzTkZmY0hEYnBqYVNPSFJzNnBMZU1ncUZZdEk1NDZYaHU0T00wazdVK0N6?=
 =?utf-8?B?ZEVJaVl2MFRNeTZqQXZuRXptLzdscVNVQVBqdlp6MEVQakhzUXdJdHZpMWx2?=
 =?utf-8?B?RW1ITnBHZUlvRElRRFhoTEVpRm9HWkxxQzZNZnY0WTJwbHltK28wSlVZV0or?=
 =?utf-8?B?cmtzb2QxSStibnY3aVB6MGF3MzdKdGYzeWwvZWd1TTRnQmtoL2ZTS1NOTFRZ?=
 =?utf-8?B?VCt0dVY0S3VQSHBCSDZ4V3YyakJwRElBVnd6Z2ZIWDgzUzFqbk1nalRsMWV3?=
 =?utf-8?B?NnJrcGJWWHYvcmE3NE90ZzVZMU9pT2Z4RENGNk1RbGNVTnQ2MloyRzJTRndM?=
 =?utf-8?B?WDVEWkJhaTRGanNVTkxHZFA5eWlvQ2k2RnFGQm5YbEtqL2tHRVJjYnNEQ0po?=
 =?utf-8?B?OHk4Qm1aL3RqcXhuZnk4cTQvUDFXK1krdE9RMUkxN2Y1UG9lSTc2RmZMazlL?=
 =?utf-8?B?QWY0N2JEVE1BSi9Yd3FhNTBpdHppU2pCVmcyWThoc0FWVnlLNnpnNGRmdS9Y?=
 =?utf-8?B?VlJkL3d5SFhpM25OSFAyVXo5M2RZZG9WRUFyNXFaZ01DRS9TMXNYQ1RTWXJZ?=
 =?utf-8?B?dWtiS0w1WENDdU5xR1AvYkVPZldOWWxxdHFZZUREU1IrU3hOWFVNZmh5OHlh?=
 =?utf-8?B?YnFmUWdIVVFpSHRuVXlRdkp4L2xqU05pdmZrN3NHT3hob0pjUXlhZlhDakd2?=
 =?utf-8?B?ekpOcllJbVhNcUVIVDlDK0JuTVlMWUtyTENydW1Wdk00Uk0vQXhMWGVLaHhw?=
 =?utf-8?B?Q1hmRVprb3B1bWI5SzhScnA0RmdnSTJTYVdudFBLcXJnZW9SL0EwZzVxcjRh?=
 =?utf-8?B?SG5iTHZKOFJ5ZlUzU3FNbHVLSE5zL2xKUmc5Skp0VVk1a3M3d0JlYkJmU3hn?=
 =?utf-8?B?dEJMUTRqY205Nk9xeDVydkF6SkdVQUx1K3F0VXpHdFc0dUhkRDd6aCs5TTJM?=
 =?utf-8?B?OVNZT1NXR1U5bFRuZGZLU1RVQ2kxR1djOGMxeExDWE50OUVVZ3MxS3pHa2pY?=
 =?utf-8?B?ZWx1aENWUjNnUFNlclhBcGVjYUxFaGRNM2RldEFLWDhacDc0N1ArbjRpbFFE?=
 =?utf-8?B?RC9KNmovVVpmR2ttL1JrR2dCSEtsL2ZLUFRQYmZ1aDZVMWtmdnRjNTV0bVIx?=
 =?utf-8?B?NVA0ZzhaZFd3VGhJWHYyNnhmRFZUNXFJTWJnMlgyOFFzMXFqN1ZidzNZcFh2?=
 =?utf-8?B?N0pxcnR4ZWtHOUpLZDFIMEZ0QndBbW1JS05CbWJXQkRRK2grckZyT3ltcGhj?=
 =?utf-8?B?MENoQk5WcGVBczZsTFB5dElobytpVndtWTVBc1N0VTlrNUVDcTllZFBPOVFD?=
 =?utf-8?B?TDVrYkFrTEN6cGJMdEJiaHZGeHFscWhGczJ2N1Z5bDZRZmtLd3dZVndQbysv?=
 =?utf-8?B?bVJKVS82OHZ4d2ZySnI5cTYwQmhkK3FmZk01dTVlQ3ptS3dLT2RTeU14L1RT?=
 =?utf-8?B?cmNrVWpXSkliVXBSODV6RWVocTVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 21:16:01.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716bacaf-d323-46e6-a842-08de554473b4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8227

On 1/16/26 04:21, Dhruva Gole wrote:
> Add AM62L3 SoC to the dt-platdev blocklist to ensure proper handling
> of CPUFreq functionality. The AM62L3 will use its native TI CPUFreq
> driver implementation instead of the generic dt-platdev driver.
> 
> This follows the same pattern as other TI SoCs like AM62A7, AM62D2,
> and AM62P5 which have been previously added to this blocklist.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 1708179b2610bca6035d10f0f4766eee6f73912e..16310e190d9ff96af3d20cc5d98dc0e4af4d1bf1 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -193,6 +193,7 @@ static const struct of_device_id blocklist[] __initconst = {
>   	{ .compatible = "ti,am625", },
>   	{ .compatible = "ti,am62a7", },
>   	{ .compatible = "ti,am62d2", },
> +	{ .compatible = "ti,am62l3", },
>   	{ .compatible = "ti,am62p5", },
>   
>   	{ .compatible = "qcom,ipq5332", },
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>

