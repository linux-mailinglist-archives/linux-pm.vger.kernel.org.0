Return-Path: <linux-pm+bounces-19430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DCA9F67EB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8651416C276
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6C1BEF60;
	Wed, 18 Dec 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSjGdV7Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580719F41D;
	Wed, 18 Dec 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530661; cv=none; b=gHOrAukKKXduSPGmC06KQKAInXQp55zsL031jUqi0VFPvLL6UtIuY92ckU91TprHhBQ1f8DGbRhp5fiuoIsXBIfp77Rg2LzhYCkH/xyCsAEedXRK1O58/lKa+SS/Q5I+zwtMhZai5vxsxQkK9OBTB50ASZvNewtxed2wbqWOXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530661; c=relaxed/simple;
	bh=Viq/UnRlTIRlYrexjgMF2brgM0EKoFrlf6kCpW3HIM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCVa9iBF8ZvvcOOGTa0nDoF74xTLLlfAjkv7rcZj1VlimiPyAJjwTGqs6lEFBzsoDn4CxVSi3/FxsiwFDGJ6Uq6E9l3f96NI9nrTwKR1TljmoYyKDz1qCJPLrinorVuDhTu9BoLqh6BPcYfetLRrLu8oqrK1zDEuTJZzhmJ7Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSjGdV7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49489C4CECD;
	Wed, 18 Dec 2024 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734530658;
	bh=Viq/UnRlTIRlYrexjgMF2brgM0EKoFrlf6kCpW3HIM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSjGdV7ZFNt2WF98SuGC2Qmw8UBWI+vvur5bdwWG28Mkf2Yhq+ihmAHwbqJzkEbO3
	 hnzlNykLfmUtEBTKOWNNTo2CJKvs8EIC3Uo3+xJSMtSPf6wTgzRgZGxFPrbtQxYv6X
	 z+KZOYLRL0w8Tn1jo3KIL96kxhHRNu7Kf5Hq/73qT9SqPt4SJK9cRD/3M+OIVF9piZ
	 Vb3Epkgsfly/5KcEqhOBwjKfsQE3OtG/cToxkzfwiOs2ueY6W8lj7q75kqEaX50PTt
	 KPXz5i8/iGVWXQK0on7WnOO7VqWmbDVF3zCLv8KseS9Mj+adEtYWHeNP5CZnMnRTrY
	 2mvdD9wjKK5eQ==
Date: Wed, 18 Dec 2024 15:04:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/5] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_MWAIT states
Message-ID: <Z2LWX5jOTOD89yPl@localhost.localdomain>
References: <20241206130408.18690-1-frederic@kernel.org>
 <20241206130408.18690-4-frederic@kernel.org>
 <CAJZ5v0hJyeoeZ3L=RicDiHz9X8PqEvTgWJVT3s9rsy653w_Fug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hJyeoeZ3L=RicDiHz9X8PqEvTgWJVT3s9rsy653w_Fug@mail.gmail.com>

Le Wed, Dec 18, 2024 at 02:24:36PM +0100, Rafael J. Wysocki a écrit :
> On Fri, Dec 6, 2024 at 2:04 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > The current handling of TIF_NR_POLLING is a bit of a maze:
> >
> > 1) TIF_NR_POLLING is set on idle entry (one atomic set)
> >
> > 2) Once cpuidle has selected an appropriate state and the tick is
> >    evaluated and then possibly stopped, TIF_NR_POLLING is cleared
> >    (one RmW operation)
> >
> > 2) The cpuidle state is then called with TIF_NR_POLLING cleared but if
> >    the state polls on (or monitors) need_resched() it sets again
> >    TIF_NR_POLLING before sleeping and clears it on wake-up. Summary:
> >    another pair of set/clear
> >
> > 3) Set back TIF_NR_POLLING (one atomic set)
> >
> > 4) goto 2) if need_resched() is not set
> >
> > All those costly atomic operations, fully ordered RmW for some of
> > them, could be avoided if the cpuidle core knew in advance if the target
> > state polls on (or monitors) need_resched(). If so, TIF_NR_POLLING could
> > simply be set once upon entering the idle loop and cleared once after
> > idle loop exit.
> >
> > Start dealing with that with handling TIF_NR_POLLING on behalf of
> > mwait based states.
> >
> > [fweisbec: _ Handle broadcast properly
> >            _ Ignore mwait_idle() as it can be used by default_idle_call()]
> >
> > Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  arch/x86/include/asm/mwait.h |  3 +--
> >  drivers/cpuidle/cpuidle.c    | 22 +++++++++++++++++++-
> >  include/linux/sched/idle.h   |  7 ++++++-
> >  kernel/sched/idle.c          | 40 +++++++++++++-----------------------
> >  4 files changed, 42 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> > index 920426d691ce..3634d00e5c37 100644
> > --- a/arch/x86/include/asm/mwait.h
> > +++ b/arch/x86/include/asm/mwait.h
> > @@ -116,7 +116,7 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
> >   */
> >  static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
> >  {
> > -       if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
> > +       if (static_cpu_has_bug(X86_BUG_MONITOR) || !need_resched()) {
> 
> I'm not sure how X86_BUG_MONITOR is going to work after the change.
> 
> As is, X86_BUG_MONITOR prevents current_set_polling_and_test() from
> being called, so __current_set_polling() will not be called and
> TIF_POLLING_NRFLAG will not be set, so an IPI is going to be used for
> CPU wakeup, which is what X86_BUG_MONITOR wants.
> 
> Preventing need_resched() from being called doesn't have this effect
> and the rest of the patch doesn't do anything about X86_BUG_MONITOR.
> 
> Is anything missing?

I fear you're right, I overlooked that. Probably I should set CPUIDLE_FLAG_MWAIT
only if !boot_cpu_has_bug(X86_BUG_MONITOR). Lemme see that.

Thanks.

