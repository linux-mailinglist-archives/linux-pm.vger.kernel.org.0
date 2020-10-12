Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02F28B23F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 12:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgJLKaX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387522AbgJLKaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 06:30:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B62C0613CE
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 03:30:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p15so16707312wmi.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yyM17tjzjvmIht2LJIVw9YnlLvTnh878kmMY5/s0rp8=;
        b=kvieTaTiPUyF2cejHPTTECoW2OcrlgEASS+aRq3RBvdy2FCPN8EKBfxeX3VHORnNLN
         X5unBpy4uWQ+JJqjF5q66UCyo+0f3S3sLYNzc1KZcWDKU2hlnEhsjwdWKN6pCWd6Iybm
         wPX64K52Pkm06XaDg/4Xm8/gUBRmkzdc4QDctjOWJPlegPCVMgorigrMRkvY0wnlmPAA
         VtcbHPkTGnkHtejmDMHrKUiGWMi8V3BSOlu9dmcS0oN1xL1DrZE9Q4TjGsTSRpJr0hqK
         4v6q3NMlrmprG5r00ou4Wh3zzIHEutEbtQiqJixfxje9rVVfUsf1OZv7HS8uJGx5cFHj
         /W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yyM17tjzjvmIht2LJIVw9YnlLvTnh878kmMY5/s0rp8=;
        b=ChBfiUHjJ282tEPRWIYlWerpwdsvUE4LTbGZS/qCZkBuJe3sYYsFFNJn90bp5WOI6K
         AeIEd2576y29wGhIbqy3jOrE4lYgc4M6E+Z3t/BW6nPdsKsy+wD3ChcGpyfHARHV9yFV
         //29nG0wI9BoXLIB3Pd6Bn/SmD4wYx35m5HG3RAM6hVT3zOBSR+oZXDCal6fcL6IYe35
         KenUY9cVmKczmnwEljpRfWAEz5t90Ap6kQSrCd8ynOJKjxtKZ0qi+cMxQcqlMjui+Fys
         f6U0FD6vNo8h88lK/vN3uDfCcopSGiURY7qQun4+jocTcsROwI0ToDFKauTE0XBSYC1Z
         koaA==
X-Gm-Message-State: AOAM531TaqwH8SWXIb0QOVncp09Ym9xLykGsrXl3/0Ymy4GG7t96fIHc
        5mNEjo1O6c8LxmhtO3HgibdEuQ==
X-Google-Smtp-Source: ABdhPJw/+WIzOfEP1ryl9YJjiyRaMzJUNiQauMEmTblkUh36HVXFAWjiNhwleESlaA5b64lQ/Y2WhQ==
X-Received: by 2002:a7b:c085:: with SMTP id r5mr10037042wmh.17.1602498620679;
        Mon, 12 Oct 2020 03:30:20 -0700 (PDT)
Received: from [192.168.43.23] ([37.166.230.211])
        by smtp.googlemail.com with ESMTPSA id z191sm22754538wme.40.2020.10.12.03.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 03:30:20 -0700 (PDT)
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Hans de Goede <hdegoede@redhat.com>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
Date:   Mon, 12 Oct 2020 12:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Hans,

On 07/10/2020 12:43, Hans de Goede wrote:
> Hi,
> 
> On 10/6/20 2:20 PM, Daniel Lezcano wrote:
>> The density of components greatly increased the last decade bringing a
>> numerous number of heating sources which are monitored by more than 20
>> sensors on recent SoC. The skin temperature, which is the case
>> temperature of the device, must stay below approximately 45°C in order
>> to comply with the legal requirements.
>>
>> The skin temperature is managed as a whole by an user space daemon,
>> which is catching the current application profile, to allocate a power
>> budget to the different components where the resulting heating effect
>> will comply with the skin temperature constraint.
>>
>> This technique is called the Dynamic Thermal Power Management.
>>
>> The Linux kernel does not provide any unified interface to act on the
>> power of the different devices. Currently, the thermal framework is
>> changed to export artificially the performance states of different
>> devices via the cooling device software component with opaque values.
>> This change is done regardless of the in-kernel logic to mitigate the
>> temperature. The user space daemon uses all the available knobs to act
>> on the power limit and those differ from one platform to another.
>>
>> This series provides a Dynamic Thermal Power Management framework to
>> provide an unified way to act on the power of the devices.
> 
> Interesting, we have a discussion going on about a related
> (while at the same time almost orthogonal) discussion for
> setting policies for if the code managing the restraints
> (which on x86 is often hidden in firmware or ACPI DPTF tables)
> should have a bias towards trying to have as long a battery life
> as possible, vs maximum performance. I know those 2 aren't
> always opposite ends of a spectrum with race-to-idle, yet most
> modern x86 hardware has some notion of what I call performance-profiles
> where we can tell the firmware managing this to go for a bias towards
> low-power / balanced / performance.
> 
> I've send a RFC / sysfs API proposal for this here:
> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
> 
> I've read the patches in this thread and as said already I think
> the 2 APIs are mostly orthogonal. The API in this thread is giving
> userspace direct access to detailed power-limits allowing userspace
> to configure things directly (and for things to work optimal userspace
> must do this). Where as in the x86 case with which I'm dealing everything
> is mostly handled in a black-box and userspace can merely configure
> the low-power / balanced / performance bias (*) of that black-box.
> 
> Still I think it is good if we are aware of each-others efforts here.
> 
> So Daniel, if you can take a quick look at my proposal:
> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
> 
> That would be great. I think we definitely want to avoid having 2
> APIs for the same thing here. Again I don't think that is actually
> the case, but maybe you see this differently ?

Thanks for pointing this out. Actually, it is a different feature as you
mentioned. The profile is the same knob we have with the BIOS where we
can choose power/ balanced power / balanced/balanced
performance / performance, AFAICT.

Here the proposed interface is already exported in userspace via the
powercap framework which supports today the backend driver for the RAPL
register.

The userspace will be in charge of handling the logic to have the
correct power/performance profile tuned against the current application
running foreground. The DTPM framework gives the unified access to the
power limitation to the individual devices the userspace logic can act on.

A side note, related to your proposal, not this patch. IMO it suits
better to have /sys/power/profile.

cat /sys/power/profile

power
balanced_power *
balanced
balanced_performance
performance

The (*) being the active profile.


> *) bias might not always give the correct impression at least
> on some Thinkpads switching from balanced (which they call medium)
> to performance boosts the long time power-limit from aprox.
> 15W to 25W which as expected results in a significant performance
> boost.
> 
> Note usually we have no idea what the black-box knob which we are
> tweaking actually does, all we know is that it is there and
> Windows 10 often has a slider to configure it and users want
> the same functionality under Linux.
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
