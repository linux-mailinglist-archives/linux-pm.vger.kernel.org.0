Return-Path: <linux-pm+bounces-27346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF379ABC001
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E6C3B74FA
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B227AC47;
	Mon, 19 May 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqNQJdkr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650426A1BD;
	Mon, 19 May 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662669; cv=none; b=hpuTiYfwF3ao6KhKdiC2vYzO+DYl2tT9rEJ3MXKbe7p3o7RtUScbQckRfQ0u9i8tMpcXYY8jGR3cZnr836AaZrGsF0pNKh8panJghAu1FsI7DIVUtRBx3qCbOTZgVfSx7zzhQPUf7McaE5HEemMsrr9DGZEpOOgD1G9rqNAXDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662669; c=relaxed/simple;
	bh=/1PocrC/g6/kywMQw3oecq3XJZshz+LGXlLp7xFGcXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6lD4LITACJekCCAFs7SQzXV26F0e6KffusWns8aSQs8RekxW+pDuspsokcH/t/f6H97za35d5vd1UfejT/vJCesLTJzEZzYrIykU3Bm04b4DX+2CYo0Qsufs+CgjKCoenWgv3z/oMHy54bpQGY+O8cPN5OsJJbfI6olyIRxKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqNQJdkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A30C4CEF3;
	Mon, 19 May 2025 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747662669;
	bh=/1PocrC/g6/kywMQw3oecq3XJZshz+LGXlLp7xFGcXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oqNQJdkr09VouujpcMBI6H3VytyyGcIvfSEiEeZH0hGui96JIK46MvH6uFmzTC+OJ
	 THvKUk6Wq0O6mCPbpoarvxY0d3JzHMQHEB/PX5RvpVGzjqblpFP/ddO3xEeMsgSBw5
	 zx3E4YNhOrSSomNYttlzZPJc6s+hVC5BuV1luyZBrFf0k5XLH4acjJtyEArRTCkJNg
	 hdAAHarQzma07j1YWTd2HCr0eVbfy91GYWBzRVP1vivPHTXoHiWutCC5PIarxEFOd4
	 5j/LfEDFzgC7rxcOCv1DAB3UAj76PuUkBNandvG8wiolBr2N35gMWlIWF+vIrzZDqa
	 xParAbdyvRz8g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so5706396e87.2;
        Mon, 19 May 2025 06:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYEJ7JHrgtmq+y73svBUNl/zJW1AgORWqqTxNT21DxXbNp0Soli7gRLltKkUrU75ehKq3VrVehZuI=@vger.kernel.org, AJvYcCWbzpDaAUZh2/huXw6C9lImNtLFdnl5ZHAy6OIJzOHgT6MZXHPC+g2xsObrpsoTwP5kM9J3HBXU/fUcnMI=@vger.kernel.org, AJvYcCXs+b5+6SwbQ/KZWgFqZvBuNNR3V8jDs6gi4PXiW9prSBPSbKcx5MwIOVI8FDoOeFHCjokvMiQBFKYyf7AU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6ntRXuZTY7US1BSReHCNm2IC3saLVrb0FY+vBQN5vj2AvisM
	sHrkKVARiw9elF9bc/0/l9GRhWfwDnQ4+IE1lxwTJTVpVYOyVd3TYjO+Y5UZ2h1Qn5BgrZFWAUX
	Z0JY888YrDoi1EZbuusL0Vdzn/vG3wRw=
X-Google-Smtp-Source: AGHT+IFb2v4EJCc3DwoI2v4DG/puP29pToHb4pOCGsztJrkqgwEjkCUyQ1ea9iz7d/fjjtJlFRh5UFKcehqUrDJqUHE=
X-Received: by 2002:a05:651c:e16:b0:329:1435:7eb7 with SMTP id
 38308e7fff4ca-329143580c0mr10546371fa.22.1747662667322; Mon, 19 May 2025
 06:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516231858.27899-1-ebiggers@kernel.org> <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com> <20250517183919.GC1239@sol> <aCl_cSO2XqtSQEZT@gmail.com>
 <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
 <20250518200114.GA1764@sol> <aCrmZnSokvmqfel3@gmail.com> <CAMj1kXGe0hMD-71KYN_htJztAL+P8vFNf+9+W_aVDkHx3nCEWA@mail.gmail.com>
 <aCsqyrHdMWlU3yc0@gmail.com>
In-Reply-To: <aCsqyrHdMWlU3yc0@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 May 2025 15:50:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHzFiQsjUH90J56ds2fgge-MUXmFMBWKtmb0LF=UjbJcg@mail.gmail.com>
X-Gm-Features: AX0GCFulSVzXOSA9gt1CMU94HvVEsTZU8m38n0TNCBCwMMdgjXnKSSADJdmeVmo
Message-ID: <CAMj1kXHzFiQsjUH90J56ds2fgge-MUXmFMBWKtmb0LF=UjbJcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when irqs_disabled()
To: Ingo Molnar <mingo@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ayush Jain <Ayush.Jain3@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 14:57, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Mon, 19 May 2025 at 10:06, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > > > # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> > > > >
> > > > > Another case that likely executes with IRQs disabled (but I haven't
> > > > > double checked) is reset_system(), which may return with an error, or
> > > > > reboot/poweroff the machine and never return.
> > > >
> > > > That makes sense to me.  preempt_disable() and preempt_enable() are already
> > > > allowed when IRQs are disabled, and I'm not sure why local_bh_disable() and
> > > > local_bh_enable() are different.
> > >
> > > Because local_bh_enable() may run softirq handlers immediately if
> > > there's pending softirqs, which shouldn't be done in hardirq context.
> > >
> >
> > Sure, but why is that mandatory?
> >
> >
> > preempt_disable() has preempt_enable() and preempt_enable_no_resched()
> > counterparts.
>
> > [...] Could we have a local_bh_enable_no_xxx() version that
> > re-enables async softirq processing on the current CPU but does not
> > kick off a synchronous processing run?
>
> Yes, that's what __local_bh_enable() does, but if used it for
> kernel_fpu_end() we'd be introducing random softirq processing
> latencies. The softirq execution model is for softirqs to be
> immediately executed after local_bh_enable(), and various networking
> code is tuned to that behavior.
>

All of that only applies when re-enabling softirqs with IRQs enabled.

> You can try talking the networking folks into an asynchronous
> local_bh_enable() executed on the next IRQ or the next scheduler tick
> or so, but it's a non-trivial behavioral change. It would probably also
> need user-return callback activation.
>
> I'm pretty sure that the naive implementation would increase LAN ping
> latencies by +4 msecs on a typical distro kernel.
>

I don't see why we'd need all of that.

Conceptually, kernel_fpu_end() would do

if (irqs_disabled())
   local_bh_enable_no_xxx();
else
   local_bh_enable();

which cannot affect any existing use cases, given that the former case
is forbidden atm.

