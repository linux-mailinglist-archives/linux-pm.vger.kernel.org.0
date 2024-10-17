Return-Path: <linux-pm+bounces-15898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E89A2BA9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 20:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB6E1C2192E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23971DFE06;
	Thu, 17 Oct 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ATTyV8n1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73141DEFF3;
	Thu, 17 Oct 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188397; cv=fail; b=hMlYt8BKPhbp6EuXdvjnkWdguelPbRvj5t5xlgNfhEBtMF182NiEBhFXOTpt1M6aLeS2YtHQSo3lj/mmR9HNxwv/WvJG6Cw9t8gu0Ghp7VcqefBZGb7l+dAL3gIYMnhVzL+lPuV3Gc3q14F4kB5MRXAvpfoRlFOlBcGmuTr/VSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188397; c=relaxed/simple;
	bh=yWYSWThUZMKRtoqE4AHWTQ28KxqsaFJW3SUBMQ5P28g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=InobH+I4gvFFs/PTHztRXZ2Rw9WJxbCF6T39elKMel6kLQeABnyY9yYS3JAgK8D6UKUt5t74eGni0g3OW50oQpUHEP/Q66d8VpPeTj4/znqcOcUR2BXAvRl50xNhZKjlKmp9Hmi+e9Ha8BP5a9MW1Fn5AoC0eN78ea2ItKZtqDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ATTyV8n1; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6DI2CBQPjP6sll/jCd7JfJc5VmhVz36vXQ5jbt5+U6t/xM/2aUGCGGq8m9xQyOJdv9gC5PbfMINmIoSao32Lfg3RxA4rzO2kbgi/eJcoeMurypEVUa5jGTyS9+0c6XXIrH6l3sYSmhK9Qnf/h1CWrhuRtnidS3OFmkyqAd2MRVMVA6uv59iat++x6pOuWl8pfGkGJIDfNDYsyKQMtboiHJsE2ShuQxwXT7voGgk85ijtLB0DK81rMb3lIOWjDtVLJAkIb9oFDL9YbqZ27aSoewt1zJFuu4M1Hp39B7DVGZRIzpwWH2Pe6ph2QwlN82J8E7n02dx8dDWtnnhWkfthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE6R8gmLK3pZivhtEZ55f3f9Hxnqxq8UNf+ipaNzKlY=;
 b=pRlq4LcBDBnUxj+uq4iiu6d9bGmbXhCQIqq/IIMiXefPyvbW16zoNs127LQhYi1S2NhGL3UH3qQAUBhU6ZmA8gsAhoXDjusSSa2BQGWCvlH1wm7/y/zdUIASfQ1Np5qZXVLiHRVgCtEQZ2WXIDqK2+k2RDzCKUN5uisS/F3YE8BBw+LEVQsRsbRCPYwIOZOo5FhDcRdsN7Qloo8QZ38PDWBOgRp2BO+7j5ghRxhnDWwdwXI0WUgK+SnjNbpH5RZc8suMjaJeLfzgPEV/v/yYxaeZsVhVb8paZ11i4anugOT3LTsSN3dtdacZrQ9EzrO81Q2ytEnZmlFgXKaL3QLIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE6R8gmLK3pZivhtEZ55f3f9Hxnqxq8UNf+ipaNzKlY=;
 b=ATTyV8n1cDa2clIUlw9BoWNnXk3j3OaBkRkDISTloYTWEzrHKOReQF3Rrq70B4E4NHqyvz/S9mVr9Sp/0sQ/2KzN5HF0VrLYS2JJdrvT8sFzwJzW+QfP3Sv1d7T5c3KUkhh8wu/leGlAbovSodBnfAtkttXgBCtgoNrw5un/KK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 18:06:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:06:29 +0000
Message-ID: <2bfa4179-3d45-44b1-9d51-a4317a548cf1@amd.com>
Date: Thu, 17 Oct 2024 13:06:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cpufreq/amd-pstate: Refactor amd_pstate_init()
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, gautham.shenoy@amd.com,
 perry.yuan@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: f781f76e-6666-4fa3-e7b3-08dceed66c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG56M3puNGpRUTZtU1JGeDgxQU9OcXBRRGxxMitjNnZveWZXdVBFRXNSN0wz?=
 =?utf-8?B?cFdHYXEyYk1Ub0hxTXZkdnBxNHZ0N3M3Vm9TdzFHNHNRaE1ObndoZ1ZkVEVl?=
 =?utf-8?B?TzFCZFlBQXBlcXMwM3FDUFp3aldGUml5ckQyWkJiVlZXSEJuR0g5dHAxMlJL?=
 =?utf-8?B?MjVGTDNhREFnSHluVlk3emowclRueWkvVUJDc0tocmh5cUd3NFQ2U21sMjh2?=
 =?utf-8?B?YTQvUUozeE5PUHEyd2puTnFYaTJOS0o3NTUvM3c1d3hqTkJIUU1tbXZvQm56?=
 =?utf-8?B?L1REcE5WY1NlZ1U5c0N1QmF5aXBnU3NPSDl5ejlJcm0ybXd1TnlvYlYwWFdK?=
 =?utf-8?B?QVVzVndTMG5OTm5lMmgxbGJpcDQ0TUVoK3JYS2c4R3RwTUVlYlFVUVZNZlla?=
 =?utf-8?B?RXd1SVdFSFNJaGNYOHZ0akxLUEFlZ3I4WkZ1MHhzZWU0RXRzL3MrUHpMMU5x?=
 =?utf-8?B?eFM0RWRBdFE1bm9PWVY1YnBBZi9adEpYS3Z2dzRyaGNHZTZ4ZExFRjFuNlZN?=
 =?utf-8?B?V3Z6SG1jZVozYmNqRHNnblhrYXFjMmtaUkNtTjBOQzdJY20vOXhJc29PZE1i?=
 =?utf-8?B?NjgxM3htdTJCMGR2Vi8vdUFkRCtXaENLSUhyT2JqMDVIODU1Rmpjc0xDZkww?=
 =?utf-8?B?bWxWTDRZRnpVQVhTZzJOM1VvOVRZVmMzZzhhZlc5Z0h4Z3FLK3ZKRGNTZUxt?=
 =?utf-8?B?ejRmWDRneVdiRE5SdlhocnVhUU1YbUFjMUVsb0FFTnNoeEU5V1l5M3ZNdS80?=
 =?utf-8?B?WWNnemR0d2dEVHBObm5ZWmRhZXZyUTVEMUNDeWh2dk1OTjhEYk1ESUxrZkdy?=
 =?utf-8?B?MFBnMGo2aDNtdVcvSTFvSUNCQmU4RkIzRkhZZ1FEY0lqYXNlL09OL0NWWk0v?=
 =?utf-8?B?cjVRdmRnWkdFSDlwTjdicGExY1dWeWlYS2Y5VXBreWRiZ2pqdW9uR2xycUM4?=
 =?utf-8?B?Zk15R01JVm13SUdxeEJBTDFLOGlUZjg4RlZrU2N3d1UwVFhBcFpUdGpZR3A3?=
 =?utf-8?B?K1dQVnZhVVI3NW9TUGtQUUx0N2tSM2JDczFQc2V0RGJ5aFRsTDJJRmxYSkpV?=
 =?utf-8?B?dHBPU1RKNCtzN0dRK2dCVGkvT2h1dTVqNGcvYTdyS1RNdWRyTms3WEZxYXdF?=
 =?utf-8?B?VHl5bWZyNU1jNHdONnVxYjh4WE1PL2dnMWp1anpnYk51cDY5ekdIZWlFUUhq?=
 =?utf-8?B?c1RyU1E4Q1JMcDVuK2dBVzdMM21uTkF6UHN0NHNIUDM4RllLbm5ueWo1UkJi?=
 =?utf-8?B?WWptMTVQOWNUMFpIYmQzTjZPWTkzT1QyTE1HRlF3dFlDMjhNWHdsU0pTZkdL?=
 =?utf-8?B?WGh0em43eVBvaE1wRVJuTHhPT24ydVFpbm9NWU5tVllTSG5DcHZzTC80d2Nl?=
 =?utf-8?B?ZE4vcFNWeS94WUxQbmhFMkhKRTV3UEZmeGowSmpDaVp2eldGWEw1OTRrVnBl?=
 =?utf-8?B?cGtRT25pclkwTXg0cFJOR0ZrVlh0RFIySDZtelR2Q0NMaEtwSGh3QzhIMlVY?=
 =?utf-8?B?Qy9kVUdCREhYZ1BOMmJtOW8xZVhzYVVua0h4eDZ6R2l3LzJwdS9zMmZkdlB6?=
 =?utf-8?B?TGo1MXdpbTFBTTFKNFlVRGswL1k3Wmk1enk3eVdQRnh4VkJoQzN4NTRsL2Jl?=
 =?utf-8?B?WTRKbEU0QzIyVlQxRE9BRGN4aE53MzhPQVVrdGJJeit4dTBUTmpLZDBzOGQ3?=
 =?utf-8?B?VEFrdGdBbkhJN3RDMWY3YlZHVEl3TG4rbE9OZFpnck1CQ1FyOUZ0dVpXbVdz?=
 =?utf-8?Q?XAz6ky2Tb5ZbS03Pt8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZWbCtJWlprQ2ROdzFuMTQydlJ5anE5OWpWQjRJRmszcG9wZ25HMmJBRk9E?=
 =?utf-8?B?cHlIZS9hOHVQY2k3SitSMEtDeTJpeVlhTFpyNWR3SEszV0k5cUt1S3d2UU5u?=
 =?utf-8?B?K3IvMjJKOFYxVy9WK002RTJkWXF3bmhQNThpTFlEdTJGK1l0ODY2U2dmM1dL?=
 =?utf-8?B?N2dadS82Y0JoWmsvaHVBNkJJSHZKelU0UTdzdS9DODFHV05KaExoQ1RzWnlZ?=
 =?utf-8?B?TDNqbms4RU9zVDZSbytMQTBPbDRUalJEQW1MQzBQdW5mSXFuei9oK2FUQ3lo?=
 =?utf-8?B?cUZhc3ZvNUFpekZxOURGR0JSM3planB0NzRjY0U2VTRXN1NPdFJxVkpEbHI2?=
 =?utf-8?B?YXRKd1dPVHI0MFgrMnlhVHk4WVVNNFdwZjhyd2hJV2lYWnRVRG1kTkpaN1k2?=
 =?utf-8?B?WW50S3RiemxaS1ByVlRLeUJjRHVYOHZoZWtZL3RkaWlaczhuUUVMTktQNXo3?=
 =?utf-8?B?R0M3LyszRW5Vc3ZsTDEzempwN0wxaDhKbW1COEhnVlRXcUFZM1o1dDh5clU3?=
 =?utf-8?B?bEY2ZjJydkVXQ0IrNFlXbHd6NUsxMXhrV2JuMXl5OVFYS2NNMWkzT1gxTEl4?=
 =?utf-8?B?akhsRlR6UStNblFYSGMzcWExNVQzSHpjdVNZWW9CMjRDTXhjM1F4bVlVK2Nw?=
 =?utf-8?B?RjhCL09DSHZYZVdDd1JEOFB6NVZiRUdoUjF4bVZka2hpZndnWFM2TnN2aGsr?=
 =?utf-8?B?aUpLRWxjejdWcWk3cGRvY1Q4M203VGJhd3lkdVJabk0xZFNsK2plTEVPbkxi?=
 =?utf-8?B?QW9vYm9ka2IzczkxVDlBUEJmWndsTE1jVWc2d1FPZWtUZnIzdUlXWDExcXk0?=
 =?utf-8?B?TTh4Mkh2UEdsLzBuVDVXRUlJQzMwMWpRSmM3R2tVMFYwdWs4ZGZyaHRWeWtV?=
 =?utf-8?B?UXVIN3BJVnVBNkg0Z0RwRWtiL3pCUzcySkozYXBtZVhXeG5yRWUwbnFaT0hS?=
 =?utf-8?B?OWQwMTRzVW1TRGtnY3grd0ZhRkU5MEFKTVRIV0xURmw0RHNpN0Q1TlZpYzQ0?=
 =?utf-8?B?VDAwY3FKemsyZ0hWb3Z6bCtYZml5dkZ2eURXWGFvVkZjQXhHM0JWUlhpdGUy?=
 =?utf-8?B?OFdBanV1RGJNU0NIdVREV2p0MklDMlZidkdxYUNtYk13d3YxU1RZeVNxY1BC?=
 =?utf-8?B?b2FGUVJYV1pSQnVEWTlNdFB0Z1VXOE1WSWsyRXVsOUZKcGFOSzZDQWpXb0xZ?=
 =?utf-8?B?b1IzTEpIRGNuUms0dmltYjE0M0EzME5CYXlJazFZSXREK1RreUFseUJkQmlj?=
 =?utf-8?B?a0kreUxlbURFMTVLdVA4MXZXeVdIZldJWHpBSnNJUkhhb3VpRi9INTdrR3JC?=
 =?utf-8?B?ZDY1WTJWQmY0eGNvSmg5WXZSUDUyRk9vaTEzOWY1eUREVFpCSzRsNW1FYUl5?=
 =?utf-8?B?akxtRXZ4cUcwSGhlTmNwcjkzVGErNjdodGdVN0FKQklBcDJFem50QVNrbmow?=
 =?utf-8?B?UVNRY1FoRGprSWZLQVpaeEZpTGFWbkpZWU5JclQ1M0lIelkvWi8xclgxQkk1?=
 =?utf-8?B?OG1yTkNJcTBvL2V6dkc0YVlMWWF2eHpRWnh3ZUU0ZmJBT0FBdXFTbDcxd3Rs?=
 =?utf-8?B?RkZsby84cGhqTXNRRUw5TGd4bjBabUZpSHVsR2ZOV2lNUitNZmVuN081OXFB?=
 =?utf-8?B?QjdLc1hWYXNQeHZ6UjFhSTNKMVEzclhpZ0xWbHZvSG5odGpPeWN1dmt5M01a?=
 =?utf-8?B?c2hJOGZyK0hZbnNpaFZOeGN3cytMOFdzKzNkLzVXME51cFkxakNjTVlYM1Yy?=
 =?utf-8?B?dVRERWRseVFkT1RteWI5anl2MHRLM2FLcndwSmJ5Nk83d01Ua0gzK2ZvRUR5?=
 =?utf-8?B?dVpQSGFheDg5cHpKMURDZktZeUF1THV3RFRVdEtWUm9QNWZYVWtCNVZYQ3F2?=
 =?utf-8?B?U2lmWUE2eXdFQk1YMFV2S2p1UklIVXFBd1lRVXE4M1RoV2RDZ0NRdWRDNURO?=
 =?utf-8?B?M0xSSDBjcVFqNHBLVzhiUDNUaEFSb3YzY1JBTlVBaFB5VGhlYzltbFB1bkE1?=
 =?utf-8?B?aWtsUlRhdTVObCt6WW5Lc1JjWFl1UUI2MkZKWWljMFVvNGVPMHJmbzlSQXZa?=
 =?utf-8?B?L1dnMmNFUHdhWEMzRnJjMFQvRFRhQlU5ZlIrUlhvdnVmOVJqSWowbERQZVZ5?=
 =?utf-8?Q?YvClG1ShOKmaUPm3QHstXilP1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f781f76e-6666-4fa3-e7b3-08dceed66c68
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:06:29.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXVwS5M1OBs1zbq739P54cVRInSz0GKCUi5zkjWP81QXK0XbANg0vAyU+zV+C+b/egfvPu5av/ai9xTEufG4BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174

On 10/17/2024 05:05, Dhananjay Ugwekar wrote:
> Replace code chunks with function calls, improve readability and
> reduce redundancy.
> 
> Base: superm1/linux-next + https://lore.kernel.org/linux-pm/20241017053927.25285-1-Dhananjay.Ugwekar@amd.com/
> 
> Dhananjay Ugwekar (4):
>    cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
>    cpufreq/amd-pstate: Call amd_pstate_set_driver() in
>      amd_pstate_register_driver()
>    cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
>    cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call
> 
>   drivers/cpufreq/amd-pstate.c | 79 +++++++++++++-----------------------
>   1 file changed, 29 insertions(+), 50 deletions(-)
> 

Thanks for the improvement.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

