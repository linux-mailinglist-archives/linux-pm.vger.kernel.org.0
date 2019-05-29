Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06332DC55
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfE2MCd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 08:02:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2MCd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 08:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8F19KGAZnZsYq954iIK5bGPIBzMRDalxLayfTO4ouik=; b=cLIGY6k6tiRv6LJ7woNdIZOmj
        z+VpD4wgAYSX3G/TuI6kMVam8b7tVY/c7h86sYGWVViMx6L8TzJ9cQFouIiFjJyVznSvCWzSAlnTj
        v4gBkGyUmqikF/ulWNpmLorECffy7rmfFuBEoEc5SWnVGH8X+XZEIwOIXzk23rTPdik8m00rbCFKi
        oCRZGKuiQmih82YkVMd43UWFd4KcFeOOL3ex+OziGqIljL0yA24BrPHmf+YJXzqy/uq4heoRX3KTt
        0+1ABZ2Q/jSAQ21kUBGBsi0qtWuDyZJDNrjFRADyGNNJZvXUTG91xTwLOQdqCD8cZbzHODRqxQmQk
        HL1dd1IFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVxHh-0003nt-7y; Wed, 29 May 2019 12:02:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3730201DA657; Wed, 29 May 2019 14:02:19 +0200 (CEST)
Date:   Wed, 29 May 2019 14:02:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
Message-ID: <20190529120219.GS2623@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 29, 2019 at 12:32:02PM +0200, Jiri Kosina wrote:
>  arch/x86/power/cpu.c | 10 ++++++++++
>  include/linux/cpu.h  |  2 ++
>  kernel/cpu.c         |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index a7d966964c6f..513ce09e9950 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -299,7 +299,17 @@ int hibernate_resume_nonboot_cpu_disable(void)
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
> +	ret = cpuhp_smt_enable();
> +	if (ret)
> +		return ret;
>  	smp_ops.play_dead = resume_play_dead;
>  	ret = disable_nonboot_cpus();
>  	smp_ops.play_dead = play_dead;

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
