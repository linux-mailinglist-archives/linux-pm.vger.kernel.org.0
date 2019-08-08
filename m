Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB57C86854
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbfHHRyx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 13:54:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbfHHRyx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 13:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WZU3ygzbX3K1RfSOuDO6mxhjCgU8KYoOmp9kTrjOeRU=; b=IM4yP22o7F6keXSIyBhIdSQ74
        4KybJkZVG3KQsOYG8eK3D8crYuQSo6+pcnoiH8u+NHYDIovj9kwRC2sOIeyjhwL9bu2bCbZNfAI0I
        9ur8ACkiSIwFqbhxlIeiggeGFaj5yH73oxnhNwxLsrYwrnVTSwVIicfRIJbMQCzIFWtzH9e5J+D7K
        mAupk/zAquoDUyiuedIEftzzVkycrzMRBkt0Hs3QoifLWFeqPwUsXRVkZRl6jDRuBR+meC95OhIp/
        2oOuVxIdNK4Hi00BfBgRZSfePlFE6Kd/MwrNhw3nssCP8OVdLFqSQKJa087k5lm1DakXSlC1whYv1
        g9jLouyBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvmci-0006bL-By; Thu, 08 Aug 2019 17:54:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FEF0307510;
        Thu,  8 Aug 2019 19:54:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43E9A20189CDF; Thu,  8 Aug 2019 19:54:46 +0200 (CEST)
Date:   Thu, 8 Aug 2019 19:54:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        x86@kernel.org, bp@suse.de,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808175446.GQ2369@hirez.programming.kicks-ass.net>
References: <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
 <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
 <7ba45ead-186a-8802-2da6-6fa9fa00b36a@intel.com>
 <20190808163849.GL20745@zn.tnic>
 <91eefbe4-e32b-d762-be4d-672ff915db47@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91eefbe4-e32b-d762-be4d-672ff915db47@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 09:54:53AM -0700, Dave Hansen wrote:
> On 8/8/19 9:38 AM, Borislav Petkov wrote:
> > On Thu, Aug 08, 2019 at 09:30:49AM -0700, Dave Hansen wrote:
> >> Could someone also add some "how to add an entry to this file" in the
> >> top of that file?  We seem to have the same, tortuous conversations
> >> about one-line patches each time.
> > There is some doc at the top:
> 
> HOWTO Build an INTEL_FAM6_ definition:
> 
> 1. Start with INTEL_FAM6_
> 2. If not Core-family, add a note about it, like "ATOM".  There are only
>    two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
>    that you are adding a cpu which needs a new option here.
> 3. Add the processor microarchitecture, not the platform name
> 4. Add a short differentiator if necessary.  Add an _X to differentiate
>    Server from Client.
> 5. Add an optional comment with the platform name(s)
> 
> It should end up looking like this:
> 
> INTEL_FAM6_<ATOM?>_<MICROARCH>_<SHORT...> /* Platform Name */

That is obviously evident from actually looking at the file; but clearly
reading skills are in short supply these days.

Also, not just _SHORT, we actually try and minimize the variation there
too.
