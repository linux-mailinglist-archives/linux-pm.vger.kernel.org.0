Return-Path: <linux-pm+bounces-41546-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gADgDV7TeGmNtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41546-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:01:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB29638D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B3C0315BC31
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237B35CBAC;
	Tue, 27 Jan 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1FxynCb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCD1DEFE9;
	Tue, 27 Jan 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525132; cv=none; b=VDKTZzG9zIk4tvLha2+Erc8eWuUJMNph0xOk1o8bSNeUwRl6JAr5psC0ZOrJfe48cC6f/un94ZQrxEqLY8X+4/DORA4myzVJd5gCtGcF4fm89A0ng52LGF4kq2lrxr090vlOi3dNnjz05zhyCTaY9Fc53U9PvYv5cNZBB/ahZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525132; c=relaxed/simple;
	bh=0YGeP0O62Pc53bwcfFkz6Pdb1KEkMMpDyI0yE++MS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Yg/eTOBnVgdXMVAIH6VT70hs/jKYuTG2hyLPSSmoBO/UU2CZKa8SlkJXEB8YrP+Zt+fvDnE1xdXNY4lm4uy1pwoZ50RLsy2LKeeMHrMITTEi5dl9hdh1kMhFpTK13O2UJaiquGOPT7k2fh5Q2sv4GvTQr16yeEJsMeq6w9y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1FxynCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C21C116C6;
	Tue, 27 Jan 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769525131;
	bh=0YGeP0O62Pc53bwcfFkz6Pdb1KEkMMpDyI0yE++MS9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1FxynCbgFyhQaZBWbdQ3U3/gG7zvUiYTdT05s4SfRvueGwkwdMXfQ67RXYmWXNMt
	 nJcwbHtZ7igNbyW3UV297EDBMkUnggDFqkNCcRRA+vRpQtytrAnvyEHNrTU6qtdODo
	 1LbCma+SiMl2LT5ZuLyH7tZpYFN9UJ2XKhsK4xuHGPaRH8LD/O8BLUfTlNb0oHlPNi
	 O/otIJveig2kXrzcfYZMWTt5fvWceAjmmlhVGZjLExQFzzscRRARYyYJJl4ENA3zWK
	 zldlROZ0P7SlFX+FcV4aIGqzhLCTEzmtf2d26kCH+JflCjYXc+hEeq7F76jfRgZo4e
	 vcqAUDXHE61jQ==
Date: Tue, 27 Jan 2026 15:45:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/15] s390/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <aXjPiZCHZ77R4awi@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-6-frederic@kernel.org>
 <20260121121748.9719Bab-hca@linux.ibm.com>
 <aXEVM-04lj0lntMr@localhost.localdomain>
 <20260122144045.38254A3e-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122144045.38254A3e-hca@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41546-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0BB29638D
X-Rspamd-Action: no action

Le Thu, Jan 22, 2026 at 03:40:45PM +0100, Heiko Carstens a écrit :
> On Wed, Jan 21, 2026 at 07:04:35PM +0100, Frederic Weisbecker wrote:
> > BTW here is a question for you, does the timer (as in get_cpu_timer()) still
> > decrements while in idle? I would assume not, given how lc->system_timer
> > is updated in account_idle_time_irq().
> 
> It is not decremented while in idle (or when the hypervisor schedules
> the virtual cpu away). We use the fact that the cpu timer is not
> decremented when the virtual cpu is not running vs the real
> time-of-day clock to calculate steal time.

Ok, good then!

> 
> > And another question in this same function is this :
> > 
> >     lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
> > 
> > clock_idle_enter is updated right before halting the CPU. But when was
> > last_update_clock updated last? Could be either task switch to idle, or
> > a previous idle tick interrupt or a previous idle IRQ entry. In any case
> > I'm not sure the difference is meaningful as steal time.
> > 
> > I must be missing something.
> 
> "It has been like that forever" :) However I do agree that this doesn't seem
> to make any sense. At least with the current implementation I cannot see how
> that makes sense, since the difference of two time stamps, which do not
> include any steal time are added.
> 
> Maybe it broke by some of all the changes over the years, or it was always
> wrong, or I am missing something too.
> 
> Will investigate and address it if required. Thank you for bringing this up!

Ok, I take some relief from the fact it's not only unclear to me :-)

> 
> > > Not sure what to do with this. I thought about removing those sysfs files
> > > already in the past, since they are of very limited use; and most likely
> > > nothing in user space would miss them.
> > 
> > Perhaps but this file is a good comparison point against /proc/stat because
> > s390 vtime is much closer to measuring the actual CPU halted time than what
> > the generic nohz accounting does (which includes more idle code execution).
> 
> Yes, while comparing those files I also see an unexpected difference of
> several seconds after two days of uptime; that is before your changes.
> 
> In theory the sum of idle and iowait in /proc/stat should be the same like the
> per-cpu idle_time_us sysfs file. But there is a difference, which shouldn't be
> there as far as I can tell. Yet another thing to look into.

Yes and that's expected both before and after my changes.

* /proc/stat is the time spent between tick_nohz_idle_enter() and
  tick_nohz_idle_exit() (to simplify, because there are some pause during
  idle IRQs).

* The s390 idle sysfs file depicts more closely the time spent while the
  CPU is really idle (and not executing idle code).

Different semantics and this is why you observe different results. I guess
/proc/stat has higher values (with idle + iowait) and that is expected.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

