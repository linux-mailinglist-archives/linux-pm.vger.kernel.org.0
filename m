Return-Path: <linux-pm+bounces-21415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5DA297FD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1536318803DB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF31FC7FC;
	Wed,  5 Feb 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HH/Tuw5H"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0C1FCD1F;
	Wed,  5 Feb 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777867; cv=fail; b=MGEEAhO8PU6GwoWXTtz/aGI6yyqT6n1ydubkrdMkYPNAseDjXB4QuyyeuJ7va0uIJWULR49JjlZV0R71iZkDfT8tT4MIgUWbDBmNDoU2Lo4Fe6+8QXujUVIG38FmPCv46qWxgjzt0TWpRYs75oICoeF7B5RXqgTdiFvis/9VEhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777867; c=relaxed/simple;
	bh=jVzv1jrVYlcVkOkaETNpppYxUB/HgFvMrisxbkHQ4kw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZ7cJ0izs7VPmu4GQs316Un1YyoLgkeiZ+/h7FoX03El9VGYZ8F3JSwuSv63vusz4ymQv/Kwece8PAauiTopY4mAbmlYpaIvUY+rZQlt0nGbLQRyOUtD2M7q+3yXioTKHL02HL0i/IVmfgDvTMKNBGtQ8tVSuzmTR1PfHGTZzow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HH/Tuw5H; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ena+8HUUwAEgQEq5H4XiVIoffwpGxzMIOt/HhBaZgJHg8MSHlGSjhGoTKRPCLTkpz9ELnJ0+AmaRZU6Na/2cIMrNRcbkxQwjhsmLxof56E7iqO2w4k3GEhOtz8hGgTTHd8WOcMq17wyMZKvSsPKB0QfGzibslIORsqde6OMUcA2jCQAQd5Un26EC6A4Nk//aHPfKTBt7LnwHY7gJY5kaCC6fnXk20hlbAh0+xBzi+Ynzc0fSZakynWhR/tgQ1B46NXww/e7AGtua4u0XousstDkY7UZbJokUDcHdeFvGjcavngZ/n+OUFi5CfuQe51wpd4P8Mi9eGWzBWeJq0j1r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGGivt95GRGxARtE6iXr20xhMn2bAW6bpMDFO9dJfrM=;
 b=XEcmjd9Gnj1uuRlSMSzbndx3IAbZSb+nSxVpGHaEC9sbQXs2Dx3ICxjiJpQkX10ZxtdG3IzdrYsblU+hyEwuft9MpwksRovSu+ZlTT6XiIPTUr2jpAAmysmK3feIH8KZfi7xn6K9vs1CRtDK+bIESBpyll9D5FjasSiv8FCcWcTw7VTrzdFqoOPtlpD+VgToANe/OgfxpyIeOe+2KgfugxP2jytJtdowTclHu1mLFEey8ydHUXK/M+rwUwUvVfzn8NPtu8g6ybf+vwooT233m3RDjCyGYXbxqlTyiNWumE0QJBtnVBzG9G/LUnzm6zCTeaQPhge8tn1SXSrPOqfDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGGivt95GRGxARtE6iXr20xhMn2bAW6bpMDFO9dJfrM=;
 b=HH/Tuw5H7VHoxoO8xXPYZLie70HDPo9Ky7lneqPXVKxJsY9aOYemRq7lRI16BQUwLRQt87LVJ76e67mbCcxR8xpSa77O6GBr02V3IBe1IwuRD9bQZwtk932NoLgGjkNll5x0LIrvK93n6xA8dUXdoSByRXeHFa2ceT2Nz3Lxzwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:02 +0000
Message-ID: <bbbc09e9-4719-4a8a-b368-1b5aa67b6e76@amd.com>
Date: Wed, 5 Feb 2025 11:45:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] cpufreq/amd-pstate: Modify the min_perf calculation
 in adjust_perf callback
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 gautham.shenoy@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-4-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-4-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a83c99-cd2b-434e-eba9-08dd460da7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2hZcEY4K25HWWVTWXJtaW9PUWN3c251KzFRNW9IUTFuandwanJFcVo5dHVy?=
 =?utf-8?B?bFBINFZJV1JyV2dFVGsxNWlhUVB1emtGT0lyZVNRMDBqNDg0RTJDQUtVRExK?=
 =?utf-8?B?QXdvVkFlWXJQNDRqUXhZR3lxVUNXNVZ2RzczeDBaVm9jTVVvZXppbmRYTDZh?=
 =?utf-8?B?Y2UyRm5udDlSOFVaWlQ1T1NSZUxyT05ycTM4L0IrV0FrTS9qTzdoZ1JTUk0v?=
 =?utf-8?B?RWFzVGpwOVVNT1JrUU8xc2J1bVltb2lqSGxwRkR0SFRGME0vTXJaVHlWWVZ6?=
 =?utf-8?B?dnlNa255b2JOYmhuV0p5M2MvYVhXcE5HVWhUc0cwMTR4L3FhYUhxbUhheGJt?=
 =?utf-8?B?ZHNmUnRUdllnUlFuQUdZOE9zWDd2akpVY0t0V0dibUtKSnFtb1BpMzFHNTBh?=
 =?utf-8?B?OTFteElNdG9ydnpZT05yMGo1Z3FiU1k3azgzdjgyYWJCM2ZjdUZPL1dES1dQ?=
 =?utf-8?B?a0JvYVRZT1huVzNIVHNySWVPQmtwWG41K0dpWEJKVHVJV1ByWlpZZit3MjRS?=
 =?utf-8?B?VzlTWTNVcVViVnFQVTJXVnc4cWR2SDN4d25jb1p6NEtVK2ZmM2E2VnJuNE1m?=
 =?utf-8?B?d2tRbS9ZS21iY0pBb3RWbnJRRGdxNlovaGhwMjAzQ2FBNlR1VjlNY2pIUk4w?=
 =?utf-8?B?SVNCeTFmYlorNlpRMzZXeHhUSXJzWkdCWDVZTWJGbDRQejhvWXVDQXdEQ3dj?=
 =?utf-8?B?S2UzMVp3Vmw4ek9IYTFMUVNHNFNsNWs2MEI1Sk41RHpZVkYrSWROMUZrRHdo?=
 =?utf-8?B?c0RDL0dBQjcxNEdyRkdoNWFOa0lrQUd1UmR1eEp5YmcyWDVBcXh3dzRXcTdr?=
 =?utf-8?B?Q3NkdlUyUzhzMUY0ZDlXQ2lMYjlWYTllbW9Hd1ZUZXlNaEpNUEZGV080WDNz?=
 =?utf-8?B?azloVDJOSVhiOTlCT09zR1BMbUxBc0gvdmd4NHovS2JXY2QvQUROUDFVOEFK?=
 =?utf-8?B?ZWVuWndIVEwwRDJZT0FKemJncFJqV1FucVNJdlN3Mjgrd2FXOFJtMGxyaXJS?=
 =?utf-8?B?SE5hZGMrWGZySEswcmxoekx5ZGxLSjg5MUFKZWNnMzFyUmtjR055UnhwUmhS?=
 =?utf-8?B?KzZyZlRHakdzKzBXMzFnVVFuckMwSkt2TFNPblh3Q3dUalMzc3UxSUtmZE9s?=
 =?utf-8?B?czRHVitpTDNaZytqSjBhcTRiSmZJblF5YU5Lam00aTFBUFhqRG1xMnBHUGpP?=
 =?utf-8?B?SnJ2WEtMNjNhN25sa2wxMmlpUnlacXByMlpUWXBKNlNlcUEyOFhVR2ZtaFd1?=
 =?utf-8?B?Y1c2WFdqdVlpRlNuMlRydVE4QkdZU2hBd01DQWNNaHE5ZFNpVmdEQW9SWmsy?=
 =?utf-8?B?NVo4aU11ZmxvcFZCK1A5TkNlaUwreWh1cHZJR2EwN0FQRGhLMVcvSmFFY1pG?=
 =?utf-8?B?bTQwSyttZ0ZHSEl6cDBjY041KytWVnV5WFJqbExSNFduU0R0N3N3bFVJbVMx?=
 =?utf-8?B?TUsvZG5NRm02a2Z3VkFGRVB1ZEVybm5nREhFcGJJZkc2NGRtY3NtdXRpTGdD?=
 =?utf-8?B?WWhiVGlaUG9LUC9mR3c1R3NvMjhid082UDNLc2lXcXJETS9mckxUTTArcXMz?=
 =?utf-8?B?ZkgyS1k2SHQ2ZmhGNjc4YUd5TndqVU1sRndCT3hMNVpHNEU2ZjJFUXo1QTJR?=
 =?utf-8?B?ajkrZHVHeHFlR2FUek5QV1B3TWFEZXJGYVMwUWk2aGhZUjcvK0JkdlRWbUww?=
 =?utf-8?B?TGFoMjBjUm1oeWMxSjdzM2c3WEtKYk5RekZMaEhmNTBDYjZJMzd0R0Nkc3hu?=
 =?utf-8?B?RVFoVk0rUFlIYkhyNG5lVGhDaXpyKzFSVUNia1plaW4zNW4rNkNaK0VkYTN5?=
 =?utf-8?B?Y2J1QUY2SGQyeitpdk9keWE3enBXRGNKTGpiaUY1QmVvei96cTkycUoyUTdP?=
 =?utf-8?Q?JCZ5UO2F5eKGT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck00Qm40QUc5YnN1ejhiUUdMV205SGUvZjFKWS9IYk5PZ0JFOWIzc0FLY2lD?=
 =?utf-8?B?a2xtNWNSZS9mYlpMV2drdWJHeEMxMjFZY3VMNDFUTWxVbG1XVjhKa3BSRWVv?=
 =?utf-8?B?dXhxRnBtNllUVDJ1cFczN012V2E5MzhtS1dhZVNMUVNMaXJOZE5ZWmNMVGhi?=
 =?utf-8?B?UzQwTDAzWDJuYXJudStnOS9wNTVpcHhqWit6aXprTzhxbjJHRlV0dVdZTEcy?=
 =?utf-8?B?QzRaK1JlQjNZUFRRb0FmbStSdERTSm9Oejgzako4T3pNOHlXajRkSDZyb08x?=
 =?utf-8?B?Mkp5eGlDc3BkWSswb01pYUNob1RhVmpWYWE5cGhkL1lOV29Nb3cxTDVvbmRs?=
 =?utf-8?B?ZlRlN29yRXlCRHdYZVp3MGp4aC9UT1M3a1dheVd6VFBJK1BRcUVzQWNwclUx?=
 =?utf-8?B?NjM2NHF4NVlqaGRtUUFEMDltV1VhMUxnaUFpbTQxbUxYWlNIdE9CSVRYWkJP?=
 =?utf-8?B?bGlwdnJvR2Y0VHlRSjAxVnUyQmhQbzg0aXNpY091WUFuYzFKWjExc2IzeCt0?=
 =?utf-8?B?eGdLb0dzSTdQRERIci8xQ0tQWWs5djR0d0FZaXgrTG1QU1JWNTdjZVUxdE5q?=
 =?utf-8?B?NHgzVmJOeGo3amVrVTRqc3BpdVlUNmJ0V01DeUR4ajBoN1JrV2ZqSUZaWlZD?=
 =?utf-8?B?L2FPb01VcmkvZnVFUm0wMFR5K1BWRDRxUUkvcDBBbnJidVc2b2QzazltWkt5?=
 =?utf-8?B?bFVvTFc1UEJTNkVCbmlzY3pqd2dLQXZ5SGl2bUV6bE0vOUI4V0tEUXBiWjZQ?=
 =?utf-8?B?RzlWK1pQb1hsU1QrWjZnMm5XRHJyTnc1V050R1FMWU1WMG5DRTFFUkpiMGgw?=
 =?utf-8?B?OEZuOUxRekhGVlROVjB5ZitrUjh6YnFtQVY0b0N5VE90T1VBa2x3MHlLVDFS?=
 =?utf-8?B?Q29ydEs4Mi9RaFdidmpqblpOUkxqUnJzREo1eVVKUm1JSHZ3TUxJNGdTTkZO?=
 =?utf-8?B?eGswMkF2V1kwTnZSa3RNSE16d1V5aTFsem5qOUMvM2c2WnI1TmNmd2lDcHAv?=
 =?utf-8?B?cjdMZ2JVMmNUd2kzdHU3cHVDM0lwT3VGcnNyckFPQmIrRlNjT21nL2hBK1Zu?=
 =?utf-8?B?RExJc2lsci9hbHpiSTVLK1lLOXVoZDR3YTNFbEE1V2V0emdocFc1WlczSHNm?=
 =?utf-8?B?bHJxZ1dDNkdPU0JkWFVNanQ2SmFyL2wwdEZYL3FTL1c3c3I0Y0hqaHRtZDJv?=
 =?utf-8?B?dkpPenJWTFRUSEpsQ1RzNVhRdVRwNlVMbDltdTJKajlTRWpndTAyUEJFOXNp?=
 =?utf-8?B?eUpidVZZdmpOelRFM2dWVGx2QUowM00wbFl5NzZFZlpJYlk3YzlzQ25neVBK?=
 =?utf-8?B?RDk5czdyNmdYRXVIdTZTMHhrM0NwZW5vZGh2VDRvWkNaNEJvRUc3anhCUzUy?=
 =?utf-8?B?bnRkNTVSY1pnYVUySVpWT0gxRThEWGRPdCtMV0hyNENia3ZmQ3JIcWVXM3dU?=
 =?utf-8?B?OGY4dWswVzlPUjRaT2cyZnExakpIK3dya05lRnpxN2pCNEZzUGROV1orKzBI?=
 =?utf-8?B?Zk1SczlFb3dKY1BVaDJzMVRKUlpEZHdSdUR5WjBNWExhczF2MUQ0TDc4ZjRw?=
 =?utf-8?B?ZXJSV0Nvdk5EalhSWjJ5U3NVMyt2dDRhM05yL3ZjWFFjN3FHNkFLQzkxU1Fp?=
 =?utf-8?B?aXRzNFlDdzZ5OTZZWlJTRmp4N0tRWWhxYi9XWitGRDVyWG5qZVlTSXpIOTY5?=
 =?utf-8?B?MnEwSEpUQlExckxVQksrTmVqdTIrMlRkcWd6TlRHVTBzRU0vMkxmakVMK3Zr?=
 =?utf-8?B?akt3NXlNbXlOemd4bXBrOWN0U2RwOUR2M0Y0MFBIQjJnaUdQMTBQYU1QcW5u?=
 =?utf-8?B?alMyRzRaNFpqZ1JGYWhNd2VzZS9GVHRtRVgwN0t0VmZ5N3BWUGg5Zml0U1VQ?=
 =?utf-8?B?M3UxR3dteWtXaTE0U2dTU2VPSUNFUCtGeDliVzJHSGxWVi9WU28vVnVROEJ1?=
 =?utf-8?B?SmlJZUZLTTJUZG5JYmlhR1ZxS1ZZaUJaZzBzRDNMbGlwcmVnK3BEVm9OZEYx?=
 =?utf-8?B?L3B6a0tSbjZwcUpDaEVnUitwTlFIUFhGRmV6dCtEWkFEak1sMDBheUh6MGFX?=
 =?utf-8?B?VHl2S20vTHJFd3YyMFMxSExSemFZMi8vUndlZHFocG9xUmRRUVU4SWRKYkFN?=
 =?utf-8?Q?NmD1OvYdBeaWbZwgMCHil8qGW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a83c99-cd2b-434e-eba9-08dd460da7a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:02.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t9SNelPSeMR4XFVjRk63fVTqbqqQnpmsFfBPXrMWFgkshBCFGRbaScr5bU+7kQvjOD4Qwvcy7bh/lWlWXMaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> Instead of setting a fixed floor at lowest_nonlinear_perf, use the
> min_limit_perf value, so that it gives the user the freedom to lower the
> floor further.
> 
> There are two minimum frequency/perf limits that we need to consider in
> the adjust_perf callback. One provided by schedutil i.e. the sg_cpu->bw_min
> value passed in _min_perf arg, another is the effective value of
> min_freq_qos request that is updated in cpudata->min_limit_perf. Modify the
> code to use the bigger of these two values.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this for 6.15.

> ---
>   drivers/cpufreq/amd-pstate.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9dc3933bc326..a23fb78a442b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -672,7 +672,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   				   unsigned long capacity)
>   {
>   	unsigned long max_perf, min_perf, des_perf,
> -		      cap_perf, lowest_nonlinear_perf;
> +		      cap_perf, min_limit_perf;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   
> @@ -684,20 +684,20 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>   		amd_pstate_update_min_max_limit(policy);
>   
> -
>   	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
>   
>   	des_perf = cap_perf;
>   	if (target_perf < capacity)
>   		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
>   
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
>   	if (_min_perf < capacity)
>   		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
> +	else
> +		min_perf = cap_perf;
>   
> -	if (min_perf < lowest_nonlinear_perf)
> -		min_perf = lowest_nonlinear_perf;
> +	if (min_perf < min_limit_perf)
> +		min_perf = min_limit_perf;
>   
>   	max_perf = cpudata->max_limit_perf;
>   	if (max_perf < min_perf)


