Return-Path: <linux-pm+bounces-40084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8644CEB7A9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 08:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DBCF301D632
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F33126C6;
	Wed, 31 Dec 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeA6aFLK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hYGj/eiy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64F3A1E82
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167572; cv=none; b=iZI43fRM6/kwM6s7HdX5odaVuneEYga+OAgj8GJ7XloxTY78/epO5P+SV1OdR8lpjRBIcTMcxijloVB/Uvkei2g76/yJ54JDlON39prsnYLIsbOoB5ONtVCMa+w56uY6VJT2aGbOJrdCQOWlDeAu+w7wcIYFsxh/9VO5CR3pEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167572; c=relaxed/simple;
	bh=NKsGp0AmDWuGXpcnGlFd3miFG9eDtO7IMWcUFbegmr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egWJuiVkKGKG1MbudKNe1kdhH6PNfcHbjvDJWWV+wvzBR3d8yZCmxNKyytsZLfvRUhFnDYqmEwZIwYnNOygIfYvftgzkOZo4SGUs6ee8LSazBT+PEa5Fj1NkQ102UQa2ft8XufUg6i/vfABGbJtenojGy1X9ezEsbJVLSaqjJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeA6aFLK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hYGj/eiy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMUhqI1685822
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KyXIjIBC3vcDSkoYHVSATBvwhoF+AaKYl83HspRl0wo=; b=YeA6aFLKUNz7r4NG
	m6G8CDqCqOX4gyJewWmXHHiqFpXgAHYumzdqx1WZT6ndZT31qEwM0w/p4GPNg9O5
	C0v4Kb5utzUDyv8Ej0DIk1LclZNB7SNWWaKvCQfmePaaDJBh9kcAx/OakJr7v8GK
	BbdIhrIJgA388svVWnQF2vV806QZ/gTb/v1Km4x74HqUdPn2Zt2Xva6SVYYPnX91
	DWGP+kk9yQnCvYG8vvtqQC+qvHJKvgUiIEo3LKOldB0lHDm8kGialX1DObHo8fic
	E3bp3O4JxcQ0kgA4Ir5q+o0pv9O2lhUeXa61Dz1kaOh05Buw3q54epi062kQUHSV
	yS5TWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdkv22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:52:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c904a1168so23375392a91.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767167568; x=1767772368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyXIjIBC3vcDSkoYHVSATBvwhoF+AaKYl83HspRl0wo=;
        b=hYGj/eiyU43kApTaqiBJlGpxZLV6RWyHQQuKbkUNOWOWCf1rIqTDiZcwabNQ6Fj+ty
         yzbnt7oi0GlXZcXO6EO4fwlGsJV3p3wNtU/L26PUSM001tnyboCiXULPl7krwU9Grveu
         y8PTxmPqFx6jVhtU3JXofEE9ZXVRxdnawwoSlPgrbLe3TCNVE6Ue75nx02eC9zvDKnN/
         /m4Yqb0FTni0WIoNPDbn5mEvxJ+MP+sTZWwPh6d8qVNKHvhTiQT4Cn6FOmuvNVJ4lfxb
         TZvaqjiSurU/pLrn8IcTv60Dnb8AtvkOC00YODCJuPAi9F3TUP+hl+I+uGtNDnmU664B
         /67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767167568; x=1767772368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyXIjIBC3vcDSkoYHVSATBvwhoF+AaKYl83HspRl0wo=;
        b=wMX7A5RY7P6Ef9cRc+5iwozLXuxPEAesUKp1sgDqZZ3xdVzfxaV5cQjZVV7zMxNiQr
         3kojqbmOKwsKOWlbHMmON3U4UYVv+1VT74IDz/q1xIlBnklFjTEWGUeZdRPJdpnbSs/l
         DnqqLtZAJl/RfyZZF4q9R3U8ug/IcQlyo+/o6qTz2oPU4ctsotEd73fIRlHOs2hbn76i
         2GEZ55sF0VVinFB0atePsLudfzgj/HBLWFG5K8B/qYGmeFe/Q2h1zI70HpC9TpNFGF1L
         dWlnFTVHHI7JgQI/o+qfc+61mxLdi3saXNXRU0E+wbxkMYCQHFVxcLK1WrDJWfvPBep6
         4C4g==
X-Forwarded-Encrypted: i=1; AJvYcCXHU2PGvpuSgx8DuyeNKw6+hxArK4PcmsPY5D5n9xzLw6GJ7GOHcDK6RR6hWWRtwPQcEEsjb/lEkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTeqqjXsO9AOKYA5VhO8hyBVQoKqfAlAs98CxZs6frg45n51m
	migEQVXqGOeanlvc/NUsg/R7JmQ3GKDBoyuGNJ0OuXQjiIxoEHHvs2PqRVQUkLpG8yFNzGT+6YM
	bb+6tHAqeI4YPzPHwleJqUyEcN7isXHD5KRLhNUKcVyZn/6FhIy/iaIF1dPi3+w==
X-Gm-Gg: AY/fxX64NMJQ5jc4vkDyP1dO9bbGcijePdcQ51XYg2cWy0HXlmVOIuSRuk5qmZl11cy
	uw3xNl5iv6xWe+rOiAmP2Iuz+ncQSnYhGN7khqzZtD97HSOvD5u8gXLboR3NYjmt5HnIgzfNCcy
	R68Ah8Q97J5eIPzHWwmTlWHHd04z6Vl2bJ+Kj4C6IxkS+58cBoav1hxHXo0IzMzZtP6RUOdDZq0
	xoUjRYawoUW7onWJRhS9B9JRfDBbj1TCIm6mQFAAXxm3q4qPx3zuSJAapAnLdLB89UhOcSH1cdm
	M2P8mjSqfVU6rRtaOS98mwWkt3YrFid6wD4PPjOxpsgWcNUvz3SXvUB1VaLgmq8XFbRLC7hXtJi
	G/J5tSgVeBpJHG+E7w7r4OUwLbNdA8y8rkUaAoth2kw==
X-Received: by 2002:a17:90b:134f:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-34e921f7bf0mr25730144a91.32.1767167567579;
        Tue, 30 Dec 2025 23:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeaZOZEeOVTiuQWpMfqrzeGgTnGb5ha7Il4l7bVR7L5mS3TqoZ8+7Xo7nEMfLTl1ktM3yFJw==
X-Received: by 2002:a17:90b:134f:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-34e921f7bf0mr25730129a91.32.1767167567019;
        Tue, 30 Dec 2025 23:52:47 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fdesm29853432a12.8.2025.12.30.23.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 23:52:46 -0800 (PST)
Message-ID: <9ab77a8e-a5e6-45bc-bc73-12c0d0700fc0@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:22:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <f6bd1bda-6aab-4d4e-9981-f55cce03f70d@kernel.org>
 <3fc177ca-0260-471d-b7a4-bd479f5e5855@oss.qualcomm.com>
 <60653b06-38c4-4276-a6e5-4a5900ba19d4@kernel.org>
 <74b33eb5-a75b-479e-92b3-cb6e094e5610@oss.qualcomm.com>
 <qbbn4dpp52nojvi3fge5kotnxcetuhsqhtvm6rl7rjbo46e2ly@cp24xlhdk54h>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <qbbn4dpp52nojvi3fge5kotnxcetuhsqhtvm6rl7rjbo46e2ly@cp24xlhdk54h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=6954d650 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=OIh3AFMXoxoDVeGUFMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA2NyBTYWx0ZWRfX7FM1AG+le0Fz
 DZis3sj4jzhMPXQF2JqRi2GU9afQYn/SegzwM78ty4ORLzVwTh98HKgRqeUlCEMltfO+8XHX9I5
 49BdnnrjAM4dDYLx4SmpTLkQ+cJOiRfak50VM3ysqdEcTz1ybfUbJh3vbuIU+4Ex3f0D22aKM5l
 zDuHlMpc1ILjNW/cA86H/NRkUC+kzcc/OfS0rHCKJhmCtX4KAMEr5wn7jOeVsdKE+44EwxOAWNx
 rkWQiSrscQ20tBGt9xwZvNQyu5vAHKY1Z03OraI0cak5ewtkooW1PoldHUeL0IrTt/CymH3BVfi
 92w7OhrNpfG/w/rWPY4KVmdseyQY8rt01ACpcdmdNbszwbkIAOEDFpLpyDrS3pujI+WKy6Dg8Ll
 cbINqugRUr3g2l2stcOigo6kFRttZn8/U1PCJEhAtNVizD72pQ1cyl7r6HbiujLQlEp2Zm7Sbw4
 zWRsM9gorpD/65nPvnw==
X-Proofpoint-GUID: 9fxKPe_1sgWs7oFGKWtG8nyMprEts22S
X-Proofpoint-ORIG-GUID: 9fxKPe_1sgWs7oFGKWtG8nyMprEts22S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310067


On 12/31/2025 1:17 PM, Dmitry Baryshkov wrote:
> On Wed, Dec 31, 2025 at 12:12:04PM +0530, Gaurav Kohli wrote:
>> On 12/24/2025 3:54 PM, Krzysztof Kozlowski wrote:
>>> On 24/12/2025 11:08, Gaurav Kohli wrote:
>>>> On 12/24/2025 2:27 PM, Krzysztof Kozlowski wrote:
>>>>> On 23/12/2025 13:32, Gaurav Kohli wrote:
>>>>>> The cooling subnode of a remoteproc represents a client of the Thermal
>>>>>> Mitigation Device QMI service running on it. Each subnode of the cooling
>>>>>> node represents a single control exposed by the service.
>>>>>>
>>>>>> Add maintainer name also and update this binding for cdsp substem.
>>>>>>
>>>>>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>> ---
>>>>>>     .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>>>>     .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>>>>>>     2 files changed, 105 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>>> index 63a82e7a8bf8..bbc82253f76b 100644
>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>>> @@ -77,6 +77,12 @@ properties:
>>>>>>           and devices related to the ADSP.
>>>>>>         unevaluatedProperties: false
>>>>>> +  cooling:
>>>>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>>>>> +    description:
>>>>>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>>>>>> +    unevaluatedProperties: false
>>>>>> +
>>>>>>     required:
>>>>>>       - clocks
>>>>>>       - clock-names
>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..90b46712d241
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>> @@ -0,0 +1,99 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +# Copyright 2023 (c), Linaro Limited
>>>>>> +
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>>>>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>> +
>>>>>> +description:
>>>>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>>>>>> +  across multiple remote subsystems. These devices operate based on junction temperature
>>>>>> +  sensors (TSENS) associated with thermal zones for each subsystem.
>>>>>> +
>>>>>> +  Each subnode corresponds to a control interface for a single instance of the TMD
>>>>>> +  service running on a remote subsystem.
>>>>>> +
>>>>>> +definitions:
>>>>> defs, look at other code
>>>>>
>>>>>
>>>>>> +  tmd:
>>>>>> +    type: object
>>>>>> +    description: |
>>>>>> +      A single Thermal Mitigation Device exposed by a remote subsystem.
>>>>> Missing proper formatting. Please do not send us code written by LLM.
>>>> This patch is based on older series
>>>>
>>>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/, did some manual changes to remove unusable code.
>>> How? This is v1, not v2. How did you address other comments? Where did
>>> you provide proper changelog? Why this is not correctly versioned/
>>>
>>>> let me fix the formatting. This is not generated code.
>>> I do not believe, because this:
>>>
>>>
>>>>>> +      phandle: true
>>
>> As i have mentioned in earlier reply, we are including below series:
>>
>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/,)
>> as this is client for remote proc cooling.
>> I was seeing this error while using older yam files.
>>
>> ('cdsp_sw' was unexpected)
>>
>> from schema qcom,qmi-cooling.yaml
>>
>> So to avoid that, i have added phandle to avoid this error. will fix this in
>> proper way
>> by including another yaml file which will define the cdsp_sw,
>>
>> Below is the dt node:
>> cooling {
>> +                compatible = "qcom,qmi-cooling-cdsp";
>> +                    cdsp_sw: cdsp_sw {
> You can't have a node called cdsp_sw. Underscores are not allowed in
> node names.


Will change to cdsp-sw.

thanks

Gaurav


>> +                        label = "cdsp_sw";
>> +                        #cooling-cells = <2>;
>> +                    };
>> +            };
>>
>>
>>> Does not exist. You cannot come with something like that, there is no
>>> such code.
>>>
>>> Only LLM when parsing DTB could invent something like this. Otherwise
>>> explain me please the process leading to coming to such change.
>>>
>>> Best regards,
>>> Krzysztof

