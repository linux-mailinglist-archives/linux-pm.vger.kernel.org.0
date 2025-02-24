Return-Path: <linux-pm+bounces-22792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73200A41B33
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 11:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B95316D4CD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D562505C2;
	Mon, 24 Feb 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rV1wHWkB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2082.outbound.protection.outlook.com [40.92.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E102441AF;
	Mon, 24 Feb 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393241; cv=fail; b=C62s7J/0TEzUiTYJijFZ9yQ94TSFCby5eXCYLvZNaoS/TmfZJemF5f+Q1dAOstVVK5UOWoQ/cFzQNM2+Cv3ekFXXkzUN48UuluBf/xMUDRYyFA9yM4q/RZbKDxVrRUOM4aNl0fA8Pclu2Wwb3Zjz88e+UI+eBux5Y2pOqV5Drdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393241; c=relaxed/simple;
	bh=3C5ghcTeDdLuJAd47C1KWq8ulX9qMemS9DoIZ3uIrm0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eARUC4cgC2CI2EIEYqF6Yxhyb4N1OMukiDLqYD8n5X6/4h+pWlqfyrJN4eEidKgK6TCRrjhzp1u7S6HY+gpTfOEq69cfoz4Ua0CxKrvMLAB4Oufe0kyj/A0Bx7qn5PUuBvQ+OyNdLq+8BnYJm+c7jZbu78xTOr7xqZc1yfJPdbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rV1wHWkB; arc=fail smtp.client-ip=40.92.15.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AywFIjNPl2XiDlSqtFeHuWv8RXTH+KAOWj6mO5/DYiPqIgeGchCEXv57w8tijeHUmhSU8RGkIyAYlOCLWXRm77GyhmunN3AZtuBOjkPNT67IkA0vc9RM2KxIn/Jj1FW6rTOU8UaYR6kmkn6akPoV2GeaU6+QSRvxOpkLKpIM2EPoEISjzEHL0NVPzIMmVkRmDiOtvMnEzSg/Uq56HIBSDK1NPI+Dbp4fc+7hS52mfyb0TOA82HexN15eW/Rn2JESThQLcB2BCHEVPvNQ4VJ6bwmHh5cIfZDyqKjT+vCbt6pt8HV8gyamXu8P5bCbYlpj4en7MsScjCiLQkxyVMqxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jirVRKLZMQsKWyByofybYhzuHNFS2jsNmbydXBC7U4=;
 b=mRjvxk9xmCKNbi6pKZqL5RfdYSbRe9sBiKiG9VQw81oIYDuSCKC0nQI097zyk8o3jqSTMv9GzjqsIb9t2M24Jbs1n26f/ZjPIE04wlhoUNAgdmU0oRwcvPTSRTKFVrxhPUPgsRWtD7EwfaFkjN8MMB/VelF57S9e6k0631efSD35sqDARemx04SrwRGAvtn4QoG71R2DYCmlOAASWMrqBoqjBaPT4wruCp8evfVOqXSJ5i+oz9vlhWfQ+0yQib7qVjVJM1Odrcnhh7i5FFC3jmGnclwolSmyKu9pd1o9keVryDXyXrUAsUpw7AjUwhYTHar8aCyB42BVWUQFmuI1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jirVRKLZMQsKWyByofybYhzuHNFS2jsNmbydXBC7U4=;
 b=rV1wHWkBhKera7Sv34JDAx3l1zEuiQ982ZLbhX3LZsS3iKsFr99sgh2DPv9jV5j1/8g2F9R7w5ycbsrT7A77ZnPxyzEpXrUQf3ICAIfAHfUCpm2RK2AZQfAFogYkgtmM046i5PdFagrSAEtT+9nhpmbpC2hEim15oPGgCVKDou4e6rbWluTmg0qBcpSoyplueY/EB6F1EAd9kSQu86nutTIqh5T38lyf+xkZ2JyfH4TQBDaKsQCZibfn7e5pJvKH4mihImpiZm/gY5sRTCthJArjgEo9ATrYOEw19OtlqyA/LMZAuIthjvD6DQD0jpMvQeI86+Mhgw+SdsrJKXuhnw==
Received: from BL4PR19MB8902.namprd19.prod.outlook.com (2603:10b6:208:5aa::11)
 by SA0PR19MB4507.namprd19.prod.outlook.com (2603:10b6:806:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:33:56 +0000
Received: from BL4PR19MB8902.namprd19.prod.outlook.com
 ([fe80::b62f:534e:cf19:51f4]) by BL4PR19MB8902.namprd19.prod.outlook.com
 ([fe80::b62f:534e:cf19:51f4%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:33:56 +0000
Message-ID:
 <BL4PR19MB890266B101FF78BFE7D065B89DC02@BL4PR19MB8902.namprd19.prod.outlook.com>
Date: Mon, 24 Feb 2025 14:33:48 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] thermal: drivers: qcom: Add new feat for soc
 without rpm
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
 dmitry.baryshkov@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 quic_srichara@quicinc.com
References: <20250224061224.3342-1-george.moussalem@outlook.com>
 <DS7PR19MB88837D7AE30CE306B8F71F3E9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
 <be872be1-dd0a-481b-abe0-57ed2bf50c22@quicinc.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <be872be1-dd0a-481b-abe0-57ed2bf50c22@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0036.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::23) To BL4PR19MB8902.namprd19.prod.outlook.com
 (2603:10b6:208:5aa::11)
X-Microsoft-Original-Message-ID:
 <0c3922b8-f2d2-4b40-a2ed-497d93f5860b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR19MB8902:EE_|SA0PR19MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: d36f6735-1f35-4294-8ecc-08dd54bebd82
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|6090799003|7092599003|461199028|15080799006|440099028|4302099013|3412199025|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldnbUN5Q1ZZZmNlM09aR29zalpIem5nM3doSmVoSDV4N3VRb1NPL0lpNnhx?=
 =?utf-8?B?TENhUGEyL1ZobnIvdjk0TWRPWVRYWmlrOUZGWHNrUCtORnZqTVNoTUNmZ2c3?=
 =?utf-8?B?QjRUcmVUNWFZaVUvVlVFeTBwMXY5TXFtVHlPbVpVd29zaDV3S2RPa1VNRnJD?=
 =?utf-8?B?TVMySnNERVp3NlBoQzZhWVdTaXRDajdIZnlxbFkyK1RWa0lualNaWkg2VnRQ?=
 =?utf-8?B?LzQyR0IybEIxem1HdTNGbklDcXNJWStHVVUvenpCQm10VEI2TlExL0c2TTZL?=
 =?utf-8?B?dHZERGoyVWV6VHV4bXFuWlBWNVBsa1hJT0RZeW4yUEdNdXkrQStoaWlmM1dv?=
 =?utf-8?B?Um90RzNrbWlEV3FOV3pWNzNyN2l2Qm42OHVNY1ZPaGJ6bklrek5mWFlrY29a?=
 =?utf-8?B?T1BXbzBaa0w3L3YreDJHckRiYjNYdGJPYk10bExyajRPcGtzWDRDSngxdVdT?=
 =?utf-8?B?eVgvdmc2ZTgwUTZ5Z0k2a205ejBTS1hXR3UzcnJqTThER3FHcW5yanhqd1dI?=
 =?utf-8?B?VGpLb2Y5Y3U4cmN1TmpGVHo2L0g1OVpnNXVYbzl6UVFjZHNMN2pseWZVcVhC?=
 =?utf-8?B?Y29XWXNjTlNUN2VpQkt5T1ZxK3FtanR0eGNDNFk1VWhtTW00ejBUV1BuZGRO?=
 =?utf-8?B?YWdlSkZJWWhRNGxHOC8xRmwxc3F1b3RZY3UwVmx3eDRaM3p3Z2xWZkNUUXhS?=
 =?utf-8?B?NWt0QkhKcU5wTElvTG0zaEsyaU1XUVl5RDNpWnpkT3g0TTk3cTlYYlloNVlS?=
 =?utf-8?B?eDhPdGxpWkxLL2dYZEhhWU5MbldMTUlwTUV0VlMyc09yYUE4VGcxR1IzK1Zu?=
 =?utf-8?B?UVoxRFpBRko2ejdLYjVKMUpKSVVMZ0dCWjkyZFBMSCs4c3RBWHRTYndNaFlS?=
 =?utf-8?B?dmNabnM2WXlFQWVHK0FaZm5UVXY3bllwUmNGSmpTVnFaTFJ0aWZLa0owWXlu?=
 =?utf-8?B?dXJzdGRSVkw1SC9tTkhWSjV1WXYxemZ3QzBuZnkzRXZoSEtvdGhsN3JBUmFP?=
 =?utf-8?B?a3BCVDh6cEI3RExhZmk1OUlhMjh6aTl6K0FCTkhmS3VSVnJLOEZsQ3lRTWM2?=
 =?utf-8?B?Y0dWZkRXKzdJRlBKOGVNR3oxRjQ5TFRXU21sM0dncDJ2WHpPL2dYMUpCUDN3?=
 =?utf-8?B?VGhGenJpV0djaDRhQWlUajhVbitwVytoemduSVk1VjczSm51b1VyM1ZaTFhk?=
 =?utf-8?B?Y3hLSFlMQkUrWHp2TlpabGFMTnlUeldSRmFBZnFBUjhVZGVtMFYwVnRBZTU1?=
 =?utf-8?B?eXJCMldDZEFIRUN2WmJiQm5nVGdtU01JR2gwdnVVRjcwUGc1azNWMzlLZmpM?=
 =?utf-8?B?ZlZxTkRROWhzeGZiRXBub0ZOa3EzKzBtSDZ0emRxdThERFc4eXhNeUNuUThD?=
 =?utf-8?B?TnlRTUxmQTIrMWVJWmt6WjRRd0kyZ3gySEViVmF0b0FQVmc3VnRuZFpFL0NZ?=
 =?utf-8?B?bS9lMFhiR1hPTDVRS25IelVmTU1wa2pRYlo0NmZjK084alIrcXAzdmMxZXNJ?=
 =?utf-8?B?S1pVNmh1UlpXS0lLaWdwVjdjNnJZRzN4YWhjajFQSDhWT3RoNFpGYVpVTUcw?=
 =?utf-8?B?bzlvdnc2ZlhLKzlvSzlrazZENVVJWHh2di8yclNlQnhYSENGcGxMTXAxb2Q3?=
 =?utf-8?B?TGdJNzEvRFRrRWpkNDc4Q0RmQkhxU0pFbW5SSC9BdEZ5cWYyd0lGMnVJaFN1?=
 =?utf-8?B?ME9QSVAwVHNDZHJmYXpzN3hMYTFyUkpWRE1zbFJrK091YjFFU040am1BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3J6UTlxYWJRcDU5MUx0RFJEU3ExdWo5bVRGZWoxSUhkbHlMM2tTcjZsRFBa?=
 =?utf-8?B?aDhSdm5QQzlSTGNPVFFLUVZvdEdCUHMwL3JLUEJ1eE9xZm1EcEkzaWM5clJj?=
 =?utf-8?B?ZDU1SkZ4WlNYMGhkeHladnpybWRxa3Z1RC90aFNsZFV5K2lRVlNDZC9icHlD?=
 =?utf-8?B?VUVnenJ4QWpPT1BWVmxGR0RKK0p4eGJ0a3BCcTJSNUVidHpXNWJROUp3WUtT?=
 =?utf-8?B?NW5Ybm9WdytOcUlWNXBTdExCYVpaVmVNNWV0S3ROUndVQkJaTW01TU90dmtQ?=
 =?utf-8?B?S1IzbkhocHZRaC9QelIrblVZdXZlK1FUWU0rdzY0OWk3L1UvUVJLVVhyWGhQ?=
 =?utf-8?B?eVFQdll5bVg3b3FOcDFLMnh2dTdzT2RUaDBreUJJdGVvOXYwdVc5MFhLaXpk?=
 =?utf-8?B?OGVJbFY4UkNZSHRmSWtIMjZGcC9Uemo0VlhENEVKMi83RnZlWnZyclAybW1r?=
 =?utf-8?B?NzJ6RkxiQWRYMzRyT0NiRHV3bGpueXlwM0JnUGgzVytYV1FQQ0pCUm1zUWJz?=
 =?utf-8?B?YnVHZmp6ZFA4WVV6RGFsTm80QWQ3WkV5NnJnM2loRjNPWElKeHI5SUlDb2Nh?=
 =?utf-8?B?RXdaY3hTZGNIZ2RBSkJQdHBOQlRkaThQVURzNnVSZVQ0U0tUZG1Ja3NTSUNO?=
 =?utf-8?B?U0E4N2JzaUk3T3duS3ZpTGw0R0RTUFlBOVI5cE1qaUdVYk9jSEtLaml5a3N2?=
 =?utf-8?B?T014TWwvWkVlWlVMTkV3Y1BsNkplNzZQUkVFdVBnV2d1SXlUeFJ5ZlNrQjVI?=
 =?utf-8?B?VjR1N0FLQnIyR0wraHpudlYySkI2a0g5NlBMN210ZVFhWmVjNEF4RnhJcGlS?=
 =?utf-8?B?WFJDbXlJNkZyYjBxeU40Z1hqQWloRE0rV29tc0hDV0RXMzEzekZka05hdXlU?=
 =?utf-8?B?WENrbnIvWTFvRFBTWGRBN2pEZGsydytCU0hmZG9hZWcvdTJMU2hmSlZ1N2U3?=
 =?utf-8?B?enQ1N3hDMGpYcXluVFlQRVdzWW1lN2VRMUhTYjZTdnZ5a0gvUy83TUpqQ1lu?=
 =?utf-8?B?VGhEeFpSMU5hd1hiY0lMV2w2Q1NnWm8zcDdSTmQvSit6QzNjM0I2YkFBRnFL?=
 =?utf-8?B?a3RlUytvK1kzRk5hT2tGQndNU2dvZmdKSmNQYnBYa0d1UGVNL3ZFaWhWaGFL?=
 =?utf-8?B?RU9wMVovZVJ2ZzJaQnBIa01mbG5VeUVhTFpUODRxWUVjclpqVUV3N3ZBQWxE?=
 =?utf-8?B?alg5QXhXamVMVi9SRjg1UFp5b2gzREs0VWhqVUgrcWhXbHV4QjBGYVBLRlc2?=
 =?utf-8?B?R3RvMi9zSW5LRjJMaHpzdkx2VnY4azBZb2Q3aGNabnpGQUowOHg1NEo3VUkz?=
 =?utf-8?B?ZmR2UnJrM1hEdlpiaVNLY3hqMENDYUZCV0lTWC9Yd0o0bW9Edkt3anVkRFNx?=
 =?utf-8?B?bitsSzcrcElCNG14cVRmc0JqQTBLNkxRdXp1aUk5RzVkaHc2TnVHK0FldmMv?=
 =?utf-8?B?bTdLbXhOWWUra3NoeVJJUGpMMWl1M1F6bzNkRzB0eWw0amhCY0JCbGJJa0FB?=
 =?utf-8?B?Wm5VNTVkdVhISW5pbGE5Um9ISm5VR3VpdEZpUXRTL3BGTUVTVlJwWCt0WkN2?=
 =?utf-8?B?Z0pOeFVUTWJuZ2xvTlJDaWZwcVE1Yis1OEdyNlZxYWVHMFVwazJvU0NrdTdh?=
 =?utf-8?B?YUYxK0Z6Ump3d3haUHJiRTd3QmpzMnl5d20wWG5rNE0zaHl4YTJQSUVvM0dt?=
 =?utf-8?Q?IP8Ybn/JVw9KLVBmxB9w?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36f6735-1f35-4294-8ecc-08dd54bebd82
X-MS-Exchange-CrossTenant-AuthSource: BL4PR19MB8902.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:33:56.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4507


On 2/24/25 13:08, Manikanta Mylavarapu wrote:
>
> On 2/24/2025 11:42 AM, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
>> enable tsens would not be done. So add a flag for that in feat
>> and skip enable checks. Without this, tsens probe fails.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  drivers/thermal/qcom/tsens.c | 2 +-
>>  drivers/thermal/qcom/tsens.h | 3 +++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 3aa3736181aa..a25ca17adf1a 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
>>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>>  	if (ret)
>>  		goto err_put_device;
>> -	if (!enabled) {
>> +	if (!enabled && !(priv->feat->ignore_enable)) {
> Please drop 'ignore_enable' and use 'VER_2_X_NO_RPM' instead.

couldn't find it, but found it was recently added in:
https://lore.kernel.org/all/5dc4bbb7-71b5-4389-9e99-099e1c93d1c9@linaro.org/
Will change to 'VER_2_NO_RPM'

>
>>  		dev_err(dev, "%s: device not enabled\n", __func__);
>>  		ret = -ENODEV;
>>  		goto err_put_device;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 7b36a0318fa6..90bf11fba563 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -505,6 +505,8 @@ enum regfield_ids {
>>   * @srot_split: does the IP neatly splits the register space into SROT and TM,
>>   *              with SROT only being available to secure boot firmware?
>>   * @has_watchdog: does this IP support watchdog functionality?
>> + * @ignore_enable: does this IP reside in a soc that does not have rpm to
>> + *                 do pre-init.
> Drop 'ignore_enable'.

will do

>
>>   * @max_sensors: maximum sensors supported by this version of the IP
>>   * @trip_min_temp: minimum trip temperature supported by this version of the IP
>>   * @trip_max_temp: maximum trip temperature supported by this version of the IP
>> @@ -516,6 +518,7 @@ struct tsens_features {
>>  	unsigned int adc:1;
>>  	unsigned int srot_split:1;
>>  	unsigned int has_watchdog:1;
>> +	unsigned int ignore_enable:1;
> Drop 'ignore_enable'.

will do

>
> Thanks & Regards,
> Manikanta.

