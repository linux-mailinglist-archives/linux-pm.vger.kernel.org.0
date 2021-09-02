Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D971F3FEAC4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhIBInm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbhIBInj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 04:43:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D110C061575;
        Thu,  2 Sep 2021 01:42:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l18so2109789lji.12;
        Thu, 02 Sep 2021 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1GCpFqrQWxKucU/U8kvbQXzC/KZMeJhASpAkd3c1XY=;
        b=CWh0uGll6zC5I3WADyO3hiRkmkkHjP6Oc8uQF3NXld/qqQGHOHlYYmgnmrGb98+ZsE
         r0VZ/1cILVzZiOpgYvZ7hewaDV43+81ZgT+uy89KPJwaeWVilYXij3AZ7Q3JjH0yFpxg
         JHTQscy0qDmoK2ooQaE/9xdATlahJ0fKwtQZTWfl1b4ijUVBBJ+TWA2fp6DCIyy6zzay
         OhASbtiNu+K9tfW0pSQQE3DMSEEEzGAQAUldgczLUURrducbpXyjMrcxk3h34VQD66Kz
         5TkA0V44x613AH72KvYxttM3rXG1KglgCuYfWnn8DawPIroN+d8YavzJyddDKURBV1Cw
         VmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I1GCpFqrQWxKucU/U8kvbQXzC/KZMeJhASpAkd3c1XY=;
        b=X03MnAeljfkBOYVqwJzqcUQdk6mMJ3f8saXWIdSLGdarf0tThRZqlrvkab612QW9+7
         7ZBX9ttQmctKtsmry14Jw9DAke4gFMczMhD5K6HbOZDoJWh4UbIgo0x2fGpuF2sly9W8
         YAwtGqtSBipbsacGBTgP/OjiLLrWVJHN5fyfis/KnBvr5RUOCYlOu4s9rM8CVHp2MLHQ
         xPr1aDVatPP8c/N/oSM8gQXKZuZT+XAmmpMeoYldzJy8h1Jn7doLrsoab5wUsaQtT/9k
         z787SvKfV5GDY3CQZr9kuRBJEPua79RvMt10W8ZkhoqDKWd8FNNLjDDEJBeTVavJs8gm
         qOVQ==
X-Gm-Message-State: AOAM533EzrKJtax8kMJxzdH8RG7mjEVqQkqstJvnaCuflh6UFaeDKhem
        UKfq9ru7nADeav0v24OqNqcZ8WSEQdo=
X-Google-Smtp-Source: ABdhPJx4oZjAD3wHpy6mhVYFMOjQ5IqN+y5KKpUHAxvyErW59LfBqfh7GGymysgFDGFoSGta1l9N2A==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr1597518ljh.190.1630572159481;
        Thu, 02 Sep 2021 01:42:39 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id n25sm133809lfe.125.2021.09.02.01.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 01:42:38 -0700 (PDT)
Subject: Re: [PATCH v10 4/8] PM: domains: Add dev_get_performance_state()
 callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-5-digetx@gmail.com>
 <CAPDyKFp4M30y9UB5Ss54ZfNjL_a6nqbka6Dq7xtGNzb2Mg8WrA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a705b35f-8ece-bf74-b7db-7c4ded19e43e@gmail.com>
Date:   Thu, 2 Sep 2021 11:42:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp4M30y9UB5Ss54ZfNjL_a6nqbka6Dq7xtGNzb2Mg8WrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.09.2021 19:59, Ulf Hansson пишет:
>> +static int genpd_dev_initialize_performance_state(struct device *dev,
>> +                                                 struct device *base_dev,
>> +                                                 unsigned int index)
>> +{
>> +       struct generic_pm_domain *pd = dev_to_genpd(dev);
>> +       bool state_default = false, suspended = false;
>> +       int pstate, err;
>> +
>> +       pstate = genpd_dev_get_current_performance_state(dev, base_dev, index,
>> +                                                        &state_default,
>> +                                                        &suspended);
>> +       if (pstate <= 0)
>> +               return pstate;
>> +
>> +       /*
>> +        * If device is suspended, then performance state will be applied
>> +        * on RPM-resume. This prevents potential extra power consumption
>> +        * if device won't be resumed soon.
>> +        *
>> +        * If device is known to be active at the moment, then the performance
>> +        * state should be updated immediately to sync state with hardware.
>> +        */
>> +       if (suspended) {
>> +               dev_gpd_data(dev)->rpm_pstate = pstate;
>> +       } else {
>> +               err = dev_pm_genpd_set_performance_state(dev, pstate);
>> +               if (err) {
>> +                       dev_err(dev, "failed to set performance state for power-domain %s: %d\n",
>> +                               pd->name, err);
>> +                       return err;
>> +               }
>> +
>> +               if (state_default)
>> +                       dev_gpd_data(dev)->default_pstate = pstate;
>> +       }
>> +
>> +       return 0;
>> +}
> As I kind of indicated in my previous reply on the earlier version, I
> think the above code can be made a lot less complicated. Although,
> perhaps I may be missing some points.
> 
> Anyway, I will post a couple patches, later this evening or tomorrow,
> to show more exactly what I had in mind. Let's see if that can work
> for you.

It's not obvious what you're wanting to improve, I'm probably missing
yours point. So indeed will be good to see the code sample, thanks.
