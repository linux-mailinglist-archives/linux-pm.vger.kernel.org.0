Return-Path: <linux-pm+bounces-26215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2FA9C8A0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B1D9C0D39
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABC2472A4;
	Fri, 25 Apr 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QSI6zs+7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2080.outbound.protection.outlook.com [40.92.18.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60123F296;
	Fri, 25 Apr 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583129; cv=fail; b=nmkgQxxdGx9b90TZUx3c+eu+R9L178VKGsanjWt6xmexjZgjMhJA0ujXMpIGzzVdWYx86m4Yerx7/ycMkcbgmkxlTHESlWKhmb8mC5IZuanom4yck8lDh/Yl1cYIHfChuOy4j7w8w4U2v/F+XfA/gY3SDRenA0iLWAv4jv1I0HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583129; c=relaxed/simple;
	bh=7qhHimJ48XakIQo9LE9lJrE2DUcFNjWcsFvFO4uMe4c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuN7viU8f0YXqiEr4CwgcFzrhNCROvDJD28pPYZwFAGQr7fwLnxtKgpBJRWMZadw4ZV7U6DUUQUK+vivDsZwGLRNkbJ6ihg9YiA9ROCvu64dFXYhhxGaD939euegW0/lBUBHiDtV3Kmz/MWWIlIOUoZCswg+Q+ocjeitRbIE3pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QSI6zs+7; arc=fail smtp.client-ip=40.92.18.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRWjpdOqcjmSIADks3k4sRWKlNBwOkcowmagedgLjbJKAZ/UtZ6oQNFhgrm7K1mjUA7+3FqRpkOXN+CAIw6iN3mHDYwl6mr0jZfQWW3EQgDUilFJzq7SVy6euGFl1oFNy1WF2gY28J+t/pea1qkuA/83fUKpp57PfmkcYTr5MVzMZNCQpsogpP148f7wn+pKC4r0Q7IRagl6oFTdpDo8N6hRPxQylNeKKNAamZRJ5b1j7LROzlV+K8RMrPpymRHNyn9N05CydENIkAbnXUQ3LI3SGh97VUIF7IM+VE+Os40KGmHUZu/oqq97re5/hlu1vxTdASG364xFr/KetKL4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+dNeClMlX3Qw5Ds/iIbpxSyvHEemputFVrghNirlKE=;
 b=yQ6ZOSjDO5yPDaRcsqm5bagbOQd9ZHivxg0hBSr0S6ccc0zrLdr0ac3o5XN2tW/S9T1xE9mSEQrEG/EU5mjw/zae1V1O3rVjC1cQrXAXJ3MMR0I50y9+Y2fRBhODKlt9WpV/QzJB1lgt75/u78Yl6OlarK0vdgW7uMhOOfV9Aq3aWQUl4UPNyIytDlgpqK12GIPUpOsjC0n4SjGTJgbqlgau6zZVvAkvQtH5Fpk+5zdxi4OHtTAacytLLyFws1nTC1bNAzOKOT+j4KWXaIJrrlVc3UygPIeswKPZAP11I2sLDvpvQ64DUYghzqSLXCpdOQhApuzt16Gjcvx3Q9DJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+dNeClMlX3Qw5Ds/iIbpxSyvHEemputFVrghNirlKE=;
 b=QSI6zs+7afg8vEHEd60BfJqAWJA8tLbtPs8RhgMS+pfRNOcZmWwVk3IXeyhiNJRgClLoJcBmUjoE3Exvs3b/ZUKNhIxWAY1PIrWUR+1K0L8f85yf7KV0xtS7bEQHNZZU12R7BjoY3ZYxgxatuUs13LV/4NVZgeVqaKe2jx+Evr3M/03iTA1EjgvPpv58r/xepFCH6xYbFHIpjRd/E3hnLAW8v84lEttTS8mraW1Q8KxxCio65ySTKQYhHl5/+3Ryjs3Nbz/rIu0Fjj43KlszOaxJ8jqCHQlSiP8u48k14ZYuhP8WvoW4JJxKcH4dja+XSGg7bNv7EGFVY3+M+srwhA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8277.namprd19.prod.outlook.com (2603:10b6:408:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Fri, 25 Apr
 2025 12:12:05 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%4]) with mapi id 15.20.8678.021; Fri, 25 Apr 2025
 12:12:04 +0000
Message-ID:
 <DS7PR19MB8883DD5176679C2C48A61A7D9D842@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 25 Apr 2025 16:11:51 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Add support for IPQ5018 tsens
To: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, dmitry.baryshkov@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com
References: <20250228051521.138214-1-george.moussalem@outlook.com>
 <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <DS7PR19MB88836DC6965515E12D70BB2C9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0032.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <8e571c85-f9ab-412f-9bcd-db6808884b94@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: bc47bf02-6240-4096-9936-08dd83f26407
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|7092599003|461199028|6090799003|19110799003|8060799006|1602099012|10035399004|3412199025|4302099013|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTI3c090UGI2eWorRktkWWVrUjBJZXIyUWppNHBKRzc4cGlmTjRjZ21EZFY0?=
 =?utf-8?B?Z1RwSU1PQ2ppbVRrOHdlK2dMT0ZjK013azlvcW94dGdWdHBzRjlhaVQrcXg0?=
 =?utf-8?B?ZmpNYjgyRTN2STJ2aG01NnowZjM1Z0hXRkFyeFdqKzFaRjE1eG5yRHFTcXZY?=
 =?utf-8?B?WHBLVkV1NU9OV3VyQkFnNnI4VXhXekJMUG00L0gvdllpTWJUenVKY3FDYzB3?=
 =?utf-8?B?UTBCb3N1UVRXOFlzSlRoREt2NGV6UFVTODh0N2w3YlRIV1BpWEQvRGk4UHp0?=
 =?utf-8?B?UHhZVWhBbE56Z1V5a01MRXlrTGFnU3FZdzVqeDVMLzlIMC9MMzdRanNscGhv?=
 =?utf-8?B?YnBkMVA4RTN2UDBheUlWQnk4VlJyTXJoNnBUTmpJbGQ4cXBsakZNc1B5ZTdZ?=
 =?utf-8?B?SG5XWmw0M3FabGFieDhtd3dIek5JWG9aVDVsck9QYmkvVlpmdk5uREZIdWlt?=
 =?utf-8?B?eGVDcisxRzhDRFFpOU9IUkpjQ0ZBNzVkSzZ6TytkU3Y3ZVBLU0xRWXVkZlZO?=
 =?utf-8?B?bmJjYmd4Tk93ZWRvUzRnMnFYQkdLU3hyRVplejNYS2svVXVDWHdWSTJYV0hh?=
 =?utf-8?B?NnVCcnpnQThUWHlNZVpVSmJSQ001RE4xKzVQL0VvWGZ1VHZSS2drR2g5YWNv?=
 =?utf-8?B?Q0g0WllZcHdrZWxQM2VHYit2b1I4TDlZZEMrUEZ5Z0dHdWxNbTZDV0Z2VE4y?=
 =?utf-8?B?RVFnbHZnb2p3ZDZvTDZZd3FSUGZNSDlWdFkyTDhKdUZhZ1IzWlZSdjdWVVIv?=
 =?utf-8?B?TEt3SGtUKzFjcVFRYWxPQk8yU3RhQnVvZy9yVEREazd1NU02TjEzWGJrSWJD?=
 =?utf-8?B?aDJxamh1UEdMRk9LMXFBRXNMVFlveDlmYllKWXpBNSszcEhGdTRvM2pQMGxw?=
 =?utf-8?B?NTAvVHE1amRsbmxXL29IdUk0c3lyKzJmbzVhMlRGRzI2b2g5NjJ6dlY1VUJs?=
 =?utf-8?B?NjZzYzdxRUplTEcya2liaW1DNVRJNytDMlZOZkd2ZlN1c3hKWEo2NUwrVGFN?=
 =?utf-8?B?RmlhZDB6ZjlnMmZYMkxhcDAzRUFxYldtOWJPR3F0Zmx0Y3RxTFVaTVFzYzA0?=
 =?utf-8?B?SUZZUU5ON0kxcVl2a3BjZFpzUkV5YjExM2tSSjNtTU1QdHQ1REp1R0k2S3Uy?=
 =?utf-8?B?eXl6dEs0VXo3N3A3QU11eDVGWkg3b094ZmpDL0JJNVJBTWNwOGYwakNtSG5h?=
 =?utf-8?B?Rm1iZEpBdEZBb29XTlBwejA5aWVnSkM4TFZHSko4bmo4NzZMSmlXeFRmbHRH?=
 =?utf-8?B?NzRuWEtLQVJoNEtDeUhRbnRVRHFZakJYbDQ3TmE5YURGZDZhZG92ZjBMMnkv?=
 =?utf-8?B?cEUvWFpZc1AvNTUvb1NENHdlRm11S2kxTjJZWmNvSGw5djdsZHFVNS8vMThu?=
 =?utf-8?B?ZXdmNGZDUTJrMTRjdkZETE4zQWV5dTNHMkkxTE0rUE1reGxsVkYxdEFlbTNK?=
 =?utf-8?B?ZURjc1RiKzlIMHY0dC8yL1ZyMHhiM0hMTkxaVHZxdGZ1THlBL3BibHpYeXBi?=
 =?utf-8?B?V3VyMW5rK0lCN1BDTW1RSGRyeVZXdFlKZjZURTVjQjVjbXNuYmpBQ2krTkp5?=
 =?utf-8?B?enpReXh6R2l0ZnJ0Q3Y5ZllwYi9FZ25VeHZUUmUrUkNDeHY5YWYvWWhnNjNu?=
 =?utf-8?B?WmNqa3NjaEpNUGZ2dzl5cURvbUpwcXRMdk4xQ2xLckhuRU1ZTGRJUnZwaU9T?=
 =?utf-8?B?dXRScmxOd21YVXh5cUFzWWRQMjZzQzMvVE1pVjFpWnZwcXRQMVBZZ3FQQjdB?=
 =?utf-8?B?bDdFdWhNVXNiNExxWnhyc3VicmZYRGxRMitXZDd0U3pscUcwVVZBR3FCZWVL?=
 =?utf-8?Q?ADrZcv6Z/8InO52cZDQeRX8DpE8p6wWy2x16A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUVqczBQYzVrcVlDakppejdGa1M0bXRqY3RzUDRkRUlwTGdsdWtycFZlNzZm?=
 =?utf-8?B?RjFXMVlBbDB1ZzdHVy9sNjVpS0k2ZUUrME9aUzlUS0x1alh4UnBHbWpsenI2?=
 =?utf-8?B?OW50RmRWZmtmQ05rKzhiUXVaWmE2cmd4UmpkYk1pSURnMTA2QUR1SjB0bHVD?=
 =?utf-8?B?NDFxMmFtWUcwdmRRNEZJa2hJRDhWVWFvTEI2bjRST3FZenZ1MGJkSHNVSlhK?=
 =?utf-8?B?R1VUUlMxcW1xVWROWGJzMHFxL0hoSERtbXY3T2pPekZLWFRsWWhJQk5SN1Zm?=
 =?utf-8?B?eThEUXpYckhqTXFRYitFa0k1WFV0SnYvbXQweEIzSnRGdDFRNXFEY2ZSVTll?=
 =?utf-8?B?ZFZxTjNUSzFjK256REE2d1c3b1pVVmJabGZvMEMrWlZLNjR6dDBGOUphc1BI?=
 =?utf-8?B?VnU3bEhBaEhTTkxBaFdSL2NIU0ZubWlzcVkwZnNwMG4zRkRlcjJaaUlIck5O?=
 =?utf-8?B?bGI0MksxZmJRVVhpRzZWbENCSXRXajZZNVpEaXA3N3ZOc1ljTkZDM3pLOUM2?=
 =?utf-8?B?ZTV0bzhKUklhRUw5VVBzY1N4UlU0MWJZbjgzVHp0L0pHNDlwY0xLUG85b2hD?=
 =?utf-8?B?K04zbHVYRnhEb2pneVpaa0lGZmptVGlWSmVrdGRmY1MxMzNsd0x2ZE53dnBR?=
 =?utf-8?B?WnFPdTFiUCtZSGtGNm1tbkZVYk50ajZwTGFFcUZ1SEt2K3V2N0J6bm1JZnBV?=
 =?utf-8?B?RGE3QlRZc1hJNFJhalBERTJLc0xoNjJSc2Fibi9GeXBRY2tnLzF5K0U1RS90?=
 =?utf-8?B?bGxsbnpUb3VSWXg2WitySkxuaFNlUUUzbG5YOWdXc1NpSTlGcEtBRkJYc09I?=
 =?utf-8?B?RjNLaWxlNWpGQnNvcEZiTGNLZGJMOFlTQ0lNdDRvZnZmL2FETk00M1RFRU9m?=
 =?utf-8?B?VWZVL2lhTCtaSmpXWi9ENXlCbDdScENla0dBeFI5MkZlanY5SmZSNmxHK0Qy?=
 =?utf-8?B?S0R4dzI5SjMwZXdiZkxXdEZiNUhjQ0pEZHFCVElVdWZTbm9pZFZPNlZLRlUv?=
 =?utf-8?B?Z1kzSW04RFJ6ZEVDWnM0MHdab1NsblZ6RDFnbVdlZmpvRlBENitXd0swdEI0?=
 =?utf-8?B?dEU2dnNFSFVQWDhxZGpBaUl5bU95cVN3UHZyY2RhVENVRnY5UHYycG1WUmlH?=
 =?utf-8?B?bGZFNlFpVXVEWkVjdUg3b01MRmN3WHh2ekVUVlN2LzZCWDdzS1FxU1JzU2FB?=
 =?utf-8?B?cE9mYmVOallhSndiVlRkK29HNjN3ZklLT0VFRkc0Y0VOdUQ1eEVnZWh0QUda?=
 =?utf-8?B?NlY5YXhEWm1LMGF6akRXWmxVZmNMQ3BhTUtqYzdUc3RMaUUvdTVzWS9GVzBJ?=
 =?utf-8?B?R0ZxSzlnSDI1MUxjc0QzRkE5MlM3WXZMRVl1OENadEZ5OUtmUEV3N1RSbys5?=
 =?utf-8?B?TjFieVF3dUxKMWRKeVhucDB1QzhCVlBuOXVnZUZMUlRRR1BsQ2dJbHRlTTBo?=
 =?utf-8?B?V05EeVBTUnhoNHk2WGJvS2VaaExKR2daSWd4aGtoMXprUkhNZVRHQ3BGRG1S?=
 =?utf-8?B?S0RSOUlUV2JXWXMwQnZLWWRaM0hzaTBLdjBhWUtHRmVQSzVkNWNIeEs1VTNt?=
 =?utf-8?B?V05QM0JvTHhWcEZTT2NySFhqYnFIbDF5VlU2eE56UXZoaEJtcm5pak1WNlVB?=
 =?utf-8?B?ZDVNTVlaUndYR0V3cGVucERFajJmQXcwR2xYOTM4YWxMYlU0SDBIYmZ3OHNn?=
 =?utf-8?Q?ZDrj743hnWNWaMuH25hq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc47bf02-6240-4096-9936-08dd83f26407
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 12:12:04.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8277

As FYI, as I don't see the email that was sent on this main thread, 
patch 1 has been applied by Srinivas on March 7 (thanks!):

https://lore.kernel.org/linux-pm/174136704062.10922.6561617829094107048.b4-ty@linaro.org/

[1/6] dt-bindings: nvmem: Add compatible for IPQ5018
       commit: eb7eeabf64d2b2ea3ae562e85f09fb2593a6da2f

On 2/28/25 09:11, George Moussalem wrote:
> IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
> and 1 interrupt. There is no RPM present in the soc to do tsens early
> enable. Adding support for the same here.
> 
> Last patch series sent by Qualcomm dates back to Sep 22, 2023.
> Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
> and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
> confirmed this SoC is still active, I'm continuing the efforts to send
> patches upstream for Linux kernel support.
> https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/
> 
> [v9]
> 	*) Updated checks in tsens to more strictly evaluate for v2+ upon enabling
> 	   v2 features as suggsted by Dmitry.
> 	*) Split patch 3 into two, one to update conditional statements as
> 	   mentioned above and the other to implement tsens IP v1 without RPM.
> 	*) Added back Dmitry's RB tag on patch 6 which wasn't carried over
> 	   from v7 to v8
> 	*) Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v8]
> 	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
> 	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
> 	   v1 interrupts are set and watchdog isn't enabled.
> 	*) Tested on Linksys MX2000 and SPNMX56
> 	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v7]
> 	*) Updated cover letter
> 	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
> 	   no RPM and removed Dmitry's 'Reviewed-by tag
> 	*) Refactored patch 4 and split support for IPQ5018 from support for
> 	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
> 	*) Depends on patch 1 and 2 from patch series to add support for
> 	   IQP5332 and IPQ5424 applied on Feb 11 2025:
> 	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
> 	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v6]
> 	*) Include (this) cover letter
> 	*) Picked up Dmitry's Reviewed-by tag on patch 5
> 	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v5]
> 	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
> 	   which 4 are described and in use as per downstream driver and dts.
> 	*) Padded addresses of tsens and qfprom nodes with leading zeros.
> 	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/
> 
> [v4]
> 	*) Documented ipq5018 in qcom,qfprom bindings
> 	*) Constrained ipq5018-tsens to one interrupt with description
> 	*) Added Rob's Acked-by tag
> 	*) Added Dmitry's Reviewed-by tag
> 	*) Fixed modpost warning: added __init to init_common
> 	*) Sorted tsens nodes by address
> 	*) Sorted thermal-zones nodes by name
> 	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/
> 
> [v3]
> 	*) Added the tsens-ipq5018 as  new binding without rpm
> 	*) Added Dmitry's Reviewed tag
> 	*) Fixed Dmitry's comments for error checks in init_ipq5018
> 	*) Ordered the qfprom device node properties
> 	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/
> 
> [v2]
> 	*) Sorted the compatible and removed example
> 	*) Fixed the name for new tsens_feature
> 	*) Used tsend_calibrate_common instead of legacy
> 	   and addressed comments from Dmitry.
> 	*) Squashed patch 3 & 4
> 	*) Fixed node names, order and added qfprom cells
>              for points seprately
> 	*) Squashed patch 6 & 7
> 	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/
> 
> 
> George Moussalem (2):
>    thermal: qcom: tsens: update conditions to strictly evaluate for IP
>      v2+
>    thermal: qcom: tsens: add support for tsens v1 without RPM
> 
> Sricharan Ramabadhran (4):
>    dt-bindings: nvmem: Add compatible for IPQ5018
>    dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
>    thermal: qcom: tsens: Add support for IPQ5018 tsens
>    arm64: dts: qcom: ipq5018: Add tsens node
> 
>   .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
>   .../bindings/thermal/qcom-tsens.yaml          |   2 +
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
>   drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
>   drivers/thermal/qcom/tsens.c                  |  27 ++-
>   drivers/thermal/qcom/tsens.h                  |   4 +
>   6 files changed, 256 insertions(+), 9 deletions(-)
> 

Best regards,
George

