Return-Path: <linux-pm+bounces-25101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C845A84141
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348DA3A20EF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176F276057;
	Thu, 10 Apr 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sEIITVji"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0332256C75;
	Thu, 10 Apr 2025 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282360; cv=none; b=hXHmew3kaEkWwgf6s6wQukUZR2jDHKxDazuH1gsBTBOPqr6duTpSA7yClxtFW5B04jkBIID+wE17lNQ4oVc1NOU0ztq6X6Bnpu805WGq2UD+Y7cbqsrepwLAs+oynMACKn7yRXg3CJjp06tkEK6j8hEGQGGUhl+JRwuIxHkq9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282360; c=relaxed/simple;
	bh=7wBrrTzsBst25ssilXMw28kvSf5Er6C0Dk03FWz+HXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmuB/SwXZpMTi0MIa7TlfHBY55eiz5CVC6lDNC7WflMN1o2bZCj0sBHl6FXAZq9vtvvvuGoy4W+3nHlSr2eqCnLoKqFnhUGtkjW/QV946ow+1eZtFaI3rNfMi89WjGCxsdgNr57sM9z+qxxWWusMdWLF6cLglpwkmiA4aQCE7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sEIITVji; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oKSUbsgAB3mRyb0GnkDkQig+o1YJFRaynD1xrmGVCo4=; b=sEIITVjixbiNYSW2H2MdnpCltD
	+Ut5StqPYsNgQpqKhE9yE4NZHmky+/PntwXYQbPYQz73fKppPVad0pgW+gQJmDVoJl/Hy+N0FQxFR
	lyPuFB3pBMo7TwFstDVzVov2wMBegl1Z8U6zO5vOCddDbM8lyLkTuAjmDS8VLCVBlsxUasbAbwMQW
	Mwix8RnK1KcYI5MpbvT3D+k5k+lQFGhR83o6sUyW4Rs4d2zb3QqluYp9WwlCVusnmrna29axMSpa3
	j0zOSK8E7trz3d7Amdk9ZN16c/o8Cj6ZK3T+d+aS8FyjnlzRyiK6nOK+tDtEwO/BQZo+nABGLg7/M
	YquEn8zA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2pWJ-00000002mNu-0nYK;
	Thu, 10 Apr 2025 10:52:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A84A3003C4; Thu, 10 Apr 2025 12:52:31 +0200 (CEST)
Date: Thu, 10 Apr 2025 12:52:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH v2 0/4] sched/fair: Dynamic asym priority support
Message-ID: <20250410105231.GF30687@noisy.programming.kicks-ass.net>
References: <20250409053446.23367-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409053446.23367-1-kprateek.nayak@amd.com>

On Wed, Apr 09, 2025 at 05:34:42AM +0000, K Prateek Nayak wrote:
> K Prateek Nayak (4):
>   sched/fair: Use READ_ONCE() to read sg->asym_prefer_cpu
>   sched/topology: Introduce sched_update_asym_prefer_cpu()
>   cpufreq/amd-pstate: Update asym_prefer_cpu when core rankings change
>   sched/debug: Print the local group's asym_prefer_cpu
> 
>  drivers/cpufreq/amd-pstate.c   |  4 ++-
>  include/linux/sched/topology.h |  6 ++++
>  kernel/sched/debug.c           |  4 +++
>  kernel/sched/fair.c            |  5 +--
>  kernel/sched/topology.c        | 58 ++++++++++++++++++++++++++++++++++
>  5 files changed, 74 insertions(+), 3 deletions(-)

This seems reasonable. I'll queue it up, and unless someone (robot or
real person) objects, we'll get it merged :-)

