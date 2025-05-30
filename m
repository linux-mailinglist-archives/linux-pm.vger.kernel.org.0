Return-Path: <linux-pm+bounces-27894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E4EAC943D
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 19:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5874D3AE210
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248D239591;
	Fri, 30 May 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW2dUbV/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C0239573;
	Fri, 30 May 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624365; cv=none; b=plP1Q9wRaKAveIMp6YgF1DqTh8dVKWgu8csAXqCmOuOheztzCNmRnVPALNpaDuBMSjbP3EZGO89YlEagH1XlU5JNpxgAAWyXU8ACEaAsNtTvB3YHImgbFbBlDwsfyY3yvSLF4QFxfdnVjXXpqW128SUuhQgQgqwmk5qwEBJcma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624365; c=relaxed/simple;
	bh=NO9wabjBf4sglqRu8I1/Z14D+qK0YvaEkQAcb2vmIFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6MP9hYd9kA69dxr4r9yO7TDhRheCLmwIvKBdXeWuxfIW0m23nQR3ZltanB5w/ufkkw+CKKfbeGbAxlGQL4Ohz+H+UNwX0BG6jzWDOsm/SLkzAajAgahBeH8MK3mKhQ9luG4+IQI+Z6WReVk8UzjBtbz2bW5xUODMS4de96ZHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW2dUbV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C828CC4CEF1;
	Fri, 30 May 2025 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748624364;
	bh=NO9wabjBf4sglqRu8I1/Z14D+qK0YvaEkQAcb2vmIFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JW2dUbV/Dp7qou5YBuTcvY07AAas/cJdNaN1Rzxfv4oFh11tXscO0R9Jdz+gu6dHc
	 GJRdVvRiJr4PvS3izNe2f5myDX6e0vlcgZFwD0Ql1zXnIto2LE62CgjtTMOe9rgAsx
	 loEJtUU+6s/OgvefaoeKYzWvMsit4ntUgYidMBRxOBN4boXLSL2Jj6lO7fLDY/52RI
	 XHNFiXFTQOl7DiNAxLa5YZGkjMFuqMYI+nExcEivOAbYFxrbVTlFZ0TNoIkS6zDswb
	 Uco7ZXrjkF6G+eM/ZBt5K2P7izVwDmDJzmJCOE1Z9AmE2oopriLeH/UpaunKf3qLsT
	 8dQCykxejQ1TQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-607dceb1afdso1411353eaf.3;
        Fri, 30 May 2025 09:59:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOzhu8kx6A7hXtMuz72tioe6GKzGZN9U6iBU2/p1SoiSt8PSM8mLmarc3gilhcwnlK1O8ztgqFfos=@vger.kernel.org, AJvYcCXv165VPMvF4j4LpDuGCdiIGWuI8G6nBrcLPwOEPHZ+69jLIGJcYtZJASIOWOdstcsnNpkc2m8HDup0aOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRY86C+UPzk8mt+YT33a+R7FHqnWcEVp0Na6WCELcTtp2mpScB
	GwaCxhi9r811r0VeZ1DGCOg35xoQvtSwGEVp7dyqGAIDG3W2jKhi2XGHS0yTtnBglKxWlOMSAgn
	XMX9W/rYYtZtoMckV2RsIPDQhXkxkPMk=
X-Google-Smtp-Source: AGHT+IHYlApyVkKpVSgtYuoDpj0fJFfpS3LaTtKivErXbyIvRyuUizjbXADljZRG1Zqz+3aUCp/xyNVAiP61LqzRyq0=
X-Received: by 2002:a05:6820:2703:b0:609:dd17:795 with SMTP id
 006d021491bc7-60c4d79ebdbmr2599358eaf.6.1748624364151; Fri, 30 May 2025
 09:59:24 -0700 (PDT)
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
 <20250530080733.GH39944@noisy.programming.kicks-ass.net> <CAJZ5v0irHEZEbZVrd-tiaXBvxM4aD9spJg1cVRcjrDQ0_HMJAg@mail.gmail.com>
In-Reply-To: <CAJZ5v0irHEZEbZVrd-tiaXBvxM4aD9spJg1cVRcjrDQ0_HMJAg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 May 2025 18:59:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCesz+jhnxeBOV6-7LLViOnzi+JFXcsOw-dqK=81d8FA@mail.gmail.com>
X-Gm-Features: AX0GCFtGa02oDofHaz1OkA8y5REs-IU07mpgJYRrpGF3TbaNhZXyR3kCDQnvoDA
Message-ID: <CAJZ5v0iCesz+jhnxeBOV6-7LLViOnzi+JFXcsOw-dqK=81d8FA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit 96040f7273e2
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 11:18=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Fri, May 30, 2025 at 10:07=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Thu, May 29, 2025 at 11:38:05AM +0200, Rafael J. Wysocki wrote:
> >
> > > First off, I'm not sure if all of the requisite things are ready then
> > > (sysfs etc.).
> >
> > Pretty much everything is already running at early_initcall(). Sysfs
> > certainly is.
> >
> > > We may end up doing this eventually, but it may not be straightforwar=
d.
> > >
> > > More importantly, this is not a change for 6.15.y (y > 0).
> >
> > Seriously, have you even tried?
> >
> > AFAICT the below is all that is needed.  That boots just fine on the on=
e
> > randon system I tried, and seems to still work.
> >
> > And this is plenty small enough to go into 6.15.y
>
> But there is still intel_idle_init() which is device_initcall() ATM
> and this needs to be tested on other arches too.

intel_idle_init() depends on ACPI which initializes via a
subsys_initcall() and doing that earlier would mean a major redesign.

Pretty much same for reordering APs initialization past ACPI initialization=
.

One more option is to kick the "dead" SMT siblings after the idle
driver initializes and let them do "play dead" again, but who'd be
responsible for doing that?

