Return-Path: <linux-pm+bounces-27644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF6AAC3C52
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FC73AB9FF
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A21E3762;
	Mon, 26 May 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cs7JLkxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD719D88F;
	Mon, 26 May 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250288; cv=none; b=Ie80/da+Em46SBf/Gps0F86/Kd+687urgHS+yRorKw33+O6DmfRK9FfWZqvF2G5U7F4hnoeuNQ+Ajtuy58aiyO38/tH9QSeCLLOJCOSgTBvPog9y8BqUjMoBd7dfvw1x0feA3Hre1Fy4M371IIKMuOwZaP+q8mYPOFYZANjnuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250288; c=relaxed/simple;
	bh=EQoCePGQ/6HVLQQKdnXIzcsGARxwEDOhnym0PaBQGcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tztfvFBWIntiNu1IKKWZeqqkoOAbABkKzId1EPGHzdu08OBeisIBj5VhQYijTj1lzdm/nE9HqtpX9Tun2QB+fDFTkWnZCQWxBlBNG929ejuqV4jKoFeliGsz86wkXXJuWwhZuY7J/vY5AR30VJktBDutbOONTG6PMOOTg36Wc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cs7JLkxT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rqxkoGqle+DY5KP+d10+n/tUx/tZ/tVc1Lafi/gnNYc=; b=cs7JLkxTx/8t/ZnbhrX1ad0r1r
	gFAgYostA0td+ESHFtKShitkuZ53EjGuUVfO7sSy6bSo1RqMYL7MrrPVMOHTmSU+E5PUZhx8/v6l1
	OMuyNFQyTM5QjVhXTbWWM+OSUWlU9Fp//BxcmSYPH2+oJiaIgjejkKezGV5lA/nmPW31wtfAN/7UD
	BCX8NM5kYTNCc2PfdZhq0JDgRbQBtdldghC8rm40kn8LOELj8OJSVgx8WUNxRHI2N5RXXIDWgjyR5
	OQN2srYlu9PoBayBSF+JxjU9J9QIK6AXiroaMYGjvaPQ4LhxXa/RJmTatk23VT4pPzfx0cZhkPQG/
	Qar6JRqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJTl6-00000001qMQ-0NTH;
	Mon, 26 May 2025 09:04:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D635300472; Mon, 26 May 2025 11:04:35 +0200 (CEST)
Date: Mon, 26 May 2025 11:04:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	masahiroy@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <20250526090435.GD31726@noisy.programming.kicks-ass.net>
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
> On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> 
> > Setting up clangd on the kernel source is a giant pain in the arse
> > (this really should be improved), but once you do manage, you run into
> > dumb stuff like the above.
> 
> Given Steve asked for an emacs lsp plugin, I'm guessing he's going to be
> wanting this part too.
> 
> The way I got clangd working is something like:
> 
> 
> $ mkdir clangd-build
> $ make O=clangd-build allmodconfig
> $ make O=clangd-build LLVM=-19 -j128
> $ cd clangd-build
> $ ../scripts/clang-tools/gen_compile_commands.py
> $ sed -i "s'randomize-layout-seed-file=\.'randomize-layout-seed-file=$PWD'g" compile_commands.json
> $ cd -
> $ ln -s clang-build/compile_commands.json 
> 
> I then also have:
> 
> $ cat .clangd
> # https://clangd.llvm.org/config
> CompileFlags:
>   Add: -ferror-limit=0
> Diagnostics:
>   ClangTidy:
>     Remove: bugprone-sizeof-expression
>   UnusedIncludes: None
> Completion:
>   HeaderInsertion: Never
> $
> 
> 
> This has you sit on about 10G of build output, and while it is very
> tempting to do make clean on clangd-build, this will in fact ruin
> things. You can however manually delete all the compiler output, just
> not the various generated files.
> 
> I've not been annoyed enough to (or out of diskspace enough) to go stare
> at fixing the Makefiles to make all this easier. But ideally it would be
> possible to do a no-op build to just generate the .cmd files without
> doing any actual compiling -- building allmodconfig is slow, doubly so
> with allmodconfig.

.. with clang -- gcc is still significantly faster; and I know there's a
k.org clang build optimized for kernels, however I seem to end up using
either distro builds or custom builds, neither of which are having
whatever goodness the k.org build has.

> Or maybe this is already possible and I just didn't find the magic
> incantations.

