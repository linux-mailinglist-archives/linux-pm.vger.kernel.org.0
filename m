Return-Path: <linux-pm+bounces-37817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54706C51FBB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 12:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7484B3AE0D1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 11:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937330DD05;
	Wed, 12 Nov 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvZ2mcAj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PsQeLKLD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2730E0C3
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946435; cv=none; b=UTeg9/vwZJ3g3lK/WDQdkdBrL3vfiZPfDCchm7z+u3ze5bLkzm9z5AwEGJuFdbvZLzQsbeNcZho2cMo0OPkgZwpN1Zm/Jq/28QRkA4iZWRsHp0RnAdmORsnAhX+BpzgC97T3FzJQNvLGNjB2b1JvGi66BqWKs8phcoa1uq1tqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946435; c=relaxed/simple;
	bh=Z8ZdAGG4EyKf8tVMNLlOiWZmA/jRMp+kaNu5G+A0Vfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf5uyDL+1ZcsvnovImw4vXWuniA3ItRaetWzqKzaf1p9z+7VdrejV8kUgZ58iZ8bWy+IHYAoG/6hWKtLBDXts93XSBf9/wNFVDKssqXZDf3ioVYhBggNjMgrsEc9oAsj4RjDj5Ch3c/j/oeUf+Gfpnk8syT3XLEKKZr7ez9JSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JvZ2mcAj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PsQeLKLD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9gLh6960177
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r5gL8BGnvahOLcwAKb9JaCY7XjjVHbw8vJ21kFjLfyw=; b=JvZ2mcAjim4Djm0G
	bkDVQQBQY6tqUxDRvzHuPOg4UKulx2RGI6pI8zcXsITA83TqJobw3rMkuYGfWP9N
	vF315wdmChMmQeAn7N5b3SAO2qX8wNs6nDYAZwvmKDba7c0ygPs0ztmSOkD/uWfx
	T3lloEVwQwCV+Y0Y7ouEfmV4FRjIKDSzBPbPHBm8l0uOC85QAraMBq5d2vQuznPI
	CxYeTAKUNk3qQL9c756ACGNGFC2iS9o1PtuKuc+KESMN6JUrTJUibj067TqjRzfb
	YD891JV2zvZWz6ECu+uUDVLY8i4GsM8Vo6I6f+YR/lAKFuTiANmgbhgar1cmEhW9
	WS1IfQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqueraeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 11:20:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edaa289e0dso2685181cf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762946432; x=1763551232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5gL8BGnvahOLcwAKb9JaCY7XjjVHbw8vJ21kFjLfyw=;
        b=PsQeLKLDEFFKWnXn1zE2B5Ja6x6Y6Q291SuOoJb8sWjuEgrUjcHL/WxxuABgRyO30h
         YE9qfVMADSYsxaWuT6nChK83cZwYO/JiZZ3XAZrJx8RTSHPr4PvOx0dy7BrU+54PglRJ
         Tioc3Tj/9+2W5oRz5qRiiprhep9w+cVQrAwviCeaOz2WEeY35eqbfTxibjiff5GnZwiU
         JCqp8jmpqoS0p/r5Xe4fm3odd5WZmmZHqAITs+3IgfiY9NwDshZv62pW5HvxB3o4tp+S
         JBKj1GltP3tKnCepwk1iFWbvCJ3XpbNj+yjKLMktp+r8cUSDxJt1zPtKe4reejEgl3py
         nxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946432; x=1763551232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5gL8BGnvahOLcwAKb9JaCY7XjjVHbw8vJ21kFjLfyw=;
        b=V/zd4WtdXi8VfCEwUQGnc7H8tFlpa/ANU+rHG7iNll+OyczNXPyQZtHZggtInog86N
         H3JT1BYI+ezFZR1WJd1HzIyzOtcOA6zz0+Wd0WvstYH7SO405BJ1JsuaHkS2K4m0RlWM
         DoRGjIHXuS33MCWNrSZ5Vit/kxjAQGbUutBTBfdX7G7vzkZnqGgZhGj0tmQHg1RNL/M3
         DvrEv7Jw7Z7YI37w7mw2fPNP7PNJZeYnPARzA91xPQ44n0PD0ApY8CYnhzyxsAR0hFzf
         f56JLekzToEfl/V8SOJH90YSGxxpMWJjLqfZKs3kHSkn8VOfgqKEbXQxHMv1hHZL8rg+
         ve/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9Jtkj95QS/bvJ3zrhNo3pgkgYQG/Q2unwkOQ6h8TQbF8tjZWx3UtrMqc312Yfz3tfNr3PsIVLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKwBJCFHNsLx99KcNR+eZZzkmSxtgU914O9lZhSPDuJqdzUoQ
	KEVj/mH/xDrkwfl7d9MuW8tSlRvluDzbQEEcK9dGpODGjfhi9Ic6daCC/DsCmDmA+GU/xj7m8Bf
	RikCPP3/oisoBbRAR9xVL2iDZgPh6Ohwtpbdt97i5F2rlvKINsrRafVTJhVcjZw==
X-Gm-Gg: ASbGncuTYrtLYiEHQ0jDhZUuD40AT4Srxdhh9iOn3QFKQ/ZO4d9n7mbY/yhbuuDATNU
	dgX0znx/oNjbQHH1wCMJn3qoj0S1uU/upSgQ7m2HE5748KHEifzEgCFxQuIJBJSUoXFu1zE3Owv
	vGDZt33lSwLSeybHuVyD+YP6b1va47YafkSCYo+sIntT69by9JGzYq2TQK0ddtSN3gOlSr+Dp7v
	nF7+KaqLIGJhJ8FqDpCziReWNIkK7wjv5mbzzAxogFEHMNvEJf0a49AJ8+5HfRIKtOoL7MIso0l
	BXI696PpJq3jZo3fqqNgO85tPKS7T5xYZ4qkL4XDjAEGUmt8neai2841veYOJw5E1fg3cH+TQLD
	ftVN16Cdrw+hw8EdFu+2pV5I2yHwLf1c/PweKsjFcVURIOD/ilWf7qv00
X-Received: by 2002:a05:622a:1a0b:b0:4e8:966b:459b with SMTP id d75a77b69052e-4eddbc9b6fdmr20569031cf.5.1762946432220;
        Wed, 12 Nov 2025 03:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuxcDboMBlXZ8IfMpbvAVD/xCyC6PkgJofI6nYVfYXkD5ZeyDbBO/vyiqeNaeZ+hpdlaOWnQ==
X-Received: by 2002:a05:622a:1a0b:b0:4e8:966b:459b with SMTP id d75a77b69052e-4eddbc9b6fdmr20568821cf.5.1762946431714;
        Wed, 12 Nov 2025 03:20:31 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7327a48bc7sm321134966b.71.2025.11.12.03.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:20:31 -0800 (PST)
Message-ID: <4e9d15cd-1ef2-464c-b421-f8a333c53825@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 12:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
 <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
 <CAFEp6-12qN0=cv5=tPeVq3bVDLkaQDHLLCVQY4dtCTSvx+dPOQ@mail.gmail.com>
 <c1269f38-ab90-40d1-b5d3-39f546829d6c@oss.qualcomm.com>
 <CAFEp6-1+inMhsgjSqAZ+UDBMuNc9DA-jXFyqB=gkvYpSzW9Ukg@mail.gmail.com>
 <6daf722b-6b1b-4c91-b108-74793d930319@oss.qualcomm.com>
 <CAFEp6-0sbDj0C9KAMxq1mrGO9jGz4YDMqnf1AGVU49PyGzLi8w@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-0sbDj0C9KAMxq1mrGO9jGz4YDMqnf1AGVU49PyGzLi8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA5MSBTYWx0ZWRfXy9dQRhAaV/30
 PkCm1z9+0cjvXaABv78xWWlqLK8Wdi4gGy7D8Pkho+IJj3KutJEmKY7fvg8sQ77+HY8W+5WBptv
 HPtGhLCI6+QfCWg7C2GW78NoABBEPOux2BjrnRc1JmWlYjEpdSLhayRslAhJTYmIM1S/GaopnvK
 86H7Nrhf63Muv2PsUhH4K6i40pgLgAjMHr7mG0Q4qgIvHQBbT7Zg9ntbcX3ciZfz1700quMNeGM
 9nrkvdzhMUyd61hcrc7swfZTJ6mu8uRFx2Vctgd7zFNL+eLvPCVTRq1GBYAjtZf2/Ba72/cIsTN
 r+aESeSFsjuMHaYGJ3WvdYTYkSmTXfjmmossld7uV8XM3eAHcZoGAZQGBrU5jsTUH9rtBvM0lr5
 2J3+Rg1no2zKk2lll3aNLLRnJ07RrQ==
X-Proofpoint-ORIG-GUID: zWBOsrQc7NQhAhhaRo8e38ImncGYJJJ1
X-Authority-Analysis: v=2.4 cv=cPztc1eN c=1 sm=1 tr=0 ts=69146d80 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=oAzUKsySGAh57qx-K-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: zWBOsrQc7NQhAhhaRo8e38ImncGYJJJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120091

On 11/12/25 12:16 PM, Loic Poulain wrote:
> Hi Konrad,
> 
> On Thu, Nov 6, 2025 at 1:50 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 11/5/25 10:44 PM, Loic Poulain wrote:
>>> Hi Konrad,
>>>
>>> On Tue, Nov 4, 2025 at 4:20 PM Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>
>>>> On 11/4/25 4:01 PM, Loic Poulain wrote:
>>>>> Hi Konrad, Krzysztof,
>>>>>
>>>>> On Tue, Nov 4, 2025 at 12:50 PM Konrad Dybcio
>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 11/3/25 7:20 PM, Loic Poulain wrote:
>>>>>>> This mechanism can be used when firmware lacks proper warm-reset handling,
>>>>>>> for example, when the PSCI SYSTEM_RESET2 function is not implemented.
>>>>>>> It enables the warm reset functionality via the PMIC.
>>>>>>>
>>>>>>> This fallback is only enabled if qcom,warm-reset property is present.
>>>>>>>
>>>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 47 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>>>>>>> index 7e108982a582..684e9fe9987d 100644
>>>>>>> --- a/drivers/power/reset/qcom-pon.c
>>>>>>> +++ b/drivers/power/reset/qcom-pon.c
>>>>>>> @@ -19,12 +19,20 @@
>>>>>>>
>>>>>>>  #define NO_REASON_SHIFT                      0
>>>>>>>
>>>>>>> +#define PON_SW_RESET_S2_CTL                          0x62
>>>>>>> +#define              PON_SW_RESET_S2_CTL_WARM_RST    0x01
>>>>>>> +#define PON_SW_RESET_S2_CTL2                         0x63
>>>>>>> +#define              PON_SW_RESET_S2_CTL2_RST_EN     BIT(7)
>>>>>>> +#define PON_SW_RESET_GO                                      0x64
>>>>>>> +#define              PON_SW_RESET_GO_MAGIC           0xa5
>>>>>>
>>>>>> Going back to msm8974 where the SPMI arbiter first showed up, these
>>>>>> values are all seemingly valid, so I think we can drop the dt property.
>>>>>> The restart reasons are set in stone too, and you can find more of them
>>>>>> in the register description.
>>>>>
>>>>> Yes, but this should only apply when the platform firmware does not
>>>>> support warm reset via PSCI, right?
>>>>> Making it unconditional would override the PSCI implementation even
>>>>> when warm reset is supported.
>>>>>
>>>>> The point is that psci_sys_reset() executes a cold reset if warm
>>>>> reset isn’t available. Therefore, our PMIC reboot notifier must have a
>>>>> higher priority than the PSCI handler.
>>>>>
>>>>> So maybe the alternative could be to introduce an additional reboot
>>>>> handler in psci, with the lowest priority, so that warm reset can have
>>>>> a chance to run either from the psci main reboot handler or from the
>>>>> PMIC reboot handler before falling back to cold reset?
>>>>> [PSCI-handler]->[other-handlers]->[PSCI-cold-reset-fallback-handler]
>>>>
>>>> This seems like a common enough problem, perhaps the framework could
>>>> accept EOPNOTSUPP or similar and try to delegate further, coming back
>>>> with a normal restart or so, if unsupported. Trying to make a special
>>>> contract between qcom-pon and psci silently will be very fragile
>>>> otherwise.
>>>
>>> I tested the following, as described above:
>>> https://github.com/loicpoulain/linux/commit/5c34ea54e1a21ff1192c3c341877b24eff5f80b4
>>> The only special 'contract' is the handler priority.
>>> If you can elaborate on another/better approach, that would be helpful.
>>
>> Thinking about it again, it'd be difficult to grab some sort of a handle
>> to the ""parent"" reboot mode, so what you propose here is good
>>
>>>>>> That said, we're circumventing PS_HOLD this way - is that intended?
>>>>>
>>>>> Well, we don’t have direct control over PS_HOLD since it’s managed by
>>>>> the firmware in our case. That’s why I considered using the PMIC
>>>>> software reset as an effective way to achieve this warm reset.
>>>>
>>>> Hm, so is there no longer a way to assert it by writing to PMIC
>>>> registers?
>>>
>>> PS_HOLD is a SoC signal, and we can maybe assert it via the
>>> MPM_PS_HOLD register through the msm-poweroff driver if needed (well,
>>> if access is allowed from a non-secure world).
>>> However, this would also require coordination with the PMIC driver to
>>> select the correct PS_HOLD action (shutdown, cold reset, warm reset).
>>> For that reason, I’d prefer to keep PS_HOLD based logic abstracted by PSCI.
>>> Using the SW_RST PMIC register allows us to perform a reset without
>>> additional signal handling.
>>
>> Yeah of course we should use PSCI where functional and available
>>
>> I think PS_HOLD used to be fully manual on old (msm-3.10) platforms
>> through PMIC registers. I see that e.g. msm-4.19 has an SCM call to
>> (de)assert it. There's also a "halt PMIC arbiter" call.
>>
>> (via drivers/power/reset/msm-poweroff.c)
> 
> Yes I could try the SCM call to deassert PS_HOLD, is it something we
> should prefer over PMIC soft reset?
> Asking because the implication would be a more complex solution
> (though not yet tested):
> - Adding reboot mode support in qcom-scm to activate ELD mode
> - Adding reset-notifier in pmic driver to modify PS_HOLD action to warm-reset
> - Adding reset-notifier in qcom,scm (of lower priority than PMIC)
> doing the actual SCM ps-hold deassert
> - Ensuring that PSCI is still used for cold-reset and warm-reset when
> supported...

My answer is unfortunately "I don't know". We should loop in some
PMIC folks that would know the difference

Konrad

