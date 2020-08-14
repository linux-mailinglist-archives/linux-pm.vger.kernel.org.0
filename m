Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC182244E3C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHNRxk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgHNRxj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 13:53:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A24C061384;
        Fri, 14 Aug 2020 10:53:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so5236486lfe.10;
        Fri, 14 Aug 2020 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1sUTWBUIPKO37P0lkqPAAoPd12fhovrUXjY7Y2QOAA8=;
        b=cC/K+J7+hu48LaNPdtU86F6S2jC38HU2Y8+CHRnRaB2/My6nLqOB26YsOQLLw9cFQH
         YK4EIQ1XFBFZ9HM3AiHipfU8qJ1ukLTFn93A7Ac6CsXNu/iGgrl7iP4QFTJRajZcdHIp
         q3UHMaXaQuhCZyngxoWd4K4Yyp40Xcw/XRa63gOOSQUDQzmsJwDDtd5zdLK6IcQujfZK
         5uYoy/bfdqqgcFQLUj6cQ/z0qfjwxTBv10lZLMtYZypOURt3n3AIEgMELJVWyeSg+juN
         CAqRf/T/36m7GceOfkBk/5V1Z0yLC+iswPMlQpC+vGQRG3C5sYdtr2pev/A2sLIS5UFA
         x7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1sUTWBUIPKO37P0lkqPAAoPd12fhovrUXjY7Y2QOAA8=;
        b=ccA3+uDZ/V09zlIDk+nGEFbEwac1q9dYVTjetoL1smfmMX3i4HOr7Bu8346qF9iuWS
         pw3je/TBWTWtsSyUvClcAQhsElowWZbQHhgxXgNewteWAT98yzYHYeLj5NBzG8gts09L
         EDb3A6fyjL85j9MNxemkkv+eEWDj0c72PWu9uMGgMijV9TfikDUKfepgt+HeABnLuv6e
         RvNjN1cVL/ZEZSYlbimBq5FuajSKHLYJjvE9MsgQ5CCPPo27HELpkGZo71EhZ+GdshN6
         Tq5YWJMQy61GDE8Yd9trheqQV8DRYlHr+d5NWsWaIG6wl3nBmTv92Cm6rELHgjvGGegi
         L+Dw==
X-Gm-Message-State: AOAM533g3DjBpPXTqpH6sa3XN13HRJXISOaCzRi0YCRHS8/u0vmdVTJf
        CNZwrN0oNyKqxB5sJnx5l6x/FETf8iM=
X-Google-Smtp-Source: ABdhPJwr8NmlymrxjdJ9qpa67z9oE9f9YLWy5VCGV+mjs21CLT39KYmGhbu1VuvHGaO58330puc7CA==
X-Received: by 2002:a05:6512:5c7:: with SMTP id o7mr1779728lfo.124.1597427617525;
        Fri, 14 Aug 2020 10:53:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 203sm2028329lfk.49.2020.08.14.10.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 10:53:36 -0700 (PDT)
Subject: Re: [PATCH v3] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200709173532.15431-1-digetx@gmail.com>
Message-ID: <69c57c9c-a8e4-2367-3f72-232b6b3456b8@gmail.com>
Date:   Fri, 14 Aug 2020 20:53:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709173532.15431-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.07.2020 20:35, Dmitry Osipenko пишет:
> The enter() callback of CPUIDLE drivers returns index of the entered idle
> state on success or a negative value on failure. The negative value could
> any negative value, i.e. it doesn't necessarily needs to be a error code.
> That's because CPUIDLE core only cares about the fact of failure and not
> about the reason of the enter() failure.
> 
> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
> the entered idle-index on success. Unlike some of other drivers, it never
> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
> driver, and thus, there is no problem for the cpuidle-tegra driver created
> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
> returns a error code.
> 
> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
> see the error code from arm_cpuidle_simple_enter() today.
> 
> Of course the code may get some changes in the future and then the
> typo may transform into a real bug, so let's correct the typo! The
> tegra_cpuidle_state_enter() is now changed to make it return the entered
> idle-index on success and negative error code on fail, which puts it on
> par with the arm_cpuidle_simple_enter(), making code consistent in regards
> to the error handling.
> 
> This patch fixes a minor typo in the code, it doesn't fix any bugs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v3: The tegra_cpuidle_state_enter() now returns entered idle-index on
>     success instead of 0. Hence the error message will be shown by the
>     tegra-cpuidle driver if arm_cpuidle_simple_enter() will ever fail.
>     Again thanks to Jon Hunter!

Hello, Jon! Do you see anything else that could be improved in this patch?

