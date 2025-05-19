Return-Path: <linux-pm+bounces-27329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB499ABBA48
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CB87A2AD3
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321191FF610;
	Mon, 19 May 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkJQYffE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8D33086;
	Mon, 19 May 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648184; cv=none; b=lMBtP1vUTT1CBoVYmm54neTdoDlsfXnAZWTEUymsmNpoZhc5GgBa/YhexsV9U12yYPk5m4gG683kS77nCL1QIjJlG/AoiC6ExSd9C7IZuSnpcabY3uIXPGn5L42nrVbTiHlMMlyZixuitZG6Ikc7ol1g4Wwe+okYneZYdMi78Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648184; c=relaxed/simple;
	bh=GsbMk3lBqAULDnb+QrS3EC8rrwMu4pNT1Ee885kOqtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyMi/bUkpgDbgXqPfzQhy8UcibrEtfTS6P629VpWv/GXCUlpLPTCXQQG60VPYWTc8/0/4gdCZkKs5CYXFMDdV0Gr+H+YRZ3a7IDkndDMXGJRuFOreigO5Rb7dfleGRw+QjjwCHhg794OefwoUIOzm9XuslTkudZyyQCo2dhB0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkJQYffE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7487DC4AF09;
	Mon, 19 May 2025 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648181;
	bh=GsbMk3lBqAULDnb+QrS3EC8rrwMu4pNT1Ee885kOqtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EkJQYffE1VqZHkjAq8NPxnUmAvtmF1S/yPp41BlsOVOx1Xx94bzNIDoBAVrL3fpTr
	 9/hl7J7473dDm1wdx1jxs51MI1l6n5tfUlMtnOxUfjPJDhLHcMZcZG/dJS67TsOfYE
	 Kic0GIHbjkz9e10d/EUewreZLaXJL6I9rNuX7vFyJFESBIvODelHTnjNMq0nHtIxId
	 5QUbd4AWBUcYmtaCVD8rhf4dSr2kxKLWL9r5RWDYRVOKaQSQOgkNpYlMjN7BbxRxHL
	 gs9uhBCd60Asb1SipGkbzCbwAP1DM6GF8M4pjjPSdFZANjRTs65SuX+kG/QPC+G6PE
	 hlYo1NsOuI94A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54b166fa41bso6345569e87.0;
        Mon, 19 May 2025 02:49:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC9g/f+SZurNX9+y3vUQMsTs4/mSBIC4UIsXbZ6T+fgJFzhQXk1Zvtc9ZysOIjcqSRgB4P5cHsY/Q6cic=@vger.kernel.org, AJvYcCVuIRC/HQmuleEB7lUHpGx8B/8dSA7URluOJUxLMZCJxAMgFpEri4cE0m6vtcIJ2jRZ03fTFY17qrnSviXM@vger.kernel.org, AJvYcCWezp3KLx0zEiQGFu8EnkXxKgFXwohBzh7nGtla58XBkPi59Hj9QW+je4UfHAayAvpA0tnSqDv8Zi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmlPyEdUl6UlC1WvZ+7tY8GoeVrMB/wXAjSCkLERuBL+JfRYj
	DifH2+9f8KjeCxdNTbj3xDyQKmAK5GppOTZzmIwTv+X1Q29yFEHNmurFSp8TCHxk8Yn0t+TzLt1
	MDBUg+FwKnRzC04rMl15GwI1jOVNlK+M=
X-Google-Smtp-Source: AGHT+IFHpwka7r/jvwA9nGkxVeZQ1YTP11Ojb06eAYdaCEkmB9G5ujZDY/NFjf5ABOkcMR8fScaCOANQVjIL+X/hH5w=
X-Received: by 2002:a05:6512:1342:b0:551:f780:a6d0 with SMTP id
 2adb3069b0e04-551f780a82fmr270916e87.40.1747648179867; Mon, 19 May 2025
 02:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516231858.27899-1-ebiggers@kernel.org> <20250516231858.27899-4-ebiggers@kernel.org>
 <aCg2DSYp0nakwX3l@gmail.com> <20250517183919.GC1239@sol> <aCl_cSO2XqtSQEZT@gmail.com>
 <CAMj1kXGVAbD9zxUQSwwGo=ueadqWWSdaQNDe_-7ZezpFLMJRMA@mail.gmail.com>
 <20250518200114.GA1764@sol> <aCrmZnSokvmqfel3@gmail.com>
In-Reply-To: <aCrmZnSokvmqfel3@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 May 2025 11:49:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGe0hMD-71KYN_htJztAL+P8vFNf+9+W_aVDkHx3nCEWA@mail.gmail.com>
X-Gm-Features: AX0GCFtaUNa2B-7_aRHLOnxbWmvQvGoR1F6bLsfojcbDm8Cwpd0zWGPWxHlaz9Y
Message-ID: <CAMj1kXGe0hMD-71KYN_htJztAL+P8vFNf+9+W_aVDkHx3nCEWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when irqs_disabled()
To: Ingo Molnar <mingo@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ayush Jain <Ayush.Jain3@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 10:06, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Eric Biggers <ebiggers@kernel.org> wrote:
>
> > > # echo PANIC > /sys/kernel/debug/provoke-crash/DIRECT
> > >
> > > Another case that likely executes with IRQs disabled (but I haven't
> > > double checked) is reset_system(), which may return with an error, or
> > > reboot/poweroff the machine and never return.
> >
> > That makes sense to me.  preempt_disable() and preempt_enable() are already
> > allowed when IRQs are disabled, and I'm not sure why local_bh_disable() and
> > local_bh_enable() are different.
>
> Because local_bh_enable() may run softirq handlers immediately if
> there's pending softirqs, which shouldn't be done in hardirq context.
>

Sure, but why is that mandatory?

preempt_disable() has preempt_enable() and preempt_enable_no_resched()
counterparts. Could we have a local_bh_enable_no_xxx() version that
re-enables async softirq processing on the current CPU but does not
kick off a synchronous processing run?

