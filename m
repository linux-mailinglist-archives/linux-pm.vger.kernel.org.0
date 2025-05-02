Return-Path: <linux-pm+bounces-26541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0945AA698A
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E027ADA5A
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BE18FDBE;
	Fri,  2 May 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J2+h4eJp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013527718;
	Fri,  2 May 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746157798; cv=none; b=nhWljYYbSFxsk1kAUXRUxAfmWOpjfefNcZPlv/0/hDHlHnMV0epR3JSXE/wlFmfXXqkh/5fco3GzJBwUBWiZgycQpfK5WFyH8t9YK89N0mb3TDkEQekCtNgMMuFFM4IkodY0ehiIeju3rvUXp17OGDRVOdOO9KQym2COZT+0GLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746157798; c=relaxed/simple;
	bh=U5mdhGYsJQIu31ah8zFEE1prb3PTq8AzmT9FnTheryc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WnnER7C5wKiIHGZXmq5DqDa+nLiiQFZK6JP9+KMV5ZClqUtYBXrqNaec0x6EdGhDGxgX0/+u9r50Jo5kV8W2DrzthQlQGKg4uXWacF6TfEKDjqKMkyR/daj26yei13FIf8vdABoOUigltWCnm44IMWviPar4hcIYvHDkoSS+rBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J2+h4eJp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421MvsN001947;
	Fri, 2 May 2025 03:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8aIn+HhV0I+UOqU2s77LSnK4rEAaF/YhK6sj5oV1cl4=; b=J2+h4eJpvRYGzO7e
	iERM1hAZT85zLkLdfJQODWCDkBf63UG1AUC8HG7RK+O5UhqUK/fCjSmCOzufUpea
	LlwFQHFcRllvbq3vfbPlDCDi2FdBIfkoIjnh11HrMVl+/Y9QOm+tqtECEnmnSwuQ
	oPT02WvE18jDW3aqRYphSM5EeTUaR50f196izV/hAeWY/1vGRJoLq6UhhkZcchL8
	8mL6qHddxJpOqW9no7Ja7okt7XELeTbEyvHw6t5OE3o4W4kqOE34JurpgetgkNc5
	5iMPIgcL/ux1Qfaaoo3q6EJchtmSehbIOdMKD9GBqViqMdOUXi052Mm+NqXwqIMP
	Y1MdUA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u7771a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 03:49:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5423npWo026585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 May 2025 03:49:51 GMT
Received: from [10.110.24.115] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 May 2025
 20:49:50 -0700
Message-ID: <d7c53dac-790a-490f-b757-fa2bc86b5276@quicinc.com>
Date: Thu, 1 May 2025 20:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] dt-bindings: serial: describe SA8255p
To: Praveen Talari <quic_ptalari@quicinc.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <psodagud@quicinc.com>, <djaggi@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>, <quic_arandive@quicinc.com>,
        <quic_mnaresh@quicinc.com>, <quic_shazhuss@quicinc.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-3-quic_ptalari@quicinc.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20250502031018.1292-3-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAyNiBTYWx0ZWRfXxQtudpHRtV6Z NMesxL05INmoHCNBtBocmmmOi/PvKeRLaEUr/FGPHJSx+8ty7qdmBpCWkP09klyS9A4UtstyLSN HZiefs1H8B/0MtGmZ/zypGJo8myeg0jcmE7pcpiLPa6if4A4eFj1zmxKhZefHspw/r1P9idi4I8
 B5GpgauU78RfOyejBUMtVHptoiufkX0pWdxngR6Ay8gpFPnfpwGEbev4La4lNOyafK5v08ZUD9+ G30oK/2b438q+2f+z11Q4kYAqsEjuoWPr7k2OkeHgWswxgTBKNwNKD2v+wiGJq3/Nsg/K00gMCa 7tRKwZ7N2vjnaQD7cq5kUYa0wCkx/7Ivi+AL4wLx3dPglclMJoaIaJ2pRD+B1BGUm4N7QA8rV9k
 Wck+k5vMG81hgTv7t9vsTmr0UzKRk/FwVWXO3DEaXuYhSQmSN2gDxCoXhOhLv2lONl2bAQyw
X-Proofpoint-GUID: z9yNTtQf08yRmmdQ-iyaXiJIvG2XhYYt
X-Authority-Analysis: v=2.4 cv=W404VQWk c=1 sm=1 tr=0 ts=681440df cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=i1IpkjnnKvMeRn0L5gEA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: z9yNTtQf08yRmmdQ-iyaXiJIvG2XhYYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020026

On 5/1/2025 8:10 PM, Praveen Talari wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
> 
> SA8255p platform abstracts resources such as clocks, interconnect and
> GPIO pins configuration in Firmware. SCMI power and perf protocols are
> used to send request for resource configurations.
> 
> Add DT bindings for the QUP GENI UART controller on sa8255p platform.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Co-developed-by: Praveen Talari <quic_ptalari@quicinc.com>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> 
> v2 -> v3
> - dropped description for interrupt-names
> - rebased reg property order in required option
> 
> v1 -> v2
> - reorder sequence of tags in commit text
> - moved reg property after compatible field
> - added interrupt-names property

Please fix all the patches. 

> ---
>  .../serial/qcom,sa8255p-geni-uart.yaml        | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> new file mode 100644
> index 000000000000..85b1d7c05079
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/qcom,sa8255p-geni-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Geni based QUP UART interface
> +
> +maintainers:
> +  - Praveen Talari <quic_ptalari@quicinc.com>
> +
> +allOf:
> +  - $ref: /schemas/serial/serial.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sa8255p-geni-uart
> +      - qcom,sa8255p-geni-debug-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: UART core irq
> +      - description: Wakeup irq (RX GPIO)
> +
> +  interrupt-names:
> +    items:
> +      - const: uart
> +      - const: wakeup
> +
> +  power-domains:
> +    minItems: 2
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: power
> +      - const: perf
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - power-domains
> +  - power-domain-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@990000 {
> +        compatible = "qcom,sa8255p-geni-uart";
> +        reg = <0x990000 0x4000>;
> +        interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
> +        power-domain-names = "power", "perf";
> +    };
> +...


-- 
---Trilok Soni

