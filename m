Return-Path: <linux-pm+bounces-27850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C76AC8AB1
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6557F9E167E
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35321FF31;
	Fri, 30 May 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjUUitks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB028E7;
	Fri, 30 May 2025 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597275; cv=none; b=HnWTwDXZHJFGwgh+HTLMEycD04/rTcfxglihMj0zpN66e/g9EKZwzjarszbupvq7XIG5e1/sS1EyubLFaNwiT5uYgd3jAVPkn+5omxmdj7gsRxCOpUtxTedh934zvPfYGZdIzqD4YEYMFr8gsx6sGiznrVr1WoQCOVcJWqttMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597275; c=relaxed/simple;
	bh=RSiqO/kmQ8iZ5K+uJsE1ImfJmQxmaHfrScdUILlX7vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ne+Tz3NdfpZM0stdLc5Yjj5YX5j6RBrW41lyW1IeyXDirRjgo5Wcs9OhDb0lCWUehGzgHbfd2wHKw4smb9GkmDR95B9dxhrsrMmBpSJYAwCA14ciCm8DMDoTVyu1hsOBzD+x5wDPe1QC6shmEC03TrjX/ZSHAvJ1VdGmNKzHHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjUUitks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227BBC4CEEF;
	Fri, 30 May 2025 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748597275;
	bh=RSiqO/kmQ8iZ5K+uJsE1ImfJmQxmaHfrScdUILlX7vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jjUUitksHOEzwX3xq+/GgKAPVOsU+wG6wGPkZvuj2Xfr6xhH+rUbAy+qCZvtwcfVC
	 iSlvN06+eLala1U8idzdU5UKQcxOGCWJF7N8rgks+wreA7zSa/9leT+kFiwBCDXlgC
	 mgemYZjiKU23S6MmtRnzXpFM8xzgeXANhRI8GQpvQ8iuo7AE2y1RmoXWWIOZCwsfZb
	 +nqdk7we2WiMC6n11/N0P91x86NaDn1gUoBHblLblZWQRlIiJtmqmpBbtbA4eDuFuw
	 pTOfEoLJFaa3WuRfi9uyQjBwgCu8KywzY0pO4D0ZQX3v1DYuypu59UUwgvCNrS6Po3
	 a1hkbjZbkzHhg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fbaa18b810so507149b6e.2;
        Fri, 30 May 2025 02:27:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2lNGzE2glvb6bgU2+im1C4pRqhsV8PN29Z1ax3phVfzTeWYYWsbHIG4MZOAfNhoqM7AlUeRRjl2C/p3U=@vger.kernel.org, AJvYcCWuz6kl/TMARaiiNtTi4JFbtdAhXnUlSz1VNwEHECPycOY6mqp1is5uZ8R3opgz1Y9MbnsgqTlApbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6gcs1/WujHIjB/uaLMvdKFwPMl4+hwjzkPePvLpBAbg9xFH3
	D8BOzwHmIBoNn35zHz+LIHFG+7NTpDr2YV60L5XU9YUZ0/FrbG6m0Lznx995wGc/YtiJ4S8Ncwz
	nP38HWy/ADDfHnZ5QE1/Iy3oFFKI8388=
X-Google-Smtp-Source: AGHT+IGJLxY/YP4qQcPSGdC9M+XSOtwoc14LjM91TbppT+2aS41XhEg2kIpcpB3/+sLOP4lhOK2f/pb3lYY/B5ouX6E=
X-Received: by 2002:a05:6820:98b:b0:60b:edbb:1f50 with SMTP id
 006d021491bc7-60d52d6db2fmr625648eaf.4.1748597274497; Fri, 30 May 2025
 02:27:54 -0700 (PDT)
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
Date: Fri, 30 May 2025 11:27:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbE1Y5zjD_WbwfXYUco=6gtJHYJrTDy0t+sGkBjdD8pQ@mail.gmail.com>
X-Gm-Features: AX0GCFtXA3TjByyV2Y_Ee8S3152mP4t9FecpBX4C3ns-oPIQRIfIXrWE6bVa4Zk
Message-ID: <CAJZ5v0gbE1Y5zjD_WbwfXYUco=6gtJHYJrTDy0t+sGkBjdD8pQ@mail.gmail.com>
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
>
> So not really there, sorry.

BTW, I do think that this is the way to go, but not in a hurry, and if
6.15.y does not include a proper fix for the original issue, this is
not the end of the world.

If it turns out to be unproblematic and all goes well, we may as well
try to put it into 6.16.

> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 0835da449db8..0f25de8081af 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -814,4 +814,4 @@ static int __init cpuidle_init(void)
> >
> >  module_param(off, int, 0444);
> >  module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
> > -core_initcall(cpuidle_init);
> > +early_initcall(cpuidle_init);

