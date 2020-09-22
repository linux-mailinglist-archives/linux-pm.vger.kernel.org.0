Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE689274789
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVReQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 13:34:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38473 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVReQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 13:34:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id y5so16384701otg.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 10:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkKfT1bHunvAZFPekK2APeELP8gPnhgpzPP51/xnQmk=;
        b=XSKyHqPV/0y3xvx7HgI536JSZviFiJ2B9ZsPcP7srWijL+J27BjAzXGshGj6mS9JpU
         FXljoFatQmd65OqnC8yftA2+yO8A+IEbH1v0khCl/jsM/uTmAd3I0uR2P9s2vMu4H2XK
         0EPHFMdswsSmgAVKJiNhlSqUePuf2BDu21rVPKz+W9FU619PKA1OvCa7jnabx719Lafn
         BMeeRZ1EOmkwPc4Ka8AXREaYl8qsHSMxI0hKS9gY5+cemBhDsDeV3cZDurPB0gJHThjG
         WRJGIBroUw2wkslSEOHqjNzAW4ACUZaIuYRI2PBnIY2ojEvFxiAWOHTlM/qsNizw6oww
         IRHA==
X-Gm-Message-State: AOAM531rcaQ35CJ5a7uJO6r8+aOF5jzPCnnxUEBlPeV2MTBtKAy3Tiv6
        MdmGxnVAd2T1THYcwzbU/dt88yh7N2/ohQ1DAGz5Y2kz
X-Google-Smtp-Source: ABdhPJwFvRsdduyDo+UicZCG5kKy+yzJ8q8k4aNi+ygNbljm65vsyB9y0VNZFeYmYgIft0jLNnKugitx8pKaPlDXiaM=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr3547336otj.262.1600796055602;
 Tue, 22 Sep 2020 10:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200922091550.90191-1-ulf.hansson@linaro.org>
In-Reply-To: <20200922091550.90191-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 19:34:04 +0200
Message-ID: <CAJZ5v0gFR5a3mkNxnpAHgK1NxDe2PYbk=9gnjdHCHsYSaB+SYQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Drop misleading comments about RCU usage
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 11:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle deeper into the
> idle path"), moved the calls rcu_idle_enter|exit() into the cpuidle core.
>
> However, it forgot to remove a couple of comments in enter_s2idle_proper()
> about why RCU_NONIDLE earlier was needed. So, let's drop them as they have
> become a bit misleading.
>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.9-rc7 material, thanks!

> ---
>  drivers/cpuidle/cpuidle.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6c7e5621cf9a..29e84687f3c3 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -142,11 +142,6 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
>
>         time_start = ns_to_ktime(local_clock());
>
> -       /*
> -        * trace_suspend_resume() called by tick_freeze() for the last CPU
> -        * executing it contains RCU usage regarded as invalid in the idle
> -        * context, so tell RCU about that.
> -        */
>         tick_freeze();
>         /*
>          * The state used here cannot be a "coupled" one, because the "coupled"
> @@ -159,11 +154,6 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
>         target_state->enter_s2idle(dev, drv, index);
>         if (WARN_ON_ONCE(!irqs_disabled()))
>                 local_irq_disable();
> -       /*
> -        * timekeeping_resume() that will be called by tick_unfreeze() for the
> -        * first CPU executing it calls functions containing RCU read-side
> -        * critical sections, so tell RCU about that.
> -        */
>         if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
>                 rcu_idle_exit();
>         tick_unfreeze();
> --
> 2.25.1
>
