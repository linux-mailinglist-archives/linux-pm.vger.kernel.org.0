Return-Path: <linux-pm+bounces-25289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37803A86549
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42CB4C71E8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575F21D5AE;
	Fri, 11 Apr 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YgAw9tB1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2E2367DC;
	Fri, 11 Apr 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395363; cv=none; b=KswkwXV7Vemo8MD7LcZPUrJyL2uHouzbA79eBcNbqt1KHdYzJV6d8MpZoUQXlhgxgaT4UCmYcKIA3Fi24vi9aCvnzSxiXcqSTylwPsNuwamgT8EWAZ+TPdAj9zIMYMA+SuK556fNZH2ibS7b0hmWDQ43NUaArQd/KiOvtjHeSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395363; c=relaxed/simple;
	bh=dyUHYy7uA2zYq4DX3dwXYPvpZrduLWaoUC38taKSDAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SK5fRzT+iNMYO5g8zTjZicOO++if3tA/3SN8BMNw1/SPbFB2Dw1vWXRrcvzGzkxrL0ci63LNeuuBcNHKAslZ5DXZywcA/Dq40RkAhztCh8cK9Oezr2MiAg4YkhFGfYNRD92YF3CPWEnmNzy78F1KJzrthCZ2Rg0UbGEaKCmM1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YgAw9tB1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFBKvF018740;
	Fri, 11 Apr 2025 18:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z3WYEGHjhVBiH0fk/qwPhN94rw6DRAu9oRxXveAoAAw=; b=YgAw9tB1oFNXcH7C
	H1WUnW1biTBR0Hix+yYpH5y4z6YhctvW7RV681op+sRyVeZn673ErOdtwojm4Z1q
	w7zbn46AN8UC0pDCoAMh6bAi+Blq7FNehXXIr1sA/fUVPhR+jx8yc9B7M9gl/2XB
	JvuY3OsOAKt5o7jNMOk0mjX6Bdy+AWMjIY2DIgK7ZJhLZfFEx5Bggy9eXb/jhAEw
	7J8FV1FIT5qYO/ZAMSdV00krHbwm1BMqDc1RQUE1lk86w0qPjb2DtMAUQkFChTMd
	UwRB+Ber+vbLG6P/lWBuipcq99W+u1cpbEwQeFZQoXrJ4lS2mDzjZYFldSvq0ldH
	UebAmg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdguewh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 18:15:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53BIFaVv005437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 18:15:36 GMT
Received: from [10.216.49.215] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Apr
 2025 11:15:30 -0700
Message-ID: <c4ae42cc-872d-41ea-95ad-9dc294f1a5a1@quicinc.com>
Date: Fri, 11 Apr 2025 23:45:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] dt-bindings: serial: describe SA8255p
To: Rob Herring <robh@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J.
 Wysocki" <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <psodagud@quicinc.com>,
        <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
References: <20250410174010.31588-1-quic_ptalari@quicinc.com>
 <20250410174010.31588-3-quic_ptalari@quicinc.com>
 <20250411175730.GA3642862-robh@kernel.org>
Content-Language: en-US
From: Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <20250411175730.GA3642862-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f95c5a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=_YL1DZwizIQu3P7nRPwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Fh9pCnJHT4bNCV0ULywHERNNYgfEWTZ8
X-Proofpoint-GUID: Fh9pCnJHT4bNCV0ULywHERNNYgfEWTZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110116

Hi

On 4/11/2025 11:27 PM, Rob Herring wrote:
> On Thu, Apr 10, 2025 at 11:10:03PM +0530, Praveen Talari wrote:
>> From: Nikunj Kela <quic_nkela@quicinc.com>
>>
>> SA8255p platform abstracts resources such as clocks, interconnect and
>> GPIO pins configuration in Firmware. SCMI power and perf protocols are
>> used to send request for resource configurations.
>>
>> Add DT bindings for the QUP GENI UART controller on sa8255p platform.
>>
>> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
>> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> Your tags go last because you touched this last (I assume). The order
> here would be correct if you were the original author, but Nikunj made
> significant enough changes to change the author and also sent the
> patches. The sender always has the last S-o-b (until the maintainer
> adds their's when applying).
Do you mean like below
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>

Are Co-developed-by and Signed-off-by both needed or can i keep s-o-b?

>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   .../serial/qcom,sa8255p-geni-uart.yaml        | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
>> new file mode 100644
>> index 000000000000..0dbfbfa1d504
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/serial/qcom,sa8255p-geni-uart.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Geni based QUP UART interface
>> +
>> +maintainers:
>> +  - Praveen Talari <quic_ptalari@quicinc.com>
>> +
>> +allOf:
>> +  - $ref: /schemas/serial/serial.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sa8255p-geni-uart
>> +      - qcom,sa8255p-geni-debug-uart
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    items:
>> +      - description: UART core irq
>> +      - description: Wakeup irq (RX GPIO)
> If this is a wakeup source, then you should have interrupt-names with
> 'wakeup' for the 2nd irq.

We have taken reference of below existing yaml file

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml

>
>> +
>> +  power-domains:
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: power
>> +      - const: perf
>> +
>> +  reg:
>> +    maxItems: 1
> 'reg' goes after compatible.
We have taken reference of 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
>
>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +  - reg
>> +  - power-domains
>> +  - power-domain-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    serial@990000 {
>> +        compatible = "qcom,sa8255p-geni-uart";
>> +        reg = <0x990000 0x4000>;
>> +        interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
>> +        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
>> +        power-domain-names = "power", "perf";
>> +    };
>> +...
>> -- 
>> 2.17.1
>>

