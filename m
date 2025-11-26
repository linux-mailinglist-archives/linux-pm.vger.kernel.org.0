Return-Path: <linux-pm+bounces-38738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363BC8B57E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586B73BDDB0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B556328272;
	Wed, 26 Nov 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cT7W2fXq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EHl+qfC5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE476315789
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179004; cv=none; b=Vq31oIa5J4OClE5YleZariPffU+HVod8nlKPLM89jnmSRMO9oQvlHHOgNImHcckXKLJ5R1PQ4bNEYfDC+FkxY1iiFxLs7+nqsB3/RRI5xrDd42oiog5XJ34WC7/sa4/19ehu0vO6DqW7mSODu6ILMCdb6mqEw9j9WktarxlkQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179004; c=relaxed/simple;
	bh=Dbd+U+20t5jh3oo5fqXo2LWhcFGP1dtMaiMN1N4Ea2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9UWV5winf/QtaX3/vvsTvU2S50KPo3gdJB8WpuS6IdpXZKSpD7kmnHvFb+cTIxNHxYP1Db+hPtZ5KSi5evSXKHYDee+dffNIb6RXTnrj28Yw4oeD6ozUy0BX61K/jdz7a2z5ECEtkPMwGXoYjFfrQsaY5GVwsqhflb+J+Csa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cT7W2fXq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EHl+qfC5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQFMH7E3738420
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/4C1ziBJx+mjYUbjAmhSYYfbHlaOdGG35KslyrE3v6A=; b=cT7W2fXqRsVUJVhr
	soy3LpKx4+EudPDBbmHgPxQC658fh1GhRt3sz0AtOpj5oAlo2lsw/IvKlUlmMLvq
	9jpZi1PA4ZSz+vkCu7/euX6E9XelQAyIr1Qlmi5sbXlJTIAsPom3kppk35kT6D3o
	3JgSjtVyPxVE2bo9+QtsviFVMUc4FoWuvCz1BKFp0V/AiJERp+JR91wgboEHUTcz
	jthMGHIxQwe1BrkYD3b3W/9k3+7Yo839uA7u0IuA2VuEQ76xW2Jipsmyxo799EWY
	XFvjAoNOV3q8jymyoQAFrdRW8HkmiHMA6Xyow/IPuP95CwPfm3YJ306ePs/+NyQB
	RKkwnQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anggykptb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:43:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b9208e1976so14399784b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764179001; x=1764783801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4C1ziBJx+mjYUbjAmhSYYfbHlaOdGG35KslyrE3v6A=;
        b=EHl+qfC5aXz3Q2q1jWQOr2bKLMiHt4sD5B6Qq3J3pt+5eCBdXuhz8XU0ENb7wgMsff
         /l4HFhU/26spOGfAlokZzWMjFdUHyjqlQ2xy3eLwbwY9hLGACvbFQoSlmf5k1MlCCM9+
         Es0Khzh0XToW7B242Ukhd5wEEAjvhPgoQQmdYJXHTYvLoOwP4K+RD4dAwCJKx89vlLCH
         NI5kQXYNUXHMUvhR8aAaGVZx/BYOGlt6cYFzq4CIy9yZpAIugs8MYahDzWVqgj4Dp8IJ
         FHCj+oidKIL8p6vnj1rnvCeZUxQPAfkV9JSFsLRCK4dec9icpBqFWjjWJrUegv5Z8X0t
         k3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764179001; x=1764783801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4C1ziBJx+mjYUbjAmhSYYfbHlaOdGG35KslyrE3v6A=;
        b=C29qYENNMyumnr/52JqSMREphcv1Zi/pm2+LajegE7Md6VAMVwk7BM96HOj3Q1iD/5
         dqqYhtQfr3TjYTdKE1fZ7nZ7YDVqBH/fEpqJKP0ir4wNp9O26WDVFdohmkC+93SZVEWX
         en4AD5y3mKC2Qicrq7d/6WzlqJNRPl2wIcvv30i0tUlaVUp1UO6LpfVAn5Viwgc8JsXN
         BMZyNPGg+P0F8sHUhGXj6zZbscli6D5yaMbh9panc8TVFbh0X6NZUdT5HNJI93Jt015D
         kswuYIXaKbc0duUPQ5zySSi8HHCtL4vfaNAWCEYf/bCVyTbw8YAd7VDhJj6RwefFy6cX
         HsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5/xpysT2HUjaFHXobW1M47WxUkiLoqpKz0N+TrDNvf+T0sgqWTSrJjpB4PmYSbd1Aw0TRXmf6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZSmjOP5X+D8TmYtLoPYi1nSOMcIybtb6xoFvEOG5vJ/VyxeS
	CCQFLo8mS411m7GhDfyVj7LqCAGHc1DzYSBvLgjb+GNsgXGq9FGzVmGXQp4lD/J5Hueb4nLMmUC
	Apq4RCAqNVhSuCRgHO4JFt2+gTj4OTlgBDY4fL8GKyCVEbJlr/4koLOyZlWYskQ==
X-Gm-Gg: ASbGncu5PcTicyxUoMLsIr0MvK1gCT4P3EcS012SSRkxnqkr1hYA3/F52UPBL8HUtky
	KYA8hxarr2yzlxQnJHX96R3sFtjnxVVWCdDMCQco47C/XTzCLvDUpi4TFzDDn3BrKjHgFfAhdaa
	Agz+7l3IDrdtfFlt8XI+QVrYsXRARAlG6/HXcMQxBDvD5hXv1VsYnLoNXiI2QSe0R/QNzG9hm/F
	Gastx6oZOWKzUpoy8/faPyTZllJfTTqnt6PyTzzRJdyjqgWJdt0v/Z+H3YUyoBQ8TkXr3Pt6jn/
	e7VHZ14OkwF/iEXCHvRqaXVWIeNffD/jPToHO4gNzJaIvWTpTfFudAYU0C5uRmK+D3ZluCsVAGa
	ERikOXhA/bG+iQDuzC+6fpv5YIRt1YjVKfaReiVQK40U=
X-Received: by 2002:a05:6a00:2e28:b0:7b2:2d85:ae53 with SMTP id d2e1a72fcca58-7c58c999ebfmr24059808b3a.8.1764179000438;
        Wed, 26 Nov 2025 09:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE9auC0BPVxJ4KxcFP48LwF0xTVOASw2feRr55RR8ZX+bZHEyVlBeSIXXDN1cl0ZFO26GaMg==
X-Received: by 2002:a05:6a00:2e28:b0:7b2:2d85:ae53 with SMTP id d2e1a72fcca58-7c58c999ebfmr24059760b3a.8.1764178999869;
        Wed, 26 Nov 2025 09:43:19 -0800 (PST)
Received: from [10.216.6.208] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed471022sm22183967b3a.21.2025.11.26.09.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:43:19 -0800 (PST)
Message-ID: <acd1b134-2c8f-af01-0de9-d9779dd2ebdc@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 23:13:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 07/12] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
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
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
 <aRIfc9iuC2b9DqI+@lpieralisi>
 <80e68e44-a8e0-464a-056e-9f087ad40d51@oss.qualcomm.com>
 <aRxmWrAkD0Vu4pF+@lpieralisi>
 <1da024e7-efb1-3a1c-cc13-0ae5212ed8bd@oss.qualcomm.com>
 <aR2P4CxQNebac6oU@lpieralisi>
 <682b1a0c-644f-2aff-1860-cbf9a53bc62b@oss.qualcomm.com>
 <aSc2Yh3AvLXOBvcz@lpieralisi>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <aSc2Yh3AvLXOBvcz@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eS7fN4qMH7WfaLci7Wihe4nNaveuzOqW
X-Proofpoint-ORIG-GUID: eS7fN4qMH7WfaLci7Wihe4nNaveuzOqW
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=69273c39 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=aq4WiCt_VBwjG6PfwrMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0NCBTYWx0ZWRfX9+v2FvfxLUk6
 SMyT/z5Y0bWp3NCS7J/uGYpk7FYYJEjZfg4A1aOE09Uflhzx5dBA2JS7zhQ9bzNWy6Gy6vMHImR
 JGpuO/xmuvoi0dXBkIJURNwGZoVXsLGV6B2rgU5xGKB7tBF3q2eUP05c5Qkc4x3VtVQ+T75sNQo
 9evokLxi1AABv2s4SqIYhKsdmvejFf/XE9oPopStzkJ+k0dZ0tgzH5DSDjpjc7ktRDd1Ey0Tq6I
 Ec5t5K7meOg6lJbrRhoxjuvl65d5PW6xJF8tj1X9KwBlazPVd2tJlMwxLYYIt3LhL70+/tn6bhC
 KG1A5CB5juTNWYWt9q69PhFfnMA6C7dFiJfg7aj8PKWGd6kPfbWHz5CNckpTKBGuPypxtaPseyq
 UHClPh6XeqKoiyl0OHP+nAjoovw5sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260144



On 11/26/2025 10:48 PM, Lorenzo Pieralisi wrote:
> On Wed, Nov 19, 2025 at 05:32:42PM +0530, Shivendra Pratap wrote:
>>
>>
>> On 11/19/2025 3:07 PM, Lorenzo Pieralisi wrote:
>>> On Tue, Nov 18, 2025 at 11:11:33PM +0530, Shivendra Pratap wrote:
>>>
>>> [...]
>>>
>>>>> Yes this could be a potential way forward but that's decoupled from the
>>>>> options below. If we take this route PSCI maintainers should be added
>>>>> as maintainers for this reboot mode driver.
>>>>
>>>> you mean the new psci_reset driver? yes. Maintainer would be PSCI maintainer,
>>>> if we create a new  psci_reset reboot mode driver.
>>>
>>> Yes.
>>>
>>>>>> - struct with pre-built psci reset_types - (warm, soft, cold). Currently
>>>>>>   only two modes supported, anything other than warm/soft defaults to cold.
>>>>>> - vendor resets to be added as per vendor choice, inside psci device tree(SOC specific).
>>>>>> - psci_reset registers with reboot-mode for registering  vendor resets. Here, we
>>>>>>   have a problem, the pre-built psci reset_types - (warm, soft, cold) cannot be added via
>>>>>>   reboot-mode framework.
>>>>>
>>>>> Why ?
>>>>
>>>> If we want the new psci_reset to take the reboot-mode framework route, is it ok to
>>>> add default modes (warm, cold) in the device tree?
>>>> If not, then the design of reboot-mode framework(power:reset:reboot-mode.c) needs to be
>>>> further changed to equip this new feature. 
>>>
>>> Well, yes, all it needs to do is allowing prepopulated reboot modes on top
>>> of which DT based ones are added.
>>
>> The mode-cold , adds a third variable to reboot-modes as the first parameter for 
>> invoke_psci_fn is different for cold vs warm/vendor.
>>
>> cold reset call       : invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>> vendor/warm reset call: invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor, cookiee, 0);
>>
>> Each mode will have 3 argument - like:
>> _ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ 
>> MODE   , cold reset, reset_type, cookie
>> _ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ - 
>> COLD   ,   1       ,    0      ,     0
>> WARM   ,   0       ,    0      ,     0
>> vendor1,   0       ,0x80000000 ,     1
>> vendor2,   0       ,0x80000010 ,     0
>>
>> So reboot-mode framework will now define and support upto three 32 bit arguments for each mode?
> 
> The cookie value is unused for SYSTEM_WARM_RESET, you can encode there whether
> it is a cold (SYSTEM_RESET) or warm (SYSTEM_RESET2 - SYSTEM_WARM_RESET) architectural
> reset when the magic value(aka reset_type) == 0x0 ?

sure that should work. if reset_type is 0, cookie to decide warm vs cold.

> 
> The reboot mode parameters do not necessarily need to map to PSCI function
> calls parameters - provided we define that explicitly.

got it.

Sorry for out of inline question - 
So the psci_sys_reset() may be looking like below after the changes suggested?
Is this on track?

if( panic_in_progress() || !psci_reset_cmd.valid) {
        if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
            psci_system_reset2_supported) {
                /*
                 * reset_type[31] = 0 (architectural)
                 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
                 * cookie = 0 (ignored by the implementation)
                 */
                invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
        } else {
                invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
        }
} else {
        invoke_psci_fn(<psci_reset_cmd.system_reset>, <psci_reset_cmd.reset_type>, <psci_reset_cmd.cookie>, 0);
}

------
where psci_reset_cmd is defined like below?

struct psci_sysreset {
        u32 system_reset; // this will be set as PSCI_FN_NATIVE(1_1, SYSTEM_RESET2) or PSCI_0_2_FN_SYSTEM_RESET.
        u32 reset_type;
        u32 cookie;
        bool valid;
};

static struct psci_sysreset psci_reset_cmd;
--

thanks,
Shivendra

