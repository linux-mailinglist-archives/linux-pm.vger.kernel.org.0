Return-Path: <linux-pm+bounces-19114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72E9EE477
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068171886EDB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA421146D;
	Thu, 12 Dec 2024 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ID6nVJSB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93826210F6A;
	Thu, 12 Dec 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000418; cv=none; b=ixf/XU9HmnOl9cq2JR6gTJCKkF7N/f4eCqw+G958OZvMgB0b+n1Kw/TbY9i2TOEkbyJJP4hnT63d57gg7s9v1Nv7YM2fF8IaTlqIP2RST2YL4/OJZ+0fC1ZsG8P10RYaqyKNSfjQPWlK2LCQ9tUG511jwWEl9KnNeTAHXNpJr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000418; c=relaxed/simple;
	bh=cB1uUmAhU+aHRtpBwlueGez8aRvqoT36e/Nk75OuHkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vj9mh3Y5W4qT723Se+FDwIVtAmH29VLmpOTgdwkVmHeptW2bb48NPXqglpRPb6os6P3JX8lCAmmiw5AOghNbQlmM2LNBJvXYuz2UQuL6AIX9k0I91O0R+MwqS49zY22cSDk0RvMDPMcb1k0QqbXj+jd1kGXvLfQ9leRHAR3YxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ID6nVJSB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7KleG015124;
	Thu, 12 Dec 2024 10:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jEIIHkgbMQKsYOwH4G4GkI9cirdEanSGZxZwk+xUnvg=; b=ID6nVJSBLfY7ECAb
	W4q9KKKp3UUseUMBlTyhHVkWATqNr23vmvkWiayS7a0ArUMKbMe6xhZ1r36KnEZO
	Zx2yJC4iNJnng5DH9/jb9KIWIu5y3nm1p9ASRVUQiPUoKiaXA98PyjhBArOZfAug
	7Ecg5EyeExEvhr2Om9OfGpDdbLGHeNd17H9E9EYM2T6llNJOtCKdFp27/PYAKhKE
	LjvcULXJZA6rZqqf/q6xqInAuJvsn+p2NGfTOKNBXaFdSQvhZ0RsmbsJ2+/Gxo99
	Cl3AiOjuUnlm5sCBSSL2ANCitqiEG9S7riMUwhihjklR956V3V3K3M3ioTq6TOjG
	e6WiBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f7dpkuqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:46:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCAkirx023600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:46:45 GMT
Received: from [10.216.23.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 02:46:37 -0800
Message-ID: <3c313557-ca99-4e6f-9d71-641e8c256126@quicinc.com>
Date: Thu, 12 Dec 2024 16:16:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2 board
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <quic_anubhavg@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        <linux-pm@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <devicetree@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
 <173386568587.497565.1413799827375300987.robh@kernel.org>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <173386568587.497565.1413799827375300987.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZFQ2FmKDgk_xdmQS2RW5CYLrDTAF7MM-
X-Proofpoint-ORIG-GUID: ZFQ2FmKDgk_xdmQS2RW5CYLrDTAF7MM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120076



On 12/11/2024 3:12 AM, Rob Herring (Arm) wrote:
> 
> On Mon, 09 Dec 2024 16:04:51 +0530, Janaki Ramaiah Thota wrote:
>> - Patch 1/4 Add description of the PMU of the WCN6750 module.
>> - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
>> - Patch 3/4 use the power sequencer for wcn6750.
>> - Patch 4/4 add support for the WCN6750 PMU.
>>
>> ----
>> Changes from v4:
>> * Added reviewed tag by Krzysztof in p1
>> * Updated the p2 commit message with sw_ctrl and wifi-enable are
>>    handled in wifi FW.
>> * Added blank line between the nodes in p2
>> * Placed the structures in proper order in p4
>> * Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/
>>
>> Changes from v3:
>> * Defined the PMU node and used the its output to power up BT
>> * Used power sequencer for wcn wcn6750 module
>> * Split the patch to multiple as per subtree
>> * Add description of the PMU of the WCN6750 module
>> * Include separate UART state node for sleep pin configuarion
>> * Link to v3: https://lore.kernel.org/linux-arm-msm/20241022104600.3228-1-quic_janathot@quicinc.com/
>>
>> Changes from v2:
>> * Sorted nodes alphabetically
>> * Link to v2: https://lore.kernel.org/linux-arm-msm/20241010105107.30118-1-quic_janathot@quicinc.com/
>>
>> Changes from v1:
>> * Corrected the board name in subject
>> * Link to v1: https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/
>>
>> Janaki Ramaiah Thota (4):
>>    regulator:·dt-bindings:·qcom,qca6390-pmu:·document wcn6750-pmu
>>    arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
>>    Bluetooth: hci_qca: use the power sequencer for wcn6750
>>    power: sequencing: qcom-wcn: add support for the WCN6750 PMU
>>
>>   .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 168 +++++++++++++++++-
>>   drivers/bluetooth/hci_qca.c                   |   2 +-
>>   drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>>   4 files changed, 217 insertions(+), 2 deletions(-)
>>
>> --
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20241209103455.9675-1-quic_janathot@quicinc.com:
> 
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'enable-gpios' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'swctrl-gpios' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddio-supply' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddbtcxmx-supply' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddasd-supply' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pinctrl@f100000: Unevaluated properties are not allowed ('qup_uart7_sleep' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,sc7280-pinctrl.yaml#
> 

Since the DTS files for all boards using the WCN6750 BT chip are not 
updated according to the PMU node, updating the 
bluetooth/qualcomm-bluetooth.yaml file will result in similar warnings 
for other boards.

Thanks,
Janakiram


