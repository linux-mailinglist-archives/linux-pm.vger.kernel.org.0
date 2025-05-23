Return-Path: <linux-pm+bounces-27601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34315AC294B
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487243B4A63
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21E298CA4;
	Fri, 23 May 2025 18:08:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD225760;
	Fri, 23 May 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023729; cv=none; b=YDbj3wMqGcloimvWLFJME8qEhg6b72LWLxI/qEKNpQb3LEQeN7ixbn6ErRJrifWC3cLeVm1Ls2j8kq+DzJ2JRdpRgSbkdxi0An2pRtpS4EuQZah0tL+DLCbQKoIY3f7/cMS5vn/fQNEAqKCeMWl19I79TqxAEP2VDtNI9kMCyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023729; c=relaxed/simple;
	bh=lVUhNqT7I20BreW7FKLOev3uAsgdV7kiMkyWWtRtwZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deaQ2gA+Ls7UJHaLhBaehAsiUantSOiU5yVnlbfTbbmxMaUWTQ2xwdW4Mf4GMpu5UcrUh4yW+Jy3BGrlQojHatbqYbYDdfu2eYFLuwwnIzDTA0inBZSKhRwqjStE3Qq+tVjvBa8lcVkkCwEN7QqdMdj9ikNvi0Z2xUuT9hSmxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0DBC4CEE9;
	Fri, 23 May 2025 18:08:46 +0000 (UTC)
Date: Fri, 23 May 2025 14:09:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, hannes@cmpxchg.org,
 surenb@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 tj@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <20250523140935.556fdede@gandalf.local.home>
In-Reply-To: <20250523164914.GO39944@noisy.programming.kicks-ass.net>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
	<20250523164914.GO39944@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 18:49:14 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> > 
> > Due to the weird Makefile setup of sched the various files do not
> > compile as stand alone units. The new generation of editors are trying
> > to do just this -- mostly to offer fancy things like completions but
> > also better syntax highlighting and code navigation.  
> 
> To be fair, by far the biggest help has turned out to be to get instant
> compiler warning/fails while you type code. This has drastically reduced
> the stupid typo, doesn't compile, try again cycle.
> 
> Code completion is 'cute' but I'm not really limited in typing speed,
> getting pop-up function arguments while typing is useful.
> 
> The better code navigation is also very useful.

Is there an emacs extension? (I'm sure there is, I'm just too lazy to look ;-)

-- Steve

