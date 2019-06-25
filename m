Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1C524F9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfFYHjF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 03:39:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfFYHjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 03:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uy5kzJlSjkqp4+nWJY6yb6ymqqytlOlAX9TAjp5nM0U=; b=RheqFs6ftGfhm6SlFYeZGdevW
        7VrzOOA+FpGkFYu19NrMZCo5nSJlFtQUNJMmaPUDoXlknoqU0/3Ecs5hAZk1BnAuQ+TQQyC+YFxGG
        IpR3ANy/UCqZcw+XEOfYDISkkrKl6PPBoQJs7XXCQpU+mZ1c/pIl8u4katNJ2lNZPALhc33yPTcng
        NKI90hh2ww1/vIlL4vfKi1KWgcgQ454s40T1qOwbyNx15TNJLobj0TaQc19ildu1BBp5ba00yCuOX
        MdydHKR7B50HgzO1LHkjSPCN2uvalHfcp1N1yU8hY+08CwC5JTztS8CwFlC8S8P0laso21rSIk0Vn
        k/C+22tHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfg22-0002gr-99; Tue, 25 Jun 2019 07:38:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1846020A0642F; Tue, 25 Jun 2019 09:38:21 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:38:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, ast@kernel.org,
        daniel@iogearbox.net, akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Vasily Averin <vvs@virtuozzo.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] notifier: Fix broken error handling pattern
Message-ID: <20190625073821.GQ3436@hirez.programming.kicks-ass.net>
References: <20190624091843.859714294@infradead.org>
 <20190624092109.745446564@infradead.org>
 <20190624222107.wrmtww6b2be26wwl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624222107.wrmtww6b2be26wwl@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 24, 2019 at 05:21:07PM -0500, Josh Poimboeuf wrote:
> On Mon, Jun 24, 2019 at 11:18:44AM +0200, Peter Zijlstra wrote:
> > The current notifiers have the following error handling pattern all
> > over the place:
> > 
> > 	int nr;
> > 
> > 	ret = __foo_notifier_call_chain(&chain, val_up, v, -1, &nr);
> > 	if (err & NOTIFIER_STOP_MASK)
> 
> s/err/ret/

-ETOOWARM :-)

> > 		__foo_notifier_call_chain(&chain, val_down, v, nr-1, NULL)
> > 
> > And aside from the endless repetition thereof, it is broken. Consider
> > blocking notifiers; both calls take and drop the rwsem, this means
> > that the notifier list can change in between the two calls, making @nr
> > meaningless.
> > 
> > Fix this by replacing all the __foo_notifier_call_chain() functions
> > with foo_notifier_call_chain_error() that embeds the above patter, but
> > ensures it is inside a single lock region.
> 
> The name "notifier_call_chain_error()" seems confusing, it almost sounds
> like it's notifying an error code.  Then again, I can't really think of
> a more reasonably succinct name.

I;m not attached to the name; I very much ran out of ideas and just
typed something.

> > @@ -25,8 +25,23 @@ static int cpu_pm_notify(enum cpu_pm_eve
> >  	 * RCU know this.
> >  	 */
> >  	rcu_irq_enter_irqson();
> > -	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
> > -		nr_to_call, nr_calls);
> > +	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
> > +	rcu_irq_exit_irqson();
> > +
> > +	return notifier_to_errno(ret);
> > +}
> > +
> > +static int cpu_pm_notify_error(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * __atomic_notifier_call_chain has a RCU read critical section, which
> 
> __atomic_notifier_call_chain() no longer exists.
> 
> > +	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
> 
> "dysfunctional"

That's copy paste, I don't think I've read the comment, my bad.

> > @@ -156,43 +169,30 @@ int atomic_notifier_chain_unregister(str
> >  }
> >  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> >  
> > -/**
> > - *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
> > - *	@nh: Pointer to head of the atomic notifier chain
> > - *	@val: Value passed unmodified to notifier function
> > - *	@v: Pointer passed unmodified to notifier function
> > - *	@nr_to_call: See the comment for notifier_call_chain.
> > - *	@nr_calls: See the comment for notifier_call_chain.
> > - *
> > - *	Calls each function in a notifier chain in turn.  The functions
> > - *	run in an atomic context, so they must not block.
> > - *	This routine uses RCU to synchronize with changes to the chain.
> > - *
> > - *	If the return value of the notifier can be and'ed
> > - *	with %NOTIFY_STOP_MASK then atomic_notifier_call_chain()
> > - *	will return immediately, with the return value of
> > - *	the notifier function which halted execution.
> > - *	Otherwise the return value is the return value
> > - *	of the last notifier function called.
> > - */
> 
> Why remove the useful comment?

Because I delete the whole function ?
