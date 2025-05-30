Return-Path: <linux-pm+bounces-27849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B09AC8A9D
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 11:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCEB7A1A65
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB720219A97;
	Fri, 30 May 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXzmpuwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186C1C84A5;
	Fri, 30 May 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748596726; cv=none; b=O3NNxk42VzIo2yyl3RarDBngDwqpkqYByJQlPYpG9X2tVBueF9qRuJduMn5NWF6qltATO8t87SX4nopF32yFEVpV9pL3E9V4wgEh3IAdZYH2/i5WBaMfcU9sJSWoNw5uWYCu9ByZ5XiX2zpmvCbn90Yt4vkxBT7HuBjJ1JWAbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748596726; c=relaxed/simple;
	bh=snZT/youdWPPK0aV1SigXN/Mc/jC4HfNSXK++zWhvss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKeDm0zQmYfD6EaQAexvnaYYStWgK1gZV5GwM31GN3/Gdua+ABF+fE9tScx01eOSxC+/IyKi1cg/gJHbhUf3xyUbHsZVChqnW9pxP0GRaAh2aobHr5lR7Z5HVg7iPFXiKrDWUnScwsGNKxfQxglWU2v8fz2l5d/0HQ36EIWtcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXzmpuwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B5C4CEEB;
	Fri, 30 May 2025 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748596726;
	bh=snZT/youdWPPK0aV1SigXN/Mc/jC4HfNSXK++zWhvss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXzmpuwlAj4kyuAaxPpp0aQotfpsdbwAdWOEHEC6GjOUTrY+j2IcrIlzIAqGnPFMc
	 dxxWCbcYB3qiCOYfnqO5WIDSIcCHlqrIrHqVhsHcJ/rVaHgPl8sKkk6oYc1HlMcnzQ
	 yrx+ru6X7irCqwtmjvCuISWjx5MpVyvwNr41zjrv/w4nbr40jzQroGlplT3GKulzM6
	 RqvGk9t5t08RYrE/SaHczpkSPvwSsI6cWIqGtLKdN3ZBlPB6GtCmXuVrtIObKZzkhI
	 0kG7P7bPfOzkYRRXuw2FALPk0NgOOUS7hyOr4fsNbc1/jJyQKtHPr4zo7zfnNRsZa8
	 uFzd/7vio6rNA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so1200176b6e.3;
        Fri, 30 May 2025 02:18:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUybTpO8nkzLtNn9wp7CrsGnq9QeWL3J8toMAHjAUo4Nfkn+d9K8XtoJilZiGgp2uIZTsqUZZ8+ms=@vger.kernel.org, AJvYcCXocrxJgzf+oFso6uoYlkKGVZN7vZViMcsz8kfjnDslpTZzpSkrZVdjE4SIbWEAgBUbjvCz9P1YLBUkx+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZBKxNxr5EvQcsNcbjDOeq758Gzi+DaI9iyMZOPXKlbqhq6pX
	P1/Lj4m4G0QrjA+G11NX4QyDH6esJ4r1ZUaCTepDXv4iiw3uTOgc9NeJ7vfIFLy+kYvGC74vlQc
	Ad32hcd3H/9gUVH6AWiJbeaQmneBLREg=
X-Google-Smtp-Source: AGHT+IHWMb0z4NVl/L+z/yrd/3T3xNhtSlR9ihUabCouVR/sVGUPbbITLPj8K1gVNQTEBwvti2Sjt8Pxu8dyoX06/Mg=
X-Received: by 2002:a05:6808:6b8c:b0:406:67b7:8b62 with SMTP id
 5614622812f47-40679778baemr1498658b6e.38.1748596725403; Fri, 30 May 2025
 02:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2006806.PYKUYFuaPT@rjwysocki.net> <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
 <20250528133807.GC39944@noisy.programming.kicks-ass.net> <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
 <20250528160523.GE39944@noisy.programming.kicks-ass.net> <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>
 <20250529085358.GY24938@noisy.programming.kicks-ass.net> <CAJZ5v0hw1910Gsb57POVhax1hAbEGHa7xksr_FygNd_JL-oeOA@mail.gmail.com>
 <20250530080733.GH39944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250530080733.GH39944@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 May 2025 11:18:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irHEZEbZVrd-tiaXBvxM4aD9spJg1cVRcjrDQ0_HMJAg@mail.gmail.com>
X-Gm-Features: AX0GCFu4bzN34rlFj1VMl2CDYb9hS8t8QF38ItYyh53nEJvlVwnKodQyub2LTqU
Message-ID: <CAJZ5v0irHEZEbZVrd-tiaXBvxM4aD9spJg1cVRcjrDQ0_HMJAg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit 96040f7273e2
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 10:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, May 29, 2025 at 11:38:05AM +0200, Rafael J. Wysocki wrote:
>
> > First off, I'm not sure if all of the requisite things are ready then
> > (sysfs etc.).
>
> Pretty much everything is already running at early_initcall(). Sysfs
> certainly is.
>
> > We may end up doing this eventually, but it may not be straightforward.
> >
> > More importantly, this is not a change for 6.15.y (y > 0).
>
> Seriously, have you even tried?
>
> AFAICT the below is all that is needed.  That boots just fine on the one
> randon system I tried, and seems to still work.
>
> And this is plenty small enough to go into 6.15.y

But there is still intel_idle_init() which is device_initcall() ATM
and this needs to be tested on other arches too.

So not really there, sorry.

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..0f25de8081af 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -814,4 +814,4 @@ static int __init cpuidle_init(void)
>
>  module_param(off, int, 0444);
>  module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
> -core_initcall(cpuidle_init);
> +early_initcall(cpuidle_init);

