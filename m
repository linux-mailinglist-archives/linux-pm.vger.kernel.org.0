Return-Path: <linux-pm+bounces-30074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72CAF7E0E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A7E584CA8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06612566E9;
	Thu,  3 Jul 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WvIbrqQY"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056C253B7E;
	Thu,  3 Jul 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560831; cv=none; b=PAIyyq8SjZ1lT3rKVvdBTolkFFybuUsbTKOdAjeDv5w9B5J9DTDmGx/1kIYhSuOU/3sfCFkzLz2zTgdHX00PHAGaW6YQXrkb/hU8PkOOrSL7qGUc2C+PZMty1NR8Lo81J8MoKcjsSV+Hh9Wc9tw3n6AwrNa5ONe+uN/qMvv1XxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560831; c=relaxed/simple;
	bh=Nq9rNp9BVIlEabZcClAYVRdzkuHt8U33NMSV2tNtP3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F51lBVEPt3PdiVirnSTx3gHB7LS+UZm5Ob6gEBmjBBZGdM8Lr6aiTTOR+9bDN7QIkLuuXNXDAr5dXxP0pK60WjT3zAfcWaJCnKTfrFfuS1QyvQ76gy27Dg5bA4isxvTkWlqWsdkv90zVnFemwAjLZOjKjxaPHd8kcBspIeCKGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WvIbrqQY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=p22ulm2JTnD0JZ9x5PYLNt42pL3casjMF3JEqG3pYOY=; b=WvIbrqQYf/a11dI5GiRZZ1D/xz
	pvNPmRHMpt5KHiHCnyk9kD1avieKDt50bs4HKSsZ67uheOEkBC4dk7ECasA+qaMblsYmCVE4ZsES1
	/zvICV/bU96sN1ulN+h5wGC6hvymQn0NySDz0ExCqufoKhaxyADDhJDLAwtNBHwh77vTGa3jeGPs1
	N7te0jr1w+wpXn7pVhqYsTqgHYtmePuGjceA5w7MHVQSGUrx/+TIRXONuxwSeR6JBWWUN3y/qV8sT
	sL3ctt3w1W1HSifXrjxmnKl9ll57kuw0PLKcDfPAVQKXYoSFIFAOLonWqSYhlxoZM5f0di1CX/zP5
	LLkyz73Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXMz0-00000007iGW-2g8d;
	Thu, 03 Jul 2025 16:40:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 95B5230017D; Thu, 03 Jul 2025 18:40:21 +0200 (CEST)
Date: Thu, 3 Jul 2025 18:40:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>, pavel@kernel.org,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
Message-ID: <20250703164021.GY1613200@noisy.programming.kicks-ass.net>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
 <20250611101247.15522-2-zhangzihuan@kylinos.cn>
 <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jpuUVM73M=Gzq36je=K_7zEkvVd8bxohi6N5OYgxgUug@mail.gmail.com>

On Thu, Jul 03, 2025 at 04:15:10PM +0200, Rafael J. Wysocki wrote:
> The patch subject appears to be incomplete.
> 
> On Wed, Jun 11, 2025 at 12:13 PM Zihuan Zhang <zhangzihuan@kylinos.cn> wrote:
> >
> > When freezing user space during suspend or hibernation, the freezer
> > iterates over all tasks and attempts to freeze them via
> > try_to_freeze_tasks().
> >
> > However, zombie processes (i.e., tasks in EXIT_ZOMBIE state) are no
> > longer running and will never enter the refrigerator. Trying to freeze
> > them is meaningless and causes extra overhead, especially when there are
> > thousands of zombies created during stress conditions such as fork
> > storms.
> >
> > This patch skips zombie processes during the freezing phase.
> >
> > In our testing with ~30,000 user processes (including many zombies), the
> > average freeze time during suspend (S3) dropped from ~43 ms to ~16 ms:
> >
> >     - Without the patch: ~43 ms average freeze latency
> >     - With the patch:    ~16 ms average freeze latency
> >     - Improvement:       ~62%
> 
> And what's the total suspend time on the system in question?
> 
> > This confirms that skipping zombies significantly speeds up the freezing
> > process when the system is under heavy load with many short-lived tasks.
> >
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> >
> > Changes in v3:
> > - Added performance test
> >
> > Changes in v2:
> > - Simplified code, added judgment of dead processes
> > - Rewrite changelog
> > ---
> >  kernel/power/process.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index a6f7ba2d283d..2bbe22610522 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
> >                 todo = 0;
> >                 read_lock(&tasklist_lock);
> >                 for_each_process_thread(g, p) {
> > -                       if (p == current || !freeze_task(p))
> > +                       if (p == current || p->exit_state || !freeze_task(p))
> >                                 continue;
> >
> >                         todo++;
> > --
> 
> This is basically fine by me, but I wonder what other people think.
> 
> Peter?

How realistic is it to have a significant amount of zombies when
freezing? This seems like an artificial corner case at best.

Zombie tasks are stuck waiting on their parent to consume their exit
state or something, right? And those parents being frozen, they pretty
much stay there.

So I suppose the logic holds, but urgh, do we really need this?

