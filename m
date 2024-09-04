Return-Path: <linux-pm+bounces-13588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49EC96C06C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A15B1F23A22
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0A144316;
	Wed,  4 Sep 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vl08D1AY"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976D441D;
	Wed,  4 Sep 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460128; cv=none; b=JcL8tUE7rBjxd3cnZboIQxi/HclSvGctTZMvfojJgmng47sB1YRe1qfATvQ6BRAy919Iv9jKF4k51NSc9elXIPdA2XNgPpVVYfDidooDkG3Z1ShBa5xN5GU2oq8YeyEEpj1pGzq1hPWip9r0p5jLQ37qKfVcjvAc6JBWVplQoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460128; c=relaxed/simple;
	bh=h6qi7OJYw6lw0d+g19EW35P5d3ez9MJ76mD+ej0r9Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ridpcKZxtLgeQPnRwh5llhfonaR30kg4IaiJsIVe4IMi4i4BCQc0BTyf3ytq2Hq8Y/P8c3tQ0rrnZ33LhdTTNXR+jWM7ZYmOQvO/rF1a6Qj91IYau9rfKPzLKDlCsdB9S2kX8qjmpafUdR9pcctGC4T7xIRGi5rtWjrnnO6hSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vl08D1AY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u40QMF5x2NUW5Y4tWOwtilkkruVYCjqBSAXZKvLFW1U=; b=Vl08D1AYrLZZWnAJoLaDlc5SEh
	9aPXO+j4zGwAveF7A6NLNsFSmRyku+iRI9CoNrmiNHyEZFjHVGIS1748iqvK/QHPoO+LAjvqcm8Su
	RjfBxAfg1luMdkH+++spDLNop8zv4Br9vPF9DESskBxcAz8o7hODQcIcbTX2UDpeCS8YC0ugUeCWJ
	6DX7m2h9ULJEkAHv/0W1nt/h19q7Fww8cqIGlv0H5gDi/UcVC36/FnPFiIWTnvE0l02Jq9I0/inBV
	ZllDz+ixDM7WJpGjD8VH5pXQf4Rmc07mST3Og/kQ3LkXZGj3fQccnf3zeDiySw6XRlNfjlZu6HpAz
	u8udRsNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slqzy-00000000FUG-1yLs;
	Wed, 04 Sep 2024 14:28:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4DA4300642; Wed,  4 Sep 2024 16:28:41 +0200 (CEST)
Date: Wed, 4 Sep 2024 16:28:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rafael@kernel.org,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
Message-ID: <20240904142841.GL4723@noisy.programming.kicks-ass.net>
References: <20240819154259.215504-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819154259.215504-1-axboe@kernel.dk>

On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
> Hi,
> 
> This is v6 of the patchset where the current in_iowait state is split
> into two parts:
> 
> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>    in terms of sleep and wakeup latencies.
> 2) The above, and also accounted as such in the iowait stats.
> 
> The current ->in_iowait covers both, this series splits it into two types
> of state so that each can be controlled seperately.

Yeah, but *WHY* !?!? I have some vague memories from last time around,
but patches should really keep this information.

> Patches 1..3 are prep patches, changing the type of
> task_struct->nr_iowait and adding helpers to manipulate the iowait counts.
> 
> Patch 4 does the actual splitting.
> 
> This has been sitting for a while, would be nice to get this queued up
> for 6.12. Comments welcome!

Ufff, and all this because menu-governor does something insane :-(

Rafael, why can't we simply remove this from menu? All the nr_iowait*()
users are basically broken and I would much rather fix broken rather
than work around broken like this.

That is, from where I'm sitting this all makes the io-wait situation far
worse instead of better.



