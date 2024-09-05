Return-Path: <linux-pm+bounces-13675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DA96D467
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8071C22F10
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B21991C9;
	Thu,  5 Sep 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RRvzrthn"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77D18732F;
	Thu,  5 Sep 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529900; cv=none; b=lHHUbfNgo/WQK8L63Fk7vyB2gbcg8ZJhL7t/BJLXfkcnErDn8rluaL4i3naJUU0unMmcnUml2Yc5OPDGyp+O45ftXeMQxuzFeyxrK3bha/i6ea6CPwfRr2cdq/FVM6aLdw9Dg/LCXFFiPKTTpGwd0VzSmMQQjvdSmOqx7BJlBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529900; c=relaxed/simple;
	bh=/aV6ELHH7RSjtnMAdXydDe60k9B7lF5WEKVS3VphtME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df8Ytt1NpxuVPRsjOPyNjn6khscjk8iOeh2So1drx9Exoq4U7zB8r4sak9HvZKA1rbpFBNOsLp2bp98q9b1QKbMD5EzVAcS7xigohD4lHjpakRnYEuH5yzhBzsuaNuWia4h7geOmXn7PhFfpDwtWEF7ubPyP5o/P7k3QpzryxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RRvzrthn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=abaPziHXBd4s3RieNdcbjSJLRTYtbh06JX3q+3G3zhE=; b=RRvzrthnRJtWvd6iCRT7PBvRyo
	/XR3TPA/hGoQgwDoXuVzmURocmBHVE7hwt86s01nAyrlozgWT0zAWtV5E3vYEllyXlAoPhljfdQIB
	eZcOqFqIqouioeuMaykGYYdIXGsY0NAqZyMOvruXs28iA2kzXTOn4WgeXijqru5krkwt7/fpzmd+M
	6Zt2cMrJx/0KbmOKaZE4/+oyo1gUtFRdFZp1ug67HM2Bwrqjk1syRGezORcBicKhEJkssg8iC9WI/
	4DY/9cFCp/nRzh1Am8o7osNeykQY/pTDA8o0AdwpyHeCpUpsQ0FjgFBX3x2cxz8AKlZsrX28LnFlN
	gYLVVUBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sm99J-00000002C9z-3UD6;
	Thu, 05 Sep 2024 09:51:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0669300599; Thu,  5 Sep 2024 11:51:34 +0200 (CEST)
Date: Thu, 5 Sep 2024 11:51:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rafael@kernel.org,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
Message-ID: <20240905095134.GC15400@noisy.programming.kicks-ass.net>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>

On Wed, Sep 04, 2024 at 08:41:23AM -0600, Jens Axboe wrote:

> > Yeah, but *WHY* !?!? I have some vague memories from last time around,
> > but patches should really keep this information.
> 
> To decouple the frequency boost on short waits from the accounting side,
> as lots of tooling equates iowait time with busy time and reports it as
> such. Yeah that's garbage and a reporting issue, but decades of
> education hasn't really improved on that. We should've dumped iowait
> once we moved away from 1-2 processor system or had preemptible kernels,
> but alas we did not and here we are in 2024.

There's 'WAIT' in the name, what broken piece of garbage reports it as
busy time? That has *NEVER* been right. Even on UP systems where IO-wait
is actually a sensible number, it is explicitly the time it *could* have
been busy, if only the IO were faster.

And are we really going to make the whole kernel situation worse just
because there's a bunch of broken userspace?

> >> Patches 1..3 are prep patches, changing the type of
> >> task_struct->nr_iowait and adding helpers to manipulate the iowait counts.
> >>
> >> Patch 4 does the actual splitting.
> >>
> >> This has been sitting for a while, would be nice to get this queued up
> >> for 6.12. Comments welcome!
> > 
> > Ufff, and all this because menu-governor does something insane :-(
> > 
> > Rafael, why can't we simply remove this from menu? All the nr_iowait*()
> > users are basically broken and I would much rather fix broken rather
> > than work around broken like this.
> > 
> > That is, from where I'm sitting this all makes the io-wait situation far
> > worse instead of better.
> 
> IMHO what we need is a way to propagate expected wait times for a
> sleeper. Right now iowait serves this purpose in a very crude way, in
> that it doesn't really tell you the expected wait, just that it's a
> short one.

Expected wait time is one thing, but you then *still* have no clue what
CPU it will get back on. Very typically it will be another CPU in the
same cache cluster. One that had no consideration of it when it went to
sleep.

A sleeping task is not associated with a CPU. There is a fundamental
mismatch there.

Using io-wait for idle state selection is very tricky because of this.

> If we simply remove iowait frequency boosting, then we'll have big
> regressions particularly for low/sync storage IO.

The frequency boosting thing I don't object to. That happend on wakeup
after we know that and where a task is going to run.

