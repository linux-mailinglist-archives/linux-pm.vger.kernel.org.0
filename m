Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4E3A43A6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhFKOBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 10:01:16 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:34604 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhFKOBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 10:01:13 -0400
Received: by mail-oi1-f173.google.com with SMTP id u11so5909396oiv.1;
        Fri, 11 Jun 2021 06:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxIYbkNeXHhsCu3s0y8J6yU1w73EDpzYD0r98vcvZIc=;
        b=WNOK8Q3ky7LZ1lgQN49pyTqqVlbAA0uLnlblo7rB7hafegf0rlkgwy5Ha7V17ofSh7
         UwPfK5DTm1tlmKrqckYOnIXIgzOLsQAKtNos9fQNEUMwmkQwGIPHBMm9fh6Zn8OACVeD
         UlVUUSfjKk061YPSP82jfXn2+JFP+azUbnDu27wW2OnNp5FzAanzRlYOmtiyfKz6LCm0
         OGqITbyRP/FIsKNlEvr6gffp3lYJkyN2Ohuy8sjQQJPkmvPDURRKsHS1Tg/pErFYGOqT
         JJ1UMIo69dtkNFnjHE4Wo6AhyIHIQMascsy7oIFTtI0aPZhe7kOa15RH/xf2qf8+2KZH
         gudA==
X-Gm-Message-State: AOAM530ClnPjueNWMlLFD9PmowahEfgEy5cyOVhdQUsJatnli1jbNE8V
        44Kjw8LcsndQ3ZNIX53hK7MhzCmsmBn/ELCPS38=
X-Google-Smtp-Source: ABdhPJyFpW4VKFSJ44Q7QK31yBlMopQKYF6Is3qp7pU5JR1h9BIowIZa8+WC2Tube+J5xF/hhEmRCUiLA61fbc+9v1k=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr434598oia.157.1623419941407;
 Fri, 11 Jun 2021 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
In-Reply-To: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 15:58:50 +0200
Message-ID: <CAJZ5v0iVVzcb5faaKUkoqX7UNpzc-aPEB1ywdWERrgvxtcHadQ@mail.gmail.com>
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 11, 2021 at 10:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Rewrite the core freezer to behave better wrt thawing. By replacing
> PF_FROZEN with TASK_FROZEN, a special block state, it is ensured frozen
> tasks stay frozen until explicitly thawed and don't randomly wake up
> early, as is currently possible.
>
> As such, it does away with PF_FROZEN and PF_FREEZER_SKIP, freeing up
> two PF_flags (yay).
>
> The freezing was tested, and found good, using:
>
>   echo freezer > /sys/power/pm_test
>   echo mem > /sys/power/state
>
> Even while having a GDB session active.
>
> Another notable bit is in init/do_mounts_initrd.c; afaict that has been
> 'broken' for quite a while and is simply removed.
>
> Requested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Overall, I like this and I've learned a couple of things from it.

Two comments below.

[cut]

> @@ -116,20 +174,8 @@ bool freeze_task(struct task_struct *p)
>  {
>         unsigned long flags;
>
> -       /*
> -        * This check can race with freezer_do_not_count, but worst case that
> -        * will result in an extra wakeup being sent to the task.  It does not
> -        * race with freezer_count(), the barriers in freezer_count() and
> -        * freezer_should_skip() ensure that either freezer_count() sees
> -        * freezing == true in try_to_freeze() and freezes, or
> -        * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
> -        * normally.
> -        */
> -       if (freezer_should_skip(p))
> -               return false;
> -
>         spin_lock_irqsave(&freezer_lock, flags);
> -       if (!freezing(p) || frozen(p)) {
> +       if (!freezing(p) || frozen(p) || __freeze_task(p)) {
>                 spin_unlock_irqrestore(&freezer_lock, flags);
>                 return false;
>         }
> @@ -137,7 +183,7 @@ bool freeze_task(struct task_struct *p)
>         if (!(p->flags & PF_KTHREAD))
>                 fake_signal_wake_up(p);
>         else
> -               wake_up_state(p, TASK_INTERRUPTIBLE);
> +               wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?

Yes, I think that using TASK_NORMAL here would make sense and I don't
see any drawbacks that may result from doing so.

>
>         spin_unlock_irqrestore(&freezer_lock, flags);
>         return true;
> @@ -148,8 +194,8 @@ void __thaw_task(struct task_struct *p)
>         unsigned long flags;
>
>         spin_lock_irqsave(&freezer_lock, flags);
> -       if (frozen(p))
> -               wake_up_process(p);
> +       WARN_ON_ONCE(freezing(p));
> +       wake_up_state(p, TASK_FROZEN);
>         spin_unlock_irqrestore(&freezer_lock, flags);
>  }
>
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2582,7 +2582,7 @@ static void futex_wait_queue_me(struct f
>          * queue_me() calls spin_unlock() upon completion, both serializing
>          * access to the hash list and forcing another memory barrier.
>          */
> -       set_current_state(TASK_INTERRUPTIBLE);
> +       set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
>         queue_me(q, hb);
>
>         /* Arm the timer */
> @@ -2600,7 +2600,7 @@ static void futex_wait_queue_me(struct f
>                  * is no timeout, or if it has yet to expire.
>                  */
>                 if (!timeout || timeout->task)
> -                       freezable_schedule();
> +                       schedule();
>         }
>         __set_current_state(TASK_RUNNING);
>  }
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -92,8 +92,8 @@ static void check_hung_task(struct task_
>          * Ensure the task is not frozen.
>          * Also, skip vfork and any other user process that freezer should skip.
>          */
> -       if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
> -           return;
> +       if (unlikely(t->state & (TASK_FREEZABLE | TASK_FROZEN)))
> +               return;
>
>         /*
>          * When a freshly created task is scheduled once, changes its state to
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -23,7 +23,8 @@
>
>  void lock_system_sleep(void)
>  {
> -       current->flags |= PF_FREEZER_SKIP;
> +       WARN_ON_ONCE(current->flags & PF_NOFREEZE);
> +       current->flags |= PF_NOFREEZE;

Because khreadd() sets PF_NOFREEZE for all kernel threads by default
and set_freezable() is called by a limited number of them, the
WARN_ON_ONCE() here is likely to trigger if any kernel thread that is
not freezable (which is the default) attempts to call this function.

This was the original reason why PF_FREEZER_SKIP was added as a
separate flag IIRC.

>         mutex_lock(&system_transition_mutex);
>  }
>  EXPORT_SYMBOL_GPL(lock_system_sleep);
> @@ -46,7 +47,7 @@ void unlock_system_sleep(void)
>          * Which means, if we use try_to_freeze() here, it would make them
>          * enter the refrigerator, thus causing hibernation to lockup.
>          */
> -       current->flags &= ~PF_FREEZER_SKIP;
> +       current->flags &= ~PF_NOFREEZE;
>         mutex_unlock(&system_transition_mutex);
>  }
>  EXPORT_SYMBOL_GPL(unlock_system_sleep);
