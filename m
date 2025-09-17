Return-Path: <linux-pm+bounces-34887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075EAB80BA5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484961892F98
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDA314D2C;
	Wed, 17 Sep 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jyuy7Gal"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358F285C82;
	Wed, 17 Sep 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124060; cv=none; b=Obq+370gJr6EL7PzBKZ7bsTIALQ9EfuwgWLFH4MlmAU919bIsbSx7jUOdL4VOTSQujI3w9n6HMiiTlGgzDiz41rfDB1Ka5SHxFmP0aTAZwdZ+OTEYt/bwGv9jqtY5vLGr70x6vOvqABpLx6kOgKequ5VScocJI9AEpQpfwm+h/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124060; c=relaxed/simple;
	bh=NlYC/Qs/zM0HnIIEytwgOrzKMLjNq/qFHYT1dPcwfWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NmTXaHQ/XKcoqc/dTYVx0rPUTcG/LdCtCqwVrcV3UN2htZqdezpdJmIQhqEps166MFdZIkdQnF6bzweBP7U7RzMwRQyMz51irYRDZm1FWJXsVive9lERrQawSUf1wBge1nSYSivApVkck37yRZp6lq5k2HQZfqCEzLYjawF7rCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jyuy7Gal; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HB0uJu031000;
	Wed, 17 Sep 2025 15:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nm5EclL4hvVyoCBtsdEWwKNnR6ndycdHW5JBCL0fhsU=; b=Jyuy7GalvecMmaUM
	jKrC/FbQSCt8bh0Y2vn/D0Tgxno7s3ZRbiuGxfCMuw+FnTDMVUWrFn+nqGoSHEK1
	ZzBku7SB9HoXqyNjoBeB98uYaIGCHVo0lqIVwzwO16eqGCAINbmVIiszR1XlFSSa
	egFPFN6tm1vi5FhGQUWmUXWOtPrW7bMDucKPpA2yy/alBH8AhNIqEGc1LIEDc42t
	remUyzRSzNKxBN829OdYEXNBvL1web4epncuwXDBXkPrh2YG8CR6NyTh+9qMXnF1
	8FmSZkpOetZh5/Cm+cxs7VXvFc5C+9N95O5hPWuR0K38w8G5vGouuicTWibMRYAL
	DdzRfw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0tyqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 15:47:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58HFlMsX029136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 15:47:22 GMT
Received: from [10.253.13.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 17 Sep
 2025 08:47:15 -0700
Message-ID: <d8da8454-d5ab-41e9-a34a-127366e83ae1@quicinc.com>
Date: Wed, 17 Sep 2025 23:47:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
 <0aa8bf54-50e4-456d-9f07-a297a34b86c5@linaro.org>
 <1e7d7066-fa0b-4ebc-8f66-e3208bb6f948@quicinc.com>
 <e874339e-f802-4793-8c0f-db85575be8e5@linaro.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <e874339e-f802-4793-8c0f-db85575be8e5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wXx7ORkbgQ2ggq8x1-ynkeB8cSyPi6kB
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cad80a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=YxtPb7ZjVR6RY7X2M68A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wXx7ORkbgQ2ggq8x1-ynkeB8cSyPi6kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5Fbqin2NXOcS
 e/NUiqHV51DBjUSBU5UbMKF9nGCBGOyb5Nnp+V6E5uNz/36h6XhaApGN+Af7me0yuDasmV8NLO+
 pnI4a5yQNAGB4fsZTrosNWNf8KxDtvGwgFOrlfaDFgMBnGwOvP1FqfRTssphD6cG1gTVf2Q7syA
 M8N/ynAIMAE3l53RKIylbihwoOea1ymxbuiCcUl4pGBVVk6BSURI9THQkMMcVpudISYWLdfAEIp
 cxVpUM6XI8ItqCqnvY1x3fob/HbO1aLy8sfMuG97QjCTxRTJhUK15eFurFTCOYXS41s5VUspzxV
 HvGdXMgG7Nd4EafFW62QoM+qOMV+MthOTMaQ/7nQkbcu9in0SqwkV/lR1OTCpBvFjoFzh6Hlnrh
 7/cBr6Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 8:35 AM, Krzysztof Kozlowski wrote:
> On 16/09/2025 16:03, Luo Jie wrote:
>>
>>
>> On 9/12/2025 5:16 PM, Krzysztof Kozlowski wrote:
>>> On 12/09/2025 11:13, Konrad Dybcio wrote:
>>>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>>>> provider and an interconnect provider. The #interconnect-cells property
>>>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>>>> the NSS ICC provider.
>>>>>>
>>>>>> Although this property is already present in the NSS CC node of the DTS
>>>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>>>> omitted from the list of required properties in the bindings documentation.
>>>>>> Adding this as a required property is not expected to break the ABI for
>>>>>> currently supported SoC.
>>>>>>
>>>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>>>> binding requirements for interconnect providers.
>>>>>
>>>>> DT bindings do not require interconnect-cells, so that's not a correct
>>>>> reason. Drop them from required properties.
>>>>
>>>> "Mark #interconnect-cells as required to allow consuming the provided
>>>> interconnect endpoints"?
>>>
>>>
>>> The point is they do not have to be required.
>>
>> The reason for adding this property as required is to enforce
>> the DTS to define this important resource correctly. If this property
>> is missed from the DTS, the client driver such as PPE driver will not
>> be able to initialize correctly. This is necessary irrespective of
>> whether these clocks are enabled by bootloader or not. The IPQ9574 SoC
>> DTS defines this property even though the property was not marked as
>> mandatory in the bindings, and hence the PPE driver is working.
>>
>> By now marking it as required, we can enforce that DTS files going
>> forward for newer SoC (IPQ5424 and later) are properly defining this
>> resource. This prevents any DTS misconfiguration and improves bindings
>> validation as new SoCs are introduced.
> 
> So you explain to the DT maintainer how the DT works. Well, thank you,
> everyday I can learn something.
> 
> You wasted a lot of our (multiple maintainers) time in the past, so I
> will just NAK your patches instead of wasting time again.
> 
> Best regards,
> Krzysztof

My sincere apologies for the misunderstanding and inconvenience my
previous response has caused. I can assure you that my intention
was never to describe the DT subsystem working, and am sorry that
it has come out as such.

I am committed to learning and continuously improving the quality
of my contributions, and co-operating with reviewers and maintainers
by following their feedback.

I will update the patch accordingly to remove this property marking
as required. Thank you very much for your support.

