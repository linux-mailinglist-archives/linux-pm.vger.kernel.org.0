Return-Path: <linux-pm+bounces-43219-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E9ULGs3n2m5ZQQAu9opvQ
	(envelope-from <linux-pm+bounces-43219-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 18:54:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6FB19BD3C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D92530EE929
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 17:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055FE3E9F68;
	Wed, 25 Feb 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nozFdv18"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D33E9590;
	Wed, 25 Feb 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042041; cv=none; b=uHg2sCWgPPz5HkZFF5rO4idtgJHqfD3KGr284KSb1tAHFRSJ9rEgpLonC4+RyGbH+LKo8tWVbRgaRPVkpWS5DcH9rd3lIGoMVQNSDDdTN6cDOJQ2TSEF0APL3oCTrLvXkLFvntZm8grqL/qHffn0EfFBmK9WWkU8h6DA2NM4Jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042041; c=relaxed/simple;
	bh=1ja0Im2L512TnWD+YtXZk/OjjkIv31t+QXdUUTTm09c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ3P+EUN2fDa6abaETeBCdv7VZkxsQYEX1d1a/xg+exfFXaJTMolXon2BqnNTB8byP5AA5v1mDIl6RI4xGzr/asf5yNMiq+alsA7chuDteEINmh1+lmL0n5GqE43OlrcqZMc0DSdnnU9y3wvzjqyufzEs3g66R6RB9skVm4VI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nozFdv18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1311C2BC87;
	Wed, 25 Feb 2026 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772042041;
	bh=1ja0Im2L512TnWD+YtXZk/OjjkIv31t+QXdUUTTm09c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nozFdv18dEnsmrhlZWcRhWtDUIX1EWwkZLcRzAM9ktO+IohcwMNk81hN37Uf7mGdF
	 nV6y69G1IJZEFXt5Wla55LiJniiaxhe/b+IhgQZB0YuXE1TEGgdB6kXMglUYUxPXoe
	 y/9xWGtB0QipOlpXSon+KlN2a0QDdiYGc2xpvUmdh/I9TeEsb0UJRr7oSoy2wWoeWN
	 rC7Bea3hYQDTVO8OG9KUPEmCT3ODy9zslKab2BcI2Hn4dGZglZniSovWq5fiB2EwvC
	 aLeVNCa6z2loKoidfQx1ST4+Za5STT+XQMaZVJ+Z8hFj43qgG1zLY5dydiGlAchbiy
	 pvzi1zEEh6LDQ==
Message-ID: <c23954df-6323-4ace-9023-6370294da097@kernel.org>
Date: Wed, 25 Feb 2026 18:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>,
 linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-5-frederic@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260116145208.87445-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43219-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D6FB19BD3C
X-Rspamd-Action: no action



Le 16/01/2026 à 15:51, Frederic Weisbecker a écrit :
> Currently the tick subsystem stores the idle cputime accounting in
> private fields, allowing cohabitation with architecture idle vtime
> accounting. The former is fetched on online CPUs, the latter on offline
> CPUs.
> 
> For consolidation purpose, architecture vtime accounting will continue
> to account the cputime but will make a break when the idle tick is
> stopped. The dyntick cputime accounting will then be relayed by the tick
> subsystem so that the idle cputime is still seen advancing coherently
> even when the tick isn't there to flush the idle vtime.
> 
> Prepare for that and introduce three new APIs which will be used in
> subsequent patches:
> 
> _ vtime_dynticks_start() is deemed to be called when idle enters in
>    dyntick mode. The idle cputime that elapsed so far is accumulated.
> 
> - vtime_dynticks_stop() is deemed to be called when idle exits from
>    dyntick mode. The vtime entry clocks are fast-forward to current time
>    so that idle accounting restarts elapsing from now.
> 
> - vtime_reset() is deemed to be called from dynticks idle IRQ entry to
>    fast-forward the clock to current time so that the IRQ time is still
>    accounted by vtime while nohz cputime is paused.
> 
> Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
> accounting twice the idle cputime, along with nohz accounting.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   arch/powerpc/kernel/time.c | 41 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vtime.h      |  6 ++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 4bbeb8644d3d..9b3167274653 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -376,6 +376,47 @@ void vtime_task_switch(struct task_struct *prev)
>   		acct->starttime = acct0->starttime;
>   	}
>   }
> +
> +#ifdef CONFIG_NO_HZ_COMMON
> +/**
> + * vtime_reset - Fast forward vtime entry clocks
> + *
> + * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
> + * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
> + */
> +void vtime_reset(void)
> +{
> +	struct cpu_accounting_data *acct = get_accounting(current);
> +
> +	acct->starttime = mftb();
> +#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
> +	acct->startspurr = read_spurr(now);

'now' doesn't exist.

> +#endif
> +}
> +
> +/**
> + * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
> + *
> + * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
> + * is accumulated and the tick subsystem takes over the idle cputime accounting.
> + */
> +void vtime_dyntick_start(void)
> +{
> +	vtime_account_idle(current);
> +}
> +
> +/**
> + * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
> + *
> + * Called when idle exits from dyntick mode. The vtime entry clocks are
> + * fast-forward to current time so that idle accounting restarts elapsing from
> + * now.
> + */
> +void vtime_dyntick_stop(void)
> +{
> +	vtime_reset();
> +}
> +#endif /* CONFIG_NO_HZ_COMMON */
>   #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
>   
>   void __no_kcsan __delay(unsigned long loops)
> diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> index 737930f66c3e..10cdb08f960b 100644
> --- a/include/linux/vtime.h
> +++ b/include/linux/vtime.h
> @@ -37,11 +37,17 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
>   extern void vtime_account_softirq(struct task_struct *tsk);
>   extern void vtime_account_hardirq(struct task_struct *tsk);
>   extern void vtime_flush(struct task_struct *tsk);
> +extern void vtime_reset(void);
> +extern void vtime_dyntick_start(void);
> +extern void vtime_dyntick_stop(void);

extern keyword is pointless for function prototypes, we should refrain 
to add new ones.

>   #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
>   static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
>   static inline void vtime_account_softirq(struct task_struct *tsk) { }
>   static inline void vtime_account_hardirq(struct task_struct *tsk) { }
>   static inline void vtime_flush(struct task_struct *tsk) { }
> +static inline void vtime_reset(void) { }
> +static inline void vtime_dyntick_start(void) { }
> +extern inline void vtime_dyntick_stop(void) { }

Why extern for that one ?

>   #endif
>   
>   /*


