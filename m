Return-Path: <linux-pm+bounces-30501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236EAFEEF8
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 18:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BA188FD8F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA321FF3C;
	Wed,  9 Jul 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IL/eQqbP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8C2080C8;
	Wed,  9 Jul 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079331; cv=fail; b=bNl7hMVdwUBb53b8nIKV7QBkU+uBxli9UBe18oT2WHyE3JiZxYd+k+3dMOw0p1jbYay8o2ji7c+Olw5D79Uga/HygGZySstz0y9MHxg0lCEvE70oWwEdjFXODaJIwqQ1M6E+Lljc+lK9+ARG8AfWNcpL5ypcfVFvnKATzxSP1IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079331; c=relaxed/simple;
	bh=nbJ4LG498AsBH/EaFmNcyzp4ArFO4oqlhaQAYUpOY/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GYsLT8Ai6BeuoyEr2eGUBuM0FSwzrVkdvWUXg2yLrQ74fXblDtczNBfY/utT1Kc8JKR1V7z3P1idhSlq1o64Sh5iPnMY4SIYHMvYkcR4+KABezXVRccvEbR1qwTflVRL5csLDbwidrNFtLKw81+udCTYjHFJyJQ0v32stgBl1IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IL/eQqbP; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4tSgWuEPGcblJEwG2L/6cr878oEvLTNug+LlUDqIv88igpAc6OSrtwAu4Xg4b3pEcMVCiILrdh+++kHMEVWk+yElQsMqF2Z0DCDFZxFHhUen8ld552vA/RaE52COnYNWKE0TmeIHSYiUE5slKmPxk4s+CFzoLKUpSDQVANGUbi3WOmSHwGCOcKeSVkfVd1EhNL49k64qyqDeFMrbxtXuHKMi00EFPV8Vq1Ev+CUxnmHkCIMqUYodU/2yEMoweKRm0Kwv5bqcaFJ4UEE/uQP4cXFXtuvHi0lwVjTYbI8WpFSc1IP6SzFO4D7u/8ksQ8gD3VK6GgkAmkp3XbY5krjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBV2QBUDrDca4U0WXCM8rpCUtd5PSjn/xdH6tKOTL3g=;
 b=OlYuBD0pXw5gr3FcYuxIZodeDBB7Ywa7ZTLkTt3IW1vDL0fFLSYgdqceMgwBRNZNYqcuB5sUkMhAhy9FCE77TS1sG+zXRivym/jqHieZcNCkGumUzc+en5oLo03LhjNRE8t86K6BtdiWJCt2fzG7kIAiu9c2z/UzMhxCt6OcE16u7jLG5vpUYunDlOOWAspgYvWlsyUEX8/Qdd0GBJFCBMvAczpy0U+FHBNaQWGunCuNOJrb7yQTyakbrULcKsmKH1rjaP6CVP1z1RuS8z5ZCtYt5t+AdrWbgfRErNHun1epcy/z1auPIvuCkJALfr/lrbPsIid7AmhFMZCvURMpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBV2QBUDrDca4U0WXCM8rpCUtd5PSjn/xdH6tKOTL3g=;
 b=IL/eQqbPXXgi/Iel+UD7KevGF4+MMzEoVwC65c1Fk4aPrXu+CXO+ll9zSqklBWRHmaoOz/uVkvgv2xZFif9KXVHW9jT3smfFa1BuiGLB8+/3O1RYu8hH3XbvrSBbD0/kvG2RpXw01pfFdiPJwKt1xNNCj/1n27sn96iOleMWy78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 16:42:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:42:00 +0000
Message-ID: <14b5bcbb-31b3-46f4-88c6-c2a243f40802@amd.com>
Date: Wed, 9 Jul 2025 12:41:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/ttm: add new api
 ttm_device_prepare_hibernation()
To: Samuel Zhang <guoqing.zhang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, ray.huang@amd.com,
 matthew.auld@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: lijo.lazar@amd.com, victor.zhao@amd.com, haijun.chang@amd.com,
 Qing.Ma@amd.com, Owen.Zhang2@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20250709100512.3762063-1-guoqing.zhang@amd.com>
 <20250709100512.3762063-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250709100512.3762063-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6335f4-76f9-4c65-8b76-08ddbf0786a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGo5OGpadVNBSG83SUNZRmMxNlozNm82UVNrR0ZIY09GN0NBZjBYbVlzOVNR?=
 =?utf-8?B?b05VbVNkQStmVTltZWRGUzRZb3NBWTF0MkYzU0ROa3hQMFBjeVJiTW9ybGdH?=
 =?utf-8?B?UzQ2OTc4TDZ0Vm01QWdFRjFFZ2FQQzYyZzlid25pM1d3UHUwYzdTVG9QcHZ4?=
 =?utf-8?B?ZEVrOFc1N2NOb1Y3c0w5SVJZUnY4OXNUUHNGbENmcC9oOWFqMnhKb0FlcVc3?=
 =?utf-8?B?R1k2VUtTUWlhTmNTM2RPNXpQa1ZFQlpjOG81TUE5WHo2RDE2a0Q5WXJFazA5?=
 =?utf-8?B?dmdNVE9jM0U2QW53ak1RWXRHdlVPS1p0MFFFTFJ2cktURUppMzUxNEtpVWNG?=
 =?utf-8?B?Zlk2WW4rYkw0UmcybWN1MFVIZVg3WkJzUll4Vm5KZVB5eldGR01JOTJORUd0?=
 =?utf-8?B?SlJRSlFvMXpNU1AzTjcxZHlLNURjeFFJcitITHN2K0IwMXgvRlNFK01sZlNy?=
 =?utf-8?B?SUFqRFVHY2RXYkVkK0M0em4rUmdEZko4VC9xZUdmY2RRdyswTnA0MGkvSUVr?=
 =?utf-8?B?aFh5R0ZNU3pFNmZJa1NBbG9HWHo4emhpUGl6NEZtWjJSMjJhczg4L1RSQU84?=
 =?utf-8?B?K1ZFVk1JZmRMdzNLbGxtUk9VNHlpQTVzRFhZTzdBcGJ4WlkvWHpOaG9UNUox?=
 =?utf-8?B?V0NiVVdZbVhKb1ZIYWNOZmxCQ3ZYbkJpR1NmZHVFRFd0UHdsTU5PRnJtOVJL?=
 =?utf-8?B?NTQrZmZxdEhybEdnazJRT3JERlFRMmw4enBzeXp5OFhmR2hqc1pOMVdPdGVn?=
 =?utf-8?B?bzRLNGRzam95ZEdCamNaVUhuMkdOZUZFUmJVUG0wZGMwNXBZOWhJakZ6SUdM?=
 =?utf-8?B?TTVjbHptOURYN3VKZU1NRUtFVUREaDFLOWxEVGZmcU1kc1dpY29hSnZOczZl?=
 =?utf-8?B?ZWtURm53ZGVxTmwwbmpTbFJTcHB6WGRlMHRYTG9zdXk3MDBZOEJkdHlPNEJ4?=
 =?utf-8?B?THZ5cHcwaEJRUjB2Zzc5MTVhejg3LytyS0pYTzBKeEMxNWQreGZMVlNDanh5?=
 =?utf-8?B?RHRMTE1Na0xKb2pQbCttSTM2OTFTYWdFdGtrZGVJc3NIb0g5MktpdXZjYTZ0?=
 =?utf-8?B?MEV4WmVZTWw3L09sOU1tWWVKY2NVeTVqbXJKa2d3SG8yaFRJQUl1dDB1Uy9u?=
 =?utf-8?B?citsLzB2bmZDSW54WGlBczZFekFnYjZ4RDhhZ3ZkMHdxcGV3MjNtS0FXQUdP?=
 =?utf-8?B?NFRLeHFySXBxbE1zNkFLeFpDQ1BLQU5MdmRDY1dNTWZNNFFkTzhab244RWxa?=
 =?utf-8?B?azBlWFVEMVA4ZTlVdVMvVmRWdXkxeHdlQzJpM2owTTUzZSs5VHR6SEF6aWVR?=
 =?utf-8?B?WmFVYzRaTkJjQnpJTldrSFhoeGd3MzZWTXREbzB2eHlNc1gycDBqd28wZmxN?=
 =?utf-8?B?bzFJU1l2NTFtS2pVWkVXWDQvRFQ0Rnhuei9GY1htRnh3d2xjZEJmYXBoYW45?=
 =?utf-8?B?U2VVNmNRWGF2bDFmMEFoazNrS2djK1B4dFNJQ3BWaWF2cjdZRnp2NkR4cHVH?=
 =?utf-8?B?NmEwR1RHQzFtVXNGbHIxVmlTZnB3VFhtMFlBdWo1VXdCci9jSUVZTzF0VmRN?=
 =?utf-8?B?QlM4VnIxa0lMcHhWZHhqVlhCT3VSbDlzTDFFZ3ozZlF4bGpFczkvYWF1T1Ra?=
 =?utf-8?B?VHB2TVpFS2tSSHl3R0xlMi95ZHo1ZTJJblNYQnArSzVLRlhmK2VKNEd6R0NH?=
 =?utf-8?B?R2l1eHNtUXJJWXRvK0JLd2NmYXp0QUx2QUljTWNqK1ZKSW5zL21wMU9zVmU1?=
 =?utf-8?Q?TfQKgdarg5TZGesnNaT7N1ALNXiUQYfAMUHAfu2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1BGZ0xObVQ5MVI5MXAzb2d5VXFldjB3VjZncDBlMEtKeXlkbWN1NFBXTUYv?=
 =?utf-8?B?U1NtWXB5RkVqaVpzWXZjUmE0NkM0SHBzTkgzNlYyd1RsUTBYeVRqWThOc1I1?=
 =?utf-8?B?MDlJREo2MU92akpHcXlWcUZxaEdCNVNFNlB2ZUs2M3F3ajZPY3k4QmE1RGpB?=
 =?utf-8?B?YnNjMUh1eGxwMWg3WmkrQUxZeUxVTlF1dy96OFh5NGg3SHJ4bHI2KzI3c0N1?=
 =?utf-8?B?WnQ1Y2ZyK2RIQjNRV01hQU8wRTErMDlIekJYdmlFMG1uSVN2eDZJUFhHaHVx?=
 =?utf-8?B?cHBUZE5uRndKaXBLYkVDYnZUcWxvQ3MxZHkzVDlaMzdsY0l6aWd6TDZUZzds?=
 =?utf-8?B?eDArZVdNZ1FNcUZhRHhWbEpKTmpMallRRmE0R2Vmc2V0RWVJVCtFVGduZDI2?=
 =?utf-8?B?SFczdjFGNUl5TWFDbDNOOHZGNTBwR093SlozQitkM1FGZmptdmFXWEl0VUVQ?=
 =?utf-8?B?aGRQVXhKVm9rRzRKTzk3V28zZGVVVG03Z25teXRvRGZVODZlSlRyNVJuaWdT?=
 =?utf-8?B?MmpxaUJadVFid055aUt6MHlwZzNjUVkzNXpXbEFpOFBGMHpwMjlGeGpwN3pK?=
 =?utf-8?B?Z2MyMk8wZ2M5cjIzTGd4Um9hL2RCSW1nSmJIVmpQNkhZMllncGJZYkErcHNH?=
 =?utf-8?B?T25KTG9MYUNlUXExWlB2UWExZHRNTmU2MHhla1Y2ZzB1VTRITmZ5T3ZKV1p5?=
 =?utf-8?B?RkJLMko5UkxsN3hkMFFGUmZPdHpTRmNDZGZ0QWRwNnVReDlHQTVlUmhESEZU?=
 =?utf-8?B?NFRqNmNiQVNBRnBCQ1QwbldZRndYam9lQWE1VzZ1YkpXNkNBRnJWaFJBRjMy?=
 =?utf-8?B?WFM5cXZzUUJkSkNWY09oWHFMSTB4VVJGc1RkN3Bsdm5HZzBFYUF3NXoxbm5M?=
 =?utf-8?B?YjZSdStZWXh4NE1GejduVnVOM2JjV2o2T3k3TVo5TnZ3VFNJOC90WFhnZHVY?=
 =?utf-8?B?U21pREcwR04xbkFrRktScnlJbmVmWXJOdGh1WjdPdkRZWWZYbUJtdGJ0emlC?=
 =?utf-8?B?dzhhaXF3cXNobmJpT1ZCYXRxRjlleU9uVk04clBlYzByOThNRnFTc3JBNXBO?=
 =?utf-8?B?dGVRUFZZMzJ0cWl4djRwa3ZGcHVqVFNVQzZ6dWhjTlMyekFISnQ2MGFUdVl5?=
 =?utf-8?B?SXJaVWdwM052YXJiVUNNc2ZDNktpdVpEenh1UkN1RVhCaXIwOVNsbjVpeDdM?=
 =?utf-8?B?OUV0NnV0c0pUVHhTRTg0Y0hPOEVDRU5ISnc5dFpyeC9VTVJtOHlBRk5ZWS9J?=
 =?utf-8?B?VDRHT2FiYUlndS9TZkgzR3RHTElvZ2pXQTBHeFVoaVpablBpVWNrYWtvTEpF?=
 =?utf-8?B?WUU3Zy9vQWNMK01XN1ZuUmE2aUVRTEVPN3JTQUlCY1ZHVWxTM2FEck5BMGJD?=
 =?utf-8?B?aXpaZ0NtUDY0R3QwYmd1RVNWNkp3L2dQb2VOSjcyTHVJQXNMaHdUeEN4MVZz?=
 =?utf-8?B?Wm9naC9panN3SWpONGVGdTQ2ekRFOEMrQWkzcmZpdlpHd1JXUnI3N3JkKzFh?=
 =?utf-8?B?ZGFoRDVNNS8yZGZ5Y3VCV01vWjBCL2xKSEVXbzBvZlhmNW1zSGRhV2gycmpW?=
 =?utf-8?B?NmxhVU9hQmI0bFYyNkovWG4vcS9iV2RjUGMzdjhOa2JPN3pKNlpaMUVDbGR5?=
 =?utf-8?B?WlBCS1RjZFFEbU82b3o4QVQwbXUyWmpFTDU1S1dTYTZpc2EzcnI5amxuaFI3?=
 =?utf-8?B?eXdPTVZDM0JMM2plRzl6c3h0d2lFOWZoZEg1WDZIbWRDek92TEI4VS9RVm9i?=
 =?utf-8?B?RWIzZTVXNEhJOEUyK0d2UnozOTRIZ3ZrKzUybWJrQ0NHczFXb1ZqM1hGSmhN?=
 =?utf-8?B?VGZxZm8vVm9hR0s1OTl1MnN0UzQya0pTNGFLRTF3dEVSREV1cXc1VUs3MVlW?=
 =?utf-8?B?bWcvUlFXdnNSQmVmeGE0dGdZblR1eXFKRWF2WVBvUS9DOXptYktxOWJ6YUNF?=
 =?utf-8?B?dFpHbmg4UHVLVXdaSkZmMjhRRTBlVUdIV0llWjY5MFhvbnREVjJ2TUxNR0Rv?=
 =?utf-8?B?dXkycG41Y3pPMlE0MGd3TUh1dTl4WkRUVzlMbDYvTStNZVdpZzZtOU1TNGxy?=
 =?utf-8?B?RUpXNWUvd2lEV1dvTnVORkhFbHJNUGRkQ25NY0FHWllTUmt1aDhSOXB4VnVK?=
 =?utf-8?Q?arID3YuYsGMeqvm0OnBQu1AU7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6335f4-76f9-4c65-8b76-08ddbf0786a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:42:00.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GuFsEJwtsDmf+HCXi/eWvZQe0zXk4BYNW28Hhbh/BKHAehzU0PcjAMJNRbIuF7e0gAZrgE2Mj2VcARKRY7qhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281

On 7/9/2025 6:05 AM, Samuel Zhang wrote:
> This new api is used for hibernation to move GTT BOs to shmem after
> VRAM eviction. shmem will be flushed to swap disk later to reduce
> the system memory usage for hibernation.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_device.c | 23 +++++++++++++++++++++++
>   include/drm/ttm/ttm_device.h     |  1 +
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index 02e797fd1891..9c9ab1903919 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -123,6 +123,29 @@ static int ttm_global_init(void)
>   	return ret;
>   }
>   
> +/**
> + * ttm_device_prepare_hibernation - move GTT BOs to shmem for hibernation.
> + *
> + * @bdev: A pointer to a struct ttm_device to prepare hibernation for.
> + *
> + * Return: 0 on success, negative number on failure.
> + */
> +int ttm_device_prepare_hibernation(struct ttm_device *bdev)
> +{
> +	struct ttm_operation_ctx ctx = {
> +		.interruptible = false,
> +		.no_wait_gpu = false,
> +		.force_alloc = true

On linux-next (next-20250709):

drivers/gpu/drm/ttm/ttm_device.c: In function 
‘ttm_device_prepare_hibernation’:
drivers/gpu/drm/ttm/ttm_device.c:140:18: error: ‘struct 
ttm_operation_ctx’ has no member named ‘force_alloc’
   140 |                 .force_alloc = true
       |                  ^~~~~~~~~~~

> +	};
> +	int ret;
> +
> +	do {
> +		ret = ttm_device_swapout(bdev, &ctx, GFP_KERNEL);
> +	} while (ret > 0);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ttm_device_prepare_hibernation);
> +
>   /*
>    * A buffer object shrink method that tries to swap out the first
>    * buffer object on the global::swap_lru list.
> diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
> index 39b8636b1845..592b5f802859 100644
> --- a/include/drm/ttm/ttm_device.h
> +++ b/include/drm/ttm/ttm_device.h
> @@ -272,6 +272,7 @@ struct ttm_device {
>   int ttm_global_swapout(struct ttm_operation_ctx *ctx, gfp_t gfp_flags);
>   int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
>   		       gfp_t gfp_flags);
> +int ttm_device_prepare_hibernation(struct ttm_device *bdev);
>   
>   static inline struct ttm_resource_manager *
>   ttm_manager_type(struct ttm_device *bdev, int mem_type)


