Return-Path: <linux-pm+bounces-17946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5DA9D59D0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 08:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7C9B21FE0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B417B428;
	Fri, 22 Nov 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jpm+hlmx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA06176AAE;
	Fri, 22 Nov 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732259810; cv=none; b=FUVM3GqCU8VOzKWa8+VY+mIUpzJpx+4DBnZFbkGbGC4sPUfPcdZbVVhmbI8B4igLiozCNjbOWFbYrq05iSXmV+fCmAhZKXzgR4KSjPMk/JnrmrDfNiW2NQzYGtI0ZGQRspK4pzlg5H68hBaVkiBz0zpudcn8F4yDUiSC68QEpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732259810; c=relaxed/simple;
	bh=4sHOO51s1jATnfOtut1zLDZ8BCLU3WdBaeHgaCW3LJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+UjjU6k9Pzf0zWqW2Sp9h/qT5m8OMYIw+YhjChT+6mvoK9ldzCvqgr5FzGUNy12aSXN3HWGh7aK+BN/S3BqKCraqW8GJrR5ulxkjyqDk7wxRxMDun6mHDBvyBD1tu+YCf2T96RiRWpmJFN0Y/l6F8vDrGyKubD43AyQuIxtZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jpm+hlmx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM77Jcq015637;
	Fri, 22 Nov 2024 07:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jXvsgXYeibjTq3pz62fi6/hRFtAf2bKrPnSHlgDAuMA=; b=jpm+hlmxSzOcks+5
	hvcJsKGaYqZ5xRyy+P9L1IAaF6UkRvLUKcAaLkGcB4CEj3xZ0OT7URFas0RaQWXW
	G9ZOfiaVFTiBWxzFTtlgoBPKvcVdV31i+cJcsbJv9fbSs1DgXipei+QbbMs6U3CP
	abYZjShVzyTH8Yi8Fcn0xHZm0nilIfMEe9jU6epC6MPZspYiv3qsy1XivGD4e+rd
	PToJl+iEBH2rAjQbEQexQKEhAB+k4EGmzOU7Y2sxE5Rhhm9BX0kbW0rrA6/0+byG
	1zYRg9SoCksSFNL9YSnyXOya9jyqD7Ntxbyw3qL0HDKsSsbf+3UoJTF1l4fEuD7/
	9BT0rQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320y9kajj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 07:16:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM7GjAR026282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 07:16:45 GMT
Received: from [10.216.2.20] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 21 Nov
 2024 23:16:40 -0800
Message-ID: <82fc7b99-bc3e-4a9b-a472-c1b70671f21a@quicinc.com>
Date: Fri, 22 Nov 2024 12:46:37 +0530
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
 <10e4fd4e-559d-4164-ab94-d5f0a60ffc22@quicinc.com>
 <53876db8-4401-481d-8684-af7e135d481e@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <53876db8-4401-481d-8684-af7e135d481e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tpQHuPRYC9LisQ4lqI77GbTVtwFSu45O
X-Proofpoint-ORIG-GUID: tpQHuPRYC9LisQ4lqI77GbTVtwFSu45O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220059



On 11/21/2024 11:20 PM, Krzysztof Kozlowski wrote:
> On 21/11/2024 18:43, Raviteja Laggyshetty wrote:
>>
>>
>> On 11/21/2024 5:23 PM, Krzysztof Kozlowski wrote:
>>> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>>> SA8775P SoCs.
>>>
>>> This we see from the diff. Explain the hardware, why adding epps-l3-perf.
>>>
>> The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.Along with SoC specific compatible, add new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based L3 scaling.
> 
> Pasting the same replies as you pasted to others won't solve the
> problem. Solve the problem - fix the commit msg.
> 
>>
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
>>> I don't understand this change in context of driver. These are the same.
>>> Isn't this compatible with sm8250?
>>>
>>
>> The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
>> Using generic compatible avoids the need for adding chipset specific compatible in match table.
> 
> 
> Not true, specific compatibles used as fallback do the same and is a
> preferred way.
>

Will make use of sm8250 compatibles for sa8775p in the next patch revision.
 
> 
>> But received comment from konrad to add both SoC-specific and generic compatibles.
> 
> I went through the history and don't see anything like that. Point to
> the specific email please, if you disagree.
> 
https://patchwork.kernel.org/project/linux-pm/patch/20241026123058.28258-2-quic_rlaggysh@quicinc.com/#26104591


>> Dmitry has suggested to update generic comaptibles for sc7280 and sm8250 SoCs, which makes use of perf state registers. 
> 
> OK
> 
>> It will be done as separate patch series.
> 
> No. I expect to see full, correct picture, not half baked patches which
> contradict what is in current code.
> 
>
Ok, I will update the generic compatibles for sm8250, sc7280 SoCs in the 
next patch revision and will include them along with sa8775p dt patch.
 
> Best regards,
> Krzysztof


