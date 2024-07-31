Return-Path: <linux-pm+bounces-11731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE29424CD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 05:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B131F23F2B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 03:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066816415;
	Wed, 31 Jul 2024 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QFuVjZLM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3FD53F;
	Wed, 31 Jul 2024 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395793; cv=fail; b=i9C3XV47JH5vYUQcCMAlM64fqa34K6D1Wk/iBBc9h6qhuj7u9+JzlUYQ8vVnf/DNpw9rstofHbeJW6mtuGAsnhxGMhpZjX0F31ifhsD8sH+uwkBIL0p67oYvwZO6gIVjLfxzjZzby8dq6x/3bYLZmi8XACa2fe1dhHjP8F0KDiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395793; c=relaxed/simple;
	bh=aX41BNhzstfph9H0frr6E1XbWSPibA/r6DCz9QcBwpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2f9OnuFhCzbKGjii5HYY+y0yzV8ab4IlTttjTBu3MYqe3gcFA1Ovti+PLQ4I5EA3nwn7p2gdo+z1YwiO7xhNrMbfMMtCPy/lxYRoT1DomE7DtphCa+W9qYznRFnZorDSWNw00s0iDB2w3bQUZZsNvpJT4ZE6PXa4u1XvsHsOac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QFuVjZLM; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiCHMVC6Oz6/KaLI2BB6Ey+5hsEyqS48PoUtB17Msc65Gjp2PS7QQNvRW7lnVffLZ9hC/rOTSqnD3O7N+nwJ2MXJz4+4h87WtfzME8Lv/lBvr+GZi931M4os4K0v3Mn1pXbdm3QmjsKdgCgNJ0NKxabW3pB9QTtMGMjy68cUfNIK0iC0/+Df3d/miRFJFt+5oH4lTnUFy22qOYC097KioYC4fZ+ivVK8ecc/40bdTw/tqlEjsGO533XThp4MNMBXpAKItXW1VZX7QdTjiLfj/uYS9c+NU5rJDuRw7h6HuzDfSjIIJDvoc8J6AHdugCodCrzW2+airCo8h4ci1m6/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su8yzS9IdlUPScSfCcCUm6lNWTpQebyoH8t/X73DRmA=;
 b=p6y/y2A+1pn0f2+BBWzBCIg9BoaAiNu7FOw/UK8dHjtYbPw5m0JcNWFnP/zmsGh6Y/1pth3+M6atvPC7BkZP+U2tvLsQR5MBo+P+g9EdboWtQLSuY/3Ats/HGvmKC9jtlMgkGWkk4smxIBp/mwqEL7yacx7eeks0qGD7NsojnxKcfqss+tsW7+/PnYD6C4WnBoV3VTkJsKsfHEtZ24OF6iaGHLjOKgm5JjLlkQRnF8S4Mq/O+wUWALHBgrC5kUTEyhKX0Kb9ll9qQrKOUROiLMm8jgDJqZpC8u8v56zPTym4GRK2Ou+FDkfGM3EG+R92MNJwo6SgSM+YjnHQWu3uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su8yzS9IdlUPScSfCcCUm6lNWTpQebyoH8t/X73DRmA=;
 b=QFuVjZLMlg/l0V1zd6xlGNFPEVAC6bUpr1BDLCMy/9qmCmmDwCW3OeaH0LfsIvX4Y+gYnkf/3Pvz5HV2itIfmt4q6piGx+yviYffm6AomhBHHu0Vw9NvPABA5aWoeqm/VsMlj7TT3nljubXd8gIgEj3E+CgG8F7kV6ii2VXKpkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Wed, 31 Jul
 2024 03:16:28 +0000
Received: from CH0PR12MB5123.namprd12.prod.outlook.com
 ([fe80::713b:cfca:3b2b:8e8e]) by CH0PR12MB5123.namprd12.prod.outlook.com
 ([fe80::713b:cfca:3b2b:8e8e%4]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 03:16:27 +0000
Message-ID: <9c229562-06f8-fad8-8f3d-a236733ce699@amd.com>
Date: Wed, 31 Jul 2024 11:16:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
Content-Language: en-US
To: David Wang <00107082@163.com>
Cc: perry.yuan@amd.com, Alexander.Deucher@amd.com, Li.Meng@amd.com,
 Mario.Limonciello@amd.com, Xiaojian.Du@amd.com, Xinmei.Huang@amd.com,
 gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
References: <20240730140111.4491-1-00107082@163.com>
 <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
 <2c2569aa.47a.191062d0d40.Coremail.00107082@163.com>
From: Xiaojian Du <xiaojidu@amd.com>
In-Reply-To: <2c2569aa.47a.191062d0d40.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5123:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d080348-038e-4e10-6bd5-08dcb10f29d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1AybGV2bW9QMXRjdDF2UUhSU3BLRGlWVTZUNXhiT0NnaXI3cUh0Q2I5ZTJU?=
 =?utf-8?B?ZGc2dngxVTkxVVREWlF4L1lMcWdjUTdzOGVWQldhTXUxVElYN2k0RURrb3FE?=
 =?utf-8?B?Vld3MWV5ckhyaXlYZkV2R3dTQ3Z2eW5UYk9uUTV6ZjRVS0VXWTM0YkJha25G?=
 =?utf-8?B?ZnVGc1Y4aXVpU3REa2dkSEE2OUFRUlYxRzJwNmQ2dUVBaTZ5dVNBQk1VM1Bw?=
 =?utf-8?B?a2JXQ2JRYTVIaktCQVk1SHVBdUIya096dE9JbnE0TGxQdnMxQllROVFISy92?=
 =?utf-8?B?OElzVWxCeGFlOFUrWUxaaHZOckFOTTR4UGMzYjc4VGxKUU1oNVpjTFJnd3Jm?=
 =?utf-8?B?dURQOHNWQjR1YUZlZkRCQ2taaDJQa0pVQjRvaFFJZVd6akRBTDhXTzdDbG8z?=
 =?utf-8?B?NlM0cXJyYWxNaVp0RWJKUndtQjZkRlpESkxsSHJRemRSRkhCblhrWG1QUHp5?=
 =?utf-8?B?L3ZkZ3h0QXV0ZWZtV1c4SEIwVzQ0b0ZlVVNFakpYdVROcTJkTS9OZW1xN1Z3?=
 =?utf-8?B?YlVlVWljRGh6SW5sMWZZRyttVXdzTlFuaENPQm1xMEVtUDM4REZYc0VSMitv?=
 =?utf-8?B?Q2NaRXpQa1BOSzJQYTMzOVYxRWRzczE5VFdVQ2JKZ2RpTklrMWZRWHE3YTBs?=
 =?utf-8?B?aTlQWk9sZ0crSkVxK2d1RGZCMW9jbGFYZnNpWFRNakZCNENRWDkyOGQ1UnZD?=
 =?utf-8?B?d1E2S01wMEg1WjFKdWkwNmxKYyszaVNrOWo5MkVjZ1IrMW9nVkVmRjd2eHFo?=
 =?utf-8?B?SUZpQytCUlFmdmNjSUJaUHJCaXl1QlQyL3FrZkx3VFI3VTVNV09BS2RMcjZI?=
 =?utf-8?B?UE1UN25wVVBSQ2luVVFyQ0wwZVlZVjhsNnlSUHF0QTBwMkp2cmlndUZPRFZT?=
 =?utf-8?B?WXQzMUZyRWxydnF5SkJoOFBiSnBCdEZhd2pwY1diaFBzeUdBKzFrTFVNVGN1?=
 =?utf-8?B?WEN0RTdQQ0hab3lsVnQrTHZhL1Y3cncwVkhWak5zVVdjTk5nOGZXc3FPQ0gr?=
 =?utf-8?B?RkhhelIyd3Zlc3FPQWsrejlUb3lPeFRsVjMrZjBENjRNRFBTYU5IZTJFbnNQ?=
 =?utf-8?B?b3RGZHpyd2ljMU5ZUEtIQ0M1cDR6TE9ZSUoyTys0Qnh6dlZ4SjJDRWtzeFlI?=
 =?utf-8?B?ZVlKb2N5Z0RkUHF3d3hreGRLVGxmdGpWcUNSTW5UdEowN3NiTGYyTUdPb3pE?=
 =?utf-8?B?d0dNUFBWTkpsRktCL1A2UkhYOTk2OElIbGRtMVE0NGptQjNBaEsvM1AyR05Z?=
 =?utf-8?B?ZThVZ3dIVWs1ZnFpMTNaQ0w5dFA4cGNlOUFDajVYaDlVTjExM0I0M0VzQ1Jl?=
 =?utf-8?B?Skh5cWpBYjR5SzdRR3hha1I1ZGxjKzNBeEJpVGNtcVZwNGg4b1Y3RlVpc0Iz?=
 =?utf-8?B?ZW5JRUxBci81QjJTSWdzTTh6Lyt2TCtZMW0wM3diczJvUW91VkZyRXBNL1hL?=
 =?utf-8?B?dTF1OFdXK2hvWWtGRXVNcTAzNDIvcGwrZjlGdGpJRlF5OTA5Q2NCLzF3UkpH?=
 =?utf-8?B?ck9SdzVlRTNOaGs0RzgvN0dLeEExaWFJYUlQNHlIZ1RadEIzeCsreFh2UFZr?=
 =?utf-8?B?MmdJc25uKzJPaFFkRFY5Zy9tMnI2ZElwS3dKeWUvOFhzblRMWjZpM3JDK2dy?=
 =?utf-8?B?eFFkV0NpWjNIL0hUbzZEbUE5VnRKTUVRRExyUVZETHJwZjl6NUI0M042MTNK?=
 =?utf-8?B?Nld4T3VKNVduU1ZEbzRRNmh2cTlTMGNSV2ZhbnBkbVJHWGtKc1Rxczg5OTdj?=
 =?utf-8?B?NEkrWkQzdFdVM3R4L3JFdE11Q1paYWhjakdhdWlsMDRaV3FuZi8yS2hkcHBu?=
 =?utf-8?B?dUxhcXQ5eldPd1UxV3FZUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L01pL3cvbWc2WjRsL2I2SmlsN210dGcvQndxQ0M3R2NmZ25rRGZRcFMxM1pa?=
 =?utf-8?B?ZmU3K3ZOeERFT1hSc1NNMFh3QXByRnRCMlllMmpUZjNLa1ZrZHBuanNlK2Fk?=
 =?utf-8?B?dmlFRE4wbTczbUFIMDBOTXVqMkxkM1Fab0FaNTRXUjVXT0RxNXdSZVBNSEhP?=
 =?utf-8?B?ODZWNTE3b1dQNEhENGRJbXEzSjBHcVFhOW01OVdKWWlGZ0w4UWJaa29NRDBR?=
 =?utf-8?B?MitnRkI0WGg2VU5UVWtORHl5L095QW56TEt2SmloSlFHT2xyRWt2VitKMGR6?=
 =?utf-8?B?bGx2YTI2Q1hXdFRvUzRCNEFYNE9WZlM3WVRUYzRxcXorWVBCb3c0a09UTEJq?=
 =?utf-8?B?UGpkZ1M3Z01aZk80OXhnYTl5YkpON3hhUklqcFRyNk40Z1BHOHlLMkNtN2dr?=
 =?utf-8?B?WThNWnVjSmMxT1J1YVJFMW1CU014SWVTeHlBWGhQSUMwRXE4Sm9ZdXltUzAz?=
 =?utf-8?B?UkExWm14UGJFNHRKZEpYWHNibmk4TmNmRlNyT2pvV1RzajY0L0xld1VNN2dx?=
 =?utf-8?B?VEZFbDJ2UW5OTnZCK3kzd3l4K09SUFJTRlRUV3kxd0ZXbHNDd0lPY1gwd3FB?=
 =?utf-8?B?Y2czRG9XaVVLWEtUSUFUTFBNSy82Vk53Z1NNdis0Smw2NWU2dFhrdUpXS1N3?=
 =?utf-8?B?TjV6b3Y0S3djT1JNckwwRUNzNkFnNWMyOGZ6MjVnOVYvME0vc3dWdEhIakVV?=
 =?utf-8?B?RWVmVGs2QzloL3BGZGhtRzB3YjdGeGl1anNCdDJCUXBwb3NxL1FjQ0l1QVl2?=
 =?utf-8?B?SnM0UTZZSVVrdHoySkpLVTJHTGxwT0U1R2hvWVVvTEtHcFQxY0U4Q25BMldm?=
 =?utf-8?B?ZHVyWS93QnV4QmQ0ZkloODRmWnY3NE96MTBFZEFsSi83Si9OOGJUd0RxWjl5?=
 =?utf-8?B?U00xSC9QM3FhQi8rdElHajZVczRRK1grczBhZU91ZWZrTDBPYlozNFp3c09G?=
 =?utf-8?B?SzQwckkrNHdzUmpVNGlXU1dPTll2V0ZjTzVNT0lSMW1iTzZEQVN2L2xwK1Rr?=
 =?utf-8?B?Z3BFT21qbzBuNjVuN2dBR2N2cDhEK0VQQVJLekN0a3NJaXN5OWlWSVB4RnB4?=
 =?utf-8?B?Ynd5YkRjT3E0S081Wmhodm5ZMTdKOWVoQnVyaVk2SzlkN01BRUlYVS9JL1NO?=
 =?utf-8?B?RmFSa3lvbEFVRmJNTHZtVVdHS1RyR09CS2ZCUk5MUno1NU96RXpydlFBQzlk?=
 =?utf-8?B?eGZDNGlpNGtaeG5Cc2xXRFpURzhoTkUyT1JZd2M2cWhEZUFoNDcyY1c1djBT?=
 =?utf-8?B?QjNQYVZOaWU1YW9XMEc2SFBESksxVHpDT3NzRE1FMHIzNGRLekpsQXM2cUZr?=
 =?utf-8?B?a0tDTEU5NmxIMEpBK3VyOE8vbUt4V0loS0Q0ejFBemRNNEh6SEJ2dVpPV3R0?=
 =?utf-8?B?ZzQyck1Rb3dLcnE2UlZGTUhEZ3BFT0N4NU56T2liZEpoYy9Mc1hTdFM2cWE2?=
 =?utf-8?B?U0FNVUtJSlJoNG1mc1Q3bzZ3Q2duc1JqQUk1K29idHlCZGh3NWRsTWd2WHFB?=
 =?utf-8?B?NE5QMGhpN3laTzMzWGZSaUkyYW1wanQ2Y1FZSVRhem4rZkFNbGdzcVh6SmRR?=
 =?utf-8?B?aGVZaW90VWNUdEdzL3BXK3RNUTFwZHNldWIxaDNjQVlzRGJ3YUplbVFXYnlx?=
 =?utf-8?B?VnBPYzRrUy85ZTM1VTdlWmZiTFdRMDFjVzdsQUNoRXZnZEppT0ZnbVgwRWJt?=
 =?utf-8?B?QjVZY1BweFkwL2dINTFpZG1lNitPaDRUaXJGS3Job3ZqWWYvaXdEcGw0eGhq?=
 =?utf-8?B?TGdzVE9HOU1WT0FOejlTSU5xUzdYdlNSaUYxa3RKQmxXL2ExNktJcno3Qktx?=
 =?utf-8?B?TUlzd3BjWlcrcURkV3JvSlJpNjZiT2c2bGozOUh2MG5aaVlzSkZxZk45L2NW?=
 =?utf-8?B?azlBQkJYMWlmSjUrd2txT3FSRDFJNzFNL2VGdlp2QlJzNHd2SUtvTCsvbnNX?=
 =?utf-8?B?eitRYkdJUlB5NVZVN01TSmFSYk0wVGJSdVFOK3lDcjFHRi9ibWs3TFdzM0lR?=
 =?utf-8?B?Zzgrbno0WFhkRkw4Rmx2cnZTeUN5N1hJVnRXclBFM3JpNVErd3d0MG5RUjBG?=
 =?utf-8?B?T1Njc0dSNjdyNDQyMU1ac3NFOXJ1N1Fpc1NzaFA4d3NTbGZad00vU3B2aXpM?=
 =?utf-8?Q?zt/dO/zU3Ed8E/Xa+Ktfu5L+R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d080348-038e-4e10-6bd5-08dcb10f29d5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 03:16:27.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RLttvNtcfWzBoON6DPEBy2EEzpxmt9OVBuCYrxRKJT5ZQp2GVf4xECbGRK7z9xf/UJ/xYfQnFL5pl2MjRlmPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281


On 2024/7/31 8:25, David Wang wrote:
> Hi Du,
>
> Thanks for the quick response
>
> At 2024-07-31 01:43:47, "Xiaojian Du" <xiaojidu@amd.com> wrote:
>> Hi  David,
>>
>> CPPC feature is enabled by default in BIOS for new ZENX arch CPU, and
>> amd-pstate driver is enabled in new linux kernel.
>>
>> For your system ,why CPPC is disabled, is it for debug or some special case?
>   I do not have any special purpose, it is just the default BIOS setup for my old system.
>
>> If you want to use legacy acpi cpu driver, you can disable amd-pstate
>> driver module in your linux kernel config file and compile a new kernel.
>>
>>> Those warning message was introduced by commit:
>>>    bff7d13c190ad98cf4f877189b022c75df4cb383 ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS)
>>> , which make sense.
>>>
>>> Those error message was introduced by commit:
>>>    8f8b42c1fcc939a73b547b172a9ffcb65ef4bf47 ("cpufreq: amd-pstate: optimize the initial frequency values verification")
>>> , when CPPC is disabled by BIOS, this error message does not make sense, and the error return-code would abort the driver registeration,
>>> but this behavior could be handled earlier when detecting CPPC feature.
>>>
>>> I feel following changes would make a clean fix: do not register amd_pstate driver when CPPC disabled by BIOS.
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 68c616b572f2..b06faea58fd4 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -1837,8 +1837,6 @@ static bool amd_cppc_supported(void)
>>>            * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
>>>            * the AMD Pstate driver may not function correctly.
>>>            * Check the CPPC flag and display a warning message if the platform supports CPPC.
>>> -        * Note: below checking code will not abort the driver registeration process because of
>>> -        * the code is added for debugging purposes.
>> As you see, it is for debug purpose, in some corner case, if CPPC
>> feature is disabled, this debug info will help to guide user to
>> *re-enable* it.
>>
>> Target system, including CPU+baseboard+BIOS, is supposed to enable and
>> use CPPC feature for better Performance per Watt.
> I agree that the warning guide makes total sense,  but  the  *errors* does not, why bother trying and report error when the feature is disabled by BIOS.
>
It has to do that.
AMD strongly recommends users to enable this feature, but each OEM will 
have customized BIOS, some support CPPC but disable by default,
some support CPPC and enable by default, and some disable CPPC directly 
without providing switch option.

Since newer Linux kernel enables the amd-pstate driver by default, and 
newer AMD Zen X CPU supports this feature,
but user find that CPPC is not effective under their software and 
hardware combination,
if this driver does not try to load module and print no information, it 
will mislead users that the problem is caused by the amd-pstate driver.

Thanks,
Xiaojian

>>>            */
>>>           if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
>>>                   if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
>>> @@ -1856,6 +1854,7 @@ static bool amd_cppc_supported(void)
>>>           if (warn)
>>>                   pr_warn_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
>>>                                           "Please enable it if your BIOS has the CPPC option.\n");
>>> +               return false;
>> Maybe need a pair of curly brace after this "if(warn)" for your change.
>>>           return true;
>>>    }
>>>
>>>
>>>
>>> Thanks
>>> David
>>>

