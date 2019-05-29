Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C42D8F6
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfE2JUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 05:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2JUq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 05:20:46 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F73920665;
        Wed, 29 May 2019 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559121646;
        bh=/PL4CQ/v4pznt0abn/nUFgtQ+rgGUt9Hn5oNdPyrQ/I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zjCbiRlgW58S4wY/EVqqrvR+RmyzSey0pbRrf5fk3HMLp2etJ2M2fdjY1qpEwdj9x
         4jZEqdDPaFj+l1hzkM9H465kFmgmtM6TyV1tVIUHXDURXjdRNnBqlP5Mt1BndZe34+
         7KM+5sNgltaxNDBBzLehFDSa01o4uR0k2HSsM0TY=
Date:   Wed, 29 May 2019 11:20:40 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1
 regression]: nvme vs. hibernation)
In-Reply-To: <20190529085618.GH2623@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1905291118100.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm> <20190524154429.GE15192@localhost.localdomain> <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm> <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com> <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm> <20190529085618.GH2623@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019, Peter Zijlstra wrote:

> > > I verified that it succesfully makes it to the point where restore_image()
> > > is called from swsusp_arch_resume() (and verified that only BSP is alive
> > > at that time), but the old kernel never comes back and triplefault-like
> > > reboot happens.
> 
> which means that even without nosmt all 'other' CPUs are offline. And
> when I look at resume_target_kernel() I see it call
> hibernate_resume_nonboot_cpu_disable().
> 
> So how is the SMT offline different from that offline? afaict they all 
> get into play_dead()->native_play_dead()->mwait_play_dead().

There is no way those other CPUs have been offlined before to the 
native_play_dead() state, as this is way before any userspace was alive to 
initiate any kind of hotplug.

So they are guaranteed to have been all online, and then offlined properly 
to resume_play_dead(). 'nosmt' is the only exception there, as it's the 
only kind of offlining that has already happened at this point.

Let's continue in the other thread.

Thanks,

-- 
Jiri Kosina
SUSE Labs

