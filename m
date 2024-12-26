Return-Path: <linux-pm+bounces-19764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA79FCBB5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 16:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41BA1628D0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A481728;
	Thu, 26 Dec 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UWMXLheL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1712E5B;
	Thu, 26 Dec 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228602; cv=none; b=fyvQLhjzu+reuNllT2y9ogJZgbhanUvIdd5KpC/L1oVjhG9ly2YNJRGx2mJAEHdA0YPZ1ix1qzIa5bG0J35rBp0RAlCrn4EtqpyhgUbWTORQW9nW2rWrfFqBPlZP/sByMEwNZxvxvHfE75hw/HNN+1GD+zAbM92IQmm5G+zW0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228602; c=relaxed/simple;
	bh=EUYudVfdl1UvskIhgud++JbK868PfNKxrtqKcQKqNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D7x37+ARqiQd2JcJoxLlPxS2vjLPUWOI5pYY5dLTkgXmSDOLxD1sEvfdbyooHUadDV3jX6PrXEpbzOwwfgmgszIWGlL1NndIk170Hf25qz9vnrd1yQRV8LH6NCqPWssUJNWXhxO616HFyngE/cQsTugMrcYZMNuS7Hm2RpX0K9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UWMXLheL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQADbHr030599;
	Thu, 26 Dec 2024 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+aYWXD/NpuSmJc7G7ZROW8aJWLf0BsoKjncZWj8tSe8=; b=UWMXLheL5ubJ6TmQ
	ljxA6pveONzOFZbFQx+pwvOyaiIakMTFe9SWQkhGrSX0998MNlZPh4bKh9NB7BDF
	Y+//kiWCQvZrL/ckxaS0C3BJGQJ9PAQtzccYinYrKD9IdKrUNRR/I/mhAuHAvgxL
	vMjOiYyH0tdGrJTt6k0/J/hAUg89MpkKJYC2PFaH/eYCJ+6zv1ivhen1RT4BPr3K
	pMCuXMMNHSq1kQVWrSqQKT35Su2NjZJYxWX89JMf0erIdBgcj0mINXa12bOS4aFA
	7LOrUVTC/yGHIvrjbRsgFMC/4LrATIjkqltajfcoeb7+w402vtHWujDYimAJ3gz7
	ZU1sFw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43s5731jge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 15:56:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BQFuZPR030521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 15:56:35 GMT
Received: from [10.216.0.11] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Dec
 2024 07:56:30 -0800
Message-ID: <91f23c5d-0bc1-49e4-9b7a-85120732326f@quicinc.com>
Date: Thu, 26 Dec 2024 21:26:16 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/4] dt-bindings: interconnect: Add generic compatible
 qcom,epss-l3-perf
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>, Rob Herring <robh@kernel.org>
CC: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-4-quic_rlaggysh@quicinc.com>
 <20241127142304.GA3443205-robh@kernel.org>
 <zchtx32wtii2mzy2pp4lp4gdaim7w56kih7jcqes4tyhu24r3n@dagazlsdgdcv>
 <0ba0f4af-5075-4bb1-a7f6-815ef95bbda7@kernel.org>
 <538761B6-5C8D-4600-AB9E-687F91B855FF@linaro.org>
 <fff1a05c-5e7c-451d-9b08-4e835d6ab131@kernel.org>
 <CD9BA30C-C38F-4F3B-9823-B8F5B4160BC6@linaro.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <CD9BA30C-C38F-4F3B-9823-B8F5B4160BC6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: byg3dUsB_ctoAqySPtXriAyy5DAL2bZo
X-Proofpoint-ORIG-GUID: byg3dUsB_ctoAqySPtXriAyy5DAL2bZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412260141



On 11/28/2024 1:15 AM, Dmitry Baryshkov wrote:
> On 27 November 2024 21:22:02 EET, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 27/11/2024 19:49, Dmitry Baryshkov wrote:
>>> On 27 November 2024 20:27:27 EET, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> On 27/11/2024 17:53, Dmitry Baryshkov wrote:
>>>>> On Wed, Nov 27, 2024 at 08:23:04AM -0600, Rob Herring wrote:
>>>>>> On Mon, Nov 25, 2024 at 05:45:10PM +0000, Raviteja Laggyshetty wrote:
>>>>>>> EPSS instance on sc7280, sm8250 SoCs, use PERF_STATE register instead of
>>>>>>> REG_L3_VOTE to scale L3 clocks, hence adding a new generic compatible
>>>>>>> "qcom,epss-l3-perf" for these targets.
>>>>>>
>>>>>> Is this a h/w difference from prior blocks or you just want to use B 
>>>>>> instead of A while the h/w has both A and B? The latter sounds like 
>>>>>> driver policy.
>>>>>>
>>>>>> It is also an ABI break for s/w that didn't understand 
>>>>>> qcom,epss-l3-perf.
>>>>>
>>>>> As the bindings keep old compatible strings in addition to the new
>>>>> qcom,epss-l3-perf, where is the ABI break? Old SW will use old entries,
>>>>> newer can use either of those.
>>>> No, this change drops qcom,epss-l3 and adds new fallback. How old
>>>> software can work in such case? It's broken.
>>>
>>> Oh, I see. We had a platform-specific overrides for those two. Then I think we should completely drop the new qcom,epss-l3-perf idea and follow the sm8250 / sc7280 example. This means compatible = "qcom,sa8775p-perf", "qcom,epss-l3". 
>>
>> It depends for example whether epss-l3 is valid at all. ABI is not
>> broken if nothing was working in the first place, assuming it is
>> explained in commit msg (not the case here).
> 
> Judging by the current schema, epss-l3 is defined as new HW block of aka not OSM L3, no matter which register is used for programming.
> 

I am going to remove the newly added "qcom,epss-l3-perf" compatible and
add target specific compatible "qcom,sa8775p-epss-l3" along with
existing generic "qcom,epss-l3" compatible.
> 
>>
>> Best regards,
>> Krzysztof
> 


