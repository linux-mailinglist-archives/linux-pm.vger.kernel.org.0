Return-Path: <linux-pm+bounces-18786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657C9E8631
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0096C2815C4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B04D1591EA;
	Sun,  8 Dec 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iFZmwuLc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCB13B2B6;
	Sun,  8 Dec 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674376; cv=none; b=hj+hPGhFm62MpWw+MyidlVgynvZsIz73HDp//Lu//FqXwmeeCIoJg+VMBFY89iR9HpaSgLl72L1yeOOXZ2HBUi0mqpc6Haoi1ok5wALnwk2W0aJ02N5RavQkGDqAz4MlRtGrBVoCmCDz/EHYgPt7rSkt0hTpYnf6lp6ametxf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674376; c=relaxed/simple;
	bh=TsI8s95ukz52F4dFjZU0phGSfOtwTyjzbFM/oksHDWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V0lNZ2oGg83b7qZmTOnqT0NF3P1N+MsJJXsCXU8mTYcAwkovBN1hDHA/L1//zK1Q/OJesCH840IgdpPctJzaeINq0l1cpHloVTM2V5WmObsVEZ5e1wH3mclIsxp96c4fFolAj1l5feazhIRjKlx0qc68ZSIBwujL8yGr0d1j5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iFZmwuLc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8EnNce016104;
	Sun, 8 Dec 2024 16:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tfYZlBzDBXMUAgDb2EyeHqUuMw1X88nJinjqD5B5u5k=; b=iFZmwuLcOBjmJ80B
	B/K3aE/WSKPqI785kf8OCQmdt1Nr6ak0MkscfAUl8ZuGKi+S+XYniZXd4827w4qm
	AmHjq05Tvt1uZHYrwdibo3kqaDd+5RaHHnhxKup2U65KzaTFM9s+t+w3YfqNpOhk
	KAFDFCMHfo8lIczevb6OSYl25evobSKtML3r9jDjWzsghdx1NIkFCSPP6uOH/gIt
	Ii1eDIYUpfobMrIZjK9QFhkg50C4n/6fegDdtWzJsbhuN7yDXZUYA8xtY6HGc8iu
	32somT5NxxssupDAOVE13xsr8SAc5eCJsQTbSd0a4jxL2vipOBz4WcTk2+IkwIvX
	IZIQnA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgjekj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 16:12:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B8GCVuo005677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 8 Dec 2024 16:12:31 GMT
Received: from [10.216.58.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 08:12:25 -0800
Message-ID: <d68907f0-15e4-486a-9077-31e8a8659e02@quicinc.com>
Date: Sun, 8 Dec 2024 21:42:21 +0530
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
 <53d44689-798e-4b5f-a0f1-8a39bea2f19b@quicinc.com>
 <hjui7cn4iuo4id2q4mmqx2i7c3eyu6ae43fcft6psflypb3aya@ia5i5s4ya45e>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <hjui7cn4iuo4id2q4mmqx2i7c3eyu6ae43fcft6psflypb3aya@ia5i5s4ya45e>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2sbgzf7YqgO8AauF1AblMxRu4vkbnUU-
X-Proofpoint-ORIG-GUID: 2sbgzf7YqgO8AauF1AblMxRu4vkbnUU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412080135



On 12/8/2024 5:35 PM, Dmitry Baryshkov wrote:
> On Fri, Dec 06, 2024 at 08:15:35PM +0530, Janaki Ramaiah Thota wrote:
>>
>>
>> On 12/5/2024 4:29 AM, Dmitry Baryshkov wrote:
>>> On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
>>>> Add a node for the PMU module of the WCN6750 present on the
>>>> qcs6490-rb3gen board and assign its power outputs to the Bluetooth
>>>> module.
>>>>
>>>> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
>>>>    1 file changed, 164 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>> index 27695bd54220..07650648214e 100644
>>>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>> @@ -1,6 +1,6 @@
>>>>    // SPDX-License-Identifier: BSD-3-Clause
>>>>    /*
>>>> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>    /dts-v1/;
>>>> @@ -33,6 +33,7 @@
>>>>    	aliases {
>>>>    		serial0 = &uart5;
>>>> +		serial1 = &uart7;
>>>>    	};
>>>>    	chosen {
>>>> @@ -217,6 +218,63 @@
>>>>    		regulator-min-microvolt = <3700000>;
>>>>    		regulator-max-microvolt = <3700000>;
>>>>    	};
>>>> +
>>>> +	wcn6750-pmu {
>>>> +		compatible = "qcom,wcn6750-pmu";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&bt_en>;
>>>> +		vddaon-supply = <&vreg_s7b_0p972>;
>>>> +		vddasd-supply = <&vreg_l11c_2p8>;
>>>> +		vddpmu-supply = <&vreg_s7b_0p972>;
>>>> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
>>>> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
>>>> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
>>>> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
>>>> +
>>>> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
>>>
>>> Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?
>>>
>>
>> For Bluetooth, these pins are not needed. We have verified Bluetooth
>> functionality, and it is working fine.
> 
> You are describing the hardware (PMU), not "a part of the PMU for the
> BT". Please check if there should be a wifi enable pin and adjust
> accordingly.
> 

We further checked with WiFi team. For wcn6750, sw_ctrl and wifi-enable 
pins handled from WiFi firmware/controller. So it is not needed to 
handle in PMU.

Thanks,
Janakiram


