Return-Path: <linux-pm+bounces-369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F417FBC18
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DF71C20340
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877859B65;
	Tue, 28 Nov 2023 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WgmwKxv9"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67885B5;
	Tue, 28 Nov 2023 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kbo+RHlcbyYyBRrrc3whU0Ok1x+trIWNBYTilsW1XuI=; b=WgmwKxv9CoPrJNaMGZ0b0cipit
	1Dn8osLTNJw+PM7fRkJSHUnm8YFQE0eP566+F9DNMA31UbmW46JjaqhPe1c6A/qyBQ2/X3RYmO7nP
	bHA0iXTXxcNP7FYVb+NyAnLisit8kmbieBp+1G92bgHC59jJGDgGSVnuk+TcL/xPnmqAsl2Ul1Z6+
	9qJgpI0XzYQA/FCON0ITa20ltlhaiJDOcpBrVLRb46FzAhU/T5ZTX/W8YnDNWHbhUXBkW7b6w7GT9
	ReXjB4GHT39ck5dC7am0UAwRNdrUFQvxFmmkMrHuI0vxK/29bBTRNETziKPoAZp5okldMW+Bh8K5K
	cpqdS1Vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r7yfT-00CPkR-Dz; Tue, 28 Nov 2023 14:02:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D8A83003F0; Tue, 28 Nov 2023 15:02:25 +0100 (CET)
Date: Tue, 28 Nov 2023 15:02:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ramses VdP <ramses@well-founded.dev>,
	ricardo.neri-calderon@linux.intel.com
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
Message-ID: <20231128140225.GS8262@noisy.programming.kicks-ass.net>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>

On Tue, Nov 28, 2023 at 08:22:27PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I come across an interesting bug report on Bugzilla [1]. The reporter
> wrote:

Thanks for forwarding, what happend in bugzilla staysi in bugzilla etc..

Did you perchance Cc the reporter?

> > I am running an intel alder lake system (Core i7-1260P), with a mix
> > of P and E cores.
> > 
> > Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems
> > to have a strong preference for the E cores, and single threaded
> > workloads are consistently scheduled on one of the E cores.
> > 
> > With Linux 6.4 and before, when I ran a single threaded CPU-bound
> > process, it was scheduled on a P core. With 6.5, it seems that the
> > choice of P or E seemed rather random.
> > 
> > I tested these by running "stress" with different amounts of
> > threads. With a single thread on Linux 6.6 and 6.7, I always have an
> > E core at 100% and no load on the P cores. Starting from 3 threads I
> > get some load on the P cores as well, but the E cores stay more
> > heavily loaded.  With "taskset" I can force a process to run on a P
> > core, but clearly it's not very practical to have to do CPU
> > scheduling manually.
> > 
> > This severely affects single-threaded performance of my CPU since
> > the E cores are considerably slower. Several of my workflows are now
> > a lot slower due to them being single-threaded and heavily CPU-bound
> > and being scheduled on E cores whereas they would run on P cores
> > before.
> > 
> > I am not sure what the exact desired behaviour is here, to balance
> > power consumption and performance, but currently my P cores are
> > barely used for single-threaded workloads.
> > 
> > Is this intended behaviour or is this indeed a regression? Or is
> > there perhaps any configuration that I should have done from my
> > side? Is there any further info that I can provide to help you
> > figure out what's going on?
> 
> PM and scheduler people, is this a regression or works as intended?

AFAIK that is supposed to be steered by the ITMT muck and I don't think
we changed that.

Ricardo?

> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218195
> 
> -- 
> An old man doll... just what I always wanted! - Clara

