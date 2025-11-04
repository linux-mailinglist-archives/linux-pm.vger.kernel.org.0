Return-Path: <linux-pm+bounces-37372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216AC31D18
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001303B486F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11F256C61;
	Tue,  4 Nov 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b11Ilfwq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXMFPKZg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5642561AB
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269657; cv=none; b=VggAEJyz9Z1vfSgE86+Q0gix6LEKkdLuNCtn6v991bLcK2RtSu2WrwRa/ewI8OZLHsb8eifgGAQamkHP6zenXh+IEstosWbcU9ZigcSH+8ufzxqgrgxqYHkW6pPIanTNQ8co5RxnoHYS7Rv5+UzfGS+2lZFbbujGLP6jivfZEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269657; c=relaxed/simple;
	bh=ACY/hvkMZ9ASLgdogPuMp6WS3Jlo0CEWfvir5g57yuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghs266tzTeAp2ge4vkVIQXg+bHn4b85mOjpVGLNg9CVtZX3rZBVe2YnqYzANkDtddEHueOjFmtiS6gJb0S41tmvf+1SZyhQTUH9EwPz20nM6CtKZEZoObT0ciMNBXlQAeghAG1fpUb8ZyOL10omJjbWtG2uiIJ2E0AvRCH9b4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b11Ilfwq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXMFPKZg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CgKuW2044398
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 15:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ETWArU1vr6/+Hq5JyddcJ90NLk7QyRDpGowL9QmlBKY=; b=b11Ilfwq8XbjxyDH
	INEsOLHPgX1bPHQZLuh55Z++HojM5ydIVayneS9AvsYsGFDJXR5U93zj1rYqb/uY
	hAUL07ewigT9i/MiRHcltruodZznX5yVQ/2sWWVfTKm02HtQ7xMXJqDw7P3r6mWl
	rH8kl8SlvZVRnUYxcRdQ8/z7+WPImBasEiEKYET7wbnYMbBtYbGDxluAfSaCsdSv
	raCqVrjgFeri+9pQr+AxUtU/1+quGulez+n5oQJ21LpVAWJNk3XFt6zeCqEY/GB4
	BSJd0UuOgofRkwMDfV3o/Hwa9fwoubYadoXKKyzEtI4ZPxY2+z6lBa1EjlgPcmA6
	Fu+Mrg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7fgrgsru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 15:20:54 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-935153c7434so180758241.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762269654; x=1762874454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETWArU1vr6/+Hq5JyddcJ90NLk7QyRDpGowL9QmlBKY=;
        b=DXMFPKZguhpIYQFxKZQ09kh24/Oy1RyU/UK2INKYi+Mx/PMXAi+D4vuxS+CcJ0C3fE
         Yy9rsA+5h4WqCeudU2hKNBXYIAUmpOT1FD+CoyFHtApwVIv18DvbtIUNBPVhhoQkR7o5
         ei6kvwNboMgANq9MVfZX41vnD63QUIEKYC0IWXzt+O19p4ICblBkYYZIIZAsLp9ldmIl
         QV8fT+b8S4zP+waBgbSFC0LiXRpmQO3vllpi1LqkRLLFWvcxEV+hC9XGK8OQNMnCSGVR
         z1kG3Tp2uj0noiGH8c0+LeQQYT58p46zhMTu9JG8phCRFntjGf4ICfVXm8+2rOJ1HORp
         ii7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762269654; x=1762874454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETWArU1vr6/+Hq5JyddcJ90NLk7QyRDpGowL9QmlBKY=;
        b=fdzo5KD9sZgj6Kb2em1/FximLp+3YCWPJdOxCluoFwKLWuwFAQCTYpFr6enEQWcrHg
         yOxNhKyHC6k8d7wAp6F+ew1ZNgP2s4Y4ZXhtHRGjqcckLdwjCmTPNVZ1/CZTl5+Mx7vR
         yjg/oDvWUOmu0guWB5M8kXYis/GBcFFMFMXskgPheFoeUMAnvML5DB6zikSiSvKR8Zcq
         nOGDKlOBsmmvZyxHawy9AI5Ms5MfJ48x3FDTQUKb/HZPz6RG5SfBau4iN51CiKLNJogu
         4ce33LE19lYSjEyc+M8ePwvSGaRDHXG1fZRN/Ll1BokEnQ3CVNPxyOb/7jaiS0dQ3jYe
         fYDA==
X-Forwarded-Encrypted: i=1; AJvYcCVGSgf+88aWgQVLyv0bx3dK8gVi+dRquphA3/AXuB+fmKcV+7P4OmmTXKpxB0efehkjphEkDss7QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUC+/fAmH9XtcByJ5QPGtnQLGodo+8AaxagW3j8cLqCf3Sl3ZJ
	A4QZ3sNZHp7tUHMCmbSSFDfAv4iZCZjmhyGcon53v65WBkARZrDiC7zjDRbFSjrhlQu1AmXsdgl
	lt9UT+qnuToF5SSy0nQNg8jKNsVlq0G0Ucm82MzsXc9G96sB3f5eEr8I6RxuHUw==
X-Gm-Gg: ASbGncsNEXm4M/cVXGiD3iI8qna3HdkFzAQ5FqhqQtxkx5bvAjdvXLfHWBdFE4FTyLh
	vthIpeR6D8KAsqapag5Cy0XNSxw9/OlZSZZe9ChogN8mkipy0xMZxzzNEnAJ06oNAosacPUaQ2u
	Hy1qfqHg5VGQxQKzN0yqA5o6+v8ixDGO4GkVQICmsSIJSqZusmpXHpU+oUZaGvTmhrNyuUWeQeC
	5zmkeYxr/ukBLQsr8suydab1dovkSN9EwSJa115biqrzG5mJi5coNyGjc0iVsgDJfv87J+ZgO75
	ymeYYBTNPzwi1kloDhIFFEUK1hZ+YGx6LxMIRRxI2OHi5+dbTkcT1D2t0dd6PZdBH+767SKMd9/
	NwGnkJeThv22Shic+R9w3bO/w6pgdkinQuKKvn8YtFHWePi2+FegtHFnE
X-Received: by 2002:a05:6122:8484:b0:559:74f3:c91d with SMTP id 71dfb90a1353d-55974f3cce6mr610349e0c.1.1762269653800;
        Tue, 04 Nov 2025 07:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4s3GJU+E6H5SL4JhynsqbUR+4QISEht8QJYjDnl7pZ0OiVYAFHgaTP8PPi0fnp2YYi1A5qg==
X-Received: by 2002:a05:6122:8484:b0:559:74f3:c91d with SMTP id 71dfb90a1353d-55974f3cce6mr610330e0c.1.1762269653226;
        Tue, 04 Nov 2025 07:20:53 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm233306166b.20.2025.11.04.07.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 07:20:51 -0800 (PST)
Message-ID: <c1269f38-ab90-40d1-b5d3-39f546829d6c@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:20:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: reset: qcom-pon: Add support for WARM reset
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, krzk+dt@kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        conor+dt@kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-3-loic.poulain@oss.qualcomm.com>
 <740b9e7c-59bc-4a35-a268-526d92db372c@oss.qualcomm.com>
 <CAFEp6-12qN0=cv5=tPeVq3bVDLkaQDHLLCVQY4dtCTSvx+dPOQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-12qN0=cv5=tPeVq3bVDLkaQDHLLCVQY4dtCTSvx+dPOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WodQoAvcwIzVFMxX1XFR4onhAM1cUC4q
X-Proofpoint-GUID: WodQoAvcwIzVFMxX1XFR4onhAM1cUC4q
X-Authority-Analysis: v=2.4 cv=b7O/I9Gx c=1 sm=1 tr=0 ts=690a19d6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nsY2OikdMtLjWMwq5xoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyOCBTYWx0ZWRfX8NAcb4S3ZyPE
 uykVV3UO/5jE0U+GVMMWKNcf1oAK3F99WFqkmv4bczEgWbpeaFWQKQQN9ZEcgcxvj0Ab68XPb1z
 sz/lJhuIVplE4riqmCts1iKudf+WWNwGU1tBYON1xFZe7Uhsf2E/AtdAnm0pP61jrsUQB/XRwZh
 0cFcbxTy4IdAFNHGJgvR4zv1fR33DxIg85cu67hVIJp96IBKdLXMQj2guRQ9MTE1YPibJB3r9Vz
 KQFakbSE2CawRXzGrJmw+VnqJbeIt2h9HKtai2fvvGS8u87GFg/B2Qr1uQcIYCLnkPslvP0K+0G
 J84coxDxzYn2kmrZOHDC1U3YU6Efw7/Wo31GfHQLT6GnCCVLbQQTpMymlNGmOn5HP4rEKg2l1fc
 YFBjBJPqI471kDAthB1piRw+z7fBDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040128

On 11/4/25 4:01 PM, Loic Poulain wrote:
> Hi Konrad, Krzysztof,
> 
> On Tue, Nov 4, 2025 at 12:50 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 11/3/25 7:20 PM, Loic Poulain wrote:
>>> This mechanism can be used when firmware lacks proper warm-reset handling,
>>> for example, when the PSCI SYSTEM_RESET2 function is not implemented.
>>> It enables the warm reset functionality via the PMIC.
>>>
>>> This fallback is only enabled if qcom,warm-reset property is present.
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>> ---
>>>  drivers/power/reset/qcom-pon.c | 47 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>>> index 7e108982a582..684e9fe9987d 100644
>>> --- a/drivers/power/reset/qcom-pon.c
>>> +++ b/drivers/power/reset/qcom-pon.c
>>> @@ -19,12 +19,20 @@
>>>
>>>  #define NO_REASON_SHIFT                      0
>>>
>>> +#define PON_SW_RESET_S2_CTL                          0x62
>>> +#define              PON_SW_RESET_S2_CTL_WARM_RST    0x01
>>> +#define PON_SW_RESET_S2_CTL2                         0x63
>>> +#define              PON_SW_RESET_S2_CTL2_RST_EN     BIT(7)
>>> +#define PON_SW_RESET_GO                                      0x64
>>> +#define              PON_SW_RESET_GO_MAGIC           0xa5
>>
>> Going back to msm8974 where the SPMI arbiter first showed up, these
>> values are all seemingly valid, so I think we can drop the dt property.
>> The restart reasons are set in stone too, and you can find more of them
>> in the register description.
> 
> Yes, but this should only apply when the platform firmware does not
> support warm reset via PSCI, right?
> Making it unconditional would override the PSCI implementation even
> when warm reset is supported.
> 
> The point is that psci_sys_reset() executes a cold reset if warm
> reset isn’t available. Therefore, our PMIC reboot notifier must have a
> higher priority than the PSCI handler.
> 
> So maybe the alternative could be to introduce an additional reboot
> handler in psci, with the lowest priority, so that warm reset can have
> a chance to run either from the psci main reboot handler or from the
> PMIC reboot handler before falling back to cold reset?
> [PSCI-handler]->[other-handlers]->[PSCI-cold-reset-fallback-handler]

This seems like a common enough problem, perhaps the framework could
accept EOPNOTSUPP or similar and try to delegate further, coming back
with a normal restart or so, if unsupported. Trying to make a special
contract between qcom-pon and psci silently will be very fragile
otherwise.

>> That said, we're circumventing PS_HOLD this way - is that intended?
> 
> Well, we don’t have direct control over PS_HOLD since it’s managed by
> the firmware in our case. That’s why I considered using the PMIC
> software reset as an effective way to achieve this warm reset.

Hm, so is there no longer a way to assert it by writing to PMIC
registers?

>> And do we need to take any special care where there's more than one
>> PMIC onboard to make sure that the SoC gets properly reset?
> 
> Good point, this likely only matters if the other PMIC reboot handler
> performs the same type of reset and their actions overlap.

I think there used to be some logic in the older days where Linux would
manually go over all PMICs with a PON and send a reset to them. Maybe
that's too old for this platform though.

Konrad

> In that case, I may need to remove the mdelay from this handler.
> Additionally, if we adopt the PSCI change discussed above, the system
> will fall back to a cold reset when a PMIC-based reset isn’t possible.

