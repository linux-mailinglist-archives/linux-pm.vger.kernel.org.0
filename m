Return-Path: <linux-pm+bounces-41169-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKf4IVWib2mWDgAAu9opvQ
	(envelope-from <linux-pm+bounces-41169-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 16:42:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F22BB466CA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3810C96251F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B143D4E2;
	Tue, 20 Jan 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn4JA8d1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858340F8EB;
	Tue, 20 Jan 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919316; cv=none; b=ZtmkEAJW4NtVOcI1h+epmFa2h2YWuBBOlhBaYyRMwm+7DR6cLWuyD6lChrv+qFX8D4cyWThlrJfBmmTt3z/Dkpj0JwC8zac/ypMRvX5g87DnjAeTRZlyqg5OT9rAZH5LlMmXQpRNcHv73QIWHFfZ+K6kauCfmelhBsVIPexLk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919316; c=relaxed/simple;
	bh=OtwTnDpvDtbMBHvqPMZewcBZYEUS5NfRqaxfbB7joZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFXPBJLakzOgP1HbIGXK/w7Lgt/ATMl7FU6awjkCW4wHhl2OTasYh8kWt/0kaQE1CFYrcSUYXBy16fIqDQ6EeaBsYXcGBp2ezmYsGQA7qFOGzkAn9RcqY1hlPy8/A+JFWXFRk+Q7xxru3iEAXPeQf1YMAxRLGxfAjx67E4+HGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn4JA8d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D304CC19423;
	Tue, 20 Jan 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919316;
	bh=OtwTnDpvDtbMBHvqPMZewcBZYEUS5NfRqaxfbB7joZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn4JA8d1pUoK5IYDAD/REmgz3XFxvQ+4EMUiivOVIwX0mBUNuj1YudA6H2j/KP2js
	 1u7RZ3bveDlNfpGQfj5OGzCZJjpb35llivcWTSd1DS9XVszq78JeigVaaDJt30fVNe
	 m8EiHvICvqta/R6tBqkwUokrutW8CSVjFsCTw82ts94PN7Wb23kyOBNOizq+Fel7E3
	 RpxysRXLhJfosaVgI0e4cwNxSR+D+4cuGZXBmV9O3xQa+5Ik08YXEiNzb0UdVRDW//
	 xY4ofNxvVqahQAvNh0AywkWtlNbS4RWT6M+8pUp5n0ah3jDMHxD4+LYjUSU0SYsqyP
	 4vxzGPayTPZrQ==
Date: Tue, 20 Jan 2026 15:28:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
Message-ID: <aW-RDkr-KQ5pkFAX@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-8-frederic@kernel.org>
 <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>
 <aW6rAjJ5hz5BYuAR@pavilion.home>
 <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gfT1A9OtEzeyp0MJ7JmrPJXF0PWL-8dSdtJXp4pAE8fA@mail.gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41169-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Queue-Id: F22BB466CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Tue, Jan 20, 2026 at 01:32:50PM +0100, Rafael J. Wysocki a écrit :
> On Mon, Jan 19, 2026 at 11:07 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> > Le Mon, Jan 19, 2026 at 01:30:07PM +0100, Rafael J. Wysocki a écrit :
> > > On Fri, Jan 16, 2026 at 3:53 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> > > > accounting has a nanoseconds granularity.
> > > >
> > > > Use the appropriate indicator instead to make that deduction.
> > > >
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > >
> > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > >
> > > or please let me know if you want me to take this patch.
> >
> > The patch is standalone but the rest of the patchset depends on it.
> > Now I don't target this patchset for v6.20-rc1.
> >
> > So if you manage to sneak this patch in for v6.20-rc1, it works because
> > I'll rebase on -rc1. Otherwise I'll need to keep it to avoid breaking
> > some code assumptions.
> >
> > What do you think?
> 
> It can go into -rc1.

Very nice, thanks for taking it!


-- 
Frederic Weisbecker
SUSE Labs

