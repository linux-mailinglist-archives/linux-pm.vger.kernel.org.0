Return-Path: <linux-pm+bounces-7590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C618BE64A
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 16:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A8128108E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCBB15F326;
	Tue,  7 May 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rb9M8KLM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E815FA6D;
	Tue,  7 May 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093048; cv=fail; b=Fg+kLshtPhAKcmdi60riwprTmU7cTRWCqMRfgw04CNTAo2jpvtpJtauQfHTY6QWq9IcbN4aTddMVryw6+VrQltPU978hdrwr12+OzQSj8IjvPZrMUT5MbppiviSxoJ+UyKFmY8abXnFCESQGhezREQh5PSVkTn1cyNCQLa3Z3aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093048; c=relaxed/simple;
	bh=vnpQ2t5a3tBokYuCeAIFnz4RYNcjKkvNb6SlMXtuFJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QINL+RpnUhW1p0DPJwM5pUqOQSsyMUwAKsdIZY+VHXthu98CFGrzZt6deagCcNmv0rrl6XIaSTa3IiLe5tN7zAVMdNn6QOQ+wuM+dR+u+Mx6dfxS67u12uQ3MG07+Q1bvtothe94HIUNhxN3dP1g5sww0HVzZRUaWHvEIwMnj7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rb9M8KLM; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3YPEgP8bSbu4JHq4GKgkIkB9Mr4mRgehqZSmLsxoRXN6iYSa6u4JM5S/tkwT4Kk2wu2s4gT7yVbYUKhtaVL1hbHOKJK12xWXEViMAmyVsEi9TdzkN/08ScK2kzxjHRhWR2ZE1O1HtxxSTp8Jz5iSiTDnGs9jdH4OxJDFAxR/OlUUB+UJ8vi7ypECRrs+kzL9vsCr9qGIY7Te2HRxKZCkYNO8boXJTni6sr6pclg17Om0i+0ypOYGgvFgqFPOr8Zo4KESGFKszLFZDaslC0QKrWVXNWLHC3nhc2Ky6B9qI+504kP3KqdUs5GrphWvTHmvTbGpPcir/jQOpPIxLpiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2a0F/J944jHUOTcWE9j7gP/plzq27Y/1/ODv0ble7g=;
 b=gIXFGBkSdQC9HA7Jo+c7AGpsThqTEtxQ+wTv3b5F+i5i7763fzFwDoH8UjuhVel32Gie9a1jSHNknm10kiegWHMjpijT8X/sJ+nSegkQWeoCqpfys0fiKq02XNRVazdYSf6jigv6xDlOR1hfdvRLrX9jqLOngCuljlw1Yx3bFg4zqfva4PyHmgzmm2xACd+9586aOFBro4udMxjM+FI0/LGDe6IVwpr0GtjDmywynZd+cd0FYcJc4sK//HcTkw4oiY9kKmdaFMjtHp5gHGNnExQnaws5XRC9vZGwqEbQT50JxQFhkRZhY6Rhsvv8fkvqVA+E/UYViVASHrNr44Pojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2a0F/J944jHUOTcWE9j7gP/plzq27Y/1/ODv0ble7g=;
 b=Rb9M8KLMLDGFlpkOfkKMy5HGr1AITuP4xt3iizO+8sTyqFXacb0SIqI/H6MS6fYCoCS4Evqawe1FD6SdMxlUqDhVCnkF7ZHp84TwlGMKdCNAfXgufyQSEuCZkaLP0OBTlmGHeZaH+59ITAhQiuMiUljBh4IygSVh6Nllx84OpoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 14:44:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:44:02 +0000
Message-ID: <874746cc-5e61-4f3a-b621-3d0a60e50733@amd.com>
Date: Tue, 7 May 2024 09:44:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] cpufreq: amd-pstate: optimiza the initial frequency
 values verification
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1715065568.git.perry.yuan@amd.com>
 <0049ad44052b051cf57d1059bf71b7ce227a5f21.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0049ad44052b051cf57d1059bf71b7ce227a5f21.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:8:55::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: e546245c-fc36-4983-8398-08dc6ea42365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0RCbEdwMHJlNFBLWnZ5a1p2WGZ6TWVRUzFYQnU4V01IZ3ZPN2NtYWZVUnVP?=
 =?utf-8?B?TDdpaEZzcUYxRzNWMEY1TEFYZkpBTGVSbDI3Uk5vZXprUnRGZ1JVN2JYU09x?=
 =?utf-8?B?VWtFMmw0eGJnejQ3anN2QVFnY2ZsSms1Vnh3WnpWTGxZckhNaHNIOWtGdXFq?=
 =?utf-8?B?TEU2NVpWZERPek0ramRkVnVTL2xsTTJFaWIzcEwzS1RnQS8rSkJrZWh1ZnBH?=
 =?utf-8?B?TnY2N21Ga3BaTmZiTDk3S3IrTXdHcDJwclBxY0ZnbWhaRStKQ2VrQW5iL2Qz?=
 =?utf-8?B?cXhScGE4Y29lOGlUQ2FCUWhWeTl6RkFaQ1JIVGFHTlByQ25aT3FtMkw1dnVZ?=
 =?utf-8?B?VnNQakQ2MmhyQ1Z5a255b0J5UlFqTzNjNW9KYllVbXBnM3oyNTBxNmNmejhz?=
 =?utf-8?B?VkVQWDlqZ3hIWXpmK2tNMWh0dzVIOWhkK1BSQUdFVTA3bzVTYlVZVFQwV3Vk?=
 =?utf-8?B?YW9GNkZXRld4UG5PeHVFcGZsSy9UcHpPU1p1SU5Remk4d1NjUkVnVmQwYWc2?=
 =?utf-8?B?eHNzMjJiTmJnWVZ4Nk5jUWR6eEtSa1BOcDZ5YjJEVU82Q2VXcEt6dkJydXFa?=
 =?utf-8?B?TUJrRm9iSTVBN1RVdUo4NVcwblNTQ2NpSU5PakRldXRnZUJybmM2aTlFM3F5?=
 =?utf-8?B?TXpXSlVaMzExRUxxMitqQzdnVjlXWHZBbEN2UXFkQzJ1bGdjZUJIbjJpbEsr?=
 =?utf-8?B?QXRldnY2bzFhNWlReXRTMWFuWnVPQ0g4THljcEIrNlhSa2NYUENHWVBrYkhF?=
 =?utf-8?B?WTJNQUh3ZXBzOWtRWjU0Y1FKSnlSSHlLUnl4Y3Z0WmdVN1ZzRy9MTTBqbzJ4?=
 =?utf-8?B?a1pxVGEzSEZhN2Z0Nmx5dDVjQ0loN0s3ZitCbVRpaXhNREkwdm02L2Z4bG5x?=
 =?utf-8?B?b2lGaGdUa3pPRVJhTFNWRkJZQW9oVVg5M1NKSXhla0gxL08yalRLa1dJc1pk?=
 =?utf-8?B?ek9adE5ZekRLd0FZblZwRTBXdEhWYlljcWtOeDNGYzZjamhxSXRUZ3Y3UFRG?=
 =?utf-8?B?L2Z2ZzVSbWEyUUNNL0hoc2J5YS8zUWs2Mld5YStOWUV4eU0vZ2ZYcHowSHd5?=
 =?utf-8?B?dFMyN2tVRG4zaVVTNHE0MGNMMnpERHRwQW16VFFsbzc2anlydGNkS1Vnd25u?=
 =?utf-8?B?L1dNamhjSGM2UmNISXVXcWJhTFkxQzBKRi8yakNSczJSWE9GMk51UTlqWnh1?=
 =?utf-8?B?QS9DZ2FUQXQxTjRad09VeVA3YU5jUlNhTGk3KzBZQ21BQTQySC9JZEFNb3Y1?=
 =?utf-8?B?QXpFamJDdWgwTlk3Q3A1cmc1VVVHSDhnTUd5Y1NacDRURXdUdDJRdkIyYWZB?=
 =?utf-8?B?aHQ2cXRsZ2ttWDN3NFR6N2p1Q01rNm5oak1aL09aZy9EZk9XVTNjSTh5d2J2?=
 =?utf-8?B?WXhCUkpnaGt4TW51bFhIYWtVcG1wczNra1dCbWJWeUpySEpPWERBemZrejZs?=
 =?utf-8?B?Zis3RXJKQ0NTbW1OTHQ4TEVJRitxemVmY2RnRWdSTVgxcjFXSUJqTitVR01m?=
 =?utf-8?B?RXFFdDRnQzZ0dEIzZUZiUk1aZmhtb1RvMi9YTzA4THBmbEFrRCtSTjZ4MjZR?=
 =?utf-8?B?bTRpbUJvSkZubVVKdWZBUXF3QTVPUzRDT0ZhOVlWaFJJZ3BVZEFJcWF5Zmw5?=
 =?utf-8?B?cldUMFB6ODlTb0I5Vm4wcjQ1UWdMRlRnMjBDTFVtck5USm5MWVVHT0t3Sy8z?=
 =?utf-8?B?ZjJxVlZSaVpYTTgzQUtySk9UdmNnRXg3bHg0MDM5Sk5LSjRMNHlOWGFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekVPM3pncVdxenhweFgwQ0dER3dLNHBDMkZWV2xvSlN1VGw5aHAxaUkvaHRJ?=
 =?utf-8?B?MWN4NVBtMHVBS0FmS1Zhb29DS0FCekJMNGhjQXdzM0lYWllNcm51TDZpTGJu?=
 =?utf-8?B?MmU4REc2L3BRdkVSTm5GU3NPd205N3BVRC8rUDZ0MFVYRmpCWWZYemRyQWZj?=
 =?utf-8?B?RzdYKzRld3E0UXlIZ1pxOFhrTG9rSTgwMnM2K2Z3L2tmNFE3SmZmTXhkRTZ6?=
 =?utf-8?B?OUFvbVNVaXFZSFowaEprUDJCYS9qZDhNaXUzS2tBQXVRa05xZ1ZoT2hEbU9r?=
 =?utf-8?B?WXlJM3FxVkN2U2grVFBWdUJHRG1YTGhpcXQ2V3FxdVFydG1iTS9wc1hPL2lt?=
 =?utf-8?B?SEZFM253ZUdRei9ORnEzMXNKb0pmeEg0K3hBMUw5cnBOS0RwQ0xvM2FIcnBz?=
 =?utf-8?B?ckNWT3ZpUlJPRHNFbVViWG1HRHNjSFM5M0EvZy9aUDNJU2lYUi82VFJodGpo?=
 =?utf-8?B?UVA0M1NJekhCZkhISEliTnBhV2MranpsVytGMGt0VE9zbEF4aVRhQW9Xcm9p?=
 =?utf-8?B?YlFsNFBCRFZvVTdoT3hEdThLdUxaNFIvTDU4UGdNNzJxK3h3ZWtNckZyWmFn?=
 =?utf-8?B?OWpUSXFZR1psV0N6SFc4dGdzU2pXUkdsRittNGc2MjdRTjRaQm50NHAxTVZu?=
 =?utf-8?B?MWMzY2hMNmYvWitpbzdZQTZzakxLL3NtRk00Y0ZUYmZMc25wSmppZHNYOXdu?=
 =?utf-8?B?eFN5cmY4cWNnNnpVc3k2eTFjQVpQcElzd1N3clJKemhleFpJZXBvbXQ3cXdJ?=
 =?utf-8?B?Y1JPNGJ3bFEwTWkrWSs4OE5mZ1BGQ3lycUZlb2gwWHZ4MXBJT3FDTFZ4cWlP?=
 =?utf-8?B?WHptZ0FqU1VPdzJFVWR6cEkvN1JhRkhYOTY4UWxWSEI3TXNqV09WS3JXMldQ?=
 =?utf-8?B?WmlBbEZrTzNhcExVSHdTYW5yRHdwalNiRlFnVFpSRHYrT0Fwajd2bmNKZVdj?=
 =?utf-8?B?L3NmL2J6S215cnlTOGs2eXJhdmxzZXcxRmEwWXZjQWRJQ1dESWJXOVNPaEhi?=
 =?utf-8?B?dW00bGp4UngrQys0NkY2MVhkYjQrN3I4NURMaTdmZUFyTzNFR3FkZnBEVFRy?=
 =?utf-8?B?TlB2WVNpL0tUMUl3RDQwN1IzS0JCQ3JiT0loaGZ3SjljT2VuNDZqa3NzVEVh?=
 =?utf-8?B?Y1JEWVdKZithaG1mZlEwQkw4UnhuN21RbE1FTmNMcmhSTVFGcFFWYUNQMEtV?=
 =?utf-8?B?aEttRExCTnBCTXhuVUc5U0h1UWhlYUdIa3NCNWRhYlYrOCtCd3RGbnVDRGRO?=
 =?utf-8?B?bDNGaFd0clJFUnB4VERJR0lWL1ZvWWIybDB6MFp2RmFETXlZS2w4Wjc4YW4r?=
 =?utf-8?B?K2tyRVZ4b3h5NndWdkc1d1Q2V0daaFArWmJUajUveWV0K3Ric3VUb1phcUhO?=
 =?utf-8?B?aElmTXhEWmVkd1Q2TFRJaDFCSDJOT2ROMUFSRG5wNkFVSXBQRDVwUDhxSTFk?=
 =?utf-8?B?a3N5RzF6WG5oT3RNRHEwekdMMCtFTHJvckZRbDYzSFhtZ2VXMDlWZUZqTVk3?=
 =?utf-8?B?Mll5WjVvQ3lYMzd0ME1HMUgxaElHZUFoaVV1REZ4QmZNZFBoclRnKzgxdlRI?=
 =?utf-8?B?SnVuRVFVQjF4a1Z2ZW1yNllNai91MTg3K3I1Vlh6U3FpcUpiVFd1YlJMbmlO?=
 =?utf-8?B?c2RWS0xwUDR6cHBYUFNqRlZpQW84bGhtQmh5VlgyM2dWUEt0dUZzV0M0Q3pY?=
 =?utf-8?B?VUhzUHh5cjYvWmtpVWw4eVN5VCtOdTcveHFBYlhYQ3VzaVlVcXh6SEpwZ0xS?=
 =?utf-8?B?M2ZzWFpjdXZEb1JUTVlxRmt0RWtEMHc5UGIwS1JLM3hIdnYwdHQ5NEFsakEx?=
 =?utf-8?B?ZEIrS2hrUzZjRkh5em5tNU9ETFJpaUI3OFBtWDl6S282cEZWbzFZZFlnRU5x?=
 =?utf-8?B?T0Ruc3Fua2I5ZmdTZWFNMmcydWM4U1hCSEdYTEJWRDRnNzE4U2Q1bWl5Sjg5?=
 =?utf-8?B?VzJQZjBHaW1ETy93NVpkcjFoeHVGVnkxeDlobE1WcjI4a0w4L2Jxa0xDSE03?=
 =?utf-8?B?TExGWEcwOXdYbDlZYnppSW8xUHJ1UEdCU1BHRWluQUtoU3NELzI0NDR2aS9J?=
 =?utf-8?B?b2VrR1RQdFlVQjdEMCtUL1krZENDNm5HZVRlUWpiNzdLNVl6NHBiVmJOY2cv?=
 =?utf-8?Q?bEn1+kMGhKzGRT6/v9ulPwxYq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e546245c-fc36-4983-8398-08dc6ea42365
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:44:02.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlEaMzDR0QJfQ8tvivQL9hZXSaDNU6CaTBzIMaSa6BkYL3NycY0hUfwa1+nmkdWNwlfOBviGjdmFWGt044cimQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

The title has a typo s/optimiza/optimize/

On 5/7/2024 02:15, Perry Yuan wrote:
> To enhance the debugging capability of the driver loading failure for
> broken CPPC ACPI tables, we can optimize the expression by moving the

Remove the "we" here.

> verification of `min_freq`, `nominal_freq`, and other dependency values
> to the `amd_pstate_init_freq()` function where they are initialized.
> If any of these values are incorrect, the `amd-pstate` driver will not be registered.
> 
> By ensuring that these values are correct before they are used, it will facilitate
> the debugging process when encountering driver loading failures due to faulty CPPC
> ACPI tables from BIOS
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 35 ++++++++++++++++++-----------------
>   1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2db095867d03..be7f2d3c86b6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -873,6 +873,24 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>   	WRITE_ONCE(cpudata->max_freq, max_freq);
>   
> +	/**
> +	 * Below values need to be initialized correctly, otherwise driver will be failed to load

"will fail to load"

> +	 * max_freq is calculated accoreding to (nominal_freq * highest_perf)/nominal_perf

according to

> +	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
> +	 * Check _CPC in ACPI table ojbects if any values are incorrect

objects

> +	 */
> +	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> +		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> +			min_freq, max_freq, nominal_freq);
> +		return -EINVAL;
> +	}
> +
> +	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
> +		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
> +			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -911,15 +929,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	max_freq = READ_ONCE(cpudata->max_freq);
>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>   
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
> -
>   	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>   	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
>   
> @@ -1372,14 +1381,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	min_freq = READ_ONCE(cpudata->min_freq);
>   	max_freq = READ_ONCE(cpudata->max_freq);
>   	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	if (min_freq <= 0 || max_freq <= 0 ||
> -	    nominal_freq <= 0 || min_freq > max_freq) {
> -		dev_err(dev,
> -			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect, check _CPC in ACPI tables\n",
> -			min_freq, max_freq, nominal_freq);
> -		ret = -EINVAL;
> -		goto free_cpudata1;
> -	}
>   
>   	policy->cpuinfo.min_freq = min_freq;
>   	policy->cpuinfo.max_freq = max_freq;


