Return-Path: <linux-pm+bounces-20742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC76A17795
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 07:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33308188B2B3
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B31AF0C5;
	Tue, 21 Jan 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jpXFYLMN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DBA1AF0A7;
	Tue, 21 Jan 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737442520; cv=none; b=bMXhE1HzG+oCHwGmZxBTqUyi3NokE/jaT0Ceh+T5tgcwkHUd2rvbAgvQ84JOo46Vj+x/szRfejd0gbcwBhw42Pi1K4+PwliP6aEADjos5JEZSia5h5syVWSYB8NmJBUeKU6igXwzf8vHqu4e+78y77wqAojC7mecRyeMTJcEXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737442520; c=relaxed/simple;
	bh=pkm8XGAE9tgDnBm+3SLaqQ3Ut6liX6OdENqYFA4t+OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bOxygVs9qgEUyiICG/OOdYpKXT4DF7WpzpV6MT60tNvGRxdc266fv4I4TxbjIUusvwTg/7KjzWKmX8Tcek1+n1YUIMx2PNtgcXN2eyO10KvyLZcNj7FtmwrM5yxxllV1Nupw3zr288Jdxjmg0aT0ExMNbAuhRVbeSD7srEWqzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jpXFYLMN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L1t5aa005855;
	Tue, 21 Jan 2025 06:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Ogw/b8W6GWVghoCfvFWx9TFai7WFTa13iUYA0aGUl4=; b=jpXFYLMNc/oRS1bZ
	UtaaqxFevPVdQ1w1PYFKNp6E3hOIXruqJpwr5YRZKinbd2MxtnzNahH6BpierdEM
	5c/l7b11NdCmMh43MsYEFYkfwT6G0/1haqDfiOFB28ChYRgID3xK1LXlrzApcZFe
	cEjWspQCe+NqM6ehZU6LwOL1q4XKU3beOVa2HA6JyCzH+rT4pHnenb5J5cCiXPpg
	2DpOGDwoxyxEtscNfyZmxQXeKpZN79/mOXgMSZG5zhvpgpFBwCwLGeJD2V3Pt4Bv
	vMf2cz9pqgDAXSM0wo0w+wsU8mrk0AC9FPEcLQgigtN0L6NIKs5ur2CqiQlw7/ky
	RPB+jQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a2b80kdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 06:55:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L6tALO016455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 06:55:10 GMT
Received: from [10.219.0.139] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 Jan
 2025 22:55:04 -0800
Message-ID: <7dedc018-b705-44c3-a1d4-e1414cc91b10@quicinc.com>
Date: Tue, 21 Jan 2025 12:25:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Enable Bluetooth on qcs6490-rb3gen2 board
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
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
 <3c313557-ca99-4e6f-9d71-641e8c256126@quicinc.com>
 <efab0b18-f1f0-457a-b1d5-8734f178141d@oss.qualcomm.com>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <efab0b18-f1f0-457a-b1d5-8734f178141d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7lYv6jjFdR3G11e4kPHn4ELiuyg33dax
X-Proofpoint-ORIG-GUID: 7lYv6jjFdR3G11e4kPHn4ELiuyg33dax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_03,2025-01-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210055



On 12/12/2024 11:12 PM, Konrad Dybcio wrote:
> On 12.12.2024 11:46 AM, Janaki Ramaiah Thota wrote:
>>
>>
>> On 12/11/2024 3:12 AM, Rob Herring (Arm) wrote:
>>>
>>> On Mon, 09 Dec 2024 16:04:51 +0530, Janaki Ramaiah Thota wrote:
>>>> - Patch 1/4 Add description of the PMU of the WCN6750 module.
>>>> - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
>>>> - Patch 3/4 use the power sequencer for wcn6750.
>>>> - Patch 4/4 add support for the WCN6750 PMU.
>>>>
>>>> ----
>>>> Changes from v4:
>>>> * Added reviewed tag by Krzysztof in p1
>>>> * Updated the p2 commit message with sw_ctrl and wifi-enable are
>>>>     handled in wifi FW.
>>>> * Added blank line between the nodes in p2
>>>> * Placed the structures in proper order in p4
>>>> * Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/
>>>>
>>>> Changes from v3:
>>>> * Defined the PMU node and used the its output to power up BT
>>>> * Used power sequencer for wcn wcn6750 module
>>>> * Split the patch to multiple as per subtree
>>>> * Add description of the PMU of the WCN6750 module
>>>> * Include separate UART state node for sleep pin configuarion
>>>> * Link to v3: https://lore.kernel.org/linux-arm-msm/20241022104600.3228-1-quic_janathot@quicinc.com/
>>>>
>>>> Changes from v2:
>>>> * Sorted nodes alphabetically
>>>> * Link to v2: https://lore.kernel.org/linux-arm-msm/20241010105107.30118-1-quic_janathot@quicinc.com/
>>>>
>>>> Changes from v1:
>>>> * Corrected the board name in subject
>>>> * Link to v1: https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/
>>>>
>>>> Janaki Ramaiah Thota (4):
>>>>     regulator:·dt-bindings:·qcom,qca6390-pmu:·document wcn6750-pmu
>>>>     arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
>>>>     Bluetooth: hci_qca: use the power sequencer for wcn6750
>>>>     power: sequencing: qcom-wcn: add support for the WCN6750 PMU
>>>>
>>>>    .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>>>>    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 168 +++++++++++++++++-
>>>>    drivers/bluetooth/hci_qca.c                   |   2 +-
>>>>    drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>>>>    4 files changed, 217 insertions(+), 2 deletions(-)
>>>>
>>>> -- 
>>>>
>>>>
>>>>
>>>
>>>
>>> My bot found new DTB warnings on the .dts files added or changed in this
>>> series.
>>>
>>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>>> are fixed by another series. Ultimately, it is up to the platform
>>> maintainer whether these warnings are acceptable or not. No need to reply
>>> unless the platform maintainer has comments.
>>>
>>> If you already ran DT checks and didn't see these error(s), then
>>> make sure dt-schema is up to date:
>>>
>>>     pip3 install dtschema --upgrade
>>>
>>>
>>> New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20241209103455.9675-1-quic_janathot@quicinc.com:
>>>
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'enable-gpios' is a required property
>>>      from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'swctrl-gpios' is a required property
>>>      from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddio-supply' is a required property
>>>      from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddbtcxmx-supply' is a required property
>>>      from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 'vddasd-supply' is a required property
>>>      from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>>> arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pinctrl@f100000: Unevaluated properties are not allowed ('qup_uart7_sleep' was unexpected)
>>>      from schema $id: http://devicetree.org/schemas/pinctrl/qcom,sc7280-pinctrl.yaml#
>>>
>>
>> Since the DTS files for all boards using the WCN6750 BT chip are not updated according to the PMU node, updating the bluetooth/qualcomm-bluetooth.yaml file will result in similar warnings for other boards.
> 
> Oh I didn't forsee this.. You must fix up any bindings errors that
> result from your changes (i.e. binding errors are the same as compilation
> errors).
> 
> That means patch 2 can't be merged unless the bluetooth dt-bindings
> are adjusted. And for the bindings to be adjusted, you'll have to also
> add the PMU node to all boards implementing wcn6750.
> 
> Fortunately, they are all based on some variants of the same SoC, so
> they should all have the same power plumbing.
> 
> Konrad

We adjusted the dt-bindings to fix the bindings errors and it is merged 
to 
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=cca4fe34979a77d9df5c0acf935e9cc939fe5cd6

Please merge below pending patches:
  - Patch 2/4 add and enable BT node for qcs6490-rb3gen board.
  - Patch 3/4 use the power sequencer for wcn6750.


Thanks,
Janakiram


