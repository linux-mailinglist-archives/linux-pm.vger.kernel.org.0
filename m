Return-Path: <linux-pm+bounces-27659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104BDAC3EC3
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 13:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58C9174E28
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3C1FE469;
	Mon, 26 May 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvYtR+lQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD01F872D;
	Mon, 26 May 2025 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259876; cv=none; b=HHRJIsYVYXjHuLK11zmrKr31vSxsJaQOvcMGqdWYAQo+tOzxwhxhIgzqODo3/Liek9uVR3JfHkUcvRH0Cx4K4AaJGiB9DiVU1u/KNY9O2Xl66dyFq8bw2INDDJ1mAmg/aRjvgkFWMOKvMctEKl76JKznH8x8Fa4vbg7sz/s9JII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259876; c=relaxed/simple;
	bh=giGENE53qxWQJPWukWQhqDJ3LI7wXbBXFNGbQUFocHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jThwDC6hNff5csp9NMC6tC8lVUm4SBW+6owP3zl5s2XHBTv9YrJiatPmMRB4/gYG4r4OVe9R6MLPdoAmydLgm+pfzoDP4m7fEG2t4eQ4LL+FWrY5PIFx35QIUi+Fym8bAPRRCNCwLe32jfc82dko3lnV3/5M9n8DdBez7Ef5ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lvYtR+lQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=48dBCeI5TbVhMkXhhKHE8P/O97o5osySUXGb/a9HQGM=; b=lvYtR+lQwz1HGHcgQhAIWVb0mB
	8mAh4NXDyFVLjsLJjpk3qzayI7iKSLbBX6I4K8i7K9qzVL5WfOiPrv2ZKp4/2l5S9AgJhsL44y+MQ
	H+hAABFzwXvUdvK+miXo9hYnGC690njg3YzPrLMYqKplPc1kyKQ/3rYPrbLRFSziV4Tea21i5bAVu
	IfPfM2NWOIry6jMqIrq8WP0F4p1Zq0V0ugwKH+oyLujgzhaHPDv5B/6H/ttDvleaLQagvU/K43tRE
	0AXpHSLgNVEwu7kc1M02lek/Gye/AhVGGpaxJQDZBu/t4zdnAnzaMADiYS22LTB+6Pn4LajptrcIY
	PAzRuVeg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJWFl-0000000BNB4-0zqe;
	Mon, 26 May 2025 11:44:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9EDCE300472; Mon, 26 May 2025 13:44:24 +0200 (CEST)
Date: Mon, 26 May 2025 13:44:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	masahiroy@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <20250526114424.GE31726@noisy.programming.kicks-ass.net>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
 <20250526085943.GQ39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526085943.GQ39944@noisy.programming.kicks-ass.net>

On Mon, May 26, 2025 at 10:59:43AM +0200, Peter Zijlstra wrote:

> I've not been annoyed enough to (or out of diskspace enough) to go stare
> at fixing the Makefiles to make all this easier. But ideally it would be
> possible to do a no-op build to just generate the .cmd files without
> doing any actual compiling -- building allmodconfig is slow, doubly so
> with allmodconfig.
> 
> Or maybe this is already possible and I just didn't find the magic
> incantations.

So I had a quick peek at the Makefiles, and while there is a
compile_commands.json target (just not readily accessible without doing
other weird things), it still causes everything to be built :-(

