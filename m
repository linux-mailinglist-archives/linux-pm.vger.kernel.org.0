Return-Path: <linux-pm+bounces-24290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CB9A69623
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BE616D751
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B31E8354;
	Wed, 19 Mar 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8MFCXxZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119051DDC36;
	Wed, 19 Mar 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404449; cv=fail; b=ubWDV6HpZc9dY2KVyajfTzqakbTYuN9bAfleALSkZNOYhzSc06ckwSxMO21F5esDevKxVNdcHgC9nsb6DEa+RSPwp894y/73wzk8ABz3Xrx1pz8gAFHXaoNxQ044eEifaTlqj712M2chTLY28cjYAhljd7HmN/pCkCf+rjRYSOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404449; c=relaxed/simple;
	bh=UqXxWRvWHddIq4AhwAaAix3AY6D0WqYcrOeiNTUnyEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GuIDreXrWf3ydbp96sPlLdxF5w1cTU60qLBQgNz3M1kwKVHY7QUJ6i4lU3owFvkpgvlHdrfFD8i+ZhGyOvNVba29Xi/QbOTWVoXVhB4VJ1pHuRpUc4utFAeWRQ+NeSdKMxOsz8CR2ueCWH25rE8/Ndxxu9AsCYj+lbd1Fl4bUyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8MFCXxZ; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejigYdsp9TmNhxBN250MtP6ZbJjZAARPilUd46SwoY30aBQtSfZExruFn+PSMKxCeFp/UjTSRx7YwNWHBwmPic4b5OOwlKr+Uf51qhCmLFbhh2Bvgu9enMx6NGeQEWFQ6vfQMIi15614J2MFdeH46oO1vgHBDD9GjTu+1h7l+CmfuzbGbIa4Z6SEqxoMREWaVxm7NXZelqLVrqjGzjjvz0eHezWarr9aWQf/xTYkO/Ck7j6WWxThIcC62+ZDG+ZvvyspwoRrtxO5IoJUqyv/1Cy1CdhuIcRAVeQoIxznxnHoO0BpaVp379wBNOEDK/vlXDFRMs06y1O54fLJ54kAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kfVIVAaip2rR+ng8NIV0x5vxNviX6yZpH64o5nRkl4=;
 b=WMLdYYuUBb3fBOHQpe2WnGGnkhOYgnaoD4ooKHRVlvPFxLzt1FyfIpOBYEjAOvac/lPoapC9jwmmdMM1Int7NPUauMVjw2GgK8Vx+4GIwqpryEv765kG25Q4h7elJ71YvwEsWXSMBSOjA+0KfQJ4a5piegA1Gnbn63TOTMkdjIcAwhNeSMMy151aFkY0QnZWwSJo9ed5LUikRLFoSN0qfA3oNmEFSYuByKry/rd0z8OutgpNIXSluPsrCwdUCaWMsyDdzjHdZnqaEu/8mkzU1TypbWJkEh+Ph1OeQ5s55a4duYnbUcEl82wHLpfzDhe7qeN0A0VHNPSaqTBaIo8+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kfVIVAaip2rR+ng8NIV0x5vxNviX6yZpH64o5nRkl4=;
 b=r8MFCXxZcVdRJyzKrEJMel4xicsIz6/itWtKnogVxvdqVC3yTRcfyWRPDzVePT/AcKevmq+DEp7Jl2b16WLhvz2Aam7Wx06jOdWkafnNDHg+4yAMHbt756RnAsuHVsLpxwQR5sy4OO6aqUaRJcf8a4jUXAOnTo2fNkAZ+zoFNWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:13:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 17:13:54 +0000
Message-ID: <43daf20e-0d5b-4a1e-8179-bb2af39f512f@amd.com>
Date: Wed, 19 Mar 2025 12:13:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cpufreq/amd-pstate: Add dynamic energy performance
 preference
To: Mario Limonciello <superm1@kernel.org>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-2-superm1@kernel.org>
 <8e87fa8c-5254-46d5-a853-46e8c31cbe0e@amd.com>
 <4e0ab8ce-908e-49a1-8445-14129a41afda@kernel.org>
 <5eb7d32e-d251-4536-a4e8-61670aa34869@amd.com>
 <59a20c51-aa1a-414d-97a6-610a82947472@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <59a20c51-aa1a-414d-97a6-610a82947472@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:805:de::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a699269-a949-48f2-0f2e-08dd67096d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3VtOEJWVk9VRkRXVGVIMCtJbHRudzZkTGlnaUxiZWVYMFd4OEpielRock12?=
 =?utf-8?B?V2ZROXFvZDY2Skg1MXZ3Sk5IUHB5TW5qLzB3Yk9qNzdKcXU3STgzeGdqMDBX?=
 =?utf-8?B?YVBqSjFzR2VDQ3B6SktRQ01FcVpwbzhhWkZ3ZXBpcUJWVTZPT0Z3S3NHZ0VZ?=
 =?utf-8?B?SDJJZCt1KzEwdUpQTFJwV0hCZEhVVzNGTjgwa1ZiaHhwdjZLbUJ2dGtxUm50?=
 =?utf-8?B?TFhGMjJFdDVvZHBpT0hYVTJyR0ZUek9CaVdXczNTN3VjdmdiTCtsemRWNGNT?=
 =?utf-8?B?WnR1Sy9ORWVYamhWbGFCVjlYaXV5R3ZLTCtLdWRaSjE1MnIrbUF1WW1xWk1N?=
 =?utf-8?B?NnM4YnZGZE45U2w0Q0FxMXhjbHVRbWoxOHNUTEhqT2Rua1BBZVNqRUJ2MTBw?=
 =?utf-8?B?bjBuUVBadktwMVZwNVo0ZkdiTVlnYUxkWk56UTdDQ3NiMElGUEJERFlzQzh4?=
 =?utf-8?B?OUowOHBBU0VUK3dxN0JDdjdUZDIzS1h3ekJmd1VkL1FmMlJERW9lallzaHBG?=
 =?utf-8?B?d2pQajVjaGZ4Si8vU0FScFJXM2l0bE10RERKNXZSZXRaeXkvU3ZiV1ErZlNj?=
 =?utf-8?B?b0wwQVhHSVEvNEJNK1hpU0VML0tXY25EQ3VrRng2UDRFQVZMdUNYZ25DbEFz?=
 =?utf-8?B?VnJOMmVWZjA0L3JicmZ3RHUyM3FYUytyMWpRNG1RclM4THlBMWpCTGc0MFhX?=
 =?utf-8?B?UVFaZ2lOd1k1dG5HUVNNNW5Mcnc1NW9DcGduQitWZS94U1gvTEhQY2Vkdjhz?=
 =?utf-8?B?SU1teEhKKzRtWWpFeFdTaXFlTUUzTlZkNW5Za0VmYS9QWWZRRzdtUGJHQzcw?=
 =?utf-8?B?dTgrQUVtdmw5d2dmQXNhS3lNa1N5Ukg0VjZhRkR0dEsxWmtUZ0s0aFpKOE5Q?=
 =?utf-8?B?c09pWWZES0w2VnJDZmVpRWZhM05YeVROMGdwR3BRVGdkNkJQSW12QkZxb3By?=
 =?utf-8?B?SENjRnQ5eUlieTEvK1d2azBQQ25sRUdTRnIrRDRteVlrdnBRcllvNktGMDlz?=
 =?utf-8?B?N2diUlJNbVB2dzUwenBxb2VvMzJhcnpGSThEeDFGUzR1U21nWmt5NjZjUjJ3?=
 =?utf-8?B?dTdlSzlNNm5qVVhVMWZXY3lCTElXWFdjODNJbTI2NmxGSzh4SHRKRGpTNUl0?=
 =?utf-8?B?RXRLeGNaTmI4WFR3TmRKZXV4cXM3NWhkck5NNGttNEVKeDFzYUQ0b1lVNXgy?=
 =?utf-8?B?dEJUb0xQTHV6bk5PVmNqZk1nZytQc1NURVVSY1dHWEN2bnFmd0ZoZEdnQVJC?=
 =?utf-8?B?UXRuSVdkOHMzNUpTdWNmUDZaY1AyM3pGQTYwSzJMbG5FcmdJanVGZE0rNWd2?=
 =?utf-8?B?YUMxUE5kYUhUKzIwT1ZaQWk4M216TzRPeWllOFhtZEMzTlppNVFvbUdvenZp?=
 =?utf-8?B?ZHZDZ0ZnVllsbXJlSGhWSTd3WGNjOHpWcVlJNU1CdVd0RWg0V0ZjRVFNMHdm?=
 =?utf-8?B?TjNpOGtiMFRQcC9MK3lXcmFZeW9zUnJaemozcGtjTFBqdE1GeXc3UWJPMm5F?=
 =?utf-8?B?UDVxSmlhbHNkYlErY3JwMGVUWFA1d1VndkkxL2lTdi9UUkpPek9WWWVoQ3NF?=
 =?utf-8?B?R3JlY2lWclRxM0NZZHNLWFNnTnVudE9oRFpPdDFKMThhRWtxNkRvMXFPMjB3?=
 =?utf-8?B?dWtLUExuaTFFY0E4RitySlV5OTJxZjVQcTllQVZjKytVYTROUUJzc0YxS1RM?=
 =?utf-8?B?ZE5UTW9ram5LelF1elRiZXVZT042N2pRUVA1b1c5YW12SDFwNmtrZmduZWtV?=
 =?utf-8?B?N1hOUHhEQS8zMHh1Sm82WGgrcmZabUw5elJBejlUK3Z3L0F4VXZSTFQ2NGRP?=
 =?utf-8?B?cXFDRFU3R0J2dEdMVTJ4OWVucnR0SEptRUVVamJoVGpsVWtBT1RlOWJHa2Zz?=
 =?utf-8?Q?xzbTHKg94PpCO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3dPS2Q5aFRRN0tLZ09WcGxWRWpuUmJZZzFtRlgzdlQwa3hlcVBMektvWldI?=
 =?utf-8?B?SVF6cXVpM2JBcXlZRmZHUUp2eVRJbmhCejhUZ0xDc0V6bjJNa285ZEdQRWZK?=
 =?utf-8?B?UWJqcnN2dkdJd0tiNysrNk9wRDdYSXoySUcwdCtPVHpyNWZLYzU1MVZhaVV5?=
 =?utf-8?B?ZDJCM2hWRDEzVXhXYTRVNlpkZHdLRUZ2aVBGa0hBU01nRlZOdnp6a0xxVkcx?=
 =?utf-8?B?WjE3NEFHMVRleDFLaDEyT01senVNRWNkeURlSmtGKzMrVFgvU0RlbFVwWG9r?=
 =?utf-8?B?SWYwNHBpblAwcytaU2tOTC9UbHRaUkVFckZCa2JLSVRKbCtKWjlHcHZlWmxv?=
 =?utf-8?B?RUgzOEEvamV1MmhFT1kzUzhUTFh5aityVVFvSWVUUlFZNzN1MDlsTjBuYmJp?=
 =?utf-8?B?WEVZQUNMaW9Ka0hXbzVmMXZOUFExQ0pxNXljOVRUbXhnMEs4aTJGZ1I0VnBC?=
 =?utf-8?B?am1JUkZkdGdFY2tCUzMxbUF3TFQ5TWlaR290ekdWMmMwd2g5QStnKzBnNnVp?=
 =?utf-8?B?cCszU29KUW1YL3lFcmtJMVdyMitkQTZDa1R4SjRtV0I0emloNGhpUm05VXNm?=
 =?utf-8?B?c1hMMUg2QzNBTjRtelQyWE1hVW9iNmVWSklaKy9XRlhLSjVkbHY2SG9iRlBO?=
 =?utf-8?B?d2xhQ21UWTVwNzJqVmVBZUs1ZHdzeW9ySFR6cFZpQlYzMHFvT2RQKy8yMHVX?=
 =?utf-8?B?VTBEOWM4QmpmS091c3NrQXQzSDRIUUxWeTZVbDN0WC91bVM0VDVxRUpHUkts?=
 =?utf-8?B?b0lHa1JqNG0rZ2RISXU2dTAvMlBSYmwzRU9rV2F2Rm56WWJvSnZoMEU4cGFj?=
 =?utf-8?B?bjlMZFh3NTNKczh4MDRwUnVhaVMrWXpNNUl5T1ZnMEpDM2JsazBZaXpjZHVa?=
 =?utf-8?B?S1RGK3hsY3RKb3JIWUtFRnhSUjlJN1NySGorakNMN3FBQUtIOEZsRmltVGVW?=
 =?utf-8?B?THRaT2g1aVJaMGZ3OVFNUnZQaG1uZWlDNTRNd0RTV2sra0cvSW5Pbkd4SEkx?=
 =?utf-8?B?bG96dHF6UDFCWWIwT1JWTHlmQnhPTEY5NTArS01JRDJoQmFkUWZJRE41ZFJG?=
 =?utf-8?B?UmVqS0Z4QVBCVlZxbWFFdSthdTFTNmNsVS80b2ZGcXZBaDZIaXMwVFBLRWk0?=
 =?utf-8?B?ZkI3a3B0UHUrOTZwaUVYc1NibjFXVm9xUUloRE0raXMrWUgvd3RCWVNubFQ2?=
 =?utf-8?B?cE9BSGhKRlZTdVlMbDRyODR1ZDU1SEZkWTc0RGM4dGhIWVlkcytyTytmUXZ0?=
 =?utf-8?B?Tkc4UjdUNzZtZE9weVVlUmpwaWo2ZVNlZHdFUTNBTklmd3JiVEdjbGREQ3Z4?=
 =?utf-8?B?OVg4UGNuRUh6TlpNclBmQ2wwOXJhYUphNHpSK2x4dUdweXBRWjZiQk9abklw?=
 =?utf-8?B?NWdOcXZuYVpjdXcvSW9ZV1V4Q3B0bEJjR0RIakNNZ1JUM2szTkVjU3IzR0p4?=
 =?utf-8?B?YmNtOHF0Z3NhYTJCWVRwc3pGSk92TVExcXNGdXJWRjUzZVBhcGp1amJ0ZC9G?=
 =?utf-8?B?Yk9FNEpYUlhPSXQxb0N0NmtVVEpkaG0zTVcrNnN4WC9SMXZNcW1BTVlwU0o1?=
 =?utf-8?B?VHlzWEdDRE43ZVZWYXZ0OGd0allzdDVucUtmMUREVXhESTdCeEt4MzhVZmcr?=
 =?utf-8?B?WWlvakhtUyt3aDZqNG1RYVJoZUd1ZnRLRHpPb0VpMHFjaS9UZEllYXR4MFhp?=
 =?utf-8?B?eXNuaUhISlNFVnpPclUwVDNLUDVZMEpLUGg2RjVVZWZvc1NEQ0oybHZmMUpX?=
 =?utf-8?B?eHFvL1BNbURxZjRpdUNEOUFlWjJJU1BweGdUNkppUHU0QWlGbitWamVCRWlX?=
 =?utf-8?B?bFlvSk1vRGJkdHl1ank5bTFGMmVORXV6dk9mekh1d2VVaGpUZjRkMFY5cm11?=
 =?utf-8?B?d0p6cDJZdFY3U1ZudW4zRGFLWmlBaXFXS3NFaGxZcEU1R0FYZk5Uam1ZSHdw?=
 =?utf-8?B?OTNlRXVJQW1JRWVHbkNWcThoV0MvSFJoN1Q0eXZWNmp2YjJZMDBaRjcxV1RX?=
 =?utf-8?B?TTFRL0MvSFAyOThHRS8rM0dWdUZvNjVmb2NsL0M3a21TL2ZNTjg2Um82WXNT?=
 =?utf-8?B?ZVdNblF2YXFWY1hMeFBpdG80Y2lDNzlOQXVYUXk2MnlyMTNuTjNpQVdKMmhy?=
 =?utf-8?Q?5ieMbvvdCAsoVj9qN6gk7Y635?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a699269-a949-48f2-0f2e-08dd67096d93
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:13:54.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d172II5Pkr2g2e/mVhUlkhUfC5s5H9UltUP4vXs5xuIZ0lkW78eLCPCMgBFSSNH8yBIBv2FyuHzP1NxUo4O20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

On 3/19/2025 11:50, Mario Limonciello wrote:
> On 3/18/2025 22:43, Dhananjay Ugwekar wrote:
>> On 3/19/2025 1:06 AM, Mario Limonciello wrote:
>>> On 3/12/2025 07:16, Dhananjay Ugwekar wrote:
>>>> On 3/4/2025 8:53 PM, Mario Limonciello wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> Dynamic energy performance preference will change the EPP profile
>>>>> based on whether the machine is running on AC or DC power.
>>>>>
>>>>> A notification chain from the power supply core is used to adjust
>>>>> EPP values on plug in or plug out events.
>>>>>
>>>>> For non-server systems:
>>>>>       * the default EPP for AC mode is `performance`.
>>>>>       * the default EPP for DC mode is `balance_performance`.
>>>>>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>> v1->v2:
>>>>>    * Change defaults to performance (AC) and balance_performance (DC)
>>>>>    * Default Kconfig to disabled for now
>>>>>    * Rebase on latest branch
>>>>> ---
>>>>>    Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
>>>>>    drivers/cpufreq/Kconfig.x86                 |  12 ++
>>>>>    drivers/cpufreq/amd-pstate.c                | 129 ++++++++++++++ 
>>>>> ++++--
>>>>>    drivers/cpufreq/amd-pstate.h                |   5 +-
>>>>>    4 files changed, 155 insertions(+), 9 deletions(-)
>>>>>
>>>> [Snip]
>>>>> @@ -1556,6 +1667,10 @@ static int amd_pstate_epp_set_policy(struct 
>>>>> cpufreq_policy *policy)
>>>>>        if (!policy->cpuinfo.max_freq)
>>>>>            return -ENODEV;
>>>>>    +    /* policy can't be changed to performance policy while 
>>>>> dynamic epp is enabled */
>>>>> +    if (policy->policy == CPUFREQ_POLICY_PERFORMANCE && cpudata- 
>>>>> >dynamic_epp)
>>>>> +        return -EBUSY;
>>>>
>>>> We might need to tweak this condition, because if we enable 
>>>> "CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP" in config
>>>> and boot with "amd_pstate=active" it lands here (cpufreq_online()- 
>>>> >amd_pstate_epp_set_policy()) driver init fails
>>>> as the default governor is performance.
>>>>
>>>
>>> The check is important to make sure that you can't go to performance 
>>> mode after init.
>>>
>>> I think this is the way I would want to solve it.
>>> Set policy to powersave before enabling dynamic epp for 
>>> amd_pstate_epp_cpu_init().
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 824756ac0010e..4a0f561d0e2d1 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -1729,8 +1729,10 @@ static int amd_pstate_epp_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>                  WRITE_ONCE(cpudata->cppc_req_cached, value);
>>>          }
>>>
>>> -       if (dynamic_epp)
>>> +       if (dynamic_epp) {
>>> +               policy->policy = CPUFREQ_POLICY_POWERSAVE;
>>>                  ret = amd_pstate_set_dynamic_epp(policy);
>>> +       }
>>>          else
>>>                  ret = amd_pstate_set_epp(policy, 
>>> amd_pstate_get_balanced_epp(policy));
>>             ^^^^^^^^^^^^ (mentioned below)
>>>          if (ret)
>>>
>>> Thoughts?
>>
>> Yes, this looks good, because anyway there is no point in having 
>> performance governor and dynamic
>> epp set at the same time.
>>
>> I found one related quirk though, we are setting performance governor 
>> for server platforms in
>> amd_pstate_epp_cpu_init() and then setting epp at the line highlighted 
>> above. We dont have a
>> check in *_set_epp() functions for performance governor. This could 
>> alter the performance governor
>> behavior if we set a "balanced" epp for it. I haven't tested this part 
>> yet.
> 
> In that case we probably want the "default" ACPI platform profile to be 
> "performance" when on a server instead of balanced.

Actually this is already done:

		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;

I'll post an updated patch series for you to test.

> 
>>
>> Thanks,
>> Dhananjay
>>
>>>
>>>>> +
>>>>>        cpudata->policy = policy->policy;
>>>>>          ret = amd_pstate_epp_update_limit(policy);
>>>>> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd- 
>>>>> pstate.h
>>>>> index fbe1c08d3f061..6882876f895de 100644
>>>>> --- a/drivers/cpufreq/amd-pstate.h
>>>>> +++ b/drivers/cpufreq/amd-pstate.h
>>>>> @@ -104,7 +104,10 @@ struct amd_cpudata {
>>>>>        /* EPP feature related attributes*/
>>>>>        u32    policy;
>>>>>        bool    suspended;
>>>>> -    u8    epp_default;
>>>>> +    u8    epp_default_ac;
>>>>> +    u8    epp_default_dc;
>>>>> +    bool    dynamic_epp;
>>>>> +    struct notifier_block power_nb;
>>>>>    };
>>>>>      /*
>>>>
>>>
>>
> 


