Return-Path: <linux-pm+bounces-39390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4147CB1CF9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 04:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45814301792B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8430E844;
	Wed, 10 Dec 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOdMgjDJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB01EBFF7;
	Wed, 10 Dec 2025 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338148; cv=fail; b=C52e631zqnbyZys3V2NKhpMTwNKFSFwFoCoijL8jJTi1s1XKzC7zhtMrhs305591GQXydusBXFlTliJOUZTnAD5bq4G/0xyBpEFtQhHwNrSnpTRyHCAYhLOaMHlbUqYo1AcAyj9c5/k3q6OCk8LjzoNaqa2vLsu5r0XLLYy46OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338148; c=relaxed/simple;
	bh=sS73po4BuJG4Sp75AaLLvqyHdJl7he9g4QShYE/CdUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wm3KEXTOXa8S31tW+zPQEqHbvC8xdn0JhWIOUQpr1Ng3GzZIJk/A/dqD8rN+OXFpY5MSPX6w9jcdJO8K+OjqM/eORabOdb3jOom43vUJ2cnyOkXHSeSoXE9E2jDR/15TgzUszSJtlsuMwykcNS0UM/C13ACanP8sFfe8KaQ8axQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VOdMgjDJ; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxaBll0it+HaprMuhy475vjq1s1QDxgkCqLXACfNlS2FDa7COFOikgPJibsvmbnJD9empmYcsizXa5DFD1vgFbPOPz7OFTVUWSIU1Kpp8z5lV3vgpxSYe3OIaIPzR4M5M4vIh3dwT84gj9UDWiwJ08Siq9FiPpzdMNc9HrzOx77rIXnKNR6SVN6zch4GhKYAl89huYjVacq+8xoAeeU3Z3Wt0Znm7cwgbimHg1ulZbh2eJ88fPFtJ4bxgtu2HHmjQDIeSUr++8mvfkvSvtS7m7qN6vY9PESmRAx6JzwOXLoISw9Ue9DQwAyj0R+ODF/fDL90EYZsA1tT/JfHwm8Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NamD6gybI78laYypXZWClAv3m2462R7lmU49xR9EchY=;
 b=be4Ilfmh7jtofxHUi9fRSkjdRppC6rXUueJrVsreknXN4uG1rHR0ueNiwJHBySK1/mKcbx7wcpmZoYuh4MedWFkkc1eym97/nDBKXzOu7zEJhu8hSU7WZUYpAPAbILARuRlzbPOsudrBjeo6t45P0yV+hnf8BixrhF6VnfKQ9z8f0bFae1j+QajODoHdBCJYv8Gh/lFpxOBhzdbyBfcpAskaGghaioNyFzU0e53kY2EUKvqAIaY+22IIrnECz9LZpWCLGSzJ79e6kvaMfpqQyjW0sBlsVWFLcEHl7ijNlfIX2fTbS96j4ek4X7uXPX86TDI3nqyg5s5D1iG7In0MBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NamD6gybI78laYypXZWClAv3m2462R7lmU49xR9EchY=;
 b=VOdMgjDJ20mDq0nNIb91vp4FsDV/DC4pPWPCr2FhmO3Su+12tvkxpc9KuVrGRMY3sAaWid+r7ztnKIKo6XanlhWM3QvCB6iScs4oi8g9XPt6glE/blw9dG9ORWSnjps2jhDX2mwz7bU8A39f3jgd7UiuFAIgw6xC8DfXmu4ux4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 03:42:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 03:42:23 +0000
Message-ID: <d06be6c6-f5b7-4259-b76a-20dc52a5ffd3@amd.com>
Date: Tue, 9 Dec 2025 21:42:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] "Wakeup event detected during hibernation"
 on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup
 events during hibernation")
To: Askar Safin <safinaskar@gmail.com>
Cc: chris.feng@mediatek.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 chetan.kumar@mediatek.com, hua.yang@mediatek.com, len.brown@intel.com,
 liang.lu@mediatek.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, pavel@ucw.cz, rafael@kernel.org,
 stable@kernel.org, ting.wang@mediatek.com,
 regressions <regressions@lists.linux.dev>,
 DellClientKernel <Dell.Client.Kernel@dell.com>
References: <20231213083251.186935-1-chris.feng@mediatek.com>
 <20251021125446.4384-1-safinaskar@gmail.com>
 <e27d0392-11c4-4b9e-8ada-9db73f47dddb@amd.com>
 <CAPnZJGB2YAx03piGMLE=wLOQU9-gCpSdFZhBE5iECkDxwzYCFQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAPnZJGB2YAx03piGMLE=wLOQU9-gCpSdFZhBE5iECkDxwzYCFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:f2::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 002bf924-4a39-4c46-19d5-08de379e2153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTF3VEFPR1pUaFBjS0pTK2RhV2hCalZlZiszSXJNTTJmcVJmN3ZMUFpjNHNJ?=
 =?utf-8?B?RS9YYXp4Z0ZsZld1NHQvaHUwaXU4b2xNVGlJaUJiOXd4TWs0R3hzVUN3WVJS?=
 =?utf-8?B?US9aYnFFZlNDa3A4c25vTkFLYzhjM1FrbzFHOUxOQ0hXWVM0ZFR1NjZmbkV5?=
 =?utf-8?B?cElkZlF2ZEpVMnpGU2FxVlBWeTQ3Tk03S1dBZFEwampSZVNPMEg3WnhCTlpz?=
 =?utf-8?B?SndUUWJOekhYZlJKc3VOcU03RHBBNm5CcmZVd1BuSlZxWE9kZkNTM3llUW5I?=
 =?utf-8?B?T1JUVUI0d0JCeVhoeUlGSzdNZlZ0L0YzYTBNUFlIVWYyZFM2Rk9sbWZTZUdD?=
 =?utf-8?B?bjdieFpXWGRtTWlOMEpZRTBDandjN3BSeXN4dUNqTEdVVEJ3UjRSL2lENnNu?=
 =?utf-8?B?ZXBwdWF0YjFidm5SeWQxRnBabTZJdTVVMzM3eFF4TFhURnpkTmRvTjRlNjBJ?=
 =?utf-8?B?MlBWRkEyNEcrTzBBdldiSFZCNWZSSGZFRDJTZDR0ZXNadkJlVG1ad1lNQ0Z0?=
 =?utf-8?B?ZkQveHAxZHEzc0V6SDlsRmY0d1RjQUNESTVpRDBENmRnWFN1Y1pMVlM1Sm9E?=
 =?utf-8?B?S2YrT2w0KzVLa2tHVDZjSm02NGtwNGlEU1psOE1SZWxWM3k1a3RXWk9zb3k2?=
 =?utf-8?B?ZzZFclBnSkhja1dyd25tN3NrbjRqZmFBRjduSmp2R0pwV0MreHQzcEVpTVZp?=
 =?utf-8?B?SkRYVXZ0VVBzVHIwNzVGaGlUa2o3ZE95SFpmZ0ZhMGlkQXJEditNQkV5Wmt5?=
 =?utf-8?B?YVhNZG81Z29CMXJsMHRMOCtzU3Z1Vm5sdFZxek84S0w0SkJjNUUrQkNGZWRh?=
 =?utf-8?B?eE0veklKREh0aXN0ajdxWHNVM1lOWlpSSUkrVktCdXBMWG5aMHd2ZWV5UkZ5?=
 =?utf-8?B?VlhBTlhiSnBFVXJYYldrenl5SUxnS0VvNWtOK2lzMWVoS1B5UmtpVndTTjha?=
 =?utf-8?B?SzNPcnpSY3ljYWdQYnFoN215SFBTeE80ald1TzM0T3k3SkpPZzUxa1BRVUtw?=
 =?utf-8?B?ZnZiaXd2Vis0Y3VOMWhPQVlLWlF4RmRZNFBNYzRDWUIyU0FKS2JSWnQ5YkRt?=
 =?utf-8?B?V281MHY1cm82OUt0UHZ5aGdlSitMd09JZlRkWHFGL05hVG1qYW1uRTMvemFR?=
 =?utf-8?B?RGVnMEdPMURFWEZxL2pEVkgybnlPUC8yN2lLR293N0lEaUFhUFpLZmEvVzk0?=
 =?utf-8?B?aHhaQklLakJVYTZyREhiR3hZR3lVR25sSUNOcWw0RTZWWUs5enhLTGh0Zlp5?=
 =?utf-8?B?SnAxdmZrQ2VXV0lMRktBeW54UHFCZmxRRmo3cGJEN1I4MlR1ZFZydnBObDNM?=
 =?utf-8?B?R0RGYXQ3UnZnUElWbVhRWFZMTmxzUWxENnk4TGdwVWkyaktBMnJOTy8yclUw?=
 =?utf-8?B?RHlwaUdUb2FrMmo1SGZtRTMwMlkwajdmbkRUK2J6NjViaVFscWhhclVEM2tW?=
 =?utf-8?B?UmFTdnhDemxqdFdJMG40R3NqQmF4b1JFUFFZcU40Nk9oekxOaGVadVRqbE40?=
 =?utf-8?B?cll2bnVrblcvS1NtKzF6RDV2MkZKV2RIQlVMeWdoczZMM3lLdkpDYlhiQWJ5?=
 =?utf-8?B?cm1uVWhLOWdiOURnQ2N2dkdoZ09CRzV1Y25Bb3VkR2QzYVJxdU5xVTRhaklN?=
 =?utf-8?B?MTlydXU4WDNnSzRJM1hxQ0JQMytlb3JJMytxK2NmU2dLamp3TzExSHBzdzJ4?=
 =?utf-8?B?bFZrN3BZdjlyMGNDY09lTVI0dUxMK2dockFBNjNTMFR1bkZqRHpDbWx1cmVa?=
 =?utf-8?B?RFJadFV5L0xHaVArcldPWWNROXZoMzJjKzV0Z3l1bDhMY0tjQ0FDdytRSmUw?=
 =?utf-8?B?SkdybVVEKzlEVFhvNTJKeThyRlhiS0V2RGhKclhOcE5hWG9EYTRxcU13M3NI?=
 =?utf-8?B?a1RjSmtLamJHa1UxNGZnMHVhOTJFVDR2YUNocFRrZERuZGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDMyeHBUYTNCUkg2NzFIMEpPbmQxRlZabTlhWHIva1JNUkxQd0c1QkNtUERB?=
 =?utf-8?B?ejMwbnVieDRENGdLS1EyVHZsV0lhaE04bTZiMDJrTU9tcVAvRmdobm1QS3F4?=
 =?utf-8?B?RnRtOGN1aWdNOElnVjB2UGN2L2NZNVI1R2N5UE5XeHVKazQwbUl6dEc3c0gw?=
 =?utf-8?B?WFF6djhiTEFubmY5VGhoeVJNWVVVWkJDZHJiSHkzbW1SUHRYVWRSYktjOGJI?=
 =?utf-8?B?d3Znc2FxVzBsT3lLM2JCMG1YaWh1WVlRM0VqYTJHZ1FGZjk0MTBWZmlMdzZk?=
 =?utf-8?B?c0FXZm9GaGJoZkJVazNDd2czeEdtMDhtMFFEdm1CYVJNNFozKytCNC9heDFq?=
 =?utf-8?B?Snhxd0d0aHhXUnc1RDFNRXl0VzBoY01VeGVlaE9IT3hsdkg5TEwweVFOOE8r?=
 =?utf-8?B?WUU3R1dlNG9COFJySW84QTJDTzBUOXIzbDRvRXhsWXZUdEZKbDVteldBelQv?=
 =?utf-8?B?bk9jdHpINWhFUy8vYmsyUURoTkYxZC9MY2R5TDhlbEphTVVFaHVnZ2YxWGIx?=
 =?utf-8?B?NTkyZktwUWNWcWJDWllBYlRGNkZ4TW1zZHNueUIrUUZvR1NDclBpZkl5Wm9C?=
 =?utf-8?B?MG1XY05BUS9GNXJHYU0rR2lWL1NOeWh1bUJLcXZOalJKUVhwT09wRzhRaVQx?=
 =?utf-8?B?SU1RUTQ0SFJzWW1UQW52bWNhdkZJZVV3VFRGa0dlU2VwbFoxcFNtQTVqSnNT?=
 =?utf-8?B?cUd4Z1drTHVidDRxM2tpVTlJK3dDVHpvUU92MVNzb01JdGNnZjExVkxkdG5w?=
 =?utf-8?B?YnlDbXB1TUxjV2pwTEVSTk9iRGRkWU8rUG02NkJrSzNiL3ZFSnRydk5PYnBt?=
 =?utf-8?B?ZFh0dG5kK1RHV0E2V1BzTDdWa0kzNlJhdG1iOW9Oc1NxcEF5aUFXUGJMdmg2?=
 =?utf-8?B?RmtKTGFXcWhKWndHbm02SFowSmNoRHY1bHhvRi8xN0VDZFJraUcreVVpZVA2?=
 =?utf-8?B?NjUvRFJZSjFOTUJudUhxOHBmZUtXRXBZNzhDUDM3UU5VN0pqNjhJWExOaDZQ?=
 =?utf-8?B?VlJjRTllRXczOUJyb1FEN0hjRGJrOExoUi9COStXamdGVmdKa0tSc0tHdzY3?=
 =?utf-8?B?anc1WFg0d2w1T2hrem1wL25RQVRuekJWUEJhWFZ6NFBjWHFUMll5ZG1MRVFR?=
 =?utf-8?B?T1VkbVZjWTRDaEJCRGxGSGlWQnZBQTZ4UVJGZlJDbWd5eXFRazk4V0luUm9k?=
 =?utf-8?B?RTVOZUgvUjhaZVBSbjhhTjhGcDNtamNGZ044N0xaYlZPSTRDUkxBaEFQbDlp?=
 =?utf-8?B?UVlGVDFTWEpaTlpqMWZlMys5Q3FqRmdXSTluZjVCNGprdFRta1JZK0dXMm5G?=
 =?utf-8?B?MnFKbUF6RGZFYmxCNUNCY25KR2pNQkZIU1lVUGhZbHRZUVhac1B2K0pWZFh1?=
 =?utf-8?B?SEwrNHRkVGZtNWt6OFh2MFcxSi9QZjhaRWpYcUlGYUNVc1Nwa2JybExXczZV?=
 =?utf-8?B?VE5EcDhNci9RYmdPc2daUkp1cnY4VmhzbWh6bzF0elpic1RMYWx6NVVpRVBB?=
 =?utf-8?B?ZTBxcGFiejBoVjRPV1lWaE51aDhYLzM4Q2VHWUhidVdvMC9OM0pzZkJTNWpr?=
 =?utf-8?B?TW1HWExERnYyQ0g1ZmdMeDQ0bWI0dk1xcmNhbTVNN0xjUG5WTmt4UklFYmNN?=
 =?utf-8?B?YWNJcTN0ZFNPQ21EQnh3elJ2QjJzT1RzSWQ5TEdvWmFHRWhENlIya1kvVHp3?=
 =?utf-8?B?eE9oUEFhVmxmd0RJWGJsZHNDeEcrU2pyN20wY293cHY0dmNjNzRaNmdRRGpV?=
 =?utf-8?B?VGZrTUYyOGV6dVFMdkJyL2k1cEVzMnBRVWhrVmtkYzVkUUt4NlpHbFhhMzBw?=
 =?utf-8?B?MW5lMjZnMGNTSnJac2dBR0VsR0FhbEF6U3dPNEVUNlp2TE9kcXdTc05Oa3Ny?=
 =?utf-8?B?RjArcWlEL1haenlxdVRndDhYbFZqdFdiN3E4OTFHQ2YzRlU1RTdLeVlQSith?=
 =?utf-8?B?SG9FdnRPL3p2T1loTVFBUjVvNUVmSzFLektuWGFOTUo4S1hDV2RmeTZGdlZJ?=
 =?utf-8?B?RlhtK3d4QXA1REtBa2gxMzd6VFZtdHJ1UVRJVnpkaGdFWHpwNERZM0dLZ1Va?=
 =?utf-8?B?VUQ1RTNGZVVucW8xb2NYamFGYm5mMjVCYnBmS3hYeWoyRy9DdlRaU2U5Zmox?=
 =?utf-8?Q?gtwR39uOx85qjor1qly6l+XSF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002bf924-4a39-4c46-19d5-08de379e2153
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 03:42:23.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ3jeeqgj7DwfOrZCE6j87vO5z96nXN6rpus40TgC7rfacDT/7057Y0W9wyPhLL8AlS0k693dclx6oFvcRf+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670



On 12/9/2025 12:02 AM, Askar Safin wrote:
> On Tue, Oct 21, 2025 at 5:29 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> To me it sounds like it's potentially the same root cause for the early
>> suspend wakeup as well as the hibernate wakeup.
> 
> Adding "gpiolib_acpi.ignore_wake=VEN_0488:00@355" or
> "gpiolib_acpi.ignore_wake=INTC1085:00@355"
> doesn't fix this bug.
> 
>> Are you closing the lid
>> and putting the laptop in a bag or putting anything on top of it?
> 
> No. I just click "Hibernate" button using touchpad in GUI, and hibernate fails.
> 

Can you try using command line instead in case it's actually the 
touchpad click still being registered?

> I just did some printf-debugging. Results:
> 
> We call
> https://elixir.bootlin.com/linux/v6.18/source/kernel/power/hibernate.c#L870 ,
> it calls
> https://elixir.bootlin.com/linux/v6.18/source/kernel/power/hibernate.c#L723 ,
> it calls
> https://elixir.bootlin.com/linux/v6.18/source/kernel/power/hibernate.c#L636 ,
> it calls dpm_suspend
> https://elixir.bootlin.com/linux/v6.18/source/drivers/base/power/main.c#L2265 ,
> that dpm_suspend returns error, and this error leads to
> "Wakeup event detected during hibernation" message.
> 
> Any further pointers? How to debug?
> 

If you haven't already; turn on /sys/power/pm_debug_messages and 
/sys/power/pm_print_times.

This should help clarify the last functions that are run and any debug 
level PM related messages that are emitted that lead to the failure.

You can also check /sys/power/pm_wakeup_irq after the failure to confirm 
which interrupt woke the system (assuming that was the source of the 
early wakeup event).

