Return-Path: <linux-pm+bounces-12058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663994D806
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 22:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA490283347
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF815FD1B;
	Fri,  9 Aug 2024 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlITpJiY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BE33D1;
	Fri,  9 Aug 2024 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235113; cv=none; b=Sr8Dzu0hjvSIKE5xOskcOIJeAdBUx11fWLJ54LxB7/YmAXlccEMAzk+KtYqFpoajFJUmjqoA+sTDA9q416keIWSTHDq1A4eMz5xqn/1IfGuYJ9H6euLR/qhq/BvPnk8iC5/BgEMFiKyvNZl11z+Fbt1SwTOVfTfv4K2ThvckID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235113; c=relaxed/simple;
	bh=JY82VNfX6WQ3JiDjCf+iJqgRRw+TQ7NAv1+7OOcT0Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGi2pThpuoaq94u1BEOckBBVYDX1qZB07SSZtJj4y8XqieBBv5rRKh3PKDrredvDkrp8HLSas/xEUaVnaCIAdrZNvIM7OI5ukuUH3XMDRaFmaofd0dKllCe3T/n6jCxnatK73yWiRDG/OxHUsLYwk1+bhuDp+IkN7wpft7yWzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlITpJiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E9AC32782;
	Fri,  9 Aug 2024 20:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723235113;
	bh=JY82VNfX6WQ3JiDjCf+iJqgRRw+TQ7NAv1+7OOcT0Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlITpJiYiyLRblAGKhiqlSx/Y8IT99XpN6sZhYnvzOrpLHA6DWAKw7BIwrOXaoVty
	 RVPDYVs3lZ5zHyaJZrwLGx9EBo9XBTUFy+WrYsPXMJV1w0DRrtgZ4SI8AECTZDr/nl
	 +/QbJQ7sbBcJIx8bZEHccxl8M1C6iJytQPa2XtB2DYqVKn+OEbJCIt3ED/uoAxD+J/
	 5bO8tBH81Qcqzi4SuB6GBtvdmgdcuR6tkyH3KpkE8i7demCUlP2Jg5B56YqQ/uc9df
	 xcVofZ28b8S4L6S4BiUeThPvgc4uYue9rImGdszYDKN8guRi/SMy5I8TeDjk7DPYzq
	 RaKJydD4UrDgQ==
Date: Fri, 9 Aug 2024 17:25:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <ZrZ7JvzGo9QRap8K@x1>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
 <2024080405-roundish-casket-2474@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024080405-roundish-casket-2474@gregkh>

On Sun, Aug 04, 2024 at 10:54:10AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 01, 2024 at 05:24:20PM -0400, John B. Wyatt IV wrote:
> > > On 7/24/24 16:11, John B. Wyatt IV wrote:
> > > > SWIG is a tool packaged in Fedora and other distros that can generate
> > > > bindings from C and C++ code for several languages including Python,
> > > > Perl, and Go. We at Red Hat are interested in adding binding support to
> > > > libcpupower so Python tools like rteval or tuned can make easy use of it.
> > > > 
> > > 
> > > Can you elaborate on the use-case and what rteval currently does and
> > > how it could benefit from using libcpupower with the bindings?
> > 
> > rteval is a Python program used to measure realtime performance. We wanted to
> > test the effect of enabling some levels of idle-stat to see how it affects
> > latency, and didn't want to reinvent the wheel. We thought that the Python
> > bindings could be useful to other people as well who might want to call
> > cpupower too from Python. I did some testing and was able to achieve this with
> > SWIG. We sent the patchset to see what folks thought about this.
 
> Is this going to require a built-time dependency on SWIG?  If not, when
> would it be run, and who will be in charge of running it and updating
> the bindings?

> And finally, why do we need these at all?  You are saying these are new
> tests that external tools will be using, but why, if external tools are
> required to run them, are they needed in the kernel tree at all?  Why
> isn't this just another external test-suite that people who care about
> measuring this type of thing going to just run on their own if desired?

We have a python binding for perf, it was done manually, didn't use
something like swig, don't recall why I made that decision at the time,
maybe not to get one extra build dependency, as you mention.

I did it at the time as another tool developed at Red Hat, tuna, a top
like tool, using GTK+, could use the perf infrastructure to get
notifications about new threads and threads exiting, as exemplified by
test tools in the kernel sources:

root@number:/home/acme/git/linux# tools/perf/python/twatch.py 
cpu: 24, pid: 2787405, tid: 2787405 { type: fork, pid: 2787405, ppid: 2787405, tid: 673409, ptid: 2787405, time: 300460407945015}
cpu: 23, pid: 2787405, tid: 673409 { type: comm, pid: 2787405, tid: 673409, comm: StreamT~s #1624 }
cpu: 4, pid: 3923381, tid: 3923381 { type: fork, pid: 3923381, ppid: 3923381, tid: 673410, ptid: 3923381, time: 300460862312442}
cpu: 23, pid: 2787405, tid: 673409 { type: comm, pid: 2787405, tid: 673409, comm: StreamT~s #1624 }
cpu: 23, pid: 3923381, tid: 673410 { type: comm, pid: 3923381, tid: 673410, comm: StreamT~s #3197 }
cpu: 23, pid: 3923381, tid: 673410 { type: comm, pid: 3923381, tid: 673410, comm: StreamT~s #3197 }
cpu: 13, pid: 2787464, tid: 2787464 { type: fork, pid: 2787464, ppid: 2787464, tid: 673411, ptid: 2787464, time: 300461205531219}
cpu: 26, pid: 2787464, tid: 673411 { type: comm, pid: 2787464, tid: 673411, comm: StreamT~s #1624 }
cpu: 26, pid: 2787464, tid: 673411 { type: comm, pid: 2787464, tid: 673411, comm: StreamT~s #1624 }
^CTraceback (most recent call last):
  File "/home/acme/git/linux/tools/perf/python/twatch.py", line 61, in <module>
    main()
  File "/home/acme/git/linux/tools/perf/python/twatch.py", line 33, in main
    evlist.poll(timeout = -1)
KeyboardInterrupt

root@number:/home/acme/git/linux# 

root@number:/home/acme/git/linux# head tools/perf/python/twatch.py 
#! /usr/bin/env python
# SPDX-License-Identifier: GPL-2.0-only
# -*- python -*-
# -*- coding: utf-8 -*-
#   twatch - Experimental use of the perf python interface
#   Copyright (C) 2011 Arnaldo Carvalho de Melo <acme@redhat.com>
#

import perf

root@number:/home/acme/git/linux#

Another

root@number:/home/acme/git/linux# tools/perf/python/tracepoint.py | head -50 | tail
time 302243176736731 prev_comm=chromium-browse prev_pid=633048 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/8 next_pid=0 next_prio=120
time 302243177970076 prev_comm=swapper/10 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=python next_pid=676159 next_prio=120
time 302243177952044 prev_comm=Compositor prev_pid=660727 prev_prio=120 prev_state=0x1 ==> next_comm=migration/17 next_pid=74 next_prio=0
time 302243176742113 prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=chromium-browse next_pid=633048 next_prio=120
time 302243177991642 prev_comm=python prev_pid=676159 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/10 next_pid=0 next_prio=120
time 302243177962820 prev_comm=migration/17 prev_pid=74 prev_prio=0 prev_state=0x1 ==> next_comm=swapper/17 next_pid=0 next_prio=120
time 302243176784747 prev_comm=chromium-browse prev_pid=633048 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/8 next_pid=0 next_prio=120
time 302243177993435 prev_comm=swapper/10 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=python next_pid=676159 next_prio=120
time 302243177966620 prev_comm=swapper/17 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=Compositor next_pid=660727 next_prio=120
time 302243176999285 prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=chromium-browse next_pid=633048 next_prio=120
root@number:/home/acme/git/linux#

By now I think there are other tools that use that python binding out in
the wild and it is packaged by distros as:

root@number:/home/acme/git/linux# dnf search python3-perf
============================================================================= Name Exactly Matched: python3-perf ==============================================================================
python3-perf.x86_64 : Python bindings for apps which will manipulate perf events
root@number:/home/acme/git/linux# 

Having these bindings opens the doors for projects to use these
libraries provided via the kernel sources, allowing other languages to
be used than C.

Now we have multiple libraries in the kernel sources, if we could have a
convenient way to provide those bindings for python, Go, etc, that could
help more projects while reducing the cost of supporting those bindings
by having more people capable of fixing up when needed as we would be
using a common way of providing such bindings.

Cheers,

- Arnaldo

