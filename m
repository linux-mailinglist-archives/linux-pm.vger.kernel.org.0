Return-Path: <linux-pm+bounces-27897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46822AC9556
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162DF1713C2
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6E277815;
	Fri, 30 May 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azKIMfjj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8B27703E;
	Fri, 30 May 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627730; cv=none; b=ksgOoj+U/pdZXvV9hg9NcCLNXMHOx0Vb4FE7Trz/GkOCVqR6q7fwpKkGddxbdvi8YesUVxkYulFGVjVBcQcIf1Q1VlUSeCFdr8h2z+9erdtZJXOQR0ET8AwuF6lw8Um2dDbnRgftBXeojqH1kfu7Sm1LACnNJF6LCqmTvNx/DnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627730; c=relaxed/simple;
	bh=Z4p8j6JP93DU8zs/CtD8Et1EBHP1OS4LXOhdqxk3m5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2GmIkz4iENUnJnOpI4DskqXVHaJ6GlLJq5PibYbTcWHaYk2GV/AHQkXWK6NwjW9F/fqlTwb28uVJydGmOHenLERG8b2zhFts5T2IfJXHre3X1JGxmdtITeWCzHb3fr6qiiceftrcHYekjyZ2/EdhTRlEdb7WtXM4uCapq7lNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azKIMfjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CE7C4AF0B;
	Fri, 30 May 2025 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748627729;
	bh=Z4p8j6JP93DU8zs/CtD8Et1EBHP1OS4LXOhdqxk3m5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azKIMfjjN+SMq6qHg3GBtCWTha0xQuQMeX05VElokprKykfCfjO38W7qDt8nLRZjM
	 eU+l2hW6YUkysQiQHJAWFoyk0zxKIaAKDOuI0hGLOaTrSx0Kj01VJxqIDsD3Qv2CCf
	 jBhTaoNozRgmadqP5E8urLtMZlr76ZiwaIgpEsS4iyTYTvte4o9Zsq1PRzHT0dXx9/
	 bh/IyjSY02c7o5oUBVMWVdV4rO5RMM7rItSoUnLKRyCKIJyejNK2oNwaLPx0MwzkWu
	 YW5xbFxIvLWaGJZJ7qJ22aQW3eMAW2N1JGG4mA4M31+tgMDauwm3Y0uBEBX5KJlOrW
	 tOFynIknGO2yQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-606648c3f9eso657539eaf.3;
        Fri, 30 May 2025 10:55:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXizlaSWGEPbY91yTAAFPwFGP/5IMnKJLXcf0kROetjAUrfmQE+3DNF1W67oRifefd61Ul37KZnnzM=@vger.kernel.org, AJvYcCXnZFU152Oq2leR+quI0bw3URMm09r4liGhsY/Vg3n1GavdEy3gNrEw2QW1wa4mqA3zfRxzrg8rsh/Bul8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcTrCSFqai3TOkmzfUliIwYoFLzXwhGzEWmjnwL3X43fBFpGM
	Vmy0QRDKhSPJR5hRKoLBvLb8nR3tnmBUVZK+hb4QZh8wG2KwRh80covmKZHgJbuAERV51tfJzzJ
	JkS20s/LhgSRZnd1Snd+XJaH5UX9Mzh4=
X-Google-Smtp-Source: AGHT+IFEyOOJa6iXg9lMxIVjt9GNXMhZtVhOhypEJV+km46HwPL10FvWa4XooMoBZknnFFbDVGH37lgrgOZDRil611I=
X-Received: by 2002:a05:6820:98b:b0:60b:edbb:1f50 with SMTP id
 006d021491bc7-60d52d6db2fmr1810112eaf.4.1748627728646; Fri, 30 May 2025
 10:55:28 -0700 (PDT)
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
 <CAJZ5v0iCesz+jhnxeBOV6-7LLViOnzi+JFXcsOw-dqK=81d8FA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iCesz+jhnxeBOV6-7LLViOnzi+JFXcsOw-dqK=81d8FA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 May 2025 19:55:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iokGEr6y38P0ic-hqa0A8VVRhxvsUz38m5douwiX+MKA@mail.gmail.com>
X-Gm-Features: AX0GCFsQrnVODltGlciG3S922ccgXSZcHHQZIoCIDExIe5PcXuzqVG3UFmN5Xp0
Message-ID: <CAJZ5v0iokGEr6y38P0ic-hqa0A8VVRhxvsUz38m5douwiX+MKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit 96040f7273e2
To: Peter Zijlstra <peterz@infradead.org>, x86 Maintainers <x86@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 6:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, May 30, 2025 at 11:18=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Fri, May 30, 2025 at 10:07=E2=80=AFAM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Thu, May 29, 2025 at 11:38:05AM +0200, Rafael J. Wysocki wrote:
> > >
> > > > First off, I'm not sure if all of the requisite things are ready th=
en
> > > > (sysfs etc.).
> > >
> > > Pretty much everything is already running at early_initcall(). Sysfs
> > > certainly is.
> > >
> > > > We may end up doing this eventually, but it may not be straightforw=
ard.
> > > >
> > > > More importantly, this is not a change for 6.15.y (y > 0).
> > >
> > > Seriously, have you even tried?
> > >
> > > AFAICT the below is all that is needed.  That boots just fine on the =
one
> > > randon system I tried, and seems to still work.
> > >
> > > And this is plenty small enough to go into 6.15.y
> >
> > But there is still intel_idle_init() which is device_initcall() ATM
> > and this needs to be tested on other arches too.
>
> intel_idle_init() depends on ACPI which initializes via a
> subsys_initcall() and doing that earlier would mean a major redesign.
>
> Pretty much same for reordering APs initialization past ACPI initializati=
on.
>
> One more option is to kick the "dead" SMT siblings after the idle
> driver initializes and let them do "play dead" again, but who'd be
> responsible for doing that?

Interestingly enough, a similar issue is there during resume from
hibernation and that's why there is arch_resume_nosmt().

So arguably intel_idle_init() could do something analogous to it after
successfully registering the idle driver.  In principle, the ACPI idle
driver could do that too on x86.

Opinions?

