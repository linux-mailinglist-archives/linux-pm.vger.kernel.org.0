Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7154EED8EE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 07:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfKDGUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 01:20:45 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32904 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfKDGUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 01:20:45 -0500
Received: by mail-ua1-f66.google.com with SMTP id c16so4603476uan.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Nov 2019 22:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqnI11jDeJSRHyM2MOO2KtRFnVVeWq77J5QgehQH3Yk=;
        b=RQ77MhLt9LdQKzG8hK4rrW7/sLslhIyUun4obwjXSY8v+ddub1GYwP7mKrIytVSomD
         AyBiXExGnjQazPg432Kk6TX5UPWdJYEyPT5BnUki2NoqwQrRr5MgD+vcop6+TrQfnVDk
         FvZl1H5NEt2b+WN+pSK7UkjDEG/hJHD/eCzHUNPQM7qPscT8HVsW6tv4POQvAvA1Ly0C
         6kZ9rTzyjlpYkodbaHgBNOJU3XSRji7HgTpK6N3qb0RTpONp3gBoVjVPC5JIBcZP1Sxz
         pSPxik2Iq4tobtxHWAqsQtBiZCr9K2/Xuv8nCJsxeoy07Y4yE3o6RoBM5mlnJRJyYwmE
         R94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqnI11jDeJSRHyM2MOO2KtRFnVVeWq77J5QgehQH3Yk=;
        b=lvEUhwQG7ZzzzQSva3QoyMspP5Hg5e1NDBEF20jQrtXVZASL1xBc5Tcy+ckOHPMYVR
         j7NucCjs220mhw4RpLwqkQhZLc35mX/cp9OZbfUJrBZGluNgyEebCHfs6slopgyisptM
         ynYaQA7pVOMHnzKVqCKOnCQL9W7KK26cxxhs0Ms7bjIfq/kxxgvCaHLD9GJfqmAgUnmY
         bUTGDbZAyfJgUX9x+5uT4THpEbXLYK+RlFPZR5VS95WKjtPSLWTpPijmsqKllMzqB8sy
         d5tesEADzqN3RAzPHFm9c2vi+Szt8ICH17a5XNh0z7bHW8bQQRg49O9kYVMfkOBkq0W3
         SNAw==
X-Gm-Message-State: APjAAAXiM3jqGJ8DdZ8SSrWC6PXbDfOVgiBdcblcy8Hkx3E/gM+GLN1L
        9jpQ9D+hrNtLSCKcGYZ+EqXoUPSzWX3ScFHYqw3vRQ==
X-Google-Smtp-Source: APXvYqxlZTvTRT9fl86YSwTGq/owe82EV9UaCl8rLTJBP4ewdVMeR8z4+fwiV/M1M3nj2QmOh2vFx8Uh/B5Tv2mRgVE=
X-Received: by 2002:a9f:364c:: with SMTP id s12mr10774138uad.77.1572848444328;
 Sun, 03 Nov 2019 22:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20191030091038.678-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191030091038.678-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 4 Nov 2019 11:50:33 +0530
Message-ID: <CAHLCerO+FRV1m73_TuAgMVgbe8PCyUZbO1Ym3LNS6S1dcCrafw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 2:41 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The option CONFIG_CPU_THERMAL depends on CONFIG_OF in the Kconfig.
>
> It it pointless to check if CONFIG_OF is set in the header file as
> this is always true if CONFIG_CPU_THERMAL is true. Remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/cpu_cooling.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index bae54bb7c048..72d1c9c5e538 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -47,7 +47,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  }
>  #endif /* CONFIG_CPU_THERMAL */
>
> -#if defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL)
> +#ifdef CONFIG_CPU_THERMAL
>  /**
>   * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
>   * @policy: cpufreq policy.
> @@ -60,6 +60,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>         return NULL;
>  }
> -#endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
> +#endif /* CONFIG_CPU_THERMAL */
>
>  #endif /* __CPU_COOLING_H__ */
> --
> 2.17.1
>
