Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A743968A5
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhEaUJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhEaUJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 16:09:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C61C06174A;
        Mon, 31 May 2021 13:07:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a4so16329322ljd.5;
        Mon, 31 May 2021 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H8R9ZAC6woctLDWtVwrlrWtOGK05ASHzYerFd6xKn8k=;
        b=FXECDuIc3HltiC+bI1f0dMixphYkh/N7QI83qOG/TCz14VMyrlYiM+rb5Nyz8KOkV2
         pUIvFjXVkoEYuqZ8nKVyJNMcRIB3ifrVnBbjI9x3dt3onEqfPKCKra3vgtSSWaxJsjiN
         XxJIeBYfaBTgFoow3pD4Nz1mXaRGx9Fg55NNSwF/uwEvjamvlOdf8k04BJaHu3wOlM4s
         Hp4bICm1B1r7ogZ0r5Xqpr+zAp6saalJuzDqveosGxIrnt5+7xNpoUBiBHCFgj0Pj2xq
         UY31SjOXQJ73J+Eof45kLFADknILcFWkFhdGry3zF9gRn29c3Lvfgs3KImPboo+N92Em
         FZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H8R9ZAC6woctLDWtVwrlrWtOGK05ASHzYerFd6xKn8k=;
        b=MwMxEiqGPLQQoeTsXRe2huvZ7pVJ356A74MTJvoA4Cq7gyVped4MfQ2HOC1ARwAnbV
         IxZbiNYANYNt/iahUVbqvMH7QFUcvmBmAxpsOt0j528Mx/fKfpj+MvjP3dxtc4QII1Du
         4k7WOHhGgiSzGIP9g8xjPJD4uQ9/PqC5Z/pDAMPRep7/ONdXzZOhrvRBoxl3pIiTgmDU
         fdd2GDY/ns9YFPJJjem5BdUPdOfmenhl7bp/AfVUH1MNy0ovdM85NEscMnlb86/Ku+Rm
         WyxSoEhnj1X0ssUtlz+JzOlriqje41K+k/j7kCXxHusci4uEhwBEDmVbHCbO570LFAaO
         lBEg==
X-Gm-Message-State: AOAM531/SfiIZL+LYduVhlY/kLJ+10HyOli0i94EgqqXE8xO44Cnszax
        JAd7cH+kNzNVO3iuZjWrnOmFrNIcxsU=
X-Google-Smtp-Source: ABdhPJwz/u8zvmtRH6GQVjYJFm3IZ+/YKYQNxLqhgZ0BqJWnXRcEznOlf82bTI6s8gJ8RkdMG2EhhA==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr17875504lji.248.1622491655239;
        Mon, 31 May 2021 13:07:35 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id f1sm1595355lfs.160.2021.05.31.13.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 13:07:34 -0700 (PDT)
Subject: Re: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210523231335.8238-1-digetx@gmail.com>
 <20210523231335.8238-14-digetx@gmail.com>
 <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
 <f0b1bea7-0752-5584-8bcc-d8b602f22c13@gmail.com>
 <CAPDyKFq0EpVjUg9RV7qR3_qywUQHKqStPNSFY==6AFBNC6m3KQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3d8d195f-d325-1b27-21f4-c1fb593678d1@gmail.com>
Date:   Mon, 31 May 2021 23:07:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq0EpVjUg9RV7qR3_qywUQHKqStPNSFY==6AFBNC6m3KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.05.2021 16:17, Ulf Hansson пишет:
> On Mon, 24 May 2021 at 22:23, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 24.05.2021 20:04, Ulf Hansson пишет:
>>> On Mon, 24 May 2021 at 01:13, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
>>>> to an external SoC power rail. Core power domain covers vast majority of
>>>> hardware blocks within a Tegra SoC. The voltage of a power domain should
>>>> be set to a level which satisfies all devices within the power domain.
>>>> Add support for the core power domain which controls voltage state of the
>>>> domain. This allows us to support system-wide DVFS on Tegra20-210 SoCs.
>>>> The PMC powergate domains now are sub-domains of the core domain, this
>>>> requires device-tree updating, older DTBs are unaffected.
>>>>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>
>>> [...]
>>>
>>>> +
>>>> +static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
>>>> +{
>>>> +       static struct lock_class_key tegra_core_domain_lock_class;
>>>> +       struct generic_pm_domain *genpd;
>>>> +       const char *rname = "core";
>>>> +       int err;
>>>> +
>>>> +       genpd = devm_kzalloc(pmc->dev, sizeof(*genpd), GFP_KERNEL);
>>>> +       if (!genpd)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       genpd->name = np->name;
>>>> +       genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
>>>> +       genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
>>>> +
>>>> +       err = devm_pm_opp_set_regulators(pmc->dev, &rname, 1);
>>>> +       if (err)
>>>> +               return dev_err_probe(pmc->dev, err,
>>>> +                                    "failed to set core OPP regulator\n");
>>>> +
>>>> +       err = pm_genpd_init(genpd, NULL, false);
>>>> +       if (err) {
>>>> +               dev_err(pmc->dev, "failed to init core genpd: %d\n", err);
>>>> +               return err;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * We have a "PMC pwrgate -> Core" hierarchy of the power domains
>>>> +        * where PMC needs to resume and change performance (voltage) of the
>>>> +        * Core domain from the PMC GENPD on/off callbacks, hence we need
>>>> +        * to annotate the lock in order to remove confusion from the
>>>> +        * lockdep checker when a nested access happens.
>>>> +        */
>>>
>>> Can you elaborate a bit more on this?
>>>
>>> Are you saying that when the child domain (PMC pwrgate) gets powered
>>> off, you want to drop its aggregated votes it may hold for the
>>> performance state, as otherwise it may affect the parent domain (core
>>> domain)?
>>
>> Yes, in particular we want to remove/add the performance vote when clk is disabled/enabled, see tegra_clock_runtime_resume/suspend() of the clk-runtimePM driver [1]. I'll send that clk patch separately once this series and some other tegra-clk patches will be merged, otherwise there are too many dependencies and it's too difficult to review.
> 
> You are likely correct from the merging point of view, but for
> completeness I would prefer to look at the whole series. Would you
> mind folding in some of these changes too?

Sure, I will send those changes once this fundamental patchset will be merged. 

>> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20201217180638.22748-33-digetx@gmail.com/
> 
> Hmm. In general, the new changes to genpd and the opp library with
> "performance states" for DVFS, should help to avoid using clock rate
> notifications.
> 
> Instead of updating the performance votes from the clock provider
> driver, the more proper thing would be to let the clock consumer
> driver (various drivers) to call dev_pm_opp_set_rate() when it needs
> to move to a new OPP. This also means calling dev_pm_opp_set_rate(dev,
> 0) when the votes for an OPP can be dropped.
> 
> In this way, the opp library will call genpd to update the performance
> state vote for the corresponding device.

This is not sufficient for Tegra because we have individual OPP tables for the root PLLs, system clocks and device clocks. The device clocks could be muxed to a different PLLs, depending on clk requirements of a particular board.

>> Please see the example lockdep trace in the end of the email that is fixed by the mutex annotation. What we have there is the tegra-host1x device driver that resumes PMC powergate domain on Tegra30, the PMC driver enables clock from the genpd.power_on callback of the powergate domain and this propagates to the clock's RPM callback which sets the performance vote of the core domain. Hence core domain vote is set from within of the powergate domain.
> 
> Right, this sounds like a fragile looking path. Are you sure it can't
> lead into deadlock situations?

The locking was a concern, but turned out that it works nicely for the Tegra clk/power tree. This approach may not be suitable for other SoCs. 

> In any case, we designed dev_pm_opp_set_rate() (and its friends in
> genpd) with these locking issues in mind.

The device drivers don't manage the parent clocks directly and OPP core doesn't support this use-case where OPP needs to be applied to a generic/parent PLL clock. Moving the OPP management to the clk driver is the easy solution which works good in practice for Tegra, it also removes a need to switch each driver to dev_pm_opp_set_rate() usage.

>>> I guess this would be a valid scenario to optimize for, especially if
>>> you have more than one child domain of the core power domain, right?
>>>
>>> If you have only one child domain, would it be sufficient to assign
>>> ->power_on|off() callbacks for the core domain and deal with the
>>> performance stare votes from there instead?
>>
>> The core domain is the parent domain of the PMC domains + some devices directly belong to the core domain. The GENPD core aggregates the performance votes from the children domains and from devices of the parent core, this all works great already.
>>
>> It sounds to me that you're suggesting to reinvent the aggregation logic within the PMC driver and create a fake hierarchy that doesn't match hardware. It won't help the lockdep warning anyways.
>>
>> I actually don't quite understand what problem you're trying to solve, could you please explain? The lockdep warning is harmless, we just need to annotate the mutex lock class.
>>
>> If you don't feel comfortable with the usage of lockdep_set_class() in the driver, then maybe it should be possible to make it a part of the pm_genpd_init(). For example like we did that for tegra-host1x driver recently [2].
> 
> I was not trying to solve a problem, but was just curious and wanted
> to ask about the reasons for the lockdep_set_class(), as it simply
> caught my attention while reviewing.
> 
> Looks like there may be something fishy going on, but let's see, I may be wrong.
> 
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a24f98176d1efae2c37d3438c57a624d530d9c33
>>
>>
>>  LOCKDEP
>>  ============================================
...
> 
> Thanks for sharing the log.
> 
> Could you perhaps point me to the corresponding DTS files. I would
> like to understand more about the PM domain hierarchy and where the
> clock controller may be located.

https://github.com/grate-driver/linux/tree/master has all the latest versions of patches applied.

For example please see clock@60006000 and pmc@7000e400 nodes of [1].

[1] https://github.com/grate-driver/linux/blob/master/arch/arm/boot/dts/tegra30.dtsi

This is how output of pm_genpd_summary looks like on Tegra30 Nexus 7, where performance=voltage:

domain                          status          children                           performance
    /device                                             runtime status
----------------------------------------------------------------------------------------------
heg                             on                                                 1000000
    /devices/soc0/50000000.host1x                       active                     1000000
    /devices/soc0/50000000.host1x/540c0000.epp          suspended                  0
    /devices/soc0/50000000.host1x/54140000.gr2d         suspended                  0
mpe                             off-0                                              0
    /devices/soc0/50000000.host1x/54040000.mpe          suspended                  0
vdec                            off-0                                              0
    /devices/soc0/6001a000.vde                          suspended                  0
venc                            off-0                                              0
    /devices/soc0/50000000.host1x/54080000.vi           suspended                  0
    /devices/soc0/50000000.host1x/54100000.isp          suspended                  0
3d1                             off-0                                              0
    /devices/genpd:1:54180000.gr3d                      suspended                  0
3d0                             off-0                                              0
    /devices/genpd:0:54180000.gr3d                      suspended                  0
core-domain                     on                                                 1000000
                                                3d0, 3d1, venc, vdec, mpe, heg
    /devices/soc0/7000f400.memory-controller            unsupported                1000000
    /devices/platform/tegra_clk_pll_c                   active                     1000000
    /devices/platform/tegra_clk_pll_e                   suspended                  0
    /devices/platform/tegra_clk_pll_m                   active                     1000000
    /devices/platform/tegra_clk_sclk                    active                     1000000
    /devices/platform/tegra_clk_dsia                    suspended                  0
    /devices/platform/tegra_clk_dsib                    suspended                  0
    /devices/platform/tegra_clk_spdif_out               suspended                  0
    /devices/platform/tegra_clk_se                      suspended                  0
    /devices/platform/tegra_clk_hdmi                    suspended                  0
    /devices/platform/tegra_clk_pwm                     active                     1000000
    /devices/platform/tegra_clk_pcie                    suspended                  0
    /devices/platform/tegra_clk_afi                     suspended                  0
    /devices/platform/tegra_clk_vde                     suspended                  0
    /devices/platform/tegra_clk_vi                      suspended                  0
    /devices/platform/tegra_clk_epp                     suspended                  0
    /devices/platform/tegra_clk_mpe                     suspended                  0
    /devices/platform/tegra_clk_nor                     suspended                  0
    /devices/platform/tegra_clk_sdmmc1                  suspended                  0
    /devices/platform/tegra_clk_sdmmc3                  active                     950000
    /devices/platform/tegra_clk_mipi                    suspended                  0
    /devices/platform/tegra_clk_sbc1                    suspended                  0
    /devices/platform/tegra_clk_sbc2                    suspended                  0
    /devices/platform/tegra_clk_sbc3                    suspended                  0
    /devices/platform/tegra_clk_sbc4                    suspended                  0
    /devices/platform/tegra_clk_sbc5                    suspended                  0
    /devices/platform/tegra_clk_sbc6                    suspended                  0
    /devices/platform/tegra_clk_cve                     suspended                  0
    /devices/platform/tegra_clk_tvo                     suspended                  0
    /devices/platform/tegra_clk_tvdac                   suspended                  0
    /devices/platform/tegra_clk_ndflash                 suspended                  0
    /devices/platform/tegra_clk_sata_oob                suspended                  0
    /devices/platform/tegra_clk_sata                    suspended                  0
    /devices/platform/tegra_clk_fuse_burn               suspended                  0
    /devices/platform/tegra_clk_usbd                    active                     1000000
    /devices/platform/tegra_clk_usb2                    suspended                  0
    /devices/platform/tegra_clk_usb3                    suspended                  0
    /devices/soc0/50000000.host1x/54200000.dc           active                     1000000
    /devices/soc0/50000000.host1x/54240000.dc           suspended                  0
