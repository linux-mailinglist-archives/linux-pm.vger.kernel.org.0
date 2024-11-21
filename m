Return-Path: <linux-pm+bounces-17883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6ED9D520D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936B9B29B70
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F91B1D63;
	Thu, 21 Nov 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XgdkcDJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99675188907;
	Thu, 21 Nov 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211024; cv=none; b=lPB39hMwJYcWizn9EwNqayM+yNHY6L3T871f861BhJMydpICb4MpiHfGA2p3+SYNAQSI/YZvrgIZGjHIQYgx/z+agXXclaPgu07jjpMFxXbXwnajKTs0qmo4ZKi5gMC5gsVorEe0B5Fm9Ftkga6cJr0BKTvPwnv4jY8PLwzoiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211024; c=relaxed/simple;
	bh=mcR0fmFBKeWHGu/LO03QGuCa3xZcBBHBeR8r8I1DIfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aUnqgTxQHLVRS1FreNeXCE5cGGGjqZH2zuTnsc5m8HWPRBKz+gftoO4OGjjsAchRpOJrBPq+arGtiQ+sx7kO5nc/CoQLkD8BUEj+ufoKEdHOmjr9EtXGlOTzhwcfaJZv6bOSv6+aix14rpD87ChZYVoSJhVoTBUv38XpzuV6pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XgdkcDJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALAYFd8027329;
	Thu, 21 Nov 2024 17:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TA0ALkDY/ov6Xz1qAVz6q8KYsn36VXCMZ2v/dUPLyYA=; b=XgdkcDJnw7bV5Wk5
	tGuW1o9svV6HuS/e9j2QfS/Idlcf4SgtPYITDs7vsnaQ/QwDlmSl2fwvWHZYirNn
	ivfgtEEEIU7dA9DLN4fHIIHloiZrf0OVrn13BWGoxabXzHDkDV295k+/psQRDDJQ
	UdWuDtLXZf38349uUxOke4LILM1H6ROvMoK9mvAmtT7rrT8ddH0di7RKdvAgfzC2
	PNyCizRrTCU8RlzxCsFQvLSMftgAuU6gTd9HX5wM5fXu7kCY41i5ViHdyROAED2d
	El/XInVZmgaFHovuGvAMoE/HorEOfag07R0QOAmTiPfUZ36jnR4RopsmyFYMN5N+
	cdLSkQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ebycgm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:43:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALHhdhH018098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:43:39 GMT
Received: from [10.216.2.20] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 09:43:33 -0800
Message-ID: <10e4fd4e-559d-4164-ab94-d5f0a60ffc22@quicinc.com>
Date: Thu, 21 Nov 2024 23:13:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/4] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-2-quic_rlaggysh@quicinc.com>
 <bda810ab-68d8-4265-87c3-a6d021092e62@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <bda810ab-68d8-4265-87c3-a6d021092e62@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v5SQSfoXoG_YKwJPnNZV-XwOANmc1-sQ
X-Proofpoint-ORIG-GUID: v5SQSfoXoG_YKwJPnNZV-XwOANmc1-sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210134



On 11/21/2024 5:23 PM, Krzysztof Kozlowski wrote:
> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>> SA8775P SoCs.
> 
> This we see from the diff. Explain the hardware, why adding epps-l3-perf.
> 
The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.Along with SoC specific compatible, add new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based L3 scaling.

>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> index 21dae0b92819..042ca44c32ec 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> @@ -34,6 +34,10 @@ properties:
>>                - qcom,sm8250-epss-l3
>>                - qcom,sm8350-epss-l3
>>            - const: qcom,epss-l3
>> +      - items:
>> +          - enum:
>> +              - qcom,sa8775p-epss-l3
>> +          - const: qcom,epss-l3-perf
> 
> I don't understand this change in context of driver. These are the same.
> Isn't this compatible with sm8250?
> 

The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
Using generic compatible avoids the need for adding chipset specific compatible in match table.
But received comment from konrad to add both SoC-specific and generic compatibles.
Dmitry has suggested to update generic comaptibles for sc7280 and sm8250 SoCs, which makes use of perf state registers. 
It will be done as separate patch series.


> Sorry, this is all (binding plus driver) quite confusing.
> 
> Best regards,
> Krzysztof


