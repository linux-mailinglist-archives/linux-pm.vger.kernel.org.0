Return-Path: <linux-pm+bounces-13678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4278E96D695
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39A3288A2F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8E198E86;
	Thu,  5 Sep 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pYX8tclX"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744C194A4C;
	Thu,  5 Sep 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534015; cv=none; b=bNhmCQIdtW6Er+ypPuBBGmHIKPWNdO9QAHsgny7f1+o8FIztoAE+vsUII5eTDdsOebnS2rc/+2iEaVA/sIiTxkzfFIOspiEa0SMiwp7YCXY0yP5elnNoXDMMNXGh7VMw+EOuHealXLGKGlRYg6F2lYHGtJc49M1HDy5EDMr6E64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534015; c=relaxed/simple;
	bh=qqu+UVLLFRQmFW4+PgMflQz1ZFN1XGdRbxoaV3dbM+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crIUI9Fiksz6qQ0zbpFBHRESBCSOQpbhIapxMMi2n0GvuerzVoVGYLFKuyEglgZagxRIK6ZRHAt5tywTqhUnSoyfzsiyFbttoz6XT7nFjBO2UqJfG4q9DVO1R4q1+j6iyivfR9DmUy0fwppoGRzAwJdRQSmWUg5KT5631CWV47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pYX8tclX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XwQHAg35CoC49Rywl870ZXsEshaEFtP6Wz0WnEqtpwY=; b=pYX8tclX9lCLyy50pa45sBsrsF
	6W4BLiL4jp1An+8SrqJFQH3z0pGw21gaMNbhw6fJzrKOAEWDiE8xWr745SMugaTYhszJzaxbHWGzE
	0gpMxCKWAmucxsH8E8ENxhvceLK9AoGMf3XPfyGOEqH2nif6xrOZ7++aIi6zNZgWf4uka+pA8E6c1
	VM/bOHypx8TBnYrL4FiPbFodrKRFDPDrkCIKt+sNhWdE1T2wcQF/3s5u16N01+cbUA1giUALvN95d
	mgvwuWKkdWGBswjC9KmDKY/NOYAAjsNV9YyWi5u/i7DCdvIy5UbVNgUucRDA5/tM7BFNHBLzePERl
	nVYjORsA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smADe-00000000T8k-3JzY;
	Thu, 05 Sep 2024 11:00:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6EC9C300599; Thu,  5 Sep 2024 13:00:06 +0200 (CEST)
Date: Thu, 5 Sep 2024 13:00:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
Message-ID: <20240905110006.GF15400@noisy.programming.kicks-ass.net>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
 <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
 <20240905093607.GB15400@noisy.programming.kicks-ass.net>
 <3efadac3-1aa0-4747-b140-3fb6f267586e@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efadac3-1aa0-4747-b140-3fb6f267586e@arm.com>

On Thu, Sep 05, 2024 at 11:31:09AM +0100, Christian Loehle wrote:
> On 9/5/24 10:36, Peter Zijlstra wrote:
> > On Wed, Sep 04, 2024 at 05:18:57PM +0200, Rafael J. Wysocki wrote:
> > 
> >> To be more precise, there are two different uses of "iowait" in PM.
> >>
> >> One is the nr_iowait_cpu() call in menu_select() and the result of it
> >> is used for two purposes: (1) select different sets of statistics
> >> depending on whether or not this number is zero and (2) set a limit
> >> for the idle state's exit latency that depends on this number (but
> >> note that it only takes effect when the "iowait" statistics are used
> >> in the first place).  Both of these are arguably questionable and it
> >> is unclear to me whether or not they actually help and how much.
> > 
> > So this one is very dubious, it relies on tasks getting back on the CPU
> > they went to sleep on -- not guaranteed at all.
> > 
> >> The other use is boosting CPU frequency in schedutil and intel_pstate
> >> if SCHED_CPUFREQ_IOWAIT is passed to them which in turn depends on the
> >> p->in_iowait value in enqueue_task_fair().
> > 
> > This one is fine and makes sense. At this point we know that p is going
> > to run and where it is going to run.
> 
> On any even remotely realistic scenario and hardware though the boost
> isn't effective until the next enqueue-dequeue-cycle, so if your above
> objection is based on that, I would object here too, using your argument.

That is a quality of implementation issue with schedutil no?

The whole notion that the wait was for feeding external hardware, and
thus the normal utilization metric doesn't work right thing is still
valid.



