Return-Path: <linux-pm+bounces-27602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8DAC297C
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B493B56E0
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0129827B;
	Fri, 23 May 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+QidrSC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E322338;
	Fri, 23 May 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024359; cv=none; b=bDLwur7gdjdk0H0EewzN4SXGJvev8By/fgFy/wB3hSJqpiUhHDCxQsJ82e2wJI5Yt/UJSEY1QPsgNzOGv7ZJa34d7dRyPW93tZO5QgZQ0NKSmh3yiphV2KBWuLtlllw6B1QUpz5Ta7KtBnP7ADav6LPDu0DeCap2JIJIwpVawDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024359; c=relaxed/simple;
	bh=UDr/5RIKCa9bp1UFZAc5EQ9Zu8pOMOCa74Uh2voszAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp0+dN1mb+NhNRIj/qNInpKtwSqWvP5i3n5BRs+pATVO2JQ3R8hfn/Oc85xKaLeXwhMe7mvPZ3UOtQcrkUWIECu6QLhSPPrPp+QfqHCnKacfrfdg7zffH+/N6SlVKbUOL9MKQscDf/Ars14EYQ8zG5eUjiWzXLHfRlxB1+TDQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+QidrSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18730C4CEE9;
	Fri, 23 May 2025 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748024359;
	bh=UDr/5RIKCa9bp1UFZAc5EQ9Zu8pOMOCa74Uh2voszAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+QidrSCj31ByT8/TjFDPVH85BB414BXtLCea8gtGOENoMKr+Vgzkk4zPJAJlxoq+
	 bAYyshxHq47hmh7UPfNixCAaQaTnpC32ixWyGpFSXGO0sq+YJiQd955ctFhoMdlJNV
	 sUPZC2wxsJV5WLbpcFfT+6J+vmhGgbJ40BCeAqvoyeR0HiT7zqBs4b+ScBQsPRK6tI
	 ZFjae90JWFbTPMSXoLazmMNgcDgdmBGEB2b86SZGW2kt1OR3Ql6dNFwrASGywYZutQ
	 IF+GtLHGiH8i+m0hrYVo2yR5aaptx2xt0oc2q0g+3ZjKGXgh7bqW4M1OhgTfT48m41
	 j2NYpB7xj2ZJQ==
Date: Fri, 23 May 2025 08:19:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <aDC8JsZetV-GHhG_@slm.duckdns.org>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
 <aDCmyEGIpPv6ggF1@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCmyEGIpPv6ggF1@slm.duckdns.org>

On Fri, May 23, 2025 at 06:48:08AM -1000, Tejun Heo wrote:
> On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> > 
> > Due to the weird Makefile setup of sched the various files do not
> > compile as stand alone units. The new generation of editors are trying
> > to do just this -- mostly to offer fancy things like completions but
> > also better syntax highlighting and code navigation.
> > 
> > Specifically, I've been playing around with neovim and clangd.
> > 
> > Setting up clangd on the kernel source is a giant pain in the arse
> > (this really should be improved), but once you do manage, you run into
> > dumb stuff like the above.
> > 
> > Fix up the scheduler files to at least pretend to work.
> > 
> > (this excludes ext because those include games are worse than average)
> 
> Yeah, ext needs to move the stuff that's shared between ext.c and ext_idle.c
> into ext.h. cc: Andrea.

Thinking more about it, I wonder whether what should happen is re-splitting
the includes and all that but add the combined compilation as a
default-enabled option, so that the files can be built separately at least
when verifying the source files are in sane states. Including the same files
multiple times don't really cost anything signficant, so that still
maintains the benefits of faster build speed. The way things are set up now,
the separation across files are bound to decay over time.

Thanks.

-- 
tejun

