Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6AB272AAA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgIUPsY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 11:48:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44778 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgIUPsY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 11:48:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id 185so17443573oie.11;
        Mon, 21 Sep 2020 08:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wfvHHeEp/JKYstqyvgUvA2MMpB9G1P1QpyTn5Wcj8Y=;
        b=py5LzIP4OA58E1T6eErwkox4jGhUIGWtg/8Q1mnhyghyK8m7V9Kg2bxB/Gsprq+ogL
         8ikdY+7AJ4Hnh1Xsito8zbsY1B2d/1ZBXA+ZFXqj8qVU8HyS4uV4s1m6HMc9NIHivqFL
         VBdoRC/mfSVTzdzbAifF4T5bCb4c2qnWjo0xExu/4xX9jTcPKz59//9BDBt6uc77fNVT
         nWfYcnFKjBHk5A/6YvrrWbXiyUw7cSHkr6rnDAtdXfsvYoXnrnHXvhU1nKoR2JC8y20P
         KihHqJXcKARdQgdpgzIIdDjAFtwBLrmeOuC9s67pyxPJSIJHnUzHvY8cu+Np/IwyGXLR
         yCrA==
X-Gm-Message-State: AOAM533hb3PTD6WWmpM/kJSQJmxFl4+5rgw9CvVPXYU2kqs1sc5ec+vm
        fw9UQ93dcATgvnehHFXoGyX6sVYiHiwIixSNZU0=
X-Google-Smtp-Source: ABdhPJygyV6wL92IxL1fJriiF2wtj07bmKmGGQKjhIUv3QpvSlXVfn7jqABqeI1d441/b4stIC1h3aBvTkpcwSUxwIg=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr28257oid.110.1600703303008;
 Mon, 21 Sep 2020 08:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200831083832.17889-1-digetx@gmail.com>
In-Reply-To: <20200831083832.17889-1-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 17:48:11 +0200
Message-ID: <CAJZ5v0iSS5u8hf9bxqz=4mc7o232nVyt8ng1P7rePg+gqDgBxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] cpuidle: tegra: Correctly handle result of arm_cpuidle_simple_enter()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 31, 2020 at 10:39 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
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
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied as 5.10 material, thanks!

> ---
>
> Changelog:
>
> v4: No code changes. Added r-b from Jon Hunter and re-sending for 5.10.
>
> v3: The tegra_cpuidle_state_enter() now returns entered idle-index on
>     success instead of 0. Hence the error message will be shown by the
>     tegra-cpuidle driver if arm_cpuidle_simple_enter() will ever fail.
>     Again thanks to Jon Hunter!
>
> v2: Improved commit message by clarifying what values are returned by
>     arm_cpuidle_simple_enter() and when. Thanks to Jon Hunter for the
>     suggestion!
>
>  drivers/cpuidle/cpuidle-tegra.c | 34 +++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index a12fb141875a..e8956706a291 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -172,7 +172,7 @@ static int tegra_cpuidle_coupled_barrier(struct cpuidle_device *dev)
>  static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>                                      int index, unsigned int cpu)
>  {
> -       int ret;
> +       int err;
>
>         /*
>          * CC6 state is the "CPU cluster power-off" state.  In order to
> @@ -183,9 +183,9 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>          * CPU cores, GIC and L2 cache).
>          */
>         if (index == TEGRA_CC6) {
> -               ret = tegra_cpuidle_coupled_barrier(dev);
> -               if (ret)
> -                       return ret;
> +               err = tegra_cpuidle_coupled_barrier(dev);
> +               if (err)
> +                       return err;
>         }
>
>         local_fiq_disable();
> @@ -194,15 +194,15 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>
>         switch (index) {
>         case TEGRA_C7:
> -               ret = tegra_cpuidle_c7_enter();
> +               err = tegra_cpuidle_c7_enter();
>                 break;
>
>         case TEGRA_CC6:
> -               ret = tegra_cpuidle_cc6_enter(cpu);
> +               err = tegra_cpuidle_cc6_enter(cpu);
>                 break;
>
>         default:
> -               ret = -EINVAL;
> +               err = -EINVAL;
>                 break;
>         }
>
> @@ -210,7 +210,7 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>         tegra_pm_clear_cpu_in_lp2();
>         local_fiq_enable();
>
> -       return ret;
> +       return err ?: index;
>  }
>
>  static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
> @@ -236,21 +236,27 @@ static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>                                int index)
>  {
>         unsigned int cpu = cpu_logical_map(dev->cpu);
> -       int err;
> +       int ret;
>
>         index = tegra_cpuidle_adjust_state_index(index, cpu);
>         if (dev->states_usage[index].disable)
>                 return -1;
>
>         if (index == TEGRA_C1)
> -               err = arm_cpuidle_simple_enter(dev, drv, index);
> +               ret = arm_cpuidle_simple_enter(dev, drv, index);
>         else
> -               err = tegra_cpuidle_state_enter(dev, index, cpu);
> +               ret = tegra_cpuidle_state_enter(dev, index, cpu);
>
> -       if (err && (err != -EINTR || index != TEGRA_CC6))
> -               pr_err_once("failed to enter state %d err: %d\n", index, err);
> +       if (ret < 0) {
> +               if (ret != -EINTR || index != TEGRA_CC6)
> +                       pr_err_once("failed to enter state %d err: %d\n",
> +                                   index, ret);
> +               index = -1;
> +       } else {
> +               index = ret;
> +       }
>
> -       return err ? -1 : index;
> +       return index;
>  }
>
>  static int tegra114_enter_s2idle(struct cpuidle_device *dev,
> --
> 2.27.0
>
