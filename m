Return-Path: <linux-pm+bounces-7450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CF8BA0E0
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 21:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E361F2128C
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7F161304;
	Thu,  2 May 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4JO+sAeH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493769D2F
	for <linux-pm@vger.kernel.org>; Thu,  2 May 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676708; cv=fail; b=SnRdxnyY3DEzKyk7JXLIL8hyCXn/prGm7nNW478gJRyS0jFgN5hTRPXfer3K6f90+v6Sla29U8RrtiwR95smYoGr6frexRs4HJUSmgOMUQ9bzq+QokhbVg6KD4d/M55K0BkXMM9T9ukS/KKsGJj6UOZYar+LQzeupgC1jQwd49c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676708; c=relaxed/simple;
	bh=o7Y1m3zhMuJzDW+AzDJ2J4MT5j5GNplPFOhrpUxq1A0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMWUhSNHE4UcpozGlVQ9QqOCMYuJ4BEizXDSa18tQopzHnJan4QH1OafxkpxvN8OUwMaioyIIlAlrMNZsH/ev7AdLo/iXRBged6hcV11a2edMTuEF8n8GsN8klfO9L9hiEVjaWNW8KmuUnc665MvOKi+2eXoxKVgUXcr4xeoFSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4JO+sAeH; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3SujgFNTEkUPhvBOpWRVERugXuq9xfEOSodhP6kuG5EjnTuOSErSnb7R86HJ9JnANeiKeyVA/e9x3nKsWmZK4eAFCNQemHIHrcDUKaaBfOqQ+qclQSeJ6q4HBGjz+fh/e7mMYkxP6yqPcgGNrdY9Q0AKgRBOvpKoM5CD/OIPz9KpSp4TNe4Q/5q1hA6ogUY5Q4KkXOVnFyRaIFnAFfz+Ynp+4Yyp+IcUbR3P2ZHJQxURM9K4UJH5rgk14L4NuJ0AiFRoTOZlXb0cs/cNmx7N8owGlsnLp/sC6gjdlNMCtO46MVEaPjsPSnzSy1jaK9IxbNTtmdxzs2z5x5M+VBT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN8L+nx4cOAtYKM9l7AZJOsQENYY2d8m2hDC4crJU+k=;
 b=R3GmfJT2oesWpzk1tssfCAF7IEwokN5tST9gRmwb+TQiSLFE28S+qONrUdQ/GGS6cSl+9hVZgAoxxvcZddW9PDhsK4xfC6i8L2Kq7kIUwB2GFeDmE0AUUZDP0YjuE5aQl42/ueTy4PMvhTOG+GQ5anBw4cvaBVE2tfN30feu41YFcIffpsc6ZWFOdx5rHT3pP9vRE0UUBxFTqmmLymgnf4FWriPF/P+IbgTg5PJvCRz8aVyZMEkk0TK+s7ygpzDWWSn5k8QdOQ0ZpGHOvffx39ZQlNxdh2oxAuV8rcJwORzAmKzP9yqbv+zE/Np9Tvfur2zy0GHzp0yrXp6D9Pfv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN8L+nx4cOAtYKM9l7AZJOsQENYY2d8m2hDC4crJU+k=;
 b=4JO+sAeHWpOAW1nQJtsLQHODGfxp+7eUvD4kKuV3NGjF2j/Map0Cf15z31ywiuiqzRFBK7FVt3j/c/8mTsUPFmWrUtOIOGqvxVsIpprTLSloXnTkX1t1w/yQq0M34b5lirLkzLU0wqiu85OA/UzeV462tixVwp3d50djKHeg9Dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 19:05:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 19:05:02 +0000
Message-ID: <1f7ba471-6d9d-4d67-94d6-17e42a8bae8f@amd.com>
Date: Thu, 2 May 2024 14:04:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: sleep: Optimize the pm_debug_messages_should_print()
 function
To: xiongxin <xiongxin@kylinos.cn>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <20240423081723.412237-1-xiongxin@kylinos.cn>
 <2f07ea21-c89b-49dc-a7b6-8c4e207d1af7@amd.com>
 <408bbf09-58ef-4d55-ba89-a64dbce25085@kylinos.cn>
 <2b4930ea-c8c9-4743-aa46-f387056f2a1f@amd.com>
 <e30df16c-1af1-4d66-97cc-c0e6620764a6@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e30df16c-1af1-4d66-97cc-c0e6620764a6@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: fc61d70d-b1a2-496d-3cab-08dc6adac50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0ZocUFnckR0V0FDNDkrMUVUYVdINnpOT21wN0lsZi95TkltM2lkdUkxRUJo?=
 =?utf-8?B?UkxNaEUvMk5yOFhSZzNtN3dvcGVFTCtCUjdudmxrdHdjOGdncHdaWXRZaytw?=
 =?utf-8?B?ZXZrQ2tqSWF4ZWo4eGY1VUJLSXphZzlXdHp6UDdJbnlVZU1XbmtOSHorZDUy?=
 =?utf-8?B?OU9NTnkwb0xCU21aZHVlWU44M0V1Tkc4M2NZT1pVZEJNWVdkUHYxU1F0WVBR?=
 =?utf-8?B?UjdBbU9xUEI3cC9FY1FMR25iS2Y2UlpqbDBESTFWTWhMZEk4bFQvalNHRDJ3?=
 =?utf-8?B?OHRKUDRKcnRZRUxvaGh1Rm1lMmNydEYzczRvdExxREY3MjRGWDE5Q0FSeUJt?=
 =?utf-8?B?YXBTaUdST05EMUR1TmtxYmlPZytwemcvTGRRT0ZSWUd5YWRXTjhLcU5JaGlI?=
 =?utf-8?B?ZGZiV3NEemo1VXdzUVZNTlExTWd4SnJvTFNjZEZHdE8vUStIc3NwamM4dHpR?=
 =?utf-8?B?R1o1U2ZnMXF2aEs2YUN4dWVJbXNaL1pmMFJiZ2JBTjhOUk1PSFU3cDU3dUs3?=
 =?utf-8?B?MFV2ZlBwQU15SVhoVVdOUVUzQlQwclNKdEdiVE1oU2g5MlpFVXQ4ajgyN1Zm?=
 =?utf-8?B?MEN4RWFmVGxSYnhVUWpmMHErM1c1U3MxYytQckVuRktCVjlOOXZXY1JlVTJK?=
 =?utf-8?B?a3U1aXV2bEhmb2F3QWlESXE1WDFQR2ZjTEpNZ1B1TWNOYnRSa0lDbUlmVTR3?=
 =?utf-8?B?b2dScjF4ZUxTZ0QvWE5xRU1EUUZ0bzBXS1oxcHgrdTNaRCtBVmpXYVpoa25I?=
 =?utf-8?B?azRNUzRLeTk0ZDBZYUZkYmppSW85cjZqOGhHWG9ZNlk3aUUvOGh5M0xTSUZ2?=
 =?utf-8?B?MFlrSXJtajlQczBxaWxodng2VzVTS1p3VkNWTVlGV0Y2ZFhRdUp0UFl3V21X?=
 =?utf-8?B?cGtaZG9oUVdneEJ5MmN4dENEcmxab0puVG92SGZpdlQ0Z1lITGVWWFFObzBs?=
 =?utf-8?B?WEJXSzlodkRhZ1UvS1RmYVVmVFgwNmU0L2Mrbkh1QzdZaHlIdEdtN3F3eHpq?=
 =?utf-8?B?K2VyUEVRSi9tamFHaWFRZThjSVlhbHE0eU9jU0l1NDZHa1p5S09hVEMydW42?=
 =?utf-8?B?V3pvV2dUNVorOFh6MzBSY2NDaldVQUQzeVFXUExNeFFNdkQ5cWprYk9Kbmdv?=
 =?utf-8?B?dCtLNEFWT0wvMXc4T2I3S2lyMjJQTjhaTUVqOWVRYlR6MUU5T0VxZlhmYWQy?=
 =?utf-8?B?Qmd0RzBjS3MvenRQalM4OEdWODAyeE1nY01LYm9DNDVodFZLWVYwYTdGNzkz?=
 =?utf-8?B?cnllRWRlTE11VGtzdjZrT1dtSU5FY1VzMGgyMEowRjkybmdXckdKNUNDdTk4?=
 =?utf-8?B?NW5sWFQ2OExPcytEUHg4TnR0RU0vbWwyblVuZVU5RTdtbEhLNkttUkdvT21B?=
 =?utf-8?B?YjVZZmt6a2JCWG1XQXFqNlpxbHdCcnBHZlEzK05scVY0V2FNYzBJNDBjd2lm?=
 =?utf-8?B?WC9SM2FlZU9GZFpLbmNTMDdXY2h2UFNQdjFvWHhkSVd3eURDaGY5VXNyQW5K?=
 =?utf-8?B?MWtoOGU4OEFKdWtIOC93c081WERwWndSUnJQeDhaR0NnZVdWSVpjclhQbHV4?=
 =?utf-8?B?OGgzRjl4REs0dWl5SThkckdVd3k1V0YzNi9rbnR2NDByMmppcWd1THlpeDUx?=
 =?utf-8?B?K3VrclIvbE4yNVk0T3VvcHR6d2lZbW5pUVRhVm41eXJiQU5nbmNoLyt3akRl?=
 =?utf-8?B?RERQQm9zM2NoSmhKWWppMjhIS0FBMUNHMzVvWDl4V1poQWpRbUNOWmtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE8yM0JESnJRVTdJVDY3Y2ZBS3l4TU8vZFB4eDRxNkIzL2h5OWNHYzFxb3g4?=
 =?utf-8?B?NGp2dTNyK2I4ZldQWHhoRzhWVkZSS0Q0V1hNdnU0d0UxZllTZTR5NDNORDNC?=
 =?utf-8?B?QWJRU1hoRGpaam9rM0UzM3pubE55VmJqdDdCV1NneFNHQ2ZNdG5FdmcxOFJk?=
 =?utf-8?B?cFBrdERvSGRFNDZyT2p2MlR4bVNVeDNyQXMxMW41SVI5SjN0OURxZmxJWW9K?=
 =?utf-8?B?Qk5KUFlSUDBWbHlBOFNmRGxmNDQyMUZPRGRVM0x2WnF6U3BzTlJ2Mzd4ZHFS?=
 =?utf-8?B?OVgrRVVPRjdZc1pvV2pqZFFCS3QrOWdXRHpadG5WM21maGFyZXhsMENoQXVF?=
 =?utf-8?B?d01iYjF6czZIRU1HRHkxTXd4NlJ3c01sKzNXWFJpMDE4V0VXNG82OG4waG5E?=
 =?utf-8?B?bHJpZDhzZkM4Ykc5ZXIrL2FDaFpXWEl5eUwxaXQ0MEZQb1hRMkMyUFJzVGFY?=
 =?utf-8?B?eUllcXdZd2dGbXVoV08xRHdqelFibiszSGY0cUN3d21aajRMYVBPSWNYd2Nr?=
 =?utf-8?B?S01OVXFZRWFlTk1WNEx1UkFMNjZuS0daUUMvS0plUDNFWE9BNEdHQ0IrYzBM?=
 =?utf-8?B?eldTME1BcnB3MzZvYWJJbWk4bjF2dUp6WG1SZ3pTQk93Ryt0MnF4N25wTkJ1?=
 =?utf-8?B?U1lrY2RDY1dJNGZJYVdlZUtxR0pieFh2cmFVb3FZVENBUEZIMm05QU5qUUpJ?=
 =?utf-8?B?a3BoVXN2Vm0rV3JrZW5KSjZrOVVUc3FQMDJtbzdOWDZIclBQeXgyZGdSWkFz?=
 =?utf-8?B?Y3hQRUhhNmNSZTY4UVNEVDl5NU9IeS84RmdNVXZHVmgrK0ZGTjNDQjg4VWhP?=
 =?utf-8?B?N2JOcFZ6a25ORmdRVi8xSU9wYkVSWjBpZU55cmY5d2JuWUdVOGZhV2VrczAw?=
 =?utf-8?B?UDc3dHdTeDJlTjArWjNPOU9wZTRpaTNtVUNuSzErRzN4bnMrU1dIOEVQQkFt?=
 =?utf-8?B?WjhyZ0w5cllXYjhKc01YOWRLaDhBRHhTanZrcFZrUTlXckJmbDh5Z0loWm1M?=
 =?utf-8?B?WnBKUXVSS3BBekxmQWt2YnA3WG8vRGZ0VGtwM01OeCtXS1NFOWU4T1p4UVNk?=
 =?utf-8?B?NmpPeWo0MkR2RkhjQW94THVQU0Y2WGJmTnlkN25RcTdCSHZ1Q2J6NkNIRE9J?=
 =?utf-8?B?TE1WVXduQ0N6R0d2QU8wa2FweGRnZXZ4eU9hUk1ic1BSTGg4TGhscjNFa3BP?=
 =?utf-8?B?WFdVS1NLMkk0aDM1a1Izb2E1aERlUTM0Nkd3SCswUU1rQjV1ekhRRTkrSVlt?=
 =?utf-8?B?czhnUmNzVElYeVo3RmtoS3pPeU9ZTXB5Vis0Vmc1Wm9CVmlnV3Y2UmloU2Rn?=
 =?utf-8?B?U0F6VGErUjVLZmU5UG1WbU5NdG5oNHZobWRBK0trSXBRVTZHdyswUURrd2Vq?=
 =?utf-8?B?YzMybGluRVJZQklKMStDSDJaM1hrcWhYNHRkTnN4aXorYjlxZFk4aS9sUkZS?=
 =?utf-8?B?MkFSa09OTDBwKzhSUG04MmpQd1lFV2E3TktMMUNDVGdKSFdqeEpIaCtsL1NV?=
 =?utf-8?B?cUlndmh5c3o5TmxlMWljcm1DbGZqUXl4cXlhaUpXSHkvblpHMFlJZngwY2o2?=
 =?utf-8?B?SU5HTm1OK2tvMFo1UWJZSkNlWkFTNHhtZmtjelZBNWZPTkJ1aXNRY2tjTWdk?=
 =?utf-8?B?TllkNDJ5TWJodHZhNmxaQ20vQkY2dHBqSEJyNmVUTVg4NlUwMGJXcmRwdjB3?=
 =?utf-8?B?Umo3TWpieXNOQjFiMWpkZDE2b3NyVVNsd214alRVUkxMbVR4aERrbUVobm1Q?=
 =?utf-8?B?elRza3lYYVcyMDhZQzQ1NWFWSXU1UG1QRXJ1b1ZwSEEzd0N3N0NaK0RiaUpn?=
 =?utf-8?B?TFNPOUJFUlZoYjcrb2NvTVFodXQ4MStZc2gzbk12RGxla0d3cjltWjBLMjlD?=
 =?utf-8?B?N29ZcHpjNm5ISmlMU3I0eGFHd080ZzlleVEwVnpUWHEvcllvMFNlZ2JoU1kw?=
 =?utf-8?B?WC96eEdSYVlVcVNEM1hEVGNuaVBZWjFDajVaMmVNYXdtNkh5YUxBNW9UZXFh?=
 =?utf-8?B?L1NKU3dhUHkzTEU2UlJoZjlTa3h6clNmQUhKajFxdDB1Y01MVzljam0xeXp2?=
 =?utf-8?B?S0lzL0dsVHB2S0tjaWJNcTFVTUFlV2gxRm1qbnZsdGNqNU5qdUZUYUhadXhW?=
 =?utf-8?Q?mVE7n/9bLM/Rr/bAhU/W9CbbM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc61d70d-b1a2-496d-3cab-08dc6adac50c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 19:05:02.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/lxYlUB0NJ50kprbLIQ7yd9yHw5u3l+MNZ29ll9zItb+pozlvWdMPLGRs/e1BAFh6lwn1alZHazjC06zyPGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359


>>> Can I change pm_pr_dbg() in amd_pmc_idlemask_read() to pr_debug() 
>>> based on
>>>
>>> pm_debug_messages_on condition?
>>>
>>> I suggest not adding a new variable to this.
>>>
>>
>> I don't understand the opposition to the new variable.
>>
>> The whole point of /sys/power/pm_debug_messages is so that it's a one 
>> stop shop to turn on power management related debugging at power state 
>> but nothing more.
>>
>> You turn that on and you can get messages from the core and also any 
>> drivers that want to emit messages during that time.
>>
>> If changing drivers back to pr_debug that means that users and 
>> software need to manually turn on BOTH /sys/power/pm_debug_messages as 
>> well as dynamic debug for any power management related messages.
>>
>> Whereas if just adding another variable for a condition then just turn 
>> on the sysfs file for any hibernate or suspend debugging.
> 
> Your patch makes the output of pm_pr_dbg() based on the values of 
> pm_debug_messages_on and pm_suspend_target_state; However, 
> pm_suspend_target_state's impact domain does not include enter_state() 
> and hibernate processes;
> 
> The patch affects the output of the sleep mainline debug log, which is 
> very unfriendly to others developers, and it is even more troublesome
> to add a new variable based on your suggestion.

Why is adding a new variable more troublesome?  We're talking about a 
one line change and then it can run in more power management situations.

> 
> The kernel already has a log output solution based on the value of 
> pm_suspend_target_state. I will issue a repair patch as follows in
> amd_pmc_idlemask_read():
> 
> if (dev && pm_suspend_target_state != PM_SUSPEND_ON)
>      pr_info("SMU idlemask s0i3: 0x%x\n", val);

But then this is going to be really noisy still for the general purpose 
users.

The point of pm_pr_dbg() is that it only outputs the debugging message 
when /sys/power/pm_debug_messages is set.

99% of people don't need this message, but when someone comes to say "it 
doesn't work!" changing one sysfs file gets me a lot more data about 
/why/ it doesn't work without compromising everyone else's logs.

