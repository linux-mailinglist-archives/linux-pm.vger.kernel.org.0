Return-Path: <linux-pm+bounces-7595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE78BE6DB
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB4F1C20AE3
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2B161308;
	Tue,  7 May 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sqYBMjz2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2E160865;
	Tue,  7 May 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094215; cv=fail; b=MZmFnPBAbcnpz9+Zio88pRWp52dHos0gBJFSb5zdyjfxP+QUAyHyX9RlIQS5LcPXC+4PeFylNR3TfcH080n0tQIyrsTyYdrbWt5LdpZ2AKimHuPHPLQBFIkACg+HxYyTG3btP9BU3Z2j73dqHC2LqFHIfTGHG7bEAcwEeM6yQvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094215; c=relaxed/simple;
	bh=PZ7OlmYfBSFVaJ3HaR5OIAm/BRdZWFBb8s7J0FV0sDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pqfHVliJiOy5utnSNONk6/p2LX3VyzdFa731Ftss6W+YQbaVw9yXymD2uwXIhBlhgnTDV5gBGwQ7Temk7Z+eORztrg0r5pUXQrb90XqxBognZDjC0CpTiDpC/4sw/4IuLV2+SvO9/DJMiAI1etsoKNCg4OG0OKQqYeNhH31V280=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sqYBMjz2; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3e1ALjHfLWgP7O3TVImvfn1Kq/89XhDBsabQaOgwpGUJah4qhXEix+V/mffwyWP/BjX6+/0CeLXw+vQyOvkWWDru7nzkb14dm7VmSVoaxfvaLlbmESqQvwOF5MPtmz+giQBs5WOsNJVAfCG8iRH3B7bRH6HEQkb9k5M/haZnXah5NMy8VC+njH7RdlWZdwvAcabLzFjCqAYbX85ViKZ2Vdp3FQQ/s9Aix4mZVALHrkg57SXHgQcyVXfkMTrKVPOkZJNODTZyEhbiZPn1bLWNU+1IGyqcN19LR7ElHUfi5uS3NikwCr8quZhbv3U3YgdpAKXjnRHrD0n+8ZL8QPWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK27XAXJ7yzzSVu5pTkXSRlqlrlhBFdIe5WVMGkhU7E=;
 b=gt9dQQ1JjxsnJ1ZfyPX44IMck52aa94QhgG4tKSTadZoqSNFC3HivohoUSowCgEOxIpj6VE3TITLdK1JuI7StzaxF0GV88632IDeBWsKY63X4ZusQPZzDi+Dxb1yYZgz/amjc4ll1BnmN5EB68EFNgQwL1dcUfAkkVazgOTL1a/Z8Ef72ghgihBO7iwNLLpcPTo4CqM6akMvmd3/qGPMslJiT2hFz/h90yRfKv5dgeu4EtwHPCprNG0Ft5O1f/slnwdZS/OuuU9duOOUO6Dc6J502eqJFYOdYpUbHtGIjoP7dnw378xHIATmulxs15sKOlg1K/Q2sEEDAHuiTfAQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK27XAXJ7yzzSVu5pTkXSRlqlrlhBFdIe5WVMGkhU7E=;
 b=sqYBMjz2mo4t2f4PtH46MHPEg35P2kCglGWTvC6h3Y7bePm+29dkrm7BjSTqjYYv4pSjQKpRSwvK0U55NXgr22LcXtY7kKkcoZQCaYRY+zIdItP46sLD6ywgdZbTdGXgIfZ6pTgxdKHX2BT2AcQMvcSIxmmShkSvw+x1GjnCeuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 15:03:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:03:29 +0000
Message-ID: <9f901f10-24f6-4d81-9bee-2f8126251a86@amd.com>
Date: Tue, 7 May 2024 10:03:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] cpufreq: amd-pstate: switch boot_cpu_has() to
 cpu_feature_enabled()
To: Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com, Borislav.Petkov@amd.com
References: <cover.1715065568.git.perry.yuan@amd.com>
 <39ce335d80306e7e9ed9e169994348e1f65e1679.1715065568.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <39ce335d80306e7e9ed9e169994348e1f65e1679.1715065568.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:806:121::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: a1710bfd-a565-4e19-a9f6-08dc6ea6dad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ZpdjNjZmN3SUtnS1VYdmI2RGRMV0FTRkhLbHdCZ0ltVDdxcUNWdTlMUnB3?=
 =?utf-8?B?TGlCaXN0cmtVak9xa21PMkpVUzhCOG1PK3NVaER4Y1NMNmpsVE1INmJEYXh3?=
 =?utf-8?B?ZW8vclpGZ0VTaURiOG16RjRIQkRidjZ6SXpaVjcyYmw4dktsMkhtVXVSQmE4?=
 =?utf-8?B?dUM1bjdrZ0JCdmhhcWdxSDh3NDVQcnJuRmxLOVVoNENWMEliUFRDc1hrTVBV?=
 =?utf-8?B?cG84aTVSblpRTWVuTjNlUnhhaW56b3R0OXhaS2FpWllVUGIvYytpMk5XYUdy?=
 =?utf-8?B?a2hOamhoUmpMMXdnem9XbUJKWTFBYWxDem1rNGQvOG8yaVpNR3JYb1Vxd1Ry?=
 =?utf-8?B?elJId1BxK3o1RjdtWHE4Vll1NWtBR1VHenBDUjlOUHI3TWExKzBaZjlZT3gy?=
 =?utf-8?B?ZE4zREFyYm5BNmloUGNKRGI4K3I5MmZOTlQrTHY4S05WR2JYakZkRFBCVngx?=
 =?utf-8?B?SUVJRnV6dzJ4NE5EdkFjcStkdTFUOWVIRkJ5cEpDZlpJU01uUVdFbXc1dnpQ?=
 =?utf-8?B?ZmEzWFc3RFZLcytiVFRWRHd1emdURkZmVUtBUVp3aVN1aXV0M1paVXlBMVdz?=
 =?utf-8?B?eENjeTB2b3RMRHlRWjFPdVV1d0I3ejNlQTZQZVQxYjdja1JSQjNJTGw3am5z?=
 =?utf-8?B?cXQ0WVJWUURBdmVmQlA2aUpESkVNQnBJaDNGN1hsZDgrYlJzMXNXTm1IZ2Rm?=
 =?utf-8?B?TlVZZDJSUVRudFJPWkpqNG5sN2UxaTlKMnNoOXN2MGJodGpxZmpyMWlFYTFV?=
 =?utf-8?B?R2JxSHZ2WlNtM295bzN2cmlTUUcyZlcxMTRtQ09LamMwVHF2eWlnMzB3QVlr?=
 =?utf-8?B?M28rMzJyMVoxdDRhbG8zd2RCZDE2UHlrUTJqenF4M0ltVUtQcUZqdUp5ZE1x?=
 =?utf-8?B?MHJSWWRLRnNNQWpiVUhZZG5PSENEMjBQbHlhRUNPRFRBOEtzODhEdlFvaHMx?=
 =?utf-8?B?NThMTmxHbTZwbldkRElBakZLbXNpUmU4cUV0OVF5RUo3bXhVSlQraFJsMHZ0?=
 =?utf-8?B?Tm9UamVscTFkbnZ4REJVZjBFSnJybitDNFV3OWMwS2IyMTdQcERYUFVEamI1?=
 =?utf-8?B?ZVB2QUpoOG1PYlAyRHFBSWdCK1FqYnlPMUR4azBPVUlXbHFIVWlVTUpCaWxs?=
 =?utf-8?B?aW9ZUXFtT1FCRzlGVFlVQW9nNklTZEY0b2g4dXBVYnJac3d6NFFEaDJFdnpn?=
 =?utf-8?B?dFdpT041YzlHSHdveTJtS2w2MFRiWjh3YmtkdXk4d29zR2ZPZ2VOL1U4L3dz?=
 =?utf-8?B?UnNneWNlZWpuaEFmbUFyV3dDVHRnVmlVOGtqcjN1UUpzVC9GcnM2MHNEaE10?=
 =?utf-8?B?U0ZHeWJFdTZycEFZUFdDc0FQMURNNTFMNks5NDVnM3YyMFVjM3VwQXdBODBD?=
 =?utf-8?B?SzhORUdwMXVUSTRvMGczYWJhS0doSDZRRHVFMnpFc2ZHTU1ienFhQTlFL0Qy?=
 =?utf-8?B?YzRYSGVwYkYyTFUxZFg5TnJLamI5NGk2SWxPL1hOMzA4Tk5KN3V2L1RQcnNS?=
 =?utf-8?B?QlNZMHNBMWwrcnlmU2pPaWJseDJjUWJFOTR4NGwwN1pVZnlUbGVUVEdVM2Zw?=
 =?utf-8?B?TVpzRTdDYVorZS9GTXZlenBnaTQ1a3lCWlRycVZJaDBrbS9vNXhkRTJYSGhQ?=
 =?utf-8?B?b2hOMW91WWoybGFlWVZOdUk1ekt2T0RobXFlZkk4VzUzd1RISVl6dkRKWTJw?=
 =?utf-8?B?LzZ1RFZwdDZ5cFFLUFVsRUJJa0ZKUU0yaE5IV1VZMmFkbnl3WnpwdmtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDZlMkNKbUhkODUrdWN6MlB2K1QyeHJCa25yT3EvZmtQOWZTV05aMThoYlA0?=
 =?utf-8?B?d1ZpQkRwUjRTMXRETjFKQlZCcDZLb2xQQmdrNHFNOUhRVmlkc3dtZURETEhJ?=
 =?utf-8?B?dUtFZTcyM01FVnJkdHd2V0ZmcUNTT1EyWGhxaVpNTkRlam1hWm5iTEhpRXlr?=
 =?utf-8?B?YjJZRWdTdXRHZG93Q21YMVhrUmdzZE5GODZXb1M4NldxcjU5OFRvU3d4RmY2?=
 =?utf-8?B?aVNwY2d3N3dORzAvbWN6UUhlVUhSTXl6Y04xeWxXU3lMYzRmZkhpeWY1QWs3?=
 =?utf-8?B?Snoxdk51SjFaUUxkZ0gvNG1pMGhUQlBqd3R5NjR0eEtNV08rdzY2QTVRMnFm?=
 =?utf-8?B?bWtXa0RKb2lLcmRDZ3hSaWFNenNOb1FsK3d2WWFyeEo4cHgzcE1sQnhJWG1R?=
 =?utf-8?B?WHEwN0F5WVlMdTJGcVNBUkVqNlRZL1lDV2VwT2puNDBvRHdEclhzdlpUTjZW?=
 =?utf-8?B?YThRakZBckdaeHBTOEJPOEwvNVJjbnFidWJMdlhrS1JzNy9sN2drL0V2RkQ5?=
 =?utf-8?B?elJHMmU0dFo2V2VESUdhRWp1Nk9TTmtzV3E1b2svSWduditRd1Vqa2VMRGxw?=
 =?utf-8?B?dklESGJBL250bkt6NGN2Q1Vwd3R2Ri9MeFhpVHp5aWQwMldBZ1gzbjhFZWxR?=
 =?utf-8?B?Wi8zT2RWb0t0ejVEVUxxTlpUZDBLOU1La2Q1bFJ4WjlHRFJnR0lOOXloNXdt?=
 =?utf-8?B?YzRRRENiNk5jUGdWVWlNclRkdCtwZ0F1QlovSnJvWXcxdjRVNHpCTit6Z2xT?=
 =?utf-8?B?V1dHUDdLaDB5VlkzMUtheGdROElZZksxZkZZa0l1RjJZYTl5c050ZW0rNFNB?=
 =?utf-8?B?RmNNUnhIaGlLRTk0MmNwa0d3Y0tqb2JCaE1sUUh3ZWVnOWdDOENaY2phdGxL?=
 =?utf-8?B?L0RGRU5adVc5VVZZelBtd3BrQ2t6VTdMWGNxUUxTQXVGSmZVbUlVN3RMb3hU?=
 =?utf-8?B?akd3S1NxbUozTDRtWXJDVWNKUlBuZjYzbEVFOGdLVmUrWVI1M252dUFQWEhF?=
 =?utf-8?B?RFFSNitZT2oyU002R2NDZFlsTkdQbVNNbTZvc0ttdWw0TzRtRzFGQTE4VWFF?=
 =?utf-8?B?alZKb3RRVFZnWDE3TnRwcG9qbHlwZ0lXTnRiaVB0T1F5N0FLcHlBMWNteGtC?=
 =?utf-8?B?SUF4cG4ybkUrV3RTaHhiZVFnN0hvdzJ4WUk0ekwwMHVTMzlJd1pMblRtaElH?=
 =?utf-8?B?WmgrUnArWEY5R09Xc3RrRmc1VjNTUFFvQ3VkeWpLeUpqUVBBZmtva3pDNzFG?=
 =?utf-8?B?MHhKTTliSWQwc0g1WGNhOHFZTHk2aUVweGJOSEJKcEZpNTcvOFc3N2FMV05D?=
 =?utf-8?B?Z3JFN2l6UFR5Sm81OUFxdUdCQThPby9CN09nSzRpRlB0TERyUE4za3VQYk9i?=
 =?utf-8?B?NjRDMG5Ba0RlNWFxcy9EVFRDY0wzaTl3ajIwckJCSkxmc3VrUHVndFpGb2Zw?=
 =?utf-8?B?MUgvZ2tjckpBcnNMTElIYklEWUg2VFJzQVdIcjBvR2kxSHFKb0RudFcwRkd0?=
 =?utf-8?B?ZXBVWFp0WEsyemErSWNzRlE4UVZKSXlLWkROZmtxUEtOdi9VTk5scmxwM0Zs?=
 =?utf-8?B?d01xVXpEN3E0YUFoVlQvQ1A0elFIWUI0RVU2Y1hVUlhPczJ1K002N3duMC8v?=
 =?utf-8?B?dFA2aVJMTVZrTjkwOFdKUXJHRjYwVlgrZERFNDJKWjFLbjAxUndGQy9LSTlL?=
 =?utf-8?B?and5bGhGbkNMOG1PeHV3aW1Ga1crK0pncGErdGtTOTBINzhxZmdYVGJBOVZi?=
 =?utf-8?B?eVF1amY0aUtkYThkVG9PQ2xBdEczdjM3eTdrQmh1NmtIQVlxMWlQdm80UFZJ?=
 =?utf-8?B?SEw2alpPWitFZlkya25kOGFNbHd1WHk4VEE2YXR5MGRjaGNNZEZzMVg3NGZK?=
 =?utf-8?B?Q0VCMTY5WUVtZ0NtUlB5UG5aR1llZys0ZlFKQzcxSnNoNm5tV1ZCc09YK3Nr?=
 =?utf-8?B?QmxpVzVQWjhnblY0RDFrV0UwNjZUQlAyRjVXTWptSHovaTQ1Q1RoVklzU1JQ?=
 =?utf-8?B?REQrN0RRWjYyVmtuUEtxMlJaVkViaU5tdmdtYVVPbTByOVZySWl2VVpaQXFH?=
 =?utf-8?B?aVd0ZjVHMjIxaFdWa2RtQWlDOFRzTEQ0TWZuVDJaR0NKd2I4Y3h3NEZmY0I2?=
 =?utf-8?Q?2G4f2oZHz9fbis4Kc46CpBsce?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1710bfd-a565-4e19-a9f6-08dc6ea6dad4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:03:29.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8vHhE8VmWoTP4PV9cPHgJlt+0mhHqiBEEY/oOQ8e5lyZey1P7IDWa+zcV8lBvzuZCZgZ5kQU4kkwd//FGaSMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On 5/7/2024 02:15, Perry Yuan wrote:
> replace the usage of the deprecated boot_cpu_has() function with

One nit.

Capitalize the "R" in replace.

> the modern cpu_feature_enabled() function. The switch to cpu_feature_enabled()
> ensures compatibility with the latest CPU feature detection mechanisms and
> improves code maintainability.
> 
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Acked-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e94b55a7bb59..7145248b38ec 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -124,7 +124,7 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>   	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
>   	 * definition in ACPI tables
>   	 */
> -	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
>   		quirks = dmi->driver_data;
>   		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
>   		return 1;
> @@ -166,7 +166,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>   	u64 epp;
>   	int ret;
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		if (!cppc_req_cached) {
>   			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>   					&cppc_req_cached);
> @@ -219,7 +219,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>   	int ret;
>   	struct cppc_perf_ctrls perf_ctrls;
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		u64 value = READ_ONCE(cpudata->cppc_req_cached);
>   
>   		value &= ~GENMASK_ULL(31, 24);
> @@ -705,7 +705,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
>   {
>   	int ret;
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		u64 cap1;
>   
>   		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> @@ -941,7 +941,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	/* It will be updated by governor */
>   	policy->cur = policy->cpuinfo.min_freq;
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC))
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC))
>   		policy->fast_switch_possible = true;
>   
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> @@ -1174,7 +1174,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
>   
>   	cppc_state = mode;
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
>   		return 0;
>   
>   	for_each_present_cpu(cpu) {
> @@ -1404,7 +1404,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	else
>   		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>   		if (ret)
>   			return ret;
> @@ -1487,7 +1487,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>   		epp = 0;
>   
>   	/* Set initial EPP value */
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		value &= ~GENMASK_ULL(31, 24);
>   		value |= (u64)epp << 24;
>   	}
> @@ -1526,7 +1526,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>   	value = READ_ONCE(cpudata->cppc_req_cached);
>   	max_perf = READ_ONCE(cpudata->highest_perf);
>   
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>   	} else {
>   		perf_ctrls.max_perf = max_perf;
> @@ -1560,7 +1560,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>   	value = READ_ONCE(cpudata->cppc_req_cached);
>   
>   	mutex_lock(&amd_pstate_limits_lock);
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
>   
>   		/* Set max perf same as min perf */
> @@ -1748,7 +1748,7 @@ static int __init amd_pstate_init(void)
>   		 */
>   		if (amd_pstate_acpi_pm_profile_undefined() ||
>   		    amd_pstate_acpi_pm_profile_server() ||
> -		    !boot_cpu_has(X86_FEATURE_CPPC)) {
> +		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>   			return -ENODEV;
>   		}
> @@ -1767,7 +1767,7 @@ static int __init amd_pstate_init(void)
>   	}
>   
>   	/* capability check */
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
>   		if (cppc_state != AMD_PSTATE_ACTIVE)
>   			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;


