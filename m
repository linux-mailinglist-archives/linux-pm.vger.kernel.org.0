Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093213E09F0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 23:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhHDVRQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhHDVRQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 17:17:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD371C0613D5;
        Wed,  4 Aug 2021 14:17:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y34so6785524lfa.8;
        Wed, 04 Aug 2021 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ELMel+NgXNUbVBDl1ElReQSMK+VjDTt4MWlrQL3F4JE=;
        b=ovv9rOYVc7un9bnovJ98Ejbubj5lJJuDwAN/+gUDQwKXQKQh0gHvBTfXfWs50XX8dF
         08HAjDIM+/o510AMsTFC3o01a0ViL2DKp5sHpA34VD6A8EMXNq4VPSONpfmcYxRDMA7O
         uPgtoU4CwOoafa5BgZJhPeuQu2qfKq56+2F8nt0S/3KQK7rD/TFKxfteAeCTBNZPlysS
         tRsl2Gv24sUzPGF/Ce8gRpmYnqJNC7zOwBw2dHkD8Xpkj5sejZNveRPNxCVj9Bf7C/DE
         f8nG/BroJSt4FAfX3yeaaKErBd5SNm8XV8vpPD/gAEolxB2eJGk1LAliGhDGn/iIzDPU
         v4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ELMel+NgXNUbVBDl1ElReQSMK+VjDTt4MWlrQL3F4JE=;
        b=GKt/C88f59oWkNve3U/fWa5/FtOK+WabyDpddp5Rr41JFe5kGpgCWhO9iv4vE1G5ec
         BMNyBNQsZtYgGfGYpfmSWXHlSaDoaeh2pqeST+n50jeoRiJBhYL6QfdzG6tHtkstgdJI
         CfBpqlRGUX/Y6gsdflJUogVJXeXzMYQHXgJ9GziSSXY3jw9kIAUwzfzzFTCJe5hiL3Ml
         gsn7+fxx7Y3IYXthfDPG9Q7IlE2MsB3K8lqffbZ9kTflmXVnGYXZAIrGQMVty0MJTYg6
         mM0qd+VNGIuXQQOUzKs9NqyOlHuc195slhhfQYX6WyHutUO9hEk8F9EbD7QzDP9Cgzn5
         V2OA==
X-Gm-Message-State: AOAM531Qin+NKU1aMYQ/qgX67/mWNn4XEo5nndBvr5aYG72daxlF/6TF
        7yJ1eM/ANlbpA+RGx/hp1GXIqqC/b0g=
X-Google-Smtp-Source: ABdhPJxAjLTFmcOIodga4Y5U7tbSQyXBlsRLNHi9hRMvJM0pP9EsNVVaxWcT1fcobPzFinvr3P/oWA==
X-Received: by 2002:ac2:5315:: with SMTP id c21mr832592lfh.570.1628111819990;
        Wed, 04 Aug 2021 14:16:59 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id m16sm301501lfr.259.2021.08.04.14.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 14:16:59 -0700 (PDT)
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210701232728.23591-1-digetx@gmail.com>
 <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
 <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
 <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com>
Date:   Thu, 5 Aug 2021 00:16:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.08.2021 12:59, Ulf Hansson пишет:
> On Mon, 2 Aug 2021 at 20:23, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 02.08.2021 17:48, Ulf Hansson пишет:
>> ...
>>>> +       if (!list_empty(&genpd->child_links)) {
>>>> +               link = list_first_entry(&genpd->child_links, struct gpd_link,
>>>> +                                       child_node);
>>>> +               core_genpd = link->parent;
>>>> +       } else {
>>>> +               core_genpd = genpd;
>>>> +       }
>>>
>>> This looks a bit odd to me. A genpd provider shouldn't need to walk
>>> these links as these are considered internals to genpd. Normally this
>>> needs lockings, etc.
>>>
>>> Why exactly do you need this?
>>
>> We have a chain of PMC domain -> core domain, both domains are created
>> and liked together by this PMC driver. Devices are attached to either
>> PMC domain or to core domain. PMC domain doesn't handle the performance
>> changes, performance requests go down to the core domain.
> 
> Did I get this right? The core domain is the parent to the PMC domain?

You got this right.

>>
>> This is needed in order to translate the device's OPP into performance
>> state of the core domain, based on the domain to which device is attached.
> 
> So, the PMC domain doesn't have an OPP table associated with it, but
> some of its attached devices may still have available OPPs, which
> should be managed through the parent domain (core domain). Correct?

Yes, the OPPs are specified only for the core domain.

> Is there a DT patch in the series that I can look at that shows how
> this is encoded?

See patches which are adding domains and OPPs to DTs:

https://patchwork.ozlabs.org/project/linux-tegra/patch/20210701232728.23591-34-digetx@gmail.com/

https://patchwork.ozlabs.org/project/linux-tegra/patch/20210701232728.23591-35-digetx@gmail.com/

> Hmm, I have the feeling that we should try to manage in some generic
> way in genpd, rather than having to deal with it here.

Still it requires a platform-specific knowledge. It could be some new
genpd hook for the initialization. But I don't know what other platforms
may want to initialize, so it's not clear to me how to make it generic.

>>>> +
>>>> +       pd_opp_table = dev_pm_opp_get_opp_table(&core_genpd->dev);
>>>> +       if (IS_ERR(pd_opp_table)) {
>>>> +               dev_err(&genpd->dev, "failed to get OPP table of %s: %pe\n",
>>>> +                       dev_name(&core_genpd->dev), pd_opp_table);
>>>> +               ret = PTR_ERR(pd_opp_table);
>>>> +               goto put_dev_opp;
>>>> +       }
>>>> +
>>>> +       pd_opp = dev_pm_opp_xlate_required_opp(opp_table, pd_opp_table, opp);
>>>> +       if (IS_ERR(pd_opp)) {
>>>> +               dev_err(&genpd->dev,
>>>> +                       "failed to xlate required OPP for %luHz of %s: %pe\n",
>>>> +                       rate, dev_name(dev), pd_opp);
>>>> +               ret = PTR_ERR(pd_opp);
>>>> +               goto put_pd_opp_table;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * The initialized state will be applied by GENPD core on the first
>>>> +        * RPM-resume of the device.  This means that drivers don't need to
>>>> +        * explicitly initialize performance state.
>>>> +        */
>>>> +       state = pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_opp);
>>>> +       gpd_data->rpm_pstate = state;
>>>
>>> Could the above be replaced with Rajendra's suggestion [1], which
>>> changes genpd to internally during attach, to set a default
>>> performance state when there is a "required-opp" specified in the
>>> device  node?
>>
>> It's not a "static" performance level here, but any level depending on
>> h/w state left from bootloader and etc. The performance level
>> corresponds to the voltage of the core domain, hence we need to
>> initialize the voltage vote before device is resumed.
> 
> Why not let the driver deal with this instead? It should be able to
> probe its device, no matter what state the bootloader has put the
> device into.
> 
> To me, it sounds like a call to dev_pm_genpd_set_performance_state()
> (perhaps via dev_pm_opp_set_opp() or dev_pm_opp_set_rate()) from the
> driver itself, should be sufficient?

We did that in a previous versions of this series where drivers were
calling devm_tegra_core_dev_init_opp_table() helper during the probe to
initialize performance state of the domain. Moving OPP state
initialization into central place made drivers cleaner by removing the
boilerplate code.

I can revert back to the previous variant, although this variant works
well too.

> I understand that it means the domain may change the OPP during boot,
> without respecting a vote for a device that has not been probed yet.
> But is there a problem with this?

Domains themselves don't change OPP, there is no problem with that. The
point is to have cleaner code in the drivers.
