Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689A3424F90
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhJGIy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhJGIy4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 04:54:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06690C061760;
        Thu,  7 Oct 2021 01:53:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u18so21603171lfd.12;
        Thu, 07 Oct 2021 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FD69cuvZkC5frBLfjKoSH67ZfStJ8NSIyGL77cvLjU4=;
        b=kZUE3L2Qdz1RASPPcawAIPwjstl13lFlpqEYDJU+JFBegHqLhO731K7OfXlliVog+3
         cJCyj6kyGy1u/kkulVUvLoz8X33Uz+ujUOZQqsB1E+JtXH+Pux594XX5WDJZgb/QautM
         w3bARkXOkUOBk8HLC3MFpYUCL+yRDk/ftqr+fR8Jzl1ZH8H7v5tcTVZDPZfyu/sJSyRr
         yj6/bGQUVqwxdcGMAgQe+urTCiqoIAX+h09nQdz8hQkjCbo8LpZ+OyjbLZAZS/Lrt/Pf
         Q/IeVYTqd6Dg5JF2uHuhB4HN/kHeW5NxN3O3+3b4iFoUx3b5aFaa3hUD9fOs/uUSeuw0
         Rnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FD69cuvZkC5frBLfjKoSH67ZfStJ8NSIyGL77cvLjU4=;
        b=m62WUpt1QsWhBUVtCRrF8klTf0aywzlT74xgofx3muUhjr/7CRjWA42KR9ukWnGZEU
         1FDyNw2bPQF1GfOzcg6sE5JdOUYxuyJ/Mvik0IfwTQTBgOtV6cCeLNb8Rn4ui2k5bnJx
         vMksu6HqVjGO2tho11ydRUcqFmwVP+PLfpwqoapqaG0HL4073+xGnL9Iy/zvtQG4lMkV
         JWq856vlN+mZBVc6MKXdiOxxDtkghWtH665spW+AYSvBh9Sq/jvVxIORIcPkEtFJDAl4
         kO6uQWYbcQW1LBO2HklvLEmEn8XDN2Fyidf+sskHI1xvCYlu6AISsaghj53MWwEhUBtj
         Ysiw==
X-Gm-Message-State: AOAM530CEdT0sUPjQqbwTPSfbED33iU1oUhUQZOEJ/SKo5z8PR4bbldk
        C5dOrZBkDSd+MNwCFnIdKb+LAzdOJyY=
X-Google-Smtp-Source: ABdhPJwEvnuZuywecghOTQy8+ySAzGDwf14DqcNddha50yLhvpBgOWLzPRJAGLtn1PU82MV4saOGSw==
X-Received: by 2002:a2e:98c3:: with SMTP id s3mr3475791ljj.430.1633596781205;
        Thu, 07 Oct 2021 01:53:01 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id v4sm1812991ljc.16.2021.10.07.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 01:53:00 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] Introduce power off call chain API
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20211007060253.17049-1-digetx@gmail.com>
 <CAHp75VeHC5M-Rv+wvJQEvmtfX0k7fP6uremGHFMnd8kEqPnBpw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e7763b75-205c-4e9f-ecdc-a32571a4b822@gmail.com>
Date:   Thu, 7 Oct 2021 11:52:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeHC5M-Rv+wvJQEvmtfX0k7fP6uremGHFMnd8kEqPnBpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.10.2021 10:18, Andy Shevchenko пишет:
> On Thu, Oct 7, 2021 at 9:05 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Introduce power off call chain API that is inspired by the restart API.
>> It allows to have multiple power off handlers invoked along the chain
> 
> allows multiple
> 
>> until system is powered off. For the starter this series converts couple
> 
> the system
> a couple
> 
>> NVIDIA Tegra drivers to the new API. Existing pm_power_off() method
>> stays around and may be removed once all users will adopt the new API.
> 
> users adopt
> 
>>
>> There were couple attempts in the past to add power off API from
> 
> a couple
> 
>> Guenter Roeck and Thierry Reding, but they were never completed. This
>> is a somewhat simplified version which doesn't try to convert whole kernel
>> to the new API at once, but solves immediate practical problem that we
> 
> problems
> 
>> have on Nexus 7 Android tablet where device needs to chain power off
> 
> tablets where the device

Thank you for the corrections, so far there is one problem and one tablet :)

> Immediate question here is how do you see the plan of spreading this.
> I.o.w. can you put an explanation that you have checked, let's say
>> 80% current users, and they may be converted like [example
> placeholder] without any special tricks?

The rough plan is:

1. Add new API.
2. Convert drivers to the new API per subsystem.
3. Expose do_kernel_restart().
4. Replace pm_power_off() with do_kernel_poweroff() per arch/, making
power off similar to the restart that uses do_kernel_restart().
5. Remove do_kernel_restart() from kernel/reboot.c

Majority of pm_power_off() users shouldn't need the chaining and
pm_power_off() doesn't conflict with the new API, so there is no need to
rush the conversion.

The single-link chain users could be converted to the new API directly,
this will remove some global variables. But at first should be better to
gain more users who actually need the chained power off since they may
have very specific requirements not covered by the current variant of
the API and will be easier to evolve API with less users.
