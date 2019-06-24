Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C3D51E22
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 00:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFXWV2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 18:21:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfFXWV2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jun 2019 18:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36C45C0546D3;
        Mon, 24 Jun 2019 22:21:16 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E553F5D71A;
        Mon, 24 Jun 2019 22:21:09 +0000 (UTC)
Date:   Mon, 24 Jun 2019 17:21:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190624222107.wrmtww6b2be26wwl@treble>
References: <20190624091843.859714294@infradead.org>
 <20190624092109.745446564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624092109.745446564@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 24 Jun 2019 22:21:27 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 24, 2019 at 11:18:44AM +0200, Peter Zijlstra wrote:
> The current notifiers have the following error handling pattern all
> over the place:
> 
> 	int nr;
> 
> 	ret = __foo_notifier_call_chain(&chain, val_up, v, -1, &nr);
> 	if (err & NOTIFIER_STOP_MASK)

s/err/ret/

> 		__foo_notifier_call_chain(&chain, val_down, v, nr-1, NULL)
> 
> And aside from the endless repetition thereof, it is broken. Consider
> blocking notifiers; both calls take and drop the rwsem, this means
> that the notifier list can change in between the two calls, making @nr
> meaningless.
> 
> Fix this by replacing all the __foo_notifier_call_chain() functions
> with foo_notifier_call_chain_error() that embeds the above patter, but
> ensures it is inside a single lock region.

The name "notifier_call_chain_error()" seems confusing, it almost sounds
like it's notifying an error code.  Then again, I can't really think of
a more reasonably succinct name.

> @@ -25,8 +25,23 @@ static int cpu_pm_notify(enum cpu_pm_eve
>  	 * RCU know this.
>  	 */
>  	rcu_irq_enter_irqson();
> -	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
> -		nr_to_call, nr_calls);
> +	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
> +	rcu_irq_exit_irqson();
> +
> +	return notifier_to_errno(ret);
> +}
> +
> +static int cpu_pm_notify_error(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
> +{
> +	int ret;
> +
> +	/*
> +	 * __atomic_notifier_call_chain has a RCU read critical section, which

__atomic_notifier_call_chain() no longer exists.

> +	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let

"dysfunctional"

> @@ -156,43 +169,30 @@ int atomic_notifier_chain_unregister(str
>  }
>  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
>  
> -/**
> - *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
> - *	@nh: Pointer to head of the atomic notifier chain
> - *	@val: Value passed unmodified to notifier function
> - *	@v: Pointer passed unmodified to notifier function
> - *	@nr_to_call: See the comment for notifier_call_chain.
> - *	@nr_calls: See the comment for notifier_call_chain.
> - *
> - *	Calls each function in a notifier chain in turn.  The functions
> - *	run in an atomic context, so they must not block.
> - *	This routine uses RCU to synchronize with changes to the chain.
> - *
> - *	If the return value of the notifier can be and'ed
> - *	with %NOTIFY_STOP_MASK then atomic_notifier_call_chain()
> - *	will return immediately, with the return value of
> - *	the notifier function which halted execution.
> - *	Otherwise the return value is the return value
> - *	of the last notifier function called.
> - */

Why remove the useful comment?

Ditto for the blocking, raw, srcu, comments.

-- 
Josh
