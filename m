Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8264486424
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390097AbfHHOOn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 10:14:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54430 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfHHOOn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 10:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z0UGEGuGseh7iEStj34QUNqw0FoQaSIU3ejKMAZDFz8=; b=gQZWXKpcNoF8drAHug1I3kxek
        lpW6Ho3F7oWr8O51eQD9v7AULBQdRWXHdEWxZLqPov3gme1bX+ix65/Ks01ROsHBXu/Wcz7QNneaD
        OatTBwVFEpXPC/U5EVQFe4d2v760MpDWt1Rmu6MBgX4wPIiIzoq3ehKGAw7T4GvcGuh8wQJnvsHCI
        nI//F3F4v5MsFonOS10WY44X1r9GK65YJH445QdNMRqT/SSUUApumx/VXekPXxRvQCiXMsOKjxgkT
        CwSIgxkmS0fH4JZL+6ZPu1LnU29g6zYoOxAsXSiZPO7FDH+m3YdovfNXFqBocqQCvNRFqFA2cWafG
        2LfSxFMPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvjBW-0002T3-SC; Thu, 08 Aug 2019 14:14:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4151730754B;
        Thu,  8 Aug 2019 16:14:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 679CF201881B9; Thu,  8 Aug 2019 16:14:27 +0200 (CEST)
Date:   Thu, 8 Aug 2019 16:14:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        x86@kernel.org, bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808141427.GI2369@hirez.programming.kicks-ass.net>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 09:19:23AM -0400, Liang, Kan wrote:
> 
> 
> On 8/8/2019 6:10 AM, Rajneesh Bhardwaj wrote:
> > Elkhart Lake is Atom based SoC that uses model number 0x96. CPUID details
> > will be documented in a future version of Intel Software Development
> > Manual.
> > 
> > Cc: bp@suse.de
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: x86-ml <x86@kernel.org>
> > Cc: Linux PM <linux-pm@vger.kernel.org>
> > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> > ---
> >   arch/x86/include/asm/intel-family.h | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> > index 0278aa66ef62..06e94ae65f28 100644
> > --- a/arch/x86/include/asm/intel-family.h
> > +++ b/arch/x86/include/asm/intel-family.h
> > @@ -79,6 +79,7 @@
> >   #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
> >   #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
> > +#define INTEL_FAM6_ATOM_ELKHART_LAKE	0x96 /*Elkhart Lake */
> 
> Usually, we should use the code name of microarchitecture for the name of
> CPUID.

Oh yes, very much. A quick google seems to suggest these are in fact
Tremont cores. So then the naming should be:

  INTEL_FAM6_ATOM_TREMONT_xxx


