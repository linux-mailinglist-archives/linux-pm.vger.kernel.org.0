Return-Path: <linux-pm+bounces-40085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5CCEB7C7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 08:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FA33004F55
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729330F925;
	Wed, 31 Dec 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBvZ1JYQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FIeGZ7Tp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88B280331
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167735; cv=none; b=R6FbualzBSPXHE8nveI1Nms59ajrZESxFeYFx1fzuquzqN8o8bO+gg9SKiR303x4PA3+Gaf5o0JrKbA5Ylim5r2M04xcv1/OB7jO5LZgQP2GdtJTJM1M/tQj4DTRS7yzwrj/dm+JWalNnVrjrq2B4sE0WM3d9o37chH7Yfqei+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167735; c=relaxed/simple;
	bh=Ci2lgViwE6iaeo2XUl4/asrVQ2GlNtpDKDBflxf9Y50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAlHaV40cDT/Ilchi5CV4PGyKptANJU5xyHsGCuWVsrMsUYSdOqWCsZdKjh/XOeDsPTk00kgmVghvWZi6lZlbMHpfFk6JtKM5bY0fatu58yEysw4dMeLwBD0gP2A9bEtURjqVcyR6ziFKBn/NOD4cFS5Nf0bG6GUtqQqI9lKYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBvZ1JYQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FIeGZ7Tp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV78RH62733191
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AYhrJHAScIxSw7RMMat/8wMUY18Hw+IB5SuvLlAJjFc=; b=SBvZ1JYQ/+TJ/gd1
	dNb7pfJkznVcJwfLnfnk2EwkFMKoZk9zzJxbfxtVoTSob2OVhB8wFtt6Xs0izghT
	0M29wSViqPKGYdQ59RiUyiVQo+laxD7ouxcjaIypc58R1vtdIFnXPEkHO0P6tY8r
	/VO3oCax0XjgUFSsdCmVPLtISDF98bj3ffFVRk7BYxy/4DOjGJj+N8tfsFdpY2dX
	pbs9xR4GLugKiPG24yIxI9vk2fA1XUc4VSpYDC4kH36f9FKrU+nX6zT97FYzKh8Z
	QlD4BlsFxK9z2Z+47PyWYkHZWHrdsjAS6k1je4CYO5XA9IIgNMdqeN89uAceauEO
	I1Gu0Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6ag2tn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 07:55:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee0995fa85so315696761cf.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767167732; x=1767772532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYhrJHAScIxSw7RMMat/8wMUY18Hw+IB5SuvLlAJjFc=;
        b=FIeGZ7TpKtrVOI5Np7b8hx0RKM4clopkv5olhlSw3ikID/SswGP88AAF8kImHpKamb
         vqjPOJzg5HO4XRSR/e4nbca8qSX5cHOWQFUgtBFY1l6h+bmLFQBkoh42EhjZBZhKS2c3
         7u5GJQPBaoQwPEZIdJBKkMp2KkQBnlMEZjJ1/8JlSNEJYgMJ0LDZz6vIPgQexsPjO5hy
         TTdDt3Pvyye7agYQV5uyu7BfbGJErlkDwk/RAPPWmm3q7QCS4SfWrOoBPvfD8fwXb0Ey
         Z7+QP0NwGxXXimBn13mb8MYhSl2etTtWcrZGbLGYxQUKxmo5zxtHI3eY4d8kYjtl2pKF
         EAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767167732; x=1767772532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYhrJHAScIxSw7RMMat/8wMUY18Hw+IB5SuvLlAJjFc=;
        b=YUPOvhZo4SthKI3ETTYBBj1Jrk5E7+wQCsgrE5RcPDG8RPTZBLTSJhrBYvo9ZERcsh
         QX2CrT8Erepqw09+5OODIml2yLWA6AkxoZZPiFLRYYW1MSpktYPc2ba82vXb/iLRXMkg
         1JFVcCQvYUjxNdFnLsXomC8hdSQkI7vOxZEXVoTatViaKC/YRNv7l4vNooVtXX3D3/i4
         vKy43ZZ+YtUR3fRINUIQ9L5SyWFu0/YzGTz+9S+Au/XkwxoP/WFF6UJmACcWn0ax9PmR
         lXT8zzQqlpSXKa+ejLtc8q5e+arMf8ON0B+FqsboGmfGZRWIabOz4T/Z8i4fIh2yA2SZ
         CZOA==
X-Forwarded-Encrypted: i=1; AJvYcCWpkMiiXAKVbBuiEAaDxiWWnnb0rPXZv17yo8a7xuVLmcz61y37FiEBFKHXpo4K7WO5lIz+4jFedQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69cLqxksQ/ppAzl8Mira/FCqZcEdtUbPEeq5iC1W5Ig7D4rMe
	q0rx2dw55KCUe00Kc5/tf2YBsz5RyFRkihfhP3OF2wuiSF4UYzceSnny83UgJUufZ+tQPi3501G
	2nLsDgCRVe3aeqgJXSJCoBTD0p/dVTE+etY7cSOFL8HiV66JIwCjQYKwv04QT2w==
X-Gm-Gg: AY/fxX4Io0Zc+YC3caugSi3RsA0pI/eMWhqvL4gvsHvye2i81zby9mRf6Xj0F639dxM
	wlLUJxvQ9FHtKp8sgxGwMhCX8JRGroPr/bBnQNelRh4aISz/lWWehf6PCl9hCyervXjf2O+L/JI
	cKWRw3ksSKQKKwh7K++fPanPvxQ640tHiAShO07Zu7wteGhMjjEnkldSoFGaIgEk/b7eMZkcOjP
	p/i2BjGhupUBCoaW0KOvDrCNG6cbLxWhzCDSVMEaRDItkwlgUGreFkiDj1xzVl/emljuI2akoN7
	ufIXBfbpQ783xoZGei49lyHqcPbhOnSdCfevJwGtlbccTOBe1I8OsLuiGi9o3FU6TynoIFwd1CD
	6+KpVvZkRa1WWSEwMAbb0Iu7b8hrOWRL1zDkuF6ZyYaV3sLzf/PJklKces9jA6YYV7eRS17kHWc
	6U6b3CK3GLuRLs
X-Received: by 2002:a05:622a:5792:b0:4f1:e9da:e876 with SMTP id d75a77b69052e-4f4abda20cdmr546160491cf.62.1767167732206;
        Tue, 30 Dec 2025 23:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0z6bL/Y1Q3cI0/9z8D+o6JuInTfb+26sqDPP2cu22WLKInz2eDNWMCCud7yvrAQyf1G40og==
X-Received: by 2002:a05:622a:5792:b0:4f1:e9da:e876 with SMTP id d75a77b69052e-4f4abda20cdmr546160291cf.62.1767167731661;
        Tue, 30 Dec 2025 23:55:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:a073:af00::4c9? (2001-14ba-a073-af00--4c9.rev.dnainternet.fi. [2001:14ba:a073:af00::4c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812267a438sm100328661fa.41.2025.12.30.23.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 23:55:30 -0800 (PST)
Message-ID: <4999105f-e105-4412-b6f8-bb1e2990eab7@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 09:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
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
 <9ab77a8e-a5e6-45bc-bc73-12c0d0700fc0@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <9ab77a8e-a5e6-45bc-bc73-12c0d0700fc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bYnIdHXxQU81usDe27-CjbAKq3kpS9qe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA2NyBTYWx0ZWRfXzYwEFEa+XWLB
 vQRCYUvsKbJ3ZQ3AP/Pq51zqbsIss89ofZuZI89Q7qWVZR7C9AxW4u6FJCIoh1ctyYNd1k2aG8V
 3vNKMP9IJ4plxjD3lVbI1F+kZvX7jAFiQSt3Cfydum+Lq7VoZKr8BxnJm5b984PjY20EiCRQunQ
 ACGYVJyk0pAclMeL/sv1V/FAugATDI+ZDXxvrs8Wx2/OietkhalPD/wKpS3mdFrvceYDMNrFv7S
 oYtw+CiC/Zw4Qrd7kqk8uGoXYkXwbjk8RS0Oe0xewa+EihD2SY/PR5wRMXAIC+xbPcTWbkqt6uY
 fFXhekKa1Q7ztak+xbx5QpbCT4pouEj/aGhzNz07aLvFgkpQtLWKPM4mLfQNDdinEiVxE0929++
 kJGBHUm7nSH8j50i2VL8Fo46PRhc1lUMu9IwnhhzBp8wxOuUro9NNOueYPH2J85VSBerxI6V6fx
 2hyleDRMAsVoicIPCeA==
X-Proofpoint-GUID: bYnIdHXxQU81usDe27-CjbAKq3kpS9qe
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6954d6f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=9DOCaZkiX73qrqxUqwoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310067

On 31/12/2025 09:52, Gaurav Kohli wrote:
> 
> On 12/31/2025 1:17 PM, Dmitry Baryshkov wrote:
>> On Wed, Dec 31, 2025 at 12:12:04PM +0530, Gaurav Kohli wrote:
>>> On 12/24/2025 3:54 PM, Krzysztof Kozlowski wrote:
>>>> On 24/12/2025 11:08, Gaurav Kohli wrote:
>>>>> On 12/24/2025 2:27 PM, Krzysztof Kozlowski wrote:
>>>>>> On 23/12/2025 13:32, Gaurav Kohli wrote:
>>>>>>> The cooling subnode of a remoteproc represents a client of the 
>>>>>>> Thermal
>>>>>>> Mitigation Device QMI service running on it. Each subnode of the 
>>>>>>> cooling
>>>>>>> node represents a single control exposed by the service.
>>>>>>>
>>>>>>> Add maintainer name also and update this binding for cdsp substem.
>>>>>>>
>>>>>>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>>> ---
>>>>>>>     .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>>>>>     .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 ++++++++++ 
>>>>>>> +++++++++
>>>>>>>     2 files changed, 105 insertions(+)
>>>>>>>     create mode 100644 Documentation/devicetree/bindings/thermal/ 
>>>>>>> qcom,qmi-cooling.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ 
>>>>>>> qcom,pas-common.yaml b/Documentation/devicetree/bindings/ 
>>>>>>> remoteproc/qcom,pas-common.yaml
>>>>>>> index 63a82e7a8bf8..bbc82253f76b 100644
>>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas- 
>>>>>>> common.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas- 
>>>>>>> common.yaml
>>>>>>> @@ -77,6 +77,12 @@ properties:
>>>>>>>           and devices related to the ADSP.
>>>>>>>         unevaluatedProperties: false
>>>>>>> +  cooling:
>>>>>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>>>>>> +    description:
>>>>>>> +      Cooling subnode which represents the cooling devices 
>>>>>>> exposed by the Modem.
>>>>>>> +    unevaluatedProperties: false
>>>>>>> +
>>>>>>>     required:
>>>>>>>       - clocks
>>>>>>>       - clock-names
>>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi- 
>>>>>>> cooling.yaml b/Documentation/devicetree/bindings/thermal/ 
>>>>>>> qcom,qmi-cooling.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..90b46712d241
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi- 
>>>>>>> cooling.yaml
>>>>>>> @@ -0,0 +1,99 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>> +# Copyright 2023 (c), Linaro Limited
>>>>>>> +
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>>>>>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>>> +
>>>>>>> +description:
>>>>>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate 
>>>>>>> thermal conditions
>>>>>>> +  across multiple remote subsystems. These devices operate based 
>>>>>>> on junction temperature
>>>>>>> +  sensors (TSENS) associated with thermal zones for each subsystem.
>>>>>>> +
>>>>>>> +  Each subnode corresponds to a control interface for a single 
>>>>>>> instance of the TMD
>>>>>>> +  service running on a remote subsystem.
>>>>>>> +
>>>>>>> +definitions:
>>>>>> defs, look at other code
>>>>>>
>>>>>>
>>>>>>> +  tmd:
>>>>>>> +    type: object
>>>>>>> +    description: |
>>>>>>> +      A single Thermal Mitigation Device exposed by a remote 
>>>>>>> subsystem.
>>>>>> Missing proper formatting. Please do not send us code written by LLM.
>>>>> This patch is based on older series
>>>>>
>>>>> https://lore.kernel.org/linux-devicetree/20230905-caleb- 
>>>>> qmi_cooling-v1-0-5aa39d4164a7@linaro.org/, did some manual changes 
>>>>> to remove unusable code.
>>>> How? This is v1, not v2. How did you address other comments? Where did
>>>> you provide proper changelog? Why this is not correctly versioned/
>>>>
>>>>> let me fix the formatting. This is not generated code.
>>>> I do not believe, because this:
>>>>
>>>>
>>>>>>> +      phandle: true
>>>
>>> As i have mentioned in earlier reply, we are including below series:
>>>
>>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling- 
>>> v1-0-5aa39d4164a7@linaro.org/,)
>>> as this is client for remote proc cooling.
>>> I was seeing this error while using older yam files.
>>>
>>> ('cdsp_sw' was unexpected)
>>>
>>> from schema qcom,qmi-cooling.yaml
>>>
>>> So to avoid that, i have added phandle to avoid this error. will fix 
>>> this in
>>> proper way
>>> by including another yaml file which will define the cdsp_sw,
>>>
>>> Below is the dt node:
>>> cooling {
>>> +                compatible = "qcom,qmi-cooling-cdsp";
>>> +                    cdsp_sw: cdsp_sw {
>> You can't have a node called cdsp_sw. Underscores are not allowed in
>> node names.
> 
> 
> Will change to cdsp-sw.

Why do you need a subnode at all? Can there be multiple cooling 
"devices" for a DSP? Also, if you insist on having a subnode, could you 
please come up with a _generic_ enough name that would describe the 
node? cdsp-sw definitely isn't generic.

> 
> thanks
> 
> Gaurav
> 
> 
>>> +                        label = "cdsp_sw";
>>> +                        #cooling-cells = <2>;
>>> +                    };
>>> +            };
>>>
>>>
>>>> Does not exist. You cannot come with something like that, there is no
>>>> such code.
>>>>
>>>> Only LLM when parsing DTB could invent something like this. Otherwise
>>>> explain me please the process leading to coming to such change.
>>>>
>>>> Best regards,
>>>> Krzysztof


-- 
With best wishes
Dmitry

