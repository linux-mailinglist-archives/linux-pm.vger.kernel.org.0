Return-Path: <linux-pm+bounces-25502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BEA8AE69
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 05:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78ABE19018C1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE31BDAA0;
	Wed, 16 Apr 2025 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AdCCtZYb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D12DFA22;
	Wed, 16 Apr 2025 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744774180; cv=fail; b=L3t5mdcygGBtra0KhGTBsUKyJkUjArGQGuRCcOja3gPzEr1xqwp/U1cFpAjGb3gNnRzQlYPAyzq/ivlGRdevrepO6FlADtdBUdKe47PRxKVCn9Di7MJob3HfgvIB8hR5hOCKVD3OMNXGjt9MqqmRfZWvyxPCSyw4/UMuwYIViLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744774180; c=relaxed/simple;
	bh=MYCc33Q6NNV4OPwPEbjvRbctLK3DHuP99hNWhPg3Eq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRiuA9JYKXwA7doXCN+IvL1+d78sb9ckK2WfR8BlG4okTA1ne+4DHkAGtYmvMvep2Yk0anGeZMwn19uBHNU0OUTLUm5OgHsvooDfGz+mgFH0qwBt7YMpFVXmy/7cyyLEjvfe8t5SkTVBiQxI+lNxG81n0yBlTABnD3agivvnzbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AdCCtZYb; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPCecfA54NW/VGdhzSkOPcyGrw00UC8ohorhRUf9tkwMq3RxGeOdPmrHEnJy3lNUEBzbm4IeJ1f6BGFXNftWkSdLy8H+po22KwDZ+Qk+9IZeOfDiE9f9uecgvN1VjZcGN08VrhQy/+jpxGWgmvvhO5Z4OfpEyrRRvrlhs+k8dj6S3Ln6Nw52ioqljzm95lHnaX99dUIouoS98FPgFPyUXwzr8rC5JWo0ukGVhLldbb/CPVRd+G90qj4D+zN3GEqOwRqbNTsRQHplmpaUjYYA+QEaHgM4QExoCtVXaGdIotNFvdIVo3orSnNxe001iRTxmGW5UE/CNVplFoaVliqZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3baI6C0ly3ECMCI14lO3zr2QCywtO+bhNgZfnMNb+uw=;
 b=Rgo7d39PZbvHdojEBIGs03Pygqrrb9bKiSozb39JD+dfruN01gDNLvgkevQd+y6JWqvN7PehTgdJeC/5ojKJHtQ0GBeFze0GZXNCBjt0SFxvVdD4vlT5gTWB+8CUhmhY3KS/uuhQohzHd2dbHduCpJki+IBr3j7nIsPDGj7jpsbOP75hjJ0EU0rQYRSd5K//TRiGsihxEpQJqSyCKZFSkH2Fu8AxWpVdefX5xsGU6/buUnIBQNdZ3OTRnIxa+G/B459V8iXZc7XcOabOVKo5UaHM3esZFy0YhiNdxE/RPnjO3hYLxq3OkznQTiDgCHHOwmDXiiypupPSTSQIspzovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3baI6C0ly3ECMCI14lO3zr2QCywtO+bhNgZfnMNb+uw=;
 b=AdCCtZYbsS7mhCLMOBwLcaVmjV1iJb1G4lnGCwctf3c7a6XMdz5njiHMB0JtKidrpclWudLwuwt0vWpTDS5oCD92OPo8dBMgN9ue4oKkC7XfKms1sgED9cbPuWW0SA2wLu2gcqIovBnKfRoTEYe0d/6mbveE1vrTjE8LOxU6su4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 03:29:34 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 03:29:34 +0000
Message-ID: <7067d5db-2997-4de2-a4c7-85f8167cd567@amd.com>
Date: Wed, 16 Apr 2025 08:59:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Add support for the "Requested
 CPU Min frequency" BIOS option
To: Mario Limonciello <mario.limonciello@amd.com>, gautham.shenoy@amd.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415102118.694999-1-dhananjay.ugwekar@amd.com>
 <20250415102118.694999-3-dhananjay.ugwekar@amd.com>
 <1f8d08e5-8bc7-4a1a-a00b-505394a451bb@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <1f8d08e5-8bc7-4a1a-a00b-505394a451bb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: c826623f-4fb1-4e56-9b1e-08dd7c96e88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJNdE5vTklaR0ZYRjBPVXRIZzhiMDZ3NytORGY0ZGo5QU8xaGhCVUZGUjFM?=
 =?utf-8?B?Z2d2ak1FbHFPckduZXU2eHhVa0lrdEFLQWpXQ1FHY2xGdDhQZDgvRjVRMlVO?=
 =?utf-8?B?T0t3SDFNS0JITEM3YXlqVDJHM2JZSmJhS2JaR0lnUXdUY1QveCthTHZObTNW?=
 =?utf-8?B?Q21mc25BNWZFQ3UwWjJrNTFEeHZ5YjlrU2Z2SjlERDJ5MTBLSU4xdGtQTHQ3?=
 =?utf-8?B?M1FqWi9IZFFjSEdyMVFrQVZhWitDREY2Z0VtL0kycHl1VlBYMkR4Rkg5b3dE?=
 =?utf-8?B?ZXhYdUpjQ21OaitJYW5nN2JUVWpJNjBDeDV3VWZHNWgyWnVmK2JwREF0bEk4?=
 =?utf-8?B?a0FvSFNtWUEyTVRvdmE5Q1AyWHB2dUlWWkY4OTVHOEdLTmd1U1dDSjFzREIv?=
 =?utf-8?B?UGg0K0l3THZxcCtpcXByejBjRmc5WExiZ1FROURoam1qNENOeVc5REdsdnVX?=
 =?utf-8?B?REtGQlZHNzBlSlQ1TFN1ODJLYUhrc2d1YWNxdGpXNFN1eVBTNTFFa0VWK0tB?=
 =?utf-8?B?blhtdkc3ejhYQmRFM1dKRGwyTzIzOU40T3Fqby9ncDhkekJTNFUwMDB4cmcy?=
 =?utf-8?B?M2owdjVUMHRFZ3pWNXdkT21uYkZSaFg4aXNEczhvNytOVkVPV01BNmJqbGEz?=
 =?utf-8?B?bUtFR2kwN0NmSDY2YktpeGJmVUQwc29wUExKTUUzUUQ0NmRGUEhYUlN5cVdt?=
 =?utf-8?B?YUYrM3p2YkhCb3N3RVpkaHZORVpUU2JVWnR5MEJsMVgzTzF3QjlaTjNyZUxT?=
 =?utf-8?B?TlBEVEEyekZMVHdzd1ZGdHNUaDdVN0M5SThtRVpCTTRJMXlDZk9LSlNsdFJh?=
 =?utf-8?B?OENtQk05MFVrczhOWnJKcHBnQnNPT1VUMHJxNDE5bkQ2RVhEcU55TnRUM0Qr?=
 =?utf-8?B?Y21JWTdpZWlFcE9HWWh3ZEJIMlErYklnTk9JU1dMamJOWWFvZ1J0S241V2pJ?=
 =?utf-8?B?aytsZlc2SDl0ZnF1ZmpaMW9zY2VEa3RLaFlQdC85WllvdHFuY3FyYVZCak1H?=
 =?utf-8?B?TVJBOGF6K0t3eURFUnhaMjNPL1lYbDBMaGdnWjIvb0t2Sjgrb2Z6VFhqMlVE?=
 =?utf-8?B?SmEyNkRCejd4RDBCVk0vNitoMmtpVVVRd0pWc3Z6bTd3WUVveVl6YkFuMWVl?=
 =?utf-8?B?aFFBeU85SXVINXF5WVJ6azk4dzhSNElrSEowTEZWQWRDV3hYZDMvVmJHVjlk?=
 =?utf-8?B?Ry84aTA4NFhEMVh5ZlpuQ1ZhT0FQWHN5eVBEdGloekRBbDE5T3NHalFiUDJN?=
 =?utf-8?B?VHpYYUlWekhiRDFOQUR3dTc1M0k2L2wvcFNzLzd1VWVJK2lxWmxwd25KMllI?=
 =?utf-8?B?RFpZbnY0OGpsVmtZRkZJcTE4bWI2M1h3WGZNMkZ2ZlhNQWFQejlaYzZIS2Fi?=
 =?utf-8?B?WXRzeEtxaUU5Y2pUcHRHRU1heVNJbTlURUdqNVdSZkNxeGxDcUF1WlZvRm1Y?=
 =?utf-8?B?T1I5WUpORVpzSHJjNEFOSWVxc3lZUHA2QXVkNFVQNnpwUjhTTEgwSlc5TTBr?=
 =?utf-8?B?UzdmT1RoT3g4K01QTjZBSnJMOEJCaTVuVGVVckw1djdjbkF5bG9zeVBLV1oz?=
 =?utf-8?B?TWo1ZHVHRUFvQStaWnRlRVpFNmRYTDl2ZHhwdjBpMmdoa3ZjQkhDcU5CM3lR?=
 =?utf-8?B?Z1JwUExuMDlKYWk2M21kekplWmdlYitTTXlTQW4rVDBFNFhiMGxhbDZ5SldN?=
 =?utf-8?B?Ly9yRFdQV3NEeld1NlZWbWsyY2lZNWhUQXZwY2JJeFVhVGkraC9BbG9sQVNV?=
 =?utf-8?B?K1BIUmNpZ1pFMFhvZERmNGpWN0tLWFYvbWpFMVI5Y0pHdUU2RVVYR2pUTHJw?=
 =?utf-8?B?YXhtSWVDeGM4T0ltTFZFYmlLb0cwZUNoYU1OL2szN0hVSlhHYjMrZmxrejhJ?=
 =?utf-8?B?QWdBTC9RN1crUlRycVBvUDI3dGZoSktKaHkvZnc0ekVyM3ZFTFNsbEhLaXlO?=
 =?utf-8?Q?2lzVmkHq/eg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxmQndvakZpWTcwMzFaeXRYUmFLQnFDOXoyVHB4YU4xQ0RSN3pzYVlWWElO?=
 =?utf-8?B?eml5Z0N5VWNZWFdBVWpyeGpRTHozY1ZEdS9CQUR1ajJWWkgvTlBRR29mcWRL?=
 =?utf-8?B?bDdneTN3UlhRK3B4UUJnbkhzWXQxWk1pVER3R1dSTG53QWpONlJFck1jNmV1?=
 =?utf-8?B?bEhrZ3VQWEhwTUlvQ3psVzcwaTVKTGVOeGd6SmZ0SGpQNGZhRnp4blVzbXBD?=
 =?utf-8?B?UzRoNCtNdFZBbUt1d1JDQnViMi9XSC9oOEhyVzU5RlRUSjNGSmswa1pqL29z?=
 =?utf-8?B?elFDUHFhWU9iZkpMaGpJVUlWK3BYUEdVbzB1dFg5aVd4Y04yTm1lVkY3d3h2?=
 =?utf-8?B?YU5QWjM3OFYvbjJJYlBDVCtBL2F5S0E1eUtMTjNhdDFRQ05NTUtIWjIzVXRz?=
 =?utf-8?B?UkZydXNJL3pzakNWUXc5bk5BbER4YWFwUFVUT1lGa0JKMTFMdTNTUFdzYmhx?=
 =?utf-8?B?WUF1S3FrRGJlbkswVVoxVFRWSm1MSHdHamlCS1ZjS1VEMFFUUHpNQ2lCSFh1?=
 =?utf-8?B?Kzk3QWJjMXZrc29PaDd5RTdCcVFyZEJ0N1NlcURzOHRlTCt1YVpvQ2ZUem5J?=
 =?utf-8?B?ZUcyNklMTUVCM0pQUHpPZWJrYnRrMGNSOHJjVTRwMmU0TTdRY0pDcklhd2xp?=
 =?utf-8?B?SmIzMzJORkJWZGFKVnlmLzhGSmNBMXEyaHlwS1VyZDIzSnk3em1kUHY5eDNB?=
 =?utf-8?B?cHJETktRcXNQUm9iZSthOWUwWEhvWVBrSjZyMlNlQ0tsb01OMGpiM3VPb3c4?=
 =?utf-8?B?WnJ4U25QYjRWQjRpYWlTUEc4TW8rUnBxemRDOW55eFV6cEFuaTBwbGxwSHNm?=
 =?utf-8?B?OGlIeXZZQWt4Um9wWXVHbnROTjN5Rjl0VXlrYmVXWHAyYnJZVjhlRHZLSHhM?=
 =?utf-8?B?Z3E3c3pOREF6TkZETC84YlUwdzA5VTQxY0c4SHBYcldMeDhWS0x3SnV3Zk9u?=
 =?utf-8?B?Ny9JU1dCL1pSZURhNktzV3lvdHJiVDNzbUJjSHpEMmRKenZmMDdOT3owRFY2?=
 =?utf-8?B?cS9HeEZuTHg5RkxDU21peVhUNXVNdTJOTWcwS3RubnBqS2JtUlp2NzZYbjNU?=
 =?utf-8?B?cGR0UXJYdUVHT0tZUkhiTGx6QUI5OXdYeGFzVnNvMmtzTnFRbWZ2V09lblRi?=
 =?utf-8?B?MFdybzcxeVNMUmNvQ25ocjIvbUE0eXRwNFhXS25QeWNNWkgyU2M0QzBzam5x?=
 =?utf-8?B?cVE0dXNRUWFmREdYWWE4YitKU0FkU1RWVk1kaG5hM2V5WW12TFBsMEsycjlQ?=
 =?utf-8?B?cGpKT1FDUnRRMXMwYUVTVjVyeklTQTNWV3F0VDdaK3V2bnpQRXNrMndwTE9p?=
 =?utf-8?B?dzlFaEx6UTlhYjFlSGJwZE80VU5KSDMzZHh0Nkd0UUtPbm1za29VZ0Z4aVZQ?=
 =?utf-8?B?b2s0dlVQRFlRMWdsTmhIa2NkZURCMlA0SHh2UHVZaVFpSnVTQ0pRcGxvZ1hU?=
 =?utf-8?B?b1AvQWFHcjQ5VjczdmswUE1tMFNPbksxckk3d3FHNVVoMUdoRE8wUzZQVWpk?=
 =?utf-8?B?T2RhRUZuSHdKeUJzUFNHbU5wdElZUU4yeW5xZWhMNzFJQlErTWt4bEF3MjJI?=
 =?utf-8?B?ZEptcVRpNUl2ZmFQV1VXbngxTXVyWk40TmxYeXhHWkJtTmtubFlHQ3JzdXJl?=
 =?utf-8?B?R0tZTzBCTDRXUEdSNDM5NnBVWUFBZWhoMWl2Z2ZVbWhzRnAvRTdHY1NQK09O?=
 =?utf-8?B?bS8yS2FTSE4rVERCSG84empLc3ludXNQOUd1bFFjd3hzeWRzSXRrd0ZvQjlz?=
 =?utf-8?B?MmVRVWRpa1JIQ1JyZHdSZ1MzVGhRbWdUZWx1L250WEFoNTAvZUg5M3BoL3E4?=
 =?utf-8?B?YTZEYkMxY01UbjMydlh3QTlDR2RPd2gxQTgwRmJUVUpXc21uSTZyT0lXaStR?=
 =?utf-8?B?c2hqRVJrK2c2clR5T3IrSzh6SDdwSkUyQTNMRER4NDRGZ1BTUVFSU2FwdFFn?=
 =?utf-8?B?cWJjSnNDeFRibXNVN1VPQ1FvN3doSWxReHJUeUZVWjFQbkt3d21RYUNGekxJ?=
 =?utf-8?B?S0xuRTVYZ0hXK3RVNW1nMEEwb0trS0RBSUtqcXlEbUNhb1REZFRLVjNFanJJ?=
 =?utf-8?B?NDVOc0xURkdnejdmclFtaXZPMTRnYkdSbE1zK1grN0lDNS9oODRoWWtjN0N4?=
 =?utf-8?Q?SQM7H9AcEC03FmC1SDSIzQVlo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c826623f-4fb1-4e56-9b1e-08dd7c96e88c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 03:29:34.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgYOHNhbsCiko6Rh4CWFSDyHpdzwGHVyJVsvXXvsQ6byzc1QZHI5GmQ2z5LNvwf8dNYX71eW1j5RQTHw/q5LzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705

On 4/16/2025 2:24 AM, Mario Limonciello wrote:
> On 4/15/2025 5:21 AM, Dhananjay Ugwekar wrote:
>> Initialize lower frequency limit to the "Requested CPU Min frequency"
>> BIOS option (if it is set) value as part of the driver->init()
>> callback. The BIOS specified value is passed by the PMFW as min_perf in
>> CPPC_REQ MSR. To ensure that we don't mistake a stale min_perf value in
>> CPPC_REQ value as the "Requested CPU Min frequency" during a kexec wakeup,
>> reset the CPPC_REQ.min_perf value back to the BIOS specified one in the
>> offline, exit and suspend callbacks.
>>
>> amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked
>> as part of the resume() and online() callbacks will take care of restoring
>> the CPPC_REQ back to the latest sane values.
>>
>> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> 
> I'm generally fine with this, but I have one nit below.
> 
>> ---
>>   drivers/cpufreq/amd-pstate.c | 62 ++++++++++++++++++++++++++++--------
>>   drivers/cpufreq/amd-pstate.h |  2 ++
>>   2 files changed, 51 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 02de51001eba..d94fd2a38990 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -389,7 +389,8 @@ static inline int amd_pstate_cppc_enable(struct cpufreq_policy *policy)
>>   static int msr_init_perf(struct amd_cpudata *cpudata)
>>   {
>>       union perf_cached perf = READ_ONCE(cpudata->perf);
>> -    u64 cap1, numerator;
>> +    u64 cap1, numerator, cppc_req;
>> +    u8 min_perf;
>>         int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>>                        &cap1);
>> @@ -400,6 +401,22 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>>       if (ret)
>>           return ret;
>>   +    ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
>> +    if (ret)
>> +        return ret;
>> +
>> +    WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
>> +    min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
>> +
>> +    /*
>> +     * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
>> +     * indication that the min_perf value is the one specified through the BIOS option
>> +     */
>> +    cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
>> +
>> +    if (!cppc_req && min_perf)
>> +        perf.bios_min_perf = min_perf;
> 
> To avoid a risk of garbage being in perf.bios_min_perf leading to hard to root cause bugs could we initialize this to 0 in the non bios_min_perf case?
> 
> something like this:
> 
> cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
> perf.bios_min_perf = (!cppc_req && min_perf) ? min_perf : 0;

Agreed, better to be safe, will amend

> 
>> +
>>       perf.highest_perf = numerator;
>>       perf.max_limit_perf = numerator;
>>       perf.min_limit_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>> @@ -580,20 +597,26 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>>   {
>>       /*
>>        * Initialize lower frequency limit (i.e.policy->min) with
>> -     * lowest_nonlinear_frequency which is the most energy efficient
>> -     * frequency. Override the initial value set by cpufreq core and
>> -     * amd-pstate qos_requests.
>> +     * lowest_nonlinear_frequency or the min frequency (if) specified in BIOS,
>> +     * Override the initial value set by cpufreq core and amd-pstate qos_requests.
>>        */
>>       if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
>>           struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>                             cpufreq_cpu_get(policy_data->cpu);
>>           struct amd_cpudata *cpudata;
>> +        union perf_cached perf;
>>             if (!policy)
>>               return -EINVAL;
>>             cpudata = policy->driver_data;
>> -        policy_data->min = cpudata->lowest_nonlinear_freq;
>> +        perf = READ_ONCE(cpudata->perf);
>> +
>> +        if (perf.bios_min_perf)
>> +            policy_data->min = perf_to_freq(perf, cpudata->nominal_freq,
>> +                            perf.bios_min_perf);
>> +        else
>> +            policy_data->min = cpudata->lowest_nonlinear_freq;
>>       }
>>         cpufreq_verify_within_cpu_limits(policy_data);
>> @@ -1041,6 +1064,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>       struct amd_cpudata *cpudata = policy->driver_data;
>>   +    /* Reset CPPC_REQ MSR to the BIOS value */
>> +    amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
>> +
>>       freq_qos_remove_request(&cpudata->req[1]);
>>       freq_qos_remove_request(&cpudata->req[0]);
>>       policy->fast_switch_possible = false;
>> @@ -1428,7 +1454,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>       struct amd_cpudata *cpudata;
>>       union perf_cached perf;
>>       struct device *dev;
>> -    u64 value;
>>       int ret;
>>         /*
>> @@ -1493,12 +1518,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>           cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
>>       }
>>   -    if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>> -        ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>> -        if (ret)
>> -            return ret;
>> -        WRITE_ONCE(cpudata->cppc_req_cached, value);
>> -    }
>>       ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>>       if (ret)
>>           return ret;
>> @@ -1518,6 +1537,9 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>>       struct amd_cpudata *cpudata = policy->driver_data;
>>         if (cpudata) {
>> +        /* Reset CPPC_REQ MSR to the BIOS value */
>> +        amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
>> +
>>           kfree(cpudata);
>>           policy->driver_data = NULL;
>>       }
>> @@ -1575,13 +1597,27 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>>     static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>>   {
>> -    return 0;
>> +    struct amd_cpudata *cpudata = policy->driver_data;
>> +
>> +    /*
>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>> +     * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
>> +     * limits, epp and desired perf will get reset to the cached values in cpudata struct
>> +     */
>> +    return amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
>>   }
>>     static int amd_pstate_suspend(struct cpufreq_policy *policy)
>>   {
>>       struct amd_cpudata *cpudata = policy->driver_data;
>>   +    /*
>> +     * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>> +     * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
>> +     * the limits, epp and desired perf will get reset to the cached values in cpudata struct
>> +     */
>> +    amd_pstate_update_perf(policy, cpudata->perf.bios_min_perf, 0U, 0U, 0U, false);
>> +
>>       /* invalidate to ensure it's rewritten during resume */
>>       cpudata->cppc_req_cached = 0;
>>   diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>> index fbe1c08d3f06..2f7ae364d331 100644
>> --- a/drivers/cpufreq/amd-pstate.h
>> +++ b/drivers/cpufreq/amd-pstate.h
>> @@ -30,6 +30,7 @@
>>    * @lowest_perf: the absolute lowest performance level of the processor
>>    * @min_limit_perf: Cached value of the performance corresponding to policy->min
>>    * @max_limit_perf: Cached value of the performance corresponding to policy->max
>> + * @bios_min_perf: Cached perf value corresponding to the "Requested CPU Min Frequency" BIOS option
>>    */
>>   union perf_cached {
>>       struct {
>> @@ -39,6 +40,7 @@ union perf_cached {
>>           u8    lowest_perf;
>>           u8    min_limit_perf;
>>           u8    max_limit_perf;
>> +        u8    bios_min_perf;
>>       };
>>       u64    val;
>>   };
> 


