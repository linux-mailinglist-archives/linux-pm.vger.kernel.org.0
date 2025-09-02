Return-Path: <linux-pm+bounces-33660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55CB40BD2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC40B7AE9DF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DF930DEB4;
	Tue,  2 Sep 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMFfl+47"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8042C17A8;
	Tue,  2 Sep 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833503; cv=none; b=s36TBnDms96aQ9w3dLdRqPpvQRZS2FCLJtn91TL9FUgcezHvodnxifdTlhDSgNRDnWGaiZZdfVi0BmD5NJZ43gbRSvnoJ0wLkGMEcgofpNG+0B/OMU1vKWH3sbjFfSHYLjMp5020BoPBSBECC7AYGA+Seo5HpVniNEsj5AtP7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833503; c=relaxed/simple;
	bh=Nxyio4+r5dh5pFJsnBPHpzd74dQzog6NwYV0HbGML+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB0q+7slVw1YWoIe0GYpmL1dfsC+WEvRnUspz1rFc1zfIEyfFffdhFNq+MT47/LlcqHOsH4035nvbTjXiI5nODqFZ52RVR97K4aNaFiBfK0aHY1ZVPrXJMXV6848k0i3exs44tN8VMQfsrYKjNo38EVGW+2xZWySONVwle1cEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMFfl+47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C621CC4AF09;
	Tue,  2 Sep 2025 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756833502;
	bh=Nxyio4+r5dh5pFJsnBPHpzd74dQzog6NwYV0HbGML+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CMFfl+47xuEPoKET33eEnJFn20A2dteQlQDXU8jCPUPX3iwss40ccYTcGq2wTgF4q
	 LrMJ0uEhZ0X37NhhJnz2MoMGJfRvmOmoO9OKYPjgs8YO494OYr4/AYpMkR6eUMoJUI
	 i5ltvR9zF2II7QBvnTCEplLGGGUm01Mftn+IAvs7d41xPzLPAZL8dh2UHqCz6nS9vO
	 Pn8JfRaw1D2PpeWN+fAwRuvpmjdpySJ8xMYgKWkLFm7/97VeiyAVU7M45Vs2HvDr3a
	 Op9lheD8WU0ufwksoXs7iicrQpaZNO1MLDZlH6R9RvT0oC1vGg7RhtiiiZGEfqXaMy
	 0X0XC7dwlrCvg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce534a91so2026072fac.0;
        Tue, 02 Sep 2025 10:18:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIreWc3+K1YVtuIG2ZssR2/6L0BbKOBbnGpS0dYtL6Yennfbs7CSxPjb47obX4GV/6J4EzU8UqKqcY0ZQ=@vger.kernel.org, AJvYcCWlWYEto5GSE4R2r72Ge2s2Nm9rejuIprgZx6wu0/Yh89fM/kqeslT4UiBA7wvBLV05wXvuGJ2Gm1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUpHYVDYerQB519O+2DLuP1WrknS+yWIZ2lYvyQP9ZeLwte8S
	yYKyHdKnj1IizWdymu8ewZvvC6iExqVuneCFEAWvpgyeuI00yHPMWthW6rI6HdBBR2dpFSPujEi
	2oRiTIDaFQPwHpgpDl7YUzYohNxEhHlk=
X-Google-Smtp-Source: AGHT+IFfaCM0HgCk+C7C9sgQixAGC/QLnJMylf+6miUkFD4/stc00mbTidlUJ9lVmdzyckPt71i7NlnS1C3nEgLe5ds=
X-Received: by 2002:a05:6870:17a3:b0:307:bb94:2260 with SMTP id
 586e51a60fabf-31963345334mr4412017fac.24.1756833502029; Tue, 02 Sep 2025
 10:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0ik7fRKwH3CnXysvBJkkdJbWP-6iL=zBF0o92rR+nHTKg@mail.gmail.com>
 <4f340f1e-1cbf-4b50-ae23-a0e50170146c@intel.com>
In-Reply-To: <4f340f1e-1cbf-4b50-ae23-a0e50170146c@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Sep 2025 19:18:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQEecBFfZkefbipXPV6HVupz67q5RYR=heC=ZUpOY+bQ@mail.gmail.com>
X-Gm-Features: Ac12FXxVBwZFPXzb8hFIoHPwnmgx_eyrOYO9eQh9yO2D0GDFLmCe6CXi9HvRtw0
Message-ID: <CAJZ5v0hQEecBFfZkefbipXPV6HVupz67q5RYR=heC=ZUpOY+bQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:56=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 9/2/25 08:05, Rafael J. Wysocki wrote:
> > On Fri, Aug 29, 2025 at 10:01=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Christian has reported that commit a430c11f4015 ("intel_idle: Rescan
> >> "dead" SMT siblings during initialization") broke the use case in
>
> Does "dead" here mean present but offline?

Yes.

> >> which both nosmt and maxcpus were added to the kernel command line
> >> because it caused CPUs that were not SMT siblings to be brought
> >> online during the intel_idle driver initialization in violation of the
> >> maxcpus limit.
>
> How does intel_idle fit in here? I don't immediately see it calling
> cpuhp_smt_enable().

It calls arch_cpu_rescan_dead_smt_siblings() which calls cpuhp_smt_enable()=
.

> >> The underlying reason for this is a missing topology_is_primary_thread=
()
> >> check in cpuhp_smt_enable() which causes that function to put online
> >> more CPUs than just the SMT siblings that it is supposed to handle.
> >>
> >> Add the missing check to address the issue.
>
> We should probably add a bit more checking in cpuhp_smt_enable() to make
> sure that it's being called under expected conditions like a:
>
>         WARN_ON_ONCE(cpu_smt_control !=3D CPU_SMT_DISABLED);
>
> and probably also some comments about how it is expected to work.

Well, see the callers.  Two out of three take care of this already and
the third one doesn't care.

> cpuhp_smt_enable() doesn't _really_ enable SMT. It specifically takes it
> from DISABLED=3D>ENABLED. Thinking about it in that context, enabling
> _just_ the secondary (disabled) threads makes a lot of sense.
>
> But that can come later, after the bug fix.
>
> >> --- a/kernel/cpu.c
> >> +++ b/kernel/cpu.c
> >> @@ -2710,6 +2710,12 @@
>
> No 'diff -p', eh?

Ah, sorry about this.

> >>         cpu_maps_update_begin();
> >>         cpu_smt_control =3D CPU_SMT_ENABLED;
> >>         for_each_present_cpu(cpu) {
> >> +               /*
> >> +                * Avoid accidentally onlining primary thread CPUs tha=
t have
> >> +                * been taken offline.
> >> +                */
> >> +               if (topology_is_primary_thread(cpu))
> >> +                       continue;
> >>                 /* Skip online CPUs and CPUs on offline nodes */
> >>                 if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
> >>                         continue;
>
> Is there a more generic problem with this not respecting 'maxcpus'? If
> maxcpus had forced a primary thread offline, this would still online the
> secondary thread, even with the fix. Taking _that_ online might still
> bring you over the maxcpus limit.

Yes, there is AFAICS, but it has been there for some time and it
doesn't affect the rescan during boot.

For the rescan, it is actually useful to not respect maxcpus because
it allows all of the SMT siblings to be kicked, but for run-time
enabling of SMT it may be sort of a problem.

This change simply addresses the regression, which is that cores
without SMT become online quite surprisingly after intel_idle (and
ACPI idle too for that matter) initialization, due to
arch_cpu_rescan_dead_smt_siblings().

