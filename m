Return-Path: <linux-pm+bounces-37794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60675C4F0B2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB8DC4E6D7D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1128236B056;
	Tue, 11 Nov 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJqm5J0U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwQTtceA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0A273D77
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878669; cv=none; b=GShTgXuc4hRGEZFrbvRj2i4vFPnFp/zWYfLQ2pYbH9DbWZ6M8/VJIEN3afEVOP7UJyE8fg1I/EUlbaYZJGW8t29A4SAu0Bqyf1k/RNLXv1NvIoucNMLsVednLsHOrC3UT5WFnuh8qJ1q+H8Xm7+zGQtmG5Ps8aCSCxhGP5CfbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878669; c=relaxed/simple;
	bh=OJVRQOjbGEHZBlcMjkrNzy8hq9YQqSg/EQiWaoSvWZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqPmdfnPH7pWgakHFZiF8qWb0iOpnIFLFMvKbAVRO1qBXjZZJBOE40yr3S6vjOiXhH/Zhkk3gv7jk44lEjFTr0BRNBXqaKvBOHghCwBV9KybUc2BZR+tNSaIL+G7e2tiSsoUKWEYSEppYl+qdWHFBmvanBR5YIVxgLMCT+sTbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJqm5J0U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwQTtceA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGC0b2250220
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 16:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bybkeY6YUl5SRT8XBgV3JMBrtdGGNVKGQ7cbU/fM7qs=; b=HJqm5J0UEi5a5w6c
	2h2wjqqxl9Bb6xdP7WBZHOENjyQg6NAS8ZraEiQfplfJPowcHFtqCp0Wre2NBBoT
	cqV0GSGULoLkhibkRsrET6yst7N2pYt7ak4tT8qeaBYN1tJRPMKJvO3rswprUSNk
	oJW+ldLEo26WFG+tl+7dDHNkChqJMWVreWbj8PYjXnUZjNrYJuFFy6LBHSka8qF2
	GdSzT/ZHRE7aGSCZYdCTS2lXRBcC4wrLY4vjsosnF6IxBCBTCzT5lvplt2IDM78/
	qQU8t14bNB3+S19tMUWIaTKJ9D4O5mUcikbxYrpAgaLRk8zATxQHRjXKIIk2Myn/
	lPQsSQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxxu9wp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 16:31:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso9103266a12.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 08:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762878665; x=1763483465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bybkeY6YUl5SRT8XBgV3JMBrtdGGNVKGQ7cbU/fM7qs=;
        b=SwQTtceA68YbH4Ptn5o3yFDPaKptnahdVEdosDKaxRPHNlZxCh+dYa5gedbYwCpDXq
         t38KfxhkHabqxQiul5dIJpv0qxQTYM0x1dHNVuy9AjXLZDNED/bPeE3JB1hgTDmC4cTZ
         xyK1hmSInSHx+qdRUJCku6tHSaNo5lv48XjVA09p4qfFe6c4PbEoW6jaEvqpklDfPCLc
         CFMcz9aRHWtObXKbBhw1i8WYzo62MV4Io9M4REl2/GcOV0TVlk/nIt8ZSazs7aMKg9VP
         pzCupoKWsxbYxcwmSdjXQQgctqZso+wrIgK4cGIcA6eVMh25pNuLKmU3oZgAo18oH98F
         5scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878665; x=1763483465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bybkeY6YUl5SRT8XBgV3JMBrtdGGNVKGQ7cbU/fM7qs=;
        b=HwWL2ZOAv5r0PHyuqmktJxEBOn5m+6d6b98IkfZQeR2UHBle0IgAlT7OVDL135X/sc
         IZ1+B+c/sKa6lJNhZGxlzRsGu+YyaEK8OwSQd2Bap92cD6x4C5L+zRsV7Gk7P8PDrUPF
         FuRBAdbK8kqjEuk1UVw+dye/XbIaDllPg6xu6YrZyQXK6ijRlXeFFG/PzKC7Y+Ue+FbY
         1zmuBvoQ38l8TbnPV47868c8kx8GQJgiR5FhA4lIADro0V18FY9uRUKD91uGXBuAtvwG
         LTDFPJx0yRyQ6r2UWl8kmeBxbl4u24p0QDZLgIst0/vsvhfAlpm4EPWIVWCuyeEbBnpY
         3awA==
X-Forwarded-Encrypted: i=1; AJvYcCXpo111W9zNrn9nkeE0J7NvU1N1UirAqjiMePDNVNbJAJFpPiokasBEUb4e+wwqWRHM0rvDgibE0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Vl+gDx9MCdLrCVnInGdV6kWb2vQFiUz6TnreYIa4CcFwzeiT
	UztSNqfe6UvxiGYFzdpt1Fa2hVEBY8N7AQRcoogJ+YbBJLDFXlPAaar4hzVs0AeOGKNcAKmWPM8
	WnxyFuguqKLWEMzWaB6tyhyveqhH4SQ69fPHG6lxk5BOKCFEih51w4RcPcxihww==
X-Gm-Gg: ASbGncvxyiBXVKjtKnQcsZeGNgNgj/ySnn5wDOnDlo+Jj4zqX2LPXExDkCj/I/7g4gz
	DctK5REZIqkKzr3zqo/PwYI5pV9e5LhTti6CTEdxg8Inmsc1K9DDghpmNpI690r9lrVvGt0Gg1Q
	eJjNyRt3jmK0w6SeZf9qMf8nR/b8TvHx/Qx+JvthjRUHnJx5ekiJzl+JcPkbleeNrmZaA5L+CrC
	ui6xaU7vBTpsXBg023pC2phbnceYBGzbmA7M1rWfDhDpxJx2lzjn8IcRXhGqSO8kGkXgSVC0xan
	xAwkInB8GpQ1dhll45ZsXdUWvx270wOEbWsx3zsxkYXthfv0oZvOfLPykUGwCot9MDRBX/ib+e+
	Y/ERGyZFz3UXMvx89qBo1Futq2a7xyZeX
X-Received: by 2002:a17:90b:3a91:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-3436cb7bcfcmr16607173a91.6.1762878664801;
        Tue, 11 Nov 2025 08:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK0C7zoIdCCrbSGtOR2lA7hiOGv0VrSOdA1mvOcJK1ts7OjzqJ7ukZDrIrLaxwld0WkX5Shw==
X-Received: by 2002:a17:90b:3a91:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-3436cb7bcfcmr16607120a91.6.1762878664213;
        Tue, 11 Nov 2025 08:31:04 -0800 (PST)
Received: from [10.216.22.22] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343685301f8sm11854378a91.5.2025.11.11.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:31:03 -0800 (PST)
Message-ID: <bdbe4328-aead-f59e-2ee8-7fe12fc83506@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 22:00:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 03/12] power: reset: reboot-mode: Add support for 64
 bit magic
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
 <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
 <gzj4r4elqewjt2gjzhuamslvobz5fgyvt672brwknoozlsplaq@wsebzmi2l6pc>
 <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>
 <zejaqakbtufwzlzs7xc7xzxezcylqjkmu4nne2mro4riuhgbkc@hlgu3u2w36bb>
 <5c83c9a1-e123-95bb-1434-588ee8c52b25@oss.qualcomm.com>
 <axle2c3i3vfyxpql43dqb4zwzjj65xhsjuhojyf5x26wqo352v@z3nwctubwanx>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <axle2c3i3vfyxpql43dqb4zwzjj65xhsjuhojyf5x26wqo352v@z3nwctubwanx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEzMiBTYWx0ZWRfX2NFuCqqrVNfe
 5Y3nDAeoWWJ7B5FkhuK2ODXSbPC/ZahukLQBQfM8GVPT5gmSlk8z8J0uJRoI6iLW4n8xpqV6T29
 xgq8eOdBt2zfSvx0Le1jIvJMMSFPsiA3JSH9Ve5gTzIhxAAmbzDKZ3jYn0qoOpKSj6S+prkkYYH
 1IlPkZIYGu5L2P4g/A2yeZ9vGrZVVwf5Cnmhs570xbHrL/fkKeeFKREkZLziWiimH8RUrd94Yx2
 R3toS5Jzdfk721kSzwXsdcwzzX9jtumZvOvmnPQYyGlpWV6TnWC76uY3sQl5SrRvD5GFCzej+o5
 3trB8dy6tVg4FmGGAhBnv6vcXVi3B79yUKMaJTS0lIBNkKm2kIdz2U3mVmViRhlViv1TnTm7e6q
 F17WQt26gPNTCTVrtXGYMfT0HkIHrw==
X-Proofpoint-GUID: VBIUNsdEqZIM-zXnvbAtQvTu5ZaxDg9f
X-Proofpoint-ORIG-GUID: VBIUNsdEqZIM-zXnvbAtQvTu5ZaxDg9f
X-Authority-Analysis: v=2.4 cv=TfObdBQh c=1 sm=1 tr=0 ts=691364c9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5lduEm2px6IFDn4QHGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110132



On 11/11/2025 9:55 PM, Bjorn Andersson wrote:
> On Tue, Nov 11, 2025 at 08:20:43PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 11/11/2025 12:03 AM, Bjorn Andersson wrote:
>>> On Mon, Nov 10, 2025 at 11:22:40PM +0530, Shivendra Pratap wrote:
>>>>
>>>>
>>>> On 11/10/2025 10:00 PM, Bjorn Andersson wrote:
>>>>> On Mon, Nov 10, 2025 at 07:15:29PM +0530, Mukesh Ojha wrote:
>>>>>> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
>>>>>>> Current reboot-mode supports a single 32-bit argument for any
>>>>>>> supported mode. Some reboot-mode based drivers may require
>>>>>>> passing two independent 32-bit arguments during a reboot
>>>>>>> sequence, for uses-cases, where a mode requires an additional
>>>>>>> argument. Such drivers may not be able to use the reboot-mode
>>>>>>> driver. For example, ARM PSCI vendor-specific resets, need two
>>>>>>> arguments for its operation – reset_type and cookie, to complete
>>>>>>> the reset operation. If a driver wants to implement this
>>>>>>> firmware-based reset, it cannot use reboot-mode framework.
>>>>>>>
>>>>>>> Introduce 64-bit magic values in reboot-mode driver to
>>>>>>> accommodate dual 32-bit arguments when specified via device tree.
>>>>>>> In cases, where no second argument is passed from device tree,
>>>>>>> keep the upper 32-bit of magic un-changed(0) to maintain backward
>>>>>>> compatibility.
>>>>>>>
>>>>>>> Update the current drivers using reboot-mode for a 64-bit magic
>>>>>>> value.
>>>>
>>>> [SNIP..]
>>>>
>>>>>>> +	if (magic > U32_MAX)
>>>>>>> +		return -EINVAL;
>>>>>>> +
>>>>>>> +	magic_32 = magic;
>>>>>>> +
>>>>>>>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
>>>>>>>  
>>>>>>>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
>>>>>>> -				 syscon_rbm->mask, magic);
>>>>>>> +				 syscon_rbm->mask, magic_32);
>>>>>
>>>>> As above, if we're no longer silently discarding bits, I think we should
>>>>> compare the magic against syscon_rbm->mask.
>>>>>
>>>>> No need for a local variable, just type cast after checking the validity.
>>>>
>>>> Trying to summarize below why we added these check-
>>>>
>>>> the patch in v11 used typecasting and did not have any of these checks(link below):
>>>> https://lore.kernel.org/all/20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com/
>>>>
>>>> As per below upstream review, type cast was removed and bound checks were added all-over patchset:
>>>> "As a general rule of thumb, code with casts is poor quality code. Try
>>>> to write the code without casts." - 
>>>> https://lore.kernel.org/all/8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch/
>>>>
>>>> We can revert to the typecast way. Please suggest.
>>>>
>>>
>>> Okay, I'm okay with Andrew's original request, stick to that for the
>>> nvmem case. Although I don't fancy the name "magic_32", and would prefer
>>> that you just call it "value" or something.
>>
>> sure will make it proper wherever applicable. 
>>
>>>
>>>
>>> For pon and syscon however, I'm wondering why you have ignored Andrew's
>>> other request from that same email:
>>>
>>> """
>>> You might be able to go further, and validate that magic actually fits
>>> into the field when you consider the << pon->reason_shift.
>>> """
>>>
>>> Writing "if (magic > U32_MAX)" in a snippet of code where magic isn't
>>> allowed to be more than either 32 or 64 is misleading.
>>>
>>> For syscon, it's true that the parameter is an unsigned long, but the
>>> actual limit better be based on syscon_rbm->mask.
>>
>> May be i was not able to interpret it correctly. Basically tried to
>> make sure that magic that now coming in a "u64 magic" should be passed
>> ahead only it its a 32 bit value.
>>
> 
> That is the correct interpretation of the original ask. But what I'm
> saying is that if you write:
> 
> if (magic > U32_MAX)
> 
> then that means "check that magic isn't larger than 32 bits". So the
> reader will see that and understand that magic can only be 32 bits.
> 
> But the actual PON magic value is 5 or 6 bits, not 32 - so you should
> check that the value fits in 5 or 6 bits.

sure. thanks.

> 
>> So should i get rid of the checks done here for syscon and pon?
>>
> 
> Continuing to silently ignoring other bits would be one option, but
> you've been asked to sanity check the values, so please do that. You
> have the code, just compare with the correct value.

ok. got it. thanks.

thanks,
Shivendra

