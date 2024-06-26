Return-Path: <linux-pm+bounces-10066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D9A918E1D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F2F1C21213
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DF17CA1A;
	Wed, 26 Jun 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2tLXVKKT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCE14A0B8;
	Wed, 26 Jun 2024 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425906; cv=fail; b=PNlnFjUjdFPIcwniC8lmKpCc01m3QvJw9Zy5qS0HnBsLw/w/5pnL2DljSQrKAbsHz4h+H3gm2abqvXk1THfcdzHZXomQj4Ng/yR41Kr6uWySJ+bUuP0BlSvu+29YACR6wjZgRO5+T7My4f9OOuYfoA0dBw8mR5r4tTBelPyFTr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425906; c=relaxed/simple;
	bh=3LP0yOCvPXB9cgZIQdi4gCf10FMJ6d+qkCldOmPp0mY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+/82mED1XUvNeFvre5ycsyArABGLri4OB3VS7SAJS4JUH5FPD2f/1sEpIq4MfzB3la2x/Qw7R9+5qaQ0N4gJlD3TA7huJtDke0bzZ9rwRJ1hp7N2lc7etu4JtWl04CT+vyOZ9Ur5v8rd0agCQtRtDV56f8tXGhWE3E0r8y9YQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2tLXVKKT; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVXaG+TN9Va041fTazJCjIaBcKC4c3YFKug1gpCu+odxtVc/w/DeHmLU22FGqGkbj6jYUWTYfx+Ld9YZCQcAfuRHVnBf3ghfAyX3PDmyO1kV+WlwG7j/vzap0DLTorR1hmSKP4fBk6zsGhVJJatzAMcoXGuM5qNo207Kne4FrgdPeAwlWpAFVxRYU8JIrmBcO8LBdnPPE7582Ac9SyAttzcSrCnK6L/01VZ0wh0YYsipOIWNLfWKqE++zsWrw05cVDZ5G/3Ken3sVSl3x7yvxljz6kW8X1NKyJ0HuhYs6xAs+nI6j2O39eq57x9WGael6+AGOK6f9IZPiq/+6ZUX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M9PWTHtX6d3WQ2Pr4dkBAAYEFUKoLsxk2cJwOrfwkA=;
 b=RQCyVVvoy6MUFf2YgC3myld2y27jW8rMHm6jg4FpgEayzZtCgHX+fRf3aUVGa16LabEf8zvQJsz+92ia60tIsnN57s86uG8ppgDoOlPZPmH0eNrtPRk5s97fAewenABoL37dakopLJZEk5R4lNh6Hv0vHFyjjuGOb3WNlrW6HDDxsnhlUbhub81bfPaVBT2iYm5JhqpMofxaTTKbP4DAAgckDxWgORkgLeYp3pXZQFOR0cN4ue/p4RgnLrliFtgoBOHIi/gmjilXVjXDC2PStAuqJ6uISOOYWAFhMydSj9x2xlNyXKzapXYXzJJ2401+gx+2u7vzAU/RGNABaC3qAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M9PWTHtX6d3WQ2Pr4dkBAAYEFUKoLsxk2cJwOrfwkA=;
 b=2tLXVKKTu28PzdSgG+QSbz2xlfMHugvWzt1Kc7sBQSeO/OJOzG/K4O52FnQJooCV8ZE4BSEtKxNV7wlaJlCsSy5+5IfPsZyEb01CQt9agOpI1C8b76rjkFJeFDKpUDRrnNX/cMaxC4RV6iUh1rsldEmO1gbTib9qAYRPYRq3GCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Wed, 26 Jun
 2024 18:18:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:18:21 +0000
Message-ID: <681732d3-76ba-47ba-9cce-362c6fe094cb@amd.com>
Date: Wed, 26 Jun 2024 13:18:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/cpu/amd: Clarify amd_get_highest_perf()
To: Borislav Petkov <bp@alien8.de>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
 <peterz@infradead.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-2-mario.limonciello@amd.com>
 <20240626171421.GRZnxMbcI83xe1SLtB@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626171421.GRZnxMbcI83xe1SLtB@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 923f5f66-793f-4897-bc56-08dc960c5c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3VpbDJpQ09DRWdtUFd4cVpPdmdkMWxPb1BuVWFTTEpONnlndVZpWnhzM1Uz?=
 =?utf-8?B?ZHJ4Y0FzYjJqK0ZqZTNrZklTOWhKeTBVUjJ6ZVFMU2k4ZkhRTXZidlg3cG4w?=
 =?utf-8?B?NElnQWdvUFJGVHdHcmdJMjJpY3ozQkNKQWl4SVVON0tzWjlmV3FvNTJkMTln?=
 =?utf-8?B?Z2ZFaWxydy9SaGFvLzJNeUk2MzlJVmc3TloxcnpyeEpMSkdCRXluSnE2TUpW?=
 =?utf-8?B?Z1htY3ZuMCsyNm9aVzNBZWJMMXJlVDZld0ZpdC8yZkkzZmo0NWhPUVlSb3hl?=
 =?utf-8?B?YnZnTmFMUEdOWVhXWUtsQjVNcFBsOS9XWlR6d3RKRXRTbEZTcnFvR0lZNzJF?=
 =?utf-8?B?MUx1YnRvWFNhRUhLUFRYd0xmTzRoclBGYUV4MFp4eVpIUXA4Y243K2dVL2tF?=
 =?utf-8?B?SHpIWEF5Wi9CWnJJeDdyQUZ1bmJrN2pFWnIzVk1vWlUwVjVsRW1DTHo0WW5G?=
 =?utf-8?B?Qlk5ZTB1ZlJTV3UzUTVqNzZnL3V2TTRnODdtZ212SE5FanBRVXpsRFR5WFVw?=
 =?utf-8?B?UXc3S3F5R3FlUHdjQ3JCRllkVEpHUlVrcDZaUDVIY2pSVkZBZHFXVTBRQ0VQ?=
 =?utf-8?B?bEJpMk5wSmtub3pNVTNtUi95cnVWN1pkNzlUUE9KZFV4LzZmYUkyZnR5QS9s?=
 =?utf-8?B?SC8xMTZQanhna1R1L2ZJQVlMQ1ZOQ1hDQ2dhY1BZTFpyd05GUzRIVmtmdjZP?=
 =?utf-8?B?TGZCSUdYQi9MdHp4aUhTZ3pkai81MFFRMndXN1I3Y1ZMVG5BbG1ZYndVZUt4?=
 =?utf-8?B?QXhmbERiMVhaY01mUWxHdldwdVBRUktUT2FFREJCekRDbTZQeU5tYXo5SGVM?=
 =?utf-8?B?MVF2Y3dGUWtRcC8zWG5wM0VDalB2RXJrYUJqbGFENDIzemJvdCt1MllXWXMr?=
 =?utf-8?B?WHUycVlxdEJ4UDJNSUtwQk1Cc3Z4cW1PYU1zcnBuUE9tbnRaaHpnNFpCVkgx?=
 =?utf-8?B?bW5aU2o3cURMNTdQaXRFaVNTM1ZGd3hvSHV6bHR6WG03ZUgvK2hRZFBKNUtP?=
 =?utf-8?B?SmIxREJ4WEgwV216eVZhc3ZJTEs2VWFPZ1VzZ3gzRVZxdVZOVitUVDMxWmhw?=
 =?utf-8?B?a0p2NmNVbm5laTZVNkJYRWw5SXBtWEhxWEx4cUV5V1R6czU4RGNrR2ZlSzNk?=
 =?utf-8?B?OUtTOFF4bVVlZTZtNWZPR3VCVlZBUTBNUkxVRG9kd1dFR1M2eE42bE5xNVov?=
 =?utf-8?B?KzJlUVlyTEt5N0N3ZGszRTkwdnYzUWxWZ2pNM1ZwTldFbVpBMHFCU1Vmck9J?=
 =?utf-8?B?WnZMR1FKVjB5a2NnUXVyVVg4NUJCWnpnVGxISmJPajFjOTNVRFNmakhUZkVR?=
 =?utf-8?B?SjRMWVFreVhPOU9vNkk0RWpabnkyenRvVjVZUTNVQ0E5STVZL2NoVHcyMHpO?=
 =?utf-8?B?enk4ZmFSaDM0U0M5NGhZRkJWM3piSnpZZUFXdU5nYkFJaC9lQk5uUXNIL25u?=
 =?utf-8?B?Nitscld6M0g5VDliUE84NUx3aEZmWVN0cjZZd2dXVU13ajhkenZ1b1F1UW0w?=
 =?utf-8?B?OUFTRENVNlNabGp2SEZWSHdQRVl6Rmt0M0dVemk5ZjI2Qk9DdFQyTC9GSHpu?=
 =?utf-8?B?UDFnMmRvdDNBWURiM0s1QmRjK24xR0V4TmR4YU12VlBsMkp3VTkvUlk4MERS?=
 =?utf-8?B?U3ZoZFdYV2d0WXJRMG5yNFFvdFNnVXBERFJFbHFpMVZYREtMZ3duNlFEMzBw?=
 =?utf-8?B?d2tuVmM2b1JEMmVoczM2TjRGallwQ241QU41SlZhVlZPRDFWT2RjRFVrMSt1?=
 =?utf-8?B?VHBQTnlrSlF6a0RsUGlsNFRwWGF0UFVMOThUa1IvWGhOZWpuTUZPVHNHbkZh?=
 =?utf-8?B?bm1VbzVGVTlOZDdJejR3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFlXbC9NbVdQc0pXQU9FYkpJTVdFNDhMMEd1MWEyYU42Q2pxbkVRU2xLYTRj?=
 =?utf-8?B?V1NHVTUzdzVJRGdnTXdmVHQwMkxvdTgvcUpjeWJBdGptZ0lZM2VLVlBWeWtR?=
 =?utf-8?B?Z2NRb2xnejc1TE8xRTV6VG50MWZuMTNQZ3RHM2V5TVlkeGFha0UvSlVpTENZ?=
 =?utf-8?B?c01sOUkzMHJvN1Z0bnZTUzNsN2FhZXFGN1oyY2FGZmNxZnhqNUlld2M2dDV2?=
 =?utf-8?B?dzVmZnRtZ0ZPTFUyVkRWVlRocWtxeEpibFRTeXBCbEpkOE9LdG9uaytRUzRH?=
 =?utf-8?B?azNla0pnWEZCaktqYkIzdjBvQjB5c25GeThTMnNzcFVQNVllV0dRUUtSK3hB?=
 =?utf-8?B?Zk53RUpOWW5EaE11UGNVWitMVTcraXArUDByRlVsMUZzVlloSFpodVRmbkIy?=
 =?utf-8?B?dVJVOWpVWExIa1h2NDI1d2lHS0ZPekE5OVFjRmxNUjRGTy80RW9vQzZqMy9D?=
 =?utf-8?B?Z2pzbGxjbncwN2gwUGl2UkVQemVia1RDemNrbElGSGNoeDZaRkRTRDZTME5K?=
 =?utf-8?B?VHorNGI5MzdxNDcwYXpaWlJNRlRVUDV5Rmd3cjRUL1BWcTNlRTJZU0xDYmZt?=
 =?utf-8?B?STRpNXJoR0tSOUY1V0kwbEF6Nnc2QW9MNmRacnN2NnY1TzRVUVhUUWFsQU42?=
 =?utf-8?B?UlhEaCt5VE83MTRDZ1F5MDNGUmF2bkVEWnd2Y1QwY29DaVNOZnE2NWFVcHgz?=
 =?utf-8?B?M1A5YUFVbEdpZmNCMURIWW9TWk15QXRjdkhDWG9qU3BuaDB1c1NWSm9CWnZi?=
 =?utf-8?B?bGEwOU42SFZ2ekhtbmFFSmh2UkUyR1pLeHladlRKMENxbEhucW95Q0ROeUh4?=
 =?utf-8?B?UGxFMmdKR2hWR1V1Vis0REd2amludTYreW8yUGZLeDVhR2QwZkdyT29WM0pR?=
 =?utf-8?B?VVdLWm9GeFhMbTNDUDBvMDRYWWxsZGxKNzdHTVNlVHhNQ1JxS3ZINjM5eUFv?=
 =?utf-8?B?d1NzYnVGekZ0K0RPSlpoMmkyaUpzTzdKb2xrUHFWWVVTNExWa3UzUCsxK0x0?=
 =?utf-8?B?aEIxY0N0K3F6c1pWbG95eXV6aTVOZ1hXWEs3Q09sVU5TSnRPcURDakxkTWFa?=
 =?utf-8?B?eWk3Q01PRDFnVTJmR1FoUnF1ZWVXRElEcDBTZ3BLaHJHeTBXRXo3SHE3ejlK?=
 =?utf-8?B?MHFhR085MmRzVy9KUTE1LzJMM3FJcmpEbFB3dkdzTDRpTURiRmI3bnNMWlp2?=
 =?utf-8?B?NG1FQ2JRKzlSOFluREVmaDF0K044a2RQT2Z5bzFkSVZqa3ZpZ1lmU0ZoVkZa?=
 =?utf-8?B?Wm40Z29VWTVxcXBHZWZ0WnloMDMyQ3N0ZC9NaDVrWnp0akFwajNoZVhNSUdB?=
 =?utf-8?B?YkNPeE5pSlRWSERsN0M3elZLNHN3bUgyNk1IZWRDdkZaajM3M21DN1ZGSjVC?=
 =?utf-8?B?WVJ1b1JNc2luNGtRcUVsNDhya0VJL2RMbGtDbzFvaGxyZHNvUXBqOUYrL29I?=
 =?utf-8?B?c05FYWhvYlVuNjd3SEF0SzlScTcxV3pyYjNPSXNoYW9CUGxwN1F4TmN4cy9m?=
 =?utf-8?B?TXgxeEFiS3pETlhXRDQ3aTJLU3kzU210cnRGemUxV0V0Q1N3T2JKOGlBVi9a?=
 =?utf-8?B?RUtiYUFvNW4xT0ZzSXZvNk1QY1dPQ1JxTzEvVTZLV1prUm5SMS9aRk95MU5n?=
 =?utf-8?B?V2huRmVvNUtsVFB2YU90TDZibWNiYTUrb0pmQTIwSXYxU1BJeit5OTFyOGMx?=
 =?utf-8?B?SnkvYnBlVitIOGJrQXlCM1QwdXpkNFNSblNveUcwd1ZJa2s0ZGlibGpoL3Bl?=
 =?utf-8?B?NUxGUGZ4REx6SjZHdXRXeDdKTXpwQWFRWDdlOXZ6cVE5R3ZESGZQaHhqTENa?=
 =?utf-8?B?L3BZK0JVSTRCQkpWSTRqS05YSm9heHFBRllHK1NBcmV3WVY0c2RXQjZRWWtG?=
 =?utf-8?B?RExTeXk4dTFBclN2OGZNTlpkL0NmMlVWVG9KMldURkc1czZNYmFSL3krU1Z0?=
 =?utf-8?B?c2RhMlpvbm5RV3hNQ0ErUTFyK3F0cG95d2UvdmlhaGF4TjJiUFhoUGVyeVhZ?=
 =?utf-8?B?S1dxZEMyTktFbFZYaDRjY3QrblVLdXE0RXFJYW5uS21nZkVGTUhKblFhS2h2?=
 =?utf-8?B?Njh1Rnk5Mk0zVEhabHdxQldyamE2Q2daL1plVHZIanlVRGxqWjVRWEdsRGN4?=
 =?utf-8?Q?7qYE3W4vk0u3vO9nZ1aERV7yT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923f5f66-793f-4897-bc56-08dc960c5c45
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:18:21.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YzmghpG4KXTwwjZwEQm8sr03GiTVXDkzgOCrxtnAQ4bvNtP4Pml2VcCkgrcnV3wX76c3cUzKDN4CHHQoPh5uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

On 6/26/2024 12:14, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 11:20:42PM -0500, Mario Limonciello wrote:
>>   static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
>>   {
>>   	u32 gprs[8] = { 0 };
>> @@ -1194,15 +1198,27 @@ u32 amd_get_highest_perf(void)
>>   {
>>   	struct cpuinfo_x86 *c = &boot_cpu_data;
>>   
>> -	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
>> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
>> -		return 166;
>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
>> +		switch (c->x86_model) {
>> +		case 0x30 ... 0x40:
>> +		case 0x70 ... 0x80:
> 
> Well, it was < 0x40 and < 0x80
> 
> You're making it <=.
> 

Good catch, I'll adjust to 0x3f and 0x7f.

>> +			return CPPC_HIGHEST_PERF_DEFAULT;
>> +		default:
>> +			return CPPC_HIGHEST_PERF_MAX;
>> +		}
>> +	}
>>   
>> -	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
>> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
>> -		return 166;
>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN3)) {
>> +		switch (c->x86_model) {
>> +		case 0x20 ... 0x30:
>> +		case 0x40 ... 0x70:
> 
> Ditto.
> 
> Also, ontop:
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 73559db78433..5d496de4e141 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1204,7 +1204,7 @@ u32 amd_get_highest_perf(void)
>   		case 0x70 ... 0x80:
>   			return CPPC_HIGHEST_PERF_DEFAULT;
>   		default:
> -			return CPPC_HIGHEST_PERF_MAX;
> +			break;
>   		}
>   	}
>   
> @@ -1214,7 +1214,7 @@ u32 amd_get_highest_perf(void)
>   		case 0x40 ... 0x70:
>   			return CPPC_HIGHEST_PERF_DEFAULT;
>   		default:
> -			return CPPC_HIGHEST_PERF_MAX;
> +			break;
>   		}
>   	}
>   
> so that you don't have so many redundant returns in the function.
> 

This uncovers a case that I'm not really sure what to do about.

Right now acpi-cpufreq uses this function and if the CPU isn't special 
cased you'll get the value as 255.  This is totally wrong for newer SoCs 
though.  That's what prompted this series in the first place that I saw 
different behavior in amd-pstate and acpi-cpufreq.

So I think we need to have something that is:

switch (zen1) {
case ...
default)
	return 255;
}
switch (zen2) {
case ...
default)
	return 255;
}
switch (zen3) {
case ...
default)
	break;
}
switch (zen4) {
case ...
default)
	break;
}

return 255;

(This is no functional changes)

And then patch 2 or patch 3 change the "default" return to 166 and if 
there is functional issues then they need to be special cased.


