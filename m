Return-Path: <linux-pm+bounces-7536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CF38BCEE8
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B5B1C22483
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172D6D1AE;
	Mon,  6 May 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UmRBzgK+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09CFBF0;
	Mon,  6 May 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002075; cv=fail; b=fY+JhpFCTAYSwV8UIj8NKkpwPFjnzT917G6b2257PAJx4PnL5bTKJeV+ZCIV0ScPbpXPlEmDt2vzRjSQDd8LwdzcveXm4r18CDUhOXty5rQ45inUFoYCZJOXxwNwbKV6ioN7qSK6LYE147RTxYbuTej+Efbv+xl5ZHXtOcz6JWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002075; c=relaxed/simple;
	bh=ixJknFuoqAHLa5lcXTW/noioQErh/IEqAsenPFFpFIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cICByyM50M4zw5Kq01VXNePg0xEtcRKTH/87qa6KqRizwoOtYIxVdIzutRpKq2nihMstbPQLc2/ivGcjujBvwZQeoB9q9URQVZfS/1UgRP7ZYRuJ0mb9fdhVrUqO8lzmfd6xtp3pdrtUXEZfpKgomkGl1Q+fxrEtrpqt/+EEn7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UmRBzgK+; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqKOL9+rUgRMgpgl8yh3BDq6nPRfnwJnhu3J65lkmLIiKw+wJHNekcp1GHxbuWePoWophAReD+KhNzLO+qQaXtAAL5RcraF/dh2xduLLrHXlnengr/n1p6KDlFNy2TeyKAFJsZFbczvNzMIcc4kxJIIDM3a5lZjd7xm3CXnmaQtcvEIzjvlXGxVyA8vC2CnB2Liw4pT2VgVtiW2lQzO4fH+aH4dU2cQ6te6+NIrt5wIyAe7h+k0JwVySpFQQe7RiGF5HYyw5hhPB/7iWIgM/ZtlGo8qaPdgdlIM3bRXHI+zujKkoutIddBsbBdUHzT8tX5KFPwSSnPAynOVCJfkG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8RMmcNxpUxd0GEWx4so1DCCXV6AwBajy3ac6MAxK2E=;
 b=PXY3+lMzOrgIVKQOzG5ME4sk5XQ+Ko9BUOaRbk0+L4XjTDgxMKI4cBi5NoRo7Z5Iao4xXf3EBTlq8zjJcKtolE3J56JcgXWvou5nCJZ/fsKz9OLs5oSdr9OqYUEEjGuT7ppuVvfS1g33dbJLByJaMnLR3svD+zmRrf7TjPCQP425tCNA87g1be582gfdltjWWF5SEw+/OtmK3w8vlA/nEbEOjV2L7stDu0hi2B0K58d2yFu9Im3lvnIccZ4eP8b9bh+ZtwtBnE6Nfcmusgl0RRt2h3voPeCGPeBztdk1bGM9mq8UoR0XuDk0zxQRn+prYh6po6kfBs9yx2RI+3K/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8RMmcNxpUxd0GEWx4so1DCCXV6AwBajy3ac6MAxK2E=;
 b=UmRBzgK+FARum909CMsGd8feqRCy2ofQ9VcqL1UgFjy8WpOmUu+oA+nkmjkzEd/naOF1gADfbX7UdRc7NRcHVdkNPHX0gnOJQECZUOGFCDCJhq/Lm32afP3YFZ/cmC3sx7maTZelpVhWm7Iy9cdekyeWWIyDfCSAAk1CO759rpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 13:27:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 13:27:46 +0000
Message-ID: <6d9dd5fb-0352-44dd-abd6-47d3ea050ba6@amd.com>
Date: Mon, 6 May 2024 08:27:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
To: Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, Borislav.Petkov@amd.com, gautham.shenoy@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com
References: <cover.1714989803.git.perry.yuan@amd.com>
 <d69d52290ec7ab4073b266348b3d7c0adf13ee30.1714989803.git.perry.yuan@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <d69d52290ec7ab4073b266348b3d7c0adf13ee30.1714989803.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0161.namprd02.prod.outlook.com
 (2603:10b6:5:332::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: f88a100a-e2e6-4bb6-961f-08dc6dd05123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHIyUjUxVDVTNS9lZloyZUNRUkdqU1VHRzNUMENpZC9tSjR2QzcvYmZyRGxX?=
 =?utf-8?B?eEFiZjh0NStzTkFFQzRuNmYzaGhzRUJIenpKVG56R3hJcmwzY1FkTWdpZGFu?=
 =?utf-8?B?UldWNWl5aEdmNlFwdFFaUDFFT2xtenJwVmNydnFvemp5cTdISTRIeWZMSVd5?=
 =?utf-8?B?TzZGc2RmeDJtT1FhUzVlMW5RVXU3ZzNJeEh5WEwzOUZ0R0V2Rk1sV05iMXVK?=
 =?utf-8?B?bkhuV1Rjdy9pZnAzNUYvbFF6MXREYjBpc2RyR1l5aXhWcnpUWmk5K05rUTZC?=
 =?utf-8?B?dzVVMW5pME5VOVdSRCthT3ZNVmpGOXJnWWhhd0Fva1pPTjFJc3AxZHpJRjF0?=
 =?utf-8?B?R1Z6SVBvVGNrN1NuM3VuL3k0WmF2THArYjRHQmlLQXVlYWdncEg3TGJuVGRN?=
 =?utf-8?B?WTJMeitBOFJlYVZIMTR1eG9hdVE4a1F6OVhBcVNYOWU5bHZITzZSVEFvMTVx?=
 =?utf-8?B?R2lvd0JTWjdVQ1pmU2xwVmlXNWVTODlwTmwyYTBPZk1wVW1KRWtYN2JWS2hQ?=
 =?utf-8?B?RmlrRmRKVkhpVlBwWTc1cXdVT09ZN05SWVFCSzI4dVpuZjFUelZpVnVTNFhX?=
 =?utf-8?B?RGs1ME9Cby8zWCtLaHdtdXBWc25JUEJGajRtbHhKZTZhRHNOQXVGOFJlemVG?=
 =?utf-8?B?QW1rWEh2a3VpT3k0dWhpSFhOaFVrL1ZNczN6ZGk1WFdBbElac1k1QnZPeTZR?=
 =?utf-8?B?V25OdnpVVXZFWjl6bFFDY205YjA0VlB1QlR0MWt1Qmc3YWNzMzRMQU1nWGNp?=
 =?utf-8?B?WnlTck9acVphQzdBMjBGSW91OFB6VGVSclI3TGxwN0VzZDZpam5IbU55aDdl?=
 =?utf-8?B?R1crajhpQzJ3akhyUm91cEk4dWNFZnBkUlphcjhTV3g5NlUrcHBoTXl1azl5?=
 =?utf-8?B?bzduNnYrY3BSckRqallkL2ZKU3IwdWE3TUFuRC9qYXRtMXdEQy9ZR1JGbnZv?=
 =?utf-8?B?ZGI4Ykhlc21VZFZYTEZKa1RkaTYxaHQxSERLZHRUQXFBUUtwaHRCV2NVM3Qv?=
 =?utf-8?B?K2s5dEZSa2NFRVJvRmhVRlA4ZTdxSjN1OWdRdDBlQ0hBdFB4UGZmUzhZNXhU?=
 =?utf-8?B?emg5T01iWmJnRFQ3cEZ0SlBHRGJVR3VpZmZ3dWhkR1pzK1BUanJGaENvNTB3?=
 =?utf-8?B?dmtSS0NnK1ZSS3RoSnRyOFYzNGtLczA4SFB0L2U5RFN3d3M5TW1CYmtzcmo3?=
 =?utf-8?B?N1JEcC9raG5xM3NEQU9KWnlucHpxbGw1WS9oeGlLM1laQXhzaVBYSWFuOG95?=
 =?utf-8?B?QlZtUlRidXZSVzhWbXVMNkVxYXJWVkpXbU0vZ3ZzU1pLZSs1bHIvK1RreVBL?=
 =?utf-8?B?UkxiQklIOXFOT09KdjB5OTk5c21aN05vT056RVlqeEtIaktjMkYyL1dHQ3Jy?=
 =?utf-8?B?RjJGbkM2Q1E2bnlXeTdhdTB6emJXREh5eTV1NnhiRDZDMWNQQWxVNjUxbktK?=
 =?utf-8?B?eFFiWENtaFFiYTl3RTlXM1J6eGcwVWM5VTJ4alJubDd6RXJZbndHaTllSzVO?=
 =?utf-8?B?RzAwNnRicmt4Y1p5dmVvM2xuNDdlRWxUTjNnazhCN2N6WjJqdFRHeUx5TTQy?=
 =?utf-8?B?Qy83cVU5bERFOVhUVFpBUndRQzVtd1gzQXVQbjFSOXlNdnJiQk1CYTBqNG9E?=
 =?utf-8?Q?rLkjCWqQofcX6+EZPtqCdKRR8TWjDCZ9VZfXULesty68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdqd2pjQjhieHpocGNyY2RmajFqSmN2bElRSFI4UC9vTEpCYzJNSTBHRmpW?=
 =?utf-8?B?cEZ1aHdEVEZ1a3lTNTVwNWVzc3B1ZWpFYjdzT2g2S2NXV0VzdlFsU2c2Q0d0?=
 =?utf-8?B?M1JRMzFJVTd5c1hRQVpVbGo1NEZvR0I5OXVCdS84cjdrMEdpUXB1QlhjZ1NV?=
 =?utf-8?B?dTNDMlFhOGwxa3ZxYmNScVRmN0VBc081WVYzbmUwTjRGTCs4OU1MZmFWNjRt?=
 =?utf-8?B?V3JsKyswdVl4NTZnUVpQSHZyWUlwSGJJMEkwc2pzeVl4b01YaW9Zc1NrNUVh?=
 =?utf-8?B?S3JhbnduT0QzcFFHeUpjSVp6RU14L0VSS1l2VHY4ci9qak5iQzZOMVc5NE5k?=
 =?utf-8?B?ZDJRTTFTOXJEZXRFdmpERkVPTzdFQ245TjV6cm9LczkvSkxOMG9RUTJsVzRi?=
 =?utf-8?B?WnFKMlN4Z2hQNXJBT2JuZEk3ZjIvU0dlNmVkMkdvWHdmcjRzQWRCRUkwVGhM?=
 =?utf-8?B?amV1QUQzWHl0WmFJWnAybVFrQVJTZ2xmTEhIU2x5UFFMZm1PRXc2QXBYdGhH?=
 =?utf-8?B?bWNsYXdFYlQ0cHg4SzdkRCtVSFQ0TXl2aWw1MnVzd01uOEMyVnBIWDQ3UlFJ?=
 =?utf-8?B?b2trRWJOcUpZQVFxUjJJUGFZMHJTbU9KM2NVYXJmL0R4TDFXNFg2UktyemJQ?=
 =?utf-8?B?OFpWdE1EU3RhNm5NWWtXSDFIRzUvM3l3M2ZqeWFkZG05czg1MFRHOU91RjdL?=
 =?utf-8?B?bzNDYUVOU0NZUWxpcHVPcjc4eThHQmJvM2U1K1NCL3ZGcEFDbnpCemIyakZ5?=
 =?utf-8?B?WmpTdXJUcVlhOXNBMnpZb00yREp3ZmtWZmRIVGo4UUVKVlFlU0hjNFhOOWR4?=
 =?utf-8?B?TUVwOVdRZ055c1FMT0hteWprTEp2MTJOK3hld2h3M1pES3B2WWJOTURScDN5?=
 =?utf-8?B?UCtiQTQ2NTRvSnFKVGN2NnZleWV4b1E5bWZnckNZckFOT2gvc3poNVpJTDRx?=
 =?utf-8?B?RlE3R3JydmdWY3JObDcybHhJQW9kOTQveDlUbjJUemxJWmI0aE5xZGdTR1Fa?=
 =?utf-8?B?QWU3NmJsNzBjODRkWEl2NkVkQll5Ym8xeUJZRUJ1NndHUzN4MWYyTGFSQmtQ?=
 =?utf-8?B?MWo0YjU4WVNHTE92VHN3ZzRWU1lsMEJxTUxDYS96a1hza1QwWHJ6eFVjT3lP?=
 =?utf-8?B?elNvM28wYjk4cExHL3ROV3QyczgzaWh4RWw3cjFHVktXaG1SR040OWsrUGZa?=
 =?utf-8?B?TXZpVlNOeS9qUFd6ekJvbmk0a2RveG9tYTM1d3MwTFV4SHBrbUZwSjlTRWgw?=
 =?utf-8?B?U0FqNHE4VzcrYlVWWHFJZWREVit4a016bGxUQlRDU0J1SCtwUHdERDNGWXdC?=
 =?utf-8?B?d1dkelVmSzdZc2pLdFNJazg3U3JoY3o0bE1Cbm82WUtSSmFZS29ZK0d6Y0xi?=
 =?utf-8?B?dXlsa1lvQ3gzOFhyNjUwM2JRNEFPMWwxNkplRFZKZ1FpUUtPdzh5anc5eVc1?=
 =?utf-8?B?UkFSVFExLzNSOHUyYkVZcVpvbGJ1emFXcVgrMGliUzRoLzZpRDQvd2dSZWM5?=
 =?utf-8?B?Q3l4WW02T3AyZmtLRUlGV1hpVmhGOUZxQTVZVGc4bDJZbDMzYjJrYWV4L25W?=
 =?utf-8?B?Q0p0TE1TZ1NSZ2ZkVE1yWHZhcHBUTHlMRVNhanZUR3ExSXQ3WVUrMk13dnZo?=
 =?utf-8?B?WkV0eFNCQ1llQUgxZVE2K0tyUXlTdHF4UklxMDJLMnF4MmFFZ1JjOGlkeHJM?=
 =?utf-8?B?ZTdGOHl3NkJMamwrNnBkTjNiazdKanZ5TkNvRmtjTTkvM3JNOUNpTnd1V2Yw?=
 =?utf-8?B?WGw5azhZdVNNalFQTEcxUjFXM0YrQ3ZlQ0ZLdW9VUHJCVkJaOWNQd0FoNURL?=
 =?utf-8?B?QjgwTWlGS3FkRkx1OHpXa1ZNN1JFN3FwQm9KbEtHNkNGT2gzTXA4NnVHZWE2?=
 =?utf-8?B?Z1RUeGdHb0ozY0l2UzBhZTVSejIzb1ZxUjVzU21iTkQvTHJYZEJoZitIaCtw?=
 =?utf-8?B?alpFcmhwRDBsTXBpVzZtWEdIRFVyOXRMWlowQVFHWDRaS2ZKNGdiMWltWDEw?=
 =?utf-8?B?Nnl6SXA2QzhFMWdrSTlWdFNXa1JQd3FpR2wvcVR4S2RaM0JGK25zSFg0VEN2?=
 =?utf-8?B?dW0rcm9CQloyVjgvWjhhNUxpWWJFWnBJMEd1cHB0TUxiSkQveStVWWRmT2NI?=
 =?utf-8?Q?vQhGSW7iaigyqH7LgfMkeNhxt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88a100a-e2e6-4bb6-961f-08dc6dd05123
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:27:46.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrQfF/Ug0Rj05YTvm2AQPRWLnacAmgC3hiJBR3+EjpG94FoFnbfyBQ0kAk1a1h/ZpEmQtH6bpkAd+VzEG+TYNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465



On 5/6/2024 5:19 AM, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.
> 
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

As I mentioned in v8, I think this makes more sense as a "per CPU 
attribute".  You're already changing the MSR for each CPU when you 
change the global one.

I think the only global member should be whether CPB is supported and 
you can use this for the visibility of the file each CPU.

Could you justify why it's better as a global amd-ptate "driver 
attribute" still?

> ---
>   drivers/cpufreq/amd-pstate-ut.c |   2 +-
>   drivers/cpufreq/amd-pstate.c    | 114 +++++++++++++++++++++++++++++++-
>   include/linux/amd-pstate.h      |   1 +
>   3 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index f04ae67dda37..b3601b0e6dd3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>   			goto skip_test;
>   		}
>   
> -		if (cpudata->boost_supported) {
> +		if (amd_pstate_global_params.cpb_boost) {
>   			if ((policy->max == cpudata->max_freq) ||
>   					(policy->max == cpudata->nominal_freq))
>   				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f7dab0f7b452..f81fd61dd2a9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -686,8 +686,10 @@ static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   	}
>   
>   	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
> -	if (amd_pstate_global_params.cpb_supported)
> +	if (amd_pstate_global_params.cpb_supported) {
>   		current_pstate_driver->boost_enabled = true;
> +		cpudata->boost_state = true;
> +	}
>   
>   	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
>   
> @@ -1293,6 +1295,114 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> +static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +	int ret;
> +
> +	if (!policy) {
> +		pr_err("policy is null\n");
> +		return -ENODATA;
> +	}
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			cpufreq_cpu_release(policy);
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else
> +		policy->cpuinfo.max_freq = nominal_freq * 1000;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amd_pstate_cpu_boost(int cpu, bool state)
> +{
> +	int ret;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy) {
> +		pr_err("policy is NULL\n");
> +		ret = -ENODATA;
> +		goto err_exit;
> +	}
> +
> +	ret = amd_pstate_cpu_boost_update(policy, state);
> +	refresh_frequency_limits(policy);
> +	cpudata->boost_state = !!state;
> +
> +err_exit:
> +	cpufreq_cpu_put(policy);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	for_each_present_cpu(cpu) {
> +		ret = amd_pstate_cpu_boost(cpu, new_state);
> +		if (ret < 0) {
> +			pr_warn("failed to update cpu boost for CPU%d (%d)\n", cpu, ret);
> +			goto err_exit;
> +		}
> +	}
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1303,6 +1413,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1327,6 +1438,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>   	NULL
>   };
>   
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 8ba5dd4d3405..56f616a5cd0f 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -106,6 +106,7 @@ struct amd_cpudata {
>   	u32	policy;
>   	u64	cppc_cap1_cached;
>   	bool	suspended;
> +	bool	boost_state;
>   };
>   
>   /*

