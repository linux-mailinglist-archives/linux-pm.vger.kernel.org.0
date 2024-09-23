Return-Path: <linux-pm+bounces-14585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A097EF4D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C634D280DB4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494419CC3C;
	Mon, 23 Sep 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J5NUzlla"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43428E7;
	Mon, 23 Sep 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109055; cv=fail; b=J5Dt9Z794+WuGU1jMhs2HKVYlXrCllpK0XmZ1AcH1gkI4lIJk4HlHET2JTDEgjtOKrUrLeJYrxHraNmSXYS9ZgUoPhILmPJLGNYsGVmDAU/OvUhOsaEfOpb3kznwRt6F/5nctasLYBGfL2180gkl/pOXf1f0yWF37S0wDzKxR+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109055; c=relaxed/simple;
	bh=lgO//OEXxYD9kD4CYEQIfbFmXiLytZCGcXnntKZqpTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8ZYr4SM7aokjSy+qWOtkFb6UsTSyVV2iluYzKr81PG/lRIag5XIxWD5BhEE0f/8uRCS0jNbVxpGjDM6k3879jdXTkiLt1ArdHkenBTJZkRW7/IHMWoY2fDWcxLUczTp+VfGEYV/g6davgIkCaasuRVfOZj+W1e/OovsKMsH6Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J5NUzlla; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeSJjR04Jrbtkw4Fd896665TFYgvmDmPhojHOREuzQMugNKB6wqw4bxjDgL8AEgR7GPUl7LXQMsU/FUBvaZLpWle5Tafb15M+CeqToAj4hYSVIlN5u07QrRzpvq+gNPAVJ7BhRyFxw/LNJCyPxkGaUdBfqWoilczuTZ+/D+vz/Cue+PIg8PlDcUZfn9wb3+AzYzIypErcjtC6cekQ3a6kWcdgPBMdyIzgIVV3DK1sZPPP3SHPWUyvEYh56/zyULK5WQStJXk+f0ZQy93u1R+hye+R/O2e3tMmG4QOVxSkqvdphuV5FE1C8TZX6k4DwZBWJuNMCsuNnOgqvrw9kd9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge6DbYX/WWGdaIvoVXPTheJfA3N1WsSFqMRBgkeaLHM=;
 b=BLuPLnZkqjADtLV9j32PiHP4TL/TOpbenglsBR/ln5zmiizRy9wct0v7XtWkcnp61czXzWCTZSaAnl4Y3KOuVYP2AmcjCtfYh96dRi6IqNqk98YIrMAp3BSt4TQrc30WGYWQ45YbnGPtyZCQbo7lHYmOY5yqJn/Q1b00isjk7t2v1nf7/B8QbfzgG3mUzGe9oBw5HoCt0UIq0Qv1jFxdZolSb80fmWlbbItG+FapMRPEZQnHDakt00eWxHDtgTtEdmgseRwSEEXgte/tjiBxOj2nQlFgYCswrhx6oM/PRsNt3R/m+Y8Jk/2x2jKvTYAWVQjKpqN6LdkagPwBZp29sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge6DbYX/WWGdaIvoVXPTheJfA3N1WsSFqMRBgkeaLHM=;
 b=J5NUzllaboOXWCR9ZmjhyzpeQYYfs50na53X8mM31TaSQKosJ0i5Z8ZPDdnLKmytzldv9n+7+/Ih2JJuwPKnwnEg/kjk1fgQeWN2xAS19jOsX0mkQNmZSsSuIDAhgrmgyglITDWgCdN3szUkYVRzlNp630T3Tg29+JgT1HGLxhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Mon, 23 Sep
 2024 16:30:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:30:51 +0000
Message-ID: <1eff4036-b785-4737-b919-d67c52efea65@amd.com>
Date: Mon, 23 Sep 2024 11:30:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls
 outside of suspend sequence
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 luke@ljones.dev, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-3-lkml@antheas.dev>
 <1a9b611c-51f0-4c3d-8bc2-62c6b6104fd2@amd.com>
 <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwFwU=KMgDUmKsYRu323dsuUfQYa8e-aXV3JGGSkgF-RkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:806:d2::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b56c288-35a8-4c7e-c358-08dcdbed169c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG5HVmxYRXNSTXpaUFBBUEgwYWJWMmNRQTJUSi9yemtiTEdIN2pTVy9jcEVh?=
 =?utf-8?B?QnpLS0dPcmdtOW9FUEowdFB0Y2daRnRGMndpM0N4TGFVVzlhVUZYeE16eUpz?=
 =?utf-8?B?UFlVTUR5V1B0bXZ6QjN2VW5XT2NhaWp2dWZ4MjFuWmRKcDRvb2RVUExQLzIy?=
 =?utf-8?B?b3M3bXUybjJpaTNWSzRYQlRNS2V5WG5IcWVUZ0hqTVo1ajdQUlZ2WUh4UlNZ?=
 =?utf-8?B?V0hSaEhodW9CRGw1YThFZytLTElqcSs4QzNBN0dhc1JFYWM5ZSt6a0R1MDg1?=
 =?utf-8?B?eE1GczBJdGZsWGdrZVBiYi9tUzBIdzJITzJPTnZmdlZ4WkkvVEFXRlNPYjhY?=
 =?utf-8?B?OEs1bEFoR0ZkWFVyL3lpWVN2RGZlSkMvbURvRUZ4TnF3V0FYdTUrdzB2TGlM?=
 =?utf-8?B?WGcrZ0pvS3ZFTkpHcVlXV1ZHQlJWemRBcU9RMk1uWTJ2a2dLZC9jSkFNQ3I4?=
 =?utf-8?B?UkpkSmpmd3VlS0UrL2ZFQlhPaFdndFdCOGNiL21sMEJseGcxaCtTUjlzd0Z4?=
 =?utf-8?B?aTh1aFRDa2hSeWMzOHZZYlpRRGxKU3RlaStCRzdmOTdqcmw2SUdkcGxVekVI?=
 =?utf-8?B?emdLeDdkZkJUKy9sVnpkSEpXNWFVcmgxOFlkU1RQWUM4ZGkyaUJGQW5hdzZY?=
 =?utf-8?B?QUFjSWFsTnJOUlFXSFlDaG8xWGhBY3YvUHhqOUllTEptREZqaDJOZ1VIWmdp?=
 =?utf-8?B?NW1oWEFLeTJNYkl0WDRJb0FDU0NNTjMvY2JlVHk5K21sa3p5TlZhbWt5SmFC?=
 =?utf-8?B?dTBIajdzNU0zditOU3hObE5jUUVYelF1a3hkNDhIWEp3S3NzQXE5ZURIRS96?=
 =?utf-8?B?WkxkY2tLK1RLZ05UdmRYMEJLU1pTWGs3c1hQU2NvWEdDMWZXTFlKZk1TNDVM?=
 =?utf-8?B?RzIyY0ZqWmRGODV3akZYbHM4N042VUhSQUZMU3UxeHRhVXlvVDZMZEhROWk3?=
 =?utf-8?B?Ymdnd1BvQTJ5TUZvaEhNNWV5UVpiNGJuN2tiK0RIZk1rTDl4c3pwMjlhMHdz?=
 =?utf-8?B?ZnRqTXRDWjVwSTBUODBTclNuT1hVY3VodlBnRWU0RXlXVFBsaDlJNTlvRTFY?=
 =?utf-8?B?dXRiZEtpVnZiKzd2cFhNZTF1ZW8yMWc3MHY0SUVES2QrbXZlTFgxOEc2ZGJ1?=
 =?utf-8?B?enAyNmh6c2R4MHhTTi83QkFGbDh1WDJ0RnlIQ2RoNFdTNzVIVjZkT2pWeFIz?=
 =?utf-8?B?VEhQai9BNGlyWVgvMGlueXdGT1ozSUVrN2lFdHMvMWFFUGQ0N05GOWswSEs5?=
 =?utf-8?B?L2xuZVRPWTZaNGVqVU93RXlYM2tYeHdNNWJQUi9MUEYweTVxMG1tSEl1WUFB?=
 =?utf-8?B?QW5xMXAwWG42Sms3T3RtazNDYW13WFYzTmRJWnJyTy9vSDY3OWlZWngrVTJM?=
 =?utf-8?B?UmhrTzBNakI1dDlNbVdvcnNsdEpYdW5vT1JLN3pkUGx2ZzdVZ0dNQW5mdkRV?=
 =?utf-8?B?bS91RGVTSlo5dXkrWXVvQkRjZTRFL1QvNDE3YVNwMW1LM3BNdjRJMWpsSHp5?=
 =?utf-8?B?d2REK1NtaU93MnY5c3doM1FpcXIvc3NtR2FqSFprd0pJd3JXM1J0ckNGS2xo?=
 =?utf-8?B?alNnQmtRYTd5aU13OWZqTytyUDcxU25wTE9QNU8zNnFpNHRLWjlzcVVIb3Zj?=
 =?utf-8?B?bWtFdm91TERHdlpJSE15UFk0VjhUQ0tSS0p6dlh2WHhnOU14UFdYbEY5eFc1?=
 =?utf-8?B?VUxaS3RIZWdVVHpkTjd2ODFCblc5aVB1YkVDTW1uWUVhaENmbnBYVHlLeEdU?=
 =?utf-8?B?K1Y2TzU3UVdiTnlFSkxna085TkZCbFIzaDNjYnNET25uaGpaZHVIL1JEQ0Zi?=
 =?utf-8?Q?mDYBLxiy1ba5OhgUJ0nKxULAcmGVgxQkNvBkY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3Z0dWs0bmliRm00ZVZISkF5RTVHTUVaVXdIK25BdW8zVnZScVF2bGFUNS9p?=
 =?utf-8?B?YzlTWkQ1S0ZpUHdvdVVNOC9qNjZNVFVSdnJlUDZrWEVOMEZDTStUakxIbWZB?=
 =?utf-8?B?N0Z3NjY1V1hHbTF3azlNQWdSMzZtdlBoOXhlNndDUUVUaXp3M3BiRzZzMHRi?=
 =?utf-8?B?WVFIaUhGR0ZjeUhXcmxBKzE3d2F4ZTVsdEtNNFVsZXByZGFTaFpVUUphZFBr?=
 =?utf-8?B?UllyeFc5c1NoSXk4dHR2T2lLUElWVEhOcXdpemZ4am1VeFI1K2gwVkNIODNJ?=
 =?utf-8?B?azhKWWxsZWFTVC9GSnYrNjBiYk5TVWNiTTJpc0Evcm44bW5GUURGRmJ1dmdx?=
 =?utf-8?B?Y0kwV1B6NXlEV1MvRldxWFI3U3p3Q3lCcG5XSVUzbldTdmFGQi9TOHp2RlVE?=
 =?utf-8?B?bVdRVm1DMEZlbTJQUUNySlNPUmI4d0VoM01xRUJlbjlNYnRWMndDeENJMkNm?=
 =?utf-8?B?d3JBV2o4SmVvVTJ5Z2ZNZWh5T3E0Vk5TWlE1ejlQaWlRU003TjBNRVBlUTE4?=
 =?utf-8?B?Q29DcWF2TFpOM2VvS05QNnd0eUZGWGZzOVhtNFFhTWMyNlJsOEtlR3RSb01M?=
 =?utf-8?B?NytDUUhoazE4dVNrNmR4STVFSXNWYWdyUHJ3dmhPS1l4L0xWVE9IaEp1SVFt?=
 =?utf-8?B?bS9wTDk1UXlWT29ncnlhNEZSYkpJTUdtZDhDMlV3VFM5WTRJWEcyOVdsNkVl?=
 =?utf-8?B?WXVRTWxsdzRBUithb25WV1VManRHanlDUENqUjNBYS8ya25XQ211a2dOQm9I?=
 =?utf-8?B?c3R5OThJQitEU29OVFliOG91SjRxTTcxVXREa1YyUjRZcm00QndZTlVBcVVQ?=
 =?utf-8?B?UWU0bmV0T2F1bGdCYXZ0a0V4aXFEOFhOd2RJc1M1TUVXSzYzbFg0cHZrbmtR?=
 =?utf-8?B?azk0K2hDM3pXRXhvS0hXc2ZxZHByQkdDSlRCbi9uWUFja0hNL3BkZVpUa216?=
 =?utf-8?B?eVdMVm4xVmhZcDRjTmNrelF6OXFzNzg1RkF5UVFVU2FPcWdxNDR0ZHFvK1ZP?=
 =?utf-8?B?TVBmOUtRK1RXa1FSUmVabnNMdWMvZkdTcFZBNmNBdVZ3UisrRldDcDRnM3l6?=
 =?utf-8?B?V0VFWG9MTmFydzdZc21QM1RpZVgzdXlOME9QQUNMMnVNTzJJZmpvNXZ5dXVH?=
 =?utf-8?B?b2dNTFRWNEkwZzk4M0NJTjRUVEVSdllOeW0yNUI2OUszLzRYcWc2SE1ZeUs3?=
 =?utf-8?B?WDczVzBJSTRDOHJHdEdyd2F4Nmw2OSswSWFibU9EL0hZQ0N6ckcwdjhMSFFQ?=
 =?utf-8?B?VEJGSEt4dWJPQVEwYkpUNGhNNmJRcEFtR1ZJeVJsSWQ2M0VtT0g1NmJlVlpD?=
 =?utf-8?B?R3FRYm9CWDl2Q3hvOXhxbTB2NFRVZExmTURaeC9aN2VSM1krRitCV3N0dUpv?=
 =?utf-8?B?L1R6ZWFXTzQ4c2pRT3hlU2FvcnFuU2l5dStsVytnKzNOb3lxUGpyVWFTdkw3?=
 =?utf-8?B?NC9SUVlnSGFVTWV1NTRZUVM0QW9Fc3lPaFdvY1V0eVlqb20wM1BFUUczTjQ0?=
 =?utf-8?B?bG5xM1hRSHdhN3FSNEJ1aUhWb2lZK0MyY2FCWUJWVS9NM3ZKbGphRTlqUUNE?=
 =?utf-8?B?VDh3dVQvTEdxZEZ5YXBCR1l3Z085OHR1Q1d4Ulh3d3NWMmlGWXN3eWRkS0hC?=
 =?utf-8?B?cEpJQ1RwM3Y4bS8wWkFXaVc1NnlxV3NETENYUEJicTh5endYUy9qRXhIZjVM?=
 =?utf-8?B?RXBEbkdpMjlXTFhmMmx4SUprSWl1ZmxTZmo3cS9Palc0akhtTCtiUTQ0VU5D?=
 =?utf-8?B?ZHRwOUZuc0g3TExlSW4yYkk4WjVzalRVK25YRFlJSTBMMjlmZVI5U2Z3cHBn?=
 =?utf-8?B?d0MzYzVlQkdjM2swMFFFcHBDaUNBMWtnZ3l4RlgyenZTWXp5OEFaczU4ajky?=
 =?utf-8?B?KzREb1hzaE9yemc5U09LZzFVcURITWk3K1NOYWlscTZOSllma3pUUzVoR3Z3?=
 =?utf-8?B?TFBMRGppTjcvd2YwR0ptSjFGdHJFb3h0TFdNZXVGbHM3aGZrMWdyME5lVUta?=
 =?utf-8?B?a0hiVHVya0ZoS3N1UWJkOVRXYkRLSmk5VExlZHhpa280OTZwSjNYc1VsM0kv?=
 =?utf-8?B?WTZPTFFDbjBpM1c5RCswNkNCaHBUZXRQUTlidGFEZ2xQZEIvbmxKS1YzeENM?=
 =?utf-8?Q?hhC/lfTkNIFu76wU3aKW3BB9J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b56c288-35a8-4c7e-c358-08dcdbed169c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:30:51.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpYklbt4nI9yLqNUgjqqo/fTqz1HciDMFKlWxubs024dDnhceT4mUxfg2Vjdyc5PV4FdQo6EimADi2SdKgaDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

On 9/23/2024 11:15, Antheas Kapenekakis wrote:
> Does DRM core handle virtual displays like VNC?
> 

You can make use of virtual display connectors in amdgpu.  This is how 
drivers for new ASICs are first developed in emulation and also what's 
used for early hardware bring up.

You can see virtual_display from 
https://www.kernel.org/doc/html/v6.11/gpu/amdgpu/module-parameters.html 
for more details.

> As mentioned in the cover letter, the _DSM specifies both virtual and
> actual displays.
> 
> Also, Windows behavior is like a lockscreen. 5 seconds after screen
> turns off after inactivity, instantly when you press the power button.
> 
> I tend towards making a sysfs entry. Not sure.
> 

Who would call this sysfs file?  Systemd?  The compositor?  When?

In Linux the compositor is in charge of doing the modesets that involve 
turning on/off the screen.  In most cases if you press the power button 
in Linux systemd-logind picks up the event.  It triggers a behavior 
that's controlled by the logind configuration.  Typically that's turning 
on a lockscreen and/or starting the suspend sequence.

Important to note; it DOESN'T explicitly turn off displays.  If you 
configured it to suspend then displays get turned off as part of the 
kernel suspend sequence (drm_atomic_helper_disable_all).

If it is configured to trigger a lockscreen then the compositor will 
turn off displays after whatever the DPMS configuration is set to.

