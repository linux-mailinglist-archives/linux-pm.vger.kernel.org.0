Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3125DE9F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgIDPy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDPy4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 11:54:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D568C061244;
        Fri,  4 Sep 2020 08:54:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so2144187ljp.13;
        Fri, 04 Sep 2020 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EqeV5GEwpLCEYW39izvLrI1V3Ff38lvkS7tHlLnnMxs=;
        b=DssenJ5M9KIfi6BE9jD/OI9v5CzIF/fPDV+WuIb9FArUFM3ZBbk7peirj6rRfKnljd
         jljpvH0T1P89IudOqYBEi1p/6AoerHB6T5dLCCJExhpIf9Mh440xmmwmYkv+kPN981gh
         FDIxduBgre/xQV28L+LlzXiTNa0QSd9HrBnc+soPXc4DZ7smtLiV+qK5sTAjB7nj+mpq
         8iqRkqp7nMybTI89mrtaf5xvKKfwrTHMguTodpCzGfR7kfKJlQ/OXu/M3sZYkVVUO+pC
         JvZfKQ0b/baOFr1DxDda9wUv1HqmDK4hLwuxRaLsedl6SKCygROjNR0auySXvMLkJfJJ
         aaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EqeV5GEwpLCEYW39izvLrI1V3Ff38lvkS7tHlLnnMxs=;
        b=MWPXhdiGPlLPC8HWyO4dNHAzjypcwaI9eMEMo3+9VvGxjpZkEe20todiTe31EChIgo
         h03c1UoRngOn7IcZOsD8EISsZqEkPB9IczTIQsda1DUcbzjw1ulLeyFdnWZjmU6cIkRH
         8GpNXI5OfEdhqIs9/3frKYYQIvoaK1D+Z0EsJ/yWSGprD49IgEAYJceFo3TywoT9h/pv
         IBkP831G15+/C2WNfXi/rMLxMW5WcUWwkve/XpU4Eb91zL7Dn5tKuFBij96EFCjgWjuP
         MPbE6f2U25b9mugVkytPc+KgbOSOLSm0q2zHaJABpLgWNcV4AFqF0S56WBE7AhFtTG1A
         Ic7A==
X-Gm-Message-State: AOAM532dqkP8jHcYlAi5rCEAsM4h5BIdQdHRoJn94lJn2BfbaFmcWIU6
        Bm9e4O11XEkZglyqegBhtbvM9UiSOfo=
X-Google-Smtp-Source: ABdhPJz5FifqYk3SjmTOueHmmnT5Ltqf/CqnsxxulfweyJbL6UPMKd91CsOuPbUe7o5Lcw9KxUjxew==
X-Received: by 2002:a2e:9910:: with SMTP id v16mr3920272lji.59.1599234894481;
        Fri, 04 Sep 2020 08:54:54 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id g19sm1333483ljk.125.2020.09.04.08.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:54:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20200830185356.5365-1-digetx@gmail.com>
 <20200830185356.5365-2-digetx@gmail.com> <20200903161022.GA2707794@bogus>
 <790dbb23-7422-887a-3f11-5ae55bb916fa@gmail.com>
 <CAL_Jsq+Ue72jJ9gurcG0f_R+gGVC77dErhgbKpB_p40buUewLg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <40e34696-5af8-a3da-35f2-483a0dacd835@gmail.com>
Date:   Fri, 4 Sep 2020 18:54:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+Ue72jJ9gurcG0f_R+gGVC77dErhgbKpB_p40buUewLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.09.2020 18:40, Rob Herring пишет:
> On Fri, Sep 4, 2020 at 6:07 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 03.09.2020 19:10, Rob Herring пишет:
>>> On Sun, 30 Aug 2020 21:53:51 +0300, Dmitry Osipenko wrote:
>>>> Add binding document for the ENE KB930 Embedded Controller.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>>>>  1 file changed, 66 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
>>>>
>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ene-kb930.example.dt.yaml: battery-cell: 'operating-range-celsius' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
>>>       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/battery.yaml
>>>
>>>
>>> See https://patchwork.ozlabs.org/patch/1354004
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure dt-schema is up to date:
>>>
>>> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>>>
>>> Please check and re-submit.
>>>
>>
>> Apparently bot uses outdated kernel.
> 
> It's on v5.9-rc2. The scripts don't know your base/dependencies and
> neither did I because you didn't mention anything here. I do review
> the errors before spamming people.

The patches are based on the linux-next, hence nothing special here. My
expectation is that the bot should use the linux-next as well in order
to prevent such warnings. Is there any reason to why bot not using
linux-next?
