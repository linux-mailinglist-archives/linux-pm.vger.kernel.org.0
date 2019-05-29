Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A003A2D84E
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2I4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 04:56:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60718 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2I4v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yoN+qjMhQOqFfhB9c55JTuMYWset936oLOIvZ9uv87s=; b=YJ4KaPKdKZ1jLs40LqPjsyPk6
        uyds6tzKQVpfr03EZu5CgRrAYZtgDRLu5KiSI+pE8dGeGCNLQD8yx7G1JrhDQIIHFWfl9BRox4HUg
        iDTe+WXBl5e74NeCuPlZTSeNVbX+d1wjL9NfeSDukchNfw0KObzXmvymR7eTLd7m/OBPlj4kmfBTv
        EcNKA556PaJqaymOdEHRufll94IcIYNRGOWtAeNRsW6NvfHttmADbxrrS4MhLc6LxNtQN7p8zhUm7
        iXpGVIbKJQBORe7knNzZZ4hYYfuSp+Yyq80iIWptFl5woTWE6YltecvczEB9vWVaEvsVRH3MUNYQF
        yAIdt2c9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVuNh-0002hC-Ei; Wed, 29 May 2019 08:56:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8915201A7E42; Wed, 29 May 2019 10:56:18 +0200 (CEST)
Date:   Wed, 29 May 2019 10:56:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
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
Message-ID: <20190529085618.GH2623@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
 <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 09:22:14PM +0200, Jiri Kosina wrote:
> On Tue, 28 May 2019, Jiri Kosina wrote:
> 
> > [ some x86/PM folks added ]
> > 
> > I isolated this to 'nosmt' being present in the "outer" (resuming) kernel, 
> > and am still not sure whether this is x86 issue or nvme/PCI/blk-mq issue.
> > 
> > For the newcomers to this thread: on my thinkpad x270, 'nosmt' reliably 
> > breaks resume from hibernation; after the image is read out from disk and 
> > attempt is made to jump to the old kernel, machine reboots.

> 
> Thomas figured it out (and this should be really more widespread than just 
> my machine :) ).
> 
> nosmt forces HT siblings to mwait, but that explodes after %cr3 change 
> during resume, as the mwait target address is all of a sudden not valid 
> anymore for neither of the hyperthreads.

ARGH!!! But also, you wrote:

> > I verified that it succesfully makes it to the point where restore_image()
> > is called from swsusp_arch_resume() (and verified that only BSP is alive
> > at that time), but the old kernel never comes back and triplefault-like
> > reboot happens.

which means that even without nosmt all 'other' CPUs are offline. And
when I look at resume_target_kernel() I see it call
hibernate_resume_nonboot_cpu_disable().

So how is the SMT offline different from that offline? afaict they all
get into play_dead()->native_play_dead()->mwait_play_dead().

