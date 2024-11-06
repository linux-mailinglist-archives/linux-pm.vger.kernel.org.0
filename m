Return-Path: <linux-pm+bounces-17065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB829BE51C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 12:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F42835CC
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611B1DE2DF;
	Wed,  6 Nov 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XYIQcpUq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E81DB377;
	Wed,  6 Nov 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890931; cv=none; b=Vj4QDcAIV2qbVZ9rLs9KnmsrVTAqRfZLFDaRcz+zZsg9zax7LJaMmtwhFAOhfRswS/jxaY9t5xg8RaCnrBjAKlafRxjA4I1llW5EiMJjnvk4BNHirk/DI/7IHKIecEsyAVsF0+571Pz4Y9lye1LiNbuhnbWNFb93z1bnNiUfBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890931; c=relaxed/simple;
	bh=1dTRn6G3+FsVzkxhN1/j7Oz/OfNqXXZqYece5eehNKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rVMFBBiV3GY6kYtWBqBxqWxPeVFCWogUUoTKXKh2GcOYDqdF/NdDxEN0f7igWVrM/bkVS/57CDd3Qc59uNwycIfFB7kUjHZHi/MK8I9YUdsw7IjTzge+CkK6tuzjvPv7DybsrA3Qw8LrzNavcIhXioLbAJkAL7RkG9RyE2OV654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XYIQcpUq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A66cCrv028341;
	Wed, 6 Nov 2024 11:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZjS0l83UJc0bSCWh5cI259hHg/JCYwNlqHSFdWT8+Kw=; b=XYIQcpUqAirPL+lC
	5RRDVa8ZH192RiCm2j/HEIf6LfvXiBfQLQLt1BlJvxE4VNbZaZWt+UcYSzhaLwDw
	yJAnOZ/r2iat3FogF6fZrUTkVNxSFrXQEL7TbdZ0BKv74jU32pV/rNpr+QEM6amY
	aXnki9zetgRKVOLJg8fCRtJmP8mtG8A3A8Qlxt1rFLTazKArTZ2V7xnC1YOMab5C
	WKIo4OhNIEv2gdWfYEvvmTgUIYRHpCRJTAbDMGnKHu4CCvXz280h8JxWU3fXPZNL
	FH/sJmIEq1dEH50rboPgrv7QRRvSGsf0py3GoeTmVshDdH/cmdnbjvrbUg0B/6CW
	gHrjHw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r3c18p2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 11:02:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6B248i009079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 11:02:04 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 03:01:59 -0800
Message-ID: <78442ba8-b6c9-45be-afbc-09456cec5a28@quicinc.com>
Date: Wed, 6 Nov 2024 16:31:57 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
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
 <00c9feac-722a-481a-9c57-36463fe0b3ff@quicinc.com>
 <925202f0-7fd1-4422-88fb-138c9027ac2c@oss.qualcomm.com>
 <CAA8EJpqM0vQZR5yEbGeBBPbog4KoEiTp1kWRwrjuwO4wo_umaw@mail.gmail.com>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <CAA8EJpqM0vQZR5yEbGeBBPbog4KoEiTp1kWRwrjuwO4wo_umaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xSnczSEthktzFdMKL2ZXPLJSMzcwFPzD
X-Proofpoint-ORIG-GUID: xSnczSEthktzFdMKL2ZXPLJSMzcwFPzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060090



On 11/4/2024 4:08 PM, Dmitry Baryshkov wrote:
> On Mon, 4 Nov 2024 at 09:35, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4.11.2024 7:40 AM, Raviteja Laggyshetty wrote:
>>>
>>>
>>> On 11/1/2024 12:26 AM, Dmitry Baryshkov wrote:
>>>> On Wed, Oct 30, 2024 at 12:23:57PM +0530, Raviteja Laggyshetty wrote:
>>>>>
>>>>>
>>>>> On 10/26/2024 8:15 PM, Dmitry Baryshkov wrote:
>>>>>> On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
>>>>>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>>>>>> SA8775P SoCs.
>>>>>>>
>>>>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>>>>>>  1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>>>> index 21dae0b92819..042ca44c32ec 100644
>>>>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>>>> @@ -34,6 +34,10 @@ properties:
>>>>>>>                - qcom,sm8250-epss-l3
>>>>>>>                - qcom,sm8350-epss-l3
>>>>>>>            - const: qcom,epss-l3
>>>>>>> +      - items:
>>>>>>> +          - enum:
>>>>>>> +              - qcom,sa8775p-epss-l3
>>>>>>> +          - const: qcom,epss-l3-perf
>>>>>>
>>>>>> Why is it -perf? What's so different about it?
>>>>>
>>>>> The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.
>>>>> So adding new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based l3 scaling.
>>>>
>>>> Neither sm8250 nor sc7280 use this compatible, while they also use
>>>> PERF_STATE register.
>>>>
>>> That is correct, both sm8250 and sc7280 use perf state register.
>>> The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
>>> Using generic compatible avoids the need for adding chipset specific compatible in match table.
>>
>> That is exactly what bindings guidelines forbid.
>>
>> You need a SoC-specific compatible so that you can address platform-
>> specific quirks that may arise in the future while keeping backwards
>> compatibility with older device trees
> 
> The proposed bindings have SoC-specific compat. If that's not against
> the current rules, I'd prefer to have qcom,epss-l3-perf to be added to
> sc7280 and sm8250 too.
> 
> 
Existing compatibles for sc7280 and sm8250 do not break the backward compatibility.
I will take up the update of generic compatibles for these two SoCs as separate patch series.




