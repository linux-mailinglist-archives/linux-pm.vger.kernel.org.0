Return-Path: <linux-pm+bounces-10136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B229A91AF61
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88051C21308
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E019AA47;
	Thu, 27 Jun 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CSAqwSjk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969C22F1C;
	Thu, 27 Jun 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514642; cv=fail; b=rhskIh81q4W1mB7XI/GuREhutWk2QwePyX9115WtaDrkvLyT2js9FUvTo29I1z/d8cD70N7lm2jCYxrF3SCXy39jA++eYSO79wwqN94XSnDCwTLfJpnfhKKHerj5F0eqqATB2WK2Tzn+bOaQFPwLEEMq/1BgOokrEGtx7cbogVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514642; c=relaxed/simple;
	bh=a8mh1kwUN+kzQSm9k0VKL/ifq7cEuRZ3PakR3KmSQ6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C92lbMv+7v54MmChsb8DEeQrFqRVQbkI3XXbA0WLw0/EuzvxI9QAaJLfC/ZRBWtj4rJ1fE+e3SVioW6dkrffkhf/zGys4t6SWsK522zRShT57rVqhkiuAqEakaCtlB+KmvXStiI8469OFroIu2oEhNJDmiYtoroyW4E88+fXVA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CSAqwSjk; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fbv5Bc0v88tsd1rKfyXH5WD50+4dHOuRlcNiyU1vBL5XerIyC+AU0jLYvAvcboi25+tsbKZ19j+KbsqA8gcbLmPjrg+dVK7REqbfkTOFM8GsVEr9f5AY6UfVdbqGwlvbkC2eh1JLKPPFEbof1dgunQtN6y1BpDjk2JHdy/9uXalKYKptDZLK2iDmL6yl2ZlsAZH1/H7iLDo+azBjKx/H4nV9pzpx8y/jbbeZHJrk3jBFunTJFTSlGOOQdRb7Al5h8Ffr9FYJ+RHcntFAZ1/hKKId19qKi0OibFXuXBDNITDT5GFCWoZPOYvJzDsdA4ZThHAPh9RfQariryivBkGWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3UcjIoFe9VeQw8B+T9mFe/95f9NLhRN4e/JTye9qkM=;
 b=FOzQRCJJAsqYoanNjlpoP8DNOeDXsI5xjtfVyuXeNd9QQgXXoqLcjhC1H1WC1zgmApU3BlVXMIiE0bn5XU4l5rXKpQMF8q7tNIdRhFr14BH+c8RzayazHLMsKcKdJ8UUHMzY3+rAF5m/ARFShxM4FsbbMnJ+rSkFAm6ZEIrvWhUf4zurp72kwwWWlKvI+fRz+7Edp6ag9EtpV+Gz1/x1c37xRjdatL5/K0ujy8LPezbc5xnlYzSps8yfiIjDmD2eHP73qhXTps/1OPjSyqPqfzoPuRTtwc+kCAgP/edbtEE++6mNGisYpSd13nzXt/6XkZkVkMNcM59+IBM9yE9awQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3UcjIoFe9VeQw8B+T9mFe/95f9NLhRN4e/JTye9qkM=;
 b=CSAqwSjkZMLrWyhun2qT2DEnyQMfRvlJnfAGdaXzUr9qNKaBNY1nkTL/oDTDHNM5/nffbqqeSBmstJxJxyf1dpFQsdshZBWltnDZBLgDaqN3oGGo2XjZWai7hrw/F5lwyOiE//zmn0TA5kbdKi8dX8urle78cCi30CyxcTIDwkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 18:57:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 18:57:10 +0000
Message-ID: <31841424-c6dd-49e2-ac2c-2394662b7f30@amd.com>
Date: Thu, 27 Jun 2024 13:57:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] cpufreq: make cpufreq_boost_enabled return bool
To: Dhruva Gole <d-gole@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627060117.1809477-1-d-gole@ti.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240627060117.1809477-1-d-gole@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0087.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee92f77-7adc-4398-8fe8-08dc96daf2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sy83TzJlaEIvdHRWR3VJTHJlU0xaTjhCQ2paOGZvT3N0V1JzMEtLQTdzSWNp?=
 =?utf-8?B?NmxOYXExT1NoOGliK2dyWFZYc05BQnRpemtDVTZiZlNPdE5kSEVrNDZRVkRv?=
 =?utf-8?B?RHhWeUtIOFhpOEorZzE1bWtzdjFBbUMwVFo1RUJ2b0tnK3ZKOXlYNXR6eWVF?=
 =?utf-8?B?QkxEYmZMWGxGM25LVFF2MytXLzcxdXVnazVicWl4c3hRb0U0cUw5QnlLcE9a?=
 =?utf-8?B?NjN1dDY1ei9INXhkMm5JVndQQWVTMHlQcG41dXIxUGZ3OWFoYkY4TlZMSnVM?=
 =?utf-8?B?aXQ4SHVwVUdRTm9zczlZT2FBTkI4NG1Sa09IaDRqVjVIUG5ZR1QweVI4RVBK?=
 =?utf-8?B?akxNRnBLS1VaZmptVkhiLzdaU0dCZkR6WWRza283UUwxMi9qcUNWcGVHQm82?=
 =?utf-8?B?ZWtjNEpHSExxaVpaK1h5bmVXdTBMQzFOOEpJSjBIcnQ4YStrT2dRUkxkTnZy?=
 =?utf-8?B?emtxQzJtNVhoM3ZGZXNpaWhNby9WQmdWUHdkQS8vNDBPcDJxZHh4aERNSUh2?=
 =?utf-8?B?bG5JZnQ3Q3NyRE84alE4VTBQSEpEWWZjRHJ2S1ovWk40Y09FYUFseXg5NExV?=
 =?utf-8?B?ZkMyNEVTZVNpT0pmWHh5YU82bVlJOURZNEx6Z3FEOEx5V3B1alFMMy9pVEhU?=
 =?utf-8?B?Z21nQUcrRk11T1BuSGR4UFQ1VnM2L1dscysybUZmTE1tL0xIdEgwaC84T21H?=
 =?utf-8?B?ZE14VmhJZW9lYk5OTCtuMjNydnR2ZmRsSkt6K09HYUlKRjhKUlpmUmhoQ2V4?=
 =?utf-8?B?Q0EwWTgrZ0N3Z1Rld2ZyOTVQNzRDVXdpakthL0tEMGF5d280R1lHZFJ6N2p3?=
 =?utf-8?B?K3k0dzJtb3RwSzZ3M21kQkdtUHVjMTFhYm9aWFJTa3BzL2JkRUtxdVZMNFlq?=
 =?utf-8?B?eXgyNmFNL3dCTlJiRkN3aFVIM2FQYTNzaThwcDl0SEtPRWx0czR1VFBDZ0RO?=
 =?utf-8?B?TjBvdXBGb0F4QTdWMGJCeGU4WVJRU2Uxc05CRzFFQk51MzluQkRrVzFQWnov?=
 =?utf-8?B?TWU4S3hPd0lhQmdOS0UwR0ZqZTBZZHl0SWNwVml2Y2lyMGJuQzlNbWVKcTg2?=
 =?utf-8?B?NXhIREF4OXVwU0VjcWRtZWc5TGRkVTR2b2hnYXBZNzNTNnZ3ZFRwZy9EWGlZ?=
 =?utf-8?B?VWF3STQ2aFNTR3BYWkxrQjUyRjk5SEZNOEkwSW42WXRYL2h6b05OeWpydCto?=
 =?utf-8?B?NjVldEpmT1JpVkNZVldXTGZoOVJJaEhSOGltUVFoRzBiNko5QVlSdmppTWlH?=
 =?utf-8?B?ZGIxeHd1akozY0NGclhrcXNHY0ZINTRlcHB6TGhXZ0pscnNiVGsyekJmSmpn?=
 =?utf-8?B?azJzU21DT25IV05sQUhycTFyVm1LYy9LQTZaYWZMTVhRQmJpNU41RWJ4dk84?=
 =?utf-8?B?SFdVRTB6OEVhY2ZPb2kveHRJZnd5SjRSWXJNQ0pjd0JKL1hmREVsSFRFYU16?=
 =?utf-8?B?RHl2QVFiWVhRVmZEWUo4VUMreUF1RkdyMUV4NEI5Z2JXRXFQbHdXbk96RnBL?=
 =?utf-8?B?T0RONGJ6WHNPT0JuMUNuczc5MU40ZVo4WnJVWGphNTFzYjVCY2VnSjVQRkpk?=
 =?utf-8?B?aGx0U2pidUxkeHdTWTNpT3dFenhGSlRsZ2szUjZCRUUxV0UvVy9BSmRid2hK?=
 =?utf-8?B?QXhMWTNXdWYzSXpmYVhmYzVHVC9ZQmdKV2V4ejFvalZhdEk5R2tiK3VzK2Vk?=
 =?utf-8?B?bXhJd2dRMDQzV3B1S2pzNU5mK2lsbG5mTzR1M0RKanJzWVJRTzVrcnRCTldY?=
 =?utf-8?Q?cgJrA94tY15g09la3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG0wRUppT1hwUEhPRkt6Mm5vbi9KdVJEdmNpWjFMWjgrR0pqZmRPbG53Q01N?=
 =?utf-8?B?RmNON0FxOGN1bitKWHhpNEVhcEJqcDNNdUlNdnl0b1NGaXhaM2ZuZG1MWC9P?=
 =?utf-8?B?MXpsa2JoWjlBaVdrc1NBbkJRSjQ2ZVQxRnJkRlVZLytoZk5TckgwOE4rOTNY?=
 =?utf-8?B?WDBxQ0JUdEQ4Mk5OVXgvbjJDV05wbjJRUUd1ZVMybGYxUzhyci9PSUs2MnJ1?=
 =?utf-8?B?cWduUDNNS3ROYkUwWkZkUDYvSlFHSk9ma1BGcy9tL0J0U0M4Qmp5NDhFazVv?=
 =?utf-8?B?YStnd1Z3TjM0U3lwMnJBUFFMQm84bHJ4azdwQW4xYzNMZmtKZjlIeHVkSTM1?=
 =?utf-8?B?ck5jdnQ3KzlLY0k3V2hkQ1V3cnpFQWxqdDZjd0ROZVoxRENXTVJsK0lXRldY?=
 =?utf-8?B?cGowMWV4V0pjTisrcXgzcGJ1a0dJcTZ2cDRxcVIwV2VMdUZQS0FqMExLUW9C?=
 =?utf-8?B?UktjRGpIc2NFTmNSUmM5TDB1aWY2SnQvZTJkc1VrUzg2dGJYUHZYT2VTUEVp?=
 =?utf-8?B?YU0wNXkzVFAwMWdJMnhNenZiYWtXNi9aVFF0cGVhRm9HSzh2S2pYRHltMUZN?=
 =?utf-8?B?VXlhelE3Wkw5Zk1iWVV3LzJzNUgwTWRQbnZONTNtWUFCOVJUOERaSzQ0OGlK?=
 =?utf-8?B?bS8xbytnRU12MVMrQTRxemtnSHZOMnpDZ2JGRHJ6dzIzaGxBMXFxd283ZjVq?=
 =?utf-8?B?WEhUaWQvREVuZWtqOWtqQmFZWVZ4MFhRZ2ErenNKQWlpWW54VlJWbnRKOGJq?=
 =?utf-8?B?cFdMUU01TVFicnZmZzVkWFdGUDlIM0Y4T3JHdmN1K3BRejlKYWQvak04Ky9G?=
 =?utf-8?B?RithYWlVa3JsczBSYlpHSHhsbEtvemtFcE9XTDg1eHlrT2hLcGRUTnJFc0lv?=
 =?utf-8?B?LzY0T29EbU5lSFQ0QVoycE5jS0pWNU5wME9Md0hiaUo5T0FLMVM4eWhHRm1I?=
 =?utf-8?B?eW0veWRYSTlaekxuVXNZM0hWQjM3SzQ0VU9TNUdyY1lLL2hnazlGYXpYV25a?=
 =?utf-8?B?K2ppKzM2TUN1TFh4L3l2T3FVUDV4dVZHRWtRclBuYmxuUUNVenE3ODdub3Vu?=
 =?utf-8?B?UzB5QnBsZXZlS1lnd1krajZueklUR3hkd1RBb295dHVVQ0o2czloZmdyTmor?=
 =?utf-8?B?MG1XRUNuMDFJSUQ4eEdyR1h1SHczMERGRkliQzdiVlU3b2s1QWlJOXVZRVJj?=
 =?utf-8?B?UE5TTWVRbjBzRmZBRmlVdWdnWU1WMjBYRE5HdXJlN25sNTBBalZtWEF6eUhC?=
 =?utf-8?B?OGdYaWdTQVh5MExpUjdJWmF6Um9wVCsxd0srOUx1K1QyU1RveHJCT0hJWmpE?=
 =?utf-8?B?M2lyc3dNdC8wY01JbjNLaVkxZ2hTNG8raDZsc284K0o1MDRwdHQ2VkhUalZj?=
 =?utf-8?B?RG8vN3laRWpKU2dQbk1hb3FMdzgvRkRSRmlpbXh2c1NEZVFXOEJrMkVrSDR0?=
 =?utf-8?B?SCt1RHJrVHNLaGo3Q1I4U05HYlB3Y3FWRXNHcDllbzFmMFpEZDhaT0F1SDgr?=
 =?utf-8?B?blk4aWpPV0xPcEJ1aUxPMEdsZDBjSFVyYzRseTBkUFhEQ0o2VGtHRDRFYWVV?=
 =?utf-8?B?SXlpaExBaS9VNUxjaVJZWW00dDNyekpUemErMWlTbWk3WlJGajRsbjNiamVQ?=
 =?utf-8?B?UXpSN1gzY1pJRFAyUW9HWXBTWW50bUpSd1dGQVRIajV3TlBzWXV2eDlhZGdU?=
 =?utf-8?B?WXYxUEk4M3hFcmhJdXk2VllHZFZUdy9kSjFMVW84Zk5tamJOc0h4M0ROL0M0?=
 =?utf-8?B?R3RNdlc3Rlk5cHl3NlNmVThPVEkxWm9qRWdtbm9kRHU5N0V5cWduUGtPb3o4?=
 =?utf-8?B?ZUlESzZSQ3BVZDd0K3ROZ3JTWlB2U2pINHI2TjNUbUVwVzVCS0xnRjNwQWcx?=
 =?utf-8?B?MS9vdm9yYVN0Tys4MWluMnI4Yi9jcXJkNHhoTjJYcFdvY0RkNER2eFI5RjhY?=
 =?utf-8?B?UFRzdnU0MzErWkxJU1NWMmdQNEhweFdrSndaSk54Z3N4aE41SzlXY2tjQkh1?=
 =?utf-8?B?TDN5SXFDSnI5THltckRUVnUrVk1MQVlMLzRaS3VJN2JjblkwVEx1U3pqTXBM?=
 =?utf-8?B?SzhiT0s3cDdLRHluSjJIMHljUTVkQmd6MEdvR0RwWlB5R1JsQVFrNFZPU0Vp?=
 =?utf-8?Q?NHiCeJcmaHXcZ50muk+0eUErH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee92f77-7adc-4398-8fe8-08dc96daf2e9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:57:10.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YXDhA/h9iQxZ9poToIR9tg6yeO87CBEL/+O99CejxhYkSTQoizrGm2LLJnpFcNt8cCy3RuaX1TeACPIvwo07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

On 6/27/2024 01:01, Dhruva Gole wrote:
> Since this function is supposed to return boost_enabled which is anyway
> a bool type make sure that it's return value is also marked as bool.
> This helps maintain better consistency in data types being used.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> 
> Changelog:
> "return false" instead of 0 as per Mario's suggestion.
> 
> Link to previous patch:
> https://lore.kernel.org/linux-pm/20240626084354.1762483-1-d-gole@ti.com/
> 
> ---
> 
>   drivers/cpufreq/cpufreq.c | 2 +-
>   include/linux/cpufreq.h   | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 82c500389a40..709e7b1f9826 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2873,7 +2873,7 @@ int cpufreq_enable_boost_support(void)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
>   
> -int cpufreq_boost_enabled(void)
> +bool cpufreq_boost_enabled(void)
>   {
>   	return cpufreq_driver->boost_enabled;
>   }
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 20f7e98ee8af..6f57de7de433 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -785,7 +785,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
>   
>   #ifdef CONFIG_CPU_FREQ
>   int cpufreq_boost_trigger_state(int state);
> -int cpufreq_boost_enabled(void);
> +bool cpufreq_boost_enabled(void);
>   int cpufreq_enable_boost_support(void);
>   bool policy_has_boost_freq(struct cpufreq_policy *policy);
>   
> @@ -1164,9 +1164,9 @@ static inline int cpufreq_boost_trigger_state(int state)
>   {
>   	return 0;
>   }
> -static inline int cpufreq_boost_enabled(void)
> +static inline bool cpufreq_boost_enabled(void)
>   {
> -	return 0;
> +	return false;
>   }
>   
>   static inline int cpufreq_enable_boost_support(void)
> 
> base-commit: df9574a57d02b265322e77fb8628d4d33641dda9


