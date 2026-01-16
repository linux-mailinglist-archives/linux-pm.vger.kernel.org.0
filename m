Return-Path: <linux-pm+bounces-41041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB23D38833
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 22:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A85B13034425
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D733081B8;
	Fri, 16 Jan 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K3rNkX6N"
X-Original-To: linux-pm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144A29E114;
	Fri, 16 Jan 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598140; cv=fail; b=saTXDuGEk3v1Ru7u/FCtsomCS9m5GitO3X8xsB5JnViVmIucdQK8kVODpr7vNiYLPzLpV0qSLsu985o2it0GrKtuVViOuzMKnpKnoPSZubT4lFnFTO9uQe8WtpJFmSU2CPjHUGpOgoF6xb9B42vEqSAVPLdil3YUoEFbfZb+gG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598140; c=relaxed/simple;
	bh=KkCInvrs/qUW4+HPjq8JpdJoxn2dm+oBgTHVmQNaXM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kLWuz4qCEfXEdagUh4AXefETz7uuuko6Wt1cY4Q6kwZM3wa0h6YS5twp9ZdPaCxoMfoIqbY+aLYH4mjcSK348rFgF/n8ko/F2qQbh90go2G8z5m81FwV95m0CUlp4qPydV2aHHBRLuvTXsdt9+crh+IUGfx+/eVIp1h/GI08wbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K3rNkX6N; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUO3C5IPhtuNa/CV1sEHTajNzGcQNM7fumLI7DybVOF++Zhr4B6+ZcI8Z8+TO8fwquRh2vJokAmN2YrLrlUexcXwlLsAP+f64hWilM5M6yOhT92gdoOQ03U6t9660LeQuyBWb1R+0WId0PiGw5y6nY8TfDa1VYnihmv6LX9WbkyzFd7VV3qUOz2GWD4NyySyM+ich3QheSpTNqAIepnQGaX06YtBrUE2Dvm3izJ4NjZ/DMdlpiCT3JHP8YKNvvylkWfXMRzCGXaLNFpPwhJyzyk7wSc+K3pcHU9QQ2rSCXpGaCH7weK0A0Ng8DSJnHEJbBPBEnIWTtwGL4r8mQtSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/+bPhBWLiaHJJJmNh2is0OckobRJS4t3PTwnPUarj0=;
 b=CgUUB17qglodjI3vxMU58cB9MYNIt7Rlx2ckBpCyJ22EtNf4h/NDTx6vNlW1KVCxf5fgSB5/sfxjrz//HIyuZDI05m87fz2ZFX42VAyurYj9Suu1u09NPnKTBJQjnS6K7C72X7J+ILb6SRYCDxJPkV67BUT1Q01xV1Sbh0TGh6dcXKbqZOvpgZ42h7DWclZ0amzbWfB/UiSluTl2Fici1hDhL9GV/3U60lD80DutEYAqpXcGx7SmKgIrvI+GT5J3hidV6dgSdIDxNArW2fPlI675QDALi8MCXwW61VXWSbHWzPpnWkZ6Sk+lV4yn0kgDyFxqXEKDD4NptlTkfuQrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/+bPhBWLiaHJJJmNh2is0OckobRJS4t3PTwnPUarj0=;
 b=K3rNkX6NVSaniMdul2dHEeQ5uSPDl0jHN/woyWBhB9+qbBafxPXszDrUNUB4khjrtt2zDEOq7RA7ZZSM0nZ8S/OhuUFKR0XU/1nTfRlkMtauKJyA9/NZlJ6SpQyXNrq2R1RPJJJhRqyy8Wj0x8B5F4gC4Re1Q2bWxEJMVUt+2/Q=
Received: from BN9PR03CA0242.namprd03.prod.outlook.com (2603:10b6:408:ff::7)
 by LV8PR10MB7941.namprd10.prod.outlook.com (2603:10b6:408:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 21:15:32 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::64) by BN9PR03CA0242.outlook.office365.com
 (2603:10b6:408:ff::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 21:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 21:15:32 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 15:15:30 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 15:15:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 15:15:30 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GLFT5M3762869;
	Fri, 16 Jan 2026 15:15:30 -0600
Message-ID: <ba251d2d-9319-4a4b-9ccb-f7681869617b@ti.com>
Date: Fri, 16 Jan 2026 15:15:29 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cpufreq: ti-cpufreq: add support for AM62L3 SoC
To: Dhruva Gole <d-gole@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Sebin Francis <sebin.francis@ti.com>, Bryan Brattlof <bb@ti.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20260116-am62l-cpufreq-v2-0-eac7e2e78d29@ti.com>
 <20260116-am62l-cpufreq-v2-2-eac7e2e78d29@ti.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20260116-am62l-cpufreq-v2-2-eac7e2e78d29@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|LV8PR10MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fc0c3b-6b00-47d2-f754-08de55446203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|34020700016|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTJuODRva0NkcE5wcHh1VS9lWTVmaVNXZmhadis1akhSa0oxdFJmditLb2kz?=
 =?utf-8?B?YS9jWklybW8zWEx6QVYwdE15VDBsRlhkUTIvUDRCai9LRDI2SlBSTHRGRFdU?=
 =?utf-8?B?azRnT2krbStBQkQzb0Qzd3lsVWhaMkhWS2hxK2NhcW84c284RW9yeVIvUHoy?=
 =?utf-8?B?TktyZVBVQ1FhVGJxc0J5UjZrYTN6WXh0YUR5TG9vOUhUcHJzczYveGJFRDc1?=
 =?utf-8?B?WUNpamkzVEhKN2srR1M5NGpaaWowdm1IR3dLL0dmWVhQNkxObVZGRTlwSWNk?=
 =?utf-8?B?cjZpVnV6b1dKNmJUSXRGQmIycjZNNFpvdlFjWCtYS1RDV1FiV3FxQ1RpM0RX?=
 =?utf-8?B?eTIvenRNdGpGS1puNk9ZWE16K3Rkb1kvQzBXc1p0dHR2WEI5bEtwdWRyMnhn?=
 =?utf-8?B?VGtNdlBKNUZucmQwaHZYdDArS0tuek85aEhTWEd0UmRrU3BIMDFseDkrRm5E?=
 =?utf-8?B?dGtVeHN5WXBvU3dUU3hsVHduTTdiSlFSZGVoUUkraEp1eU1lQ0hSU0tsRXlM?=
 =?utf-8?B?Z0ZLalZ1SzZuNDM1NGwxK0Y3Mm04MUZhNDlMMEJGM3ZuWEFIczlsWWl6WXlj?=
 =?utf-8?B?ZWhNYjBFbXBHODBWL1JBKzU0dTVPZndqaTZZd3U2Vi9GMTErcVNOZExuVDk2?=
 =?utf-8?B?SWVsRDdEODFxSk1oYjFBRmlkL2tOd0kxOS9qaDBnZmVkTUdJamFybnN4RnMx?=
 =?utf-8?B?MXQweWtTRHN1cEpwNzZNYmtIcVgrSUNYbEp5U0Qza2pCWE5QbWFUT3Z4MHhZ?=
 =?utf-8?B?c1dDVnJvSExZRnJrM2NPS1RHWTZNelVzSHdpQk5RSGdHdzdvbnRVMWpHSXo0?=
 =?utf-8?B?V3YvKzlzWExMSE9mamcwaHg3TENIdEdhQ2NTTlNTVFNORHdNeFlhYnRpMTZ3?=
 =?utf-8?B?Wk5pVlp2ZzhPdWg2L0piaUdGaC8va0U1ZFQ0SG1kcWlhWUhia2RKRzQvN0s4?=
 =?utf-8?B?NkdmMEVDbTdTekdwMXR6dE9JaWtJeUxaT0hzQTJaVDVlYllQZlZmQWhXRnZn?=
 =?utf-8?B?cFlWRytDVmpWZ0Q1MkFGL3VORWtaOHVBTDhWckp0eC9DdTd5YVA1YjlmWmEv?=
 =?utf-8?B?ek5HeGpXbmRoN3YwMTJIT3NyYjBSM0tvL1VwaWxvQzJLOVhScnljMVMzTlhB?=
 =?utf-8?B?UnUwOFA0V3hVdy9kVzVKTjBaR2ZNclk1MlhveGJwMUdRZjN1NlIxNVJTSVZk?=
 =?utf-8?B?SlN0Q1NYMnhleTU0K1E3UEVUZzdoaTRWekxsaWdNQlB3REpLemdyZ2p3Tmkv?=
 =?utf-8?B?S0xUVVNkQXNOL2JTWUZ3WnUzK2k5enh3QzkvWHRnZzlvNzFDRzhiaS96TmZo?=
 =?utf-8?B?Z2cwa05xYy85K3MxLzJvRG9xVTFhM2Nxb2syc1ppYWhpSnVDLytGUi9rSXlP?=
 =?utf-8?B?VTJKNHhQQlM0UytvbE9ld0luV2phNlRscVUrYUczOGorcmdIOUlJM0dmMm9Y?=
 =?utf-8?B?MS9FZ1VVL3NsUmZLaG1CYjYvZzJhR3F2UVRXRDJtSWJnemNhc0cvM2JSSTla?=
 =?utf-8?B?Qkp2THpINzlBYzlYbW51UmpDWVdEeWpvd1Q0QUZlb1ZoRE92TXZJK050Y3Vw?=
 =?utf-8?B?S3Z1M0tBZVI5M3FHT002ajBmR2ZVckwyMFlRYTVrTHlsUldCYnE2ZkVPc3Ns?=
 =?utf-8?B?VmlubGsxUGc5cm15MzNHb3hmOEY3MVRkejJ6UHRoNWt5S1pIY2pGclFZMnU4?=
 =?utf-8?B?MWFHLzFGdlg3R2ZDQTZXcVBsWmhZSFY1czRmLzkyUW1tdlowVVdGT3oyTU1j?=
 =?utf-8?B?WkVHSG5XcWJKVWRGNW5zQ2JlVnR1dWZvL2V0S1dMV1ZVNkc5ZXZFVWp1ODZk?=
 =?utf-8?B?RVJSRFJ1ZlRPQkdmdm9TRFJNQ1E0clc3Z0JVOWZDOEVYMlo0elJIMlIrK28y?=
 =?utf-8?B?K21BNnI2dUFzMjhQTmlSRWRtNENFdUM3MGJ6K1gwOE9wS2hWcGh4VW1BN1VC?=
 =?utf-8?B?SnE2cnhTbGhkZWpyMk1YUEprdFlmOUUxSzJiVFVOMG9JL0pJK2NmazNCdVhu?=
 =?utf-8?B?M1dweHh3UXRpckh0STJPc09sSzBJTU5SVFAyT0hiVVc1RkloRGdBM1VMSHhS?=
 =?utf-8?B?R3Z4VStkMzc1cnBQcGVMV3VyTjI5WlM5WmtyNTBSUVNZNVZTU2RpZXlaRTJm?=
 =?utf-8?B?YWhSWS9OMmtjeXFLY0RvWEowWFFaZ293M3E2MXZVVkpLZFVhR0phdzdVM0wx?=
 =?utf-8?B?dlE4Q2VwZitZbjJCc1pEeVZjcFFvckxudnFmM3R0YXJvbFhBZ24rYTVCdmd2?=
 =?utf-8?B?c0ZJWkVBdHZMWGlPMisvRzFBaGZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(34020700016)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 21:15:32.2607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fc0c3b-6b00-47d2-f754-08de55446203
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7941

On 1/16/26 04:21, Dhruva Gole wrote:
> Add CPUFreq support for the AM62L3 SoC with the appropriate
> AM62L3 speed grade constants according to the datasheet [1].
> 
> This follows the same architecture-specific implementation pattern
> as other TI SoCs in the AM6x family.
> 
> While at it, also sort instances where the SOC family names
> were not sorted alphabetically.
> 
> [1] https://www.ti.com/lit/pdf/SPRSPA1
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/cpufreq/ti-cpufreq.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 6ee76f5fe9c567b0b88797ddb51764a2a5606b16..4e65e96b784ee908716c63316bb54eb1ac1efc49 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -48,6 +48,12 @@
>   #define AM625_SUPPORT_S_MPU_OPP			BIT(1)
>   #define AM625_SUPPORT_T_MPU_OPP			BIT(2)
>   
> +#define AM62L3_EFUSE_E_MPU_OPP			5
> +#define AM62L3_EFUSE_O_MPU_OPP			15
> +
> +#define AM62L3_SUPPORT_E_MPU_OPP		BIT(0)
> +#define AM62L3_SUPPORT_O_MPU_OPP		BIT(1)
> +

Shouldn't these defines for AM62L be placed after the AM62A defines to 
maintain alphabetical order?

>   enum {
>   	AM62A7_EFUSE_M_MPU_OPP =		13,
>   	AM62A7_EFUSE_N_MPU_OPP,
> @@ -213,6 +219,22 @@ static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
>   	return calculated_efuse;
>   }
>   
> +static unsigned long am62l3_efuse_xlate(struct ti_cpufreq_data *opp_data,
> +				       unsigned long efuse)
> +{
> +	unsigned long calculated_efuse = AM62L3_SUPPORT_E_MPU_OPP;
> +
> +	switch (efuse) {
> +	case AM62L3_EFUSE_O_MPU_OPP:
> +		calculated_efuse |= AM62L3_SUPPORT_O_MPU_OPP;
> +		fallthrough;
> +	case AM62L3_EFUSE_E_MPU_OPP:
> +		calculated_efuse |= AM62L3_SUPPORT_E_MPU_OPP;
> +	}
> +
> +	return calculated_efuse;
> +}
> +
>   static struct ti_cpufreq_soc_data am3x_soc_data = {
>   	.efuse_xlate = amx3_efuse_xlate,
>   	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
> @@ -313,8 +335,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
>   static const struct soc_device_attribute k3_cpufreq_soc[] = {
>   	{ .family = "AM62X", },
>   	{ .family = "AM62AX", },
> -	{ .family = "AM62PX", },
>   	{ .family = "AM62DX", },
> +	{ .family = "AM62LX", },
> +	{ .family = "AM62PX", },
>   	{ /* sentinel */ }
>   };
>   
> @@ -327,6 +350,14 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
>   	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
>   };
>   
> +static struct ti_cpufreq_soc_data am62l3_soc_data = {
> +	.efuse_xlate = am62l3_efuse_xlate,
> +	.efuse_offset = 0x0,
> +	.efuse_mask = 0x07c0,
> +	.efuse_shift = 0x6,
> +	.multi_regulator = false,
> +};
> +

Same thing here with the AM62L struct being before the AM62A struct 
which is not alphabetical.

>   static struct ti_cpufreq_soc_data am62a7_soc_data = {
>   	.efuse_xlate = am62a7_efuse_xlate,
>   	.efuse_offset = 0x0,
> @@ -463,6 +494,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
>   	{ .compatible = "ti,am625", .data = &am625_soc_data, },
>   	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
>   	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
> +	{ .compatible = "ti,am62l3", .data = &am62l3_soc_data, },
>   	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
>   	/* legacy */
>   	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
> 

Best,
Kendall Willis <k-willis@ti.com>


