Return-Path: <linux-pm+bounces-27279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B17ABB17D
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9DC7A8850
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C618CC15;
	Sun, 18 May 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg3syiBZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC223CB;
	Sun, 18 May 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747598486; cv=none; b=IdUGrlykZnp32kMTKf2JjqD74Mj27U+qCle/3d28nYaLjhcMANmn8r43Gmpm0UYvQqZ8uLuYDpLmzVNYt0BEz1FuRgtVIOy6JPVLtMt7ArG/4ZHqUjuNqxzc4RU0eaYYSICkRSQjoHd93ljQGXPnpgKih4DYBNOiKWypHacb31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747598486; c=relaxed/simple;
	bh=0f49MjhDKdzQU+MAiyRdFlnx8Vv6e53SA7kU+MKyHdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4XIPtyVfWJ4tdC5AdVpFZA17U1CjXbGyQx6aEF61pZDsqaQzXlLa/OLS9n8p3xSixvaVIEV0bOEJz/qN5jhgyG0Zlb5JgZ3bQ20MEk8+MkF0uUXOG4XzYM+HklWhkyDSGSzgDg36Qytdo9BsvuD1Ttg63EESm6HqaJgbZ+eM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg3syiBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D215C4CEE7;
	Sun, 18 May 2025 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747598485;
	bh=0f49MjhDKdzQU+MAiyRdFlnx8Vv6e53SA7kU+MKyHdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg3syiBZZtobEtNh4thkTGM/bOo1xVDrQSdVGomKUhu0ouz23ovB1ebCCmKYw3cA+
	 fVKEB1i6WVJTn+Nzz+9KTUUmjCymXjf+9/PA8VCp8sPiJGqq6IkYx1WnAl4OAVx7GM
	 5wzZZgtMaxMFb6Gr7dfB2vHXT/+X02pyDBSV+rHUWkXV8X7Zmt/rkYkWyp3ABcOiA1
	 8+PZTn7nGc2/x59Ww+zi0kbTShNS/JCI07bYpAynhpdd/2LnI3hLEs3s6jeG1zZMjR
	 RHqC4j4+gBrC2ETIdn+c6lDhWkDdlWFySlVXdBa8sqx114DJ4mW/b8x7Ah3CMsRP4E
	 ziSCOJE1pGBdQ==
Date: Sun, 18 May 2025 13:01:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when
 irqs_disabled()
Message-ID: <20250518200114.GA1764@sol>
References: <20250516231858.27899-1-ebiggers@kernel.org>
 <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com>
 <20250517183919.GC1239@sol>
 <aCl_cSO2XqtSQEZT@gmail.com>
 <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>

On Sun, May 18, 2025 at 03:18:58PM +0200, Ard Biesheuvel wrote:
> On Sun, 18 May 2025 at 08:34, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > > > Alternatively we could set in_kernel_fpu during CPU bootstrap, and
> > > > clear it once we know the FPU is usable? This is only a relatively
> > > > short early boot period, with no scheduling, right?
> > >
> > > Yes, if there isn't agreement on this approach we can do that
> > > instead.  Say:
> > >
> > > - Replace in_kernel_fpu with kernel_fpu_supported, with the opposite
> > >   meaning (so that the initial value of false means "unsupported")
> >
> > I'm not against simplifying the x86 FPU model to exclude IRQs-off
> > context (especially if it also micro-optimizes some of the key runtime
> > kernel-FPU primitives), but it has to be a full solution and we'll have
> > to see how complicated the EFI changes get.
> >
> > Ie. without seeing the full cost-benefit balance it's hard to call this
> > in advance. Mind sending a full series that addresses the EFI case too?
> >
> 
> EFI services are only called with IRQs disabled in exceptional cases,
> so it would be unfortunate if it prevents us from make meaningful
> improvements here. In ordinary cases, they are called from a
> workqueue, and I'd prefer it if we can address this without calling
> all EFI services with interrupts disabled either.
> 
> AIUI, the reason we cannot tolerate IRQs being disabled is because
> re-enabling softirqs will complain if IRQs are disabled, due to the
> fact that handling softirqs should not be attempted at that point?
> 
> I don't know the history here, but I wonder if that isn't overly
> pedantic? Disabling softirqs could be avoided entirely when IRQs are
> off, given that they are disabled implicitly already. But why then is
> it not permitted to disable and re-enable softirqs under this
> condition, given that it makes no difference? Or perhaps I'm missing
> something here.
> 
> A good way to trigger such an exceptional case is running a kernel
> with efi-pstore and lkdtm built-in under QEMU with OVMF, and do
> 
> # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> 
> Another case that likely executes with IRQs disabled (but I haven't
> double checked) is reset_system(), which may return with an error, or
> reboot/poweroff the machine and never return.

That makes sense to me.  preempt_disable() and preempt_enable() are already
allowed when IRQs are disabled, and I'm not sure why local_bh_disable() and
local_bh_enable() are different.  local_bh_enable() already uses
local_irq_save(flags) instead of local_irq_disable(), so it seems it's sort of
intended to work when IRQs are disabled, despite the
lockdep_assert_irqs_enabled().

Anyway, that would point to continuing to support kernel-mode FPU when IRQs are
disabled.  But also EFI needs it anyway, unless we refactor it to use
kernel_fpu_begin() and kernel_fpu_end() only when irq_fpu_usable() and otherwise
use different code, analogous what arm64 does.

So for now I've sent
https://lore.kernel.org/lkml/20250518193212.1822-1-ebiggers@kernel.org which
implements the other possible fix, where we just start keeping track of whether
the FPU has been initialized or not.

- Eric

