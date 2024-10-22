Return-Path: <linux-pm+bounces-16221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17F9AA2B6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A671C20809
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3B19D080;
	Tue, 22 Oct 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ro6dNm2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC2194ADB;
	Tue, 22 Oct 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602241; cv=fail; b=jXcm/IcHD/CsXeT+hkeI8rpUPPrK67i/8hUQ2ATL2B2CeypVQwCvcx0Nvm3GJ0NsbyI4ROu0tr+sGck/vM/93l2tAReHNWOTDsGsLXHvur1c9DeNzj1F708ZfixQgONreZbvtWwMjfCBOZch2htzuTP13GFd6opI60jSUJWWr1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602241; c=relaxed/simple;
	bh=91AhtWXR7rEWINF0jsup5XKP1rq6m+lBEokl/b6LEVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mezHzqHxhI7FBfzI261vhBneLb63jvvgi3kmqgRsFPcERJ2Q/1TnbTWhptHrFLExorD5FhN3dR8TlXU6sJ4mDNjip1c9BvHIzPkkMtix5UjWGOvgnA4S1h71AKcUEopF6oSZ12s+N26TvXLRqJXT8U8mKqRUHeHLdiUwD9v+e6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ro6dNm2t; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQdSmfX+8KIijm4tFavAkQFdpnmvqDCxYWBsv5FsWGqsXmtL0PKtmIEdFKW7aAFU1318VBRo3G+iN4N0LKnRCA++WIfGNDyQ5+djfsi2SpG0e6DAoHOpTdin65d7ACghadGN4HOt0dIg57QsdoYnF8w6FEK69d8TB5JpHSOsNQzKg13NZVAD0n8gw3Ochmzdz1hF1mKCxUNW6/weSC+i1OIITiozhkpjxpcsjF28u+HWBb0oiX46mh0XAQECgzD0yTrtakUGuldJY/lO8+DJP+dNjngDl22Sjvj1QIJKtqhvKLO/s3azR7pfN+obSzFjtFTJfRD2oavNFjhArUPtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y3eNfOr2qqaQ6VwJfYMlEIJtMbM5naCTPkQhfFzUos=;
 b=D6Zm9PIDiSFiIt3qhHrSjcM45zTvVSIXtzO0xvt1dCGYhkDsZkEzIRBhS86wZUM7BgVeO3mphK5F/YXwpGBCHvM3IOlXGagA7IOCE8E+6aMtPamv0WTEmwaaUpvz3HzY/kcKd34rk3boa/gfrwCwNgCCIAsHXSudNvMjLGUi3UhO+OOZSyVHkioF5YnpbPMSDFfsR1S15EG/gbXWxRoTq8wGNN9zDmPPkdZYNxv4LSeHYLvqIqKEszlIaiGGA3YNs6R0LLyfynIjWLoNdcJfPtOCGwbE7Td9AfgUG6pbAGSMbOwF6i//A7FmBhw5P03pmvrp/gLEroJLFKWF1VJ1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y3eNfOr2qqaQ6VwJfYMlEIJtMbM5naCTPkQhfFzUos=;
 b=ro6dNm2t57DTRDmkmyPGsEElqzVkKHrBxB5R+0qgXS3RpZZb5rd7fGZFIrdAC/F0QxJNd4CGDYwoIz+cPC4soGuoQ4A+5YeFQ9fJ+wJ1ROai0108SVv7fPs2LXNWvNm42M3wO6vDABPD9BgShsM6Rz/BYMLPD8T2nl+cba8mymU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:03:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:03:57 +0000
Message-ID: <8ed47095-b0dd-4684-ace3-99737a0db4fa@amd.com>
Date: Tue, 22 Oct 2024 08:03:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] amd-pstate: Make amd-pstate the default driver on
 server platforms
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241021101836.9047-1-gautham.shenoy@amd.com>
 <d5d8783d-472d-4266-a0cd-e9eb7ba3cbac@amd.com>
 <Zxcz7RiUxhETNYNM@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zxcz7RiUxhETNYNM@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:806:23::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b20022-3706-47fb-7d9c-08dcf299fd60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDFCdVRHMEF1VWtteXlKa0MrSmt6aWpuTjl2NDdpM1VIejl3L0JsTW9Ub3Rn?=
 =?utf-8?B?MDNJVVpmTDlLLzcrd1FLTFNwOHlSaisyRVFPUlRiVG8xR2sxTXBnUzVURWFI?=
 =?utf-8?B?ZWhybzNSd3pkUlhlMERROEovbXBaSEQ2cVg3Q0pQaVZlZ00rZkpYcGhvL3BM?=
 =?utf-8?B?cE5Ia1VvWmtsMFZoQkV6QU4xdVFOdXkzd2tYYVFycGpnN3luY3RVcW9aeGlh?=
 =?utf-8?B?a0loYlFQUkZHdlZodGl0NEpON3E2MnZQekZpNkp6dDFzM2Z3QzJGUTJkMjlL?=
 =?utf-8?B?dklOK1FsdDZyRDl1VGFqam8yOTRWZW90cVNSMEJaNTV5UVpBM3JuSTVvRWVh?=
 =?utf-8?B?RFJwUmFLc0MyaU4xbSt2SUNOK2o1elFoS2RER0lhb0NvOEtVLytzUkQ5SmQy?=
 =?utf-8?B?NCtWeU92MUo3VHB3RGRoQW14TDhoN0hVWFJnOVA0SVlPUHNlYm1jQkVmYzho?=
 =?utf-8?B?ZFdyZWprMlcyYXF3di9iTU1SZ2N2VVdsN0gvNXA5NHZyaWtFWVlGK2RBTjE4?=
 =?utf-8?B?cSt4dk55SkV5QzFhUnlCS0phQ0RmcFZLZUtFazdhdTJwL1paMlZQRGhXNFZx?=
 =?utf-8?B?NTVMcW5Fc0JTOXlKOVJlUGQ5QTVFYU1hVzJoMVpMZXl4Vm45NWVHR0FRWjVR?=
 =?utf-8?B?ZlhPeG5OZG5nWk0rWWQ2V0JYUFh3cWw1TlNBek1QRURmZTNiMDRBTTVtTXgz?=
 =?utf-8?B?RXZ3RWlxK25HbnloR0Fra09udmFEWTlSNVR6aU9PaGFrNWxtSHVpTlArKytu?=
 =?utf-8?B?WnVWMjdQeEFIRXFMemlkUGZiSldlMXA4alQwWkxNbUpaejdSK3h0Zzd5U2RC?=
 =?utf-8?B?L1JHVmNxVVkxcVExa2pWRnR1c3lVR0VZSFVzTmlxc3BFaVJtNnlMaVlIb2cz?=
 =?utf-8?B?N2lrc1dxUXlqWVZZdFlhUDB5NTVoOWpSUXlmVytLc29RNUFTdjVEUlRYRnNL?=
 =?utf-8?B?blB1UzU0MzBaS25VOGhWU0RaTHM3YkQrelk2dVRFQk5ZU3dBeFkyemRpUTJE?=
 =?utf-8?B?eTZTRWFGSkxnckh0dnN4MVEzQm1vRERCY3FiQ2I3bXpkaFAxMjl2TW0ybytl?=
 =?utf-8?B?R3FrMU1pR2VsaDZhNVNBREZCSkNmdWFMcnJoWWd0bjVqdnpMMThFYkJMQ2FC?=
 =?utf-8?B?a2R1eno0blNFai84Nm16YWtTVUtHUk5jM1pWQy9KYW4vNUNWMlI4RkFGRFA3?=
 =?utf-8?B?aWV4VjFLQ3dvdDVmUnhuVFhrcE5kMld6cmJEWjlFZFpIMDdGaVBwSEhkSGxJ?=
 =?utf-8?B?eGoxaTNEbmg5ZTdtMFhWMkxlY2xlMm5FS3ZpZWZCdVZPK2pod3VlTnNvOEZ4?=
 =?utf-8?B?ZFFiYi9IaDJZcWRDQzlGZzlZcGtzQWxvYVNUaDZ5TmJLVG1sVWxrRmpRYzMy?=
 =?utf-8?B?WFJuMUZKdzhFSUNxbk10ZHJac0FzVWhqQ0M1dDVxQWs4c0dCMENyOWJnc2RI?=
 =?utf-8?B?dFh1SUNMVEZBRXRLNGZoQVNvbnZONTBBdWlQaXZxQ1NNM2JtWEVwejhTWkxL?=
 =?utf-8?B?S3FRenNTQWVhMEk4cUtvTTF5YXBTa21tNzRLNlVxU3p4UjRGV29wWTNhRU50?=
 =?utf-8?B?MmFxM3NzcmZoZDBwTzN5UXRkOGFCSjZjVkNFSk92cUYxcjNaN0dtM0lodUJ4?=
 =?utf-8?B?VmkvcDMybHc2VFpXeG5lV1pkM1BQTEtlZG9kd05oVHpVOUtlSUkyeXF4WGpl?=
 =?utf-8?B?b3c1ZTg3NkNRd3pJUXdKMm5VRjFzQ2tBUGlraitSS3QxcVV2bDZxZFZCaXBM?=
 =?utf-8?Q?o9mUXfzKXsDjAy8sqNVaUvTd0cpnRMKre+cNkvu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkhDYmpqRDdWcDVmOVkzYlUyUS9UUHR3WjNPVG1nNlMrK1MybzBIb3ZmTjcv?=
 =?utf-8?B?SzBYdGhWUzNpZDhOV2JjSWxiQ2FOZUpkTm1JWHRHemFhalVDQzFnYUtJRUlw?=
 =?utf-8?B?Sy9ZcTFDdFZCb2tXY0hLWEUwNzZJRWQzRWJNZWprSEx2bFJYMjdCUlUyTkdG?=
 =?utf-8?B?TmZGb0owcjJsVHdtV2p3Y281bUVDanIxcElWbTFxZEpFMUljNGlMeHRiaXlD?=
 =?utf-8?B?Z0RrdlpUWGNJTHY2NzYvRHpRTHZBSjViVkM4SjFlN0hIWSs0K0hHWi9uN1c5?=
 =?utf-8?B?WWRZa3BqRWVkc1J4R1Exa0hnNTNlMUFCNUUyc2oycmVacGVCMkRwajlPS1Zv?=
 =?utf-8?B?THhjZXJ2OVZoVEI3NlQyYnZYUUpFYXVPSElmRjlxTWtvejhTNkd0OTRkUHB5?=
 =?utf-8?B?R3ZsTWJRNHRuUHp5bGcwOVR5WDl2QnpZemRPTThkNUo1OU16clRLVXRwUHN4?=
 =?utf-8?B?Y21YekdRY2tmaHFGcXNPMm11TmRteXpWM0lOZGg1b1FJL1NHTHQzQ2tpMVYr?=
 =?utf-8?B?Tkp4dS90UkNjL1BERUFPWlRUb2ZQSThQZjMvN0s2ODN6SjROeHpjYzRZUVVw?=
 =?utf-8?B?M1pkZVhGbXNIUTU4UmY2UWpmbGNUQm9ncmlkak9sQzB0SzFDSGJOVURacnA2?=
 =?utf-8?B?VlpEVkxtQkEwek9vRFVTV1VUaGREaXNjT2J4ZG1YY2Y1RjRqYU10QjJjTkNR?=
 =?utf-8?B?R0JYTmVJWmFJNERzWitOUys3RThzaEpScWZKS1ZaR05aNVhhc3dTdzE0R2pO?=
 =?utf-8?B?bXVuQ1B6cmpyY3dzNTFzcWt0VDROTEcwNW5rdm54RnpWNVpmRUFHSzdFbnRt?=
 =?utf-8?B?bm9jaksraXJpOHB4eldNR3NucW9uWXhHcEtHZnZqUTZIUE9Da3FNbStVTHFu?=
 =?utf-8?B?SUZINU9HaElKTnpGN2lYY1BvdmQxTktsWGkxUjhaZUNjMGxDay9vU1NaK2l1?=
 =?utf-8?B?dDJRQVRiTXFCbHZNOVAyQ0NhUUIyeStRendIelkySStOcGFXYWlOQzR2UUxF?=
 =?utf-8?B?emRvRTZRTzF5bnNNT0ZhNmNaR2tlaGl5cDhhVG1OaEMvUjljc1JRS0daelRT?=
 =?utf-8?B?MXc3TFJmVytRSm1kMHA2YUU0VEJwLy95emJUbDVTQWRrMkx5QU83eURlSUVQ?=
 =?utf-8?B?K3ZKelpDUnRwVXMzVk04N3NjbDlHVXcrZEdtZmZaZHM3NkUvbnQwd05PY3pL?=
 =?utf-8?B?dTJVNWtPUHJ4RHJmL1VSTlBBRDMybDdZWjJ3Y1YzNXQza01pVWxjaU8vWGhD?=
 =?utf-8?B?U0dEOGpOM29TaEJQa3RBSlY1Z2VHeWJHdGc3YmdhMlh6UUtVeXdmaTJOeUVp?=
 =?utf-8?B?QnFldXFndmM5YnU3TlBPYzBFRGd1Nm5jNjZacnAwNC95REVUMk1XcGMvVUVD?=
 =?utf-8?B?UDU2UVFBQVZrWWtQdndxNkR3Nm1tSDJaOUxOak5pWjBFcmNwaWw4eXhYQ1Zl?=
 =?utf-8?B?SmxJRlhDa3lrbEFMbmJOVmp3WXlWY0w0U3FpQmMvQ2xDVVZWK2NXQ3FGbjNL?=
 =?utf-8?B?ejR2TjRoUmkzL0FiMm5hc1VrYkZhckdvZ2hsZGxUbVd5U0V5ME5VejdleUxs?=
 =?utf-8?B?NldBOVpCSG1NQk96L2Myb3liYWR2RDZMMXd6QzdwWVBIcm4wcStSNFNMQWJo?=
 =?utf-8?B?cjh4bXBxVzloOW5mZXFYbjlYTmU5SmE3U2pLektiUytqZTljc1BaallFMi9S?=
 =?utf-8?B?ZTVQb1lXbXRxZjVOTnREM3BuTVdKazhTNUo3b2VLVkF3M3lYZkhRdEV1UVhM?=
 =?utf-8?B?VDRjS0hRZDVXUk9DenFYQXRFN2lzaHFqaGRMUWRZa2pTODArbytrWGhUSnVw?=
 =?utf-8?B?ZUdhN3dobEhQc3JaS3pycnVhelhPSklGQ1hyTGR5a3NMeGVYbEJCeU1aVDhh?=
 =?utf-8?B?YS9Qd25ESUFyaE53L1ZJa0tkQlZHQjlCMEZPN0d5RnRwdXlsU0IwRGJqL1Zm?=
 =?utf-8?B?NCtpY2JFRVdobkxNdGhZbGVJZDVyWlVLd0pXZVJLREJaNXBlVkJ1Q1dJbGVR?=
 =?utf-8?B?UVJoQjFwZEN5R21uMThXSkE4ZU1OVnBORTFUQWlZbjZMY2tiVWFldm9UaElD?=
 =?utf-8?B?N1BWYmJHbVhSaU9sa3hmcEZwOVk5NTM2VG5rZnhkc1dibk9ZVkdVSm9SL2hq?=
 =?utf-8?Q?HkYaVB1cphvUTMleAYrfJgPe5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b20022-3706-47fb-7d9c-08dcf299fd60
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:03:57.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3v2Wj43pm9OI5gMIqwmlEegncC7xtmu7ymN8XB5tiqMDU8MgSlpbtToX/31o1xP6nct6pSmlt42Z8UA4KDSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535

On 10/22/2024 00:11, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Mon, Oct 21, 2024 at 08:05:17AM -0500, Mario Limonciello wrote:
>> On 10/21/2024 05:18, Gautham R. Shenoy wrote:
>>> Hello,
>>>
>>> This patchset contains two patches to
>>>
>>> * Prevent frequency throttling on power-limited systems with
>>>     amd-pstate active mode with performance governor.
>>>
>>> * Make amd_pstate default on EPYC Family 1A+. Based on tests, the
>>>     amd-pstate driver performs well enough on EPYC.
>>>
>>> These patches are based on the "linux-next" branch of
>>> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>>>
>>> Gautham R. Shenoy (1):
>>>     amd-pstate: Set min_perf to nominal_perf for active mode performance
>>>       gov
>>>
>>> Swapnil Sapkal (1):
>>>     amd-pstate: Switch to amd-pstate by default on some Server platforms
>>>
>>>    drivers/cpufreq/amd-pstate.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>
> 
> Thank you!
> 
>> I'll queue this up for 6.13.
>>
>> There were previously two differences for server and non-server:
>>   * amd-pstate not enabled by default
>>   * amd-pstate cpufreq policy starting in performance mode vs power-save?
>>
>> This series adjusts the first for at least the newer parts, but I would like
>> to ask does it make sense to also evaluating changing the default policy to
>> powersave as a follow up, or should this policy delta remain?
> 
> We would like to retain the policy delta for now and retain
> CPUFREQ_POLICY_PERFORMANCE as the default on servers.
> 

Ack, thanks.

