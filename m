Return-Path: <linux-pm+bounces-30262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A766AFB0CC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF02D17328F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9E292B31;
	Mon,  7 Jul 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n1gWQ1su"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7611BD9F0;
	Mon,  7 Jul 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883029; cv=none; b=DKQ87Glu+DwMLynAS+t1Js0ecw1NZMwl/WHBFa6OeVWaxYNep4JjsWoqj1/alxUFQCQWTTiacq4eMg9sex7NXJhwY8xJuaKMZQo/PH285ZT8o92HYc/YKysAaOciTU8f+2d/b/x5pac0yge5CTNPo0iR0+5CeWmprZB04QE2DXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883029; c=relaxed/simple;
	bh=j/74EfwCut4e9GXyoPFJK6hkdne1vf1ui/JxX20Cg08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP7NJMrHPBxqV3t2AA9S/DDlzPU634SoejiJpOsg1UDRbYy+hYQm3W0F+BptgVnoPzwUP8ZdfTVPfQJuk5cITQGtcnM3NbMttjH/TES7uTgpGA6ZPRnHJWKLOzOvcuUCXVlOglrLbVwf08byz2VCBzPe17QIU/hIVuxHwT/dwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n1gWQ1su; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I57VkaSapJBkG6/ifvRIJbA8dsl3ex8n0FkR8Qwg0oo=; b=n1gWQ1suNLDJNKLEaSVcpE/Y3w
	FtbPZFxfG36Bs3zzKQcN1N2Way4NA/P0t4RTiSV9hEwNiq+64AtqjxqfI8A/C2pVr2mplyi5jFjVy
	gG9xIPkQLC/Rm9smpT4eBihU22tXgI59B71HuZE2P/AP1f9qt7M0874JcHDy9aCpb1CPN/xYXZSl5
	RiWPRYeCcoH6mNtEAtG1vrx8jIKc4g3wK1RDQHS9wL/NF1LpCqR3bvY1RcysmKeraVKEJtYgRziye
	WyNezsefN+BqeWqvw3M/VcR0gbHJQ2CeiUco1TQ5hpPlQaEHjj/8znPS697ZoCNhQYo0eAHA4fXpT
	0lZzL5HQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYink-0000000CW8r-42Vw;
	Mon, 07 Jul 2025 10:10:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A160300399; Mon, 07 Jul 2025 12:10:19 +0200 (CEST)
Date: Mon, 7 Jul 2025 12:10:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: timvp@google.com, Michal Koutn?? <mkoutny@suse.com>, rafael@kernel.org,
	pavel@kernel.org, tj@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <20250707101019.GE1613200@noisy.programming.kicks-ass.net>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
 <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
 <85fc85e8-af92-4d58-8271-9bf4aeb0a63d@huaweicloud.com>
 <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc5a4d3-6942-4ba2-a13d-35f2e13c0b37@huaweicloud.com>

On Mon, Jul 07, 2025 at 12:02:47PM +0800, Chen Ridong wrote:

> >> And I'm not quite sure I understand this hunk either. If we bail out,
> >> current->__state is reset to TASK_RUNNING, so what's the problem?
> > 
> > The issue occurs in this race scenario:
> > 
> > echo FROZEN > freezer.state
> >   freeze_cgroup()
> >     freeze_task()
> >       fake_signal_wake_up() // wakes task to freeze it
> > 
> > In task context:
> > get_signal
> >   try_to_freeze
> >     __refrigerator
> >       WRITE_ONCE(current->__state, TASK_FROZEN); // set TASK_FROZEN
> >       // race: cgroup state updates to frozen

I suppose this is me not quite knowing how this cgroup freezer works;
how does it race? what code marks the task frozen?

> >       freezing(current) now return false
> >       // We bail out, the task is not frozen but it should be frozen.
> > 
> > I hope this explanation clarifies the issue I encountered.
> > 
> 
> Hi, Peter, Tim
> 
> I was looking at the WARN_ON_ONCE(freezing(p)) check in __thaw_task
> and started wondering: since we already have !frozen(p) check, is this
> warning still needed? If we can remove it, maybe reverting commit
> cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen")
> would be a better approach.

I suppose that is possible; modern sensibilities require we write that
function something like so:

void __thaw_task(struct task_struct *p)
{
	guard(spinlock_irqsave)(&freezer_lock);
	if (frozen(p) && !task_call_func(p, __restore_freezer_state, NULL))
		wake_up_state(p, TASK_FROZEN);
}

