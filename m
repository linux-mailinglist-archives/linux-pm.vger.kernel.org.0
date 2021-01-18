Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22F92FA92B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 19:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393770AbhARSpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 13:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393772AbhARSp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 13:45:26 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AFC061573;
        Mon, 18 Jan 2021 10:44:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m13so19247392ljo.11;
        Mon, 18 Jan 2021 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9tPZEWAJ0kOhm4O/8sptvQx+KLZAi/Ezlz9DZ5Lzzw=;
        b=HIcMkOkLlSoHWH3wqzkEPBCe0BQob75nBypcfRmK6i63y0gf0bkSc/PdWSL9c5MYbY
         Ogeh+SIoeKxe+uqHId3F49qJBx7c8DrpIho8Wnh36zuOiPNEytc/u14af5tSfrhFzVzH
         U3H+kpsCBdtfL4oRjt5i/Wob0/Snk23HWwqe6pkjaFWHPErTajhSqqQiJrCpSR8OED1X
         79Y5owxTBaHBIXrmCeGSzOg5HU2kFPgoNxKzJWF5ehTJ8heEaF5dheZgQx52rngyqqE4
         RHDD+lwxnH+ba2409CU5UdLoI4FAgDF6qmWe1MTn0L8mdQBOHAKF03k57hYP4ziDLZXH
         2gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9tPZEWAJ0kOhm4O/8sptvQx+KLZAi/Ezlz9DZ5Lzzw=;
        b=mLXgkXPi/+/kbkmaicTz01w4J4yKBBvY+ZnOb9ImJxQwYcylzuUw0qcKoiMhsXkjfG
         nRYMqHh5s/vWNqY9QLIr4KsDmg6V6KRIN0Lczxfj+gIyQPCWc8J4HBGuWKo/jNDt6on/
         UWebOLjgDUUKF+KK6vFVI1zPVA/n30dpeqqkGKJVAkwZNo4Yp+vezAN9rmdbzGgM+EsM
         1BUWiqoAyVqqvECI5e+dKPvbmlGgW2mMClKePv80m8ZZQyNSuPTar0o3JJO90TsUye1p
         lpQ9DCAf6PK07ee6Eq3JTT2/thuxOJEhf2g+e+FGKvNq74YJ8feXHAtcZ8Sv/eQq1EGS
         D4Iw==
X-Gm-Message-State: AOAM532LARdTW0NiOM44aplWYfnKPVK+sHmnNu4tYuGJp+xOthLgTxUH
        4zlkkt1Y+1UthuO0AtvE5noXvyecoLc=
X-Google-Smtp-Source: ABdhPJzqPEioWPRzst3A8xaUpHPO8uguVNXO608ISL5tUcGmJmqGr6eq4B3RTHyUtokS/sEtJ91yIg==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr386000ljn.44.1610995484516;
        Mon, 18 Jan 2021 10:44:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id i27sm1865991lfo.213.2021.01.18.10.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:44:43 -0800 (PST)
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state() callback
 optional
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210118011330.4145-1-digetx@gmail.com>
 <20210118011330.4145-2-digetx@gmail.com>
 <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
 <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1e54674e-000d-d3a1-6123-715f8f445726@gmail.com>
Date:   Mon, 18 Jan 2021 21:44:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 13:59, Ulf Hansson пишет:
> On Mon, 18 Jan 2021 at 08:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 18-01-21, 04:13, Dmitry Osipenko wrote:
>>> Make set_performance_state() callback optional in order to remove the
>>> need from power domain drivers to implement a dummy callback. If callback
>>> isn't implemented by a GENPD driver, then the performance state is passed
>>> to the parent domain.
>>>
>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
>>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/base/power/domain.c | 11 +++++------
>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 9a14eedacb92..a3e1bfc233d4 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -339,9 +339,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>>>                       goto err;
>>>       }
>>>
>>> -     ret = genpd->set_performance_state(genpd, state);
>>> -     if (ret)
>>> -             goto err;
>>> +     if (genpd->set_performance_state) {
>>> +             ret = genpd->set_performance_state(genpd, state);
>>> +             if (ret)
>>> +                     goto err;
>>> +     }
>>
>> Earlier in this routine we also have this:
>>
>> if (!parent->set_performance_state)
>>         continue;
>>
>> Should we change that too ?
> 
> Good point! I certainly overlooked that when reviewing. We need to
> reevaluate the new state when propagating to the parent(s).
> 
> To me, it looks like when doing the propagation we must check if the
> parent has the ->set_performance_state() callback assigned. If so, we
> should call dev_pm_opp_xlate_performance_state(), but otherwise just
> use the value of "state", when doing the reevaluation.
> 
> Does it make sense?

I played a tad with the power domains by creating a couple dummy domains
and putting them into a parent->child chain. Yours suggestion works well
for the case where intermediate domain doesn't implement the
set_performance_state() callback, i.e. the performance state is
propagated through the whole chain instead of stopping on the domain
that doesn't implement the callback.

I'll make a v4, thanks.

