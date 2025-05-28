Return-Path: <linux-pm+bounces-27735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB4AAC6A37
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9971116F1A2
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21112857E6;
	Wed, 28 May 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsBDSu5F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A223CB;
	Wed, 28 May 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438430; cv=none; b=OTVEHGPpighBR9mjY1ZW+FtNQ8zdcbkiMW5Tv+zNro51TroG6Lkg2NZKI7g76cL0pNaU+gHSitmYdT1XDoHV6rS/a3b0SNO/54X4YB47qVCpyjK6FRuNzrJvaBpXcP3cyf+GmDIbgIh4wfSqZhE43vTAP8thiokl0lzLyJVJKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438430; c=relaxed/simple;
	bh=zpWkRzpL1C1wvvbWchbIoGchgtFgQWV3X6yXDovDrAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYIzOAww49rIqRFWZOcb2pxwd11evdCGd6EjiQF5oIHkQR/FdBwRMq9ZZ1/1aqCbKaGHXNPJu9XHnmqf06v3XzbAkuyg7MS686bPU1pqS1DdDX2CvWwTvCwgLe9Hdo2clSzkBIFbGTQhncOYm2v8g5gfGSl8nj2GLUVtkjFvUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsBDSu5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A5DC4CEE7;
	Wed, 28 May 2025 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748438430;
	bh=zpWkRzpL1C1wvvbWchbIoGchgtFgQWV3X6yXDovDrAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AsBDSu5FRR8uEmQbjNLsGm3374RoccQXcTz/X/CD92r4TOjoUCSB3Gu8V/ukAn3f4
	 vseF7e3ugk3EGKjstDTHtT5cyQeIVZDyLRm0aqy2OUaSA2/jhcGxl+XddBO8j8tbAo
	 cmpvqxJ/fdJrDxk66sH0Qis7BqO1m/j9FEG+oKyn0FppduD92TFQoQWZ2dfEvqm+lX
	 C9adiSXr4uuSYY2F+tSj4hVpvVN+4yKoiCHwYRRmT9ErzXi0K26UBJ+trpwb8u4U/b
	 6Ckv7De1aLpsqh1gJ/5QY8HQEpmIhOH2FcxRkFZ/78Dk3SXquN/0wnxhZQc0UJNlF/
	 VhQQmfM0/VeMQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3feb3f54339so3904217b6e.1;
        Wed, 28 May 2025 06:20:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfgKBp3PFqykOY/Mr30/XhC2rkcsdNQZCZ0EGtkw4DhJ4G2tl868fQhfPjMeZ3qljf+GTRJtWWsHtAAp4=@vger.kernel.org, AJvYcCX+K+I24CQAIRq7KZvfteH6MRj2VHSLMTGtdrpbWdBCF5SYYzjE1wKYcb5N7/gd/PQbhGgUSceOU8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIqwHc+HQqGeYx94uk3ARJGFb4EW0M2KFKQ46qsSjMJx1PGYg
	MIvfLS+hiv4uUdR4QYq/wRQlfsyoPSqvVfSghNjCa1BLzclFbl3yIQg6BYQma30RnG4xRYsWggo
	1IPTmPkhttA30tH0R988Ojo5VOjVH3LE=
X-Google-Smtp-Source: AGHT+IFkwud3yYeLapngqvo6cYzzvuTV5s6QtdDYYMRDy6+GZADou18DJw3mNX6kjJmg7SCa4PL1LBDrZB+RcJeKPz4=
X-Received: by 2002:a05:6808:2b06:b0:402:17a8:af08 with SMTP id
 5614622812f47-406467d087fmr7651740b6e.9.1748438429625; Wed, 28 May 2025
 06:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2006806.PYKUYFuaPT@rjwysocki.net> <20250528131759.GA39944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250528131759.GA39944@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 May 2025 15:20:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
X-Gm-Features: AX0GCFuEgUkMOGqlQvpYEqqL33KbB4TEexttzkuk0hi3BVR-IbleJPyuVqM_zqk
Message-ID: <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
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

On Wed, May 28, 2025 at 3:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, May 28, 2025 at 02:53:13PM +0200, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > Commit 96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
> > that shipped in 6.15 introduced a nasty power regression on systems tha=
t
> > start with "nosmt" in the kernel command line which prevents it from en=
tering
> > deep package idle states (for instance, PC10) later on.  Idle power, in=
cluding
> > power in suspend-to-idle, goes up significantly on those systems as a r=
esult.
> >
> > Address this by reverting commit 96040f7273e2 (patch [1/2]) and using a
> > different approach, which is to retain mwait_play_dead_cpuid_hint() and
> > still prefer it to hlt_play_dead() in case it is needed when cpuidle is
> > not available, but prefer cpuidle_play_dead() to it by default (patch [=
2/2]).
>
> I don't understand. The revert says the reason it regresses is that it
> goes into play_dead before cpuidle is initialized. The fix is then to
> call cpuidle first.
>
> But if cpuidle isn't initialized yet, how does that fix anything?

The revert fixes the bug.

The other patch does what the reverted commit was supposed to be
doing, but differently.

