Return-Path: <linux-pm+bounces-39904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49812CDBAAB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FCEA301D0C1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916A32D42F;
	Wed, 24 Dec 2025 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FIP3jSsC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jSXUp63L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853203128A3
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564657; cv=none; b=nYdZ21T/ij348CsEpD0XGQ5OePMqdF+q3NfGqzQR6f0MaYqflTUKUqNIPb9SOt4PnDWRV4bXvH8NReQaZrB9L5FGiAeuB6z7shmwhjXut7K6/Qg6mggS/b9I0w2swH+XHz+9w4Ob8v8IftS6tKKGvs+h2NiGycW2Hj5znoOaBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564657; c=relaxed/simple;
	bh=2afYR+QPHTFaaxhOoQKgqdK4lXJQ8ziaCl7IQD08vVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPysJe1r13pnT4Qw6ksBGLnFVbL/d2FG/r9CBYdoStZrefYkyEcni2PVhzLdnvboFZIFzBXWAbhl9ID8OjjvwoKbjdSrhCvT3GHcLs6BiD1uxnIKToCflzj3iEUkPTICe7iWfUJvVxCIq3cxaPNQF6pp+QVLj7+GLMKdGxSTw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FIP3jSsC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jSXUp63L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO17S621597720
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 08:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amWwOEekimBMh3/UGtUq5nDhhjd4Nl657eBMQHZc8lA=; b=FIP3jSsCC5K2aUcz
	qQq9mYn0YnSpRFIufdSUDbG0vrRz2/QbpLYNzMSJSEG1JvQwke5qJ9gnYwGeoF6p
	zl60iIeXpvTVkwmG2MW9sQB5XjJ7auPyUwG/PUoIIzoWtjruYKtmOxPWx64k6ahf
	hdD4ZZ3YcyVtXf/0kU4hXD/0P6pmCbHDfFNZiScbb1GGeYfSv1D4V6YIV5BKwbza
	VBwbw58aPsx+M5qsyrbRcJP3SQoxTRcqaGY56LSXOeLZBjJPXOO7mO78rnmvNrTg
	D0yG5eZU/TcuQ2qinYDeBPV8Xh6G9L+DhP2l5ExIAJAVo3EdZ8AKY9weLlYAMD7z
	h4t8bQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8683h08f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 08:24:14 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7f66686710fso11674947b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766564654; x=1767169454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amWwOEekimBMh3/UGtUq5nDhhjd4Nl657eBMQHZc8lA=;
        b=jSXUp63LUFEUOZF07nggeW72hTIslRFaNRcSUVebqqozXRpkGzrkPFNhKFre6t5u6b
         g2tCsEW9gG8kSihiplR+Ueux+neSxffz7e5UUJxm1L8czCpxYFvIYnNQANlv+dhk4yXy
         u1M2Z9ly7Wo/56UXxNEp+yNds0aZcl317fYUPZmyKtwf1SHMoBkS70ySvh8zoeMzCXyk
         2Uc1gKeUNmsLGSPLxpap92Euihno9DPnBllohhuL6WQuv0mWjIcgUC+ziO5Vl+/sPLXI
         CYEcVX8baR7bptyHBa/c2aysODZFcsV5vIwoMZ6dMtSjCOovocNUSz7VIVmIKBPXCyr8
         uQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766564654; x=1767169454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amWwOEekimBMh3/UGtUq5nDhhjd4Nl657eBMQHZc8lA=;
        b=fwFzojqI2deYhaWG0G5sQP9rdbYctXnFXvwULou4OEavu+tuXtX4zzU9cVSQHPVNb8
         fgkmyDgn/rPH5W7dcBflL80eCpTAYAON3yJMRSeJ5PAZfg70sFbLms93W4VMAlaxON9I
         GVprzctiSZdzT6MiQVPeSwI7opI03hoQyRTMehdKdY2Nj2WYjWEUwlNUxSvskngNrlan
         H7oUWsfkv5/Ak3NX4VNukEHo09ba2VRrODmNkEZob7aHHffdWOK7sGkVTxxjKevtYlfy
         D690DpQKoqkLc/c5FEdBesrYY312cWOXYic/NWMBUAs8uYJPyIglmOmTDDK8y8jdPOMR
         8AOA==
X-Forwarded-Encrypted: i=1; AJvYcCUX3nBIMKNuuzjbjTn9sJ9zz/8OIeV5xKRJbMBlwV9/QMg2qA94inKEsa2ZZSIp1F8tq/VHPBbi6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvP3drwxScThIFRRX42GCD8ylqvYPGILdr0OqS+nGww+4TJ5Pk
	c8AIwXtrA08g90ajr5dV5fmxYDkpgBXTE4Pg4F37iuXGcTgWP5RMY+u0ZGLKkePUfHqU04w14+q
	xC0hyw/j3atIsgFDSoiNB/O+JWd7XFJcbow+QlIVtoEyn6Il7Lddi2BGIPn9MnA==
X-Gm-Gg: AY/fxX7XPC/QHJTlTE4Ek3Ae19L1Pu40dOYGdRL0eAR7AmDIGFtu23zXmZbyX1ZjYYD
	R2e6p/xw3Q76nBQWGZQXEfIPqjysvrVPGt++eaeVZp9teSqO10KxjWW9Henb96nAs+8EAZyI4vH
	lMVCOtUg739vhdDjswbNQkkoTpv+Y3YZiZ9BxHmsyuOhE7lPdO9Y87komLfCHdJzJJB5mO2hQX3
	Aj9jEbfFknCNkbaA/LEKdUswUg5vT1nzA5ATaoiBh/kFyRnzXiQ6iiKTUfcAH9BEV44xmEL9kXQ
	0PP4y3gmyCtoYtTpMl7I1it4ulK7P7DEmLEtXULMyalfpkdNcf7v1FvKBo2sLyMYrAc9bpxTJKp
	lNjTDZvkO2QLL0EXA1/QmkrF/eIFugyfj5atd+UxK+g==
X-Received: by 2002:a05:6a20:1611:b0:35b:f559:171b with SMTP id adf61e73a8af0-376a81e2ec3mr15421689637.2.1766564654053;
        Wed, 24 Dec 2025 00:24:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqVbw4RVYEzoJEqtKIanM6SZbyN6obz97DqOEhmYo+cCNx2r94xkB9hkwvHBS64bB4jJT09g==
X-Received: by 2002:a05:6a20:1611:b0:35b:f559:171b with SMTP id adf61e73a8af0-376a81e2ec3mr15421657637.2.1766564653525;
        Wed, 24 Dec 2025 00:24:13 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d65653sm17921554a91.5.2025.12.24.00.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 00:24:12 -0800 (PST)
Message-ID: <7e946103-06cc-4e44-be00-fd0ab9a8f55c@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 13:54:04 +0530
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
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <fu7rhvpo7t2fjx4l7nvzd2cec7loyjeqyvwgochghyyax4nqof@6bat54r3qgov>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <fu7rhvpo7t2fjx4l7nvzd2cec7loyjeqyvwgochghyyax4nqof@6bat54r3qgov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7lS1mcADW8JCSY7p_KPYtoraPw-cxNLJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA3MSBTYWx0ZWRfX4Iqp9PE95dQ7
 NHMhOZrep2cOzXYAGBApMEHhkvkW5++ETcNM+LN9oTkqGRO1gffrjFBPuZmaawPPfERij+MEJy+
 XlQOkcOrQJMAgUxcQmTcsoson5JaxYxKjzv0D3lQNuNBcR9/F5PwiXzMuwNpjPn7t1L7CXCvBVN
 HrfeI3k/pnOpw/eLKMNAtdNXP7aRzezWHhnmW/UPl7SxjhN6rR/BWe/+o4HANMmFeAMCo1KnUyY
 snzBp9J52ljFnikGeYvTMPJNZhZXNZ00qr7eYV1K6qE9b5H3gh/ezIRK1/zWMUgjYgO1Adt9DZm
 6XBcZfKhL/NLdjR5APwSdQ0zBufC3CV3CFqq5gOXdf8UULdW0p0EAkw7FtTuYPzJPW9L2pvclsv
 kEp04aWjtaPb5acPNE1dpGWJSCsGQd17b2FfeuzuPQ7TBCAdLdev7QXro/Nt7lDfJXFEStPqMCw
 FP9GJ3/R++jhaCL+Lbg==
X-Authority-Analysis: v=2.4 cv=HqV72kTS c=1 sm=1 tr=0 ts=694ba32e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=oWjmmMRXmHzkLbypZ2IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7lS1mcADW8JCSY7p_KPYtoraPw-cxNLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240071


On 12/24/2025 1:00 AM, Dmitry Baryshkov wrote:
> On Tue, Dec 23, 2025 at 06:02:22PM +0530, Gaurav Kohli wrote:
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
> This wasn't updated.


will fix this.


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
>> +  tmd:
>> +    type: object
>> +    description: |
>> +      A single Thermal Mitigation Device exposed by a remote subsystem.
>> +    properties:
>> +      label:
>> +        maxItems: 1
>> +      "#cooling-cells":
>> +        $ref: /schemas/thermal/thermal-cooling-devices.yaml#/properties/#cooling-cells
>> +      phandle: true
>> +
>> +    required:
>> +      - label
>> +      - "#cooling-cells"
>> +
>> +    additionalProperties: false
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qmi-cooling-modem
>> +      - qcom,qmi-cooling-cdsp
>> +
>> +  vdd:
>> +    $ref: "#/definitions/tmd"
>> +    description:
>> +      Modem processor temperature TMD
>> +    properties:
>> +      label:
>> +        const: modem
> Why it being called vdd?
>
> Why do you define modem-specific node here, while the CDSP-specific is
> defined under the if block?


will remove modem in next post,  earlier we were developing for all 
subsystem.
right now wanted to post for cdsp subsystem first, will fix in next post.


>> +
>> +required:
>> +  - compatible
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,qmi-cooling-cdsp
>> +    then:
>> +      properties:
>> +        cdsp_sw:
>> +          $ref: "#/definitions/tmd"
>> +          description:
>> +            CDSP software TMD
>> +          properties:
>> +            label:
>> +              const: cdsp_sw
> Why do we need a label in addition to the node name?


was seeing label error for cdsp_sw without this, let me recheck and update.


>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    remoteproc-cdsp {
>> +        cooling {
>> +            compatible = "qcom,qmi-cooling-cdsp";
>> +
>> +            cdsp_sw0: cdsp_sw {
> Is it allowed for device node names to have underscores?


will fix this, but not seeing any binding error with underscores.


>
>> +              label = "cdsp_sw";
>> +              #cooling-cells = <2>;
>> +            };
>> +        };
>> +    };
>> +
>> +    remoteproc-cdsp1 {
>> +        cooling {
>> +            compatible = "qcom,qmi-cooling-cdsp1";
>> +
>> +            cdsp_sw1: cdsp_sw {
>> +              label = "cdsp_sw";
>> +              #cooling-cells = <2>;
>> +            };
>> +        };
>> +    };
> What's the point of having the second CDSP block? Could you demonstrate
> modem instead?


Missed one cdsp1 block in this series, will add in next post. Leman's is 
using two cdsp subsystem for that we need cdsp1.


>> +...
>> -- 
>> 2.34.1
>>

