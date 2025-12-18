Return-Path: <linux-pm+bounces-39673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15DCCC5ED
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5563062E09
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45B2472A5;
	Thu, 18 Dec 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W27VBbtq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TsTnk7du"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA2287506
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070002; cv=none; b=M6DmEJXKr3P4g0xxNOgb/E8xxX8pnOuVAcoLHPt9nUz5Z4w/cdS3EVnBmivMCcbOQp8LCiKZphB05+SVYkkjPPdFZwI8PPhOEo2VHvkPKO8/+kk8v7YVTnpEdaVRiYXQK2BREAz8h/z0bBwKQ7SeASC5lHKV0xOmXsOurUISuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070002; c=relaxed/simple;
	bh=TTUSg9c7SQ25F3h6Y+3feZ9hKn8pWE0fflqhp8v8Lls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJgxJ4b6UC8UXnlZp2ygWnBq4a7jYWrUidDhtgAR7hoiKyzhJTXp5sUOoTb4fi7h8hxFxHqFgkpI8DAovHKsj4GdbNzcfLNkNE4ZES/9SVB989Ws4hPFaZr/IkYgOcJLSb+FSdUD63/bUqUyvUbtZwhloyGk0ahUhhIAyOQPe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W27VBbtq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TsTnk7du; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI9F1nb174303
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 14:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pr6x/FHZNy2BKmBuWTvABEu0BkQWH32tUpuP8BZZdQI=; b=W27VBbtq5yugaGUu
	HZEFBmSyctDT2jwZHRQfRyyH64CkEQc3qj6Zw3GUAwgnbX0zC70tDe7OfIGucFZb
	MlO+YKy5cOB5Sr59IP83O26dWO+z+Z9TlVcfc/6i4rX0Ckzk5IukaeEhAAb8rJEb
	1kQjNrKWc/lVyr6i/NW0TNkpXt/gNBhR60Afpl7IbnKSlztW3VBihDnCY/fYOlj8
	h/GHQslpZgqRc55cZ1RYlu6ncm+GRNHGqaey9YaMWZFlHKUVc6fFC+rLh7OvW9hK
	My6GCq5s2sYPiqoh9Rfbwlq5Sj9OyVewoHgmDlbhNWr9SXjG1uiiorIjdw9duMrp
	L3pBhg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43nmu1xy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 14:59:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b1be0fdfe1so28137185a.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766069998; x=1766674798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pr6x/FHZNy2BKmBuWTvABEu0BkQWH32tUpuP8BZZdQI=;
        b=TsTnk7du28m3TEP5XHfEQIdr0/lAwL3n7cqP8FAKueiXOUmrF5oIImd1XuQk5QZ3oi
         /ysw1Mni6gS6NZJ09Vw9MxaZVEpIdOCSqALKILGjzrHHpWs72GMFPp7T4/xUhWOQxxVn
         clHXY+ZhotLVhO/HAnTN9yXgsDuzNSjrE3Ty4Y/hHCo1r8Wo95oa8MzL9iPVYmquu1B2
         pVKQRYgmOCXF2hae3+mnU06umoEVvoiyniD0hVjOkLh82CYDGgdKQIeXwz1h1V6Dc2Bl
         3dISlpfQ6Kavjre1F6YgmydOrLQBVT8a7C87G6VR2I6RchpvNMBEq808CjJPXCgQkOje
         NPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766069998; x=1766674798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr6x/FHZNy2BKmBuWTvABEu0BkQWH32tUpuP8BZZdQI=;
        b=L1nlpxzwZHsefBfm0uCjIXwQYxXG4ISN0/EyEgLe+18vf0Fi3bpjelusRCIcDddOKw
         QXapgryx286ghN+QwMnLoYxH2f04+2lJojQOPVfa6WNUv0n2MrgJUB6jUA/ZlNVAs77v
         xyQxkUb15hWtMV+U8pGSHeTO8VPqkYOdlUoSkNckt++hls6Ea+ozjlPR3f2j9OSRPb+3
         hMMOdaaI+Z8SLCiQd/2mZIrBPNMq+zTJwAlFZ7VZq+6cX4obSCRHUY3PXwnQaMQ/dKqf
         BrX041uGBcHNgzlBoT/QEtt18kn+MGEFQiSwE36gI4Lh56clG0L8rAeb63Z+UtyNYjyk
         Gy9A==
X-Gm-Message-State: AOJu0YzNsQMlCKVC4t598Lqvz9R0gFYNzJHJtQi+Li98++P/Z9mkyzfe
	/fN2Turzu96wLNft4jOg/4vvo591ChsTbbSsMK+PXwi0Y+IqBq+YCkgzncnykAqAju4dPnyRuBW
	cs7yB/DIJcIV+9VfoxaqM+Fqq908OzR/b7ER47W/4fUICiFbR6h33BFwdOQzEMA==
X-Gm-Gg: AY/fxX53M6Fx0neN/jOQmnQVrlp6ysekHecAnogyWR32AppU+5M4WRGz9yJBgAFoaEv
	QNbLU1pYfAnk9uJVLsoiNGGr5pvPa7ODrg8FZzEVy/75DydvRcNy7PLUvWxxMNcy0Tvwj9Zn8kw
	HaucQ38bmsbpjk4BjQXwagUg4TbbXP48Xs58VYNh2DrqHNnkti9LR5OOIeR8y0pE1Qkw27h55wh
	zS2aDTOGZH5EqMgGQ3VryFgxr7RU73MGaZIR6TVyG4iQEYCRlcHrEvlkBcwXzCC3vO8Au4R2FHP
	Ww4vcJhenVmagZ3ntBOHZ0USaNtpVMxbLRmiWOdqYDeYkCCKXvxR5/smwomcoZ2Iv4aUIRBd5z0
	JqG+FIBhZHE4Px0GVaTVTfkXwbZsphpBsve7igKbI9dtikSJiutkCqa/X2MKO96VeWg==
X-Received: by 2002:a05:620a:c43:b0:8b2:e5c6:b4a2 with SMTP id af79cd13be357-8bef2348e2fmr288593785a.1.1766069998458;
        Thu, 18 Dec 2025 06:59:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdbJaaEQGTSDHRIBxUjseFJ7FtDsKJ+MMYtyNHiM5OM/Tdv+vbo7kLGv97qZkIXFwVzKKyRA==
X-Received: by 2002:a05:620a:c43:b0:8b2:e5c6:b4a2 with SMTP id af79cd13be357-8bef2348e2fmr288587885a.1.1766069997854;
        Thu, 18 Dec 2025 06:59:57 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b585d4a85sm2706715a12.12.2025.12.18.06.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 06:59:57 -0800 (PST)
Message-ID: <acc02791-1828-4578-8a8f-ef3d6824cdbf@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 15:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] power: supply: Add driver for Qualcomm PMI8998
 fuel gauge
To: David Heidelberg <david@ixit.cz>, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-2-dd3791f61478@ixit.cz>
 <5d6c3dda-71cd-4684-8546-bc4918b560de@oss.qualcomm.com>
 <d84c25d7-62c7-433d-9978-dd6b20f5681c@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d84c25d7-62c7-433d-9978-dd6b20f5681c@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: czUFOQ_Ehc8aiIGDFbC3H-esY0oqrUYB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEyNCBTYWx0ZWRfX3n2TlvZ2vK+W
 SU9s3KE4/lFiBHGMpo6KeAwuqOJdLkd9RSAo6pAKyWADPPUdXWl1yuTKEGNciZCn+ZeDQ6R1713
 xDd0Bq4kPrZ38sB/2Itxfrv4GvUsGOSrRZ309qZT5y2sQ2588K2jBQzwTvn8/w+yjp1hL2FnrR6
 9lPDQxejIxfgitvGXXArapXa/mXJysV4D2aEZDFrBv6GeA8yWidVgXUAtQdpnwIKX49uDC4Acgr
 4dwwhvMiftHtrbdvvuBPNM720S9A/eXHOWJGL/v7UKYgsNAcaBcMMCncOKN4LdjBPlr/yrT7urf
 uv/A3M6+ruhD/s9yKUw3+7zP+B7pqXAz8bilCVVc0khE6L1CX1rUXpHJQCPYP+i2QQkD0qCd+L6
 u4vaoIsPv/920sz4seJA1xqrDA4gRg==
X-Proofpoint-ORIG-GUID: czUFOQ_Ehc8aiIGDFbC3H-esY0oqrUYB
X-Authority-Analysis: v=2.4 cv=A6Zh/qWG c=1 sm=1 tr=0 ts=694416ef cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OQN141zOAAAA:20 a=WFa1dZBpAAAA:8 a=KKAkSRfTAAAA:8
 a=HXtEcHK5oMWiseVRQrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=MZguhEFr_PtxzKXayD1K:22 a=cvBusfyB2V15izCimMoJ:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180124

On 12/12/25 4:22 PM, David Heidelberg wrote:
> On 27/11/2025 16:28, Konrad Dybcio wrote:
>> On 11/24/25 10:53 PM, David Heidelberg via B4 Relay wrote:
>>> From: Joel Selvaraj <foss@joelselvaraj.com>
>>>
>>> Ths driver supports the fuel gauge hardware available on PMICs known as
>>> 3rd generation fuel gauge hardware available on PMI8998.
>>>
> [...]
> 
>> Downstream checks if the address is > 0xBA which is what you want
>> at least for pmi8998
> 
> My downstream [1] checks this value.

https://github.com/LineageOS/android_kernel_xiaomi_sdm845/blob/lineage-22.2/drivers/power/supply/qcom/fg-util.c#L434

I can quite surely tell you "> 0xBA" is the correct condition to check
for.. both my work laptop and a downstream clone on my SSD concur that

> 
> [1] https://github.com/LineageOS/android_kernel_xiaomi_sdm845/blob/lineage-22.2/drivers/power/supply/qcom/qpnp-fg.c#L760>
>> You can de-abbreviate this to 'secure_access' (not to be confused
>> with 'secondary' or so). There's a locking mechanism which needs a
>> 0xa5 byte written to the base+0xd0 register (applies to all FG
>> peripherals with the 'last non-secure register' value possibly
>> varying).
>>
>> [...]
>>
>>> +    u8 sec_addr_val = 0xa5;
>>> +    int ret;
>>> +
>>> +    if (((chip->base + addr) & 0xff00) == 0)
>>
>> The 'fuel gauge' consists of:
>>
>> FG_BATT_SOC @ 0x4000 (state of charge monitor)
>> FG_BATT_INFO @ 0x4100 ("general fg minus SoC")
>> FG_BCL @ 0x4200 (battery current limiter)
>> FG_LMH @ 0x4300 (limits management hardware)
>> FG_MEM_IF @ 0x4400 (DMA engine)
>> RRADC @ 0x4500 (today handled by its own driver)
>>
>> and a couple other peripherals that Linux doesn't need to worry about
>>
>> Each one of them should have its own 'reg' entry (which is assumed
>> to be 0x100-long), which will let you skip such interesting checks
>> and rely on the regmap framework disallowing address spillover (or
>> you can just then make the addr argument a u8)
> 
> Sounds good.
> 
>>
>> It would be good to keep in mind their relationship and think about how
>> to model them together. I don't think they must all necessarily be part
>> of a single big "fg" dt node, particularly the LMH/BCL part seems to be
>> rather self-contained
> 
> Would you recommend some readings to prepare for this task?
> 
> I see the FG_BATT* + FG_MEM_IF seems to be pretty relying on each other, so I assume I need to take good care of that relation, when spliting pieces up.

It may be that a single "fuel-gauge@" device node may make the most
sense to represent all three of batt_soc, batt_info and mem_if.

You'll unfortunately find out whether this is a good idea as you
write/port the drivers. Downstream has some hacks around plumbing
various PMIC peripherals with just function exports between drivers,
so don't read too hard into that, just try to understand what each
piece/function is doing and how that fits into the power_supply
framework.

I'm a little unsure about bcl and lmh.. but downstream keeps them in
a single node and it doesn't seem to be that bad of an idea. There's some
LMH support today in the kernel.. but not for the PMIC peripheral. That
said, the downstream driver seems to just make the same secure calls
anyway (which may be incomplete for some platforms, I don't remember the
details: <20230113031401.2336157-3-konrad.dybcio@linaro.org>)

Konrad

