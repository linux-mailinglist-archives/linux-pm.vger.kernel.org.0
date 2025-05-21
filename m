Return-Path: <linux-pm+bounces-27461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80FABFA16
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DCD3AAF58
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC675220F4D;
	Wed, 21 May 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjQ1NMaP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1dQ1PAbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40401187876;
	Wed, 21 May 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841971; cv=none; b=i3YfdPIcH2/qvYGOYAayoJPqozde9puKUhcSgm5b7i3Y1KAB17rI36RBdsGmpNDwCJGuWZ+xpJWgRG7vxPqMjBiJmYAqpFeSvhC469ZSetIPgMhuVtEQ8pIxmy6UxvgopCe+s/6HIkvx0qJHC7LDqd7oEllpJ0C8KWyygMxwRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841971; c=relaxed/simple;
	bh=M0xnQCH/jkZcVXaDZwlHXs+CVeYCjbcwpo+8G31rlSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+bJUQykJVPWWFNTaXdADop8srSLYzLcLn4BrKwU1VHxBA44SlfEQwj1QiazHegexhosX7jsNTnMnGBrp5yYOQD0V5B1Oipe+jIZdpPl3rE0jqujja0D0TzSts/4TYLUmpcNbCYtXJNbZsBhr0IUZiY8btU2BpMZMQvx1jbXRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjQ1NMaP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1dQ1PAbL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747841968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQ+g0KsSoQcXvFv/UMQhWRNxJGO87hFMnKc/PPFYBFw=;
	b=TjQ1NMaPTGPoxadAMirnci0cD3lHXLGVja0LVlzqikLmmul3L+e57SdlvmG6e7WC62nPbM
	SaAYm72Oq9kkjhhUrjgSdpfSvbdvp66/qbPWXP8IoGOXVxjRyzl7Wpz2YHtb2i6QrgTAqT
	J30QU8WO+NOHv506cJ6B3OhWAxpbBYwDFUp2AH7LStQZOALHqAZrBBLEnPhfbI/SqPu9ks
	s16YzSkLkHpHLovu5DjHRWzRKHy845bSmoZgxfycm/Ift+fKf/TcrQ2vHvZMAgTtFKGMTv
	+YTVpfVg3uuK+SWvU+5636/zrouX7pCF8FcJOnHso+jQivsM2qHHNyZxESiYdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747841968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQ+g0KsSoQcXvFv/UMQhWRNxJGO87hFMnKc/PPFYBFw=;
	b=1dQ1PAbLE14uEhyztrb5NRt/6b5fAPyBgieR6Z+vBAQVG5EonVObjVj1CRQnv6RgW7mn5j
	ar2xoPZjHjpZRjAg==
To: Ingo Molnar <mingo@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, Borislav Petkov
 <bp@alien8.de>, Ayush Jain <Ayush.Jain3@amd.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during
 CPU onlining
In-Reply-To: <aCxMXqQmHGU06l-O@gmail.com>
References: <20250518193212.1822-1-ebiggers@kernel.org>
 <aCrrMEN01O7FWY6V@gmail.com> <aCrsiPd3u1-tEVd0@gmail.com>
 <20250519170425.GA1243@sol> <aCxMXqQmHGU06l-O@gmail.com>
Date: Wed, 21 May 2025 17:39:27 +0200
Message-ID: <87y0uqq8gg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 20 2025 at 11:33, Ingo Molnar wrote:
> * Eric Biggers <ebiggers@kernel.org> wrote:
>
>> Or we could use DEFINE_PER_CPU() = true in patch 1, then revert that 
>> in patch 2 and replace it with the line in fpu__init_cpu().  But 
>> again I think the split would be more likely to create problems than 
>> solve them.
>
> Well, my request would be for the first patch to simply mimic current 
> (and buggy) behavior as much as reasonably possible (obviously the 
> effects of BSS zeroing shouldn't be mimiced 100%) - and the second 
> patch to fix the initialization-ordering bug.

So the first patch is then incomprehensible buggy and needs a trivial
one-liner to fix up, right?

TBH, that's just bonkers. Eric's patch is trivial enough as is and easy
to review. Artifical patch splitting with buggy intermediate state makes
only sense, when the overall changes are massive and hard to
review. That's absolutely not the case here.

Thanks,

        tglx





