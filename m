Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B44290451
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405099AbgJPLsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394876AbgJPLsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 07:48:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29195C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 04:48:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p15so2149361wmi.4
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tkJ6vBaz3G5IwdB8Lg8ppojVTnQOkfwjYi/pmtrKvtY=;
        b=K3AUdSrJUNqBT+9eMbnfsnzyoaatQyFjkJArkqEqxkFZaEQX2ySi7qZuZKv9jzzBi7
         docQAuack5TT+lb31NtHVnC+oiI8fWpB3sYS95ITCmIss6IyRdKsHluTXINkGuTcPLXt
         /nOkbXExWurUdksNsHVHin7d+mlu00PGEdplcS1+GqhjjZ8OtvewBp/7Sm1UggbrhZ3q
         nE7KP+vyIW7Uejuybg6KiZNsU5Rb85H5hwjLNK2nGmtCsd57eFArsC1DaxHSECGMYt1p
         Guu24o42dbd3i8hIe2Ql++aFiHrxCR+vC3HEjNcZA5swI6ppmjXb+e3zFuCxZXOj8Qhq
         x+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkJ6vBaz3G5IwdB8Lg8ppojVTnQOkfwjYi/pmtrKvtY=;
        b=TbyGgvma5EzN/Y9KJSP8CjxpjUsP4GjqEusjXwwAWpIVD/pzpbViUNzk9hJDmNXTJ6
         Bey91UHkhHV3sQDMrNCNwwm7UdWGH0Efn3SjIr6MiVTKRFxcqBZyo/zbW6rRLErZ9jw8
         baGtR0YJAN7qEnF4Gdz9OCpgFLHKWKqE8fUWKzzX7m6knPSCwjIp7gFH19DQbBgYlqrm
         ydukqAW2P/2rx25CAzcotg1EavNRyTxlhlFkNZ1CdePxiKkiSD2WtA69j0HXFo4RgMyq
         /VB7GKI5NVLR8ypSyk0BVL42VytW9CDBkr3lP13NwAL7Xo0UWWTFYhx3oNrtf1eQf3wg
         U11Q==
X-Gm-Message-State: AOAM530LmOsIrQTeU44rMqDKAPcT9oiNUN4hPu0OHaAac2HPq0VuT+Yu
        86nWlurb1J6eGxHrZq0O2UTzhg==
X-Google-Smtp-Source: ABdhPJzIh0gyjgnwTmNsufvBdiYn1uCOXZAh0ZgDPqxiAQnmADiHb5tQAhCutRDRz/iqz/gBUwIPFw==
X-Received: by 2002:a1c:2681:: with SMTP id m123mr3316003wmm.138.1602848915555;
        Fri, 16 Oct 2020 04:48:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d8:1700:5168:39b? ([2a01:e34:ed2f:f020:c9d8:1700:5168:39b])
        by smtp.googlemail.com with ESMTPSA id 24sm2467947wmg.8.2020.10.16.04.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:48:34 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
Date:   Fri, 16 Oct 2020 13:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/10/2020 15:40, Rafael J. Wysocki wrote:
> On Thu, Oct 15, 2020 at 12:22 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:

[ ... ]

>>> We would allow to co-exist em_dev_register_perf_domain(..., false)
>>> with dev_pm_opp_of_register_em() EM devices.
>>>
>>> Is it make sense?
>>
>> Well, it does not change my opinion. We should assume the energy model
>> is always milliwatts. If the SoC vendors find a way to get around with
>> bogoWatts, then good to them and up to them to deal with in the future.
> 
> That sounds fair enough, but it also means that any kernel patches
> using power units different from milliwatts for the EM should be
> rejected in the future, doesn't it?

Actually there are two things: the units and the numbers.

The energy model is expressed in mW.

All the frameworks (EAS, IPA, hopefully DTPM) using the energy model
should stick to the same unit, which I believe makes sense.

The numbers are provided by the SoC vendor or any contributors [1][2].

The different frameworks depends on those numbers.

If we specify in the documentation we support abstract numbers for the
EM, then that will imply any framework using it will have to comply with
that.

My point is we use milliwatts as a reference.

If we want to support abstract values, then the code should be changed
by *explicitly* use with these values, so if the other frameworks are
expecting real watts, they can detect they are not available and take
another action, like the scmi scaled power numbers and the
sustainable-power of the thermal which are incompatible.

If the consistency across the frameworks is guarantee by identifying the
kind of values (abstract or real), then we can put in the documentation
we support abstract value.

Unfortunately, IIUC, scmi does not tell us if the power numbers are real
or abstract ... :/

I don't see how we can ensure a consistency across the framework without
enforcing a strong policy.

> And the existing code using different power units for the EM (if any)
> should be updated/fixed accordingly, shouldn't it?

Currently, the power units are expressed in mwatts for the energy model
and the frameworks using it.  AFAICT, no change is needed if we keep mW.

If we use scaled numbers, the EAS will work correctly (but the energy
values will be incorrect), but other frameworks won't.

The power numbers are provided by the DT (as supposed real), or by SCMI
(real or abstract).

If the SCMI is returning abstract numbers, the thermal IPA governor will
use these numbers as a reference to mitigate the temperature at the
specified sustainable power which is expressed in mW in the DT. So it
does not work and we can not detect such conflict.

That is why I'm advocating to keep mW for the energy model and make the
SCMI and DT power numbers incompatible.

  -- Daniel


[1]
https://patchwork.kernel.org/project/linux-arm-kernel/patch/1500974575-2244-1-git-send-email-wxt@rock-chips.com/

[2]
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20190604165802.7338-2-daniel.lezcano@linaro.org/#22686211

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
