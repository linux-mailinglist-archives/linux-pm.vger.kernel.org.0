Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842A88622E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfHHMr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 08:47:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53592 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfHHMr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 08:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GbvdPjWYQKpX6m4dPm69X1cZqB+jN5UDvAAop4Eg0rM=; b=XHlNodIjk6DvivItB9D4MYPX6
        muGMtMODFNVL+DTJWkpjQyMvzEtjEeIz+HHPQuVpFA0WhrDaNlXoNkxFuk6De5rBSOK8VXeN7uUzX
        pYbfcuIwwWtnysbs/hC+Vvjkf2wfbTSypIlqWU4+wzM8vYNsYYvUYSC17YcYNXwxOBx6v5Nzf1WkO
        22YNV+Q8faWtV+rnK01JofbVa2Vf3R79mkwdbCI6gOSX0RVs0y7WRackVK5xcuCn/QmYpvtRgPina
        GXuV0/sBohRYUtlIAARHz3H465R72ugzr3e4qLdsmZdAyXGMFfKNaXYvAvo6+bUWhsG3qyPoJe8Yo
        SgiUfkjFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvhp2-0001np-Ay; Thu, 08 Aug 2019 12:47:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E3B430759B;
        Thu,  8 Aug 2019 14:46:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81EE22018B96B; Thu,  8 Aug 2019 14:47:09 +0200 (CEST)
Date:   Thu, 8 Aug 2019 14:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     x86@kernel.org, bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808124709.GH2369@hirez.programming.kicks-ass.net>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <20190808104253.GG2369@hirez.programming.kicks-ass.net>
 <9d7241a1-5c2c-2369-5b1d-68912cc430b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7241a1-5c2c-2369-5b1d-68912cc430b4@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 05:58:35PM +0530, Bhardwaj, Rajneesh wrote:
> Hello Peter,
> 
> Thanks for the review.
> 
> On 08-Aug-19 4:12 PM, Peter Zijlstra wrote:
> > On Thu, Aug 08, 2019 at 03:40:45PM +0530, Rajneesh Bhardwaj wrote:
> > > Elkhart Lake is Atom based SoC that uses model number 0x96. CPUID details
> > > will be documented in a future version of Intel Software Development
> > > Manual.
> > > 
> > > Cc: bp@suse.de
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: x86-ml <x86@kernel.org>
> > > Cc: Linux PM <linux-pm@vger.kernel.org>
> > > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> > > ---
> > >   arch/x86/include/asm/intel-family.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> > > index 0278aa66ef62..06e94ae65f28 100644
> > > --- a/arch/x86/include/asm/intel-family.h
> > > +++ b/arch/x86/include/asm/intel-family.h
> > > @@ -79,6 +79,7 @@
> > >   #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
> > >   #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
> > > +#define INTEL_FAM6_ATOM_ELKHART_LAKE	0x96 /*Elkhart Lake */
> > Almost, please try again.
> 
> Did you mean "It should be after Gemini Lake"? And / Or a Space inside
> comment before 'E' ?

The comment :-)
