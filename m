Return-Path: <linux-pm+bounces-30510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BB6AFF21D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C0D5A5B7D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D502417D4;
	Wed,  9 Jul 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U1TaioFm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933391FF5E3;
	Wed,  9 Jul 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091106; cv=fail; b=txRloF0QbEBCBp7HkJH+72bkZp+dU80jUa+ExboIC7oG/gF194VQJLezxqCgp3wrig7aOJnif+SmVAbH/W2pAbPmsY7aq2DgQFu0DezP1Ckz3qxHqYot3alc72Hl/u7TRqI5G2nLKK24/XDJ7TZYus85NjtjwWcMeUlaM2CanS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091106; c=relaxed/simple;
	bh=2GXgJsNkk7oDRZIzxltkodYIgXWOMUcF4oYl00NIicg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nz5nz+ZeKduGM9Gd9J6TAXMUlRwbjoihmLXn/l3tSY4GxuT/zDlQp8uwWA+q+lK9nUTiuarLZYmFOTcNwnO99hV/HpZWOQZy8EKoIIH053dIwhcfdhijx2L20n8HiMXLaHAygNxMjyy0UfakI1GAg8Jwn0+wrvNP/hVwGCYgfkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U1TaioFm; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQpp0xNg55fm6FMdq+E4htXUrjuPwVJJi30B5PmSrPXUpsRMNovhOz0XpD8/fQuvHK5PQ2xjSZUpBQ9qJYj3o8uXbttrYWOf5ZHp1V/ZSbR6YdDDY40rdHwgP3iQIn0JI37dn8IIX4TTO4ytlK9S6rFKyD+4WMxbbfrci1h/h4+b6K2hl0kH6RfE41KvJYAgCYs/cY2juG547E03vn34HYuJrMGgUO/3YcHkBjTkzS2JhfrgWCcbVQkFC2R/7r36ai0Fq9or5QrGrBXTKRSTg4dcr0FUvE2zkUqj1LRiAPQTGPeCSXWgnKxiFB2DauBQoEEC0VzhxSXdUMk6QK5jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+ogCmx/yQYLiJlIr2IXtwXrZWeDW7GcwbyjYOS8aDA=;
 b=mp5Qn8ijQA2mV5wfObztB8Ckv/CB5NRUBQLXQyiY9dyZbcippblSBmgG1iwYBhcs0/I00O2LvBPxgD7bE4E+dKQAeDsrNaylW8qEi3GHdjSixn+229fpvlTeq8VC1hetuvPvwaP6yuFsuGK0UaywPF7VeYaPqcoQ5O0Erw7SKRr4HfuGuysdB9nxq8yataMqhzqv554cCxy13x2eX03USQ7ERusBcBtWH02lmhmP8XYQcq0Rlp6ScleHPtvoCcdug/zp9eK313SdbtMNUIVCvXmzZW/H7osRFdpLTW/t7/N1cxGmFZ9sqS36OXnhACPY26E26qyPVOAoFChQUByXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+ogCmx/yQYLiJlIr2IXtwXrZWeDW7GcwbyjYOS8aDA=;
 b=U1TaioFmDormJrXgMnvvP8CjBAC9DAEcq+r6OzY2jhWsajmbOSOXC84HV7/FP0U9fPhE/UWhk8D5t2lGwGgrF+DAfItCExnari1d8Pt5SX8NRu3veag8SuOCdNWUHnp0N4EISBZbJb+hsp9tUlp9J9b5YjlVDmCdIO6cc4jP5Is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 19:58:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 19:58:20 +0000
Message-ID: <21c6f554-fbbf-4856-823f-f58c9956f8ef@amd.com>
Date: Wed, 9 Jul 2025 15:58:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Call pm_restore_gfp_mask() after
 dpm_resume()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <2797018.mvXUDI8C0e@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2797018.mvXUDI8C0e@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e14a9d-42dc-45e5-8488-08ddbf22f436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3pOZGhOSTFmQnFCUW81bmUyQkFGTWJHaHdVV3phUm9aRDBuK0ZYL0s0UjRK?=
 =?utf-8?B?eXlBMWszQWtpVmZzY0lldGhCSWNLYmlyOW0xYTBFWmUxSU12K2RKWkJobHVp?=
 =?utf-8?B?cGcvYlVCNmdzNG5MbTdxNm1OMnduaE1QZ3RLL2M4WENwWkpQS3RVREswL2pm?=
 =?utf-8?B?UkRWaHRZSTg5enRSMEgvZmxnVWZWZ3Q2aG4yZCtDU0NDVEdGL081TWVUVXha?=
 =?utf-8?B?Nkl0blBHcWZvUk9aN3JxM2U3K3JuaDJKS2VsaTNtR3Jhc3Q1RXR1QUdOUzVw?=
 =?utf-8?B?UWZKVE1UckhYWUcvQ004K2haaW91a045UVZFMDVXVEhqSzhwem9OYXFhU2ZG?=
 =?utf-8?B?eDdvdTZXeHdtSjRDMUlzMWlXd20vakc0NkVhWmhNQ3A0MWNwblR1ZWdrWHJJ?=
 =?utf-8?B?OGdPUGl3Y1pocmhMdGtBbHhyT2dyd3JLbnE3OVJSMk8xc1BIU2trVkIyMFQz?=
 =?utf-8?B?bWl0SjhBMmhIMTlJT0NsL1JxRVZ3NnhMd3R4RUMwU1AyUVcvVDBscktTclhy?=
 =?utf-8?B?UExUZmpLVzY1YlhBOHVkNVZpdXdlMk9JYjdhVldOb2RIS0M2TGxTSjBvN21V?=
 =?utf-8?B?dmlIcWpuYnN1T2hISFZzL25EbmdVbzEwMlBiZzh2M1M1QldnRUpJMUwxNzBJ?=
 =?utf-8?B?QWZLZnpMS3N6SHlvaFFOSXRJRGVLVzZuZmpiaUZsOU9TbXQ2TExXRUdtV2dO?=
 =?utf-8?B?U2dkbW9vdFZCOE5KU05LNVlmQWsvMGtML0paV0pQUi9uWGNZODF3c1V5Ulk2?=
 =?utf-8?B?MnJRcXRmRzFXNkZRcElEMWZ3ZXNVOXRkaVN6NlhWSTcxZVg0dWJYdjJ3ZVEv?=
 =?utf-8?B?TkQ5ZVpRczB6RFhmVXBlUVUxYTR1bHRuQ1NadURVZ3o1cXZBN3ZqWXB6QkY4?=
 =?utf-8?B?Y2QvcU5tNlZvejJKTDVNa0ZBbHVpSXNjS2Y5dUtneTVBVmo1YkMxaXlPTjZi?=
 =?utf-8?B?YjVQUnhiaDI0cUthd01teHhVTG9WalAvQkNkSW5aUzRZVkk2cFZTRll5SkRx?=
 =?utf-8?B?MUV4YndRcFN5eC9teEpjbVpFd0wxcUo0Mjk3dkdMZm1Rb3dsZGZDTnptdHdZ?=
 =?utf-8?B?TjlvNVhMNU12aVBvVU81enJabzNLczdQR1lUS3J5eWlxbGRuNTM1ZHlBdmhp?=
 =?utf-8?B?VlpyNkpwL3dvcGMzS2VacmVtL083VGpVT0MzdG9ISEg3RGE1ZlhHL3hVRDAx?=
 =?utf-8?B?dzd2bE42SDMrbG0xTkE4dmhHaDdsMnlKaHBhaUJXekJlR3dIdFdVcG8vdHpV?=
 =?utf-8?B?YjlQMVdacUhMWXNEdnVrZHhVRHE2Q1Myd1FIMGZMODlZMmo1c2RCYjRQQzRJ?=
 =?utf-8?B?cGtCVUdTZGExMHJ4V2JjclZVOCtUQ0E1RmhleHZPTm9LYlV1ZTZ2RnBTdUds?=
 =?utf-8?B?aDdEaFZ6NkR2L2ZXdE1rTG92TkozNVVnS0RVOHNzSk9IcVNPMElham1KajhP?=
 =?utf-8?B?ajJzWkxnOTgvQmxFM2w1elhVS0Z3VVlPbWhwcWE1cHJobEc5M05qYTlDOG5E?=
 =?utf-8?B?S2ZOKzJCdVhYRGxCN2ZaN3doQVBHaXZRcnZOMXhIVTRFeWE4ZzJOaTZtZVJE?=
 =?utf-8?B?NFEzVGJtTHM4NkFoaE8xMUVKMkVoZjJCSlhrMTNleHhoOUwyK2U4V1RPbXE4?=
 =?utf-8?B?UVdvYW9HRXQzYSt6Nmk0N1VzUDFZQXFsMlY1K0RpNy9uTzZJQlJxSlNvQUpk?=
 =?utf-8?B?bkx3ektubVd4ODFYR0pWSlNxdjlTTkhqTVpKd1p0QjRscFZ5OTdLMlZKVURj?=
 =?utf-8?B?Q2RHL05SMUZxTmtoaXlXcWltZFRuWFFBR0luRGsrbWczT2U3bWt6ZkJNc3Vj?=
 =?utf-8?B?ZGlvNGhaRVNiSTJvOGRIanRneEVVQSt1VFZRRjZaa0o5SkptcnU2Tm52ZDFG?=
 =?utf-8?B?NmpkbitYaUtqU3Y3dGhlTmhzUUVSZ1R2cit4ZGNBTmVZUEVuRUVsbFJTUkRi?=
 =?utf-8?Q?/xjNXtlzCQU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFpeThwYjdCQmZsSGpwL3ZFd2lNaHNLQ1VXOWRmaHJDRW4yTDFNS2tkR1h1?=
 =?utf-8?B?Mktla0xhbkh0bjl4akQyb3pzY0xWeDYweThVL2taSFRyd0dobGVWNjJHZ2lz?=
 =?utf-8?B?YmE2TEFHdEg5SGxNdWRTdkt3Wk5QWHE4aGk0ZSsvNkkrSzRyTGdhdngvVmpm?=
 =?utf-8?B?eGs5eFdEMkdCRnpPcTN2dU9nVDl6NWEwUTZQSlgzdnZ3M0RpYkVXTWhvVXBD?=
 =?utf-8?B?dHMwQ3QyZEJSVXhtSjFCdDFKUlkxTnpIL0wycjVLdlpDMDFXS0gyM09vOVpB?=
 =?utf-8?B?SEIxR21OcUh3RFA4SWdTOFZqTkptaWFlOVB2dVIzTE1UM0cxU085ZFp6RlJm?=
 =?utf-8?B?cVJkemNENmhWSlJXbWZIUXhzTDdOM1NHQjU1L1RxYko1aFBFL004OW5xK0tm?=
 =?utf-8?B?dU8zNkk4UTd5Tlp5bkd2ZVRvcVdxMTdaUllXdzQ3K2RObEtLVVh5ZnJITzhh?=
 =?utf-8?B?d0ZZVEdhL055emZWdmU2S05mZ0JvaW9TN3h6Zk5tN3Z2ZU11ZlRHWEZiWFc0?=
 =?utf-8?B?eUZQQ3BuRHBJWnRlVGltUDBpMHFITFRtR2VoaFVpVVVYN25GVTdTYzhIeml3?=
 =?utf-8?B?bFJxNjYwQ2NNT1daNXpIS0ZsckE0aFkvOUFRblZXUWcyeHQxOWhaSlV2b1Q0?=
 =?utf-8?B?TGpJa09yUG1HeXU0cVJjK3pOY2xkSS96ZllMc1JOMmE3MjArdGtEajhBR3VS?=
 =?utf-8?B?SDQySXdUajVlc1NBWkROQkd1dFd2bGN6TzkyaFl6YXVUMStCVHplWkNETksx?=
 =?utf-8?B?UzZENkRhWFlUYkU0STdSTGNaVjZSaVNMcmtOYlg1Z2M3ckx5cXNZdVUxY04z?=
 =?utf-8?B?OElDS0lxdnlza3R6ZVFrOHNjSzBNa2hsV3JMeElyMmxseVlSbzdzZjZSTWVZ?=
 =?utf-8?B?bHhkMGROL01paE5CNFE1clhIUUI0SEVYTzVEQ3ZNZWdPMUQvUkdPN3pwYkNQ?=
 =?utf-8?B?YjlqMGdXWjlGRkptc0RFbzNFZ3YyT213T2JjWUcvdjR5dFR2VUpVR3VMRmpM?=
 =?utf-8?B?ZnN2ZU0yWEd3d0hvaTJLNGNxbVNtUEZaY3RQRTFNL3lUdGhCNGd1a0d1R2N3?=
 =?utf-8?B?cXhHRmQvd1cyWlN5NEtlQXhxb0ExUHh5akoyZVFNWEY0UWdOeGdhSWpjYzlJ?=
 =?utf-8?B?d0U1NHV4emRJQ3lDSThNbS9nVHVEU1ZJcG5mT3JUZzk2SHQrZlBFWGg1RTZZ?=
 =?utf-8?B?aGZiVU1hZ0pzRTF6am9JVlo0V2JRREJaVm92NjJaeUhzUG9NRmVjSmRzZHFJ?=
 =?utf-8?B?a3g5TVFGL0pwZEg0YWhLZmFkeFNDTzZXdGxXME55ZmlrOFc5U3VXcGVtYzJH?=
 =?utf-8?B?YW5GZ2JSWHQzbys5Y3lGYlZqbUd6SWZleWt4M0ZrSGFmSUtpOHpXenphL3JS?=
 =?utf-8?B?dlZjZW9XLzhRVFNQTmg2UUU0T0trS3VVQ2tJL2pLM1NnSVhMRUF4VmhJVjlQ?=
 =?utf-8?B?ZnZYaEtZWUh2U1h3S09NUUFoZ0FKRDJHOWhiZG9KNnRkS2x5NW9Yc2tId0xt?=
 =?utf-8?B?TDM3cXhHUkRaZThhQlcva0hWVEZEVThkTmNQTEU5cG5JdVdrTHFnZzZCa2NX?=
 =?utf-8?B?cXplY3JmYkVqbTNRSGt0d0dPRkQxc2ZYc3FFbVd0aWc2VzdGelBwRnRJUUVP?=
 =?utf-8?B?WDFkWFF4VGVxSnBPOXFZUXBxeGw5aUY3U0pRMTVRa0dob0VTV245RE04TEpv?=
 =?utf-8?B?R2tWNW1iQlV4cGd0SEM1TnZlR1FiS09Rc2NDZXI1emZoVzhKZzczbE9oeGgw?=
 =?utf-8?B?RWE2b3ZWN0g0WVlyUkdicFdwVGs1RWVld25jRnpjZ3k3cU9qUFNMcUs5T29D?=
 =?utf-8?B?ek0rcFNsUVM1b1lBbkhXeTJPVmVKVVdrZWF3ODYvRTJDeGk0M2lndTZNOTU3?=
 =?utf-8?B?U09paG5iVUxhV3RYQTJnVkQzMlROM3Fac1NFRHkyRERKZWY0dUxHOWd4aDc1?=
 =?utf-8?B?ZHVVSTdIa01XOVJYKzdIWWdHakp5VkhOSW43MGFDSzV2N05UdStXRGJpQ2I2?=
 =?utf-8?B?UWV5MS9WTndQVGJxZXhVL3FiUzZxOHcxcnpyRXJSOGpGLzgrM3dPL3NsQzVK?=
 =?utf-8?B?SkkyL1ZDQ0tFeW1mNEE1UVI0c0diRVBDQTlreGtNMkhqeTVQQ21XcUt3VG1P?=
 =?utf-8?Q?xvZ+n6ki5INkRxZJN4zWygy73?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e14a9d-42dc-45e5-8488-08ddbf22f436
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:58:20.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNntgilOaVYXWoc7ABRxxB9hswBApTMATMk6uYDCcoM6mdOMQbkZ7Fq7/H2JCfq5WEbjxbhjLvRmxDZbn7s/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

On 7/9/2025 1:12 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 12ffc3b1513e ("PM: Restrict swap use to later in the suspend
> sequence") changed two pm_restore_gfp_mask() calls in enter_state()
> and hibernation_restore() into one pm_restore_gfp_mask() call in
> dpm_resume_end(), but it put that call before the dpm_resume()
> invocation which is too early (some swap-backing devices may not be
> ready at that point).
> 
> Moreover, this code ordering change was not even mentioned in the
> changelog of the commit mentioned above.
> 
> Address this by moving that call after the dpm_resume() one.
> 
> Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/base/power/main.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1254,8 +1254,8 @@
>    */
>   void dpm_resume_end(pm_message_t state)
>   {
> -	pm_restore_gfp_mask();
>   	dpm_resume(state);
> +	pm_restore_gfp_mask();
>   	dpm_complete(state);
>   }
>   EXPORT_SYMBOL_GPL(dpm_resume_end);
> 
> 
> 

Thanks, I looked through the codepaths and I agree with this change. 
Thanks for catching it.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

