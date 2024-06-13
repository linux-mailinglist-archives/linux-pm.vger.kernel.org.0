Return-Path: <linux-pm+bounces-9095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D8A907990
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696E01C23F5F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8B145FFD;
	Thu, 13 Jun 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mq6DHbr8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197812D76D;
	Thu, 13 Jun 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299136; cv=none; b=heonebUk1O3tKnTHSSqRfpNYym947DV6aHE4RBLQhYsab9fRXbrezIWzaAuGuhubOYTbhXKyGbHb4uuOVxdUsnBkz8EWkVCDnjL1GQKj/Dbh32fDoFaUVz+hlqYRB1vIk57VnuBECShm3fA1V7EyGVdANBXflN6+l6W3rIB2iiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299136; c=relaxed/simple;
	bh=S35i76nKYUQSIG9GqJjphtCKd/GP5PGO5NOohhgo7EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b6f6lhg8Z39Wc/6Ji1vB+S9uvgeZVL2Wa0ojL48a9dpVfRob31lYyA/j/Fv6IpR3zc9x2/eq08xILCFg31NHZ48eHgqJajQ15eyP+k8nIJOV9U0h7dBAsW7xc6kZRO2VK9siJ3kSsK210JempnMrHXVD0Hl9JkaMaow7wL0JMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mq6DHbr8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D9n4rJ025592;
	Thu, 13 Jun 2024 17:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x/eclDCtoXTMK13TuopGFkoGhleL4p2YXQEd5/J6oEQ=; b=mq6DHbr8G4NPibld
	ht+SBfsWtQq+TJhZJW4ugOx33h4jW03GBPMlY1T1nZs+oICKJIWYLG5Syx0QOxZd
	9D+OfmjZtnTKvs7/tUNS+e5AaShq4266Sd8DTY7fTQwjH+UaLbS8sOq9h2BVJBoX
	Xo2ILZ02ttYiBctax9MGRzNORsvobQcIq9awp4EjD7YxbVkbf5nPkQp7Vu/+9bjl
	C8boU6Fb36BaFbeTuYqBr9uWpp8YBwm7ORUK6GMSOdtRm1NXTD+0Pv0rGjkkJWYU
	w/w7B8INzthU/GBrC03dWrj6v+5lzWNrCJB8jN83x9un0OZiFGU+oZ4JuQMOGhnc
	022q+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5xe2a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:18:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DHInv6026844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:18:49 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 10:18:43 -0700
Message-ID: <6b46ed87-e225-bf74-dbe1-ad8913c585c7@quicinc.com>
Date: Thu, 13 Jun 2024 22:48:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add BWMONs
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
 <20240604011157.2358019-4-quic_sibis@quicinc.com>
 <4ef1d9a9-6a0e-4324-b6d5-2ae225855b03@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <4ef1d9a9-6a0e-4324-b6d5-2ae225855b03@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fGiutENxV6EMnPU2IEyDGjLfvd54Edlk
X-Proofpoint-ORIG-GUID: fGiutENxV6EMnPU2IEyDGjLfvd54Edlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406130124



On 6/6/24 15:26, Konrad Dybcio wrote:
> On 4.06.2024 3:11 AM, Sibi Sankar wrote:
>> Add the CPU and LLCC BWMONs on X1E80100 SoCs.

Hey Konrad,

Thanks for taking time to review the series :)

>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 169 +++++++++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 1929c34ae70a..d86c4d3be126 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -5329,6 +5329,175 @@ cpu_scp_lpri1: scp-sram-section@200 {
>>   			};
>>   		};
>>   
>> +		pmu@24091000 {
>> +			compatible = "qcom,x1e80100-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
>> +			reg = <0 0x24091000 0 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
> 
> QCOM_ICC_TAG_ACTIVE_ONLY

ack

> 
> [...]
> 
>> +
>> +			cpu0_bwmon_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
> 
> I *think* if you add opp-shared here, you can reference the same OPP table
> from all 3 BWMONs without anything exploding.

I did try this out before IIRC this resulted in just one device vote
in the interconnect_summary. Didn't investigate further before because
it was breaking bindings anyway. Will have another look at it.

-Sibi

> 
> Konrad

