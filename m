Return-Path: <linux-pm+bounces-16636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F69B41A4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 05:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F4E28372A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 04:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1C1DE2C4;
	Tue, 29 Oct 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="krJ/CGDu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A252FB2;
	Tue, 29 Oct 2024 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730177577; cv=fail; b=BfXDCFgKlB7I/TD9jG9OyIWDF9exS7N1bgbdmkJSXBSyDLkFdtfn042bYCzII+PS5ODQHTX8DKaice/bVKtfr9LW8IWjKAa0VQus14dTBHqJ25J2WUflUYAa1zOUnhOxHwBcA/IP24FMtGPKAxT5QthyvrHQ5aaYFifvUdS65kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730177577; c=relaxed/simple;
	bh=6E145uiBAsJ257EFujOKnqyGx9AjVHwp83ll2nFY5gs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AofAk2GEQqBcZpuJcgM+JTSCNnwVDrWq0tq+JsUcNBxIuOYEiJLs8KvRHNtTl2UzaLpYJwPCOitLWwcXhGgtw3ZXsGN0rrPgTJU6vakRYw+sOcLoZkJFoqEJu+NmdJB0YjsJ9Nqy6Un9Mx3Wwd9rvzvI8R0VoYsFxIj5OpUFQAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=krJ/CGDu; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKE6y1kxTMS0SNTId7asLbHsjmkQKsgJR8RCHWvIpKHMozdIakKvNhlgRmlrZ9MX/vzkG5ogt3lgTh0dmAacT6E1KM8VyTNh5fhIB+TOAQ98dUpa+dz/RvsngrfVP/J8S1kkd/2kPH+NlEcmZssdPmt+OPP3+rF08Bxjg2D5C6wI7rRF16Z1Cz7hxjhD68Y5CDCMwKbRC2ECQdtd1/3lQwQnqS338PgghgUQviksIsxeMi2a+6OFp2fz9P/L93QWDuZJjcSjdUMHQGDrAX4hSJdBuGPrWPD13Q9cscUHxQZ0U8V2067jQWYkLQZMqy2dzonGjlPdqAzkcxiJlaqNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM5hCnklPWYQq7M4lC0OqiOslLyQrf5k8242acvYbmI=;
 b=gZmpszPMQLrmPNtFv4Ael8JwmFgacDTlhAsh3eiFNHBuJedsHc/QWmqpy3UX9PKN6+fDzb/GeMMWwyzVVrClFlo3+z77DuPR+Y7A4VErUwL0ekKfKt3JQ1XcmjClmUyB0kUag0sQsQ/HK4f89byH0ZcDmMPUVqx2+RrgiO9IuXceEPyYz0Ha0NjAyyzJbY1o9Kho73HbLCOcVf8HNZWKZnS172reFmZVZKKUcyVYPuL81OAnu4lVLRYi4eiQHV5VrP5N/HiWIeE6UdDX8geQ3C9QduDFbG5tHKO3g64sJ4etDiVZjigI/Z6gasIpVidqVqMyBbTxZWsNsLlSbha1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM5hCnklPWYQq7M4lC0OqiOslLyQrf5k8242acvYbmI=;
 b=krJ/CGDubOlMTYZXzD86ntLuhShf6U4qzuqe3qQXBumJzeeDqoH/JfGs5SJKcwFgkRtB7Hde131zr6y11RlzLyFeJtJ4nedx9z2BLzRMLVRLB3fAy5rp1JflSR91OgNhx3hcuM+LcedE2QEcI7v8OhiezXr2Mzz1KNM/0OMY1E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 04:52:53 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Tue, 29 Oct 2024
 04:52:52 +0000
Message-ID: <44f8bf0a-4d1a-4a75-99fd-4ca7473423d4@amd.com>
Date: Tue, 29 Oct 2024 10:22:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq/amd-pstate: Push adjust_perf vfunc init
 into cpu_init
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Klara Modin <klarasmodin@gmail.com>
References: <20241028145542.1739160-1-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241028145542.1739160-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: ae525771-fd3a-464f-0e87-08dcf7d58b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3h2WGVtc292b0NzcnErSERLWHZEN0dvRmJISCtaNU9jYVozdzBkQ1V2YnFo?=
 =?utf-8?B?TTArbXFVUnAxVS9hdWxXd29QQVZhV0FwSlhXbm80WEdxMEtEV0lEYWpXMzcr?=
 =?utf-8?B?RnRXaExWVEZQWVZKaTNrRkJ5THBaV0hub1M1QTBzSzlQNXR1V25pb2lBSE9z?=
 =?utf-8?B?SVdkZU55OW1PMTc2bjg2RWVUTEZnT25NK24razRCanJ3R1pBTC9YcTNSV2tr?=
 =?utf-8?B?SmxJOFM0dGRzWTRJenZXWmZPRmpUbkJMZVVUUlo4RmpDMVRDc3BjanlON0lv?=
 =?utf-8?B?blZUc2tzbldhVDQ0bFdnRzExV25ZQ04yTlEvTG1yN2VmS1BkZ0xhTmNEVElF?=
 =?utf-8?B?TUIvM3VMc3FVVUd1Tk9JTFpFMFAyb1ZpSEN5MU9yMjcveHQzaFpMZDFUaGhq?=
 =?utf-8?B?ajNuZDhmWllnOEV0dnNvUHVEaFpoSE9LbFJYSHZCWFlOamF2TEs3ODlCTmov?=
 =?utf-8?B?b3FDd056Z1JDQ3lqWHoyMm1Ib2VMa09MdHp3WHNBYWlLcHMrZEsrc3hXcTZI?=
 =?utf-8?B?S1VvQVFVTDIwRkFhOUUybUNRTkYrNWxLY2VsNi9KRXVUazcrUUxtdUQrSHh6?=
 =?utf-8?B?b3RYS2lIYmkwaG1OdDgrM20vV1dtVWVEUEhuUkQxTmFsMm5CYW5uTzlXdU96?=
 =?utf-8?B?Um1xM3NKblJVaWZYdC9zMXZwcTE4TGNBQTFBZFBlRUFBRGYvek5Fb25OdFUv?=
 =?utf-8?B?eWM5UG56ZlR2VkZPemxHblVTejBWRTZSV3AxWnVjRGZDZ0N3VDlwekdxMHYx?=
 =?utf-8?B?U0N3dnYyTzRHQU1kZ2lPZGZINEQwSGh0WHE1eE9qZCtCTTVMOGs3UFgxM2VF?=
 =?utf-8?B?ckpzSG0zVnJIZnljRXNQdVV1RFp5NFRHK05pa2VMaVZ6aGJxRXRhWlM1Yjgx?=
 =?utf-8?B?b1lTdzVXWTdPOG96akNSVGw5Mll6dEVXSXFkTTZrWlQwMmpIMjhBQWE2ZGFj?=
 =?utf-8?B?WTd1WVlWaUIrdmhXNk9pVE1yTTVPTWpvMXhjaHUxcE1ZU0FNcGE3Q0dLUERt?=
 =?utf-8?B?SG9VNkJxdmh5bThTTElaaHNGTk9idWVwZUhsSnF0R0J4TzVZbGk1c0ZqVHNV?=
 =?utf-8?B?OFNzRVJnUUVhNE1DZFhNencwMXJNZGpUKzBGbHorZzM2c25zZHpqUVJFTnZJ?=
 =?utf-8?B?MHhYNEVPSCtPSkRwZ3pxRU5YZXkzV3c2TTY3d3NDMno2Q0xpTW5jc2h4RW9s?=
 =?utf-8?B?VHVMSHFVbmFhK2xoM0lTNytEYVgzcXJra0ZpY0crN1hxVTc4SjArWSsxMS9o?=
 =?utf-8?B?U3M1OFVzT29mUkl5ZXlYRGFWSFdzakE3WW5DRWxicXVPQ0d2WVRub2RTeXNh?=
 =?utf-8?B?Ty9SWHFxYTFlc0NyM1piVEJSRWhIMEx0ZXg1aVkxdW1KY3pKeW81bFQrS2Zq?=
 =?utf-8?B?ZXZOMEsvaVJWczZJZFRrM0t0T3ZtMHJTV0ZSUGxvdjRyVjEzRXh2Z1VhUWsz?=
 =?utf-8?B?WjhGN1RXUm9JeGVBTlcvS1A1ZjJSamlmSkJiaTZiL2JoWWJ2cjZHVk5rcjdZ?=
 =?utf-8?B?RVY5dnJudVZtcm9hUDBYWDduN0kwNWRxdGk3MC83N1YyTnVYMTB5cEV1M01W?=
 =?utf-8?B?c0RBOWNubTI5MWR1M2lVNTNjckJIemM1dkRzRmdFZUtOQ2txNWM4U3NEK2ov?=
 =?utf-8?B?S21WUHp1djJVcTQvWXlhOUhHQ2JWdjM4ZG14WnVJeFNSTUVBZHk4bi81eWs1?=
 =?utf-8?B?dWNlZEhaNXpmckJQTCs4VWZLbVB0ekEvc3NPUkJmbDQ2VkpNYUdwUEc1R09i?=
 =?utf-8?Q?d+/YVWUKYekDK5jJmRTvNBShXr3UUAdscy3VQ0P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVRKT2ZiYm9qNmxVaFB1cW1SZFByY2U2K3ZKRGdUV05NZFpxZU1yVjVXNDgw?=
 =?utf-8?B?TFlncjdUYjdaR1d5N0p4N0dqQnhYaFBjbTJxVjd5MHAwazVJTEkvaUFUYzZi?=
 =?utf-8?B?Y3NBRFo4OFpETlF4VzY4Z3RsakFBcXJMS2wxYThESnNYZkticSthOTNaSlQ1?=
 =?utf-8?B?SVVacStjRkdNaE9NTytMc0crakNkS2cvUUZnb0VYblFuMjVnMWhqN3NuZ0ly?=
 =?utf-8?B?Vkd0MGV2VWZmdHp4b3Y3L2lYa0k1eC8yL1B6djk5aXNwRThRdk5kTE5jYjl0?=
 =?utf-8?B?Mk51eXdsd3NsYmlnTThGVC9LK0M4dE9FWStZYXVVQ1VyT2VrN21DOHlqeUhQ?=
 =?utf-8?B?VjlLdG1SdWtrYVJYdTJkZkZLVXpMWkxVdkZqL2RpZnZtVFJkMitrdXM0MVUz?=
 =?utf-8?B?N0I4c0FZd2wvMm5PTFJqaVBLRVBGQ1R1Q0RCRUdQc3JSQUl2WU1TREo0RnE0?=
 =?utf-8?B?SkVnTWc1WlNYSGpWMHdCSFdKRmFkam1JYS9XZ2NaUFVZeHJTKzlGTG9xVnhW?=
 =?utf-8?B?SFQ4S1hwdU5zUmMzSXZadGZ6RlJ4SVNBV0hZTWJSQ3VYWnd6VHRNNUYxREpF?=
 =?utf-8?B?NENVa0U4VTVvNjROMGpNT1FSY0FPUmFVWFV1OTlmZTJvUXN2dHlBQ3IvVVNj?=
 =?utf-8?B?MlNtaGw3NUlUWFdudGM4S25UTjBkNVhTQUlDWFAzNm5BLy9ScXVOVmN3U2JP?=
 =?utf-8?B?ckptZDJoTTk4ekJNSTZ3K0U3aE9yYUpjM2VJcFpxempuVmV0YkNVUVQwMlJG?=
 =?utf-8?B?QTFmQWU5cFhVS3I5MWlCZm5WeHdrVEl5aXI2c2gwMTkxRkM2Z0NkelRBeGJv?=
 =?utf-8?B?S0ZtNXl6Mys4N2tDaXdpNEZYNjlxcjMrZHptbk04dEF2OUxqQ0RDZWI2b0Vy?=
 =?utf-8?B?elRXaSt0UFJ6ODNZM1VXQXdwMy9RSlEycTg4U1licnZzMDdLSHhtbnpTZHFm?=
 =?utf-8?B?czZJOHUzeVIwVGlNYWtiNXlXVGVuZ3hQTFVVZFpVZFBGdnR5VUZwWm1FR255?=
 =?utf-8?B?Q252dURIVkVGQVZKSHpxYk1rVkxPcjB4aUV6R1NWalczM0FhRWFUb2NEcnZJ?=
 =?utf-8?B?bnVWdXYvRGN6bU1adnBwQzh2eDgvcW9UZ1orSUZrMnlUS2xKUDk4NFpQdjB4?=
 =?utf-8?B?VkhBM0FCQmwvWUV3cEN5SStJR2lsdThZR21saFo1QlhpZ285UmppWmdmZVlm?=
 =?utf-8?B?bU5HR3J4WllFN0xGWG5meVNkZlpFRkRmRHRyajNydDErak5BZGVrVk9pb0hK?=
 =?utf-8?B?WGZUZUxSVXh0ckFRV0hUOUJZRnZMZHdEakVhREdzejllR2ZrbXJUMnV5N3kw?=
 =?utf-8?B?bkt3endyUHZiaXNHQnFqTDY1MDd2a05Va1ZxUytnK2dwdEhlSVpmZUJWdktn?=
 =?utf-8?B?S09JN1I2ZDdOS3ROVzUwRmtVdTFqRnlhTzVXbkh6YmJIVk5JaCt1eWJFTjlX?=
 =?utf-8?B?Q3RncHBkTDNYVW83dndIMlR0RWhzV25lUnZIQWFxL1VTaThxMUMrOFNmR0pL?=
 =?utf-8?B?amNTUU9VSXVEa25XMEEyZ2pBUkhDa0M5YTdrZCtqNXVERlhMakdTejZ6T2pP?=
 =?utf-8?B?REFGR3J1dmU3U1VHRHREVGVUbjlhNWlOc01Uc0lTMS8rL2RTMHorMWRkd0Vp?=
 =?utf-8?B?aGFyUmFPUDQ4elRaVEE4RzJoZzU0ZFhFY1J3NmM4L1lUZ2tWc3liU3lhN2hO?=
 =?utf-8?B?TjhORlhYaTExQkV2V3RaMGlmL1Y5bDlJVHRoYlFTd1dVZ0pYUWZnRjh4RUlU?=
 =?utf-8?B?YzBaUWp6WDUzSGlWcHNmMDB6U1lzemwvaUk5U3JoOWJhdHFiTE4vVXN4WUdu?=
 =?utf-8?B?eHJvZkhCWHZyUGpLaXp3ZmRrNTU3aysrR2t5eGJFeENuRWlvRHhQWVNOLzBy?=
 =?utf-8?B?RUkzeUY2cURDNFFheGVlV2lJYnpCcmx4VE1peFREMGtKVjd1V25KRWhmMlo0?=
 =?utf-8?B?akMrelF4OU5QQVZyejNHdlBqM0pQbWZtRUh1Z3BaYUh1MlJUOWZtenpBWXJJ?=
 =?utf-8?B?ajdjRmpaVUJOOGt3ZTQ0NG4rOFBPSm4wQkt2eEdJa1ZiclBRaG5Pekp3UGdh?=
 =?utf-8?B?VzNqajJYalZVbmVoL3A5NndvczZpUGdoREMzM3J6QzNicm1LRzFtTWdIQ1Ry?=
 =?utf-8?Q?IEo+8w8B0Auy3qtl/FeBX1Cyz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae525771-fd3a-464f-0e87-08dcf7d58b9f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 04:52:52.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udjnatRbjY2RkgJqG/aubJNavu0P+JGexE18ROpkYIShWny5Zon2rTFyD6EuisWuoSRJePktsccjW9uRKbvNBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

On 10/28/2024 8:25 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> As the driver can be changed in and out of different modes it's possible
> that adjust_perf is assigned when it shouldn't be.
> 
> This could happen if an MSR design is started up in passive mode and then
> switches to active mode.
> 
> To solve this explicitly clear `adjust_perf` in amd_pstate_epp_cpu_init().
>

Great, this solves the overlooked issue as well, looks good to me.

You may also add,
Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks,
Dhananjay
 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Klara Modin <klarasmodin@gmail.com>
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 206725219d8c9..e480da818d6f5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1504,6 +1504,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
>  
> +	current_pstate_driver->adjust_perf = NULL;
> +
>  	return 0;
>  
>  free_cpudata1:
> @@ -1866,8 +1868,6 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		if (cppc_state != AMD_PSTATE_ACTIVE)
> -			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_cppc_enable, shmem_cppc_enable);

