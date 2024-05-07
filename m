Return-Path: <linux-pm+bounces-7598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7633C8BE768
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962DCB22A10
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4931635B3;
	Tue,  7 May 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0CctJMmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C614EC79;
	Tue,  7 May 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095421; cv=fail; b=SdGVG8IIIe6zZwgA/IJJjyPeDbe/L+cYWv4Be2p00g4OHrZdc2Ejru6b2NqeO4yHScnksmc5OAKBJSn+kzxfVzRWv4rmbLs+k2VBsb2u5cW1u+Z9LDfHV6yL9v3nvU2PY3OCON8O5wGo2+JhJ7vZH7trS++DX02T1hhi5IJORiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095421; c=relaxed/simple;
	bh=2KYUELBHq5nD89N7dMaA6jAjZGG1+KesX/UGzlK8Ic0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UoUWIjCLK5FYnA5/+tbZHqtuo/rmyl2XWlR8HkgvnV9pGCkbjnxpplhhuMQnotiBNTTsq7HxW9jd9xox5savMzdEsGdfJK05XAg9HLjcCiv8Zs5zMhJy4l+EPzmqQ0iuyodEQFc1j4ku3KR2FX/cBP/YFl10BAT498rVOpYd6Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0CctJMmY; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqfJzmOIWOzNV8fxHtISDNEkMvMe5nDLKIFNr0Lrda/8jkM5R6R7nPiDiexVVYIUpScQPtpGFA/L06cuT0u/+tF4i7Qk2zms++9AP/oZBh+fAMKR5AwBzx8RcoxljrGNDbu6+F+e5A1rDkcVifZpQELTRXyhtqplDx9GSpMFTfehCBfdqLjRXx9WGdDccCcZyMRN5DZNkwSXas1wL3VIaoRFSEDGbwrpQXdnAiEkuAT2balP/H6YAXc7nbWFln7D4bZA3B1H6NSOoL0tdg5w+kTqEEAZyuQtPSvnLxwCZ70Rl8F5eweuHbhnqWGp47QpguslPtX3QpjQqpMEZatXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGMvC8mJAFMonaqNA+gwvBIu6uk3C4imjMkF72gsvTs=;
 b=gCHNVxmMK7jGgQsM3hNifn89qL6e4T9eHRNlWxpY/2X6AkTIqqZX/HLS5g4LSfH6ZGUpSYdXrGI3poN2OyfW9oSlqGpqICgZM/GhjA1zFBZ99AkmlAAuujlbCk5Eg2B//GYFFXY++FJU9al77Kt6vtmnPf9jmsejMqlWogtm5BDLTmsObGJhi0PiigeGeSAEYViv7WIfCn6r3nO6lM/NHiN7jH7qr+Vcpla/4RsthhZfNLpHjIcVU/tB93YD7uuOnTB6Ca11hQMleWGC5VMauGsvRjAbzqnGv7U1H8HNTgIMDRDSWgXcbSQXoinegiUHoSYnby1naNsf7i3np4I9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGMvC8mJAFMonaqNA+gwvBIu6uk3C4imjMkF72gsvTs=;
 b=0CctJMmYMa8HhO6ES183rQsPT75UzWh43ITab18Xcs7NHNA+eKN7kE2/aT7gamHaryaeLIsGgHDlbN5g+0/heujvHkK9vjy3jDm80h1AAqnsLTDTg7t9BEu3JjJRnBCmTJpPhMNEKn93Ng2aoRsvlu/MuLKHWbDd/kb1qYkBpP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 15:23:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:23:34 +0000
Message-ID: <5fc36c91-1552-4929-8fac-c76b217e1c03@amd.com>
Date: Tue, 7 May 2024 10:23:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] cpufreq: amd-pstate: fix the highest frequency
 issue which limit performance
To: Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com
References: <cover.1715065568.git.perry.yuan@amd.com>
 <c8feaf14acbe2e8288a5e8e927b8da479819bc71.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c8feaf14acbe2e8288a5e8e927b8da479819bc71.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:806:f3::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a78d553-9076-4afd-0279-08dc6ea9a91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0Z5UWRoaXNKd1RtTTI1M3JOYzlmY3NQQ1I4ZjVWMmxZdkJKbXlFL1dWNElE?=
 =?utf-8?B?dm1RZkc4RVdaaFovMkNwTTNIVnBzdUJSOGxKMVYwY29tdTlHTHFNditMTzdF?=
 =?utf-8?B?QzJvYTY1dFpPTElpUGhTZTJCek8rREFTeXFGWUloakVDak81SHBMWWFQTG5u?=
 =?utf-8?B?R0pkSUpXazlPK1lXK3NGNkE5OEJRM0RTNGdhQkRnUENuL25tMTQ2dkMrNTRr?=
 =?utf-8?B?VnVOdlJYalZIVnQySmlTVGpkSXNrQkw4UzkwY3ZkWXpCRjlvMTI4UG1ZdGNQ?=
 =?utf-8?B?Y2RyQzRLNVhsenp5V1NzYll5M3dwc3RBUWt0WDAzNmNYZWRjeEJqUktGUVNO?=
 =?utf-8?B?RmEyOUQ0bFRXYWZCWGJsejJiU0xCMEw0VHc2Z0NqTVNmYkRicXNHdUVRSk13?=
 =?utf-8?B?L2VpckViZy81RVpHZndrbVMrc0JrRXZIb1A2UXMwNytldG9TMWlhWlk2M2Ir?=
 =?utf-8?B?ZWk2dFY0UGxMVVdneGtrOXZ3VXBSL0lCU2V6WmwybEFvTkJnVW9RN2JHaUN1?=
 =?utf-8?B?Nldmb3k5ZHlIcGRmZjhIV2JUNXgxQ1Y2RCtPZG9WeUNBWEZzODVWS0dLcGJJ?=
 =?utf-8?B?aktHUHplNnhneVRuOUYxK1UyUTJzdW1BaHR0NmsvSURuYWRlcEVleENGUDhO?=
 =?utf-8?B?UHloaEVHT3dreEt1Zzh5SWc4YVk4blg0QU5CUzlTSGVZWmF4dXV5bDByN0E5?=
 =?utf-8?B?c05hZEdXV1JvclV0KzVzbUVCVHJWcEtwak5RSTJrSW85cUtBNC9xcWlGQmFP?=
 =?utf-8?B?VDY1RUJWYlJwVEdoRU9mZENZUEJUR0Jobm9HQXR5TDFmQjkyZGNJVnVHaTZU?=
 =?utf-8?B?ZUZRdEdCTmFrZWp4ZzU3alVWL0xzVllMa2pGS2Y1QzROUkxoZVdDOUZWdEJo?=
 =?utf-8?B?MlBWQ29Odm1udjltVytwOEIrb2lVUjRyRlRLSlJBOXV3ZDFyT1N2bGx5QjdV?=
 =?utf-8?B?bE5uUHEwa2JMaDkwaFkwMUFjQnliNW5LZ1o4WHh5SE1RcTEzUGIyRVpQNjdS?=
 =?utf-8?B?dWRoNzJiV1UycDVQVVVsSkVJM3FsM2wzYXdWZlFtQW9Uc3NyTHZhaGsybXdt?=
 =?utf-8?B?YkhtOFhoMEwwNUJSeE1lVXljVGZGVEhsaCtHVGxpeFExMVJPamdwVmprQStG?=
 =?utf-8?B?bHNrckVtR01DTE5IVGZSc1liWG03SzUvODBaaWN6TkF2YmVrdkJOaUJlbjJ4?=
 =?utf-8?B?NTI4OFBLT0N3Q0RrVGY1TjZMelhSQ3Y3SmJnVjJnNTd5VUVEUnFmNWdqdzBB?=
 =?utf-8?B?UEQ1d1JHUlljbG1uclhKejJNQm5CRDFoeS8xbFgyN1M0T1BXTUFjSEphRDhu?=
 =?utf-8?B?NVBUK1IvaHlHcjB1Skh5K0lFM3kwdUhqS3hmeG9OWVdFVzZyOUtTS3BOcWk1?=
 =?utf-8?B?S25FZkExTENiQkRxSzZLWUxRWkJ0WUQ2dVlwZFl3VGxpb1NjZWszVXZxTmFt?=
 =?utf-8?B?THArVVEwQW9vbUhMRmlqbUp1WWhQZmRZNGFPandEck5DS0N2dng2YzYrTkxm?=
 =?utf-8?B?NUNwYWY3emJFVkxjSlFnVkR3TGJ3eE1BTjNSSFM2MlMvbFF0cExFa3hyakxo?=
 =?utf-8?B?cUw5NGIybHZMUlg2bnUyRm5RS0NKMkh0T0FTLzVCYVJwVFpIWXZNeGk2M2xv?=
 =?utf-8?B?am9EbzkwYXpUeHNKTE04ZGNYTHN1b3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnFrYk03M3o5ZWNTTXp0a1BDYkR4RS82QjhVcnlyS0ZPeTRsR3UyNSthK1VL?=
 =?utf-8?B?eUxzc0pjWGNrZ0lvYUE4MjVxczhaSHd6QWszUStGYnFtb051ME5PWXU2Wi9j?=
 =?utf-8?B?Q01WbkxEVkRPNEJxR2N5MHdvS0F0ayt2Z0hrK3dlbU9XSURmRmpGQkVaYVVT?=
 =?utf-8?B?RWRFUUxnRDk4Z0dpVkk0L3V4UFFkL01VWDh6TDNiMlpJdktUbUJDNlF1NW5D?=
 =?utf-8?B?MFk0bVVJaFpmZTdZbEtadXVOUGdLK3cwdEJ2cDVxVXhqMmx3T3duOVd5R01V?=
 =?utf-8?B?TE0vc3c3QVJiKzFPZ3krckZRbnYwRVd1Z2dKVzhOaklZUDgvMW93RnM0NXh0?=
 =?utf-8?B?bFVyOXVSWTFxMy9LWWozME45aGorY3k5UnY4Q3c0SFpGWHFwVFlFdzJta2JK?=
 =?utf-8?B?Nkd5SDdOeCtHamNvMWFuand2b21TUHJNUVFiaFBCT2h5cGpuNmlIaWhoSjA3?=
 =?utf-8?B?L0hSdzlRbUxHb1VWc2tSRk10czNHZWVNM1M5bFNzcy9rZjFhTWdjSFZPek5v?=
 =?utf-8?B?R04waFZKcndyTzRYN0k3WnVhQXpWZmpNTGRuNXRJd2pjbWxEcCtsR2dsdzl0?=
 =?utf-8?B?U1VOWnBaeG5CRDNrejh4blM0YlROMURxR1JNbXZGNS9KREkyR3JienFGUzhE?=
 =?utf-8?B?bGEwakR3UjZvWjlaKzJCUFEzQVBGNnFUMGlCV3JVNTdKd2ZaTlZkeUsza1NH?=
 =?utf-8?B?b3Y2c0VhV09UaWxYbzNHQldwclhMNEdGY0JiL200QU9JRjVFd283KzBZc2ZB?=
 =?utf-8?B?bFJ0bGhRNnkvbEk4RmhJZ0VFSjlTTSs0WVUzMXlpOHplOVhrVVFOcm9lYUFY?=
 =?utf-8?B?OG9NWVpaQ2N0ZUV1Z2gvQkpLNW5Oem42QjV1UERIcEFjUTNZcCtZRFhyT0N3?=
 =?utf-8?B?UXVBbm1YLzVUZDBhRnBFZ2NsVmhFS05wNzdvNzJUUkt1WmhITkd4eXNNNVdq?=
 =?utf-8?B?UVFUOW1pMjgvS3hSRzhzSDlSanl6T2tRSUszbldTaXFBR1VlY245cGJkbzY4?=
 =?utf-8?B?cnZuVmNWZWFCZ2hiNEhMNEM4OEhkMHpiWDhDVmE4eXNna3VHbGhEaEJlY3ZP?=
 =?utf-8?B?NWhGRE9IcXBkemw0dytKRVFxYmZsSHpYWnFGRmtjTHpKdDBtRnNpMzBHenBn?=
 =?utf-8?B?N2o2WTRpQ1hSTGwrWGFBQ09ac1BzQUlEUFdFTk9sWkpQSFlHSmcyQjl1UXgr?=
 =?utf-8?B?b3JzZjhiVEk5b2VVUzFkWEJEY255YlMzMnZLZkJTZjQ3M28vREF6RDV6Y0FZ?=
 =?utf-8?B?TUlKaXJ6cGRQTSsvREtjcVRjTjJlMzgwajFrZEczZ2hGQXV3ZWtIWnZ5N1hV?=
 =?utf-8?B?emRZUEIyY0c0VkJCNm03b0g5TzFQRXhXWWtkVG9DQk16dVNyYjhMZndPRmZ6?=
 =?utf-8?B?RFJCanlNckFkQ1BVZzlhMVZoNENkN3BIbFBQekh4SzNnSWxOSDJBWE55dmcv?=
 =?utf-8?B?R2pRTzdWR213YjZaa2EwcVRFdlJlM3BpUytnMlRtVzhsd1U5NXU3bUdrVmtq?=
 =?utf-8?B?dmxnaSsyZ0tlQVJ3VVY4bndUWDV6cG5sak42SVZyZkZHcm9EYlQxRjNNcGJD?=
 =?utf-8?B?NWYvamN0TnhBcys1dnZjell2RmZ5UlM2SWlRcVNSRWhjdjJMMGlXUmpZL2RN?=
 =?utf-8?B?ZG1pY2Q3YmRPdTIwQkczcGdXZ1Ezak9MVWFrYVNHM1kvUUhUZndzNk5RTGIv?=
 =?utf-8?B?QkY5ZVhWSEFrelJUbDh1eTgyUTZ3b1hLbkIzOVBPbUlEOEpqaUZNS1Vuc2xj?=
 =?utf-8?B?S1hZTXFRUkF2cCsxblI5WTNacG5oNjluT1BRUTg4VWkrMlpaczc5OCtnUHpC?=
 =?utf-8?B?R0FWd2hLMGd2YTJjSDNaNlBDSWUrNVdVNDIwaXdxUlh3MlAvajdEZ3M3NUxi?=
 =?utf-8?B?ZElWOU9ESTlhMEJuOVp6MFlld2RzaG5Yb1Q1YlZmQ2YrN0xJZzMrRnVxWFBk?=
 =?utf-8?B?VkJIVFZoQ3hTamR5ZE1ma0gyZUdSSHRhd0llQUQwb0JScUlzbDRNeTQ2U3ZS?=
 =?utf-8?B?UjJSRWpubWl0R1lTekFUMEFFa1R0RDFwM1hEam1sY1h2cWtCRVRzZHVYK0oy?=
 =?utf-8?B?TWNxQ3RCUUQ2SjYyY3ZmaU9jMk5PcWYxbUFpOWI5cktHRi8xZWtma3doUEdz?=
 =?utf-8?Q?kgDaJWaeActDwL+E59YM40Qf5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a78d553-9076-4afd-0279-08dc6ea9a91a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:23:34.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NVVoBu0GH8uAUwT5j+1xYl1FdxWuG3uNtQkeLIJRGdJOXzsT9ZZUI7Ek4LYanLQ1zdFwMqvPCt6HK6hoijFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700

On 5/7/2024 02:15, Perry Yuan wrote:
> To address the performance drop issue, an optimization has been implemented.
> The incorrect highest performance value previously set by the low-level power
> firmware for AMD CPUs with Family ID 0x19 and Model ID ranging from 0x70 to 0x7F
> series has been identified as the cause.
> 
> To resolve this, a check has been implemented to accurately determine the CPU family
> and model ID. The correct highest performance value is now set and the performance
> drop caused by the incorrect highest performance value are eliminated.
> 
> Before the fix, the highest frequency was set to 4200MHz, now it is set
> to 4971MHz which is correct.
> 
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>    0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>    1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
>    2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
>    3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7fe8a8fc6227..3ff381c4edf7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -348,6 +348,7 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>   {
>   	u32 highest_perf;
>   	int core_type;
> +	struct cpuinfo_x86 *c = &cpu_data(0);
>   
>   	core_type = amd_pstate_get_cpu_type(cpudata->cpu);
>   	pr_debug("core_type %d found\n", core_type);
> @@ -355,6 +356,13 @@ static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
>   	switch (core_type) {
>   	case CPU_CORE_TYPE_NO_HETERO_SUP:
>   		highest_perf = CPPC_HIGHEST_PERF_DEFAULT;
> +		/*
> +		 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7F,
> +		 * the highest performance level is set to 196.
> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
> +		 */
> +		if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7F))
> +			highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;

I agree this is the right type of change to make for the reported issue, 
but since it's actually a performance regression from 6.9, can you move 
this to the start of the series and add a Fixes tag and stable tag so we 
can get the regression fixed for 6.10 and 6.9.y?

This will of course mean you need to adjust patch 9 as well for such a 
change, but I think it's better this specific patch goes into 6.10 as a 
fix and the rest of the series can aim for 6.11.

>   		break;
>   	case CPU_CORE_TYPE_PERFORMANCE:
>   		highest_perf = CPPC_HIGHEST_PERF_PERFORMANCE;


