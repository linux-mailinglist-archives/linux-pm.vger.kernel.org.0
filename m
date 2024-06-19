Return-Path: <linux-pm+bounces-9631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C42290F750
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7E1C21C1C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CADB1E4B0;
	Wed, 19 Jun 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnzmgvtE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04344A19;
	Wed, 19 Jun 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827255; cv=fail; b=seb6a/XaRiurdGaTlxHXWmq/oAouTuisOcL5lvU8ruTB3inc15/z7+fGBBqA8mmIwnDRwsjd77yE5gTLt+Rxwa8pXMbI3hewAapQ82OP0FWzyCO5h4apB9a3sR5X/wCiFz0AFpXIXkRiNEqQ5Y3DU8z1Fs7ZJ3i0hGL/5I4UVMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827255; c=relaxed/simple;
	bh=2Lti4Ovxez1+XUFN6HhzP6Te1VQeZwj0UsynF7e9UPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+/8x0do5gueX8PnsM5BeBKEkrHw/GMpCo3H5K/6WdmRcROYQ7ZrtXqDOKfcv6n9nY4YaGha10qKTMcYGaDhAyxq6ITx5EyzgiML9iVmAcq9rHlW2RPe34bYAvIdDfeCqkbI1Awk7GZUd5NOP7yaueTkV1bdhAmz0N2RnliOKTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnzmgvtE; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPWOo/5aRLt3OHckzXYDK+SC8YP42fbV65NP1RinbRZQKbNTP7qbEaONNIhPKcC5dQgC7C1BWp8oHvFI4lUNxAlIk8CDCm1BJFWuyQuTt5J5I9KyBrc2gLh1Dp9MILvqKncF3rNQcd1F8bedyMScR7nIJJLpWelQYmw9G3uKHszVLtn22g/xP51J/vNl7Vm55sB1NMNXgonLUgT8BqvnGclqMUHaXaLBk0P3Xgi+zynRrzMbf86lD8RKZuyMrjLiQSV488Azq3dQY6px23Xxk7kMDXO5aQIDQiRYIXcTVaYp+wM3whOiQEuOWG6DfKrC3B3CS80yTWl274aSVJUIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp28w3vABNOEMYFiqbcQbp2f2Ol6PR5u03AbPTtkASg=;
 b=WlLAN2VnmW7BL2O+39c85p3IDq2QXFeOlRkAWtJWHaPZZXPZrC+U80Q+vXrtdTPzk2EqYZozwvLghMB3AzpnAeYbN4wnqQxM4pDbvQfCJm0L07BHNe81C4/SbC1LLboCdCWG2RMn4v5P70/y3fEXIRKKB8qHfUmVQWMGQm9MNwAa+p07vZyAE3/e4ldHJemy8FLYUAfyXZz2vnrWLrh3/F955dQHE77aXM9G3MOtGVbYwmvTBz81+q8lG+tFoWeshkrCbbNS777Ie72DucV3y7Zn+CRxw2caIB5qOdXKr2FOB21SlXpc9KzTEVNqlMZ3NuKzABZ7jpucOGkvYI3BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp28w3vABNOEMYFiqbcQbp2f2Ol6PR5u03AbPTtkASg=;
 b=rnzmgvtEJbWjIoLWi2QKZ2cBSHsJGlyuEC+4oqIMDugOj9RACzFazHzTmZikBK7mESRcvlBHNpLih0KdkOzfObTcPVVQBRcu/Qfpm6eRAF5/zdRUc8R0T6Wq6BVdzU8B1s279C3jHlkQDSknFWQGyewNP2tR0xBz66sdKOUSNNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 20:00:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 20:00:50 +0000
Message-ID: <39014142-2232-4d8c-a51d-1c10a2278ad6@amd.com>
Date: Wed, 19 Jun 2024 15:00:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: update to sysfs_emit for safer buffer handling
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Borislav.Petkov@amd.com, gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240619081520.259971-1-perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240619081520.259971-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: dac42a14-5b95-4aac-0c8a-08dc909a84ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnQybmw3U20wSE9EczZxdkYyUVBZWVdPM3dIUllvdFY0TmtwVGtqdjFkdGM5?=
 =?utf-8?B?citNTVp0allTUjRqN0RLa01hTVB5WkVTd05GNThJSDFNK21abW0vanUxYVBo?=
 =?utf-8?B?TUFtaENLR1hrRGRaU2d5Uytkc3VzK1FTYkJ2SFhhZnM1STRvY3Q2OUF4a3or?=
 =?utf-8?B?YktMdXI2OEJYbHRsSnJkSHJuQWdZckwrU0FNVmZadEpGV1lDUnJETHArN0sr?=
 =?utf-8?B?RDlwV04raFZVaXRaMWhMZnBhbCtGQTk2WEtLL1VFcE1DZVdMTnAwSHlnYyt6?=
 =?utf-8?B?dVRtdTU0ZUhTdXRWWi9ZcnB2eHZjQjU3aFFZYUZQeUp4aTZkbTdzMUVXcmI3?=
 =?utf-8?B?OFJpMDRZZUJLMndQemxFby9jV1dnSTNNakllekNMRXJoUWpYZ2wyNWRsR2xx?=
 =?utf-8?B?bFRoa085VTNraktSemRpRExDbjZaUUw3NWwzSnNEMHdVL1NvYTFxaUl0ZTdz?=
 =?utf-8?B?T0JOeHpiSHM3eHJTQTBCZWU0ME13dnBvVk1xcmY3WGt5VnowVXRwRXBKL0F2?=
 =?utf-8?B?VlJrSXdGaDA5d0tmNVpZbUpnN1FLNWI4RFVlT0pVUTR4SE5DdUczSm1nOTg1?=
 =?utf-8?B?c010Z1lnTlhSamg5ZkQzL2xRZ0VSQnFPWThESVhWNGJOSXZzczBWQ3prdHE5?=
 =?utf-8?B?UWdYKzFaU0s3TnBiQ3FvcS9vclNKYTlqQ0hHWUNib01kWFViR3VNWjNCS1hE?=
 =?utf-8?B?SzEySGlpYWI0ZjJFb2pnQU9EVld0TzlIVXpEWXBLZVQ5eGJzV3ZlbnFDdDJO?=
 =?utf-8?B?QW1UbENCWUV5NTVTbElzaE5GWXRtNGI4dkpvZVE3VUdqSTcwMFRNMTVnVXZE?=
 =?utf-8?B?a1dDZ3g1M2xHMkVuMlczTjQrM2RiY1VaWVBjb25MYThYSFdaVENEVkRaZ0p5?=
 =?utf-8?B?SXlGVHFWa1VhUU9KbkpuWlJpZ3JFVXkzV1FJR012R3hocWJaRGtCUDN6a2Rh?=
 =?utf-8?B?ci9yRGcxUE1uZ0htaHowN3BnMlhIcldtc25DM0IzRm1NV3h4R3VyUjY3cXBs?=
 =?utf-8?B?SC9XL3BxczlMaWd1czhHQUtDSGN3QWFJZFQxdWlqVG9ueStNNVAzamhneXB3?=
 =?utf-8?B?ZFRCY083T1VhRUhZZGdCVm5Yd3dvNGJFSzJUT1I4RFo3L0JtVzh3VGZnQTRU?=
 =?utf-8?B?TFlJNDVmUWRrWlh5TE9pVmYwVUZScGV1cWNiSGpKMUI4SFJCLzhBc2dvSzd1?=
 =?utf-8?B?ZW1sV1dEa3BEZEl6UG5mMFZZb3E4em5IZW53eS9ZTHAxc3FDZS95aXpUOTUv?=
 =?utf-8?B?TlJCdFpraWNwZWFQN0NMeW1NeUg2WENKZ2J4MlB2SlQyUHpvUSsxcG9oNnhS?=
 =?utf-8?B?eHVmUkY5MktnMDdLTkZxZXlDZ3N4NHdkblJkSmNYRGJFa1FUanZoMmJrQjdF?=
 =?utf-8?B?b3RtNEh6ZGMxak1YRmppVVVHYlFISkg5NDhnV3d1d2ZxZDhGMW9mYkdCMHI2?=
 =?utf-8?B?ZVlTZlNxR3JLbEhubUtVQ1FPS0orUmtLaEtRbzZnVWtRZ1hUdEdEdlBHMGNI?=
 =?utf-8?B?K2Fzb0tFVk8xSzRQSjJwZHFoY29HTzVjNTlSbzdzN2hTeUR4RDlkVVJ4MEw2?=
 =?utf-8?B?cHVCMjAwVjA4a3JWbjNUaGhsbVI5SjJva3dYdFZIN1k1VER5cm5USi84MlVZ?=
 =?utf-8?B?cEI0bkZWc2JCZEFlTFBITEl6MExFL2R2SUM2MHJpeDQyMUcyK1pPQktody93?=
 =?utf-8?B?K1haOWxsTzIwcUUxN3JyUnFBMmZqQTcydEJWVTROQTVkZGRuUDVsakluR0c1?=
 =?utf-8?Q?sMj2fInt0n9MJvXZcNe6vV/IBkiPnmYegyPdrZj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWN6dk55QWphcmVWc1BoU2pQU0p1S2RBc3Zhb2xRTDluYlZwRUd1TE1LMEtQ?=
 =?utf-8?B?ZW5TZFVlaitnTHZXZ1FWU0lYQXZBK3VwdTVXNmxRTUduc3E4ZnQvV1NTQ3VH?=
 =?utf-8?B?ZWhnbUFnUW13RHIyNndnSjRDYVdoek9RQVk2Nm5ieStycG5RWlRoK1NpTTBP?=
 =?utf-8?B?bHQrbVc2amZRK0t2UHRyd1cwWE9MNVRPUTZ3OXBuc2paMUt1RUJIQlozdURH?=
 =?utf-8?B?a0w2dFd1YlB0UmJPNXpOSG81UyszWDg1RmgrY0VzVDNtOHV5SHNyV0J2REpv?=
 =?utf-8?B?Q292R0hURE9Pc1A1NkN0TExwMHlmVVlwSjIwQkJMSjE2NWdjTGtKMldlSFR2?=
 =?utf-8?B?RjJVVHdjUWNNYjJGb2xTejBJakdNZnhjUnUwSDJERlNjbi8vbXR1aEk1UE5n?=
 =?utf-8?B?T25JeUNrR1BEd3ptTnNVaDV4WWdPdDZ4ZVlHMnNHdmwwMml3aUVyTnRORk5P?=
 =?utf-8?B?MG9mZkpuay9VZXJ3eFdzR3NidnhjRFBJNFZlaHM2NHFtVE03WUJxZkUrTEd5?=
 =?utf-8?B?WUZxd052a01LYUZFQUN2Mzk5eXBWVVBVRWlPdjZ4M1RYOGJIQ3A2VGhKVERK?=
 =?utf-8?B?UjR5TkNnS3JabkJENlBOYTZtUVlUcytKeG5hM1NKalRVTG05S1FaMnVrWUt1?=
 =?utf-8?B?TmxZMmNScmZ5MFA3VjZIZ2RYZ0ovT0N6NGU4bmpSUXdMWFMrSmNtZU1NZW04?=
 =?utf-8?B?UndnY0o1M3Q1d2pRanpoOVdyY3RQSURPVUg3eWp5ZUIxK2VwSXg1ZXp0NkxS?=
 =?utf-8?B?K2swa2t6cXd0MHJqa1kwTlArbFMrbU5ZQ3FTYnd6ZlJBbEVMTlhnZnZvZ2pJ?=
 =?utf-8?B?YWo5MEp4QVI5Y2YrUGRKZm5EZHBxcElkN0F0c01SWUpDd3YvRUVZRkszMHI0?=
 =?utf-8?B?V1dpN1QycGVCVDV1WkxYNkcwbk00dzlSVXBodmpubGF5eGcvUUYvTWVFY2ts?=
 =?utf-8?B?Z2V0THg0QTY1Z1pkSGsybXVab2tUSDY1YlpQWTlkdTVHYW80UVJndXE3cEFJ?=
 =?utf-8?B?Y1VnR3NNYmFVbnFoNTZUZXA5TkhDUnpmb0dyWkx6YzJ4UThhaXhiWEkrV3VL?=
 =?utf-8?B?MlN2bHlFRFVrL0g0NiszL2N4azREYW00OTRqMmtaeTBWeHRsTFRIYTVtYkdO?=
 =?utf-8?B?N2NkZnlwYUhIWDFOdFZPMmYvVCs4djhGYnNOeDgyOWZodXVuZUM4c0NSbmhR?=
 =?utf-8?B?M2FWRHFDUEJNd2JGUno0MGF2VWVic1JCdDZXYXFFbk44Sk1BZjY4UGpxZWRo?=
 =?utf-8?B?dnZBdjVSQTRzc2JNRXBVa016YVBkR0pyN1VYZlQxQ3ptMTJYMXVYT3l3Vmo2?=
 =?utf-8?B?OUdwWjlYWHpYb3RnVkNSMTF3WUhlQjUraVl0dS82bTVmUDdGK2ZLMHNQM2Y2?=
 =?utf-8?B?Sk1DS1hIanB1VVU0ZGNiV3ZvckhXOGFGWjlyL2pxNmZWbUNBWUN4UXc1YUJk?=
 =?utf-8?B?cTZmTkJFZEJvdkR2QzBiRE9PYy9SMHBuZXlKMXg5cjFGd3I5RjFKekhBdTk1?=
 =?utf-8?B?OGVvdDVoUDBFdmdPc1h6Z1dCbitTUUoyd2VEQ1Jobk5Dd1lsSmhsbHYzUjJx?=
 =?utf-8?B?Z05nejdSaHBLbkNJSEhpSFBkNGpqUnB1ME53US95OEFaMlFURzNPekYwbVZW?=
 =?utf-8?B?V3U1bWJQdjFOZ3lMZzNUME92OUQwUGlhTVorV1FNL3JicmF6UDkvZVhVRlc5?=
 =?utf-8?B?T1laVE01MXd6dkhNTy8wdmw0QzBFVlVxR29rNGU3YVQwbkwwcVpBaUJQSEY0?=
 =?utf-8?B?TXN5QVFCOXl4ZytKUUJ0WUZFZlk2QlZKYVNDdWFYNXF5ZTVFT3gySTVDc2ND?=
 =?utf-8?B?UHVYNDFOVkR3ak0xWXpjeVc0aGR1b3hIcURaWi8rZngvbXRaZXdicWdtV2tZ?=
 =?utf-8?B?Z1dyZVZDeDBqUFpNeVJxR3RhQzBYMHpHVGM1V3FOWG04NWkxc0luNnN6bThy?=
 =?utf-8?B?T2ltT3VsOHRaRVdEdzkxT3d2enpnMFEwSHpmc1E2RlgvYXI4enA4Yys3R3hh?=
 =?utf-8?B?VVJCcGd4RkZSclMzbHZKcnl5dU8yVjJUTWlOdE1ld3YzUUk2K1J0alFGbmsv?=
 =?utf-8?B?WlVzaFFnYVl4ZVQzdnZoU3prZXV5VjgxVVdrR3hRVzA2TUFTR3BaNEFhTk1u?=
 =?utf-8?Q?1j+JE/IrpNy6uAV6vumBnGgfi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac42a14-5b95-4aac-0c8a-08dc909a84ca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 20:00:50.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUMazQU0v5twCTBkZtIl/L/xuiiVpBNZGQ0dkD8DV3K1oG8jNQTfUvMPIHeg61WYFuERsmwoeHwYjT4VZ/UXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

On 6/19/2024 03:15, Perry Yuan wrote:
> Replaced sprintf and scnprintf with sysfs_emit and sysfs_emit_at in the
> cpufreq driver. This ensures safer buffer handling and consistency with
> sysfs interfaces. Updated show_scaling_available_governors and related
> functions for compliance with the new API.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e1a4730f4f8c..e76d8e2b4c87 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -608,7 +608,7 @@ EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
>   static ssize_t show_boost(struct kobject *kobj,
>   			  struct kobj_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
> +	return sysfs_emit(buf, "%d\n", cpufreq_driver->boost_enabled);
>   }
>   
>   static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
> @@ -738,7 +738,7 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
>   static ssize_t show_##file_name				\
>   (struct cpufreq_policy *policy, char *buf)		\
>   {							\
> -	return sprintf(buf, "%u\n", policy->object);	\
> +	return sysfs_emit(buf, "%u\n", policy->object);	\
>   }
>   
>   show_one(cpuinfo_min_freq, cpuinfo.min_freq);
> @@ -759,11 +759,11 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>   
>   	freq = arch_freq_get_on_cpu(policy->cpu);
>   	if (freq)
> -		ret = sprintf(buf, "%u\n", freq);
> +		ret = sysfs_emit(buf, "%u\n", freq);
>   	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> -		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
> +		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>   	else
> -		ret = sprintf(buf, "%u\n", policy->cur);
> +		ret = sysfs_emit(buf, "%u\n", policy->cur);
>   	return ret;
>   }
>   
> @@ -797,9 +797,9 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>   	unsigned int cur_freq = __cpufreq_get(policy);
>   
>   	if (cur_freq)
> -		return sprintf(buf, "%u\n", cur_freq);
> +		return sysfs_emit(buf, "%u\n", cur_freq);
>   
> -	return sprintf(buf, "<unknown>\n");
> +	return sysfs_emit(buf, "<unknown>\n");
>   }
>   
>   /*
> @@ -808,12 +808,11 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>   static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
>   {
>   	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
> -		return sprintf(buf, "powersave\n");
> +		return sysfs_emit(buf, "powersave\n");
>   	else if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
> -		return sprintf(buf, "performance\n");
> +		return sysfs_emit(buf, "performance\n");
>   	else if (policy->governor)
> -		return scnprintf(buf, CPUFREQ_NAME_PLEN, "%s\n",
> -				policy->governor->name);
> +		return sysfs_emit(buf, "%s\n", policy->governor->name);
>   	return -EINVAL;
>   }
>   
> @@ -872,7 +871,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>   	struct cpufreq_governor *t;
>   
>   	if (!has_target()) {
> -		i += sprintf(buf, "performance powersave");
> +		i += sysfs_emit(buf, "performance powersave");
>   		goto out;
>   	}
>   
> @@ -881,11 +880,11 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>   		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
>   		    - (CPUFREQ_NAME_LEN + 2)))
>   			break;
> -		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
> +		i += sysfs_emit_at(buf, i, "%s ", t->name);
>   	}
>   	mutex_unlock(&cpufreq_governor_mutex);
>   out:
> -	i += sprintf(&buf[i], "\n");
> +	i += sysfs_emit_at(buf, i, "\n");
>   	return i;
>   }
>   
> @@ -895,7 +894,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
>   	unsigned int cpu;
>   
>   	for_each_cpu(cpu, mask) {
> -		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u ", cpu);
> +		i += sysfs_emit_at(buf, i, "%u ", cpu);
>   		if (i >= (PAGE_SIZE - 5))
>   			break;
>   	}
> @@ -903,7 +902,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
>   	/* Remove the extra space at the end */
>   	i--;
>   
> -	i += sprintf(&buf[i], "\n");
> +	i += sysfs_emit_at(buf, i, "\n");
>   	return i;
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
> @@ -946,7 +945,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>   static ssize_t show_scaling_setspeed(struct cpufreq_policy *policy, char *buf)
>   {
>   	if (!policy->governor || !policy->governor->show_setspeed)
> -		return sprintf(buf, "<unsupported>\n");
> +		return sysfs_emit(buf, "<unsupported>\n");
>   
>   	return policy->governor->show_setspeed(policy, buf);
>   }
> @@ -960,8 +959,8 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>   	int ret;
>   	ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
>   	if (!ret)
> -		return sprintf(buf, "%u\n", limit);
> -	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
> +		return sysfs_emit(buf, "%u\n", limit);
> +	return sysfs_emit(buf, "%u\n", policy->cpuinfo.max_freq);
>   }
>   
>   cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);


