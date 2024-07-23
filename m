Return-Path: <linux-pm+bounces-11351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F4593A614
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AB6282BEE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADAE15821A;
	Tue, 23 Jul 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nz90t1af"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7415821E;
	Tue, 23 Jul 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759489; cv=none; b=LD75pD11FTUhD4B+y17/RPckHB832GJN7YaGvFPBQZHPNwOmGxWnCa9TsQFySz0uZoJ48WXCwZoVCS0iG+wlkxVlas4ufbhYrAysUR17uDkBztQPR5cj5AFD1TFVr3BJLpQOv0EuiGyYsXFIQP1y1M0WEEiJuDkCrx+NvpLu8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759489; c=relaxed/simple;
	bh=nGeubOj0aFAvEDDVidBpz//vAu/I0XKtSRIWt2NlxUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cOSXIQGeeTyKcJbF93G3mNJ5LlnbaPjvVPrDlMXOHjmvbUNVLN259SOHSOHQLf5TG/EdgFxFBvJhYHmbaJWo4TvEBlsXvAmfbipudsoZjdJVaLSsQnd8D9dIXxkHYsabGVgdLMGhaWaPiizhbS+MCb1BcQiJYu9kl5D4FTinBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nz90t1af; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NB8Cgr013108;
	Tue, 23 Jul 2024 18:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ie9ulMpQcFi6Uj23FHCbwUX6LK2hWvaAQ/QQF2cZFJY=; b=nz90t1afue99IUF6
	1Mbyxel7jHTGSyT/NGPmCuBsdbssZShytrHQeuwzUAMD1EtUqOTZCfme1mYZ/Djn
	SdLVUMo+Z5YdUTkayWRPnXCI5zpPSc+wAVKk7ZTLtlBbWCss8nTc5snxn5/HyCoa
	gha/vaBiodKCZ70j3BZc7IYmO7SsHDJiYqippY9wR9jk3uXPR0IRQ9v032YMDt7C
	mueaZpITMrP9yVxb53GA5eWdm87SryVzsW0tnAO15Ft4H/6DgbREbCAlupfupifk
	4lk8ECZaU+v/q9cSLD0mItDZgxP9+mgr+w86CNdOycSSDUFOicALXG0BPXcU8xWE
	cRF5+Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487fw1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:31:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIVLw8022886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:31:21 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:31:20 -0700
Message-ID: <37357507-d997-4e74-8e98-c120f27b9291@quicinc.com>
Date: Tue, 23 Jul 2024 11:31:20 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM/devfreq: governor: add missing MODULE_DESCRIPTION()
 macros
Content-Language: en-US
To: Chanwoo Choi <cw00.choi@samsung.com>,
        'MyungJoo Ham'
	<myungjoo.ham@samsung.com>,
        'Kyungmin Park' <kyungmin.park@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20240605-md-drivers-devfreq-v1-1-d01ae91b907e@quicinc.com>
 <CGME20240626042133epcas1p3f68b406443e993411c4e01072ed63d5f@epcas1p3.samsung.com>
 <f09b56c7-ad2f-472a-896e-466261b39ce7@quicinc.com>
 <001501dac79d$53cdf390$fb69dab0$@samsung.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <001501dac79d$53cdf390$fb69dab0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CtQgZQQMjvzu6bt8MtaJhUsvqKM6uEO8
X-Proofpoint-GUID: CtQgZQQMjvzu6bt8MtaJhUsvqKM6uEO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407230128

On 6/26/2024 12:49 AM, Chanwoo Choi wrote:
> 
> 
>> -----Original Message-----
>> From: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Sent: Wednesday, June 26, 2024 1:21 PM
>> To: MyungJoo Ham <myungjoo.ham@samsung.com>; Kyungmin Park
>> <kyungmin.park@samsung.com>; Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
>> janitors@vger.kernel.org
>> Subject: Re: [PATCH] PM/devfreq: governor: add missing MODULE_DESCRIPTION()
>> macros
>>
>> On 6/5/2024 11:18 AM, Jeff Johnson wrote:
>>> make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>> drivers/devfreq/governor_simpleondemand.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>> drivers/devfreq/governor_performance.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>> drivers/devfreq/governor_powersave.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>> drivers/devfreq/governor_userspace.o
>>>
>>> Add all missing invocations of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>>  drivers/devfreq/governor_performance.c    | 1 +
>>>  drivers/devfreq/governor_powersave.c      | 1 +
>>>  drivers/devfreq/governor_simpleondemand.c | 1 +
>>>  drivers/devfreq/governor_userspace.c      | 1 +
>>>  4 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/governor_performance.c
>> b/drivers/devfreq/governor_performance.c
>>> index 5dbc1e56ec08..2e4e981446fa 100644
>>> --- a/drivers/devfreq/governor_performance.c
>>> +++ b/drivers/devfreq/governor_performance.c
>>> @@ -58,4 +58,5 @@ static void __exit devfreq_performance_exit(void)
>>>  	return;
>>>  }
>>>  module_exit(devfreq_performance_exit);
>>> +MODULE_DESCRIPTION("DEVFREQ Performance governor");
>>>  MODULE_LICENSE("GPL");
>>> diff --git a/drivers/devfreq/governor_powersave.c
>> b/drivers/devfreq/governor_powersave.c
>>> index 4746af2435b0..f059e8814804 100644
>>> --- a/drivers/devfreq/governor_powersave.c
>>> +++ b/drivers/devfreq/governor_powersave.c
>>> @@ -58,4 +58,5 @@ static void __exit devfreq_powersave_exit(void)
>>>  	return;
>>>  }
>>>  module_exit(devfreq_powersave_exit);
>>> +MODULE_DESCRIPTION("DEVFREQ Powersave governor");
>>>  MODULE_LICENSE("GPL");
>>> diff --git a/drivers/devfreq/governor_simpleondemand.c
>> b/drivers/devfreq/governor_simpleondemand.c
>>> index d57b82a2b570..c23435736367 100644
>>> --- a/drivers/devfreq/governor_simpleondemand.c
>>> +++ b/drivers/devfreq/governor_simpleondemand.c
>>> @@ -140,4 +140,5 @@ static void __exit devfreq_simple_ondemand_exit(void)
>>>  	return;
>>>  }
>>>  module_exit(devfreq_simple_ondemand_exit);
>>> +MODULE_DESCRIPTION("DEVFREQ Simple On-demand governor");
>>>  MODULE_LICENSE("GPL");
>>> diff --git a/drivers/devfreq/governor_userspace.c
>> b/drivers/devfreq/governor_userspace.c
>>> index d69672ccacc4..d1aa6806b683 100644
>>> --- a/drivers/devfreq/governor_userspace.c
>>> +++ b/drivers/devfreq/governor_userspace.c
>>> @@ -153,4 +153,5 @@ static void __exit devfreq_userspace_exit(void)
>>>  	return;
>>>  }
>>>  module_exit(devfreq_userspace_exit);
>>> +MODULE_DESCRIPTION("DEVFREQ Userspace governor");
>>>  MODULE_LICENSE("GPL");
>>>
>>> ---
>>> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
>>> change-id: 20240605-md-drivers-devfreq-42b19b2594a1
>>>
>>
>> Following up to see if anything else is needed from me.
>> Hoping to see this in linux-next :)
>>
>> /jeff
> 
> I'm sorry for late reply. I applied it.
> 
> Thanks,
> Chanwoo Choi
> 

Hi,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

