Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4688254
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 20:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436646AbfHISWd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 14:22:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32840 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407519AbfHISWc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 14:22:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so70272717lfc.0;
        Fri, 09 Aug 2019 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d17w+XfuyIIJSGQTvN29rXadrWu0vpB5brrtMkm6CsM=;
        b=YedaAfoXaWKKR4xheV/cw+fePm0iEaiWHKnkr6AeeS0ea6v0cPmihNn19xVHKDdb+/
         rJxupantlpiPHL3QmOZOHpvMcH3/H7Dzmdv+C8ESKzwqryJFYJboUdF/C5H3t+3Wwyc9
         C/ddZfv2X9WkowWYehUVQqwofdG4rNr91APrD4tXCGoSjznplsxwP16iMa/iYnq/HDmI
         bukG7ojiP+IbR2Iemuw9Amxp4IEDvLy9CKOrH2yXOIBskhDFpv09IW9ce+cXsWRufPUE
         VtQtH6VXB6PfBix3tOG5rmj96V1DPHKuM4M5PiNUkLVgNpyfHYEUfQVQbEzu2a3cr+1l
         2zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d17w+XfuyIIJSGQTvN29rXadrWu0vpB5brrtMkm6CsM=;
        b=twn5syXN5N1o/4fV4qlIzSirHJ0VwW9WLcoyJiH1p4j+1G8UeZt5UWzDwtZBtUX95j
         qJIjMLdogzw7W91QKVlubX3buQbudzJcy3SS92zSdUMqLvfz0+0+YVcG1lgDejF09I4W
         dlxfatdKUHO16Q/2Yrwt1AnOz1s4duYhSwu5vGbibmomH5r9pRzqS0D2NRsp0P/eKYXp
         2FxwID7D7+OoKQhYG4vjg0FOs5kbwJqHJEnw0hUSgxwwZax6BFmlr7IcWZVYeFhlB5IO
         j370xWCrX/RxuMNYty7g6LcLX9UY8m9Fcn1iAnuK/MV+QRhHRBrtwsqYO7wJFpzDgA1Z
         LPqw==
X-Gm-Message-State: APjAAAVXmlZrjbogC/qES46XxZXSHmsB6KOKeHyTBhewJA7u3DS7ObkS
        dY4oROoAIJXsqDpvU1mfDIYwXeMc
X-Google-Smtp-Source: APXvYqwD55t6TduNNq/nj1xhhTb8oJCD1U9R3vSd8pnx4NuWlAr61iSdw9qIjaKQSJh4jGRioOIDZA==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr13255013lfn.2.1565374948181;
        Fri, 09 Aug 2019 11:22:28 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id d3sm585122ljj.55.2019.08.09.11.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 11:22:27 -0700 (PDT)
Subject: Re: [PATCH v8 19/21] soc/tegra: pmc: Configure deep sleep control
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
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-20-git-send-email-skomatineni@nvidia.com>
 <57ed54cd-bf57-cab1-eb63-8548761640de@gmail.com>
 <275f3685-bc53-38ff-c778-cf2ea588e5a5@nvidia.com>
 <60ea494a-9960-b7fc-3afb-8c17feec9fda@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5b585870-f622-0727-8c4d-78cd48623edd@gmail.com>
Date:   Fri, 9 Aug 2019 21:22:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <60ea494a-9960-b7fc-3afb-8c17feec9fda@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 20:24, Sowjanya Komatineni пишет:
> 
> On 8/9/19 9:23 AM, Sowjanya Komatineni wrote:
>>
>> On 8/9/19 6:23 AM, Dmitry Osipenko wrote:
>>> 09.08.2019 2:46, Sowjanya Komatineni пишет:
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
>>>>   drivers/soc/tegra/pmc.c | 13 ++++++++++++-
>>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>> index e013ada7e4e9..9a78d8417367 100644
>>>> --- a/drivers/soc/tegra/pmc.c
>>>> +++ b/drivers/soc/tegra/pmc.c
>>>> @@ -88,6 +88,8 @@
>>>>     #define PMC_CPUPWRGOOD_TIMER        0xc8
>>>>   #define PMC_CPUPWROFF_TIMER        0xcc
>>>> +#define PMC_COREPWRGOOD_TIMER        0x3c
>>>> +#define PMC_COREPWROFF_TIMER        0xe0
>>>>     #define PMC_PWR_DET_VALUE        0xe4
>>>>   @@ -2277,7 +2279,7 @@ static const struct tegra_pmc_regs tegra20_pmc_regs = {
>>>>     static void tegra20_pmc_init(struct tegra_pmc *pmc)
>>>>   {
>>>> -    u32 value;
>>>> +    u32 value, osc, pmu, off;
>>>>         /* Always enable CPU power request */
>>>>       value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>>> @@ -2303,6 +2305,15 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
>>>>       value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>>>       value |= PMC_CNTRL_SYSCLK_OE;
>>>>       tegra_pmc_writel(pmc, value, PMC_CNTRL);
>>>> +
>>>> +    osc = DIV_ROUND_UP(pmc->core_osc_time * 8192, 1000000);
>>>> +    pmu = DIV_ROUND_UP(pmc->core_pmu_time * 32768, 1000000);
>>>> +    off = DIV_ROUND_UP(pmc->core_off_time * 32768, 1000000);
>>>> +    if (osc && pmu)
>>>> +        tegra_pmc_writel(pmc, ((osc << 8) & 0xff00) | (pmu & 0xff),
>>>> +                 PMC_COREPWRGOOD_TIMER);
>>>> +    if (off)
>>>> +        tegra_pmc_writel(pmc, off, PMC_COREPWROFF_TIMER);
>>> The osc/pmu/off values are undefined if they are not defined in device-tree. I suppose this
>>> need to be corrected in tegra_pmc_parse_dt() if the values really matter even if LP0 suspend
>>> isn't supported in device-tree.
>>>
>>> And I'm also not sure what's wrong with setting 0 for the timers.
>>>
>> These settings are for SC7 only and will not have any impact in normal state.
> POR value for these timing registers is not 0 and has default timings based on chip design
> and on top of that based on platform HW components charge/discharge timings there's a need
> to increase these timings so support for programming these thru DT is needed and these
> values have effect only in LP0.

If it is legal to omit the timings in DT, then tegra_pmc_parse_dt() need to be corrected if
there is assumption of 0 meaning that values are undefined in DT.
