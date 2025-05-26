Return-Path: <linux-pm+bounces-27632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C1AC381D
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 04:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5A73B0802
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 02:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C227118C937;
	Mon, 26 May 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ZYIarfKN"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EBEEBA;
	Mon, 26 May 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748228174; cv=none; b=pJ3UzbDytI4Slxxx4MryZ4kF8lcWYp8591dR+rwJ5rCDCmsizmIPWPCzXMwElMrX1/YcOJHuJ69RYEiCm9HAcjCGB7Y5FM07M8ja6ykeb/8EC1d434ukG13ulUA/kRyr/WFBkNC5xSp6sCm5bV710pHtodzacO4TbzZEEEozyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748228174; c=relaxed/simple;
	bh=bV5+HFFetyXc8aCsy2tWkN9nsNC/vR/wBEC6I9tj56A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxKXeviua/az0vOZxwluAT0uYQMpE76DLdI+V8b8qkfAwrQhUJlSMsfpUv2p84/Tm0vpceUvKB+OUdqZmpF0X49R1CwI74PjnghDBXeMCD7N5Mn89a/0AoSiVy5hnwNraejqec2dGgZF/Q+7x144QosHQg/STaHoAtaE/dhCKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ZYIarfKN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RNlDjUKV8vb9lss0kDBUHO59CbXa+yGWQS2V6xmXcG4=; b=ZYIarfKNWgc+b7y8gbavlX+aTd
	1iSQ7zlVLXh1yifi97DL8KQ25pApUmzat969sEwBe8d9y4oW8zBjVTzbZXwML6dSM4LOre4APxbpW
	Ov/ZHnCMZwVrMu3L+iPKadnHzZABQ+vzx9Njz3aM0eChCNPMZv29RPE1fRvnWW+v6pP5r2lKZmiie
	NTkurBPvfltvttpxwYhm+D9gnrPPudDfUYgLuunJyALHikEou2OA44MYbMn/URFWviFpKlD2Gy/vQ
	IaCupKlswlSwm+RrJKBTVctoK8IkHgJsts8W4bcWjVGsOqWNhXcPmA85gh6u3TK5vCTF7SsRh/+Ip
	FkXKjJkg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uJO0T-008wzR-0q;
	Mon, 26 May 2025 10:56:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 26 May 2025 10:56:05 +0800
Date: Mon, 26 May 2025 10:56:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Ayush Jain <Ayush.Jain3@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU
 onlining
Message-ID: <aDPYRUTYVGii2NYd@gondor.apana.org.au>
References: <20250518193212.1822-1-ebiggers@kernel.org>
 <87v7puq8g2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7puq8g2.ffs@tglx>

On Wed, May 21, 2025 at 05:39:41PM +0200, Thomas Gleixner wrote:
> On Sun, May 18 2025 at 12:32, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > irq_fpu_usable() incorrectly returned true before the FPU is
> > initialized.  The x86 CPU onlining code can call sha256() to checksum
> > AMD microcode images, before the FPU is initialized.  Since sha256()
> > recently gained a kernel-mode FPU optimized code path, a crash occurred
> > in kernel_fpu_begin_mask() during hotplug CPU onlining.
> >
> > (The crash did not occur during boot-time CPU onlining, since the
> > optimized sha256() code is not enabled until subsys_initcalls run.)
> >
> > Fix this by making irq_fpu_usable() return false before fpu__init_cpu()
> > has run.  To do this without adding any additional overhead to
> > irq_fpu_usable(), replace the existing per-CPU bool in_kernel_fpu with
> > kernel_fpu_allowed which tracks both initialization and usage rather
> > than just usage.  The initial state is false; FPU initialization sets it
> > to true; kernel-mode FPU sections toggle it to false and then back to
> > true; and CPU offlining restores it to the initial state of false.
> >
> > Fixes: 11d7956d526f ("crypto: x86/sha256 - implement library instead of shash")
> > Reported-by: Ayush Jain <Ayush.Jain3@amd.com>
> > Closes: https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Since this patch is holding up my pull request, I will be applying
it to cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

