Return-Path: <linux-pm+bounces-13429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A458969FB2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFD5B2198C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282DF1803A;
	Tue,  3 Sep 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQbrtLlc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCB1CA6B5;
	Tue,  3 Sep 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372153; cv=none; b=SrcT7G/Jgb/BewJJlI+6QjIhC9I89r5egLlBNexR1f2Cl9vxjNp/+5bSYHI3t4alP1Xkjb124mICgKX3wIcFotIEr/Ub7bRTDNo5V7x4Sbobix5Lgi3xNxmfzTNbQ0p4hfq4uLZ+cuvOd1Pf7xAKq3EYiysWaT+saRARijagaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372153; c=relaxed/simple;
	bh=ISEPiyuW5HpWwnRmZ2TxcXfpXbOWpUrDh3u1r9u6zYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghdIrWdSg6FAuOmwSch5rhhh2qUOJF5MggqHf/qDEqvF9O12DH9liU5xKVupgOKk5kMIqxk2UsO6NrG+4RwSXhCySQu1D2q/dvcUE/yJZjHDMGi6hdkqXmjXpE3ymLPq72vfGG4UBHsl2SguItYMXeRSnQTIEZKYTlL6460iCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQbrtLlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B9BC4CED0;
	Tue,  3 Sep 2024 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725372152;
	bh=ISEPiyuW5HpWwnRmZ2TxcXfpXbOWpUrDh3u1r9u6zYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lQbrtLlcW9ICfUMaj/zhYwPRIurwZCpLyv/YF4PQjdawRjF20Gd02tEPTIUY28Zy6
	 VRhBBPEM/cYTyRIwsNXleZaOQiZaUJBAr2i7SbRI3554Hwa1V7qu7M2gyMiNRfy5xk
	 6ArpHsOt4wizacmbEr85taTAbW2dj+iLbdJj6vR1Cgl5ipoqHVGk/fPjsxoENcVNaW
	 UttbttRqyhwLpg10InLEqhabK3Zj8PBL5mP+TryTtEYxVCdcGKcj9ONRqSCoGGCfzf
	 p8fIDB84tQWteze56ZoppQ3pVXKEoeUhHaysF7xZTww4ZaocH0zav9dgZ4nkvb9h5D
	 ENYMdIkVJU60A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e172cc6d97so1058262eaf.1;
        Tue, 03 Sep 2024 07:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdYaDWa0GCjJ9viq0qD89D/ZyRYuhDgGR92eAN7Msbmf76tFV/lYQZUBp96uZ2xW03il2jJKVn+7RMkqM=@vger.kernel.org, AJvYcCXvBF48M5NYaRZdMXyrI1rBRIjzTCiCzGKmhdYePxqntdz4llaFB3I0HAvnqRBbD+DTZaPKuaqw2Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9+dX4jEUtbz8x09V+NmCF04CIE4pu28/fI1saAJs4TdSRs5K
	yp8c19s4ZiBycnu5uJAZt7RwYe6T2oQCUysUWlauR6LJiXRkl+Jxw9dFrS+z4A8jff3dekI/5N/
	VScyX0H5+AvVHjHDOv2M+0xz6BEs=
X-Google-Smtp-Source: AGHT+IFf2DBDKS65tIQFLlU5VpFjsDfIqRxNn8mDJQyYoNTfaBwsAmEvaa2hTrEUkMwd8an5t150Tgkh6hcyPFWpUr0=
X-Received: by 2002:a05:6870:c186:b0:260:71c4:f33a with SMTP id
 586e51a60fabf-277902b2663mr18497038fac.39.1725372152062; Tue, 03 Sep 2024
 07:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3310447.aeNJFYEL58@rjwysocki.net> <1979653.PYKUYFuaPT@rjwysocki.net>
 <20240903135502.GX4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240903135502.GX4723@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 16:02:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jWAfvSXkiQfg5yRaZRwT6gWAjDN=jqwnhDuE=UwcFsKw@mail.gmail.com>
Message-ID: <CAJZ5v0jWAfvSXkiQfg5yRaZRwT6gWAjDN=jqwnhDuE=UwcFsKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: intel_pstate: Set asymmetric CPU capacity
 on hybrid systems
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:55=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Aug 28, 2024 at 01:48:10PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make intel_pstate use the HWP_HIGHEST_PERF values from
> > MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> > via the previously introduced arch_set_cpu_capacity() on hybrid
> > systems without SMT.
> >
> > Setting asymmetric CPU capacity is generally necessary to allow the
> > scheduler to compute task sizes in a consistent way across all CPUs
> > in a system where they differ by capacity.  That, in turn, should help
> > to improve scheduling decisions.  It is also necessary for the scheduti=
l
> > cpufreq governor to operate as expected on hybrid systems where tasks
> > migrate between CPUs of different capacities.
> >
> > The underlying observation is that intel_pstate already uses
> > MSR_HWP_CAPABILITIES to get CPU performance information which is
> > exposed by it via sysfs and CPU performance scaling is based on it.
> > Thus using this information for setting asymmetric CPU capacity is
> > consistent with what the driver has been doing already.  Moreover,
> > HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
> > both the instructions-per-cycle (IPC) factor and the maximum turbo
> > frequency and the units in which that value is expressed are the same
> > for all CPUs in the system, so the maximum capacity ratio between two
> > CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
> > values.  Of course, in principle that capacity ratio need not be
> > directly applicable at lower frequencies, so using it for providing the
> > asymmetric CPU capacity information to the scheduler is a rough
> > approximation, but it is as good as it gets.  Also, measurements
> > indicate that this approximation is not too bad in practice.
> >
> > If the given system is hybrid and non-SMT, the new code disables ITMT
> > support in the scheduler (because it may get in the way of asymmetric C=
PU
> > capacity code in the scheduler that automatically gets enabled by setti=
ng
> > asymmetric CPU capacity) after initializing all online CPUs and finds
> > the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
> > capacity number for each (online) CPU by dividing the product of its
> > HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PE=
RF.
> >
> > When a CPU goes offline, its capacity is reset to SCHED_CAPACITY_SCALE
> > and if it is the one with the maximum HWP_HIGHEST_PERF value, the
> > capacity numbers for all of the other online CPUs are recomputed.  This
> > also takes care of a cleanup during driver operation mode changes.
> >
> > Analogously, when a new CPU goes online, its capacity number is updated
> > and if its HWP_HIGHEST_PERF value is greater than the current maximum
> > one, the capacity numbers for all of the other online CPUs are
> > recomputed.
> >
> > The case when the driver is notified of a CPU capacity change, either
> > through the HWP interrupt or through an ACPI notification, is handled
> > similarly to the CPU online case above, except that if the target CPU
> > is the current highest-capacity one and its capacity is reduced, the
> > capacity numbers for all of the other online CPUs need to be recomputed
> > either.
> >
> > If the driver's "no_trubo" sysfs attribute is updated, all of the CPU
>
> Trubo :-)

Thanks, will fix before applying.

> > capacity information is computed from scratch to reflect the new turbo
> > status.

