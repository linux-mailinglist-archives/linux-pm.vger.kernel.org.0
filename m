Return-Path: <linux-pm+bounces-36350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D2DBE8460
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 460414E4FA0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A88343218;
	Fri, 17 Oct 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQyOs01W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013D343206
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699937; cv=none; b=lXKzRrZGM5CKSICzpVwu/FaGpaqjyS4DALmVLkG2wkFz42grjB0rkro6l8Uv4aCQdPx4fI0P8+NGGuWHZVdCrZVlS6olOcfM0d73pjoHDaJ+37LJDzbRtrNUvRvaKqx1oJimpnOGpGmXA1zduIEnkYmuAxeaJafpfGDIgYIwUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699937; c=relaxed/simple;
	bh=oOAbWrdIWy8QTIeq7s27EupODM0hsiWV2SWffEEP900=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKHRP3TI1V08386AOLd9dF2QQpyxOgNCUuw+ZhdxJzq6hKbrJ8EIilUIFI5EhfG3UwzlR+YIZXOA62v1xIGMj6dmte2l72cAzGDCHWF0r7bhpYwEMQAACMd90zV3LgSU2tWIn19VRSgvhnkKdGW7yngrLWWHKXR41gV8x0RBzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQyOs01W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H81Rwg025269
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 11:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRpDYpc/IEeUA+KEWpYpACEZ5933xUZoquxcDmxbVME=; b=QQyOs01W6RAb8ve4
	PorT425SvxxK3wcxG+Zv0ipLFZMU+dRg0fjBZ3K3+Bq4I+sNCoLBWh4k88tUoiud
	zApYI/Y2uC6PgLMQRpqk0UYUdHe2uNBWU1fGGpmw3uFFnwKIk9Pnk/hTfEL/gDNw
	9N48eMWiZWRRRUtUmVaHcrxLrod049PXFGRXFeGBxQbtRvzanEzVDKoWES7phb7a
	NTrej/n8wPoeNX2fSI+x8bEiKWQUvmI1YtIzeOGs21UAwiTlnXEKMdp1Rj1n+3LG
	xI2k8Kgp52cmzXPrr14GmBNSOd6Z4N4popZY6SY9m9OOgdyQwkaKHVjWuwhGyDw9
	MO7V9w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkkywd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 11:18:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33826e101ecso3146667a91.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 04:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699933; x=1761304733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRpDYpc/IEeUA+KEWpYpACEZ5933xUZoquxcDmxbVME=;
        b=ZNOuSnq7Scrl3O7ML+5E4P9yTlrzMZkKJJZEWOZWrlGF8kmLQQ20TqJAZsLZAcQgMu
         yINMsttgqZWSHNGRzlu/1Nua7Xsy9KPeW8Towm91WpIhoxQ5Oac0beR1idCeBnJ01DEo
         qnaFAqDSpk6nsX4GJ11ooFgJntriuzBYBmZKPeiN7pjnr6i83Y4hu1pOc2qqsz8BpBO/
         ++WT4kNZF8vizixYgTj/nfcdrbl31As7jidolLnsKrVCDhwS3jzJRthmW+h4UaEejMWE
         ie8K94gTrEQD76HrhsFZgYa8as2BpT9YZ+zXmo0a+QCLWXkkEkyTzjBFF7p3f/7ETJcO
         XI+g==
X-Forwarded-Encrypted: i=1; AJvYcCXzltjYLNJ+Is4/R8fOYomjhJuVLxuLDmLLx+Y+VOQZDJxSwsXgBiE7l6Dyk4LMWvre7pETWeH3lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuk7F/+wuM2rIL26kyBwYrmgWONp8fTyWiSajvqqeeOwSFWlvO
	fjd3qKGG/zZiG9U8V8pLE4kDlLxLZi+1FqbPLIB4BxJwE//ZfarcwYJw/CbAy9Xo7CaKkmWOkp5
	JtVZqCs086oWteSlNtBDPlXw1o+g8K4G+ZFI7vQWOZbQcAwu/imQbtQ5KDyAR+Q==
X-Gm-Gg: ASbGncueV8lGiFwqrzlyVoTKFvsC9Wilr0RnmDDGzEdufrBRn3/I2kPlg7xs+c9IuMO
	KVmT39jJcWxqk7JFClEJZhfa2xGL6HVd7fVnurh24VOIwlfv5srMBTW5uoKDvqEdUPtw8cd86pi
	X6uCGsSryB9+oksUF1Uu2noDOvTLAJWZLoisnpKxlDrUJqizcQaj4AjyDv1KzKZ53sU8w+jBms+
	nzFwjurRClQQeyMC1ZlUR1u6DKfXbcJJlXMNI2g9lD8eA/Xed1/rcGQV4pfnYsmoi8N1PMj1tRh
	FGHRhNfowMSJjwbEsZK9HpTzskipy/sUWviDJvENPa/2/VJwSHCZ9v7XkIkckiA0z0oyhUIYrH7
	6XHHVsZAnqHw5ub0FKNcymkE9szjNBnA=
X-Received: by 2002:a17:903:19e7:b0:267:cdc1:83e with SMTP id d9443c01a7336-29091b586d2mr92162165ad.15.1760699933469;
        Fri, 17 Oct 2025 04:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYJ3ZunwrRNVnlYzmBkV0+8dpKLlZWhJj8Tv4UNS+d8TzTV200DdWwmNQLBB06wtIOD7N2xw==
X-Received: by 2002:a17:903:19e7:b0:267:cdc1:83e with SMTP id d9443c01a7336-29091b586d2mr92161545ad.15.1760699932971;
        Fri, 17 Oct 2025 04:18:52 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909a4590d9sm59498775ad.50.2025.10.17.04.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:18:52 -0700 (PDT)
Message-ID: <68a9b8e8-bdf4-430f-baef-6a293ccea78d@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 16:48:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
 <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
 <20250927144757.4d36d5c8@jic23-huawei>
 <a3158843-dfac-4adc-838a-35bb4b0cbea4@oss.qualcomm.com>
 <CAGE=qrrCvq28pr9Y7it-CGMW=szKUnU+XBj1TmpoUwuASM05ig@mail.gmail.com>
 <31bd08ce-823a-4a71-baca-a9d1e02fcb6a@oss.qualcomm.com>
 <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jRy_hrtJSClxMYLrESYYckBpFiR_ZQg7
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f2261e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0Enez7m-cBcTSUDfOx8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jRy_hrtJSClxMYLrESYYckBpFiR_ZQg7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXziSpAP/Kq6IC
 9GbnPiVt5BlsVMel0OvfiD/FmqhEonjotQipMq/0GUJ3ioyPDf6B352IsQenMbxvGjf33opzGlo
 blrTDPYEv5VRkrV8pENzr12bwKme2bV9Yxj7WGcqoIxOwr5FCqmhACM1RLKEu06geQbcyq9/ZQC
 6dqTvBqiESk2phPkxb68ODMlWTHsoROYj9dSqI8zTAuchUosjS7Qf49i6tsth4uGCIfCicoWk8y
 carVXIP8e+Dc7wLlmFZ70iwEoOt+dHgWIA4dVevKEMF6XxwjojhHGO1qGlgcy5oGCGMfkOGKyP+
 ivP0OoJ7tu0E3lVWT88HQdH2ZGARyHPu6w+NWPSJ1hCBkbD7ZUVHpUtP8mHLYqNsKw30GEHuo4K
 dNUsBZf8aewYakgvjLGIm34Z2GMecA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Hi Krzysztof,

On 10/9/2025 5:22 AM, Krzysztof Kozlowski wrote:
> On 08/10/2025 23:20, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>
>>>> Hi Jonathan,
>>>>
>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 18/09/2025 04:47, Jishnu Prakash wrote:
>>>>>>>> Hi Krzysztof,
>>>>>>>>
>>>>>>>> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
>>>>>>>>> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>>>>>>>>>> You cannot have empty spaces in ID constants. These are abstract
>>>>>>>>>>> numbers.
>>>>>>>>>>>
>>>>>>>>>>> Otherwise please point me to driver using this constant.
>>>>>>>>>>
>>>>>>>>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>>>>>>>>
>>>>>>>>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>>>>>>>>> which is added in patch 4 of this series.
>>>>>>>>>>
>>>>>>>>>> They can be found in the array named adc5_gen3_chans_pmic[].
>>>>>>>>>
>>>>>>>>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>>>>>>>>
>>>>>>>>
>>>>>>>> We may not be using all of these channels right now - we can add them
>>>>>>>> later based on requirements coming up. For now, I'll remove the channels
>>>>>>>> not used in adc5_gen3_chans_pmic[].
>>>>>>>
>>>>>>> You are not implementing the feedback then. Please read it carefully.
>>>>>>>
>>>>>>
>>>>>> Sorry, I misunderstood - so you actually meant I should remove the
>>>>>> empty spaces in the definitions, like this?
>>>>>>
>>>>>> -#define ADC5_GEN3_VREF_BAT_THERM               0x15
>>>>>> +#define ADC5_GEN3_VREF_BAT_THERM 0x15
>>>>>>
>>>>>> I thought this at first, but I somehow doubted this later, as I saw some
>>>>>> other recently added files with empty spaces in #define lines, like:
>>>>>>
>>>>>> include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
>>>>>> include/dt-bindings/regulator/st,stm32mp15-regulator.h
>>>>>>
>>>>>> I can make this change, if you prefer this. Please let me know
>>>>>> if I'm still missing something.
>>>>>>
>>>>>> Also please let me know if you want me to remove the unused
>>>>>> channels - I would prefer to keep them if there's no issue,
>>>>>> as we might need them later.
>>>>>>
>>>>> He is referring to 0x14 and below not being defined values.  So what
>>>>> do they mean if they turn up in the DT?
>>>>>
>>>>
>>>> Thanks for your clarification. To address your first point above, the macros
>>>> added here only represent the ADC channel numbers which are supported for
>>>> ADC5 Gen3 devices. If there are numbers missing in between (like 0x14),
>>>> that is because there exist no valid ADC channels in HW matching those
>>>> channel numbers.
>>>>
>>>> For your question above, if any of the undefined channels are used in the DT,
>>>> they should ideally be treated as invalid when parsed in the driver probe and
>>>> lead to an error. When I checked the code again, I saw we do not have such an
>>>> explicit check right now, so I will add that in the next patch series.
>>>>
>>>> And to be clear on which channel numbers are supported, I think it may be
>>>> best if, for now, we only add support for the channel numbers referenced in
>>>> the array adc5_gen3_chans_pmic[] in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
>>>>
>>>> There are only 18 channel numbers used in this array and I would remove
>>>> all channels except for these from the binding files. During parsing, we
>>>> would use this array to confirm if an ADC channel added in DT is supported.
>>>>
>>>> In case we need to add support for any more channels later, we could add
>>>> their macros in the binding file and update the array correspondingly at
>>>> that time.
>>>>
>>>> Does all this sound fine? Please let me know if you have any more concerns
>>>> or queries.
>>>
>>> No, it doesn't.  You keep ignoring my arguments and responding to
>>> something else. I prefer not to store hardware values as bindings,
>>> because these are not bindings (and you failed to prove which SW
>>> interface they bind) and it's really not necessary.

Sorry about the delay in replying. Let me go step by step
over the use of the macros and how they are used by clients
SW.

1. In ADC Gen3, this is the superset of channels supported on all
PMICs (with ADC):

Ref: include/dt-bindings/iio/adc/qcom,spmi-vadc.h

/* ADC channels for PMIC5 Gen3 */

#define ADC5_GEN3_REF_GND		0x00
#define ADC5_GEN3_1P25VREF		0x01
#define ADC5_GEN3_VREF_VADC		0x02
#define ADC5_GEN3_DIE_TEMP		0x03
....


2. Since some PMICs may not have all of these channels supported in
HW, we have the PMIC-specific channel definitions (starting with PMIC
name like PM8550_..) made referencing the above definitions.

Ref: include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h:
...
    #define PM8550_ADC5_GEN3_DIE_TEMP(sid)	((sid) << 8 | ADC5_GEN3_DIE_TEMP)
...

side note: This is also used for the "reg" property in the ADC channel
definition DT nodes.

Here `sid` is needed as there can be different instances of same PMIC
using different `sid`s on a single SoC, and also on different SoCs, the
same PMIC may have different `sid`s.


3. This PMIC-specific definition will be used by clients like below
(in io-channels) to get the ADC channel they need to read.

    pmic@1 {
        temp-alarm@a00 {
            compatible = "qcom,spmi-temp-alarm";
	    ...
            io-channels = <&pmk8550_adc PM8550_ADC5_GEN3_DIE_TEMP(1)>;
            io-channel-names = "thermal";
        };
    };


Can you please provide your suggestions on changes we can make
in the above points ?


>>
>> In my previous replies in this thread, I missed mentioning that the macros
>> defined in include/dt-bindings/iio/adc/qcom,spmi-vadc.h are also used in
>> other places than the driver file - they are also used in the PMIC-specific
>> binding files added in this patch, for channel definitions. Considering
>> one channel for example:
>>  
>> We have this in include/dt-bindings/iio/adc/qcom,spmi-vadc.h:
>> +#define ADC5_GEN3_DIE_TEMP			0x03
>>  
>> The above is used in include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h:
>> +#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
>>  
>> And the above definition may be used in device tree, like in the example added
>> in Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml:
>>  
>> +        channel@203 {
>> +          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
>> +          label = "pm8550vs_c_die_temp";
>> +          qcom,pre-scaling = <1 1>;
>> +        };
> 
> This is not a driver. I do not understand your argumentation at all.
> 

I hope with the comments above I was able to explain the purpose of
the different macros added in dt-bindings. Please let me know if
you want me to elaborate anything more.

Thanks,
Jishnu

> Best regards,
> Krzysztof


