Return-Path: <linux-pm+bounces-13651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932FE96CE2C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 06:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270BF28AA0D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69514F125;
	Thu,  5 Sep 2024 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PAxDMFhA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4B13DBB1;
	Thu,  5 Sep 2024 04:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725511371; cv=none; b=B3IIXjyqi5hlyqsXnbZNClgVnAzf4383uG1DjMLnGGefwNBov3B9RTdfh9OQr+gdRn6vm2ouaraoBIzSm/9SLubdynDEOBy7JqUvTn4FIfOZuWSsMqKlzTOsIJe8EAO9jOZf9xfimm5QY3QIc0qAUIBtDhQy0CkIki2kIJawF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725511371; c=relaxed/simple;
	bh=RRS9pYCw6a5x6rwrrbkwY7IjeSnUyJBEBB0isPM8oTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nlPvRov79OslTw0x6DzvrUgs6A7jOL7Kk5RObVFHPHGjZN6LmFIPwL203b4F+NK6Hol6+w1K6P2Kt5vkyF2POaLVgfm7KWE0UkEdm1OLD0rVWdtw/tqbI69Ur3TkYV1CGdzHzqnRFHZRpUUq9US/zjfPImoDh99cbOV7q1hNyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PAxDMFhA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484N6nEm020956;
	Thu, 5 Sep 2024 04:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wEpbW7Ga7PleMMC94flb3g17KxIeZlw72iJuZws+CBw=; b=PAxDMFhA+NL3zWAD
	ppDa2wau5KIm77d1dMW4XY6kJsdVg+qAJ+Cys9sbFSP3uUgeJ5La6bECV4ESo422
	hLV929NiiQn3nZx1qcHKHZvX6H0c1g3bkgRvHThz0B7OQe90D+mJppgTQedSeoFT
	N65yqmtxEHofj+yuMFTMzlgPQA7fPEPH8Qt3Q1XvAkrj3ndoIyvHVrMpVilszLpI
	oH6Tj3Je12C9n7UQitD2xXqkEuID4nZ2Qiwnjf4pVV1gJUf7W4uwVkr/RhbS5sS/
	8Tzz5l25lDNMGliybE71bbysJgvR+uJR9TIlZZd6a7qDOy0nkQB+8PURuoKAYWB5
	uROrQg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxvrw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:42:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4854ggqK010221
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 04:42:42 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 21:42:39 -0700
Message-ID: <161a0b3d-457e-4164-a33e-5897efd529c6@quicinc.com>
Date: Thu, 5 Sep 2024 12:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] dt-bindings: arm: qcom: document QCS8275/QCS8300
 SoC and reference board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
 <20240904-qcs8300_initial_dtsi-v1-16-d0ea9afdc007@quicinc.com>
 <0627fd69-f7d8-48ae-bbba-3a2d9bbaa5b1@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <0627fd69-f7d8-48ae-bbba-3a2d9bbaa5b1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oxtoPbwe8YvMwbqz_lGy_SyEJ7DDv6Vh
X-Proofpoint-ORIG-GUID: oxtoPbwe8YvMwbqz_lGy_SyEJ7DDv6Vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_03,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050032



On 9/4/2024 5:38 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 10:33, Jingyi Wang wrote:
>> Document the QCS8275/QCS8300 SoC and its reference board QCS8300 RIDE.
>> QCS8300 is an Industrial Safe SoC, while QCS8275 is the Industrial
>> Non-Safe version which can share the same SoC dtsi and board DTS.
>>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index c0529486810f..ccf9a166368f 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -42,6 +42,8 @@ description: |
>>          msm8996
>>          msm8998
>>          qcs404
>> +        qcs8275
>> +        qcs8300
>>          qcs8550
>>          qcm2290
>>          qcm6490
>> @@ -895,6 +897,12 @@ properties:
>>            - const: qcom,qcs404-evb
>>            - const: qcom,qcs404
>>  
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs8300-ride
>> +          - const: qcom,qcs8275
> 
> So the qcs8300 ride comes with non-safe SoC?
> 
> Best regards,
> Krzysztof
> 
Both QCS8275 and QCS8300 SoC can reference qcs8300 ride board. Could you
describe your suggestion in more detail?

Thanks,
Jingyi


