Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD108682B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfHHRiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 13:38:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfHHRiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 13:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MVsjwAx9qmVm8X0Q25v4cAiTrnUdcKFSuJqjia9ViYc=; b=m6NHVxdlhhNMKdwo3qBO7eygue
        Q0M95c1jeeLg78Dt4dBfE31uIDLZcLe5vv3SVQc98IHvmNGrJFsZNABD/cvpX/EHR5AnN9XCXH8Wa
        QU2XQkdXvRZiWsaDxkCjsP47cH0dJpeTGEHGbvW+TPzoe91X3ZMm1KvHzwpuI7Ry/tqxcxraQdTkd
        b2CM3n2pOc+ZgeCZtKXGnUUpnk+Q0id5iZ4iARcjOq4DOFF9iCkQcFUgf9YBaMlNSuDLzEIgyuxD3
        4HTlF/kYfc/7rlQO3ivXVT2GE4aAcuYH9zkxzt/JBQ0T4HpBPtJ2Q2hSRbdkc7k3QgPz8uVtxQ23g
        2hK9+tBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvmML-0004Fc-19; Thu, 08 Aug 2019 17:37:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3FAA3035D7;
        Thu,  8 Aug 2019 19:37:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3888A20C4860B; Thu,  8 Aug 2019 19:37:50 +0200 (CEST)
Date:   Thu, 8 Aug 2019 19:37:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808173750.GN2369@hirez.programming.kicks-ass.net>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 09:20:03PM +0530, Bhardwaj, Rajneesh wrote:
> 
> On 08-Aug-19 9:01 PM, Peter Zijlstra wrote:
> > On Thu, Aug 08, 2019 at 05:23:26PM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 08, 2019 at 08:40:49PM +0530, Bhardwaj, Rajneesh wrote:
> > > > On 08-Aug-19 7:44 PM, Peter Zijlstra wrote:
> > > > > On Thu, Aug 08, 2019 at 09:19:23AM -0400, Liang, Kan wrote:
> > > > > > Usually, we should use the code name of microarchitecture for the name of
> > > > > > CPUID.
> > > > > Oh yes, very much. A quick google seems to suggest these are in fact
> > > > > Tremont cores. So then the naming should be:
> > > > > 
> > > > >     INTEL_FAM6_ATOM_TREMONT_xxx
> > > > Sure, I feel INTEL_FAM6_ATOM_TREMONT_ELKHART_LAKE may be too long so is
> > > > INTEL_FAM6_ATOM_TREMONT_PLUS a better name?
> > > Neither. WikiChip says it is the successor to Denverton, which is a
> > > server chip. If this is true then:
> > > 
> > > #define INTEL_FAM6_ATOM_TREMONT_X	0x.. /* Elkhart Lake */
> > > 
> > > is what it should be.
> > Of course we already have a TREMONT_X :-/ WikiChip is also confusing me
> > further by stating that Jacobsville is the platform that carries the
> > Elkhart Lake core, so they should be the bloody same chip.
> > 
> > But here we are, with two different model numbers.
> > 
> > Can someone please spell out in dummy language wth these chips are?
> > 
> > Are they both server chips?
> 
> 
> Elkhart Lake is Intel Atom based CPU product targeting primarily PC Client,
> IOT and industrial segments.  Jacobsville is Atom (Tremont) based
> Microserver.

Can we classify 'PC Client, IoT and Industrial' as MID ? Or rather, can
we say this Elkhart Lake is the successor to Moorefield? If not, what is
it successor to?

> Internally, preferred acronym for Elkhart Lake is EHL so does
> INTEL_FAM6_ATOM_TREMONT_EHL look ok?

No; that would be wildly inconsistent with everything else.

Also, I would suggest correcting wikichip and creating a tremont
(microarchitecture) wikipedia page.  There is a distinct lack of public
information on this.
