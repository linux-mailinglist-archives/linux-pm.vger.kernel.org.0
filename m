Return-Path: <linux-pm+bounces-27276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A89ABB056
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9246B16F41D
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1116211A0E;
	Sun, 18 May 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtuQAT+M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72C1373;
	Sun, 18 May 2025 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574351; cv=none; b=W2FgVzedgvBQWvEMhV7GRGtjqVGaCDjY8K3+Av28serrzYvTj3aPAJ/INbJV8QFKKjSwZy5OHHbytu941GiC2JOtbsh0a8JmpzHcg/R9A6JkbIglFJffRh7xBrlm7jTG3vqMC0MyHp8f31PRu7O8to6ULr6Rc8TwtIXf3czUeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574351; c=relaxed/simple;
	bh=zqPJuOXxqod++t44o4DuYRjFJgaOBYIO604IdtZ/VSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMARPL/m+wIzoDxBNnxXeePrN/Qih5oBP/duuND/qX/afD6XKCJ9ullU98UqxicFieAIvAT/yb7pEBMxXRaOBWmJrnpF3LP+nEipO37WRm+LoN+UzS3gJPA1NWXIsPTp+k2XMz0jlkgMMWPeiwY6Wvw+ZMD4qZT5v/JysG5rxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtuQAT+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17127C4CEE7;
	Sun, 18 May 2025 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747574351;
	bh=zqPJuOXxqod++t44o4DuYRjFJgaOBYIO604IdtZ/VSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EtuQAT+MxP1GAaFTXXnnzw0HNIiXtfN6h78D9OLv9S74SNymO1gsGhp/UUqG3JpA0
	 j9pmoOFDNiNbCwt7VF1iPNmMsiZ0DxFrrqSFc3tMHEQHNHwWAKoVHlUsqpxpTl3nci
	 0kSDGHL+uu3VHErMoMm0jpgkyLTUukVsYi8chHctOkKabDmnnS7Q6/S0ai1o4ezgXm
	 9OYe0RCZ6UmlL/CGmMqfZvhJxqeJ0qqRrzuaFeMZE+kuUQAqt1tGdcEnj1W4Ee2/1c
	 bGsIc+NojAA2qppAo8h78OvHwRZ1f7XJbOAucZMUCTmsGFVQOcWNuXEmhbfOXaXlqx
	 vXbE4nECNWgXw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-329107e3f90so3774661fa.3;
        Sun, 18 May 2025 06:19:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL9zoGbkrM8CpXRAsVo77LpR5xFbkrV/FJZuoBJmypFeSUnILxmVZm9ueTLG5nByQiztqvtUU/Tqi9ZU4=@vger.kernel.org, AJvYcCVSJRh41pONmtblkVOPv9+ucNrSCBH9gaQiCFO5mWYaQmFYboVA8t8fM6YkR9JOlVm+enDZU5G8SBA=@vger.kernel.org, AJvYcCWbySZEDOiBZ6JfTbuYyiWYXP2OxLZd3MlWSy2UJwfNtnuFp8jW4URUI9C7AtIN+/nrMMPfBswOqXgZcSCH@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkS0Kgq+fcer3jGyE41A+Q7OYPcB6/SMyIdPtvYeCkBMc8MZi
	BuBae3ntAHFa7rKNMkGEHTbRm05KDal6PAUXufxR0Y3lbgLwulB1BJP+1BDfefC3vdGnX7e1N/+
	4UO86h1Ee0s4/UGgDQ/wGRWWh6ZzpdxM=
X-Google-Smtp-Source: AGHT+IErqxXbCbuTtNVXIG+u+d7vpWcTqptYViLWkXc2Q2KmR50BGaqxSQAOGQizG46jzCV5EsAkk2BeVoCgiwwTEIU=
X-Received: by 2002:a05:651c:400c:b0:30b:f42b:72f6 with SMTP id
 38308e7fff4ca-3280977f153mr20883761fa.32.1747574349469; Sun, 18 May 2025
 06:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516231858.27899-1-ebiggers@kernel.org> <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com> <20250517183919.GC1239@sol> <aCl_cSO2XqtSQEZT@gmail.com>
In-Reply-To: <aCl_cSO2XqtSQEZT@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 18 May 2025 15:18:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
X-Gm-Features: AX0GCFu1VtSQRdHeCMJJc1l14RlBDttfmugJzDPWh47VUQRPpT4-fKjjp6OfCwk
Message-ID: <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when irqs_disabled()
To: Ingo Molnar <mingo@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ayush Jain <Ayush.Jain3@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 May 2025 at 08:34, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Eric Biggers <ebiggers@kernel.org> wrote:
>
> > > Alternatively we could set in_kernel_fpu during CPU bootstrap, and
> > > clear it once we know the FPU is usable? This is only a relatively
> > > short early boot period, with no scheduling, right?
> >
> > Yes, if there isn't agreement on this approach we can do that
> > instead.  Say:
> >
> > - Replace in_kernel_fpu with kernel_fpu_supported, with the opposite
> >   meaning (so that the initial value of false means "unsupported")
>
> I'm not against simplifying the x86 FPU model to exclude IRQs-off
> context (especially if it also micro-optimizes some of the key runtime
> kernel-FPU primitives), but it has to be a full solution and we'll have
> to see how complicated the EFI changes get.
>
> Ie. without seeing the full cost-benefit balance it's hard to call this
> in advance. Mind sending a full series that addresses the EFI case too?
>

EFI services are only called with IRQs disabled in exceptional cases,
so it would be unfortunate if it prevents us from make meaningful
improvements here. In ordinary cases, they are called from a
workqueue, and I'd prefer it if we can address this without calling
all EFI services with interrupts disabled either.

AIUI, the reason we cannot tolerate IRQs being disabled is because
re-enabling softirqs will complain if IRQs are disabled, due to the
fact that handling softirqs should not be attempted at that point?

I don't know the history here, but I wonder if that isn't overly
pedantic? Disabling softirqs could be avoided entirely when IRQs are
off, given that they are disabled implicitly already. But why then is
it not permitted to disable and re-enable softirqs under this
condition, given that it makes no difference? Or perhaps I'm missing
something here.

A good way to trigger such an exceptional case is running a kernel
with efi-pstore and lkdtm built-in under QEMU with OVMF, and do

# echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT

Another case that likely executes with IRQs disabled (but I haven't
double checked) is reset_system(), which may return with an error, or
reboot/poweroff the machine and never return.

