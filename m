Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDFF9F38
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKMAWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 19:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKMAWk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 19:22:40 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8CA206BB;
        Wed, 13 Nov 2019 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573604559;
        bh=KYsxxVfb9c/zNMVXXf6w4bZXIsHRXJu0HaUT9jvjS00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X60QwV+TY1luo9vcFS/kOlrxatdJKJF4PDOBVlOrneBwPxse7QBb6ZbrqZqNYAaSJ
         klLbWbH9v36NACYd+CGLcLlxIw6gkJkEH9QIEMNLiOvNfezKtJ05omywy2QM0i/iWa
         GFkKAX5BjMUUmQVcipBXgLeYBT2pI3FAfhPUPSXs=
Date:   Wed, 13 Nov 2019 01:22:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4] irq_work: Slightly simplify IRQ_WORK_PENDING clearing
Message-ID: <20191113002235.GA5746@lenoir>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-4-frederic@kernel.org>
 <VI1PR04MB70239C2E838B72C171CC62C7EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB70239C2E838B72C171CC62C7EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 12, 2019 at 08:27:05PM +0000, Leonard Crestez wrote:
> On 08.11.2019 18:09, Frederic Weisbecker wrote:
> > Instead of fetching the value of flags and perform an xchg() to clear
> > a bit, just use atomic_fetch_andnot() that is more suitable to do that
> > job in one operation while keeping the full ordering.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >   kernel/irq_work.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index 255454a48346..49c53f80a13a 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> > @@ -34,7 +34,7 @@ static bool irq_work_claim(struct irq_work *work)
> >   	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
> >   	/*
> >   	 * If the work is already pending, no need to raise the IPI.
> > -	 * The pairing atomic_xchg() in irq_work_run() makes sure
> > +	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
> >   	 * everything we did before is visible.
> >   	 */
> >   	if (oflags & IRQ_WORK_PENDING)
> > @@ -135,7 +135,6 @@ static void irq_work_run_list(struct llist_head *list)
> >   {
> >   	struct irq_work *work, *tmp;
> >   	struct llist_node *llnode;
> > -	int flags;
> >   
> >   	BUG_ON(!irqs_disabled());
> >   
> > @@ -144,6 +143,7 @@ static void irq_work_run_list(struct llist_head *list)
> >   
> >   	llnode = llist_del_all(list);
> >   	llist_for_each_entry_safe(work, tmp, llnode, llnode) {
> > +		int flags;
> >   		/*
> >   		 * Clear the PENDING bit, after this point the @work
> >   		 * can be re-used.
> > @@ -151,8 +151,7 @@ static void irq_work_run_list(struct llist_head *list)
> >   		 * to claim that work don't rely on us to handle their data
> >   		 * while we are in the middle of the func.
> >   		 */
> > -		flags = atomic_read(&work->flags) & ~IRQ_WORK_PENDING;
> > -		atomic_xchg(&work->flags, flags);
> > +		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
> >   
> >   		work->func(work);
> >   		/*
> 
> This breaks switching between cpufreq governors in linux-next on arm64 
> and various other stuff. The fix in this email doesn't compile:
> 
>      https://lkml.org/lkml/2019/11/12/622
> 
> I assume you meant "&= ~" instead of "~=", this seems to work:

Indeed, duh again!

I still think that ~= would be nice to have though...

Thanks!

> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 49c53f80a13a..828cc30774bc 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -156,10 +156,11 @@ static void irq_work_run_list(struct llist_head *list)
>                  work->func(work);
>                  /*
>                   * Clear the BUSY bit and return to the free state if
>                   * no-one else claimed it meanwhile.
>                   */
> +               flags &= ~IRQ_WORK_PENDING;
>                  (void)atomic_cmpxchg(&work->flags, flags, flags & 
> ~IRQ_WORK_BUSY);
>          }
>   }
