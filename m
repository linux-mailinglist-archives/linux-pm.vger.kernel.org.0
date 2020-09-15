Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C509226A694
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIONtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgIONsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 09:48:31 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21CC061353
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 06:21:10 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id w3so1001666uad.12
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/kdF94weVvZODB/AUs9f/NpmbxAQ75av/THK7S+FHo=;
        b=kWSUr2pvfEBqdC0GJbcTw32LfLwQVJZ4Jurp7+Fl5teucDdSALr+lDkQJlg3AWmuxH
         UHZRqZXxupGczvxbeJNyUoGu4lv3BgI0hU42Nqa9idhTcSYHE7EF9CsCouvsOGLyAWbJ
         8BEwsRb9CjVil+Tzxz4mUya2EKWBH83lNdynQTFEvCtP94fOHwP552sMh89jskhaLXjV
         A4xlOKV9VcFOi4aGbgHfqXeQOpDVRm4xZQfOWpOrLcgdtwpLBMXkKWIECKruXWFQiu7j
         InN/xHzez2Q6xUALABBVn/FSLk5/6FtEy2Gje8nnPGCsdyff3do/3J8CBALMPbtLzdaG
         WXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/kdF94weVvZODB/AUs9f/NpmbxAQ75av/THK7S+FHo=;
        b=N/QpVjo2bGSonvmgOZ6gVQBj+9JU4MZD+Skxd+sPJ8vx5oOKT8xqOa8ncCJ8k3N+th
         fsMEo/bpjaxZrzlqVdMlZAHWmyFXbD7bzCZfsd838mXWVO1VovVYVDMW/D/uxvDFTZrh
         pfkSFiZqWNdYLqZ/p2ZQVJHpX1MNy3IDOOvjC5YQAKeLQR1UgzkYJ80g6zgblb7uhYHs
         nki4Q2U7XctHNU2PLyUeprVLicKH+tOG6DqI+oQ7QJGQIaI5B01wJkPbxymOcNzMOHzz
         opNJ2vp40fxzDIsAxcQYpHQrAZnJ21ibxe/Li+uphDkYtr6A3SIBo1e8nVv0Rbmt8A3M
         k5PQ==
X-Gm-Message-State: AOAM532wnigjQ+dwH4KDANoLFBQ4ijPF36URU5dnN1PFUxk+j/1p9OoU
        pbhHbJkvAicHt1R13ae+hD4bgbaOq53/VBlhxvNT/A==
X-Google-Smtp-Source: ABdhPJw2tkkqzsTAYQBMAkSwdJ4a+/HWDG22i9K7BnBMNlT8KvEg3SRWxdng0aXuWW9caPvNIEDB06eAO3j9mhggOfk=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr10012968uae.100.1600176064842;
 Tue, 15 Sep 2020 06:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200915103157.345404192@infradead.org> <20200915103806.411374792@infradead.org>
In-Reply-To: <20200915103806.411374792@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Sep 2020 15:20:27 +0200
Message-ID: <CAPDyKFpku8oybzyDpSBU0JEkdaEFkadA9P=QLcB-RkQtVhTe8A@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] cpuidle: Allow cpuidle drivers to take over RCU-idle
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 15 Sep 2020 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Some drivers have to do significant work, some of which relies on RCU
> still being active. Instead of using RCU_NONIDLE in the drivers and
> flipping RCU back on, allow drivers to take over RCU-idle duty.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle.c |   15 ++++++++++-----
>  include/linux/cpuidle.h   |    1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -138,6 +138,7 @@ static void enter_s2idle_proper(struct c
>                                 struct cpuidle_device *dev, int index)
>  {
>         ktime_t time_start, time_end;
> +       struct cpuidle_state *target_state = &drv->states[index];
>
>         time_start = ns_to_ktime(local_clock());
>
> @@ -153,8 +154,9 @@ static void enter_s2idle_proper(struct c
>          * suspended is generally unsafe.
>          */
>         stop_critical_timings();
> -       rcu_idle_enter();
> -       drv->states[index].enter_s2idle(dev, drv, index);
> +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> +               rcu_idle_enter();
> +       target_state->enter_s2idle(dev, drv, index);
>         if (WARN_ON_ONCE(!irqs_disabled()))
>                 local_irq_disable();
>         /*
> @@ -162,7 +164,8 @@ static void enter_s2idle_proper(struct c
>          * first CPU executing it calls functions containing RCU read-side
>          * critical sections, so tell RCU about that.
>          */
> -       rcu_idle_exit();
> +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> +               rcu_idle_exit();
>         tick_unfreeze();
>         start_critical_timings();
>
> @@ -239,9 +242,11 @@ int cpuidle_enter_state(struct cpuidle_d
>         time_start = ns_to_ktime(local_clock());
>
>         stop_critical_timings();
> -       rcu_idle_enter();
> +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> +               rcu_idle_enter();
>         entered_state = target_state->enter(dev, drv, index);
> -       rcu_idle_exit();
> +       if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
> +               rcu_idle_exit();
>         start_critical_timings();
>
>         sched_clock_idle_wakeup_event();
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -82,6 +82,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_UNUSABLE          BIT(3) /* avoid using this state */
>  #define CPUIDLE_FLAG_OFF               BIT(4) /* disable this state by default */
>  #define CPUIDLE_FLAG_TLB_FLUSHED       BIT(5) /* idle-state flushes TLBs */
> +#define CPUIDLE_FLAG_RCU_IDLE          BIT(6) /* idle-state takes care of RCU */
>
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
>
>
