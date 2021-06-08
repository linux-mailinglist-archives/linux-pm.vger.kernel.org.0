Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8D39EDE0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 06:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFHE6R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 00:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhFHE6Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Jun 2021 00:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7E8E6124C;
        Tue,  8 Jun 2021 04:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623128184;
        bh=6XVSYO53rouXTNC0JGmYmDWKE20TC2eAhh4ZbpoGbcI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lvjM+bXY7YAf2FxeomNjPYezK+TKb3jxP8S9yKihYjVF1GotNDtPAUMTqw5joM/PF
         Ohxhk6l/T63uitoZLn8VRSrG89I5vdJ9o9yamHBIElm9fIOTRHFZoJudw0Kf+gz5rd
         lh6wB+Ki+5RuVwE/luzZ9qCgP0forEtYAKfCQzxUJwE+Y7nxM/LGSo+MqhfkgijpyQ
         ESsSSEIJWakxFl5WXdV+neyIDh8yFg+cCmPPIIUc4RwyuZkhVQGOxZLR2tzHLpin3w
         DCoZVa9LPpduvuwf5CZp2I4HvqSam2JRUbPaMPy79RRBQ3CIZg7zbUJnxUEbh84y1L
         YiN0FOR+kdj1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D88F5C08B9; Mon,  7 Jun 2021 21:56:24 -0700 (PDT)
Date:   Mon, 7 Jun 2021 21:56:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with
 rcu_read_lock/unlock()
Message-ID: <20210608045624.GY4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210607065743.1596-1-qiang.zhang@windriver.com>
 <CAJZ5v0iYtNP54mUFs5VbmHxuXYjTBMrbCZ5CqfaHShnGdd+3Jg@mail.gmail.com>
 <DM6PR11MB42027F9DA1B3E9B6BDFA5194FF389@DM6PR11MB4202.namprd11.prod.outlook.com>
 <20210607154138.GU4397@paulmck-ThinkPad-P17-Gen-1>
 <DM6PR11MB42025552629034A22B8E5BC6FF379@DM6PR11MB4202.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB42025552629034A22B8E5BC6FF379@DM6PR11MB4202.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 08, 2021 at 02:50:26AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Monday, 7 June 2021 23:41
> To: Zhang, Qiang
> Cc: Rafael J. Wysocki; Rafael Wysocki; Len Brown; Pavel Machek; Linux PM; Linux Kernel Mailing List
> Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with rcu_read_lock/unlock()
> 
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Mon, Jun 07, 2021 at 02:11:37PM +0000, Zhang, Qiang wrote:
> > ________________________________________
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Monday, 7 June 2021 19:45
> > To: Zhang, Qiang
> > Cc: Rafael Wysocki; Len Brown; Pavel Machek; Paul E. McKenney; Linux PM; Linux Kernel Mailing List
> > Subject: Re: [PATCH] PM: sleep: Replace read_lock/unlock(tasklist_lock) with rcu_read_lock/unlock()
> >
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> >
> > On Mon, Jun 7, 2021 at 8:57 AM <qiang.zhang@windriver.com> wrote:
> > >
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Using rcu_read_lock/unlock() instead of read_lock/unlock(tasklist_lock),
> > > the task list can be traversed in parallel to any list additions or
> > > removals, improve concurrency.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> >
> > >This changes the reader side only AFAICS, but what about the >writer side?
> >
> > Hello  rafael
> >
> > In the case of holding read_lock(tasklist_lock)
> > if there are a lot of tasks in the system that need to be frozen,
> > the read_lock(tasklist_lock)  has not been released for a short time,
> > when clone task,  we will acquire write_lock(tasklist_lock) and insert task to list, if  Ifcan't get the write lock all the time.  the hung task
> > may be trigger and report warning.
> >
> > for example:
> >
> > copy_process()
> > {........
> > write_lock_irq(&tasklist_lock);
> > ........
> > list_add_tail_rcu(&p->tasks, &init_task.tasks);
> > }
> >
> > >
> > >What exactly is there to ensure that the updates of the list will
> > >remain safe after this change?
> >
> > The RCU  can guarantee that the list can be traversed and added at the same time,  and in the read critical area, it is guaranteed that the task structure will not be released.
> >
> > In  ./Documentation/RCU/listRCU.rst , it is also explained.
> >
> >  Maybe we can ask  Paul E,  Paul E what's your opinion ?
> 
> >Although RCU does guarantee that the task structures are not freed while
> >an RCU reader references them, that is only one of the questions that
> >must be answered.
> >
> >Changing from read_lock(&tasklist_lock) to rcu_read_lock() also allows
> >all of the code currently under write_lock(&tasklist_lock) to execute
> >concurrently with these newly created RCU readers.  Is that safe?
> >If it is safe, why?
> >
> >For example, the first pair of hunks in the diff -might- be safe because
> >"todo" is updated while read-holding tasklist_lock, and then that value
> >is used after releasing that lock.  But I do not know this code well,
> >and it is quite possible that something else is going on.
> 
> Thanks Pual E
> 
> you mean is the rcu ensures that the task_struct is not released  but it does not guarantee that some members of the task_struct object are valid.
> There may be the following scenarios:
> In rcu read critical area,  when accessing some members of task_struct object , it may have been released, when the task exiting.
> 
> Is my understanding correct? 

Yes, that is a concern.  The freezer code would need to be checked
carefully to see whether or not the transformation from read_lock()
to rcu_read_lock() was safe.

							Thanx, Paul

> Qiang
> 
> >
> >                                                Thanx, Paul
> 
> > Thanks
> > Qiang
> >
> > > ---
> > >  kernel/power/process.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > > index 50cc63534486..0f8dee9ee097 100644
> > > --- a/kernel/power/process.c
> > > +++ b/kernel/power/process.c
> > > @@ -48,7 +48,7 @@ static int try_to_freeze_tasks(bool user_only)
> > >
> > >         while (true) {
> > >                 todo = 0;
> > > -               read_lock(&tasklist_lock);
> > > +               rcu_read_lock();
> > >                 for_each_process_thread(g, p) {
> > >                         if (p == current || !freeze_task(p))
> > >                                 continue;
> > > @@ -56,7 +56,7 @@ static int try_to_freeze_tasks(bool user_only)
> > >                         if (!freezer_should_skip(p))
> > >                                 todo++;
> > >                 }
> > > -               read_unlock(&tasklist_lock);
> > > +               rcu_read_unlock();
> > >
> > >                 if (!user_only) {
> > >                         wq_busy = freeze_workqueues_busy();
> > > @@ -97,13 +97,13 @@ static int try_to_freeze_tasks(bool user_only)
> > >                         show_workqueue_state();
> > >
> > >                 if (!wakeup || pm_debug_messages_on) {
> > > -                       read_lock(&tasklist_lock);
> > > +                       rcu_read_lock();
> > >                         for_each_process_thread(g, p) {
> > >                                 if (p != current && !freezer_should_skip(p)
> > >                                     && freezing(p) && !frozen(p))
> > >                                         sched_show_task(p);
> > >                         }
> > > -                       read_unlock(&tasklist_lock);
> > > +                       rcu_read_unlock();
> > >                 }
> > >         } else {
> > >                 pr_cont("(elapsed %d.%03d seconds) ", elapsed_msecs / 1000,
> > > @@ -206,13 +206,13 @@ void thaw_processes(void)
> > >
> > >         cpuset_wait_for_hotplug();
> > >
> > > -       read_lock(&tasklist_lock);
> > > +       rcu_read_lock();
> > >         for_each_process_thread(g, p) {
> > >                 /* No other threads should have PF_SUSPEND_TASK set */
> > >                 WARN_ON((p != curr) && (p->flags & PF_SUSPEND_TASK));
> > >                 __thaw_task(p);
> > >         }
> > > -       read_unlock(&tasklist_lock);
> > > +       rcu_read_unlock();
> > >
> > >         WARN_ON(!(curr->flags & PF_SUSPEND_TASK));
> > >         curr->flags &= ~PF_SUSPEND_TASK;
> > > @@ -233,12 +233,12 @@ void thaw_kernel_threads(void)
> > >
> > >         thaw_workqueues();
> > >
> > > -       read_lock(&tasklist_lock);
> > > +       rcu_read_lock();
> > >         for_each_process_thread(g, p) {
> > >                 if (p->flags & PF_KTHREAD)
> > >                         __thaw_task(p);
> > >         }
> > > -       read_unlock(&tasklist_lock);
> > > +       rcu_read_unlock();
> > >
> > >         schedule();
> > >         pr_cont("done.\n");
> > > --
> > > 2.17.1
> > >
