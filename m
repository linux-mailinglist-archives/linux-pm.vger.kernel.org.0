Return-Path: <linux-pm+bounces-13425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AD969F18
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA29D1F251F0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925A1CA698;
	Tue,  3 Sep 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZDhjFf/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7424A06
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370355; cv=fail; b=VT11Ru7qnJzJWVG1UDtTxUiUgt53JTiO+eIODrwfKheO4jIIow6b8GYFG64iGkabdT+cvRwTmdwdnI3l+YgANqD9BGzOadh6NroImLl3N2Xu5LB9BYqHDiI66GPoFggObMaS97CgtwOkoJRNXJK7Ewbm5wrFD8ICr7QDqZ9z0gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370355; c=relaxed/simple;
	bh=5hbZAvVC20HiDT+fOzlTWkgmks3lx14MSOlfU5ZbCUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jP9+FdbILsAMd4kQWHTY4SHbY8jMIAmyFFYw6Vqg7GUtmoc9NZSXm6vF0WpGJCj5srHlv4ba1zWO0RNnxHG1MejdbQ6hirZxHWezFFLspeCuquLzxeVulJmjJUZAOclJQaLbHr5EttfATvpJNkaI2VQa25onNSc36Yu/+wathVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZDhjFf/1; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0KxuIOqp7Cs8absQjtB4PvEuE/kohOFiKDjb2qWUd6BnUb2s+VcEt1NIYZlCJJhV4XId0RbuKyVoFWvT+hsYjTE1DgNP8CvULv0Og78kr5dBH11omQ1xJLnkMqWdqZKmB00C7gKm4UbaXxUmQ5uF2G/jJJFQn9Q+XEu3kz/QwAqdC6HLSB2ve8uNC9I2D0ogb28hKAkNaFyTqvUXt/ZFX9WBz+I9Sv+2erY1sAdsm6Ji8zC04Cb4Qy2PriVuxzk9P1C0gtnfU3Ckk5EEH99H5weKGHA86Ylc3sOr1B0+tIaNowNJ8iW/dw+qPM4YVThuJpouM7hyrePnsqacJtSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvOeBdmcUylCemureOVgR26XIEe4tq3LsZTYkc67J0c=;
 b=jFtHWXkB77FdqkcpECeVnQ4dd03mGpxPmrQod9GMkitdotA6dlv0Hmb9bUN56Q4FYuoA+P5pUep/2xJmRO4NbMf1jSKB19IGWOPdU63lF86g2jgq8n5kmewHpReWY7KzuzyD3O/pwgWZiRF827KT6o0o5pbKBBGowquuDO9gx9rwJRXy+lkchWotFPnLkczLyT9kfppmPLZ/E2OnLaZ8D1zZg8y7V0nUlQ1p5+mToZdXrv/6jfoKP4LoqVnbNdcgUkAji4hZlsjtwJ37qAEH7e7Abwc63/jZFIi/cULSn2H7hjUrBWEwjgjCMpy7ZD0uBUKsjFvz7oJ3MJWLrfAHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvOeBdmcUylCemureOVgR26XIEe4tq3LsZTYkc67J0c=;
 b=ZDhjFf/1G2RVXuAeCVy94Ij7JsxF4BCtqUV32XX0gh3cnVjYAjmaMLlrkgeS9nT5SvudimLn8TTYoWEcRnG3e0UgGXBPQedqzYsGKS/9/vwnlMs4HDCQ53aBun9WxyJXwkgWP6xa/BXWOdqn+i4iv8CkhK9axjqtZAbUXwG9fTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:32:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:32:30 +0000
Message-ID: <365cb75f-4d47-4e77-a202-ddb171f92004@amd.com>
Date: Tue, 3 Sep 2024 08:32:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amd-pstate-epp: CPU freq never hits minimum level booted into
 OpenWrt but does under Arch
To: "Yuan, Perry" <Perry.Yuan@amd.com>, John <therealgraysky@proton.me>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
 <CYYPR12MB86554E10C5F1A155B7F049F79C932@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CYYPR12MB86554E10C5F1A155B7F049F79C932@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:805:66::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: fe85ac0e-70e1-4925-cfe1-08dccc1cdc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZUdlVHdHBaWVVnSTFTQzArOUJ4MkNnN2pSZ1RGbG14SFJlMmxNR2ZCcHd0?=
 =?utf-8?B?NGViZkNsbTBOSjNQRWFvWE1RQ3hMSFB2VFg2azl2eHljaDh1NjhkcEFDQTNW?=
 =?utf-8?B?bWpRVEFuN2FvYUNRY21keCtpLzhxcGQ2dDV2aHVIckxmZUU5bXRXVmtVSjdm?=
 =?utf-8?B?cFFLZDRMRUNlM3Bkb0R4QzZXMWVGb0hmdlhUWjlhSG9ZeGQ1ekxhMjF0U1pL?=
 =?utf-8?B?TkNWR1BpalIwUVFuVFh1aDlRTWErNWF4T0dmZnFTVXBTYUFNdFJ4Q3RvUWhz?=
 =?utf-8?B?UjhDeEdUYVVrbkg1S3pLS1RsNHBXMlhJV1NFV3RDOXNHdGxnVnJWa1ZsSGFu?=
 =?utf-8?B?RmN4YUU0a3RNTlQ5bWhJM0VIdTBZZlFlU2ljZWtNOXFkRmVNeitOWE5VK3hO?=
 =?utf-8?B?OVZCeHZ1T25CbUxhZnAvK01pMXUzNXVvUHRLb1h0TEROOHBlL2RWb0NSTDFq?=
 =?utf-8?B?ZGtNVWpTNVo3UW4vRTNzcVdxd2ZjeWxBVTdDK3RWZTBCWE1KOVFhaXp1c1lk?=
 =?utf-8?B?T3ArN1drSWFpQjVtejFuUUtLbGdadmovNVBEeTdkVVFsQm45OFBVQTFmNXN6?=
 =?utf-8?B?UTBuaC9OWU53WHBZNm9OZHAzN0RiMlVYNXJ2KzROSEFha2JMT2dvemoyYXQ2?=
 =?utf-8?B?TWJyekY4Y0c5dFRzYVB6d3JUbC90OVZWWVhlamRYQ2pzeVppTVhmT0ppelJC?=
 =?utf-8?B?dWM1cTRuaTVoZlVmUjJ6Zk5COEF2M3lZZmQ1amdvcG1xY3pvQzRJd25zU3kv?=
 =?utf-8?B?TzZkTVptY2cvMGdwcmttNFFXVGJNOU10dHoxZS9TNUlqa1hkenV4Z3ZGK3ZZ?=
 =?utf-8?B?VVBmTi8wRmFsUnRxL0txWkNaeGNEYVFodUVhZm5tblQxLzhoSndtaSs4ZGFW?=
 =?utf-8?B?VXFCYjF0b1c2c2tieG5oUzB0RUEyZ2Vkdm5seVV3Z1NHbklleXdNR1REc0hU?=
 =?utf-8?B?Nkl3czd4WWhESlU5Z2R5cjZsZVJ5aUZmbnNLNDFLTEJHQURmZCsxNy8rYmJh?=
 =?utf-8?B?WXJ3bEROZXJVK21SM1h0VEszVzNjRUF1LzRzOFp6ZW5MdG5pUVpwNmp4Nzc2?=
 =?utf-8?B?QkJBcE8ySGlqazVJVGNTQVc0dWg0MUlyNWFvRmJTZWFoWFlxZlI2TGNYbjgx?=
 =?utf-8?B?YlQxV2tYRFB1dE90SXloT3hZUG5aR3ZZSTc2U2xqaVN6eHlKbksrWWxYK3N5?=
 =?utf-8?B?VFgyZGZHaFlUaVQyWXE1QUJPL2FYRGZOOXFPZkpoZE11RkRESVdWNmtRRTFz?=
 =?utf-8?B?Ykg4b0NQd3VERUdrQ0pRWGU4N2lub3VUMGRQdGl6aklUbXJpM0dKcFk1VkhH?=
 =?utf-8?B?Zk1pTTlHbGJKYjlzSmxiMkpkU29ZYVQ2QndCa0FBQVlUTkRCbElBKzBZbHhM?=
 =?utf-8?B?VkNaekVEZmRFTVJXY2J3SDlKeERzWnpoa2ppQ29vTmhRWi9DV1lKbTVKTmVX?=
 =?utf-8?B?d1IyNS9MMUViQWlObnVCajBIU0J2Wjg3WWcyeW1nZFFlL1FJSXp5bG9QeUNh?=
 =?utf-8?B?QnFsSkhnWUlJK0xqUWpQS2dJRHNLZXBUSzBVd3RVRnQ4ZmpaQTFyazAwdnRs?=
 =?utf-8?B?UzlNNzNaVXdFaFJpUUhxTWxPS090LzFHc213YWVDd2gxQTlod1pUVThzNXE2?=
 =?utf-8?B?RGNVbCtMS3NjOHJYR2VxNUFxY21GNS9lTGpTVzR5QlYwT3pNVXdlZVBiWlN2?=
 =?utf-8?B?Z2hUZ2tjWXJBZXVRUHdxMi9OeWxMNUZxVjFITW5RZVdhT0ttZjlBd2N1dmFH?=
 =?utf-8?B?SUZsMUV2Q3ZPaDJTQTBzaGE3clRPVEtHckg2QUdUdWFXcDFNTFd0Mys3ZmF1?=
 =?utf-8?B?QkZpcEI2bzczVnNvSC9WZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZ2YzRaRjRSUERHdldZVWQ2dGF5U1U5VmpsdXdPMVRPRFZmN0hXT1RjRENV?=
 =?utf-8?B?NEgrUmF6bzcvMUsxeEgzQ2dIR2ExMkVlejd6M1hOUlNDMVV6RTRJWEFMc1gx?=
 =?utf-8?B?K3dWTDBQdzZWZzNSRW1BVzJLb3N1NDA4T2FodVlzdWpDRERVZk1rWWxTenUy?=
 =?utf-8?B?ampua1pUL3FlWEdjdmRqWkE5cGE2ekFJYllMN1l2aEswRlY2ZDdMNDduRlQx?=
 =?utf-8?B?VS85Qk9McG8vNFJLMUtYWkpRQ2trT0ptTkVBZVl1YngwRkhWSUZaMzZpd1BM?=
 =?utf-8?B?aHAxa28zVENBbk1SRDA4aUZ2NXltUTJvaHhML2pwTXVib2doVEtsa082RXhs?=
 =?utf-8?B?aFBSdDNBamZVL1RDNjJpcklhdnlWV0xLMVV2b1lab08rUE56WnpmK1V2YmJW?=
 =?utf-8?B?anhSUmxCWjR1QlY1eG9ZZ2ZPNXlLZ2FYaWROK3hXMUVFZHVOc2lTVzRvUm04?=
 =?utf-8?B?VU1ZZndqVDRpbVBhcTBHYzg0d3R0d1FObFRwZURVN3cxMDZQbEg1cmx6UDhR?=
 =?utf-8?B?MHhVd0U5TldWa3M4NnZMaGZqUERaWlNZN0ZoQXAyUS8xNWpFZXo0SGFMOUtE?=
 =?utf-8?B?S1VlQ3huWWI5YmlWN294QS9ibG0rc1pQeExQcEJJenlrSlRTY1VPYWhJZnBs?=
 =?utf-8?B?eWUwaWlNZXA5WlNYUzBYYnlLT3NJaUpCVjFTVGtKOXhxUE5uWkRhaE9ZbFpp?=
 =?utf-8?B?VmpXUTVNWU5lWWZYV3BubkRvT1h4bHhvQ0ZXNUdUZENQSVl6UkpYYjJwMWdu?=
 =?utf-8?B?WDBGc01jT2tNWS9KRVA2WlhhZlREWjZ6YU1wYVZJRHE3RGhLd2VWa3cxMlcx?=
 =?utf-8?B?RkZkZ0MwdjY0d0d2ZFI3dHcxQ21UM1ErQ2pOVlk5YmlzbmxNdWdUS0hITFdM?=
 =?utf-8?B?T0czbXlCMnk0WGw0NWZMSnViSXN2WDRaMStqYS94czZDWmxwUlZrSzA5R3N4?=
 =?utf-8?B?V3JYTWJGdlIwSXo2TTBac3BJd1dZeXo1M0U5VmlzU0hRNTIyS2M0V0ErR3VQ?=
 =?utf-8?B?WmxoQlgwSjhTcm1BVDE1cmlmT2JxM1VVUTJiRE9UcExLTnZWMU5KSnJoek5z?=
 =?utf-8?B?U2NrcW4yTDQwSm80SlltV1hVSjYxaG9rZnFjNVFtRy8wTTRKNDhzYlVMTDNQ?=
 =?utf-8?B?WXUzdnhWSGM0YzZMV1Iwd0w4c1M4dk9GemtwR253dm1DbEorUFZOK0N2bnZJ?=
 =?utf-8?B?Nzk3QnZaa0RhYUtlNTZaOGswSXNldmFYOHRieTd5aFcxeVBRcjZuOE9UMXNz?=
 =?utf-8?B?V1kwKzFZK0dEdFNXY1N6QnZ3TkZRUWZqRldyNjNLSVdTbHVITWdoenJVYXJ5?=
 =?utf-8?B?ZkFNMEMwYnJDbWNxcDBCL2pHSjVwUXJMZ0p6OXRKL0JTT2lhOXFHa1pCazg2?=
 =?utf-8?B?eFVGTzg5a2p4SmlqdFh0elBUWjZWRzd5N2xsWkd5RGlxWFlmbE40VzlveVh2?=
 =?utf-8?B?aHlOTExqQmZzSm1iZGk5MTdrMXBVU2ZPUFJQVWFnYklOWjk3cWhKZUlQRHpk?=
 =?utf-8?B?Um5hbjg0bDA4ZXowMGhiZHk1enRTUmFZcVJudTloSmRYa05DR0N2UlJwSm9J?=
 =?utf-8?B?L2k2WnZteURUKzZ0ZVhWY0NZaHhZQm8vNFhHcm9nOXlPZEdpRERVUWJtYjAx?=
 =?utf-8?B?cTY3WHNMem10VUoxQVJpbE9HOEdYZFA0MWZJYW5FYnROblF0ZjN0V0tMMUVO?=
 =?utf-8?B?L2puRi9YbW5ERWpjaS9GYzNiMElxeDgvZlVqRkRWYjduTk0xWW5HNllqMVFl?=
 =?utf-8?B?WWg0ZUxsdFNRczBuRitVLzVGRkYrMk1YYVl2SXZFd1pLY1E3SDYxMTYvM3h3?=
 =?utf-8?B?YnI3K0NRenZwRzF1cy90WFN3SHdnUllGNjdCKzg4V2xkaHlqVU9wMU5ad1N6?=
 =?utf-8?B?TzIvU2JkU2RZNXNHTGRnaHhPazVHenlEb1J3bmtaRndVOVlrK25CYVJBaVJL?=
 =?utf-8?B?eWdBaWVDL0xzeFpmUFlRdW5tNmEveEVkbUJHNCtPYUFXb2xCL0JORG5DaGYz?=
 =?utf-8?B?U2I5NTJLa2o4djBralY4ZkQ4bUp3K2V1dGIvQUgxZGU2aTFDK1VWYkVzWjVY?=
 =?utf-8?B?UFFXTXlSMVdtOCtINDJBMFpBSTVNZnhOa0dkeFYrajh3WElnT0QzZXd4RG1Z?=
 =?utf-8?Q?YFr0JqnD5/O875ifXi4ezfDAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe85ac0e-70e1-4925-cfe1-08dccc1cdc01
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:32:30.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzZ5l/lHuiqW8BDWMHQ90azGqoOrczgslgIDaFQHo03EmMWF31HtzpmbRT9VF7e3Qyi0Vax44YDIlzo2yod5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949

Hi John,

My first thought is that you might not be enabling amdgpu in OpenWRT. 
If you don't enable amdgpu on an APU then some IPs in the SoC will 
remain initialized to the firmware defaults.  So I would start with 
checking this.

Something else you could do to confirm it's not a userspace cause is 
compile your arch kernel using your OpenWRT kernel config and confirm it 
replicates or not.

If it's not amdgpu and you can't figure it out I agree with Perry's 
suggestion to open a bug report for us to characterize this.  Please 
attach kernel configs from both so we can do a scripts/diffconfig to 
understand.

Thanks!

On 9/2/2024 21:28, Yuan, Perry wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi John,
> 
> I would like to suggest that you submit a BZ ticket to resolve the issue.
> Loop Mario and Gautham for help.
> 
> 
> Best Regards.
> 
> Perry.
> 
>> -----Original Message-----
>> From: John <therealgraysky@proton.me>
>> Sent: Tuesday, September 3, 2024 3:21 AM
>> To: linux-pm@vger.kernel.org
>> Subject: amd-pstate-epp: CPU freq never hits minimum level booted into
>> OpenWrt but does under Arch
>>
>> I have a mini PC based on an AMD Ryzen 7 5800U APU dual booting Arch
>> Linux and OpenWrt (snapshot).  When booted into Arch, the cores idle at the
>> minimum frequency of 400 MHz with amd-pstate-epp/active.  When I boot
>> into OpenWrt with amd-pstate-epp/active however, the lowest frequency the
>> cores will drop down to is 1,383 MHz.
>>
>> As a test, while booted into OpenWrt, I stopped every running daemon and
>> stopped all network interfaces.  Checking CPU% in htop showed more or less
>> nothing using the CPU that might be keeping it from reaching 400 MHz.
>>
>> The kernel version for both distros are in parity (currently 6.6.48), but do differ
>> in their respective configs.  I am wondering if kernel config options might be to
>> causing this or if there is something else that can be checked.
>>
>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
>> powersave
>> # cat /sys/devices/system/cpu/amd_pstate/status
>> active
>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
>> amd-pstate-epp
> 


