Return-Path: <linux-pm+bounces-8951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11816903EDF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F311F21BC2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C9176FCE;
	Tue, 11 Jun 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qkJSIL/6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1B28E37;
	Tue, 11 Jun 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116323; cv=fail; b=gDIaYbkBvyjr9wWHQFeuZujk5LrLN8ggfSm6BNNJJzCnsgp8m9EqzdIyLCsVc/Jtf62AAiRY9ihon6KbsvNt7Pd4a45bdp1wifjbJak+xvxJcgqOBz/2QQgeTb7P6YgBf1jx0aBaYvhzrlKYmN56bbL2Ws8a5vE30zecfWyA+BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116323; c=relaxed/simple;
	bh=PrMt0/hjzn7znGNzT4sz0rQlysfM1y4RMI83w6wY7sw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ozlLglcWTEK1vIILJte1ryiz2iOCNmLAv2CZ30n/fYPA34jmX2RWZczul3sU1j6Ws5dxgcu5lzYY3sppB/G15+8aFrnQ61qsQvAfrVPs4d7GQL+pykAfjSvtkEtxj5gI+nrvMhHnMhRv0QKTWz20wCAjpOWqf/Ku7mHlFtV28ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qkJSIL/6; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghENoGSpS3NXks22v1vP3wuSH5PyylgAx2a9Nn103JJfAdaIifN/aS/orVqfoVsbpNKSNiA49o8SQLcciz3wYo/a1pXXjGlDcjnqVBKFKsa508WHOxUw7Ot9J9nFVgRdzlQvAF+ED2p4q+d3L9tFwUSFbz04JGii52zmrcyoYwBOejB0AApnusyOqebd308xG05SqUNN0mxPCjtW3+7LyL0ydVLaKiuuVXPVz/A0Lq9x/7JBaHFASai1BKv9fCq12kr6dvHHyPsM/c85mnIMb7qIC0U6NXPtKdt45uGSkN1krK4FnJMHyLfTkXYJ1scLY1BsOWqHokzDHoC818y/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdATHg0HYKLiNZz2aGMGFHgQZ6dnFttHZVh0bw0sn6c=;
 b=LMITwYwefWB4PE5jBSx8qGqrbCH1eIr5TdihDT25Ot1t8rwjux2K56ujL51bzaWHL/uQTp82equHo2Y+hra908mEBjIlGomM9GlI6BKKuPEH38vs5nGG/38lHSZs/kA/t5op/ZXkNnCFmhEbhuh4Juqcg5ryRVE52Gdq9uX2uKRACWhH/lz0XyrpDJD8lh30mt2KnFixxBDMxtl7CozefP+oNBjkEVg/r8eacXEAm4VNn5VCULuzDdREl59hfvFTChUP8dkwE2OR+Sb/7m6TFTSc8HooOdCqp16b6M0iSj1EPo6ZNZuSScyuPeDMyPujLcZF87VedgN1ErmnoMRCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdATHg0HYKLiNZz2aGMGFHgQZ6dnFttHZVh0bw0sn6c=;
 b=qkJSIL/6yQL3voNOrcZMq1C9vx9Xcm2QJ0meSmYuKYYQj5mKtVsX4es7aApJ3Cmo3pLHA6kS1Z6ajmFzsCjTSzp6HB9ZpODtuAxe+UqQDu6Ba2nKHwYUisiuZQvu6HX9eyZu6yhBAU4A+DKsmSK1XrTdsFOMlf72TXVguKp6nB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 14:31:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:31:58 +0000
Message-ID: <e41fd460-6b50-4792-9328-3eda370672e4@amd.com>
Date: Tue, 11 Jun 2024 09:31:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
To: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>
Cc: gautham.shenoy@amd.com, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, Alexander.Deucher@amd.com,
 Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718095377.git.perry.yuan@amd.com>
 <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>
 <20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:8:56::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 0583cad3-5881-4dde-8a78-08dc8a233fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpIQ3RIVEw3N3JETTdQUFdlT1UrdDZuNmY0a0s4cFdWSy9NWGd5akJ6T2VS?=
 =?utf-8?B?Z1o0MkV5OHlNNlEyWkpMNWRad3V2ZmxheC9IMkkxbmYwb2VsbVpoRDJJczJT?=
 =?utf-8?B?ckhzVEo4K2xrRk9EeWU1dy9jcjMzUTJaUHZOaFFSSDJZNjhoQ2xpVVF6Q1lq?=
 =?utf-8?B?SG40UTBGQmVDd1JuU0hSS0llMGh1T3VndHJDMDZBN1RNZ25PQ0prMzlmYnNR?=
 =?utf-8?B?R09vc0xXSnNIcFNFMWQyYzBmRHBMTjBXMCttLzBrSVBVRklmaGphNk8rbFdH?=
 =?utf-8?B?bzQrT0lUdGN0TEVNbUxjZkZjckxoVUhJblNxMXpHOTJteENhMnBmaUc0MHBq?=
 =?utf-8?B?VVRVOU5seXZMdVpGL3Z4c01LalpYS1F4WUdQbWdyT2NtNXlIOTl4VjN4Mncz?=
 =?utf-8?B?VG1MQzF3M3pBSGo1bCtIbFk0dDdoM2tHM1RlekFKaitFS3FYSnJpSHI3QzdL?=
 =?utf-8?B?R2dMSFZvbERBK09mMUJiaWwva055MzZ4NlR3UmZJVUZaWXEvZnRtYUlmUEFI?=
 =?utf-8?B?ZElQNHhLNm1uTnEreXNtZXU3U1ZKcitMTkF0OHFRUHpZYXRSUzJEQ0ZjR2VG?=
 =?utf-8?B?VUhRNnNFTnlNOXp5dmtHQWgvZG12dVhIMklxSkhad2dqTVRTaGR6d1duQ2lj?=
 =?utf-8?B?c05FUnR4bnFiU244QTI2MCtoYk9lYjd4bkJweC8yS0JsTlhMTE9saTd5b3My?=
 =?utf-8?B?NFVib2VqbEZhWlNlVHRlSHRxWGdZM0dQelFCcm05WlA2OUQ3QkI5Zml6SzV0?=
 =?utf-8?B?S1lvVTZIMWt6UE5qSlR3K1VwUExYMGhlUDVmSnJuMmxXd0ZiakxQTVN0QUIx?=
 =?utf-8?B?RVVSU0t6UStNNFNuaFB6eG9ESDA0aEhtbEliRGhibXpxanp5VjNPYXVQOTht?=
 =?utf-8?B?OEt1WjBVcG84OTU0RFN0NTBtbzJmd0RMQmNQQXExSlRkSkN5eVU3eWNzdXQv?=
 =?utf-8?B?K3UzOFlMc2c5N29oVEZJR3VZeXF4NXhQMFd4M0lXb3ZDZXFhZWVVQUNHSDJS?=
 =?utf-8?B?UnlWbUtrOEtRWGxjOTRreEJIZWg3eGJkYm1jcFJxZFlsS2JQSXB4R0tQa2tN?=
 =?utf-8?B?OWpWZ3NDaHRjMWNrN1VCSDNONTFtdGVDcWdrcDNrVU4vZWVMQjBtSmptSnZH?=
 =?utf-8?B?MlhqQ25ZaEpQeFBBeXFBWno2dVpkbnVQa2dVSGdwS1RYV0d0QnpMZ2ZRWjhR?=
 =?utf-8?B?MVF2Ti9lYlVOTXY0a2IzdWd2d3IzV2I5T2YyRFFvZFpZTjlEZjdwZGY2VHJZ?=
 =?utf-8?B?aVplZE5yOFVhR3hnM21QUVB4NjlZdWxKdmQvZWkwQklZM21YZnpMbTRLeE16?=
 =?utf-8?B?aGcrOGVBMlVQM3Q0d0pJcVFiekxDSmlUUFRmYjlyakhUL2JGTnlJNDQvUEdw?=
 =?utf-8?B?bUhvSHJPMGNiUHpKSjZ6YTZieU1rMTRzL1l1RmhGWTQweUlORmoxa1ZUeC84?=
 =?utf-8?B?TVNuY3ZkZGFRSG9hQnljK3h5WDRZbnNBc21XVlg2Ti9HWG85aW93K2l5eGpx?=
 =?utf-8?B?QUFSTlVKWllCYW15cXNTc3IwMXVYSXRIZjJIdDFmK2p4ZmtvQ1Fod0hXUkUy?=
 =?utf-8?B?ZGJUNTQraUdNUkVkR0JzZFhJL251ZWh5VkY3TDBYR3N2L01ycHdYWVVHbmxn?=
 =?utf-8?B?VUFiWU1VNUkzNVpzZlZUT1cxdXBuVmEvK3pjdUNTSG1WcFEyR20rcjF5Z2Nx?=
 =?utf-8?B?T2RSVGxkek1wWG1TaTNEbXVpSHAvN29FSTVYUGdQUVpiRkhPeFo1TFBsZWNo?=
 =?utf-8?Q?eC2sqBERr/9GImUQjLQvJvDSj6YgSeTydDVY34u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjhUZ0lFRXdsQTR6MHV6R29keFo0SDRJUVBha0h0NFlneGNKRFpYejB3RVJj?=
 =?utf-8?B?VzRMdzRWVi9ITUZ1SGF0bFFxZ3FYMmIrK1JqdUI0cVRxNWJiUDREdVV3SWUv?=
 =?utf-8?B?cGlWcVdIRHB5cjMyRXQrMFFwNGxBZGZIZDZKVmtnOVhSbzdDUkVFcFdpMzhZ?=
 =?utf-8?B?VGtFZVFJYnc4cVUrUEp6RTNBa00wZ0pQVHFob2V1MFRUNXpoRWlVU0g0cVFh?=
 =?utf-8?B?MDJkSjdjcHJoS0ErZS9rZ2lrWEZvZHRZUC82aGExNUZOU3ZUZWFJL0R4VU9H?=
 =?utf-8?B?SkhYWWdpdVA2YktPM2YwQ2lxbDgrbmJhQnpvbTFQOVZVRldEUHRzekRkQ05O?=
 =?utf-8?B?RFMveThtRWV1clBQNGhPeFRtV0crWVM1SldBRlBneFhEcHNFb01ieHdDSkJT?=
 =?utf-8?B?aGc0RG9RM0R6aG9wS2JCd2R4UFVsVVcydlA4S1BtNWp1QVVKckt4cE1yWVB1?=
 =?utf-8?B?R3NmcnZUd0wyVTQ3Rk84VDhScFVPdXFOVGZDUStrRlNHeHhLY3NSbWxpQ012?=
 =?utf-8?B?aU1mN1JxaGk0SUcvSTZVeWNidlZKZW1hVGJwNFB6S2V5NmY5NDk2MW0rRDhj?=
 =?utf-8?B?OEJ3Y1ptQXpkdlMwSXZCTUJSK0liZFhKRi9rMlJQdGpIdFlwb1orTlV4RmpB?=
 =?utf-8?B?Y1RUTy9OM3doRDgyMFpiL3kxY1RTaXJLQ3FBTFo2UDFUYTNzbDJZWG1TZlg0?=
 =?utf-8?B?K0FDcW9lWkFIWG9FU0FqWTlvRUwyakltbHlmaVBXWW5saEUzY1dFY3VKU1lZ?=
 =?utf-8?B?b3IrV0d4SnoyY05RanE4ZG84eXBYbXowanUwUWwwMmNuczNBbElIVGNuVU5B?=
 =?utf-8?B?V2lKZDV4VXl2V3lSQkI4WVcwVm0xc25IOHpaWHBRb05TdWZpcWNoVGVJeUhm?=
 =?utf-8?B?QlhReW5kaFpoNEl4OXg5N2JBK0FKS2VrKzBYcGdxWVNEaHNhWnR0Vk42bU5Y?=
 =?utf-8?B?M1RFUWtIQTE1dUtKKzVJY0ZmUUF3aG1xSUF4NGRaRERrUW0xcjNBR043YlNm?=
 =?utf-8?B?QUJwRzNIUlBQd211SzFKWFpaTlFwZS9CVlJCMnRIZ1BmbGM4R2RJZE9tcnBx?=
 =?utf-8?B?dlREcXc2THkzaEVoYk9oYm5pcUxNbmI5cFpDekZKYmt4S3FyeE5sbWtTRHNS?=
 =?utf-8?B?SkZZeVRwUkJNRnd2NzBXMmlpdGZqanMrd1BRRVB1bndtdDRpRGlNd3BzRXp3?=
 =?utf-8?B?ZVBuSnVzYUE5a0QzWWlnOGZSNUxyNTFTN3JzejdLam5QbXRpN2xEYUl5K0N4?=
 =?utf-8?B?dmVaaG0rNEsyVTl4T2FPQ0xjRzFWSmR4NVpYOFpCUDJDT0dNT3VmU1BpSFNv?=
 =?utf-8?B?Y2Y2SUI2SmZnWEFVeFVpc2lZakRkNjRYWFdFc3Z4ZlRtMFJDRHlpYyt4Vnhx?=
 =?utf-8?B?N2xlbFdGci9kSGk5NG5jWm5DU3FlRzhnK0RqbkNRRU0rTVB6d2JRY2hDcmQ4?=
 =?utf-8?B?dEFCL2orcmE1RGlkZHBJZE1FVVV3RFZGSk1mcjkzQ0ZJNUxEV2x5RnN1V0JS?=
 =?utf-8?B?K01rbVpQK2lPalZINEc3VVJhd2tMeWdlc1MwQ05ZWllNdlJsZ3BLRjBHSEFm?=
 =?utf-8?B?TEhaN1ZHamsybm82TDhVdUFPODc1QU1TcFFlZjBuNG9XU1ljalZlaE13bWI5?=
 =?utf-8?B?UG5iTzh1bU8zOTRBRU1pQTA3RVUzODcvWmpKWWM3YzAwTnpxeklydVB3S0pz?=
 =?utf-8?B?bUVPcEIwbEs3NlEzc0hHTk1jU0JHVGdnN3lEN0xMYlN3dUtOaW5oNGRzNHlu?=
 =?utf-8?B?c3dzQ2dSUzVvbDY0WWk4Q1Y2cytMVDhycVhZcmMvaDFpY095ZDV5R1hibXdz?=
 =?utf-8?B?VldZNmxHSDd3TC9INE5YVXJvNjVZY0lHdmhuK2FBUVQ3LzNLcXJWaFVsdUtH?=
 =?utf-8?B?bGIwOEQzNldvcUwvNVlkVEJoNnFHbzZpOVFZa0hhSVBCSGNsNERZc3k3aGhR?=
 =?utf-8?B?dWdraUd4N0pQWWtLY25hdVBiVit2cFRHR3FoRktqdm1pdHd1WlMwYVRkdFlV?=
 =?utf-8?B?eE56R3NONFJsQmNQYnVuaVMxRWwxdG16c3ZBTFFZTUY1bHlOT09MWloxOW9F?=
 =?utf-8?B?RXRRSVhnc2tubm5kZWhSMnZYYkZXSlVNdmpOeUVLUDdPSjdDTDJOZXd3ckFp?=
 =?utf-8?Q?Ko1WKGTN4h/N9PVPokgd0/03I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0583cad3-5881-4dde-8a78-08dc8a233fbf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:31:57.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loW2nlca4860bHlmSegDVqq4gNt5UlaFYtWnO3jWPqYz33wnKG6JquH+NxhDFTcsGRGuwRBn9SCeisd9B7Py0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

On 6/11/2024 05:52, Borislav Petkov wrote:
> On Tue, Jun 11, 2024 at 04:52:24PM +0800, Perry Yuan wrote:
>> Subject: Re: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD heterogeneous processor
> 
> "... Add a heterogeneous core topology feature bit"
> 
> not "feature bits"
> 
>> CPUID leaf 0x80000026 advertises core types with different efficiency rankings
>>
>> Bit 30 indicates the heterogeneous core topology feature, if the bit
>> set, it means not all instances at the current hierarchical level have
>> the same core topology.
>>
>> For better utilization of feature words and help to identify core type,
>> X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.
> 
> This sentence is not needed.
> 
>> PDF p274
>>
>> Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
> 
> This link will become obsolete, you can say instead
> 
> Search the web for "architecture programmer's manual volume 2 system
> programming docID #25493" in order to find the official document.
> 

Another option is to upload it a non ephemeral location like a kernel 
Bugzilla and link to that.  I do recall there is a bug already opened 
for this purpose in the past.

