Return-Path: <linux-pm+bounces-8985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29634904930
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 04:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52083284EB6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252FD29B;
	Wed, 12 Jun 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AMwuBv1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2020.outbound.protection.outlook.com [40.92.99.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51585DDC4;
	Wed, 12 Jun 2024 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160768; cv=fail; b=XQQzlmMDJCoUxxOTWPCYN9e1RP95UYLa+jDEGb4pWrHWES+91E5MNbup4a5g/Vc9bHiVS3nwzLmyVqmI6bRGkz15VszVM3UC2bjGtwR7iPT8rO/IFyv1+bWn7vEViHuxcOf+gDXbkBk/8tGgPDkGnGTvs45wh3CaUFu18Cehcl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160768; c=relaxed/simple;
	bh=buuIiOQGoff+vz5Sd19MBnjxdZabcjz03fZ8jU9Gqck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lfAa98XjC0yG7+55eR2LwriNHQd7JdjlLtoB6DVlWCVXiBY1mb5jRqKip/DGp0Ky+L4EEVrwK4TFq1gbd7w/7AjVIiSLYNzsvtqnakyClJIGwg7V9ZHKEudvXzXFK7GVybTlijZFcZG/jG4QMZmq+vK4bybFdfgjwevEyrQ2msU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AMwuBv1e; arc=fail smtp.client-ip=40.92.99.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhMW7jGdeKtnSRQpUgFSerw4kblgDYdr+46iqHDVZMjABs5P7qAtsIY5bMN2r3QRZi5ALVhUmn+x1buSz+I44H3W+Rs3uF5s7hSGWFNkTAlGTJub+IL5z1IqHXZueDbM/esKYdn1qnWGxa9Hh23rJzLyGmImJHz8olNxYSCria5c0DpaMEuofHaFHAHqRd5sdNGYG02qx+Es+k3f4zr+gRHkW2j1n340LIYqlu19B6eO9N5623AROVIRFJtbKhbLioglFGtTQ15iOb//dkODwKSQ15SiqSBpFMBI3+srHMvUnjPnmQ0YmJL14FIZBoX0Tco4KkL/XHEqRGf/uqhUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfBaPbr+1B07yA3UWFpVBv0zR1ewlCfBxFi3v76pZnQ=;
 b=YiJo+n2xlw5k/DUJmmjhadmr8IZlyODTshWw7fyvbpLgLsUWIpYSDjJpMhwOjuJwqDAVr5YxJedUyv3VC8W/LNOPPvihfq5Hjfj88SLCIYSKO9r7mIuKXnCgKf/NuAXcSxn7XMDqjDQ8wm4ZD+zU/ImYGIbKBoxAyMpbiAALmLV6qJtdw03bxGXHoVgUBqcjxvEIpMXnOQfIll/K+/lxQWj+ADO4Z8nm0FmiLE5L7zgnhlOLn0ulAr3UmJ3CG7pyQzu1xxqYj9Omno9jv9Fk9TT2w0zQXRW3RvQxUEdm1o6JY1v+Z4ch3S6t1mp/kg2VjQQwQxcW7bXNe3J1KkYBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfBaPbr+1B07yA3UWFpVBv0zR1ewlCfBxFi3v76pZnQ=;
 b=AMwuBv1eGnSs6NDWndXtkIkK3erYFNaTBfzltLb1FfP0qgksq/E1CtApgqF86TKDg5Ir6Xguh6iJuOr2UkTcn4zPrv/rQLjwruUSV0mUiup7b7ATG0qDJxBOaBXhC2YET1PZw0WrMFHhTHHizuI37i8A2IU4TiRrlFkmMTjT8tQuDKi9bbv+RhrBTziIz7eXb6DALL8alLV1COrhky5gRgChHMFU7UeeiTpN6h/zZ7x2FpwA6CAmveKHQzMaPtEG0mtCekKWSaD1jskxggJjIKHOZACk0UHD/sNDrqEzEYeINEZey8txsZLiG3B3797lR/zgGSvU11BLM9rt50EqnQ==
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11)
 by OSZP286MB1485.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.39; Wed, 12 Jun
 2024 02:52:43 +0000
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef]) by OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 02:52:43 +0000
Message-ID:
 <OS3P286MB249073C57E2B5A36F45A02E0B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Date: Wed, 12 Jun 2024 10:52:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when set
 target
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Ionela Voinescu <ionela.voinescu@arm.com>
Cc: beata.michalska@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, hotran@apm.com, Riwen Lu <luriwen@kylinos.cn>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240606090737.z3qenphikjs5ijj4@vireshk-i7> <ZmgQ06jtJBPh5wat@arm.com>
 <20240611091049.lrypvvluntf37uff@vireshk-i7>
Content-Language: en-US
From: Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <20240611091049.lrypvvluntf37uff@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [Vcye6qVrRSyyp3pLxSPKrxTethtFDSjt]
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f1::11)
X-Microsoft-Original-Message-ID:
 <f6e6e2d9-c9dd-4c5a-9309-6b2438c0f7c8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2490:EE_|OSZP286MB1485:EE_
X-MS-Office365-Filtering-Correlation-Id: 35143306-7307-42ba-7749-08dc8a8abb64
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199020|440099020|3412199017;
X-Microsoft-Antispam-Message-Info:
	QwlrkyzcTYr0CFXW+vmL8VcZxvzgjYmADSfRqyGjBnbwxFYOs5pG875rDWXPydbqlbN64QXl0JtYSA7JOGUwMEGOsoHJJU50f4wJUQSAfXsn/JqXUqOT6OmOPjI4jC0ERcF1fajUTjbEb3QhFo8uqcUfsR45tGOnbTIpJwXVhjdNt4kmB1+yaoTQT6PTlQVL9SQXPo9byJ51UQO97eufmeY9vHA3kX9HMW9vUfeG2KczJgutDXV03lF+UPhhpbSVyAhbBGxYPIlTgO4ndLvw8Et5fJ1h0/H73osRgdRNm4xpg+4EU+aTnUrtzxc+PGO2pd3Jg7RxIgJCxPI5ghchpu7RYCvVjnS/wtTueSeTgqvDWMiy8dYmwQZCaOB+5E3N+uPIByNwAquuRKJKfHg0vz+qXfoljyTh6lwplpjYOPZ1kWawlN0hnNU3QMt5TT3+I9RcoB3iciUEw46GTh5B6iLFlfnpLFzqSvSVS9ABe/gr8eYw3p/FQKe7ubsLPmpvvS66/YFeiYPqAgejpf77ox5qBidlXqqiX5hL8Tc6NVaSm1NKDKkixhwNi4J9v73JOeWN0ldEBWGIWvMxBTt6u/XFaV+lthcDWrPqUtPWW6D54WyFPopv2pyol8sazFXJWfX9EqkktBP2udq1D4Gf/VDE9OSxKmqCjex8xJ5+YJI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekpBbVVobTVOWTlab2ltVG42WVp5Z0E0eTdlc1QwZHc4b2ZQbkhZWG9tMUsx?=
 =?utf-8?B?UEZIY3VpeGRaNDI4a0NsbHcycDdaWWlHblFOd1RXbCtWTEFUOG8veVRpb3BP?=
 =?utf-8?B?VHhINXZ2MGlteTdGSGZpeEJYVmpkdENPRGxnaHh5RS9CcjkrQlMxSHdrOUNp?=
 =?utf-8?B?ekVRV01hWWwySksyc29RTmJZdmwzNENKY3NaNmVNcEljYW9LYjhJcVZ5b2x0?=
 =?utf-8?B?emd5c01VWE5pVzc5eFFubTRyaEpWbEJZSVZCQUlQMGo5c2plTHpkUU43Rlc2?=
 =?utf-8?B?THRZQmE0L2RXV2RjT1FNRk5MODcwM0ZyYnZMWklqSFFXUGxFLzVDb2FBeDhZ?=
 =?utf-8?B?cVlJUjFFUEQwRFFxZm5IU29OMzd0bjdNcGpFOHA3ci9wV214QWFnTjNTazFh?=
 =?utf-8?B?MWNad0dOZ1VyMjh1Q0orcko1dFMvN1Y0Q0JtYkhqV0ZjcEFrWmIvLzFXUmNP?=
 =?utf-8?B?TkZvM2pwdXE3VlNwVUttVEpPakhiaVhCaTAxZHVXblVOUkk2Umg0d1RVM24r?=
 =?utf-8?B?T0RraEN2UEJldnNESk01Z25JTkUxZXR3YTZHaG5sNVBHVjd0YlA0ZDREU0lY?=
 =?utf-8?B?dUFiSHRiSU9GY2k0RXZBTnp6MUhScVNhdTA1c0NEVm5LSld3Q29PK1FjZ2hC?=
 =?utf-8?B?T1g4a0FCQjE5b0NrUUo2djJoN05LWmhQTld6N1JMSEhoMjV5VG41d0UxRmlU?=
 =?utf-8?B?anBKZElLMDR0OWR0SllrMTN6Y0toVWxHNXVqWGtrOTBjSW9jeFBxUmVUR3BE?=
 =?utf-8?B?N2orc3p4R3lwaEdXY2g2S3lraDJ4M2hjT0NXUStDVkFTZnh6RCtaUnM1SStD?=
 =?utf-8?B?UnJ1dWdRa2VwbUZRV0xKOFhqVFlJMXpTWFY0bHFmaHBpS28vLy90OVRBUk9s?=
 =?utf-8?B?cDl1NzFIRFMwaTJBclE0dFUrU2tKY3ZibGZ6UlVVaEQ2dEFVU3lSWG9uQ2I2?=
 =?utf-8?B?N25oeFR5RjFBWlhyVElPbjBUTXlReEFzb0t0YUh6d2xWYTRZdEtGTGFQRnY1?=
 =?utf-8?B?WVZuT1MrTTNjSTFYK2c0SjgyQTE3RVNOczhtWnA2Z01oVmlpTnM4bTJmZkI0?=
 =?utf-8?B?d2hHZjl4cnhPc0VwOXJaSE9kRnJpdEFoOXc3QkF5anhOeVlRbmJjYjVuOUpi?=
 =?utf-8?B?dzNlZm9GZW8zaC92L3g1V3M4OVBNZitPTTNPK2VuYWNOT3NvdWJyV2p2T3Mz?=
 =?utf-8?B?ZE1ZVHlxYXZ5WGRuelpXRVZIYTVDbXB2bTRhSEFwZlJUNmVrVFJnSjZwaElM?=
 =?utf-8?B?NW9BWDlMQTRvQ09tcTBseE1LbGVRdEw2S1pYWjhpNGVQWkJrNWsvM1JJcHBY?=
 =?utf-8?B?NXlwMHFmM1lWaVN4WVVBZXlFV0JYZnI3d3pDcjJMVWFaaWQ5ZmVHWUFaNU16?=
 =?utf-8?B?TEp5NktCWEMxbkhWVVVSWStmUzlhVHYrWUVVT20yUkVTb0Rqc3FsTC9HTUl6?=
 =?utf-8?B?MHdBYi9TcUtaNlFpQ3pSd3ZJcnVqd2pKbW9HV0VqRkhmdW1aWTJPVUg3WERi?=
 =?utf-8?B?dVpqcWs2WE5rMmVUeGhvUklxODF2Sk02Tlo3UHJLakZmUlVxUnpwMmlXbVNm?=
 =?utf-8?B?Z3pLVUoxNnZpY3pxQlpsM3BQUU1tZ3B1UnIzWHllM1FTSksrUDNpNHRGdktR?=
 =?utf-8?Q?yxswDG4L0kZ1xKgVywusXxXz8kVMGnq0vqKPQKlJ8/OM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 35143306-7307-42ba-7749-08dc8a8abb64
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 02:52:43.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1485

在 2024/6/11 17:10, Viresh Kumar 写道:
> On 11-06-24, 09:54, Ionela Voinescu wrote:
>> It's alright with me.
> 
> Great.
> 
>> Some "nits":
>>   - the "desired_perf" local variable could be removed in this case.
> 
> Riwen, please fix this and resend.

I think it's no need to remove the "desired_perf" local variable here, 
the code is seems more readable.
> 
>>   - [note] while this change helps, we'd still need policy->cur to always
>>     have the latest request value (see details at [1]) for this check to
>>     be made obsolete by the comparison between target_freq and policy->cur,
>>     as mentioned in the commit message. But this is/can be a separate
>>     matter.
>>
>>     [1] https://lore.kernel.org/lkml/ZmB1qKucR5fXk100@arm.com/
> 
> Yeah, lets discuss that in the other thread only.
> 


