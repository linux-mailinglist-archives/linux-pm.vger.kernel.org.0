Return-Path: <linux-pm+bounces-27621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B30AC2D26
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 04:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7911D7B30E8
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266591946C8;
	Sat, 24 May 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwdrdY+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831A3C1F;
	Sat, 24 May 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748055374; cv=none; b=V0QD1X20br7G+PewkwIQkuyzCe7pH6aiLQgC2ajg+WflBmWIYCTC7G9QS5J3w1p8DroB1443h0lRH6Fwxl66uiwnFk5aeUXKvdzDorT7s14aFJIgodyvbxB2+BmTG6P3BEADplt/3bPEsJSbpbxNPRWIA8H5eVcJkWbbkmT8fAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748055374; c=relaxed/simple;
	bh=+ETxQqm1eQuqJdqC0LMF8vy2BlyEGdf6TeoNQ5gOoRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbgzut+LtAwPlu11zbrPMPJFUmth20z+gxGty7gBuaiEQI5cP4RYD9MBuYtavLNjyRUyRpOs2fL5oHWlsWAKj/MnLEZRQZj3tzdkdefBbTwhNsXHlntv1J+bcv+mfxBdFCr6R+3u/n1fTRZ2e7z8OR11Yo3psi2s1dOJXksAa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwdrdY+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00850C4CEE9;
	Sat, 24 May 2025 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748055373;
	bh=+ETxQqm1eQuqJdqC0LMF8vy2BlyEGdf6TeoNQ5gOoRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwdrdY+DbpRK7HSVitrJcxZFMMGbkysG7fq86UfnHfP1DhYRTNFaNjwfPMCTXgm9g
	 Kndqb7wCNrQFpf3NNDl77WH14cJcBotmbmsDR/JLrZglupfpwQIKzNbUxODjlmRjDv
	 L2VnkaC5GKLVrnfvBihJKiU9dV1IvKTXwN5DMMUzLq7AnS1AxqU9SWgpj+PZ11eMkk
	 6yFFIC1u6YeD7j6k1Xm8VuOgmqTU9D3ikhl08f9zt25UaFbS/kHCc/fzvlBxzt635B
	 rLIahp0avfvvNzuQf11v7odzNgBfyxPkQKXlfHaNCjgfasGhG491u6C5qfUDefm+j2
	 NQlHd5wI3/sKQ==
Date: Fri, 23 May 2025 19:55:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU
 onlining
Message-ID: <20250524025559.GA68080@sol>
References: <20250518193212.1822-1-ebiggers@kernel.org>
 <aCrrMEN01O7FWY6V@gmail.com>
 <aCrsiPd3u1-tEVd0@gmail.com>
 <20250519170425.GA1243@sol>
 <aCxMXqQmHGU06l-O@gmail.com>
 <87y0uqq8gg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0uqq8gg.ffs@tglx>

On Wed, May 21, 2025 at 05:39:27PM +0200, Thomas Gleixner wrote:
> On Tue, May 20 2025 at 11:33, Ingo Molnar wrote:
> > * Eric Biggers <ebiggers@kernel.org> wrote:
> >
> >> Or we could use DEFINE_PER_CPU() = true in patch 1, then revert that 
> >> in patch 2 and replace it with the line in fpu__init_cpu().  But 
> >> again I think the split would be more likely to create problems than 
> >> solve them.
> >
> > Well, my request would be for the first patch to simply mimic current 
> > (and buggy) behavior as much as reasonably possible (obviously the 
> > effects of BSS zeroing shouldn't be mimiced 100%) - and the second 
> > patch to fix the initialization-ordering bug.
> 
> So the first patch is then incomprehensible buggy and needs a trivial
> one-liner to fix up, right?
> 
> TBH, that's just bonkers. Eric's patch is trivial enough as is and easy
> to review. Artifical patch splitting with buggy intermediate state makes
> only sense, when the overall changes are massive and hard to
> review. That's absolutely not the case here.
> 
> Thanks,

That sounds reasonable to me.  Anyway, any interest in applying one of the
versions to the x86 tree?  Maybe either this original one, or v2 which has the
extra WARN_ON_FPU() checks that Ingo requested.

- Eric

