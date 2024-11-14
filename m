Return-Path: <linux-pm+bounces-17564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE39C89AD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 13:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12C81F22040
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C831A76C0;
	Thu, 14 Nov 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BDSbBvrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B518C92C;
	Thu, 14 Nov 2024 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586672; cv=none; b=ExlryZJ9I8QwUUP1xHKj474rmHsfXsoHB08fpcOo5qXTlEvE9EYKf1gcTljFnCTEthbhEtJ0J/nzMqVkTVfGxW+PjL/guVxGry0GKHOz8Nfr1iV+XMTPo/AIUtw2mOjnvJnIXwZJSEt94QBN8C+t9MeeCISxmmoHpOQRTO2Y9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586672; c=relaxed/simple;
	bh=Qrz1XjOTeyRPFLyrkAQrTeiKf8T3tzBXiKIJH4F213I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpJt2GVvgC8r3u9O8aL9+4+SWw8Xyc6sPipsFOISh8nDGUdCI+TOwrttaWLJ6SCccXGk6bGOGMwr6Q9oo7M6E9//xOuQFsKNxHbNBQ2v9iGdkpF9KIv+xFBMBqCoUoHQ6fhz2/aqInopKS6AToxNlNS38tVYJVtBh0k4BzOCrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BDSbBvrb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0sj9eZp+dyyI8o7irWjZwbPZGsKmkQGU2wy0PFWXrZU=; b=BDSbBvrb1DcrhCkszATttEyIWe
	n2l3lQdzaaGLcuE0DDoWDUItMG8fsdNfSQyzwHHuVCfgydDIilMekOwn42N+SZ4g0y1MTKfUgPXZ0
	BqgjNEYqclEU/fsJxJBWiNRiNU9KSd2qs88RhtCgnxEmQV/vraDf7lgg7/KYdAFPlOoLuqYNm7fg/
	t4XEwz2OkACM98dFOCQ8dtYM72Z5MtKi0AODgsRmfcrblepPM6nEVVf5ff/K5LJ4kHZihdA3xNLkH
	zOOfF4JnRjLjUL5TBx+5zcjRv3EdN14gTC/TdebsyJU0SV0o1oApn9galDjxOWuhu8pqPgnWoWxJl
	2iVFjmcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYnA-0000000019g-0NOH;
	Thu, 14 Nov 2024 12:17:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 712F1300472; Thu, 14 Nov 2024 13:17:43 +0100 (CET)
Date: Thu, 14 Nov 2024 13:17:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	len.brown@intel.com, artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241114121743.GR6497@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241113162222.GA24625@noisy.programming.kicks-ass.net>
 <9152f296-3f81-438d-8dc8-3c0bc60ea4b6@intel.com>
 <CAJZ5v0jeJsGyvb-LU7=sy37Cgj_SUCEGirAF58q5h_5ymx3juA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jeJsGyvb-LU7=sy37Cgj_SUCEGirAF58q5h_5ymx3juA@mail.gmail.com>

On Thu, Nov 14, 2024 at 12:58:49PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 13, 2024 at 5:27 PM Wysocki, Rafael J
> <rafael.j.wysocki@intel.com> wrote:
> >
> >
> > On 11/13/2024 5:22 PM, Peter Zijlstra wrote:
> > > On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
> > >
> > >> How about something like this (completely untested)
> > >>
> > >> ---------------------x8----------------------------------------------------
> > >>
> > >> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> > >> index f3ffd0a3a012..bd611771fa6c 100644
> > >> --- a/arch/x86/kernel/acpi/cstate.c
> > >> +++ b/arch/x86/kernel/acpi/cstate.c
> > >> @@ -215,6 +215,24 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
> > >>   }
> > >>   EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
> > >>
> > >> +static int acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> > >> +{
> > >> +       unsigned int cpu = smp_processor_id();
> > >> +       struct cstate_entry *percpu_entry;
> > >> +
> > >> +       /*
> > >> +        * This is ugly. But AMD processors don't prefer MWAIT based
> > >> +        * C-states when processors are offlined.
> > >> +        */
> > >> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> > >> +           boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> > >> +               return -ENODEV;
> > > Are there AMD systems with FFh idle states at all?
> >
> > I don't know.
> >
> >
> > > Also, I don't think this works right, the loop in cpuidle_play_dead()
> > > will terminate on this, and not try a shallower state which might have
> > > IO/HLT on.
> >
> > I think you are right.
> 
> AFAICS, cpuidle_play_dead() needs to be reworked to not bail out after
> receiving an error from :play_dead() for one state, but only after all
> of them have failed.

That and ideally we remove that whole ACPI_STATE_C[123] filter on
setting enter_dead. I don't see how that makes sense.

