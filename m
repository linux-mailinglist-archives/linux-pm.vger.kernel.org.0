Return-Path: <linux-pm+bounces-28445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E5BAD4C7F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E914417682C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9322D4CE;
	Wed, 11 Jun 2025 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OE61tWwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2034.outbound.protection.outlook.com [40.92.21.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C922CBD0;
	Wed, 11 Jun 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626618; cv=fail; b=E9l2EI+mYSklc0+qcp4gKZFXMM/izbd2BO6vE1hy5lfej5qri1y/m5zEXIlIFQQfXXBqQBPAsQTx2EkFLvwexNqiAhhr1smSWRGI+7vYKnFjRwUhYTjbcraH+S0d0qSE0lWD/Rz+YPin7JU0ooswT/3svmo4NvAHvLa9+02w9nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626618; c=relaxed/simple;
	bh=ZU1W+hlYSkfT3A/7pNLzlKI9gGTIgVfsjjDF72XQFkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULovRA3lQFkOLmmYJZ98xvGy5EPtGK7R7rmi5xAJomeq4MO+Vc95KjKhAMXCyb0u6LWLaBuFedOo2QYbYG6h+Mn9wYGjm+l/ufZj5x/CBGve3isrksXAGVxZrzI1897bwnB2boEFoFQICBx2tZY7r2QKEYvlT+Lfa24lkYSs6kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OE61tWwl; arc=fail smtp.client-ip=40.92.21.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEj+6BUB07EcXWvvbmhSyhKzMrC+8Q3YqJjyVqYl316e3D7MvXOZxHhiy1Z4eR+mu8dWbCOT3godLYqQLPZ6mndOEkRFsLcUHfTxIs0c6VA1qYX5rlzURxRhmH9yOtJAtu9f33hhk96ht7f9G/mc4lUMrFt6GOMzJLRa7+g8Q8tCrhl3YyvaPctcuvvqN8ml7ANEOePwNBCcrCM4J9mPWUhVR3OWb3IAZmmzhHYTsXxTYDXVVJcL8gWzt3gSC+GK1JpdFEtNZP5U/4YAoiv3g3qdeZRn4m64I5HtEfWNGivUZgyo8GTMASjimAtbemDstmDJBBjwxwu7G6hXzpoZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPWxl06q6HuXtauJJ31XW+SQbNtEim3zIEVgoplTMAA=;
 b=gW7iLWPy7x68pCJ70Rv9hJ9qhXLcGVFTNl2nHWrKFdj8S2Z+pU0f0df1n4VMpPUXXzqMFis3kzA0huYvfS0p4FvFWC1SKOOVwBoeK10WxdNyPq/FRs0BjN2P3osuwlH6M5rUXmAHAYiuK2o6P/BxjM9S51GWmXzJ8A9/TMwFI5Oknzz7y6xW8NHWXwQqvtsMxx9M67j8czYgcw1DmzeqqUc7DvvJ6KJnZD0pwd4TU9u9+y6fJR2i67e3wYMupOE/erpQqT66nW7WJlGPJuIef3codzQXCxuGVrTkgNl8qfs+LFOk95wpLsDEd/foMtu6Grz9MU3f7zrIhL1pPMp1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPWxl06q6HuXtauJJ31XW+SQbNtEim3zIEVgoplTMAA=;
 b=OE61tWwlvr3Gg+1z6aWExMTaJgVffNneWViZ1dGVPn3Rm9tZKjwjr0NoPFkZZSt8mRsYoGMW7ZB7JcQI9lcLH+LDIAqbCv0ma7H8rOhtscxApsicOYwIIYw5KghugiBS1tb2KJhj7wUHwT5FNHuKdpmmzAbfC6b2ncZ1fq6BCW8DDtv9eMb7UwvdaSmSgrXh8anUVspQPy1XhuPuhtUlFW9dlyYuMFOYlegbNpZm0PQ+Bbzz3I4IS8h5ERtaqNhLbF21PEfE1rX97KFLb1s91DtkFLUHBFeItawp/NK1Fs3YTHCTWA9aiZdr970dzP4ZCL/B4CjFp8um8ElqWaFsmg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV8PR19MB8795.namprd19.prod.outlook.com (2603:10b6:408:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 07:23:32 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8835.012; Wed, 11 Jun 2025
 07:23:32 +0000
Message-ID:
 <DS7PR19MB88830F20F9AA1D54EE130CC99D75A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 11 Jun 2025 11:23:21 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
 <20250611-ipq5018-tsens-v11-1-266566bfd16a@outlook.com>
 <17eaaad4-7713-4149-b66c-1c48db3ab42f@kernel.org>
 <DS7PR19MB8883034308D6642B6B567CAD9D75A@DS7PR19MB8883.namprd19.prod.outlook.com>
 <61e53f55-394d-422f-8600-9035eac40ff4@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <61e53f55-394d-422f-8600-9035eac40ff4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: DX0P273CA0094.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::7) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <b8cae341-ae08-40d4-88fd-26dfc1882b0f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV8PR19MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: a564f03e-de48-4c65-f02a-08dda8b8de1e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|6090799003|461199028|15080799009|19110799006|7092599006|5072599009|1602099012|4302099013|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2d5cENpKzZqTkduNVVHRmROMzRQeGhaUzhWNjJQUGV6bDVqYUlnWFhuQ1Bt?=
 =?utf-8?B?SDVwaUlPOWRyQnRXN0RiYzdydm5TWE5Ib1ErR09pRXFDWklremdTeTlFcy9s?=
 =?utf-8?B?Vm9ockcwYXJzU0tiQUVSTFc3U0pyTm1tbEdrUmpNVnRKQkYvODZsWkw3RmRm?=
 =?utf-8?B?K2xUdEE2UWhjMGlUMlcvL25aK2J5bEZkeG01Y2h6Z1B5ZklFb3VmTHpsdS9a?=
 =?utf-8?B?OHJGRjhxZ2psc1RLZ2swVDVRZlhFZ1BRcHU2Q2lOMElPTFZtRU1QTWFJclQx?=
 =?utf-8?B?bUNyMlpPeVd6ZmUrbGQzd2F5ajdjV1g1UVEyKzFJdFBwelBrcFNwVXlDVjZZ?=
 =?utf-8?B?Mi9hdUlpSjVKVWNlTWs5WEpKZkswZ05tbWtqQldqUDVVN0hYZTNJaXNqZWJI?=
 =?utf-8?B?b2ZoR0Y4anl0dWo1bVJIOXNPdmNNVkUrVndKeTBhYkJNbzJ5b21udGk4TlZ1?=
 =?utf-8?B?TE92NjVDZ01ZeDJwbWNoem1LRzB3QUVPOFVMdnFPeUFNaTY0Z0xrMmtMK25n?=
 =?utf-8?B?TG9NSCtJRVhnMU1uVncvMGh1Sm55MmdlYzBDQWsxTFFSTnFybVZuVTFTa3pS?=
 =?utf-8?B?dCt0TGpoSUhnNmdCc24xMmJTSkZhNG5mTmc4YzkxNGxzUHI3b2IwSm1XQlZG?=
 =?utf-8?B?biswc0NzYTZmUTRybm5RRVJJZ2JtTUpzNXBGaDc2b0JKN1ZjTHZ2TDVDUG5L?=
 =?utf-8?B?eGU3TkI2RlhPQ2VWRVhnUllTRE1obEg2aDROYkxzNTJKaXNGVkVxeG9FV0ZO?=
 =?utf-8?B?ZU0wWEh0c01BdzlqK1diZmdLVVQ2STQ2alVyMlZ5Y1NlUjhUVkhIM0Rja3I3?=
 =?utf-8?B?Y3NKeitoUWtTWDY2SGRKZmJzZUw5Tml2YXFYS3RzSmNvMnZCMEZSdmZId1Nh?=
 =?utf-8?B?b2ZzdmlsSmtBdDlkL1VTWkw0aUd4QUllc2c5aHFibFJzUUtEaEM1UGNZaVFy?=
 =?utf-8?B?cUFZSnMzQUJFSEZzVUdURGFWYXBLL0JBd0dJWWZZQUV2NkVzQkRXWndyQSto?=
 =?utf-8?B?Vm8rL0tqTEp0YVNKNFZzMDdEL21SaU1obmtQMS83c3U5R0E0RkJqQ1g4TFlM?=
 =?utf-8?B?Nm1aZEpZSVJ3MjBkZ2JzUVpXZGJsc2FCalJzZzAwMTA5ancra1ZYMUdURUUx?=
 =?utf-8?B?eGF2NDR1WEVBZ0EreGhYczBIMFVheDZBeFNiUXlabVpHekVUTWt3endHa3B2?=
 =?utf-8?B?RWE3YjJYTmNKRTlpZUVmaG9ZU3RxWW9meGl4UkVBOG5VUEU1RDlCOWNuZ0Zx?=
 =?utf-8?B?OCtJTzlUSDNUeEVBVENrMDZKYTJNT0FzQ1AvZjd2bVF4SHNuMS8zd28wMkZF?=
 =?utf-8?B?eXExWnA2UncrbDlxVmE3emM5a3RRWk1VY3JtcnRNejM1c1ZUUUxlVWFOOXlO?=
 =?utf-8?B?NHdnaHQrcFhBa3lrQ3c3K2xWMkRMeDJwT0ptbGRIY2gweFIwandPRWZnVmRp?=
 =?utf-8?B?Y3pIRUxTRjJ3Uy9FS1Ribk9DekZiNkhtbDlNR1NpUjcyc2hXeXZIOVdhQWRM?=
 =?utf-8?B?RlNiWFEwOGtNR2Rjb0hHNmNjQlM2Rk5ua2EyRFpxNDk4MEt5eHNMVXk2SXhl?=
 =?utf-8?B?ZFVEekZJeU9Ka1VsMTlPQmpzL0FNVEd0dXNQUmc1OFFMT0hRa25sYktTSUFm?=
 =?utf-8?B?bDlPV0lhK3hKcW1NSlk2VFdsd1ptNE1KSlUwa2hRUEVCZHdqclppZzRpS1Jn?=
 =?utf-8?B?TTk3bDRyTXhWbm16ZkJ2RmJ5YkNDTisxR0JkTHM2L2xvdWlnMDFoT09HeXox?=
 =?utf-8?Q?Wi+oe857raXiAd3U8I=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d214VGd5dTlUNi9zcklkV3pSbnpBK1c3d1BBSmxVRjFsSENkclpwRGJqQkow?=
 =?utf-8?B?WDNiQjBNVEZweHYvbURjL0xSQ01XNkN2bUYzYVZrbTNabFhMVmYwNzlncXRh?=
 =?utf-8?B?d2dRVWE2UzI0Q1MraHEvbzdVcCtUcEFaOC9hNjUvZW1mMnVCbkRqWGJyaWFJ?=
 =?utf-8?B?N1JhSVFySGo3Q0cxNHRZb1FoRCtHM25peTFKNHVsZDQ2WE9BamliU0Q5V1Zo?=
 =?utf-8?B?U3MyNzk4dEc4NE5lWjdOSm1waVpHNzJXSHdYWTY3L0pGUEcwcFZPTE9HaXZF?=
 =?utf-8?B?WEFXQmNmaDcwYTdnd2tTQ2NISldqRUxOTE1nUmFER3UyYWRRWHUrRFdzQy9W?=
 =?utf-8?B?UU9Wd2duYWljYk1GVWQyV0NCb05adWF3RXAweG0yaitMb0hWenBLdmtRdUZJ?=
 =?utf-8?B?dUNOcjU1MHBabXcrb3FCYXVSL1NGNzVDSFRDUHhKaXo4MFVodHErbGlpMHdC?=
 =?utf-8?B?NTJpSUc3bDlObHF5R2IvaThFcDBFK2IrQVdpQ2RyaWI1TXN0ay9pbi9yWUJh?=
 =?utf-8?B?N0xONGh5ZHkxd1JFcmdRb0tmOTdZY2Q2ZTBwSXpJVGE3eTd2bXlOdnd5ZEo5?=
 =?utf-8?B?dFo2aFlBdjd0SEgyQTgwbEJ0SDV2UUpvUVYzSXQ1NmVnV2ZUMWVkSFJQYTlJ?=
 =?utf-8?B?NGNWbjA4KzNhNit1djVBZ2FjRzJtaEhPTXBIZ0cwTE1MTlFxZnpocGkzdHZn?=
 =?utf-8?B?M2szZHA1SzkwRkpIS0cydGdEazgwaFQvMzdZUWRzeGdzM3Y3V1pkd1VCTm1C?=
 =?utf-8?B?MUQwOXYxbVp4QVlSVVdldk9oNkRlMmlZalRxQ0VlRVpPdy9rQzNQdzl2T3VO?=
 =?utf-8?B?c3JrdFJJV05zaHZWdE5WMm5mazRPWCtXL0JTU3N3UWprLyt1NWUyTVJteUdh?=
 =?utf-8?B?dHkvQ0Z0eTBSUTlXRW1FVmRlNUR6U1VpYVBJSmc3L1lsM3lSOGJCV1QyZEo2?=
 =?utf-8?B?WFRFTDNXVDZSbGY0c1lVNjdWWDA0WGk2ZHdVSVVYQkZVTnRxd1AwQnZIMDBq?=
 =?utf-8?B?emNnd2dubEhpRnZaQVZnWmI0U0dvb2tXZmVxYjg4eHJKQlduOGJHTWQrRHZq?=
 =?utf-8?B?NFRCLzdDZE5EcnBkd2Z6OXZQSnQrSzBYV0poT1FVblRGOFVMV0Q3K3lCOFox?=
 =?utf-8?B?Zk51R1pGa1R1MXc3NmppZUR2N09MR1lQRlZidGExSVdGZ0lFNnM0VkxnTWpG?=
 =?utf-8?B?dnhnYjFmV2JFL1FYTnFONU4rTWtldFJmQ1dXOGdPSS82U21RRk1vMk1NYjBE?=
 =?utf-8?B?YlVkUTNuU3FUYXQwWHpLRVNTN09XR01vNnQ1VW9tTGtQeHd1RnBod1JnMTJp?=
 =?utf-8?B?aVo3UENJM0hRMFB6blhRMlRoWUloQTJCNjJGVzNlVGhyRUdTSGtyUWtRWERv?=
 =?utf-8?B?WlYrVXloSEs4THdUUjRuYkkveE1xV2s0TzlSa1Z1QjV5dnJhMmdFWHExMWVq?=
 =?utf-8?B?WE53SndTZUlSUW9NZFk1aXVpQVFONm8weExvNXFwa2JKMTJHQXc5RWluV3dj?=
 =?utf-8?B?MENDbXZDTm5vMmEwQmFGM0RWSHJGWk5aTjllRlFFdXp3UlBISE1yWjhBRW9n?=
 =?utf-8?B?cW9OdEVlbkQyVGdpdi90by84eTBmNzA5TGRycHc1bXZjMnBtUmNRdEZaOHRz?=
 =?utf-8?B?by8vcGRlWG81K3NJV2ZQVUMzQy81Z0xxUnVyNCtDWGt3MEZGYWNxV0Z4V25v?=
 =?utf-8?Q?hVL91fFTPDFRt4jUK8KE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a564f03e-de48-4c65-f02a-08dda8b8de1e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:23:31.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8795



On 6/11/25 11:13, Krzysztof Kozlowski wrote:
> On 11/06/2025 09:06, George Moussalem wrote:
>> Hi Krzysztof,
>>
>> On 6/11/25 10:51, Krzysztof Kozlowski wrote:
>>> On 11/06/2025 07:12, George Moussalem via B4 Relay wrote:
>>>> From: George Moussalem <george.moussalem@outlook.com>
>>>>
>>>> IPQ5018 tsens should not use qcom,tsens-v1 as fallback since it has no RPM
>>>> and, as such, deviates from the standard v1 init routine in the driver.
>>>> So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.
>>>>
>>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 5 ++++-
>>>
>>> You just added it recently with the fallback (in v9 of this patchset)
>>> and now remove it?
>>>
>>> And what does it mean it has no RPM? How does it affect the driver? Does
>>> fallback work or not?
>>
>> IPQ5018 tsens IP is V1, but since it's got no RPM, it follows a
>> different init routine for which VER_1_X_NO_RPM was created just like
>> there is one for V2 without RPM, else the driver wouldn't probe. This
>> was added as part of:
>>
>> https://patchwork.kernel.org/project/linux-arm-msm/patch/DS7PR19MB8883C5D7974C7735E23923769DCC2@DS7PR19MB8883.namprd19.prod.outlook.com/
>>
>> Since its introduction, I missed updating the bindings which caused a
>> binding issue (as reported by Rob) on the compatible as it expects the
>> qcom,tsens-v1 as a fallback. But we can't use that fallback, so that's
>> why it needs to be a standalone compatible.
> 
> 
> So you need Fixes tag and explain what was buggy in previous patch.

will add, thanks.

> 
>>
>>>
>>>
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>> index 0e653bbe9884953b58c4d8569b8d096db47fd54f..73d722bda8adc2c930edfc3373e6011f19c7c491 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>>> @@ -36,10 +36,13 @@ properties:
>>>>                  - qcom,msm8974-tsens
>>>>              - const: qcom,tsens-v0_1
>>>>    
>>>> +      - description: v1 of TSENS
>>>
>>> So that's still v1... I don't understand.
>>
>> As mentioned, the IP is still v1 but with a different init routine in
>> the driver for IP v1 without RPM
> 
> OK, just merge it into first enum and drop the description there.

can't merge it into the first enum as that description is invalid for 
this SoC ("description: msm8960 TSENS based").

My proposal would be:

       - description: v1 of TSENS
         oneOf:
           - enum: # for IP V1 without RPM
               - qcom,ipq5018-tsens
           - items:
               - enum:
                   - qcom,msm8937-tsens
                   - qcom,msm8956-tsens
                   - qcom,msm8976-tsens
                   - qcom,qcs404-tsens
               - const: qcom,tsens-v1

thoughts?

> 
> Best regards,
> Krzysztof

Best regards,
George


