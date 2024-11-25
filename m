Return-Path: <linux-pm+bounces-18072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ED59D87A5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D8E166093
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7E1AF0BC;
	Mon, 25 Nov 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cw28wnQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EB1F16B;
	Mon, 25 Nov 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543944; cv=none; b=YfNhmmB1dGmCfH1Rm3V0rPgN5mka+Yn79avbnttv7mBgUNeG2/x8xEw6WPKe+PIEap3+SeUu/acVlG3mW3o5fTIrRzYb04949uUZQyiGY6n7HsEgqs6uQDAkycJWWeDYKzAnT96PL9AOi0ZE96JC3TKu4O7tmDhgx2B9N3E3gGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543944; c=relaxed/simple;
	bh=YVy7uTxEwHCmhd06FSFJGkGeW9Z/Xis7hZydsV9KFlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by0cPDbmWG5Fx+/RIsQPUXBfTQz0qLDJeVAFYOFymAvOArQBUGGCqd+7Te4MxtUMOtI8renwX7+Rcfz/eAPkDKkMwTBpPh1zIqLS9856mhFUTFTSLi3zUObFbxsM8LgoY5O2Y2L7rNf7iHLbX66oNWROQ8Cqa+aj8C85uxAX4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cw28wnQt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JUcrl+bCogdVwq9Y+6oqWPTJoRozT0Q8MkJQvUfb7EY=; b=cw28wnQtg9tdJ1jq5b07rXm6W4
	mCcwf9VG7o3GlSsUJq/qm9AzxW98cWujV5cHEVsARRHvyW229g4O0lbtWeMG0iYTsgOQXVSjbWFFZ
	0pq+Nv3CdCD9YymHHmO6twcsfGPjrQGIH9gpNRfIPkJdcb9TKarLQ4Am/yKcrUVITLC3KUQMyq+fS
	4bHeFHgJnAc5OYPImb5gP9YObik9IHFU0r+ZUJeZSp/MRLHNc2ubWAbxjM9KrY6fRucpV1SiSyP8F
	4WaKqussTTWx6xMCxm5mmNbBn0LL8UarSs3bP5jeoBMLb8Ph2rOnHCoMQ19KnJ0COZ2erHU9ldvTD
	CQBOkraQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFZp0-0000000BxDf-440U;
	Mon, 25 Nov 2024 14:12:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A7D330026A; Mon, 25 Nov 2024 15:12:15 +0100 (CET)
Date: Mon, 25 Nov 2024 15:12:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, gautham.shenoy@amd.com
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for
 SRF
Message-ID: <20241125141215.GF38837@noisy.programming.kicks-ass.net>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com>
 <20241125135306.GD38837@noisy.programming.kicks-ass.net>
 <CAJZ5v0gXy5FNsRepBTAyBS++HmhszZbN22KgfO8M=mXRVK9d6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gXy5FNsRepBTAyBS++HmhszZbN22KgfO8M=mXRVK9d6Q@mail.gmail.com>

On Mon, Nov 25, 2024 at 02:58:50PM +0100, Rafael J. Wysocki wrote:

> > @@ -2143,10 +2143,15 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
> >                 if (intel_idle_max_cstate_reached(cstate))
> >                         break;
> >
> > -               if (!cpuidle_state_table[cstate].enter &&
> > -                   !cpuidle_state_table[cstate].enter_s2idle)
> > +               if (!cpuidle_state_table[cstate].enter)
> >                         break;
> >
> > +               if (!cpuidle_state_table[cstate].enter_dead)
> > +                       cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
> > +
> > +               if (!cpuidle_state_table[cstate].enter_s2idle)
> > +                       cpuidle_state_table[cstate].enter_s2idle = intel_idle_s2idle;
> > +
> >                 /* If marked as unusable, skip this state. */
> >                 if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
> >                         pr_debug("state %s is disabled\n",
> 
> You can do the same thing with :enter() I think?  And it doesn't need
> to be in one go.

!enter is used as a terminator.

And it's harder to not do everything in one go; regex ftw :-)

