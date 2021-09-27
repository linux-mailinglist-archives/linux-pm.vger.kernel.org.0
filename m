Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA2419449
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 14:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhI0Mdi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhI0Mdi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 08:33:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60CC061575
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 05:32:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 136-20020a1c048e000000b0030d05169e9bso404457wme.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QeZnI55FPHwfoU9K8wR/l7Sg7vTWuOqx5rFs1GcxTC0=;
        b=l/Y6xeISF9e4wUWT/J5DrEajJGZq/ZPmecpiEOwW+VSKrC+iYnwqfz1PDwd+P4KcXQ
         qiDIMXwzyC2ts9Nnkx3PqmMXLQmkh9zgI8WV3FVmnaEn0hVV/OVi6wvCHl+cIAJWUErb
         Y53ijjbqmMlfk4VN82LvNea8G/LdezlhAN8iFS0q+Xyd5Ni5QYg35WWWwZI0mTWW+mIK
         /e7s3VKC+tUZ6g6ThUh0V8coBkeppSu8C+dE6lgLryrC1wE99ILboEzQZ3rWAy/yAROW
         eIM5AI5J0KxKwE6jnH1EBjgufSSWVTZ7T76a543B7kk3fZ+CR9eYDcU6qQYJIztZCgtv
         p1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QeZnI55FPHwfoU9K8wR/l7Sg7vTWuOqx5rFs1GcxTC0=;
        b=7EW9e39ZfyxAmVdTk+9s4PPaYockxLwIh1x/7WqCOFf5n1cQxlYxaNrBjugz67W+J8
         ZExbu7Z6CG/rUhBfjjDfYAph827b7xKmqoL2uFnYXYTnaIWcjM8SmSqIcy+wYzIJ7LwN
         9FfEyDkLZS0OaH5Xj8IV6WIwU4hG/EIA0fSeNFBB8Ed0jqvewNgYVHv71yreNOmrsEie
         3eBqOGAwbrNBmnZVYAM9Hk/HB1IgzNxb3hau6KvRnIakQ6rDWZiAcgw1LGA53DH5bxEo
         fQLOHZyQqten4y1OCS/yhCj4DFjdHGSUrMxctKcYQ4LM5eeU4vuXk8M0ESs7aSDVyMYw
         Pyhg==
X-Gm-Message-State: AOAM530uHbXaAu/u6hPNpybNo4PpDpeWCneyH/w4Xe9BH6K8h1UgcsUu
        j87k34eD6fxX/r0zmxA6lXsMjO4JYc2tsQ==
X-Google-Smtp-Source: ABdhPJzJjvRIjQJXrAFWXc1ZfyMEp6F2w2BJWGz+/v/rM/07lPN7ZFbA9egqYGPtVVeSnfidCn2Ftg==
X-Received: by 2002:a05:600c:4f95:: with SMTP id n21mr15725495wmq.22.1632745918835;
        Mon, 27 Sep 2021 05:31:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:34f3:60a8:c3cc:641b? ([2a01:e34:ed2f:f020:34f3:60a8:c3cc:641b])
        by smtp.googlemail.com with ESMTPSA id u6sm19490373wrp.0.2021.09.27.05.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:31:58 -0700 (PDT)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <942558b3-e884-a907-0cc6-5eddf07c358a@linaro.org>
Date:   Mon, 27 Sep 2021 14:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB53814545BAE8C5A45E81220FAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org




On 27/09/2021 13:22, Vadim Pasternak wrote:
> Hi Daniel,
> 
> Thank you for quick reply.
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: Monday, September 27, 2021 1:42 PM
>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
>> Cc: =idosch@nvidia.com; linux-pm@vger.kernel.org
>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
>> update for configuration operation
>>
>>
>> Hi Vadim,
>>
>>
>> On 27/09/2021 10:24, Vadim Pasternak wrote:
>>> The thermal subsystem maintains a transition table between states that
>>> is allocated according to the maximum state supported by the cooling
>>> device.
>>>
>>> When the table needs to be updated, the thermal subsystem does not
>>> validate that the new state does not exceed the maximum state, leading
>>> to out-of-bounds memory accesses [1].
>>
>> Actually, thermal_cooling_device_stats_update() is called if the
>> set_cur_state is successful.
>>
>> With a state greater than the max state, the set_cur_state should fail and
>> thermal_cooling_device_stats_update() is not called.
>>
>> Perhaps the problem is in mlxsw_thermal_set_cur_state() ?
> 
> "mlxsw" thermal drivers has additional use of 'sysfs' 'cur_state' for
> configuration purpose to limit minimum fan speed. 
> Fan speed minimum is enforced by setting 'cur_state' with value
> exceeding actual fan speed maximum.

Yes, and that is the problem because the driver is doing weird things
with the cooling device state resulting in an abuse of the sysfs API and
conflicting with the thermal internals.


> This feature provides ability to limit fan speed according to some
> system wise considerations, like absence of some replaceable units 
> or high system ambient temperature, or some other factors which
> indirectly impacts system airflow.

Is that a static thermal profile depending on the platform set by
userspace or something which can be changed dynamically at runtime via
eg. a daemon ?

> For example, if cooling devices operates at cooling levels from 1 to 10
> (1 for 10% fan speed, 10 for 100% fan speed), cooling device minimal
> speed can be limited by setting 'cur_state' attribute through 'sysfs'
> to the values from 'max_state' + 1 to 'max_state * 2' (from 11 to 20).
> Following this example if value is set to 14 (40%) cooling levels vector
> will be set to 4, 4, 4, 4, 4, 5, 6, 7, 8, 9, 10 for setting device speed
> cooling states respectively in 40, 40, 40, 40, 40, 50, 60. 70, 80, 90,
> 100 percent. And it limits cooling device to operate only at 40% speed
> and above.
>
> Maybe it would be worth adding earlier some dedicated 'cur_state_limit'
> attribute for this feature, but it was not done.
> 
> We have another driver required this feature and one new we are
> developing now, which require fan minim speed limit as well.

The use case is valid but I think the approach is wrong. Probably the
simplest thing to do is to set a low trip point with a minimal fan speed.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
