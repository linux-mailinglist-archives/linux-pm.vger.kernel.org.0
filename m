Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11751419578
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhI0N5f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhI0N5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 09:57:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BFC061575
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 06:55:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d6so51966945wrc.11
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFqhaSMzancWCnAnbexHDip4+ntsr4/iV9d3TVQRJvI=;
        b=itEmT4l+CEgWrclpdIM1tX/D2SZWQ920Lre+JttJ/lsrc5BRYUAzIy6M1k94wG4RZE
         wgpR2ErpvfHWY1xpkDpwF/yDcJIwEcrU8owgXUc2kHOI0GIBc6V1+hpOmuAyVnfmUOK6
         IvwQv4+5TqghFStytYz0pF2pN5tqkmA37+FZbOhgLY4JuLngGt7QkwpF8I+voDqIKUdm
         4twX56W69XWH2kYMzt2W9mtCSJl0ycyMLslZf7M2YcTR4s1cxLRomIB3FS/3AXiDPkas
         WrIxSrOST2KXfwbH66ohnq5+K5857VzP7/D6a/zhF08HX0PAgf0o2Jn0cj3DvfWEkzuT
         Dfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wFqhaSMzancWCnAnbexHDip4+ntsr4/iV9d3TVQRJvI=;
        b=VV8S2m6QkFjom+ODs5SGXXnCjUXVraDHkYohq6dybzM1WsKvUs20Ep3qcz7BNcF//O
         0BJgi3Lhlj5mzZDM8URCTUTSpXusZcDvNAHEkn8Lb7lWcswhgZx3+Z6VYMx5XkY+kE57
         MeFgMZEtw+oC5Uz7PmnyH9msjKc/FWDqSLfTIZ64IrBl7Ia+V1G3gDRNTRT11Uvy7iYp
         PhCIvNSFq2T1IMShS5ZLKmqrOou4hJV2yygyNaPjGiUGFU22iUvv4pfTBjT4+0DH/gkd
         pw481mnyJvuDHoRHZc+lcXdH07yUB6SpHsRb3SPNC9Vr7D2fMWXghm3REeHR9xwEJEKD
         nSXg==
X-Gm-Message-State: AOAM531G4JQo6CCADeOiV3emwwpf6xwzqz/mLL0ZDsSDruaD4DIo4pIW
        4nx3zv5WobFWlhVCrjW/aZ0dIMuZMCcisw==
X-Google-Smtp-Source: ABdhPJywok0qsqJCLjQhDp8WiJKVCzvNiasTBBAav9to7bsi2A96vs3/9kac3XV/HR0WjVVcZCNJ/Q==
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr27858252wrp.343.1632750954898;
        Mon, 27 Sep 2021 06:55:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:34f3:60a8:c3cc:641b? ([2a01:e34:ed2f:f020:34f3:60a8:c3cc:641b])
        by smtp.googlemail.com with ESMTPSA id l124sm20869477wml.8.2021.09.27.06.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 06:55:54 -0700 (PDT)
Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
 update for configuration operation
To:     Vadim Pasternak <vadimp@nvidia.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210927082421.2358851-1-vadimp@nvidia.com>
 <9aca37cb-1629-5c67-1895-1fdc45c0244e@linaro.org>
 <BN9PR12MB53814545BAE8C5A45E81220FAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
 <942558b3-e884-a907-0cc6-5eddf07c358a@linaro.org>
 <BN9PR12MB5381EADD601B87E4F2C60EBFAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d87227b8-57b9-fdb9-bb87-f01c6d0e23cc@linaro.org>
Date:   Mon, 27 Sep 2021 15:55:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB5381EADD601B87E4F2C60EBFAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/09/2021 15:29, Vadim Pasternak wrote:
> 
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: Monday, September 27, 2021 3:32 PM
>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
>> Cc: linux-pm@vger.kernel.org; Ido Schimmel <idosch@nvidia.com>; Rafael J.
>> Wysocki <rjw@rjwysocki.net>
>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
>> update for configuration operation
>>
>>
>>
>>
>> On 27/09/2021 13:22, Vadim Pasternak wrote:
>>> Hi Daniel,
>>>
>>> Thank you for quick reply.
>>>
>>>> -----Original Message-----
>>>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Sent: Monday, September 27, 2021 1:42 PM
>>>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
>>>> Cc: =idosch@nvidia.com; linux-pm@vger.kernel.org
>>>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device
>>>> statistics update for configuration operation
>>>>
>>>>
>>>> Hi Vadim,
>>>>
>>>>
>>>> On 27/09/2021 10:24, Vadim Pasternak wrote:
>>>>> The thermal subsystem maintains a transition table between states
>>>>> that is allocated according to the maximum state supported by the
>>>>> cooling device.
>>>>>
>>>>> When the table needs to be updated, the thermal subsystem does not
>>>>> validate that the new state does not exceed the maximum state,
>>>>> leading to out-of-bounds memory accesses [1].
>>>>
>>>> Actually, thermal_cooling_device_stats_update() is called if the
>>>> set_cur_state is successful.
>>>>
>>>> With a state greater than the max state, the set_cur_state should
>>>> fail and
>>>> thermal_cooling_device_stats_update() is not called.
>>>>
>>>> Perhaps the problem is in mlxsw_thermal_set_cur_state() ?
>>>
>>> "mlxsw" thermal drivers has additional use of 'sysfs' 'cur_state' for
>>> configuration purpose to limit minimum fan speed.
>>> Fan speed minimum is enforced by setting 'cur_state' with value
>>> exceeding actual fan speed maximum.
>>
>> Yes, and that is the problem because the driver is doing weird things with the
>> cooling device state resulting in an abuse of the sysfs API and conflicting with
>> the thermal internals.
>>
>>
>>> This feature provides ability to limit fan speed according to some
>>> system wise considerations, like absence of some replaceable units or
>>> high system ambient temperature, or some other factors which
>>> indirectly impacts system airflow.
>>
>> Is that a static thermal profile depending on the platform set by userspace or
>> something which can be changed dynamically at runtime via eg. a daemon ?
> 
> Yes, this is some profiles/rules, which are system specific and according to these
> rules userspace can limit fan speed. Like, for example:
> - if one of power supplies is removed, system fan should be enforced to full
>   speed, because it makes a hole in a box, and it has hard impact on airflow.
> - If port side ambient temperature reaches some threshold X1, fan speed should
>   be limited by Y1%, X2 - Y2%, etcetera.
> - if temperature fault is detected for any optical transceivers - some limit is
>   required. 

I see, thanks for the information.

>>> For example, if cooling devices operates at cooling levels from 1 to
>>> 10
>>> (1 for 10% fan speed, 10 for 100% fan speed), cooling device minimal
>>> speed can be limited by setting 'cur_state' attribute through 'sysfs'
>>> to the values from 'max_state' + 1 to 'max_state * 2' (from 11 to 20).
>>> Following this example if value is set to 14 (40%) cooling levels
>>> vector will be set to 4, 4, 4, 4, 4, 5, 6, 7, 8, 9, 10 for setting
>>> device speed cooling states respectively in 40, 40, 40, 40, 40, 50,
>>> 60. 70, 80, 90,
>>> 100 percent. And it limits cooling device to operate only at 40% speed
>>> and above.
>>>
>>> Maybe it would be worth adding earlier some dedicated 'cur_state_limit'
>>> attribute for this feature, but it was not done.
>>>
>>> We have another driver required this feature and one new we are
>>> developing now, which require fan minim speed limit as well.
>>
>> The use case is valid but I think the approach is wrong. Probably the simplest
>> thing to do is to set a low trip point with a minimal fan speed.
> 
> For "trip_point_0_temp" there is the below definition:
> 	{	/* In range - 0-40% PWM */
> 		.type		= THERMAL_TRIP_ACTIVE,
> 		.temp		= MLXSW_THERMAL_ASIC_TEMP_NORM,
> 		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
> 		.min_state	= 0,
> 		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10, (40%)
> 	},
> For "trip_point_1_temp":
> 	{
> 		/* In range - 40-100% PWM */
> 		.type		= THERMAL_TRIP_ACTIVE,
> 		.temp		= MLXSW_THERMAL_ASIC_TEMP_HIGH,
> 		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
> 		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10, (100%)
> 		.max_state	= MLXSW_THERMAL_MAX_STATE,
> 	},
> 
> To limit cooling device by f.e 70%, I should change dynamically 'min_state' and 'max_state'
> for both trips to (70%, 70%) and (70%, 100%). I am not sure I can do it?
> 
> And we have many customers, using this user space interface, it would be not so good to
> change it.

The issue is the driver is wrong here. The change you referred in the
past should have not been merged. I note there is no thermal maintainer
blessing in the tags.

> I understand it is possible to handle this issue inside driver's set_cur_stat() callback by
> returning positive value for configuration request.
> But maybe this feature could you useful for other developers and it could be some common
> interface to support it? 

I suggest to revert a421ce088ac8 and switch to hwmon to set the fan
speed. At the first glance, it is already supported by the mlx driver, no ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
