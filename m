Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C824094E51
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfHSTd5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 15:33:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52861 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfHSTd5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 15:33:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id o4so573914wmh.2;
        Mon, 19 Aug 2019 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M8LYhD4lhXPC7C0Kz4FM0eI8Uon0RGyTbjZ7iSLdUwY=;
        b=G/Xz5WNgJus57o+i2ehU+l0iHOMv8K+eX7esd5Hsp8ECu1hc9Ij2lFCCMT8c/TeTQx
         KPxGFnwhHfLCIuhABPymGXDPH0oEnZlCiWXK4u0Ggx6yY8rqCwwB764VaXJ2WamY2LwK
         V0y5VSxnkH2oPCLaRqgkNtJKf+KXfenR2Mgqd52G43nCPwFJY4jkEoY4yIi92vlt8HU8
         ENKFx7T9KuXh511hTtpe7jujVFXmzEyWHXNhyrD9ZGosBFQgGvTbjw9aVwqtOnqp9XpT
         2x3s4e6pw/JIijGy+an8s+tsrNoMURxBIKU583BC6tsFmleaeStVM3g3pSv6Oa0eeXSY
         ZmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8LYhD4lhXPC7C0Kz4FM0eI8Uon0RGyTbjZ7iSLdUwY=;
        b=IXS76+FZTUGHBAxESpVXRK31XSmSe/DDlVeF+bU7jKIbF4YK3Xkf/vwiBPq5GeyfAe
         0JUrzz8kK4lEub/vRBA7798Z5BpVpO9YibC00K7Re/B6whvXadpNDF6bR1dgEUFyX0Ob
         xIfUjQ27Q375vBA93fmmlcXDd25TXiQxQhTUCTIVxj7tLvwff/eb4bnj4+MANDzx00RM
         IsjzPFpqsr/33Ut1iVN+lc+14wTGE6klFIJSAu8rC8ZTgsVNsIM8jr0ODH6m/o8XItnb
         8Qa7bzySeDyLy261UDcZ2IFuY4S2RJTxroPdegseoyLzEIXM1YSzNuqQUo+VCsiTtbjD
         gZag==
X-Gm-Message-State: APjAAAXbqmpx8WvcXLdjSltC2KXT19OzATWl6uDh88sEowKdFdJUEu3X
        rPAkxo+6aTCwHH4fQQPu5Qazc4HH
X-Google-Smtp-Source: APXvYqx3j1A+XbE8p3KzEPzhIilb1DSi7SDFHoAeZejzy26ay1t6am8l3zqKSE2XA96TglOR8BVogQ==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr23171852wmg.28.1566243233356;
        Mon, 19 Aug 2019 12:33:53 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id o11sm12528508wrw.19.2019.08.19.12.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:33:52 -0700 (PDT)
Subject: Re: [PATCH v9 20/22] soc/tegra: pmc: Configure deep sleep control
 settings
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
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-21-git-send-email-skomatineni@nvidia.com>
 <bf5541d2-1bad-8a8c-fd9d-821b55861136@gmail.com>
 <2092e557-06cb-4a74-fe40-1d83bf67ccca@nvidia.com>
 <a8d65dbc-6924-c972-06e9-5bc47d66e94f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8f5630bd-2869-4f5b-c18d-7ee8326432d6@gmail.com>
Date:   Mon, 19 Aug 2019 22:33:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a8d65dbc-6924-c972-06e9-5bc47d66e94f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.08.2019 22:07, Sowjanya Komatineni пишет:
> 
> On 8/19/19 11:20 AM, Sowjanya Komatineni wrote:
>>
>> On 8/19/19 9:48 AM, Dmitry Osipenko wrote:
>>> 16.08.2019 22:42, Sowjanya Komatineni пишет:
>>>> Tegra210 and prior Tegra chips have deep sleep entry and wakeup related
>>>> timings which are platform specific that should be configured before
>>>> entering into deep sleep.
>>>>
>>>> Below are the timing specific configurations for deep sleep entry and
>>>> wakeup.
>>>> - Core rail power-on stabilization timer
>>>> - OSC clock stabilization timer after SOC rail power is stabilized.
>>>> - Core power off time is the minimum wake delay to keep the system
>>>>    in deep sleep state irrespective of any quick wake event.
>>>>
>>>> These values depends on the discharge time of regulators and turn OFF
>>>> time of the PMIC to allow the complete system to finish entering into
>>>> deep sleep state.
>>>>
>>>> These values vary based on the platform design and are specified
>>>> through the device tree.
>>>>
>>>> This patch has implementation to configure these timings which are must
>>>> to have for proper deep sleep and wakeup operations.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>   drivers/soc/tegra/pmc.c | 14 +++++++++++++-
>>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>> index 53ed70773872..710969043668 100644
>>>> --- a/drivers/soc/tegra/pmc.c
>>>> +++ b/drivers/soc/tegra/pmc.c
>>>> @@ -88,6 +88,8 @@
>>>>     #define PMC_CPUPWRGOOD_TIMER        0xc8
>>>>   #define PMC_CPUPWROFF_TIMER        0xcc
>>>> +#define PMC_COREPWRGOOD_TIMER        0x3c
>>>> +#define PMC_COREPWROFF_TIMER        0xe0
>>>>     #define PMC_PWR_DET_VALUE        0xe4
>>>>   @@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs
>>>> tegra20_pmc_regs = {
>>>>     static void tegra20_pmc_init(struct tegra_pmc *pmc)
>>>>   {
>>>> -    u32 value;
>>>> +    u32 value, osc, pmu, off;
>>>>         /* Always enable CPU power request */
>>>>       value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>>> @@ -2303,6 +2305,16 @@ static void tegra20_pmc_init(struct tegra_pmc
>>>> *pmc)
>>>>       value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>>>       value |= PMC_CNTRL_SYSCLK_OE;
>>>>       tegra_pmc_writel(pmc, value, PMC_CNTRL);
>>>> +
>>>> +    /* program core timings which are applicable only for suspend
>>>> state */
>>>> +    if (pmc->suspend_mode != TEGRA_SUSPEND_NONE) {
>>>> +        osc = DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
>>>> +        pmu = DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
>>>> +        off = DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
>>>> +        tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
>>>> +                 PMC_COREPWRGOOD_TIMER);
>>>> +        tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
>>>> +    }
>>>>   }
>>>>     static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
>>>>
>>> In the previous version of this patch there were checks for zero values
>>> of the timers with intention to skip programming of the timers if value
>>> is zero. I'm a bit puzzled by the new version, given that SUSPEND_NONE
>>> means that suspending isn't available at all and thus PMC timers won't
>>> be utilized, hence it shouldn't matter what values are programmed for
>>> the counters, isn't it?
>>
>> Yes, as I see in documentation we already specify all these timings
>> are required properties when suspend mode is used, I updated in this
>> version to program core timings only when suspend mode is enabled.
>>
> In other words, core timings are for SC7 entry only. So when SC7/suspend
> mode is not used, these timings doesn't matter.

In this case, it should be a bit more straightforward to always program
the timers unconditionally. But since device-tree binding requires all
the properties to be specified when suspend mode isn't NONE, then the
new variant also makes sense. Either way is good to me, thanks.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
