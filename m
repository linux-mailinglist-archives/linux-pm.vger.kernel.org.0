Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACC3DDF11
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 20:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhHBSYE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHBSYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 14:24:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC0BC06175F;
        Mon,  2 Aug 2021 11:23:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t9so22378692lfc.6;
        Mon, 02 Aug 2021 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A2cWlW6pgYuSWsahIzYgGPs6I4RK+uZng7TRkUqOaAw=;
        b=H1pn8GH7wXvWvYwTnbs7bdMHPlwqcM/iJScEzxQ/zAkWypusygPPbvku3eSuT190yN
         zPFRoZCvktkuxqoleBgK8y5Uzv5Fmeqd1bbhmRsU+8MxXxRw8T8y+0sHploztJ2+QVqn
         K58S/JnExlUO6oIXV0tFWcBYPeYiwBJRkgmKCMuWnC+4A28bNtIqaxlBVCyURf9FOwKk
         4FnjEmQtRKc+BFOug7/xn0azcogjPR+odU0hl0SM8YwaLE6GnhT3w/niXT/0cWqbRgq8
         MzqMNgzev0LA/KsZ9+9+qg6oaNg1l98gmbVMYv/uMejRIVq6umScHxBgKK4OnEdG/ZwO
         QAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2cWlW6pgYuSWsahIzYgGPs6I4RK+uZng7TRkUqOaAw=;
        b=ZFSD4EGWeLsfw4QOuveV6jasRhvNynglh6HqG6ZA8RYH5HylrqMJKvnjyYYBlHMDhn
         PQr5g5yuZBFFdppkcIIN6G1YjSaa5mrvtgkWSJA0EYr3BCODDW8RXHvtIuPtxhQqdxV2
         kQ0h6tC40sjHDNhRB2BKNj1sqIjdvXMl9qWCTrdbUIo+O49VJzVKe0geSes8bABOB4ab
         sGN4PZWxJ/o44k1THFldvoDiPVrSsiWFuZ5tagYMcZ/PBLbngEgkozzHn/csgehGaVNG
         ITDf0+A8a66KOiwUJImd4erhk4UrYjPMneHD7AuNqCkRNWzbwShYwOXj+3PSPzz3OyrN
         wdKg==
X-Gm-Message-State: AOAM533pOkVgSmLC5ZyuodLAhPrRF9AVFVXidBfbFXDyNHgo3iLFiDHg
        iBshAneJJDV4f8v5yiQuzesFjaLwxPk=
X-Google-Smtp-Source: ABdhPJxmeetaV9/wDLh3f6TYJLqFwfzcDKekE86b0K3MFq343cGfeWSlBYy2uLtfZPYyOQFzUh4IaA==
X-Received: by 2002:ac2:5f78:: with SMTP id c24mr13366081lfc.199.1627928632378;
        Mon, 02 Aug 2021 11:23:52 -0700 (PDT)
Received: from [192.168.2.145] (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.googlemail.com with ESMTPSA id f23sm911482ljm.34.2021.08.02.11.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 11:23:51 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
Date:   Mon, 2 Aug 2021 21:23:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.08.2021 17:48, Ulf Hansson пишет:
...
>> +       if (!list_empty(&genpd->child_links)) {
>> +               link = list_first_entry(&genpd->child_links, struct gpd_link,
>> +                                       child_node);
>> +               core_genpd = link->parent;
>> +       } else {
>> +               core_genpd = genpd;
>> +       }
> 
> This looks a bit odd to me. A genpd provider shouldn't need to walk
> these links as these are considered internals to genpd. Normally this
> needs lockings, etc.
> 
> Why exactly do you need this?

We have a chain of PMC domain -> core domain, both domains are created
and liked together by this PMC driver. Devices are attached to either
PMC domain or to core domain. PMC domain doesn't handle the performance
changes, performance requests go down to the core domain.

This is needed in order to translate the device's OPP into performance
state of the core domain, based on the domain to which device is attached.

>> +
>> +       pd_opp_table = dev_pm_opp_get_opp_table(&core_genpd->dev);
>> +       if (IS_ERR(pd_opp_table)) {
>> +               dev_err(&genpd->dev, "failed to get OPP table of %s: %pe\n",
>> +                       dev_name(&core_genpd->dev), pd_opp_table);
>> +               ret = PTR_ERR(pd_opp_table);
>> +               goto put_dev_opp;
>> +       }
>> +
>> +       pd_opp = dev_pm_opp_xlate_required_opp(opp_table, pd_opp_table, opp);
>> +       if (IS_ERR(pd_opp)) {
>> +               dev_err(&genpd->dev,
>> +                       "failed to xlate required OPP for %luHz of %s: %pe\n",
>> +                       rate, dev_name(dev), pd_opp);
>> +               ret = PTR_ERR(pd_opp);
>> +               goto put_pd_opp_table;
>> +       }
>> +
>> +       /*
>> +        * The initialized state will be applied by GENPD core on the first
>> +        * RPM-resume of the device.  This means that drivers don't need to
>> +        * explicitly initialize performance state.
>> +        */
>> +       state = pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_opp);
>> +       gpd_data->rpm_pstate = state;
> 
> Could the above be replaced with Rajendra's suggestion [1], which
> changes genpd to internally during attach, to set a default
> performance state when there is a "required-opp" specified in the
> device  node?

It's not a "static" performance level here, but any level depending on
h/w state left from bootloader and etc. The performance level
corresponds to the voltage of the core domain, hence we need to
initialize the voltage vote before device is resumed.
