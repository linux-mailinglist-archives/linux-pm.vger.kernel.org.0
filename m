Return-Path: <linux-pm+bounces-27643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1FAC3C36
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8124D189503E
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7D1E9B0B;
	Mon, 26 May 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPKCVH/o"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657212AEFE;
	Mon, 26 May 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249993; cv=none; b=b669CAIhxazAX2KsQvm12cD9nTC266X1kpIOCViZQ3fDjpf3B4t0x/O2JxcR6B+9ITGB87O9USWk1EYGjxuOfWoYwBKdoNJO3PRMgTqJWrbQtWYTfw+0hAWzFMKBSmnSOGKL0BBTX/ehp6RkOIQ5oM/3oUuA3kGi8sgqzkgA1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249993; c=relaxed/simple;
	bh=TMcUB/LB+1jE6Ec6x90eZmChUh2FqQpkKLIRpuR6q5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYR6/v4T9Ry1r1PRBnlZcHaDutLadOlPODeuJfUVHdxFD+NS7YKuXsffD4pWrIYNL23R1NW0JZmtQ3cBOYyX+vZI01X2l9lLMrIEy0PH3g25DqVT5j3NV/vnumXVdCE+HrFYuhTXJTJi1itoiZwTgNp+PJ8bIsej3d+Zb7kOoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qPKCVH/o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0eMy8vq5h+PybiES5IoQMngwNShFL7iseFqitaneLkI=; b=qPKCVH/oRsNiTrDqwyuKljUrce
	M/zc78XLmFLnlJmhDHXHL08ROttqBa2UK/VtOXhVT5I/LnMp4mZlIMusIUWnEIyjaFc1lLSq/6e1X
	OjATElDqxV+GqmmRe4sCdqi8lUSV5+cgZ+cFva6alwtZ9NXq1ei3DM+82PtCtuvIR1zQsFW1NvNbA
	HQb6qOed/3iQ2DRAIOUdoD3ovZH6XMWAR6aRET7MMgTWEcbx/ie+VshgrdQYLsXUBwMkghYjWO8X1
	pwRrRH54UGU0jOQxFyYAov4ar9dONPKCtHwbs9O9/qxpBTujRTHtvKHeOd6sWa7ioRVP17ts1pxhH
	enbcuT4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJTgN-0000000BDdI-3UvI;
	Mon, 26 May 2025 08:59:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3BBF330066A; Mon, 26 May 2025 10:59:43 +0200 (CEST)
Date: Mon, 26 May 2025 10:59:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	masahiroy@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <20250526085943.GQ39944@noisy.programming.kicks-ass.net>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523164348.GN39944@noisy.programming.kicks-ass.net>

On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:

> Setting up clangd on the kernel source is a giant pain in the arse
> (this really should be improved), but once you do manage, you run into
> dumb stuff like the above.

Given Steve asked for an emacs lsp plugin, I'm guessing he's going to be
wanting this part too.

The way I got clangd working is something like:


$ mkdir clangd-build
$ make O=clangd-build allmodconfig
$ make O=clangd-build LLVM=-19 -j128
$ cd clangd-build
$ ../scripts/clang-tools/gen_compile_commands.py
$ sed -i "s'randomize-layout-seed-file=\.'randomize-layout-seed-file=$PWD'g" compile_commands.json
$ cd -
$ ln -s clang-build/compile_commands.json 

I then also have:

$ cat .clangd
# https://clangd.llvm.org/config
CompileFlags:
  Add: -ferror-limit=0
Diagnostics:
  ClangTidy:
    Remove: bugprone-sizeof-expression
  UnusedIncludes: None
Completion:
  HeaderInsertion: Never
$


This has you sit on about 10G of build output, and while it is very
tempting to do make clean on clangd-build, this will in fact ruin
things. You can however manually delete all the compiler output, just
not the various generated files.

I've not been annoyed enough to (or out of diskspace enough) to go stare
at fixing the Makefiles to make all this easier. But ideally it would be
possible to do a no-op build to just generate the .cmd files without
doing any actual compiling -- building allmodconfig is slow, doubly so
with allmodconfig.

Or maybe this is already possible and I just didn't find the magic
incantations.

