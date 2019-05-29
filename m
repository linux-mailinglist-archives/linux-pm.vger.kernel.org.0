Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB532D86A
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 11:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2JDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 05:03:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2JDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 05:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DQecSnjdhg6zaZt0Sm+a9voWoeWmhZYoxUEy6QCaRzg=; b=ujCnVLHXd3svo0YUlFR+yRj41
        NfM8tDeaWnjSh4BH8141kURu7wQ4RIBK4RryFX7XjTYCAPKHQTTE568TKC7nKa3OwddUxxADTNb/K
        O1FGblx9WzUKZb+yn07+yc5QIO4BhwIubOxLXuwpdwrrqxi2YyA8bUlVfU53ZhBvqyQklYmODyFDB
        TsJACk7PpPhbAr7HcA4UKNXCuHt0HIgfA0TKe/SEEh0sIhzS781jKbAOOn73xcFTVBhhn1p0SsafH
        MkjVKuzIYtswUA0BP+KjJIyS6m3ySpsPWkZCibV/0snf5/ct28YMIH7LN0hhxggX5MCnCxMX6yQkH
        pJIQMWO3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVuUd-0002lp-SK; Wed, 29 May 2019 09:03:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56E9C201A7E42; Wed, 29 May 2019 11:03:30 +0200 (CEST)
Date:   Wed, 29 May 2019 11:03:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190529090330.GI2623@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 11:31:45PM +0200, Jiri Kosina wrote:

> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index a7d966964c6f..bde8ce1f6c6c 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -299,9 +299,20 @@ int hibernate_resume_nonboot_cpu_disable(void)
>  	 * address in its instruction pointer may not be possible to resolve
>  	 * any more at that point (the page tables used by it previously may
>  	 * have been overwritten by hibernate image data).
> +	 *
> +	 * First, make sure that we wake up all the potentially disabled SMT
> +	 * threads which have been initially brought up and then put into
> +	 * mwait/cpuidle sleep.
> +	 * Those will be put to proper (not interfering with hibernation
> +	 * resume) sleep afterwards, and the resumed kernel will decide itself
> +	 * what to do with them.
>  	 */
>  	smp_ops.play_dead = resume_play_dead;

Oooh, teh yuck!, but this explains my confusion from the other thread.

> +	ret = cpuhp_smt_enable();
> +	if (ret)
> +		goto out;
>  	ret = disable_nonboot_cpus();
> +out:
>  	smp_ops.play_dead = play_dead;
>  	return ret;
>  }

I think you can avoid the goto like:

	ret = cpuhp_smt_enable();
	if (ret)
		return ret;

	smp_ops.play_dead = resume_play_dead;
	ret = disable_nonboot_cpus();
	smp_ops.play_dead = play_dead;
	return ret;

We don't need the play dead change to online CPUs.

