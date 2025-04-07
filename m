Return-Path: <linux-pm+bounces-24881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B996A7DF20
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 15:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801A016C1BB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED08253F1E;
	Mon,  7 Apr 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUvuB2V6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A8323E349;
	Mon,  7 Apr 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032323; cv=fail; b=BH4MkKdhtEAR6UMZU9UXfRiDWw4yVG5+4ATwszoWkpSbpJGERxCoWAyC4fC8P2NAXCfMrUV4mpQjHGjOlOGQLW/y/3GYDFy17gkob16pzp+1IZkeivH2k2dlZLQHuAvPMZRLfdvChaA7mho1QQp6a+Gf8otGNm3mobPXXyNLnV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032323; c=relaxed/simple;
	bh=w4OfzNfSmHYnhS55LioHbYDvLV+IwyrFnL+4bSZ6mwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b3w+FXK+iS/vCc9JKKjBZk9WAjcltWeMIJng0Ag/1Qt0HKebO5Qj09tz4oTNZl/r8Va9IBOetBBiVxHE4M8/IWlNhzDsQ3dcJM7lVkD5muFD/BhuyM20WGaEDPxrM48c9tJomwTNPIPFRXBvpcmBBIl8yble/Sq0R17y05y6vf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yUvuB2V6; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yURfWJplhuIaToK9xedeDh83uBjE5eSo0P9UgYyehzU7uzKWvMj1TRtSoyDsbHqn3okcH/Np/VIbYJvXel20+C20D/QqvV18lMIMuy+3Dz05gHRko/PKUqXpu0Nc7ja9Z65GWD+drZTYnmYXC9h+cO/3t/mcn9SkSjhVCg9QpJqZJtMsfJb2uTufqZ0v7pFfSKAvxFwMHU3R3CePubHBQ0ivZ5qPQFRVkW+++Eqft+7uB5slz8RK7+lfNopa17sYt2Bs7vnLk1Kt1dlIiNkfORCvCuEv9Ujqpxl6fgyOGToxNfaaQ4v4ep9k0yTAW+yb3Jbx2d0IoDO0aZFPDAtFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj5q99zMgLdVLsHq4sH8EfiJJjIMsDvFICCzLr8kQZU=;
 b=D+8UtmBuG0KApgB+rOfpucA5lbYD/o1RSWB1Gjb+F7ARqZmmG9pw3MHjBL5K2KNHTxbckAxjStmAM1KpxCm7uhC0LGujBN6me/2InfNJ5hsuy5NwDqJfmJ5Nr5CPeSSVRn4SIqyYii99YZWbbaK5BNyXA2v9fbIpt3wZoxhuzIgV5aZew19nrmlOnLReQ+qqMEL6FfJaxgKOpFB8SxNC2/mlP3dBKnG6bF1PAQOQEk3YKr/h4SVkhE80+VyH1LyHmrGJbLFVtJR4AnusdqbKH4porDhyzR9DiDtzJLHJCNq24DjfKbycfiqgPmmuNAzljlJRGjOhgyG7e0BQ0eow3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj5q99zMgLdVLsHq4sH8EfiJJjIMsDvFICCzLr8kQZU=;
 b=yUvuB2V6sA9JYi6nMCXzmOR01vfXGvmRHhof7g7n7tFt41DTk8wvgTjS0q11FhpL5C2Hr1apqBqUvc6sDJKSDD58cvB9BxFgYtkoLU1Jz5af78sVhzvg9K9wo/oyZU8tQLonRsF2A0EWR7+8mEsEvNRfiXd3t58p3mmPFqClVmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 13:25:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 13:25:19 +0000
Message-ID: <2489c84a-580b-4cc3-acf0-110b5d1309d2@amd.com>
Date: Mon, 7 Apr 2025 08:25:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix min_limit perf and freq updation
 for performance governor
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407081925.850473-1-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250407081925.850473-1-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dc9ba9-ecc5-4617-754b-08dd75d7a44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d011akZnakRZUmZBVEFkU2hVZ1lJMVJmVko3RDRtRzlRelZQUzJmbVkzcGxY?=
 =?utf-8?B?Y2FWLzJwM2l2RDdGdWxhNWxhSnBPdVRPRFR3Z2gyZ00zMFdUOWFoOWwyZXJ3?=
 =?utf-8?B?SzFEbmdJTE5zSlRERmhYTS9BcnliT28yN2pHU3dOL0tJMUViSGkzYWVMRmdO?=
 =?utf-8?B?UTNhYlhPRTlwZWhrSDVBM0pmUVlaUkg2VldzTjdBMDY2T0Y3c0xpeXFtMzBS?=
 =?utf-8?B?R3FhZjBjU3AvNDlrMi9wajV6Um40VFJjbDRtMjc2UDhkdkpRV285aEFTbWpy?=
 =?utf-8?B?bldMNnVLS3FZNGFXM0J0RzBjS0JhMHF6bDNnZjBVNVZlTUpXaFVJSmdZT09C?=
 =?utf-8?B?bmMxY2U2MXJzQnQ2UzY1RGdCclY1Z0pGNHdOUmZsRVgzc3Bqenkra0FqRWJR?=
 =?utf-8?B?Uml4M3U4Zzk1ajhQUEY3aXViTFpSUUdjeU1jbmRhaU1jN0VZTDhwOGFSdklZ?=
 =?utf-8?B?WER4RmVzYWpvTjlqR2lqN3k0cWNPUU5GSHhyc3NGL3llUE0wMEJURVhzMmNK?=
 =?utf-8?B?NG9ETENCZkJKTWYxRFZ3aVg3dEhacTlpR2J6TWgxRFczbnZRZ054Tm5Zd3BU?=
 =?utf-8?B?bks0ZGxRSE96b2twOCtSVVRlTEdSZXNYRXpaV1dXanBBbzZYWVRaTmNuUkJR?=
 =?utf-8?B?OGFLOWVMYnpGMHhVM3BkZERHQmhFTlB1VDdoWlU4MHdmWUZWQ3BlQWNuR1I0?=
 =?utf-8?B?cW9WZHZoMXJSamR3a1QydWYwNFFzRndKSWpNeTEyaFYvSFBWNU5GVy9JNVF0?=
 =?utf-8?B?ZURBcG1QS3NFT3ltUUN4Q3JCQnZKTFNZN3NyZ0Rjb2R0dU5ZOFJ5bXpmNDZP?=
 =?utf-8?B?dkxCZUFvUU1YSE5yT1JlY3lrdG1ZTEI3N2VFNWdaY05BQU9LUEN0YzhiYVZx?=
 =?utf-8?B?dnlrZnMzM25vWW9aQW9wUnFCb1htaUZ1czliUThyMjRyM2Mrb1B2eVZVQ3dL?=
 =?utf-8?B?cEdjMndyOUxmVWVidW9mU00wWExBNFJZSFl5UGtIU3pOYXNpT1M2SkVLek0y?=
 =?utf-8?B?WG1mc3ZGaEFpWlVFNGkxbDZDQXVQRklhUWJ0OHB3dnB2SXhkaGhuMUticXBq?=
 =?utf-8?B?Qm1wK3BCZHAwdUVqRXRYVzR0NWZCZUMxSE56ZW93YkVJd1VPWGQvUzlXT29P?=
 =?utf-8?B?WkJFWHFXVDJYVnl4Q0VLbnlSWG05cmJYUDVxTjY5VWMvaWMzdVpXSW5Kc3kv?=
 =?utf-8?B?YkpGK3Q0SDJFNGd5VXFWZk5BWElHWFc3ZnFSQVNsR2ovSnkxNWFqNzg4MDVo?=
 =?utf-8?B?ZnJOUjdkbzJJNHZURWJBY01LazFTRUJrQ3hJY2ZsME43eU1TbDNwRzV3M0FU?=
 =?utf-8?B?MmZleEo5T1dpaDNyRnNBd0pPZHpEV3hRbzhEK3FJYUxCMDBoa080K3RZWnR6?=
 =?utf-8?B?ZWlEdkNHZ2FlSm41SWpMdFk2a2hlb0Yvblg5aDBoM0pXdHYxc0UvZDNqekZN?=
 =?utf-8?B?YS9JWDUvRVBveFdMWHo0M1IyUzZrYU1GbXpJb1dwb2NpNnAyQnpGV1RYUjZN?=
 =?utf-8?B?a3BGYmVzeU0ybE1CcC9Qenc0Zk4zaVZzbXQyOHRVdTBmU2RMaEJaZTlYVk9o?=
 =?utf-8?B?ZFhaSWpISFVkU2ZqbEVlSXVJWHQyQ25lbW5EcXF0aHFjaE1aOGttNi8zdWM1?=
 =?utf-8?B?UEZFMTBnY3JLU05GVHVzKy9FUE5PQ2tXRmp0UWFLMDZmeHg3V0tqNkhJcjEw?=
 =?utf-8?B?OEhiK0hzNFZMZWhWeXdMa2s2K3N6LzRCQ2lPQjV4Tmk2UGNJUm9QZGpNdzN4?=
 =?utf-8?B?TlNRNGZXTDRRUjY1bklaOUlHWWlnclBEY2tKTGU5UUtDNTM2WEFGYTU2cWI0?=
 =?utf-8?B?SHFwTzVtb2hrVkVNaUVIaHJaaUhaNXVYTkxyR1JkOGV5YTBxeDAvMHJKSm12?=
 =?utf-8?Q?11n6OIuQuMtuD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDQ0ZXlaM0J5R2JBV0ZkdGdRR1lORW5JMHNqZFFwR2N2RTZMZmxWbXV5aDlB?=
 =?utf-8?B?dmpTV0ZTUWFXNHNJeVlkcHBZblYyeksxMXYwY3l1R0M3bEMvZDFOS2I3TVV2?=
 =?utf-8?B?YkIzYzBwVS8rbng4K3Z0ZWYxRFZacDJuaWZVU05ZSUorWHAzNEwwUVlQelI0?=
 =?utf-8?B?MXgvM3dGeEFGTDlyT3NZOWsrLzRyc0tiQzN5bWh2V2NMeFh6VHNwTUIyZU40?=
 =?utf-8?B?QnJsK0JEZjJSZWZXTHhRc3A3cDZ0SjQzYzVxZCtWQlhMcmZubThBWWIzSDVL?=
 =?utf-8?B?WkE1MWpwRW1ydEl0d0x0K21OQkFsb2lqM1prVlhpQW85WHhyTGh5YnVlaE1N?=
 =?utf-8?B?eG1HRGRwNG5iZzBPMWhMQ2JwMlFock96REVpWE1oVlh1elBhVWpmZXF0TVlQ?=
 =?utf-8?B?YWtwSkN2TURJVG9GYm4wcnZaM1FURHdSOTd1MTZLZUVHZXliakpCQzJJOURT?=
 =?utf-8?B?d3UwWTVDZzJWWGwzZm9qQkJhbVlXbEtZd1paNk9UYi9WOG9NZWlNMk1QWTcr?=
 =?utf-8?B?TGZxaXIrOElFWTkxU1Y4TFdIRVdNK3Q0bWFGZWdWNnR4VmVFcGRVaFF3N3U1?=
 =?utf-8?B?bkNBZDRpdmd2a3JYWk93cE9qQXB5M2prQ2Vwb25PYVBRbHpOT3B6MGkya0JU?=
 =?utf-8?B?ajdxSVVTSFp6VklQMjhOVmw5QXVkZFh3RlZUNUUvMS9Ob1p0RHUzZitTN252?=
 =?utf-8?B?TXovT1lqVDEvNUVrb2REVmNLVVZsakpYY0wza1hNUnk3RjJKTjNDVHlYNWxz?=
 =?utf-8?B?Szdxb2Z2UC8yWVJzd0MrU3JDbkpJN2x5anJhUm5zeU9DZUtNVWJzZkovY0NO?=
 =?utf-8?B?clNKUEhrSi9BanNQZ2N2MGU4ck9qKy9vdzBVZnVKZ0hQTkpkQmpUbTNTL3pL?=
 =?utf-8?B?VFBpWWUwSVFXL056dEpFa3R1cFRaeTVIMXliQjJsZ2gwN3c2WWg2YTJYSm01?=
 =?utf-8?B?ODJXbEExNzhmUWNSa0x4LzFZcHNmcE9DOG0zOTFmTllNc0pCYW1lbkR5WWxi?=
 =?utf-8?B?RXEyM2hJWGoxY0NtVllWK25pVzVHRVZ4QldLRmlHOXpkdDQ3ZDJPQVZEK1hp?=
 =?utf-8?B?UjRra2U5d2hCbWRXQ0p1SERiVUl1bUwzOU5NODdFdGdNa1hXbzJjMXFrNGFM?=
 =?utf-8?B?bjdKN2N2R1JDcXRnVG9UTXFoc2s3YmNBL25FalNqMEdGVG10b2hzczVzNk5H?=
 =?utf-8?B?aTdZMWJZN3lGWDRUQm9FcEdHeWNDYlR1VGdTU2RZVmF5NlVoQnBvNDQ2WDZj?=
 =?utf-8?B?TmNQQ21sN1B0WGRDZnRrN1ZMaUovallmOHBrbWgzNERINlVNZVRjZmxsa2ha?=
 =?utf-8?B?S2k1elFqeFQxYW5aYXM2Y1hrWHZNYUQyYzFRQW9Ua1NKNDhtenAyVGZya1pY?=
 =?utf-8?B?MXViS0dCUlZPa0dmMlRaZXFTYkRnTG85elMzRHYrUnBFcC9hVmpVOFU0cnJj?=
 =?utf-8?B?SXhEdFgzVjBibUhBdEpWNzlxcUhDclYxbCt3TS92WDVJdHBoejBQbFFHa1Y2?=
 =?utf-8?B?SU5xNG1rWUZwVndHZTFwM2FzNEJBZ2l0N2hXbmpTbmZ6V0xCekJFMDFRNFZB?=
 =?utf-8?B?ZHdjN3plNHhENzJJWVd1Wm1SblFEaGlPN0RLeVppY3lwR29UWWFOYklZQXg5?=
 =?utf-8?B?WG1yMWRWV0l4cGhXdGhUZmJtNVVuSFozVG9pR21xNm01NndMWjVFOGw3dlg4?=
 =?utf-8?B?cmdKYTRmaDI1VE9QU2N1U0MwWVRseklCdHNMMGlxL0hPMjhJWWpZWUgxOHkx?=
 =?utf-8?B?a0NBU1VtUVNBQjdtRllGbEY3VXdxQzYvSkpJQ1BvS2l2Z0pWMzRRTFdua0Iv?=
 =?utf-8?B?azhOUXd1WHRqSm14cGl1Rit0UU5kUzBqeXllTTExR1FPLzhZRzNhd0NBcFhq?=
 =?utf-8?B?eThhamRkOWNOTGppYklvZzRZcEhlcHpCY1ZodzJ1cGcxTjVxZEl6Vk05MXNY?=
 =?utf-8?B?aHB4WmVqTXFmM0d0TlNENk9peDdEVzBXYjB6TlhkaGo0TGJCQWt1YmVxYkpp?=
 =?utf-8?B?UEtNeDIzdk1KWGVMY0RSMS91K2JIam1HemR4Qlp0YjJNNE1kVGdiSFF6M09O?=
 =?utf-8?B?R2ltbm9zSjkvRGJpbHpSdGRXUVBRREJBQjNPaFhsOUc0RzM5SFoydjNjU2V0?=
 =?utf-8?Q?fEWdoCSIUvDOIdqnYsKkVfJjE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dc9ba9-ecc5-4617-754b-08dd75d7a44c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:25:19.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHuq7pWgsDeZh1nLhNpzYrk6FfSp/8qy6BY3GQglw3zYf5A49593adzFjdcXKq4PUBn30nkKjKEbID/xR0SIPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991

On 4/7/2025 3:19 AM, Dhananjay Ugwekar wrote:
> The min_limit perf and freq values can get disconnected with performance
> governor, as we only modify the perf value in the special case. Fix that
> by modifying the perf and freq values together
> 
> Fixes: 009d1c29a451 ("cpufreq/amd-pstate: Move perf values into a union")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks!  I'll get this added to bleeding-edge and move it to fixes in a 
few days.

> ---
>   drivers/cpufreq/amd-pstate.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 024d33d5e367..76aa4a3698c3 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -607,13 +607,16 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   
>   	perf.max_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->max);
> -	perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
> +	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>   
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
>   		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
> +		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
> +	} else {
> +		perf.min_limit_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->min);
> +		WRITE_ONCE(cpudata->min_limit_freq, policy->min);
> +	}
>   
> -	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
> -	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
>   	WRITE_ONCE(cpudata->perf, perf);
>   }
>   


