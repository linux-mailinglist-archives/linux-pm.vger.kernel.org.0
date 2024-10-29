Return-Path: <linux-pm+bounces-16684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404D9B555A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667251C21266
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEE19258A;
	Tue, 29 Oct 2024 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AkzGxRVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BBE1422AB;
	Tue, 29 Oct 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238886; cv=fail; b=XCBn9m+cwYGhOFCjB26s3jJbaQmedUgk2Raahcu1f6kYHR2X/10vFKWk80Sh5e18d/9BIlzBt4ZVlxvpt7Lbn3MofXnjE4mt/ujjxl7lWEA6Rc/t9czVUNGqwyxDP0K9wKukJ1esLNM+hOemhCxucnPtGAl8tz6l0uV+aZsdAUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238886; c=relaxed/simple;
	bh=10ummxDvsO8vNiq2cni/Trlh2HoEbIkaZrq6/1U6+B0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7eYLxZh/UC3bOyVGt9XOu1zfAjui4shga6jgFF2IGLufeIjuBPGPZX2oUGMVOw24IP19NuFZ/Ns/dCcEvKlUtRq4ttVlYYBIsPkeZyb5duZXxwt8FbaoQeVllg5g95n7wxxRScKFqYYcyHqn7kcEDAAg1YSMAvf8lYSYhS3ZAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AkzGxRVm; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f844fWvy6/543Lp18rbLfT/NsomJsDuoxWja2lTXMDj6+nxTV15RoiGZsJy0KjIeVA36TDDwM4mA00uwKz7S97jSMSVwYZdkxQQ8CtOGLKWjZB/dO4UnBUFqvDTUxlpr/syiCaaxlyWGcbVs1AUD3/Xao1wxj2RDok5ksGmCWF0/pRUmMY+044Scwbm+A+XXWRmoyeavWo+QPHSlniI7eKMGFPXGFL7DZBjmxQPxV6SHnS5UBVPL9hdqBS35tsp2u5MzcMhCqYfgd6Ods9zB/STEac6za03T/c2n8AbIU4yjriQW5Dz+NdfJU8GfQVzIVAAmAIKZSwfgiVrwAggnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5UcSQlcgbyaRwz2tYfYSxhlVVfd33eFyj7XYABZbts=;
 b=ontOnqaFeA6tX+S2NqeaY29E77xijc38fLk1p0GNi2C/Lqv2dSAkW4ES2IJBx4NBpKa1UUx9clAUKTikT2On8CFaEQfVP0eCh+qVFvUCjf4T+QolIWbEg3uM6Xp4i1/uwF+khCC0QF/ODmLMjs7FhMu8GrUeRl62R2S/cBr6ozPRGi/dn2rlRwI00k5Hp4CHj0qN2/v5d+rAxJxMY6q7EaQUxRD9cgOYt3MLuMSQuNwnhlao5JWLmumBov07vjJ6RC/Mk/O4/G3vYHezzuNaCQfCUdH52Xf0oN+2GfUI9ddwV3mE5G/zAhZB69xMHfIOVXuYPBlm7zp6FjJwR+LTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5UcSQlcgbyaRwz2tYfYSxhlVVfd33eFyj7XYABZbts=;
 b=AkzGxRVmldEtsdGOdhVCy1ECJuqzjgs9qd/Fj54K/3awrHx5oxqi4SSQy1d1wClGlEFJaolmBiELGkt25nncfaVLEf8N2RLHTbxax8h0CSmC5ecT361EFTDQTio1JoCGCHnO+spyxXq51xprhjKRxyc8QdJ9whPalfu1x07PYTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 21:54:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 21:54:41 +0000
Message-ID: <2cce09cd-d50e-4ab7-96fb-833f98ddcf5f@amd.com>
Date: Tue, 29 Oct 2024 16:54:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y v2] cpufreq: amd-pstate: Enable CPU boost in passive
 and guided modes
To: "Nabil S. Alramli" <dev@nalramli.com>, stable@vger.kernel.org
Cc: nalramli@fastly.com, jdamato@fastly.com, khubert@fastly.com,
 Perry.Yuan@amd.com, li.meng@amd.com, ray.huang@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
 <20241029213643.2966723-1-dev@nalramli.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241029213643.2966723-1-dev@nalramli.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 0940497f-01d0-4979-55be-08dcf8644a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWRXcTZBM2lKL2l4TzB3QkIrdmo4SWRpTFc2b1dOZVA1VEw3UmZMc0RmTTQ0?=
 =?utf-8?B?QnM2R1AzektuTnc1d0hyclJhYVlsUE5FTUtPQ3ZFYysrYVliZ3A3OU14QTI2?=
 =?utf-8?B?czQ0ejhIYXpyWW54NEE2UEFCR2dqREdsSGVWekNSRzRaQVYzWnBnWnJVOGhp?=
 =?utf-8?B?bTV2TGhISTRXWnd5UmJ4c1BIVGxFWTZjaGZsOUErUElESkFxVUlWdDdFNTR4?=
 =?utf-8?B?R3NFZDY0d2QvR3RlNnNzWmlzMjkvb3hma1ROVzRwLzFpSWsyMFlMTmI1RU5x?=
 =?utf-8?B?MUlxdDVkak9MSWZoWjZKNEdGVzlTZ0YvWHJrTHNHSTArSlUvaGdUSDJHS2xH?=
 =?utf-8?B?ZXFaQmVOQjBUbWhFSnkzbEpvYkMrNEl4TzkzUjBDSms0QnZZT3ZvcHJnN3Ev?=
 =?utf-8?B?RTc4TVlTN3QwVlZRL3F0VEZBUy85cTJ2ZUVPRis0amhHcUptTGxycnpaWnZE?=
 =?utf-8?B?NEtJeklhOFFZZmVnVFFUWGpTUGNXa2w4eDlCSENnL0JDMC9GTVlVenloT2Fw?=
 =?utf-8?B?SEc3WTl5ai91K1Rsek5QZ0s4NzVOR1B0VVZmUHovcktKNVN1K0J3TUQ2SW1t?=
 =?utf-8?B?TE5xUENHSGwrc050NVZNN04vUklZMU9McTVxYnF4U2ZQRjJCd2pORmhLaGcw?=
 =?utf-8?B?NkhyUDZxU0x6clRJdUlHZmhEaUFheXFYYVF6TFh0R1J1ZlMraTNKVmVkSW5Q?=
 =?utf-8?B?UFpVb0lnR29vRU9MTTJ5aUUxbmxWc2ZoNEpwcURJVEhpWHVQeXZoU1pFck9i?=
 =?utf-8?B?cnRLK3p6REorT3ZjQjlaUXVXemhIWmFtSDdoR1lRWTdSRFNyV3k2ZkpuL3h1?=
 =?utf-8?B?V29tTHUwMm0zYUNWdDZ4RjZLd3BXSWZvVmdOQkNxdytweFdjUzZvbCsrM2hu?=
 =?utf-8?B?WXdqL1J5c0lLNW4wK0dJRGJXV3pYVFJqRWtzSVpubGoxSDNVOFlqUGdmTXh4?=
 =?utf-8?B?Q0pBdCsyeVdFNmh2aVc2WHpMM0RwbWpwalNZc3lwQTVoRUZZM3phcVJuMXMw?=
 =?utf-8?B?U2duelVuTUZ4akhhNDhzYlRURUZsZWllMTBBWTJFZHEyR25HWFI1aCtzUk1r?=
 =?utf-8?B?SjIwbnlCYXpXUGx3M0dlaHUzQm9EWU1YM2Z3Ykl6VGh4djUrWnpNNVYvVkpJ?=
 =?utf-8?B?dUVLTjJHdVNMa2lTNmVHUGI2aVQ2TUxKbkFUQXZCZjMybGNUVFRBUDhudThV?=
 =?utf-8?B?NmdPTEtvYjRFZXVxMHlnUVRJd05Qbm1zaDl6U05SdW1iQ0pLMk1BTGczWVll?=
 =?utf-8?B?V0FBTzJPQ1piZjhDY2VPWk5KQUpKMHk3NVJSYUcySGJuaGhGaE9aQ3NHNnN3?=
 =?utf-8?B?emdIUnk5MFR2eE9Ka3ljSFV4K2tRK0pqYzJWSGhSZjJCRDArYWh4Q1oyVk5z?=
 =?utf-8?B?N0RIc3FHMnp6OGNXQ3hHeGludkU3TGdmZlRXMGN6UktWSHMyeW80cVRwMUJN?=
 =?utf-8?B?UzRKK0p3Z0hlTlJRLzNuR3EyUElaT3oyUlh6NXVPVmNvTFZuK3J5TXlhRHNZ?=
 =?utf-8?B?MTIyRDJhbm5PZmZIeEdsMWlreVcwc05HVXdRWEs4djNGUUl1dHBBZDFvNVRC?=
 =?utf-8?B?R210aUNrWjJjMlVuKzBJSG1JVmR4eDRwdDhWdEFzNkFUZ25IWFVQbW96OFA1?=
 =?utf-8?B?VlVFZy9mMDJ3YWlvR1ZKOFFVVWQ1MlpjMDdKczJ2M0dyc1hoRlovRjA0Z2s3?=
 =?utf-8?B?V1lHMEVJUCtXQlZrSEF2Si9qZUdJaEVJYUF5WTQ0WElOVm1WaDVDVE56U3pV?=
 =?utf-8?Q?lIXPwR02d6hRaiazmBfR4BwBWHyEdP8ZSavtbDX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDB6TitpV05wZzVORkdaR3BSa2RVcTl2SGZYaGZMdlZYdm91RkhGWTJnUzd4?=
 =?utf-8?B?R1NlcEFjZmlZSk9XNnY0VDRaV1RvVlZDNEJTZWc2cTVkUUp0R0Nselh2NW5u?=
 =?utf-8?B?a1dNSVJxRUJaUGdyTHhSbmFvTWdESm5nbUhubWRwbmVyRnh0a2M0TDJyZmMv?=
 =?utf-8?B?bi8xUUk2Yk5JY21yVmlYOGc2c0oyNnFjZUtoWU1nWEJ0NG9Ca2NqOU9JN1dl?=
 =?utf-8?B?SmJvUnd5YVY1WWdNRkpTOGdmczZSTWNKTjIrcEY1Y2Y1TEhzQ21wcGhQTUhQ?=
 =?utf-8?B?cTlWTDhoZUo0cGVWdGlYSmZwaWY2aFNRczZrZlBRNWdSaHMwcmNzcGxwa2lj?=
 =?utf-8?B?M2RxV1ErTHVqam0rK1NOVyt5VGZ0WVRsbS9UVFpCSktyUm1VdE4yd3V1M3ZU?=
 =?utf-8?B?am5xUVJveXYyV3JMNzBtOENmRDVMUHUwMnpXWDBEdDNLVUlEYm9wOE9iUDd5?=
 =?utf-8?B?MlhMc2pudFZiUHZGaW9lcmdubkRUWXhuZDRKVEtVN0NNSmdWTFFhWXd1MjJJ?=
 =?utf-8?B?RW1qV1c4clQzZmFKNmcwTW90S1BHU0x1THFKUEdxU1pUT2M0Y0M2N2o4ZXBK?=
 =?utf-8?B?MTR3OFFtUkNyUFFXYzVrdW9IWHNRZFRyTDhoWEtyTEVWUTRacE1KUWlQandE?=
 =?utf-8?B?UC9lUS9XQUlYQThFMnFQQ1FiQzd0Y0FUYmVTTVR1TmlPbUFFWFppWkFwZXRz?=
 =?utf-8?B?Z2dJZEIzRFNKTUlTb1ErcmNHV21NUVBGU2srNHA4dXV5SGdoQjNlR3Q2Q2x0?=
 =?utf-8?B?aFJ1RlZmUEFwVjFJSVJoaUxrT2d5cVJWeEEzL3F6WVpLa2NER3kxRnJkMjJD?=
 =?utf-8?B?b0ZCRTR3S3NBdnNOdVQwVzV0LzdKM2RrSlZpTXN1UEdRckVPVExyOFVuL3JO?=
 =?utf-8?B?b3NsY1MwakhsM3c2L3ZKRzZYYlBlcnVzckxLUTdPU2oxb1pBeVdFalV3V0ta?=
 =?utf-8?B?T3hzckNhaUZ3WXB3TGNoaEZDYmJ1dHBSc0tVZU83R0pQY3Y3Q2diZko3QWxN?=
 =?utf-8?B?UzBEbzZXSjV2R0xiaHZQKzdXWTRUQ0ZUdnVSL2JDN1cwYzlaalNxeFB1Nk14?=
 =?utf-8?B?bTRjaGRsRVZzdlpXNEplZ21PZWhQaE4rdE9HTi9vNG8xVGRrVXBVeDRvb1Zs?=
 =?utf-8?B?bWQ2SVdvRWZqcklEMXlKc2Q3aE9lN3NxSTVDQUlxU3BoWEN3MERzQ2RmMFoz?=
 =?utf-8?B?WlpTMVQ4SlJjYVNDRnZyMjhZN0g4MnMxKzIydkI4ZnRlYllPbktkL0JzZTlt?=
 =?utf-8?B?ZlB0SmxUcHZJd0lYRU1HYmZleFoxejU5cm90TXZJR2JHdEFFOWNNQ3UyWlBO?=
 =?utf-8?B?U2lWQzI2VTR2T2t6ck4yaGZOa0hSYU5PT2kwck9GdWtTRzFyNFJFNTJoNFRE?=
 =?utf-8?B?bXRoSGxwUXR1dEhNWXBmLzZQK2FnR3Bzem9YNi9mNEp3SzBJK2N1Mktiblp6?=
 =?utf-8?B?SDI3L0o1U2lLSUU4STlNN0d5T2tGVDAxTmlXY3hmZ0RqbWNrdjhhRVoxdkRB?=
 =?utf-8?B?dDdycFFIbDF2Vy9PeEdUNllSaUx6ay90YVFxR0dHOWt6YnVXb01kdHlmZmFP?=
 =?utf-8?B?amZzQzhObkhhY3JLUWd6Ni9nNm9SNVNXRUdyZ1l6SnJpN1p2elhqQlRwSVcv?=
 =?utf-8?B?bEdmNk1xV2tseklYQzE2T2thZ1pmdSt6bUV5WkJ5NGhCZjcxTURzblczdnNr?=
 =?utf-8?B?c0E5emNiT1NDVG5ON24wVDdGeldSYUtIeitZd0plM1JyNXJETWJLeDJPODha?=
 =?utf-8?B?YWJCUlliMkI5UVV2NWYvU2dXTDY0YUVsWHp3YUUraEJ5VFBTclJES3FOWDdW?=
 =?utf-8?B?K0hsdk9RTGJ4NlQ0K2dxSCsvdUhHd25NSlFqNGVhQ1FLRkp0YnMvN0RWY2dV?=
 =?utf-8?B?dlhMYml1SzJ5dHZDSTJxZUpCOWE3LzVZeXdaOXBSRDhRM2FJUk9KQUU4SGVF?=
 =?utf-8?B?YllmeDErRXFQWnFCT0pFUCtxUVdnWkZrOXFHeWUxMmZDYkk5YzZ2V2UwblVJ?=
 =?utf-8?B?QWxGUHVKaEF1SEJQR1hwTGI0ZEgrTEFkZ3U0YjdJR0l0eTg5TjVnTlhHVnQ1?=
 =?utf-8?B?Q0g2MVJmSWpnUjUwN0RQNzMzYkNVd2t5ZkFkMUt2K3gvaUNwRklkY2Uvbitu?=
 =?utf-8?Q?VfBXazpcbW6YPlc6tGAcjR07q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0940497f-01d0-4979-55be-08dcf8644a60
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 21:54:41.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe6HFCjM4b25kDNGV1jXmaJSFqvHbfbTNm6mVqIBPIQLprDHxDnot0ogYVPKlByYdNKT+SDCNuCWVeA6VPmHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

On 10/29/2024 16:36, Nabil S. Alramli wrote:
> CPU frequency cannot be boosted when using the amd_pstate driver in
> passive or guided mode.
> 
> On a host that has an AMD EPYC 7662 processor, while running with
> amd-pstate configured for passive mode on full CPU load, the processor
> only reaches 2.0 GHz. On later kernels the CPU can reach 3.3GHz.
> 
> The CPU frequency is dependent on a setting called highest_perf which is
> the multiplier used to compute it. The highest_perf value comes from
> cppc_init_perf when the driver is built-in and from pstate_init_perf when
> it is a loaded module. Both of these calls have the following condition:
> 
> 	highest_perf = amd_get_highest_perf();
> 	if (highest_perf > __cppc_highest_perf_)
> 		highest_perf = __cppc_highest_perf;
> 
> Where again __cppc_highest_perf is either the return from
> cppc_get_perf_caps in the built-in case or AMD_CPPC_HIGHEST_PERF in the
> module case. Both of these functions actually return the nominal value,
> whereas the call to amd_get_highest_perf returns the correct boost value,
> so the condition tests true and highest_perf always ends up being the
> nominal value, therefore never having the ability to boost CPU frequency.
> 
> Since amd_get_highest_perf already returns the boost value, we have
> eliminated this check.
> 
> The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
> amd-pstate: Fix initial highest_perf value"), and exists in stable v6.1
> kernels. This has been fixed in v6.6.y and newer but due to refactoring that
> change isn't feasible to bring back to v6.1.y. Thus, v6.1 kernels are
> affected by this significant performance issue, and cannot be easily
> remediated.
> 
> Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Kyle Hubert <khubert@fastly.com>
> Fixes: bedadcfb011f ("cpufreq: amd-pstate: Fix initial highest_perf value")
> See-also: 1ec40a175a48 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> Cc: mario.limonciello@amd.com
> Cc: Perry.Yuan@amd.com
> Cc: li.meng@amd.com
> Cc: stable@vger.kernel.org # v6.1
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   v2:
>     - Omit cover letter
>     - Converted from RFC to PATCH
>     - Expand commit message based on feedback from Mario Limonciello
>     - Added Reviewed-by tags
>     - No functional/code changes
> 
>   rfc:
>   https://lore.kernel.org/lkml/20241025010527.491605-1-dev@nalramli.com/
> ---
>   drivers/cpufreq/amd-pstate.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 90dcf26f0973..c66086ae624a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -102,9 +102,7 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>   	 *
>   	 * CPPC entry doesn't indicate the highest performance in some ASICs.
>   	 */
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> -		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
> +	highest_perf = max(amd_get_highest_perf(), AMD_CPPC_HIGHEST_PERF(cap1));
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>   
> @@ -124,9 +122,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>   	if (ret)
>   		return ret;
>   
> -	highest_perf = amd_get_highest_perf();
> -	if (highest_perf > cppc_perf.highest_perf)
> -		highest_perf = cppc_perf.highest_perf;
> +	highest_perf = max(amd_get_highest_perf(), cppc_perf.highest_perf);
>   
>   	WRITE_ONCE(cpudata->highest_perf, highest_perf);
>   


