Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA94F49D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfFVJM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 05:12:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35027 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFVJM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 05:12:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so8723925otq.2;
        Sat, 22 Jun 2019 02:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za5DjWecnxQo5WhKu7I+X5Hk3iA1uY1rMAIDn+XLDII=;
        b=YoG4ncd8373zFg6HZwCcpzB9zw+pEF6pAtAOISfTBhubdC5D+3+WLsgGAhZZfP/fz0
         zCRARpIpRFYNi2xjYvgt8HceNP0TLEhVhKxwoDM4+t0TQiIPb3/Bo/JL59Rqbg08sYYK
         mrBkrrNGCOiHCpSnVa42MsDP/Y01FdKkWO5iMV3VFKaXYwp7B4mH8MeC/H1U7mJ9b00R
         vIFy/nEv/hAcp26GHM8vzjJXStS4ko7NZ1itlA5G3dt+btkA4K/bGRjdqQaBhjpNbYtj
         91dt6JOP9eJftgfBcc8cAOtN+QJ3SlUtx3ri22Di2Vu6vPtM4Dmk/WxdDrLV7HEOO9re
         S97w==
X-Gm-Message-State: APjAAAVPFY2YE5dwSInzyF+YJUr+YQJ5xRqWnIMAdoUwcuLku/Somju3
        DM/jYxY/xOGhVw7jSzZZDoZGbRlZmR3n/o0QnbM=
X-Google-Smtp-Source: APXvYqy79d/NCRv3FRk7cUoFWpn4u0tK3EJ2qKGeyjzmJz8YDBEpJ1Pun+fgOt8pSnglb/ICBLDyOrBxFfzzVgXc+6g=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr16209366otp.189.1561194777137;
 Sat, 22 Jun 2019 02:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190621132302.30414-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 22 Jun 2019 11:12:46 +0200
Message-ID: <CAJZ5v0j0q+Z+FRpVuj39ML_c5ijo-veMMMSANdoDz1ZxAK3RgQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpufreq: Use existing stub functions instead of
 IS_ENABLED macro
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 21, 2019 at 3:23 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The functions stub already exist for the condition the IS_ENABLED
> is trying to avoid.
>
> Remove the IS_ENABLED macros as they are pointless.

AFAICS, the IS_ENABLED checks are an optimization to avoid generating
pointless code (including a branch) in case CONFIG_CPU_THERMAL is not
set.

Why do you think that it is not useful?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..7c72f7d3509c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
>
> -       if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> -           cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> +       if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
>                 policy->cdev = of_cpufreq_cooling_register(policy);
>
>         pr_debug("initialization complete\n");
> @@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
>                 goto unlock;
>         }
>
> -       if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> -           cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
> +       if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
>                 cpufreq_cooling_unregister(policy->cdev);
>                 policy->cdev = NULL;
>         }
> --
> 2.17.1
>
