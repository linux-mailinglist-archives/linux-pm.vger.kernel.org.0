Return-Path: <linux-pm+bounces-17609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104E9CDCBE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502D3282AD4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD01B4F0D;
	Fri, 15 Nov 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XYP+2N0F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654E38DD8;
	Fri, 15 Nov 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667124; cv=none; b=o5BNWsce0nsnASzIHjvTyb3naihMZGzpWxgSDWaEDKrzR9S9ewScMDyHYv8k9zhOQgEtAWluWSezmXF5Imi6giMQE7j9yTz3ymcZoZKFx1Sz9aIzGnLNHmEwGb0RAz1nvTkcPrkZmLgHIo5hfq1SBzN4lSsUEdEIzu0EI7PCZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667124; c=relaxed/simple;
	bh=H0boV9wNcUaUvCupA60cDstG/1gsv7QE+nR0hEYIg5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q/YfCc5h9xrk49RatsgvTkRQy4Y44NyBFUR3jO3CCJAKjfReFCKrTMVqjUJJAQV87sOlOoEXUFyMY6AAvwX46n/skyrgfTdfS5D4YR+igeIu21RJMdjzZO0VI1k56rv1REn9lur8cTMq6gxaTyzSoK0OKT4+vSr2cvhEwyXKO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XYP+2N0F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8Txkh000925;
	Fri, 15 Nov 2024 10:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lDwx/1QgYatgC+hjwnNrOs23Jwv/LxH8QR2w7LLcHWc=; b=XYP+2N0FXLEqUkIn
	zNTtCw2ekwWP7t0EFPoL1qu5vFFB60aC/kTIUKhJ5PjjNxPljNqydpL1P3LO4bIh
	SRlurFdifDzGwLH7Oo+yh4GKMknaSK8RJGbfVpcOM2Cr9uSrsDWXCmRqg9y3meQv
	LzGOTc1W9+hyem8qDtzoCO63Xk+t0il7PlM7xQQ4gK56L48s/riPP2+jnuMxpET9
	XRgECqkxLDFHbc5Vh5MNPeLDJfSV7aG4lub9i1PRMTiuH02eS340i0jgXPDxs3k3
	KGHk3pRjO6NY/qlmZmBeJ8wjh0iB83QE3PaxdlLQRbwe3S1nFyIYtF/22XVT6rpA
	VbYobg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv5kc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:38:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAcXbF008339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:38:33 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 02:38:27 -0800
Message-ID: <dbcb01e8-9f5f-4e54-bfe4-e7be8185c7aa@quicinc.com>
Date: Fri, 15 Nov 2024 16:08:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio
	<konradybcio@gmail.com>,
        <srinivas.kandagatla@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-8-quic_mmanikan@quicinc.com>
 <91ea0f03-9bbe-491d-9056-ebd9fdc73bfa@oss.qualcomm.com>
 <8cb665f5-4885-4853-804a-7313decc719c@quicinc.com>
 <2c7ece9d-95e8-4d01-a9da-c1d5d7388771@gmail.com>
 <fc676574-ffac-40d2-aa47-8d7cb61b5e3f@quicinc.com>
 <9bd3d4e2-aba1-423c-946a-f5c60da71497@oss.qualcomm.com>
 <f5ceee66-9d09-44f9-9217-3abd467d1086@quicinc.com>
 <6565a4ec-6db6-4442-a07f-ace467c47395@oss.qualcomm.com>
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <6565a4ec-6db6-4442-a07f-ace467c47395@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: muIduWTVexMo6APGjOVLJ_AIR6Oi6xe5
X-Proofpoint-GUID: muIduWTVexMo6APGjOVLJ_AIR6Oi6xe5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150090



On 11/12/2024 4:32 PM, Konrad Dybcio wrote:
> 
> 
> On 11-Nov-24 12:51, Manikanta Mylavarapu wrote:
>>
>>
>> On 11/7/2024 8:17 PM, Konrad Dybcio wrote:
>>> On 6.11.2024 11:25 AM, Manikanta Mylavarapu wrote:
>>>>
>>>>
>>>> On 11/6/2024 2:42 PM, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 11/6/24 09:47, Manikanta Mylavarapu wrote:
>>>>>>
>>>>>>
>>>>>> On 11/4/2024 7:21 PM, Konrad Dybcio wrote:
>>>>>>> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>>>>>>>> Add thermal zone nodes for sensors present in IPQ5424.
>>>>>>>>
>>>>>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>>>>>> ---
>>>>>>> [...]
>>>>>>>
>>>>>>>> +
>>>>>>>> +        cpu3-thermal {
>>>>>>>> +            polling-delay-passive = <0>;
>>>>>>>> +            polling-delay = <0>;
>>>>>>>> +            thermal-sensors = <&tsens 13>;
>>>>>>>> +
>>>>>>>> +            trips {
>>>>>>>> +                cpu-critical {
>>>>>>>> +                    temperature = <120000>;
>>>>>>>> +                    hysteresis = <9000>;
>>>>>>>> +                    type = "critical";
>>>>>>>> +                };
>>>>>>>> +
>>>>>>>> +                cpu-passive {
>>>>>>>> +                    temperature = <110000>;
>>>>>>>> +                    hysteresis = <9000>;
>>>>>>>> +                    type = "passive";
>>>>>>>
>>>>>>> You have a passive trip point without passive polling
>>>>>>>
>>>>>>
>>>>>> Okay, will remove this.
>>>>>
>>>>> You most likely want to preserve it, while keeping a sensible
>>>>> polling frequency, so that userspace will be aware of the current
>>>>> CPU temperature. <100> sounds like a sensible value here.
>>>>>
>>>>> Konrad
>>>>
>>>> Temperature sensor's present in IPQ5424 supports interrupts.
>>>
>>> Correct.
>>>
>>>> Hence no need to configure polling frequency.
>>>
>>> No, that interrupt firing signifies crossing the temp threshold (meaning
>>> no updates beyond that) or the tsens watchdog barking.
>>>
>>> Konrad
>>
>> An interrupt fires when the temperature crosses a threshold.
> 
> Which means you can't monitor the temperature at runtime
> without polling..
> 
> Konrad

Hi Konrad,

I got the point. Will configure polling-delay-passive with 100.

Thanks & Regards,
Manikanta.

