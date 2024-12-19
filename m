Return-Path: <linux-pm+bounces-19527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B649F7D84
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 16:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1256016C1AE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0848A762EF;
	Thu, 19 Dec 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZD4c6JQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578841C64;
	Thu, 19 Dec 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620481; cv=fail; b=NcahQrpIgImA8xaNmoQrOmRescUH9zlil9XN+dh2asfEBaSOY7qCIj08+7QwGwmfuq7J2fvjiIJrUyBcqzHImwaNo8jg6xg+ZF4ZdjULXTR3YG5pllP5eQx2GEBbeJBR1JOqMpZA21XfIvBBqE/VbDl92KTuI2EV18ITzmOa9/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620481; c=relaxed/simple;
	bh=NRht340q/OBH98VgXsczgmRpmrrl/CueXHL9fdPHfdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HET+C0S5ZWYzSRpbktD6wMRwjlV+b1Rx1HjFYZScF0kRQrXa6zrRQal+3yxiJdeUEd0nptBU/Cn4xMu8+bCy0Jo07YNKDyaQEHH1hqljhKOFzHdgU602uTyUKvpkox56meoRMX/d/aBmIpeygdht3o/C2CX7RdLl3RtI/NFeiTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZD4c6JQh; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHqTtG9UqxW1GNqq+j/8K+dL30omfxGDm1tpjC1X2+7fYpGPfs3BgUzbaidSIql2G/DdbarLLXTpLGueWeSRNLAMFCJ8mv15p/mW/yCp+py6x+BLB8WFJKFTl2Vflz8x72H+7tU4fud/7AAmqSrYh16da0l52j4hHIyQwl1ryYVDW5aJlLETXEZ92MmCXp/yU+XpK+uhpwp7HmDQZ2NM8H92UwkzTlwPV3OkReIo532lcOuC74U0l3J6ot5//HjQcI5YQcYyBcaYefu4eqTKtdR5RfaYmX9vZNOQZCSbyAOq5cqDhkkMdwDMaLjCXAbLAT/hCThC4R4WHuD9+wIxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWcK5n41X7QVG7E/B8w1tjwNaflyjcJCnpdiMbp1IR4=;
 b=s91QyT52BD2zKcfmzX45SKHoEqsT+AFjkmEDioadi8RTqgg0/WpTYjLNkOZuXHsDESyebKV0J20q3MsjmmzJIzTcLoJ9GHx2lboT+oUYX02fMlFSe2roeyBOANqpddgLIhVBIvJ2zGx0BBpZkzr2BjdtYo3KXdD9YlDr3+RQj70kygO2o2Mspd05tjB+dDnXW0foqwg322Clepg9RiA41O8KXRE55OMYoSraNiHyr3B5zBGPGVr0cupjR33UFibcCjEUVu27mIS8sN+4k1eMhvk5JeFs4zYSnzJMVuF3jEZjg2oCLif5rqQyKX4nB5FNcN97ThOnwMjNyd15lhhwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWcK5n41X7QVG7E/B8w1tjwNaflyjcJCnpdiMbp1IR4=;
 b=ZD4c6JQhytxfUc7o+8UGXE3GULQQx1iV1O18WcS2w8SdYCVj4wudkw/YctLoOp4aHtKIg1UPX+5NkUABke2VFu0ksGOkhmFkJ7CeO7/TTyxY1dGYYxzZSg6pDHZv6hOeeS+uz5vl4ZXjDLbiu2qSltvPPU5g7XKuWeA/B2aN0HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 15:01:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:01:15 +0000
Message-ID: <f919e9d0-c466-4e4b-b32c-3713f6468987@amd.com>
Date: Thu, 19 Dec 2024 09:01:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Refactor max frequency calculation
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241218190030.1228868-1-naresh.solanki@9elements.com>
 <b1210cbf-22c8-48f1-ad50-d81395abc8f3@amd.com>
 <CABqG17h_b+_c2oBPyKWjUjHUVe0Nis+PyvgfvzAMdA1Dcd=rMA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CABqG17h_b+_c2oBPyKWjUjHUVe0Nis+PyvgfvzAMdA1Dcd=rMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e9b844-04c6-4de5-b321-08dd203dfc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTZNbStKZ3RXaVc4QnJHYnpPVmtoNEVZWmwzeXVIWXVMYTBlY21qM0NSOEpl?=
 =?utf-8?B?b1lpMS9ldGRiNGVTM2lkNG5OdjFtZFlrek1Ha0p4bHhEUWZCK1BjM1I4TnA4?=
 =?utf-8?B?dncvaTZYL3huVVBhdlZrdXhnOU85WkRuYS9kU1c2dHUyT0lVOWpNQTZDSkNn?=
 =?utf-8?B?M2pSRnhLbmJTN2xCL3lnTUVxS0dONlBMcUlrM1lsckgxZDN4THpMQkdKVG0x?=
 =?utf-8?B?M0FOUGtPU2owcVIyUGR6UHRGdTdlNEsxSHNVSEwxZWFXa2ZuYmhwcCtFSHk0?=
 =?utf-8?B?SlJpMU4zcnRqYzNYcG8zdlpldVFaUUsycUtBaUNPZzlRcEtZZWp6b2hRMDR3?=
 =?utf-8?B?cERBaGRsL3BqWnFleEpLU1RwdmpWOVlEK1g2TWVlcTRWSXNlZHR1LzZXNkw1?=
 =?utf-8?B?WkZDb05KaS9IeURmOXozb1NXOXdIM21od2toZ05JQnIwVGZEdXl6VzN0bmNH?=
 =?utf-8?B?M3BUOGxqRE14QndVTzJsVmovaWVQK2kzdmVKSXN5alpxaEk1NmgyZVV2OGdz?=
 =?utf-8?B?YkVuOXZROWxTZlBvVWN3Tzd0NXZ4Q3dlaWxxSWRQTmE0VHdBdEljWUlFcWZu?=
 =?utf-8?B?eUttaG4vaTZyaEZwU2dEMzNDMWRvUTlmd01YQXkrNmx6TGpXSWJNYitWQkRT?=
 =?utf-8?B?LzRRTXBETW1Ub0FJZU85djk4U3FxSzY3UURreDY3bnpxZkluVmtpSHI4aDdD?=
 =?utf-8?B?dG9XLzM3YURTdHNpUGVCelhHYTRJbWlKeVQrZmZtMjA4Z1RkemlKY0k2Vkp1?=
 =?utf-8?B?V1FhamY1M1V3Mi9tVHB0UjNVcm9FMVhWZW53OXZJYk5vYjFTcWZucUlGN2p3?=
 =?utf-8?B?UUdZc3p3dEt0QWFzQ2NmYmNnM2hIWFI0bE9Ja0NXbFV6RWNEOXBrUWczRE1o?=
 =?utf-8?B?NHlmWURKV3JTMVFwQW5rWGtBNXlLcmsreldBSFdGWE56cVFnQzJLZHZGY2dh?=
 =?utf-8?B?NDFtWDc4dnFQdnQxTlZscHZGc2RSbXFlUHpIRzQwbVJMZGgxbDJHd1Y4RzdC?=
 =?utf-8?B?di9POGs1WlFwM01qU2d4T1dpWE84Y0hVYkFjb3I2SnJ2ajdoMVNGUW80ODlm?=
 =?utf-8?B?TUNNRXMwTUt5RWdOanZRaWwrMk5lQ3RIWmVQZVFiY2NYS0VvWXlRb1cvMHNL?=
 =?utf-8?B?MWRNdDhLcTB3UVJZTGlTeWhvcnl2bUI1QXFJR29HWGJuakdlRHhnbERRZzFO?=
 =?utf-8?B?ZW5HaGRVRWd5R1BDVmMxaXp5T1IrSzBKc3BBcjQyZjBYQVdRRDRZQzNuYnNB?=
 =?utf-8?B?UzV3M3l1VWVvZ0t5Q1FjVk5XcGtFMEx6LzRRbDI5d0pZY3BFcjc1cnpYYTQy?=
 =?utf-8?B?ODY5SXY2b3E3aHR1NWh5eTViYlFQdUtHU08yOEdjWkd1N0dNenBuOUNQYXFG?=
 =?utf-8?B?OGZzaFdEd1l4Y2tLUVZ3YWZQODRNTy9oUE5DZHZici9xOWZtTng2T1dLWEdj?=
 =?utf-8?B?WE1NbCt1akFIVEtOd003cDNHNVFkUkdRWjZSd0JwUURXd1J6THd5dkF0OWJ1?=
 =?utf-8?B?TlkvR1BxakNTUko2YS9VSkFZaHU5VC9Ka1RxckR4b1RnQkV1b3VwU0pBYnIv?=
 =?utf-8?B?YjR1ZnhYNmVTT3JvNklpMWdGUFBaSHBNU2ROM0xpdjVhNlJyMjB0ejNtUFZ0?=
 =?utf-8?B?ZWJFTmFsRy9DVU9aQWc5dXptZFlDNk1zZkdMVnRJTEsrS0w5MThiWGxsRVZz?=
 =?utf-8?B?UlRaRHVjdTZIVmJzdHVWdGtZY2Ztd1M3TDg3QThOQ2NMaTJpRExrYzRZM0h4?=
 =?utf-8?B?a2p5WUJkNW91ZVNSUnNrNXp5Qlp3V3hRanRkdTdhQ0E5eTFBUjBucVBFYWVJ?=
 =?utf-8?B?S1BpaVdGM0xEQk9qRGRmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXUvdDFiWUY2bTlKZE4rZUM5L2hJbFdDam1NbCtEd3N3TDNOTDh2dGVQT1dP?=
 =?utf-8?B?RlF2NmNFTTNicXczY1J2cUlSNzcybjJxcUlCdGhjajczOUlPclNpM3JybGZD?=
 =?utf-8?B?d3dyQ1pLdGN4UmpQQlFkcU5QdWRPaHNPTVhrK1FWbFp0VTJiUnlYYklYaXdH?=
 =?utf-8?B?NUtLTlloQTlENTN6dGMxMXdXR2RFZFEzUVc0QTBUZzZ3R2xWdzd0S0JKM1Ri?=
 =?utf-8?B?Zmc0bDBCQjlCWVRTWHQxV3ArWHVFVU9KcXNZQUVSWGw1RCtjS3ZkN3pVbU1y?=
 =?utf-8?B?OVlld0xOVFdXdDNyYnluUGdYalA4NUwrTHV4bkNCbU1DLy9Ob29nbUVkWHRL?=
 =?utf-8?B?NnRPTU5xVi9lTkFmRHF1RDVBU2w4K29qZEZYWnltZWF4VkRtdGJMOXVnc01F?=
 =?utf-8?B?bzAxQ3d3ZVU1d2pZcy94VGVhN1JJcnpLYWl0TEZjc3lRaktQbFluK1FUMktx?=
 =?utf-8?B?eXh5TDdQVDhJaFkrVEt5RTNoUTVZZ3pibHpyOWQ5eWtad3pQTStBV3djSFdn?=
 =?utf-8?B?TGtFSmM4SGhqN00zSnQwcmphS3VmMXllaEtjN3YxL3dnOWl5ZGdhZCtpcktE?=
 =?utf-8?B?M1loVlNOWmo4ajB6OXd6VU1jZXNKU1NnMDZKOHpmUFU0RFdYdXFMRzRmckpq?=
 =?utf-8?B?d21wY1JQTExvR0h0WkVLdkJ4cWVYenVWaWpIeGVzL2F6Z2pzR241MkR3MGMw?=
 =?utf-8?B?UmxlTjM3MG40VFZXbTNHZDJFeFFLUzhKU3FhU2NUbTN5VWlpeWx6Q2R0RE9O?=
 =?utf-8?B?Q21ISTNZTFV4by92SHJmSVlHbW14TldWYlloOWNmV0x2d0o1UmZTSkhUT2Vr?=
 =?utf-8?B?dU94N2FsVitiM09JcHFnWUVUbTRST1BKUDdySkllaUFEYTBKbzArTDdRMUk1?=
 =?utf-8?B?c1VSaFBCY0did2VmWlNsL25kWkY0OUhkajM1Y2RraldLRzhPaVVTTkhNbUxz?=
 =?utf-8?B?WmczSnovSC9mWTgvTURTSFNZVys5dUQvNTR2MXFESmFITHJCU0FTNVNOOGF1?=
 =?utf-8?B?aUl3QWJ0ZEdoejR3d2pPSnFPQkh1YmFrZHUwRGJvdnFLL3VJWXVZRnppaW5Z?=
 =?utf-8?B?OXBsSEZQUW16V2lFakFOZTRoTWZ2Z3BhUFhzZ1kwNHF3ZWNuWE5GVy96bUpF?=
 =?utf-8?B?VG9BcmpiNUZMcFB5d0lMSTdNVjk5WTRPM2RaWGVIMFZGNlF1V3hNVFJIR2Jv?=
 =?utf-8?B?ZlhodUVlbldRWXdERk9KRlNiOGFyVzhGaWJZdWg0Wk1wYkYySkFoUVh6c2pJ?=
 =?utf-8?B?Q1Y1b05xL2o0MWhib3Jldkx3eHdSdXBQZTdXQjRKckl4a2laR25CcmdzOU5B?=
 =?utf-8?B?dDBuVG9Sc1pzVVhjQnZQV25Uck9Zb2swbFJJanFUZWJ4eUxGV0NCUC9aWUtO?=
 =?utf-8?B?cVFnSWJlQ1lCRU5XNzc1TGxRSlBuUWZld3dVVlphMzRxUzZibDNXbTJIZVRs?=
 =?utf-8?B?cVo3RWFNNHlsanhPRVhjbGJBOXovRDVwUmNwQWxneUg1ZXp3Y2FNSGE0ME1u?=
 =?utf-8?B?ZDZtZDIwK2ZNcm9ObVNuYTFCYTBQaVAveDBENTlwQmZwQnUzZGhTbEpwQ2hm?=
 =?utf-8?B?VkkxeFQ3K2tQY0UvamNhQksxOEJHWGtMcG9jS3RkK3k2K242dlIyT1NBUk5K?=
 =?utf-8?B?ZDk1OFVDYzdBaEZJRDFwWjZDaStLNFBBa1Z1TXBnVkpOZ1NYNC9zNUJETStK?=
 =?utf-8?B?Qkt6R0l2YWZ4amVaR0NYc3VLNUxmZlgvN0pXcVZDSzFPR0p5UFZjbkZwVVBv?=
 =?utf-8?B?dmlabFJqY01OK3JwNStQTDZ0U21OQUpUMkV0bWt1KzRPUmVpaVJLYkhDT0hB?=
 =?utf-8?B?bkNXcUZGYzB6dHBoWDRWdGkzSXhlRHlEZzhDM3A3VjV3cTZtVTVUVmo5YkJ3?=
 =?utf-8?B?TVVzbEpuMS9nd2diakxVL0dHeTZNRjhiNFA3MzFXWGVJbnArUjJjNEI0RFVl?=
 =?utf-8?B?Wm1IWEsxVFR2eFVFVk90VEtRNlFhbWNSSS9YSlVnNXhyalVBbStVUUxxVzlz?=
 =?utf-8?B?NFJRSVVjY2pSdDNNSEY0a3dFbEc3VEtiZW83cHJwa3RqczAzMFFJNDl0STZL?=
 =?utf-8?B?b05iQXZOUjRJOW1nTVlLZ0Y0aGp0OTJhckhhTEd0SFpsK3BDUndUMHJSR2pw?=
 =?utf-8?Q?QhlDQDhSAojt8BvqdaguO+Dw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e9b844-04c6-4de5-b321-08dd203dfc44
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:01:15.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqNox6ZCc+ElHjnYf5Zb3Q6n6lrqslTzT4DQCRiuzTe4pymqqVDhPrxCLFRl0a4ASlR3syNCGhL1Qib+8ymKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

On 12/19/2024 03:21, Naresh Solanki wrote:
> Hi ,
> 
> On Thu, 19 Dec 2024 at 00:50, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 12/18/2024 13:00, Naresh Solanki wrote:
>>> Refactor to calculate max-freq more accurately.
>>
>> Can you add some more detail about what you're finding?
>> What was it before, what is it now, why is it more accurate?
> Sure.
> The previous approach had some roundoff error due to division compute
> when calculating boost ratio.
> Which intern affected max-freq calculation resulting in reporting lower value
> In my Glinda SoC board,
> See below calculations with below values:
> max_perf = 208
> nominal_perf = 100
> normal_freq = 2600
> 
> How linux kernel calculates:
> freq = ( (max_perf * 1024 / nominal_perf) * normal_freq) / 1024
> freq = 5405 // Integer arithmatic.
> 
> With the changes
> freq = (max_perf * normal_freq) / nominal_perf
> freq = 5408
> 
> 

Ah, thanks!  Please include some of this info in the commit message for 
the next version.

> 
>>
>>>
>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>> ---
>>>    drivers/cpufreq/amd-pstate.c | 5 ++---
>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index d7630bab2516..78a2cbd14952 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -892,7 +892,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>        u64 numerator;
>>>        u32 nominal_perf, nominal_freq;
>>>        u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>>> -     u32 boost_ratio, lowest_nonlinear_ratio;
>>> +     u32 lowest_nonlinear_ratio;
>>>        struct cppc_perf_caps cppc_perf;
>>>
>>>        ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>> @@ -914,8 +914,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>>        ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
>>>        if (ret)
>>>                return ret;
>>> -     boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
>>> -     max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
>>> +     max_freq = div_u64(numerator * nominal_freq * 1000, nominal_perf);
>>
>> This doesn't apply currently, because of some changes in the
>> superm1.git/linux-next branch; specifically:
>>
>> https://git.kernel.org/superm1/c/68cb0e77b6439
>>
>> I haven't sent this out to linux-pm yet so it could be in linux-next,
>> but will be doing that soon.  So can you please rebase on that branch if
>> this change still makes sense?
> Sure. Will do
> 

Thanks!

> Regards,
> Naresh Solanki
>>
>>>
>>>        lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>>>        lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>>


