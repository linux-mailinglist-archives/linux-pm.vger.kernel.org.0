Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0701D9D27
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgESQqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 12:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbgESQqu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 12:46:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35618AC85;
        Tue, 19 May 2020 16:46:51 +0000 (UTC)
Message-ID: <1589906807.13984.22.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 18:46:47 +0200
In-Reply-To: <20200518222037.GA14829@ranerica-svr.sc.intel.com>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
         <20200428132450.24901-2-ggherdovich@suse.cz>
         <20200501133042.GE3762@hirez.programming.kicks-ass.net>
         <1588429500.8505.29.camel@suse.cz>
         <20200518222037.GA14829@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-05-18 at 15:20 -0700, Ricardo Neri wrote:
> On Sat, May 02, 2020 at 04:25:00PM +0200, Giovanni Gherdovich wrote:
> > > 
> > > I've changed the patch like so.. OK?
> > > 
> > > (ok, perhaps I went a little overboard with the paranoia ;-)
> > 
> > Right, I wasn't really checking for overflow, only for when the product
> > "mcnt * arch_max_freq_ratio" becomes zero.
> > 
> > Thanks for your edit (I took note of the macros check_*_overflow, didn't know
> > them). I fully subscribe to the paranoid approach.
> > 
> > I understand you've already edited the patches in your tree, so I am not
> > resending, just confirming my
> > 
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> 
> Hi, have these changes been merged? I still don't see them in the tip or
> Linus' tree.
> 

Hi Ricardo,

the kbuild bot found an error in this patch, the macro check_mul_overflow
doesn't build on x86 32bit, so Peter Zijlstra hasn't merged it yet.
This is the error:
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/7GDIBOMNVDG5W2XZD4EICE2TUZR3THBN/

I'm writing a patch to avoid doing frequency invariance entirely on i386.
I doubt those machines have APERFMPERF anyways. This will fix the build error.


Cheers,
Giovanni
