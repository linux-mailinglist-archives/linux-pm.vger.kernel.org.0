Return-Path: <linux-pm+bounces-16914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB629BACA8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B87281BE4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328D18CC00;
	Mon,  4 Nov 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IyPipN0X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3838F97;
	Mon,  4 Nov 2024 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702441; cv=none; b=f/XbBbM+R0wfyViouDfRApf9b5C1hDTU6JmbBCr0QbRpNxVHNRmjT0NARL9JmtyDHfRhqsjqv6JSZbh8ZCIxbuCzJnnIQl7wbH1JI9dU2n8ep6YhQssjmiQqR83i4GdttuxLzuwy9pJY2ZF6/r/ttjyxNPssF+MmJbeHpce/ZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702441; c=relaxed/simple;
	bh=WRlbfbH8V+ZVE5u00EimMugItUuIhEkRBSYgoDOJvQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ahy58lcwz0HrY5NTIhPjTnjDk+mE5GOaaUAKjH/MxgdH83KPAHGJNeyzx8Q7UnefuX55xxJ3Y7xxwesXlABVl8wf6fju/nxXCHBnEg8rl0l1TfmQ78oPGv2qoI78y/fplY+In1Qa2qkfH/fRBtR9pV65R9nwMEVE5nUS4RppDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IyPipN0X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A40LNam028863;
	Mon, 4 Nov 2024 06:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	akmgyX4ei7Y+AGwadML9tnYPiiiqBalW/jXlHP/suPU=; b=IyPipN0Xm0kihKs4
	fsnj4YLeaRYyYajsa+LySURhrtKT4HAXicA/sWhS2n77NEA6EuJJcmYb65usP6xP
	b73gXq2ifK9FHLcbzuw4LcVUWEqfMEOQ96/W14j48/HGj6Gt/mWspAl0OwmDB9vg
	9dIBLbREUx/cfy3HKDKNM0Vp8vlSgf2sPAmhezK8MwPkTe5CyvaoCBeEF39OGT7S
	YwJV5G/ROmdIFEz4iDqrWT3DHlB3GOgf+CYvJ2OPqcIqT03AUja1TeChrvSkFQAd
	wIhGT9zZf7SZJ6Ym/KKPbz6bwxBjtT5OWvkCQ/XV7oSeQemFEfwvoe/lH7YMRDF9
	4SqF0A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2s39sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 06:40:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A46eYru032661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 06:40:34 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 3 Nov 2024
 22:40:30 -0800
Message-ID: <00c9feac-722a-481a-9c57-36463fe0b3ff@quicinc.com>
Date: Mon, 4 Nov 2024 12:10:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
 <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
 <2ac4604c-a765-48b1-84b2-8979f18c29a7@quicinc.com>
 <vljb7wwqaaqgdcm6whf5ymhnh4jbtswyibto4qpqmbgwvshudy@unh3jhbyeac6>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <vljb7wwqaaqgdcm6whf5ymhnh4jbtswyibto4qpqmbgwvshudy@unh3jhbyeac6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I_gM5_C0gQt9lcVl808fXY9dU4LOc6an
X-Proofpoint-GUID: I_gM5_C0gQt9lcVl808fXY9dU4LOc6an
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040057



On 11/1/2024 12:26 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 30, 2024 at 12:23:57PM +0530, Raviteja Laggyshetty wrote:
>>
>>
>> On 10/26/2024 8:15 PM, Dmitry Baryshkov wrote:
>>> On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
>>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>>> SA8775P SoCs.
>>>>
>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>> ---
>>>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>> index 21dae0b92819..042ca44c32ec 100644
>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>> @@ -34,6 +34,10 @@ properties:
>>>>                - qcom,sm8250-epss-l3
>>>>                - qcom,sm8350-epss-l3
>>>>            - const: qcom,epss-l3
>>>> +      - items:
>>>> +          - enum:
>>>> +              - qcom,sa8775p-epss-l3
>>>> +          - const: qcom,epss-l3-perf
>>>
>>> Why is it -perf? What's so different about it?
>>
>> The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.
>> So adding new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based l3 scaling.
> 
> Neither sm8250 nor sc7280 use this compatible, while they also use
> PERF_STATE register.
> 
That is correct, both sm8250 and sc7280 use perf state register.
The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
Using generic compatible avoids the need for adding chipset specific compatible in match table.
>>
>>
>>>
>>>>  
>>>>    reg:
>>>>      maxItems: 1
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>
> 


