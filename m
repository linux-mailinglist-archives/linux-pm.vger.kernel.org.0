Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A563290249
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406437AbgJPJzI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406414AbgJPJzH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 05:55:07 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9538DC061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 02:55:07 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id o70so1462801ybc.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KAG00OU6I8ZSKVj+GjsDY5lnIf7cqlgqOKkytYnMQYA=;
        b=dqC73mbifYSnjiynxQSRfPcV8neE4zGgBUukmpro4mix8nZi9JC8qw3lp9DB/n/xvV
         6YJC5cd84A+TwsRmbGwBxkLQfz3P2f3m45ouXxSzrQG3FZkGVUn034/6ROWF7gOkjseo
         FebJ6YvhIDXwZ5zHZ3EELH6thU2AqbgzWHQd4y3WiN4eUH66qy+bPlp6aKW1C3+O6tqv
         uluAsBt6+p/Qhh9VESBzRPDEXBzle9omIbh6JIVp07asw61uAlp+oxrmbFw4ujkl1bgR
         RT2kF3Lk6chjnuI27Pz3kOglB+TmQ/VYw/INOuuU2gB0J+/IUpE6PLQVE1HJkXF18h9s
         5sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KAG00OU6I8ZSKVj+GjsDY5lnIf7cqlgqOKkytYnMQYA=;
        b=Oxhz1p2Sd2C98Ci+urOSiqNiWL+qwRNvjd43xNYAkqs9jmsQyfpOmMNe9X1LSMKd/V
         bMy4FycaTkC7TqEa+BAvqsuc+/m4sDTmozGXwlucaAs2Cwi3WU5WoxudHeaGwym72lcs
         d1sDZHgnx5RaGrHOP6wlKVUNS+7csL3z46ssLaHxSUAFU7XrQT5HAQs3wMmmZjkPz96E
         L09HAbtqosnlPwwSfIlo9hN2U6y8w92AHUKZNGk0YqejUUKd4ZRQ3heFOvk8jGyVseZz
         FOcLTbQ7f3YbblLlqk338cp/ZDn5id+uaPzyp75zA1y2Ght5jWCEgUY8Uvs4YdsjqDr1
         Exgg==
X-Gm-Message-State: AOAM532k2KcPAkbVsfk1VhVLUDSZRuvfY1H/mD5Oha/3s+Zd8yv8Ok2q
        gJCtxP4xPibm1kls/2rwx1vRgBqm3b6Lth/0IxqIAg==
X-Google-Smtp-Source: ABdhPJzrDKChDSgbRPUnqHVLxigY3990lB2Cf6/7Eyx/Kc+ZUDTPyGYgWd4tlAAwDr+fVdO0D1caZ7iOZT9mVPrFviE=
X-Received: by 2002:a25:2389:: with SMTP id j131mr1711428ybj.25.1602842106593;
 Fri, 16 Oct 2020 02:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201016035109.3952356-1-josephjang@google.com> <20201016090108.GG8871@alley>
In-Reply-To: <20201016090108.GG8871@alley>
From:   Joseph Jang <josephjang@google.com>
Date:   Fri, 16 Oct 2020 17:54:55 +0800
Message-ID: <CAPaOXEQadaDTVbwbi72Zw2yDHEKDgRNM-rLhoOzVMp_N0fyqMw@mail.gmail.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jonglin Lee <jonglin@google.com>,
        Woody Lin <woodylin@google.com>,
        Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks Petr promptly response.

On Fri 2020-10-16 11:51:09, Joseph Jang wrote:
> From: josephjang <josephjang@google.com>
>
> Add suspend timeout handler to prevent device stuck during suspend/
> resume process. Suspend timeout handler will dump disk sleep task
> at first round timeout and trigger kernel panic at second round timeout.
> The default timer for each round is 30 seconds.

A better solution would be to resume instead of panic().

[Joseph] suspend_timeout() will trigger kernel panic() only when
suspend thread stuck (deadlock/hang) for 2*30 seconds.
At that moment, I don't know how to resume the suspend thread. So I
just could trigger panic to reboot system.
If you have better suggestions, I am willing to study it.


> Note: Can use following command to simulate suspend hang for testing.
>     adb shell echo 1 > /sys/power/pm_hang

This looks dangerous. It adds a simple way to panic() the system.

First, it should get enabled separately. e.g.
CONFIG_TEST_PM_SLEEP_MONITOR.

Second, I would add it as a module that might get loaded
and unloaded.

[Joseph] Agree to enable new compile flag for test module.
I think it is better to create separate patch for the new test module right=
?

> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
Using kthread looks like an overkill to me. I wonder how this actually
works when the kthreads get freezed. It might be enough to implement
just a timer callback. Start the timer in start_suspend_mon() and
delete it in stop_suspend_mon(). Or do I miss anything?


Anyway, the kthread implementation looks a but hairy. If you really
need to use kthread, I suggest to use kthread_worker API. You would
need to run an init work to setup the RT scheduling. Then you
could just call kthread_queue_delayed_work(()
and kthread_cancel_delayed_work_sync() to start and stop
the monitor.

[Joseph]
Actually, I had ever think we just need to use
add_timer()/del_timer_sync() for start_suspend_mon()/stop_suspend_mon() bef=
ore.

But I am not sure if add_timer() may cause any performance impact in
suspend thread or not.
So I try to create a suspend monitor kthread and just flip the flag in
suspend thread.

Thank you,
Joseph.
> @@ -114,6 +251,10 @@ static void s2idle_enter(void)
>       s2idle_state =3D S2IDLE_STATE_NONE;
>       raw_spin_unlock_irq(&s2idle_lock);
>
> +#ifdef CONFIG_PM_SLEEP_MONITOR
> +     start_suspend_mon();
> +#endif

It is better to solve this by defining start_suspend_mon() as empty
function when the config option is disabled. For example, see
how  vgacon_text_force() is defined in console.h.

[Joseph] Thank you for good suggestions.
May I know if I could use IS_ENABLED() ?
if (IS_ENABLED(CONFIG_PM_SLEEP_MONITOR))
start_suspend_mon();


Best Regards,
Petr



Thank you,
Joseph.


Petr Mladek <pmladek@suse.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8816=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri 2020-10-16 11:51:09, Joseph Jang wrote:
> > From: josephjang <josephjang@google.com>
> >
> > Add suspend timeout handler to prevent device stuck during suspend/
> > resume process. Suspend timeout handler will dump disk sleep task
> > at first round timeout and trigger kernel panic at second round timeout=
.
> > The default timer for each round is 30 seconds.
>
> A better solution would be to resume instead of panic().
>
> > Note: Can use following command to simulate suspend hang for testing.
> >     adb shell echo 1 > /sys/power/pm_hang
>
> This looks dangerous. It adds a simple way to panic() the system.
>
> First, it should get enabled separately. e.g.
> CONFIG_TEST_PM_SLEEP_MONITOR.
>
> Second, I would add it as a module that might get loaded
> and unloaded.
>
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 8b1bb5ee7e5d..6f2679cfd9d1 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > +static int suspend_monitor_kthread(void *arg)
> > +{
> > +     long err;
> > +     struct sched_param param =3D {.sched_priority
> > +             =3D MAX_RT_PRIO-1};
> > +     static int timeout_count;
> > +     static long timeout;
> > +
> > +     pr_info("Init ksuspend_mon thread\n");
> > +
> > +     sched_setscheduler(current, SCHED_FIFO, &param);
> > +
> > +     timeout_count =3D 0;
> > +     timeout =3D MAX_SCHEDULE_TIMEOUT;
> > +
> > +     do {
> > +             /* Wait suspend timer timeout */
> > +             err =3D wait_event_interruptible_timeout(
> > +                     power_suspend_waitqueue,
> > +                     (suspend_mon_toggle !=3D TOGGLE_NONE),
> > +                     timeout);
> > +
> > +             mutex_lock(&suspend_mon_lock);
> > +             /* suspend monitor state change */
> > +             if (suspend_mon_toggle !=3D TOGGLE_NONE) {
> > +                     if (suspend_mon_toggle =3D=3D TOGGLE_START) {
> > +                             timeout =3D msecs_to_jiffies(
> > +                                     SUSPEND_TIMER_TIMEOUT_MS);
> > +                             pr_info("Start suspend monitor\n");
> > +                     } else if (suspend_mon_toggle =3D=3D TOGGLE_STOP)=
 {
> > +                             timeout =3D MAX_SCHEDULE_TIMEOUT;
> > +                             timeout_count =3D 0;
> > +                             pr_info("Stop suspend monitor\n");
> > +                     }
> > +                     suspend_mon_toggle =3D TOGGLE_NONE;
> > +                     mutex_unlock(&suspend_mon_lock);
> > +                     continue;
> > +             }
> > +             mutex_unlock(&suspend_mon_lock);
> > +
> > +             /* suspend monitor event handler */
> > +             if (err =3D=3D 0) {
> > +                     timeout_count++;
> > +                     suspend_timeout(timeout_count);
> > +             } else if (err =3D=3D -ERESTARTSYS) {
> > +                     pr_info("Exit ksuspend_mon!");
> > +                     break;
> > +             }
> > +     } while (1);
> > +
> > +     return 0;
> > +}
>
> Using kthread looks like an overkill to me. I wonder how this actually
> works when the kthreads get freezed. It might be enough to implement
> just a timer callback. Start the timer in start_suspend_mon() and
> delete it in stop_suspend_mon(). Or do I miss anything?
>
> Anyway, the kthread implementation looks a but hairy. If you really
> need to use kthread, I suggest to use kthread_worker API. You would
> need to run an init work to setup the RT scheduling. Then you
> could just call kthread_queue_delayed_work(()
> and kthread_cancel_delayed_work_sync() to start and stop
> the monitor.
>
>
> > @@ -114,6 +251,10 @@ static void s2idle_enter(void)
> >       s2idle_state =3D S2IDLE_STATE_NONE;
> >       raw_spin_unlock_irq(&s2idle_lock);
> >
> > +#ifdef CONFIG_PM_SLEEP_MONITOR
> > +     start_suspend_mon();
> > +#endif
>
> It is better to solve this by defining start_suspend_mon() as empty
> function when the config option is disabled. For example, see
> how  vgacon_text_force() is defined in console.h.
>
> Best Regards,
> Petr



--=20
Embedded Software engineer
