Return-Path: <linux-pm+bounces-30940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2379B07CFE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548BF1C23204
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E29288CB7;
	Wed, 16 Jul 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jMzt0Cbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FEB7346F;
	Wed, 16 Jul 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691006; cv=none; b=R4iX/znnEs0Q2MyRUqvpDNLSndzoFGfkxnjBpcoLwWBqIbxW7nLb1YnZJ2ARUuF3Ei9X/Pq519Sc7Wlrg6arKLUCZJfElDqBWHq7nFy5snVANm6o+cbRdHxxhWvK6TSm+AFahOto8eg3mTLGPccb107HCU7bbwxcuO95mm4Rt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691006; c=relaxed/simple;
	bh=1NpaKjaM3/4/cf2WZaf74wakQGEw0joAtJ3bc4Jdjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYd7WFr/D8BclvhkZM7MXRtjDy0mJg8IKp7udWP60i3Mrw6/Y/XjXv7I19i5nEKLpeCA8B8S36SJLmFRlos+Sr21BLOtaY4ovNE+KPw5Ks/dtFRErma4qJFjPXDBv6GcOvquBVlpmtTahKGIghOHWMgliWu/vjQyurgXtyLOSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jMzt0Cbq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GU6y5kCNABbY0nc7oCLioqncGXIwHA2oqKU6IqcfIfM=; b=jMzt0CbqqKcCF2zaaffnUOENHg
	AcMbtqVb+aZfEfm6SyraaM8fOLlO2RtsOKLHzrDws8bZZQKtbyLn/1roGlEf7zDoojfpe1D9/2+B8
	18QRDg0Ja3eM9s3sFqo1K7V1661DhB5dlfx+gKnK7HmWUzGTYmYwrgPro5j7jfb3MvnMgKmUtDcdf
	gsK/KIVgSnlQuPQn+JUrOwjW1ipxXOHsphxajIn026pDVS3UsK/MSKWmhoeO88B600YoCn/u1oEDJ
	iC0+BUq6UkCa2H2rJ9XgU3+xf6qglyAbIppQfYrSBo+Og5OLKJpX7AiaKn9c9KUQu1ll3T84betUd
	hA4I/jXg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc6zd-0000000A9kr-3yAv;
	Wed, 16 Jul 2025 18:36:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82D1B300186; Wed, 16 Jul 2025 20:36:37 +0200 (CEST)
Date: Wed, 16 Jul 2025 20:36:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>,
	"rafael J . wysocki" <rafael@kernel.org>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce
 freeze latency
Message-ID: <20250716183637.GJ4105545@noisy.programming.kicks-ass.net>
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
 <20250716163854.GE16401@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716163854.GE16401@redhat.com>

On Wed, Jul 16, 2025 at 06:38:55PM +0200, Oleg Nesterov wrote:
> On 07/16, Zihuan Zhang wrote:
> >
> > @@ -51,7 +51,15 @@ static int try_to_freeze_tasks(bool user_only)
> >  		todo = 0;
> >  		read_lock(&tasklist_lock);
> >  		for_each_process_thread(g, p) {
> > -			if (p == current || !freeze_task(p))
> > +			/*
> > +			 * Zombie and dead tasks are not running anymore and cannot enter
> > +			 * the __refrigerator(). Skipping them avoids unnecessary freeze attempts.
> > +			 *
> > +			 * TODO: Consider using PF_NOFREEZE instead, which may provide
> > +			 * a more generic exclusion mechanism for other non-freezable tasks.
> > +			 * However, for now, exit_state is sufficient to skip user processes.
> 
> I don't really understand the comment... The freeze_task() paths already
> consider PF_NOFREEZE, although we can check it earlier as Peter suggests.

Right; I really don't understand why we should special case
->exit_state. Why not DTRT and optimize NOFREEZE if all this really
matters (smalls gains from what ISTR from the previous discussion).

