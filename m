Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7E1D8AAB
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 00:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgERWUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 18:20:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:47013 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgERWUS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 May 2020 18:20:18 -0400
IronPort-SDR: nPtcy3ktJ2Aa5zGV7ptvVTd1UTnMi7Hrg/UVpVlvIkvekMpoaYEnStfvwwCu+nqE5xqg9Afcvu
 MfWRPWqXxUDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:20:18 -0700
IronPort-SDR: bunCAUpkQe5rEtfhlNJhPWAzLxi8Vq+VFArHQiuw64K4VzT++yLn9vczgTv1L+qSPLrskSpF0b
 V0DPyg0vOPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="267675369"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2020 15:20:17 -0700
Date:   Mon, 18 May 2020 15:20:37 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
Message-ID: <20200518222037.GA14829@ranerica-svr.sc.intel.com>
References: <20200428132450.24901-1-ggherdovich@suse.cz>
 <20200428132450.24901-2-ggherdovich@suse.cz>
 <20200501133042.GE3762@hirez.programming.kicks-ass.net>
 <1588429500.8505.29.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588429500.8505.29.camel@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, May 02, 2020 at 04:25:00PM +0200, Giovanni Gherdovich wrote:
> > 
> > I've changed the patch like so.. OK?
> > 
> > (ok, perhaps I went a little overboard with the paranoia ;-)
> 
> Right, I wasn't really checking for overflow, only for when the product
> "mcnt * arch_max_freq_ratio" becomes zero.
> 
> Thanks for your edit (I took note of the macros check_*_overflow, didn't know
> them). I fully subscribe to the paranoid approach.
> 
> I understand you've already edited the patches in your tree, so I am not
> resending, just confirming my
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>

Hi, have these changes been merged? I still don't see them in the tip or
Linus' tree.

Thanks and BR,
Ricardo
