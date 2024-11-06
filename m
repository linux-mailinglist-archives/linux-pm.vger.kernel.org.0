Return-Path: <linux-pm+bounces-17062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39799BE437
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95B51C243F5
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91391DDC34;
	Wed,  6 Nov 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OOfMF074"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AC188CAE;
	Wed,  6 Nov 2024 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888766; cv=none; b=HA9+vBOHsJnzf9OxFFOk8L4osqBPXGckL14SZNLUMG0JwH9ScwYahHP06xXC1gmvhqQJiWdVhSbJKu3ESfI8IRrHp1WO5NYUoaKPcq/H6kRxG4BadO6UTXM+6j8ofUQcwdE0/6UaLXetb1yrcwMXcwhf7YZXCS3imPb0/p047PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888766; c=relaxed/simple;
	bh=OHOSCCzUoex3Pq5CawCSNCv9Uc5SEz/0fE8jH4w6Wmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HQYPpRaFAw7xOi2CYhvSiSLg4/E+0bAtozlZ9hRh9mJ3sUdFlgsICOJJhfoicPXRrU79P2emb5J2MFF7zDy4N8v8LcWGixld7H79nyd3nbN9mb09SHLWjiHt8ETA2EUwByyGuO2+wDVWuOYz4rehIIRRjVKFrHL5gB52Z4snj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OOfMF074; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A632eFV001983;
	Wed, 6 Nov 2024 10:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wGZ0NZK3NF3z4vwe9RFE7hRudr4CiDJi8bjCZ4lT26E=; b=OOfMF074EOsizQ5t
	G1KAaj3Srm3JsJCTL+jIEUnjggHi6BVCLN50tOHxhRj3NTVIVTQtYFPoDUtswaoU
	Nh5fx88fQHc8h31AWctgUcQFtnva6Px8EnGtoIY0w8KMb0XiUItP4MOojHHFuyeJ
	MoKR7FWgkMMYnYEAtUNqgJ8WZ7KLKYtYwWnPEyGkEIEvLvByp3d8Z9LHKLWHde6r
	xk7qkKWU0lmAb51msVbUovZq3uTFEq+ZplPy+dQPxKLBbOR+w3AeqNKoPelOci9X
	kaMHbnOvzyA7miYNQnryR83kCi2NZXToepMcwvtwqblDKWirxV9/BCaBeub4bkfi
	p0Xbug==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r072h18h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 10:25:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6APu9T024989
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 10:25:56 GMT
Received: from [10.152.195.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 02:25:49 -0800
Message-ID: <fc676574-ffac-40d2-aa47-8d7cb61b5e3f@quicinc.com>
Date: Wed, 6 Nov 2024 15:55:46 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: ipq5424: Add thermal zone nodes
To: Konrad Dybcio <konradybcio@gmail.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <2c7ece9d-95e8-4d01-a9da-c1d5d7388771@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cx37B31ZhJkqmkO2fywRXMcj6BmASg1g
X-Proofpoint-GUID: Cx37B31ZhJkqmkO2fywRXMcj6BmASg1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060084



On 11/6/2024 2:42 PM, Konrad Dybcio wrote:
> 
> 
> On 11/6/24 09:47, Manikanta Mylavarapu wrote:
>>
>>
>> On 11/4/2024 7:21 PM, Konrad Dybcio wrote:
>>> On 4.11.2024 1:44 PM, Manikanta Mylavarapu wrote:
>>>> Add thermal zone nodes for sensors present in IPQ5424.
>>>>
>>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>>> ---
>>> [...]
>>>
>>>> +
>>>> +        cpu3-thermal {
>>>> +            polling-delay-passive = <0>;
>>>> +            polling-delay = <0>;
>>>> +            thermal-sensors = <&tsens 13>;
>>>> +
>>>> +            trips {
>>>> +                cpu-critical {
>>>> +                    temperature = <120000>;
>>>> +                    hysteresis = <9000>;
>>>> +                    type = "critical";
>>>> +                };
>>>> +
>>>> +                cpu-passive {
>>>> +                    temperature = <110000>;
>>>> +                    hysteresis = <9000>;
>>>> +                    type = "passive";
>>>
>>> You have a passive trip point without passive polling
>>>
>>
>> Okay, will remove this.
> 
> You most likely want to preserve it, while keeping a sensible
> polling frequency, so that userspace will be aware of the current
> CPU temperature. <100> sounds like a sensible value here.
> 
> Konrad

Temperature sensor's present in IPQ5424 supports interrupts.
Hence no need to configure polling frequency.
I will remove polling-delay-passive/polling-delay.

Thanks & Regards,
Manikanta.

