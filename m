Return-Path: <linux-pm+bounces-19535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900979F845C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08B77A27BA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0961B6525;
	Thu, 19 Dec 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vq9gpAJO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5C1A2541;
	Thu, 19 Dec 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636774; cv=fail; b=DnttX/M86TSwedDWlhGIuN2ZRR93HKWtsVmVEi3n/VnN7NblGuJ3iJux8x+JlrAVpNuqr9FFGV9oRsZ6HQh6O4fhsffiudLJyRaZNfilbG6inuLZuWvPTrv7ivmj2IGVn5gTbiKqIuMfstJIOnAzT519NTr70BbVLqd+ACudYCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636774; c=relaxed/simple;
	bh=DwogoNJ54ssLAuX3+46nYhN8tcDo4mkSiD4HfBRac90=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Haj6VsHbohBds3oba23GR/OEx63X+dIf4+u0WHrqfbMtmQDae6KJ6rUGVemFLAgiLJOiracHE6IydxM8Ijjgi4EtIc9ec5ybZUkiroX0TOrBfe9eujpacpESNZFYjyWQCFeEYTBsVMvTZOP5Q9eNO+4FC/EeAdaBnrrMsemY0nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vq9gpAJO; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1uoW0A+Mcv9ElV5AwvN3ycXa6HYQWvXZ6AqHcrQ7z0jJCpGs34C23P5lnUsruqMS2ihPHbmtHMiFQ1bYPo0ERN9+y14AcB9Qs5BRg+gR06UX2EcprxmU0UlOCLHx4FRhF2HVb77zwYq9nv3lK7ckmjcZo4HL+m7YPCj4ghhugdHCaCU9uBXuxxPDgk9PY+H0P7aWoxMpZCqnE06Sw0Vzv2sBU8a3xgPSzuWLfwrRAcfrdVb6thKps4YllmgFPsVersQywlW/lBNP97kGMMRvIYQXUuFPJW9bPIE5frvynUB19GDIf9ep5+EfefdIbuspQXnLEkYQW/fswVpIQ+OuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c7HCfpN2Huaqc2YYLbS0cyjynPaJJi0/I7fQlpLauo=;
 b=EeQr4Cq5X4g1M12SioPXyvnJkoLJoKJuqahx/NS5Lxkj97Drof4zx2Os5fcpD3xYMd+E1JPmmRKVqdtzKDWqP5s42uRQguT7TIUibOh1fyg3h768AalR6mU2299nSf3X/uGLnsLqumbfBuNn6smpyewiTF2NNsZw2qarN7QbOKApG5bKFSgAXYdTlfGvG6NA+4uNw7Dv7zuHvb6gPOR0CoQzrRLskJt2wEXKbVSs2llcOIqvDvFN9e3BrBlDs0hMwwTk7gQaraW8Qqaok5dh4qPd9g+8Awvi2wafYd341rncF7wH+ShZxaebhaLTnFa9MZDWhkPqThWeAOkssMiLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c7HCfpN2Huaqc2YYLbS0cyjynPaJJi0/I7fQlpLauo=;
 b=Vq9gpAJOtNgGvaf5AsuwPBSdTukA4gU4G/tBqwM9000mNaOwvatAurWJrlz7lqxS/0SKX+PFtNJ4i3SL04H+ZSgaa0WvzbUhaHg8zt/nBzbyriMKLl8IXiggBb3MXXLSARSPlQLtyLJjLsHkOQ+FobIxCuyuDOE4eO8zvICJhz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 19:32:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 19:32:48 +0000
Message-ID: <4239407f-2676-45c4-9730-70493e56e36c@amd.com>
Date: Thu, 19 Dec 2024 13:32:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Naresh Solanki <naresh.solanki@9elements.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
Content-Language: en-US
Cc: Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241219192144.2744863-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:805:ca::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 49297254-4e21-4c89-2a69-08dd2063ebd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0FCS1N5R2g0TU1HNDZFMVFtTVVGYkxjMkg3WS9CQk1zLzlScVRuMHptS3NR?=
 =?utf-8?B?NmdNWndLT0RaTjRLd2RGVGIzR1N4WXNQRDRrZHZLMERLRkM3KzhoWkpDWTNJ?=
 =?utf-8?B?Wi9DTGJaUUxQUUw4MWFnWVpHM29GMHM0Qm1xV0kyaUVLTVlMY25tS3RjdUtT?=
 =?utf-8?B?Z1dnTGF5WFVpQy91b1dFbVk1eUI3Ry93L0MwdFFQL1RkZ3VKNUN6MGF3b1M3?=
 =?utf-8?B?c28wNXo5YWt3VjBHenNkbk5zSUJRZjhkUTBLR1lrYWlKZ1BYYzg3UlFKa2NO?=
 =?utf-8?B?VFg2SmFDQkxqQy92WjMvZm5ZUDVoRW9tSHZ0bkVxaS82Mk03NHEreUhTdU1D?=
 =?utf-8?B?d3YxUS8wdlUwellIODNYTHQzaEJJWW1TSUxpMUZUTjI3K1NnT0FDWXVlWHBy?=
 =?utf-8?B?RmpQMUZ0RmMyUlNqR1NzSnFSaXk5UThHNldoM29wN2QzTnhPa3ZINTM3djh1?=
 =?utf-8?B?R3FJNm5UYmd0VUVrQ2lxRjlmNC9Id3c1dEVsMHNXV1pCTnZ2QUY5eTFJT1dL?=
 =?utf-8?B?aDdlNW9FcWNWMzNPVGxoNU9ZZFZLOVpVSjRsem1VcmRtdUlVRjBZU2RCdkx0?=
 =?utf-8?B?cXg5ZmxDRkFOT0dKNUNWSlRJOU1KbVUxREptN1FNOHBzQ2g4SXM3Qk5pUjAx?=
 =?utf-8?B?eTVUbmJINHNkNDFIcUcrUG1wU1BEbGhBTTNyMm1oVHVsRVM0YWxqOUtINHI1?=
 =?utf-8?B?dno4TDYyMXErRjFCZWdZdHdsVUdhU1JzeDBveDBVaGRDN0h2RTErd0JpQVVX?=
 =?utf-8?B?QVNxWlMvd3FMWXNhSDJ0Q1I2OHlwcXRKRFlxb0YwZXd5RzBPQzFBQWxobXh2?=
 =?utf-8?B?MnlobUZyZENIY2xoTTcxSWVNOGVuWlRaKzZ6NFFJTExUOFhIUFpvbENzRnp2?=
 =?utf-8?B?aTFKSXN5SGxYVGVrWnBsNjd2NE9iTEZiaUIvK3BzWWJKNFhtaUZLSlVlRDhi?=
 =?utf-8?B?WGE4b1Rtay9TM3o1VHYwL0RMa3Y4ek9ZK2hrMUVkV0lsN2VNQVZMOGl2Uk9U?=
 =?utf-8?B?K2pCT2lqRnREV0sxcU1wdE00K2pSLzhQTFZvY3dYMUNOMG41RlQ5LzAvSFJP?=
 =?utf-8?B?WHF5ZEwwSnFtY3VxdC9sdDZsZmNia0hQMWNFN0Z5Smc2dmtGUGd2NytjRVla?=
 =?utf-8?B?b3o5RFZEaVRNZWhxeXIvUGw0NThNTS9VU0hrWTNlMzg5YzVhZUl2TzdDcEZR?=
 =?utf-8?B?UEtiYzJsa2NpQzJEaWVua0g3Q0dzb2l5clVkbzhoMWR1NndxQzRxbWNsYlFY?=
 =?utf-8?B?MG5iTG03SzhPYWRHZ0VwcnZWaEFHclNPZklhcFNPZ05lUmF6SU9QT0g2OWkx?=
 =?utf-8?B?Vkk0RFpZV3UyWkw5bk5IbkZKdFQ1RFV1VER2bEVtdk1yVGU4NWErUXdiZHpk?=
 =?utf-8?B?SlhVNzdNTE9vQk5KRjgyaEl0QnFubjdMWmMzaHZpYjhUR29WYmVxY3VuRHNn?=
 =?utf-8?B?UW11UEQ1YVBrd1Jka0tpTjNqQnBBaitSY3FLQVpUNjhTVU55UHhFZmltbXA1?=
 =?utf-8?B?NkZlQVg0V29VeDdnL0RXRFpOOW1nK25LVVlyNUxXVmNSUURUV3BKTklKb0tL?=
 =?utf-8?B?R0JDekE5dnZuR25yMUt5ak9LZWJXa1plU09SWlU1OG1FUEk3MUsxYjFQNEto?=
 =?utf-8?B?dDVhQ1kvTmxDK0lVV3BNOTVDZ0cvR0lOZ2MxNTlMaUdoSlRta043YmNtUUEv?=
 =?utf-8?B?czkzaWhUcDlIL3ZxSGtuQUdLYlBMdmY0ZTZkbm9pRHBpZjYxNWxtdUlHTjBY?=
 =?utf-8?B?Mk0zQkFVbGFST2cwRXJCUEpZRm9LNTVTT2UvZkY4Y2lLajV4RHRTNzk1MmU5?=
 =?utf-8?B?d2gxMTFhUEl2dDBCcWROUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDFFNys0SncremZXQVJtU3ByQkdtMWVpSEZwd204VHlWOU4yalJEa2JOSTF0?=
 =?utf-8?B?YW1TcmZMTjZsQnlhbUZXb3ZxOFpqYzl3OWdFalMrb1VZQmVia2c1QWdWQkhv?=
 =?utf-8?B?WTY0N0RpU3labnF4RHZKbGExTDlyUCtLczZIc21rR2dnQTNlTVlMbGlvOUFW?=
 =?utf-8?B?ZG5IZjRjV21NZHlIdFV6TzVkemJWc0p6RlZzZ3pNSzdIV1lWZDJ2NnpuYk83?=
 =?utf-8?B?TVlrT20wb1ZmRHdIYStNVzlUZUgwMFJsN2RXSGpKdXJiMnBFRkxuT1M4ZlJr?=
 =?utf-8?B?a1pXOUh6RHFlQmMvOXZDdkRiQmdiM1UzR0kzakdPdGZUdEcwK1ZoZHd0Qi9a?=
 =?utf-8?B?b1IwZGtkeldtdVROWVBYUDJ5Qk1zeVVIdHhmMUVMZ3hTaTdlcXl5V3VjR1dS?=
 =?utf-8?B?czZ0Y2hYUzA5RzJMY1dBOEdhb1VJT3h0ak5xUDc2cXZqWXNQMXpQUytBNEN6?=
 =?utf-8?B?VGUxQitiREtvQnIxdjhpUE4wSzc1TUFvbzRrdTd3NFJVblVNaEVpeWVkSWtw?=
 =?utf-8?B?eGRkNDlXTkVNbjdGTUZXMlZnM3BqdU9RbVhnQi9yTlNhNTh4UDZ1ZzNKc3B0?=
 =?utf-8?B?cFlQeFBHS0xFMmVGcHRyWHZaRjFBOXd5TjZ5KzRSOFkrM2ZKSDkyUXIwL20w?=
 =?utf-8?B?TzdtSEFUaWRQVjRhejAraDNVcTl5UGM0RG9IRUJBckFhSnVNZkllK284WGNr?=
 =?utf-8?B?NjZWZTIzN2wvcStGeHR0UWVSWHZkaDFOV2lBSjkydnU1dmxqbVJVT05lQXJj?=
 =?utf-8?B?a1FBbk5maDdKNVBwYm1LV1hrcmFoMVBLNG1SUjNBWGNaR21BdnRLVVJNVkZo?=
 =?utf-8?B?RHZGdVpSY3ZteHBJSkdDS0VGMHgyamZGZ0c2eCs2US9rNkZIQ0s1MEN3TWRs?=
 =?utf-8?B?eDFmQ3dOUVJzazd6MkdBUThoTTZweVdGVWc5OXhCdTBXWWJYeExFTDlxbUNR?=
 =?utf-8?B?eE1sdDVOM0Z3OElueUI5TkV0b3JwejI1clpWdTdZQU5SVWpxM3YyUHRDSjV5?=
 =?utf-8?B?ZEs2b3YyNk94WmxIVmk1WGhZVTlkWG1MUFNQeDZ2SmJEdDBuZlBucGlBcmpW?=
 =?utf-8?B?cWNOaG1JcEhTQkNBdmp1KytNbnZHdGFncmNCdjV1MjRxWndwc1RFeHB1L3Jh?=
 =?utf-8?B?bEQwT1VjQ1lTZEVteXRrN1NLbHM0Qm1kZTlVd1BWNlVsWjdpZlUzelMwNmJC?=
 =?utf-8?B?TURRa1E1V21yd2Q2Y3JXck9ISUYycDVIdEpIc2JLdFhmUkxBdTdSbTlNOW9i?=
 =?utf-8?B?ZnBvZ2RDcTJ3MEJFbUQrTnhBRVlEeGk2ZzhwekxUZjF1d0ZOUS95M1llRHpr?=
 =?utf-8?B?SUt3ZVpFR0tERmg0cS9WMjRxZ3lTbjllZ2R4ckd5NFBjSjNjRTlkbndRMjlJ?=
 =?utf-8?B?WGN3ckdRTm1pVmpjT29LeDlyTHZmVGVEQm1FWklVMzdpYjZDZTkxV2ZaMVVS?=
 =?utf-8?B?cEVSOXB3UnRGaHE1bnZuY3plbU5rVUx2ZjZWQzFRcjZuYm5CS1lnQ05Fek9Y?=
 =?utf-8?B?aFc4LzQwMmlTYVVhdkVlcXlpMFo5RGIxMG1YS2tUNEU5WUxKU21xdjdFWkJs?=
 =?utf-8?B?cXRvVWlvQ1VCYkwycGtkVXRSVWp1WDBrcktjaEp3OU9KaE5mVk0vaktzZGxJ?=
 =?utf-8?B?dXI3Y2tqOXVCWHU1ZXE2T01iNFZkRFE2d3hocUVhOW9ESmdhcm50VzJTbWZB?=
 =?utf-8?B?b2lzR0xqRndhaFFRNU9qSUdEc1hlODNOKzVHSFlRWmlCRWFOU3dsZ0lhTDRl?=
 =?utf-8?B?SnV6cldOZzk5eUFRTEdvbHB4ckFsUXpMMUJhV3M5eWRhMFI3WSs3MERhNjU0?=
 =?utf-8?B?VFYraVpPTzZKaFFRSGNkczhiZkVtMzY1cVUzQVlYMEU1ZEkwMGtBWEZNQUE3?=
 =?utf-8?B?cWRZdkp1M1BBeXhZelM5V2NUbkpaMzhNd1pMTldEMVg2NlMxVU5BMVpXa3VY?=
 =?utf-8?B?VkRjRHF4UUtlNmFhb1VZYm4rMlJGUkJKcmE5LzQ5RWNTaXZGaVVvN1Z1Mnh5?=
 =?utf-8?B?WUpNVllraVlzR2RRUzlKdVhFL2xQa0lIMTZuYXlFU1RvWkhEOS9YVDIyN0Fv?=
 =?utf-8?B?U2V3dFgvWHlyN0xaeklOMFpveVV6R093TWlOUWdnVTg4RlZjRkJFZEIxRVAy?=
 =?utf-8?Q?QQdFX+83E3L/NfEIl5/nm2h3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49297254-4e21-4c89-2a69-08dd2063ebd3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:32:48.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJI9vFCl6BMJg3mZbN623FEXGZn9wOzYI11Wgnbf+QZF3m7IzlqLRjkPibxfFYHaIzS22xHHYKTHsJnCBy8Q6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895

On 12/19/2024 13:21, Naresh Solanki wrote:
> The previous approach introduced roundoff errors during division when
> calculating the boost ratio. This, in turn, affected the maximum
> frequency calculation, often resulting in reporting lower frequency
> values.
> 
> For example, on the Glinda SoC based board with the following
> parameters:
> 
> max_perf = 208
> nominal_perf = 100
> nominal_freq = 2600 MHz
> 
> The Linux kernel previously calculated the frequency as:
> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
> freq = 5405 MHz  // Integer arithmetic.
> 
> With the updated formula:
> freq = (max_perf * nominal_freq) / nominal_perf
> freq = 5408 MHz
> 
> This change ensures more accurate frequency calculations by eliminating
> unnecessary shifts and divisions, thereby improving precision.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Thanks, this makes sense to me.

But looking at it, we should have the same problem with lowest nonlinear 
freq as it goes through the same conversion process.  Would you mind 
fixing that one too?

Gautham, Perry,

Is there something non-obvious I'm missing about why it was done this 
way?  It looks like it's been there since the start.

> 
> Changes in V2:
> 1. Rebase on superm1.git/linux-next branch
> ---
>   drivers/cpufreq/amd-pstate.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d7b1de97727a..02a851f93fd6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   {
>   	int ret;
>   	u32 min_freq, max_freq;
> -	u32 nominal_perf, nominal_freq;
> +	u32 highest_perf, nominal_perf, nominal_freq;
>   	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> -	u32 boost_ratio, lowest_nonlinear_ratio;
> +	u32 lowest_nonlinear_ratio;
>   	struct cppc_perf_caps cppc_perf;
>   
>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	else
>   		nominal_freq = cppc_perf.nominal_freq;
>   
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
>   	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -
> -	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
> +	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
>   
>   	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>   	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,


