Return-Path: <linux-pm+bounces-23125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB4A48685
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C505E7A73E8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBA1DDC29;
	Thu, 27 Feb 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="atixRQOm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2098.outbound.protection.outlook.com [40.92.21.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED961DDC22;
	Thu, 27 Feb 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677120; cv=fail; b=KqOIvQP4kCWOfANWas+W4waXXXhEd0LOq97Fs4CgSbLFHLuMN5lJDnFo9zVerPluJS7k9t3utlU9wESlSnALNwJmU6wmx54OSyA04s+ilPD7eWipV9bHTRpEpJvNgrvpBos0E618+aO7y6Y0Z9eYjlE3Hu8WtdPTnOjQngkCDeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677120; c=relaxed/simple;
	bh=g8Ihu+KZmsofLVpktBXugHoL0Zwk3t1Mm8oWlFS54lM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqTk+eP4y671dFG3apAwgQ1HFe4Uk8ajfVJ8GfF38gMmgTSVkyAGWqsul4PoT7Ql6/w9jOPuEWlHMz8PfKB35iJEQa86tJ/wjG0jPybStJqpF9MIQP/Jkein5FgFiHbwQgddGdAd6GnMlP9IAA9qPRWfnxa90uCwuz5Yhx6KNJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=atixRQOm; arc=fail smtp.client-ip=40.92.21.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e75Z9uRjgVWiKISyoi7JfLwx5vbHd/qcLVjLmT02V1TfYRFTpBSi4FGYPNXwoFt7zfoluPx66054eJ1ekrOzZYHGqjrADymCB1JXognH/mcSTs0Bx/xlltNg6WC4OG5wTxYh+9ePQWJn4vp9PKCFrpkJh20q2CSVTNGIzqDIYFbapDKL2irXz0pfn/j1/1tlaqcYCnee2/HEIy3baZt3HCbbZuylzUAvGnlhn7ISY8KedRSj47Zp/8djYA72RSWulhvfv474KWKe2ZSL/gYGcEuCdm9HvGjJNEZTDsnokv8GUTtHqQAHmwDH+AjAxCLalCEhi1pyHPdKrYq6tdyDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWqVm+C9h3M8Yo1NXGARj9RG/mWzlIvk/bFmdbOgTzg=;
 b=tGzkIQ1gYqDdo4tQHCbn3VcDLPbkmUb34Vgvj1VMJ1/PjZl8GogGbgDVVX1Sr1kaztVvoV1BepAeSAqlEJ+WsfXS2sA7yTSJhC0Q8igTpXZ5aSSUt5dCYI/PXi4spmMJHKA20ApV2Cd3tm3rDYOm0T1L41d5p7ijM9UA8B0am0GVsxwAQN9wvroWZU3LVxMPqG61Ypfozd5iqswBO+Jk/d2PPJfTqiIIfF1Zg726x0YsyP+zM7UYDXlqGRjOw51hunxQSsOH4RF2pUFmOo/YbxySTUZAk8WFjjQIVbpLnnL7StSlDfJOvXC3JoWjAPW8JBuOv8S5qOi3POByk0rQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWqVm+C9h3M8Yo1NXGARj9RG/mWzlIvk/bFmdbOgTzg=;
 b=atixRQOmtuoP3NBbWC0kvYzIuow+g9MVU/NOwVlubU+C25xaCcW/SDkHLGTavQd0zzVMuX3Ud6iFOLJcHhzWr1T5K1YXobUWt7fjs2MxexPWQSmIM9/JBWkOdNU85sFPL7EZwh76/fVwmqBRJu2BNERaPxgHdCBBHlp72+MQmuHxBgkuskg929vrTnDnQDypZRzmqopmHVKALu91uj5U5m07Ua1YV5eyB7uKBKM/wSBIL33CLQrqZLh6a8rPANmUo4XODAKcwtshqzlNZ80X3B+cBsiBAbG+FVgRfgK2LgsB/e5kVZYxP/gTzsqSFEhdwNozOEy58tPT/XcpeuJcbQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SJ0PR19MB5559.namprd19.prod.outlook.com (2603:10b6:a03:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 17:25:16 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 17:25:16 +0000
Message-ID:
 <DS7PR19MB888363A4FF954A6275E81B4B9DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Thu, 27 Feb 2025 21:25:05 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] thermal: qcom: tsens: add support for tsens v1
 without RPM
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, quic_srichara@quicinc.com
References: <20250227110423.8418-1-george.moussalem@outlook.com>
 <DS7PR19MB888322C58FC555299256E8D99DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <eafirt5dg4vmafmu2wph47zrrzyqrz65z5ypqrl7fhr77qckfi@dgqwkkhnz4ge>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <eafirt5dg4vmafmu2wph47zrrzyqrz65z5ypqrl7fhr77qckfi@dgqwkkhnz4ge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0053.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <dc89d77b-ec24-4f6a-9c4b-b0852dfdc241@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SJ0PR19MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: e3754b5d-bc35-469b-0545-08dd5753b32c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|5072599009|461199028|15080799006|7092599003|8060799006|41001999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUNBdVA4Q0YwcFpKclJKYTJyUlQyVFRlQ05FbTVwbGF2eW1zd2F4SE1Yd3JH?=
 =?utf-8?B?Q2RwUFVmRmZGZnNERXFNSCt1aG9nUkUvWFBQM1luRXFjYmlqd29OVmFaQjhQ?=
 =?utf-8?B?a3RqK2F0QWE3VWRlWmc2R1R4aElyTW5CM05pZ0tOYXRrMVB6VnpOb280NFVr?=
 =?utf-8?B?TXp5Lzh1Y25nd282MGRoaWI1L3N6ZHBJSWFHVVlaVCt4dnJNaEN5QW5EUVNN?=
 =?utf-8?B?bUJpMmlpazhWUFNySU1meS90dENyS3BOMWN1NUZ3cXNvcWoyVU8wRkJJaTli?=
 =?utf-8?B?NUs5MlR0TVpIRmJIemdwRzJiczZGVU9jdU0wbWV1clZPREdmOVpvTjg0TlpZ?=
 =?utf-8?B?Vlpneld0dVZnYTlHMHIxQjRIUFk1OUlicHlzWnZIT2g3RXpYY254VHQ5L3VH?=
 =?utf-8?B?aVYzV01qMWVkTjR6b3B3ZldSYW1kS1d6N3RkeUhCcDlseGFtcWlmMllWNmJK?=
 =?utf-8?B?YXFBbHJicGNwbnpLOEtTOHA4ckJqTHRDVGdwUnlIa05UYnRDTmJzM1l3bDRq?=
 =?utf-8?B?ekh3N2FyUVE5ZWRaOVlOcUJHNk1ISmpTbWo5NFk4c3hXNTRBV0p6cW55cGhy?=
 =?utf-8?B?MndReUIzbWl5Yk1lQUhVU05acjRuM3NWaVkzbjdKeWpvR2F2YnBOSFI3Ym94?=
 =?utf-8?B?WWFLNWFkWUR1ZEpXT3RhQSswc2xiY2wxOVVxT0kwWFExeUZYeHZIQm9hTzh4?=
 =?utf-8?B?T1NrSnEyMGNOT2Iyb0NtbHV1VmpPeHVudzU0Ri9jT1pSR2U4Qk82ay81S0V1?=
 =?utf-8?B?eStHNkMzTjlHS0hXL3ZkZEw3WCsxKzdYaVBwK0ZoTjlhR0dGNnZDT2tBdFVO?=
 =?utf-8?B?YmRsdFY5Wk9wazZRSUJvdi9CcytRQXFxUW9YZUpWQUtPZk1sZFl3d28xRm1i?=
 =?utf-8?B?aTllWGc0MnJjMGtvekQzV2ZiSmZ1cW1tcVNVOXJCeEZLU1pyMm9yeFNzdHd6?=
 =?utf-8?B?R1dWUnJGU3A3d1dXMlIwWTlwMm9EMXVIZ2hFenVXaUJEdFM4TTNyL3VnVXRC?=
 =?utf-8?B?QkZNQkFTeHZNcEFFNU1oQVYvbnJJOFdQVEg5WVA4Q1pQYlkvR2pVU2wrazYv?=
 =?utf-8?B?anBCM1ZjQjdIZWJXdzFFdmIwNzJGdmVhdGFEMTFubnVSSGNrL1lCeCtjdW5p?=
 =?utf-8?B?TUpROTlrcXRuNVVmYlQxSnNVU2tyTm0ySFZwNXJocGFzRG1UaGFQYU4rWHRv?=
 =?utf-8?B?dmVLbFFyREo1NVUrOUxLd1EvaVNNNUhyVExmWWhkTEFSMGRjK0hCb3p4cjFr?=
 =?utf-8?B?WmpqcWt4dzRIYmtsQkVpQURUcC9GWXdJbm9yTEtOY3lreHlYblhHWVBvUXMr?=
 =?utf-8?B?WXlMZlpVekNsYndsaTlZKzU2dEwxNU5LYko5K01idEhRS0dIakk1NzZzSjFY?=
 =?utf-8?B?Q3dwZHBZMHVDdmFwb1laV0lsREJuVW9reVk3bjloUnd2NklBZTdIOFdmYlhU?=
 =?utf-8?B?MHNmL1hYYS9NZGFpY0oreHR3SVRBSlgxZ3g1c1FFeS9tRGtiSHd2QXdYK2NC?=
 =?utf-8?B?VnlJOXVOSHpiNGozQzM3MzFQQThIWS9nSlBzdWYwYjErMUgxcGZoU0RLVGNS?=
 =?utf-8?B?MlpQdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThoUlVKUkF2cDE3MWdjZHpDT2g5Qi9RVXhNMmk3SlAxZnBGVmVXREZwOHRY?=
 =?utf-8?B?ZnUvdnJuMlpRcHZNaTMvNm5mSjJLK094Z1ZYYU96NEp5Q09SZmdsWEdyaXRE?=
 =?utf-8?B?emdRbzFlVmZUYkdCVXZpYVhzd3VoWHhHOEc0SmQ1WWpIUHdZbmV0UnplOGFl?=
 =?utf-8?B?cEZSNWFRbHlZUFNkVEE3cFNSQzMxUmZCeTRZUWFCZHZ5d2M3YmtVbXlCejE0?=
 =?utf-8?B?NC9hVTQ0R0MyUXJ2d0dFUkQ4aWFMbUJmMEdWREZnOEVZeFB5aTIyYVpzWGZm?=
 =?utf-8?B?aGVuNlk2Nm9IMjJnMEc5WGlLV1BIMEJQNVd3c1BYR2tLWXZiazNlMkFKYk1E?=
 =?utf-8?B?dVp1SDB2Zk11ajBDUnBJTmdGUVM1eFRwa2R4eWdweEcyYkIyUWl3THRsczZL?=
 =?utf-8?B?cVgyTkowdUt6dHdqT1VLRVVJZWg1QUNORTEyYVNXRm1xS1U4M1RxcGxGcC8x?=
 =?utf-8?B?RFNwYlA3MytYMzdheS9mK3hwbnlLL1NBYzBWUFZSVXJyM0R4RWZNOUtoREpU?=
 =?utf-8?B?MDVDSS9jb3FWUDYrb1hJcXAvdFA1VEJ5RWM2WmxBaTliWUVaU3QramdSMmVG?=
 =?utf-8?B?NmtPb3I4UEIxdkh5WjcreVNaNUFjVDRmU0VNb1RjUGE5YTJ6NVJCUGhSYnZW?=
 =?utf-8?B?ek1DdkIya3JLYWtZb3lRdTlMUHo4dDFUUDZrbXM2dkZyeWYxZU84Qk1Qc3Bx?=
 =?utf-8?B?R1VmZS9JaTZvLzd4SnRpUHNGOXN4MlNpQVdMOXpXZkFXRnhKVGZKN1pjQm1z?=
 =?utf-8?B?cnlYRzZqM0V5cGdBS2RocXBIdnNmblJ6cHl2cmJ4VXpyQVNoU0IvODFaRHI4?=
 =?utf-8?B?VS9jWUdNanZxbVhCdWRiajNQYld2b0Fka2grL084VmhsWGNoUXd5SVBaTUd1?=
 =?utf-8?B?c1Q5cUd4WU81ajJBNFFLRDBYcjVBMVdLS0ZNNTkxV0RPM2U4OHhhR3BSMDJh?=
 =?utf-8?B?RGJvVGorYWwzZWVnSTZaeVJ2UzYzVWt0ZWliSjFyem5keHA3YklzTkFKdnZx?=
 =?utf-8?B?SE9SZHd5S21rZ3pjbUk5anFPcEpTU1UvNHR4NWdiRk5pRlBYbFhseFBZWjRx?=
 =?utf-8?B?cTFaMElnaGVYbU1ONDNUUW5qTnB0UzVVM0k0NmdRVUNBVndiR3RQUnMyZ2Qv?=
 =?utf-8?B?aHNTU0dZMTBSQklDajFZRWp0WDlib0I2VGsyZHNHbWl1c0E3cWpRWVVJU1B2?=
 =?utf-8?B?eUJoK1BGWUFGYklSeEovZFVyNzI0a2pGUStCYzBQVFNScG8yaktJSjVPVFpr?=
 =?utf-8?B?ZHNBeWRXQkkycXJGTW9XaWRPWCsrWnJtdURPVWpTemRwSTcyVjRKYkRKNjlO?=
 =?utf-8?B?Z2N3UnNNL0tGNkxzelFSbXJ0bGlwbTFPb1hhTENrYXYrbjVMQXZFclJDeVBl?=
 =?utf-8?B?S2F3Q1FvSndxWkZJQW1pOFFma0UwWlkwQS9xcW0rTWk0VUg3MlFicHpnYWdm?=
 =?utf-8?B?S3hjQTJmdjVoWDF5Z1FwcUJMekU2TUxjMnJTL3hFUDc4eVF3SEFHY0FzSm9p?=
 =?utf-8?B?S3ZJaGEzV1Fia1p4MUhtUWRtUkdyMk81UkFkdldnWGd1RkNVYnRUU1JoMnNV?=
 =?utf-8?B?eVZPSzlSWTEvV0YxVTJRZEtrZUhESkVXYTRxRURCNGFpQ3pqU0F3dkNJb1g1?=
 =?utf-8?B?ck81blNGc0RIVEhGWU9mdnV2Q2FMOTh6Q1JKak9OVFRuTC9ycyttbGd5RUxM?=
 =?utf-8?Q?DdfICfiFch2icP3uUNup?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3754b5d-bc35-469b-0545-08dd5753b32c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:25:16.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5559


On 2/27/25 18:59, Dmitry Baryshkov wrote:

> On Thu, Feb 27, 2025 at 02:56:41PM +0400, George Moussalem wrote:
>> Adding generic support for SoCs with tsens v1.0 IP with no RPM.
>> Due to lack of RPM, tsens has to be reset and enabled in the driver
>> init.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
>>  drivers/thermal/qcom/tsens.c    | 24 ++++++++++-------
>>  drivers/thermal/qcom/tsens.h    |  1 +
>>  3 files changed, 64 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>> index 1a7874676f68..877b27274fd2 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -79,6 +79,17 @@ static struct tsens_features tsens_v1_feat = {
>>  	.trip_max_temp	= 120000,
>>  };
>>  
>> +static struct tsens_features tsens_v1_no_rpm_feat = {
>> +	.ver_major	= VER_1_X_NO_RPM,
>> +	.crit_int	= 0,
>> +	.combo_int	= 0,
>> +	.adc		= 1,
>> +	.srot_split	= 1,
>> +	.max_sensors	= 11,
>> +	.trip_min_temp	= -40000,
>> +	.trip_max_temp	= 120000,
>> +};
>> +
>>  static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>>  	/* ----- SROT ------ */
>>  	/* VERSION */
>> @@ -150,6 +161,43 @@ static int __init init_8956(struct tsens_priv *priv) {
>>  	return init_common(priv);
>>  }
>>  
>> +static int __init init_tsens_v1_no_rpm(struct tsens_priv *priv)
>> +{
>> +	int i, ret;
>> +	u32 mask = 0;
>> +
>> +	ret = init_common(priv);
>> +	if (ret < 0) {
>> +		dev_err(priv->dev, "Init common failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
>> +	if (ret) {
>> +		dev_err(priv->dev, "Reset failed\n");
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < priv->num_sensors; i++)
>> +		mask |= BIT(priv->sensor[i].hw_id);
>> +
>> +	ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
>> +	if (ret) {
>> +		dev_err(priv->dev, "Sensor Enable failed\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_field_write(priv->rf[TSENS_EN], 1);
>> +	if (ret) {
>> +		dev_err(priv->dev, "Enable failed\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
>> +
>> +	return ret;
>> +}
>> +
>>  static const struct tsens_ops ops_generic_v1 = {
>>  	.init		= init_common,
>>  	.calibrate	= calibrate_v1,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 1f5d4de017d9..f860ea86d130 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
>>  	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
>>  		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
>>  		enable ? "en" : "dis");
>> -	if (tsens_version(priv) > VER_1_X)
>> +	if (tsens_version(priv) > VER_1_X_NO_RPM)
> I'd suggest to replace these checks with >= VER_2_X. This saves us from
> all the troubles if there is another 1.x 'modification' later on.

makes sense, will change to >= VER_2_X. Thanks for the feedback.

>
>>  		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
>>  	else
>>  		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
>> @@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
>>  	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
>>  	if (ret)
>>  		return ret;
>> -	if (tsens_version(priv) > VER_1_X) {
>> +	if (tsens_version(priv) > VER_1_X_NO_RPM) {
>>  		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
>>  		if (ret)
>>  			return ret;
>> @@ -543,7 +543,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
>>  
>>  static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
>>  {
>> -	if (ver > VER_1_X)
>> +	if (ver > VER_1_X_NO_RPM)
>>  		return mask & (1 << hw_id);
>>  
>>  	/* v1, v0.1 don't have a irq mask register */
>> @@ -733,7 +733,7 @@ static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
>>  static int tsens_enable_irq(struct tsens_priv *priv)
>>  {
>>  	int ret;
>> -	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
>> +	int val = tsens_version(priv) > VER_1_X_NO_RPM ? 7 : 1;
>>  
>>  	ret = regmap_field_write(priv->rf[INT_EN], val);
>>  	if (ret < 0)
>> @@ -975,10 +975,16 @@ int __init init_common(struct tsens_priv *priv)
>>  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>>  	if (ret)
>>  		goto err_put_device;
>> -	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
>> -		dev_err(dev, "%s: device not enabled\n", __func__);
>> -		ret = -ENODEV;
>> -		goto err_put_device;
>> +	if (!enabled) {
>> +		switch (tsens_version(priv)) {
>> +		case VER_1_X_NO_RPM:
>> +		case VER_2_X_NO_RPM:
>> +			break;
>> +		default:
>> +			dev_err(dev, "%s: device not enabled\n", __func__);
>> +			ret = -ENODEV;
>> +			goto err_put_device;
>> +		}
>>  	}
>>  
>>  	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
>> @@ -1040,7 +1046,7 @@ int __init init_common(struct tsens_priv *priv)
>>  		}
>>  	}
>>  
>> -	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
>> +	if (tsens_version(priv) > VER_1_X_NO_RPM &&  ver_minor > 2) {
>>  		/* Watchdog is present only on v2.3+ */
>>  		priv->feat->has_watchdog = 1;
>>  		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 336bc868fd7c..e3cb611426c4 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -34,6 +34,7 @@ enum tsens_ver {
>>  	VER_0 = 0,
>>  	VER_0_1,
>>  	VER_1_X,
>> +	VER_1_X_NO_RPM,
>>  	VER_2_X,
>>  	VER_2_X_NO_RPM,
>>  };
>> -- 
>> 2.48.1
>>


