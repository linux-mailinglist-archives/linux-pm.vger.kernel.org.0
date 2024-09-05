Return-Path: <linux-pm+bounces-13673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6FA96D373
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC9F1C25A91
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C102194AF3;
	Thu,  5 Sep 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aE1XIjPT"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AD2107;
	Thu,  5 Sep 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528973; cv=none; b=XEJ00WQ5WwoMAXS62ROLcy/HvIb0gGu6KCKuTlEIwxh8n8BJPHvnY3Kijgq+VwjRg2fy/vzjK9rlMdPlgjy60UOPIHeocPxFuzmXmw3j+c2AGBBvGFTnJtCEpy912LKeitq5d+pfmdprv0b+lwOb+2Br9HRkaaJrCe8665QXif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528973; c=relaxed/simple;
	bh=TsX4HNYJRYQ3b4miU4bbbI2kC1l3WTu/SURXtvFNfWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFzyJwNC7ibH8dDkdxf3crFr+IgOBGDRKoLn2uHRk1T+di+BaUrzxvhCHv1nFMgaHDhDGERfk4qYIMiiyclNVOGlJ4kej2tDqF/Zbeor44+ugMD9M7A0QDvHl66R+PN0OSGZtVrwPHHHYDXqXddiTbssm5XIjmaZmtT8a9rZo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aE1XIjPT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FNW3preQti8XyoWg/zqU1z7ONAVaLVpYxz3a9sBv3TA=; b=aE1XIjPT/Mnz3cccqMVbPbksX4
	gN+PcvP7ILMx8km+itTNCcauMNhaGekVRQ+oHukD23I/Gxuvi9/jmEIhXF8dgPvAeABXFaOqq+Wc5
	Cqfdccshjx3zeBLSuygSLcQWEsR8VopXcKb/hvXB26Yh5Ar1/2Ilsn5d+nIaxqB6o1NZASzBizpzV
	iFOK0x1Pee0Wvg00apnN+kjShyPsLiDozODUYQhO+Z/juvAtetnyOFbq+PoT1OK63ZWsKNLa5xHh7
	+GERdEF7DQJ9yUij8Z6qxZw7hlMqlaSClQ90MMsf76wQ2/cSlC8c81UELq/O4cVU3Sv/AsVKdgT3V
	pevt6JJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sm8uM-00000002B3V-215u;
	Thu, 05 Sep 2024 09:36:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63270300599; Thu,  5 Sep 2024 11:36:07 +0200 (CEST)
Date: Thu, 5 Sep 2024 11:36:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
Message-ID: <20240905093607.GB15400@noisy.programming.kicks-ass.net>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
 <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>

On Wed, Sep 04, 2024 at 05:18:57PM +0200, Rafael J. Wysocki wrote:

> To be more precise, there are two different uses of "iowait" in PM.
> 
> One is the nr_iowait_cpu() call in menu_select() and the result of it
> is used for two purposes: (1) select different sets of statistics
> depending on whether or not this number is zero and (2) set a limit
> for the idle state's exit latency that depends on this number (but
> note that it only takes effect when the "iowait" statistics are used
> in the first place).  Both of these are arguably questionable and it
> is unclear to me whether or not they actually help and how much.

So this one is very dubious, it relies on tasks getting back on the CPU
they went to sleep on -- not guaranteed at all.

> The other use is boosting CPU frequency in schedutil and intel_pstate
> if SCHED_CPUFREQ_IOWAIT is passed to them which in turn depends on the
> p->in_iowait value in enqueue_task_fair().

This one is fine and makes sense. At this point we know that p is going
to run and where it is going to run.

