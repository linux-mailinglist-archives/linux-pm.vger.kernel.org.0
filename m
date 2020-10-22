Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3766295E68
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898249AbgJVMaw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898170AbgJVMaw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 08:30:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E5C0613CE;
        Thu, 22 Oct 2020 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/zZlgQ49hzZ8Igx9Ir7W2mtc3LsLICFZToYlcVG4c3s=; b=OikXOIKqeP/evXisZbUfxoO7ss
        9Dav6ZcY9P8OqgqxY4sLrkbOHmB9l3SZD3uv1jCLDEDErpBzAC5erMGuI+5O0DGezfBKibLDX3ru+
        m8VvOusREx8QQzArsXRNJ3ox/CcGoxXaqFhKiARe8m27ooSpjxs4ybMW7RwChbdJo4ftX3QyWjfhc
        lN4JR485EjemVRi/YmIN3+O8ws3InRcIK5PL5fxHpLPMPEXoMuMSJ5Fc2cAb2ad5BQHa+4duz47/I
        BtsLZfGkXj6t9xJMTcaQPUJrT9OfAizMm8cwq+v366BoP9CDSQfroB28nCXVwEC+nW7MxzRw1MzGy
        w2AaiC8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVZjx-0004Dy-TM; Thu, 22 Oct 2020 12:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A662304D28;
        Thu, 22 Oct 2020 14:30:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 700A32B90AF8C; Thu, 22 Oct 2020 14:30:44 +0200 (CEST)
Date:   Thu, 22 Oct 2020 14:30:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v2 1/3] x86, sched: check for counters overflow in
 frequency invariant accounting
Message-ID: <20201022123044.GX2628@hirez.programming.kicks-ass.net>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
 <20200531182453.15254-2-ggherdovich@suse.cz>
 <20201022084618.GU2628@hirez.programming.kicks-ass.net>
 <1603369318.3162.21.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603369318.3162.21.camel@suse.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 02:21:58PM +0200, Giovanni Gherdovich wrote:
> On Thu, 2020-10-22 at 10:46 +0200, Peter Zijlstra wrote:
> > On Sun, May 31, 2020 at 08:24:51PM +0200, Giovanni Gherdovich wrote:
> > 
> > Hi Giovanni!
> > 
> > > +error:
> > > +	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> > > +	schedule_work(&disable_freq_invariance_work);
> > > +}
> > 
> > I'm getting reports that we trigger this on resume. Would it make sense
> > to hook into tsc_{save,restore}_sched_clock_state() (or somewhere near
> > there) to reset the state (basically call init_counter_refs() again to
> > ensure we're not having to deal with crazy ?
> 
> Hello,
> 
> right, if the counters keep running while the machine is suspended then the
> current code thinks it's a runtime overflow. I'll prepare a patch to fix that,
> thanks for the heads-up and the hint.

Either keep running, get reset, get scrambled, everything is possible.

Thanks!
