Return-Path: <linux-pm+bounces-40081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01658CEB609
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 07:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F753007952
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8478E310785;
	Wed, 31 Dec 2025 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHT8QzIP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJLo3eCl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795121578D
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163335; cv=none; b=uUGlyBnS8bQBXYlprEwczZbekV+2gFCJzZMqirIR8sH5I6wVG2kYSCzor7o/Dwc903clk0uDk8OBxwi6mraKnqdFqjffWNbRyUGmP8dXw8PEq1pM4Y/aMjZ0980O9wPQM73vmgig/WzJij5VowwbAHKrmaYTBxlv+wvCOHEGXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163335; c=relaxed/simple;
	bh=Fciu5cToeAhIXk/TQN4sMQaWhR+7ySM4v/oru1l+XDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZWo0Xtg9e7kZuIeAngnEs8VFSqblhaOSb9EugRvxV1hMvZ09ZPKRy+V+z+jYpPyRMLKXnYQpl2+fqY3DsKRlV5F8cog1NvvzTD6FA8P6PXv+8Q6ZZLQDuyq4/1cTHE/NvIolswPOQHP9ApBATDr+D+gy5vMXOX+8JpxKj2ng3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHT8QzIP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJLo3eCl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BULPIrI2551611
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jUOWXlGfx496nUZUwjiT8mnWUlnUNQfXG/CIZWbqY1k=; b=jHT8QzIPp0bP4DvH
	jRNWx03A9gCmX0xUp2bfewDjzJsoQPKcHnzZvhtbFd6nFjlwtNGCOyFR0/3wechE
	+3FLbLFVWxZNC/Gf4//DZLUDRAyCOlCwd8rH0HFNpB/0XJyyK+nOXxJhzKVMArDI
	BYxPJklJFFNjf3xP6sidYofqtfvdOaFG77Vdsv8CY6qKC8Z86z+WlmkfqLLcm3uk
	XiPqn3WueRiCBWUrEaWww7o+ldAKnmbj8jutcjmE869Bl3SVGYo4cCXXuH+j7EEV
	ctU28R/dV1/PflWE+dTJCRCfqx06VB5U/UWuzpTg7X4IBk7+w/ZSfdZjcz5A0+F0
	mNHcXw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skkqnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 06:42:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f4822f77so287269285ad.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 22:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767163332; x=1767768132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUOWXlGfx496nUZUwjiT8mnWUlnUNQfXG/CIZWbqY1k=;
        b=UJLo3eClX0tYp2dAsgMvMUA5FJ3Xi3Yo6lKEfZHfpVT2UijEe/OJ4sWVMJyd+8Tv6H
         s1nfaAPrZvqX2VIyTZUCzS9nz2qRdX5TOn+AoRx4gT8qZWh5XugZ7DzCOIkH21cLG0dj
         n819IAuncm3vxOlycp5ZMTVF5wIGyb867AaVK4bvTiQk8zokRe9kskhv9oD/zDWu/O02
         M2vzoqNmw2RGAqSs441YhcklxV7GEwoWxOE3wEpFIu7zxRxjm3llnVOOJ6efDz3AmZCB
         dasinC+6BFZMpeb6XzEwROXJVGc07WRtmN/jLfxDqsXxpZGegOiGDDotQIuTqBViSsjr
         E/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767163332; x=1767768132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUOWXlGfx496nUZUwjiT8mnWUlnUNQfXG/CIZWbqY1k=;
        b=kZ9/sAw15WZTSUUqHEOLYaHRhcJFUnFNkefqyieJ7gHvK6iAhFBQJE/LT00XFvBWIg
         tiGmOpvbz2Gm0Hrz5s6ZP7wgQ3EAPQ7TzTF71U7LnarwyH9HoXjT8H7z+VjUdmAeYjgj
         sGJWUELwtVG8cTHndhFMh9gx5SPizRXC7TiSW8oYdZY+pe2buqNlVVXo/TlpwMmuSX3i
         71j7rRut7YzbQN6mPIAStVpN6ZOjAb30Or+MJ82kRZjjqBNsobRy1dqmSAPNieh3PE30
         DxjW4ZgKUnqbUxOaWxWQY/++bpsx5lI3EtpFZSPcWaH/CxLOdP7mzfjFB8mdKgyNXLEH
         PkIA==
X-Forwarded-Encrypted: i=1; AJvYcCVa8hPSXhppC7rrFXZIU7ZzddLLFEJX8kFPYr5KFTAJN4bf+OWrmos/M+3zoaJRoYW8+IRRtI92oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oAg11MLyCJcEL3oYLM+x4CM7UR4GDIvHMFD+1VdkCBCU6QQ5
	bmwaptNpZzHkE224ybnzjZidvqGSQY9GYsysld8+IyzWGwar7hivTwu0ZAweu66FJPWDgtL0eml
	mp3VQYZMd1y/DFFlKFfGL8s+g5ow7FYC5m5aL0eMKuYroqiSa6CT/Hf+d3u2glg==
X-Gm-Gg: AY/fxX4gG+hOSWz+hweMRVD5vhX8T8vup835LeNeHSrrA3eg4Wm3yQYEGnr332BlVeR
	ybZtnDMI2EzqDmoIzcNQJVYqv71blWRJ+ySIZblXwWxKQoZn0oyfSX8NKwYI2kzhTPkEV4V7uI3
	FX4Miau0hLUuRDzdkDBecwNZu+qHlUhyOJZSoNJzDT+HIX06kT99RrugsweE5Ozsl5XszTaUo4C
	mOmAl02cODSAXqJ3zI7WBDxnn/CWK8CuZSVCNVZ5HFtR93SBxA0Oz5B5bOICQ1wEbxFtYn0ATvW
	ruFcltlAMvrMqD87FWPSutUJa4Onbo+00r9SsSRS81bQ7mnJ/8GMCcYL39k+t3onC1uI5KhKCuS
	Qim6ntjpx/Yv61lHceYd6ShyKFjfqnfQq/RXe9FJn3g==
X-Received: by 2002:a17:903:2c04:b0:29f:1bf:642a with SMTP id d9443c01a7336-2a2f220cb99mr368054835ad.12.1767163331752;
        Tue, 30 Dec 2025 22:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT7HRR37iJWhDT6viw+JV6tiAVVUvKFTX6dzMDFLsFQX5QdlYMk0VqdFo6QuKenYEGoujh5Q==
X-Received: by 2002:a17:903:2c04:b0:29f:1bf:642a with SMTP id d9443c01a7336-2a2f220cb99mr368054755ad.12.1767163331291;
        Tue, 30 Dec 2025 22:42:11 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c627f3fsm30428681a12.31.2025.12.30.22.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 22:42:10 -0800 (PST)
Message-ID: <74b33eb5-a75b-479e-92b3-cb6e094e5610@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 12:12:04 +0530
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
 <3fc177ca-0260-471d-b7a4-bd479f5e5855@oss.qualcomm.com>
 <60653b06-38c4-4276-a6e5-4a5900ba19d4@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <60653b06-38c4-4276-a6e5-4a5900ba19d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDA1NiBTYWx0ZWRfX7m4P+R8KF3j8
 PwNQCOVKfNmfWGIJFPSm6onBAcoilLcuBB3n86CnaLyB/38Uszlf39y0/1hPd9/EPPHCmSORowu
 ZZkWx7gG94XmFHmGv9uomgFg33eqqwQ81jydN0edp/uLlawAnNWHYirwYJg2raAoD/7ZWLGiAAx
 evHMliUt6u5y5mFiFCFOZnH6M3Km54E1tT+b9j3cRatFCvpl/kGRjbM4CCvNjqdnPnxiHQasOkE
 HS3RDj0QWdyJTDlTvdP3xRQjFT6DR5k4D3FMSH9uh5UCQMD7t0Eoycbyfy9bdOb+NMl89y2mdhV
 tX3iEBV0/GqDSliglySeotR66KucSqE2or5leCF6nPhw0aOCR2W0E0LrKgEPUEq8Rwiy3GfwN3f
 uRJ8OusyOCmfhqDsfAFv4hd3AQKNmZoC9H1/2oG7a4qGLEOc8KA40KMaaewY61iHFmn9OcbwCi3
 F5i/t6tdKanXFrVCS9A==
X-Proofpoint-ORIG-GUID: 0rM1EMARJfzS9UYa69hdOKJyO8t6H-JV
X-Proofpoint-GUID: 0rM1EMARJfzS9UYa69hdOKJyO8t6H-JV
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=6954c5c4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=2qAtJ3vxrRqM__EgsU4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310056


On 12/24/2025 3:54 PM, Krzysztof Kozlowski wrote:
> On 24/12/2025 11:08, Gaurav Kohli wrote:
>> On 12/24/2025 2:27 PM, Krzysztof Kozlowski wrote:
>>> On 23/12/2025 13:32, Gaurav Kohli wrote:
>>>> The cooling subnode of a remoteproc represents a client of the Thermal
>>>> Mitigation Device QMI service running on it. Each subnode of the cooling
>>>> node represents a single control exposed by the service.
>>>>
>>>> Add maintainer name also and update this binding for cdsp substem.
>>>>
>>>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>> ---
>>>>    .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>>    .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
>>>>    2 files changed, 105 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>> index 63a82e7a8bf8..bbc82253f76b 100644
>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>> @@ -77,6 +77,12 @@ properties:
>>>>          and devices related to the ADSP.
>>>>        unevaluatedProperties: false
>>>>    
>>>> +  cooling:
>>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>>> +    description:
>>>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>>>> +    unevaluatedProperties: false
>>>> +
>>>>    required:
>>>>      - clocks
>>>>      - clock-names
>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>> new file mode 100644
>>>> index 000000000000..90b46712d241
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>> @@ -0,0 +1,99 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +# Copyright 2023 (c), Linaro Limited
>>>> +
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices.
>>>> +
>>>> +maintainers:
>>>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> +
>>>> +description:
>>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>>>> +  across multiple remote subsystems. These devices operate based on junction temperature
>>>> +  sensors (TSENS) associated with thermal zones for each subsystem.
>>>> +
>>>> +  Each subnode corresponds to a control interface for a single instance of the TMD
>>>> +  service running on a remote subsystem.
>>>> +
>>>> +definitions:
>>> defs, look at other code
>>>
>>>
>>>> +  tmd:
>>>> +    type: object
>>>> +    description: |
>>>> +      A single Thermal Mitigation Device exposed by a remote subsystem.
>>> Missing proper formatting. Please do not send us code written by LLM.
>>
>> This patch is based on older series
>>
>> https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/, did some manual changes to remove unusable code.
> How? This is v1, not v2. How did you address other comments? Where did
> you provide proper changelog? Why this is not correctly versioned/
>
>> let me fix the formatting. This is not generated code.
> I do not believe, because this:
>
>
>>>> +      phandle: true


As i have mentioned in earlier reply, we are including below series:

https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/,) 
as this is client for remote proc cooling.
I was seeing this error while using older yam files.

('cdsp_sw' was unexpected)

from schema qcom,qmi-cooling.yaml

So to avoid that, i have added phandle to avoid this error. will fix 
this in proper way
by including another yaml file which will define the cdsp_sw,

Below is the dt node:
cooling {
+                compatible = "qcom,qmi-cooling-cdsp";
+                    cdsp_sw: cdsp_sw {
+                        label = "cdsp_sw";
+                        #cooling-cells = <2>;
+                    };
+            };


> Does not exist. You cannot come with something like that, there is no
> such code.
>
> Only LLM when parsing DTB could invent something like this. Otherwise
> explain me please the process leading to coming to such change.
>
> Best regards,
> Krzysztof

