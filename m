Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95FD58D0E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0VbU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:31:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46695 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfF0VbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:31:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so3791643ote.13;
        Thu, 27 Jun 2019 14:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1SnWA9DFUhRdoSwMwoAjC3R75VohWjZ3wyZhwcVI0I=;
        b=qCWKmcCJ7XpqNs2XNTW+pyy0WVpkom8KogxcCBVUpRzRP0EeD7wUD4qklLsFCX31Vq
         GqqzlqY2gHJq6fof1PnY7CWBe3On4Q7mFyZwx35ev4BpYFnjT7gkp/ptkKqSIYmDe7j/
         0wS0gHBCX0yTudc24etxkmIsh3I4QtFdFGgyXgNcEHLO/ED0STnsa2781jRKhhoV9oqu
         GQtSmqS27cldxgkhQLet2lcmLxlk4sYdIP6EJyYxhpX8Vgy7Pf5zf0GvCEfUBU1asRcx
         5aB5ipAKuHPHLuCvfo5Ax3Av7oLpKeP556TTOkRLikW2CefqDRJhB/jpoM+Kx7kfV0CZ
         gQ/g==
X-Gm-Message-State: APjAAAW+bKet4RlshBMr2BQq2Kfl+0QI0+f0EnJDRFGOVZ/KROXIUWqN
        y1LceFA7+s0cJTWNZcLr5ri59plbidGD95Vtq/0=
X-Google-Smtp-Source: APXvYqwRxpD1ZnhLRVEKbWRFwO4WTEF0OSE2DyA8cuCq4FlsfIbinxoruHvh8I0Or1KnwcZmWQAdShb2BVZGGbnG15k=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr5062269oto.118.1561671079104;
 Thu, 27 Jun 2019 14:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190627210209.32600-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 23:31:08 +0200
Message-ID: <CAJZ5v0gA0sgpkaPCJwe1J7zqRynnwttGT-hcknfCF_LwBw5oHw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro in
 a stub
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 27, 2019 at 11:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The cpufreq_online and the cpufreq_offline [un]register the driver as
> a cooling device. This is done if the driver is flagged as a cooling
> device in addition with a IS_ENABLED macro to compile out the branching
> code.
>
> Group this test in a stub function added in the cpufreq header instead
> of having the IS_ENABLED in the code path.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

This one has been queued up for 5.3 already, no need to resend.

Thanks!

> ---
>  drivers/cpufreq/cpufreq.c | 6 ++----
>  include/linux/cpufreq.h   | 6 ++++++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..aee024e42618 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
>
> -       if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> -           cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> +       if (cpufreq_thermal_control_enabled(cpufreq_driver))
>                 policy->cdev = of_cpufreq_cooling_register(policy);
>
>         pr_debug("initialization complete\n");
> @@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
>                 goto unlock;
>         }
>
> -       if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> -           cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
> +       if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
>                 cpufreq_cooling_unregister(policy->cdev);
>                 policy->cdev = NULL;
>         }
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d01a74fbc4db..a1467aa7f58b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -409,6 +409,12 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  const char *cpufreq_get_current_driver(void);
>  void *cpufreq_get_driver_data(void);
>
> +static inline int cpufreq_thermal_control_enabled(struct cpufreq_driver *drv)
> +{
> +       return IS_ENABLED(CONFIG_CPU_THERMAL) &&
> +               (drv->flags & CPUFREQ_IS_COOLING_DEV);
> +}
> +
>  static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
>                 unsigned int min, unsigned int max)
>  {
> --
> 2.17.1
>
