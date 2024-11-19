Return-Path: <linux-pm+bounces-17749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30309D22C6
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 10:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1E8B22190
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A891925B3;
	Tue, 19 Nov 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CoGMGeHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DE14AD24;
	Tue, 19 Nov 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009901; cv=none; b=qcUhQ/zM+p/mo0jMjFh8mdpZjAFg/difF7cX2aecT2FqQp2VqJb4P2JH48zHtBzV8hlypdH8U3ES/+kRIjR0sqsHgbWTqKtscUVdwjVbpA9qNPpN6oVzOrii766h2JRk8Cxfnd3kJpHiJTX+rw8rYG0LUN7TCb9ICO/p1hkir2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009901; c=relaxed/simple;
	bh=9/3BDPNAhsyKcvB91n9a+b9ji+46sWZqifIksBsC69w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaEuTIjKV2McksnY87c6CX7+742PAILIlK6h8bZF79RegQYhdpik1Cy/HxsILy3BeB7FsxQqjF1PBauBhYlknGR/Xy1P6MHsRKUT7DthrEJveiCuWZ6mskDWROeWc5icgfIMQD47nd6oFvIkDzY4KYnw2HMwAXDyCRJwTPnCtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CoGMGeHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3B1C4CECF;
	Tue, 19 Nov 2024 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732009901;
	bh=9/3BDPNAhsyKcvB91n9a+b9ji+46sWZqifIksBsC69w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoGMGeHwaeOsv114QewdXn3tskfPaTPPvsW8HM4aGw9RVAkr1d/zC1YxcoiqscjV0
	 7yfHTKIcRyqVlR34pIObvbdt4Ta7RoZSrx/kzQG+3HbopqKr0JeFcNAzzJMxaY6/CK
	 4DeI5m9lNMwz61GlYW2ktaKHe3Z5V4hPUKlkCbNI=
Date: Tue, 19 Nov 2024 10:51:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marex@denx.de>, Bird@google.com,
	Tim <Tim.Bird@sony.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Optimize async device suspend/resume
Message-ID: <2024111946-myth-graceful-7d70@gregkh>
References: <20241114220921.2529905-1-saravanak@google.com>
 <CAGETcx-NEjg5GwEMyz7C88ZhBrpFd55Md05Wez4kurvmdaWabQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-NEjg5GwEMyz7C88ZhBrpFd55Md05Wez4kurvmdaWabQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 08:04:26PM -0800, Saravana Kannan wrote:
> On Thu, Nov 14, 2024 at 2:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > A lot of the details are in patch 4/5 and 5/5. The summary is that
> > there's a lot of overhead and wasted work in how async device
> > suspend/resume is handled today. I talked about this and otther
> > suspend/resume issues at LPC 2024[1].
> >
> > You can remove a lot of the overhead by doing a breadth first queuing of
> > async suspend/resumes. That's what this patch series does. I also
> > noticed that during resume, because of EAS, we don't use the bigger CPUs
> > as quickly. This was leading to a lot of scheduling latency and
> > preemption of runnable threads and increasing the resume latency. So, we
> > also disable EAS for that tiny period of resume where we know there'll
> > be a lot of parallelism.
> >
> > On a Pixel 6, averaging over 100 suspend/resume cycles, this patch
> > series yields significant improvements:
> > +---------------------------+-----------+----------------+------------+-------+
> > | Phase                     | Old full sync | Old full async | New full async |
> > |                           |               |                | + EAS disabled |
> > +---------------------------+-----------+----------------+------------+-------+
> > | Total dpm_suspend*() time |        107 ms |          72 ms |          62 ms |
> > +---------------------------+-----------+----------------+------------+-------+
> > | Total dpm_resume*() time  |         75 ms |          90 ms |          61 ms |
> > +---------------------------+-----------+----------------+------------+-------+
> > | Sum                       |        182 ms |         162 ms |         123 ms |
> > +---------------------------+-----------+----------------+------------+-------+
> >
> > There might be room for some more optimizations in the future, but I'm
> > keep this patch series simple enough so that it's easier to review and
> > check that it's not breaking anything. If this series lands and is
> > stable and no bug reports for a few months, I can work on optimizing
> > this a bit further.
> >
> > Thanks,
> > Saravana
> > P.S: Cc-ing some usual suspects you might be interested in testing this
> > out.
> >
> > [1] - https://lpc.events/event/18/contributions/1845/
> >
> > Saravana Kannan (5):
> >   PM: sleep: Fix runtime PM issue in dpm_resume()
> >   PM: sleep: Remove unnecessary mutex lock when waiting on parent
> >   PM: sleep: Add helper functions to loop through superior/subordinate
> >     devs
> >   PM: sleep: Do breadth first suspend/resume for async suspend/resume
> >   PM: sleep: Spread out async kworker threads during dpm_resume*()
> >     phases
> >
> >  drivers/base/power/main.c | 325 +++++++++++++++++++++++++++++---------
> 
> Hi Rafael/Greg,
> 
> I'm waiting for one of your reviews before I send out the next version.

Please feel free to send, it's the middle of the merge window now, and
I'm busy with that for the next 2 weeks, so I can't do anything until
after that.

thanks,

greg k-h

