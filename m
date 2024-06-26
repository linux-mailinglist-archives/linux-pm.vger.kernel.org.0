Return-Path: <linux-pm+bounces-10067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F70918E24
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7571B20978
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636A190471;
	Wed, 26 Jun 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IeQWLs5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE619190045;
	Wed, 26 Jun 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426007; cv=fail; b=h/Pq+xyR6ds5IYZwtyu/6Tw3cec8L7uv16iITvx+cvE3WCO1ZBiZffzGN/UMUQ7K3WuZC02JJX6X/mf6+j0QRf+LKKfHhDC/atGZuzIiFZ8d2BFkgp1EeC++UWHcNERgreI55X6duGkv0lSVpWJfvJ0SoloCwW1hhYN3C7sRjCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426007; c=relaxed/simple;
	bh=bcqXoUNQ9GKf2T8gAcyGSVrInFWW5wI0ZCGpSrwdER4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEZYZrwoku+6PLrBYIfYzHdMlrGJBmYvVSl11oQF01F7ANJgcRZkdTjgBHuoZakZFOe/oToWPZqEej8NhNYM44JveMvD8ITGCuoQvenNS0iB+7Gkqa6MlbDeA3Up4QHjQJQWAQZIh9QpfYt8GMAuTgMwkyVrl/yxUnveIfq01rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IeQWLs5G; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dvue+8flryOoFETo6Rky0T4klk+vQdtZPOSu0vxfFzUq6xM0yHv406KHcNtq6DrZ9xWaPKQxl6BTuwoYhDvQiAcAsRGOxTnUwhIpFRgnm/+CqoVfblXRUXdw6UCd/w6mDaI8qD/4g51IGZQry29nkvKKmRpoEX4wiXgMjshEbmKf1yGd4zZxRinIVQ4ttN1BAAEAhjLFad5Asp1qQAP0QDXhwhUhv/x8X6J9tZqj3A5D1ksQeZZpS6tYTsWz2QLzkTs9vSPYx1VeLOeHvzQdD042WQ238dH1frgH8viqd5vVHBvFCyRccqVwI/EZdnpfNvE5JbxUV5bXxKVRwLCFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzetPGzB0I8/2Z727kPrm0iOCxZ6hYboNLK1tK0I7DI=;
 b=IFWSa+mol/bjIehDpqTb2jtrB4hwyEeC6iOI5CPFIvnjQbOE6SBPpAGuBPyvnlvYWxL37d//Lp4hcm+wpYVnL0mfUKHWqlTHVLzMNPZ5r+tJ7oeQeTLouraFdtgcCDLbBofGSq6EXAVvpPAmZmdVYUPjMOCsWNNC5KouHBAcWsOnJjzC8Fncdeq7tFrJsSMviSf+Sv4wzi2QWsv+mch+M2/Y1LPSn/LEuso4x2wAhBeS9JijSvS1W/82vDBGnEf6k38JqV7dpIk4hfeKFFp83poOOt1V0a7R5qRGvTb3azpIt1jFeb2eiO19qd+QTPEf2sKui7ldcKXaEf7MQTC0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzetPGzB0I8/2Z727kPrm0iOCxZ6hYboNLK1tK0I7DI=;
 b=IeQWLs5GBSx4aabV7rxPFQXSLNe9UBOctdt3IAL8CWtIHk3iIJpPntF60uiypL38Vt+nxP35GCqp+GhncyATVlwFNuL4MZaCvz8s/qWyOnQXMSgj9XvSxcKmdg5zD4TG+gUiVvtrCwaeU4V1a2ynCHgo2YOtPKtCM8J0Vx5Z3K0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 18:19:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:19:59 +0000
Message-ID: <f5251cea-32f2-426d-b3c8-73ce4c562fac@amd.com>
Date: Wed, 26 Jun 2024 13:19:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq: amd-pstate: Use amd_get_highest_perf() to
 lookup perf values
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
 <20240626042043.2410-3-mario.limonciello@amd.com>
 <20240626171809.GSZnxNUd4tcRT4IB_k@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626171809.GSZnxNUd4tcRT4IB_k@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:806:127::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: bb18c513-834c-4522-09bd-08dc960c96a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNnTjdwcGVoY255ZTdjQzNJcnhvNzQwc3RkVStmdzIrSkpNQXdXM2M0S01w?=
 =?utf-8?B?UmdRQWFicGxsdUNWMThYVFNEODVYbHZpZ1NCaU5RNlhKVHBubTRiZVJBREVu?=
 =?utf-8?B?U2VTa0ZFR1NmbHlCVWJQZStxS2dpbWlYQWpWSWFPZnR0WDZUT1haVFZPdURN?=
 =?utf-8?B?eXVsckhBYWF4N00xM2FiN1FVVlM5dkh0Tzh4UzBMRWU3Q1JVblQ1bkszM2Vw?=
 =?utf-8?B?d3REMFlkN1hnOEFjS1RTV0ZrSTNNUkQySXNmQy9haWNoeDZ5RUEweUp4UjN3?=
 =?utf-8?B?SWtNclNoMjN3Skg4RUFRa3ByNWdIQWRjRUNESGtRTHMvRkJ1N3RxYVQ2Vnox?=
 =?utf-8?B?MzlKTVY5aWdhVXVFYmllZks3TVVSVWhxRGUxNWV6U3hWNk00amk3aDNZS2Jm?=
 =?utf-8?B?L2kxSlVnbW1PM0NSMTU0ekZwRFNMVFVKamtQR09SaUlPYnVFKzZXSmhDNVdz?=
 =?utf-8?B?K0REYWxzbGVKZ0NVcXlqZk1OdXFkUFZtazVKa01UcUdwUjZEM2F3WHJoVmI2?=
 =?utf-8?B?eVZZVTRkbFEzRnh6KzVlby9FaU9heTNmQy82WUtyVUVVU2VST3ZuSy9BV3h5?=
 =?utf-8?B?Q3dBMFU3YXhnMlR4YlJaMVc1eDIxek1vV2lwRS84ekltYXI5dGxVUXRHTVNO?=
 =?utf-8?B?ejBqS0tBeE53ME1kWkFxTXlZMyt0KzhRdSt5TWxmUStVemVTTVQ0RThrZ2xa?=
 =?utf-8?B?Qko4SXl4Um1rZHNGcjllQW53K01Tc1pOdXNxVzJKNk5lYUtkT0FLNGpPOUpT?=
 =?utf-8?B?WG5RZ0lPcWI0RUV1Z2U3WkxXc2ZMbjBwaStGTU14VW5TYy9JRE94UTFka09F?=
 =?utf-8?B?dlVlYndQeHp2ams2SG9GVDlmVGpYZHRMdU5PNU1DZmtnSDIyRlV1aWk0c0tF?=
 =?utf-8?B?L01XcXd2eFAvYVdadlo0ZG8zcDJ5T2NaTzh0ZWI1SkE5c1ZZYmlESGgyR3N5?=
 =?utf-8?B?TDc4WEhMRU9YUk1Nb09OZy9qZlppcTU4eW9yZVp3RjVBdWkrUUxHR2JJSnRh?=
 =?utf-8?B?cTZmOStSN0ZuRjJvTk5jVlpLNkJtTGh4aDZrdUl1cXNYMmM5Y2RIYTY0R1J0?=
 =?utf-8?B?ZllpUDVaNUNPTlNBOGk3NUJSVVcxWlFRWHRObW1SeFd0OFRJa21xa3QySS83?=
 =?utf-8?B?Ry9UWmNRMno2NHh4Zk9jaXpIdzRLTEU5dUErT1htSEdQNzZETU9vejFTM3l5?=
 =?utf-8?B?dXVzZXU2S3NvUytWa29VVm55Z0tpT1pSTVpyUkRwK2J4SHFHQkNBenhmTVJp?=
 =?utf-8?B?RFArMnd5YWUyVExsV29EZG44bW45K25rZW5lRXJ5azU3OFBRNFpqYWVFQ1hF?=
 =?utf-8?B?YUNVTVNvcEgvYTVoQWlFbXNzalRZNmdGK3lUVjkrdTJSOStsOGNRVHNTbWtk?=
 =?utf-8?B?dVg0aFlnZmE1blpOU0tFRHpXdGpTTkpQaE1UVVFDalozN3kxdy83VmhIWDVU?=
 =?utf-8?B?TWZNM0NrWWtvR0dYdTJybzUwcllQRlUrUWlmbk9mQkRYaTRiT2Q4ZEN6WmFs?=
 =?utf-8?B?cDI3bmZlWDBXV2JtbFFUUThuVTdWNlVHNFNCT0haQ2dFRkVZQURLcVRuUVNY?=
 =?utf-8?B?RllobUFZSlFBeFpEdXludi8rcTJ4L1NXRi9kc01DWXQycnRHaUJOb08rVS9R?=
 =?utf-8?B?eCt3SEIxZFhNNW93SzdhUHFhbG1YbzJFWTl0UDB1MjZWdE9aN2JIOVZxTHQ2?=
 =?utf-8?Q?PMzyl1FiKEDatSdu+hgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzhESTlMQWJWWHhoTnhLRHhabnUreU9oazZyMFZYVmhWY285MUtZWTBmUU96?=
 =?utf-8?B?VmlqbVFRR3pVK0VXcVJYaUlPdDNtK2ZBT2tiTm1rdTk4ZGtuaHBwUVl0WXJL?=
 =?utf-8?B?d1VMSnNBcFVwWU94MmlhSjNzbUVYanJOTVlpZm9mTXRvZ2NBdWRPSld3UXA2?=
 =?utf-8?B?VEJ5TXlxbWExMUNRRHFNOFZScDk4NFg4ZTArOWNMeStKNmJxbkFQSkFkVnJM?=
 =?utf-8?B?eUwvdzlmbnBuSmx3K2N5L3VzamdyZU5JYmd4WTUzY2dYaFhaOVl0b3NsNWJI?=
 =?utf-8?B?LzlBclBod1NWb3FTRWo1eGdmY3ZRbkoyUXJsUFU3N1dvNTd3NWdBV1Vya1V3?=
 =?utf-8?B?cEFvbVJuVlNrUnl4dFhOT2pPQ0RiVHl0UmlQSDRMVUpESUpuZnllYWtNMnd5?=
 =?utf-8?B?V0NicTVoOTVMT3BFTHBrSFRtNzVFbjVmTEVJRUZvbFN3MzdUb0FCQnJNVGI4?=
 =?utf-8?B?eXZQd0g2VzdocEZwZGtFdy9nTlZkQlQzZWx5SC90NXpVMW40bExTcmFlT1Za?=
 =?utf-8?B?M2h4SnRUNWZ0NEM2U2RzZk5qWGhmU2ZGa1ZSd2ltM1g5ZkJzcFNGQktDeHh4?=
 =?utf-8?B?bmdwR2NoSmNFcC9IMFcybUYvRFlvZFQwNnprSmlpV1dpa1NVdk1XYXRiTHdG?=
 =?utf-8?B?SjRLb1ZKT1RaT0ZXTkJPNkYyazczaXRtZlB4eE5wbmU1OE9GdGRzZXFGNkZ5?=
 =?utf-8?B?VGFsL2ZyZVdDREcwU0k3NXdlQXoySEZzeVRhVkxwVEx5NHI2N1hETVBGV1o5?=
 =?utf-8?B?bmNubmR0TGE4YTdvZ1VpWkttenV5RnQrQkx4R3UrUE5YaTQwSVY1Q2tHbmh6?=
 =?utf-8?B?bjdmOEtQMngwajd0eUc4SEx2SVVzSE9pMjJlRTN3dHZMM2pweVlCdUV1cHZu?=
 =?utf-8?B?bVpsbGV4YzcybWtzNm1heE5UamNPSEF6dUhDR2RoRGx0YTFpVWpOQjZUMGdq?=
 =?utf-8?B?TnhIQXZBdW5yQ2hoa1o5a0JwNHRyQ1hYbWd5UjA3NU04eHcxSnh2NG53cDV0?=
 =?utf-8?B?Q1k2aFFpaVpCYVQzRFp4S3JvRTJGZ2cvallUbmJneEFZNTVyL3l1Z0FidW5m?=
 =?utf-8?B?cTBVUHl2anVrRjYyRzNUeGd5elFhZm9CLy9OWnlDYmozcVdKc0hOSTl1WDZP?=
 =?utf-8?B?Q3Y5M0dVVlVrdnUxRTFpN25RaTk3R2VoL1lON1UwK2c0VUttQU1FczZxN3VS?=
 =?utf-8?B?TXhFZi8wTVRSaGxtZTltRFRvUjFLb1BDeDREQWQ3MDlGSUpOeWdtblRETDZt?=
 =?utf-8?B?b0ZYYUpPY0VkaHJiNk9aMGJlNU1Cc2RCbEZuck1xczVCY2hVUnI0TDR4bXVZ?=
 =?utf-8?B?S0ZQYzhNUzZXQWpteFBPVno0dTVkSTA0Y1pNODNhUThmZFdKbVVaQ2UrNG1S?=
 =?utf-8?B?K211Z1NTencyUmkxMmlkWC9wY0JKMzU0YzI3MndGU3ZLRnpaSENsN0RoYXhl?=
 =?utf-8?B?dUZlTUQyN1ZxWXZlREV4TmJ6Q2t1ZThWUkdSU3hid0dxSEMzQmg5eEJWb2M0?=
 =?utf-8?B?K0ZWcEViODRrdTFYcm93OFd5Q29wNGdwaFhMUUhpOWZGd2RLOGxvS09vS0lB?=
 =?utf-8?B?dzlFOWpLTGl6UFFwYlAvRTM5a0JYYkM4MlN0UXpXYzJVd3NpUXBMMTFNYm1q?=
 =?utf-8?B?OFVncnlrcmN1M3NRa3lkenIyUFNGVmFVN0hBcHFicThxUXdHSG9FVTY2ZVh4?=
 =?utf-8?B?aWZvOFJUTHZDbUR6N3puMzFWZXdYYklnQnduZFIxVGZBck5rdkVoZzAyTzVm?=
 =?utf-8?B?WFFjTFdTbjRmNW54K0tpWGhORUlQMmp4Nm4xS2YxWDM2YU5jSVVTc3ZXSHNK?=
 =?utf-8?B?OE5LZVV4MmhESFluTTFwZERVd1dQOTdQQUQ5NU1tV2tPc2hzL3BvbzBKeE1M?=
 =?utf-8?B?UlcwUG9BVmdTVjZhbkczY0l6ZndpZ1o4NkR6MnRRTm05NmpmSHJqM28ydlFy?=
 =?utf-8?B?S1NQbzcxLzRNNGtYMXB5UUZIR0JjUi80TENNOTFRZUpyeEZCRnExR1ZaTkx2?=
 =?utf-8?B?TXZQZkNDM2hHVFpReHRVK25Sdkh0OUZ2WWpGUVVjL05rbWJkalRMUG8yMFJX?=
 =?utf-8?B?REJNb2F1RCtYblo1a3RnY3hyNHVJeTFZdkZSaDZ1QUdaRU1IdVM5NFlwZ0dO?=
 =?utf-8?Q?btlDsmvS/xOGX1VskRyJ3WMaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb18c513-834c-4522-09bd-08dc960c96a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:19:59.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y36RZ0PZUtoJsdjvY32UM1G4+mQX5JUmC17ndhcvwBmReKcaAtXbObG4joAog0PxeO/5uwj9YY6NbTcwB339Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

On 6/26/2024 12:18, Borislav Petkov wrote:
> On Tue, Jun 25, 2024 at 11:20:43PM -0500, Mario Limonciello wrote:
>> +	/*
>> +	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>> +	 * the highest performance level is set to 196.
>> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
>> +	 */
>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>> +		switch (c->x86_model) {
>> +		case 0x70 ... 0x7f:
> 
> Aha, so here it is non-inclusive - "<" and not "<=".
> 
> So you need to check the model ranges first.
> 
>> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
>> +		default:
>> +			return CPPC_HIGHEST_PERF_DEFAULT;
> 
> As for patch 1.
> 
>> +		}
>> +	}
>> +
>> +	return CPPC_HIGHEST_PERF_DEFAULT;
>>   }
>>   EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>>   
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 80eaa58f1405..f468d8562e17 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -52,8 +52,6 @@
>>   #define AMD_PSTATE_TRANSITION_LATENCY	20000
>>   #define AMD_PSTATE_TRANSITION_DELAY	1000
>>   #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
>> -#define CPPC_HIGHEST_PERF_PERFORMANCE	196
>> -#define CPPC_HIGHEST_PERF_DEFAULT	166
>>   
>>   #define AMD_CPPC_EPP_PERFORMANCE		0x00
>>   #define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
> 
> This already doesn't apply:
> 
> checking file arch/x86/kernel/cpu/amd.c
> checking file drivers/cpufreq/amd-pstate.c
> Hunk #1 FAILED at 52.
> 

I was thinking we would take this patch through superm1/linux-next or 
linux-pm/linux-next as there is other amd-pstate stuff for the next 
merge window, but if you'd rather go through x86 then we can wait until 
after the merge window on this series.

