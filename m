Return-Path: <linux-pm+bounces-41170-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP9PBk+7b2kOMQAAu9opvQ
	(envelope-from <linux-pm+bounces-41170-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 18:28:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CB48911
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 18:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7E8E687DA7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC646AEF0;
	Tue, 20 Jan 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPSOBYBt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9A46AEEC;
	Tue, 20 Jan 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920740; cv=none; b=SU2ez78nZYYu0KvQMm0kZcp3Mz4MvOCNB8dPLKgu2fRYzuf4G7Qok2RuL0ZOpEkd/0xqWN/Jj771UO8CW8jhmI9EYldk0uzxGBaK5cdr7zPgB0FfNz8JNp/2bL7Zfmrlos9Z7+vLmvmTPQ6yZjnTIK/DkM25lNVj2j54UHL4UGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920740; c=relaxed/simple;
	bh=DpCSZAzTuJI/7gGOtphK/DlHzjIiahQ/22C6C32U1mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMNN9YkYJCeHmr69XZ7cxDBFiec9a9BJ0x81s7T/ZtOFjHMNp7sDou9PjGuJg2TeHyq3hDB9NBZT3L8iEMyWq3EVM1nlK9O+zDzv3W9MpcTNUkbkIjdnZnHxBBFt7poxrQlIif4ZngsiLjAsFylvzcIsbWRbSp4eyLr5xg0RIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPSOBYBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD110C4AF09;
	Tue, 20 Jan 2026 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768920739;
	bh=DpCSZAzTuJI/7gGOtphK/DlHzjIiahQ/22C6C32U1mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPSOBYBtcsR6iQhbXYih9Qp4HdBObVgVQWeBJdOmP5uvW3N0XpRwSuRGUWszm8Wsm
	 x7X1naATf4iHfH9+WXGmMpEbmoBIzfMBWDcjtXp2ALq+q0DiaZyE+0hf8qZzmfyuAh
	 +k54n2m4xgJ9vCgrUunkiflZvzFqqvPrajs2pQaTShpqhWcSbbMV55FcEigDfmF0b6
	 b/su04c8MKtL98toNNGznOkNtlwkGEo9U5PNysWfc/lynAGqRxUMUxxpDP98oacmK/
	 95IV+zJ4Gik2QAjU0tollXRYSthjis0U+sTqRza5ZxURR6g98HQ8t2T1QaqUfMgxNy
	 +l4xvmdsJAObg==
Date: Tue, 20 Jan 2026 15:52:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
Message-ID: <aW-WoBsdb-jKDomL@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-2-frederic@kernel.org>
 <20260119125347.GT830755@noisy.programming.kicks-ass.net>
 <aW6ccexiQaPLQcS1@pavilion.home>
 <ec1fbc52-3e72-4a0f-954c-9ecf581f9e39@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec1fbc52-3e72-4a0f-954c-9ecf581f9e39@amd.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41170-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Queue-Id: EC5CB48911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Tue, Jan 20, 2026 at 09:56:12AM +0530, K Prateek Nayak a écrit :
> Hello Frederic, Peter,
> 
> On 1/20/2026 2:34 AM, Frederic Weisbecker wrote:
> > Le Mon, Jan 19, 2026 at 01:53:47PM +0100, Peter Zijlstra a écrit :
> >> On Fri, Jan 16, 2026 at 03:51:54PM +0100, Frederic Weisbecker wrote:
> >>
> >>>  kernel/sched/idle.c | 11 ++++++-----
> >>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >>> index c174afe1dd17..35d79af3286d 100644
> >>> --- a/kernel/sched/idle.c
> >>> +++ b/kernel/sched/idle.c
> >>> @@ -260,6 +260,12 @@ static void do_idle(void)
> >>>  {
> >>>  	int cpu = smp_processor_id();
> >>>  
> >>> +	if (cpu_is_offline(cpu)) {
> >>
> >> Does it make sense to make that: if (unlikely(cpu_is_offline(cpu))) ?
> > 
> > Yes indeed!
> 
> nit. but don't we inherit it from:
> 
> #define cpu_is_offline(cpu)     unlikely(!cpu_online(cpu))
> 
> so it will end up being annotated with unlikely() no?

Ah right!

> 
> -- 
> Thanks and Regards,
> Prateek
> 

-- 
Frederic Weisbecker
SUSE Labs

