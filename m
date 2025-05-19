Return-Path: <linux-pm+bounces-27344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C29ABBE6C
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861227A020B
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9BE27934A;
	Mon, 19 May 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRwXHkt4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97E278E79;
	Mon, 19 May 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659472; cv=none; b=L7gvx9yuA7tOPr9uApRIXKyFvl8WUvOeZx6irqvuL4QZ0jx2ca17mZZTb788Wcz7QRvSa42eaKD0NayFEwie6/GGVIiEJs/aLSajOc/jV1v3hhf1QpDgTP51YvbLP+9oIXXKBFweczLyFVKT6D0uFa8VPgIbINCVtF98pury5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659472; c=relaxed/simple;
	bh=kEOXFQHC9RoM8eAOkKs69L7ICX7VhE3OmdVsIRdGCTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqJf4IIsNgGtbk9PIbH3vZdCVAUlmtmt/wEIjKPl5W8YpTEyZ+x5X2xtQ5dQLBy+VaDZkxTxg3TqCKgx0kbpXigosQP4/I1d6Htsj0pfR1S6RQn1dGp9aPYXexeVWerF9n5hWr0PdkkiwISS9mPt9CJm64Qvtw9D3LzIUaZU5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRwXHkt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBEFC4CEE4;
	Mon, 19 May 2025 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747659471;
	bh=kEOXFQHC9RoM8eAOkKs69L7ICX7VhE3OmdVsIRdGCTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRwXHkt41r88inU1cYD9K+LCn94Q8Ws6urXoNboBr8VBvQCWA4V5kfGosC6qdJR/C
	 1c7J/73vEj/kTeRIF5XHlh3oqw5ttiZKLEp10C8MM8GDXVpcHdhEmtDUPEp4qD6XIe
	 nO3/P45Or0YwpgI1iVyGObUXvRZ2cqcxTzKsbHf0yYRVkqahahdv5vGnPCEYF0w6B5
	 Y2aqhZNcpombt/nRzszMzK9Jha2/lcNI9Uuk8Qc5qmGmJtPVEBiMYCw4dn8QEhxqTS
	 KUAdwLevGYC6hMGntBQzgxKA73TD8XEW39gc5dukXPDbWwGxwDeprPkumRQHsw5kXS
	 T3iUFMdZydSOQ==
Date: Mon, 19 May 2025 14:57:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when
 irqs_disabled()
Message-ID: <aCsqyrHdMWlU3yc0@gmail.com>
References: <20250516231858.27899-1-ebiggers@kernel.org>
 <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com>
 <20250517183919.GC1239@sol>
 <aCl_cSO2XqtSQEZT@gmail.com>
 <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
 <20250518200114.GA1764@sol>
 <aCrmZnSokvmqfel3@gmail.com>
 <CAMj1kXGe0hMD-71KYN_htJztAL+P8vFNf+9+W_aVDkHx3nCEWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGe0hMD-71KYN_htJztAL+P8vFNf+9+W_aVDkHx3nCEWA@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Mon, 19 May 2025 at 10:06, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > > > # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> > > >
> > > > Another case that likely executes with IRQs disabled (but I haven't
> > > > double checked) is reset_system(), which may return with an error, or
> > > > reboot/poweroff the machine and never return.
> > >
> > > That makes sense to me.  preempt_disable() and preempt_enable() are already
> > > allowed when IRQs are disabled, and I'm not sure why local_bh_disable() and
> > > local_bh_enable() are different.
> >
> > Because local_bh_enable() may run softirq handlers immediately if
> > there's pending softirqs, which shouldn't be done in hardirq context.
> >
> 
> Sure, but why is that mandatory?
>
> 
> preempt_disable() has preempt_enable() and preempt_enable_no_resched()
> counterparts.

> [...] Could we have a local_bh_enable_no_xxx() version that 
> re-enables async softirq processing on the current CPU but does not 
> kick off a synchronous processing run?

Yes, that's what __local_bh_enable() does, but if used it for 
kernel_fpu_end() we'd be introducing random softirq processing 
latencies. The softirq execution model is for softirqs to be 
immediately executed after local_bh_enable(), and various networking 
code is tuned to that behavior.

You can try talking the networking folks into an asynchronous 
local_bh_enable() executed on the next IRQ or the next scheduler tick 
or so, but it's a non-trivial behavioral change. It would probably also 
need user-return callback activation.

I'm pretty sure that the naive implementation would increase LAN ping 
latencies by +4 msecs on a typical distro kernel.

Thanks,

	Ingo

