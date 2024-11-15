Return-Path: <linux-pm+bounces-17606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEDC9CDC30
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1571F22346
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09A1B21AA;
	Fri, 15 Nov 2024 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VxYOIw8J"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B52192B9D;
	Fri, 15 Nov 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665468; cv=none; b=qwP5j7V1Xw5CyHqPOOAmTh2jmFXS7TfO/CVxAlUV89LZjmxJ/VAIkRQz6FwAMNxtMniBxTEQ281fLUpmHCAdziJPVhA5Auoxp0LUetunh6UGZfnr5x3u42RIucqNKZjv8SczKCs3GTFQfDCAxeCwvCoQndGBqGif7ti2NhQ1FFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665468; c=relaxed/simple;
	bh=GO/WA2wAEOShVWCavx8bz6gRcWjEy+ltFtLTqOWopT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqvF+YS01WmwWLZWBXh//PN5BQMCyZHap/WFNP2VUHl7BOY5Lc+7vh7dWhBGa02Ot606MjwC+5nmRHMjG9ahRBi7+kZEOoT226JOaNTO3/bMQo0F0zIedbHvBDSXMVZyjqbHlx0Rza72nbYNXi3zA53I5dUV1FEfIMRfhJvSZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VxYOIw8J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aMM/JHxbJMLbuCFvPQSnf8YKLN6m5w62tGV9qSiPbVE=; b=VxYOIw8J6ggvoH9bn5WY/s7fVv
	HkmFc0QJiyz+rvK2kPOAr1yycEydfyjN3IBw1ADw1LlnTFHCwtYrcqh3X/bPKMw8Rkj5rwa3Wbq3A
	UHBGl07BvU08hLkV3SAkcQKNAFzzUIKbF+SPnhMDRbFT/slDlBsTp6Y6bX7BB2P8gbquRADca1fPK
	X3Ar1sJNZsyKb40fLIWDMroJbZr1sahL5y2aQpP5eNcSx8+X/RNemP8XxU+gPidUP4/x9Fd3VVbGv
	CI5JDn9ar1xFNdS5QWXqyW6nwDxGmDfWSvyB3p/xDJdMbvbC7cdT/iOQGYGKeTVVDmddZ1yDxh+p+
	EIeFx1Vw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtI6-00000001DsL-0TpB;
	Fri, 15 Nov 2024 10:11:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D8E3A30066A; Fri, 15 Nov 2024 11:11:00 +0100 (CET)
Date: Fri, 15 Nov 2024 11:11:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241115101100.GZ22801@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
 <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
 <CAJZ5v0hJ8NoFgjtnYce99+qjCZc3_ihBojyK1gRrcyU5Fp6inw@mail.gmail.com>
 <20241112145618.GR22801@noisy.programming.kicks-ass.net>
 <ZzSQcq5JxGgKVh5Z@BLRRASHENOY1.amd.com>
 <20241114115831.GQ6497@noisy.programming.kicks-ass.net>
 <ZzYyPzT4AwSkbRpH@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYyPzT4AwSkbRpH@BLRRASHENOY1.amd.com>

On Thu, Nov 14, 2024 at 10:54:15PM +0530, Gautham R. Shenoy wrote:
> Hello Peter,
> 
> On Thu, Nov 14, 2024 at 12:58:31PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 13, 2024 at 05:11:38PM +0530, Gautham R. Shenoy wrote:
> > 
> > > AMD platforms won't be using FFH based states for offlined CPUs. We
> > > prefer IO based states when available, and HLT otherwise.
> > > 
> > > > 
> > > > Robustly we'd teach the ACPI driver about FFh and set enter_dead on
> > > > every state -- but we'd have to double check that with AMD.
> > > 
> > > Works for us as long as those FFh states aren't used for play_dead on
> > > AMD platforms.
> > 
> > AFAIU AMD doesn't want to use MWAIT -- ever, not only for offline.
> > Confirm?
> > 
> 
> AMD wants to use MWAIT for cpuidle and it does use MWAIT based C1
> state on both client and server parts.
> 
> Eg: On my server box
> 
> $ cpupower idle-info  | grep "FFH" -B1 -A3
> C1:
> Flags/Description: ACPI FFH MWAIT 0x0
> Latency: 1
> Usage: 6591
> Duration: 1482606
> 
> > But if it were to use MWAIT for regular idle, then surely it's OK for
> > offline too, right?
> 
> I tried this out today and there is no functional issue.
> 
> However, I would like to run some experiments on whether HLT provides
> better power savings than MWAIT C1 with CPUs offlined. I will get back
> with this information tomorrow.

Right, but in most cases you'll have C2/C3 with io ports specified and
those will be picked for play_dead anyway. It's just the exceptionally
weird BIOS case where you'll have C2/C3 as FFh -- because random BIOS
person was on drugs that day or something like that.

Anyway, what I'm trying to say is that you'll probably fine without
adding a bunch of if (AMD|HYGON) logic -- the less of that we have, the
better, etc..

