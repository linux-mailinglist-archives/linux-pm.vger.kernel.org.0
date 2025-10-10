Return-Path: <linux-pm+bounces-35898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A52BBCC71C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 11:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ED13BD682
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C42C0299;
	Fri, 10 Oct 2025 09:55:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16D20A5EA;
	Fri, 10 Oct 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090140; cv=none; b=XSHaih/KmzPw/qqltIuvt8MsTyyPpWsxoo2and09ubsGVsgjwdSv1vOZp5csc3B0gjT8Hp9dz/1tKagM9oddD7AXS3J2U4EhzzyYG+GtuzxAtL4KLsQFR+l4YleG9hX5MBmD8lqmAuR8ItrPU6apN0WUgGOmGnIdSfuRXuui38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090140; c=relaxed/simple;
	bh=mTfjnlLIPs747DZ8NtNpnvu4jI9ogYkuUeDHxXbtTJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGs0Se61zO79vprLKKIQtfqrCmblqX1QfR+RH+RB9W4/yjQx4Idjt3+BfGWzflaAJcg5WUNdTlUibbmB5pIKFY3aObvmQRt0wBjCiACCcbcvaFVu3Hfs/pERCe3PmB2nL9jVzfPSIEZvTZ/8DZCzSmFz6fHPENWGLhNTpigwfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7471596;
	Fri, 10 Oct 2025 02:55:29 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82B7F3F66E;
	Fri, 10 Oct 2025 02:55:35 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:55:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
Message-ID: <aOjYFBpeqj8sBHJ9@J2N7QTR9R3>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org>
 <865xcsyqgs.wl-maz@kernel.org>
 <CAPDyKFq4RgL0=hPhB0cwTQF-A+mXH8dxsZAYTB1CFuLxxxTujg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq4RgL0=hPhB0cwTQF-A+mXH8dxsZAYTB1CFuLxxxTujg@mail.gmail.com>

On Fri, Oct 10, 2025 at 10:30:11AM +0200, Ulf Hansson wrote:
> On Mon, 6 Oct 2025 at 17:55, Marc Zyngier <maz@kernel.org> wrote:
> > On Fri, 03 Oct 2025 16:02:44 +0100,
> > Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > To add support for keeping track of whether there may be a pending IPI
> > > scheduled for a CPU or a group of CPUs, let's implement
> > > cpus_has_pending_ipi() for arm64.
> > >
> > > Note, the implementation is intentionally lightweight and doesn't use any
> > > additional lock. This is good enough for cpuidle based decisions.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> > > +bool cpus_has_pending_ipi(const struct cpumask *mask)
> > > +{
> > > +     unsigned int cpu;
> > > +
> > > +     for_each_cpu(cpu, mask) {
> > > +             if (per_cpu(pending_ipi, cpu))
> > > +                     return true;
> > > +     }
> > > +     return false;
> > > +}
> > > +
> >
> > The lack of memory barriers makes me wonder how reliable this is.
> > Maybe this is relying on the IPIs themselves acting as such, but
> > that's extremely racy no matter how you look at it.
> 
> It's deliberately lightweight. I am worried about introducing
> locking/barriers, as those could be costly and introduce latencies in
> these paths.

I think the concern is that the naming implies a precise semantic that
the code doesn't actually provide. As written and commented, this
function definitely has false positives and false negatives.

The commit message says "This is good enough for cpuidle based
decisions", but doesn't say what those decisions require nor why this is
good enough.

If false positives and/or false negatives are ok, add a comment block
above the function to mention that those are acceptable. Presumably
there's some boundary at which incorrectness is not acceptable (e.g. if
it's wrong 50% of the time), and we'd want to understand how we can
ensure that we're the right side of that boundary.

Mark.

