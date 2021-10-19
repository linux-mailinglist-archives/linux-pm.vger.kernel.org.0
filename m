Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348FD433FFC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 22:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhJSUyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 16:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJSUyN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 16:54:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F43C06161C;
        Tue, 19 Oct 2021 13:51:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s19so8464666ljj.11;
        Tue, 19 Oct 2021 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G7qwr2Tn9hf9lesJD/Db4IBpXW2EeZKyA2WDSHyoBgE=;
        b=NcHIZ/b/jQIJNFN8E9x67a6l3qpkGJtyBwX5tfhhG8ClJzF5t/0e0BzGo0AaMPi1sW
         2rlOkgFeIamyNrWbuoDjs9yheW66Z9qe4oxE8AL+TlawkcnQkGosFJj0L4RP2yHDQTdg
         5RqPbphtMf/ohwndNjCyjrzAa/hvz3rgPzcq4UDoOGOI9dYWzjmdnby9yFyJnVfxhpkk
         OvnrFZ10nv6DEgkyiOHhnBJFufBPNpzwpb68qDc0o8fT4BEbPWjE2+wssCSH4xM0scaI
         qv6TYbiAiNR11McbwzD6FF+SuyEaooybxuD6+Qb/N1eKEjtK9HnHPQ6u8E6yraOVKFRo
         3Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G7qwr2Tn9hf9lesJD/Db4IBpXW2EeZKyA2WDSHyoBgE=;
        b=B8pt2gOKf2Ys1W00optKvY+BqHKpiR2Z35Kf4rNoLJZTTJXNXzHnOGwH4BqT7ePCVx
         FZss+OQs+ZSkFdjCmvbwr/sIIZCFVL5+LzYbtxsJ1ulZpfbRTJiN33dTDu8gWtPiYXlr
         wBW/jJSnHhPhfK7WTh1P6RaHJDznZMT7phFBblxi73e4IR5oBEai0x9lDciU9fxrraMZ
         h1armlm6Vv67J6gGpevPOuYgaptusx663J0JliB4zJ7U/VkYolebsoYMEbUvjaGQCAbS
         qsFRkEtfLqYbr0vTEG+GrS1Z/D1JZH8eAfVAvdcNchQLN/QiBZsAmt/ExFm1ZQZgLJYk
         NadA==
X-Gm-Message-State: AOAM532mNYEq2HRT2Xb5YjiWEaWW0nPIS2c0YdKJk59PF3QI3LpwO1U/
        JInetwRj/D7vpK3WUlmDN797HpWoAXw=
X-Google-Smtp-Source: ABdhPJw5rl0M7vhAOyhjzlSRXOdFqJxYZiK6HqOugk5MbOmToxZpxdULdyGyIx60L5Px3IsuETozUg==
X-Received: by 2002:a2e:994:: with SMTP id 142mr9123423ljj.481.1634676718023;
        Tue, 19 Oct 2021 13:51:58 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-10.dynamic.spd-mgts.ru. [94.29.39.10])
        by smtp.googlemail.com with ESMTPSA id x24sm11283ljd.89.2021.10.19.13.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 13:51:57 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] mfd: max77620: Use power off call chain API
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211007060253.17049-1-digetx@gmail.com>
 <20211007060253.17049-5-digetx@gmail.com> <YW7k0SW73kcvyo2W@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c488d332-46b3-2250-cd96-34897189562f@gmail.com>
Date:   Tue, 19 Oct 2021 23:51:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YW7k0SW73kcvyo2W@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.10.2021 18:31, Lee Jones пишет:
> On Thu, 07 Oct 2021, Dmitry Osipenko wrote:
> 
>> Use new power off call chain API which allows multiple power off handlers
>> to coexist. Nexus 7 Android tablet can be powered off using MAX77663 PMIC
>> and using a special bootloader command. At first the bootloader option
>> should be tried, it will have a higher priority than the PMIC.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mfd/max77620.c       | 22 +++++++++++++++-------
>>  include/linux/mfd/max77620.h |  2 ++
>>  2 files changed, 17 insertions(+), 7 deletions(-)
> I don't have a problem with the approach in general.
> 
> I guess it's up to the relevant maintainers to decide.
> 

Thank you for taking a look at this. Guenter Roeck gave me advice based
on his previous experience of working on this topic and I'm now in a
process of finalizing v2 that will be a more comprehensive and nicer
solution. So you will need to take another look soon, thanks.
