Return-Path: <linux-pm+bounces-30487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7BAFEC22
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 16:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C524F4A3DE6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF152E5B0D;
	Wed,  9 Jul 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5Lt8yB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A72DCF74;
	Wed,  9 Jul 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071746; cv=fail; b=YAwbN4Z5UpO+i2ibT1OUwSv/bXGarmBlBN1mqR15FJ2xazYOujLXFKi8lOSqmnrGLU2YBo1f/CNebeBlPeUZjTMFo/nK5GRDR52IecBO+LYyadRz5REhPjSvREBv4597s/QWoKpxqbYRBER48XojCnX/QVj/KF000kteElI4BlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071746; c=relaxed/simple;
	bh=D/6IxA9yIEF7LwL92pnF+DhTwQ3yXlD1JljCs87tsJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fu59yrfKvays4k6riTfnjTkZgE7JmQGaudhvBb0cFrWXz2ka2s/ghTpwoY59kJtqa7LpMjWDoLeW4p9ALtiPeYBbSDhyi7XHJHnCKjJtRpyeL6QVUR1arCCDuLVLbSpAYvHZxxBpB74g4pwxD41jbrZ0Qa8GJpA0tnPppG/+1o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5Lt8yB8; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGN2q//H0HF+Ow41RVlHCYfUXYIvWvIvagvjDBcuQv1gZrfcYeNQ+WgWNtC1+SLcVh7jiOAZMp/M0Ov7fKVY132Z4MFAg9JVBRCYqVP3dPUoffw17mP48lcgxjqj6lqeZxeuCICzYOvP2QcopmedQSIlOI36ABIGWsrCbfLQYH8znUHpCz7uxjfGMTHSUUNTakQHgm7hN5X8NNnhepS0cn/lnYNNdeK0d57BTur0IN2R8KapSKWhDINNznZFW2osbIhIrrspl/+NBDX99P6M7+d4RFRoUj1h9zxq+ES2Ih/wFdGXwvxY0K/NJwZuZyaT2x9oryX581aEcdA+e+Mo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLE8NtYm4NLVgl055MqbNJouH65MXjU2mTWEElAMvCY=;
 b=r5HDMqiFhZP1tFNxrjdMv8q7KRPsSVPLuknSZ0bf6/QabKr7e5iQwbJTcC77m4VteEKXSKFrJIKs5O10guDLlq0cQiNFpajejYTBk3OJfX5V4l1Qsa/JHJLSxpWZpqFWL02sCEGrmj9dzb/soiIWUaE3bo8AjC6tWpBueVYP/t7N1o9VkFsO9yTQVWbfQHS+NhTIfaU6DQt4lc1JbORbErj6mLgcZMyFKPLdy45zGKwaLYOu2NtapjWefOHvJGgGiLgRxBlFEo6wXsY8slFUwfy1yeJth/gwGgMoyNMmQ6lsbgJ4hc4tkII61xdXDXaPkdP7kknrv5d4adh/1BrsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLE8NtYm4NLVgl055MqbNJouH65MXjU2mTWEElAMvCY=;
 b=z5Lt8yB8lKe7q8YdYF3PQzM4rNNxjUv+Kj8U9Ghj+7cZWoTB9BnnPyGhP25QYf4ROeGn8VTEjfh9YVoNfJCdlXHkzQxKAUWW7rdC08R2vns/hVxxsbw4Hqx9V3/epkuyxizXYTRUNPPF5GqijpYxo4Hie7hfB41Hb575xVAEtGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 14:35:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:35:42 +0000
Message-ID: <24c245be-1ae6-4931-a0ac-375cae18e937@amd.com>
Date: Wed, 9 Jul 2025 10:35:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
To: Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev,
 stable@vger.kernel.org, Nat Wittstock <nat@fardog.io>,
 Lucian Langa <lucilanga@7pot.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org,
 len.brown@intel.com, linux-pm@vger.kernel.org, kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org> <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org> <aG2bAMGrDDSvOhbl@lappy>
 <aG4AilDpnqrqHXaS@duo.ucw.cz>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aG4AilDpnqrqHXaS@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0487.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: b8854723-51c6-4c4d-1154-08ddbef5e19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXdFSzZacGdaUEtnWGlDNXQ4T0pFMkJXTERLSGpWeWw2OEtHUWFsSW9YNnJ5?=
 =?utf-8?B?WGp2dVFtM2xjaGY0bGNxV3hIUi9nWXArZFUyREluRVk0RTZsNUZ0Y0VSVU5o?=
 =?utf-8?B?VnRpVTJlZUNvRVcvYkV2Z29SZitqaHRPUU80eWp5WGhTNkI2b1ZpWm9NN0lT?=
 =?utf-8?B?K0JmejgwanRKQm5oWWpySnhRZ2JwNjJ3V0xmSXRmNS9NOWZ1Nkx0MXFmQ3NG?=
 =?utf-8?B?NnVGUWdOVlpwenNSUllURFkzbnFNRXUzN0dDd2NXMUZRdlVDTVRZODFiNHZa?=
 =?utf-8?B?MCtscUthdXNscWNFV1dGTlM5YVZVUjZ1QklnMFBENk1QZ2F6cG5pbVdJUis3?=
 =?utf-8?B?REpkSmF5RWQ3MnBqUW5ZV2cxQWlUTDFjY09tMkhmZEVPOGtJbmM5cERmcG5V?=
 =?utf-8?B?NEtFcWt1bEtTalMwOUFpQklIY291NVQ0RjVIRUlrMnA3ZWtpTmdSVjJIcEpO?=
 =?utf-8?B?bTVpVlYxOVloSWphVlJBK0dsLzk1ZFlHTUFOOU9zTDVSTTFiR09WaWJXRWNC?=
 =?utf-8?B?dWp3Mm1rcmNBR3NBUlBsUnZQWnVrNXMwOGFzUk1ORmo4L3ZhV3U5cytQRmhU?=
 =?utf-8?B?M1QxRFVndmU4bFJmZy9mS3lkeFZsMWFWSTUzbHEzcmNCQ1pKMVVNRlJSdUdU?=
 =?utf-8?B?M01PS0ZwN1ZDei9JamMrZVJrdkhSZmo3NmVvdkJneGFla0xlWWQ5WWdqd2pD?=
 =?utf-8?B?ZTdiUFVhWWk0YTRJRUZubi9Ua3NBMXdSb0lhVW5CcHpzMW9GeFRyTlhhU3FJ?=
 =?utf-8?B?N3BrNmJhKy9qU3ExeldyUG1MR05ia3dwUHlVVDNlZlZOM3ZqSUtFMlV0QWhM?=
 =?utf-8?B?NUkrejBoM25mWFFGemRxaWV3VnJxU1ozbG12R2d1eHJ2akhTd3IxUTZyNTdw?=
 =?utf-8?B?MFJINnlrZkVWbXpaU3VpaXJNS3VRWkV2dmJGWGNKSHNDdkVZWVVWTEFVODR3?=
 =?utf-8?B?YkgyK01Jb0NxUjZpNGdudGp5cjBWNlk5QXNvZXBMVXZxamdNUml6bFZmKzFT?=
 =?utf-8?B?T2NtMkswNGVOTXAwU2J0dWVjeXBCeWU3WmIxMXV4aFFhYUJXZGFidlF5R0xM?=
 =?utf-8?B?T1UybXhUc3pDdE4wQnNDL3ZLMFpaaW5OZjFLSWN0cW14K2dHeSticlpyYnNw?=
 =?utf-8?B?K3lIYW9hc29BaWRuQlpPdTYvK0t6b21uSkJkKzZubEFILzQ5K25vQTdzRDR5?=
 =?utf-8?B?WHgzSmJxaTV5aDFWQTg2ZjRuek0zZ0lEZThRby83SCtmUUpJUW1hWDJFU0VY?=
 =?utf-8?B?WFpYRHRQdlkvUDBJWU9EZ1hueXRJM0lqT2t1alhpanZFWjZHOTY4dyt3Qmhl?=
 =?utf-8?B?cE5sem1OK0Z1UGJOd3M2N0tLMnlzVUNGS2hPL2JQc2RuRENvanJUWVAxUmxk?=
 =?utf-8?B?VkMzeXF4b0xzaW40RS9UNHhXdDlUZ2RweGZlL1N1OFgrY29qQkJmdHpLRUlk?=
 =?utf-8?B?OEtWajNWby96WUxQSzZDbTNCdG1kNUlvSE0rdTVmOG1hdHVaaFEvWG9QTHhy?=
 =?utf-8?B?RWFHLzF1Qk5LZUE1UG8xTzZtTlg1YmxPRkQ1ZncxVTQ3WkIwaHdWbkdVUDVj?=
 =?utf-8?B?SkVpY1dQRHR2elpWd1ZrUVJKV3pZelh1MVh3NmpTVEFYZHAwckYzd29STFZU?=
 =?utf-8?B?emNrZTlraGM0RjJaWktxQ2xxZEcyTjhWbnZraDF0VFpvYUlCVGUxNHVLRklT?=
 =?utf-8?B?enE5b3Qzbzc1ckJ0dW93M05NekhmZWdrMUpoMXRWN3pva3Q1QnFQMFIzanZk?=
 =?utf-8?B?bXorSXBUa0NpQnJHbnp1aGFUNEhRd1BsejY2RE5sNVVOWUk5cEFmcVJGSnZt?=
 =?utf-8?B?d1ptWE91TmFSby9lc2RxUTlqRzFiQVhlZHFVcVN6QU54WGlFWU1oTVh2WmZW?=
 =?utf-8?B?QlA0QnhaNVMxc3NncHpoMW9CUTVVY21FeVJuZjE1NGI5ckJETzNBR0F0VVBH?=
 =?utf-8?Q?4MnhvGHG1To=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3NBbXJWaU5kbG1acGNiTWc4Z2lCSzFITmlncnlaVFY1amdZRGs0OUZYRy9Z?=
 =?utf-8?B?VmNnaUM5akZVck1OVEIzMHpiMy9tVVoyb1JtZloyc24rMUpieVdsUURYUVZ3?=
 =?utf-8?B?QmhRSFR1ZllLRWRDdWZOZHJzaEtSQmVTd1RYUkkwMmtteFludWI0dFVLVTN3?=
 =?utf-8?B?OTlMaE5tcDNVNkYzSm5HTVpTVU9JN1hNL0s5blg0ZFk3QmVUbzJDQXErTE95?=
 =?utf-8?B?UHlXRWVkalZaL2pZZnVvVDNXb29KUkJFQi9NZVpMUFdocjZJK2NGRnZxY1Ro?=
 =?utf-8?B?YUhmeU90b0ZQNS9RUmFGMU96eWVjUjJFUXFONko4SXBnd0NDLzdBaHhtazAw?=
 =?utf-8?B?aTdIckJZNWl1alJYaEU5T0JoVWpsazNSQUZmN0Rwb2psbG1NYmc0MTFYTCtx?=
 =?utf-8?B?VHRXTDY4NU95MyszV1JTeTEzUFNVKzBxQ21NK2swa2dkVVUySS9VTEpWenRS?=
 =?utf-8?B?RURXdWZVeUZVbGNuV2J2NXBhd3lZRm1rbFBWK1ZMNlRLQ3IrQXFXMkNPc3RY?=
 =?utf-8?B?cUg4ZHZxUFk0UFBLcTlwTFd6QzA2bW5La3pKYUN5NFBrdHRJaElhM04wR29V?=
 =?utf-8?B?UFJUK3pnemtYZFNZYWlvR3FNS2orWGZQVlFTYUNrNW8rMmdleU92VmNyT0JH?=
 =?utf-8?B?cko3QnFTZldNUDJHT0t1cTM2eGJiM3gyYitaTVBiN1NYeDNDS0tiT0llTlAv?=
 =?utf-8?B?aFFjZmE5K3pXdDM0RDU1dkcxdlVXYlZpbWhORlZVdzRENnZYbTRvNDVOQ0Zt?=
 =?utf-8?B?RklBMjFqcDBlNXNpRzV5enVjRzA1cVRrajUvbnpsUytTSm51cFZjaEt5YXlI?=
 =?utf-8?B?SmZWMmZJbzhuN2wrQ0thRTFWMlNVeFBWVC9YR3MwTFRTalFxQ0tYaXQ0RGQ5?=
 =?utf-8?B?VGtoakhnSmRzVGJwTkltWWVaaERnU3kzamQ4VmJvcHQ0Z1FWWWgyWStBRXhz?=
 =?utf-8?B?WURBUXFoTG03R3BaZXhqZjRnVmxSOFVXUjZuUzltVnR6RkxsK1ZtMDBFMS9I?=
 =?utf-8?B?RnNZdEpzU0xYb0lGWmlRS25PZFcyb3JaRzlLMURxajhha0U1UjgxZEd2OXJp?=
 =?utf-8?B?T3lCcmhFMkl4c2l1ZzVhT1o1T1N5ZHdzd3lLQklCVXF3OXZiT2ZrbWJZa3Zt?=
 =?utf-8?B?T3huaUdhcWFKRmNFaDBwRkVONE1xblMvSmx1emROY0JKRFBjUm5DcTFLdzEv?=
 =?utf-8?B?d0c4R0MvV2ZWT2QvNlB5bzM0MTE1cFRQQnI2Zk5XOERja3o3OVZrOVRqcWw1?=
 =?utf-8?B?bXNLWkw1aHBmUzBmaTRsWGF0RXUxNnpQSHVnRENNTUhEaDhoQkloamRlc0VZ?=
 =?utf-8?B?WjRRQnVKVEpadk5UUTRLUEJSMmlFM1MwaUFmSkhkK3lzSWYwZU1HZ1ZXVTNE?=
 =?utf-8?B?bzR0WXcxYWxtUXEzazVkZFMxR1FKZ1BJYUxvWXR3enlXY1ptY0V1UmdwWm1m?=
 =?utf-8?B?by9xRGxNN0xyYW5BM3VnTURBVDJ2UmpSU2R3bFRwTkpkVlVLYlV6ME1zeCtO?=
 =?utf-8?B?TmxGa1pHbjJ6bWl2aGVmVmVGUlk3d3RFR2JBb1NXVFRNdERBZUdpZkoxdzNh?=
 =?utf-8?B?c1dlZmhRakJaeGlNbk03Q3YybDR3OVEyRmFBSE92M2tFOXA3enRENitsWEpv?=
 =?utf-8?B?MkVTNzEzNTlVOElBeEhhYVI2eVlJQ1lPLytGRm5lUjVNZW1OVGJnb3hUWXVN?=
 =?utf-8?B?VVZJWkhjcFdGald5Qng3VE9CcU5zbUxPOHNJNzdnOTVDQkFLaDJqNlJ3c0lr?=
 =?utf-8?B?Zi9rdVIvZkRXck01RVNFZ09KVE9vRFgzcVVrdndYS3k1RXJvKzZ2KzlOck9O?=
 =?utf-8?B?amwydURKR2RONHRqdTBSbVg4eXZtbzFuOU43eEJCa0VpUCtNR0dpajA5UmVn?=
 =?utf-8?B?WHpMNEpEeE8vdjNqVVNKU3YwYlBNWm5xZ2xJbXdRQytlejFSa0MzeEg1OFFY?=
 =?utf-8?B?MWNCbjB3SUNObGJVR0NVcnRVd2xNQnV3YWtyd1hXRGRyc1JmNTFYMGNWUGdZ?=
 =?utf-8?B?YkxuTDEzMi9RVUkrUFFGUkI2ZXpoTUxJQzZhaUI5MjVOU1lBaGpJMjA5K2ht?=
 =?utf-8?B?dFdzSDYwLzNZMkRHbGh6TWg2S1VhQ0hHSjAvbVhvbEoxSjlIaXpuVmk0VjJE?=
 =?utf-8?Q?d+fRURme9/AO4Jgclngmbjvcd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8854723-51c6-4c4d-1154-08ddbef5e19c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:35:41.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndjo6isAEOa51ifNZgiPk0p0SgUP3ulkmoCGs65vKfEUZAxvlcvbljbShxta6Q7h/uSPziwYfgiyTkVh4lNPtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

On 7/9/2025 1:39 AM, Pavel Machek wrote:
> 
>> In this instance I honestly haven't read the LLM explanation. I agree
>> with you that the explanation is flawed, but the patch clearly fixes a
>> problem:
>>
>> 	"On AMD dGPUs this can lead to failed suspends under memory
>> 	pressure situations as all VRAM must be evicted to system memory
>> 	or swap."
>>
>> So it was included in the AUTOSEL patchset.
> 
> Is "may fix a problem" the only criteria for -stable inclusion? You
> have been acting as if so. Please update the rules, if so.

I would say that it most definitely does fix a problem.  There are 
multiple testers who have confirmed it.

But as it's rightfully pointed out the environment that drivers have 
during the initial pmops callbacks is different (swap is still available).

I don't expect regressions from this; but wider testing is the only way 
that we will find out.  Either we find out in 6.15.y or we find out in 
6.16.y.  Either way if there are regressions we either revert or fix them.

> 
>>> I assume going forward that AUTOSEL will not consider any patches
>>> involving the core kernel and the user/kernel ABI going forward.  The
>>> areas I have been involved with over the years, and for which my review
>>> might be interesting.
>>
>> The filter is based on authorship and SoBs. Individual maintainers of a
>> subsystem can elect to have their entire subsystem added to the ignore
>> list.
> 
> Then the filter is misdesigned.
> 
> BR,
> 								Pavel
> 
> 


