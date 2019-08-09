Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE20882F5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 20:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfHISwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 14:52:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45065 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHISwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 14:52:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id t3so4436810ljj.12;
        Fri, 09 Aug 2019 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h22eQ216TUwl2M9AY0DcsqhpZJRWYBzIWJYlSY8put4=;
        b=tvKxQNTpYVlmAtY5mOsYS3ycnzI27d22L/8l3Bh4h+8YXUZA9FQxZoRtY9/e8v0nQO
         aT5S4V4sx4fKTg9c8gyT8ItkLNK3YPAsXrTn8qgJee/U8UmBMR9/XtikkniIEbmntOhS
         6MHdTBWurgumRTtVSOuYMPscOTYJjYOLcJlJ/9jPhGrjVTkUJMaOut22wB+0jit2v13M
         IqJByuXO+9t5W8djPn+0ucZ2RbfvddJIk2HZwoe3ijLkQANoc7UzyAHRaV8+PxMaJGzM
         AiZBBzLfIBjbsGxjzgtwLTOC6oIuPXSf/SPiUVdn8U0XmbGtdZIK0gw0sVxz8JvSUPCM
         WjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h22eQ216TUwl2M9AY0DcsqhpZJRWYBzIWJYlSY8put4=;
        b=UqWAqPZXGVfq8bpfTeeI812MqTsSl5dwPpKfbfybQYz7fyLksdvRykPvFv9AltBzhf
         lK+rZmEbyKhqZTzK9YcWj6LQOPXqj9RdDGM/xIRVlkAc5dyplWE5pTrn625ghxJ0j+86
         MsnxpepoTyjV1mlunJtMuwd6AmF+n+8ZerfssFrbwFhClEoUnqoS2AfSLc71fN/PT1tJ
         6kLIPgWwfn593SF7C2rreb4bTPHSEukcwMKlwH7psmY6jeTaWeYmf6/rlgvHfPNG4y4n
         7YstcMPORyj1VBoYIAhW60uwkaMYUvVEFmiXElsYBprhMxJZVbED2u0vFxIALfCaFF0y
         5GbQ==
X-Gm-Message-State: APjAAAU9UImjzsAjOchEjKwQDmfTXixwsCVlB54VHEFh0cdZpTTRaNK4
        oqInIH484GQ02IoxWTvhHkGguTYe
X-Google-Smtp-Source: APXvYqytQt1+S3AxDk9AK0nr3ulH0kn0895rC1IYdLSAHMThZ0GCZqdDBUKukPz62P7FmUIG5OmWhQ==
X-Received: by 2002:a2e:98c9:: with SMTP id s9mr12333317ljj.176.1565376723803;
        Fri, 09 Aug 2019 11:52:03 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id c89sm11389695ljf.83.2019.08.09.11.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 11:52:03 -0700 (PDT)
Subject: Re: [PATCH v8 11/21] clk: tegra: clk-dfll: Add suspend and resume
 support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-12-git-send-email-skomatineni@nvidia.com>
 <eb4fdab8-aba3-7f0c-a391-d751674fd03e@gmail.com>
 <29a85a35-10ff-2d43-d148-9dba1ee25869@nvidia.com>
 <84a0d46a-bca2-1000-a2a6-8890ee702dd3@gmail.com>
 <9902aa72-3f18-9840-35ad-137293d2e26c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3f94d6c9-4e33-8e67-abe4-8d948f151910@gmail.com>
Date:   Fri, 9 Aug 2019 21:52:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9902aa72-3f18-9840-35ad-137293d2e26c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 21:33, Sowjanya Komatineni пишет:
> 
> On 8/9/19 11:00 AM, Dmitry Osipenko wrote:
>> 09.08.2019 19:39, Sowjanya Komatineni пишет:
>>> On 8/9/19 5:23 AM, Dmitry Osipenko wrote:
>>>> 09.08.2019 2:46, Sowjanya Komatineni пишет:
>>>>> This patch implements DFLL suspend and resume operation.
>>>>>
>>>>> During system suspend entry, CPU clock will switch CPU to safe
>>>>> clock source of PLLP and disables DFLL clock output.
>>>>>
>>>>> DFLL driver suspend confirms DFLL disable state and errors out on
>>>>> being active.
>>>>>
>>>>> DFLL is re-initialized during the DFLL driver resume as it goes
>>>>> through complete reset during suspend entry.
>>>>>
>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>> ---
>>>>>    drivers/clk/tegra/clk-dfll.c               | 56 ++++++++++++++++++++++++++++++
>>>>>    drivers/clk/tegra/clk-dfll.h               |  2 ++
>>>>>    drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  1 +
>>>>>    3 files changed, 59 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>>>>> index f8688c2ddf1a..eb298a5d7be9 100644
>>>>> --- a/drivers/clk/tegra/clk-dfll.c
>>>>> +++ b/drivers/clk/tegra/clk-dfll.c
>>>>> @@ -1487,6 +1487,7 @@ static int dfll_init(struct tegra_dfll *td)
>>>>>        td->last_unrounded_rate = 0;
>>>>>          pm_runtime_enable(td->dev);
>>>>> +    pm_runtime_irq_safe(td->dev);
>>>>>        pm_runtime_get_sync(td->dev);
>>>>>          dfll_set_mode(td, DFLL_DISABLED);
>>>>> @@ -1513,6 +1514,61 @@ static int dfll_init(struct tegra_dfll *td)
>>>>>        return ret;
>>>>>    }
>>>>>    +/**
>>>>> + * tegra_dfll_suspend - check DFLL is disabled
>>>>> + * @dev: DFLL device *
>>>>> + *
>>>>> + * DFLL clock should be disabled by the CPUFreq driver. So, make
>>>>> + * sure it is disabled and disable all clocks needed by the DFLL.
>>>>> + */
>>>>> +int tegra_dfll_suspend(struct device *dev)
>>>>> +{
>>>>> +    struct tegra_dfll *td = dev_get_drvdata(dev);
>>>>> +
>>>>> +    if (dfll_is_running(td)) {
>>>>> +        dev_err(td->dev, "dfll is enabled while shouldn't be\n");
>>>>> +        return -EBUSY;
>>>>> +    }
>>>>> +
>>>>> +    reset_control_assert(td->dvco_rst);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL(tegra_dfll_suspend);
>>>>> +
>>>>> +/**
>>>>> + * tegra_dfll_resume - reinitialize DFLL on resume
>>>>> + * @dev: DFLL instance
>>>>> + *
>>>>> + * DFLL is disabled and reset during suspend and resume.
>>>>> + * So, reinitialize the DFLL IP block back for use.
>>>>> + * DFLL clock is enabled later in closed loop mode by CPUFreq
>>>>> + * driver before switching its clock source to DFLL output.
>>>>> + */
>>>>> +int tegra_dfll_resume(struct device *dev)
>>>>> +{
>>>>> +    struct tegra_dfll *td = dev_get_drvdata(dev);
>>>>> +
>>>>> +    reset_control_deassert(td->dvco_rst);
>>>> This doesn't look right because I assume that DFLL resetting is
>>>> synchronous and thus clk should be enabled in order for reset to
>>>> propagate inside hardware.
>>>>
>>>>> +    pm_runtime_get_sync(td->dev);
>>>> Hence it will be better to remove the above reset_control_deassert() and
>>>> add here:
>>>>
>>>>      reset_control_reset(td->dvco_rst);
>>> By the time dfll resume happens, dfll controller clock will already be enabled.
>>>
>>> so doing reset de-assert before pm_runtime seems ok.
>> I don't see what enables the DFLL clock because it should be enabled by the CPUFreq driver
>> on resume from suspend and resume happens after resuming of the DFLL driver.
> 
> dvco_rst is part of peripheral clocks and all peripheral clocks are restored by clk-tegra210
> driver which happens before dfll driver resume.
> 
> So dfll rst thru part of peripheral clock enable is set prior to dfll reset deassertion

Ah, so that is DVCO resetting and not DFLL, which are different blocks. Looks correct then.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
