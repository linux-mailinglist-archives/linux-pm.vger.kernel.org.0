Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E48D32140B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 11:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhBVKXO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 05:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBVKXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 05:23:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D4FC06178B
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 02:22:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m1so13804352wml.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzhAm54W/9fzbzcaxzy1NT+5bc7fiy3sUsh0lCDscII=;
        b=DTqTG3ANLVbC24ksi5/RLM69eVWALii0090x+7cXoFjfgbHpwiFMviVQQP+etMt62K
         G/56meV4VejR5jVkRXpNqKKcKu+NGtPQc5UEdjKrpcReHSJtng+WCdhvP0MnMpusOfI5
         tlYQYV4+orcrEGI1NKelVYngJFQ+vVYyu0Ggu6k2DCSkR5mHZ6wVQsLx9dEoXCNSX5vp
         jaE9GBHQGbuQr/z2B153ABjKu9XtfDosT4VpnJqYferSyEuknKnrOdSlgl69SBVG8ewj
         xJwSpVPOH0yYLAUKOZlB12IO6E/va9D/ma4epXEOrK9ctWHwCX/9FfvdOGiJbkele+ws
         AL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzhAm54W/9fzbzcaxzy1NT+5bc7fiy3sUsh0lCDscII=;
        b=gDW7IOsRqSGNP71NzH5aiBmnAYDONPPPCY1x9imPnbOldqNwwSSH3Cpa2PyVhMgI3n
         3GwWJZPkslecu7YW/3dspIf1DyZVgdeJqQubyTPagdhzVTPmlm0AwwpxHqprZymlopYU
         +9y6/Jbg6k8P9W0RH9ZIC/M8JjwMzFmT7/6wwDZcQ8ZmWg4laHdVSW5YORIcnpMlhEne
         caj8aamnoVY9+R4ysmHrfBdU2s5TVAzdDhkvHGw7d5bLyJ61U7eI0pVfVI9c7I3Gkn8F
         j3330uxzvh9cxv9AIe96O1PlFisoI2UFLyeOJlbknWAEKtCzdoQKFGoj6HW6+24WnIZ+
         Oe6g==
X-Gm-Message-State: AOAM5334kzMbkoSTyUqClXIumA+YNNI+JyOBjCM9fZayKBUSE9T/zYoG
        6giniHL/HkpSwRSlnrVuoiof/g==
X-Google-Smtp-Source: ABdhPJza1uaC7tcXppo/6+lr5xblW3A5dqMncwyyZvMWjcemVC3QHlyvhHLvZ3XP7FmaUEZ2R0jiWA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr19459775wmc.162.1613989341128;
        Mon, 22 Feb 2021 02:22:21 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8d19:48da:83de:346d? ([2a01:e34:ed2f:f020:8d19:48da:83de:346d])
        by smtp.googlemail.com with ESMTPSA id d7sm16575095wrm.62.2021.02.22.02.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 02:22:20 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, rafael@kernel.org, Dietmar.Eggemann@arm.com,
        amitk@kernel.org, rui.zhang@intel.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2f4d7bf2-3f3e-ac24-20fb-b8d66dcdd809@linaro.org>
Date:   Mon, 22 Feb 2021 11:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126104001.20361-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

sorry for the delay, it took more time to finish my current work before
commenting these patches.

On 26/01/2021 11:39, Lukasz Luba wrote:
> Hi all,
> 
> This patch set tries to add the missing feature in the Intelligent Power
> Allocation (IPA) governor which is: frequency limit set by user space.

It is unclear if we are talking about frequency limit of the dvfs device
by setting the hardware limit (min-max freq). If it is the case, then
that is an energy model change, and all user of the energy model must be
notified about this change. But I don't see why userspace wants to
change that.

If we just want to set a frequency limit, then that is what we are doing
with the DTPM framework via power numbers.

> User can set max allowed frequency for a given device which has impact on
> max allowed power. In current design there is no mechanism to figure this
> out. IPA must know the maximum allowed power for every device. It is then
> used for proper power split and divvy-up. When the user limit for max
> frequency is not know, IPA assumes it is the highest possible frequency.
> It causes wrong power split across the devices.

That is because the IPA introduced the power rebalancing between devices
belonging the same thermal zone, so the feature was very use case specific.

The DTPM is supposed to solve this by providing an unified uW unit to
act on the different power capable devices on a generic way.

Today DTPM is mapped to userspace using the powercap framework, but it
is considered to add kernel API to let other subsystem to act on it
directly. May be, you can add those and call them from IPA directly, so
the governor does power decision and ask the DTPM to do the changes.

Conceptually, that would be much more consistent and will remove
duplicated code IMO.

May be create a power_qos framework to unify the units ...

> This new mechanism provides the max allowed frequency to the thermal
> framework and then max allowed power to the IPA.
> The implementation is done in this way because currently there is no way
> to retrieve the limits from the PM QoS, without uncapping the local
> thermal limit and reading the next value. It would be a heavy way of
> doing these things, since it should be done every polling time (e.g. 50ms).
>
> Also, the value stored in PM QoS can be different than the real OPP 'rate'
> so still would need conversion into proper OPP for comparison with EM.
> Furthermore, uncapping the device in thermal just to check the user freq
> limit is not the safest way.
> Thus, this simple implementation moves the calculation of the proper
> frequency to the sysfs write code, since it's called less often. The value
> is then used as-is in the thermal framework without any hassle.

Sounds like the DTPM is doing exactly that, no ?

> As it's a RFC, it still misses the cpufreq sysfs implementation, but would
> be addressed if all agree.
We are talking about power, frequency, in-kernel governor, userspace
having knowledge of max frequency limit to set power.

I'm a bit lost. What is the problem we want to solve here ?

May be I'm missing something. Is it possible to share a scenario where
the userspace acts on the devfreq and the IPA taking decision to
illustrate your proposal ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
