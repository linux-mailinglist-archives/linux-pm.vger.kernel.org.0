Return-Path: <linux-pm+bounces-17562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314FB9C895C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 12:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5C0284BD1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95681F9416;
	Thu, 14 Nov 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKY7VlpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4F1F77B3;
	Thu, 14 Nov 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585541; cv=none; b=H4pHjbFAsfYrPXwMZybryJejKtdVzsiXS+DUONz+dncCqPmZm0qJKXGroVg/XRXymfAHbV1BI3wCAhKL7aaVuC4UZJUdK0z9FcfuttUeeNIV3zYb6ibwq7dLYJVxMBfpSLuc6ToPdVzPWOVhbrh1Rrr6VvsaOnCPJ+CwpMwhhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585541; c=relaxed/simple;
	bh=NM/UYzi691wSStXmoFzLvRciyAeiwdtL4YWAHchLXbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR8XiNPSOjfCK1F8QP9y3jeT2P2QzpABhrcN7VQ98O8lmvroIu38/gkzAK8YmukvLBFz1XuwPGeJIitf8gFsB2+aoZ4jvrMIpMsEV5ffzaR0ehxYmAia7k1MsHOAlOf6BJWbJoMZ6dDCH5WJOulyN2NsvnWeFnlCHf1V/HRN9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKY7VlpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8DEC4CED6;
	Thu, 14 Nov 2024 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731585541;
	bh=NM/UYzi691wSStXmoFzLvRciyAeiwdtL4YWAHchLXbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oKY7VlpODsD93UAgBsmbGupb1KaE4HoZ2LVaM2wbUx+gBN4ou6N4uSSiepVuoF/jc
	 Bjf+IOoML8+hgkT1sOHWmY3sxc0pCQefbhCMYDhfMsVeBLWIsDhDNLteoVJvr4oE20
	 80GmYRnMVxxq5AIy7aDZ0IQL3no2s/XpuX41D0AphDgX6Pu6lGC9RPXaMxOSJpUEva
	 GpErx8LgA/5kuLAXKTgTqX8V4FJ9UA/+egqbOwwnHYJRHw2yoxlCSfXlad83cjTszW
	 qadQa1hd4vYP3hvnILz+S31Elz1RF9VQwarz4UA90j6udd+LJxa9Dk8MoB8nfi3B99
	 ftHZT3mGdjimA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288916b7fceso228628fac.3;
        Thu, 14 Nov 2024 03:59:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUT/0kpc4iH+CWZgdnPe37NRKNP9qGlXuaTiYrq8+AlScWned+CmivRk2WCyS4fyLODbJ8E+kQ2jao8ly0=@vger.kernel.org, AJvYcCWGpFlb2DZrSXM6GNchwMa7gUdj8mjFB6Qm7hPA89PYrjlxrQDZOihaWDANr7Wdeo4Mz/h/JjOW97g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FjmVUQ/uvReh6QijyOjZVeA8CxC0yQl3Korr9fxr3E2BvoKG
	cFtQ57jwQZawnHmvpVoeWBOpjIQcxjK5WROH8qCJJUHzJKL9dhfkKshECvfCqzm/xQ/h3LUpwD2
	JZthf78ApAIeOOlXTOxUdbOk7khs=
X-Google-Smtp-Source: AGHT+IHNWrnMdxXQkGaxJSUergy9tRSs7XlpenaVu2VqfSN2SqVNZD44Q/hYYLKjSHOpxlQOhTMVI9zj00MeFSZOW9k=
X-Received: by 2002:a05:6871:e00a:b0:278:245d:cde7 with SMTP id
 586e51a60fabf-295e903e15fmr6538460fac.36.1731585540365; Thu, 14 Nov 2024
 03:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com> <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net> <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241113162222.GA24625@noisy.programming.kicks-ass.net> <9152f296-3f81-438d-8dc8-3c0bc60ea4b6@intel.com>
In-Reply-To: <9152f296-3f81-438d-8dc8-3c0bc60ea4b6@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Nov 2024 12:58:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jeJsGyvb-LU7=sy37Cgj_SUCEGirAF58q5h_5ymx3juA@mail.gmail.com>
Message-ID: <CAJZ5v0jeJsGyvb-LU7=sy37Cgj_SUCEGirAF58q5h_5ymx3juA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Peter Zijlstra <peterz@infradead.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:27=E2=80=AFPM Wysocki, Rafael J
<rafael.j.wysocki@intel.com> wrote:
>
>
> On 11/13/2024 5:22 PM, Peter Zijlstra wrote:
> > On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
> >
> >> How about something like this (completely untested)
> >>
> >> ---------------------x8-----------------------------------------------=
-----
> >>
> >> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/csta=
te.c
> >> index f3ffd0a3a012..bd611771fa6c 100644
> >> --- a/arch/x86/kernel/acpi/cstate.c
> >> +++ b/arch/x86/kernel/acpi/cstate.c
> >> @@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(st=
ruct acpi_processor_cx *cx)
> >>   }
> >>   EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
> >>
> >> +static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> >> +{
> >> +       unsigned int cpu =3D smp_processor_id();
> >> +       struct cstate_entry *percpu_entry;
> >> +
> >> +       /*
> >> +        * This is ugly. But AMD processors don't prefer MWAIT based
> >> +        * C-states when processors are offlined.
> >> +        */
> >> +       if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD ||
> >> +           boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON)
> >> +               return -ENODEV;
> > Are there AMD systems with FFh idle states at all?
>
> I don't know.
>
>
> > Also, I don't think this works right, the loop in cpuidle_play_dead()
> > will terminate on this, and not try a shallower state which might have
> > IO/HLT on.
>
> I think you are right.

AFAICS, cpuidle_play_dead() needs to be reworked to not bail out after
receiving an error from :play_dead() for one state, but only after all
of them have failed.

> >> +
> >> +       percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
> >> +       return mwait_play_dead_with_hints(percpu_entry->states[cx->ind=
ex].eax);
> >> +}
> >> +EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);

