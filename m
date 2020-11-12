Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A72B0969
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgKLQEJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 11:04:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37601 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgKLQEJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 11:04:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id l36so6059242ota.4;
        Thu, 12 Nov 2020 08:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Dh+IYRtEiWg2FAJshN1OCW4IcCJdA74FHicoJTj/Wg=;
        b=A0pna/EH7xoQaCexyhKH5PpmzOty+IJ9n55EPcJIAg+bu/bv2vM3826BF7XHlTN6XW
         G2ExrgwCgFUyzIQAnDmsCW1/jEQTv3Mc0qpzSqmZkUpqTMQI/G7PT1OyWLeiOsAWouIx
         ofmir2DaVOCJzAcvcLhZJE4HZ47BNcVgeMQxSvDZP3bYeZVCtDGKXLc8i8Vqzap2LkOx
         bOyE4mwWJiTg48/th+dLBUANro+weULSc8vH86+BFtBT8I7BalTSA+oVNFc7y/2DqmCM
         2nGD3sHOgl2YmI3/3R8ElICIsgJDlN8B42UK5j+iQ6Wzr4abfrJHQ6z9p6n8dHyYAgPx
         dn0g==
X-Gm-Message-State: AOAM531g8JF9efUxUl3TkLrUZfoU2aSCQ9PUSR+UHPO/EkltYdG5yVdP
        v33/knqyK9xeLW6rH0Vsfgz8nibIB/aNOwi30B+dRUin
X-Google-Smtp-Source: ABdhPJzDqLH/D6b11M3EbFlXd1opsl7D+7lY4VSegjro9tq9JSXU+cHNN0YeJ3CVaPtu6yi4KOfZmSZOnhNNa4oeKm4=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr23141676otu.206.1605197048152;
 Thu, 12 Nov 2020 08:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20201104132126.15943-1-digetx@gmail.com>
In-Reply-To: <20201104132126.15943-1-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 17:03:57 +0100
Message-ID: <CAJZ5v0iauVV7cBT5Aj8Qa_yyjPTwbK6uD5b5kJLMKzcP+V8=Tw@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: tegra: Annotate tegra_pm_set_cpu_in_lp2()
 with RCU_NONIDLE
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 4, 2020 at 2:21 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Annotate tegra_pm_set[clear]_cpu_in_lp2() with RCU_NONIDLE in order to
> fix lockdep warning about suspicious RCU usage of a spinlock during late
> idling phase.
>
>  WARNING: suspicious RCU usage
>  ...
>  include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
>  ...
>   (dump_stack) from (lock_acquire)
>   (lock_acquire) from (_raw_spin_lock)
>   (_raw_spin_lock) from (tegra_pm_set_cpu_in_lp2)
>   (tegra_pm_set_cpu_in_lp2) from (tegra_cpuidle_enter)
>   (tegra_cpuidle_enter) from (cpuidle_enter_state)
>   (cpuidle_enter_state) from (cpuidle_enter_state_coupled)
>   (cpuidle_enter_state_coupled) from (cpuidle_enter)
>   (cpuidle_enter) from (do_idle)
>  ...
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Reported-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index e8956706a291..191966dc8d02 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -189,7 +189,7 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>         }
>
>         local_fiq_disable();
> -       tegra_pm_set_cpu_in_lp2();
> +       RCU_NONIDLE(tegra_pm_set_cpu_in_lp2());
>         cpu_pm_enter();
>
>         switch (index) {
> @@ -207,7 +207,7 @@ static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>         }
>
>         cpu_pm_exit();
> -       tegra_pm_clear_cpu_in_lp2();
> +       RCU_NONIDLE(tegra_pm_clear_cpu_in_lp2());
>         local_fiq_enable();
>
>         return err ?: index;
> --

Applied as a fix for 5.10-rc, thanks!
