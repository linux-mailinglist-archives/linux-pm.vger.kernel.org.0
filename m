Return-Path: <linux-pm+bounces-15441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DD9982E4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFC91F20D38
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499C1BD003;
	Thu, 10 Oct 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nnc3htwB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53165191F62;
	Thu, 10 Oct 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554104; cv=fail; b=bEhY0I9u4BsVi4Vj2Q/ckuZ1GZfDLCG1gnk6kIZeoc4SQJ/4I75XQMizJaAdv65RTDEwWiszU2iYqTau7xPAe4nbSPVD20vcD4iZFNriu4PliwxH48ZMhxjIIKreyh/4fRwMJHKohZcEtXkxQ3xAmEFQapLwBf4zwoaP9PpbMrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554104; c=relaxed/simple;
	bh=2MyzO791Gjt3/SZZXoyYEox66a+JOEPgSN0D4uQ7eno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IR4P4AX63nxtOSwpNBk39UQefimC0A5Dg+anxomoLh+jf91FXfPygDCh5K/m/hukMXn6WZFrjUVJM5wAo/pX9hPdQdzg+7ENHNNGxZTbDKLlF6t5Z9YiaRASZYwQsNfRqvAYMt0kFwg6XXFqVV5bcmLQGHVrPl8W63hHvqoVOzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nnc3htwB; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUi1CA4CkhLkhlPfJAyyp5iY5y7NhARmsYuJRV+tC8G6DRfJEP0nb03NPXi0ZXDvT/9NmVtI7LHh2DdEQ1U2XUW/mt1okH1HKRCCduyApL4iTOIyLpBH1SU74DHjLsf7Gw24rlCYmAElgU2o/qe7A8r8T+Qk4Lf7axJ731lg4AjPSLWT2qVAWJTQCLOebwA1GiFSx6osXtlgkw7zuJNmBecWzo3SspG/cJom8UDSbegjYKh4Z2PbBg3siofUGnq4x8FbbEIpLRKo/fX6dyNHGac+pAJokVwFA/Yj67XE+haIQfg62OD0rtqOM+dFLNB+YR6GjKkR0e/5lKJ2eEF9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3m28VE9PVTANHwSCUKulhdOYmZUDdA6UN3CQrVg9v4=;
 b=tw5hDqJbKG50ACo2/3Um3nuhIIdbiyjjjkOweWQYd/g2IS/JNZcdLxjuGhSjXO/ytOdykwJb2/xv1dZHCCiNVM4zE5VjtuCT6o0QLnLnrnqVLofCow4QGeq9b181WXEPt9Ka5mGkPRHGt6+2w+eXTBm38HHxOn0AMK98PFixednFmW6yQFhAQucCenH/QUqmD8RNCC+69l7bW2PI+riyZ6OYmOl8efn+p39wTXHhHzHHvcpj/AftsQ61tnSbA71/5oGv9c6KMljXUn3q6E7Pr7zv++e0hIemJiAU1JzEXrRk5dPFFgFcLvXg666Y/sfaJR+aiFVvfcOlcZwBXplXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3m28VE9PVTANHwSCUKulhdOYmZUDdA6UN3CQrVg9v4=;
 b=nnc3htwBMtrIvkj0tCQFX13dwyp3ua16YoX72gFG1QcVdNt0fUgpmDJpnN+EPD3yHFBHMJ35t1IGvcm3EPYSwwMYC6Rvwivsz6lYegGXsg1HrHDUtr5qET80K03S3vQ3mszjWYwS+cQBOJHReRVYF5XR7EDs74FV4Q95A6hZz7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 09:55:00 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 09:55:00 +0000
Message-ID: <1a38d478-6e34-4041-9169-ba34996d573c@amd.com>
Date: Thu, 10 Oct 2024 15:24:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
 <20241010073541.nxsftik6g3tche7n@vireshk-i7>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241010073541.nxsftik6g3tche7n@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e60b4a-b536-448f-efc4-08dce9119ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUlZbUJ5U29UVTFVYkZveHcrd1N3ZW1HcXhGOGlkdDV0UFBPSXJ6aXY4anVl?=
 =?utf-8?B?RFRZUGJFUGpLdVQ0akdsclVqMlZuTlRWSWtidUFOdGd1QndZcWl1TEtseVF2?=
 =?utf-8?B?NHB4VkY0TEdqNHlBbTVUcGE1VnRTWG9iVFFJQm9hc3B3dHJzQmZOM3gxcEwy?=
 =?utf-8?B?R1o0N3FNNWZpelMvUHFwWnVYR3JrZTlyZGYvWXlGNkZmQVlVNTRRdStObmI1?=
 =?utf-8?B?SE9RZ3RvNlk3NmlxcWJsWW9uRDhIVEpwc29COW5hTEcrYU4wdE14K1V2U09O?=
 =?utf-8?B?blVweGlVQWpuYVA1RWthVjkzWmZ3cnZzOVUxMzMxNVc4NFh5Qy9ialYrdXFE?=
 =?utf-8?B?aDVUczNIV0ZpS2ZhZFkrODVsaFJ5U2YxbGpYZERYRzhDNm5QT04rZnBEMG9j?=
 =?utf-8?B?LzY0RUFxYVFhT3NqZzJ5NWl2SHp5MnFrdGhrZW9kbFRJOHJEdzUvaGdtelF0?=
 =?utf-8?B?a1NDWnRiY2N3SjhQQTVFUFdNczFkNEtvNFU5U3lkeVlzSmh2Mjl4Z0xlSk1I?=
 =?utf-8?B?T0dGZFRUYzQrK3BteXZndVJoQkcvK0JVY0VvNG1JSVhKTXowK29NUnBOT2ww?=
 =?utf-8?B?THVvakhOalRSVzdYTWVLeXNxUjBaV21YN1Q5blRzU2RwVWJXQTF1NTVKSGVN?=
 =?utf-8?B?Y1M3bGxRSXFWa2VMSzgyNjk5Y3EzL1NocEVUVHJTM0dNL2Q3MTExMjdsSllx?=
 =?utf-8?B?NzZLVS9ydFFHeFZLNS9Ka29YVjUxY2EwZ3NvS0d5OGFVK1J4d0ZwZ29XVS9O?=
 =?utf-8?B?dnkyMjVwUFpSU1ppQXdiWUhMaTJJZDdVQ0xjUjdHT1NRVE93M0tjMXp6aGNk?=
 =?utf-8?B?enA5KzhFeU1pRHUvSmptV1VHcFFobzZienZNRlozblBmeUxOcHpRakdiZHZw?=
 =?utf-8?B?RjlERlFZKy8yeFZxOE1LL0hiWUVZdk1DdWV5UDBJSTR0MzVCbzlhbHlFODZG?=
 =?utf-8?B?TGNSaUhqTjJFK1ZudzdkRTFuQi9CMTBoUHhFbUJZNWUwZVBZdGJrWkRIZXRu?=
 =?utf-8?B?WG9lOUJJMWo0WW1xN3M1cll5ZmJEbnVwaXRnQzRmL0RkeUdjTW5EdXNXN0pk?=
 =?utf-8?B?WnIzNzJRdGhNeG1GTlZBY1U2WGdJUE8wOVRaWHBFS3R0NzNaRHl0eTRUVlJC?=
 =?utf-8?B?dVM2QUZxVXpTTWtzQVdlYTBwaGtnSCtpd3JVNEVkNkhPUENZTW44azVBMy8x?=
 =?utf-8?B?a3ozV1c4aHp3ajJvekhjaXpubmFvYW1JQkpWYWZKZENPVktTRjBVVEw2WnBM?=
 =?utf-8?B?Wld5NDVXem1EMzJuc2NtL2FZcithdmViOTNpVGdUWWhqSU1XZ1ZDQ2V0RS84?=
 =?utf-8?B?TG14VHA0b2crVjhXa2VBQi9qSUs2QmxmeUdMeW9wZEQ5SFdrdlc4SnA1bXha?=
 =?utf-8?B?RXN4Qkcvd01WT3BRSHJsUmllUHArWW44YnFNcWEvTEdNVnNCTWN4cjBvOXJa?=
 =?utf-8?B?TDFqSjJqVXJsaTZ3cURpcW04SUtWZHFab2ptR3gxekZLK3JMWkNIQmJkL2th?=
 =?utf-8?B?WnpPa0pBb3MrS1RPSW44bVl6OVpqQW04b3pJemlwZE5nakIwMXQxcG9zZy9i?=
 =?utf-8?B?dVI4dXZreGhjQTlGWktYZjBoS1AvR0VMN0t1VTFnWFY2QnpMZU1QWE5MVElD?=
 =?utf-8?B?aWRVQm5PdEREN2tvbDhwVVVWSHNnQ3BrTXBtc3lFK2dyQUhObTl0TjR1QUQy?=
 =?utf-8?B?dXFvYlJNbW4vc1c2UkpDTWVTL3BVT01ibFE1a0o0MGJSQmllbVZGTEhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRlQjY3akFOOU9hbnYxY2JlVFo1Z01BRjB2akVuK0tRdElDQS9EWnN2SkZ1?=
 =?utf-8?B?MEFJZGlmdEVPUWU4U2duWU8wZnFUVGxKQnZQbEZ4aHFZcFpwRmQ2cElEbm8v?=
 =?utf-8?B?KzAwMXVQVXpCOXI5ZkR0U09NWmhzUUM4dmhtOFdzcXdZMFVzOHBjRXdmajVj?=
 =?utf-8?B?c0taQWxOZFJwNzJ3dWkxbUdoKzdnblVPeWttTFNZaFhrM1FKZ2Izd0FwU2ZG?=
 =?utf-8?B?YnNZOFRMbWhjSkhwdXZLSWZsazlSZWo1V3VXUXZQcXN5d3FCRyttcmoxb0Vs?=
 =?utf-8?B?bi9YWXpQY1hnOWFRMHJDQjVPTE1qZ0I4REM4NmxaQ1dDUm03VWw3Yy8xVHFi?=
 =?utf-8?B?bTg3bG9uRlJxQmNLVUp5NzBFVkRpb0diWWFuYnpmT0hrTmRwUHkxcmtzYjVo?=
 =?utf-8?B?ZGxjckMwTUtISzJTL0E1UC9CL3d1L2M3ekRwcFRCV0g3SVhjY0RQSHQ5ckhI?=
 =?utf-8?B?d1FFbGpRME11VlI5SFpoSVl3dHNZSmJpMFZ2UUlUa2F6OWZpQmE0Y24wU0NJ?=
 =?utf-8?B?ajZhaGZJbG1VeWVXaEhuRk40T2RETm1zUUd2T0VwSHVaQk5yNXV5d0d5MXBZ?=
 =?utf-8?B?Z2kzOFFBTDNhMzhIaTdyYWJPaC81bFhBZVprbEhmMWJEZ2ltWDY0UHY5UWVG?=
 =?utf-8?B?eGM3SWR0Q25Fd0pDM21BZVRKUGQxcXFPbmhGYUZrRVNsQU1BMlhjOGZzL3Vx?=
 =?utf-8?B?Y29SNEkzeEoxUTB4ckJ6bkxyMkJXSGNkMzNWTDM5SHBpRVY4RXVxbGtYd05S?=
 =?utf-8?B?UlJkbG01STFIZ1NKaExuT0kzRzc1WmtuTVp1OVVMaFJodmVDd2ZsYzRaR0li?=
 =?utf-8?B?UFJzVy9BMldWaytlQXNhdXVONWxIZVFPUkNNYW4zdUJPK3NnRnBzZ0MxdUFP?=
 =?utf-8?B?dzFGZlJlbWp4Z1JPdWx3M3J0NWVnSU1QV0dwVzNvaTJFeERhWDBxWDFmMDVL?=
 =?utf-8?B?U2R0cVd2Z3E0WXRXUDllUS9uUjhIS2ttZUhERk9BT2EydTZYdGF0dVRJRkZh?=
 =?utf-8?B?R05neE9ZUDQvSUVnN1p6L0VXTDlVc1pQTkxVUWNRcDFhM2Q3dlhDNHhQRTh2?=
 =?utf-8?B?TEsvWVVhRURYOHVBUGZvSlhmcmhFMlAyWFJpZHZUa0hkREhHd1g0cTJXays0?=
 =?utf-8?B?Vmw2US80M1JtbFlETG8wbmZyVGxGT3VQYVBxLzFSSGJUUFRaOHRWNlpGNDNy?=
 =?utf-8?B?MEVLZEtIMGZtSzNUdUViT1B2ZHZQcFpwYWQ5eXFQYmxZTHFjbE8ySk1NZ2xw?=
 =?utf-8?B?MU9DOGIvaWtabklVSjlLSHdFWklua2RSV1cvb2FDZmFQNHlMNXc1ei95RkhZ?=
 =?utf-8?B?NGtmL2J6OEFrRnNPcldXWE5xcERpNzdnaEsxTnorQi9HYUtwZEFjbi9GNjNC?=
 =?utf-8?B?NDJ5aDF0VmEvTW5OM2I2RHhOaXR5emQ0dFpGWWRGRUZwRHNQaHNTd2pmdWtx?=
 =?utf-8?B?M2wxUlNqMW1MOFhoM2tSNitpQ00xb1dCQ0VpZDg3eXY4anhBaG9TcGRKanpa?=
 =?utf-8?B?VCtXY01tYk5rTDBtcnpRVGlOTnlsN0FHbWI3d0tmY0NEd1RQSzVUdVNCR016?=
 =?utf-8?B?cXlKaWtsL3FXblk5K202Skh2OWZPZVp2dHBmY2RxNS9GaUsxRnhZYjFBNTg3?=
 =?utf-8?B?NXRmSit0ajNWazRLbnlEdkw2RkhKVU9XWDVSZ1lvZjBYU3ozVkZINEI4ai9z?=
 =?utf-8?B?RzNlWXhHNFhndTE2enBmQU14ZlpsVi9WQVpXUUlzeEpLazBndmY3bXlIRzRm?=
 =?utf-8?B?cG1YajJwRFo1TlVqNlRwMUt4ZDBnQUdIMCtxZWNYRndnaUFiL1JrbFFDM2dY?=
 =?utf-8?B?S0t1b1paNEU5MFpyL2dycHVuUERHdzZSeDlsbS9rK0pWalE1LzNzQUZnYjhm?=
 =?utf-8?B?eFlrOTVFU05lR3FmWUZqZ2VRalRaS1I5YWdRS3NTUkZRV2cyMFp5R2IxT3F4?=
 =?utf-8?B?SFVWV2VVK3ptc3FTVWpwRjVYQlVERG9MaGJ3VDlXekdjN2c5b1RKekVRZFFr?=
 =?utf-8?B?UTZKTmd2L2Y2UEp2RkRjVHp1NFl1ekpQaHJzQWg1NTlLOCtSekFnRXJwMkZs?=
 =?utf-8?B?RnZsTm9KUnV3RCtwbUxtc0RaWm1LdWJPaEhFM3YyQzlGVHJiaTBJZjFoSkFF?=
 =?utf-8?Q?Ff7miiDKJ2TmRMPfSnN4dC025?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e60b4a-b536-448f-efc4-08dce9119ae6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:55:00.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpWJFB+RhyvXbid/YhH13JAm7A4Q2UGSeZiXglvV/q07vMqajUldiUG3qfgTcP0kkFW3hAy1nWVKDWhrFmgkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

Hello Viresh,

On 10/10/2024 1:05 PM, Viresh Kumar wrote:
> On 03-10-24, 08:39, Dhananjay Ugwekar wrote:
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index e0e19d9c1323..b20488b55f6c 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -414,6 +414,12 @@ struct cpufreq_driver {
>>  	 * policy is properly initialized, but before the governor is started.
>>  	 */
>>  	void		(*register_em)(struct cpufreq_policy *policy);
>> +
>> +	/*
>> +	 * Set by drivers that want to initialize the policy->min_freq_req with
>> +	 * a value different from the default value (0) in cpufreq core.
>> +	 */
>> +	int		(*get_init_min_freq)(struct cpufreq_policy *policy);
>>  };
> 
> Apart from Rafael's concern, I don't see why you need to define a callback for
> something this basic. If we are going to make this change, why can't we just add
> another u64 field in policy's structure which gives you the freq directly ?

Sure, that also works for us, if it is okay with you and Rafael, I can add the 
u64 field in policy struct.

Thanks,
Dhananjay

> 

