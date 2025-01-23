Return-Path: <linux-pm+bounces-20873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C740A1A3C9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 13:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D073A1FDF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7020E6F2;
	Thu, 23 Jan 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iYo1yVEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356420DD72;
	Thu, 23 Jan 2025 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634072; cv=none; b=R12qPZZPBcZUv/wcckbVuEBvA7OZd69REu/KFoYWikl6jpOWO/+1weqgnROIMAQh0KVZh91QW1SVJBsLj715W0Cxvk3DOeM17t/8iu+lPw4yTWwQ6qQ8IwJDgrbRakce/cQjxex3+LTLfVO5dLq5VLtqCKE103XGusQT8IZDnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634072; c=relaxed/simple;
	bh=ZeIexN4amvexFLjXrqE9Kp1pHIHLK4d1flWZyFgJQgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FFQZuQ2FFN3dTQnHznm5u7SCCi5Xliyo8KmKPA9IgllWUTE0cxodECFdil2tC1egsnl05ON2efsc3tFjwO497bLiBZl47z1PjKfO9f0II8tuJk2rRS6zhM/9yjYAecNqqrf0isUWYKMV6jKWQZaZnMqBsnIJkxw5/AJ6iB5gbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iYo1yVEU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NAqKLL015837;
	Thu, 23 Jan 2025 12:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ciwA2MPCleiFiaVjg17UfNND6tZ6x9t2suDc4aTpQjg=; b=iYo1yVEUG4XYWaHc
	Id8gVgGExXKDO794alaBLCBqQUrLvyT/aWl26bWYUA/kbOVledp4xzy1hOMdpOjM
	jjS20kP+INMG70lyHGoxjdZkTNCOqYXn/FbEe0HcZtIHBJ55/TZ2aDt8zS9TXhk4
	PoXvWWQt6bcpr54jdYBQPXxqN94/3DstL0GsQntdogEcO9jqORUoubsDX45d8gEE
	htMwdkh+Va0OyPC9YBUuNDvAbarA32eWIiHRNxDdrjZgFCvL4oEQdwzFOKU4JVI5
	fVP1bGUnXKdNYO0rCUgHT9YU21Nd/ep2Iho7Mb3nuzOj3OIO+ydymiCfwQu3FP+C
	dRf37g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bmcvg5pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 12:07:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50NC7kYx010160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 12:07:46 GMT
Received: from [10.216.27.253] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 04:07:40 -0800
Message-ID: <08916876-2e24-4b4d-89ad-c0a6203bffd2@quicinc.com>
Date: Thu, 23 Jan 2025 17:37:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <mdtipton@quicinc.com>,
        Vivek Aknurwar <viveka@quicinc.com>,
        "Sibi
 Sankar" <quic_sibis@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
 <20250111161429.51-4-quic_rlaggysh@quicinc.com>
 <273w3qr5wix4srdum5qmrqdzzaw3uprqhhfmmgrwycrb6wlyqf@txuxzzyjyhfk>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <273w3qr5wix4srdum5qmrqdzzaw3uprqhhfmmgrwycrb6wlyqf@txuxzzyjyhfk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bkl84Gqqbn2xsRhxFRQjjOE-MACOuFIT
X-Proofpoint-GUID: Bkl84Gqqbn2xsRhxFRQjjOE-MACOuFIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_05,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230092



On 1/12/2025 3:01 PM, Krzysztof Kozlowski wrote:
> On Sat, Jan 11, 2025 at 04:14:27PM +0000, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>> SA8775P SoCs.
> 
> 1. And why is this not compatible with sm8250? There was lengthy
> discussion and no outcome of it managed to get to commit msg. Really, so
> we are going to repeat everything again and you will not get any acks.
> 
sa8775p is compatible with sm8250, but only difference is sa8775p has
two instances of L3 EPSS. Initial patches were posted with two
compatibles for supporting two instances.
Later there was a comment to reuse the existing and avoid growing the
compatibles in the driver.

Initially we thought to have separate generic compatible
"qcom,epss-l3-perf" for SoCs which support L3 voting through
EPSS_L3_PERF state register. But actually, it is already supported in
the driver for sm8250 and sc7280. We can reuse sm8250 or sc7280
compatible for sa8775p.

I will update the commit text with details in the next patch revision.


> You have entire commit msg to explain things but instead you repeat what
> the patch does. We can read the diff for that.
> 
> 2. Binding *ALWAYS* comes before the user.

Sure, I will update the patch order to bindings, driver and dt in next
patch revision and will follow the same for future patchsets.
> 
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> index 21dae0b92819..94f7f283787a 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> @@ -33,6 +33,7 @@ properties:
>>                - qcom,sm6375-cpucp-l3
>>                - qcom,sm8250-epss-l3
>>                - qcom,sm8350-epss-l3
>> +              - qcom,sa8775p-epss-l3
>>            - const: qcom,epss-l3
> 
> Your driver suggests this is not really true - it is not compatible with
> qcom,epss-l3. Maybe it is, maybe not, no clue, commit explains nothing.

"qcom,epss-l3" is generic compatible introduced for EPSS H/W from sm8250
SoC.  sm8250, sa8775p and sc7280 SoCs have same EPSS H/W and use
EPSS_L3_PERF register for configuring the perf level. We thought to add
generic compatible "qcom,epss-l3-perf" for configuring perf level
through EPSS_L3_PERF register.
 Later, as suggested by reviewers, looks like using a different register
cannot be a reason to have different generic compatible as the EPSS H/W
is still same on all the SoCs.
> 
> Best regards,
> Krzysztof
> 


