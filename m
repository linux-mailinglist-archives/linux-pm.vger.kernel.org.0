Return-Path: <linux-pm+bounces-41140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E119ED3BA6A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 23:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8643049C4E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0527FD7C;
	Mon, 19 Jan 2026 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cver8y8O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5E1917ED;
	Mon, 19 Jan 2026 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860422; cv=none; b=DaJV8TI6jq2h34g8+SFGuBVcDDy8AJgYxMss5XP4htH9c67ttfQPU+jXhFPVFRZKmmOb/YI8KMoiOk5kyk7u0owX105xxDfTf/F8sbPMv7DhIIy3odrgozFjf33thrvUZEmo6CLJGq1RcdpdpTbu76r/pwtTDArovDqQ3SIkq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860422; c=relaxed/simple;
	bh=Nafb/OJ7lFPcWlC17ZXYnF4HcJUl+iFGvBaNeELuzy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J++j7q/c5+Jmk5ufstk0olMLqVE8q2eOQkJf0ujokjesynuMVCTzQRorfd+HmQlxI4s4sgkvZws3NrHLOSHWJSBrL80WzI7Ggwjl3GxbiuJrjt94uPkqaJMzOwJKWQNOoXwWZtFvxIC3gOsy6CWrO1bnhe9z3mNFuqRjsk2vAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cver8y8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0330C19422;
	Mon, 19 Jan 2026 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768860421;
	bh=Nafb/OJ7lFPcWlC17ZXYnF4HcJUl+iFGvBaNeELuzy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cver8y8Oyj9J+Gx5rk8ecwY3aCbD1IfmObkpHKHd+ntNdp7WSN9l5Fvo128YUVZEo
	 dxmLHFXQSiZKeXmFPZYll3bz9QdryagTWut5BsZ2Ma/STcC4BRZjBg+qMk53k/oHJ8
	 ftMwZsIWBuhQ0JJD75ooZrtPxA+VqMuce12YEC6TwkjAXwEQ+9B9wuYwk4xj5vjpZc
	 9g5lY5aZi3XhMHDGsOLxeBb+Cbg/kCrdS/WtWzBrdbxEfpMhdqatlsUe2NnklsTgr/
	 nyG1GNOcsHbzJWf7d75pxNpQcwvjrGzQgRBlQ5iWlCFvqRDIkb9+XC1nol0jsHMkMB
	 6Eduzn7yGQo+g==
Date: Mon, 19 Jan 2026 23:06:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime
 granularity test
Message-ID: <aW6rAjJ5hz5BYuAR@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-8-frederic@kernel.org>
 <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hn81J_0N0Hy6QYtc3655w-9hDqVgWWY1BVhW=DT56Deg@mail.gmail.com>

Le Mon, Jan 19, 2026 at 01:30:07PM +0100, Rafael J. Wysocki a écrit :
> On Fri, Jan 16, 2026 at 3:53 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
> > accounting has a nanoseconds granularity.
> >
> > Use the appropriate indicator instead to make that deduction.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> 
> or please let me know if you want me to take this patch.

The patch is standalone but the rest of the patchset depends on it.
Now I don't target this patchset for v6.20-rc1.

So if you manage to sneak this patch in for v6.20-rc1, it works because
I'll rebase on -rc1. Otherwise I'll need to keep it to avoid breaking
some code assumptions.

What do you think?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

