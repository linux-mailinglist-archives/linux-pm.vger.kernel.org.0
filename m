Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77454D3E9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 23:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241445AbiFOVpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiFOVpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 17:45:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B532338BA
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 14:45:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so20864098lfg.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxKotNlIQUP1TJrIgSLaFJNRK8CsQneLEY5gHhwVYxA=;
        b=huxt0c1nC3YkXAqw1K2QAvkiB7XN0YUWmZX348cQLCUb1nGebShMTqR0OjyvMp04ar
         5Q9MhQ0ulo6lXzwprHNI+HaG1QdOmK4mfrOcXmQ7H23jcW69jjdPLm2HfNBH6NnDH6tp
         TOrrVUFNhtSd/8UR3/61ZWIHf50UXf/HkUed6I4HgSXtFvpJEFMavJeB9mwW4nl6kk/e
         o4EB9uCIORMxAjMKS+PJgmq0NqvnL78WH2skPNJUOPZ8lREZRRfKRZkDTGc8OdfW62Dh
         eBUisnlxlGhqbHJcRnT2hjX8na1Br2Wc9L5xr75dSIanlrNKH+uQQaGzjSfCMeJe2C10
         hnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxKotNlIQUP1TJrIgSLaFJNRK8CsQneLEY5gHhwVYxA=;
        b=1VTGG+dMy2ftReKJpCWhIvHfOvrkB5YtZhgHHtWvuL+wt04cvHNMUhZ9KYX1NDtcjH
         yPBjMpixsUxBgtfprgmGj9i0WYZQwaKlcHgXtre9v0sHQoplQjzY9R6QqSvWsV4ro2Tb
         SxSfTTDizgagNlhBzN7vpY7iu7sVJxDCEtv+8nJE/Y9SxG7D501LzWdPl538/vfX486Y
         XrpbPFFBysejN2rvzyRNb2cacsbx0Iv0UNqad5waJkz4qYDy5FoBzImoJBPM0idoQQQd
         jYBYgevFzq9yjNaiz7mgioI8zJHvzsvk4ga5YLyv0Eptped0k2K5xUi2Rng714Ly13n8
         KfKg==
X-Gm-Message-State: AJIora+fv+wFYEQ0HPIREt5WLKb9nGFJs1z6bcnfY7eSIbeNCrgAWLVb
        J3K5mW/qIo93KK1zhAQH0PQgnGrL7hlb9CSyT6fk6w==
X-Google-Smtp-Source: AGRyM1tuDNI/QxNEJKWQ5nsViTUyLPF0UL0iKabgUZdgwWime1hc6LNXk9arOz+lRhXm5eJt8RFAMEAeGA8ksOwDbBE=
X-Received: by 2002:a05:6512:1047:b0:479:2308:ac0b with SMTP id
 c7-20020a056512104700b004792308ac0bmr898006lfb.167.1655329502392; Wed, 15 Jun
 2022 14:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220615203605.1068453-1-athierry@redhat.com>
In-Reply-To: <20220615203605.1068453-1-athierry@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 14:44:25 -0700
Message-ID: <CAPDyKFrLbNsdxfoWRfYBUfijLF0m7XjtH5_aY7LLmzbW5pkn9A@mail.gmail.com>
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
To:     Adrien Thierry <athierry@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jun 2022 at 13:36, Adrien Thierry <athierry@redhat.com> wrote:
>
> We've been encountering a BUG: scheduling while atomic while running the
> 5.18.0-rt11 kernel on a Qualcomm SoC (see stacktrace below).
>
> It seems to occur because a spinlock is taken in the PSCI idle code path
> in the idle loop. With the RT patchset applied and CONFIG_PREEMPT_RT
> enabled, spinlocks can sleep, thus triggering the bug.
>
> In order to prevent this, replace the generic_pm_domain spinlock by a
> raw spinlock.
>
> [    2.994433] BUG: scheduling while atomic: swapper/6/0/0x00000002
> [    2.994439] Modules linked in:
> [    2.994447] [<ffff80000810b0ec>] migrate_enable+0x3c/0x160
> [    2.994461] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.18.0-rt11+ #1
> [    2.994464] Hardware name: Qualcomm SA8295P ADP (DT)
> [    2.994466] Call trace:
> [    2.994467]  dump_backtrace+0xb0/0x120
> [    2.994473]  show_stack+0x1c/0x6c
> [    2.994477]  dump_stack_lvl+0x64/0x7c
> [    2.994483]  dump_stack+0x14/0x2c
> [    2.994487]  __schedule_bug+0xa8/0xc0
> [    2.994489]  schedule_debug.constprop.0+0x154/0x170
> [    2.994492]  __schedule+0x58/0x520
> [    2.994496]  schedule_rtlock+0x20/0x44
> [    2.994499]  rtlock_slowlock_locked+0x110/0x260
> [    2.994503]  rt_spin_lock+0x74/0x94
> [    2.994505]  genpd_lock_nested_spin+0x20/0x30
> [    2.994509]  genpd_power_off.part.0.isra.0+0x248/0x2cc
> [    2.994512]  genpd_runtime_suspend+0x1a0/0x300
> [    2.994515]  __rpm_callback+0x4c/0x16c
> [    2.994518]  rpm_callback+0x6c/0x80
> [    2.994520]  rpm_suspend+0x10c/0x63c
> [    2.994523]  __pm_runtime_suspend+0x54/0xa4
> [    2.994526]  __psci_enter_domain_idle_state.constprop.0+0x64/0x10c
> [    2.994532]  psci_enter_domain_idle_state+0x1c/0x24
> [    2.994534]  cpuidle_enter_state+0x8c/0x3f0
> [    2.994539]  cpuidle_enter+0x3c/0x50
> [    2.994543]  cpuidle_idle_call+0x158/0x1d4
> [    2.994548]  do_idle+0xa8/0xfc
> [    2.994551]  cpu_startup_entry+0x28/0x30
> [    2.994556]  secondary_start_kernel+0xe4/0x140
> [    2.994563]  __secondary_switched+0x54/0x58
>
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>
> This patch fixes the bug but I'm not sure if this is the proper way to do
> so. Suggestions for other ways to fix this are very welcome.

Honestly, I am not so sure about this either.

Turning the lock into spinlock_t into a raw_spinlock_t, may have the
effect of spreading into constraints on the genpd providers. Thus
those may need to be converted to use raw_spinlock_t too (assuming
they use a spinlock_t and GENPD_FLAG_IRQ_SAFE). On the other hand,
there are a limited number of genpd providers that this can become a
problem for, if any, so maybe it would not be a big problem after all.

Kind regards
Uffe

>
>  drivers/base/power/domain.c | 10 +++++-----
>  include/linux/pm_domain.h   |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 739e52cd4aba..9378decb58cf 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -82,7 +82,7 @@ static void genpd_lock_spin(struct generic_pm_domain *genpd)
>  {
>         unsigned long flags;
>
> -       spin_lock_irqsave(&genpd->slock, flags);
> +       raw_spin_lock_irqsave(&genpd->slock, flags);
>         genpd->lock_flags = flags;
>  }
>
> @@ -92,7 +92,7 @@ static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
>  {
>         unsigned long flags;
>
> -       spin_lock_irqsave_nested(&genpd->slock, flags, depth);
> +       raw_spin_lock_irqsave_nested(&genpd->slock, flags, depth);
>         genpd->lock_flags = flags;
>  }
>
> @@ -101,7 +101,7 @@ static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
>  {
>         unsigned long flags;
>
> -       spin_lock_irqsave(&genpd->slock, flags);
> +       raw_spin_lock_irqsave(&genpd->slock, flags);
>         genpd->lock_flags = flags;
>         return 0;
>  }
> @@ -109,7 +109,7 @@ static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
>  static void genpd_unlock_spin(struct generic_pm_domain *genpd)
>         __releases(&genpd->slock)
>  {
> -       spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
> +       raw_spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
>  }
>
>  static const struct genpd_lock_ops genpd_spin_ops = {
> @@ -2022,7 +2022,7 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
>  static void genpd_lock_init(struct generic_pm_domain *genpd)
>  {
>         if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> -               spin_lock_init(&genpd->slock);
> +               raw_spin_lock_init(&genpd->slock);
>                 genpd->lock_ops = &genpd_spin_ops;
>         } else {
>                 mutex_init(&genpd->mlock);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index ebc351698090..80166a915b0d 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -159,7 +159,7 @@ struct generic_pm_domain {
>         union {
>                 struct mutex mlock;
>                 struct {
> -                       spinlock_t slock;
> +                       raw_spinlock_t slock;
>                         unsigned long lock_flags;
>                 };
>         };
>
> base-commit: 979086f5e0066b4eff66e1eee123da228489985c
> --
> 2.35.3
>
