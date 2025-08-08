Return-Path: <linux-pm+bounces-32058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF38B1E570
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949241AA2C44
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C226D26C397;
	Fri,  8 Aug 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aqFUNBLt"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632F268C73;
	Fri,  8 Aug 2025 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644451; cv=fail; b=OguGJksYD9I8jXiJ0z2Zz+MJa9UgoWOkCH49zf8ljKZ5yJ8+Txc823sREoSLaQPICOQzr/sbBduEWv3BpYrEAeXSNjnig5DC1zsRuq3pbxX6iuKdWstxUr/w/e+pQPTCabItN7UnAjPEALWjEVA+zOlz/vvs8P6ixNwxVwfF4zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644451; c=relaxed/simple;
	bh=DaKKynti8A6ES0bLSnhq+2iNxQ/we/r4mteI6gwNVn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5v3XcBkGMDodX4iNoxkJ/LLritZPOHh2oWsO5GOsvoTIJFvP+u/ZtE0P2bj5VAoaefBUowZDVu0sI3CKXkWTPunUP6FAs2RvR2mfn22XaiQsX1iMV9LLXQDSr4yNyuDpbhrYf+Ytgn6/AS2a6r9BV4s8vmsxjw8InkAmkH4PTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aqFUNBLt; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGswqXq1IFwQmXlW9xRj6jwdNavXxa1JbFg39KBrswo93TkgVz0CqUOgRxU/9hyW30meI+Gvv2yZUgJ7dbfbuv+hpmhaI+pB16z/c8EhwFsNsuMpCDHvbMQRK6Xgcl/h1NYO0WKRQpFHh+uBuFXnOvn5J4K3rG9Fc3CqqeklyhOCE9prOeU+kOokkjKC75jTXfbqjMgUnHL8RS1EPFNxew+Mvvmog9dOPtZoKtrKe2Ah2/kNlhrNVlFIZyjx8fCnK3Q9VGeZKtqyt7lMxqX0h5DGb8N1oFBCkQwzHPfsMdW844RwSv/xBzBc4OFwm6mw+MpduxqBp/E1fDXmRIzRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er6xrq5GCC9/OyJ3Z6QAreldlhsmFbwI09W/GWIaiZA=;
 b=KSfnMUW8GxOXOkTeRmAMh7bvbgm8p9KU6E1/VP/oqhOKPD5SstSe59bPfoP28fTXfyzsblhu/UVdAKt4gSsugHT3dGyKtvnVgFT+FzRSwaH0pqZLPwx5UOXeBWjdDsAYQIF6rpTAoyLB+ocV1YoBeFfSP/CR9tGMVLB65NEZUedJH2WdF4T27ErybJy73uYlsqTumelxi/B9IkErHrs8l8l5prAUbnhYlcfazbljSfKYpL1mYnNCXOG5EfD+EIBIafPkvc6vj6/nHNXkfokxAzo6QqI/2yu3tTFSkZjDbxKAtq20d22hNE80dzDGKNhZLyvt9iCNhByPioiDuQ4h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er6xrq5GCC9/OyJ3Z6QAreldlhsmFbwI09W/GWIaiZA=;
 b=aqFUNBLt/znhNZI1dvdK8iBck5hU86Uo0PfS/9MN20nL+jsXF5ma7LMD7frrAdEs/3aAE4kNzBX8yTLcqxnfYDM9A8OVvA5oa/Gw3OU3v3f/MpAf/Ttvn4CSJpA6Q5zIK1bFaq3br/5NGdqPQnC0UyoPZYnFrIRZmrGzsqzHQAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19) by GV4PR02MB11326.eurprd02.prod.outlook.com
 (2603:10a6:150:296::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:14:06 +0000
Received: from VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d]) by VI1PR02MB10076.eurprd02.prod.outlook.com
 ([fe80::869a:7318:e349:822d%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 09:14:05 +0000
Message-ID: <1aec872a-f1fb-4302-b346-08992ab19276@axis.com>
Date: Fri, 8 Aug 2025 17:13:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Jerry Lv <Jerry.Lv@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "letux-kernel@openphoenux.org" <letux-kernel@openphoenux.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel@pyra-handheld.com" <kernel@pyra-handheld.com>,
 "andreas@kemnade.info" <andreas@kemnade.info>,
 Hermes Zhang <Hermes.Zhang@axis.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
 <VI1PR02MB10076D58D8B86F8FB50E59AADF422A@VI1PR02MB10076.eurprd02.prod.outlook.com>
 <2437B077-0F51-4724-8861-7E0BEE9DB5F0@goldelico.com>
Content-Language: en-US
From: Jerry Lv <jerrylv@axis.com>
In-Reply-To: <2437B077-0F51-4724-8861-7E0BEE9DB5F0@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To VI1PR02MB10076.eurprd02.prod.outlook.com
 (2603:10a6:800:1c2::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB10076:EE_|GV4PR02MB11326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcd1a62-571b-439a-dd33-08ddd65bec6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|42112799006|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnRmb3JtM0hxckFlRHpSZXBtOWo1Sld1K09OV0oyQ1JKSnUxODhmbEJ1VDRR?=
 =?utf-8?B?V0IrOEw1cm1hWm9VdFJ6WFNHT1NWR3lZSDdUS25QT1daQi92UTc4UEhPaUNZ?=
 =?utf-8?B?RE82UXhqajlQdUV0REZEUFZRVnhpQ3pTTzl6UzlDSys4aTdlenZXUGxqdW9M?=
 =?utf-8?B?bXZpell4MW1Gd2RDbDBEa0RqRTM0TE1SbFB0aUhCdGZGT0hCaHFGUGZFNGVz?=
 =?utf-8?B?Sjl4QmVzbVFIaXdvOG4wQW50RDd0RmlqdGtwTVFKNGZYTkpjWEpLRVlzeGhp?=
 =?utf-8?B?Z2dOekhBZEhKQWhSSkx4Q29BbHRBbVdkcW13RlRIRVJVUmtHTUd1MWF3UDBP?=
 =?utf-8?B?b2ZxbFRMbVpBbHpHTzVSNG1uYy9QVGRLYlJyNXFRVlFCSHdKb25rUVp0b0gz?=
 =?utf-8?B?SyszZzVGMWxkVE9ZRDlhL2JxQmxVN2lOelRxa1dYR24rRTFCdUJGazdFdWM1?=
 =?utf-8?B?MnlHN2l5NGVRUTBLVlZsY01MaWVLaXZ2QjIvaWpkUWhZOWQra1kyNmhscUlB?=
 =?utf-8?B?NXR5WXFQUmtCVGV6Y0d4UXI0cTlNZVZnbFJLbW9YZTFiL2F3anpQRnA5YW5I?=
 =?utf-8?B?eisxbm1YNmNCMW9LMFVUN0RJSjlJR2VjVkZLV3RyODRlMkl5dkQzU3F2Tktx?=
 =?utf-8?B?NTNsbUtIT0ttaERwZnpyeFU4U0ZoSHhlZzNJazAxRW1VRUpybllndHR4TVRv?=
 =?utf-8?B?YkR3SnFHaHF2SjlwMGtibkpEYjRMUXhrZUhZNVhnK0tkS1VyM2loVmErZ01M?=
 =?utf-8?B?aHlpdVNlRDBmR0dQMDJtd3l4YmV4WlI3TXdxc1VOTW5MYThmeU5jcWtMaitG?=
 =?utf-8?B?Rk5NakVONldERWxvL3ZUN284S3RwWU80M1Jsamc5eTV1VldTd0cybnloMVhV?=
 =?utf-8?B?L3Irb29mVTdyR08zUXd4ZjUvbm9vNkVLa2Q3cDhWZjFVR1ViMGZJZHFaNVZT?=
 =?utf-8?B?c0FGeWJHTllYREFCK2FTeXYzaEcrS2ZQQ0YrTUp4WnZSWVNqaDI2UUt6Q0NZ?=
 =?utf-8?B?emtRQzc1aXBCUWJDamxxdyt3NkhRSWUweVRBdldYMGhJUnNtbXZKMUcrQjA3?=
 =?utf-8?B?RzBlN1hORlIwNDd1bGVVQU96Yi9URTV1TWZYL2VQWWNzMmVQd0ZCTndUTk9Q?=
 =?utf-8?B?NUtXdmFxRXVYWU9nNTZsK25hdVFUWTczMStSMlFPUER1cStETjVzaFkzTkhL?=
 =?utf-8?B?MGdpeEdIQnYyenZaS2d6Y3pYT0xNc0ppMkFiWDd3WjkwSVp4UXIrR3krdEFG?=
 =?utf-8?B?ckk3WFlERzVEcFJZY2pTM3VycmhRQlRELzd6SkVEYUlWYklrclEzZ2ZGUFZu?=
 =?utf-8?B?SFRDZVdFc0NRNzN3eFluVG54Zk83TkRnaGh6MCtEUmRYZEN1WVIwVWVHMURZ?=
 =?utf-8?B?S2tUQzMvMUtZaU5Ha3NIK21HMi9XdHBVUDQ5Q1pBclVVOERmQ3VzSkNXRXR0?=
 =?utf-8?B?bDZLaTBiWUpTUnp4QjNOVEFJSVNNbnUxNWJQOHArWWhKNmRiUG50Lzd5c2xO?=
 =?utf-8?B?NXUrREZVMHhIWlZvY2UzcjR1SzBMOHVhUWhaTGVoYWZwUHZPS1VlOVZHVEpn?=
 =?utf-8?B?cFRaZ1V2a2g0M1JPcGRDWEQ1NmVwemwxQTRDcmZmR3d0VGU2d2JDOU0rSEtl?=
 =?utf-8?B?U0twbEsxZnp6RStBRG9hUXVwQ1MrN0txT3d4VmthM0VPUW9ZNm4ybUJyZVZj?=
 =?utf-8?B?c1FQSmZmWDBkZU5Jc05CblRNem8zQzdBanMzZndBdnAydVpDTXpaSk5meFJt?=
 =?utf-8?B?KzR6WVpVK29sSVBRNmZYOVRpTmRNNytxUXpHZVlHeEdvdzlJSFVPRk5KcEhH?=
 =?utf-8?B?OVpQOEhFdmlOb0tNZitzK2NJWEpmeUpydUZKdmlQdlB3UlVKcVNNQktZY3F2?=
 =?utf-8?B?Tks4aE52OHhFOXFOYUwxOE9jaHFURFJoY2UwRzk0NXhlV2o5QldnME1FYlhq?=
 =?utf-8?Q?iM11fYVpWcY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB10076.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTZmRWpkckVadkFCL053aU1DYmRUYW9BWWNiZzl6QUNuMDBtZ0pwOG1HVlkw?=
 =?utf-8?B?bXZ1SEdTd1JCTGZUNGYyVVd2LzdhZ0Q5OFBBWkhZWEwrUWkxMWRxYTc3dFVC?=
 =?utf-8?B?eEhUM3Z0Nnd4dlNSdmJuRmhVSk9NNzlkSFZ3bzhrZTd5Uy8yb3dHZllmeTM4?=
 =?utf-8?B?eTF0YWtNQVM0OFJsRE1ZS0NyalE3ZnlVZHBZY2lZSitBYnZQWGttVTdGZ1Fx?=
 =?utf-8?B?WTJ2Q3dSVWRvTmVVVHZzeEJ1TEQ2ZzdhWFJpQlF3ZTVTVnY5UUcvZytFKzU3?=
 =?utf-8?B?VkllOE9ENThoYU5CWTVyUk1pWUJxRzUyQzNmTnU0Y3FVcm1telpqV3kzUit0?=
 =?utf-8?B?M2M3Z0FKb1U3V3VqZ1Bma0haYjB5b2FwRUw3MGdQKzQvcGJlem1Id3RGdkk5?=
 =?utf-8?B?V0h4NWhSM0tPbWRUV0Nqb2FYWFJmMnlOZExHRzZnZ0d3TG1hZE5BbFg5N3ZK?=
 =?utf-8?B?UVhNMVRVNnNPTjNNVGpTZmJRRGsyVHVoNUVsS0c2YXYvVXJibGl3QkxkMjBY?=
 =?utf-8?B?T0s5VzkzOHVteVZSVXMrdUtDV1dSVVRCK2diRWRHSHZNUWowU2JJZU1BVUx1?=
 =?utf-8?B?SGJRQ2pKMHNNYmJzUVh0VjVDWTlJUk9VaWFwckZjcmRkNUJXZ0dLS1kzUlhQ?=
 =?utf-8?B?U3R6czhYV1YrZU4yR2NUSnVFcjB3YUZrK3U2eHc2Vm8xbW5TdnBNVW5udm5R?=
 =?utf-8?B?L2JySzFZOWZiRm9tQW5zY253RVo5SWpOMWw2ZUxFdVY5OW1qYXhrN3Y3ZDIz?=
 =?utf-8?B?VzRpdCtpZUp2eEtqc29yNmhBL3hVVmtLQzVCdlA4QzM1cGF1bEYzMzMwNWhM?=
 =?utf-8?B?MTFGL0VzeU16THdvd1VEbkZab2wwN0JjbWY5Rjk2RHkrb3RVTmllYkV2eWpv?=
 =?utf-8?B?WFJpUUd4Q3c4c3dHa0xHaEI2MVJtSWJwejBVZ0xwNk5DdDVXaUQxc2xNOW0r?=
 =?utf-8?B?QXBUd3hhLzJ5VWVXZ29zMkFhbWJwQTJCVFJYWVZMNEVtUEkrWkRnYlJrd09r?=
 =?utf-8?B?SkxWUjV1YlFDQlArMWlZTXpzSUZ0cElMZE5rTWV0MVZIbUttNFJ1RkZ0SEFS?=
 =?utf-8?B?dEFzNElLYURjcGlUbE15Mm9RL2JxWnZGYmFZdmkwOGIzZmhXMFh4UUN2dFdx?=
 =?utf-8?B?VTdzVUg4c2prRjhxYmFIZkdxN1lJUE9QNW9YUWtXbjRuYUVkNHY0N2FYWTB6?=
 =?utf-8?B?SGF5MysxUWlOT3hjOTJSTXpIYkMzeVI1clhxZTdvVVpjZk5YMnM2UXJxd1ZC?=
 =?utf-8?B?a2RwQWdZSTFkOTJtZDBpakdLQjRuRGhDU0owRXBMNHg1cVpseE1ZcmU3ZzBK?=
 =?utf-8?B?Y25NSmFuS2lmZXh1YU5saUtNWHJaUmgwR2l6QWhrWnhCbWhCaHYyYU9jMDRy?=
 =?utf-8?B?R1hteDNQQ0F1QmZiWHV0dmxqRGY5SzlxQnpRMnM5Y1VVVHA4aUYxVzdDUVRR?=
 =?utf-8?B?WWJzNThpajFLQWg5NklCRUw2dE5LMDFSSmlTaGNQU1BYMHkxclg4RVhLczJo?=
 =?utf-8?B?QjFYblRJVDJycFdqNVNmT1Fyelg0WkZQTHNDeThnanhSQmxzRlFCalpwR0Fs?=
 =?utf-8?B?R2ZiZnppZUJjUjNXVDMzRXpTR3FHMzZMY1NXRnZDc2NYZmowSzYzeEpacnht?=
 =?utf-8?B?THBmMUZVenA3R3loa000eUJ4SUpPNmFqb0w3ZjQ5ZG1ESXNlaWpTdEdZZk1Y?=
 =?utf-8?B?K0tJblZuOCt6NkEySy90d2E2eVR1aks3YTBDWDVENkNMaXMreVBCMGZ2SHVN?=
 =?utf-8?B?KzBwMWVURTErK2cya05XZ0UwdkdhZU1Qek1EWWQyamtxK0FmS0RjOWJxZHds?=
 =?utf-8?B?MVo4UFdBT1QzYVl6elBTOUlZaDNXUVUydmJHNXkxN2F6UGVnNGN5WnJ6Zkp2?=
 =?utf-8?B?N0Q5Kzg0MXVNMFFUdmZ2S3VWV3Z4SG0ya0FJSTdNTHZ5ZU5nS2FtQ0M1YWky?=
 =?utf-8?B?bzRTUDhXK2ZCeWZmczBzbmx5aVBMNUtRQmJUSzYwa1ZZVTR5bEVXeVVKY25D?=
 =?utf-8?B?WmcvV0JoMWtHY0VEV2JEdnR0VzdHYWRjazlxdnZvUFVlbWlzbTRGNkVBU1RV?=
 =?utf-8?B?QWx0aTA0U2NFVkVvay9TNVo2ZFQ3MDFocGxwQUpQZVpBdXltTUk3SUh0R0Zp?=
 =?utf-8?Q?1aJPPKwbZHr5DXcQemH/LHXiq?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcd1a62-571b-439a-dd33-08ddd65bec6c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB10076.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:14:05.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK4+9bIeB+5ZxIHnjUBlEwbdEbgaKBikIEESd4S0bf6rYR79PbzE1H8FaezEvj6XLngIWgi2F2PKaYyyPSuJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR02MB11326

Hello Nikolaus,

On 8/5/2025 5:28 PM, H. Nikolaus Schaller wrote:
> Hi Jerry,
>
>> Am 05.08.2025 um 10:53 schrieb Jerry Lv <Jerry.Lv@axis.com>:
>>
>>
>>
>>
>> ________________________________________
>> From: H. Nikolaus Schaller <hns@goldelico.com>
>> Sent: Monday, July 21, 2025 8:46 PM
>> To: Sebastian Reichel; Jerry Lv
>> Cc: Pali Rohár; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; letux-kernel@openphoenux.org; stable@vger.kernel.org; kernel@pyra-handheld.com; andreas@kemnade.info; H. Nikolaus Schaller
>> Subject: [PATCH] power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
>>
>> [You don't often get email from hns@goldelico.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Since commit
>>
>> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
>>
>> the console log of some devices with hdq but no bq27000 battery
>> (like the Pandaboard) is flooded with messages like:
>>
>> [   34.247833] power_supply bq27000-battery: driver failed to report 'status' property: -1
>>
>> as soon as user-space is finding a /sys entry and trying to read the
>> "status" property.
>>
>> It turns out that the offending commit changes the logic to now return the
>> value of cache.flags if it is <0. This is likely under the assumption that
>> it is an error number. In normal errors from bq27xxx_read() this is indeed
>> the case.
>>
>> But there is special code to detect if no bq27000 is installed or accessible
>> through hdq/1wire and wants to report this. In that case, the cache.flags
>> are set (historically) to constant -1 which did make reading properties
>> return -ENODEV. So everything appeared to be fine before the return value was
>> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, triggering the
>> error condition in power_supply_format_property() which then floods the
>> console log.
>>
>> So we change the detection of missing bq27000 battery to simply set
>>
>>         cache.flags = -ENODEV
>>
>> instead of -1.
>>
>> Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
>> Cc: Jerry Lv <Jerry.Lv@axis.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/power/supply/bq27xxx_battery.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 93dcebbe11417..efe02ad695a62 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -1920,7 +1920,7 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
>>
>>         cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
>>         if ((cache.flags & 0xff) == 0xff)
>> -               cache.flags = -1; /* read error */
>> +               cache.flags = -ENODEV; /* read error */
>>         if (cache.flags >= 0) {
>>                 cache.capacity = bq27xxx_battery_read_soc(di);
>>
>> --
>> 2.50.0
>>
>>
>>
>> In our device, we use the I2C to get data from the gauge bq27z561.
>> During our test, when try to get the status register by bq27xxx_read() in the bq27xxx_battery_update_unlocked(),
>> we found sometimes the returned value is 0xFFFF, but it will update to some other value very quickly.
> Strange. Do you have an idea if this is an I2C communication effect or really reported from the bq27z561 chip?
It's the data returned by i2c_transfer(). I have reported this issue to 
TI, and wait for their further investigation.
Not sure whether other gauges behave like this or not.
>> So the returned 0xFFFF does not indicate "No such device", if we force to set the cache.flags to "-ENODEV" or "-1" manually in this case,
>> the bq27xxx_battery_get_property() will just return the cache.flags until it is updated at lease 5 seconds later,
>> it means we cannot get any property in these 5 seconds.
> Ok I see. So there should be a different rule for the bq27z561.
This is not only for bq27z561, it's the general mechanism in the driver 
bq27xxx_battery.c for all gauges:

        static int bq27xxx_battery_get_property() {

       ...

       if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)

             return di->cache.flags;

       }

>> In fact, for the I2C driver, if no bq27000 is installed or accessible,
>> the bq27xxx_battery_i2c_read() will return "-ENODEV" directly when no device,
>> or the i2c_transfer() will return the negative error according to real case.
> Yes, that is what I2C can easily report. But for AFAIK for HDQ there is no -ENODEV
> detection in the protocol. So the bq27000 has this special check.
Since this is the special check only needed for bq27000,

suggest to check the chip type before changing the cache.flags to 
-ENODEV manually, see my comments in later part.

>
>>         bq27xxx_battery_i2c_read() {
>>                 ...
>>         if (!client->adapter)
>>          return -ENODEV;
>>                 ...
>>                 ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
>>                 ...
>>                 if (ret < 0)
>>         return ret;
>>                 ...
>>         }
>>
>> But there is no similar check in the bq27xxx_battery_hdq_read() for the HDQ/1-wire driver.
>>
>> Could we do the same check in the bq27xxx_battery_hdq_read(),
>> instead of changing the cache.flags manually when the last byte in the returned data is 0xFF?
> So your suggestion is to modify bq27xxx_battery_hdq_read to check for BQ27XXX_REG_FLAGS and
> value 0xff and convert to -ENODEV?
>
> Well, it depends on the data that has been successfully reported. So making bq27xxx_battery_hdq_read()
> have some logic to evaluate the data seems to just move the problem to a different place.
> Especially as this is a generic function that can read any register it is counter-intuitive to
> analyse the data.
>
>> Or could we just force to set the returned value to "-ENODEV" only when the last byte get from bq27xxx_battery_hdq_read() is 0xFF?
> In summary I am not sure if that improves anything. It just makes the existing code more difficult
> to understand.
>
> What about checking bq27xxx_battery_update_unlocked() for
>
>         if (!(di->opts & BQ27Z561_O_BITS) && (cache.flags & 0xff) == 0xff)
>
> to protect your driver from this logic?
>
> This would not touch or break the well tested bq27000 logic and prevent the new bq27z561
> driver to trigger a false positive?
This change works for my device, but just as you said, this change makes 
the existing code more difficult to understand.

Since changing the cache.flags to -ENODEV manually is only needed for 
the bq27000 with the HDQ driver,

suggest to check the chip type first like below:

        if ((di->chip == BQ27000) && (cache.flags & 0xff) == 0xff)

              cache.flags = -ENODEV; /* read error */


This will not break the well tested bq27000 logic, and also works fine 
with other gauges, and it's more easy to understand.
What's your opinion?
>
> BR and thanks,
> Nikolaus
>
Best Regards,

Jerry Lv


