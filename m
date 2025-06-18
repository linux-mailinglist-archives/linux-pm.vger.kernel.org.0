Return-Path: <linux-pm+bounces-28987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10372ADF205
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF1117F500
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD12EF285;
	Wed, 18 Jun 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jpJza5Pm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275912ECD3C;
	Wed, 18 Jun 2025 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262346; cv=none; b=S1hemCZFtPqmyD9cR5IJvUJ64BHJ7qIjs6hVI+nf/Rih5HwNlrbqCNGjutwXDNEX85fXs76t8CT+jVX3mTAY0oj56EQNBK1VzwkEIfpdzWpYDX7dg5huM1ThLXmQUQvUiV39e48WmUEP03KHkZfCNOD/LSsyRK+XQZJ+ptskNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262346; c=relaxed/simple;
	bh=CibxHS6GY+GqRLUvVhyMjHBa8Bs8bIOkIvOyKIjRJwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sCZOXAgRjuMgYYZsRyIMmxMkTYA0nxxJ3PMIrWtxCcV71p1V6ykaewZY82WOsenplaRKPO8wvAIn/m7gFQMhL8QGGPUM6rwDKIzY1/F6Ys7GUc8WA/kFh+6uLqtDt3rx8T9+5pZq2I3KUZmkVW7WlEMWveYzdCgLrXTkJMXXYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jpJza5Pm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9rClg011037;
	Wed, 18 Jun 2025 15:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0qRlTbO7X/d/0oR5r6fAgbOsxi1Ac3vlI97bqLLbBs=; b=jpJza5PmuA1xClgV
	2p8SE3Nv34Hcb1D2rUwVavRshr4EwalDhFkbVboY2Z7Yw18kbYMIG9OPB1Pr3EO4
	bk2nCK4jMcMwRt1pxSNeM/MQ7aeJAVoEW2RTM9x0jlHxEI45KFQlxvx2ZK0fHxNz
	8u0TU+kxUbAD/XufZowateupc9KG6Z/9vplKN17cnQpYgAfu2HivRmWyUbieQYdH
	FxdYlg2prHZr0n7X+AsIW4xag9CmqXaXTxb7BzHFqI7VOng8iHIE2ov6uC3tzplp
	NpWwop05m8xkljlqrF72wKO1D17wm4kh0g0ckXSV/B756zwUkkceSXDu8FfehUBK
	2rbjXw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791f7cqab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:58:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55IFwn1v032646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 15:58:49 GMT
Received: from [10.253.36.28] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Jun
 2025 08:58:43 -0700
Message-ID: <512e3355-a110-4e7c-ab43-04f714950971@quicinc.com>
Date: Wed, 18 Jun 2025 23:58:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] dt-bindings: clock: qcom: Add NSS clock controller
 for IPQ5424 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will
 Deacon" <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>
References: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
 <20250617-qcom_ipq5424_nsscc-v1-5-4dc2d6b3cdfc@quicinc.com>
 <b628b85b-75c4-4c85-b340-d26b1eb6d83e@kernel.org>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <b628b85b-75c4-4c85-b340-d26b1eb6d83e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEzNCBTYWx0ZWRfX8Za/vyljFqC5
 5CHAZ6LmzJLY3U51wMI20ufhmVFfuH7aGNyAcaRyPueVyBuJRSDm4AoNXO1LqrwePqwT6ddtXqB
 sCO+MRO6fXdEqnmHR5yuzndlBW6AyMExETie21Tu9BCH8t2ckzmrRuzwzAyyRRdgW3MV06OoCFB
 3paU1ABuS4BDJpx7koqM7ci32DIBKWNbaIdg0j2CK5kqwLRohIOj66C6wlljc8bv+0RyjuZswZY
 jMqwnKAtC8U6rp8S1ZFlqbZeyU/ziLcwVQ/m17Ueq0QBJphOVzwVjMm8U5cG/KlH11AYBSU/xvz
 vhxw3RE9deSUKKwauE9Ec1gEfa6BRR/DrnTg2OusHiiJP/A8PTc29qyA3jH8j50kubkM+CHKgyL
 zIwqI701R0wtNKn+qjkQ1+SOVNAckuDtkf4PcXvWFI1QY1mYUYAJIRrjgtTeXSVPVC6yo1a9
X-Proofpoint-GUID: _-FqpXlC-gP6RwvTHHwf4ZHE5QsZZD6g
X-Proofpoint-ORIG-GUID: _-FqpXlC-gP6RwvTHHwf4ZHE5QsZZD6g
X-Authority-Analysis: v=2.4 cv=FrIF/3rq c=1 sm=1 tr=0 ts=6852e23a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=P-IC7800AAAA:8
 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=yXJ3Pirk8toTXRASsBEA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180134



On 6/17/2025 10:49 PM, Krzysztof Kozlowski wrote:
> On 17/06/2025 14:06, Luo Jie wrote:
>> NSS clock controller provides the clocks and resets to the
>> networking blocks such as PPE (Packet Process Engine) and
>> UNIPHY (PCS) on IPQ5424 devices.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 

OK.

>>
>> Add the compatible "qcom,ipq5424-nsscc" support based on the
>> current IPQ9574 NSS clock controller DT binding file.
>> ICC clocks are always provided by the NSS clock controller
>> of IPQ9574 and IPQ5424, so add interconnect-cells as required
>> DT property.
>>
>> Also add master/slave ids for IPQ5424 networking interfaces,
>> which is used by nss-ipq5424 driver for providing interconnect
>> services using icc-clk framework.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,ipq9574-nsscc.yaml         | 66 +++++++++++++++++++---
>>   include/dt-bindings/clock/qcom,ipq5424-nsscc.h     | 65 +++++++++++++++++++++
>>   include/dt-bindings/interconnect/qcom,ipq5424.h    | 13 +++++
>>   include/dt-bindings/reset/qcom,ipq5424-nsscc.h     | 46 +++++++++++++++
>>   4 files changed, 182 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> index 17252b6ea3be..5bc2fe049b26 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>> @@ -4,7 +4,7 @@
>>   $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
>> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
>>   
>>   maintainers:
>>     - Bjorn Andersson <andersson@kernel.org>
>> @@ -12,21 +12,25 @@ maintainers:
>>   
>>   description: |
>>     Qualcomm networking sub system clock control module provides the clocks,
>> -  resets on IPQ9574
>> +  resets on IPQ9574 and IPQ5424
>>   
>> -  See also::
>> +  See also:
>> +    include/dt-bindings/clock/qcom,ipq5424-nsscc.h
>>       include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>> +    include/dt-bindings/reset/qcom,ipq5424-nsscc.h
>>       include/dt-bindings/reset/qcom,ipq9574-nsscc.h
>>   
>>   properties:
>>     compatible:
>> -    const: qcom,ipq9574-nsscc
>> +    enum:
>> +      - qcom,ipq5424-nsscc
>> +      - qcom,ipq9574-nsscc
>>   
>>     clocks:
>>       items:
>>         - description: Board XO source
>> -      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
>> -      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
>> +      - description: CMN_PLL NSS 1200 MHz or 300 MHZ (Bias PLL cc) clock source
>> +      - description: CMN_PLL PPE 353 MHz  or 375 MHZ (Bias PLL ubi nc) clock source
> 
> This change means devices are different. Just ocme with your own schema.

The NSS clock controller hardware block on the IPQ5424 SoC is identical
in design to that of the IPQ9574 SoC. The main difference is in the
clock rates for its two parent clocks sourced from the CMN PLL block.

Given this, would it be acceptable to update the clock name and its
description to use a more generic clock name, such as "nss" and "ppe"
instead of the current "nss_1200" and "ppe_353"?

> 
> Best regards,
> Krzysztof


