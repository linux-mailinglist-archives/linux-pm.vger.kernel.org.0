Return-Path: <linux-pm+bounces-18703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3E9E70A6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB90C16573B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7291494A8;
	Fri,  6 Dec 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KkJZIm+0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749A193;
	Fri,  6 Dec 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496355; cv=none; b=GW9VWemC26a+CS+gRlP/wQeD+FVIcdvGp/4I/UP7vZAXQJ9lnewGWhoz+FGCBVSRWNZ3lEkphqU2n7nerj5U3uQV/2asa0RgDuuYoWaHwNKcTJ+PhrBhujTxSzZG2jfZG2LRMtzmeMiLE8iRLyiNlgPpQ1+lqQasUdUJ1qDaYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496355; c=relaxed/simple;
	bh=RCAerEsBSOduxZ6ChbLto3fB45xJtvmu2G8R9418J60=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H5b4mmyyo0OOnQtVTahfYCgg6eWi2b63/NOeNC5kOESDWdsozscef3J8MKlZ3mT7KmG4P1g5QqLNq2lW/iXaFnyFk84ngYpFT5ptNyKAgQQgVlpSstK0oQLXeG0XXBOnTuD1LV8p1wilOBcrgzshl3fwInyv0GDipH/IALdBFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KkJZIm+0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B68a6uD018434;
	Fri, 6 Dec 2024 14:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F6xvmmj4pj78R2BWZJh97FZN7e9Q86pkpxcb1LWqoWA=; b=KkJZIm+0Q9+bKdrF
	I04Pfw2jwRE5iFhohFyfFgcQBh8BM1BLdPWj/Hipxw3Fao8Qwtsgz+c406CtG/gn
	DibvlRDr07GCxbd+gHZlyZ7P1Zuq79VWbwRYA30tuOuUdBUOs8D9+DLnKMK7CmOE
	w4gYrV4Pac53HgdaqWjMWnQzB7b4LOhgdcfhOhR8+y/Unk2IqasNBZ2Nb+r9d8Cc
	shbOXRZ8b7p827pn0jCin9mygGKZhDf0bKPGQwYGwwLOG995kroWWcOfLO7BZquV
	eGDgZPa2H0E0Q2FNVVnsKkJBbTxgDmvvziQ8J3S1oIf1dwOjkt+vqsiUUJkshet9
	6EJt1Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bjk8tmq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 14:45:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6Ejjfi011238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 14:45:45 GMT
Received: from [10.216.17.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Dec 2024
 06:45:38 -0800
Message-ID: <53d44689-798e-4b5f-a0f1-8a39bea2f19b@quicinc.com>
Date: Fri, 6 Dec 2024 20:15:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
 <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x4Hfa3zjxpu6CePiOiqZlv4-e8w3wYJE
X-Proofpoint-GUID: x4Hfa3zjxpu6CePiOiqZlv4-e8w3wYJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060110



On 12/5/2024 4:29 AM, Dmitry Baryshkov wrote:
> On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
>> Add a node for the PMU module of the WCN6750 present on the
>> qcs6490-rb3gen board and assign its power outputs to the Bluetooth
>> module.
>>
>> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
>>   1 file changed, 164 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 27695bd54220..07650648214e 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: BSD-3-Clause
>>   /*
>> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>>   /dts-v1/;
>> @@ -33,6 +33,7 @@
>>   
>>   	aliases {
>>   		serial0 = &uart5;
>> +		serial1 = &uart7;
>>   	};
>>   
>>   	chosen {
>> @@ -217,6 +218,63 @@
>>   		regulator-min-microvolt = <3700000>;
>>   		regulator-max-microvolt = <3700000>;
>>   	};
>> +
>> +	wcn6750-pmu {
>> +		compatible = "qcom,wcn6750-pmu";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&bt_en>;
>> +		vddaon-supply = <&vreg_s7b_0p972>;
>> +		vddasd-supply = <&vreg_l11c_2p8>;
>> +		vddpmu-supply = <&vreg_s7b_0p972>;
>> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
>> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
>> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
>> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
>> +
>> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> 
> Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?
> 

For Bluetooth, these pins are not needed. We have verified Bluetooth 
functionality, and it is working fine.

Thanks,
Janakiram


