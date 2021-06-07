Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08C839DBB3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFGLsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 07:48:09 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36700 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFGLsJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 07:48:09 -0400
Received: by mail-oi1-f182.google.com with SMTP id a21so17742776oiw.3;
        Mon, 07 Jun 2021 04:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEl81Lqay+G30/sSfGcw7ncOc/rjW1sWcXqyvmGm4kE=;
        b=mfhJvCXU7d3Tg80EMW0j24hIwMdw1Km9/qHuYNt0QKKUhnF4PaW8b9R1Q3yCRJNuNW
         PkFtxibamVlrihAnMteXL82lBPbLJ8ktIG4EehtuJTJq14UWwK1wFtE8gYyp53tIEWB2
         2bgT2I4Fracy9mmTEYZR40YF/8xTWcHd819QjGPsFQTZ5QyxSqtTgP9Mb1YR5257oszD
         92t7YFgU3TVp5o/0qJUXJyCEu5oNtaunGCzPvK3l314F2d+LfIwHgckaMsIK/80LdhRS
         l9gcvpBMHiLpJcEn98PI/TJhCAJLUwe+rBBye2u3v+QIw6HiK+8cqVUcj/kzy4ltVjrm
         u9Ww==
X-Gm-Message-State: AOAM532g/0J0NzrsVqJ7C3ZVzRumS21DuJsgw0J4jn1TswlFxW9odg1R
        I5qOJcYIgBGSvzdq7i6y9tGeRkdFEdbuJkgk+/dICRk2
X-Google-Smtp-Source: ABdhPJxnQI80kAlxZ34WJQqGdft4eB4yy9/QZ5tV7+lWxrd4QjKNYxghRvYBZP4WPlhQx2mAthI1kXdM0Io/tc4kQp8=
X-Received: by 2002:aca:b406:: with SMTP id d6mr11026154oif.71.1623066361440;
 Mon, 07 Jun 2021 04:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210607065743.1596-1-qiang.zhang@windriver.com>
In-Reply-To: <20210607065743.1596-1-qiang.zhang@windriver.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 13:45:43 +0200
Message-ID: <CAJZ5v0iYtNP54mUFs5VbmHxuXYjTBMrbCZ5CqfaHShnGdd+3Jg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with rcu_read_lock/unlock()
To:     qiang.zhang@windriver.com
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 7, 2021 at 8:57 AM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> Using rcu_read_lock/unlock() instead of read_lock/unlock(tasklist_lock),
> the task list can be traversed in parallel to any list additions or
> removals, improve concurrency.
>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

This changes the reader side only AFAICS, but what about the writer side?

What exactly is there to ensure that the updates of the list will
remain safe after this change?

> ---
>  kernel/power/process.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 50cc63534486..0f8dee9ee097 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -48,7 +48,7 @@ static int try_to_freeze_tasks(bool user_only)
>
>         while (true) {
>                 todo = 0;
> -               read_lock(&tasklist_lock);
> +               rcu_read_lock();
>                 for_each_process_thread(g, p) {
>                         if (p == current || !freeze_task(p))
>                                 continue;
> @@ -56,7 +56,7 @@ static int try_to_freeze_tasks(bool user_only)
>                         if (!freezer_should_skip(p))
>                                 todo++;
>                 }
> -               read_unlock(&tasklist_lock);
> +               rcu_read_unlock();
>
>                 if (!user_only) {
>                         wq_busy = freeze_workqueues_busy();
> @@ -97,13 +97,13 @@ static int try_to_freeze_tasks(bool user_only)
>                         show_workqueue_state();
>
>                 if (!wakeup || pm_debug_messages_on) {
> -                       read_lock(&tasklist_lock);
> +                       rcu_read_lock();
>                         for_each_process_thread(g, p) {
>                                 if (p != current && !freezer_should_skip(p)
>                                     && freezing(p) && !frozen(p))
>                                         sched_show_task(p);
>                         }
> -                       read_unlock(&tasklist_lock);
> +                       rcu_read_unlock();
>                 }
>         } else {
>                 pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
> @@ -206,13 +206,13 @@ void thaw_processes(void)
>
>         cpuset_wait_for_hotplug();
>
> -       read_lock(&tasklist_lock);
> +       rcu_read_lock();
>         for_each_process_thread(g, p) {
>                 /* No other threads should have PF_SUSPEND_TASK set */
>                 WARN_ON((p != curr) && (p->flags & PF_SUSPEND_TASK));
>                 __thaw_task(p);
>         }
> -       read_unlock(&tasklist_lock);
> +       rcu_read_unlock();
>
>         WARN_ON(!(curr->flags & PF_SUSPEND_TASK));
>         curr->flags &= ~PF_SUSPEND_TASK;
> @@ -233,12 +233,12 @@ void thaw_kernel_threads(void)
>
>         thaw_workqueues();
>
> -       read_lock(&tasklist_lock);
> +       rcu_read_lock();
>         for_each_process_thread(g, p) {
>                 if (p->flags & PF_KTHREAD)
>                         __thaw_task(p);
>         }
> -       read_unlock(&tasklist_lock);
> +       rcu_read_unlock();
>
>         schedule();
>         pr_cont("done.\n");
> --
> 2.17.1
>
