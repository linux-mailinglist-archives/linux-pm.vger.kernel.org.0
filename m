Return-Path: <linux-pm+bounces-39910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597EFCDBEF7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53AC230169B3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFB334695;
	Wed, 24 Dec 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jE5p+oUT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COnOp8cL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8932FA25
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766570929; cv=none; b=lbTWGLOuCemWHd2C5WS3ASmL0D99Y9Q/GLf0KF7gr9rabHFiqA4w2VDPsGnNJ4JB/puE9ixnT4LQgzxHIlZ9XIcYWYzLjtU+/XwicWMPLvsCn4VlwqkWwKxyu30VI+6u4yKR7D80dgG9VqqUEH01zM5MCxmWBqMRMx0fFVw7hS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766570929; c=relaxed/simple;
	bh=93MsyT+IYVMTmknn6KGbQdvJhvtLNUcz1iZs84K74wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3yYlMy0rCmEhyWxwBUU7BB0p+mEX3RAdBjmdp7+zT3n9drXpIJ8c7uzg2qSd1PZnhZZtBk81XSDxYr4bZO+00yhKBZobEz4c3q5YKApqSy4EnW0lRIoCHEnRBlA6kQOYYatW+7MwMblOT6Qzng8ioaHYTs1vpPmEJMFG5yXcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jE5p+oUT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=COnOp8cL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO26W6I461408
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 10:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDpMnYGKrQ0Yj1wED0jcceHbFC0oOSXev/movDISLDI=; b=jE5p+oUT51IPMqTg
	FQH9kxzVdycsF49F6VRmTLRQojqDgfqYSRG+ykTmL6hjV2lmTkxv72BLXYAcNA9q
	M84ePDgIyaTp4QOpOaedhqhyVLWHzDitadrS/cM1SwId3YeA5nL50LNo6Djo3OX4
	nAD5eD3/VVllA8dawtUeHNk/25Jbdx94vgTnQNUAT9sYUuu93OiMC/pO2YSc94OP
	rP/qTQtHs4ptguu8OPKlANJXfU4RqtJCqZn+XqCPbGUzutmQrkOYgHrcMIVwVcea
	GD9AMSNfmY67Y4x2Je4x2vqZDte/ljGVQJU8Y+sa3o9ym0IwyuTcuk5FU47D6xuP
	3iJyZA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8ftvgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 10:08:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so6993655b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766570926; x=1767175726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDpMnYGKrQ0Yj1wED0jcceHbFC0oOSXev/movDISLDI=;
        b=COnOp8cL8dB3pUB0QydmzR8CBSHViH15YWs9kZDAD5fs7mDvVlPOISUHx17ajlQWea
         /YX3NQvTNZ7ZsB5JhZYHLR2SvbCl2JRfCnTtgjNDzeH8qriu5e3uQCu3cvE/VdtFMc/9
         KM3YUTI1ngpugO5DPTu70Zxq2mCilzElAQYUfwgtfcfoNyCKW9lMcxYLnR3J4YYun7E/
         L+snr6s2iz4qfOoayLkaRPY+e/kjYW8VucrglUPHXUjuIm4MbzL2rdfNBoKuqD33K/FY
         iGxeLGquKBCmym5KcxcDKDI08jYE97VWqun/lUVXnQYht45FW4W/bGRh9TG1lXFTDcWZ
         Bdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766570926; x=1767175726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDpMnYGKrQ0Yj1wED0jcceHbFC0oOSXev/movDISLDI=;
        b=X7jPLpFb11WSjFgFdVM6cw3vQ8BIrb4eJ5lw6/y2PO3NDH/tRwZV0xob0W+gc97ipX
         8vGs+VboNA8CohSiXVvz035YQL3hcds8PW5wvyhVNG+pRz0GCrjRDqBL5VV2eZlD3xau
         yxGdHjLB9e8SZc4VCdFD46/AzAfNGgmS/GCXFoIEgL5LUbWRrwk98xnCrHd2N72fTOgb
         PASamF1OxGohKFhFfNt0kwebS/Ahe4T4w0HEngb5PbKRdgqvzOKuVODBczN+dYoBeGYu
         /w1Gb3TE+De2CuWc4qwg39t800BB98izoLZsVbzXsax1RkT9myhHW8CD8GMewQxveBCD
         HV6w==
X-Forwarded-Encrypted: i=1; AJvYcCX6JAiV3m3NI+YagNDxZOUDvopOT1y9wUXFhe0VLD1Dx8tzuaRny+T11dXRJlBx3NKCx1ONzGrWow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvPiR1nO+5zwtBCPiufh1a8COapOiizX+AqxnTQxZRanvyjdX
	XXv3QipZbG4le3mrAnpRlEE4q+ZHqlT71+u7nRfY+P+ROuLWrK1G7MXZQlgfGtgw8Mg0YCIBCDj
	8u3COfYgeDqmannb1GtzdUIVhVcePq93TBAwHgC3wZHocA87pOTqC1pwKfkca+g==
X-Gm-Gg: AY/fxX6pKokHkJIbAAwCV6WZALDUhpsCEXbgv+wCCdhHub/b3Vq4hHS6O2r5imSCUPF
	q+X1CkcO3X2qMU32jlyv6Z6MEfKU00hzf4eqezu8cc7cPJIHaAMZ7g7Ffvh6G/FUjW6cZwIBcDB
	ao+Wrppv9LL5seGvsTMkUtdbk1ht59loez0Ptg25Z9y7zd0ugS4rc+/TljoLe1IwwYVbeUAAOWx
	2hSfucFFT3+XcXFyBTuNcn7t8Lcu+6HMRnYV+CJArU2Swf1n2R7bP8+23TpnCMl51dm8vkduw6O
	qATlrQVlf41qf19k7P3dJqFsfFX+i3Q8slGOQt3DOS7wcb0TVmQfvlZs0fqlUBw5xXvWjUcJNdm
	7uI/savlqRdFum9+uCEo/oHZoOqDBKu6O6H/SnALF9w==
X-Received: by 2002:a05:6a00:3002:b0:7f7:497d:8118 with SMTP id d2e1a72fcca58-7ff64211caemr13493167b3a.7.1766570926074;
        Wed, 24 Dec 2025 02:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKnvZ0J3w/9xfYtkjlUkt6SiK57Js68KIyJzgQVlAbrZ+vjsuQratK12FIJSddtnDVO4843Q==
X-Received: by 2002:a05:6a00:3002:b0:7f7:497d:8118 with SMTP id d2e1a72fcca58-7ff64211caemr13493145b3a.7.1766570925564;
        Wed, 24 Dec 2025 02:08:45 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f300sm16401247b3a.54.2025.12.24.02.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:08:45 -0800 (PST)
Message-ID: <3fc177ca-0260-471d-b7a4-bd479f5e5855@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 15:38:38 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <f6bd1bda-6aab-4d4e-9981-f55cce03f70d@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <f6bd1bda-6aab-4d4e-9981-f55cce03f70d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OxLZ0H-VdVE060nZGYXmp8AldtKA_j46
X-Proofpoint-ORIG-GUID: OxLZ0H-VdVE060nZGYXmp8AldtKA_j46
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694bbbae cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=qdUy6Y8sbFzTvRIqqwMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4NiBTYWx0ZWRfXyEbj9eakv6kg
 Xj702Rn4wtE4xAKk7wJOXBguNMC2kktx7ocLy3zXjJzdBPt6ORDAXxtgvBQqKb54BbOf3H/Bkbz
 5W4TuRy03fbVtPjgd5DOBw4N8CGXyyFSh2xXMwSWRSJoLMZfhjz5a4wmLXBjVbBJcDXGVgIO+jK
 ARNNHkLuHq6r6OuyhPsID9KeYr88F0zRWD14sI4y4mTim2L5kyPVF/r4pC81YPYba03fRUF97nN
 i9SqNGOS2GCe0f2D1xAz76DdVlU1JOgEKvyLeKzBxxejjqBqwuPwFxUWjo3qNNgjQZXQ1Tkh4TH
 +/cLMPpYptz4gSSZhtsT6dKbEkGbfB4cQjChfWR57ak7pUV6QIlUsSIyBKL/X91Or3pv2yQKvBP
 aZA089JxfGDKO7eTTj5aczQQdsD4AAkOXXe0egmpUGOPXF9iu9raAP9zpi5AwnAAjDv7w+BlJxD
 KHh6a5rC2k0izE1obvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240086


On 12/24/2025 2:27 PM, Krzysztof Kozlowski wrote:
> On 23/12/2025 13:32, Gaurav Kohli wrote:
>> The cooling subnode of a remoteproc represents a client of the Thermal
>> Mitigation Device QMI service running on it. Each subnode of the cooling
>> node represents a single control exposed by the service.
>>
>> Add maintainer name also and update this binding for cdsp substem.
>>
>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>   .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>>   2 files changed, 105 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> index 63a82e7a8bf8..bbc82253f76b 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>> @@ -77,6 +77,12 @@ properties:
>>         and devices related to the ADSP.
>>       unevaluatedProperties: false
>>   
>> +  cooling:
>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>> +    description:
>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>> +    unevaluatedProperties: false
>> +
>>   required:
>>     - clocks
>>     - clock-names
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>> new file mode 100644
>> index 000000000000..90b46712d241
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>> @@ -0,0 +1,99 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2023 (c), Linaro Limited
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
>> +
>> +maintainers:
>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> +
>> +description:
>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>> +  across multiple remote subsystems. These devices operate based on junction temperature
>> +  sensors (TSENS) associated with thermal zones for each subsystem.
>> +
>> +  Each subnode corresponds to a control interface for a single instance of the TMD
>> +  service running on a remote subsystem.
>> +
>> +definitions:
> defs, look at other code
>
>
>> +  tmd:
>> +    type: object
>> +    description: |
>> +      A single Thermal Mitigation Device exposed by a remote subsystem.
> Missing proper formatting. Please do not send us code written by LLM.


This patch is based on older series

https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/, did some manual changes to remove unusable code.
let me fix the formatting. This is not generated code.


>
>> +    properties:
>> +      label:
>> +        maxItems: 1
>> +      "#cooling-cells":
>> +        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
>> +      phandle: true
> NAK, LLM generated junk. It is not acceptable to send such code.
>
>
> Best regards,
> Krzysztof

