Return-Path: <linux-pm+bounces-11148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15A932646
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9693A1F21B3C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82B19A28C;
	Tue, 16 Jul 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmgPLFZR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAA198857
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131828; cv=none; b=RuGUAC0fEWI1s6a71EaqCVfB+VRZ7Ovh1jbSR7MvhXBVwcy/reiEquxTA7f9gR8X4wDIVPxwypWeLi97YWNKlYdf/lqQhncHPsbnLKfDeq9DEG3w5EbnI+IuRxoSi5PFF346ytkaSMfT8eRpTgve90NVOk6c9zojB6kW0fH0rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131828; c=relaxed/simple;
	bh=jX7WjWzGTWvX2ra57HcR0LmSTOXNIpNypG8ZJ/uqpz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doxokiwRLEuvngeXrXFb5BhMv+L3aa9i4DKKmRDcR968SB+mmN5Q+DGim9Md4Zy1cUdTZVpl+SwLh2nY8mNII6lFUC3Y/Lko35bmQUGspTbHXHPOdFqqxn06w4ClgMk4LxkU+Xpzk9opZeZ2e7U2PeQkBpbMDP5mSsPQpcGwwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmgPLFZR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36794da7c96so1454506f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721131824; x=1721736624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8M7XkNShPiZntbZSKCIEKfKzlbdchBfyfDOGijdarc=;
        b=xmgPLFZRmfs/4aUcADzUwrJdAdMpoeaAo5RQBnmUwf/X/e1v8Ij+ZaWXktpJ3T0zBp
         VOXlD8meTaJFMqDx0Zq8CUyhwoAHTQHNFZR1wSPzeclV4Zcfn2g+jEqahOYpBT9tZqsn
         ZBpcKuDa4BLtF8jLAg7cYXo4gDgKzdNELzU3PkSF/S6cXNtLek/mRSvQjrh5vPVFqHiE
         7dUnEgWifUKhAOoz5Xj9mI0T337fGAljem61hIzBV7k3MXnHIYWW9oJbVmG7UKnpNrhh
         B89Jng/nCdV4ZWpIsiBUYeFN3RAS4V95ZBSiCF1+fKaODtETDNrxDZICOC9i+us/o+v1
         82aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131824; x=1721736624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8M7XkNShPiZntbZSKCIEKfKzlbdchBfyfDOGijdarc=;
        b=vviotmLhs87fQNAOQDAYdSR/fXtsPQFN3j5sG7tRQF7uDJBSbxFfxKgwICtACie/6m
         Ku3DZX2kBFRc4N1dexA+lF4j96SNU+FQQjKexVtuvHkCsl9TgvGqzGQGWvMcpsXeJjdD
         wBFHlotFCiV33wx2mSC2BqBSPcJKoVELfsaEgUFG4uQB+IwiEK12vfjSZXadNH8l9sbC
         8DxcZWuVOLu461aml3DauuJtp+sV/O4kHrN8+07zLSjclfXZhdRv8q3fqGaSXSDyy+Ac
         1d9bhJYlt+HmenpF9NvLxDwny3ywbusBmznnhPlzurHGWKzFeDkSkXiTOB5fPpB8bpvR
         6H6w==
X-Forwarded-Encrypted: i=1; AJvYcCUmoJtq9puKe34U9WSitF9lizloIxRVjgnv33M/k15eam9odLEzM6tHXDAzzNLJH+DVsac7l4EKojx+mYk99ny9vprjtiEn8dM=
X-Gm-Message-State: AOJu0YziHEz5qJJSow+r11/dYLvN5VzdDaXmqmXn/ArnrV52LbN2F2e9
	a5dpy9dOGT5gwyDfQlDwoWuoO80cS1Q5Nn/07vTpsclHAzzMUvR8Q50eOvad138=
X-Google-Smtp-Source: AGHT+IGGMmtkRSegLHXvzl8/bHmzFA87wfV0q/Ta1cIwIqQ1Gk5Vwh6w0qsX5zYDH19AXcj8PSxkNA==
X-Received: by 2002:a5d:4acd:0:b0:362:d875:6dab with SMTP id ffacd0b85a97d-3682610811emr1265416f8f.25.1721131824366;
        Tue, 16 Jul 2024 05:10:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5abd:5899:c977:d551? ([2a05:6e02:1041:c10:5abd:5899:c977:d551])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dabf195sm8799734f8f.42.2024.07.16.05.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 05:10:23 -0700 (PDT)
Message-ID: <3238291f-9d2a-4308-98fe-4765d7e1bcfb@linaro.org>
Date: Tue, 16 Jul 2024 14:10:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: Eric Biggers <ebiggers@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
 <20240715044527.GA1544@sol.localdomain>
 <4d7e11a7-b352-4ced-acee-b5f64e3cd0b6@linaro.org>
 <CAJZ5v0gx6GyKBYt7YMFwmUQ4OCG49d9k2H=P-4Awr-mJ=eFHKw@mail.gmail.com>
 <20240715145426.199c31d0@mir>
 <CAJZ5v0gPiwkNczZhCf_rkxVoUX33tS9c6irMf_7=Rg48Nw9C4w@mail.gmail.com>
 <20240716014830.243bb0cf@mir>
 <CAJZ5v0jkA72=avuthGkrS5iu_UGEQeaEp7LjedXCpzamcnRKsA@mail.gmail.com>
 <20240716125538.09f716d1@mir> <20240716131500.35cf4f00@mir>
 <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0j2w-8c83Lw6OdJGg53pOKQMdeWiwaNkEEThwE6fXLiHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/07/2024 13:36, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2024 at 1:15 PM Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
>>
>> Hi
>>
>> On 2024-07-16, Stefan Lippers-Hollmann wrote:
>>> On 2024-07-16, Rafael J. Wysocki wrote:
>>>> On Tue, Jul 16, 2024 at 1:48 AM Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
>>>>> On 2024-07-15, Rafael J. Wysocki wrote:
>>>>>> On Mon, Jul 15, 2024 at 2:54 PM Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
>>>>>>> On 2024-07-15, Rafael J. Wysocki wrote:
>>>>>>>> On Mon, Jul 15, 2024 at 11:09 AM Daniel Lezcano
>>>>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>>>> On 15/07/2024 06:45, Eric Biggers wrote:
>>>>>>>>>> On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
>>>>>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> [...]
>>>>>>> Silencing the warnings is already a big improvement - and that patch
>>>>>>> works to this extent for me with an ax200, thanks.
>>>>>>
>>>>>> So attached is a patch that should avoid enabling the thermal zone
>>>>>> when it is not ready for use in the first place, so it should address
>>>>>> both the message and the useless polling.
>>>>>>
>>>>>> I would appreciate giving it a go (please note that it hasn't received
>>>>>> much testing so far, though).
>>>>>
>>>>> Sadly this patch doesn't seem to help:
>>>>
>>>> This is likely because it is missing checks for firmware image type.
>>>> I've added them to the attached new version.  Please try it.
>>>>
>>>> I've also added two pr_info() messages to get a better idea of what's
>>>> going on, so please grep dmesg for "Thermal zone not ready" and
>>>> "Enabling thermal zone".
>>>
>>> This is the output with the patch applied:
>>
>> The ax200 wlan interface is currently not up/ configured (system
>> using its wired ethernet cards instead), the thermal_zone1 stops
>> if I manually enable the interface (ip link set dev wlp4s0 up)
>> after booting up:
> 
> This explains it, thanks!
> 
> The enabling of the thermal zone in iwl_mvm_load_ucode_wait_alive() is
> premature or it should get disabled in the other two places that clear
> the IWL_MVM_STATUS_FIRMWARE_RUNNING bit.
> 
> I'm not sure why the thermal zone depends on whether or not this bit
> is set, though. Is it really a good idea to return errors from it if
> the interface is not up?
> 
>> $ dmesg | grep -i -e iwlwifi -e thermal
>> [    0.080899] CPU0: Thermal monitoring enabled (TM1)
>> [    0.113768] thermal_sys: Registered thermal governor 'fair_share'
>> [    0.113770] thermal_sys: Registered thermal governor 'bang_bang'
>> [    0.113771] thermal_sys: Registered thermal governor 'step_wise'
>> [    0.113772] thermal_sys: Registered thermal governor 'user_space'
>> [    0.113773] thermal_sys: Registered thermal governor 'power_allocator'
>> [    3.759673] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
>> [    3.764918] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
>> [    3.764974] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
>> [    3.769432] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
>> [    3.873466] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.0 cc-a0-77.ucode op_mode iwlmvm
>> [    3.907122] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
>> [    3.907886] iwl_mvm_thermal_zone_register: Thermal zone not ready
>> [    4.032380] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=0x10a100
>> [    4.032392] thermal thermal_zone1: Enabling thermal zone
>> [    4.098308] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
>> [    4.112535] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    4.128306] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
>> [    4.369396] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    4.625385] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    4.881416] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    5.137377] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    5.394377] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    5.649412] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    5.905379] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    6.161380] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    6.418381] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    6.673381] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [    6.929377] thermal thermal_zone1: failed to read out thermal zone (-61)
>>                 [...]
>> [   21.009413] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [   21.265496] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [   21.521462] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [   21.777481] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [   22.033468] thermal thermal_zone1: failed to read out thermal zone (-61)
>> [   22.213120] thermal thermal_zone1: Enabling thermal zone
>> [   22.283954] iwlwifi 0000:04:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0
> 
> Thanks for this data point!
> 
> AFAICS the thermal zone in iwlwifi is always enabled, but only valid
> if the interface is up.  It looks to me like the thermal core needs a
> special "don't poll me" error code to be returned in such cases.

 From my POV, it is not up to the thermal core to adapt to the driver.

Usually network devices have ops when they are transitioning to up or 
down, would it make sense to move enable / disable the thermal zone in 
these ops ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


