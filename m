Return-Path: <linux-pm+bounces-27173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864A8AB7DBD
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383558C27F5
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF62868B2;
	Thu, 15 May 2025 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s4xE4lhO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064071CEAD6;
	Thu, 15 May 2025 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290124; cv=fail; b=IqSt2NXAmZ3w7ANqY9j+oG/cFqUujgm/1yxDANgfCfqRSzGgEkDkrGHHm8jrZavmJ4ihRZeUo2hyqFO8iS9M6PlhWAFlQFnrjuYR9Cp15ZeXj4+oI25QGrzSkYWFGd/P326oLNPhVOrYmCjzhe3i/TEDvgJuoPFFyBhw4Z+6jHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290124; c=relaxed/simple;
	bh=nroq1w/PGMwX7Nkbqdq+hTk1WgYCMANLV5mqUQGwdZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JnmfAnjvDiNuwR7bGQ8SEGWLRh7EY++Dh21r3LihdeN8SsfFK42hdRS0TBHxhjnaf1VkQm+FsZu8Ircr0eRVmUohe5kQiekpyz3nraXeqMSBPwch57Dn2OMP7eYDHWlIqXDdM2TMxaWWO7lw+wwMZePcR7sE1giR0GjQ/lPjr9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s4xE4lhO; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO6ufkQazbvK5nrruEMEBPW8rjLVKKChp1vmqQIP2KGwEs5poDz1fcFAyMpbP6smNIfaBxNGRzFHF9pwQaMasSwe2hHkARtk6vXliyQEXBHRHnwOpQlcsJLTcuj4GEbznjTGmB0/VhB6y/koMcz6anJfEKBPYm9aq61GMGy1O5z1Oj+CyXlDBnIq2IGvs3stEXueKWFj6YTOEn7B3YzvYWjkKDcteFgu271KvEP9NyJ/Z7pdkaTi+ZPvxDX2i01GEkJ2xl2//z5kz/zrzOIO7vKXkJ2DxPF4zDTFLKhUT+KBOlO6eLb2GvZxxds9onPyowK9tTxCqv1r2Nt0ApRToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr7/ClEL053tipYfYK+OEUU/0AILwmMO8W4zB9KKOVo=;
 b=Lrgs3HOoNvxGnLwx3U8xi4sZi2Xqm+QziPV/4wJW1i4S8a6XQArNt+FcWldPCkrgTBBVdE57XfGax/Gch014tS0gGIgwnTuUvtT0qHgzDUvoFrdnrA2ln85aPbI3OUlhNFZmHJWkn6R1qMNhUq5gRpNkyInYCOosOAJ/+WlskjEA+WTDc+a6VNt44v501vNHWOs+lRK5++oZoKiPsU9bxgZA3BHnr7eTZM5U464F01LRRmmLMPbiyNgvkhSDx7yKn8Qq/6hCjjKlpWzq+xDvi+Bd3p6apf42vV7BHwOGWpoD3AXNBdumbN34dPVVc66VveFWZcUHCMgM4l9XU/uBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr7/ClEL053tipYfYK+OEUU/0AILwmMO8W4zB9KKOVo=;
 b=s4xE4lhOdQUP3bNVzwTlf/XUiErIf8pG6NRoPVwa+hhlNeAKeP64KQ24bg3VFsg+NK+HTHfCvH9DtJV2GogiI9P0gBl48yTrF2ejrHOs7US8ynLcR2fpuou5BGKjUyi+2AgquxZAHI+F0+CdvvZbInr29z6LDe/Nz0RXLJ+1OVSPrLV69ntncsCLQrhB8+E9qULiYf07xzBGAcaVNfy/agtIAN2jnsJgtK6lfw5+yDmD3qLpyiCL7Yv0iQdDrmWLaVnvaUJFj9lpS9UiJNAS7yd1c7pqHSmDbyMGGlvo+pvIS/fwahA3IEiejCzEGF/wlWRp5Qo02gwkftfrUuPgdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 06:21:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:21:59 +0000
Message-ID: <4a9fe001-9104-4a11-986d-02651738d84d@nvidia.com>
Date: Thu, 15 May 2025 07:21:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Aaron Kling <webgeek1234@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <da080e61-4e54-4334-a239-1619bf8fea0c@nvidia.com>
 <CALHNRZ9DKf_p5y3K4yVF8wDm4S0jRB-NSF8aZB5CsYxk7GmyNQ@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CALHNRZ9DKf_p5y3K4yVF8wDm4S0jRB-NSF8aZB5CsYxk7GmyNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 6363e703-e204-41e7-9eb5-08dd9378cc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTFpcFVYdVZtRFRkS2FWOWZsL29kc3pQdkoyZ0VEdEw1TUVIRUlhVHF2cm0r?=
 =?utf-8?B?UE5IcHErdmkrc2Z1eEhwYS9jTCtWcmtONjA2M2pSNDdPQUlvVjdsaGZVNlQ4?=
 =?utf-8?B?OFhTTXdId05oZzdZTEZUa1kwNWwraHI0SW1qNmJRYzhBaUNQdUx3ZzNWdzgz?=
 =?utf-8?B?ZFBzUHkwNUgrVWlCNnE2TjNRa0tuZ3dBcm05UEZUdGEzeTl0Q1NwbnZYYk9r?=
 =?utf-8?B?NFVtSXhXZ0dSYjhrOU5ZK2FXUGtycTRwbk5UVU9SUm1KTmhYMlMvT3huMjlh?=
 =?utf-8?B?RmhXK3RvMUhjbCtrbVJaZDUwOE5nckI3WlgvL1JPS2VaU3ZNaDJGODBPTE4z?=
 =?utf-8?B?cVN3QzE2aWcwdmFzV1BvT0NKMzdiYlVxQk5JbEtoMHBqMzlJY2Nhd0haaGVW?=
 =?utf-8?B?UmxraytTL01RdHMwRmcxRkJka2QrSW1TMEFxSlBUUWM0SzBTWWlSUWhwWWRx?=
 =?utf-8?B?MXhnVHllYnc1bGhlQ2dsNXVTaTVucFpaeGt4d1hmOTlSQ2VyeDJEN28vSkdS?=
 =?utf-8?B?UzY3a2lweWFGcXhtbU16QkI1L0VwektiRkNMZ0VNeFFsOHgrY2I1Qm5qc1Jh?=
 =?utf-8?B?K1c4aUFqREt3SVFvWXRLZ1hzRDVQbDV1WEJHZVNrTm1ubHdZc1pVY0EwbEFX?=
 =?utf-8?B?b0Urc2dkNTVyRkFpVGhJajdNTGttNnU0NXJwNjA4Wk9uTW0yTXdWVmpmRlNp?=
 =?utf-8?B?K0Q4SUptQmlIbC9JRVZPS3FRYkhPNmd2U0VPRXJ1bzFqQnovRlZiZksxeDkx?=
 =?utf-8?B?QlRNb3hxTEdPc3N1QXBLRnlYSW0rZGFCSlNySEVYUWRTVE5PNzdpeHFqckYv?=
 =?utf-8?B?QzR5aEpVSGk0Nmh5RmlGMytoSmZLWVg4dlZoMmZKR21LSkIvSU5TOTVGbWFZ?=
 =?utf-8?B?QUl1TWFIamtRc1ZVVS9ZQmlZNSttSktZTnJEelVCanVVMmxuTXV4WWlUUUpu?=
 =?utf-8?B?cDVQaGh3RXdaSE0xNGphU2ZEQndkdCtvZmpwTk13Zld1TFJJcXNxWjRlNEwx?=
 =?utf-8?B?ZHVhSFcveGkycmErWCt1cDFKWld1ZlAzelEyQ2pxWTVYeG1NSHB5dFAvd2Ft?=
 =?utf-8?B?K0xJRlB6VWI0UzA4K1dTK1Z4ZjVCM3VVY2ZpVytVUEp3N28rV2dZSE1ZWEYw?=
 =?utf-8?B?WVk4a0IzZERudG9tdUFsdTZ2TzVGNERuL25kUTByRjBPcnVpWWNWWWx4ZzB1?=
 =?utf-8?B?ZDl0d3c4TEE0T2tjQWI3Q1FHRlZhUld1R3g0WHIxZGNHTTJyUzJVbXhqcG9o?=
 =?utf-8?B?NWdGbUl3UjhCSzlkNmRidDQza1JWOXZZYVM1UEhBd0hSbHdBS0VMUHAyTkU4?=
 =?utf-8?B?Q3czc2ZKVnU2czlnb3pTNTU2MGhxVHJ1eDJFNFBjYU9TWVovS0FTejBRNTlP?=
 =?utf-8?B?OGMxcXNDRVoxc3BwVGMrRW1nMFVTZWVJQVdxcVplOENmSEpLdllVUWR3STZm?=
 =?utf-8?B?S3dZNmxDZkxJZk04TEJKbjFQc2RaRk5JT24rUUpZcDI5OUY2R05BeGROR09j?=
 =?utf-8?B?eFhtZFdwMUJCWDVlU3RmMzh4Uy9rejV2ekVkV3lzS1VWdTlVWndGT3ZrNk95?=
 =?utf-8?B?MjVUcFFqU2cwVFV3T2NHWWFJbENMenJETWZrU2lUbmlBcURQYjhiR0RGYVBk?=
 =?utf-8?B?bFJNMEdtQWdGNWpidjcvZFBpKzNxYkwzTW1RQ251ZER0U25KdGoycVphM1Nt?=
 =?utf-8?B?TmtTdmJBRlUxbzRad1VUZFBSdVIxanUrZC9WUFcwM0tHV1RGN3JpaXVSYW9k?=
 =?utf-8?B?OEUwTk8xYnZLRGVjczlzQm5vYVBabDEwck1oeGpDTS9UdWt5VC9rNXpJRVEz?=
 =?utf-8?B?OExKZTBuK3FkRm5iRUwxdVdmSzVkWVdDSWt4ZzY3aUZwRXNzZ0VoaThoWk83?=
 =?utf-8?B?WGxobTJyM1RMRUFacnFVZEo5NnpGY1YrR0ZpeHJSSUhIc0NCYTZhV3o3cGZ6?=
 =?utf-8?Q?JXx06E9FOd0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1lXd1Vzai91TFFubGF6TkZ2bnVXc0VKTERLWTVRSksyVE15Kzhqa0pBNU00?=
 =?utf-8?B?ZGpBaUR2Rm9GamMrNVFNcFlrUWZLOGhQMk1uMUtJYXJBRnV4WkhGVzJqazd0?=
 =?utf-8?B?d3NYWFpSUUt0VFNBQUc0V1ZmYjBJeHhLcSsxdHcvUzZJNDJ0ODI4elZrcldh?=
 =?utf-8?B?Q0tXVWt5TDRhUG1Yd3pYTDhScERGLzZaVTg4TTUwWmZScEpFWnVyVUF6WUU2?=
 =?utf-8?B?emtWc2tTRlhYcm9vSllucG9HN0xGOWhDcW5FeWVvSFBLMVkwVzZFalhzVVlD?=
 =?utf-8?B?QmxQWEtOY2pHc1dGOG1waXNML01DSTVqcjQ5RzBzU3djUmtUQlA5TDlhZHQr?=
 =?utf-8?B?emQxWFVrMGl5ZlZxbURqWVlrTVdJdjNXSDNlUTh1YUkrcHVleExBODl0MDF6?=
 =?utf-8?B?c0h1STNKNjhLSGhHdkpHSkg0LzZLRmpJZGJBclRKamRZUktXam93L1BXSFNS?=
 =?utf-8?B?NG5abG9URGkyT2padDlKZ3V4S0IwdmNRcjRvcnpvM09PbkJBZ1ZwZFg0MWlP?=
 =?utf-8?B?ZDRLMzVjZ2NkNlU0cWVva2FHOWdacS95WHp5ZW9icVdmL1ZUUktKQ2pTSm1m?=
 =?utf-8?B?dUJkQjRvMnpQYU9vWm0zbTdSR2NhbEFyM3pYbWhRRFZFQVNIS2I1RmM4dEtS?=
 =?utf-8?B?U1l3dzNtWEhjUTFiVmVzYzd6WFNEbDBhR2xrZWlwUnJhV3JRaCsyNkRFeStS?=
 =?utf-8?B?VFZvTnBtUUJBMXJrZGpjTjZldUtkNFB3dXYvR2VGakNhTGMzZERqZWh4Tk1E?=
 =?utf-8?B?SWdQeWNUWUVqNi9CdlgvWE5vMnNmTHNCZGxhQ2VOQ3VJSktRVExadDVGdUp2?=
 =?utf-8?B?V1dPSGphck9OeVFYMlFDSFo2VXlUa1FLVnNmRXVWLzZ5T3RsaGFDalU1Wjho?=
 =?utf-8?B?ZjJEZDl4UkJHZVBhckQ0VjJNZWdwU3lrODBFV29WYXcrUGdyVUxxeTkzOFdP?=
 =?utf-8?B?eU9OTjE2Tm9zUElvNVp3ZDhDUkliY3hvRWRXNmgvc3RmUG9iYjlkTGZHeTdU?=
 =?utf-8?B?YkZROFIvN0F2OCt4N28vQ1o4OTFROU0zRVhxdW90VGhIUE9Ma3YzZ3ZLd1Qz?=
 =?utf-8?B?UWpCWnA3SDlRS05lelBGRjNPSkthZE1odm55c29JNHZUNlFqZytLVW1EeWlo?=
 =?utf-8?B?RlJiRHZrM0U4QUNRZDNXSSt0RE15RlFMZ3RkTkhFOUgzMTRLeDdPTnBwN0Yw?=
 =?utf-8?B?aUJkSi9kNUlHU3NPQkdnME96TVN6Zm40UjZSK3M2azNTaUZCUGNHanlORWVp?=
 =?utf-8?B?UU1MVW1CeWhLdXZoaXNYVzR0Q0ZQak1VRXhYejZuK1dTbWhRM0g4U0gvdWsx?=
 =?utf-8?B?WEpNWHVpOEo4bUZPYlcxTWQvL2ZzajR4VEVYN1VjTTVEeFc1ZnozS290SjVK?=
 =?utf-8?B?MzlGWGoyTUxMWS9tdXhUZzg4cHBiZ0JxZEZsSENBNjdBMHc2dUhjbzhmVk5T?=
 =?utf-8?B?Z2cyMVNXS01QZTlNQWRJTlk3NW93QW1uK0NSeERvUHd1bmFjVXJ3d1lUMFN2?=
 =?utf-8?B?aXNYSjR2dExsa213U240eWtSVzJjSnFicjh0bzJBTkdudXhpZ0tTcWNlUEdp?=
 =?utf-8?B?NURsUFJvOGZVcTUwOG8rVzBNNnM0UVdCSkpOYUlTMnhGRDN5OWo4czRobXhH?=
 =?utf-8?B?TGV5TkZrRFBhVkRFN2tnTmJUOVVrVWh5YmtUMmpzWG8rWHMrWlEwQUxmQVVY?=
 =?utf-8?B?Uk9vTjJ4eHloYW03TGU2Tk1oTjBsSnFObU5uNENkdXgwWlFhZzYxcmNkMVlv?=
 =?utf-8?B?QTAyTm1CcGpBU3AyRFB3RVlOdGZ3cHhuWGhVeDRpNCtLTHdOaXExRjZXVVd0?=
 =?utf-8?B?OGFoenZibFg1bUtoVnZUYWU2dzJnN2g3RExmQzd4YXNjazl3Ym9rM3pZanI1?=
 =?utf-8?B?TSt1bWJTQmRVb25kNzZJczFyN3c4dGEwSmpMbmM3czdmWXJ4aXFrS1F0Q0Zn?=
 =?utf-8?B?ckZVWEZTekVRSEZoWGRyR3IrcEFSQmNMb0tpekhMYWYzellmTG81NU9vRm5o?=
 =?utf-8?B?UE5kWGFvcmZrQS9BdVhSRTI1T2NLVVpvNDlzQzQwcVFrVnoveFMzQm1odW02?=
 =?utf-8?B?L0p4dkd0RjZucndUU0RSNlhZd2pjWE1Ta2xqcUJVSmZrR205Vy8yMHU1aEhO?=
 =?utf-8?B?SDUyRldhb1RkZnY0Z0pyeWE5T3ZMeGoybTllVitYSXdYaVVpbHFMUEdwb0Ro?=
 =?utf-8?B?UmpuOC9jajZNZC9mRyt5YUJZRXF3cDl3WHVOSDUwTksxSWMxQ3kwQzIvOXlS?=
 =?utf-8?B?RERxb2VzUk9ZSmczTEhVM2ZoaUpRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6363e703-e204-41e7-9eb5-08dd9378cc29
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:21:58.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ10uBgsOmnPQDqb06Ox+/TQToIbygzVxj7BV7i0eDwJxP406Z4MR7F4EIconZlrW+2zFGfGw+LH2BSCveYl+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537


On 14/05/2025 17:30, Aaron Kling wrote:
> On Wed, May 14, 2025 at 5:32 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>
>>> This requires three changes:
>>> * A soft dependency on cpufreq-dt as this driver only handles power
>>>     management and cpufreq-dt does the real operations
>>> * Adding a remove routine to remove the cpufreq-dt device
>>> * Adding a exit routine to handle cleaning up the driver
>>>
>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>> ---
>>>    drivers/cpufreq/Kconfig.arm        |  2 +-
>>>    drivers/cpufreq/tegra124-cpufreq.c | 36 ++++++++++++++++++++++++++++++++----
>>>    2 files changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>> index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb996eb7ce980da41ee 100644
>>> --- a/drivers/cpufreq/Kconfig.arm
>>> +++ b/drivers/cpufreq/Kconfig.arm
>>> @@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
>>>          This adds the CPUFreq driver support for Tegra20/30 SOCs.
>>>
>>>    config ARM_TEGRA124_CPUFREQ
>>> -     bool "Tegra124 CPUFreq support"
>>> +     tristate "Tegra124 CPUFreq support"
>>>        depends on ARCH_TEGRA || COMPILE_TEST
>>>        depends on CPUFREQ_DT
>>>        default y
>>> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
>>> index bc0691e8971f9454def37f489e4a3e244100b9f4..b6059c91f2474c56809c403eca94eacf51df734f 100644
>>> --- a/drivers/cpufreq/tegra124-cpufreq.c
>>> +++ b/drivers/cpufreq/tegra124-cpufreq.c
>>> @@ -16,6 +16,8 @@
>>>    #include <linux/pm_opp.h>
>>>    #include <linux/types.h>
>>>
>>> +static struct platform_device *platform_device;
>>> +
>>>    struct tegra124_cpufreq_priv {
>>>        struct clk *cpu_clk;
>>>        struct clk *pllp_clk;
>>> @@ -176,6 +178,21 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
>>>        return err;
>>>    }
>>>
>>> +static void tegra124_cpufreq_remove(struct platform_device *pdev)
>>> +{
>>> +     struct tegra124_cpufreq_priv *priv = dev_get_drvdata(&pdev->dev);
>>> +
>>> +     if (!IS_ERR(priv->cpufreq_dt_pdev)) {
>>> +             platform_device_unregister(priv->cpufreq_dt_pdev);
>>> +             priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
>>> +     }
>>> +
>>> +     clk_put(priv->pllp_clk);
>>> +     clk_put(priv->pllx_clk);
>>> +     clk_put(priv->dfll_clk);
>>> +     clk_put(priv->cpu_clk);
>>
>>
>> If we use devm_clk_get() in probe, then we should be able to avoid this.
> 
> I can do that. There's a lot of other cleanup like this that the
> driver could use based on newer kernel apis, but that's out of scope
> of this series.

I don't think that using devm_clk_get() is out the scope here, because 
this would greatly simplify the remove.

Jon

-- 
nvpublic


